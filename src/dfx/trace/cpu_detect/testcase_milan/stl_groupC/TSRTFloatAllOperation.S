.global TSRTFloatAllOperation

.text
.p2align 4

TSRTFloatAllOperation:

TSRTFloatAllOperation_TestBegin:
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
    MOVZ  X3, #0x1830, LSL #0
    MOVK  X3, #0x140f, LSL #16
    MOVK  X3, #0x5e56, LSL #32
    MOVK  X3, #0xc11e, LSL #48
    MOVZ  X4, #0x812c, LSL #0
    MOVK  X4, #0x86fa, LSL #16
    MOVK  X4, #0x3a74, LSL #32
    MOVK  X4, #0xabf3, LSL #48
    MOVZ  X5, #0xdf73, LSL #0
    MOVK  X5, #0x5d36, LSL #16
    MOVK  X5, #0x4ff, LSL #32
    MOVK  X5, #0x1ce4, LSL #48
    MOVZ  X6, #0xaa7d, LSL #0
    MOVK  X6, #0xc657, LSL #16
    MOVK  X6, #0xef37, LSL #32
    MOVK  X6, #0x45df, LSL #48
    MOVZ  X7, #0xf1a0, LSL #0
    MOVK  X7, #0x870, LSL #16
    MOVK  X7, #0xc371, LSL #32
    MOVK  X7, #0x42d, LSL #48
    MOVZ  X10, #0xf2ec, LSL #0
    MOVK  X10, #0xd206, LSL #16
    MOVK  X10, #0x2e8f, LSL #32
    MOVK  X10, #0x69a2, LSL #48
    MOVZ  X11, #0xc530, LSL #0
    MOVK  X11, #0xab49, LSL #16
    MOVK  X11, #0x484d, LSL #32
    MOVK  X11, #0xd700, LSL #48
    MOVZ  X12, #0x8ed4, LSL #0
    MOVK  X12, #0x1a50, LSL #16
    MOVK  X12, #0xbcf8, LSL #32
    MOVK  X12, #0x8cc4, LSL #48
    MOVZ  X13, #0xb842, LSL #0
    MOVK  X13, #0x8359, LSL #16
    MOVK  X13, #0x3460, LSL #32
    MOVK  X13, #0xade3, LSL #48
    MOVZ  X14, #0x4898, LSL #0
    MOVK  X14, #0x6b14, LSL #16
    MOVK  X14, #0x59b1, LSL #32
    MOVK  X14, #0x9a1a, LSL #48
    MOVZ  X15, #0x6768, LSL #0
    MOVK  X15, #0x8a88, LSL #16
    MOVK  X15, #0x9007, LSL #32
    MOVK  X15, #0x140a, LSL #48
    MOVZ  X16, #0x9919, LSL #0
    MOVK  X16, #0x4263, LSL #16
    MOVK  X16, #0xf35, LSL #32
    MOVK  X16, #0x2417, LSL #48
    MOVZ  X17, #0x8efd, LSL #0
    MOVK  X17, #0xd511, LSL #16
    MOVK  X17, #0x9644, LSL #32
    MOVK  X17, #0x4f5c, LSL #48
    MOVZ  X18, #0x300e, LSL #0
    MOVK  X18, #0x8057, LSL #16
    MOVK  X18, #0x46f2, LSL #32
    MOVK  X18, #0xc184, LSL #48
    MOVZ  X20, #0x2693, LSL #0
    MOVK  X20, #0x2763, LSL #16
    MOVK  X20, #0x7a33, LSL #32
    MOVK  X20, #0xf0c9, LSL #48
    MOVZ  X21, #0xed83, LSL #0
    MOVK  X21, #0xfe62, LSL #16
    MOVK  X21, #0x4769, LSL #32
    MOVK  X21, #0x393a, LSL #48
    MOVZ  X22, #0x7d3, LSL #0
    MOVK  X22, #0x438d, LSL #16
    MOVK  X22, #0x7de4, LSL #32
    MOVK  X22, #0x7d8e, LSL #48
    MOVZ  X23, #0x7f96, LSL #0
    MOVK  X23, #0x3e8, LSL #16
    MOVK  X23, #0x9360, LSL #32
    MOVK  X23, #0x5acc, LSL #48
    MOVZ  X24, #0xedd9, LSL #0
    MOVK  X24, #0x9857, LSL #16
    MOVK  X24, #0x947f, LSL #32
    MOVK  X24, #0xf6bd, LSL #48
    MOVZ  X25, #0xb4fb, LSL #0
    MOVK  X25, #0x407b, LSL #16
    MOVK  X25, #0x7271, LSL #32
    MOVK  X25, #0x2955, LSL #48
    MOVZ  X26, #0x41b3, LSL #0
    MOVK  X26, #0x4cac, LSL #16
    MOVK  X26, #0x615a, LSL #32
    MOVK  X26, #0x11de, LSL #48
    MOVZ  X27, #0x882a, LSL #0
    MOVK  X27, #0xc140, LSL #16
    MOVK  X27, #0x55f8, LSL #32
    MOVK  X27, #0x776a, LSL #48
    MOVZ  X28, #0x1418, LSL #0
    MOVK  X28, #0x2579, LSL #16
    MOVK  X28, #0xb078, LSL #32
    MOVK  X28, #0xb7c3, LSL #48
    MOVZ  X29, #0xf8ce, LSL #0
    MOVK  X29, #0xb5c6, LSL #16
    MOVK  X29, #0x6abe, LSL #32
    MOVK  X29, #0xafcc, LSL #48
    MOVZ  X21, #0xd56, LSL #0
    MOVK  X21, #0x36c4, LSL #16
    MOVK  X21, #0x476a, LSL #32
    MOVK  X21, #0xbe4b, LSL #48
    MSR  FPCR, X21
    MOVZ  X21, #0xbaaf, LSL #0
    MOVK  X21, #0x98fd, LSL #16
    MOVK  X21, #0x6d00, LSL #32
    MOVK  X21, #0x1ffd, LSL #48
    MSR  FPSR, X21
    MRS  X27, FPSR
    MOVZ  X10, #0xff60, LSL #0
    MOVK  X10, #0x7ff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    AND  X27, X27, X10
    MOVZ  X10, #0x0, LSL #0
    ORR  X27, X27, X10
    MSR  FPSR, X27
    ISB  SY
    SUBS  X23, X29, X10, LSL #33
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X3, #0x2b07, LSL #0
    MOVK  X3, #0x4778, LSL #16
    MOVK  X3, #0x9981, LSL #32
    MOVK  X3, #0xa966, LSL #48
    MOVZ  X4, #0xb52f, LSL #0
    MOVK  X4, #0x188f, LSL #16
    MOVK  X4, #0xd006, LSL #32
    MOVK  X4, #0xc5f5, LSL #48
    MOVZ  X5, #0xf4bc, LSL #0
    MOVK  X5, #0x6fb3, LSL #16
    MOVK  X5, #0xd63f, LSL #32
    MOVK  X5, #0x14e2, LSL #48
    MOVZ  X6, #0x467b, LSL #0
    MOVK  X6, #0x3f8c, LSL #16
    MOVK  X6, #0xc45d, LSL #32
    MOVK  X6, #0xb723, LSL #48
    MOVZ  X7, #0xad4a, LSL #0
    MOVK  X7, #0x98a4, LSL #16
    MOVK  X7, #0x9d09, LSL #32
    MOVK  X7, #0x90b, LSL #48
    MOVZ  X10, #0x7b8b, LSL #0
    MOVK  X10, #0x27ab, LSL #16
    MOVK  X10, #0x5fb7, LSL #32
    MOVK  X10, #0x2ee3, LSL #48
    MOVZ  X11, #0xd98d, LSL #0
    MOVK  X11, #0xa2f, LSL #16
    MOVK  X11, #0x4cf0, LSL #32
    MOVK  X11, #0x4bc9, LSL #48
    MOVZ  X12, #0xc31d, LSL #0
    MOVK  X12, #0x210c, LSL #16
    MOVK  X12, #0xd18a, LSL #32
    MOVK  X12, #0x1e31, LSL #48
    MOVZ  X13, #0x9ff9, LSL #0
    MOVK  X13, #0xee8f, LSL #16
    MOVK  X13, #0xa597, LSL #32
    MOVK  X13, #0x6859, LSL #48
    MOVZ  X14, #0x193b, LSL #0
    MOVK  X14, #0x9128, LSL #16
    MOVK  X14, #0xb1e, LSL #32
    MOVK  X14, #0xd53, LSL #48
    MOVZ  X15, #0x5961, LSL #0
    MOVK  X15, #0x4d06, LSL #16
    MOVK  X15, #0x27c3, LSL #32
    MOVK  X15, #0xe691, LSL #48
    MOVZ  X16, #0x3392, LSL #0
    MOVK  X16, #0x8b54, LSL #16
    MOVK  X16, #0x3bad, LSL #32
    MOVK  X16, #0x4a04, LSL #48
    MOVZ  X17, #0x479d, LSL #0
    MOVK  X17, #0x59c5, LSL #16
    MOVK  X17, #0x23f3, LSL #32
    MOVK  X17, #0x9381, LSL #48
    MOVZ  X18, #0xfb28, LSL #0
    MOVK  X18, #0x2740, LSL #16
    MOVK  X18, #0x1a46, LSL #32
    MOVK  X18, #0x13a1, LSL #48
    MOVZ  X20, #0xee12, LSL #0
    MOVK  X20, #0x56c1, LSL #16
    MOVK  X20, #0x27a8, LSL #32
    MOVK  X20, #0xa74c, LSL #48
    MOVZ  X21, #0xa66b, LSL #0
    MOVK  X21, #0x8179, LSL #16
    MOVK  X21, #0xf359, LSL #32
    MOVK  X21, #0xd193, LSL #48
    MOVZ  X22, #0x1480, LSL #0
    MOVK  X22, #0xb1bd, LSL #16
    MOVK  X22, #0xf95b, LSL #32
    MOVK  X22, #0x6939, LSL #48
    MOVZ  X23, #0x86d2, LSL #0
    MOVK  X23, #0x76e7, LSL #16
    MOVK  X23, #0x8d6, LSL #32
    MOVK  X23, #0xec8f, LSL #48
    MOVZ  X24, #0x66a4, LSL #0
    MOVK  X24, #0x3ab6, LSL #16
    MOVK  X24, #0x3abb, LSL #32
    MOVK  X24, #0x549c, LSL #48
    MOVZ  X25, #0xf157, LSL #0
    MOVK  X25, #0x15d0, LSL #16
    MOVK  X25, #0xa426, LSL #32
    MOVK  X25, #0xb515, LSL #48
    MOVZ  X26, #0xac93, LSL #0
    MOVK  X26, #0x7d6f, LSL #16
    MOVK  X26, #0xaa49, LSL #32
    MOVK  X26, #0xa493, LSL #48
    MOVZ  X27, #0xad52, LSL #0
    MOVK  X27, #0xe7e6, LSL #16
    MOVK  X27, #0x91ea, LSL #32
    MOVK  X27, #0x7976, LSL #48
    MOVZ  X28, #0x482e, LSL #0
    MOVK  X28, #0xbfb6, LSL #16
    MOVK  X28, #0xf6d0, LSL #32
    MOVK  X28, #0xf0bf, LSL #48
    MOVZ  X29, #0xecac, LSL #0
    MOVK  X29, #0x230e, LSL #16
    MOVK  X29, #0xa9df, LSL #32
    MOVK  X29, #0x1857, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X5
    FMOV  V4.D[1], X4
    FMOV  D5, X6
    FMOV  V5.D[1], X26
    FMOV  D6, X24
    FMOV  V6.D[1], X21
    FMOV  D7, X6
    FMOV  V7.D[1], X20
    FMOV  D8, X10
    FMOV  V8.D[1], X18
    FMOV  D9, X28
    FMOV  V9.D[1], X25
    FMOV  D10, X28
    FMOV  V10.D[1], X7
    FMOV  D11, X11
    FMOV  V11.D[1], X7
    FMOV  D12, X22
    FMOV  V12.D[1], X27
    FMOV  D13, X28
    FMOV  V13.D[1], X20
    FMOV  D14, X11
    FMOV  V14.D[1], X26
    FMOV  D15, X20
    FMOV  V15.D[1], X3
    FMOV  D16, X4
    FMOV  V16.D[1], X26
    FMOV  D17, X29
    FMOV  V17.D[1], X25
    FMOV  D18, X14
    FMOV  V18.D[1], X11
    FMOV  D19, X14
    FMOV  V19.D[1], X3
    FMOV  D20, X28
    FMOV  V20.D[1], X7
    FMOV  D21, X3
    FMOV  V21.D[1], X28
    FMOV  D22, X18
    FMOV  V22.D[1], X24
    FMOV  D23, X12
    FMOV  V23.D[1], X15
    FMOV  D24, X26
    FMOV  V24.D[1], X17
    FMOV  D25, X12
    FMOV  V25.D[1], X22
    FMOV  D26, X3
    FMOV  V26.D[1], X20
    FMOV  D27, X24
    FMOV  V27.D[1], X7
    FMOV  D28, X16
    FMOV  V28.D[1], X10
    FMOV  D29, X18
    FMOV  V29.D[1], X21
    FMOV  D30, X6
    FMOV  V30.D[1], X23
    FMOV  D31, X24
    FMOV  V31.D[1], X27
    MOVZ  X25, #0xa, LSL #0
TSRTFloatAllOperation_label_0:
    FRINTM  H5, H27
    SCVTF  D23, X3, #43
    FRINTA  D5, D23
    FCVTNS  W12, D24
    FCVTZS  X20, S20
    FCMP  H31, H5
    FMINNM  D17, D28, D25
    FRINTI  H6, H22
    FRINTX  S27, S17
    FCVTZU  W7, D26, #9
    FMOV  W15, H29
    UCVTF  H21, W27
    FCVTAU  X24, S30
    SCVTF  H14, W21
    FCVTNS  X6, H14
    FCVTMU  W18, D27
    FMAX  D12, D6, D6
    FMSUB  S22, S21, S12, S2
    FRINTA  S24, S5
    FNMUL  H21, H22, H24
    FRINTP  D28, D26
    FCVTNU  W3, D14
    FCVTMS  X21, S3
    FCCMPE  D3, D30, #0x2, AL
    UCVTF  H29, X15
    FCCMP  D2, D4, #0xb, VS
    FCVTPS  X15, H18
    FDIV  D24, D23, D29
    FMAXNM  H4, H30, H20
    FCVTZS  W21, H15
    FCVTZS  X28, D2, #13
    FCMPE  D21, #0.0
    FMADD  S18, S28, S2, S5
    FMOV  S22, #1.56250000
    FCVTMS  X11, H5
    FCVT  D20, S27
    FMUL  D12, D2, D28
    FCVTZU  X22, D20
    FCVTPS  W4, S0
    FCVTZU  W24, S15
    FCVT  D21, S29
    FMOV  D5, D8
    FCVTMS  W28, H13
    FABS  D8, D9
    SCVTF  D2, W15, #31
    FCVTZU  W12, S24
    FCVTAU  X10, S22
    UCVTF  D30, X10
    FCVTZU  W20, H18
    FMOV  W11, H30
    FRINTN  S13, S12
    FCVTPS  W27, D4
    FCVTPS  X29, H5
    UCVTF  D27, X21, #44
    FCCMP  S21, S21, #0xb, MI
    FCSEL  S21, S8, S2, GT
    FCVTMU  X6, D13
    FNMSUB  H29, H27, H21, H27
    FMOV  S24, #-0.78125000
    FCVTNS  W7, D27
    FCMP  D2, #0.0
    FMUL  H13, H3, H1
    FSQRT  D8, D13
    FCVTZU  X20, H4, #10
    FNMADD  S4, S27, S5, S31
    FCVTNU  W14, D27
    SCVTF  H21, X14, #5
    UCVTF  H13, X7
    UCVTF  D18, X27, #54
    FCVT  S2, D30
    FADD  H5, H10, H6
    FDIV  D30, D24, D21
    FCVTPU  X29, D2
    FCVTMU  W26, D29
    FRINTI  D22, D8
    FCVTZU  X15, S4, #13
    FMOV  D1, D13
    FCVTPU  X13, H1
    FRINTX  S3, S22
    FMINNM  S8, S5, S30
    FCVTAU  X29, S8
    SCVTF  S2, X13
    SCVTF  S31, W26
    FRINTN  H29, H31
    FCVTMS  W24, D3
    FCVTZS  X27, H29
    FCVTPS  X27, H2
    SCVTF  D4, W15
    FCVTPS  X24, S18
    FMOV  D13, X29
    FCVTNS  W12, D21
    SCVTF  H29, X12
    UCVTF  H3, X27
    FMOV  S5, #12.50000000
    FCMPE  S10, S0
    FCVTZS  X20, S4
    FCVT  D4, S17
    FCVTMU  X5, S4
    FMOV  H22, W24
    FCVTPU  X10, H28
    FCVTZU  X22, S19
    UCVTF  D2, X22, #56
    FMAXNM  D0, D8, D21
    FCMP  D24, #0.0
    FRINTM  S18, S3
    FMOV  W13, S21
    FMOV  H17, H19
    FSQRT  H10, H23
    SCVTF  D3, X20
    FCSEL  H21, H22, H22, NE
    FCVTMU  X14, H10
    SCVTF  H31, W10
    FMINNM  S19, S31, S2
    FCCMPE  H3, H5, #0x6, HI
    FCVTZU  X7, H19, #58
    FCMP  S21, #0.0
    FCVTZU  W10, H17
    FCMPE  S18, S18
    FSUB  H23, H0, H0
    FCMP  D23, D23
    FCVTAU  W18, H6
    FCVTZU  W10, S14
    FCVTZU  W24, H12, #2
    FMUL  D23, D1, D14
    SCVTF  H5, W13
    FMOV  D14, X24
    UCVTF  S28, X5, #34
    FRINTM  H18, H3
    FMUL  S22, S13, S6
    FCVTZU  W29, S7
    FMAX  H2, H4, H13
    UCVTF  H21, W29
    FRINTN  H12, H3
    FDIV  S19, S23, S12
    FCVTPU  X4, H5
    FCVTMU  X10, H19
    FMADD  H19, H28, H22, H14
    FMADD  S0, S19, S19, S2
    FABS  H2, H0
    FRINTI  H6, H2
    FCVTAU  X14, H10
    FCVTNU  X22, S18
    FCMP  D21, D21
    FCVTNU  X27, S2
    FRINTZ  D3, D11
    FCVTPU  X7, D31
    FSQRT  D31, D13
    FCVTZU  X15, D10, #55
    FCVTAS  X24, D21
    FCVTZU  W28, H13
    SCVTF  D13, W24
    FMADD  S18, S16, S4, S19
    FMINNM  H10, H21, H19
    SCVTF  H4, X27, #32
    FMOV  D21, #-1.75000000
    FCMP  D18, #0.0
    FCVTAS  W24, H22
    FCVTAS  W21, D23
    FCSEL  S0, S12, S22, NE
    FMOV  X26, H12
    FCVTMU  X3, H16
    FCVTPU  X4, D7
    FRINTM  D18, D31
    FMADD  D22, D1, D31, D21
    FRINTM  S1, S26
    FNEG  H21, H0
    FSQRT  D23, D4
    FCVTNS  X28, D18
    FCVTZS  X13, S3, #24
    FCVTPU  W22, H13
    FNMSUB  D2, D10, D15, D22
    FMOV  H22, W26
    FCVTNS  W29, D1
    SCVTF  D4, X13
    FSUB  S26, S22, S21
    FCVTZU  X28, H26
    FABS  H12, H4
    FMOV  D22, #-3.25000000
    FCVTZS  W26, S31, #20
    FMINNM  S7, S23, S22
    FRINTX  D1, D2
    FRINTX  D3, D12
    UCVTF  S23, X26
    FRINTX  S10, S23
    FCVTZS  X11, S10, #62
    FMIN  D16, D3, D3
    FCVTAS  W6, H16
    FCVT  S15, D7
    FDIV  H26, H15, H15
    FCVT  H0, D26
    FMADD  D2, D1, D1, D0
    FMOV  W22, H22
    FMOV  D23, #1.62500000
    FRINTZ  S10, S24
    FCMPE  S3, S17
    FMOV  X14, D23
    FCSEL  S31, S14, S0, GT
    FCVTPS  X27, S11
    FCVTZS  W20, H24, #3
    FCVTZS  W10, S18
    FMOV  H12, X10
    FCVTPS  X5, H19
    SCVTF  S17, W11
    FCVT  D19, S20
    FCVTNS  W13, H11
    FMSUB  S23, S30, S4, S26
    FRINTN  H25, H13
    FCVTAU  X13, S31
    FNMSUB  S1, S23, S18, S10
    FDIV  D3, D20, D10
    FMOV  H26, X22
    FNMSUB  S22, S11, S26, S17
    FMADD  S17, S10, S21, S31
    FMOV  H14, X13
    UCVTF  H0, W14
    FCVTPS  W7, D22
    FSUB  D16, D19, D1
    FCVTZU  X11, S16, #45
    SCVTF  S19, X11, #53
    FABS  S31, S14
    FNMSUB  D14, D25, D25, D12
    FMOV  H13, H19
    FCVTPS  W14, H0
    FRINTN  H10, H13
    FCVTZS  X21, D10, #53
    FCVTZU  W15, H14
    FCVTAS  W14, S31
    FMIN  S14, S26, S3
    FMAX  H4, H17, H17
    SCVTF  S1, W5, #11
    FCVTZS  W29, H1
    FRINTA  S16, S4
    FABS  S10, S16
    FSUB  S12, S10, S14
    FCVTAU  X3, S24
    FCVT  H19, D23
    FNMADD  H25, H29, H25, H31
    UCVTF  D3, W7
    FMAX  D0, D6, D29
    FNMSUB  D17, D22, D6, D18
    FCVTZS  X7, D29, #33
    FCVTNS  X3, H24
    FCVTMU  X6, S17
    FCVT  S31, H19
    FCMP  S24, S14
    FMOV  H10, W21
    SCVTF  D16, W7, #30
    FNMUL  H13, H10, H1
    FCVTNU  W22, S16
    SCVTF  H4, X29
    FCVTPS  W22, D0
    FMAXNM  H29, H29, H11
    FADD  S17, S13, S16
    FCVTPS  X5, H10
    FCVT  H19, S14
    FCVTZU  W21, S5, #2
    FNMUL  H0, H8, H20
    FCVTZS  W15, D4
    FCVTAU  W6, D29
    FCVTNS  X6, H0
    FCMP  D17, D31
    FCVTAS  X13, D19
    FMUL  S10, S4, S0
    FCCMP  H10, H10, #0x3, LS
    FRINTM  S14, S29
    FCVTPS  W7, S14
    FRINTZ  D19, D7
    FCVTNU  W4, H19
    FCVTMS  W6, H9
    FNEG  S5, S31
    FMIN  S7, S6, S18
    UCVTF  S24, X4, #13
    FCVTMS  X21, H15
    FCVTNS  X22, S2
    FMOV  W29, H18
    SCVTF  H14, X29, #54
    FCMP  D19, D13
    UCVTF  H15, W5
    UCVTF  H9, X13
    UCVTF  S6, X15
    FCVTZU  W5, S17
    FCVTZU  W13, S24
    FCVTMS  X4, S14
    SCVTF  H2, W6
    FSQRT  S17, S27
    FCVTZU  W15, S30, #30
    FCMPE  D10, D31
    FCVTZS  X6, H1, #2
    SCVTF  D10, W15, #22
    FMOV  S19, W4
    FCVTZU  X21, D10
    FMINNM  H24, H19, H19
    FCMPE  H7, #0.0
    FMAX  H14, H6, H17
    FCVTPU  W14, D14
    FMINNM  H10, H15, H9
    FMSUB  D18, D2, D5, D10
    UCVTF  H27, X6
    FRINTP  D5, D18
    FCVTZS  X27, H5
    SUBS  X25, X25, #0x1
    B.NE  TSRTFloatAllOperation_label_0
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X17, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x1f, LSL #0
    MRS  X17, FPSR
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X17, D0
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D3
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D4
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D5
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D7
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0xad4a, LSL #0
    MOVK  X16, #0x98a4, LSL #16
    MOVK  X16, #0x9d09, LSL #32
    MOVK  X16, #0x90b, LSL #48
    FMOV  X17, V11.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0xd98d, LSL #0
    MOVK  X16, #0xa2f, LSL #16
    MOVK  X16, #0x4cf0, LSL #32
    MOVK  X16, #0x4bc9, LSL #48
    FMOV  X17, D11
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D12
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X17, D13
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D14
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D16
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D17
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D19
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X17, D21
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D22
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X17, D23
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X17, D25
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D27
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D29
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff0, LSL #48
    FMOV  X17, D30
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X17, D31
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    FMOV  V0.D[1], X29
    FMOV  D1, X14
    FMOV  V1.D[1], X12
    FMOV  D2, X21
    FMOV  V2.D[1], X16
    FMOV  D3, X25
    FMOV  V3.D[1], X26
    FMOV  D4, X28
    FMOV  V4.D[1], X27
    FMOV  D5, X24
    FMOV  V5.D[1], X23
    FMOV  D6, X22
    FMOV  V6.D[1], X11
    FMOV  D7, X18
    FMOV  V7.D[1], X18
    FMOV  D8, X29
    FMOV  V8.D[1], X28
    FMOV  D9, X24
    FMOV  V9.D[1], X11
    FMOV  D10, X20
    FMOV  V10.D[1], X29
    FMOV  D11, X25
    FMOV  V11.D[1], X15
    FMOV  D12, X13
    FMOV  V12.D[1], X3
    FMOV  D13, X29
    FMOV  V13.D[1], X20
    FMOV  D14, X3
    FMOV  V14.D[1], X18
    FMOV  D15, X10
    FMOV  V15.D[1], X23
    FMOV  D16, X10
    FMOV  V16.D[1], X24
    FMOV  D17, X10
    FMOV  V17.D[1], X17
    FMOV  D18, X15
    FMOV  V18.D[1], X18
    FMOV  D19, X28
    FMOV  V19.D[1], X24
    FMOV  D20, X23
    FMOV  V20.D[1], X23
    FMOV  D21, X29
    FMOV  V21.D[1], X18
    FMOV  D22, X25
    FMOV  V22.D[1], X29
    FMOV  D23, X4
    FMOV  V23.D[1], X18
    FMOV  D24, X27
    FMOV  V24.D[1], X3
    FMOV  D25, X25
    FMOV  V25.D[1], X3
    FMOV  D26, X10
    FMOV  V26.D[1], X26
    FMOV  D27, X16
    FMOV  V27.D[1], X13
    FMOV  D28, X6
    FMOV  V28.D[1], X27
    FMOV  D29, X13
    FMOV  V29.D[1], X25
    FMOV  D30, X12
    FMOV  V30.D[1], X11
    FMOV  D31, X5
    FMOV  V31.D[1], X28
    MOVZ  X22, #0xa, LSL #0
TSRTFloatAllOperation_label_1:
    FCVTAS  X13, D26
    FRINTN  H4, H24
    FMOV  D20, #3.62500000
    FCVTPS  W28, H29
    FCVTMS  X29, H27
    FRINTP  H4, H31
    FCMPE  D30, #0.0
    FRINTP  S24, S28
    FCVTZU  X5, D24
    FMAX  H12, H20, H4
    FCVTPS  W6, S12
    FRINTN  S4, S25
    FCVTPU  W26, H4
    FCVTZS  X12, H5, #7
    FCVT  S18, H15
    FCVTNS  W13, H11
    FCCMP  D6, D3, #0xa, LS
    FCVTZS  X10, S0
    FCSEL  S15, S6, S11, CC
    FCVTPS  W7, D27
    FCVTPS  W29, D11
    FRINTA  H30, H1
    FCVTZS  X4, S20, #35
    FMOV  H0, W6
    FCVTMU  X6, H14
    FDIV  H12, H29, H27
    FCMPE  S28, S27
    FCVTMU  X25, D18
    FCVTAS  W15, H4
    FCVTNU  W25, H1
    FMUL  D31, D17, D0
    UCVTF  H1, X6, #36
    FMAXNM  H27, H6, H20
    FCVTZU  W17, S4, #12
    FCVTZU  X10, S24, #20
    FCMP  D0, #0.0
    FCVT  D3, H17
    FRINTX  H20, H16
    FCVTZU  X10, D22
    FCVTMU  W12, S5
    FCVTZU  X20, D9
    UCVTF  D29, X17
    FCVT  H5, S20
    FCCMP  H15, H31, #0x9, LS
    FCVTZS  W23, D29
    FCVTPU  W12, S1
    FNMUL  S24, S27, S5
    FCMP  H24, #0.0
    FCVTZU  W29, H3
    FCVTZU  W23, H0, #11
    FCVT  S16, D30
    UCVTF  S22, X20
    FCVTPU  X4, S22
    FRINTI  D3, D12
    FSUB  H20, H3, H3
    FCMPE  H16, #0.0
    FNMUL  D18, D2, D10
    FCVTNS  W10, D6
    FCMPE  S14, S20
    FMAXNM  H1, H5, H8
    UCVTF  H31, W23, #19
    FCVTZU  X16, H20, #17
    FCMP  S4, S27
    FMAX  S30, S18, S25
    SCVTF  S3, W29, #15
    FSUB  H12, H0, H14
    UCVTF  H20, W4, #16
    FCVTPU  W5, D12
    FCVTNU  W12, S12
    FCVT  D4, S6
    FCVTPS  X13, D14
    FRINTI  H5, H25
    FCVTAS  X20, S0
    FRINTI  H0, H9
    FCVTAS  X15, S12
    FCVTNS  X25, S29
    FCVTAU  X15, S3
    SCVTF  S25, W5, #12
    FCVTMS  X3, H0
    FMOV  W12, S10
    FMOV  H9, #2.50000000
    FMOV  W15, H25
    FCVTAS  X15, D13
    FCVTZS  X7, H6, #2
    FNMUL  D12, D7, D8
    FNMSUB  H8, H1, H31, H1
    FCVTMS  W25, H23
    FCVTZS  W3, H26
    FRINTZ  H23, H15
    FABS  D31, D27
    FCVTPU  W17, D9
    FCVT  D0, S5
    FCVTZU  X29, H31
    FCVTNS  X21, H0
    FCVTMS  W5, D12
    SCVTF  H31, W29, #30
    FNMADD  H6, H31, H31, H23
    FCMPE  S4, S4
    FMSUB  H3, H8, H6, H8
    UCVTF  D0, X7, #19
    SCVTF  D1, W17, #27
    SCVTF  S26, W25
    FCVTMU  X23, D6
    UCVTF  D27, X21, #48
    FCVTZS  X27, H3
    FMOV  S8, S5
    FRINTM  H12, H12
    FCVTMS  W21, H16
    FCVTZS  X23, D29
    FCCMPE  S31, S17, #0xa, NV
    FCVTAU  W28, H19
    FRINTM  D16, D10
    FSUB  D19, D7, D29
    FCCMP  H20, H11, #0x7, NV
    FCVTMU  W20, D11
    FMAXNM  H9, H17, H5
    FRINTZ  D15, D8
    FCVTMS  W15, H15
    FMOV  S17, W23
    FCVTZU  X7, S17
    FCVTZS  W4, H26
    FCVTZU  W18, H9
    UCVTF  S3, W7, #15
    FCVTMU  W25, H12
    FCVTZU  X27, S19
    FCMP  H16, H1
    FSUB  D16, D3, D3
    FRINTI  S7, S0
    FCVTZS  W17, S27, #2
    UCVTF  H10, W27
    FMAX  D26, D7, D2
    SCVTF  H12, W17, #16
    FMAX  D27, D10, D16
    FCVTZS  X15, S26
    FNMADD  D2, D27, D27, D12
    FMAXNM  H20, H31, H7
    FCVTMS  X4, H2
    FCVTPS  X13, S0
    FCVTZS  W23, H11
    FRINTX  H11, H15
    FMSUB  D9, D6, D19, D15
    FCVTZU  X5, D14, #51
    FCVTPU  X29, S28
    FNMADD  S3, S16, S27, S0
    FMSUB  H19, H10, H15, H21
    FRINTI  H21, H17
    FCVT  H14, S21
    FMADD  S21, S1, S7, S23
    FCVT  S27, H8
    FMADD  H28, H27, H20, H14
    FCCMPE  S9, S26, #0xd, PL
    FCVTPS  X4, D29
    FCVTAU  X28, S10
    FRINTI  H13, H14
    FRINTM  H27, H9
    FRINTN  D20, D6
    FCVTAS  X21, D21
    UCVTF  D9, X21
    FCVT  H23, D2
    FCCMPE  H13, H3, #0x0, MI
    FRINTX  S17, S9
    UCVTF  D10, X28
    FADD  H21, H20, H28
    FCVTNU  X17, S21
    FSUB  D0, D19, D11
    FDIV  D26, D27, D0
    FRINTA  D11, D17
    SCVTF  S28, W17, #32
    FSUB  H19, H10, H28
    FRINTP  S14, S19
    FDIV  S27, S11, S23
    FCMPE  H14, #0.0
    FRINTI  H11, H27
    FCMPE  S26, #0.0
    FMUL  S6, S25, S29
    FCCMP  H19, H2, #0x6, GE
    FCVTNS  W3, D30
    FCMP  D1, D8
    FCVTNU  W25, S9
    FCMP  S1, S24
    FCVTAU  X26, S20
    SCVTF  H27, X18, #25
    FRINTI  H14, H30
    SCVTF  D23, X15
    FCVTMS  X17, D22
    FNMUL  H28, H13, H0
    FCVTZU  X6, S1
    FRINTX  S10, S31
    SCVTF  H22, W22
    FMOV  W29, H3
    FCVTPS  X7, S30
    FCMPE  D5, #0.0
    FCVTNU  X25, D19
    SCVTF  H5, X13
    FCVT  S29, H6
    FMOV  H8, X20
    FCVTNS  X25, D5
    FSQRT  D13, D29
    FMOV  S29, #13.00000000
    FRINTN  H5, H11
    FMOV  H30, #4.50000000
    FCVTNU  X20, H13
    FCVTZS  X16, D22, #8
    FSQRT  S13, S8
    UCVTF  H6, W20
    FCMP  S13, S29
    UCVTF  S20, X7, #15
    FNMADD  H31, H28, H30, H20
    FCVTPS  X17, S6
    FCVTZS  X27, H31, #19
    UCVTF  H28, W27, #15
    FCVTZU  X18, S5
    FCVTAS  W29, D28
    FCVTMS  X13, H4
    FMADD  D11, D2, D6, D2
    FCVTZU  W3, D11
    FCVTZU  W12, S4, #32
    UCVTF  S30, X3, #41
    FNEG  D5, D3
    FCVTPS  X4, H23
    FMAX  D2, D14, D25
    FMAX  D20, D11, D18
    FRINTP  S28, S9
    FMOV  H23, X12
    FCVT  D18, S13
    FCVTZU  X27, D28, #11
    UCVTF  H25, X18
    FCVTZS  X4, S11, #38
    FRINTX  H3, H5
    FCSEL  H28, H25, H13, EQ
    FMOV  W4, S3
    FRINTA  S14, S4
    SCVTF  H13, W27, #9
    UCVTF  H4, W13
    SCVTF  D6, X4
    UCVTF  S25, X3
    FCVTMU  X5, S23
    FCVTPU  W28, S28
    FRINTI  D31, D25
    FCVT  H9, D14
    FNMUL  S3, S6, S6
    FMAXNM  D11, D4, D20
    FRINTP  D23, D18
    FSQRT  S25, S23
    FCVTAS  X25, H31
    FMINNM  D31, D9, D11
    UCVTF  H5, X28
    UCVTF  S6, X25
    FCSEL  S9, S13, S25, LE
    FRINTI  H25, H3
    FCVTPS  X27, D6
    FMOV  H23, H9
    FRINTZ  D11, D25
    FCVTAS  W4, H23
    FCVTNU  X17, D11
    FNMUL  H3, H5, H5
    FMADD  H12, H2, H31, H31
    FMOV  W13, H3
    FCVTZS  W25, S3, #24
    FCVTAS  W6, H11
    FCMPE  S9, S6
    FMOV  S18, W16
    FNMUL  H13, H28, H2
    FMADD  S3, S4, S10, S16
    FMOV  X26, D25
    FCVTAU  X20, D11
    FNMSUB  S23, S22, S9, S6
    FCMP  S21, S11
    FCCMPE  S12, S4, #0x6, AL
    FMAX  D6, D27, D10
    FCVTPU  W21, S15
    FMINNM  D5, D25, D31
    FCMPE  H15, #0.0
    FCVTNU  W17, D26
    FCVTMS  W5, S13
    FMSUB  D12, D26, D19, D26
    UCVTF  D11, W26, #27
    SCVTF  H26, W4, #9
    FCVTNU  X13, H22
    FCVT  H22, D15
    FRINTZ  S0, S22
    FCCMPE  S6, S6, #0x7, PL
    FCVTPU  W21, H23
    FRINTA  S27, S12
    FCVTZU  X10, S18
    FCMP  D5, #0.0
    FRINTX  S2, S3
    FRINTZ  S18, S27
    FCCMP  D2, D26, #0x6, CS
    FSQRT  D15, D0
    FNMSUB  S3, S15, S11, S18
    FCCMP  S7, S12, #0x8, NE
    FCVTZS  W28, H19
    FRINTZ  S19, S7
    FRINTN  S5, S22
    FCVTZS  W20, H29, #12
    FCVTZU  W17, H1, #17
    FNMADD  S27, S7, S13, S7
    FMOV  X16, D25
    FCVTPU  X28, S15
    SUBS  X22, X22, #0x1
    B.NE  TSRTFloatAllOperation_label_1
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x1, LSL #0
    SUB  X24, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X24, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x1f, LSL #0
    MRS  X24, FPSR
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D0
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x3e40, LSL #48
    FMOV  X24, D1
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D2
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D3
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D4
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D5
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D6
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D7
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D8
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D9
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D10
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D11
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    FMOV  X24, D12
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x8000, LSL #0
    FMOV  X24, D13
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D14
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D15
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D16
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D17
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D18
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D19
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    FMOV  X24, D20
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D22
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D23
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    FMOV  X24, D24
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D25
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D26
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    FMOV  X24, D27
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D28
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4150, LSL #16
    FMOV  X24, D29
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D30
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X14, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X11
    FMOV  V2.D[1], X29
    FMOV  D3, X14
    FMOV  V3.D[1], X4
    FMOV  D4, X29
    FMOV  V4.D[1], X5
    FMOV  D5, X3
    FMOV  V5.D[1], X4
    FMOV  D6, X5
    FMOV  V6.D[1], X20
    FMOV  D7, X12
    FMOV  V7.D[1], X26
    FMOV  D8, X3
    FMOV  V8.D[1], X10
    FMOV  D9, X18
    FMOV  V9.D[1], X27
    FMOV  D10, X20
    FMOV  V10.D[1], X20
    FMOV  D11, X23
    FMOV  V11.D[1], X18
    FMOV  D12, X17
    FMOV  V12.D[1], X26
    FMOV  D13, X14
    FMOV  V13.D[1], X28
    FMOV  D14, X24
    FMOV  V14.D[1], X11
    FMOV  D15, X29
    FMOV  V15.D[1], X18
    FMOV  D16, X27
    FMOV  V16.D[1], X25
    FMOV  D17, X17
    FMOV  V17.D[1], X28
    FMOV  D18, X17
    FMOV  V18.D[1], X14
    FMOV  D19, X26
    FMOV  V19.D[1], X18
    FMOV  D20, X16
    FMOV  V20.D[1], X14
    FMOV  D21, X7
    FMOV  V21.D[1], X3
    FMOV  D22, X17
    FMOV  V22.D[1], X26
    FMOV  D23, X28
    FMOV  V23.D[1], X13
    FMOV  D24, X27
    FMOV  V24.D[1], X5
    FMOV  D25, X17
    FMOV  V25.D[1], X24
    FMOV  D26, X24
    FMOV  V26.D[1], X12
    FMOV  D27, X13
    FMOV  V27.D[1], X25
    FMOV  D28, X12
    FMOV  V28.D[1], X14
    FMOV  D29, X7
    FMOV  V29.D[1], X16
    FMOV  D30, X3
    FMOV  V30.D[1], X28
    FMOV  D31, X13
    FMOV  V31.D[1], X14
    MOVZ  X23, #0xa, LSL #0
TSRTFloatAllOperation_label_2:
    FRINTN  H24, H29
    SCVTF  H15, W20
    FCVTMS  X28, S22
    FCVTZU  X27, D19, #5
    FCVTMU  W5, H15
    FCVTMU  W20, S31
    UCVTF  D27, X11
    FNMADD  D29, D26, D23, D24
    UCVTF  D7, W22
    FMOV  H11, #5.75000000
    FCVTZU  W13, H30
    FNMSUB  D19, D27, D25, D28
    SCVTF  S12, X14
    FNMSUB  S14, S11, S29, S11
    FDIV  D15, D14, D7
    FABS  D25, D12
    FCVTNU  W11, D15
    FNEG  D8, D19
    FNMSUB  D22, D8, D25, D25
    FCMPE  S7, #0.0
    FDIV  D8, D20, D14
    FCVTAU  W22, H18
    FABS  D30, D21
    UCVTF  S18, X4, #1
    FCVTNU  W14, D26
    FCVTZU  X4, S25, #52
    FMOV  D24, D15
    FMAXNM  D15, D24, D6
    FNMSUB  H11, H5, H19, H18
    FMOV  S20, #0.25000000
    FCVT  S29, H5
    FCVTMU  W7, D31
    UCVTF  D7, W14, #13
    FCVTNS  W21, S10
    FCVTZS  X17, H5
    FMAX  S19, S16, S17
    FRINTI  D6, D29
    FRINTZ  H14, H17
    FRINTZ  D25, D30
    FMSUB  H31, H20, H8, H6
    FMUL  D27, D22, D7
    FCVTAS  W10, S19
    SCVTF  D30, X21, #1
    FCVTPU  X10, H11
    FCSEL  S19, S30, S25, MI
    FDIV  D8, D15, D15
    FABS  D10, D31
    FRINTZ  D7, D8
    FCVTNS  X10, H7
    FRINTN  H30, H10
    FNEG  S16, S27
    FABS  S5, S30
    FRINTA  S17, S5
    FRINTN  D20, D14
    FCMP  S19, #0.0
    FCVTZS  W20, D17
    SCVTF  D25, W10
    FNMUL  S10, S16, S25
    FCVTNU  X14, H28
    SCVTF  D31, X20
    FCVTZU  X20, H31, #18
    FRINTA  D14, D20
    FMSUB  D8, D14, D10, D14
    FCVTMU  X22, S19
    FNMUL  H27, H14, H8
    FCVT  D7, S19
    FRINTA  H20, H11
    FRINTA  D11, D20
    FDIV  H20, H15, H5
    FCVTPS  W16, D12
    FCVTMS  X21, H21
    FCVTAU  X16, S3
    FMOV  S3, S15
    FCVTAU  W3, H17
    FCVTZS  W13, H23
    FCVTPS  W5, H20
    FCVTZU  X29, D1
    FCVTPU  X17, D13
    FCCMP  S25, S21, #0x1, GE
    FRINTX  D30, D9
    FCMPE  D12, #0.0
    FCVTMU  X7, D24
    FMOV  H31, W21
    UCVTF  H8, W22, #9
    FCVTMS  W10, H10
    FNMADD  S20, S31, S21, S21
    UCVTF  D14, W13
    FMAX  S1, S5, S4
    FCVTZS  W21, S1
    FRINTI  S4, S3
    FCVTPU  W16, S30
    FMSUB  D5, D8, D8, D20
    FCMP  S5, #0.0
    FABS  S23, S14
    FCSEL  S25, S4, S4, GT
    FCVTAU  X20, H25
    FCCMPE  H23, H23, #0xd, LT
    FCVTPU  X20, D16
    FMADD  D14, D12, D10, D30
    FCMP  S25, S2
    FDIV  S2, S25, S30
    FCVTNS  W15, D27
    FCMPE  S24, #0.0
    FRINTZ  H27, H25
    FCMP  H23, H25
    FCVT  S24, D22
    FNEG  S3, S31
    FCVTZU  X22, H13, #57
    UCVTF  H22, W16
    FCVTZS  W24, S6, #27
    FCMP  H28, #0.0
    SCVTF  S4, W20
    FRINTA  S25, S4
    FCVTNS  W28, S13
    FNMUL  S1, S28, S11
    FCCMP  H0, H25, #0xd, NV
    FNMSUB  H6, H8, H2, H0
    FCVTAU  W22, H24
    FCVTAS  X29, H24
    SCVTF  H13, W29
    FCCMP  S20, S4, #0x9, PL
    FMOV  H23, W28
    FCVT  S20, H5
    FADD  D4, D1, D6
    FMUL  S30, S4, S20
    FCCMP  S3, S13, #0x9, LS
    FCVTPU  X22, H30
    FSQRT  S10, S22
    FCVTZS  X5, H10, #31
    FRINTZ  D31, D23
    FCVTMU  W28, H31
    FCVTAU  X3, S24
    FCVTAS  W10, S18
    FCMP  S18, #0.0
    FCVTZU  W29, H7
    FCVTPU  X28, S18
    UCVTF  S18, W22, #18
    SCVTF  D23, W28, #26
    FMADD  H3, H6, H16, H2
    FMOV  X29, H17
    FCVTZS  W13, H31
    FDIV  H6, H10, H11
    FCVTMS  W13, D27
    FMUL  H22, H30, H13
    FRINTA  H30, H0
    FCVT  S0, D7
    FNMSUB  D1, D27, D0, D28
    FCVT  S2, D27
    FCVTZS  X27, S24
    FCMP  S4, S12
    FADD  H4, H22, H29
    FCVTZU  W3, S15
    SCVTF  H0, X3, #4
    FCVTAU  W16, D6
    FCSEL  S24, S1, S4, GT
    FABS  S31, S3
    FCVTAS  X5, S31
    UCVTF  D7, W10
    FDIV  D10, D2, D30
    FCVTMU  X10, S0
    FCVTZU  W13, H10
    FMADD  S4, S24, S24, S24
    FCCMP  S4, S7, #0xb, GT
    FMOV  X18, D27
    FNMSUB  H30, H18, H27, H3
    FMADD  D7, D30, D30, D30
    FCVTZS  X29, D23, #2
    FCVTZU  W4, D30, #18
    FSUB  D24, D30, D29
    FMOV  D23, D23
    FCVTMU  W22, S11
    FADD  D15, D7, D14
    FCVTPS  X17, D22
    FCVTZU  X5, D30
    FRINTP  H3, H20
    FCCMP  S11, S23, #0x1, LS
    FCVTZU  X15, D25
    FRINTZ  D4, D30
    FCCMP  H3, H15, #0x5, PL
    FCMPE  H20, #0.0
    FRINTN  D18, D13
    FCVT  H29, D10
    FCVTAU  X16, S30
    FRINTN  H20, H1
    FCVTNS  W7, S18
    FCVTPU  X11, H26
    FCVTMS  W11, H14
    FMOV  S3, W17
    FRINTP  H13, H5
    FMIN  S15, S30, S17
    FNEG  H25, H27
    FCMPE  D30, #0.0
    FCVTMS  W6, D25
    FRINTZ  H27, H15
    FCVTAU  W10, D0
    FCVTZU  W22, D30
    SCVTF  D30, W5
    FRINTP  S14, S0
    UCVTF  H10, X16
    FCVTZU  X10, D10, #37
    FDIV  S15, S20, S20
    FRINTA  S10, S14
    FCVTZS  X22, S13, #11
    FRINTP  D5, D3
    FRINTX  D18, D27
    FCVTPS  X11, H18
    FMOV  S25, #-1.81250000
    FSUB  H17, H30, H25
    FCVTPU  W14, S10
    FCVTPS  W15, H17
    FCVTZU  X15, D5, #28
    FSUB  D18, D15, D15
    FRINTZ  H17, H18
    FCVTNS  X27, H17
    FMADD  H25, H8, H1, H28
    FCVT  H20, D28
    FMOV  W28, H11
    FNMADD  D5, D9, D15, D0
    FADD  H18, H29, H28
    FMAX  S9, S24, S2
    FRINTX  D15, D28
    FABS  D14, D14
    FCVTNS  W24, D12
    FCVTMU  X28, D3
    SCVTF  D27, W27, #32
    FMUL  H8, H12, H9
    FCVTMU  X21, D16
    FRINTM  S28, S6
    FADD  S10, S18, S5
    FABS  H18, H20
    FNMADD  H20, H18, H15, H28
    FRINTI  H29, H25
    FCVTPU  X10, S29
    FCVTNS  W22, D8
    FCVTZU  X4, S14, #22
    FMADD  S12, S20, S13, S11
    FCVTPU  X28, S12
    FCVTAS  W17, D27
    FCVT  H16, S24
    FSUB  D3, D14, D30
    FMAX  H25, H28, H22
    FCVT  S0, H1
    FCVTAS  X7, H9
    FRINTN  D22, D13
    FCVTZU  W3, D3, #27
    UCVTF  D11, X4, #10
    FCVT  S13, D18
    FCVTNS  X14, S21
    FNMSUB  D27, D0, D11, D27
    FCCMP  S13, S25, #0x7, NV
    FCCMP  D31, D10, #0x6, CS
    FNMUL  H24, H0, H19
    FCVTMU  W21, D9
    FCMP  D11, #0.0
    FNEG  D8, D19
    FRINTP  D14, D9
    FABS  H25, H11
    UCVTF  H18, X14, #46
    SCVTF  S19, W21, #10
    FNEG  D21, D18
    FNMSUB  S29, S14, S14, S21
    FRINTM  H9, H25
    SCVTF  H0, X3
    FCVTAS  W7, H27
    FCVTZS  W13, H0
    FCVTNS  X7, S8
    FCVTZS  W16, D24, #29
    FRINTZ  D18, D9
    FNMADD  S3, S19, S18, S29
    FRINTP  S18, S3
    FCVTAU  W5, S18
    FCVTAU  X21, S4
    FCVTMS  X18, H27
    FMOV  H27, H21
    FMAX  H21, H22, H12
    FCVTAU  X17, H2
    FCVTNS  W18, S30
    FMOV  S12, S21
    FRINTI  S9, S23
    FCVTMS  W4, D13
    FCMP  D17, #0.0
    FCCMP  D13, D29, #0xe, VC
    FMOV  X16, D22
    FCVTZS  X3, D21
    FCVTZU  X5, S22
    FMIN  H2, H15, H25
    FCSEL  S4, S31, S9, CC
    UCVTF  H23, X18, #36
    FADD  S17, S26, S3
    FCVTPS  X29, S1
    FRINTI  D30, D31
    FCMPE  D15, D22
    SCVTF  D21, W5
    FCVTZS  X17, S7, #45
    UCVTF  H15, W21, #20
    FNMADD  D13, D15, D30, D17
    FRINTA  D15, D21
    FABS  S22, S23
    SCVTF  S31, W17
    FCVTMU  W21, D4
    SUBS  X23, X23, #0x1
    B.NE  TSRTFloatAllOperation_label_2
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x1, LSL #0
    SUB  X25, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X25, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x1f, LSL #0
    MRS  X25, FPSR
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    FMOV  X25, D3
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X25, D5
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    FMOV  X25, D6
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X25, D8
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7fc0, LSL #16
    MOVK  X12, #0x8000, LSL #48
    FMOV  X25, D13
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7fc0, LSL #16
    FMOV  X25, D17
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    FMOV  X25, D18
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x8000, LSL #0
    FMOV  X25, D20
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x8000, LSL #0
    FMOV  X25, D24
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X25, V26.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X25, D26
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x7155, LSL #0
    MOVK  X3, #0x9f60, LSL #16
    MOVK  X3, #0xf207, LSL #32
    MOVK  X3, #0x183, LSL #48
    MOVZ  X4, #0x9d1d, LSL #0
    MOVK  X4, #0x21f, LSL #16
    MOVK  X4, #0x7a04, LSL #32
    MOVK  X4, #0x6fa, LSL #48
    MOVZ  X5, #0x43ba, LSL #0
    MOVK  X5, #0xde09, LSL #16
    MOVK  X5, #0xce93, LSL #32
    MOVK  X5, #0x4643, LSL #48
    MOVZ  X6, #0x3785, LSL #0
    MOVK  X6, #0x7bab, LSL #16
    MOVK  X6, #0xf6fe, LSL #32
    MOVK  X6, #0x8b90, LSL #48
    MOVZ  X7, #0xfbb1, LSL #0
    MOVK  X7, #0xa76e, LSL #16
    MOVK  X7, #0xd78d, LSL #32
    MOVK  X7, #0x3db8, LSL #48
    MOVZ  X10, #0x4481, LSL #0
    MOVK  X10, #0x4ae1, LSL #16
    MOVK  X10, #0xf654, LSL #32
    MOVK  X10, #0x83fa, LSL #48
    MOVZ  X11, #0xf1fa, LSL #0
    MOVK  X11, #0xc84d, LSL #16
    MOVK  X11, #0x7e5d, LSL #32
    MOVK  X11, #0x86ef, LSL #48
    MOVZ  X12, #0xd1b1, LSL #0
    MOVK  X12, #0x63f9, LSL #16
    MOVK  X12, #0x2de6, LSL #32
    MOVK  X12, #0x33bd, LSL #48
    MOVZ  X13, #0x8674, LSL #0
    MOVK  X13, #0x93f5, LSL #16
    MOVK  X13, #0x5993, LSL #32
    MOVK  X13, #0x7034, LSL #48
    MOVZ  X14, #0xe95e, LSL #0
    MOVK  X14, #0x5963, LSL #16
    MOVK  X14, #0xf11b, LSL #32
    MOVK  X14, #0xb498, LSL #48
    MOVZ  X15, #0x1fb4, LSL #0
    MOVK  X15, #0xfda0, LSL #16
    MOVK  X15, #0xb687, LSL #32
    MOVK  X15, #0xc2c6, LSL #48
    MOVZ  X16, #0xfa04, LSL #0
    MOVK  X16, #0x6363, LSL #16
    MOVK  X16, #0x6685, LSL #32
    MOVK  X16, #0x6345, LSL #48
    MOVZ  X17, #0x4d9d, LSL #0
    MOVK  X17, #0x4edf, LSL #16
    MOVK  X17, #0xb96d, LSL #32
    MOVK  X17, #0xce76, LSL #48
    MOVZ  X18, #0xd993, LSL #0
    MOVK  X18, #0x7610, LSL #16
    MOVK  X18, #0x9620, LSL #32
    MOVK  X18, #0xa42b, LSL #48
    MOVZ  X20, #0x368, LSL #0
    MOVK  X20, #0x9462, LSL #16
    MOVK  X20, #0x294e, LSL #32
    MOVK  X20, #0x4486, LSL #48
    MOVZ  X21, #0x3b53, LSL #0
    MOVK  X21, #0xc5eb, LSL #16
    MOVK  X21, #0xdd69, LSL #32
    MOVK  X21, #0xe7b4, LSL #48
    MOVZ  X22, #0xb2ed, LSL #0
    MOVK  X22, #0x489c, LSL #16
    MOVK  X22, #0x9c49, LSL #32
    MOVK  X22, #0xbd0f, LSL #48
    MOVZ  X23, #0xdece, LSL #0
    MOVK  X23, #0xe4fa, LSL #16
    MOVK  X23, #0x627e, LSL #32
    MOVK  X23, #0x80fb, LSL #48
    MOVZ  X24, #0xd3ee, LSL #0
    MOVK  X24, #0x25df, LSL #16
    MOVK  X24, #0xa315, LSL #32
    MOVK  X24, #0x14e6, LSL #48
    MOVZ  X25, #0x3a4b, LSL #0
    MOVK  X25, #0xe745, LSL #16
    MOVK  X25, #0xca39, LSL #32
    MOVK  X25, #0x62ac, LSL #48
    MOVZ  X26, #0x87b4, LSL #0
    MOVK  X26, #0x55a6, LSL #16
    MOVK  X26, #0x1d68, LSL #32
    MOVK  X26, #0x809b, LSL #48
    MOVZ  X27, #0x1d6c, LSL #0
    MOVK  X27, #0x99d3, LSL #16
    MOVK  X27, #0x31b, LSL #32
    MOVK  X27, #0x9712, LSL #48
    MOVZ  X28, #0xe5e4, LSL #0
    MOVK  X28, #0x8357, LSL #16
    MOVK  X28, #0x5a34, LSL #32
    MOVK  X28, #0x42eb, LSL #48
    MOVZ  X29, #0xd971, LSL #0
    MOVK  X29, #0xe04d, LSL #16
    MOVK  X29, #0x7c0, LSL #32
    MOVK  X29, #0xd425, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X13
    FMOV  D3, X29
    FMOV  V3.D[1], X12
    FMOV  D4, X25
    FMOV  V4.D[1], X4
    FMOV  D5, X11
    FMOV  V5.D[1], X10
    FMOV  D6, X25
    FMOV  V6.D[1], X21
    FMOV  D7, X29
    FMOV  V7.D[1], X16
    FMOV  D8, X7
    FMOV  V8.D[1], X16
    FMOV  D9, X28
    FMOV  V9.D[1], X13
    FMOV  D10, X14
    FMOV  V10.D[1], X29
    FMOV  D11, X6
    FMOV  V11.D[1], X17
    FMOV  D12, X20
    FMOV  V12.D[1], X13
    FMOV  D13, X29
    FMOV  V13.D[1], X3
    FMOV  D14, X24
    FMOV  V14.D[1], X10
    FMOV  D15, X17
    FMOV  V15.D[1], X6
    FMOV  D16, X15
    FMOV  V16.D[1], X23
    FMOV  D17, X21
    FMOV  V17.D[1], X13
    FMOV  D18, X12
    FMOV  V18.D[1], X3
    FMOV  D19, X26
    FMOV  V19.D[1], X4
    FMOV  D20, X29
    FMOV  V20.D[1], X13
    FMOV  D21, X10
    FMOV  V21.D[1], X11
    FMOV  D22, X5
    FMOV  V22.D[1], X28
    FMOV  D23, X24
    FMOV  V23.D[1], X14
    FMOV  D24, X17
    FMOV  V24.D[1], X26
    FMOV  D25, X11
    FMOV  V25.D[1], X26
    FMOV  D26, X4
    FMOV  V26.D[1], X7
    FMOV  D27, X12
    FMOV  V27.D[1], X21
    FMOV  D28, X26
    FMOV  V28.D[1], X6
    FMOV  D29, X24
    FMOV  V29.D[1], X27
    FMOV  D30, X18
    FMOV  V30.D[1], X11
    FMOV  D31, X22
    FMOV  V31.D[1], X14
    MOVZ  X15, #0xa, LSL #0
TSRTFloatAllOperation_label_3:
    FMADD  D4, D22, D31, D29
    UCVTF  H3, W10, #30
    FSUB  S5, S28, S4
    FCVTMU  X18, S3
    FSQRT  D22, D24
    FCCMPE  H25, H25, #0xd, HI
    FCVTNU  X21, D22
    FMUL  S25, S26, S30
    FABS  D0, D25
    FMIN  D23, D5, D27
    FRINTA  D15, D23
    FCCMPE  S0, S20, #0x1, VC
    FRINTZ  D5, D20
    FRINTP  H10, H10
    FCVTPU  W10, H4
    FMOV  W21, S8
    FMADD  H8, H24, H7, H22
    FCVTMS  W14, H0
    FRINTM  S20, S7
    SCVTF  S27, W7
    UCVTF  H4, W12, #6
    UCVTF  H23, W26, #16
    FCMP  D26, D14
    FCVTMS  X7, D7
    FCVTAU  X26, H1
    FMOV  S26, S20
    FCVTAU  X12, S22
    FCVTZU  W6, S21, #5
    FCCMPE  D27, D4, #0x4, NE
    FRINTA  S22, S17
    FCVTPS  W4, D30
    FMOV  X26, H8
    FCMPE  H3, #0.0
    FMOV  X11, H5
    FRINTN  S20, S14
    FABS  D5, D28
    FCVTMU  X23, S20
    FCVTAU  W23, D24
    FMINNM  H1, H13, H6
    FCVTZU  X4, H31
    FCVTZS  W17, D25, #7
    FCVTPS  X17, D24
    FDIV  S8, S5, S19
    FCVTPU  X5, D9
    FCVTAU  X7, H6
    FCVTPS  X29, S8
    FCVTZS  W6, S21
    FNMSUB  H0, H31, H2, H15
    FCVTPU  X11, S20
    FCMPE  H2, H24
    FCCMPE  D23, D20, #0x5, NE
    FCVTPS  X5, D14
    FMIN  S3, S1, S13
    FRINTX  D28, D9
    FRINTX  D30, D31
    FMOV  H2, H11
    FCVTMS  X4, H17
    FNEG  H11, H17
    FCVTMS  W4, S28
    FCVTZU  X13, H3
    FMAX  H29, H18, H8
    FSQRT  H25, H5
    FCVT  D15, H24
    FRINTI  D13, D4
    FCVTAU  X4, H13
    FSQRT  D4, D7
    FCVTMS  X4, H31
    FCMP  H5, H3
    FMOV  D20, D8
    FSUB  S28, S11, S15
    FRINTP  H31, H30
    FMOV  H21, X13
    FCVTPS  X29, S2
    FRINTN  H7, H4
    FCVTMU  W11, H7
    FCVT  S5, H29
    FCVTZS  W16, D25, #16
    FCVTMS  W26, S31
    SCVTF  H3, X26
    FCVTNS  X11, D21
    FMINNM  H4, H3, H20
    FCVTZS  W5, S5
    UCVTF  H20, X5, #24
    FMOV  S15, #5.25000000
    FRINTZ  S25, S22
    FSQRT  H29, H28
    FCVTNS  X13, H15
    FNMADD  D30, D20, D25, D4
    FCMP  S30, S29
    FMAXNM  D5, D16, D31
    SCVTF  H11, W16
    FRINTI  S3, S2
    FABS  H25, H7
    FCVTAS  X7, H12
    FCMP  S22, S6
    FCVTZU  X14, D27
    FNEG  D6, D10
    FCSEL  H7, H31, H27, NE
    FCVTZS  X18, D28, #8
    FCVTPS  W27, H8
    SCVTF  S21, X18, #51
    FCVTMS  W5, D22
    FCVTZS  X23, D0, #15
    FCMPE  H29, #0.0
    FMADD  S12, S19, S16, S28
    FCVTNU  W21, H19
    SCVTF  D10, W23, #2
    FRINTZ  H2, H5
    FMAX  H29, H12, H10
    FRINTZ  S28, S21
    FCVTAS  W5, S28
    FCVTZU  X28, H3
    FMINNM  H27, H7, H11
    FCMP  H2, H6
    FCVTZU  W10, H27
    FCVTNS  W26, H29
    FRINTZ  H8, H26
    FMUL  H16, H9, H25
    FCVT  S5, H19
    FSUB  H21, H12, H3
    FADD  H0, H6, H5
    FCVTMS  X13, D19
    FMSUB  S28, S27, S19, S30
    FRINTP  D12, D28
    FMOV  D10, X27
    SCVTF  H2, X10, #2
    FCVT  S9, D13
    FMSUB  S26, S23, S28, S22
    FCVTPU  X13, D8
    FSUB  D19, D21, D21
    FCVTAS  W11, H20
    FCMP  D28, D26
    FNMADD  S28, S9, S9, S16
    FMOV  W13, H2
    UCVTF  H20, W26, #14
    FCVTNS  X4, S12
    FNMADD  D13, D0, D0, D0
    FMAX  S5, S5, S10
    FCVTNU  X6, S5
    FCVTAU  W12, D13
    FCVTAS  W16, D20
    FRINTZ  D22, D28
    FMOV  H0, W4
    SCVTF  H8, W13, #22
    FCVTNU  X3, H0
    UCVTF  S5, W11
    FCSEL  S13, S22, S19, CC
    UCVTF  S20, W14, #29
    FCMPE  H5, #0.0
    FMOV  X29, D13
    FDIV  S2, S20, S22
    FMOV  X28, D2
    FMOV  D13, X28
    FCVT  D28, S15
    FCSEL  S5, S31, S27, CS
    FRINTP  D10, D30
    FCVTPS  W13, H26
    FCMP  H24, H15
    FSQRT  S22, S29
    FCMP  D20, #0.0
    FRINTP  S0, S10
    FCVTAU  X16, H23
    FCVTZS  W16, H6, #9
    FCVTZS  W21, S7, #18
    FRINTI  H15, H6
    FMOV  H29, H15
    FCVT  H9, S30
    FCVTAS  X21, S11
    FCVTZS  X17, D21, #5
    FCVTPU  W20, S14
    FMIN  H27, H6, H27
    FRINTZ  S11, S8
    FRINTN  D2, D29
    FCVTZU  X10, S28, #1
    FCVTPU  X29, S9
    FMOV  W29, H22
    FMOV  S28, #1.62500000
    FCVTZU  W14, H28, #18
    UCVTF  S10, X29
    FMOV  D6, X21
    FNMUL  H22, H13, H11
    SCVTF  S11, W17, #25
    FMINNM  H28, H2, H2
    FCMP  H27, #0.0
    FMOV  D9, X20
    FCVTMS  W21, D0
    FCMPE  H10, H22
    FDIV  S21, S6, S9
    SCVTF  D27, W14, #24
    FMIN  S8, S27, S21
    FNMUL  H21, H28, H8
    FCVTZU  W5, H21, #25
    FCVTNU  X27, H22
    FRINTA  S13, S23
    FCVTNS  W28, S28
    FADD  D22, D0, D26
    FCVTNS  W26, H29
    FCVTAS  X11, H22
    FCVTAU  W26, H2
    FRINTI  S6, S8
    FCCMP  S25, S4, #0xe, HI
    SCVTF  H25, W5, #20
    FDIV  S26, S29, S25
    FDIV  S28, S4, S18
    FCMPE  D23, D8
    FRINTN  S23, S29
    FCVT  S22, H20
    FCVTPS  X29, H23
    FCMPE  D1, #0.0
    FCVTZS  X26, S13, #11
    FNMUL  H0, H12, H22
    FCVTZU  W18, H19, #19
    FMOV  H8, H21
    FCMPE  D21, D17
    FCVTNS  W11, D1
    FCMP  S15, S0
    FCVTAS  W20, D16
    FCCMPE  D12, D14, #0xe, GE
    FCVTMU  X6, D14
    FCVTNS  X18, D30
    FSQRT  D2, D28
    FCVTMS  W14, S3
    FCVTZS  W21, H21, #27
    FNMUL  S20, S14, S25
    FCVTZS  W6, S12
    FMOV  D18, X18
    FMOV  D28, D12
    UCVTF  D17, W20, #29
    FCVTAS  X20, H25
    FCVTZS  X16, D2
    UCVTF  S25, W16
    FCVTNU  X18, S10
    FCCMPE  H31, H18, #0xb, VS
    FRINTM  H23, H18
    FCMP  S13, #0.0
    FCVTMS  X16, D28
    FCVTAU  W16, D11
    FCVTAS  X23, S15
    SCVTF  H11, X18, #52
    FCMP  H1, #0.0
    FCMP  S19, #0.0
    FCVTMU  X5, H27
    FCVTPU  X28, H18
    FCVTZS  X7, S3
    FNMUL  S12, S21, S12
    FCVTNS  X26, S27
    FCVTNU  W26, S0
    FMOV  H2, W5
    FCVTAS  W21, S20
    FDIV  S18, S5, S14
    FCVTZS  W18, H30
    FRINTA  H27, H20
    FCVTPU  W28, D4
    FMOV  W18, S4
    FMINNM  S0, S12, S18
    FCVT  H28, D17
    FCVTZS  W3, S24, #8
    SCVTF  S15, W23, #8
    FCVTAS  X13, S10
    FCVTZS  X28, H4, #21
    UCVTF  H19, W21
    FCVTAU  W27, H27
    FRINTX  D18, D28
    FNEG  D5, D15
    FCVTNU  W16, H18
    FCVTNS  X13, D19
    FCVTNU  W11, S0
    FCVTZS  W27, D5, #9
    FABS  H3, H22
    FCVTNS  X23, D3
    FRINTI  D27, D18
    FMOV  S4, #-0.25000000
    FCVT  H30, S27
    FCVTAU  X16, H30
    FRINTA  D0, D4
    FCVTPU  W21, H0
    FMOV  H15, W13
    FNMUL  H19, H22, H20
    FMAXNM  S5, S4, S5
    FCVTZU  W16, D2, #17
    FCVTMU  W4, S17
    FNMSUB  H24, H31, H1, H6
    FNEG  D30, D29
    FSQRT  S2, S5
    UCVTF  D5, X27, #49
    FADD  H17, H3, H3
    FMAXNM  D18, D25, D15
    FCVT  H0, S6
    FRINTX  H6, H28
    FCVTMS  W7, S19
    SCVTF  H19, X4, #2
    FCMP  H17, #0.0
    FMINNM  D29, D30, D0
    FCCMP  D24, D19, #0x1, AL
    FMUL  D1, D2, D18
    UCVTF  S15, W21, #27
    FCVTZU  W5, S5
    FCVTZS  X20, S6, #15
    SCVTF  D2, W16
    FCMP  D2, #0.0
    SUBS  X15, X15, #0x1
    B.NE  TSRTFloatAllOperation_label_3
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X22, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x1f, LSL #0
    MRS  X22, FPSR
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D0
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V1.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D1
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D2
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D3
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xbe80, LSL #16
    FMOV  X22, D4
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D5
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D6
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D7
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x8000, LSL #0
    FMOV  X22, D8
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x1, LSL #0
    FMOV  X22, D9
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D10
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D11
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    FMOV  X22, D12
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D13
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x4481, LSL #0
    MOVK  X25, #0x4ae1, LSL #16
    MOVK  X25, #0xf654, LSL #32
    MOVK  X25, #0x83fa, LSL #48
    FMOV  X22, V14.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0xd3ee, LSL #0
    MOVK  X25, #0x25df, LSL #16
    MOVK  X25, #0xa315, LSL #32
    MOVK  X25, #0x14e6, LSL #48
    FMOV  X22, D14
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D15
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D16
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D17
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D18
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    FMOV  X22, D20
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x8000, LSL #0
    FMOV  X22, D21
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D22
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D23
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D25
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X22, D26
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D27
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D28
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #48
    FMOV  X22, D29
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #48
    FMOV  X22, D30
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X22, D31
    SUB  X24, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    FMOV  V0.D[1], X29
    FMOV  D1, X15
    FMOV  V1.D[1], X23
    FMOV  D2, X16
    FMOV  V2.D[1], X22
    FMOV  D3, X24
    FMOV  V3.D[1], X26
    FMOV  D4, X28
    FMOV  V4.D[1], X27
    FMOV  D5, X20
    FMOV  V5.D[1], X18
    FMOV  D6, X14
    FMOV  V6.D[1], X25
    FMOV  D7, X28
    FMOV  V7.D[1], X14
    FMOV  D8, X5
    FMOV  V8.D[1], X16
    FMOV  D9, X26
    FMOV  V9.D[1], X14
    FMOV  D10, X21
    FMOV  V10.D[1], X12
    FMOV  D11, X4
    FMOV  V11.D[1], X16
    FMOV  D12, X27
    FMOV  V12.D[1], X13
    FMOV  D13, X26
    FMOV  V13.D[1], X18
    FMOV  D14, X29
    FMOV  V14.D[1], X5
    FMOV  D15, X28
    FMOV  V15.D[1], X23
    FMOV  D16, X24
    FMOV  V16.D[1], X16
    FMOV  D17, X14
    FMOV  V17.D[1], X14
    FMOV  D18, X24
    FMOV  V18.D[1], X6
    FMOV  D19, X26
    FMOV  V19.D[1], X16
    FMOV  D20, X18
    FMOV  V20.D[1], X17
    FMOV  D21, X4
    FMOV  V21.D[1], X22
    FMOV  D22, X18
    FMOV  V22.D[1], X28
    FMOV  D23, X3
    FMOV  V23.D[1], X21
    FMOV  D24, X5
    FMOV  V24.D[1], X13
    FMOV  D25, X16
    FMOV  V25.D[1], X24
    FMOV  D26, X17
    FMOV  V26.D[1], X11
    FMOV  D27, X20
    FMOV  V27.D[1], X6
    FMOV  D28, X4
    FMOV  V28.D[1], X4
    FMOV  D29, X4
    FMOV  V29.D[1], X25
    FMOV  D30, X5
    FMOV  V30.D[1], X24
    FMOV  D31, X26
    FMOV  V31.D[1], X5
    MOVZ  X18, #0xa, LSL #0
TSRTFloatAllOperation_label_4:
    FCMP  S24, #0.0
    FMOV  W6, S31
    FCVTAU  X13, H30
    FCVTMS  X16, D19
    FCVTMS  W26, H28
    FCVT  H22, D27
    FMADD  H4, H26, H26, H25
    FRINTN  S17, S29
    FMOV  H1, W14
    SCVTF  S12, X18
    FCVTPU  W14, H4
    FDIV  H4, H1, H12
    FCVTZS  X10, H22
    FMADD  D21, D4, D17, D17
    FCVTZU  X25, D30
    FMIN  S19, S23, S27
    FCVTZS  X29, S4, #30
    FCVTNS  X15, H13
    UCVTF  H13, W10
    FCVTAU  X10, D15
    FCVTZU  X29, D17, #13
    FABS  D24, D22
    FMOV  X28, H2
    FMOV  S15, #-7.50000000
    FNEG  D4, D26
    FCVTAS  X13, S23
    FMOV  W14, S5
    FCMP  S6, #0.0
    FRINTX  S17, S16
    FMIN  S26, S11, S10
    FRINTZ  D1, D24
    FMOV  H11, #-3.87500000
    FCVTZU  W29, S19
    UCVTF  H2, W28, #27
    UCVTF  S16, W14
    FSUB  H19, H21, H11
    FMAX  S22, S4, S19
    SCVTF  S24, X13, #10
    FCVTAS  X14, H2
    UCVTF  H2, X29, #48
    FCMP  H1, #0.0
    FRINTP  H1, H22
    FRINTZ  S21, S15
    FCCMP  D26, D13, #0xa, LE
    FCVTAS  X15, S17
    FCVTNS  W14, D16
    FMOV  H26, X14
    FDIV  D10, D26, D24
    FDIV  D22, D10, D2
    FCVT  S15, D21
    FCVTAS  X6, D1
    UCVTF  D17, X15
    FMOV  H21, H0
    FCVTZS  W16, H22, #14
    FCVTAS  X14, H15
    FCVTZS  W14, D21
    FDIV  H13, H24, H5
    FCVTAS  W26, S21
    FSQRT  H22, H2
    FCMP  S27, #0.0
    FNEG  D24, D12
    FCVTNU  W16, S8
    FCVTNU  X13, D2
    FMSUB  S4, S19, S25, S27
    FRINTZ  D8, D29
    FRINTX  S29, S29
    FMUL  S21, S28, S13
    SCVTF  H16, W4
    UCVTF  S1, X21, #61
    FSUB  S19, S1, S24
    FMOV  X22, H22
    FCVTZS  W7, S8
    FCVTZS  X17, S16
    FCMPE  H29, H19
    FMOV  W26, S21
    FCVTPU  X20, S17
    SCVTF  D25, W14, #28
    FMUL  D13, D23, D5
    FCSEL  S1, S29, S13, CS
    FMSUB  H12, H19, H11, H1
    FCVTMS  X13, H4
    FSQRT  S15, S26
    FCVTPU  X12, H1
    UCVTF  D21, W22
    FCVTPU  W17, S26
    FCVTPS  X29, D3
    FCVTZS  W22, H7, #12
    FRINTX  H7, H10
    SCVTF  S8, W22, #21
    FABS  S24, S24
    FMUL  S17, S9, S17
    FCVTAU  W29, H9
    FRINTA  S9, S26
    FCVTNS  X12, D12
    FSUB  D29, D7, D8
    FDIV  S1, S15, S24
    FCSEL  D26, D29, D9, HI
    FCVTZS  W3, D17
    FCVTMS  W14, D21
    FCCMPE  S26, S1, #0x6, MI
    FCMP  D29, D25
    FNMSUB  H4, H31, H27, H28
    FCVTAS  X29, S0
    FMINNM  H3, H10, H7
    FCVTAS  W22, H30
    FCVTNU  X26, D10
    UCVTF  D17, X14, #57
    FMOV  S10, W17
    UCVTF  D27, X26, #30
    FRINTM  H7, H19
    SCVTF  D30, W22
    FMSUB  D31, D22, D25, D15
    SCVTF  D28, X3, #15
    FMOV  H29, H7
    FCVTPS  W11, S10
    FCVTMS  W26, D3
    UCVTF  H10, X11
    FCVTAU  W7, S30
    FCVTZS  W15, S27
    FCVTMU  W4, S31
    FRINTN  H31, H17
    UCVTF  D17, X29
    FMIN  H26, H17, H28
    FCVTNU  X29, S31
    FCVTNU  W3, S10
    FCVTMU  X25, H26
    FCVTZS  X6, H29
    FCVTNS  W6, H12
    FMSUB  D29, D14, D2, D30
    FNEG  S27, S25
    FMINNM  S12, S24, S30
    FNMUL  S25, S20, S24
    FRINTA  H20, H12
    SCVTF  S10, X29, #52
    FMADD  H28, H5, H0, H22
    FMAX  S17, S25, S24
    FCMPE  D29, D7
    FRINTN  H26, H12
    FNEG  D5, D23
    FCVTMU  X3, S23
    FRINTX  S22, S27
    SCVTF  S14, W3
    FCVT  S30, D27
    FDIV  H29, H11, H27
    FMADD  H25, H26, H29, H20
    FCVTNS  W26, D10
    UCVTF  H0, W4
    FCVTNU  X13, H5
    FCVTZU  X13, H28, #23
    FNMADD  H29, H8, H25, H22
    FMADD  D31, D29, D29, D0
    FCVTPS  W7, D17
    SCVTF  S0, W13, #8
    FMAXNM  D12, D31, D0
    FMSUB  D10, D12, D30, D12
    FADD  D23, D10, D14
    FCMPE  D17, #0.0
    FSUB  D12, D27, D4
    FCVTAU  W6, H18
    UCVTF  S0, W26, #16
    FCVTZU  X29, H22, #27
    FSQRT  S25, S27
    SCVTF  D30, X6, #61
    FCMPE  H30, H2
    FCVTZU  W17, H12, #17
    FCVTZS  W11, H26
    FCSEL  D2, D30, D0, PL
    FMAXNM  H17, H23, H24
    FCVTNU  W21, S10
    UCVTF  D8, W21
    FRINTM  H22, H30
    FCVTPU  W17, D0
    FMUL  H18, H21, H12
    FCSEL  D21, D8, D27, VC
    FCVTMS  W3, S12
    SCVTF  S4, W17
    UCVTF  H23, X3, #54
    FRINTA  D10, D4
    FRINTA  D27, D13
    FCVTZS  W26, H10, #3
    FMIN  S24, S27, S17
    FCSEL  S0, S22, S22, VS
    FSUB  S8, S25, S2
    FCVTNS  X15, D18
    FCMPE  H23, #0.0
    UCVTF  H10, X26, #17
    FCVTAS  X29, H10
    FRINTP  S26, S21
    FMAXNM  D17, D24, D14
    FRINTX  S13, S0
    FMIN  D30, D13, D19
    FCVTZS  X10, H17, #28
    FRINTI  H4, H8
    FNMUL  D14, D26, D4
    FCVTZU  X22, S14, #48
    FCMP  D21, #0.0
    FRINTM  D27, D8
    FCVTPU  X28, D29
    FMUL  H18, H27, H25
    FCVTMS  X21, H25
    UCVTF  D21, W10, #29
    FDIV  D29, D29, D31
    SCVTF  S24, X21
    FCVTPU  X17, S7
    FCMPE  D4, D3
    FCVTNU  X25, S13
    FCVTZU  X27, H18, #46
    FMUL  S14, S10, S17
    FCVTNS  W4, H16
    FCVTZU  W29, D14
    FRINTA  D17, D20
    FSUB  D8, D19, D2
    FNMUL  S19, S25, S14
    FMAXNM  H16, H21, H31
    FCVTZU  X11, D25
    FDIV  D14, D10, D10
    FCVTNU  X14, D28
    UCVTF  S27, W25, #31
    FCSEL  D18, D24, D17, CS
    FMADD  S28, S8, S8, S19
    FCVTZS  X10, H29, #44
    FMOV  D17, X29
    FCVTPS  X21, D16
    FDIV  H2, H27, H17
    UCVTF  S10, W11, #8
    FCVTZU  W13, H14
    FMOV  D16, D18
    FCVTAU  X6, S2
    FCVTZU  W4, S28
    FCCMPE  D16, D16, #0x5, GT
    FCVTMU  X13, H6
    FRINTI  S2, S15
    FCMPE  D3, #0.0
    FRINTM  S24, S7
    FRINTI  S18, S24
    SCVTF  H7, W13
    FCVTZU  X29, H20, #58
    FMOV  H20, X21
    FNMSUB  H19, H4, H4, H27
    FCVTZS  X20, H28, #47
    FMINNM  H8, H16, H19
    FRINTA  H21, H9
    FCMPE  H3, H12
    FRINTI  D14, D1
    SCVTF  D25, W20, #22
    FMOV  H16, H25
    FCMP  S14, #0.0
    FCVTZS  W6, S16
    FMAXNM  S6, S7, S2
    FMOV  S24, #17.00000000
    FCMP  S20, #0.0
    FCMP  S21, S18
    FCCMPE  H8, H8, #0x4, NE
    FMIN  D2, D6, D6
    FNMSUB  S7, S2, S24, S2
    FCVTMS  X25, H7
    FSQRT  S27, S5
    FCVT  D24, H30
    FMADD  H6, H5, H28, H14
    FCVTMU  W12, D23
    FCCMPE  H2, H29, #0xc, CC
    FCVTNU  W10, H10
    FMOV  H29, X10
    FMIN  H20, H23, H7
    FMSUB  H30, H21, H11, H0
    FRINTP  S25, S9
    FRINTM  S23, S31
    FMOV  H16, #0.29687500
    FCVT  D18, H13
    FNMSUB  D28, D23, D29, D16
    FCMPE  H18, H24
    FCVTAS  W12, D28
    FCVTZS  X26, S25, #51
    FNMADD  D25, D17, D20, D27
    UCVTF  H27, W25
    FMUL  S16, S30, S6
    FSUB  H0, H16, H16
    FCSEL  D31, D0, D27, MI
    FNMUL  H30, H31, H31
    FCVTNU  X10, S30
    FCVTZU  X27, H7, #32
    FRINTM  H23, H26
    FMSUB  H9, H1, H2, H29
    FMOV  W4, S2
    FCVTNU  X15, D19
    SCVTF  H16, W12, #15
    FRINTZ  D31, D1
    FCVTZU  W16, S8, #3
    FADD  H6, H27, H28
    FCVTZU  W21, H0
    FRINTA  D7, D12
    FCSEL  H28, H30, H5, CS
    FMOV  H26, H15
    FCMPE  S25, S9
    FCMPE  H31, #0.0
    SCVTF  S0, X21
    FCCMP  S28, S6, #0x7, VS
    FMAXNM  S15, S30, S16
    FSQRT  D6, D15
    FCVTMU  X22, D7
    SUBS  X18, X18, #0x1
    B.NE  TSRTFloatAllOperation_label_4
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x1, LSL #0
    SUB  X24, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x1, LSL #0
    SUB  X24, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X24, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x1f, LSL #0
    MRS  X24, FPSR
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D0
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D1
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D2
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D3
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D4
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #48
    FMOV  X24, D5
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x3bcc, LSL #0
    MOVK  X5, #0x667f, LSL #16
    MOVK  X5, #0xa09e, LSL #32
    MOVK  X5, #0x1ed6, LSL #48
    FMOV  X24, D6
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D7
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D8
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D9
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D10
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0xc3c0, LSL #0
    FMOV  X24, D11
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #16
    FMOV  X24, D12
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D13
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D14
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x8000, LSL #0
    FMOV  X24, D15
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D16
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D17
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D18
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D19
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D20
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D22
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D23
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D24
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0x8000, LSL #48
    FMOV  X24, D25
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D26
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D27
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x8000, LSL #0
    FMOV  X24, D28
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D29
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x8000, LSL #0
    FMOV  X24, D30
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X23, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X23
    FMOV  V3.D[1], X4
    FMOV  D4, X5
    FMOV  V4.D[1], X14
    FMOV  D5, X22
    FMOV  V5.D[1], X14
    FMOV  D6, X23
    FMOV  V6.D[1], X3
    FMOV  D7, X10
    FMOV  V7.D[1], X12
    FMOV  D8, X16
    FMOV  V8.D[1], X21
    FMOV  D9, X26
    FMOV  V9.D[1], X17
    FMOV  D10, X4
    FMOV  V10.D[1], X3
    FMOV  D11, X16
    FMOV  V11.D[1], X12
    FMOV  D12, X15
    FMOV  V12.D[1], X5
    FMOV  D13, X11
    FMOV  V13.D[1], X27
    FMOV  D14, X16
    FMOV  V14.D[1], X10
    FMOV  D15, X29
    FMOV  V15.D[1], X14
    FMOV  D16, X11
    FMOV  V16.D[1], X3
    FMOV  D17, X17
    FMOV  V17.D[1], X22
    FMOV  D18, X13
    FMOV  V18.D[1], X4
    FMOV  D19, X14
    FMOV  V19.D[1], X6
    FMOV  D20, X18
    FMOV  V20.D[1], X16
    FMOV  D21, X15
    FMOV  V21.D[1], X29
    FMOV  D22, X26
    FMOV  V22.D[1], X22
    FMOV  D23, X14
    FMOV  V23.D[1], X15
    FMOV  D24, X16
    FMOV  V24.D[1], X26
    FMOV  D25, X7
    FMOV  V25.D[1], X10
    FMOV  D26, X17
    FMOV  V26.D[1], X13
    FMOV  D27, X17
    FMOV  V27.D[1], X3
    FMOV  D28, X15
    FMOV  V28.D[1], X18
    FMOV  D29, X3
    FMOV  V29.D[1], X21
    FMOV  D30, X10
    FMOV  V30.D[1], X17
    FMOV  D31, X28
    FMOV  V31.D[1], X14
    MOVZ  X11, #0xa, LSL #0
TSRTFloatAllOperation_label_5:
    FCVT  S5, D28
    SCVTF  D12, W23
    FRINTZ  D2, D5
    FRINTN  D7, D29
    FCVTMS  W26, S19
    FMAX  D16, D25, D12
    UCVTF  S16, X23, #49
    FABS  D11, D30
    FCVTMS  X10, S21
    FMIN  D7, D24, D7
    SCVTF  S9, W3
    FMIN  H20, H11, H7
    FMAX  S25, S20, S2
    UCVTF  H13, X21
    FCVTZS  X21, S27
    FMOV  D19, D16
    FCVTMU  W28, D9
    SCVTF  H23, X14, #54
    FCVTAS  W3, H31
    FMIN  D7, D25, D19
    UCVTF  S21, X20, #4
    FCVTNU  X20, H23
    FMOV  H9, X12
    FCVTZU  W14, H9
    FCVTAU  W12, D21
    FCVTMU  W3, H7
    SCVTF  S23, W10
    FRINTM  S16, S19
    FADD  D30, D24, D1
    FCVTPS  X5, S31
    FRINTZ  S2, S2
    SCVTF  S19, W21, #10
    FCVTNU  X7, H18
    FCVTPU  X28, D7
    FCCMP  S21, S13, #0xb, PL
    FCCMPE  D24, D15, #0xf, CS
    FDIV  H7, H31, H2
    FCVTZS  W10, S4, #20
    FNEG  D24, D12
    FCCMPE  H1, H11, #0x0, HI
    FCVTAS  X17, S13
    FCVTZU  W4, S19, #20
    FMUL  D12, D30, D14
    FCVTPS  W28, D15
    FMOV  H1, #1.31250000
    FCCMPE  D18, D24, #0xb, MI
    FCVTNU  W3, H13
    FRINTZ  H24, H28
    FCVTNS  X23, S5
    UCVTF  H31, X10
    FRINTA  D15, D18
    FMUL  D5, D15, D12
    FCVTPU  X12, H16
    FMOV  D2, D6
    FMAXNM  S4, S6, S12
    FCVTZS  W24, S22
    FMOV  H14, W3
    FRINTP  H28, H5
    FNMUL  D22, D24, D24
    FNMSUB  H24, H31, H22, H7
    FCCMP  S1, S14, #0x2, MI
    UCVTF  S14, W23
    FCVTZS  X6, D14, #25
    FCVTAS  X17, D2
    UCVTF  S14, W17
    FCVTNU  X23, D4
    FCVTPU  X28, D28
    FCMP  S14, #0.0
    FMOV  S5, W23
    FCMPE  H28, H17
    FRINTX  H1, H19
    FCVTZS  W17, S5, #4
    FCCMPE  S7, S2, #0x0, PL
    FMOV  D18, #2.50000000
    FCSEL  D4, D23, D13, CC
    FCVTPU  X22, S8
    FCMP  D9, D21
    UCVTF  S23, X17, #45
    SCVTF  D17, X22
    FNMSUB  S7, S21, S0, S22
    UCVTF  H8, X28
    FCVTZU  X14, H2, #5
    FCMPE  H23, H22
    FCVTZU  W25, D31, #12
    FNMUL  D21, D0, D10
    FCVT  D19, S31
    FMOV  H5, H21
    FMIN  S31, S4, S4
    SCVTF  D21, W25, #16
    FCVTMU  X7, H1
    FMUL  S10, S21, S5
    FNMSUB  S0, S8, S8, S10
    FCCMPE  D19, D31, #0x9, LS
    FCVTNU  W21, H0
    SCVTF  H22, X21, #64
    FCVTPS  W23, D7
    SCVTF  D2, X23
    FRINTM  H21, H2
    FCCMP  S22, S17, #0x1, CS
    FMAX  S23, S21, S21
    FDIV  H22, H18, H23
    FMADD  H9, H31, H12, H12
    FCVTZU  W28, D15
    FMADD  H5, H20, H10, H4
    FSQRT  S31, S8
    FRINTM  D21, D1
    FCVTPU  W23, H4
    FRINTX  H4, H13
    FMAX  S0, S22, S14
    FMUL  S8, S2, S25
    FCMPE  D25, #0.0
    FMADD  H7, H16, H1, H2
    FCVTZS  X16, S21
    FCVTZS  X4, D27
    FMOV  S25, S12
    FCVTZU  W4, H29
    FSQRT  S2, S4
    FCVTPU  W17, H22
    FCVTAS  W7, S21
    FRINTN  D16, D24
    SCVTF  H10, W7
    FCVTAU  X16, H10
    FCVTMU  W29, D9
    FCVTZS  X29, H5, #9
    FNMSUB  S24, S2, S31, S8
    FCVTAS  W23, D7
    FSQRT  S22, S25
    FCVTNU  X21, H31
    FRINTZ  S10, S16
    FMUL  H7, H10, H10
    FCVTAS  X22, H24
    FCVTPS  X22, S22
    FRINTN  S4, S7
    FCVTZU  X24, D4, #21
    FCVTMS  W15, H12
    FCVTZS  X4, H11, #1
    FCMP  D5, #0.0
    FMOV  H1, #-7.50000000
    FCMPE  D19, D16
    FCVTAS  W12, S23
    FRINTM  D9, D22
    FCVTAU  X29, S26
    FCVTAS  X12, S29
    FCVTZS  X23, D12
    FCVTPU  W26, S17
    FCVTAS  W4, H20
    FCVTNS  X28, D25
    FCVTMS  W24, H16
    FCVTAU  W5, H14
    FCCMPE  S31, S5, #0xd, EQ
    FCMPE  D19, D8
    FMSUB  S17, S18, S22, S8
    UCVTF  H12, W4, #3
    FCVTMS  X22, S5
    FCVTNS  W7, S3
    FCSEL  D31, D9, D13, VC
    FCVTPS  X14, S28
    FCVTZS  W16, D5
    FCVTAS  W14, H23
    FCMP  D13, #0.0
    FRINTP  D20, D18
    FCCMPE  D24, D26, #0x6, CC
    FCVTMS  X12, H3
    FCVTPU  X6, S6
    FCVTMS  X16, S6
    FMOV  D11, D8
    FNMUL  D22, D29, D25
    FCVTMS  X14, S3
    FCVTMU  X24, S25
    FNMADD  S5, S10, S16, S21
    FCVTZS  W24, S8, #27
    FMAXNM  D9, D19, D9
    FMOV  H14, W7
    FCVTNS  X22, D9
    FRINTM  D24, D14
    FCVTAU  X24, D17
    FCVTZU  X22, D24, #12
    FCVTZS  W15, S20, #21
    FNEG  D21, D22
    FCMPE  D11, #0.0
    SCVTF  H26, W16, #32
    FCVT  D16, H26
    FCVTPS  X14, H21
    FNMUL  H3, H5, H31
    FADD  H11, H16, H16
    FRINTN  H14, H3
    FSUB  H8, H11, H14
    FMAX  H16, H11, H31
    FCVTZS  W6, S25, #4
    FCVT  D10, H9
    FRINTN  H5, H26
    FCVTPU  X20, D1
    FMUL  H1, H12, H6
    FCVTNU  W12, D5
    FMOV  H22, #0.96875000
    FCVTMS  W26, S9
    FMSUB  D25, D9, D31, D18
    FCMP  H7, #0.0
    SCVTF  S9, W26, #5
    FCCMP  S21, S26, #0xb, HI
    FCVTPU  W22, S9
    FCVTZS  W12, D18
    FCVTNU  X5, H23
    UCVTF  D9, X5
    FADD  H6, H29, H14
    FCVTAS  X26, H25
    FMADD  D5, D13, D6, D26
    SCVTF  S25, X20
    FRINTM  S29, S19
    FMOV  X6, H29
    FMOV  S23, #-0.16406250
    FMAX  S7, S22, S5
    FCVTAU  X29, D25
    FCVTPU  X29, S9
    FRINTZ  S18, S7
    FRINTX  S26, S18
    FCVTAS  X28, H16
    FMIN  D16, D23, D23
    FCVTZS  X3, S26
    UCVTF  H21, W28, #20
    FMOV  D23, X26
    FCVTZS  X17, D16, #33
    FRINTZ  H25, H23
    UCVTF  H29, W17
    FRINTP  S26, S25
    FMAX  D14, D26, D11
    SCVTF  H26, W6, #32
    FCVTNU  X20, H14
    FMUL  D11, D21, D29
    FNEG  S25, S26
    FMOV  D14, D25
    FRINTZ  D25, D11
    UCVTF  S7, W20, #23
    FCVTMU  W15, D14
    FNEG  D21, D10
    FRINTI  H29, H7
    SCVTF  H26, X3
    FCVTZU  X21, D21, #36
    FCMP  H25, H26
    FCVT  S14, D14
    FNMUL  S18, S19, S10
    FCVTZS  W21, D12
    SCVTF  S19, X21, #41
    FMOV  S7, S10
    FCVTNU  W28, D17
    FMIN  S23, S9, S23
    SCVTF  S11, W15
    FRINTX  H21, H24
    FCVTAS  X23, D25
    FCVTZU  X25, S0
    FDIV  D24, D26, D29
    FCVTZU  W7, S11, #30
    FCVTZS  W25, H26
    FCVTZU  W29, S4, #27
    FCSEL  H12, H8, H8, GT
    FMSUB  D26, D18, D28, D29
    FRINTA  H10, H22
    FABS  S18, S12
    FDIV  H27, H18, H3
    FRINTX  H9, H26
    FCCMPE  H10, H27, #0x5, LE
    FABS  H10, H14
    FRINTN  H0, H21
    FCSEL  S29, S19, S9, VS
    FMAXNM  S27, S24, S0
    FCVTMU  W21, H23
    FRINTZ  H0, H10
    FCVTZS  X14, D29
    FMAX  D18, D7, D27
    FMINNM  D3, D7, D0
    FCVTPU  X17, H3
    FCVT  H29, D6
    FRINTX  S25, S8
    FCVTMS  X28, S16
    FMOV  X15, H26
    FCVT  H27, S7
    FCMP  S8, #0.0
    FMOV  D3, X15
    FSUB  S28, S21, S28
    FRINTP  H21, H30
    FCVTMS  W21, S14
    SCVTF  S0, X28, #24
    FCCMPE  D30, D20, #0x4, LE
    FCVTZU  X28, D25, #15
    UCVTF  S7, X28, #21
    FCVTMS  W25, S28
    UCVTF  H8, X14, #15
    FRINTA  H14, H20
    FRINTM  S25, S3
    FMAX  S6, S25, S7
    FMAX  H30, H29, H6
    FCVTZS  X17, D21
    SCVTF  S20, W21
    FCVTMS  W24, D30
    FCVTAS  W22, D20
    FCVTPU  W24, S0
    FCMP  D14, #0.0
    FCVTZU  X3, H8, #24
    FMADD  S20, S3, S24, S9
    FMIN  S16, S20, S20
    SUBS  X11, X11, #0x1
    B.NE  TSRTFloatAllOperation_label_5
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x2, LSL #0
    SUB  X18, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x1f, LSL #0
    MRS  X18, FPSR
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xb380, LSL #16
    FMOV  X18, D0
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D1
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D2
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D3
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D4
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D5
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D6
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D7
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D8
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D9
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D10
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D11
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D12
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D13
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D14
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D15
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D16
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D17
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D18
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D19
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D20
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D21
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x3bc0, LSL #0
    FMOV  X18, D22
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D23
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7ff8, LSL #48
    FMOV  X18, D24
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D25
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D26
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D27
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D28
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D29
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D30
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D31
    SUB  X27, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x95c2, LSL #0
    MOVK  X3, #0x2d74, LSL #16
    MOVK  X3, #0x194b, LSL #32
    MOVK  X3, #0xde08, LSL #48
    MOVZ  X4, #0xd568, LSL #0
    MOVK  X4, #0xc532, LSL #16
    MOVK  X4, #0x7835, LSL #32
    MOVK  X4, #0xd321, LSL #48
    MOVZ  X5, #0xb166, LSL #0
    MOVK  X5, #0xffe4, LSL #16
    MOVK  X5, #0x7cce, LSL #32
    MOVK  X5, #0x6be3, LSL #48
    MOVZ  X6, #0x2dd4, LSL #0
    MOVK  X6, #0x8212, LSL #16
    MOVK  X6, #0x4d06, LSL #32
    MOVK  X6, #0xca93, LSL #48
    MOVZ  X7, #0x8262, LSL #0
    MOVK  X7, #0x590, LSL #16
    MOVK  X7, #0x6eee, LSL #32
    MOVK  X7, #0x114b, LSL #48
    MOVZ  X10, #0x72ad, LSL #0
    MOVK  X10, #0x411f, LSL #16
    MOVK  X10, #0x8383, LSL #32
    MOVK  X10, #0xdbbd, LSL #48
    MOVZ  X11, #0xbd50, LSL #0
    MOVK  X11, #0x7455, LSL #16
    MOVK  X11, #0xcb12, LSL #32
    MOVK  X11, #0x4934, LSL #48
    MOVZ  X12, #0x184c, LSL #0
    MOVK  X12, #0x1a8c, LSL #16
    MOVK  X12, #0xc246, LSL #32
    MOVK  X12, #0x852b, LSL #48
    MOVZ  X13, #0xc452, LSL #0
    MOVK  X13, #0xebb1, LSL #16
    MOVK  X13, #0xa47e, LSL #32
    MOVK  X13, #0xc1c6, LSL #48
    MOVZ  X14, #0x3471, LSL #0
    MOVK  X14, #0x778d, LSL #16
    MOVK  X14, #0x26db, LSL #32
    MOVK  X14, #0x5cf0, LSL #48
    MOVZ  X15, #0x47fb, LSL #0
    MOVK  X15, #0xff66, LSL #16
    MOVK  X15, #0xf45f, LSL #32
    MOVK  X15, #0x2ca2, LSL #48
    MOVZ  X16, #0x62ed, LSL #0
    MOVK  X16, #0xe562, LSL #16
    MOVK  X16, #0xc6c8, LSL #32
    MOVK  X16, #0x9aae, LSL #48
    MOVZ  X17, #0xe223, LSL #0
    MOVK  X17, #0x25cb, LSL #16
    MOVK  X17, #0xf257, LSL #32
    MOVK  X17, #0xa583, LSL #48
    MOVZ  X18, #0xbc16, LSL #0
    MOVK  X18, #0x8a60, LSL #16
    MOVK  X18, #0xa8a6, LSL #32
    MOVK  X18, #0x3dbb, LSL #48
    MOVZ  X20, #0x9d1e, LSL #0
    MOVK  X20, #0x1b75, LSL #16
    MOVK  X20, #0x425a, LSL #32
    MOVK  X20, #0x9db2, LSL #48
    MOVZ  X21, #0xce43, LSL #0
    MOVK  X21, #0x5f0e, LSL #16
    MOVK  X21, #0x7af4, LSL #32
    MOVK  X21, #0xcbd4, LSL #48
    MOVZ  X22, #0xb605, LSL #0
    MOVK  X22, #0x7cd7, LSL #16
    MOVK  X22, #0xbe24, LSL #32
    MOVK  X22, #0x33f, LSL #48
    MOVZ  X23, #0xbe77, LSL #0
    MOVK  X23, #0x443, LSL #16
    MOVK  X23, #0xc34c, LSL #32
    MOVK  X23, #0xba0, LSL #48
    MOVZ  X24, #0x47d5, LSL #0
    MOVK  X24, #0x3830, LSL #16
    MOVK  X24, #0xe2b3, LSL #32
    MOVK  X24, #0xdc8c, LSL #48
    MOVZ  X25, #0x8794, LSL #0
    MOVK  X25, #0x71c, LSL #16
    MOVK  X25, #0xe467, LSL #32
    MOVK  X25, #0x8245, LSL #48
    MOVZ  X26, #0xda42, LSL #0
    MOVK  X26, #0x25ee, LSL #16
    MOVK  X26, #0x8267, LSL #32
    MOVK  X26, #0x45c2, LSL #48
    MOVZ  X27, #0x6a8c, LSL #0
    MOVK  X27, #0xc6e1, LSL #16
    MOVK  X27, #0xf408, LSL #32
    MOVK  X27, #0x131d, LSL #48
    MOVZ  X28, #0x48b2, LSL #0
    MOVK  X28, #0x40be, LSL #16
    MOVK  X28, #0xdade, LSL #32
    MOVK  X28, #0x3f2b, LSL #48
    MOVZ  X29, #0xdf1d, LSL #0
    MOVK  X29, #0xa5b0, LSL #16
    MOVK  X29, #0xf919, LSL #32
    MOVK  X29, #0xb34, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X28
    FMOV  V3.D[1], X12
    FMOV  D4, X21
    FMOV  V4.D[1], X21
    FMOV  D5, X20
    FMOV  V5.D[1], X26
    FMOV  D6, X7
    FMOV  V6.D[1], X7
    FMOV  D7, X24
    FMOV  V7.D[1], X10
    FMOV  D8, X5
    FMOV  V8.D[1], X5
    FMOV  D9, X24
    FMOV  V9.D[1], X25
    FMOV  D10, X10
    FMOV  V10.D[1], X6
    FMOV  D11, X16
    FMOV  V11.D[1], X18
    FMOV  D12, X16
    FMOV  V12.D[1], X22
    FMOV  D13, X11
    FMOV  V13.D[1], X20
    FMOV  D14, X12
    FMOV  V14.D[1], X3
    FMOV  D15, X7
    FMOV  V15.D[1], X10
    FMOV  D16, X13
    FMOV  V16.D[1], X28
    FMOV  D17, X11
    FMOV  V17.D[1], X10
    FMOV  D18, X11
    FMOV  V18.D[1], X28
    FMOV  D19, X22
    FMOV  V19.D[1], X6
    FMOV  D20, X20
    FMOV  V20.D[1], X24
    FMOV  D21, X29
    FMOV  V21.D[1], X21
    FMOV  D22, X3
    FMOV  V22.D[1], X27
    FMOV  D23, X14
    FMOV  V23.D[1], X28
    FMOV  D24, X22
    FMOV  V24.D[1], X18
    FMOV  D25, X3
    FMOV  V25.D[1], X29
    FMOV  D26, X15
    FMOV  V26.D[1], X29
    FMOV  D27, X7
    FMOV  V27.D[1], X24
    FMOV  D28, X22
    FMOV  V28.D[1], X22
    FMOV  D29, X17
    FMOV  V29.D[1], X3
    FMOV  D30, X25
    FMOV  V30.D[1], X5
    FMOV  D31, X12
    FMOV  V31.D[1], X16
    MOVZ  X26, #0xa, LSL #0
TSRTFloatAllOperation_label_6:
    FCMP  D25, D24
    FNMUL  D5, D23, D23
    FRINTP  S7, S30
    FRINTA  S3, S7
    FCVTAS  W12, D26
    FNMUL  S0, S29, S31
    FMOV  H20, H28
    FNEG  D8, D5
    FSQRT  D9, D3
    FRINTN  D19, D0
    FMIN  H17, H9, H9
    FCVTPU  X28, S20
    FCVT  D20, H17
    FMAX  S7, S20, S20
    FMAX  H20, H7, H19
    FCMP  H8, H8
    FCCMP  H20, H20, #0xf, MI
    FCVTNS  X16, H2
    FCVTNU  X18, H13
    FCVTZU  W7, H27
    FMIN  D23, D13, D11
    FDIV  S27, S23, S21
    FNMUL  S26, S27, S21
    FMAX  H9, H26, H31
    FCVTAS  X5, S21
    FRINTP  D17, D5
    FCVTAS  X28, H22
    FCVTNU  X7, H29
    FRINTZ  H5, H22
    FCVTNU  W25, H12
    FSQRT  H26, H31
    FMIN  S21, S20, S24
    FCVTZS  W13, D27, #29
    FCVTPS  W24, H25
    FNMADD  S23, S26, S21, S15
    UCVTF  S12, W6, #31
    FNMUL  S31, S7, S19
    SCVTF  H2, W23
    FCVTAU  X16, D19
    FRINTA  D19, D19
    UCVTF  S25, W7
    FMOV  W20, S19
    FDIV  D20, D23, D2
    FCVTPS  X23, S12
    FRINTA  H22, H17
    FNMUL  S19, S31, S22
    FCVTNU  X5, D20
    FRINTA  H15, H25
    FMUL  D27, D9, D19
    FNMSUB  S20, S27, S27, S5
    UCVTF  S2, W20, #11
    FCMP  H2, #0.0
    FCVTAS  X18, D29
    FCVTZU  W28, H15
    FCCMPE  S20, S3, #0x5, LS
    UCVTF  D15, X23
    FCVTNS  X11, S3
    FCVTPU  W10, D14
    FMIN  D14, D18, D8
    SCVTF  H22, X28, #19
    FCVTMU  W15, S5
    FCVTZS  X6, D26, #21
    FCVTAU  X17, D17
    FRINTN  H9, H7
    UCVTF  D31, X11, #44
    SCVTF  H5, W5
    SCVTF  S25, X18
    SCVTF  H20, W17
    FCVTAS  W5, H14
    UCVTF  D3, W15, #8
    FCVTZU  W15, D24
    FCVTZS  W18, H15, #12
    FRINTM  H14, H21
    FCVTMU  X16, S13
    FCVTAS  X11, D10
    FNMADD  S13, S19, S2, S7
    FCVTZU  X14, D20, #51
    FCVTAS  W13, S25
    FCVTPU  W6, H5
    FNMSUB  H26, H13, H3, H22
    FMOV  H21, H9
    FMIN  S17, S26, S21
    UCVTF  D21, X15, #28
    FCVTAU  W6, H17
    FCVTPS  W24, S14
    FCVTZU  X15, S21
    FABS  H21, H21
    FCMP  D12, D29
    FMAXNM  D17, D18, D29
    FRINTA  S5, S7
    FCMPE  S6, S6
    FCVTPS  W11, D17
    FCMPE  D28, #0.0
    FCVTAU  W24, D8
    FNMSUB  H25, H19, H13, H10
    FCMPE  D29, D15
    FSUB  H20, H20, H15
    FCMPE  S3, S23
    FRINTP  S3, S16
    FCMP  D13, D18
    FCVTMU  W5, S15
    FSUB  D12, D4, D28
    FSQRT  D14, D15
    SCVTF  D29, W5, #21
    FCVTAU  X23, D3
    UCVTF  S17, X24
    FSQRT  D7, D12
    FDIV  S26, S15, S30
    FNMSUB  D3, D21, D14, D21
    FCVTZS  W13, S29, #28
    FCVTZU  W10, S25
    UCVTF  S28, W11, #11
    FNMADD  S30, S26, S28, S28
    FCVTPS  W25, H7
    FCMP  H20, H20
    FMINNM  D4, D30, D3
    SCVTF  S6, X25
    FMOV  H20, #-0.28125000
    FCCMPE  S4, S17, #0x6, CC
    FADD  H14, H20, H6
    FDIV  D25, D14, D14
    FCMP  S25, S2
    FCVTZU  W20, S15
    FRINTZ  S17, S1
    FMOV  D15, #-13.50000000
    FCMP  D29, D26
    FMINNM  H12, H6, H19
    UCVTF  S19, X10, #26
    FCVTNS  X24, D11
    FCVTZS  W23, H25, #26
    UCVTF  S11, X20
    FMAXNM  H6, H27, H5
    FSUB  S26, S15, S28
    FMIN  H25, H13, H30
    FCCMP  S14, S22, #0x0, LT
    FCVTNS  W18, H12
    FMOV  H7, W18
    SCVTF  H5, W23
    FNMSUB  H29, H14, H8, H31
    FCCMPE  H17, H25, #0x3, EQ
    FCVTPS  W3, S27
    FCVTNS  W3, H7
    FSQRT  S25, S11
    FCVTZU  X3, H6, #57
    FCSEL  S17, S29, S29, NE
    FSUB  H14, H19, H19
    FDIV  H19, H5, H17
    FCVTMS  X15, S14
    FCVTZS  X6, D25, #8
    SCVTF  D27, X6, #41
    FCMP  H27, H27
    FCVTZU  W14, D26, #2
    FCVTMS  W6, D9
    FCVTZU  X16, D30, #51
    SCVTF  H5, W14
    FCCMP  S2, S9, #0x7, LT
    FRINTX  S9, S29
    FCVTZU  X10, D25, #52
    FMINNM  D2, D24, D14
    UCVTF  S27, W6
    FMADD  S14, S2, S7, S24
    FCVTZS  W13, D28, #28
    FCVTNU  W6, S28
    FSUB  S30, S21, S8
    FRINTM  S26, S28
    FCVTAS  W5, S15
    FCVT  D28, H30
    FCMP  S13, S15
    FCVTMS  W10, S8
    FMOV  S30, W6
    FMUL  D13, D12, D4
    FRINTM  H8, H5
    FMOV  D29, X16
    FRINTA  S21, S29
    FCVTAS  W14, S28
    FNMSUB  S25, S30, S21, S30
    FCMPE  H14, H19
    UCVTF  D19, W15, #13
    FCVTNS  W18, H26
    FNMADD  H7, H8, H13, H19
    FMOV  H4, W14
    FCCMP  D4, D4, #0x8, PL
    FCVTAU  X20, D25
    FMAXNM  D5, D7, D7
    FCVTPU  W18, D5
    FABS  D15, D27
    FNMADD  D8, D15, D15, D15
    FCVTNU  W17, D8
    UCVTF  H27, W13, #6
    FCVTAS  X7, S10
    FMOV  D8, D22
    FCMP  D20, D15
    UCVTF  H19, W18, #20
    FCVTMS  W24, H9
    UCVTF  H21, W24
    FCVTPS  W18, D1
    FMOV  H25, W7
    FRINTI  D5, D26
    FCMP  H7, H5
    FCVTMU  W18, D5
    FMOV  S26, #-3.00000000
    FMOV  D20, D4
    FCVTAS  W24, D21
    FCVTZS  X28, H29, #16
    FCVT  D28, S16
    FCMP  S6, #0.0
    FADD  H21, H28, H28
    FCVTAS  X27, S19
    SCVTF  H1, X27
    UCVTF  S10, W28, #20
    FRINTA  D16, D1
    FCVTZU  W25, S4
    FCVTAU  X7, S1
    SCVTF  D28, X25
    FCVTZS  W24, S25
    FCVTPU  X23, S28
    FCVTAS  W18, D20
    FDIV  H6, H8, H16
    FRINTP  D20, D21
    FMAXNM  D4, D10, D20
    FRINTI  S19, S26
    FCMP  D4, D4
    FCMP  H19, #0.0
    FDIV  D8, D6, D3
    FCVTNS  W28, D15
    UCVTF  S1, W18
    FCVTZS  X11, S8
    FCMP  S14, S6
    SCVTF  H3, W23, #28
    FCVTPU  W14, S31
    FMOV  H28, X24
    FCVTAU  W15, S5
    FCVTAU  X24, H25
    FNMUL  S14, S21, S9
    FMSUB  S21, S24, S30, S31
    FCVTZS  W3, D19
    FCMP  D2, D5
    FMADD  D5, D13, D8, D7
    FCVTMS  X23, D5
    FMOV  H7, H29
    FCVTNU  X24, D4
    FCVTAU  X24, H10
    FDIV  H29, H22, H27
    FRINTA  H19, H5
    SCVTF  D26, W11
    FMUL  D4, D14, D29
    FCVTPS  X16, H26
    FRINTM  H5, H19
    FCVTNU  W23, S21
    FNMSUB  H19, H7, H5, H3
    FMIN  D27, D1, D4
    FCVT  S7, D19
    FCVTNS  X14, D7
    SCVTF  D8, W15, #19
    FCVTMU  X20, D28
    FRINTA  S19, S8
    FCVTAU  W23, H19
    UCVTF  H10, X14, #15
    FRINTM  S22, S24
    FSUB  S28, S18, S16
    FSUB  S16, S19, S26
    FMAXNM  D5, D28, D18
    FCVTMS  X20, H5
    FRINTM  D5, D11
    FCCMPE  D21, D29, #0x1, VC
    FCVTZU  X24, D21, #64
    FNEG  D4, D7
    FNMSUB  H1, H8, H26, H21
    FCVTZU  W15, D28
    FCVTZU  W16, S30, #16
    FCVTZU  X6, H7
    FCVTMS  W12, D3
    FMINNM  S11, S4, S10
    FCVTNU  X15, D9
    FMINNM  S29, S7, S24
    FDIV  D26, D31, D18
    FNMADD  H7, H9, H28, H24
    FCVTZS  X12, D27, #47
    FCVTZU  X16, D26, #63
    FNMUL  D22, D16, D11
    FCVTPS  X25, H22
    FCVTZS  X3, H1
    FCVTZS  X17, S2, #13
    FMOV  H16, W12
    FMOV  D19, D16
    SCVTF  H24, W16, #11
    FRINTA  H30, H29
    UCVTF  H29, W3
    FCVTAU  X14, H7
    FCVTMS  W10, H29
    FCVTMU  W15, D30
    UCVTF  H7, X15
    FRINTM  H16, H19
    FCVTAS  W15, H7
    FRINTP  S31, S16
    FADD  H4, H10, H24
    FCVT  S29, H4
    SCVTF  S2, W6
    FCVTZS  W15, D2, #3
    FCVTAS  W10, H29
    SUBS  X26, X26, #0x1
    B.NE  TSRTFloatAllOperation_label_6
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0xd568, LSL #0
    MOVK  X21, #0xc532, LSL #16
    MOVK  X21, #0x7835, LSL #32
    MOVK  X21, #0xd321, LSL #48
    SUB  X29, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0xfffe, LSL #0
    MOVK  X21, #0xffff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    SUB  X29, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X29, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x1f, LSL #0
    MRS  X29, FPSR
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #16
    FMOV  X29, D0
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D1
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D2
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D3
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D4
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D5
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    FMOV  X29, D6
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D7
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D8
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D9
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D10
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D11
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D12
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D13
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #16
    FMOV  X29, D14
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D15
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D16
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x8000, LSL #0
    FMOV  X29, D17
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x48b2, LSL #0
    MOVK  X21, #0x40be, LSL #16
    MOVK  X21, #0xdade, LSL #32
    MOVK  X21, #0x3f2b, LSL #48
    FMOV  X29, V18.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0xbd50, LSL #0
    MOVK  X21, #0x7455, LSL #16
    MOVK  X21, #0xcb12, LSL #32
    MOVK  X21, #0x4934, LSL #48
    FMOV  X29, D18
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D19
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D20
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D21
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #48
    FMOV  X29, D22
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #16
    FMOV  X29, D23
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D24
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D25
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D26
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D27
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0xbd50, LSL #0
    MOVK  X21, #0x7455, LSL #16
    FMOV  X29, D28
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D29
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D30
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X29, D31
    SUB  X22, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X4
    FMOV  V2.D[1], X29
    FMOV  D3, X25
    FMOV  V3.D[1], X16
    FMOV  D4, X23
    FMOV  V4.D[1], X22
    FMOV  D5, X21
    FMOV  V5.D[1], X7
    FMOV  D6, X3
    FMOV  V6.D[1], X21
    FMOV  D7, X18
    FMOV  V7.D[1], X20
    FMOV  D8, X10
    FMOV  V8.D[1], X23
    FMOV  D9, X17
    FMOV  V9.D[1], X23
    FMOV  D10, X5
    FMOV  V10.D[1], X27
    FMOV  D11, X5
    FMOV  V11.D[1], X16
    FMOV  D12, X5
    FMOV  V12.D[1], X18
    FMOV  D13, X5
    FMOV  V13.D[1], X6
    FMOV  D14, X25
    FMOV  V14.D[1], X27
    FMOV  D15, X24
    FMOV  V15.D[1], X11
    FMOV  D16, X16
    FMOV  V16.D[1], X17
    FMOV  D17, X22
    FMOV  V17.D[1], X16
    FMOV  D18, X24
    FMOV  V18.D[1], X22
    FMOV  D19, X18
    FMOV  V19.D[1], X26
    FMOV  D20, X4
    FMOV  V20.D[1], X10
    FMOV  D21, X21
    FMOV  V21.D[1], X24
    FMOV  D22, X12
    FMOV  V22.D[1], X22
    FMOV  D23, X21
    FMOV  V23.D[1], X17
    FMOV  D24, X28
    FMOV  V24.D[1], X26
    FMOV  D25, X6
    FMOV  V25.D[1], X23
    FMOV  D26, X12
    FMOV  V26.D[1], X16
    FMOV  D27, X4
    FMOV  V27.D[1], X15
    FMOV  D28, X27
    FMOV  V28.D[1], X12
    FMOV  D29, X27
    FMOV  V29.D[1], X23
    FMOV  D30, X25
    FMOV  V30.D[1], X10
    FMOV  D31, X21
    FMOV  V31.D[1], X13
    MOVZ  X7, #0xa, LSL #0
TSRTFloatAllOperation_label_7:
    FMAX  S19, S28, S20
    FCVTMS  W22, H25
    FCVTZU  X6, S29
    FCVTNS  X10, D24
    FCVTAS  W24, H19
    FCVTZU  W13, D26
    FCVTMU  W15, H30
    FRINTM  S31, S31
    UCVTF  S2, W6
    FMOV  S0, W22
    FCVTNS  W6, H27
    FADD  D11, D2, D0
    FCMPE  S11, S23
    UCVTF  H2, W27
    FMOV  D11, X11
    FCVTZU  X21, H24, #34
    FMOV  W22, H15
    FMINNM  H14, H7, H3
    FCVT  H13, S8
    FCVTZU  W11, H12, #22
    FMOV  H28, W10
    FSQRT  S20, S3
    FRINTI  H23, H16
    FCVTAU  W27, S2
    FCMP  H17, H31
    FCVTMS  W10, H9
    FRINTP  D27, D29
    FCVTAU  W29, D19
    FDIV  D17, D11, D9
    FCVTPU  W21, H13
    FCMP  D8, #0.0
    FCVT  H2, D11
    FCCMPE  S18, S5, #0x1, VS
    FCVTAU  W26, H0
    FMSUB  D18, D10, D4, D19
    FCVTNU  W10, D1
    FCVT  S8, H15
    FCVTAS  X6, H28
    FCVTNU  X15, D20
    FCVTZU  W11, H17, #9
    FCVTZU  W28, D23, #30
    UCVTF  S9, W22, #19
    FMOV  X15, H8
    UCVTF  S29, X5, #34
    FCVTMS  X4, H9
    FNMSUB  S8, S2, S2, S14
    UCVTF  S5, W27
    FCMP  D18, #0.0
    UCVTF  H20, W28
    FRINTA  D18, D8
    FCVTZU  X23, H5, #55
    FRINTX  H9, H29
    FCVTNU  W16, S20
    FRINTA  H29, H18
    FABS  H28, H9
    SCVTF  H17, X11, #17
    FMAXNM  S15, S17, S17
    FMUL  H14, H28, H29
    FCVTPU  X23, S14
    FCVTZU  X4, H22
    FMOV  H14, H1
    FMIN  H5, H2, H31
    FCMPE  H2, #0.0
    FRINTA  H2, H8
    FSUB  D29, D12, D18
    FNMSUB  H1, H3, H27, H2
    FMOV  H22, W23
    FCVTZU  W20, S22
    FCVTPU  W21, D22
    FCVTAU  X16, D20
    FCMP  H17, #0.0
    FCMP  D11, D11
    FCVTAU  X26, S19
    FCVTAU  X10, H8
    FSQRT  S22, S27
    FCVTNS  W22, S3
    FNMSUB  S19, S31, S26, S9
    SCVTF  D28, X21
    FCMP  H19, H2
    FCVTZS  W5, D21
    FMOV  D11, X22
    FCVTNU  X24, S20
    FRINTM  D9, D17
    FSQRT  S12, S1
    FCVTAS  X25, S22
    FCVTMU  X17, S12
    FCVTAS  W26, H11
    FMAXNM  S26, S28, S28
    FMSUB  H18, H26, H26, H26
    UCVTF  D21, W20, #7
    SCVTF  H2, X16, #44
    FCVTMU  X23, H21
    FCMP  S29, S18
    FMOV  S17, #-0.15625000
    FCVTMS  X16, D17
    FCVTZS  W16, D7
    FMUL  H17, H9, H2
    FMIN  D26, D6, D26
    FCMP  D10, D6
    FMOV  S18, W17
    SCVTF  S12, W23, #12
    FRINTX  D7, D24
    FRINTI  S28, S5
    FNMSUB  D10, D23, D28, D16
    FCVT  H29, D6
    FRINTA  H5, H30
    UCVTF  S1, X16, #14
    FMAX  S6, S17, S17
    FCVTMS  W29, S12
    FNMSUB  S11, S26, S6, S1
    FCCMPE  H18, H29, #0x4, PL
    FCVTZS  W4, H7, #27
    SCVTF  S21, X4
    FCVTMU  W4, S11
    FCMP  D10, D5
    UCVTF  S30, W4, #32
    FNMADD  S17, S23, S6, S22
    UCVTF  S22, W29, #16
    FCVTZS  X25, D1, #16
    FCCMPE  S24, S27, #0x7, GE
    FCVTMS  X26, S13
    FRINTX  H9, H10
    SCVTF  H26, X13
    FCVTMS  W6, H13
    FMAX  D13, D2, D2
    FSQRT  S11, S20
    FCVTNU  X20, S31
    UCVTF  S1, X13
    FRINTM  D24, D26
    FMOV  D5, #0.56250000
    FMOV  X25, D17
    FCVTPS  W6, D22
    FSUB  D27, D29, D5
    FCVTZU  X15, S21, #32
    FCVT  S5, H30
    FCMP  H27, H24
    FCVTMS  W20, H1
    FMOV  H1, W20
    FCVTNS  W24, S1
    FCVTMS  W6, D11
    FCVTNS  X5, H5
    FCSEL  S26, S13, S9, GT
    FMOV  H2, W25
    FCVTMU  X12, H12
    FRINTI  H10, H27
    FCVTPS  X6, D17
    FRINTP  H22, H1
    FCVTAU  W24, D30
    SCVTF  H11, W13, #6
    UCVTF  D9, W29, #7
    FCVTZU  W17, D20, #28
    FCVTZU  W27, S27
    FCVTPU  W24, S29
    FRINTP  D27, D26
    FCVTZU  W22, H25, #32
    FMINNM  D12, D23, D4
    SCVTF  H13, W20
    FCCMPE  S27, S8, #0x1, GT
    SCVTF  D20, X12
    FCVTMS  W25, S0
    SCVTF  D1, X21
    FABS  H17, H10
    FABS  S5, S12
    FCVTAU  X26, S2
    FMOV  D25, #-7.75000000
    UCVTF  D24, X6, #14
    FNMUL  D4, D9, D20
    FCVTAU  X24, H1
    FCMP  D17, D13
    SCVTF  H9, X26, #35
    FCCMPE  H5, H5, #0x0, VS
    UCVTF  H8, X25, #42
    FRINTI  S30, S8
    FCVT  D8, H30
    FCVTPU  X11, D9
    FCVTNU  W11, S11
    FDIV  H10, H8, H24
    FRINTP  S27, S10
    FRINTP  S0, S27
    FCVTMS  X5, H6
    FCMPE  H0, #0.0
    FCVTMU  W11, D25
    FNMSUB  H20, H11, H24, H10
    UCVTF  D2, W5
    UCVTF  D27, X24, #1
    FMUL  H6, H22, H25
    FCVTZU  X13, H10, #4
    FCVTAS  W6, D0
    FCVTZS  W22, H20, #18
    FCMPE  S18, #0.0
    FMSUB  D11, D9, D6, D14
    FCVTZS  W25, H27
    FNMSUB  D20, D19, D11, D7
    FCVTZU  X26, D10
    FRINTP  H8, H23
    FCVTAU  X23, S21
    FNMSUB  S25, S6, S27, S21
    FRINTP  H24, H21
    UCVTF  D21, W6
    FRINTX  S18, S4
    FCVTZS  W4, S7
    FCVTAU  X4, S2
    FCMPE  H6, H7
    FCMP  H1, H25
    FCVTZS  W28, D16
    FCVTMS  W5, D5
    FADD  H23, H17, H2
    FCMP  S20, #0.0
    FCVTAU  X10, H3
    FCCMP  H8, H17, #0xf, VC
    FCMP  H3, H5
    FCVTPS  W16, D4
    FRINTA  S4, S29
    FCVTPS  X28, H10
    SCVTF  H5, X23
    FCVTNU  X13, D21
    FMAXNM  D16, D10, D1
    FCVTPU  W12, H24
    FCVTPS  X25, H26
    FCVTNS  X16, S31
    FRINTX  D9, D9
    UCVTF  H3, X13, #61
    FCVTAU  W29, H0
    FNMADD  S21, S3, S17, S5
    FCVTZU  W13, S10, #13
    FRINTP  H0, H31
    FCVTNU  X29, H22
    FMOV  H1, W25
    FCVTZU  W26, D0, #32
    FCVTZU  X24, H17, #20
    SCVTF  D26, W12, #14
    FRINTZ  D8, D24
    FNEG  H29, H13
    FCVTMS  X21, S21
    FNMUL  H21, H9, H29
    FCVTNU  X22, H16
    FCVTZU  W5, D21
    FNMSUB  D3, D26, D26, D1
    UCVTF  S17, X24, #10
    FCVTAU  W10, D17
    FCVTNS  X4, S8
    FCMPE  D3, D3
    FCVTMS  X15, D5
    FMOV  D10, D8
    FCVTAS  X4, S11
    FRINTX  H5, H15
    FCVTNS  X26, D29
    FCVTPU  X6, D24
    FRINTA  D24, D6
    FRINTZ  H3, H8
    SCVTF  H16, X6, #55
    FRINTN  H29, H31
    FRINTA  S26, S21
    FDIV  S9, S22, S9
    FCVT  S22, D14
    FCVTNU  W28, D5
    FCVTZS  X23, D24
    FNMSUB  H5, H16, H20, H29
    FCVTMS  W20, H9
    FRINTP  D11, D22
    FRINTP  S6, S11
    FCVTNU  X5, H26
    FCVTZS  W23, D9, #24
    UCVTF  D31, X23, #14
    FMOV  S16, S5
    FCVTAS  X20, S6
    FSUB  D26, D16, D16
    FCVTZS  W11, D3, #11
    FRINTZ  D5, D31
    FRINTX  S24, S5
    FRINTI  S5, S10
    FCVTMU  X15, S5
    SCVTF  H22, W28, #11
    FCCMP  S26, S22, #0xd, HI
    SCVTF  D5, W20, #13
    FRINTX  D16, D5
    FCMPE  D30, D16
    FCCMPE  D17, D3, #0x7, VS
    FRINTX  S26, S9
    FABS  H10, H9
    SCVTF  S22, X15, #7
    FCVTZS  X15, D24, #30
    FCMPE  S19, S20
    FCVTAU  W6, H11
    FMAXNM  S6, S14, S11
    FRINTZ  H20, H8
    FCVTZU  X15, S24, #6
    FNMADD  H19, H16, H5, H19
    FMOV  W12, H15
    FCVTAS  X21, D17
    FMOV  X27, D21
    FSQRT  S14, S27
    UCVTF  S3, W27, #22
    FRINTX  S16, S27
    FCVTMS  W29, D3
    FCVTAS  W21, H14
    SCVTF  H31, W6
    FNMSUB  S11, S6, S22, S6
    FRINTA  D6, D19
    FCVTZS  X17, H16
    SUBS  X7, X7, #0x1
    B.NE  TSRTFloatAllOperation_label_7
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X18, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x1f, LSL #0
    MRS  X18, FPSR
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D0
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D1
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D2
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D3
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D4
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D5
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D6
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D7
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D8
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    FMOV  X18, D9
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D10
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D11
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D12
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D13
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D14
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D15
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D16
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D17
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D18
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x8000, LSL #0
    FMOV  X18, D19
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D20
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D21
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D22
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D23
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D24
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D25
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    FMOV  X18, D26
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D27
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D28
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D29
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D30
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X18, D31
    SUB  X3, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatAllOperation_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X23
    FMOV  D3, X28
    FMOV  V3.D[1], X22
    FMOV  D4, X24
    FMOV  V4.D[1], X6
    FMOV  D5, X21
    FMOV  V5.D[1], X17
    FMOV  D6, X7
    FMOV  V6.D[1], X17
    FMOV  D7, X3
    FMOV  V7.D[1], X22
    FMOV  D8, X18
    FMOV  V8.D[1], X14
    FMOV  D9, X21
    FMOV  V9.D[1], X13
    FMOV  D10, X15
    FMOV  V10.D[1], X26
    FMOV  D11, X14
    FMOV  V11.D[1], X28
    FMOV  D12, X24
    FMOV  V12.D[1], X18
    FMOV  D13, X6
    FMOV  V13.D[1], X16
    FMOV  D14, X4
    FMOV  V14.D[1], X5
    FMOV  D15, X15
    FMOV  V15.D[1], X6
    FMOV  D16, X11
    FMOV  V16.D[1], X12
    FMOV  D17, X21
    FMOV  V17.D[1], X21
    FMOV  D18, X13
    FMOV  V18.D[1], X16
    FMOV  D19, X18
    FMOV  V19.D[1], X26
    FMOV  D20, X4
    FMOV  V20.D[1], X27
    FMOV  D21, X5
    FMOV  V21.D[1], X29
    FMOV  D22, X13
    FMOV  V22.D[1], X17
    FMOV  D23, X4
    FMOV  V23.D[1], X26
    FMOV  D24, X13
    FMOV  V24.D[1], X14
    FMOV  D25, X22
    FMOV  V25.D[1], X22
    FMOV  D26, X15
    FMOV  V26.D[1], X13
    FMOV  D27, X7
    FMOV  V27.D[1], X12
    FMOV  D28, X23
    FMOV  V28.D[1], X13
    FMOV  D29, X15
    FMOV  V29.D[1], X23
    FMOV  D30, X3
    FMOV  V30.D[1], X16
    FMOV  D31, X12
    FMOV  V31.D[1], X20
    MOVZ  X12, #0xa, LSL #0
TSRTFloatAllOperation_label_8:
    FMADD  D30, D27, D26, D28
    FRINTM  D28, D29
    FMSUB  S2, S25, S28, S31
    FCMP  D24, #0.0
    FMSUB  D7, D30, D21, D30
    FMAX  D13, D7, D7
    SCVTF  S27, X4
    UCVTF  D26, W28
    SCVTF  S11, W11, #15
    FCVTNS  W14, S26
    SCVTF  S29, W20
    FMAX  S3, S13, S11
    FCVTAS  W13, D2
    FNEG  H31, H3
    SCVTF  H1, X10
    FSQRT  D19, D27
    UCVTF  D13, W4, #16
    FCVTAU  X11, H31
    FMAXNM  D27, D1, D13
    FCVTNU  X10, S29
    FRINTZ  D20, D27
    FCVT  D27, S19
    FCVTNS  W4, H27
    FCCMPE  D10, D21, #0xb, AL
    FCVTZS  W20, S12
    FRINTX  H12, H6
    FMOV  S31, W5
    FCVTZS  W28, D6, #12
    SCVTF  S27, X18
    FMSUB  H6, H17, H29, H15
    FMSUB  D17, D26, D25, D20
    FCVTZS  X15, D0, #47
    FCVTZS  X14, H5
    FCCMP  S3, S4, #0xc, MI
    FADD  H10, H17, H8
    FCVTZS  W16, S4, #6
    FNEG  D0, D20
    FRINTI  D3, D10
    UCVTF  H1, X4
    FMADD  S15, S31, S20, S13
    FMOV  D4, D15
    SCVTF  D25, W15, #26
    FCVTPU  W27, H20
    FCVTAU  W7, D29
    FCVTMS  X6, D31
    UCVTF  D19, X16, #53
    FCVTPU  X5, S25
    FCVTZU  X15, H12, #14
    FCVTMU  X11, H1
    FCVTAS  X21, H27
    FMSUB  S27, S0, S4, S4
    FNMUL  S12, S27, S3
    FCVTNS  X20, D19
    FMADD  S26, S6, S12, S12
    FCVTPU  X24, D31
    FRINTP  S19, S15
    FCVTNU  W4, H13
    FNMUL  H29, H22, H18
    FCVTZU  W5, H6, #17
    FCVTZS  X22, H8
    FCVTZU  X16, D2, #53
    FMOV  X29, H7
    FABS  H10, H7
    FRINTM  D31, D21
    FRINTA  D17, D28
    FMOV  H8, X21
    FCVTZU  X11, H0, #49
    FCVT  D12, S18
    FCVTZU  W15, S25
    FSUB  H2, H26, H30
    SCVTF  S0, W16
    FCVTMU  X16, S31
    FCVTNU  W6, S2
    FCVTZU  X28, H0
    FCVTZS  W21, H19
    FMOV  H7, H8
    FCVTMU  W22, D10
    FCVTPU  W11, S7
    FCVTZS  X29, D12
    FMSUB  D7, D17, D17, D17
    FCVTNS  X6, D7
    FMSUB  S15, S16, S10, S6
    FRINTP  H16, H15
    FMOV  H8, X6
    FCCMPE  D29, D22, #0x8, EQ
    FSQRT  H31, H5
    FMSUB  H15, H28, H0, H3
    FCVTZS  W29, D26, #3
    FCVTZU  X22, S14, #27
    FCVTZU  W11, S13
    FCSEL  S0, S21, S17, CC
    FMOV  H29, X16
    FCVTZU  W5, D28, #4
    FMINNM  H28, H27, H0
    FCVTPS  X20, D16
    FMOV  D22, #-0.17187500
    FMOV  S10, S13
    FCVTZS  W11, D26
    UCVTF  H13, X22
    FMIN  S3, S6, S16
    FMUL  S0, S29, S15
    FNMADD  D16, D8, D13, D3
    FCVTNU  X21, H22
    FCVTPS  W17, S31
    FRINTX  D12, D16
    FABS  H27, H28
    FRINTN  H6, H0
    FCSEL  S29, S10, S12, MI
    FCVTZS  X7, S27
    FMAX  H31, H6, H29
    FCVTNU  W24, D29
    SCVTF  S12, W24, #15
    FCVTNU  W21, S27
    FMADD  S27, S6, S12, S4
    FCVTAS  X28, D13
    FCVTZU  X20, D18
    FMOV  D29, D2
    FCVTNU  W5, S11
    FCVTPU  W5, H3
    FCMP  H17, H29
    FCVTZU  X21, H22, #30
    FMADD  S18, S30, S23, S5
    FNEG  S29, S6
    FABS  D6, D12
    FCVTAU  X18, S27
    FCVTZS  X20, D5, #23
    FCVTZU  W10, H25
    FCVTAU  X28, S27
    FCVTMU  W28, D3
    UCVTF  S4, W21, #23
    FCVTZU  W16, S30
    FCVTNU  X22, S27
    FCVT  D23, S28
    FCVTPS  X20, H8
    FRINTM  H30, H16
    FCSEL  H3, H7, H27, HI
    FRINTP  H22, H18
    FCVTPS  X21, S2
    FCVTZS  W22, H27
    FSUB  H5, H4, H29
    FRINTZ  D13, D2
    FCVT  H16, S16
    FCVTZS  X10, D12, #28
    FCVTPS  X16, D20
    FADD  S20, S25, S24
    FCMPE  S20, S23
    FCVTZS  W17, H16
    FCVTZS  X15, S6, #50
    FRINTN  S6, S13
    SCVTF  H13, X17
    SCVTF  S18, X20, #44
    FSQRT  D16, D5
    FADD  S23, S6, S6
    FCVTZS  X5, H10, #7
    FABS  S12, S22
    FCVTNS  W6, H30
    UCVTF  S22, W15, #30
    FABS  S30, S12
    FCVTMS  W6, D13
    FCVT  H8, D18
    FCVTZS  X29, D3, #47
    FMOV  X3, D16
    FMOV  D20, D23
    FCVTZS  X13, D20, #54
    FMAXNM  D20, D22, D12
    UCVTF  S23, X22
    FCVTZU  X11, D23, #27
    FMADD  S22, S20, S20, S20
    FCVTZS  W29, D22
    FADD  S10, S8, S8
    FCVTZU  W29, H10, #9
    FMAXNM  D10, D27, D5
    FCVTPS  W16, S10
    FMOV  D10, X29
    FCVTMU  W16, S7
    FSUB  D12, D9, D4
    FABS  S20, S22
    FCVTNU  W21, S6
    SCVTF  S9, X11, #4
    FCVTNS  W20, H22
    FNEG  S16, S13
    FRINTA  D23, D16
    FCVTMS  X13, S27
    FCCMPE  S17, S0, #0xd, MI
    UCVTF  S6, W20, #11
    FCVT  D0, S14
    FRINTZ  H16, H8
    FCMP  S9, S0
    FCVTPU  X14, H30
    FMOV  S22, S16
    SCVTF  S13, W13, #9
    SCVTF  H21, X21, #48
    SCVTF  D27, W14, #6
    FNMUL  D7, D23, D22
    FCVTMS  W15, H6
    UCVTF  S9, X15, #46
    FCMPE  S20, #0.0
    FRINTP  H4, H9
    FMOV  D30, #20.00000000
    FCVTNS  W22, D7
    FSUB  D6, D27, D13
    FCMPE  S21, #0.0
    FNMSUB  D20, D6, D6, D6
    FMSUB  D23, D30, D30, D20
    FCVTMU  W22, H4
    FCVTMS  X21, H23
    FNMADD  D4, D24, D18, D25
    FCVTAU  X7, D8
    UCVTF  S9, X20, #24
    FCVTMU  X7, S17
    FMINNM  S16, S17, S0
    FCVTAS  X18, S12
    FRINTI  D18, D21
    SCVTF  S25, X22
    SCVTF  H17, X13
    UCVTF  S23, W6, #30
    FRINTP  D0, D4
    FCCMPE  S5, S19, #0x2, VC
    FRINTI  H7, H12
    FCMP  D22, #0.0
    FCCMPE  S28, S11, #0x0, CS
    SCVTF  D4, W11, #17
    FCVTMS  X14, D0
    FMOV  X10, D17
    FMUL  S22, S4, S18
    FRINTM  H24, H23
    FCVTPU  X24, D16
    FMAXNM  D5, D25, D22
    FNMUL  D25, D7, D7
    FMOV  D0, X12
    FCMP  H0, H24
    FCCMPE  S25, S5, #0x6, MI
    FMADD  H28, H4, H31, H16
    FCMPE  H16, #0.0
    FRINTP  S31, S28
    SCVTF  S7, W10
    FCVTAS  W18, D5
    FCVTZU  X7, D11, #64
    FNEG  S18, S26
    FCVTZS  X10, H9, #9
    FCVTPS  X5, D8
    FCMP  H6, H7
    FCVTNS  W18, S24
    FCVTMS  W28, S16
    FCVTZS  W4, S16
    FMSUB  D23, D4, D21, D18
    FRINTA  H16, H19
    FADD  H5, H16, H5
    FCVTAS  W21, S10
    FCCMPE  H26, H7, #0xa, MI
    FCVTPU  W20, D5
    FCVTZS  W28, S31
    FMAXNM  S9, S16, S25
    FNMADD  S17, S26, S19, S2
    FCVTPS  W4, H7
    FCVTMS  W18, H28
    FMIN  D6, D23, D7
    FNMADD  D23, D4, D4, D12
    UCVTF  S10, X28, #8
    FMOV  H18, H12
    FRINTP  H7, H7
    FCVTPS  X7, S12
    FRINTA  H5, H9
    FRINTM  H4, H16
    UCVTF  H12, W7
    FCVT  H11, D23
    FCVT  S21, D17
    FCVTMS  X28, H21
    SCVTF  S28, W28, #2
    FCVTZU  X28, H12
    FCCMPE  D4, D7, #0x3, AL
    FCVTNS  X17, S6
    SCVTF  D9, X18
    FMSUB  H17, H10, H28, H28
    FMOV  W21, S8
    SCVTF  S10, W4
    FCVTMS  W5, H10
    FNMUL  D21, D11, D9
    FCVTNS  X3, S17
    FCMP  S5, #0.0
    FSUB  H7, H21, H18
    FCVTPS  W13, S29
    FMUL  S18, S7, S31
    UCVTF  S8, X3
    FMOV  X4, D26
    FCVTPU  X28, S22
    SCVTF  D10, X13
    FCMP  H29, #0.0
    FCVT  H22, D25
    FCMPE  D13, #0.0
    FMUL  D11, D20, D17
    FCVTZU  X11, H26
    FCVT  D26, H4
    FMADD  D9, D22, D18, D7
    FCVTMU  X28, H2
    UCVTF  D2, W11
    FRINTA  H22, H30
    FCCMPE  S0, S11, #0x9, CC
    FCVTZU  X20, H25
    FABS  S20, S8
    SUBS  X12, X12, #0x1
    B.NE  TSRTFloatAllOperation_label_8
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    SUB  X25, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    SUB  X25, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x1f, LSL #0
    MRS  X25, FPSR
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x1, LSL #0
    FMOV  X25, D0
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D5
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X25, V14.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0xffff, LSL #0
    MOVK  X23, #0xffff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    FMOV  X25, D14
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #48
    FMOV  X25, D21
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #48
    FMOV  X25, D23
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D24
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #48
    FMOV  X25, D25
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x8000, LSL #16
    FMOV  X25, D29
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x4034, LSL #48
    FMOV  X25, D30
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X26, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x3bd5, LSL #0
    MOVK  X3, #0xf791, LSL #16
    MOVK  X3, #0x2c9a, LSL #32
    MOVK  X3, #0xd1a5, LSL #48
    MOVZ  X4, #0x8f46, LSL #0
    MOVK  X4, #0x7dff, LSL #16
    MOVK  X4, #0x3a32, LSL #32
    MOVK  X4, #0x4d9f, LSL #48
    MOVZ  X5, #0x6079, LSL #0
    MOVK  X5, #0x82df, LSL #16
    MOVK  X5, #0x294c, LSL #32
    MOVK  X5, #0x8204, LSL #48
    MOVZ  X6, #0x5047, LSL #0
    MOVK  X6, #0x8368, LSL #16
    MOVK  X6, #0x1dd9, LSL #32
    MOVK  X6, #0x3454, LSL #48
    MOVZ  X7, #0x95e1, LSL #0
    MOVK  X7, #0xbe28, LSL #16
    MOVK  X7, #0x42d9, LSL #32
    MOVK  X7, #0x4680, LSL #48
    MOVZ  X10, #0x182e, LSL #0
    MOVK  X10, #0x41c9, LSL #16
    MOVK  X10, #0x8595, LSL #32
    MOVK  X10, #0x84de, LSL #48
    MOVZ  X11, #0x9a6c, LSL #0
    MOVK  X11, #0x8151, LSL #16
    MOVK  X11, #0x22f9, LSL #32
    MOVK  X11, #0xd262, LSL #48
    MOVZ  X12, #0xa349, LSL #0
    MOVK  X12, #0x6879, LSL #16
    MOVK  X12, #0x9e68, LSL #32
    MOVK  X12, #0xb45b, LSL #48
    MOVZ  X13, #0x3cb9, LSL #0
    MOVK  X13, #0x103f, LSL #16
    MOVK  X13, #0x5b6a, LSL #32
    MOVK  X13, #0x9740, LSL #48
    MOVZ  X14, #0x39dd, LSL #0
    MOVK  X14, #0xf766, LSL #16
    MOVK  X14, #0x1eaa, LSL #32
    MOVK  X14, #0xc795, LSL #48
    MOVZ  X15, #0xbd2, LSL #0
    MOVK  X15, #0x7b89, LSL #16
    MOVK  X15, #0xd484, LSL #32
    MOVK  X15, #0xcd03, LSL #48
    MOVZ  X16, #0x6cea, LSL #0
    MOVK  X16, #0xd4dd, LSL #16
    MOVK  X16, #0xc76d, LSL #32
    MOVK  X16, #0x36ee, LSL #48
    MOVZ  X17, #0x9717, LSL #0
    MOVK  X17, #0x1f35, LSL #16
    MOVK  X17, #0x7d72, LSL #32
    MOVK  X17, #0xda31, LSL #48
    MOVZ  X18, #0x4fc1, LSL #0
    MOVK  X18, #0xf92c, LSL #16
    MOVK  X18, #0x97e4, LSL #32
    MOVK  X18, #0x19e, LSL #48
    MOVZ  X20, #0x882b, LSL #0
    MOVK  X20, #0xaa4, LSL #16
    MOVK  X20, #0x239a, LSL #32
    MOVK  X20, #0x2e65, LSL #48
    MOVZ  X21, #0xa002, LSL #0
    MOVK  X21, #0x79f0, LSL #16
    MOVK  X21, #0xa8ff, LSL #32
    MOVK  X21, #0xa010, LSL #48
    MOVZ  X22, #0xe1b4, LSL #0
    MOVK  X22, #0x72fc, LSL #16
    MOVK  X22, #0x8db0, LSL #32
    MOVK  X22, #0x8ef1, LSL #48
    MOVZ  X23, #0xf2a7, LSL #0
    MOVK  X23, #0xc0f0, LSL #16
    MOVK  X23, #0x80f1, LSL #32
    MOVK  X23, #0xb781, LSL #48
    MOVZ  X24, #0x5e2e, LSL #0
    MOVK  X24, #0x1f5d, LSL #16
    MOVK  X24, #0xf839, LSL #32
    MOVK  X24, #0x5831, LSL #48
    MOVZ  X25, #0xf417, LSL #0
    MOVK  X25, #0xe678, LSL #16
    MOVK  X25, #0x69e0, LSL #32
    MOVK  X25, #0xd197, LSL #48
    MOVZ  X26, #0xab1d, LSL #0
    MOVK  X26, #0x8263, LSL #16
    MOVK  X26, #0xede4, LSL #32
    MOVK  X26, #0x69fe, LSL #48
    MOVZ  X27, #0xb51e, LSL #0
    MOVK  X27, #0x347b, LSL #16
    MOVK  X27, #0xbae5, LSL #32
    MOVK  X27, #0x8c4d, LSL #48
    MOVZ  X28, #0xfd39, LSL #0
    MOVK  X28, #0xf1ea, LSL #16
    MOVK  X28, #0xb82d, LSL #32
    MOVK  X28, #0x5176, LSL #48
    MOVZ  X29, #0xbb3a, LSL #0
    MOVK  X29, #0x7e0e, LSL #16
    MOVK  X29, #0xb2f, LSL #32
    MOVK  X29, #0x89c5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X29
    FMOV  D3, X14
    FMOV  V3.D[1], X18
    FMOV  D4, X22
    FMOV  V4.D[1], X5
    FMOV  D5, X15
    FMOV  V5.D[1], X10
    FMOV  D6, X16
    FMOV  V6.D[1], X29
    FMOV  D7, X6
    FMOV  V7.D[1], X17
    FMOV  D8, X15
    FMOV  V8.D[1], X27
    FMOV  D9, X12
    FMOV  V9.D[1], X16
    FMOV  D10, X24
    FMOV  V10.D[1], X11
    FMOV  D11, X7
    FMOV  V11.D[1], X28
    FMOV  D12, X11
    FMOV  V12.D[1], X11
    FMOV  D13, X12
    FMOV  V13.D[1], X15
    FMOV  D14, X27
    FMOV  V14.D[1], X3
    FMOV  D15, X20
    FMOV  V15.D[1], X13
    FMOV  D16, X21
    FMOV  V16.D[1], X27
    FMOV  D17, X28
    FMOV  V17.D[1], X26
    FMOV  D18, X22
    FMOV  V18.D[1], X6
    FMOV  D19, X22
    FMOV  V19.D[1], X14
    FMOV  D20, X22
    FMOV  V20.D[1], X16
    FMOV  D21, X21
    FMOV  V21.D[1], X18
    FMOV  D22, X25
    FMOV  V22.D[1], X12
    FMOV  D23, X24
    FMOV  V23.D[1], X24
    FMOV  D24, X10
    FMOV  V24.D[1], X15
    FMOV  D25, X6
    FMOV  V25.D[1], X16
    FMOV  D26, X12
    FMOV  V26.D[1], X17
    FMOV  D27, X29
    FMOV  V27.D[1], X18
    FMOV  D28, X11
    FMOV  V28.D[1], X20
    FMOV  D29, X17
    FMOV  V29.D[1], X26
    FMOV  D30, X10
    FMOV  V30.D[1], X16
    FMOV  D31, X5
    FMOV  V31.D[1], X29
    MOVZ  X24, #0xa, LSL #0
TSRTFloatAllOperation_label_9:
    FMOV  D10, #-0.39062500
    FCVTMU  W17, D27
    FRINTM  S14, S29
    FRINTP  H29, H26
    FMADD  D6, D14, D10, D24
    FCVTZS  W11, H31
    UCVTF  D18, W11, #28
    FRINTX  S18, S18
    FCVTMS  W20, D18
    FCVTZS  W26, D30
    FCMPE  D25, #0.0
    FRINTZ  S8, S23
    FMAX  H29, H28, H29
    FCVTZS  W10, S6
    FCVTAU  X5, S29
    FMSUB  H6, H25, H17, H6
    FCVTMS  W12, S15
    SCVTF  H15, W20, #30
    FNMADD  S18, S23, S12, S21
    FCVTMU  W11, H10
    FCVTNS  W20, D9
    FMOV  H27, #0.12500000
    UCVTF  D12, W12
    SCVTF  H29, W7, #6
    FCMP  S22, #0.0
    FRINTX  D23, D17
    FCVTZS  W7, D28
    UCVTF  S25, W6
    FCVTPS  X12, S23
    FCCMP  S29, S29, #0xa, LT
    FMAXNM  H9, H18, H27
    FRINTX  D10, D15
    FRINTM  H22, H9
    SCVTF  D23, W5, #5
    FCVT  D21, H10
    FCCMPE  S8, S22, #0x1, LS
    FCVTZS  W17, H12
    FRINTA  D17, D25
    FRINTZ  S10, S17
    FCVTMS  X5, H23
    FRINTZ  H18, H10
    FRINTP  S29, S21
    FCMPE  S18, S6
    SCVTF  D17, X17, #12
    FNEG  H27, H26
    FMOV  S10, S7
    FMOV  H21, X5
    FCVTZS  W23, S30
    FNMUL  D22, D23, D23
    FCMP  H11, #0.0
    FRINTN  S30, S25
    FCVTNS  W22, D2
    FCVTNU  X7, S2
    FNMUL  S23, S30, S27
    FCVTAU  W25, H3
    FMOV  S11, #0.19531250
    FCVT  S2, D14
    FCVTMS  X22, S29
    FCMPE  S3, #0.0
    FCVTZS  W4, H23, #29
    FCVTMU  X5, S1
    FCVTZU  X17, D5
    FMOV  S3, S20
    FCVTNU  W21, H14
    FCVTNS  W6, S7
    FNMADD  D1, D18, D20, D19
    FCVTZU  W15, H22, #11
    FMOV  H14, #0.29687500
    FMOV  H27, H21
    FCVTZU  W14, D21, #5
    SCVTF  S20, W22, #29
    FCSEL  H23, H11, H20, LE
    FADD  H21, H14, H27
    FNMADD  S29, S3, S3, S3
    FCVTZS  W3, S23
    FCVTAS  X25, S10
    FMAX  S18, S29, S21
    FMAX  D10, D1, D18
    FCCMP  S10, S2, #0x8, LS
    UCVTF  S19, W15, #11
    FMSUB  D14, D29, D25, D12
    FCVTNS  X14, H12
    SCVTF  H12, W3, #7
    SCVTF  S7, W6, #10
    FCVTMU  W3, S1
    UCVTF  D29, W17
    FDIV  D18, D12, D13
    FCVTAU  X20, D5
    FRINTA  H11, H17
    FCVTPU  W27, S16
    FCCMPE  S2, S24, #0x4, MI
    FMOV  H25, #-0.90625000
    FNEG  H13, H2
    FMAXNM  S2, S5, S7
    SCVTF  H21, W25
    FNMSUB  D10, D11, D29, D21
    FCMPE  S9, S10
    FMAX  D17, D14, D2
    FCVTMU  X14, D13
    FCVTPS  W4, S17
    FMIN  H10, H18, H18
    FNMADD  H24, H10, H25, H25
    FCVTMU  X15, H24
    FCVTZS  X14, D18, #43
    FMOV  H16, X3
    FCVTNU  X17, S28
    UCVTF  S1, W26
    FCVTZS  X25, S12
    FNEG  D12, D8
    FMINNM  D25, D26, D2
    FMUL  D17, D13, D23
    FCMPE  S25, #0.0
    FCVTPS  W15, S11
    FCVT  D9, H16
    FRINTZ  H14, H16
    FMIN  H24, H13, H24
    FRINTX  H25, H4
    FMSUB  D21, D17, D4, D7
    FCVTAS  X3, H11
    FMOV  D5, D9
    FMIN  S29, S20, S30
    SCVTF  D27, W3
    FCVTPU  X11, S24
    FCVTMU  W11, H1
    FMOV  S23, #-0.62500000
    FSQRT  H13, H27
    FCVTMU  W27, H13
    FCVTMU  W12, S23
    FMUL  S10, S31, S29
    FCVTMU  X3, D21
    FMOV  S31, #1.50000000
    FNMADD  S29, S10, S12, S12
    FRINTX  D17, D14
    FCVTAU  X6, S15
    FCMP  D29, D31
    FCVTNU  X7, H5
    FCVTPU  W4, D25
    FSQRT  H29, H19
    FCVTMU  W22, D5
    FMSUB  S10, S31, S9, S21
    FDIV  S16, S15, S20
    FNMUL  S27, S27, S10
    SCVTF  H19, X22
    FCCMP  D12, D5, #0xa, VC
    FCVTZU  W27, H8
    SCVTF  S20, W4
    FMOV  H13, H30
    FCVTZS  X7, S22, #61
    FCVTZU  X3, H9, #20
    FRINTI  H25, H4
    FCVTPU  X23, S8
    FCVTZU  X26, D25, #43
    FMSUB  S31, S8, S26, S17
    FCVTPU  X26, S6
    FMUL  D9, D10, D7
    FRINTA  S22, S29
    FCVTZU  X7, S18, #34
    SCVTF  S21, X7, #44
    FADD  H8, H31, H22
    FCSEL  H30, H27, H20, LS
    FCVTNU  X27, D21
    FMINNM  H31, H9, H9
    FCVTPU  X20, S31
    FCVTPS  X10, D13
    FMADD  H22, H19, H8, H30
    FMIN  D6, D22, D22
    SCVTF  D31, W26
    FCVTZU  X22, S6
    FMOV  D27, X10
    FSUB  D4, D27, D31
    FCVTAU  X14, H4
    FMSUB  D9, D29, D16, D13
    FCVTAS  W18, S3
    FMAXNM  S18, S31, S25
    UCVTF  H3, W27
    FCVTAU  X20, S8
    FCVTNS  W26, H5
    UCVTF  H7, X26
    FSQRT  S31, S8
    FCVTMS  W4, H22
    FRINTN  H5, H12
    FCVTNU  X17, D19
    FCSEL  D6, D15, D0, NE
    FCVTAS  X5, D0
    FRINTN  D4, D6
    FMINNM  H25, H28, H16
    FMOV  H12, X22
    FCMP  S4, S3
    FCVTMS  W11, D18
    FCVTAS  W18, D9
    FCVTPU  W21, S12
    FCCMPE  S25, S31, #0xb, MI
    FMAX  D18, D7, D9
    FMOV  S0, W14
    FCMPE  D5, #0.0
    FCVTNU  X4, D18
    FCMPE  D14, #0.0
    FMIN  H19, H17, H8
    FRINTX  H17, H21
    SCVTF  D27, W18
    FABS  H12, H28
    FNEG  D4, D6
    FMOV  H6, W17
    FCVTMS  X17, D8
    FCVTNS  W22, H24
    FSQRT  S22, S31
    SCVTF  D14, X4, #7
    FNMADD  D9, D0, D14, D14
    FCVTNS  X3, D17
    FCMPE  S19, #0.0
    FCVTZU  X4, D22
    FSQRT  H21, H27
    FCMPE  D21, D21
    FRINTA  S27, S12
    FCVTMS  X27, S6
    FCVTZU  X4, H9, #33
    FCVTAS  W3, D6
    FCVTZS  X27, D4, #55
    FCMPE  D15, #0.0
    FCVT  H6, D17
    FCVTMS  X11, H31
    UCVTF  D31, X4, #19
    FCVTAU  X6, S21
    FADD  D9, D8, D4
    FNMUL  H12, H23, H23
    FCVTAS  X11, D10
    FSUB  H4, H21, H24
    FCSEL  D19, D12, D5, PL
    UCVTF  D17, X6, #51
    FCVTZS  X13, D24, #34
    FCVTZS  W20, D28
    FCVTZS  X3, D29
    FCSEL  H23, H27, H22, LE
    FCCMP  S18, S5, #0x3, VS
    FCVTZS  X23, H30
    FCVTAS  W26, S2
    FCVTMU  W18, D13
    FADD  D27, D19, D5
    FNMADD  S2, S7, S10, S26
    FNMUL  D15, D9, D19
    FCVTAS  W22, H21
    FNEG  S9, S14
    FMIN  S19, S17, S23
    FCMP  S4, #0.0
    FCVTPU  X7, H19
    FNEG  D8, D9
    FCVTPU  X7, S2
    FCMP  D8, D8
    UCVTF  D2, X7
    FMINNM  H18, H31, H2
    FNMUL  D19, D17, D18
    SCVTF  S9, W26, #5
    SCVTF  H4, X20
    FCVTZS  X11, D10
    FRINTA  D26, D27
    FCMPE  H15, #0.0
    FCVTPU  W25, S4
    FRINTM  D2, D26
    FRINTX  S10, S19
    FCVTPS  W15, S2
    FADD  D23, D9, D9
    FMAXNM  D15, D11, D23
    FCVT  D23, S10
    FMAXNM  S8, S15, S23
    FRINTP  S18, S9
    FCVTAS  X15, S1
    FCMP  D26, D27
    FCVTNS  X18, S13
    FCVTMS  X7, H20
    FCVTMS  X5, S0
    FRINTX  S14, S21
    FCVTPU  X12, S4
    FCVTMU  X12, H12
    FSUB  D19, D6, D27
    FCVTAU  X5, D28
    SCVTF  H11, X25
    FSQRT  H2, H29
    FABS  D29, D28
    FMADD  S28, S22, S29, S28
    FCVTMU  X10, H4
    FMOV  H22, W10
    FCVTMU  X3, H14
    UCVTF  D1, W15
    FCMP  S1, #0.0
    FMOV  D6, X5
    FDIV  H9, H7, H7
    FMAXNM  S14, S19, S11
    FCVTAS  W21, H14
    FDIV  D29, D18, D9
    UCVTF  H27, W3, #15
    SCVTF  H18, X12
    FCVTNS  X14, H6
    FCVTMS  X11, H18
    FCVTZS  W14, S8
    FCVTPS  X14, H29
    FRINTA  S29, S2
    FMAX  D8, D28, D22
    FCVTAS  X21, S27
    FNMADD  S1, S29, S29, S29
    FMINNM  H0, H1, H1
    SUBS  X24, X24, #0x1
    B.NE  TSRTFloatAllOperation_label_9
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X29, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x1f, LSL #0
    MRS  X29, FPSR
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D0
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    FMOV  X29, D1
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D2
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D3
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D4
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D5
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D6
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D7
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x9a6c, LSL #0
    MOVK  X16, #0x8151, LSL #16
    FMOV  X29, D8
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X29, D9
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D10
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D11
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X29, D12
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D13
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X29, D14
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D15
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X29, D16
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D17
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D18
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    MOVK  X16, #0x8000, LSL #48
    FMOV  X29, D19
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D20
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D21
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D22
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D23
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X29, D24
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x9a6c, LSL #0
    FMOV  X29, D25
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D26
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D27
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x9a6c, LSL #0
    MOVK  X16, #0x8151, LSL #16
    FMOV  X29, D28
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D29
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D30
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, D31
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    FMOV  D0, X24
    FMOV  V0.D[1], X21
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X14
    FMOV  D3, X6
    FMOV  V3.D[1], X25
    FMOV  D4, X22
    FMOV  V4.D[1], X23
    FMOV  D5, X26
    FMOV  V5.D[1], X28
    FMOV  D6, X20
    FMOV  V6.D[1], X18
    FMOV  D7, X5
    FMOV  V7.D[1], X17
    FMOV  D8, X7
    FMOV  V8.D[1], X16
    FMOV  D9, X21
    FMOV  V9.D[1], X23
    FMOV  D10, X23
    FMOV  V10.D[1], X28
    FMOV  D11, X5
    FMOV  V11.D[1], X22
    FMOV  D12, X26
    FMOV  V12.D[1], X11
    FMOV  D13, X14
    FMOV  V13.D[1], X20
    FMOV  D14, X23
    FMOV  V14.D[1], X3
    FMOV  D15, X27
    FMOV  V15.D[1], X14
    FMOV  D16, X14
    FMOV  V16.D[1], X5
    FMOV  D17, X28
    FMOV  V17.D[1], X24
    FMOV  D18, X4
    FMOV  V18.D[1], X24
    FMOV  D19, X13
    FMOV  V19.D[1], X25
    FMOV  D20, X5
    FMOV  V20.D[1], X25
    FMOV  D21, X4
    FMOV  V21.D[1], X26
    FMOV  D22, X15
    FMOV  V22.D[1], X3
    FMOV  D23, X21
    FMOV  V23.D[1], X27
    FMOV  D24, X25
    FMOV  V24.D[1], X16
    FMOV  D25, X20
    FMOV  V25.D[1], X18
    FMOV  D26, X22
    FMOV  V26.D[1], X10
    FMOV  D27, X3
    FMOV  V27.D[1], X23
    FMOV  D28, X6
    FMOV  V28.D[1], X15
    FMOV  D29, X15
    FMOV  V29.D[1], X13
    FMOV  D30, X7
    FMOV  V30.D[1], X15
    FMOV  D31, X18
    FMOV  V31.D[1], X17
    MOVZ  X20, #0xa, LSL #0
TSRTFloatAllOperation_label_10:
    FSUB  D30, D26, D24
    FCCMPE  D29, D18, #0x4, VS
    UCVTF  H16, X24
    FCVT  D2, H30
    FCVTAU  W22, S31
    FCVTMU  X3, D16
    FCVTAU  X24, H23
    FRINTI  S11, S28
    FABS  D11, D11
    FNEG  H1, H2
    FNMSUB  H22, H27, H11, H27
    FCVTNS  X17, H22
    FCMP  H1, #0.0
    FCVTMS  X18, H22
    FCMP  H6, #0.0
    FCVTZS  W5, S28
    FCVT  H18, S8
    FCVTZS  W28, D29
    FDIV  D6, D16, D18
    FMOV  S1, W4
    FCVTPU  W4, S26
    UCVTF  H8, X17
    FMOV  D22, D0
    FCVTNS  W17, D18
    FRINTI  D30, D18
    FCSEL  D27, D1, D12, HI
    FABS  D26, D21
    UCVTF  H21, X5, #51
    FCVTZS  X5, D29, #36
    FCVTZS  W22, S28
    FCVTZU  X14, D19
    SCVTF  S1, X28, #11
    FRINTA  H19, H1
    FMAX  H18, H10, H14
    UCVTF  D16, W5, #12
    FCVTMU  X23, H21
    FRINTN  S1, S6
    FABS  D6, D27
    FCVTZS  X13, D1
    FCVTPS  W28, S30
    FCVTZU  X23, S18, #40
    FMIN  S8, S16, S22
    FCMP  S19, #0.0
    FCVTZU  W13, H8, #18
    FCVTAU  X4, S6
    FMUL  S29, S18, S18
    FCVTAS  X11, D15
    FMOV  X11, H24
    FCCMP  D9, D2, #0x9, AL
    FCVTPS  W17, H11
    FCVTNS  W4, D2
    FCVTMS  W21, S29
    FMOV  S6, S8
    FCVTNU  X23, H19
    FCSEL  S9, S1, S20, NE
    UCVTF  D18, W28, #8
    FCVTPS  X11, D17
    FCVTAS  W23, D18
    FCVTZU  W18, D30, #23
    FMINNM  D30, D25, D28
    FABS  S28, S7
    FCVTZU  X14, S4
    SCVTF  D18, W14
    FCMP  H13, #0.0
    FCVTAU  W16, S19
    FMAX  S25, S14, S24
    FMOV  H27, H0
    FCVTZU  W4, H3
    FMAX  S13, S14, S26
    SCVTF  S22, W4, #25
    FMOV  H7, #-0.14062500
    FCSEL  H17, H27, H20, LE
    FCVTMU  X14, S7
    FRINTM  H0, H9
    UCVTF  S9, W11
    FCVTPS  W11, D18
    FMINNM  D20, D13, D6
    FCVTZS  W27, H25, #31
    SCVTF  H25, W14, #27
    FMIN  D1, D1, D22
    FMOV  X26, H20
    FCVTZS  X13, S1, #56
    FCMP  H17, #0.0
    FMADD  S19, S9, S0, S0
    FMIN  S22, S25, S30
    FCVTPU  X3, D22
    FCCMP  H19, H19, #0xb, LT
    FCVTZU  X13, H23
    FMUL  S23, S26, S19
    FRINTX  D7, D7
    FMOV  X22, H28
    FCVTAU  W25, D18
    FCVTPS  W22, D15
    FCMP  S15, #0.0
    UCVTF  D26, X3, #56
    FCVTZS  X10, H11
    FCMPE  S6, S8
    FCVTZS  W17, H3, #12
    FCVTZU  X6, D19, #37
    FSUB  H22, H22, H9
    FRINTI  S28, S21
    UCVTF  D6, W11
    FCVTZS  X25, S28, #38
    FDIV  D25, D1, D0
    SCVTF  S0, X10, #21
    FCVTAU  W17, S1
    UCVTF  H9, W17
    FCVTMU  X29, S16
    FCVTZU  W14, H11
    FCVTZU  X3, H25
    FCVTPS  X29, S20
    UCVTF  H28, W25, #18
    FABS  S3, S25
    FNEG  D30, D9
    FCVTMS  X17, H28
    SCVTF  S28, W3, #22
    FCVTZS  W28, H30
    FRINTN  S8, S3
    UCVTF  S30, X22, #59
    FMOV  W11, S0
    FCCMP  S28, S6, #0xf, PL
    FCVTNU  W5, S30
    FRINTA  D9, D8
    FRINTN  H30, H9
    FCVTZS  W25, D30
    FCVTNS  W25, D4
    FADD  S16, S2, S11
    SCVTF  H8, X17
    FRINTZ  D4, D16
    FMOV  H1, #-0.43750000
    FCVTAS  W17, D8
    UCVTF  D25, W11
    FCVTPU  W26, S25
    FCVTZU  X28, H1, #25
    FCVTMU  W10, D13
    FCCMPE  D30, D17, #0x2, CC
    FADD  D11, D15, D17
    FCMP  S26, S25
    FNMSUB  D28, D29, D4, D28
    FCCMP  H20, H0, #0x0, VS
    FSQRT  D16, D11
    FABS  H25, H17
    FCVTNS  X21, D19
    FCVTNU  W13, S25
    UCVTF  S2, W17, #29
    FCVTZU  X27, H24, #57
    SCVTF  S6, X13
    FRINTI  H29, H27
    FCVTZU  W24, S3, #20
    FNMSUB  S8, S31, S16, S29
    FCVTAS  X17, D26
    FRINTX  D9, D8
    FCVTMS  X6, S16
    FCVTAU  W13, S29
    FCVTPS  X22, H8
    FCVTZU  X5, H8, #57
    FCMP  H6, #0.0
    FRINTZ  S8, S9
    FCMP  D28, #0.0
    FCVTZS  W14, H5
    FMAXNM  S31, S3, S20
    FCVTNS  X26, S7
    UCVTF  S5, W14
    FRINTA  H16, H24
    FCVTZS  X26, D6, #55
    FCVTNU  X5, D16
    FMUL  S28, S11, S12
    FCVTMS  W26, H11
    FCCMPE  H19, H23, #0x4, GE
    FCMPE  D21, #0.0
    FNEG  H27, H9
    FCVTZS  X23, H8
    FCVT  D16, H2
    FCVTNS  X21, H13
    FMAX  D13, D16, D30
    FCVTMS  X17, S14
    FDIV  D11, D30, D28
    FCCMP  H26, H23, #0x6, AL
    FRINTX  D29, D10
    FCVTNS  W13, D8
    FMOV  W5, S18
    FCVTMS  X4, H6
    FCVTPU  W25, H31
    FCVTAS  X28, H25
    FNMADD  H14, H4, H9, H25
    UCVTF  H18, X23
    FNMUL  H20, H17, H7
    FCVTZU  X24, H15
    FCVTNS  X25, H5
    SCVTF  S26, X17, #48
    FCMP  S14, S1
    FNMSUB  S31, S16, S24, S12
    FABS  D10, D23
    FCVTAU  X24, H18
    FCVTZU  X23, H13
    FCVTAU  W3, D11
    FCVTZU  X16, S20
    FCVTZU  W16, H10, #19
    FMOV  D5, D26
    FCMPE  D27, D31
    FRINTN  H24, H5
    FCVTNU  X29, S24
    FABS  S1, S13
    FMUL  H15, H18, H12
    FSUB  S14, S0, S14
    FCCMPE  H6, H3, #0x3, NE
    UCVTF  S6, X29
    FCVTAU  W11, S11
    FCVTNS  X22, S12
    FNMUL  D8, D16, D12
    FRINTA  H16, H18
    UCVTF  S12, W3
    FCVTAU  X23, D17
    FCSEL  H0, H22, H9, HI
    FCVTZU  X25, S19
    FMOV  S26, W24
    FCVTNU  W16, H0
    FMOV  D3, D26
    FCVT  H24, S12
    FMADD  H13, H8, H15, H3
    FCVTMS  X29, S1
    FCVTAU  X21, S16
    FCVTZU  W25, H6
    SCVTF  S20, W29, #30
    FCMPE  H20, H24
    FRINTP  D11, D13
    FCVTNS  X4, D11
    FCMP  D1, #0.0
    FNEG  D5, D13
    FRINTA  H12, H10
    SCVTF  D15, X21
    FMOV  S17, S19
    UCVTF  H3, X11, #50
    FCVTZU  W11, D11, #14
    FCVTNS  X18, D3
    FCVTMS  X10, D2
    FCVTZS  W18, D10
    FDIV  H18, H15, H18
    FSQRT  S22, S20
    UCVTF  D10, W4
    SCVTF  H24, X11
    FSQRT  S20, S14
    FSQRT  S14, S1
    FCVTPS  W11, H26
    FCVTAS  X18, S10
    FMINNM  H8, H12, H22
    SCVTF  S10, W18
    FCVTAS  W4, D18
    FRINTN  H2, H5
    FCVTMS  W28, D8
    FCVTAS  W11, D17
    SCVTF  S15, W4, #18
    FSQRT  S3, S15
    FCVTMU  W25, S3
    FNMSUB  D22, D2, D14, D10
    FCVTZU  X24, S20
    FADD  S20, S24, S24
    FCVTMU  W28, D22
    FMOV  W13, H30
    FCVTZU  X13, S10
    FSUB  H8, H3, H1
    SCVTF  H30, W25, #19
    FCSEL  S26, S27, S23, LT
    FMAXNM  D17, D15, D27
    FNEG  S5, S14
    FNMADD  S22, S20, S17, S22
    FCVTMS  W3, S16
    FCVTMS  W21, D19
    FMSUB  D2, D13, D28, D22
    FCCMPE  S7, S27, #0xe, LT
    FCVTZU  X11, D16, #59
    FMOV  D23, X24
    FCVTMU  W29, S22
    FCVTMU  X27, D6
    UCVTF  H1, W21
    FMAXNM  H18, H0, H5
    UCVTF  D15, W29
    SCVTF  D13, X28, #32
    FCVTMS  X29, S18
    UCVTF  S28, X29, #15
    FRINTP  D27, D20
    FMOV  D17, D8
    FMOV  H20, H26
    FCVTMS  W4, D15
    FRINTM  H0, H1
    FCVTZU  W11, H13
    SCVTF  H16, X27
    FRINTP  S6, S16
    FABS  D5, D6
    FCVTMU  X13, S20
    FRINTA  D15, D30
    FCVTZU  X4, H5
    UCVTF  S6, W13, #28
    FCVTAS  W17, S28
    FCMPE  H17, H17
    FCVTZU  X4, H27
    FCMPE  H0, #0.0
    FMAX  D20, D6, D6
    FCVTPS  W27, H15
    FCVTMU  W4, D20
    SUBS  X20, X20, #0x1
    B.NE  TSRTFloatAllOperation_label_10
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X15, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x1f, LSL #0
    MRS  X15, FPSR
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D0
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D1
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    FMOV  X15, D2
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D3
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D4
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D5
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D6
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D8
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D10
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D11
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D12
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D13
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D16
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D17
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D18
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D20
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    FMOV  X15, D22
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D23
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D24
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D26
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D27
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D29
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D30
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X15, D31
    SUB  X7, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, TSRTFloatAllOperation_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X23
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X3
    FMOV  V3.D[1], X21
    FMOV  D4, X26
    FMOV  V4.D[1], X24
    FMOV  D5, X13
    FMOV  V5.D[1], X29
    FMOV  D6, X27
    FMOV  V6.D[1], X18
    FMOV  D7, X28
    FMOV  V7.D[1], X13
    FMOV  D8, X28
    FMOV  V8.D[1], X5
    FMOV  D9, X15
    FMOV  V9.D[1], X4
    FMOV  D10, X12
    FMOV  V10.D[1], X16
    FMOV  D11, X15
    FMOV  V11.D[1], X22
    FMOV  D12, X15
    FMOV  V12.D[1], X14
    FMOV  D13, X26
    FMOV  V13.D[1], X26
    FMOV  D14, X22
    FMOV  V14.D[1], X20
    FMOV  D15, X14
    FMOV  V15.D[1], X18
    FMOV  D16, X28
    FMOV  V16.D[1], X27
    FMOV  D17, X24
    FMOV  V17.D[1], X26
    FMOV  D18, X25
    FMOV  V18.D[1], X12
    FMOV  D19, X20
    FMOV  V19.D[1], X5
    FMOV  D20, X14
    FMOV  V20.D[1], X25
    FMOV  D21, X29
    FMOV  V21.D[1], X20
    FMOV  D22, X20
    FMOV  V22.D[1], X11
    FMOV  D23, X26
    FMOV  V23.D[1], X13
    FMOV  D24, X14
    FMOV  V24.D[1], X17
    FMOV  D25, X6
    FMOV  V25.D[1], X3
    FMOV  D26, X4
    FMOV  V26.D[1], X23
    FMOV  D27, X4
    FMOV  V27.D[1], X18
    FMOV  D28, X7
    FMOV  V28.D[1], X16
    FMOV  D29, X23
    FMOV  V29.D[1], X25
    FMOV  D30, X5
    FMOV  V30.D[1], X11
    FMOV  D31, X11
    FMOV  V31.D[1], X20
    MOVZ  X7, #0xa, LSL #0
TSRTFloatAllOperation_label_11:
    FCVTMS  W26, D19
    FMINNM  H17, H26, H25
    FCCMPE  H22, H28, #0x7, VC
    SCVTF  D9, X25
    FCVTPU  W18, S9
    FCVTZU  X3, D29
    FCVTZS  W4, S27, #20
    FCMPE  H31, H31
    FCMP  S30, #0.0
    FMINNM  S4, S17, S17
    FCVTNU  W20, D24
    FMAX  D24, D4, D4
    FNMADD  H26, H24, H24, H24
    FCMPE  D11, D26
    FNEG  D2, D17
    UCVTF  H13, X13
    UCVTF  H23, X11, #52
    FSQRT  D10, D12
    FADD  S4, S7, S6
    FRINTP  S6, S16
    FDIV  S27, S28, S27
    FRINTI  H24, H1
    FMINNM  S11, S22, S29
    FCVTAS  W13, H6
    FCMP  H23, #0.0
    FCMPE  S10, S24
    UCVTF  H30, W20
    UCVTF  H29, X13, #33
    FADD  S12, S29, S13
    FCCMP  H12, H12, #0x2, PL
    FCCMP  D4, D30, #0x0, VC
    FCCMPE  D18, D11, #0x8, CS
    FCVTNS  X11, S27
    FCCMP  S4, S21, #0xe, CS
    FMAXNM  S10, S18, S22
    FCVTZS  W20, S18
    FMIN  D29, D31, D2
    FCVTZU  X14, S10, #42
    FCVTNU  X11, S6
    FRINTP  D10, D0
    FNMADD  H17, H28, H3, H4
    FCVTPU  W6, H2
    FCVTMU  W4, H15
    FMAXNM  H11, H13, H3
    FMSUB  D3, D5, D26, D4
    FCVTAU  W4, S7
    FMOV  S30, S16
    FCMPE  H26, H15
    FCVTAS  X17, H19
    FCVTZU  X3, H19
    FABS  H2, H13
    FMOV  S4, S10
    FCSEL  S31, S0, S15, GE
    FCVTZU  W10, H15, #11
    FCVTAU  X18, D19
    FRINTX  D18, D23
    FDIV  D5, D18, D29
    FCVTAU  X3, S30
    FCVT  H23, D2
    FCVTAU  X14, H23
    FMINNM  S22, S17, S4
    FRINTN  S26, S3
    FCVTZU  W20, D11, #3
    UCVTF  H11, X20, #4
    FRINTA  D23, D31
    FCVTZS  W17, S23
    FCVTAS  W6, H22
    FCVTPS  X11, S5
    FRINTX  S13, S11
    FCVTNS  X16, H13
    FNMSUB  H16, H8, H24, H8
    FCVT  D22, S17
    FMADD  S24, S28, S30, S5
    FNMUL  D15, D6, D16
    FCVTMU  W28, D13
    FMAXNM  H3, H13, H24
    SCVTF  S18, X16, #61
    FCVTZS  W28, D15
    FRINTN  H23, H25
    FRINTP  D17, D7
    FNMADD  H7, H7, H17, H3
    UCVTF  H25, X17, #17
    FCVTNS  W16, H30
    FSQRT  S30, S17
    FCVTPS  X4, D28
    FMIN  S8, S22, S22
    FCVTZU  X18, D5, #39
    FRINTZ  S15, S6
    FCVTPU  W6, H25
    FABS  H13, H6
    FRINTP  H3, H30
    FCVT  D17, S15
    FRINTP  H16, H9
    SCVTF  S5, X6
    FCVTPU  W10, S7
    FRINTA  S15, S5
    FCVTZS  W6, D13, #5
    FADD  H13, H17, H15
    FCVTZS  X5, D3, #64
    FRINTA  H9, H18
    FCVTPU  X23, H16
    FCMPE  S8, S8
    FNEG  S8, S13
    FSUB  H28, H8, H9
    FCMPE  D28, #0.0
    FMAXNM  S18, S28, S22
    FCVTZU  X10, D31, #32
    FCMP  D4, D28
    FCMPE  S17, S23
    FRINTZ  H22, H15
    FCVTPS  X20, H28
    FMOV  H9, W20
    FCVTPS  X15, S6
    FCVTZU  X3, S14, #37
    UCVTF  S4, W10, #16
    FCVTZU  W4, D25, #8
    UCVTF  S8, X3
    FCSEL  D31, D23, D26, LT
    FCVT  H13, S5
    FMIN  S14, S1, S11
    FRINTX  H25, H3
    FCVT  H1, D25
    FCVTPS  W17, H22
    FMOV  W14, H18
    FCVTZU  X4, S9, #35
    FCVTAS  W6, S4
    FCVTZS  W26, S1
    FCMP  S8, #0.0
    FCMP  S14, #0.0
    FCVTPS  W25, D31
    FMOV  H5, X14
    FCVTZU  W23, S25, #1
    FCVTZS  W3, D15
    SCVTF  D17, X26
    FMOV  H23, W17
    FCSEL  S6, S17, S8, LS
    FCVTPU  W15, H13
    FRINTX  H3, H10
    FMIN  H17, H7, H27
    FCMPE  H1, #0.0
    FCCMPE  D9, D20, #0xa, CC
    FNMADD  H1, H27, H29, H20
    FRINTI  D20, D21
    FCVTMS  X28, H4
    FCCMP  H9, H14, #0x2, VS
    FCVTZS  X29, H18
    FMIN  H13, H3, H31
    FCVTNU  W5, H22
    FNMSUB  H11, H19, H3, H18
    FCVTNU  W16, D30
    SCVTF  D8, X16, #42
    UCVTF  S31, W3, #2
    SCVTF  H9, X15, #45
    FDIV  H10, H17, H5
    FNMSUB  H30, H10, H20, H20
    FCVTNU  W18, D13
    UCVTF  D14, W18, #23
    FCVTMS  W24, D9
    FCVTMS  X4, S6
    FMSUB  D10, D31, D31, D1
    FRINTZ  D15, D8
    FCVTZU  X11, S10
    FCVTAU  W25, D30
    SCVTF  H31, W4
    FMINNM  H8, H11, H14
    FCVT  S9, H15
    FCVTAS  W26, S9
    FRINTZ  S7, S31
    FCVTZS  W24, H8, #27
    FCMPE  D8, #0.0
    FMOV  S10, W28
    FMOV  H19, W11
    FABS  S9, S3
    FCVTMS  X14, D24
    FCMPE  S26, S22
    FCVTMS  W3, D16
    FRINTP  D1, D3
    FCVTZS  W29, S13, #20
    FCVTNU  W10, D12
    FRINTX  H8, H2
    FMOV  W26, H11
    SCVTF  H30, W24
    FSQRT  D31, D5
    FNMUL  S24, S5, S30
    FCVTZU  X11, S3
    FMSUB  H16, H19, H14, H26
    FMIN  S3, S13, S27
    FCMPE  D8, #0.0
    FMADD  S15, S16, S9, S7
    FNEG  H12, H25
    FSUB  S2, S3, S3
    FCVTAU  W6, D24
    FMOV  H11, X3
    UCVTF  S9, X24
    FMADD  H24, H2, H9, H15
    FCVTPU  X23, S24
    FADD  H5, H31, H31
    FCVTAU  W25, H11
    FCVT  S25, D5
    FCVTZS  X26, H10
    FMADD  S22, S12, S1, S12
    SCVTF  D11, X11
    FMAXNM  S26, S25, S11
    FRINTZ  H0, H26
    FMINNM  S24, S0, S22
    FCVTZS  X29, H24, #36
    FNMSUB  H31, H25, H24, H10
    FCVT  H2, D14
    FRINTA  D3, D2
    FRINTN  H24, H0
    FRINTA  H0, H1
    FMIN  H12, H14, H4
    FCVTZS  W26, S9
    FCMP  H11, #0.0
    FCVTZU  X20, S5
    FCVTAS  W28, D0
    FSQRT  H22, H10
    UCVTF  D25, W20
    FRINTA  D1, D24
    FCVTZU  W13, H1
    FMAX  H26, H8, H24
    FCVTAS  W11, S16
    FCVTZU  W4, S29
    FCMPE  H20, H29
    FCVTPU  W15, S24
    SCVTF  D8, X15, #2
    FCVTZU  W18, H14, #25
    FRINTN  H4, H29
    FRINTP  H20, H7
    FCVTZU  W10, D8
    FMOV  H9, W18
    FMADD  H0, H12, H26, H22
    FCVTNS  W27, D25
    FCVTMS  W18, S4
    FMAX  D24, D0, D0
    FCVTNS  W20, H9
    SCVTF  D10, X11, #5
    FCVTAU  X16, S10
    FCVTZU  W23, H3, #30
    FABS  S12, S20
    FRINTZ  S16, S30
    FCVTZU  X13, H24, #34
    FCVTZU  X18, S16
    FRINTZ  S22, S9
    FCVTMU  X14, H15
    FCVTAS  W11, D13
    FCVT  D3, S24
    FMOV  W28, H29
    FMOV  S13, #1.31250000
    FMSUB  S16, S1, S9, S1
    FCCMP  S26, S6, #0x4, NV
    FCVTAS  W20, S26
    FNMUL  S15, S25, S27
    FMAX  D25, D15, D22
    FCVTZU  X11, S11, #26
    FCVTPS  W5, H0
    FCVTZS  X28, H21, #64
    FMUL  H24, H25, H27
    FCVTAU  W10, S30
    FCVTZU  X13, D15
    SCVTF  H6, X13, #62
    FCVT  D30, S14
    FCVTZU  X25, D29, #28
    FCVTAU  X4, S7
    FCVTMS  W23, H16
    FCVTPS  X15, S20
    FCVTAS  X6, D16
    FCVTNS  X25, S29
    FCVT  D20, S20
    FCVTAS  X18, D18
    FMUL  H14, H6, H11
    FCVTAU  W17, D11
    FCMP  D9, D9
    FMIN  H6, H14, H2
    FCVTPU  W27, S5
    SCVTF  D29, X4, #56
    FADD  D21, D31, D21
    SCVTF  H1, X6, #41
    FCVTMU  W3, S1
    SCVTF  H7, X18
    FMOV  H31, #-0.78125000
    SCVTF  S18, W17
    FCVTNU  W14, D6
    FCVTPS  W16, D24
    FCVTPU  X27, S20
    FRINTI  S6, S31
    FMOV  H1, H7
    FCSEL  H7, H29, H30, NE
    FRINTI  D11, D21
    FNEG  D20, D11
    FABS  H11, H1
    FCVTNU  W4, D6
    FRINTX  H24, H20
    FCVT  H1, D24
    FCSEL  H20, H1, H1, PL
    FRINTA  D1, D8
    FCVTAU  X6, S1
    FRINTM  D1, D18
    UCVTF  H24, X3, #12
    FMUL  S18, S1, S7
    SUBS  X7, X7, #0x1
    B.NE  TSRTFloatAllOperation_label_11
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X12, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x1f, LSL #0
    MRS  X12, FPSR
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D0
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D1
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D2
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D3
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D4
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D5
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D6
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D7
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D8
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D9
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D10
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D11
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D12
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x3fa8, LSL #16
    FMOV  X12, D13
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D14
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xffc0, LSL #16
    FMOV  X12, D15
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D16
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x8000, LSL #0
    FMOV  X12, D17
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D18
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D19
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D20
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7ff8, LSL #48
    FMOV  X12, D21
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D22
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D23
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D24
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xffc0, LSL #16
    FMOV  X12, D25
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D26
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    FMOV  X12, D27
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D28
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D29
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, D30
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X21, #0xba40, LSL #0
    FMOV  X12, D31
    SUB  X22, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0xc19a, LSL #0
    MOVK  X3, #0x1fb7, LSL #16
    MOVK  X3, #0x3f93, LSL #32
    MOVK  X3, #0xb27c, LSL #48
    MOVZ  X4, #0x6d7a, LSL #0
    MOVK  X4, #0xd347, LSL #16
    MOVK  X4, #0x95f4, LSL #32
    MOVK  X4, #0xf4e3, LSL #48
    MOVZ  X5, #0x3d1c, LSL #0
    MOVK  X5, #0x5bf7, LSL #16
    MOVK  X5, #0x9172, LSL #32
    MOVK  X5, #0x30db, LSL #48
    MOVZ  X6, #0x5ab, LSL #0
    MOVK  X6, #0x10cb, LSL #16
    MOVK  X6, #0xd7c, LSL #32
    MOVK  X6, #0x57e0, LSL #48
    MOVZ  X7, #0x80a5, LSL #0
    MOVK  X7, #0x4852, LSL #16
    MOVK  X7, #0x7999, LSL #32
    MOVK  X7, #0x146f, LSL #48
    MOVZ  X10, #0xa007, LSL #0
    MOVK  X10, #0xe1ea, LSL #16
    MOVK  X10, #0xfbe9, LSL #32
    MOVK  X10, #0xf50e, LSL #48
    MOVZ  X11, #0xf2a0, LSL #0
    MOVK  X11, #0x3a26, LSL #16
    MOVK  X11, #0xc4a4, LSL #32
    MOVK  X11, #0x2de0, LSL #48
    MOVZ  X12, #0xe68a, LSL #0
    MOVK  X12, #0xf65d, LSL #16
    MOVK  X12, #0x411, LSL #32
    MOVK  X12, #0x447d, LSL #48
    MOVZ  X13, #0xd7ee, LSL #0
    MOVK  X13, #0x799d, LSL #16
    MOVK  X13, #0x669, LSL #32
    MOVK  X13, #0x2907, LSL #48
    MOVZ  X14, #0xa8b4, LSL #0
    MOVK  X14, #0x4eca, LSL #16
    MOVK  X14, #0x7248, LSL #32
    MOVK  X14, #0x7d44, LSL #48
    MOVZ  X15, #0x764c, LSL #0
    MOVK  X15, #0x8754, LSL #16
    MOVK  X15, #0x9dca, LSL #32
    MOVK  X15, #0xd3c2, LSL #48
    MOVZ  X16, #0xa4fc, LSL #0
    MOVK  X16, #0x6839, LSL #16
    MOVK  X16, #0xe338, LSL #32
    MOVK  X16, #0xfb21, LSL #48
    MOVZ  X17, #0x5810, LSL #0
    MOVK  X17, #0xe606, LSL #16
    MOVK  X17, #0x515f, LSL #32
    MOVK  X17, #0x156, LSL #48
    MOVZ  X18, #0x3f1f, LSL #0
    MOVK  X18, #0x40b4, LSL #16
    MOVK  X18, #0x3021, LSL #32
    MOVK  X18, #0xd911, LSL #48
    MOVZ  X20, #0xf86e, LSL #0
    MOVK  X20, #0x6178, LSL #16
    MOVK  X20, #0xecbf, LSL #32
    MOVK  X20, #0x8249, LSL #48
    MOVZ  X21, #0x3e3c, LSL #0
    MOVK  X21, #0x5fdc, LSL #16
    MOVK  X21, #0x4cea, LSL #32
    MOVK  X21, #0x2f52, LSL #48
    MOVZ  X22, #0x26e7, LSL #0
    MOVK  X22, #0x450b, LSL #16
    MOVK  X22, #0xf855, LSL #32
    MOVK  X22, #0xf224, LSL #48
    MOVZ  X23, #0xfc7, LSL #0
    MOVK  X23, #0x1637, LSL #16
    MOVK  X23, #0x397, LSL #32
    MOVK  X23, #0xdaca, LSL #48
    MOVZ  X24, #0xfc65, LSL #0
    MOVK  X24, #0xa06c, LSL #16
    MOVK  X24, #0xfc2d, LSL #32
    MOVK  X24, #0x834f, LSL #48
    MOVZ  X25, #0xe7ec, LSL #0
    MOVK  X25, #0x90aa, LSL #16
    MOVK  X25, #0x1f24, LSL #32
    MOVK  X25, #0xd844, LSL #48
    MOVZ  X26, #0x7f17, LSL #0
    MOVK  X26, #0xcdfb, LSL #16
    MOVK  X26, #0xae39, LSL #32
    MOVK  X26, #0xd9c5, LSL #48
    MOVZ  X27, #0x7d8d, LSL #0
    MOVK  X27, #0x9d54, LSL #16
    MOVK  X27, #0x2daf, LSL #32
    MOVK  X27, #0xcd79, LSL #48
    MOVZ  X28, #0x7d3b, LSL #0
    MOVK  X28, #0x5b81, LSL #16
    MOVK  X28, #0x3aad, LSL #32
    MOVK  X28, #0x3664, LSL #48
    MOVZ  X29, #0xd8cf, LSL #0
    MOVK  X29, #0x6ae1, LSL #16
    MOVK  X29, #0xb93d, LSL #32
    MOVK  X29, #0xec39, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X24
    FMOV  D3, X15
    FMOV  V3.D[1], X4
    FMOV  D4, X25
    FMOV  V4.D[1], X26
    FMOV  D5, X15
    FMOV  V5.D[1], X4
    FMOV  D6, X11
    FMOV  V6.D[1], X24
    FMOV  D7, X3
    FMOV  V7.D[1], X24
    FMOV  D8, X27
    FMOV  V8.D[1], X12
    FMOV  D9, X27
    FMOV  V9.D[1], X15
    FMOV  D10, X21
    FMOV  V10.D[1], X11
    FMOV  D11, X16
    FMOV  V11.D[1], X27
    FMOV  D12, X23
    FMOV  V12.D[1], X27
    FMOV  D13, X20
    FMOV  V13.D[1], X12
    FMOV  D14, X6
    FMOV  V14.D[1], X29
    FMOV  D15, X21
    FMOV  V15.D[1], X13
    FMOV  D16, X17
    FMOV  V16.D[1], X17
    FMOV  D17, X14
    FMOV  V17.D[1], X11
    FMOV  D18, X20
    FMOV  V18.D[1], X28
    FMOV  D19, X12
    FMOV  V19.D[1], X3
    FMOV  D20, X22
    FMOV  V20.D[1], X10
    FMOV  D21, X4
    FMOV  V21.D[1], X24
    FMOV  D22, X12
    FMOV  V22.D[1], X10
    FMOV  D23, X28
    FMOV  V23.D[1], X22
    FMOV  D24, X11
    FMOV  V24.D[1], X16
    FMOV  D25, X22
    FMOV  V25.D[1], X5
    FMOV  D26, X10
    FMOV  V26.D[1], X6
    FMOV  D27, X4
    FMOV  V27.D[1], X23
    FMOV  D28, X20
    FMOV  V28.D[1], X6
    FMOV  D29, X11
    FMOV  V29.D[1], X29
    FMOV  D30, X3
    FMOV  V30.D[1], X24
    FMOV  D31, X12
    FMOV  V31.D[1], X21
    MOVZ  X10, #0xa, LSL #0
TSRTFloatAllOperation_label_12:
    FCMP  H30, H23
    FCVTMU  W16, H24
    FCMPE  S28, #0.0
    FCVTMS  W29, S26
    FMOV  H16, #-4.75000000
    FRINTN  H21, H20
    FCVTMU  X12, D31
    FRINTN  S0, S29
    FCMP  S27, #0.0
    FMUL  D10, D16, D0
    FCVTNU  W6, S10
    FRINTM  H16, H25
    FMINNM  D10, D16, D16
    FMUL  S26, S21, S17
    FCVTNS  X3, S26
    FCCMPE  S9, S24, #0xa, CS
    FMOV  H21, #0.21875000
    FCVTZU  X21, D3, #54
    FCSEL  H25, H30, H22, CS
    FCVTMU  W17, S19
    FRINTA  H16, H18
    FCSEL  S0, S27, S19, LE
    FMOV  S29, S3
    FRINTX  H27, H13
    FCVTNU  W25, D4
    FCVT  D17, S8
    FCVT  S18, D4
    FCVTZU  W5, D10, #31
    UCVTF  S26, X25
    UCVTF  D30, X21
    FRINTN  H3, H16
    FCVTMU  W21, H17
    FCVTNS  X22, H18
    FCVTPU  X26, H21
    FSQRT  H18, H25
    UCVTF  H16, W17
    FCVTZS  W15, H26
    FCVTZU  W22, D27
    FMINNM  H10, H6, H29
    FCVTAS  X18, H30
    FRINTI  S8, S3
    FCMP  D0, #0.0
    FRINTN  D4, D18
    SCVTF  D17, W22, #31
    UCVTF  D25, X21, #43
    FMOV  W22, S25
    FCVTMU  W14, S10
    FCVTZU  X6, H16, #35
    FCVTPU  X24, H8
    SCVTF  H21, X18
    FMINNM  H29, H4, H10
    FMAX  H0, H29, H29
    UCVTF  S29, X26
    SCVTF  H30, W15
    FRINTN  D26, D17
    FCMPE  H26, H26
    FCVTPS  W21, D21
    FCMPE  D29, #0.0
    FRINTX  S18, S0
    FNMADD  S16, S18, S30, S18
    FCVTMS  W26, D15
    FCVTZU  X28, H5
    FCMPE  H19, H30
    FCVTZS  X29, S15, #57
    FNEG  S8, S27
    FMOV  X5, D25
    UCVTF  H15, X24
    FSQRT  D18, D4
    FNMUL  D10, D16, D2
    FCVTNS  X22, S26
    FMOV  D25, X26
    FCVT  H6, S16
    FNEG  D5, D18
    FCVTZS  W3, H17, #16
    FCCMPE  D19, D30, #0x3, NV
    FCVTNS  X21, D25
    FMOV  S2, S21
    FNEG  H27, H21
    FCVTZU  X28, H14
    FMOV  S14, S11
    FMOV  S4, #-0.59375000
    FRINTI  H0, H4
    FCVTMS  X21, S14
    FCVT  D29, S8
    FRINTI  D26, D27
    FCMP  H26, #0.0
    SCVTF  S16, X3, #34
    SCVTF  H25, X28, #7
    FRINTM  D5, D29
    FCVT  H11, S16
    FSUB  S14, S2, S2
    FNMADD  H29, H6, H11, H0
    FCCMP  D14, D25, #0x2, MI
    UCVTF  S17, W21
    FMAXNM  S4, S29, S17
    SCVTF  S21, W28
    FCVTZU  X24, H4
    FCVTNU  X7, D21
    FNEG  S2, S5
    FCVTPS  X13, D2
    SCVTF  H14, W13
    FCVTNS  W12, D20
    UCVTF  D17, X12, #5
    FMOV  H29, X7
    FMADD  H25, H10, H28, H8
    SCVTF  D5, W29
    FMOV  H27, X10
    FCCMPE  H6, H14, #0x8, EQ
    UCVTF  H21, X26
    UCVTF  D26, X3, #51
    FNEG  S11, S22
    FCVTNU  X21, D28
    FCVTNU  X24, D1
    FCVTZU  X13, S5
    FRINTA  H1, H13
    FMOV  H0, #21.00000000
    FMADD  D16, D0, D26, D11
    FMOV  S11, W12
    FRINTA  D8, D29
    FMOV  D28, D25
    FCVTMU  X12, S1
    FCSEL  D25, D17, D28, LT
    FCVT  H28, D24
    FMOV  S22, #1.12500000
    FCMPE  D8, D26
    FCMPE  S25, S21
    FCVTZS  X13, H11
    UCVTF  D5, X26
    FCVTZS  W21, S16, #28
    FCMP  S22, #0.0
    FCVTMU  W4, D27
    FCVTMU  X25, D5
    FCVTAU  X24, D23
    FMIN  S21, S0, S11
    FCVTZU  W21, D5
    FCVTPS  X12, S29
    FCVT  H26, S10
    FCVTAS  X4, S4
    FCMPE  H30, #0.0
    FCVTZS  X13, S23
    FCVT  S23, D12
    FCMP  D12, #0.0
    UCVTF  S11, W12, #2
    FRINTZ  H0, H4
    FSQRT  S4, S21
    FRINTM  D12, D30
    FCCMPE  D19, D30, #0xb, GE
    FCVTZU  X3, S1, #23
    FMOV  H16, #-4.25000000
    FDIV  S5, S31, S14
    FMIN  D10, D23, D11
    FMOV  H29, W4
    FCVTNS  W18, H10
    FMOV  H10, W21
    FCVTNU  W26, S12
    FADD  H30, H0, H26
    FCVTZS  W21, H30
    FCVTZS  X28, H10
    FMINNM  D0, D4, D16
    FCVTPS  X29, S0
    FMOV  X13, H29
    FCVTNS  W6, D8
    FRINTP  D12, D12
    SCVTF  S28, W3, #3
    FRINTI  D26, D31
    FCVTPU  X25, D0
    FCVTNU  W3, S27
    FMAX  D11, D16, D1
    FMOV  H19, X21
    FCVTZS  W11, D21
    UCVTF  D21, X28, #17
    FCVTAU  X18, S4
    FRINTN  H1, H25
    FCVT  H14, S16
    FCVTPS  X13, D11
    FMSUB  S30, S19, S12, S21
    FCVTPU  W14, D1
    FCMP  H26, #0.0
    FMSUB  H19, H30, H28, H28
    FCVT  H4, D14
    UCVTF  H21, W6, #16
    FCVTMS  W21, H11
    FCVTAU  X11, H21
    FCMP  D4, #0.0
    FCVT  H12, D18
    FRINTI  S11, S15
    FMOV  D30, X18
    FRINTZ  S18, S10
    FCVTZS  W26, S12
    FCVTNS  X28, D12
    FCVTZU  X6, H13, #37
    FRINTZ  D28, D17
    FSQRT  H21, H28
    FMINNM  D25, D15, D1
    UCVTF  D12, W26
    FCCMPE  D30, D31, #0x6, EQ
    FMIN  D14, D6, D10
    FCVTZU  W22, D4
    FCVTNU  X17, H8
    FMAX  S15, S6, S12
    FCVTNS  W24, H14
    UCVTF  S14, W11, #18
    SCVTF  H6, X22
    FRINTP  H13, H17
    FCVTNS  W22, S18
    SCVTF  D26, W17
    SCVTF  S28, W6, #26
    FCCMPE  D19, D26, #0xf, CC
    FMADD  S17, S15, S13, S14
    FCMP  D6, D6
    FMOV  H13, #2.87500000
    FRINTI  D8, D25
    FRINTI  D18, D8
    FCVTMU  X15, S18
    FCVTNS  X21, S21
    SCVTF  S6, W22
    FCVTAS  W6, S6
    FMOV  H21, W15
    FSUB  H6, H21, H21
    FCVTZU  W12, D17
    SCVTF  D18, X12
    FCMPE  H28, #0.0
    FMOV  W3, S18
    FCCMP  S6, S13, #0xd, EQ
    FRINTN  H31, H12
    FRINTX  H21, H14
    FCMP  D12, #0.0
    FCVTPU  W5, D23
    FCVTZU  W25, D5, #12
    UCVTF  D25, W3
    FCCMPE  S16, S16, #0xd, AL
    FCVTZS  X3, H13, #38
    FCVTZS  X24, S14
    FCMP  D12, D0
    UCVTF  D6, X5
    FRINTI  D17, D23
    FCMP  H28, #0.0
    FCVTMS  W11, D21
    FRINTZ  D28, D19
    FCVTAU  X6, D20
    FCVTAU  W29, H21
    FRINTN  D18, D25
    FMADD  H8, H5, H26, H24
    FMOV  W29, S3
    UCVTF  D21, X29
    FMSUB  D3, D0, D7, D26
    FMSUB  H26, H1, H15, H8
    FCVTMS  W18, D6
    FCVTMS  X26, D8
    FCVTZS  X24, H26, #42
    FMAX  S23, S9, S10
    FCVTZS  W11, H2, #6
    FCVTPS  X22, S17
    FNMUL  D19, D22, D10
    FSUB  S0, S19, S30
    FNMSUB  D2, D3, D20, D26
    FCVTZS  X7, S0, #41
    FCVTMS  X12, D2
    FADD  S1, S14, S1
    UCVTF  D9, W6
    FCMP  D29, #0.0
    UCVTF  D22, W26, #31
    FCMP  D11, D12
    FNMSUB  D30, D26, D6, D9
    FCMPE  S24, S10
    FCVTZS  X6, S13
    FCVTZS  W22, H14, #27
    FRINTX  S29, S12
    FRINTP  D8, D13
    FMSUB  D0, D1, D30, D1
    FMSUB  D19, D29, D22, D0
    UCVTF  S26, W22
    FCVTPS  W15, S26
    FCMP  D19, #0.0
    FCVTZU  W29, D8, #10
    FCVTAU  W14, H28
    FRINTZ  S10, S7
    FMSUB  D24, D10, D23, D10
    FCVTNU  X14, S9
    FCVTPS  W4, S14
    FCVTMU  X11, H21
    FCVTZS  X16, H10
    FMOV  S11, S9
    FRINTM  D12, D17
    FCVTPS  W15, S20
    FADD  H13, H13, H28
    FCVTMS  W17, D20
    FMOV  H21, H19
    FCVTMS  X6, S19
    SCVTF  S6, W6
    UCVTF  H30, W15
    FCVTNS  X21, D5
    FMSUB  S14, S1, S28, S25
    UCVTF  S26, X21
    FCMPE  D12, #0.0
    UCVTF  H22, X11, #39
    FNMUL  H28, H22, H26
    FCVTZS  X25, H30, #4
    FCVTZU  X12, H28, #41
    FMIN  H28, H14, H6
    SUBS  X10, X10, #0x1
    B.NE  TSRTFloatAllOperation_label_12
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xb8, LSL #32
    SUB  X23, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x1, LSL #0
    SUB  X23, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x8b3, LSL #0
    SUB  X23, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #16
    SUB  X23, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x8b20, LSL #0
    SUB  X23, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X23, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x400, LSL #0
    SUB  X23, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x1f, LSL #0
    MRS  X23, FPSR
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V0.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D0
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V1.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D1
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x8000, LSL #48
    FMOV  X23, D2
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V3.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D3
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D4
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D5
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D6
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0xfc65, LSL #0
    MOVK  X27, #0xa06c, LSL #16
    MOVK  X27, #0xfc2d, LSL #32
    MOVK  X27, #0x834f, LSL #48
    FMOV  X23, V7.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0xc19a, LSL #0
    MOVK  X27, #0x1fb7, LSL #16
    MOVK  X27, #0x3f93, LSL #32
    MOVK  X27, #0xb27c, LSL #48
    FMOV  X23, D7
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x3ff0, LSL #48
    FMOV  X23, D8
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D9
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D10
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V11.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D11
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V12.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D12
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V13.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x41c0, LSL #0
    FMOV  X23, D13
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D14
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x8000, LSL #0
    FMOV  X23, D15
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0xc440, LSL #0
    FMOV  X23, D16
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V17.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D17
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V18.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D18
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D19
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0xa007, LSL #0
    MOVK  X27, #0xe1ea, LSL #16
    MOVK  X27, #0xfbe9, LSL #32
    MOVK  X27, #0xf50e, LSL #48
    FMOV  X23, V20.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x26e7, LSL #0
    MOVK  X27, #0x450b, LSL #16
    MOVK  X27, #0xf855, LSL #32
    MOVK  X27, #0xf224, LSL #48
    FMOV  X23, D20
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V21.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D21
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D22
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D23
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V24.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D24
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D25
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D26
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x1, LSL #0
    FMOV  X23, D27
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V28.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D28
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D29
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x6859, LSL #0
    FMOV  X23, D30
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X23, D31
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    FMOV  D0, X15
    FMOV  V0.D[1], X26
    FMOV  D1, X10
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X20
    FMOV  D3, X27
    FMOV  V3.D[1], X25
    FMOV  D4, X24
    FMOV  V4.D[1], X18
    FMOV  D5, X21
    FMOV  V5.D[1], X23
    FMOV  D6, X22
    FMOV  V6.D[1], X26
    FMOV  D7, X20
    FMOV  V7.D[1], X28
    FMOV  D8, X17
    FMOV  V8.D[1], X27
    FMOV  D9, X29
    FMOV  V9.D[1], X10
    FMOV  D10, X15
    FMOV  V10.D[1], X23
    FMOV  D11, X14
    FMOV  V11.D[1], X26
    FMOV  D12, X26
    FMOV  V12.D[1], X23
    FMOV  D13, X3
    FMOV  V13.D[1], X6
    FMOV  D14, X18
    FMOV  V14.D[1], X7
    FMOV  D15, X7
    FMOV  V15.D[1], X11
    FMOV  D16, X17
    FMOV  V16.D[1], X7
    FMOV  D17, X5
    FMOV  V17.D[1], X24
    FMOV  D18, X21
    FMOV  V18.D[1], X27
    FMOV  D19, X21
    FMOV  V19.D[1], X13
    FMOV  D20, X15
    FMOV  V20.D[1], X24
    FMOV  D21, X28
    FMOV  V21.D[1], X25
    FMOV  D22, X17
    FMOV  V22.D[1], X12
    FMOV  D23, X23
    FMOV  V23.D[1], X23
    FMOV  D24, X28
    FMOV  V24.D[1], X12
    FMOV  D25, X20
    FMOV  V25.D[1], X11
    FMOV  D26, X28
    FMOV  V26.D[1], X25
    FMOV  D27, X17
    FMOV  V27.D[1], X16
    FMOV  D28, X25
    FMOV  V28.D[1], X14
    FMOV  D29, X29
    FMOV  V29.D[1], X26
    FMOV  D30, X21
    FMOV  V30.D[1], X29
    FMOV  D31, X10
    FMOV  V31.D[1], X23
    MOVZ  X22, #0xa, LSL #0
TSRTFloatAllOperation_label_13:
    FCVTNU  W29, D19
    FCVTZS  X27, S24
    FRINTX  S11, S25
    FCVTZU  W12, H27
    FCVT  D21, H31
    FCVTPU  W26, S29
    FCVTNU  X11, H28
    FMOV  D9, #-2.62500000
    FSUB  H27, H11, H21
    FCCMPE  S9, S30, #0xe, AL
    FCVTMS  X28, H27
    FNMADD  D3, D24, D8, D31
    FRINTI  S19, S3
    FCVTNU  W23, H19
    FCVTZU  W21, H25
    FNEG  H17, H8
    FCMP  S23, S29
    FNMADD  S16, S18, S21, S12
    FCVTNS  W5, S3
    FRINTX  S24, S19
    FMINNM  H27, H9, H24
    FCVTAU  W7, S4
    UCVTF  D31, X21, #26
    FMINNM  H4, H8, H4
    FCVTAU  X21, H25
    FRINTM  H11, H31
    FNEG  D30, D11
    FCVTAU  X11, D13
    FCVTPS  X11, D2
    FMADD  S3, S16, S4, S8
    FCVT  D23, S7
    FRINTX  D28, D20
    FCVT  H20, S26
    FRINTZ  S16, S4
    FMAX  H2, H22, H16
    FCVTZU  X27, H19, #14
    FMINNM  D31, D7, D2
    UCVTF  D8, W5
    FCVTMU  X23, H27
    FCVTMU  W27, S20
    FCMP  D30, #0.0
    UCVTF  D26, X23
    FCVTMU  W3, H31
    FCVTPU  W7, H8
    FCCMP  H26, H26, #0x7, NV
    FNEG  H16, H28
    UCVTF  H26, W11, #10
    FCCMP  H3, H16, #0x7, AL
    FCVTPU  X4, H23
    FRINTP  D31, D12
    SCVTF  H12, X27
    FRINTI  H30, H20
    FCVTNU  W29, S1
    FCVTMS  X7, D11
    FCVTZS  W25, S7
    FCVTMS  W10, H11
    FCVTNS  W3, D5
    FCVTZU  W17, H22, #1
    UCVTF  D27, W22
    FMINNM  S20, S0, S25
    FCVTPU  X24, S21
    FMSUB  S8, S18, S17, S29
    FCVTNU  X23, H17
    SCVTF  H23, W4
    SCVTF  H1, W17, #24
    FCVTMS  W27, H12
    FCVTZU  W4, H20, #25
    FNEG  S25, S30
    FRINTI  S11, S23
    FCCMPE  D11, D31, #0x9, AL
    FRINTM  D11, D8
    FCVTMS  X29, D1
    FCVTNS  W3, S25
    FCVTZS  X10, D11
    FCVTNS  W28, D26
    FRINTZ  D22, D27
    UCVTF  H8, X24, #54
    FCVTZS  W4, S29, #11
    FCCMP  D13, D13, #0xe, CC
    FCVTPS  W14, H16
    FSUB  D17, D21, D2
    FSUB  D31, D3, D12
    FCVTAU  X4, D8
    FMOV  S30, S2
    FCVTMS  W13, D8
    FCVTPS  W12, S24
    UCVTF  D2, X10
    FMSUB  S21, S31, S1, S30
    FCCMPE  H5, H7, #0x2, VC
    FMUL  H13, H14, H26
    FCVTAS  W17, H14
    FMOV  W17, H24
    FRINTP  S14, S0
    FRINTZ  D3, D20
    FCMPE  H1, #0.0
    FCVTNS  W17, S27
    FNMUL  H16, H26, H30
    FCVTPS  W10, D10
    FCVTNU  X26, S2
    FCCMPE  D24, D4, #0x9, NV
    FCCMP  H9, H26, #0xa, LS
    FRINTI  S12, S8
    FSQRT  S20, S28
    FRINTN  H0, H16
    FRINTX  H5, H13
    FCVTPU  X7, S3
    FMADD  S30, S0, S14, S14
    FCVTPU  W10, S20
    FCSEL  D27, D12, D12, VS
    FCMPE  S5, S5
    FCVTNU  X12, H30
    FNEG  S10, S27
    FCVT  H13, D10
    FCVTAS  X13, S13
    UCVTF  D8, X10, #5
    SCVTF  H24, X7, #16
    FADD  D27, D8, D18
    FCVTZS  X14, D10
    FCMPE  S26, S10
    FCVTZU  X29, D29
    FRINTZ  H30, H6
    FRINTI  H5, H1
    FMOV  H10, #-9.50000000
    FCMP  S29, #0.0
    FNEG  H13, H18
    FMOV  D8, D13
    FDIV  D26, D12, D15
    FCVTZU  X26, D21
    FCVTNS  W12, H3
    FNMSUB  D29, D7, D30, D6
    SCVTF  D18, X26, #30
    FMIN  S20, S15, S27
    FMADD  S27, S27, S14, S27
    FRINTX  D1, D24
    FCVTAU  X21, H19
    FCVT  S24, H5
    FNMUL  S12, S29, S27
    FCVTAU  X25, D24
    FNMSUB  D13, D26, D12, D1
    FCVTNU  W18, H8
    FRINTM  S21, S18
    FMAXNM  D6, D10, D27
    FCVTZU  X25, S20
    FMIN  H30, H13, H6
    FCVTAU  X21, S21
    FRINTI  D22, D12
    FNMADD  D3, D29, D28, D27
    UCVTF  D24, X18, #29
    FMADD  S12, S21, S17, S21
    FCVTZU  X29, H17
    SCVTF  S5, W29, #24
    FRINTM  S21, S31
    FCVTZS  X23, S18
    FCVTNS  W27, H30
    FCVTMS  W13, S25
    UCVTF  H26, X25, #35
    SCVTF  H20, W21, #3
    FCVTPU  X14, D12
    FMADD  D7, D18, D16, D18
    FRINTZ  S29, S27
    FCMP  D7, D3
    FMOV  D10, D21
    FRINTA  S17, S24
    FCVTMS  W23, D29
    SCVTF  H12, X13
    FNMUL  H28, H10, H5
    FMAXNM  H21, H17, H12
    FNMADD  H6, H21, H20, H22
    FCVTZS  X18, S1, #63
    FSQRT  D27, D6
    FCVTAS  X4, H28
    FCVTPU  X29, S27
    FNMSUB  H25, H17, H20, H19
    FCVTZS  X11, H16, #20
    FCVTMU  W10, H15
    FMADD  H5, H11, H24, H26
    FCVTZU  X4, S12, #21
    FCVT  H20, S17
    FMOV  S29, #4.00000000
    UCVTF  D3, X23, #64
    FRINTP  S24, S5
    FCVTZU  W25, D9, #7
    FCVTAS  W13, D19
    FMINNM  S11, S13, S10
    SCVTF  H7, W11
    FCMP  H29, #0.0
    FSUB  S6, S29, S29
    FCVTAU  W3, H15
    FCVTPU  W24, S6
    FCVTMU  X29, S17
    FCVTMS  W27, S5
    FCVTZS  X24, S27
    FCVTNU  X28, S30
    FCVTZU  W14, D30, #14
    FCVTPS  X21, H3
    FCSEL  S30, S9, S24, MI
    FRINTN  H17, H30
    FNMUL  S1, S20, S1
    FMAXNM  D5, D12, D23
    FMOV  X4, H20
    FCVTAU  W21, D31
    FCVTZS  X5, H23
    FCMP  D5, #0.0
    FADD  D5, D6, D17
    FNMSUB  S19, S31, S30, S30
    FCVTMU  W7, D0
    FCVTMS  W21, D21
    FCVTAS  W4, S17
    FNMUL  H6, H16, H15
    FNEG  S21, S11
    FCVTPU  W27, S30
    FCVT  S15, D6
    FRINTA  S6, S30
    FCVTMU  X13, S4
    FCVTZS  X11, H13
    FCMPE  D20, D3
    FMUL  S11, S13, S19
    FCVTPS  W5, H28
    FNMADD  S17, S7, S13, S7
    FRINTM  D0, D10
    FADD  D16, D17, D31
    FMAXNM  S23, S16, S26
    FCVTPU  W14, D17
    SCVTF  S30, W4, #7
    FCVTMU  X11, S23
    FCMPE  S21, S21
    SCVTF  D21, X11
    FCVTZU  X18, D0, #44
    FCVTNU  W10, D30
    FCVTZU  X29, S6
    FMAX  H19, H21, H5
    FDIV  D31, D19, D11
    FCVTMU  W21, D31
    FNEG  S17, S27
    FMSUB  S11, S28, S23, S10
    FSQRT  D4, D11
    FMOV  S26, S11
    FCVTZS  X27, H30
    FMOV  D0, D31
    FMOV  X3, D25
    FRINTZ  H6, H0
    FNEG  H16, H9
    FRINTZ  H28, H20
    FCVTZS  W25, S1
    FCVTNU  X5, H3
    FMSUB  D27, D13, D25, D26
    FCVTZS  X25, S15, #23
    SCVTF  H11, W5
    FCVTPS  W21, D7
    FCVTNS  W12, H15
    FCVTAU  W12, D0
    FRINTP  H21, H11
    FCCMP  H10, H31, #0xf, VC
    FMINNM  D31, D3, D1
    FADD  D10, D2, D13
    FCVTNU  W23, S6
    FNMADD  S30, S10, S21, S27
    SCVTF  S1, W12
    FCVT  S21, D16
    FMADD  S7, S21, S28, S21
    FCVT  H2, D7
    FABS  H7, H2
    FCCMP  D31, D30, #0x3, LT
    FMINNM  D9, D7, D1
    FCVTAS  W13, S9
    FMOV  H21, #12.00000000
    FADD  H16, H21, H21
    FRINTZ  H0, H16
    FCVTZS  X20, D19, #16
    FCVTMU  W20, S16
    FCVTZU  X14, S0, #50
    FCVTZU  X27, D6, #17
    FSQRT  H7, H24
    FCVTNS  W20, D11
    FRINTM  S11, S15
    FADD  H28, H30, H18
    FCMPE  D22, D17
    UCVTF  D15, W27
    FCVTAS  X4, S18
    FNMUL  H6, H22, H10
    FRINTZ  D24, D9
    FCVTNS  X5, S4
    FCMP  H31, #0.0
    FCVTAU  W29, S26
    FCMPE  H27, #0.0
    FMOV  X5, H11
    FSUB  H19, H3, H24
    FNMUL  D24, D0, D19
    FABS  S22, S26
    FCVTNU  X28, S31
    FCVTZS  W3, S4, #26
    FCVTAU  W17, H10
    FMOV  H17, #-1.81250000
    FCVTMU  X17, H21
    FNMUL  S31, S10, S3
    FRINTM  S26, S29
    FRINTA  D29, D22
    UCVTF  D18, W5, #6
    FCCMP  S24, S6, #0x9, NE
    FCVTNU  W25, D29
    SUBS  X22, X22, #0x1
    B.NE  TSRTFloatAllOperation_label_13
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0xc, LSL #0
    SUB  X15, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0xffff, LSL #0
    MOVK  X16, #0xffff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0x7fff, LSL #48
    SUB  X15, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X15, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x1f, LSL #0
    MRS  X15, FPSR
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x4e00, LSL #0
    FMOV  X15, D0
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D1
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D2
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D3
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D4
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D5
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X15, D6
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D7
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X15, D8
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    FMOV  X15, D10
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D11
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x7bff, LSL #0
    FMOV  X15, D12
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    FMOV  X15, D13
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x3f80, LSL #16
    FMOV  X15, D14
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D15
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x4e00, LSL #0
    FMOV  X15, D16
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0xbf40, LSL #0
    FMOV  X15, D17
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D18
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D19
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D20
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x4a00, LSL #0
    FMOV  X15, D21
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D22
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D23
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    FMOV  X15, D24
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D25
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4080, LSL #16
    FMOV  X15, D26
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    FMOV  X15, D27
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, D29
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    FMOV  X15, D30
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    FMOV  X15, D31
    SUB  X6, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
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
    FMOV  D0, X22
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X5
    FMOV  V3.D[1], X29
    FMOV  D4, X6
    FMOV  V4.D[1], X3
    FMOV  D5, X16
    FMOV  V5.D[1], X28
    FMOV  D6, X28
    FMOV  V6.D[1], X4
    FMOV  D7, X10
    FMOV  V7.D[1], X13
    FMOV  D8, X17
    FMOV  V8.D[1], X26
    FMOV  D9, X23
    FMOV  V9.D[1], X13
    FMOV  D10, X4
    FMOV  V10.D[1], X16
    FMOV  D11, X13
    FMOV  V11.D[1], X23
    FMOV  D12, X15
    FMOV  V12.D[1], X4
    FMOV  D13, X28
    FMOV  V13.D[1], X29
    FMOV  D14, X14
    FMOV  V14.D[1], X27
    FMOV  D15, X22
    FMOV  V15.D[1], X10
    FMOV  D16, X22
    FMOV  V16.D[1], X25
    FMOV  D17, X28
    FMOV  V17.D[1], X17
    FMOV  D18, X27
    FMOV  V18.D[1], X28
    FMOV  D19, X16
    FMOV  V19.D[1], X25
    FMOV  D20, X18
    FMOV  V20.D[1], X3
    FMOV  D21, X11
    FMOV  V21.D[1], X13
    FMOV  D22, X4
    FMOV  V22.D[1], X14
    FMOV  D23, X5
    FMOV  V23.D[1], X5
    FMOV  D24, X10
    FMOV  V24.D[1], X4
    FMOV  D25, X3
    FMOV  V25.D[1], X11
    FMOV  D26, X10
    FMOV  V26.D[1], X17
    FMOV  D27, X23
    FMOV  V27.D[1], X13
    FMOV  D28, X24
    FMOV  V28.D[1], X7
    FMOV  D29, X25
    FMOV  V29.D[1], X6
    FMOV  D30, X21
    FMOV  V30.D[1], X6
    FMOV  D31, X6
    FMOV  V31.D[1], X13
    MOVZ  X13, #0xa, LSL #0
TSRTFloatAllOperation_label_14:
    FMADD  S15, S28, S23, S31
    FSUB  D8, D27, D29
    UCVTF  H4, W13, #7
    FABS  H3, H30
    FMOV  X21, D26
    FCCMP  H8, H15, #0x9, GE
    SCVTF  H13, X10
    FCVTZU  W17, H3, #32
    FCVTPS  X25, H13
    FMOV  S12, W27
    FNMUL  D26, D4, D12
    FCCMP  H26, H26, #0xe, MI
    FCVTZS  W23, S20, #29
    UCVTF  H21, W6
    FMIN  S12, S21, S21
    FCMP  H12, H12
    FMOV  D21, X7
    FDIV  S26, S21, S21
    FNMUL  D21, D26, D26
    FRINTN  D15, D5
    FNEG  D3, D29
    FMOV  S4, S5
    FMAX  H8, H12, H4
    FCVTAU  W7, D4
    FCVTZU  X6, H14, #48
    FCVTAU  X27, H0
    FCVTMS  W17, H7
    FDIV  H12, H2, H17
    FMADD  D0, D3, D24, D19
    FRINTX  D14, D16
    FCCMP  H21, H23, #0xb, LE
    FRINTA  H26, H29
    FMIN  D7, D4, D18
    FCVTZS  W24, H10, #18
    FCVTZS  X26, H1, #25
    UCVTF  D2, X23, #33
    FCVTZU  W23, H23
    FCVTMS  W24, D3
    FCVTAU  X11, S7
    FCVTZS  W24, D19
    FCVTAU  X6, S0
    FCVT  S4, D21
    FCMPE  S17, S12
    UCVTF  S12, X11
    FCCMP  H29, H1, #0x1, EQ
    FCMP  D12, #0.0
    UCVTF  S18, X6, #30
    FCSEL  H29, H11, H5, EQ
    FCVTZU  X17, H22
    FMUL  H0, H21, H2
    FCVT  D11, S16
    FMADD  H22, H29, H14, H11
    FCSEL  H11, H0, H4, EQ
    FRINTI  S19, S18
    FRINTI  H1, H11
    FNMSUB  D23, D22, D22, D1
    SCVTF  D17, W23, #17
    FMOV  X18, H17
    FMOV  W10, S23
    FCVTPS  X11, H19
    FMOV  S12, #-0.22656250
    FABS  D21, D0
    FCVTPS  W18, H27
    FMADD  D4, D30, D0, D9
    FCVTZU  W23, H17
    FCCMPE  H9, H30, #0x2, LS
    FCVTPS  W21, D6
    UCVTF  D19, X10
    SCVTF  D1, X18, #6
    FMAX  H23, H28, H18
    FMOV  D11, D4
    FRINTP  S9, S19
    FMOV  X7, H5
    FCVTZU  W5, S12, #11
    FMAXNM  H5, H6, H27
    FNEG  D17, D2
    FMAXNM  D19, D7, D22
    FCSEL  S12, S5, S6, CC
    FRINTN  S0, S26
    FCVTZU  X28, S23
    FCVTZS  X26, D11
    FRINTA  H27, H11
    FCSEL  H6, H1, H9, LE
    SCVTF  S18, X28, #55
    SCVTF  S22, W23, #12
    UCVTF  H1, X26, #49
    FMADD  H4, H21, H1, H0
    FMOV  X21, H19
    FCVTZS  X17, H22, #56
    FCVTMS  X26, S17
    FCVTMS  W12, H12
    FCVTAS  W12, S4
    FCVTNU  X21, H27
    FMAXNM  H23, H18, H18
    FMADD  H2, H6, H6, H6
    FMOV  D6, #1.68750000
    FCVTNS  X17, H2
    FADD  D4, D23, D6
    FCMPE  H2, H20
    FCVTZU  X6, S20, #37
    FCVT  S2, D7
    FNMSUB  S19, S3, S8, S17
    FCVTZU  X5, D17, #16
    FSUB  H0, H9, H5
    SCVTF  H23, X12
    FMOV  D3, D15
    FCCMPE  D17, D17, #0xd, LS
    SCVTF  D22, X6
    FCVTZS  W28, S8, #9
    FCMPE  S3, S8
    FCVTNS  W6, D23
    FCVTAS  W18, D22
    FABS  D1, D23
    FCVTNS  X17, D6
    SCVTF  H20, W17, #28
    FCVTZS  W15, S4
    FCVTZU  X24, S9
    FCVTNU  W7, H17
    FRINTA  H22, H10
    FCVTAU  W15, D6
    FCVT  D15, H24
    FNMADD  H24, H31, H19, H0
    FNMSUB  D9, D29, D10, D28
    FADD  S18, S27, S24
    FDIV  S4, S5, S12
    FRINTI  D3, D29
    FNMADD  D19, D15, D2, D1
    FCVTNS  W5, H4
    FMOV  H8, H9
    FCVTMU  W26, H20
    FCVTMS  W4, H11
    FRINTZ  S17, S25
    FRINTX  H23, H3
    FCVTPS  X20, D17
    FCVTAU  X25, H22
    FNMADD  D6, D23, D23, D18
    UCVTF  S4, W5
    FCVTPU  W27, H19
    FRINTP  H24, H26
    UCVTF  H2, W24, #19
    FCVTMU  W10, S4
    FCVTZS  W18, S8
    FNMUL  H0, H2, H2
    FCVTZS  W12, H6
    FCVTNS  W14, S0
    UCVTF  H4, X12, #44
    FRINTM  S31, S24
    FCVTPS  W27, S16
    FCVT  S0, H17
    SCVTF  D3, W14, #3
    FRINTN  S24, S15
    FMOV  S6, #-4.50000000
    FMOV  S19, S20
    FCVTNS  X11, D0
    FCVTAS  X27, H7
    FCVTZS  X27, S31, #22
    FRINTZ  H2, H14
    FRINTP  S14, S8
    FCVTPS  W21, D0
    FMUL  H8, H15, H8
    UCVTF  S15, W11
    FMUL  D26, D3, D8
    SCVTF  S0, W18, #4
    FCVTZU  W5, S2, #11
    FMIN  D18, D14, D26
    FMOV  S17, #-6.00000000
    FCVTNS  X24, S0
    FCVTNU  W21, D19
    FCVT  D0, H15
    FCVTNS  W4, H24
    FCVTZU  X25, H17, #64
    FCVTZU  X11, D0, #64
    SCVTF  S15, W27
    FCMP  H15, #0.0
    FCVTPU  W22, S18
    UCVTF  H31, W7, #9
    FMAX  S0, S31, S31
    FMAX  H3, H0, H6
    FABS  H31, H14
    FMADD  D19, D28, D29, D4
    SCVTF  H24, X22
    FMOV  S28, W21
    FMOV  W17, H17
    FCVTZU  X23, H22, #56
    UCVTF  D15, X17
    FSQRT  D0, D10
    FCVTAU  W10, D29
    FCVTZU  W21, H3, #25
    UCVTF  H4, X23, #63
    FCVTAS  X27, D11
    FCVTZU  X24, H0, #33
    FMOV  S3, #1.56250000
    FMOV  D0, #-7.50000000
    FCVTNU  W23, S21
    FCVTAU  W22, S18
    FMINNM  D22, D23, D18
    FCVTNS  X21, H22
    FCVTZU  X7, D28
    FRINTA  H14, H3
    FNMSUB  S28, S14, S14, S24
    FMIN  H24, H0, H28
    FCVTPU  X26, H24
    FNMUL  S10, S4, S15
    FCVTAU  W28, S10
    FRINTI  S6, S9
    SCVTF  S17, X28, #39
    FMAX  S20, S6, S6
    FRINTZ  D6, D20
    FMOV  H20, X26
    FCVTAS  X4, S17
    FCVTZU  W18, S6
    FCVTZS  W12, S24, #20
    FCVT  D0, H29
    FCVTNS  W7, S9
    FCVTMU  X27, H28
    FCVT  S11, D4
    FMIN  D10, D7, D1
    FMUL  S17, S10, S10
    FCVTZS  X10, D0
    FCVTZU  W11, S6
    FMSUB  S24, S29, S20, S13
    SCVTF  S15, W11
    UCVTF  S9, W4, #27
    FSUB  H7, H15, H30
    FCVTPU  X4, S13
    FCMP  S0, #0.0
    FMOV  H15, #-12.00000000
    FRINTZ  D1, D4
    FCVT  H20, S25
    FMAXNM  S25, S20, S3
    FCVTMU  W5, D18
    FCVTZS  X7, H14
    FCMPE  D31, D24
    FCVTPS  W20, H15
    FCVTMS  X14, D28
    FCVTZU  X15, S19
    FCVTPU  W20, S21
    FCVT  S18, D8
    FRINTP  D31, D23
    UCVTF  S23, X14, #22
    FMAX  D30, D18, D11
    FCVTZU  X15, H31
    FCVTMU  W7, D17
    FCVTAU  X10, H9
    FCVTZU  W4, D7, #22
    SCVTF  H15, W23
    FMOV  H14, H30
    FCVT  H28, D15
    FCVTPS  W24, H23
    FRINTA  D8, D14
    FCVTPS  X26, H8
    FMOV  D19, D28
    FADD  S7, S19, S19
    FCVTNU  X26, S7
    FCVTZU  X10, D18
    FDIV  D21, D20, D9
    FADD  H20, H21, H21
    FCVTZS  X17, D20
    FCVT  D19, H13
    FRINTZ  S28, S19
    UCVTF  D17, X5, #30
    FCVTNS  X6, S28
    FADD  S30, S26, S9
    FCVTZS  X18, D9
    FCVTAS  W22, S10
    UCVTF  H31, W6, #26
    FCVTNU  W22, D12
    FSUB  D15, D1, D27
    FMIN  D27, D5, D22
    UCVTF  S14, W4, #27
    FMSUB  S7, S31, S27, S17
    FCVTPS  X7, S0
    FCVTAS  X14, S24
    FCVT  D17, S10
    FCSEL  D5, D7, D29, CC
    FMUL  H23, H5, H17
    FCVTNS  W21, S25
    FCMP  D8, #0.0
    FCCMPE  D4, D24, #0xc, LE
    FRINTA  H7, H3
    FRINTZ  D3, D28
    FMADD  H28, H23, H30, H1
    FMAX  D27, D15, D12
    FCVTZU  W17, D22
    FCVTZS  X15, S9
    FCVTMS  X18, D8
    FMOV  H15, H25
    FCVTZS  W25, D9
    UCVTF  H12, W17, #12
    UCVTF  S23, W15, #18
    FCVTPU  X21, D31
    FCVTZU  X23, H1, #18
    FMUL  H26, H16, H7
    FCVTNS  X21, H20
    FCSEL  S4, S22, S24, PL
    FCVT  S30, H12
    FCVTZS  W18, H26
    FCVTAU  X10, H4
    FNEG  H12, H15
    FRINTA  S15, S28
    SUBS  X13, X13, #0x1
    B.NE  TSRTFloatAllOperation_label_14
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X29, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x1f, LSL #0
    MRS  X29, FPSR
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D0
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D1
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D2
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D3
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D4
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D5
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D6
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D7
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D8
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D9
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D10
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D11
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x8000, LSL #0
    FMOV  X29, D12
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D13
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D14
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D15
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    FMOV  X29, V16.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    FMOV  X29, D16
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D17
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D18
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D19
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D20
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7ff0, LSL #48
    FMOV  X29, D21
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D22
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D23
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D24
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x3fc8, LSL #16
    FMOV  X29, D25
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    FMOV  X29, D26
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D27
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D28
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D29
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D30
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X29, D31
    SUB  X16, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0xf552, LSL #0
    MOVK  X3, #0x27cd, LSL #16
    MOVK  X3, #0xb819, LSL #32
    MOVK  X3, #0x412f, LSL #48
    MOVZ  X4, #0x97, LSL #0
    MOVK  X4, #0x47dd, LSL #16
    MOVK  X4, #0x8026, LSL #32
    MOVK  X4, #0xc96d, LSL #48
    MOVZ  X5, #0xd296, LSL #0
    MOVK  X5, #0xcf41, LSL #16
    MOVK  X5, #0x318b, LSL #32
    MOVK  X5, #0xa5bf, LSL #48
    MOVZ  X6, #0x8aca, LSL #0
    MOVK  X6, #0xa4e5, LSL #16
    MOVK  X6, #0xd256, LSL #32
    MOVK  X6, #0x87dd, LSL #48
    MOVZ  X7, #0x559c, LSL #0
    MOVK  X7, #0xad2c, LSL #16
    MOVK  X7, #0x5776, LSL #32
    MOVK  X7, #0xdd4b, LSL #48
    MOVZ  X10, #0xfd47, LSL #0
    MOVK  X10, #0xd9e0, LSL #16
    MOVK  X10, #0xfe02, LSL #32
    MOVK  X10, #0x466d, LSL #48
    MOVZ  X11, #0x36ae, LSL #0
    MOVK  X11, #0xce07, LSL #16
    MOVK  X11, #0x8811, LSL #32
    MOVK  X11, #0xc679, LSL #48
    MOVZ  X12, #0xdae4, LSL #0
    MOVK  X12, #0x82f2, LSL #16
    MOVK  X12, #0xcda9, LSL #32
    MOVK  X12, #0xb8aa, LSL #48
    MOVZ  X13, #0x95ed, LSL #0
    MOVK  X13, #0xc0d8, LSL #16
    MOVK  X13, #0xb7f6, LSL #32
    MOVK  X13, #0x2d05, LSL #48
    MOVZ  X14, #0xb9c7, LSL #0
    MOVK  X14, #0x19b2, LSL #16
    MOVK  X14, #0x828, LSL #32
    MOVK  X14, #0xcc9d, LSL #48
    MOVZ  X15, #0xbc0e, LSL #0
    MOVK  X15, #0xbe82, LSL #16
    MOVK  X15, #0x90e0, LSL #32
    MOVK  X15, #0x7bdf, LSL #48
    MOVZ  X16, #0x9eae, LSL #0
    MOVK  X16, #0x69ce, LSL #16
    MOVK  X16, #0x673d, LSL #32
    MOVK  X16, #0xad7a, LSL #48
    MOVZ  X17, #0x2802, LSL #0
    MOVK  X17, #0x210a, LSL #16
    MOVK  X17, #0xe6fa, LSL #32
    MOVK  X17, #0x590b, LSL #48
    MOVZ  X18, #0xd44f, LSL #0
    MOVK  X18, #0x3cce, LSL #16
    MOVK  X18, #0x22c4, LSL #32
    MOVK  X18, #0x48b7, LSL #48
    MOVZ  X20, #0x5d63, LSL #0
    MOVK  X20, #0x8a9f, LSL #16
    MOVK  X20, #0x5561, LSL #32
    MOVK  X20, #0x46f9, LSL #48
    MOVZ  X21, #0xa478, LSL #0
    MOVK  X21, #0xd526, LSL #16
    MOVK  X21, #0x96fb, LSL #32
    MOVK  X21, #0x4286, LSL #48
    MOVZ  X22, #0x110, LSL #0
    MOVK  X22, #0x4a75, LSL #16
    MOVK  X22, #0xf577, LSL #32
    MOVK  X22, #0xf155, LSL #48
    MOVZ  X23, #0x66d4, LSL #0
    MOVK  X23, #0x3c04, LSL #16
    MOVK  X23, #0xaeec, LSL #32
    MOVK  X23, #0x688b, LSL #48
    MOVZ  X24, #0xca74, LSL #0
    MOVK  X24, #0x4e57, LSL #16
    MOVK  X24, #0x7ec3, LSL #32
    MOVK  X24, #0x3ed, LSL #48
    MOVZ  X25, #0x639d, LSL #0
    MOVK  X25, #0x288a, LSL #16
    MOVK  X25, #0x80a0, LSL #32
    MOVK  X25, #0x7d79, LSL #48
    MOVZ  X26, #0xc26b, LSL #0
    MOVK  X26, #0x943a, LSL #16
    MOVK  X26, #0x70c0, LSL #32
    MOVK  X26, #0x1bdb, LSL #48
    MOVZ  X27, #0x4845, LSL #0
    MOVK  X27, #0x6bb9, LSL #16
    MOVK  X27, #0x8d7d, LSL #32
    MOVK  X27, #0xe425, LSL #48
    MOVZ  X28, #0xf95d, LSL #0
    MOVK  X28, #0xeab9, LSL #16
    MOVK  X28, #0xc689, LSL #32
    MOVK  X28, #0xa206, LSL #48
    MOVZ  X29, #0xf5bc, LSL #0
    MOVK  X29, #0x4813, LSL #16
    MOVK  X29, #0x73ab, LSL #32
    MOVK  X29, #0x5dfe, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X14
    FMOV  V3.D[1], X26
    FMOV  D4, X24
    FMOV  V4.D[1], X27
    FMOV  D5, X28
    FMOV  V5.D[1], X6
    FMOV  D6, X11
    FMOV  V6.D[1], X14
    FMOV  D7, X27
    FMOV  V7.D[1], X22
    FMOV  D8, X20
    FMOV  V8.D[1], X21
    FMOV  D9, X11
    FMOV  V9.D[1], X5
    FMOV  D10, X18
    FMOV  V10.D[1], X7
    FMOV  D11, X5
    FMOV  V11.D[1], X23
    FMOV  D12, X12
    FMOV  V12.D[1], X16
    FMOV  D13, X24
    FMOV  V13.D[1], X7
    FMOV  D14, X20
    FMOV  V14.D[1], X14
    FMOV  D15, X25
    FMOV  V15.D[1], X18
    FMOV  D16, X23
    FMOV  V16.D[1], X14
    FMOV  D17, X14
    FMOV  V17.D[1], X4
    FMOV  D18, X25
    FMOV  V18.D[1], X18
    FMOV  D19, X26
    FMOV  V19.D[1], X7
    FMOV  D20, X14
    FMOV  V20.D[1], X16
    FMOV  D21, X24
    FMOV  V21.D[1], X22
    FMOV  D22, X27
    FMOV  V22.D[1], X22
    FMOV  D23, X3
    FMOV  V23.D[1], X24
    FMOV  D24, X28
    FMOV  V24.D[1], X18
    FMOV  D25, X29
    FMOV  V25.D[1], X12
    FMOV  D26, X15
    FMOV  V26.D[1], X23
    FMOV  D27, X4
    FMOV  V27.D[1], X5
    FMOV  D28, X29
    FMOV  V28.D[1], X26
    FMOV  D29, X12
    FMOV  V29.D[1], X16
    FMOV  D30, X7
    FMOV  V30.D[1], X7
    FMOV  D31, X22
    FMOV  V31.D[1], X22
    MOVZ  X5, #0xa, LSL #0
TSRTFloatAllOperation_label_15:
    FCCMP  S27, S27, #0x1, EQ
    FMADD  S16, S20, S22, S20
    FCVTMU  X7, H30
    FCMP  H19, H24
    FCMP  H29, H29
    FCVTMU  W15, H28
    FCVTMS  X28, S25
    SCVTF  H13, W21
    UCVTF  D22, X6, #12
    FMINNM  H18, H23, H31
    FCVTMU  W6, D13
    FCVT  S22, H22
    FCVTZS  W26, H26
    FCVTZS  X4, H22, #48
    FCVTMS  X21, S16
    FNEG  H24, H7
    FCVTMS  W22, H17
    FCVTZS  W12, S20, #32
    SCVTF  H26, X22
    FRINTA  D13, D8
    FCVTZU  W22, S27, #32
    FMAXNM  S17, S0, S22
    FMAX  S23, S3, S20
    FMOV  H7, X12
    FMADD  H20, H18, H0, H12
    UCVTF  H16, X26, #45
    FCVTNU  X3, S8
    FCVTNS  W7, S8
    FMIN  S31, S10, S15
    FRINTX  S25, S16
    UCVTF  H15, X3
    FMSUB  H30, H29, H26, H17
    FSQRT  S12, S20
    FDIV  S26, S15, S24
    UCVTF  S3, W7
    UCVTF  S28, X22, #30
    FMINNM  S26, S28, S28
    FCVTNS  W27, D26
    FNMSUB  D28, D25, D25, D7
    FMOV  S24, #1.25000000
    FCMPE  S30, S12
    FMOV  D26, #-0.12500000
    FMAX  H30, H31, H24
    FCVTAS  X3, D28
    FCVTNU  W7, D3
    FCMPE  S30, #0.0
    FMIN  D30, D26, D23
    FMOV  S15, S30
    FCMPE  D15, D15
    FCMPE  S12, #0.0
    FCVTAU  X15, D28
    FMOV  H31, H21
    FMAX  H26, H10, H0
    FCVTNS  X26, H31
    FCVTZS  W26, D18
    FADD  H15, H19, H2
    FCVTPS  X16, D2
    FRINTN  H18, H24
    FCVTZU  W26, D6, #13
    FMIN  H6, H15, H5
    FCVTZS  W26, S30, #12
    FCVTMU  X17, D16
    FMOV  H10, X7
    FCVTAS  X21, S27
    FCVTZU  W24, S23
    FMOV  S24, W16
    FCVTZS  X10, D0
    FNEG  D16, D14
    FCVTZU  X24, S4
    FCVTMU  X6, S1
    FCCMPE  S2, S20, #0xd, LT
    FDIV  H3, H13, H4
    FMAX  D5, D26, D10
    FCMPE  S19, #0.0
    SCVTF  H0, X24, #43
    FRINTZ  H15, H16
    FCVT  S4, D2
    FCVTZU  W22, S16
    FMSUB  H23, H11, H25, H4
    FCVTZS  X7, S23, #46
    FCVTZU  X27, S19, #20
    FCVT  S19, H14
    SCVTF  D31, X6, #12
    FRINTI  D2, D18
    FCCMP  D3, D6, #0xc, AL
    FRINTZ  D6, D19
    FCVTMU  W18, S2
    FSUB  S16, S6, S6
    FCVTNU  X21, S15
    FCVTNU  W20, D0
    FRINTI  S23, S5
    FNEG  S1, S23
    FCVT  D26, H31
    SCVTF  S5, W20, #12
    UCVTF  D14, X7, #35
    FCVTPU  W25, S1
    FMAX  D1, D5, D29
    FCCMPE  H14, H1, #0xd, MI
    FCVTPS  X27, S16
    FRINTM  S25, S22
    FCVT  H29, S8
    FCVT  H18, D7
    FCVTPS  W21, H22
    FRINTX  D31, D19
    FABS  D5, D18
    FMUL  D0, D0, D15
    FMOV  D6, #2.50000000
    FCVTZS  W18, H2, #2
    FCVTAS  W6, D6
    FCMPE  H17, #0.0
    FRINTA  D17, D5
    FCVTAS  X4, H11
    UCVTF  D14, X4, #14
    SCVTF  S23, X25
    SCVTF  D22, X21, #41
    FCCMPE  D17, D0, #0xe, VS
    FCVTPS  W13, D14
    FRINTN  S6, S29
    FCVTPU  X26, H25
    FMOV  W27, S31
    FCVTMS  W20, H6
    FCVTZU  W13, D22, #15
    FCVTAU  W12, S23
    FCVTNU  X3, D1
    FCMPE  S8, #0.0
    FCVTNS  X29, D10
    FCVTPU  W26, H18
    FSUB  S14, S4, S28
    FSQRT  D4, D0
    FCVTPS  W12, D19
    FCCMP  H5, H14, #0x1, GE
    FMOV  D10, #-0.68750000
    FCVTPU  W18, H23
    FCVTZS  W10, H13, #8
    UCVTF  H2, W10
    FMOV  D22, #0.39062500
    FCVTMU  W15, H22
    FCVTZS  X24, S15
    FCVTZS  W6, D22, #5
    FRINTN  D29, D8
    FCMP  D21, D27
    SCVTF  H28, W29
    FCCMP  D16, D17, #0xf, GE
    FMOV  S14, S15
    FMAX  D5, D10, D21
    FRINTZ  H17, H12
    FRINTN  D18, D3
    FMIN  S22, S12, S7
    FRINTN  D8, D18
    UCVTF  H27, W18
    FCMPE  D14, #0.0
    FCMPE  D4, D2
    FMSUB  H12, H28, H29, H27
    FADD  H13, H22, H12
    FMUL  D27, D8, D17
    FCVTPU  X6, S13
    FCVTPS  X20, S27
    FCVTZS  W3, S19
    FMAX  H15, H7, H10
    FCVTMS  X27, D16
    FRINTZ  S21, S23
    FCVTNS  X27, D27
    FCVTNS  X28, S5
    FCMPE  D18, D5
    FCVTAS  W18, S10
    SCVTF  S7, W28
    FRINTA  H2, H20
    FSUB  D18, D14, D9
    FCVTAS  X24, D26
    FRINTN  S4, S5
    SCVTF  H16, W25
    FSQRT  H19, H8
    FMOV  H10, W18
    FCSEL  D9, D7, D16, AL
    SCVTF  S13, X6, #48
    FCVTAS  X6, H9
    FRINTZ  D23, D4
    SCVTF  H14, X27
    FADD  D27, D14, D2
    FCVTPU  W24, H10
    FRINTM  S20, S19
    FDIV  H9, H21, H13
    FRINTZ  D14, D18
    FCSEL  S18, S23, S27, LS
    FRINTN  D23, D15
    FRINTP  H7, H20
    FMOV  H19, X24
    FCVTMU  X13, H23
    FCCMPE  D9, D14, #0x3, CC
    FRINTN  S21, S18
    FNMADD  D8, D19, D7, D7
    FADD  S18, S21, S8
    FCMP  S15, #0.0
    FCVTAU  X17, H0
    FCVTMS  W7, H13
    FCVTAU  X6, D26
    FABS  D8, D10
    FCVTMU  X16, S26
    FMUL  H4, H18, H28
    FRINTI  D0, D14
    FCVTAU  W16, H4
    UCVTF  H16, W6
    FMOV  W20, H10
    FSUB  S9, S27, S10
    FCVTNS  X15, H8
    UCVTF  H20, X13, #12
    FCVT  S2, H18
    FCMP  H20, H26
    FCVTZS  X18, H6, #56
    FMOV  S27, S29
    FCVTPU  W17, H6
    FCVTMS  W12, S13
    FADD  H8, H27, H20
    FRINTP  S28, S3
    FMOV  S13, #-0.53125000
    FCVTMS  X16, D13
    FNEG  H3, H27
    FNMSUB  D10, D3, D26, D17
    FMADD  H13, H0, H19, H22
    FCVTNU  X27, D21
    UCVTF  H14, X17, #40
    FMOV  S26, #-0.15625000
    FSQRT  D0, D28
    FMADD  D4, D8, D0, D16
    FCVTAS  W20, H10
    FADD  D0, D2, D2
    FMIN  D18, D14, D14
    FCVTMU  X15, H18
    FCVTZS  W25, D9, #10
    FCVTNS  X17, S26
    FDIV  S26, S0, S13
    FCSEL  D6, D4, D4, AL
    FCVTMS  X6, H26
    FCVTNU  X26, S6
    FMIN  S2, S16, S24
    FMAXNM  S29, S29, S15
    FRINTM  D20, D18
    FMIN  S17, S4, S22
    SCVTF  H21, X17, #37
    FCVTMS  X15, S25
    FRINTA  H10, H12
    FCMPE  D26, D23
    UCVTF  H25, X25, #40
    FCVTPU  X25, D20
    FCMP  D19, D2
    FCVTZU  W3, D30, #1
    FCVTNS  X25, S9
    FCCMPE  H23, H20, #0x3, GT
    FCSEL  D23, D4, D15, VC
    FCCMPE  D25, D22, #0x0, MI
    FCVTAS  W29, H21
    UCVTF  D30, X26, #26
    FSUB  S4, S26, S15
    FMOV  H12, #-0.14062500
    FCVT  S18, D17
    SCVTF  S21, W3, #15
    FCMPE  S21, #0.0
    FCVTNU  W17, D11
    FMUL  S0, S27, S19
    FCVT  S17, D20
    FCVTZS  X13, S17
    UCVTF  S16, W25
    FCVTZU  W6, S16
    FMINNM  S26, S0, S23
    FCVTNU  X7, H26
    SCVTF  S22, W13
    FRINTZ  S26, S18
    FSQRT  H27, H22
    SCVTF  S2, X17
    FMUL  S18, S2, S26
    FMOV  W12, H27
    FNMSUB  H27, H18, H18, H30
    FCVTZS  W15, D27
    SCVTF  S22, W6, #15
    SCVTF  D16, W12, #12
    FCVTNS  W3, S22
    FMOV  X27, H16
    SCVTF  H18, W7, #15
    FNMADD  S22, S18, S18, S18
    FRINTZ  D23, D22
    FCVTZS  W18, D23
    FNMSUB  S16, S10, S7, S25
    FCVTZU  X18, D16, #21
    FNEG  D0, D2
    FCVTZU  X28, S0, #3
    FCVTNU  X25, S24
    FCCMP  S17, S23, #0x4, MI
    FRINTN  H20, H11
    FRINTN  D23, D5
    FCVTZS  X4, D16
    FCVTZU  X16, D23, #59
    FCCMP  H14, H29, #0xc, LE
    FCVTZU  W24, S3
    SCVTF  D27, X27
    FCVTZU  W24, H26
    UCVTF  H0, W3
    FRINTZ  S11, S15
    FMOV  S2, #0.17187500
    FNMADD  S15, S11, S17, S24
    FSUB  S26, S22, S18
    SUBS  X5, X5, #0x1
    B.NE  TSRTFloatAllOperation_label_15
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x19, LSL #0
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X23, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x1f, LSL #0
    MRS  X23, FPSR
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V0.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D0
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V1.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D1
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3e30, LSL #16
    FMOV  X23, D2
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V3.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x8000, LSL #0
    FMOV  X23, D3
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x7fc0, LSL #16
    FMOV  X23, D4
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D5
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D6
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V7.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D7
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D8
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x8000, LSL #0
    FMOV  X23, D9
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D10
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V11.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D11
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V12.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0xb080, LSL #0
    FMOV  X23, D12
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V13.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D13
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D14
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x1, LSL #0
    MOVK  X14, #0x8000, LSL #16
    FMOV  X23, D15
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D16
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V17.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D17
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V18.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D18
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D19
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V20.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D20
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V21.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D21
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    FMOV  X23, D22
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D23
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V24.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x1, LSL #0
    FMOV  X23, D24
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D25
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    FMOV  X23, D26
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D27
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V28.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x3f80, LSL #16
    FMOV  X23, D28
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D29
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D30
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D31
    SUB  X11, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    FMOV  V0.D[1], X25
    FMOV  D1, X4
    FMOV  V1.D[1], X12
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X23
    FMOV  V3.D[1], X26
    FMOV  D4, X28
    FMOV  V4.D[1], X20
    FMOV  D5, X24
    FMOV  V5.D[1], X22
    FMOV  D6, X29
    FMOV  V6.D[1], X21
    FMOV  D7, X10
    FMOV  V7.D[1], X10
    FMOV  D8, X4
    FMOV  V8.D[1], X18
    FMOV  D9, X13
    FMOV  V9.D[1], X6
    FMOV  D10, X4
    FMOV  V10.D[1], X17
    FMOV  D11, X23
    FMOV  V11.D[1], X27
    FMOV  D12, X24
    FMOV  V12.D[1], X16
    FMOV  D13, X16
    FMOV  V13.D[1], X6
    FMOV  D14, X4
    FMOV  V14.D[1], X18
    FMOV  D15, X25
    FMOV  V15.D[1], X11
    FMOV  D16, X28
    FMOV  V16.D[1], X24
    FMOV  D17, X16
    FMOV  V17.D[1], X6
    FMOV  D18, X3
    FMOV  V18.D[1], X29
    FMOV  D19, X15
    FMOV  V19.D[1], X24
    FMOV  D20, X7
    FMOV  V20.D[1], X3
    FMOV  D21, X21
    FMOV  V21.D[1], X11
    FMOV  D22, X27
    FMOV  V22.D[1], X5
    FMOV  D23, X14
    FMOV  V23.D[1], X16
    FMOV  D24, X26
    FMOV  V24.D[1], X15
    FMOV  D25, X14
    FMOV  V25.D[1], X28
    FMOV  D26, X14
    FMOV  V26.D[1], X11
    FMOV  D27, X5
    FMOV  V27.D[1], X6
    FMOV  D28, X15
    FMOV  V28.D[1], X22
    FMOV  D29, X11
    FMOV  V29.D[1], X11
    FMOV  D30, X15
    FMOV  V30.D[1], X15
    FMOV  D31, X17
    FMOV  V31.D[1], X21
    MOVZ  X18, #0xa, LSL #0
TSRTFloatAllOperation_label_16:
    FCVTZS  X11, H26, #57
    FMAXNM  S13, S19, S24
    FCVTZU  X26, D28, #30
    FCVTMU  W27, S22
    FDIV  S28, S25, S30
    FRINTI  D16, D28
    FCVTZU  W11, H23, #6
    FMOV  W21, S27
    FCVTPS  X17, D13
    FNMADD  H30, H29, H16, H29
    FCMP  H30, #0.0
    FMOV  S14, W28
    FCMP  S5, #0.0
    FCVTPS  W14, S14
    UCVTF  H10, X27, #33
    FRINTN  D17, D18
    FMINNM  H24, H29, H16
    FMOV  H25, W21
    FCCMPE  S0, S25, #0xa, MI
    FRINTN  S18, S16
    FCVTAU  X28, S16
    FCVTZS  X27, D31, #29
    FDIV  S5, S9, S17
    FCMPE  H19, #0.0
    FCMPE  H16, #0.0
    FCVTAU  W15, D25
    FCVT  H27, D24
    FCVTPU  X24, H2
    FCMPE  S3, #0.0
    FCVT  H30, S7
    FCVTMS  X26, S30
    FCSEL  D16, D0, D28, NV
    FCVTPU  W23, S15
    FCVTAU  W5, H1
    FSUB  S29, S25, S10
    FCVTZU  W10, H6
    FABS  D9, D13
    FMINNM  S7, S10, S22
    UCVTF  H24, W26, #24
    FCVTZU  W6, D9
    SCVTF  D1, X14
    FCVTNU  X16, H23
    FRINTP  D23, D2
    FMSUB  S17, S16, S1, S7
    FCVTZU  X6, H29
    FCVTAU  W27, S23
    FCCMP  S17, S24, #0x7, LT
    FCVTZS  X10, S14
    FNEG  D30, D7
    FCCMPE  D30, D30, #0xd, HI
    FCVTNS  X3, H29
    FCVTNS  X13, S8
    FCCMP  S5, S15, #0xa, PL
    FSQRT  H2, H4
    FCVTZS  X14, S13
    FRINTZ  H6, H26
    UCVTF  S3, W5
    FCVTAU  W13, D26
    UCVTF  H16, W6
    FCVTPU  W4, H13
    SCVTF  D0, X13, #64
    FSUB  H23, H7, H16
    FCVTAS  X15, S6
    FCMP  D11, #0.0
    FCCMPE  S2, S23, #0x2, CS
    FCVTMS  X3, S5
    FNMADD  S15, S30, S6, S17
    FCVT  D13, S17
    FCVTAS  W10, H6
    FCVTZS  W27, H0
    FCSEL  H16, H10, H17, GE
    SCVTF  D8, W4
    FCVTPU  X7, H11
    FCVTPS  X21, H6
    UCVTF  S7, X14, #26
    FCVTPS  W20, S13
    FMAX  D0, D19, D2
    FRINTZ  D29, D27
    FCVTAS  X17, S24
    FCVTNU  X25, S10
    FMUL  D5, D12, D17
    FMUL  H13, H16, H1
    FCVTZS  W15, D12
    FCVTMU  X23, H25
    FCVTPU  X5, D20
    FMAXNM  D24, D15, D25
    FCMPE  D17, #0.0
    FCVT  D23, S8
    FCVTMU  X23, S19
    FCVTZU  W27, S23
    FCVTAS  X17, H23
    UCVTF  H6, W15, #24
    FABS  H19, H21
    FRINTA  S16, S13
    FCVTMS  X13, H10
    SCVTF  H13, X13
    FMINNM  H20, H13, H7
    FCVTMU  W11, D6
    FCVTMS  W13, H20
    FNMSUB  H20, H5, H19, H16
    FMOV  H7, #-1.12500000
    SCVTF  H11, W13
    FCVTZU  W7, D11, #21
    UCVTF  H5, W7
    FNMSUB  D23, D29, D20, D20
    UCVTF  S20, X23, #44
    FCVTAU  W21, D23
    FCVTMU  X17, H20
    FMOV  H11, W17
    FSQRT  H13, H5
    FCVT  D5, H11
    FMAX  S11, S7, S5
    FCVTZS  W28, S11, #27
    FCCMPE  H13, H13, #0xb, HI
    FMOV  D21, X11
    FCVTZU  W6, D1
    FSQRT  S19, S19
    FRINTN  S29, S26
    FNMADD  D1, D23, D1, D12
    FNEG  D11, D12
    FCVTZS  X14, D28, #35
    FCVTNU  X5, D21
    FCVTAS  X7, H1
    FCVTPS  W11, S17
    FMOV  W28, S28
    FMOV  H21, H10
    FRINTP  H12, H10
    FMOV  W3, S25
    FCVTPS  W10, S12
    FRINTI  H17, H8
    FCVTZU  X16, H15
    SCVTF  S7, X6
    FCVT  D26, H6
    FMAXNM  S1, S31, S31
    FCVTZS  W20, D5
    FCVTNU  W7, H8
    FMOV  D25, #-4.00000000
    FRINTI  D20, D17
    SCVTF  H13, X7, #58
    FMOV  H28, H19
    FCVTNU  X26, H7
    FCVTPU  W24, S21
    FCVTZU  X20, H26
    FCVTPS  W7, D13
    FCVTNU  W27, H1
    FCVTZS  W6, S28, #6
    FCVTZS  X28, D20
    FCVTNU  X4, H25
    FCVTAU  W28, D27
    UCVTF  S19, X14, #26
    FCVTZU  X5, S19, #44
    FCVTZS  W17, D9, #25
    FRINTA  D5, D17
    FMIN  H12, H20, H4
    FCVTAU  W14, S21
    FCVTMU  X3, H0
    UCVTF  D0, X6, #23
    FCVTAS  X10, H26
    FMSUB  H7, H13, H27, H8
    FCVTAS  W24, S11
    FCCMP  S29, S24, #0x0, LS
    FRINTX  D1, D21
    FRINTZ  D26, D17
    UCVTF  D11, X7
    FCVTNS  X16, H22
    FCVTAU  X21, D3
    FCVTMU  X26, S22
    FNMADD  S13, S19, S29, S20
    FCVTZU  W10, H9, #18
    FCVTZU  W14, S4
    FCVTPS  X25, S28
    FMIN  H3, H8, H1
    FCVTPS  X4, D22
    FMAX  S8, S0, S15
    FCMP  H2, #0.0
    FCVTZS  W21, S26, #3
    FCVTZU  X16, D19
    FMOV  D2, X26
    FCVTAU  X16, H30
    FRINTN  S27, S7
    FCVTAS  W25, D12
    FDIV  H7, H7, H21
    FRINTN  S29, S18
    FCVTZU  W17, S27
    SCVTF  D24, X3
    FMSUB  S12, S7, S24, S13
    FMAXNM  S19, S3, S2
    FRINTA  S7, S8
    FCVTMS  W28, D29
    FNMADD  H9, H12, H12, H7
    UCVTF  H26, X28, #1
    FCVTZS  W7, H19
    FCVT  D19, H26
    FADD  S22, S19, S19
    FRINTX  D24, D27
    UCVTF  H27, W21
    FCMP  D9, #0.0
    FMIN  H19, H12, H22
    FNEG  D9, D19
    FCVTZU  W3, H27
    FRINTI  S8, S9
    FCCMPE  D8, D8, #0xc, NV
    FMOV  H22, #7.00000000
    FCVTAU  W3, D25
    UCVTF  D26, X17, #37
    FNMADD  H27, H7, H15, H21
    FRINTX  H12, H7
    FCMPE  S0, #0.0
    FDIV  D0, D12, D9
    FCVTPU  W17, H14
    FMOV  W15, H1
    FCVT  H3, S20
    FRINTZ  D15, D21
    FMOV  H21, #7.50000000
    FRINTP  S9, S12
    FCVTMS  X25, S22
    FMOV  S25, S24
    FRINTX  S24, S21
    FRINTP  S29, S15
    FMOV  H21, #-0.50000000
    FCVTZU  X4, S21
    FCVTMU  W3, D29
    FCVTZU  W5, S0
    FMAX  H29, H27, H27
    FADD  H14, H21, H25
    UCVTF  S15, X4
    FNEG  S21, S26
    FCVTPS  X26, D21
    FMAX  H1, H15, H3
    SCVTF  D0, X26, #23
    FCVT  D27, H0
    FMOV  H0, W5
    FCMPE  S24, S0
    FCVTPU  W27, H7
    FMOV  H20, H29
    FCMP  D9, #0.0
    FCVTZS  W17, S20, #27
    FNEG  D3, D14
    FMOV  S20, #15.00000000
    FCMP  H3, H27
    FCVTAS  W3, S1
    FMAXNM  D9, D21, D16
    FCVTNS  W14, D5
    SCVTF  D14, W14, #5
    FCSEL  H5, H8, H22, GE
    FCVTNS  X11, S21
    FRINTZ  D29, D24
    FCVTZU  W10, D23
    FCMPE  S29, #0.0
    SCVTF  D7, X3, #64
    FRINTN  S22, S28
    FCVTNS  X26, H2
    FRINTZ  S0, S9
    FCMPE  S4, #0.0
    FRINTA  D9, D11
    FCVTPS  W3, D13
    FCVTZS  X20, D29, #49
    FCVTNS  X6, S24
    FCVTZU  W6, D23, #8
    FMSUB  S16, S4, S5, S1
    FSUB  H28, H24, H4
    UCVTF  D4, W3, #32
    FCVTZU  W23, H16
    FDIV  S13, S0, S28
    FRINTM  D3, D7
    FRINTM  D21, D13
    FCVTAS  X25, D22
    FNMUL  S23, S3, S9
    FCMP  H14, H23
    FCVTAU  W26, H4
    FRINTP  D11, D21
    FCCMP  S15, S16, #0xe, LS
    FCSEL  S22, S22, S31, CC
    FCVTZS  X27, D30
    FMIN  S30, S28, S11
    FCVTZU  X26, D3
    FNMSUB  D2, D7, D29, D25
    FCVTPS  X26, H11
    SCVTF  D21, W25
    FCVTZU  W6, H27, #6
    FCCMPE  D8, D25, #0xe, CS
    UCVTF  D27, W20
    FSUB  S11, S26, S27
    UCVTF  S31, W6, #30
    FCCMPE  D15, D25, #0xa, GT
    FCMP  D19, D9
    FCVTMU  W25, D4
    FSQRT  D19, D17
    FCMP  S9, S8
    FCVTAU  X5, D8
    FMINNM  D28, D12, D9
    FCVTNS  X26, D14
    FMAX  S0, S22, S27
    FCMPE  H2, H17
    FMOV  X20, D25
    SCVTF  D9, W20
    FRINTN  D12, D10
    FCVTMU  W21, D21
    FCVTPU  W15, S9
    FCVTPS  X27, H0
    SUBS  X18, X18, #0x1
    B.NE  TSRTFloatAllOperation_label_16
    MOVZ  X29, #0x1, LSL #0
    SUB  X22, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X22, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x1f, LSL #0
    MRS  X22, FPSR
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D0
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V1.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D1
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D2
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D3
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x3df0, LSL #48
    FMOV  X22, D4
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x4700, LSL #0
    FMOV  X22, D5
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D6
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D7
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D8
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D9
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D10
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D11
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D12
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x7fc0, LSL #16
    FMOV  X22, D13
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V14.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D14
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D15
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D16
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D17
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D18
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D19
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x4170, LSL #16
    FMOV  X22, D20
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D21
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D22
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0x8000, LSL #16
    FMOV  X22, D23
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D24
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D25
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D26
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D27
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D28
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D29
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D30
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X22, D31
    SUB  X12, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTFloatAllOperation_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X24
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X15
    FMOV  D4, X15
    FMOV  V4.D[1], X10
    FMOV  D5, X13
    FMOV  V5.D[1], X22
    FMOV  D6, X25
    FMOV  V6.D[1], X27
    FMOV  D7, X24
    FMOV  V7.D[1], X28
    FMOV  D8, X16
    FMOV  V8.D[1], X14
    FMOV  D9, X11
    FMOV  V9.D[1], X6
    FMOV  D10, X18
    FMOV  V10.D[1], X15
    FMOV  D11, X21
    FMOV  V11.D[1], X26
    FMOV  D12, X21
    FMOV  V12.D[1], X6
    FMOV  D13, X20
    FMOV  V13.D[1], X11
    FMOV  D14, X14
    FMOV  V14.D[1], X4
    FMOV  D15, X11
    FMOV  V15.D[1], X4
    FMOV  D16, X5
    FMOV  V16.D[1], X5
    FMOV  D17, X21
    FMOV  V17.D[1], X21
    FMOV  D18, X15
    FMOV  V18.D[1], X12
    FMOV  D19, X26
    FMOV  V19.D[1], X7
    FMOV  D20, X11
    FMOV  V20.D[1], X21
    FMOV  D21, X3
    FMOV  V21.D[1], X24
    FMOV  D22, X29
    FMOV  V22.D[1], X23
    FMOV  D23, X18
    FMOV  V23.D[1], X6
    FMOV  D24, X11
    FMOV  V24.D[1], X12
    FMOV  D25, X17
    FMOV  V25.D[1], X6
    FMOV  D26, X11
    FMOV  V26.D[1], X3
    FMOV  D27, X17
    FMOV  V27.D[1], X6
    FMOV  D28, X7
    FMOV  V28.D[1], X16
    FMOV  D29, X20
    FMOV  V29.D[1], X15
    FMOV  D30, X20
    FMOV  V30.D[1], X13
    FMOV  D31, X12
    FMOV  V31.D[1], X6
    MOVZ  X13, #0xa, LSL #0
TSRTFloatAllOperation_label_17:
    FCVT  H7, S17
    FMADD  H21, H7, H30, H25
    FRINTA  D1, D31
    FMOV  S3, W21
    FCVTAS  W21, S3
    FCVTZU  X29, H1, #47
    FCMP  S28, #0.0
    FMOV  W20, H22
    FMINNM  H2, H29, H29
    FCVTAS  W18, H21
    FCVTMU  X16, S2
    FMAXNM  S14, S27, S1
    FCCMPE  D14, D14, #0x1, CC
    FCVTNS  X11, D15
    SCVTF  D30, X25, #56
    FNEG  S31, S30
    UCVTF  S25, W18, #18
    FMUL  D28, D31, D25
    FRINTP  H7, H28
    FCVTZU  W18, S7, #4
    FSUB  D3, D29, D18
    FCVTPS  W25, D13
    FCMPE  D22, #0.0
    SCVTF  D18, W6, #23
    FMOV  X6, H8
    FCVTZS  X12, S7
    FMINNM  H8, H9, H14
    FSUB  D15, D22, D15
    FNMUL  D1, D31, D10
    FMINNM  H14, H5, H29
    FMADD  S22, S25, S12, S27
    SCVTF  H27, X25, #57
    FCVTNU  W3, H24
    FCMP  H13, #0.0
    UCVTF  H2, W3
    FMOV  S12, S22
    FCVTAS  X28, H12
    FCMPE  H27, H1
    FCVTZU  X6, H3
    FABS  H9, H20
    FDIV  S25, S15, S14
    FMSUB  H15, H8, H15, H18
    FCVTZS  X21, H25, #10
    FCVTZU  W6, S15
    FMAX  H22, H9, H9
    FCMPE  D22, D22
    FRINTM  H5, H10
    FRINTM  S29, S29
    UCVTF  S12, X6, #54
    FCVTMU  W11, S8
    FRINTX  S10, S12
    FMIN  D13, D13, D0
    FRINTI  S8, S9
    FCVTNU  W6, H3
    FCMPE  D21, #0.0
    FMOV  H18, W21
    FCVTZS  W11, H0
    FCVTAU  X21, S18
    FCVTAS  W4, S14
    FRINTN  H25, H21
    FCVTZU  W21, H18, #19
    FRINTI  D22, D17
    FCVTNS  W6, D1
    FCMP  D14, #0.0
    FCVTAU  W17, S28
    FMOV  S12, S6
    FMSUB  D3, D10, D8, D8
    FCVTZS  X6, D22
    FCVTMU  W20, H13
    FRINTM  D9, D3
    FCVTAS  W23, D25
    FRINTX  D8, D12
    FCMP  D8, D5
    FMIN  D0, D9, D9
    FCVTMS  W3, S0
    FCVTPU  X25, S6
    FADD  H18, H2, H13
    UCVTF  D12, X4, #24
    FRINTM  H22, H18
    FCVTZU  W10, D9, #27
    FNMADD  D21, D4, D16, D15
    FSUB  S15, S27, S9
    FCVTNU  X24, H12
    FNMUL  H14, H8, H19
    FMUL  S27, S23, S12
    FCVTPU  W18, D21
    FCVTZS  W25, H21, #21
    FCVTAS  W11, H18
    FRINTM  D17, D0
    FMOV  D1, #2.50000000
    FCVTZS  W10, D27
    FCVTMU  X23, H7
    FCVTMS  W22, D27
    FCVTMS  X27, H11
    FCVTZU  X15, D1
    FCVTPU  X27, D12
    FCMP  H1, H6
    FCVT  D9, H12
    FCVTAU  W25, H26
    FCVTZU  W25, D7, #20
    FNMADD  H27, H23, H1, H9
    FCVTNU  X7, H2
    FRINTX  H11, H20
    FCVTPS  W16, D14
    FMOV  D7, #6.00000000
    FRINTX  H21, H29
    FNMUL  S0, S18, S20
    FABS  H6, H20
    FMADD  H20, H6, H0, H17
    FRINTM  H0, H20
    FMIN  S14, S21, S27
    SCVTF  S29, X22
    FRINTN  H6, H26
    FCVTAS  X24, S22
    FCVTPU  W23, H7
    FRINTN  S26, S0
    FCVTPU  W28, D26
    FRINTP  D27, D11
    FRINTN  S20, S29
    FRINTA  D2, D20
    FMOV  H12, #-10.50000000
    FCVTNU  X18, S27
    FCVTPU  W6, H14
    FCVTZS  X17, H12, #12
    FMOV  D17, D2
    FCVTNS  W11, S23
    FCSEL  H26, H6, H6, CC
    FCVTMS  X18, D17
    FCVTZS  W17, H18, #10
    UCVTF  H1, X11
    UCVTF  H29, X18
    FCVTZU  W18, S4, #28
    FCVTPS  W21, D27
    FSQRT  D6, D11
    FMOV  H0, X21
    UCVTF  D14, W28, #18
    FCVTAU  X6, S24
    FMOV  W21, H18
    FMINNM  D7, D27, D15
    FCVT  H20, D2
    FMOV  W25, H7
    FNEG  H7, H18
    FMADD  H2, H20, H30, H22
    FCMP  H7, #0.0
    FRINTN  D17, D29
    FCVTPU  W23, D25
    FSUB  S25, S4, S9
    FCVTNU  X29, D7
    FCVTZS  W17, D3, #31
    FCVTZS  W21, H14
    FCVTAS  W3, S24
    FRINTM  D23, D23
    FMSUB  D11, D11, D9, D5
    FRINTZ  H12, H2
    SCVTF  S9, X25
    FMOV  W3, S23
    FCVT  H3, D11
    FCVTNS  X21, S25
    FCVTNS  W10, H3
    FRINTN  S29, S17
    FCVT  S4, H12
    FRINTA  S12, S4
    FNMADD  D24, D9, D9, D12
    FRINTN  D4, D0
    UCVTF  H25, X6
    FRINTX  S0, S29
    FRINTP  H29, H24
    SCVTF  D5, W10, #8
    FCMP  D5, #0.0
    FCVTNU  X15, S4
    FCVTNS  X6, H29
    UCVTF  S2, W21, #15
    FCVTPU  X7, S25
    FCCMP  D0, D2, #0x7, LE
    FCVTAS  X23, D1
    FRINTM  D17, D8
    FMINNM  S5, S0, S12
    FCVTNS  X27, D8
    FCVTAS  X15, D28
    FCVTMS  W28, S23
    FRINTA  S23, S9
    FCVTNU  W22, H5
    FCVTNS  W23, D19
    FMIN  S25, S6, S4
    FRINTA  D4, D27
    FDIV  D3, D16, D28
    FCVTPU  X28, H29
    FCVTZS  X23, D0, #32
    SCVTF  S2, X22
    UCVTF  S9, X10, #48
    FCVTZS  W3, H12
    FADD  S6, S0, S9
    FCVTZS  W15, H4
    FCVTAU  X25, S9
    FMOV  S1, #-3.50000000
    FDIV  D24, D12, D7
    FRINTX  D29, D16
    FCVTPU  X20, S2
    FSQRT  H19, H3
    FMOV  X23, H29
    FCVTNU  W16, S25
    SCVTF  H28, W23
    FMOV  X27, D19
    FRINTI  D27, D28
    FCSEL  D28, D1, D6, GE
    FMOV  W3, H24
    FRINTX  S5, S28
    FABS  H12, H5
    FCVTNS  X7, S27
    FMAX  H14, H12, H23
    FCVTPU  W3, S30
    FDIV  H7, H19, H10
    SCVTF  S16, X16, #23
    FCVTPU  W10, D21
    UCVTF  D9, W10, #4
    FCVTMU  W25, S13
    FCVTAS  W28, S2
    FMOV  H21, H10
    FCVTMS  W16, S23
    FCVTAU  X21, H0
    FCVTNU  X23, H4
    FRINTM  S12, S28
    FMADD  D24, D15, D20, D2
    SCVTF  H10, W27
    FMSUB  H6, H9, H15, H12
    FNMADD  H9, H29, H9, H24
    FCMPE  D0, #0.0
    FCVTNS  W21, S14
    FCVTNU  W29, H8
    FCVTZS  X28, D4, #12
    FMSUB  H19, H23, H4, H21
    FNMUL  D8, D11, D14
    FABS  H14, H10
    FMUL  H11, H6, H7
    FCMP  H3, H26
    FRINTI  S13, S24
    FNMUL  S21, S27, S31
    FNMSUB  D10, D1, D26, D29
    FMOV  S28, W23
    FCVTNU  X10, D8
    FRINTX  S4, S9
    FNMUL  D15, D13, D13
    FCVTZU  X6, H15, #50
    FRINTZ  D6, D19
    FCVTZU  X18, H4, #20
    FCVTPS  X17, H6
    FMAXNM  S23, S14, S28
    FRINTM  D20, D23
    FMSUB  S23, S10, S20, S11
    FCMP  S23, #0.0
    FCVTAU  W4, H12
    FNMSUB  D28, D30, D24, D16
    FCVT  S24, H2
    FCVTPS  X3, D7
    FMAXNM  S30, S28, S24
    FRINTM  D3, D16
    FRINTP  H0, H16
    FCVTPS  X17, S13
    FMOV  W20, S13
    FCVTZS  X18, D8, #48
    FCVTZU  X18, S27, #18
    FCVTAS  W16, H14
    FNMADD  H12, H22, H30, H15
    FMOV  H28, W16
    FCVTAU  W17, D8
    FCVTMS  W16, S8
    FRINTA  H24, H26
    FCVTZS  W17, H9
    FMOV  S23, W17
    FCMPE  D27, D26
    FCVTZU  W20, H31, #12
    FNMADD  S26, S6, S28, S27
    FCVTPS  W21, S20
    FMINNM  S9, S21, S5
    SCVTF  S31, W16, #30
    FCVTAU  X17, S5
    FCVTPU  W22, S18
    FMUL  S6, S13, S30
    FRINTA  D28, D0
    FMOV  X28, D26
    FMSUB  S18, S23, S12, S12
    FMAXNM  H14, H9, H31
    UCVTF  S8, W22
    FRINTP  D27, D24
    SCVTF  D5, W21, #12
    FCVTZU  X24, S5, #38
    FNMUL  H13, H27, H8
    FCVTAS  W7, S13
    FCVTZS  W28, S14
    FCVTMU  W27, S6
    FNEG  H6, H18
    FMOV  S18, W28
    FCMP  D28, D28
    FCVT  S20, H6
    FNMADD  S14, S20, S20, S20
    SCVTF  D8, W7
    FMINNM  H21, H8, H14
    FCCMPE  H21, H18, #0xb, GE
    FCVTAS  X24, H16
    FCVTMS  X4, S19
    SUBS  X13, X13, #0x1
    B.NE  TSRTFloatAllOperation_label_17
    MOVZ  X14, #0x1, LSL #0
    SUB  X26, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    SUB  X26, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x1f, LSL #0
    MRS  X26, FPSR
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D0
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xc060, LSL #16
    FMOV  X26, D1
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D2
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D3
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D4
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D5
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D6
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x7e00, LSL #0
    FMOV  X26, D7
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D8
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xc040, LSL #16
    FMOV  X26, D9
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D10
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x7e00, LSL #0
    FMOV  X26, D11
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x8000, LSL #0
    FMOV  X26, D12
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x8000, LSL #0
    FMOV  X26, D13
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    FMOV  X26, D14
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #48
    FMOV  X26, D15
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V16.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D16
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D17
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D18
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D19
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D20
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D21
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D22
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D23
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D24
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D25
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x8000, LSL #16
    FMOV  X26, D26
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D27
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V28.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D28
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D29
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V30.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D30
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X26, D31
    SUB  X5, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x7a67, LSL #0
    MOVK  X3, #0x23c8, LSL #16
    MOVK  X3, #0xadf4, LSL #32
    MOVK  X3, #0xab14, LSL #48
    MOVZ  X4, #0xc8da, LSL #0
    MOVK  X4, #0x733b, LSL #16
    MOVK  X4, #0x2b32, LSL #32
    MOVK  X4, #0x821e, LSL #48
    MOVZ  X5, #0x3d76, LSL #0
    MOVK  X5, #0xee84, LSL #16
    MOVK  X5, #0xb7cb, LSL #32
    MOVK  X5, #0x7306, LSL #48
    MOVZ  X6, #0xa53b, LSL #0
    MOVK  X6, #0x8762, LSL #16
    MOVK  X6, #0x9c41, LSL #32
    MOVK  X6, #0x99c7, LSL #48
    MOVZ  X7, #0xe86a, LSL #0
    MOVK  X7, #0x2244, LSL #16
    MOVK  X7, #0xfcd0, LSL #32
    MOVK  X7, #0x1263, LSL #48
    MOVZ  X10, #0x2ab8, LSL #0
    MOVK  X10, #0xfa09, LSL #16
    MOVK  X10, #0xa77d, LSL #32
    MOVK  X10, #0xd333, LSL #48
    MOVZ  X11, #0xbd9, LSL #0
    MOVK  X11, #0x6ad, LSL #16
    MOVK  X11, #0xb367, LSL #32
    MOVK  X11, #0x7702, LSL #48
    MOVZ  X12, #0x8700, LSL #0
    MOVK  X12, #0x1e58, LSL #16
    MOVK  X12, #0xf893, LSL #32
    MOVK  X12, #0x357b, LSL #48
    MOVZ  X13, #0xfec0, LSL #0
    MOVK  X13, #0xb825, LSL #16
    MOVK  X13, #0xa5b6, LSL #32
    MOVK  X13, #0xde05, LSL #48
    MOVZ  X14, #0xe12a, LSL #0
    MOVK  X14, #0x92e0, LSL #16
    MOVK  X14, #0x4321, LSL #32
    MOVK  X14, #0x546c, LSL #48
    MOVZ  X15, #0x77a5, LSL #0
    MOVK  X15, #0x8a0b, LSL #16
    MOVK  X15, #0xb647, LSL #32
    MOVK  X15, #0x2148, LSL #48
    MOVZ  X16, #0x4b2e, LSL #0
    MOVK  X16, #0xe278, LSL #16
    MOVK  X16, #0x4944, LSL #32
    MOVK  X16, #0x427, LSL #48
    MOVZ  X17, #0xb018, LSL #0
    MOVK  X17, #0xdbe, LSL #16
    MOVK  X17, #0x7fb5, LSL #32
    MOVK  X17, #0x267d, LSL #48
    MOVZ  X18, #0x5960, LSL #0
    MOVK  X18, #0xd5ad, LSL #16
    MOVK  X18, #0x34b0, LSL #32
    MOVK  X18, #0x9720, LSL #48
    MOVZ  X20, #0xa622, LSL #0
    MOVK  X20, #0xecd4, LSL #16
    MOVK  X20, #0xab58, LSL #32
    MOVK  X20, #0xc52e, LSL #48
    MOVZ  X21, #0x9498, LSL #0
    MOVK  X21, #0x2c0b, LSL #16
    MOVK  X21, #0xd2ba, LSL #32
    MOVK  X21, #0x1eb4, LSL #48
    MOVZ  X22, #0xe806, LSL #0
    MOVK  X22, #0xec71, LSL #16
    MOVK  X22, #0x308f, LSL #32
    MOVK  X22, #0x121c, LSL #48
    MOVZ  X23, #0xc205, LSL #0
    MOVK  X23, #0x4013, LSL #16
    MOVK  X23, #0x735a, LSL #32
    MOVK  X23, #0xd03c, LSL #48
    MOVZ  X24, #0x775c, LSL #0
    MOVK  X24, #0xdcf2, LSL #16
    MOVK  X24, #0xd5a6, LSL #32
    MOVK  X24, #0x2458, LSL #48
    MOVZ  X25, #0x9d51, LSL #0
    MOVK  X25, #0x3a8, LSL #16
    MOVK  X25, #0x7895, LSL #32
    MOVK  X25, #0x1615, LSL #48
    MOVZ  X26, #0x1667, LSL #0
    MOVK  X26, #0xf1ec, LSL #16
    MOVK  X26, #0xcea4, LSL #32
    MOVK  X26, #0x8bc1, LSL #48
    MOVZ  X27, #0x3564, LSL #0
    MOVK  X27, #0x9248, LSL #16
    MOVK  X27, #0xddaa, LSL #32
    MOVK  X27, #0x5c9c, LSL #48
    MOVZ  X28, #0xac51, LSL #0
    MOVK  X28, #0xc46f, LSL #16
    MOVK  X28, #0x2021, LSL #32
    MOVK  X28, #0xb4e0, LSL #48
    MOVZ  X29, #0x2d0c, LSL #0
    MOVK  X29, #0x57d8, LSL #16
    MOVK  X29, #0xee3b, LSL #32
    MOVK  X29, #0xe603, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X13
    FMOV  D3, X5
    FMOV  V3.D[1], X26
    FMOV  D4, X26
    FMOV  V4.D[1], X12
    FMOV  D5, X14
    FMOV  V5.D[1], X12
    FMOV  D6, X3
    FMOV  V6.D[1], X22
    FMOV  D7, X21
    FMOV  V7.D[1], X16
    FMOV  D8, X11
    FMOV  V8.D[1], X11
    FMOV  D9, X13
    FMOV  V9.D[1], X21
    FMOV  D10, X10
    FMOV  V10.D[1], X5
    FMOV  D11, X20
    FMOV  V11.D[1], X27
    FMOV  D12, X6
    FMOV  V12.D[1], X29
    FMOV  D13, X12
    FMOV  V13.D[1], X4
    FMOV  D14, X22
    FMOV  V14.D[1], X11
    FMOV  D15, X26
    FMOV  V15.D[1], X27
    FMOV  D16, X23
    FMOV  V16.D[1], X23
    FMOV  D17, X20
    FMOV  V17.D[1], X16
    FMOV  D18, X3
    FMOV  V18.D[1], X27
    FMOV  D19, X22
    FMOV  V19.D[1], X14
    FMOV  D20, X21
    FMOV  V20.D[1], X25
    FMOV  D21, X3
    FMOV  V21.D[1], X14
    FMOV  D22, X6
    FMOV  V22.D[1], X16
    FMOV  D23, X18
    FMOV  V23.D[1], X3
    FMOV  D24, X23
    FMOV  V24.D[1], X17
    FMOV  D25, X10
    FMOV  V25.D[1], X7
    FMOV  D26, X10
    FMOV  V26.D[1], X5
    FMOV  D27, X27
    FMOV  V27.D[1], X11
    FMOV  D28, X12
    FMOV  V28.D[1], X28
    FMOV  D29, X27
    FMOV  V29.D[1], X20
    FMOV  D30, X24
    FMOV  V30.D[1], X25
    FMOV  D31, X10
    FMOV  V31.D[1], X28
    MOVZ  X11, #0xa, LSL #0
TSRTFloatAllOperation_label_18:
    FNMUL  D27, D30, D28
    FMAX  H1, H31, H29
    FCVTMU  X5, H1
    FCVT  D4, S26
    UCVTF  H31, X11
    FCVT  H30, S27
    FCVTAU  X10, D25
    FRINTA  S16, S24
    FSUB  S15, S23, S31
    FCVTZS  X20, S4
    FMIN  D19, D30, D30
    FMSUB  H25, H19, H19, H15
    FCVTAU  X24, H25
    FMAX  D9, D9, D22
    SCVTF  S10, W11
    FNMADD  H22, H2, H30, H17
    FCCMPE  H7, H5, #0x7, PL
    FCVTZU  W22, D18, #12
    FMINNM  H15, H16, H8
    FMOV  W14, S17
    FMUL  D1, D11, D15
    FCMP  H27, #0.0
    FCMP  S2, #0.0
    FMSUB  D7, D13, D7, D22
    FCVTNS  W7, S18
    FCMPE  S27, #0.0
    FCMP  H30, #0.0
    FCVT  S4, D4
    FMINNM  H2, H24, H24
    FCVTAS  X16, H18
    FMOV  D8, X29
    FCMPE  S11, #0.0
    FCVTZU  W24, H0
    FCVTPS  X10, S3
    FCMPE  H3, H7
    FCVT  D30, H2
    FCVTZU  W29, H20, #10
    FCVTNU  X16, H2
    FMOV  D15, D5
    FCVTPU  W7, S23
    FMUL  H18, H26, H21
    FCVTZS  W22, S8
    FCVTZU  W18, S7
    FCVTPS  X25, D5
    FMOV  D27, #0.14062500
    FCCMP  S18, S20, #0xc, LS
    FCVTZS  X12, S3, #44
    FCVTNS  X18, S29
    FCMP  S3, S18
    FCVT  H7, S12
    FSUB  D29, D19, D2
    FCVTPU  X14, S2
    FCVTZS  W25, H22
    SCVTF  D3, W16
    UCVTF  D18, W7, #13
    FCVTZU  W23, S0
    FCVTNS  X21, H16
    SCVTF  S5, W21, #7
    FADD  H0, H18, H15
    FCVTZU  X22, D0, #35
    FCVTAS  W4, S29
    FMINNM  D20, D5, D5
    FMOV  X16, H3
    FCVTZU  W10, S27, #15
    FCVTNS  X26, S30
    FCVTNU  X20, S7
    FRINTZ  S27, S21
    FMINNM  S2, S8, S19
    FCVTZU  X3, D4, #22
    FNMUL  H12, H19, H11
    FCMP  S25, #0.0
    FMAX  S3, S26, S12
    FRINTX  D12, D7
    FNMADD  H4, H14, H30, H14
    FCVTMU  X3, S28
    FNMUL  S21, S13, S23
    FDIV  S5, S31, S8
    FCSEL  S22, S31, S26, NE
    SCVTF  H28, X20, #18
    FMSUB  S29, S20, S3, S4
    FCVTZU  W12, H12
    FMOV  D11, X10
    FNEG  D31, D28
    FMADD  H19, H11, H2, H21
    FMAX  S8, S5, S5
    FCVTPS  W14, S27
    FCSEL  D3, D8, D8, LE
    SCVTF  D2, X3
    FRINTI  H8, H3
    FCVTMS  X20, D22
    FCVTMS  W6, D31
    FRINTX  D3, D19
    FMOV  D25, D29
    FMOV  D7, #0.31250000
    FCVTZS  W23, S25, #26
    FMOV  W23, H2
    FNEG  D27, D7
    FCVTMS  X13, S27
    FCMPE  H8, #0.0
    FNMUL  H27, H31, H18
    FCVT  H19, D18
    FMOV  X26, D23
    SCVTF  H22, W26
    UCVTF  H5, X13, #58
    FSUB  S18, S24, S20
    FNMUL  S7, S14, S23
    FCMPE  S15, S22
    FCVTAS  X10, H22
    FMIN  S25, S3, S7
    FDIV  D15, D7, D15
    FCVTZU  X24, S25
    FRINTZ  S29, S31
    FMOV  S23, S4
    FCVTNS  X27, S22
    FSQRT  H24, H7
    FMSUB  S8, S29, S15, S1
    FCVTNS  W3, H10
    FMOV  D10, #-0.68750000
    FCVTZS  W23, D9
    FCVTZU  X27, S21
    FMADD  D25, D0, D2, D19
    FCVTAU  W24, D21
    FMOV  X16, H25
    FMAX  S0, S0, S1
    FNMSUB  S10, S25, S31, S2
    FCVTPU  X7, D1
    FCMPE  D7, D8
    FCCMPE  D6, D25, #0xa, LE
    FNMADD  S6, S31, S23, S27
    FCMPE  H6, H13
    FCVTAU  X29, H18
    FCVTMS  W13, D24
    FDIV  H18, H8, H30
    FCVTAU  X14, S20
    FRINTZ  D21, D19
    FCVTMS  X12, D29
    FSQRT  S9, S14
    FCVTPU  W5, S4
    FRINTN  H24, H28
    SCVTF  S8, X16
    FCCMP  S20, S18, #0x5, HI
    FNMADD  D6, D15, D19, D4
    FMUL  D30, D30, D8
    FCSEL  D7, D17, D2, EQ
    FRINTZ  D17, D12
    FCVTZS  W18, D17
    FRINTI  H15, H30
    FCVTZU  W13, D7, #16
    SCVTF  H17, X12, #36
    UCVTF  S14, X29, #12
    FSUB  D1, D21, D10
    FCMP  H24, H6
    FCVTMU  W13, H1
    UCVTF  H28, X18
    FCMPE  D22, #0.0
    FCVTNU  W12, S9
    FCVTZS  W12, D28, #9
    FNMADD  D12, D14, D14, D17
    FCVTAU  X16, H15
    FCCMPE  H19, H22, #0xd, AL
    FMOV  H10, #29.00000000
    FRINTP  S28, S3
    FCVTNS  W29, S4
    FMOV  W29, H22
    FCVTZS  W13, D6
    FCVTNU  W10, H3
    FNMADD  S7, S2, S11, S21
    FNMUL  H22, H28, H13
    FCVTAS  X20, S30
    FCVTNU  X25, D11
    FCVTZU  W18, H9, #21
    UCVTF  S14, X18, #6
    FCVTMS  X20, H12
    FMOV  D17, X29
    FCCMP  H16, H0, #0x2, MI
    SCVTF  D4, W18
    FMUL  S24, S12, S2
    SCVTF  D13, W12
    FABS  S3, S20
    FMINNM  S6, S24, S13
    FRINTI  H2, H10
    UCVTF  H21, W16
    FCVTNU  X22, S21
    FCVTMS  X27, H22
    FCVTAU  W6, H7
    FCVTZS  W25, D17
    FCMPE  S3, S4
    FCVTPU  W21, H2
    FCVT  H30, S3
    FCVTPU  X29, S6
    FCVTAS  W7, D14
    FCVTNU  X12, S27
    FCVTZS  W23, H21, #1
    FCVTPS  W7, D3
    FCVTAU  X22, S17
    FRINTI  D10, D6
    FCVTZS  X3, D26
    FSQRT  H2, H18
    FNEG  S27, S18
    FCVTPU  W5, H16
    FMOV  D14, #2.12500000
    FMOV  D16, #-1.37500000
    FNMUL  D21, D5, D2
    FCVT  H2, S22
    FCSEL  D18, D2, D22, NE
    FCCMPE  D10, D29, #0xb, NE
    FCVTAU  X29, H3
    FCMPE  H19, #0.0
    FMOV  S6, W12
    FMINNM  S10, S30, S12
    FMOV  X24, D10
    FMSUB  H26, H20, H14, H20
    UCVTF  D7, W5, #19
    FSUB  H4, H30, H26
    FMIN  H7, H12, H31
    FRINTZ  H12, H30
    FCVTZU  X6, S8, #30
    FCMPE  S26, S2
    FCVTAS  W4, S20
    FCVTPS  W23, D23
    FCVTMU  X6, H24
    FCSEL  H26, H28, H17, MI
    FSQRT  D2, D21
    FMAX  S24, S27, S4
    FMIN  D17, D6, D24
    FCVTAS  W21, D26
    FCSEL  H30, H18, H17, LS
    FMIN  S28, S30, S30
    FMOV  S20, W23
    FMOV  X4, D7
    FCVTNS  W29, S20
    FCVTAU  W14, H28
    FCVTZU  X16, S12
    FCVTZU  X27, D2, #25
    FCVT  D18, H25
    FCVTZU  X29, H6
    FRINTI  S23, S6
    FNMUL  H12, H31, H8
    FCVTZU  X26, H28, #50
    FSUB  H21, H5, H9
    FDIV  S10, S16, S30
    FMSUB  H25, H14, H24, H5
    FCVTMS  X29, D16
    FRINTM  S8, S25
    FCVTNU  W29, H5
    FCVTZS  X24, S0
    FCCMP  H9, H25, #0x4, PL
    FCVTPU  W7, D9
    FCMPE  H12, H31
    SCVTF  S2, X26
    FDIV  H17, H2, H18
    FCVTMU  X5, D9
    UCVTF  S30, W27, #22
    FCVTNU  W5, S28
    FNMUL  H25, H20, H21
    FCVTAU  W25, H11
    FRINTI  S5, S30
    FCVTAS  W27, D15
    FCVTZU  W21, H17, #28
    FDIV  D14, D3, D1
    FCVTZS  X29, D26, #35
    FSUB  S20, S25, S15
    FRINTP  D28, D29
    FCMPE  H29, H8
    FSUB  D0, D27, D30
    FCVTPS  X6, D1
    SCVTF  D9, X24, #54
    FMOV  W12, H1
    FCVT  D26, H4
    FCMP  S20, #0.0
    FMAX  S24, S4, S8
    FCVTAS  W4, H17
    FADD  H20, H31, H28
    FCVTZU  X21, S6
    FRINTN  H6, H25
    FCVTMS  W23, S3
    FMAXNM  D1, D11, D19
    FCVTMU  X22, D6
    FADD  D30, D14, D9
    FCVTAS  X5, S30
    FRINTN  H6, H1
    FCVTNS  X25, H20
    FMOV  H19, X12
    UCVTF  S27, X6, #58
    FRINTX  S15, S24
    FNMADD  S29, S15, S19, S6
    FCVTZS  X23, D27
    FMOV  W21, S26
    FCVTZU  X13, D29, #21
    FCVTNU  W29, S21
    FCMP  H28, #0.0
    FDIV  H14, H11, H7
    FRINTA  S9, S11
    FCMP  D11, #0.0
    FCVTPS  X12, S26
    FMSUB  D7, D17, D6, D28
    FCVTPU  X7, D8
    SCVTF  H8, W23
    FNEG  S19, S26
    FDIV  H27, H25, H24
    SUBS  X11, X11, #0x1
    B.NE  TSRTFloatAllOperation_label_18
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X17, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x1f, LSL #0
    MRS  X17, FPSR
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    MOVK  X15, #0x8000, LSL #16
    FMOV  X17, D0
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D1
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D2
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D3
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D4
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D5
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D6
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D7
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D8
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D9
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D10
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D11
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x8000, LSL #0
    FMOV  X17, D12
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D13
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X17, D14
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D15
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xbff6, LSL #48
    FMOV  X17, D16
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X17, D17
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D18
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    FMOV  X17, D19
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D20
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X17, D21
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x8000, LSL #0
    FMOV  X17, D22
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D23
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D24
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0xfe00, LSL #0
    FMOV  X17, D25
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D26
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X17, D27
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, D28
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    FMOV  X17, D29
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X17, D30
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #48
    FMOV  X17, D31
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x0, LSL #0
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
    FMOV  D0, X18
    FMOV  V0.D[1], X11
    FMOV  D1, X29
    FMOV  V1.D[1], X16
    FMOV  D2, X25
    FMOV  V2.D[1], X23
    FMOV  D3, X27
    FMOV  V3.D[1], X22
    FMOV  D4, X24
    FMOV  V4.D[1], X28
    FMOV  D5, X26
    FMOV  V5.D[1], X21
    FMOV  D6, X23
    FMOV  V6.D[1], X21
    FMOV  D7, X5
    FMOV  V7.D[1], X14
    FMOV  D8, X23
    FMOV  V8.D[1], X16
    FMOV  D9, X17
    FMOV  V9.D[1], X10
    FMOV  D10, X21
    FMOV  V10.D[1], X21
    FMOV  D11, X11
    FMOV  V11.D[1], X29
    FMOV  D12, X7
    FMOV  V12.D[1], X10
    FMOV  D13, X18
    FMOV  V13.D[1], X10
    FMOV  D14, X5
    FMOV  V14.D[1], X24
    FMOV  D15, X6
    FMOV  V15.D[1], X24
    FMOV  D16, X15
    FMOV  V16.D[1], X23
    FMOV  D17, X27
    FMOV  V17.D[1], X5
    FMOV  D18, X18
    FMOV  V18.D[1], X6
    FMOV  D19, X15
    FMOV  V19.D[1], X18
    FMOV  D20, X6
    FMOV  V20.D[1], X17
    FMOV  D21, X18
    FMOV  V21.D[1], X7
    FMOV  D22, X16
    FMOV  V22.D[1], X27
    FMOV  D23, X17
    FMOV  V23.D[1], X18
    FMOV  D24, X17
    FMOV  V24.D[1], X25
    FMOV  D25, X16
    FMOV  V25.D[1], X18
    FMOV  D26, X7
    FMOV  V26.D[1], X14
    FMOV  D27, X25
    FMOV  V27.D[1], X28
    FMOV  D28, X29
    FMOV  V28.D[1], X5
    FMOV  D29, X12
    FMOV  V29.D[1], X21
    FMOV  D30, X4
    FMOV  V30.D[1], X5
    FMOV  D31, X7
    FMOV  V31.D[1], X11
    MOVZ  X18, #0xa, LSL #0
TSRTFloatAllOperation_label_19:
    FRINTI  H31, H26
    FCVTAU  X11, H27
    FCVTNS  W15, S22
    FABS  H30, H28
    FRINTA  S30, S25
    UCVTF  S24, W28
    FCMP  D30, #0.0
    FMOV  D29, #-13.00000000
    FCCMP  H29, H24, #0xf, EQ
    SCVTF  D30, W4, #20
    FCMPE  S23, S31
    FCVTMS  W28, D30
    FMIN  S10, S16, S2
    FCVTZS  W4, S19
    SCVTF  H31, X28, #25
    FRINTX  H19, H8
    FCVTZS  X28, H22
    FCVTAU  X7, D29
    FCVT  S12, H21
    FCVTAU  X5, S25
    FCVTNU  X24, D2
    FMOV  S15, W17
    FCVTMU  W17, D20
    FNMSUB  D14, D24, D8, D30
    UCVTF  S3, X28, #37
    FNMADD  S8, S13, S30, S26
    FCVTPS  X25, H15
    FMAXNM  D27, D17, D11
    FNMSUB  S16, S30, S2, S29
    FCVTNU  W11, H14
    FNEG  D24, D3
    FRINTA  H22, H10
    FNMUL  H10, H31, H12
    FCVTZU  X7, S16
    FCVTZS  X24, H5, #37
    FCVTPS  W26, H19
    FSQRT  H23, H10
    UCVTF  H3, X25, #32
    FCCMPE  S24, S3, #0x2, HI
    FMOV  W24, H8
    FCVTZU  W15, S27, #21
    FCVTAU  X23, H23
    FCVTPS  X21, S28
    UCVTF  S24, W7
    FCVTMU  W29, S18
    FDIV  D27, D11, D17
    FCVTZS  W29, S26, #23
    FRINTP  D31, D21
    SCVTF  D16, X26, #47
    FMIN  S18, S23, S9
    FCVT  D28, H29
    FNMUL  S26, S30, S25
    FRINTI  D12, D31
    FMOV  S19, W29
    FSQRT  H30, H26
    FCVTPS  W22, H30
    FMOV  W24, S12
    SCVTF  H2, W21
    FMOV  S5, W15
    FDIV  H26, H18, H18
    FCVTZS  W7, H24
    FCVTZU  W10, S22, #5
    FCMPE  H26, #0.0
    FDIV  D24, D27, D19
    FMAX  H3, H16, H28
    FCVTAU  W15, D5
    FRINTP  S21, S2
    FNMUL  S29, S21, S24
    UCVTF  H27, X22
    FMOV  H21, #14.50000000
    FCVTZU  W21, H27, #4
    FCVTPU  X25, S3
    FCVTAS  X27, D21
    FCVT  D18, H27
    FCMP  D21, #0.0
    SCVTF  H11, W15, #4
    FMAXNM  D16, D16, D4
    FMOV  D19, #26.00000000
    FCVTMU  X5, H11
    FCVTZU  W26, D30, #10
    FCVTMS  W11, D25
    FCVTPS  X15, D28
    FMSUB  D3, D0, D11, D29
    FMOV  D27, #3.25000000
    FCVTZS  W25, D8
    SCVTF  D21, X11
    FSQRT  S4, S6
    SCVTF  H2, X26
    FMUL  H5, H11, H16
    FCVTAS  X28, H25
    SCVTF  S11, X15
    FNMADD  H0, H11, H19, H29
    FCVTMU  W25, D18
    FCVTZU  W11, S27, #24
    SCVTF  H19, X25, #4
    FCVTNS  W21, S5
    FMIN  D25, D19, D2
    FCVTZU  W11, D3
    FCVTZS  X21, H0, #46
    FRINTA  D30, D25
    FRINTI  S28, S21
    FMINNM  D8, D28, D30
    FCVT  D6, S4
    FNMUL  H3, H6, H14
    FMOV  X13, D8
    FCVTZU  W15, S12
    FMAX  D30, D5, D17
    FCSEL  S5, S28, S28, GE
    FSUB  S27, S28, S3
    FNMADD  D14, D8, D5, D27
    FCVTMU  X11, H1
    SCVTF  H2, W15, #23
    FNMUL  H17, H21, H25
    FMSUB  H4, H7, H17, H12
    FCVTMU  X23, S22
    FCVTZS  X25, H14
    FMOV  W15, H21
    FCMPE  S21, #0.0
    FMUL  D3, D5, D4
    FSUB  H25, H16, H15
    FCVTPU  W29, H12
    FMSUB  D6, D29, D22, D23
    FCVTZU  W5, S4
    FCCMPE  D28, D24, #0x8, LT
    FCVTZU  W23, D22
    FCVTZS  X26, S2, #63
    FRINTX  S27, S24
    FCVTZS  X13, S11
    FCVTAS  W24, D6
    FCVTPU  X26, D25
    FCVTZU  X17, S1
    FSQRT  H8, H22
    FCVTMU  X17, H27
    FMOV  D2, D2
    FCVTNU  W26, H5
    FSQRT  H28, H30
    FCVTNU  X16, H11
    FCVTZU  W26, D24, #18
    FCVT  D6, S18
    FMOV  D30, #1.62500000
    FCVTZS  X21, D28, #25
    FCVTNU  W21, S19
    UCVTF  H24, X16, #49
    FMIN  D25, D14, D7
    UCVTF  S1, W29, #25
    FMADD  H11, H9, H29, H13
    FCMPE  H2, #0.0
    FCVTMU  W10, D6
    FMOV  S2, #-6.75000000
    FCMP  S1, #0.0
    FNMUL  D19, D11, D11
    UCVTF  D27, W10
    FMOV  X13, D8
    FRINTZ  H5, H27
    FRINTA  H18, H5
    FCVTZS  W12, H19, #21
    FMSUB  S14, S2, S25, S24
    FMOV  D6, #20.00000000
    FCVTPS  X5, D18
    FCVTNU  X29, S6
    FMUL  H7, H14, H14
    FCVTPU  W26, S7
    FCVTPS  W10, H25
    FNMUL  D29, D21, D6
    FCVTZS  X15, H5
    FCVTNS  X20, S4
    FCVTAU  X10, D19
    FCVTMS  X29, S21
    FMSUB  D19, D4, D12, D2
    FCVTZU  W29, S22, #15
    FABS  H22, H2
    FMOV  X17, H19
    SCVTF  H7, W17, #13
    FMADD  S18, S4, S27, S2
    FMIN  D1, D14, D6
    UCVTF  H6, X15, #4
    FRINTP  D5, D28
    FCMP  H11, H30
    FNMSUB  S4, S18, S9, S22
    FCVTNS  X23, D5
    FCVTPU  W22, H6
    FSUB  D21, D10, D25
    FCVTPS  X4, H1
    FCVT  D19, S3
    FCVT  H5, D22
    UCVTF  S2, X4, #33
    FRINTX  S14, S26
    SCVTF  S9, W23, #31
    FCVTMU  W4, D14
    FCVTZS  X27, D4, #54
    FCVT  D4, S9
    FCVTMS  X28, D29
    FCVTZS  W26, S21, #3
    FNMUL  S30, S4, S4
    FCVTMU  X28, D30
    FCVTZS  W29, H2, #12
    FCCMPE  D5, D5, #0x8, EQ
    FCVTNS  X24, S19
    FCVTZU  W4, S8
    FCVTAS  X16, D22
    UCVTF  H3, X16, #36
    FCVTNU  W7, H13
    FCMP  D9, #0.0
    FCVTMU  W23, H11
    FCVT  H8, S3
    FRINTI  D5, D7
    FCVTPU  X29, H11
    FMOV  H7, H7
    FCVTMS  W23, S2
    FMINNM  D21, D22, D8
    FMOV  D6, D15
    FCVT  S15, H18
    FSUB  S30, S8, S27
    FDIV  S3, S9, S3
    FMINNM  S19, S28, S30
    FCVTPS  X26, S6
    FRINTA  S14, S19
    FCVTZU  X29, D10, #60
    FCVT  H18, S6
    FCVTAS  W4, S27
    UCVTF  H9, W26
    FCVTMS  W16, D25
    FCVTNS  W22, S27
    FCVTAU  X21, H14
    FMOV  X29, D16
    FCVTMU  X28, H9
    FCSEL  D30, D30, D21, CC
    FRINTP  H25, H13
    FCVTZU  X20, S25
    FCCMPE  D7, D19, #0xf, GE
    FCVTAU  W21, H13
    UCVTF  S22, X20
    UCVTF  H21, W4
    FCVTPU  W26, D17
    FCVTZS  X11, H18
    FRINTM  H9, H7
    FCVTNS  W25, D10
    FCVTAU  X26, H27
    FCVT  D18, H19
    SCVTF  S13, X12, #60
    SCVTF  S10, X22
    FMOV  D25, #-0.32812500
    FCVTZU  X4, H18
    FMAX  H27, H22, H21
    FCVTZS  X26, D9, #64
    FMIN  H21, H27, H27
    FCVTMS  W27, D30
    FCVTAS  W29, S13
    SCVTF  H17, X28, #59
    UCVTF  S30, W29, #16
    FCVTPS  X28, D21
    FCVTAS  W27, H30
    FCVTAS  X10, D17
    FSUB  D18, D10, D10
    FCVTZU  X24, S25
    UCVTF  H10, X25, #13
    FCVTZU  X26, D23
    FCVTMS  W5, H12
    FRINTZ  H19, H27
    FNMSUB  S13, S4, S19, S18
    FCVTPS  X29, S27
    FCVTZS  X4, H2, #62
    FCVT  S9, D20
    FCVTZS  W25, S18, #18
    FRINTP  S4, S19
    FMINNM  S20, S21, S2
    FNMADD  S27, S18, S0, S19
    FCVTNU  W5, H17
    FCVTZU  W4, H27
    FCVTNU  X4, D24
    FMAXNM  H22, H10, H29
    FCMP  S29, #0.0
    FCVTZU  X12, S4, #14
    FCVTNS  X28, S2
    FNEG  H25, H13
    FMOV  D12, #0.62500000
    FCVTMS  X10, S8
    UCVTF  H8, X29, #37
    FCVTMS  W4, D9
    FCVTNU  W27, H18
    FCVTZU  W10, H13
    FNMUL  S21, S28, S3
    FRINTX  H23, H10
    SCVTF  D10, X10, #3
    FRINTI  D9, D8
    FCMPE  S3, S27
    FMADD  D18, D27, D25, D15
    FCVTAU  X27, D6
    FDIV  S24, S1, S21
    FMAXNM  S28, S21, S28
    FRINTN  D2, D20
    FCMPE  H23, H12
    FCMP  H10, H22
    FMOV  H21, W25
    FMOV  W27, S9
    FCVTPS  W16, S28
    FNEG  S12, S2
    UCVTF  D3, X28, #56
    UCVTF  D22, W27, #7
    UCVTF  S10, W16, #9
    SUBS  X18, X18, #0x1
    B.NE  TSRTFloatAllOperation_label_19
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X6, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x1f, LSL #0
    MRS  X6, FPSR
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x8000, LSL #0
    FMOV  X6, D0
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x6000, LSL #0
    MOVK  X3, #0x8003, LSL #16
    FMOV  X6, D1
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D2
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D3
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D4
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D5
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D6
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D8
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D10
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D11
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    FMOV  X6, D12
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D13
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D14
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D16
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D17
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D20
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D21
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D23
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x7fc0, LSL #16
    FMOV  X6, D24
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x8000, LSL #0
    FMOV  X6, D25
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x7e00, LSL #0
    FMOV  X6, D26
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #16
    FMOV  X6, D27
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    MOVK  X3, #0x8000, LSL #48
    FMOV  X6, D29
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, D31
    SUB  X14, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatAllOperation_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X5
    FMOV  D3, X3
    FMOV  V3.D[1], X16
    FMOV  D4, X16
    FMOV  V4.D[1], X6
    FMOV  D5, X14
    FMOV  V5.D[1], X3
    FMOV  D6, X15
    FMOV  V6.D[1], X4
    FMOV  D7, X18
    FMOV  V7.D[1], X26
    FMOV  D8, X18
    FMOV  V8.D[1], X10
    FMOV  D9, X22
    FMOV  V9.D[1], X6
    FMOV  D10, X15
    FMOV  V10.D[1], X20
    FMOV  D11, X24
    FMOV  V11.D[1], X6
    FMOV  D12, X15
    FMOV  V12.D[1], X27
    FMOV  D13, X16
    FMOV  V13.D[1], X24
    FMOV  D14, X22
    FMOV  V14.D[1], X21
    FMOV  D15, X10
    FMOV  V15.D[1], X17
    FMOV  D16, X23
    FMOV  V16.D[1], X22
    FMOV  D17, X10
    FMOV  V17.D[1], X18
    FMOV  D18, X27
    FMOV  V18.D[1], X10
    FMOV  D19, X10
    FMOV  V19.D[1], X23
    FMOV  D20, X3
    FMOV  V20.D[1], X23
    FMOV  D21, X6
    FMOV  V21.D[1], X12
    FMOV  D22, X27
    FMOV  V22.D[1], X23
    FMOV  D23, X24
    FMOV  V23.D[1], X16
    FMOV  D24, X6
    FMOV  V24.D[1], X28
    FMOV  D25, X23
    FMOV  V25.D[1], X7
    FMOV  D26, X23
    FMOV  V26.D[1], X11
    FMOV  D27, X16
    FMOV  V27.D[1], X26
    FMOV  D28, X16
    FMOV  V28.D[1], X27
    FMOV  D29, X25
    FMOV  V29.D[1], X5
    FMOV  D30, X25
    FMOV  V30.D[1], X10
    FMOV  D31, X21
    FMOV  V31.D[1], X28
    MOVZ  X7, #0xa, LSL #0
TSRTFloatAllOperation_label_20:
    FCVTMS  X11, H31
    SCVTF  H14, W15, #29
    FDIV  D8, D24, D21
    UCVTF  D3, X11, #13
    FCVTNU  W21, D26
    FCVTZS  W6, D3
    FRINTZ  H29, H28
    FCVTMU  W24, D30
    UCVTF  S3, X21, #32
    SCVTF  D6, X24, #57
    FMINNM  H28, H14, H6
    FRINTX  D20, D23
    FCVTMS  W21, D28
    FMINNM  S2, S8, S20
    FMOV  D10, D2
    FMAX  H9, H29, H3
    SCVTF  D21, X10
    UCVTF  D16, W7
    FCMPE  S9, #0.0
    FCVTPS  W4, H16
    FDIV  H2, H10, H10
    FCVTAU  W11, H21
    FMINNM  H14, H2, H2
    FRINTM  S9, S12
    FDIV  S31, S31, S30
    FCVT  S28, H5
    FCVTZS  W10, S28, #19
    FDIV  H21, H31, H24
    FCVTZU  W24, S2
    SCVTF  H8, X21, #13
    FCVTNU  X21, H24
    FMOV  W17, S13
    SCVTF  H12, W11
    FCVTPS  W28, D13
    FCVTZU  W15, H30
    FCVTZS  X11, D22, #10
    FCVTNU  X25, S29
    FCVTMS  X27, H18
    FMOV  S16, #-14.00000000
    FCVTNU  X17, H29
    SCVTF  S29, X10
    FCVTPS  W21, H25
    FRINTZ  S30, S0
    FCMP  S19, #0.0
    FMOV  H5, H16
    FMOV  X6, D7
    FMOV  D31, #-15.00000000
    FCVTNU  W16, D29
    FMINNM  S7, S9, S31
    FMOV  W10, H7
    FCVT  S9, H30
    FCVTPS  X23, S5
    FCVTZU  X25, H12, #29
    FRINTN  D0, D9
    FRINTN  H18, H0
    FCVTZU  X15, H18
    FNMADD  D9, D21, D16, D10
    FCVTAS  W5, S8
    FNEG  D25, D19
    FCVT  S19, H24
    FCVTMS  W3, S8
    FCVTAU  W14, S3
    FMOV  S29, W6
    FCVTAS  W11, S24
    FCVTAU  X3, D5
    FCVTMS  X25, D28
    FRINTI  H30, H15
    FCVTPS  W13, S6
    FMOV  W14, S3
    FCVTZS  X4, H22
    FDIV  S31, S20, S9
    FCVTMS  W5, H22
    FCVTAU  W13, S27
    UCVTF  D15, W14
    FCVTNU  X14, D18
    FCVTAU  X14, D5
    FRINTM  D20, D21
    FCCMPE  D22, D27, #0xd, GE
    FCSEL  H22, H24, H9, LE
    FCVTPS  W6, H3
    FCVTNU  X17, D13
    FDIV  H5, H12, H21
    FMOV  X16, D20
    FMINNM  H20, H31, H5
    FMOV  W24, H15
    FCVTZU  W3, S22
    FNEG  H24, H30
    FCVTAU  X6, H24
    FNMADD  D18, D20, D20, D20
    FMOV  H22, X3
    FRINTZ  D30, D18
    SCVTF  D27, W16
    SCVTF  S31, W24, #27
    FMOV  S20, S22
    FCVTPU  X3, H31
    FCVTZU  W13, S23, #19
    FCMP  H20, #0.0
    FRINTI  S20, S30
    FCVTNU  X3, D27
    FRINTA  D23, D6
    FMOV  H5, #12.00000000
    SCVTF  S15, X13, #1
    FCVTZS  W10, H29, #27
    FCVTZS  W4, H3
    FCVTMS  W10, H6
    FMADD  H30, H31, H27, H27
    FMAXNM  D21, D21, D31
    FSUB  H31, H23, H7
    FCVTZS  W5, S20, #13
    FCMPE  H23, #0.0
    FCVTZS  X23, H23, #11
    UCVTF  H24, X3
    FMOV  H23, W4
    FCCMP  H2, H31, #0xe, HI
    FABS  S2, S25
    FSUB  H25, H15, H1
    FCMP  S26, #0.0
    FSUB  D3, D15, D18
    FMINNM  H22, H21, H13
    FCVTNU  X24, D12
    FMAX  D26, D10, D3
    FCMP  H26, H1
    UCVTF  H5, X23, #63
    FRINTM  H27, H13
    FRINTP  S6, S19
    FCVTMS  X28, H2
    FCVTPU  X24, S6
    FCVTPS  W6, H25
    FCVTMU  W27, D24
    SCVTF  D31, W28
    FMAXNM  H24, H22, H31
    UCVTF  H1, X6
    UCVTF  D21, W24
    FCVTZS  X4, H30, #6
    FCVTZS  X17, D27
    FMAXNM  D22, D1, D5
    FCVTAU  W10, D24
    FMSUB  S24, S21, S22, S21
    FRINTX  S19, S24
    FMADD  D25, D19, D19, D19
    FCVTPU  X15, D25
    FCVTPS  X14, S22
    FCCMP  D9, D10, #0xc, GT
    FMUL  S22, S0, S4
    FCVTAU  W10, D28
    SCVTF  S2, X27
    FCVTZS  X15, D31, #1
    FCVTZS  X13, H22
    FCVT  S31, H10
    UCVTF  S27, W13, #15
    FMOV  X4, D15
    FMOV  D21, D20
    FCVTPS  X16, H11
    FCVTMU  X24, H8
    FNEG  D5, D18
    FCVTPU  W23, D26
    FMSUB  D26, D23, D30, D23
    FCVTPS  W14, H18
    FRINTM  D23, D9
    FRINTP  H30, H19
    FNMADD  H22, H16, H25, H6
    FRINTI  S15, S27
    FSQRT  D9, D21
    FCVTPU  X13, H9
    FCMP  S23, #0.0
    FCVTZU  X11, D31, #19
    FCVTAS  W22, H22
    FMOV  X4, H15
    FNMADD  D9, D26, D26, D30
    FCMPE  H5, #0.0
    FCMP  D9, #0.0
    FSQRT  H20, H26
    FCVTNU  W4, H6
    FCVTZS  X22, H29, #42
    FADD  H18, H17, H8
    FCVTAU  X5, S8
    FCVTZS  W16, D7, #29
    FCVTAS  X25, S3
    FMOV  D16, X4
    FCMPE  S17, S17
    FMIN  D17, D10, D6
    FCVTAU  X10, D26
    FRINTA  H9, H13
    FMIN  D10, D16, D5
    FCVTNS  X22, H29
    FMOV  H29, W10
    FRINTN  S15, S19
    FMADD  S7, S0, S27, S26
    UCVTF  S23, W5
    FMAX  S19, S23, S18
    FCVTPS  X18, H10
    FMAXNM  S18, S17, S7
    FCVTNS  X17, D18
    FNEG  H6, H9
    FCVTAS  W4, H29
    FRINTP  D23, D15
    FSUB  H15, H23, H19
    FCSEL  H30, H15, H15, LE
    FNEG  D16, D30
    FMIN  H5, H6, H6
    FCVTMU  W27, H16
    FCVTAS  X3, H5
    FMUL  D7, D23, D12
    UCVTF  D6, W22
    FMIN  S5, S23, S16
    FCMPE  D20, D20
    UCVTF  S26, W18, #16
    SCVTF  H18, X17
    FCCMP  D8, D6, #0x1, VS
    FRINTZ  D12, D28
    FCVTAS  W14, D20
    FCVTZU  X10, S22
    FMOV  S20, W3
    FMUL  H22, H7, H7
    FDIV  H15, H4, H10
    FCVTMS  X6, H27
    FCVTPU  W6, H21
    FCCMPE  S25, S21, #0x2, NE
    FCVTAU  X28, D15
    FSQRT  H28, H9
    UCVTF  H16, X14
    FCVTMS  X28, H1
    UCVTF  D10, W10, #8
    FRINTP  H6, H16
    FMAXNM  H1, H25, H10
    FCVTZU  W3, H6
    FADD  H7, H28, H28
    FCVTNS  X6, H20
    FCVTPS  W13, H1
    FCVTAU  W25, D12
    FMINNM  D1, D22, D7
    FCSEL  H28, H18, H1, EQ
    FMSUB  H25, H28, H28, H28
    FCVTZU  X11, D25, #26
    FRINTP  S16, S23
    FCVTPU  X17, H16
    UCVTF  D21, W6
    FRINTI  D1, D21
    FCVTNU  W21, S1
    FRINTN  S20, S13
    FCVTMS  X28, H4
    UCVTF  S4, X28, #50
    FMOV  S1, S0
    FMOV  H7, #0.96875000
    FMUL  H18, H30, H1
    FRINTM  D25, D18
    FNMADD  D18, D0, D29, D25
    FCVTAU  X5, S24
    FCVTZS  W28, H8
    FNMSUB  H23, H30, H4, H24
    FABS  S8, S15
    UCVTF  S28, X5
    FCVTZU  X13, S30
    FCVTZS  W21, H13
    FCVTNU  X4, D2
    FSUB  H6, H29, H4
    FMOV  S0, W4
    SCVTF  S2, X21, #30
    FSUB  S29, S8, S7
    FRINTI  S7, S0
    FCVTZS  W18, D18
    FMIN  S24, S7, S20
    FRINTN  D1, D29
    UCVTF  D25, X18, #32
    FCMP  S25, #0.0
    FCVTNS  X3, S23
    FRINTM  H15, H1
    FMAXNM  S13, S2, S28
    FCVTZS  X18, H13, #12
    UCVTF  H0, X3
    FCVTAS  X22, S6
    FNEG  S6, S24
    UCVTF  D20, W18, #8
    UCVTF  H2, X22, #51
    FCVTMU  X13, D15
    FCVTNU  W24, H2
    FMAXNM  S8, S20, S0
    FCVTZS  X18, D8
    FCVTZU  X18, S0, #57
    FRINTI  D30, D13
    FSQRT  H0, H12
    FMAXNM  S15, S21, S7
    FCVT  H1, S28
    FMOV  D4, #-6.25000000
    SCVTF  H7, W18
    FABS  H23, H8
    FCMPE  H25, #0.0
    FCVTMS  W21, H4
    FMIN  H24, H2, H0
    FABS  H20, H5
    FRINTZ  S13, S30
    FABS  S4, S16
    FCVTZU  W3, S15
    FNMADD  S28, S6, S4, S23
    FMOV  H12, #7.50000000
    FNMUL  D6, D28, D1
    FCCMP  D6, D6, #0x6, PL
    FCVTPU  X11, S12
    FABS  S28, S8
    FCVTAS  X24, D28
    SUBS  X7, X7, #0x1
    B.NE  TSRTFloatAllOperation_label_20
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x1, LSL #0
    SUB  X26, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    SUB  X26, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x1f, LSL #0
    MRS  X26, FPSR
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D0
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D1
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D2
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D3
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D4
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D5
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X26, D6
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D7
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D8
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D9
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D10
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X26, V11.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0xffff, LSL #0
    MOVK  X12, #0xffff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    FMOV  X26, D11
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x4780, LSL #0
    FMOV  X26, D12
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D13
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    FMOV  X26, D14
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D15
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V16.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D16
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D17
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X26, D18
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D19
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D20
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D21
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D22
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D23
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D24
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D25
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D26
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D27
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V28.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D28
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x4240, LSL #0
    FMOV  X26, D29
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V30.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D30
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, D31
    SUB  X29, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatAllOperation_TestFail

TSRTFloatAllOperation_TestEnd:
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
TSRTFloatAllOperation_TestFail:
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
