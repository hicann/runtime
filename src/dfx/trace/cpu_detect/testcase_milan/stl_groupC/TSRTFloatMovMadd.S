.global TSRTFloatMovMadd

.text
.p2align 4

TSRTFloatMovMadd:

TSRTFloatMovMadd_TestBegin:
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
    MOVZ  X2, #0x3a4f, LSL #0
    MOVK  X2, #0x1ea5, LSL #16
    MOVK  X2, #0x4372, LSL #32
    MOVK  X2, #0x6d78, LSL #48
    MOVZ  X3, #0xa331, LSL #0
    MOVK  X3, #0x3408, LSL #16
    MOVK  X3, #0xff5, LSL #32
    MOVK  X3, #0x62c4, LSL #48
    MOVZ  X4, #0x45fd, LSL #0
    MOVK  X4, #0xe884, LSL #16
    MOVK  X4, #0x5407, LSL #32
    MOVK  X4, #0x609f, LSL #48
    MOVZ  X5, #0x41ce, LSL #0
    MOVK  X5, #0x259d, LSL #16
    MOVK  X5, #0x95d2, LSL #32
    MOVK  X5, #0x6510, LSL #48
    MOVZ  X6, #0x7d4f, LSL #0
    MOVK  X6, #0xe4e8, LSL #16
    MOVK  X6, #0xb409, LSL #32
    MOVK  X6, #0x13df, LSL #48
    MOVZ  X8, #0x7530, LSL #0
    MOVK  X8, #0x1ede, LSL #16
    MOVK  X8, #0x3630, LSL #32
    MOVK  X8, #0x9083, LSL #48
    MOVZ  X9, #0x7848, LSL #0
    MOVK  X9, #0x6803, LSL #16
    MOVK  X9, #0x2025, LSL #32
    MOVK  X9, #0xa105, LSL #48
    MOVZ  X10, #0x4a75, LSL #0
    MOVK  X10, #0x65aa, LSL #16
    MOVK  X10, #0x69a5, LSL #32
    MOVK  X10, #0x596f, LSL #48
    MOVZ  X11, #0x392e, LSL #0
    MOVK  X11, #0xc909, LSL #16
    MOVK  X11, #0xa778, LSL #32
    MOVK  X11, #0xc278, LSL #48
    MOVZ  X12, #0xa4b7, LSL #0
    MOVK  X12, #0xcd42, LSL #16
    MOVK  X12, #0x4e73, LSL #32
    MOVK  X12, #0xc2ce, LSL #48
    MOVZ  X13, #0x881b, LSL #0
    MOVK  X13, #0xd060, LSL #16
    MOVK  X13, #0xccc9, LSL #32
    MOVK  X13, #0xfbc9, LSL #48
    MOVZ  X14, #0xb493, LSL #0
    MOVK  X14, #0x3c79, LSL #16
    MOVK  X14, #0x34ed, LSL #32
    MOVK  X14, #0x924e, LSL #48
    MOVZ  X15, #0x7d31, LSL #0
    MOVK  X15, #0xf925, LSL #16
    MOVK  X15, #0xa45a, LSL #32
    MOVK  X15, #0x1b78, LSL #48
    MOVZ  X16, #0xc510, LSL #0
    MOVK  X16, #0xaf68, LSL #16
    MOVK  X16, #0x54e9, LSL #32
    MOVK  X16, #0x6b52, LSL #48
    MOVZ  X17, #0x4252, LSL #0
    MOVK  X17, #0x71ea, LSL #16
    MOVK  X17, #0xed00, LSL #32
    MOVK  X17, #0x26bf, LSL #48
    MOVZ  X18, #0x1fcd, LSL #0
    MOVK  X18, #0xcaab, LSL #16
    MOVK  X18, #0x1df0, LSL #32
    MOVK  X18, #0xc14a, LSL #48
    MOVZ  X19, #0xc0ba, LSL #0
    MOVK  X19, #0x74f5, LSL #16
    MOVK  X19, #0x4128, LSL #32
    MOVK  X19, #0x97c7, LSL #48
    MOVZ  X21, #0xeb20, LSL #0
    MOVK  X21, #0xd2cb, LSL #16
    MOVK  X21, #0x2c75, LSL #32
    MOVK  X21, #0x29d5, LSL #48
    MOVZ  X23, #0xfaf9, LSL #0
    MOVK  X23, #0xc6bb, LSL #16
    MOVK  X23, #0x3ba5, LSL #32
    MOVK  X23, #0xab72, LSL #48
    MOVZ  X24, #0xbb0a, LSL #0
    MOVK  X24, #0x43c7, LSL #16
    MOVK  X24, #0xcb47, LSL #32
    MOVK  X24, #0xdc28, LSL #48
    MOVZ  X25, #0x2795, LSL #0
    MOVK  X25, #0x7d42, LSL #16
    MOVK  X25, #0xcd65, LSL #32
    MOVK  X25, #0x67d5, LSL #48
    MOVZ  X27, #0xbe49, LSL #0
    MOVK  X27, #0xda36, LSL #16
    MOVK  X27, #0x356d, LSL #32
    MOVK  X27, #0xdb3a, LSL #48
    MOVZ  X28, #0xdff1, LSL #0
    MOVK  X28, #0x4c6c, LSL #16
    MOVK  X28, #0x7716, LSL #32
    MOVK  X28, #0xb010, LSL #48
    MOVZ  X29, #0xffef, LSL #0
    MOVK  X29, #0x18dd, LSL #16
    MOVK  X29, #0x3ec2, LSL #32
    MOVK  X29, #0xf90f, LSL #48
    MOVZ  X8, #0xcb39, LSL #0
    MOVK  X8, #0x27d5, LSL #16
    MOVK  X8, #0x4053, LSL #32
    MOVK  X8, #0x819f, LSL #48
    MSR  FPCR, X8
    MOVZ  X8, #0x4b7a, LSL #0
    MOVK  X8, #0xdf50, LSL #16
    MOVK  X8, #0x1979, LSL #32
    MOVK  X8, #0x22d5, LSL #48
    MSR  FPSR, X8
    MRS  X18, FPSR
    MOVZ  X10, #0xff60, LSL #0
    MOVK  X10, #0x7ff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    AND  X18, X18, X10
    MOVZ  X10, #0x0, LSL #0
    ORR  X18, X18, X10
    MSR  FPSR, X18
    ISB  SY
    ANDS  X8, X5, #0xffff8fffffff8fff
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0xa794, LSL #0
    MOVK  X2, #0x8287, LSL #16
    MOVK  X2, #0x69b1, LSL #32
    MOVK  X2, #0x30bf, LSL #48
    MOVZ  X3, #0xa7fd, LSL #0
    MOVK  X3, #0x515b, LSL #16
    MOVK  X3, #0xfd5f, LSL #32
    MOVK  X3, #0x453f, LSL #48
    MOVZ  X4, #0x30e4, LSL #0
    MOVK  X4, #0xacf8, LSL #16
    MOVK  X4, #0xed48, LSL #32
    MOVK  X4, #0xe713, LSL #48
    MOVZ  X5, #0xf318, LSL #0
    MOVK  X5, #0x7de7, LSL #16
    MOVK  X5, #0x9d35, LSL #32
    MOVK  X5, #0x79c9, LSL #48
    MOVZ  X6, #0x77bb, LSL #0
    MOVK  X6, #0xdfda, LSL #16
    MOVK  X6, #0xb7db, LSL #32
    MOVK  X6, #0x87e8, LSL #48
    MOVZ  X8, #0xeef7, LSL #0
    MOVK  X8, #0x7229, LSL #16
    MOVK  X8, #0x293a, LSL #32
    MOVK  X8, #0x44f9, LSL #48
    MOVZ  X9, #0x1825, LSL #0
    MOVK  X9, #0x4d5e, LSL #16
    MOVK  X9, #0x6112, LSL #32
    MOVK  X9, #0x8be6, LSL #48
    MOVZ  X10, #0xcdd2, LSL #0
    MOVK  X10, #0xb9c6, LSL #16
    MOVK  X10, #0x566b, LSL #32
    MOVK  X10, #0x5f80, LSL #48
    MOVZ  X11, #0x95af, LSL #0
    MOVK  X11, #0xd36b, LSL #16
    MOVK  X11, #0x41a2, LSL #32
    MOVK  X11, #0xa05c, LSL #48
    MOVZ  X12, #0x6bd, LSL #0
    MOVK  X12, #0xe6ae, LSL #16
    MOVK  X12, #0x7872, LSL #32
    MOVK  X12, #0xb54, LSL #48
    MOVZ  X13, #0x777d, LSL #0
    MOVK  X13, #0xb56, LSL #16
    MOVK  X13, #0xbb6c, LSL #32
    MOVK  X13, #0xbd36, LSL #48
    MOVZ  X14, #0x4da8, LSL #0
    MOVK  X14, #0x33b6, LSL #16
    MOVK  X14, #0xa079, LSL #32
    MOVK  X14, #0x2e3b, LSL #48
    MOVZ  X15, #0x9c3b, LSL #0
    MOVK  X15, #0x3f8a, LSL #16
    MOVK  X15, #0x687e, LSL #32
    MOVK  X15, #0xbce, LSL #48
    MOVZ  X16, #0x5928, LSL #0
    MOVK  X16, #0x8873, LSL #16
    MOVK  X16, #0x9928, LSL #32
    MOVK  X16, #0x8a4, LSL #48
    MOVZ  X17, #0x860, LSL #0
    MOVK  X17, #0xbb05, LSL #16
    MOVK  X17, #0x117f, LSL #32
    MOVK  X17, #0xc875, LSL #48
    MOVZ  X18, #0x189b, LSL #0
    MOVK  X18, #0x66c6, LSL #16
    MOVK  X18, #0x4e08, LSL #32
    MOVK  X18, #0xca1f, LSL #48
    MOVZ  X19, #0x48f7, LSL #0
    MOVK  X19, #0xe118, LSL #16
    MOVK  X19, #0x7ad3, LSL #32
    MOVK  X19, #0xd107, LSL #48
    MOVZ  X21, #0x6600, LSL #0
    MOVK  X21, #0x11d0, LSL #16
    MOVK  X21, #0x7d4b, LSL #32
    MOVK  X21, #0x897f, LSL #48
    MOVZ  X23, #0xca4f, LSL #0
    MOVK  X23, #0x9c87, LSL #16
    MOVK  X23, #0xc84f, LSL #32
    MOVK  X23, #0xa4fb, LSL #48
    MOVZ  X24, #0x2283, LSL #0
    MOVK  X24, #0xc6b9, LSL #16
    MOVK  X24, #0x1a3f, LSL #32
    MOVK  X24, #0x84c6, LSL #48
    MOVZ  X25, #0xb6e0, LSL #0
    MOVK  X25, #0x6d8, LSL #16
    MOVK  X25, #0x2046, LSL #32
    MOVK  X25, #0x93d7, LSL #48
    MOVZ  X27, #0x19c4, LSL #0
    MOVK  X27, #0x853c, LSL #16
    MOVK  X27, #0x2583, LSL #32
    MOVK  X27, #0x4e18, LSL #48
    MOVZ  X28, #0xd41c, LSL #0
    MOVK  X28, #0xb761, LSL #16
    MOVK  X28, #0x47d0, LSL #32
    MOVK  X28, #0x6e73, LSL #48
    MOVZ  X29, #0x6b71, LSL #0
    MOVK  X29, #0xd6f1, LSL #16
    MOVK  X29, #0xf473, LSL #32
    MOVK  X29, #0x7501, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X12
    FMOV  V2.D[1], X13
    FMOV  D3, X4
    FMOV  V3.D[1], X19
    FMOV  D4, X24
    FMOV  V4.D[1], X18
    FMOV  D5, X21
    FMOV  V5.D[1], X9
    FMOV  D6, X9
    FMOV  V6.D[1], X16
    FMOV  D7, X27
    FMOV  V7.D[1], X14
    FMOV  D8, X15
    FMOV  V8.D[1], X11
    FMOV  D9, X6
    FMOV  V9.D[1], X11
    FMOV  D10, X2
    FMOV  V10.D[1], X6
    FMOV  D11, X6
    FMOV  V11.D[1], X28
    FMOV  D12, X18
    FMOV  V12.D[1], X28
    FMOV  D13, X21
    FMOV  V13.D[1], X5
    FMOV  D14, X9
    FMOV  V14.D[1], X10
    FMOV  D15, X15
    FMOV  V15.D[1], X9
    FMOV  D16, X12
    FMOV  V16.D[1], X17
    FMOV  D17, X9
    FMOV  V17.D[1], X5
    FMOV  D18, X18
    FMOV  V18.D[1], X15
    FMOV  D19, X13
    FMOV  V19.D[1], X8
    FMOV  D20, X3
    FMOV  V20.D[1], X21
    FMOV  D21, X21
    FMOV  V21.D[1], X19
    FMOV  D22, X14
    FMOV  V22.D[1], X25
    FMOV  D23, X23
    FMOV  V23.D[1], X14
    FMOV  D24, X15
    FMOV  V24.D[1], X4
    FMOV  D25, X2
    FMOV  V25.D[1], X15
    FMOV  D26, X11
    FMOV  V26.D[1], X28
    FMOV  D27, X21
    FMOV  V27.D[1], X28
    FMOV  D28, X28
    FMOV  V28.D[1], X3
    FMOV  D29, X13
    FMOV  V29.D[1], X5
    FMOV  D30, X15
    FMOV  V30.D[1], X8
    FMOV  D31, X25
    FMOV  V31.D[1], X13
    MOVZ  X14, #0xf, LSL #0
TSRTFloatMovMadd_label_0:
    FSQRT  D23, D31
    FNMSUB  S13, S28, S24, S27
    FNMSUB  D7, D30, D25, D26
    FNMSUB  H6, H29, H29, H7
    FNEG  D23, D6
    FNMADD  S1, S13, S13, S13
    FCSEL  H4, H1, H1, VS
    FABS  D18, D22
    FNMADD  S9, S23, S23, S18
    FSQRT  S1, S4
    FMADD  H6, H1, H9, H9
    FNMSUB  H1, H29, H5, H6
    FMUL  H30, H11, H9
    FSQRT  H19, H23
    FMOV  X5, D24
    FMSUB  D25, D1, D23, D3
    FMOV  S4, #0.62500000
    FMOV  D6, D26
    FMOV  X13, D11
    FABS  H5, H30
    FDIV  H31, H18, H16
    FMOV  X8, D25
    FNMSUB  H25, H14, H9, H30
    FNMADD  H14, H25, H8, H5
    FMOV  W3, S18
    FMUL  S16, S30, S18
    FNMADD  D11, D24, D31, D31
    FMOV  X13, H15
    FMOV  H23, X24
    FMOV  X16, D6
    FCSEL  D9, D3, D28, NV
    FABS  S6, S26
    FNMUL  S1, S25, S14
    FABS  D22, D16
    FMOV  H3, H7
    FADD  S7, S23, S1
    FMOV  X28, D6
    FMADD  S6, S9, S3, S11
    FNMSUB  D30, D22, D19, D7
    FMOV  H24, H30
    FMOV  D7, #-0.62500000
    FMOV  S25, S7
    FNMADD  S26, S24, S6, S6
    FCSEL  S14, S25, S25, NE
    FMADD  S24, S26, S26, S26
    FMOV  X21, D14
    FMOV  H9, #0.14062500
    FSQRT  H7, H24
    FNMUL  D26, D7, D9
    FMADD  S6, S1, S3, S7
    FMOV  S9, #-0.71875000
    FABS  H30, H8
    FNEG  D25, D23
    FMUL  D5, D17, D24
    FABS  H22, H7
    FCSEL  D3, D28, D25, NV
    FSUB  S8, S8, S6
    FMOV  X15, H19
    FMSUB  H23, H20, H20, H4
    FNMSUB  H1, H21, H10, H16
    FMADD  H24, H1, H8, H1
    FMOV  H8, X21
    FADD  S14, S8, S9
    FCSEL  S11, S26, S5, LS
    FSQRT  S9, S24
    FNEG  D4, D14
    FSQRT  S26, S7
    FNMUL  S9, S11, S3
    FABS  H10, H30
    FABS  H19, H26
    FNMUL  S3, S23, S9
    FMOV  W6, S19
    FNMSUB  D11, D23, D22, D22
    FNMUL  S19, S3, S11
    FNEG  S20, S4
    FMUL  H23, H10, H20
    FMUL  S1, S23, S19
    FMOV  D21, D21
    FSQRT  S22, S24
    FMOV  D26, D19
    FMOV  S8, W24
    FMOV  H20, W28
    FNMADD  S7, S18, S24, S4
    FMOV  W21, S15
    FMOV  W13, S23
    FADD  S23, S10, S25
    FMSUB  S5, S10, S0, S30
    FSQRT  D18, D31
    FMOV  X18, D7
    FMUL  D19, D23, D18
    FMOV  D14, D1
    FMSUB  D23, D21, D20, D5
    FMOV  S25, #0.68750000
    FSQRT  D21, D22
    FCSEL  H20, H8, H26, LS
    FMOV  D15, #-19.00000000
    FNMUL  H9, H14, H20
    FMADD  S14, S15, S19, S27
    FNMUL  D5, D9, D23
    FNMSUB  H10, H5, H14, H5
    FABS  S14, S10
    FNMUL  S1, S21, S25
    FNMUL  S30, S1, S1
    FMOV  X16, H30
    FSUB  H30, H0, H7
    FMOV  D24, #0.18750000
    FMUL  S18, S28, S3
    FNMADD  H4, H13, H26, H21
    FMOV  H31, H4
    FMOV  S13, W12
    FSUB  S3, S13, S19
    FNEG  D13, D9
    FMADD  H28, H26, H30, H16
    FMADD  D10, D5, D9, D29
    FSUB  D9, D3, D24
    FMSUB  H20, H30, H20, H23
    FMOV  D1, D17
    FABS  H19, H18
    FMOV  H30, #-0.21093750
    FNEG  D21, D28
    FNMSUB  H8, H13, H31, H13
    FMOV  W2, H30
    FNEG  D30, D8
    FABS  D4, D19
    FCSEL  H0, H4, H4, VS
    FMOV  D24, D10
    FNMSUB  H16, H14, H21, H14
    FADD  D10, D16, D20
    FMOV  D14, #-11.50000000
    FMADD  S29, S9, S9, S10
    FCSEL  S13, S10, S1, VS
    FMUL  S26, S13, S24
    FMSUB  H24, H30, H26, H26
    FMSUB  S3, S24, S29, S0
    FADD  D16, D14, D3
    FNEG  D18, D7
    FMOV  W5, H31
    FABS  D21, D0
    FSQRT  S17, S20
    FMOV  H9, #4.75000000
    FDIV  S8, S17, S14
    FMOV  H1, #-25.00000000
    FNMADD  D20, D15, D11, D13
    FNMUL  S7, S18, S31
    FMADD  H10, H0, H18, H1
    FNMSUB  D1, D19, D8, D9
    FSUB  D29, D6, D11
    FMOV  H30, #-0.62500000
    FABS  D14, D22
    FNEG  D4, D1
    FMADD  H18, H30, H4, H29
    FDIV  D3, D20, D20
    FSQRT  D21, D10
    FMOV  W2, S3
    FABS  H0, H14
    FDIV  H14, H7, H0
    FMSUB  S11, S14, S14, S18
    FMADD  S0, S11, S21, S16
    FMOV  S26, W2
    FABS  S8, S14
    FADD  S22, S27, S15
    FMSUB  S14, S27, S12, S31
    FDIV  S24, S20, S21
    FNMADD  D15, D22, D10, D15
    FNMADD  D10, D9, D6, D14
    FDIV  H3, H31, H20
    FMADD  H18, H11, H17, H2
    FMOV  W15, S29
    FSUB  D21, D18, D13
    FSUB  H7, H7, H9
    FMOV  H18, W6
    FMOV  D4, D0
    FMOV  D31, #3.12500000
    FADD  D13, D7, D18
    FABS  S12, S21
    FMADD  D16, D6, D8, D12
    FSQRT  D22, D3
    FNEG  H3, H31
    FNMSUB  H2, H15, H26, H22
    FADD  H31, H10, H24
    FDIV  H12, H4, H31
    FMUL  D8, D13, D2
    FABS  D11, D0
    FNMUL  H10, H12, H11
    FMSUB  D17, D8, D16, D10
    FSUB  H21, H17, H3
    FSUB  S9, S19, S16
    FMOV  X15, H16
    FNMADD  D6, D3, D29, D9
    FMOV  S26, W14
    FNMADD  H0, H8, H13, H29
    FSUB  D18, D28, D17
    FNMSUB  S3, S18, S26, S17
    FCSEL  D22, D14, D5, LT
    FMADD  S4, S31, S15, S28
    FMADD  H13, H14, H18, H31
    FNEG  S18, S7
    FCSEL  H26, H0, H2, NE
    FNMADD  D28, D22, D18, D21
    FDIV  D24, D21, D22
    SUBS  X14, X14, #0x1
    B.NE  TSRTFloatMovMadd_label_0
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x8000, LSL #0
    SUB  X9, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xcdd2, LSL #0
    MOVK  X17, #0xb9c6, LSL #16
    MOVK  X17, #0x566b, LSL #32
    MOVK  X17, #0x5f80, LSL #48
    SUB  X9, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x95af, LSL #0
    MOVK  X17, #0xd36b, LSL #16
    MOVK  X17, #0x41a2, LSL #32
    MOVK  X17, #0xa05c, LSL #48
    SUB  X9, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x6bd, LSL #0
    MOVK  X17, #0xe6ae, LSL #16
    MOVK  X17, #0x7872, LSL #32
    MOVK  X17, #0xb54, LSL #48
    SUB  X9, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3f38, LSL #16
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x48f7, LSL #0
    MOVK  X17, #0xe118, LSL #16
    MOVK  X17, #0x7ad3, LSL #32
    MOVK  X17, #0xd107, LSL #48
    SUB  X9, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X9, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xca4f, LSL #0
    MOVK  X17, #0x9c87, LSL #16
    MOVK  X17, #0xc84f, LSL #32
    MOVK  X17, #0xa4fb, LSL #48
    SUB  X9, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x2283, LSL #0
    MOVK  X17, #0xc6b9, LSL #16
    MOVK  X17, #0x1a3f, LSL #32
    MOVK  X17, #0x84c6, LSL #48
    SUB  X9, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xb6e0, LSL #0
    MOVK  X17, #0x6d8, LSL #16
    MOVK  X17, #0x2046, LSL #32
    MOVK  X17, #0x93d7, LSL #48
    SUB  X9, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x19c4, LSL #0
    MOVK  X17, #0x853c, LSL #16
    MOVK  X17, #0x2583, LSL #32
    MOVK  X17, #0x4e18, LSL #48
    SUB  X9, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x8000, LSL #0
    SUB  X9, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x6b71, LSL #0
    MOVK  X17, #0xd6f1, LSL #16
    MOVK  X17, #0xf473, LSL #32
    MOVK  X17, #0x7501, LSL #48
    SUB  X9, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x95, LSL #0
    MRS  X9, FPSR
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x8000, LSL #0
    FMOV  X9, D0
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D1
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D2
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D3
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D4
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #48
    FMOV  X9, D5
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #48
    FMOV  X9, D6
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xc4c0, LSL #0
    FMOV  X9, D7
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D9
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xfe00, LSL #0
    FMOV  X9, D10
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D11
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x7e00, LSL #0
    FMOV  X9, D12
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D13
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D14
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x4033, LSL #48
    FMOV  X9, D15
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D16
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D17
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xc4c0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    FMOV  X9, D18
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D19
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D20
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D21
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #48
    FMOV  X9, D22
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D23
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    FMOV  X9, D24
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x3f30, LSL #16
    FMOV  X9, D25
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x8000, LSL #0
    FMOV  X9, D26
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xd41c, LSL #0
    MOVK  X17, #0xb761, LSL #16
    MOVK  X17, #0x47d0, LSL #32
    MOVK  X17, #0x6e73, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x6600, LSL #0
    MOVK  X17, #0x11d0, LSL #16
    MOVK  X17, #0x7d4b, LSL #32
    MOVK  X17, #0x897f, LSL #48
    FMOV  X9, D27
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D28
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D29
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xb900, LSL #0
    FMOV  X9, D30
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X9, D31
    SUB  X4, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X6
    FMOV  V0.D[1], X17
    FMOV  D1, X3
    FMOV  V1.D[1], X13
    FMOV  D2, X25
    FMOV  V2.D[1], X27
    FMOV  D3, X29
    FMOV  V3.D[1], X4
    FMOV  D4, X16
    FMOV  V4.D[1], X19
    FMOV  D5, X24
    FMOV  V5.D[1], X21
    FMOV  D6, X28
    FMOV  V6.D[1], X23
    FMOV  D7, X19
    FMOV  V7.D[1], X17
    FMOV  D8, X13
    FMOV  V8.D[1], X17
    FMOV  D9, X25
    FMOV  V9.D[1], X15
    FMOV  D10, X5
    FMOV  V10.D[1], X6
    FMOV  D11, X12
    FMOV  V11.D[1], X12
    FMOV  D12, X8
    FMOV  V12.D[1], X28
    FMOV  D13, X18
    FMOV  V13.D[1], X21
    FMOV  D14, X5
    FMOV  V14.D[1], X15
    FMOV  D15, X16
    FMOV  V15.D[1], X23
    FMOV  D16, X17
    FMOV  V16.D[1], X17
    FMOV  D17, X2
    FMOV  V17.D[1], X24
    FMOV  D18, X23
    FMOV  V18.D[1], X4
    FMOV  D19, X10
    FMOV  V19.D[1], X19
    FMOV  D20, X29
    FMOV  V20.D[1], X4
    FMOV  D21, X28
    FMOV  V21.D[1], X23
    FMOV  D22, X19
    FMOV  V22.D[1], X15
    FMOV  D23, X25
    FMOV  V23.D[1], X19
    FMOV  D24, X8
    FMOV  V24.D[1], X14
    FMOV  D25, X21
    FMOV  V25.D[1], X27
    FMOV  D26, X6
    FMOV  V26.D[1], X28
    FMOV  D27, X4
    FMOV  V27.D[1], X4
    FMOV  D28, X14
    FMOV  V28.D[1], X10
    FMOV  D29, X21
    FMOV  V29.D[1], X18
    FMOV  D30, X24
    FMOV  V30.D[1], X24
    FMOV  D31, X3
    FMOV  V31.D[1], X15
    MOVZ  X13, #0xf, LSL #0
TSRTFloatMovMadd_label_1:
    FSUB  D29, D28, D22
    FDIV  D6, D26, D31
    FMOV  D3, D30
    FSUB  S11, S27, S29
    FDIV  D15, D11, D6
    FABS  S29, S15
    FNEG  D0, D25
    FSQRT  D19, D0
    FADD  S29, S19, S3
    FMADD  S7, S29, S29, S29
    FSUB  D0, D7, D7
    FMSUB  H10, H0, H0, H0
    FNMSUB  S15, S10, S10, S10
    FNMSUB  S23, S15, S15, S15
    FMOV  X15, D23
    FMADD  D6, D27, D24, D16
    FMUL  H27, H16, H2
    FMOV  H11, #-1.68750000
    FSUB  S15, S10, S5
    FCSEL  H0, H14, H13, LE
    FMOV  W16, H20
    FDIV  D13, D8, D5
    FNMSUB  D8, D18, D27, D5
    FMSUB  S23, S26, S24, S27
    FCSEL  D14, D2, D5, VC
    FMOV  X19, D22
    FSUB  H19, H3, H30
    FMADD  H28, H15, H15, H19
    FCSEL  H5, H23, H11, LE
    FABS  D20, D8
    FNEG  S16, S6
    FNMADD  D3, D16, D16, D11
    FMOV  S16, W2
    FMADD  D27, D13, D17, D13
    FSQRT  H26, H20
    FABS  D17, D26
    FADD  D2, D14, D16
    FDIV  D29, D5, D3
    FMOV  S10, S28
    FNMSUB  S11, S0, S27, S27
    FMSUB  D23, D10, D17, D2
    FMOV  H5, X12
    FMSUB  S13, S5, S29, S5
    FNMUL  D10, D11, D11
    FMOV  S27, #-6.00000000
    FMADD  D6, D27, D13, D23
    FCSEL  S30, S6, S6, CS
    FDIV  S14, S30, S30
    FMOV  W12, H10
    FNMSUB  S0, S28, S20, S8
    FMOV  D18, X16
    FMUL  S26, S27, S16
    FNEG  H8, H2
    FMOV  D30, D10
    FMOV  H13, H8
    FMOV  D11, D23
    FMSUB  H16, H11, H27, H8
    FMOV  H17, H4
    FMADD  D3, D20, D13, D29
    FNMUL  D27, D23, D18
    FMOV  D11, D24
    FMSUB  H23, H11, H30, H11
    FABS  D24, D14
    FSQRT  S6, S0
    FMOV  S11, S26
    FSQRT  H10, H23
    FMOV  H30, #25.00000000
    FMUL  D18, D16, D25
    FMOV  D14, X5
    FMUL  H26, H17, H27
    FMOV  S0, S3
    FABS  H5, H24
    FNMUL  D20, D10, D5
    FSQRT  H2, H18
    FCSEL  D23, D2, D26, LS
    FDIV  S8, S6, S23
    FMOV  D16, X25
    FDIV  H27, H16, H14
    FSQRT  H18, H20
    FMSUB  D24, D11, D0, D8
    FDIV  D29, D27, D27
    FNMADD  S20, S30, S29, S29
    FABS  D14, D24
    FMOV  H24, #0.45312500
    FMOV  W9, S0
    FNMADD  H6, H18, H30, H18
    FMOV  H16, H31
    FNMUL  S11, S6, S20
    FNEG  D27, D14
    FMSUB  S17, S27, S24, S24
    FMUL  D31, D17, D17
    FNMADD  S17, S31, S16, S31
    FNEG  D2, D11
    FMUL  S20, S31, S2
    FCSEL  D8, D17, D20, VC
    FNMADD  S6, S0, S29, S18
    FNMSUB  S17, S27, S14, S13
    FMOV  H3, W29
    FMADD  H14, H14, H4, H23
    FMOV  H11, #8.50000000
    FSQRT  H5, H10
    FSUB  D4, D18, D9
    FMOV  H10, H13
    FMUL  H30, H5, H10
    FADD  H16, H3, H28
    FCSEL  D14, D0, D30, NE
    FADD  H25, H4, H8
    FADD  S5, S6, S11
    FMOV  X18, D16
    FNMUL  H11, H14, H14
    FNMADD  H18, H5, H11, H17
    FDIV  S4, S25, S18
    FMOV  D28, D23
    FDIV  S27, S4, S15
    FMOV  D18, X12
    FMOV  D15, X18
    FMADD  D4, D26, D5, D14
    FMADD  S25, S13, S23, S23
    FNMSUB  H10, H11, H27, H8
    FMUL  H11, H15, H20
    FSUB  H16, H10, H16
    FABS  H6, H4
    FADD  S20, S25, S27
    FMADD  D4, D14, D6, D18
    FMSUB  H26, H19, H26, H8
    FMOV  X18, D11
    FMOV  D9, X12
    FMOV  W25, H12
    FSQRT  D10, D28
    FNMUL  H5, H1, H0
    FADD  D23, D25, D6
    FMOV  X2, H5
    FNMADD  H8, H27, H29, H6
    FMUL  D5, D6, D6
    FCSEL  H0, H10, H5, GE
    FDIV  H14, H16, H4
    FMADD  H5, H14, H23, H8
    FMOV  H13, W5
    FMOV  H6, W19
    FMUL  H28, H30, H26
    FMOV  W29, H28
    FMOV  X29, H6
    FNMSUB  D28, D6, D9, D20
    FMOV  X18, D5
    FMOV  D14, X29
    FNMADD  H11, H14, H15, H0
    FDIV  D19, D11, D13
    FSUB  H4, H19, H19
    FMSUB  D8, D28, D28, D28
    FNMSUB  H10, H4, H4, H8
    FABS  S30, S11
    FMOV  D28, #1.18750000
    FMOV  H9, X19
    FMOV  X23, H19
    FMSUB  D20, D15, D25, D26
    FCSEL  H19, H8, H1, MI
    FSUB  D4, D31, D27
    FMOV  W29, S30
    FMOV  S27, #1.62500000
    FMOV  H13, H7
    FMOV  S11, #23.00000000
    FNMADD  D25, D4, D11, D9
    FMUL  H26, H27, H13
    FMOV  H30, W25
    FABS  S8, S19
    FADD  D19, D10, D10
    FABS  S7, S26
    FMSUB  S9, S25, S30, S20
    FSUB  S10, S28, S9
    FSUB  H4, H19, H19
    FMOV  D6, #-14.50000000
    FDIV  S9, S6, S8
    FSQRT  S28, S9
    FMUL  H6, H28, H28
    FMOV  S20, S6
    FMADD  H11, H20, H20, H4
    FSUB  D31, D10, D10
    FADD  H4, H31, H7
    FNMUL  H19, H11, H4
    FCSEL  D25, D5, D18, MI
    FMSUB  D13, D13, D12, D5
    FABS  S8, S18
    FMUL  S27, S21, S21
    FSQRT  S12, S16
    FMOV  S31, W2
    FMUL  H30, H27, H14
    FCSEL  D5, D25, D20, AL
    FCSEL  S10, S29, S21, AL
    FNMUL  H26, H26, H26
    FDIV  D25, D19, D30
    FABS  D16, D26
    FSQRT  D27, D13
    FSQRT  H12, H16
    FMOV  X5, H12
    FMSUB  D12, D8, D31, D27
    FMOV  S7, #0.40625000
    FMOV  X14, D7
    FMADD  D7, D22, D12, D10
    FNEG  H18, H7
    FNMUL  H21, H18, H5
    SUBS  X13, X13, #0x1
    B.NE  TSRTFloatMovMadd_label_1
    MOVZ  X21, #0x8000, LSL #0
    SUB  X3, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x8000, LSL #0
    SUB  X3, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x3ed0, LSL #16
    SUB  X3, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x7e00, LSL #0
    SUB  X3, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    SUB  X3, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x8000, LSL #0
    SUB  X3, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x95, LSL #0
    MRS  X3, FPSR
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D0
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D1
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x8000, LSL #48
    FMOV  X3, D2
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x8000, LSL #0
    FMOV  X3, D3
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D5
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D6
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D7
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D8
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    FMOV  X3, D9
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D11
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D12
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D13
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D14
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D15
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x8000, LSL #0
    FMOV  X3, D16
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D17
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x8000, LSL #0
    FMOV  X3, D18
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x8000, LSL #0
    FMOV  X3, D19
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D20
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D21
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D22
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D23
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x3740, LSL #0
    FMOV  X3, D24
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7ff8, LSL #48
    FMOV  X3, D25
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x8000, LSL #0
    FMOV  X3, D26
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D27
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7fc0, LSL #16
    FMOV  X3, D28
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x7ff8, LSL #48
    FMOV  X3, D29
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, D30
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X21, #0x8000, LSL #0
    FMOV  X3, D31
    SUB  X11, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
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
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X10
    FMOV  V2.D[1], X18
    FMOV  D3, X24
    FMOV  V3.D[1], X19
    FMOV  D4, X13
    FMOV  V4.D[1], X8
    FMOV  D5, X29
    FMOV  V5.D[1], X17
    FMOV  D6, X13
    FMOV  V6.D[1], X27
    FMOV  D7, X19
    FMOV  V7.D[1], X16
    FMOV  D8, X8
    FMOV  V8.D[1], X3
    FMOV  D9, X16
    FMOV  V9.D[1], X19
    FMOV  D10, X25
    FMOV  V10.D[1], X24
    FMOV  D11, X12
    FMOV  V11.D[1], X11
    FMOV  D12, X18
    FMOV  V12.D[1], X29
    FMOV  D13, X8
    FMOV  V13.D[1], X14
    FMOV  D14, X8
    FMOV  V14.D[1], X3
    FMOV  D15, X10
    FMOV  V15.D[1], X29
    FMOV  D16, X4
    FMOV  V16.D[1], X12
    FMOV  D17, X19
    FMOV  V17.D[1], X25
    FMOV  D18, X6
    FMOV  V18.D[1], X11
    FMOV  D19, X14
    FMOV  V19.D[1], X4
    FMOV  D20, X18
    FMOV  V20.D[1], X24
    FMOV  D21, X27
    FMOV  V21.D[1], X10
    FMOV  D22, X13
    FMOV  V22.D[1], X25
    FMOV  D23, X23
    FMOV  V23.D[1], X4
    FMOV  D24, X4
    FMOV  V24.D[1], X18
    FMOV  D25, X23
    FMOV  V25.D[1], X8
    FMOV  D26, X18
    FMOV  V26.D[1], X27
    FMOV  D27, X8
    FMOV  V27.D[1], X13
    FMOV  D28, X27
    FMOV  V28.D[1], X15
    FMOV  D29, X23
    FMOV  V29.D[1], X10
    FMOV  D30, X21
    FMOV  V30.D[1], X28
    FMOV  D31, X23
    FMOV  V31.D[1], X3
    MOVZ  X28, #0xf, LSL #0
TSRTFloatMovMadd_label_2:
    FMOV  D22, D31
    FMSUB  H25, H30, H28, H28
    FABS  H5, H29
    FABS  S25, S24
    FNMSUB  D3, D26, D26, D5
    FMOV  W8, H22
    FDIV  S4, S3, S27
    FNMADD  D28, D4, D25, D4
    FMADD  H30, H28, H21, H23
    FDIV  H21, H4, H11
    FMOV  H29, H12
    FMSUB  H22, H28, H4, H14
    FSUB  S8, S18, S21
    FMOV  X23, H2
    FCSEL  D14, D26, D6, HI
    FSQRT  D31, D5
    FMOV  S11, W18
    FNEG  S6, S23
    FCSEL  D16, D14, D26, NV
    FMADD  H21, H6, H14, H28
    FMUL  D23, D17, D19
    FABS  H26, H8
    FMUL  D5, D30, D23
    FNMUL  H30, H16, H5
    FCSEL  H12, H30, H8, GT
    FSUB  S28, S21, S12
    FSUB  H16, H11, H28
    FMOV  W18, H29
    FNMADD  S17, S26, S22, S22
    FNMUL  H5, H17, H31
    FMOV  D2, #1.56250000
    FABS  D14, D5
    FDIV  S11, S16, S2
    FDIV  H18, H11, H22
    FNMADD  D26, D14, D14, D30
    FMSUB  D6, D26, D26, D26
    FMOV  S27, #-0.26562500
    FNEG  S23, S27
    FNMADD  S31, S19, S6, S6
    FMOV  S4, S31
    FMUL  D31, D23, D10
    FMUL  S26, S31, S18
    FNMUL  S8, S26, S26
    FNMUL  H26, H8, H8
    FSUB  D5, D4, D26
    FMSUB  D19, D8, D14, D10
    FNMSUB  H6, H4, H20, H9
    FDIV  D27, D10, D13
    FMSUB  S17, S12, S25, S4
    FMUL  S29, S17, S27
    FMOV  H26, #1.87500000
    FNMADD  S30, S20, S6, S20
    FDIV  S20, S31, S26
    FMOV  D31, X3
    FCSEL  S23, S13, S18, VC
    FNEG  D25, D28
    FMOV  S14, W23
    FSQRT  D27, D5
    FADD  D13, D31, D14
    FMOV  X15, D13
    FMADD  S26, S27, S19, S29
    FSUB  H8, H26, H20
    FMOV  H12, W25
    FNMSUB  D11, D12, D23, D25
    FMOV  X29, H30
    FMOV  D30, #-12.00000000
    FMSUB  H28, H8, H30, H8
    FSUB  H9, H28, H28
    FCSEL  D4, D9, D9, CC
    FSQRT  H28, H14
    FSUB  S23, S28, S4
    FMUL  H12, H23, H19
    FMSUB  S31, S12, S11, S11
    FMOV  D27, D9
    FSUB  S18, S31, S15
    FABS  S6, S9
    FABS  H14, H31
    FCSEL  H17, H27, H5, PL
    FSUB  H15, H28, H6
    FMADD  D26, D9, D31, D23
    FNMADD  S19, S31, S24, S0
    FMADD  S4, S16, S7, S21
    FMUL  H16, H28, H12
    FADD  D31, D13, D21
    FSQRT  S27, S31
    FCSEL  H8, H18, H18, HI
    FMSUB  H11, H8, H3, H16
    FMUL  D5, D11, D14
    FDIV  D13, D5, D5
    FMUL  S6, S4, S17
    FADD  S17, S26, S15
    FABS  S8, S13
    FMOV  H25, H17
    FNMUL  S23, S19, S8
    FCSEL  H26, H27, H6, CC
    FMOV  W24, S20
    FNMUL  H17, H25, H26
    FNMUL  D28, D17, D23
    FABS  D14, D31
    FNMSUB  H0, H16, H25, H1
    FMOV  D17, X11
    FMADD  D11, D28, D20, D25
    FMOV  H27, H15
    FSUB  D5, D24, D1
    FMOV  X15, D27
    FSQRT  D4, D23
    FMOV  X19, H6
    FMUL  D26, D16, D11
    FMOV  H3, #27.00000000
    FSQRT  S27, S1
    FMOV  D15, X24
    FMOV  X23, H14
    FMOV  H14, X6
    FMOV  W3, H4
    FMOV  H6, #30.00000000
    FNMUL  H18, H26, H3
    FADD  H11, H15, H31
    FMOV  X4, H27
    FMUL  S16, S11, S14
    FNMADD  H3, H18, H0, H18
    FNMADD  D1, D16, D6, D5
    FMOV  X23, H1
    FMOV  S31, #0.50000000
    FNMUL  D19, D3, D3
    FABS  H4, H17
    FSUB  H1, H19, H31
    FMOV  X17, D1
    FNMSUB  S26, S7, S1, S26
    FDIV  S20, S25, S2
    FMUL  S2, S29, S17
    FCSEL  H11, H24, H20, AL
    FMADD  H18, H5, H22, H8
    FABS  S15, S10
    FADD  S14, S31, S6
    FMOV  X17, D15
    FMUL  S19, S1, S12
    FMOV  X9, D21
    FADD  S16, S29, S14
    FNMSUB  D3, D10, D15, D29
    FSQRT  D24, D19
    FNMUL  S22, S13, S27
    FADD  S12, S16, S15
    FMSUB  D20, D12, D3, D3
    FMUL  S31, S11, S26
    FMUL  S15, S18, S22
    FMOV  S27, S24
    FNMUL  S0, S2, S4
    FMOV  D30, D0
    FMOV  X6, H20
    FMADD  D17, D15, D15, D27
    FMOV  H6, X5
    FMUL  H15, H31, H17
    FNMSUB  H31, H6, H30, H15
    FMOV  H17, #0.43750000
    FNMSUB  S11, S1, S5, S28
    FMADD  H0, H21, H17, H20
    FSQRT  S1, S22
    FMOV  X8, H9
    FDIV  D22, D27, D11
    FABS  H15, H5
    FNMADD  S6, S12, S11, S9
    FNMADD  D4, D7, D15, D8
    FMOV  D15, #-0.28125000
    FMOV  H19, X9
    FMOV  X11, H17
    FMUL  H30, H3, H13
    FMADD  H12, H15, H15, H30
    FCSEL  S17, S6, S4, VS
    FABS  H7, H31
    FNMUL  S21, S12, S1
    FMUL  S8, S0, S0
    FNEG  D28, D7
    FADD  D15, D28, D28
    FNMSUB  D7, D15, D22, D21
    FMOV  H0, X3
    FDIV  H9, H0, H0
    FMOV  D5, D8
    FABS  H15, H7
    FSQRT  H6, H9
    FMOV  W23, H17
    FMUL  S12, S19, S6
    FNMADD  D0, D12, D2, D5
    FNEG  S11, S0
    FNMUL  H1, H11, H15
    FCSEL  S30, S13, S4, PL
    FCSEL  H4, H4, H21, NV
    FDIV  D31, D31, D10
    FNMUL  S21, S3, S31
    FMOV  W19, H13
    FMOV  S5, W21
    FSUB  S11, S4, S31
    FNMSUB  H17, H3, H26, H31
    FSUB  H22, H7, H20
    FDIV  D28, D28, D25
    FABS  D22, D25
    FMUL  S10, S1, S6
    FABS  S12, S5
    FMSUB  D8, D14, D31, D22
    FNEG  S3, S25
    FMOV  S5, W21
    SUBS  X28, X28, #0x1
    B.NE  TSRTFloatMovMadd_label_2
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x3700, LSL #0
    SUB  X27, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0xffff, LSL #0
    SUB  X27, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7fc0, LSL #16
    SUB  X27, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    MOVK  X10, #0xffff, LSL #32
    MOVK  X10, #0xffff, LSL #48
    SUB  X27, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    SUB  X27, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x95, LSL #0
    MRS  X27, FPSR
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V0.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #48
    FMOV  X27, D0
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V1.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x8000, LSL #0
    FMOV  X27, D1
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    FMOV  X27, D2
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    FMOV  X27, D3
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V4.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D4
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0xffff, LSL #16
    FMOV  X27, D5
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    FMOV  X27, D6
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V7.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    FMOV  X27, D7
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    FMOV  X27, D8
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x7e00, LSL #0
    FMOV  X27, D9
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V10.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D10
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D11
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V12.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0xffff, LSL #0
    MOVK  X10, #0x7fff, LSL #16
    FMOV  X27, D12
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    FMOV  X27, D13
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3f00, LSL #16
    FMOV  X27, D14
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D15
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x3f00, LSL #16
    FMOV  X27, D16
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D17
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V18.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D18
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V19.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D19
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V20.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D20
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    FMOV  X27, D21
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D22
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D23
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D24
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D25
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D26
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D27
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    FMOV  X27, D28
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x8000, LSL #16
    FMOV  X27, D29
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V30.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, D30
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x7ff8, LSL #48
    FMOV  X27, D31
    SUB  X14, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x759a, LSL #0
    MOVK  X2, #0xa13f, LSL #16
    MOVK  X2, #0x456b, LSL #32
    MOVK  X2, #0x99e2, LSL #48
    MOVZ  X3, #0xa659, LSL #0
    MOVK  X3, #0x5ed, LSL #16
    MOVK  X3, #0xc373, LSL #32
    MOVK  X3, #0x633f, LSL #48
    MOVZ  X4, #0xf48e, LSL #0
    MOVK  X4, #0x3b38, LSL #16
    MOVK  X4, #0xcee0, LSL #32
    MOVK  X4, #0x4cb5, LSL #48
    MOVZ  X5, #0x8689, LSL #0
    MOVK  X5, #0xc4b8, LSL #16
    MOVK  X5, #0xb61c, LSL #32
    MOVK  X5, #0x98d3, LSL #48
    MOVZ  X6, #0xd12f, LSL #0
    MOVK  X6, #0xa090, LSL #16
    MOVK  X6, #0x69c8, LSL #32
    MOVK  X6, #0xf9dc, LSL #48
    MOVZ  X8, #0xb52c, LSL #0
    MOVK  X8, #0xd6ca, LSL #16
    MOVK  X8, #0xed09, LSL #32
    MOVK  X8, #0x46f6, LSL #48
    MOVZ  X9, #0xdb4e, LSL #0
    MOVK  X9, #0xeb4, LSL #16
    MOVK  X9, #0x60f2, LSL #32
    MOVK  X9, #0x31b5, LSL #48
    MOVZ  X10, #0x4cbe, LSL #0
    MOVK  X10, #0x168a, LSL #16
    MOVK  X10, #0x5011, LSL #32
    MOVK  X10, #0xfdb5, LSL #48
    MOVZ  X11, #0x71a3, LSL #0
    MOVK  X11, #0x9e6a, LSL #16
    MOVK  X11, #0x489b, LSL #32
    MOVK  X11, #0xdfc2, LSL #48
    MOVZ  X12, #0x7f69, LSL #0
    MOVK  X12, #0x4823, LSL #16
    MOVK  X12, #0xe58d, LSL #32
    MOVK  X12, #0x5c3f, LSL #48
    MOVZ  X13, #0x1e61, LSL #0
    MOVK  X13, #0x26e4, LSL #16
    MOVK  X13, #0xcee, LSL #32
    MOVK  X13, #0xcc98, LSL #48
    MOVZ  X14, #0xa836, LSL #0
    MOVK  X14, #0xf1e6, LSL #16
    MOVK  X14, #0xa637, LSL #32
    MOVK  X14, #0x3bcc, LSL #48
    MOVZ  X15, #0x4fdf, LSL #0
    MOVK  X15, #0xf15, LSL #16
    MOVK  X15, #0xc779, LSL #32
    MOVK  X15, #0x7f5d, LSL #48
    MOVZ  X16, #0x3481, LSL #0
    MOVK  X16, #0x547b, LSL #16
    MOVK  X16, #0xccf9, LSL #32
    MOVK  X16, #0x36a6, LSL #48
    MOVZ  X17, #0xe626, LSL #0
    MOVK  X17, #0x62df, LSL #16
    MOVK  X17, #0xa60, LSL #32
    MOVK  X17, #0xc91c, LSL #48
    MOVZ  X18, #0x1715, LSL #0
    MOVK  X18, #0x6023, LSL #16
    MOVK  X18, #0x7462, LSL #32
    MOVK  X18, #0x11e6, LSL #48
    MOVZ  X19, #0x6641, LSL #0
    MOVK  X19, #0x46b0, LSL #16
    MOVK  X19, #0xce15, LSL #32
    MOVK  X19, #0xdc99, LSL #48
    MOVZ  X21, #0x852f, LSL #0
    MOVK  X21, #0xd88b, LSL #16
    MOVK  X21, #0x10fb, LSL #32
    MOVK  X21, #0x9ad5, LSL #48
    MOVZ  X23, #0x4446, LSL #0
    MOVK  X23, #0x4c81, LSL #16
    MOVK  X23, #0x610, LSL #32
    MOVK  X23, #0x82b7, LSL #48
    MOVZ  X24, #0xfd69, LSL #0
    MOVK  X24, #0x9682, LSL #16
    MOVK  X24, #0x187c, LSL #32
    MOVK  X24, #0x49b2, LSL #48
    MOVZ  X25, #0x6b62, LSL #0
    MOVK  X25, #0x7143, LSL #16
    MOVK  X25, #0xbbf2, LSL #32
    MOVK  X25, #0x4570, LSL #48
    MOVZ  X27, #0x9d4a, LSL #0
    MOVK  X27, #0x28a0, LSL #16
    MOVK  X27, #0xad17, LSL #32
    MOVK  X27, #0x608f, LSL #48
    MOVZ  X28, #0xf0ee, LSL #0
    MOVK  X28, #0x8997, LSL #16
    MOVK  X28, #0x8931, LSL #32
    MOVK  X28, #0x19c5, LSL #48
    MOVZ  X29, #0x88f9, LSL #0
    MOVK  X29, #0x1603, LSL #16
    MOVK  X29, #0xe40, LSL #32
    MOVK  X29, #0xfbb0, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X21
    FMOV  V1.D[1], X29
    FMOV  D2, X23
    FMOV  V2.D[1], X28
    FMOV  D3, X2
    FMOV  V3.D[1], X15
    FMOV  D4, X2
    FMOV  V4.D[1], X25
    FMOV  D5, X14
    FMOV  V5.D[1], X5
    FMOV  D6, X24
    FMOV  V6.D[1], X13
    FMOV  D7, X9
    FMOV  V7.D[1], X10
    FMOV  D8, X21
    FMOV  V8.D[1], X29
    FMOV  D9, X4
    FMOV  V9.D[1], X18
    FMOV  D10, X15
    FMOV  V10.D[1], X14
    FMOV  D11, X8
    FMOV  V11.D[1], X28
    FMOV  D12, X13
    FMOV  V12.D[1], X18
    FMOV  D13, X10
    FMOV  V13.D[1], X13
    FMOV  D14, X13
    FMOV  V14.D[1], X4
    FMOV  D15, X11
    FMOV  V15.D[1], X13
    FMOV  D16, X21
    FMOV  V16.D[1], X17
    FMOV  D17, X18
    FMOV  V17.D[1], X9
    FMOV  D18, X29
    FMOV  V18.D[1], X4
    FMOV  D19, X24
    FMOV  V19.D[1], X8
    FMOV  D20, X5
    FMOV  V20.D[1], X21
    FMOV  D21, X12
    FMOV  V21.D[1], X12
    FMOV  D22, X19
    FMOV  V22.D[1], X24
    FMOV  D23, X18
    FMOV  V23.D[1], X23
    FMOV  D24, X24
    FMOV  V24.D[1], X19
    FMOV  D25, X29
    FMOV  V25.D[1], X17
    FMOV  D26, X16
    FMOV  V26.D[1], X19
    FMOV  D27, X21
    FMOV  V27.D[1], X25
    FMOV  D28, X18
    FMOV  V28.D[1], X28
    FMOV  D29, X13
    FMOV  V29.D[1], X2
    FMOV  D30, X23
    FMOV  V30.D[1], X21
    FMOV  D31, X14
    FMOV  V31.D[1], X19
    MOVZ  X28, #0xf, LSL #0
TSRTFloatMovMadd_label_3:
    FDIV  H9, H31, H30
    FNMUL  S31, S24, S9
    FMSUB  H10, H26, H18, H26
    FDIV  S14, S25, S31
    FABS  D21, D28
    FMOV  X24, D10
    FNMUL  H21, H29, H29
    FCSEL  S7, S27, S23, VC
    FMSUB  S26, S21, S7, S21
    FMUL  D27, D22, D26
    FABS  S24, S27
    FMOV  W13, H24
    FMADD  D31, D9, D4, D4
    FMUL  S10, S14, S14
    FNMSUB  D24, D1, D7, D9
    FNEG  D25, D23
    FNMUL  H22, H28, H15
    FNEG  S23, S30
    FCSEL  H2, H17, H8, AL
    FMOV  S8, S17
    FNMUL  H29, H3, H2
    FMSUB  D2, D5, D14, D30
    FCSEL  D18, D31, D23, AL
    FMOV  S4, S10
    FMOV  S15, W11
    FMADD  H21, H18, H8, H29
    FNMSUB  H30, H4, H21, H1
    FMOV  D14, X8
    FNMSUB  S7, S14, S15, S22
    FSQRT  D27, D24
    FNMADD  D15, D27, D30, D27
    FNEG  S29, S2
    FADD  D10, D25, D15
    FMOV  W21, S7
    FMSUB  S5, S29, S10, S10
    FSUB  H2, H29, H7
    FCSEL  S30, S18, S4, VC
    FADD  S27, S1, S26
    FNMUL  H22, H29, H22
    FMSUB  H21, H5, H7, H12
    FNMSUB  S8, S2, S17, S30
    FMSUB  H31, H9, H16, H9
    FADD  H23, H6, H20
    FABS  D15, D23
    FDIV  S20, S20, S14
    FMSUB  H4, H15, H10, H11
    FSQRT  D2, D3
    FNMADD  S22, S28, S19, S17
    FMUL  D15, D10, D26
    FMOV  X18, H30
    FDIV  S28, S27, S31
    FNMUL  S18, S21, S4
    FADD  H11, H18, H8
    FSQRT  H7, H11
    FABS  H11, H7
    FMADD  S7, S2, S6, S11
    FCSEL  S14, S7, S22, GT
    FNMADD  S5, S15, S15, S14
    FMOV  H23, W9
    FMOV  D8, D23
    FCSEL  H3, H20, H8, AL
    FMSUB  S18, S28, S25, S28
    FMOV  X8, D3
    FMOV  W12, S18
    FDIV  H18, H3, H22
    FSQRT  D23, D1
    FMOV  H7, W6
    FCSEL  H14, H16, H8, LS
    FSQRT  D1, D0
    FNMSUB  H11, H8, H29, H3
    FMOV  H8, X3
    FMOV  H22, W16
    FMOV  H25, X11
    FADD  D29, D23, D8
    FMADD  H16, H1, H5, H18
    FMOV  X8, H25
    FMOV  H15, #0.34375000
    FMOV  X24, H14
    FMOV  H5, H25
    FADD  S23, S11, S7
    FADD  H28, H26, H29
    FSUB  S8, S5, S22
    FNMSUB  H5, H16, H15, H15
    FMSUB  H0, H5, H5, H23
    FMUL  S16, S0, S28
    FDIV  S25, S12, S16
    FMOV  H20, #13.00000000
    FMOV  H15, #7.75000000
    FNEG  H14, H8
    FNEG  D22, D15
    FSQRT  S15, S25
    FNEG  S5, S30
    FSUB  H11, H15, H5
    FSQRT  H26, H11
    FCSEL  S3, S20, S5, VS
    FNMUL  S15, S28, S3
    FNEG  S30, S15
    FMOV  S18, W9
    FMOV  D11, X6
    FSUB  H16, H22, H11
    FMADD  H12, H18, H18, H14
    FDIV  S1, S12, S16
    FSUB  D15, D26, D1
    FDIV  H22, H15, H30
    FMUL  D8, D0, D9
    FDIV  D1, D31, D16
    FMOV  S28, W11
    FMADD  D14, D23, D3, D27
    FNMADD  D31, D23, D8, D10
    FMOV  S26, #3.75000000
    FADD  H12, H22, H4
    FDIV  H25, H30, H26
    FNMADD  S15, S19, S15, S27
    FDIV  H3, H8, H23
    FMOV  S11, S12
    FABS  S23, S5
    FNEG  H20, H1
    FMOV  S5, W10
    FNMUL  H10, H5, H25
    FADD  S25, S10, S31
    FMOV  S16, S28
    FNMUL  D12, D16, D25
    FDIV  H30, H23, H23
    FABS  H9, H30
    FNEG  S4, S9
    FNMADD  H1, H4, H15, H12
    FMUL  S27, S1, S20
    FNMUL  H9, H14, H3
    FSQRT  H16, H27
    FMOV  S1, S11
    FSQRT  S11, S9
    FNEG  S23, S11
    FMOV  H25, H23
    FCSEL  D22, D16, D25, AL
    FMOV  S25, #-20.00000000
    FMOV  X21, D22
    FSUB  S9, S1, S1
    FMUL  S8, S25, S20
    FMOV  W9, S8
    FDIV  H28, H16, H22
    FCSEL  D30, D21, D12, CS
    FADD  D27, D15, D18
    FDIV  D20, D29, D11
    FNMADD  D8, D16, D16, D11
    FMOV  H3, X23
    FNMUL  H12, H27, H29
    FSQRT  H21, H2
    FNEG  D27, D24
    FMOV  D10, #0.24218750
    FNMADD  D23, D12, D28, D21
    FSUB  S15, S9, S30
    FMUL  H30, H3, H3
    FSUB  S16, S11, S10
    FSQRT  H2, H20
    FMADD  H1, H16, H2, H8
    FCSEL  S18, S1, S15, GT
    FMUL  D14, D30, D27
    FCSEL  H29, H23, H14, MI
    FMSUB  S22, S18, S29, S29
    FCSEL  H24, H17, H13, LE
    FMADD  D21, D23, D16, D8
    FCSEL  S28, S7, S10, LE
    FMOV  H12, #0.17968750
    FNEG  H3, H0
    FMOV  D23, #-1.37500000
    FMOV  H25, H8
    FMOV  S8, #-2.37500000
    FSQRT  H2, H21
    FABS  H21, H12
    FNMUL  D29, D21, D21
    FMADD  S10, S29, S22, S23
    FABS  D29, D8
    FMOV  S15, #0.14062500
    FNMADD  H0, H15, H28, H24
    FDIV  H17, H2, H2
    FNEG  S22, S29
    FMADD  S14, S22, S3, S10
    FMUL  H2, H14, H25
    FCSEL  S22, S2, S0, GT
    FDIV  D7, D17, D22
    FDIV  H1, H17, H17
    FCSEL  D13, D10, D21, VS
    FMOV  S24, #-0.15625000
    FMUL  S2, S15, S11
    FSUB  D22, D24, D19
    FNMADD  H27, H30, H7, H18
    FNMADD  D11, D16, D14, D17
    FNMSUB  D29, D19, D18, D18
    FSUB  H15, H12, H30
    FADD  S28, S29, S6
    FMOV  W25, H23
    FNMUL  D19, D3, D16
    FMOV  S21, W21
    FNMSUB  D25, D19, D7, D19
    FMSUB  H0, H28, H25, H11
    FABS  S10, S15
    FADD  D28, D10, D27
    FSUB  S11, S13, S2
    FNMSUB  S2, S21, S22, S1
    FMOV  S22, #-9.00000000
    SUBS  X28, X28, #0x1
    B.NE  TSRTFloatMovMadd_label_3
    MOVZ  X2, #0xa659, LSL #0
    MOVK  X2, #0x5ed, LSL #16
    MOVK  X2, #0xc373, LSL #32
    MOVK  X2, #0x633f, LSL #48
    SUB  X15, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x8689, LSL #0
    MOVK  X2, #0xc4b8, LSL #16
    MOVK  X2, #0xb61c, LSL #32
    MOVK  X2, #0x98d3, LSL #48
    SUB  X15, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xd12f, LSL #0
    MOVK  X2, #0xa090, LSL #16
    MOVK  X2, #0x69c8, LSL #32
    MOVK  X2, #0xf9dc, LSL #48
    SUB  X15, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x71a3, LSL #0
    SUB  X15, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #16
    SUB  X15, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x4cbe, LSL #0
    MOVK  X2, #0x168a, LSL #16
    MOVK  X2, #0x5011, LSL #32
    MOVK  X2, #0xfdb5, LSL #48
    SUB  X15, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x71a3, LSL #0
    MOVK  X2, #0x9e6a, LSL #16
    MOVK  X2, #0x489b, LSL #32
    MOVK  X2, #0xdfc2, LSL #48
    SUB  X15, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7fc0, LSL #16
    SUB  X15, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xa836, LSL #0
    MOVK  X2, #0xf1e6, LSL #16
    MOVK  X2, #0xa637, LSL #32
    MOVK  X2, #0x3bcc, LSL #48
    SUB  X15, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x3481, LSL #0
    MOVK  X2, #0x547b, LSL #16
    MOVK  X2, #0xccf9, LSL #32
    MOVK  X2, #0x36a6, LSL #48
    SUB  X15, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xe626, LSL #0
    MOVK  X2, #0x62df, LSL #16
    MOVK  X2, #0xa60, LSL #32
    MOVK  X2, #0xc91c, LSL #48
    SUB  X15, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x6641, LSL #0
    MOVK  X2, #0x46b0, LSL #16
    MOVK  X2, #0xce15, LSL #32
    MOVK  X2, #0xdc99, LSL #48
    SUB  X15, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x4446, LSL #0
    MOVK  X2, #0x4c81, LSL #16
    MOVK  X2, #0x610, LSL #32
    MOVK  X2, #0x82b7, LSL #48
    SUB  X15, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x9d4a, LSL #0
    MOVK  X2, #0x28a0, LSL #16
    MOVK  X2, #0xad17, LSL #32
    MOVK  X2, #0x608f, LSL #48
    SUB  X15, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    SUB  X15, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x88f9, LSL #0
    MOVK  X2, #0x1603, LSL #16
    MOVK  X2, #0xe40, LSL #32
    MOVK  X2, #0xfbb0, LSL #48
    SUB  X15, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x9f, LSL #0
    MRS  X15, FPSR
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x7e00, LSL #0
    FMOV  X15, D0
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x7e00, LSL #0
    FMOV  X15, D1
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, D2
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xfe00, LSL #0
    FMOV  X15, D3
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x7e00, LSL #0
    MOVK  X2, #0x8000, LSL #16
    FMOV  X15, D4
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x4cbe, LSL #0
    MOVK  X2, #0x168a, LSL #16
    FMOV  X15, D5
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x1e61, LSL #0
    MOVK  X2, #0x26e4, LSL #16
    MOVK  X2, #0xcee, LSL #32
    MOVK  X2, #0xcc98, LSL #48
    FMOV  X15, V6.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xfd69, LSL #0
    MOVK  X2, #0x9682, LSL #16
    MOVK  X2, #0x187c, LSL #32
    MOVK  X2, #0x49b2, LSL #48
    FMOV  X15, D6
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff8, LSL #48
    FMOV  X15, D7
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xc018, LSL #16
    FMOV  X15, D8
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, D9
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xcc84, LSL #0
    FMOV  X15, D10
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, D11
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x31c0, LSL #0
    FMOV  X15, D12
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x31c0, LSL #0
    FMOV  X15, D13
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, D14
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xcc84, LSL #0
    FMOV  X15, D15
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, D16
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x7e00, LSL #0
    FMOV  X15, D17
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, D18
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #48
    FMOV  X15, D19
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff8, LSL #48
    FMOV  X15, D20
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, D21
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xc110, LSL #16
    FMOV  X15, D22
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xbff6, LSL #48
    FMOV  X15, D23
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xbe20, LSL #16
    FMOV  X15, D24
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x7ff8, LSL #48
    FMOV  X15, D25
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x4070, LSL #16
    FMOV  X15, D26
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x8000, LSL #0
    FMOV  X15, D27
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, D28
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x8000, LSL #48
    FMOV  X15, D29
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x4c90, LSL #0
    FMOV  X15, D30
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0xbff6, LSL #48
    FMOV  X15, D31
    SUB  X4, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X10
    FMOV  V0.D[1], X25
    FMOV  D1, X4
    FMOV  V1.D[1], X24
    FMOV  D2, X21
    FMOV  V2.D[1], X23
    FMOV  D3, X15
    FMOV  V3.D[1], X19
    FMOV  D4, X13
    FMOV  V4.D[1], X11
    FMOV  D5, X29
    FMOV  V5.D[1], X18
    FMOV  D6, X27
    FMOV  V6.D[1], X17
    FMOV  D7, X28
    FMOV  V7.D[1], X14
    FMOV  D8, X25
    FMOV  V8.D[1], X16
    FMOV  D9, X23
    FMOV  V9.D[1], X29
    FMOV  D10, X6
    FMOV  V10.D[1], X28
    FMOV  D11, X29
    FMOV  V11.D[1], X25
    FMOV  D12, X21
    FMOV  V12.D[1], X4
    FMOV  D13, X10
    FMOV  V13.D[1], X9
    FMOV  D14, X18
    FMOV  V14.D[1], X8
    FMOV  D15, X29
    FMOV  V15.D[1], X12
    FMOV  D16, X25
    FMOV  V16.D[1], X23
    FMOV  D17, X18
    FMOV  V17.D[1], X13
    FMOV  D18, X19
    FMOV  V18.D[1], X11
    FMOV  D19, X2
    FMOV  V19.D[1], X5
    FMOV  D20, X23
    FMOV  V20.D[1], X16
    FMOV  D21, X15
    FMOV  V21.D[1], X10
    FMOV  D22, X14
    FMOV  V22.D[1], X8
    FMOV  D23, X6
    FMOV  V23.D[1], X2
    FMOV  D24, X24
    FMOV  V24.D[1], X11
    FMOV  D25, X19
    FMOV  V25.D[1], X18
    FMOV  D26, X8
    FMOV  V26.D[1], X17
    FMOV  D27, X8
    FMOV  V27.D[1], X21
    FMOV  D28, X29
    FMOV  V28.D[1], X23
    FMOV  D29, X11
    FMOV  V29.D[1], X3
    FMOV  D30, X16
    FMOV  V30.D[1], X6
    FMOV  D31, X25
    FMOV  V31.D[1], X27
    MOVZ  X13, #0xf, LSL #0
TSRTFloatMovMadd_label_4:
    FNMUL  D20, D28, D17
    FCSEL  H30, H21, H20, LS
    FSQRT  D3, D24
    FADD  S14, S26, S29
    FABS  D21, D19
    FMOV  X2, D3
    FADD  H7, H31, H23
    FMOV  H15, W9
    FMOV  D2, X2
    FCSEL  H28, H30, H25, GT
    FNMADD  S7, S27, S7, S2
    FABS  H24, H15
    FNMUL  H25, H24, H7
    FSUB  H8, H21, H28
    FNEG  D20, D14
    FMUL  S29, S8, S25
    FMUL  H21, H29, H20
    FNMADD  H31, H31, H16, H26
    FMSUB  H19, H15, H21, H4
    FMOV  H4, X5
    FMOV  W5, S13
    FADD  S13, S16, S19
    FNMADD  S23, S25, S13, S18
    FNMSUB  S29, S10, S29, S18
    FMADD  H10, H26, H19, H29
    FNMUL  H30, H25, H17
    FDIV  S25, S0, S20
    FMSUB  S20, S14, S20, S29
    FNMADD  H21, H4, H6, H25
    FMUL  D24, D30, D24
    FMOV  S19, #1.43750000
    FCSEL  D17, D8, D27, CS
    FDIV  D2, D25, D3
    FMUL  S0, S20, S31
    FNMUL  S4, S17, S23
    FMOV  S26, S21
    FNMADD  D18, D26, D19, D4
    FMOV  S30, S0
    FADD  D29, D18, D18
    FDIV  H18, H2, H29
    FSQRT  D27, D10
    FSQRT  D20, D24
    FNEG  S17, S30
    FSQRT  H8, H10
    FMOV  D6, D18
    FMADD  H18, H6, H6, H27
    FSQRT  D14, D20
    FMOV  W5, S17
    FSQRT  S4, S14
    FCSEL  H14, H20, H4, PL
    FMADD  S3, S8, S8, S18
    FSQRT  S20, S18
    FMOV  H13, H16
    FMSUB  S30, S14, S14, S13
    FMOV  X2, D20
    FNEG  H0, H30
    FMSUB  D10, D3, D3, D3
    FDIV  D18, D10, D0
    FABS  D10, D29
    FNEG  H16, H13
    FMUL  S20, S24, S15
    FMOV  H29, X24
    FNMADD  S24, S8, S17, S24
    FMOV  S3, S21
    FNEG  D17, D17
    FNMUL  H8, H13, H26
    FMSUB  H19, H17, H10, H24
    FMADD  D0, D20, D3, D18
    FMOV  W24, S16
    FNMADD  H14, H29, H8, H29
    FMOV  D24, X3
    FMOV  X12, H19
    FSUB  S4, S0, S24
    FCSEL  H0, H4, H4, CS
    FMOV  D16, X5
    FMSUB  S17, S16, S9, S16
    FABS  D30, D17
    FADD  S10, S14, S0
    FNMUL  S21, S30, S30
    FNMADD  S13, S21, S21, S10
    FSQRT  D17, D7
    FNEG  H15, H19
    FSQRT  H26, H21
    FMADD  S7, S7, S9, S9
    FCSEL  S8, S10, S0, AL
    FMOV  H21, H3
    FMADD  H10, H12, H30, H29
    FMADD  S24, S20, S14, S4
    FMSUB  D29, D8, D26, D15
    FNMSUB  H18, H13, H17, H7
    FDIV  S3, S18, S21
    FMOV  X14, H3
    FMADD  D4, D10, D4, D29
    FDIV  S30, S24, S24
    FADD  D5, D4, D4
    FNEG  D12, D5
    FMUL  D5, D12, D20
    FMADD  S9, S30, S30, S30
    FMOV  S26, S5
    FNMSUB  D16, D9, D9, D9
    FMUL  S20, S26, S16
    FNMUL  D4, D1, D17
    FDIV  S13, S14, S1
    FNEG  H26, H29
    FMOV  H8, #-0.75000000
    FMSUB  H17, H31, H22, H17
    FSQRT  D12, D16
    FABS  D3, D25
    FNMUL  H22, H0, H6
    FSUB  S10, S12, S22
    FNMUL  D18, D8, D13
    FMUL  S31, S10, S4
    FMOV  H5, W15
    FMOV  H0, X27
    FMUL  H13, H3, H0
    FMADD  S0, S18, S3, S17
    FSQRT  H10, H16
    FABS  D29, D31
    FNEG  S31, S13
    FDIV  S17, S0, S26
    FMOV  H21, H10
    FDIV  S0, S5, S20
    FMUL  S16, S0, S0
    FSUB  H26, H31, H29
    FSQRT  S0, S26
    FABS  D18, D0
    FMOV  W8, S17
    FABS  D13, D16
    FNMSUB  S4, S18, S21, S9
    FNEG  D29, D13
    FMOV  S0, W14
    FMOV  W27, H0
    FMOV  S14, W9
    FSQRT  D3, D4
    FMOV  X14, D29
    FNEG  H10, H3
    FNEG  S5, S14
    FDIV  S13, S5, S5
    FSQRT  H9, H13
    FMSUB  H21, H9, H9, H10
    FMADD  D17, D25, D25, D11
    FCSEL  H20, H14, H4, VS
    FMOV  D16, #11.00000000
    FMOV  H23, H10
    FDIV  S18, S19, S5
    FMOV  W18, S12
    FMSUB  H12, H7, H7, H0
    FNMUL  S13, S16, S25
    FMADD  H4, H12, H14, H9
    FMOV  X8, H19
    FMOV  W15, S25
    FSUB  S0, S25, S25
    FABS  S11, S9
    FNMSUB  S31, S23, S4, S11
    FMUL  H4, H17, H17
    FMSUB  H10, H31, H4, H13
    FMOV  X29, H10
    FNMSUB  S5, S0, S0, S21
    FNMSUB  S10, S5, S28, S20
    FMOV  H11, #-13.00000000
    FNMUL  H17, H18, H18
    FMOV  H23, #0.53125000
    FSUB  S13, S10, S23
    FNMADD  D19, D13, D11, D11
    FMOV  D9, #0.65625000
    FMOV  S18, S17
    FMOV  W21, S18
    FMSUB  S23, S9, S9, S19
    FSUB  H11, H10, H13
    FMOV  D12, D8
    FSQRT  H9, H24
    FNMUL  H24, H9, H5
    FMOV  X12, H10
    FNEG  D5, D2
    FDIV  H21, H22, H5
    FNMUL  S28, S14, S12
    FMOV  D19, D10
    FNMADD  S22, S20, S14, S26
    FCSEL  D2, D1, D26, PL
    FMOV  H1, X12
    FSQRT  S18, S2
    FMOV  H2, X16
    FMSUB  D13, D21, D1, D23
    FNMADD  D20, D30, D28, D13
    FCSEL  H17, H20, H18, LS
    FSUB  S14, S22, S22
    FADD  S26, S19, S19
    FNMSUB  D18, D11, D14, D24
    FNMADD  S9, S17, S6, S26
    FNMUL  S17, S2, S10
    FCSEL  S1, S18, S17, NV
    FADD  H17, H9, H9
    FNMSUB  H12, H1, H17, H1
    FMSUB  S13, S30, S15, S22
    FCSEL  D11, D3, D7, NE
    FNMSUB  H18, H31, H24, H9
    FMOV  X8, D14
    FDIV  S17, S22, S22
    FMOV  W16, H15
    FMOV  H28, H31
    SUBS  X13, X13, #0x1
    B.NE  TSRTFloatMovMadd_label_4
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xffc0, LSL #16
    SUB  X10, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x8000, LSL #48
    SUB  X10, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    SUB  X10, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X10, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X10, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    SUB  X10, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X10, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x9f, LSL #0
    MRS  X10, FPSR
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D0
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D1
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    FMOV  X10, D2
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D3
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D4
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0xfff8, LSL #48
    FMOV  X10, D5
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    FMOV  X10, D6
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D7
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0xba00, LSL #0
    FMOV  X10, D8
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D9
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D10
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D11
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D12
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D13
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D14
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    FMOV  X10, D15
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x4026, LSL #48
    FMOV  X10, D16
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D17
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    FMOV  X10, D18
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D19
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #48
    FMOV  X10, D20
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x7e00, LSL #0
    FMOV  X10, D21
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x8000, LSL #16
    FMOV  X10, D22
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D23
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x8000, LSL #0
    FMOV  X10, D24
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D25
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D26
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D27
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D28
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    MOVK  X25, #0x8000, LSL #48
    FMOV  X10, D29
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x7fc0, LSL #16
    FMOV  X10, D30
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X10, D31
    SUB  X23, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, TSRTFloatMovMadd_TestFail
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
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X23
    FMOV  V2.D[1], X25
    FMOV  D3, X16
    FMOV  V3.D[1], X12
    FMOV  D4, X16
    FMOV  V4.D[1], X11
    FMOV  D5, X18
    FMOV  V5.D[1], X16
    FMOV  D6, X14
    FMOV  V6.D[1], X4
    FMOV  D7, X24
    FMOV  V7.D[1], X14
    FMOV  D8, X25
    FMOV  V8.D[1], X19
    FMOV  D9, X3
    FMOV  V9.D[1], X23
    FMOV  D10, X19
    FMOV  V10.D[1], X12
    FMOV  D11, X2
    FMOV  V11.D[1], X5
    FMOV  D12, X14
    FMOV  V12.D[1], X2
    FMOV  D13, X12
    FMOV  V13.D[1], X3
    FMOV  D14, X4
    FMOV  V14.D[1], X12
    FMOV  D15, X28
    FMOV  V15.D[1], X28
    FMOV  D16, X18
    FMOV  V16.D[1], X10
    FMOV  D17, X3
    FMOV  V17.D[1], X27
    FMOV  D18, X8
    FMOV  V18.D[1], X5
    FMOV  D19, X16
    FMOV  V19.D[1], X19
    FMOV  D20, X27
    FMOV  V20.D[1], X18
    FMOV  D21, X18
    FMOV  V21.D[1], X17
    FMOV  D22, X16
    FMOV  V22.D[1], X9
    FMOV  D23, X4
    FMOV  V23.D[1], X21
    FMOV  D24, X28
    FMOV  V24.D[1], X15
    FMOV  D25, X28
    FMOV  V25.D[1], X9
    FMOV  D26, X10
    FMOV  V26.D[1], X21
    FMOV  D27, X19
    FMOV  V27.D[1], X21
    FMOV  D28, X4
    FMOV  V28.D[1], X5
    FMOV  D29, X12
    FMOV  V29.D[1], X25
    FMOV  D30, X5
    FMOV  V30.D[1], X14
    FMOV  D31, X28
    FMOV  V31.D[1], X6
    MOVZ  X17, #0xf, LSL #0
TSRTFloatMovMadd_label_5:
    FNMSUB  S22, S22, S28, S24
    FSUB  H31, H25, H30
    FMUL  H1, H29, H23
    FMADD  S16, S31, S27, S27
    FMOV  W14, S22
    FNMUL  S7, S16, S26
    FNMSUB  H29, H1, H7, H20
    FMOV  H3, #-0.62500000
    FDIV  S5, S29, S3
    FMADD  S1, S5, S29, S5
    FNEG  H16, H1
    FNEG  S12, S7
    FCSEL  D24, D16, D21, PL
    FNMADD  S22, S30, S7, S3
    FMOV  W25, H7
    FMOV  D27, D25
    FNMUL  H28, H18, H2
    FNMSUB  H20, H15, H1, H0
    FMOV  D15, #-4.25000000
    FABS  H23, H22
    FNMUL  S31, S29, S14
    FSQRT  H14, H25
    FABS  S22, S24
    FMADD  S26, S22, S23, S23
    FMOV  X10, D27
    FSUB  S27, S12, S26
    FNMSUB  S22, S27, S31, S28
    FSQRT  D5, D22
    FNMSUB  D18, D5, D14, D20
    FMADD  D24, D15, D15, D18
    FADD  D7, D3, D31
    FNMUL  H23, H19, H11
    FMUL  D20, D3, D16
    FNMSUB  S21, S5, S7, S0
    FNEG  H30, H0
    FDIV  H16, H18, H2
    FSUB  S28, S28, S11
    FNEG  S25, S9
    FNEG  S15, S2
    FNMUL  H7, H15, H28
    FMADD  D2, D7, D7, D7
    FNMSUB  D19, D24, D24, D16
    FDIV  H11, H19, H20
    FMSUB  S15, S25, S11, S25
    FNMSUB  D9, D2, D15, D15
    FADD  S25, S23, S30
    FMOV  W14, S21
    FSQRT  H18, H25
    FNMUL  D30, D18, D18
    FMADD  S28, S9, S9, S30
    FNEG  S30, S24
    FSQRT  H15, H6
    FNEG  H11, H6
    FNMUL  H21, H15, H31
    FNMADD  H16, H29, H10, H2
    FNMADD  D23, D8, D7, D20
    FMOV  S7, W3
    FMSUB  D19, D12, D11, D16
    FDIV  D16, D10, D22
    FCSEL  H25, H1, H23, EQ
    FNMUL  S18, S3, S11
    FABS  S20, S29
    FMUL  D29, D20, D21
    FABS  D24, D7
    FMOV  D8, D19
    FNEG  H11, H30
    FMSUB  D2, D18, D24, D28
    FSUB  D28, D16, D29
    FSQRT  S7, S2
    FSUB  D23, D11, D25
    FMOV  H3, W6
    FMOV  D6, X13
    FMOV  S11, #4.75000000
    FMOV  H31, H6
    FNMADD  S22, S23, S22, S28
    FMOV  W8, S7
    FSUB  S25, S22, S8
    FMADD  H6, H21, H3, H31
    FCSEL  D30, D11, D25, NE
    FABS  D24, D23
    FABS  D28, D30
    FADD  H18, H28, H28
    FMOV  H2, H18
    FSQRT  S31, S2
    FNEG  S7, S31
    FSQRT  H8, H24
    FSUB  D24, D31, D8
    FNMSUB  S18, S7, S24, S7
    FMOV  H11, X11
    FABS  H21, H6
    FMOV  D22, D11
    FNMADD  H25, H22, H22, H18
    FADD  H3, H21, H25
    FMADD  H18, H2, H28, H1
    FCSEL  H22, H27, H2, VS
    FSQRT  H30, H8
    FDIV  D29, D6, D25
    FNMADD  S23, S5, S11, S26
    FSQRT  D24, D16
    FNMSUB  S21, S25, S13, S7
    FNMUL  S31, S25, S26
    FSQRT  H11, H23
    FMADD  D9, D22, D29, D30
    FMOV  W5, H0
    FNMADD  H2, H3, H3, H3
    FADD  D23, D2, D2
    FMOV  H2, W16
    FMOV  H3, H18
    FMUL  D0, D21, D31
    FNMUL  D21, D9, D0
    FNMSUB  H25, H3, H24, H11
    FMOV  D17, X27
    FADD  D0, D25, D6
    FMOV  D18, X25
    FNMSUB  S8, S28, S23, S21
    FMOV  H31, W16
    FNMUL  D16, D31, D0
    FADD  D5, D8, D2
    FDIV  D9, D5, D16
    FNEG  S29, S17
    FMOV  H27, W3
    FCSEL  S16, S9, S27, LT
    FMOV  S24, W8
    FMOV  X3, D29
    FMOV  D0, X17
    FSUB  H2, H0, H0
    FSQRT  S9, S18
    FSQRT  D18, D15
    FABS  S22, S24
    FABS  D13, D2
    FMADD  H31, H16, H18, H9
    FSQRT  S3, S13
    FDIV  D23, D3, D31
    FNMUL  D17, D22, D8
    FNMUL  D27, D17, D17
    FSUB  S5, S23, S27
    FADD  H23, H25, H3
    FNEG  H3, H27
    FSQRT  H29, H15
    FCSEL  S2, S6, S12, CS
    FSQRT  D17, D27
    FADD  S24, S23, S4
    FCSEL  H25, H7, H10, VC
    FMADD  D22, D27, D3, D21
    FMOV  D3, #-0.90625000
    FNMSUB  S10, S24, S24, S16
    FMOV  W8, S21
    FMOV  S0, W28
    FNMSUB  S7, S29, S2, S3
    FSUB  H12, H22, H5
    FSQRT  D27, D0
    FABS  H31, H27
    FSQRT  D24, D31
    FNMSUB  S15, S7, S25, S12
    FDIV  S0, S10, S24
    FDIV  H6, H17, H15
    FADD  H23, H3, H22
    FNEG  S24, S6
    FNMADD  S31, S0, S24, S28
    FMSUB  D27, D31, D9, D23
    FNMADD  D18, D24, D22, D3
    FABS  H16, H22
    FDIV  D5, D31, D1
    FMUL  D10, D31, D11
    FCSEL  S23, S25, S24, VS
    FMUL  S2, S14, S8
    FSUB  D21, D2, D25
    FSQRT  H8, H22
    FMOV  S17, S1
    FNMUL  S24, S18, S10
    FMOV  S22, W19
    FDIV  S18, S8, S5
    FMSUB  D14, D18, D16, D16
    FMUL  H11, H24, H23
    FADD  S6, S14, S17
    FSUB  D5, D6, D11
    FMSUB  H8, H21, H1, H27
    FMUL  D2, D22, D22
    FMOV  S22, S2
    FMOV  H10, W3
    FMUL  H2, H22, H2
    FMOV  H24, X9
    FNMSUB  H18, H2, H11, H5
    FMOV  D22, D24
    FMOV  S1, S22
    FMOV  S27, W24
    FMOV  X14, D27
    FMSUB  D24, D1, D1, D1
    FMSUB  D6, D18, D8, D18
    FMUL  S1, S10, S24
    FMOV  S18, S1
    FABS  D5, D18
    FSUB  D21, D6, D6
    FMADD  H8, H5, H5, H28
    FMOV  H16, H8
    FNEG  D14, D16
    FMOV  S1, W17
    FADD  D16, D21, D1
    FMADD  S2, S16, S18, S16
    FNMSUB  S24, S14, S14, S2
    SUBS  X17, X17, #0x1
    B.NE  TSRTFloatMovMadd_label_5
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0x7fff, LSL #16
    SUB  X21, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    SUB  X21, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X21, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    SUB  X21, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x9f, LSL #0
    MRS  X21, FPSR
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    FMOV  X21, D0
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x1, LSL #0
    FMOV  X21, D1
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V2.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D2
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xbfed, LSL #48
    FMOV  X21, D3
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    MOVK  X18, #0xffff, LSL #32
    MOVK  X18, #0xffff, LSL #48
    FMOV  X21, D4
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D5
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D6
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D7
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D8
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D9
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    FMOV  X21, D10
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x7e00, LSL #0
    FMOV  X21, D11
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D12
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D13
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #48
    FMOV  X21, D14
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D15
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D16
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    FMOV  X21, D17
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D18
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D19
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x7e00, LSL #0
    FMOV  X21, D20
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D21
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    FMOV  X21, D22
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x7e00, LSL #0
    MOVK  X18, #0x8000, LSL #16
    FMOV  X21, D23
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D24
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D25
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D26
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xffff, LSL #0
    MOVK  X18, #0xffff, LSL #16
    FMOV  X21, D27
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x4098, LSL #16
    FMOV  X21, D28
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D29
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, D30
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    FMOV  X21, D31
    SUB  X2, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x39e2, LSL #0
    MOVK  X2, #0xcd01, LSL #16
    MOVK  X2, #0x391, LSL #32
    MOVK  X2, #0x67b5, LSL #48
    MOVZ  X3, #0x2d08, LSL #0
    MOVK  X3, #0x6f6d, LSL #16
    MOVK  X3, #0xb763, LSL #32
    MOVK  X3, #0x3994, LSL #48
    MOVZ  X4, #0x3719, LSL #0
    MOVK  X4, #0x2f1b, LSL #16
    MOVK  X4, #0x52d6, LSL #32
    MOVK  X4, #0x24a7, LSL #48
    MOVZ  X5, #0xfe1, LSL #0
    MOVK  X5, #0x9920, LSL #16
    MOVK  X5, #0x9d19, LSL #32
    MOVK  X5, #0x5680, LSL #48
    MOVZ  X6, #0xee0a, LSL #0
    MOVK  X6, #0xce9, LSL #16
    MOVK  X6, #0xdbfd, LSL #32
    MOVK  X6, #0xb5dd, LSL #48
    MOVZ  X8, #0xaecd, LSL #0
    MOVK  X8, #0xf136, LSL #16
    MOVK  X8, #0x2c92, LSL #32
    MOVK  X8, #0x7f39, LSL #48
    MOVZ  X9, #0x181f, LSL #0
    MOVK  X9, #0x86fc, LSL #16
    MOVK  X9, #0x1c2b, LSL #32
    MOVK  X9, #0x2cc4, LSL #48
    MOVZ  X10, #0xa9a2, LSL #0
    MOVK  X10, #0xb548, LSL #16
    MOVK  X10, #0xc3be, LSL #32
    MOVK  X10, #0x9581, LSL #48
    MOVZ  X11, #0x8cae, LSL #0
    MOVK  X11, #0xe755, LSL #16
    MOVK  X11, #0xeb9a, LSL #32
    MOVK  X11, #0x1bc7, LSL #48
    MOVZ  X12, #0xdb4, LSL #0
    MOVK  X12, #0x9e1d, LSL #16
    MOVK  X12, #0xc70f, LSL #32
    MOVK  X12, #0x67c7, LSL #48
    MOVZ  X13, #0xf36b, LSL #0
    MOVK  X13, #0x2d9d, LSL #16
    MOVK  X13, #0xb200, LSL #32
    MOVK  X13, #0x1301, LSL #48
    MOVZ  X14, #0x535a, LSL #0
    MOVK  X14, #0xc20e, LSL #16
    MOVK  X14, #0x9508, LSL #32
    MOVK  X14, #0xdb90, LSL #48
    MOVZ  X15, #0xddb4, LSL #0
    MOVK  X15, #0xf583, LSL #16
    MOVK  X15, #0x4eb3, LSL #32
    MOVK  X15, #0x2afc, LSL #48
    MOVZ  X16, #0x51f9, LSL #0
    MOVK  X16, #0xd0a2, LSL #16
    MOVK  X16, #0xd1b2, LSL #32
    MOVK  X16, #0x7490, LSL #48
    MOVZ  X17, #0xc95d, LSL #0
    MOVK  X17, #0xd4db, LSL #16
    MOVK  X17, #0xea7, LSL #32
    MOVK  X17, #0x74b2, LSL #48
    MOVZ  X18, #0x752c, LSL #0
    MOVK  X18, #0x113a, LSL #16
    MOVK  X18, #0xd0b1, LSL #32
    MOVK  X18, #0x4211, LSL #48
    MOVZ  X19, #0xc781, LSL #0
    MOVK  X19, #0x9c7, LSL #16
    MOVK  X19, #0x1c63, LSL #32
    MOVK  X19, #0x83, LSL #48
    MOVZ  X21, #0x9b39, LSL #0
    MOVK  X21, #0xf346, LSL #16
    MOVK  X21, #0x536f, LSL #32
    MOVK  X21, #0x1c7a, LSL #48
    MOVZ  X23, #0x8a3b, LSL #0
    MOVK  X23, #0x6504, LSL #16
    MOVK  X23, #0xf420, LSL #32
    MOVK  X23, #0x592f, LSL #48
    MOVZ  X24, #0x1851, LSL #0
    MOVK  X24, #0x45b0, LSL #16
    MOVK  X24, #0x3bbf, LSL #32
    MOVK  X24, #0x516b, LSL #48
    MOVZ  X25, #0xe5a0, LSL #0
    MOVK  X25, #0x63a8, LSL #16
    MOVK  X25, #0xb646, LSL #32
    MOVK  X25, #0x40ca, LSL #48
    MOVZ  X27, #0xab04, LSL #0
    MOVK  X27, #0x914e, LSL #16
    MOVK  X27, #0x8339, LSL #32
    MOVK  X27, #0xa265, LSL #48
    MOVZ  X28, #0x7774, LSL #0
    MOVK  X28, #0xedd4, LSL #16
    MOVK  X28, #0x750c, LSL #32
    MOVK  X28, #0xcf16, LSL #48
    MOVZ  X29, #0x44f1, LSL #0
    MOVK  X29, #0xb7ac, LSL #16
    MOVK  X29, #0xda82, LSL #32
    MOVK  X29, #0xd434, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X8
    FMOV  D3, X23
    FMOV  V3.D[1], X21
    FMOV  D4, X8
    FMOV  V4.D[1], X10
    FMOV  D5, X16
    FMOV  V5.D[1], X3
    FMOV  D6, X25
    FMOV  V6.D[1], X27
    FMOV  D7, X11
    FMOV  V7.D[1], X18
    FMOV  D8, X25
    FMOV  V8.D[1], X12
    FMOV  D9, X12
    FMOV  V9.D[1], X28
    FMOV  D10, X11
    FMOV  V10.D[1], X5
    FMOV  D11, X5
    FMOV  V11.D[1], X10
    FMOV  D12, X10
    FMOV  V12.D[1], X11
    FMOV  D13, X11
    FMOV  V13.D[1], X3
    FMOV  D14, X12
    FMOV  V14.D[1], X6
    FMOV  D15, X15
    FMOV  V15.D[1], X13
    FMOV  D16, X29
    FMOV  V16.D[1], X2
    FMOV  D17, X13
    FMOV  V17.D[1], X28
    FMOV  D18, X24
    FMOV  V18.D[1], X19
    FMOV  D19, X15
    FMOV  V19.D[1], X25
    FMOV  D20, X24
    FMOV  V20.D[1], X16
    FMOV  D21, X29
    FMOV  V21.D[1], X21
    FMOV  D22, X12
    FMOV  V22.D[1], X10
    FMOV  D23, X19
    FMOV  V23.D[1], X19
    FMOV  D24, X14
    FMOV  V24.D[1], X3
    FMOV  D25, X3
    FMOV  V25.D[1], X4
    FMOV  D26, X21
    FMOV  V26.D[1], X10
    FMOV  D27, X16
    FMOV  V27.D[1], X27
    FMOV  D28, X24
    FMOV  V28.D[1], X29
    FMOV  D29, X8
    FMOV  V29.D[1], X10
    FMOV  D30, X16
    FMOV  V30.D[1], X15
    FMOV  D31, X21
    FMOV  V31.D[1], X2
    MOVZ  X12, #0xf, LSL #0
TSRTFloatMovMadd_label_6:
    FNMSUB  H2, H25, H23, H23
    FNEG  S14, S26
    FNMUL  H21, H22, H24
    FMADD  D14, D29, D19, D29
    FDIV  D18, D30, D20
    FMOV  S30, S21
    FNMUL  H28, H28, H18
    FADD  D14, D27, D28
    FSUB  D25, D30, D30
    FMOV  H24, #4.75000000
    FMOV  S2, #1.50000000
    FNMUL  H21, H25, H2
    FMADD  D29, D31, D14, D31
    FMOV  H13, H24
    FMADD  H11, H21, H21, H21
    FNEG  D14, D13
    FMOV  S23, W11
    FMOV  H20, H29
    FMOV  X11, H11
    FADD  H20, H26, H13
    FABS  H21, H14
    FNMADD  D18, D23, D21, D23
    FNEG  S25, S20
    FADD  H24, H18, H25
    FNMADD  S2, S12, S7, S10
    FNEG  D14, D11
    FSUB  S18, S13, S13
    FNMSUB  S10, S10, S25, S17
    FSUB  D31, D5, D11
    FNMSUB  S5, S8, S12, S15
    FADD  D13, D29, D3
    FMSUB  S23, S17, S11, S24
    FNMUL  S27, S22, S29
    FCSEL  D19, D31, D18, VS
    FSUB  H26, H19, H19
    FADD  H28, H13, H22
    FMUL  H15, H14, H9
    FMOV  S22, W11
    FNMUL  S30, S22, S2
    FDIV  S3, S26, S26
    FADD  D25, D23, D15
    FNEG  H8, H27
    FMSUB  H12, H10, H5, H25
    FNMADD  S29, S3, S28, S8
    FCSEL  D7, D6, D31, NV
    FMUL  S19, S30, S7
    FSUB  D15, D29, D22
    FMADD  D28, D15, D19, D12
    FMOV  H14, X5
    FMUL  D22, D28, D29
    FNMADD  H13, H20, H7, H25
    FNMUL  H21, H11, H25
    FMOV  D23, X14
    FNMSUB  D11, D17, D25, D14
    FMOV  X2, D2
    FNEG  D9, D20
    FNMUL  D6, D1, D5
    FCSEL  D26, D23, D2, LT
    FADD  S8, S27, S28
    FSUB  H20, H20, H2
    FCSEL  H29, H6, H20, CC
    FMOV  S10, S22
    FNMUL  D30, D29, D11
    FMOV  W16, H30
    FADD  S3, S10, S21
    FMADD  D2, D8, D8, D3
    FSQRT  D15, D26
    FDIV  S14, S9, S9
    FNEG  H3, H13
    FMOV  S19, #-5.50000000
    FMSUB  S8, S2, S19, S19
    FMOV  S19, S8
    FDIV  S9, S3, S3
    FNMSUB  S8, S15, S15, S15
    FSUB  D7, D8, D19
    FNMADD  S30, S9, S12, S7
    FSUB  D27, D14, D19
    FMADD  D13, D27, D30, D27
    FSQRT  D21, D26
    FNMSUB  H14, H16, H27, H24
    FMOV  W28, H14
    FNMSUB  S11, S19, S7, S25
    FMADD  D19, D28, D10, D0
    FMOV  X10, H5
    FSQRT  H5, H9
    FABS  S7, S26
    FNMSUB  H28, H0, H31, H28
    FCSEL  D31, D13, D29, MI
    FNMSUB  S6, S29, S20, S2
    FNMSUB  S12, S6, S24, S2
    FSUB  H3, H4, H13
    FMOV  H6, #0.40625000
    FMOV  W27, S19
    FNMADD  S13, S21, S28, S11
    FNMUL  D19, D13, D7
    FMOV  H13, X23
    FMUL  H25, H19, H5
    FMOV  D4, D13
    FMOV  S28, S15
    FMOV  D21, X15
    FMADD  S0, S21, S28, S31
    FNMADD  D13, D25, D12, D6
    FMUL  H29, H3, H17
    FNMUL  D19, D0, D13
    FNEG  S3, S19
    FDIV  D11, D3, D4
    FSQRT  S25, S29
    FNMADD  D4, D11, D25, D11
    FMOV  W28, H16
    FSUB  H24, H16, H29
    FMOV  W24, H21
    FNMADD  D5, D31, D29, D27
    FADD  S28, S21, S21
    FMOV  H25, X5
    FMOV  X24, D24
    FMOV  D29, D6
    FMOV  D24, X19
    FSQRT  H0, H8
    FNMUL  S21, S0, S29
    FNMUL  H31, H24, H3
    FNMUL  D7, D2, D4
    FNMSUB  S12, S14, S3, S18
    FCSEL  H29, H3, H7, NE
    FSQRT  S27, S11
    FMUL  S2, S12, S1
    FNEG  D16, D6
    FNMUL  D15, D21, D25
    FMOV  X21, H29
    FMOV  S25, W25
    FMUL  S6, S26, S25
    FNMSUB  S3, S15, S27, S31
    FMOV  W3, S5
    FMOV  H24, H6
    FMOV  S19, #-0.32812500
    FABS  S21, S16
    FMOV  D27, #-1.37500000
    FNEG  H8, H24
    FNMUL  H25, H3, H27
    FNMUL  D6, D25, D21
    FNEG  H5, H2
    FCSEL  D15, D5, D19, VC
    FADD  D11, D15, D6
    FNMUL  S21, S8, S8
    FMUL  D16, D11, D21
    FNMUL  H26, H16, H16
    FMADD  D16, D15, D1, D16
    FMSUB  H31, H5, H17, H8
    FMOV  S24, W8
    FMOV  D2, #27.00000000
    FNMADD  S3, S24, S24, S16
    FMUL  H1, H19, H24
    FMOV  H12, X25
    FDIV  H11, H8, H29
    FNMUL  S27, S25, S21
    FMOV  S25, W6
    FMOV  D21, #-0.29687500
    FSQRT  D15, D12
    FABS  H6, H3
    FABS  D3, D27
    FMUL  S8, S1, S11
    FMOV  H29, W3
    FMUL  D12, D26, D15
    FNMSUB  D11, D29, D2, D12
    FMSUB  S1, S6, S11, S19
    FNEG  H18, H1
    FSUB  H17, H25, H25
    FMOV  H16, W6
    FCSEL  S5, S21, S21, LT
    FMUL  D26, D3, D31
    FNMUL  H27, H17, H8
    FMUL  S11, S16, S27
    FMUL  D8, D5, D11
    FABS  D5, D18
    FMSUB  D1, D8, D26, D21
    FMOV  S29, #-7.25000000
    FMUL  D8, D5, D5
    FMADD  H11, H1, H1, H8
    FNMADD  S12, S11, S11, S29
    FMOV  W29, S10
    FNMSUB  S21, S2, S29, S3
    FCSEL  S11, S8, S5, NV
    FNMUL  D18, D16, D15
    FNEG  H27, H26
    FMOV  H5, X23
    FMOV  H3, #-0.48437500
    FMADD  H17, H17, H4, H31
    FNMADD  S6, S23, S15, S5
    FADD  D23, D3, D18
    FABS  H16, H16
    FMSUB  H3, H5, H8, H4
    FMOV  H5, X8
    FSUB  D10, D21, D3
    FMOV  D8, X2
    FSUB  D19, D16, D11
    FNMSUB  S16, S19, S10, S21
    FNMADD  H26, H17, H5, H5
    FNMUL  H4, H26, H23
    FDIV  D17, D6, D4
    FMUL  H1, H12, H8
    FMADD  H31, H1, H16, H16
    SUBS  X12, X12, #0x1
    B.NE  TSRTFloatMovMadd_label_6
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    SUB  X18, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x3719, LSL #0
    MOVK  X17, #0x2f1b, LSL #16
    MOVK  X17, #0x52d6, LSL #32
    MOVK  X17, #0x24a7, LSL #48
    SUB  X18, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xfe1, LSL #0
    MOVK  X17, #0x9920, LSL #16
    MOVK  X17, #0x9d19, LSL #32
    MOVK  X17, #0x5680, LSL #48
    SUB  X18, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xee0a, LSL #0
    MOVK  X17, #0xce9, LSL #16
    MOVK  X17, #0xdbfd, LSL #32
    MOVK  X17, #0xb5dd, LSL #48
    SUB  X18, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xaecd, LSL #0
    MOVK  X17, #0xf136, LSL #16
    MOVK  X17, #0x2c92, LSL #32
    MOVK  X17, #0x7f39, LSL #48
    SUB  X18, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xf36b, LSL #0
    MOVK  X17, #0x2d9d, LSL #16
    MOVK  X17, #0xb200, LSL #32
    MOVK  X17, #0x1301, LSL #48
    SUB  X18, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x535a, LSL #0
    MOVK  X17, #0xc20e, LSL #16
    MOVK  X17, #0x9508, LSL #32
    MOVK  X17, #0xdb90, LSL #48
    SUB  X18, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xddb4, LSL #0
    MOVK  X17, #0xf583, LSL #16
    MOVK  X17, #0x4eb3, LSL #32
    MOVK  X17, #0x2afc, LSL #48
    SUB  X18, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xc781, LSL #0
    MOVK  X17, #0x9c7, LSL #16
    MOVK  X17, #0x1c63, LSL #32
    MOVK  X17, #0x83, LSL #48
    SUB  X18, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x8a3b, LSL #0
    MOVK  X17, #0x6504, LSL #16
    MOVK  X17, #0xf420, LSL #32
    MOVK  X17, #0x592f, LSL #48
    SUB  X18, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xe5a0, LSL #0
    MOVK  X17, #0x63a8, LSL #16
    MOVK  X17, #0xb646, LSL #32
    MOVK  X17, #0x40ca, LSL #48
    SUB  X18, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    SUB  X18, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x9f, LSL #0
    MRS  X18, FPSR
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D0
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D1
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x403b, LSL #48
    FMOV  X18, D2
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D3
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x8000, LSL #0
    FMOV  X18, D4
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xaecd, LSL #0
    FMOV  X18, D5
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D6
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xfff8, LSL #48
    FMOV  X18, D7
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    FMOV  X18, D8
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7fc0, LSL #16
    FMOV  X18, D9
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D10
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D11
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x40e8, LSL #16
    FMOV  X18, D12
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #48
    FMOV  X18, D13
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xc4db, LSL #0
    FMOV  X18, D14
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D15
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D16
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7ff8, LSL #48
    FMOV  X18, D17
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #48
    FMOV  X18, D18
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D19
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x44db, LSL #0
    FMOV  X18, D20
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x8000, LSL #16
    FMOV  X18, D21
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D22
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D23
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xaecd, LSL #0
    MOVK  X17, #0xf136, LSL #16
    FMOV  X18, D24
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xee0a, LSL #0
    MOVK  X17, #0xce9, LSL #16
    FMOV  X18, D25
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x2ecd, LSL #0
    FMOV  X18, D26
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x8000, LSL #0
    FMOV  X18, D27
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0xddb4, LSL #0
    MOVK  X17, #0xf603, LSL #16
    FMOV  X18, D28
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xc0e8, LSL #16
    FMOV  X18, D29
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x7fc0, LSL #16
    FMOV  X18, D30
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, D31
    SUB  X9, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X24
    FMOV  V0.D[1], X6
    FMOV  D1, X23
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X16
    FMOV  D3, X29
    FMOV  V3.D[1], X15
    FMOV  D4, X17
    FMOV  V4.D[1], X18
    FMOV  D5, X19
    FMOV  V5.D[1], X21
    FMOV  D6, X28
    FMOV  V6.D[1], X5
    FMOV  D7, X14
    FMOV  V7.D[1], X18
    FMOV  D8, X14
    FMOV  V8.D[1], X21
    FMOV  D9, X15
    FMOV  V9.D[1], X11
    FMOV  D10, X12
    FMOV  V10.D[1], X24
    FMOV  D11, X29
    FMOV  V11.D[1], X27
    FMOV  D12, X10
    FMOV  V12.D[1], X27
    FMOV  D13, X23
    FMOV  V13.D[1], X12
    FMOV  D14, X2
    FMOV  V14.D[1], X14
    FMOV  D15, X14
    FMOV  V15.D[1], X12
    FMOV  D16, X19
    FMOV  V16.D[1], X18
    FMOV  D17, X5
    FMOV  V17.D[1], X15
    FMOV  D18, X23
    FMOV  V18.D[1], X18
    FMOV  D19, X15
    FMOV  V19.D[1], X11
    FMOV  D20, X10
    FMOV  V20.D[1], X5
    FMOV  D21, X8
    FMOV  V21.D[1], X14
    FMOV  D22, X6
    FMOV  V22.D[1], X15
    FMOV  D23, X15
    FMOV  V23.D[1], X12
    FMOV  D24, X23
    FMOV  V24.D[1], X3
    FMOV  D25, X29
    FMOV  V25.D[1], X6
    FMOV  D26, X21
    FMOV  V26.D[1], X18
    FMOV  D27, X2
    FMOV  V27.D[1], X13
    FMOV  D28, X9
    FMOV  V28.D[1], X5
    FMOV  D29, X9
    FMOV  V29.D[1], X25
    FMOV  D30, X19
    FMOV  V30.D[1], X17
    FMOV  D31, X19
    FMOV  V31.D[1], X13
    MOVZ  X21, #0xf, LSL #0
TSRTFloatMovMadd_label_7:
    FMOV  H22, #0.93750000
    FSUB  D4, D28, D31
    FSQRT  H1, H27
    FNMSUB  H20, H24, H29, H24
    FNEG  H8, H25
    FMOV  W29, S22
    FMOV  W6, H23
    FNEG  S18, S1
    FSQRT  H20, H26
    FDIV  D7, D20, D18
    FMOV  W9, H4
    FMUL  H4, H30, H30
    FCSEL  D8, D4, D4, MI
    FDIV  S12, S7, S7
    FNEG  D28, D12
    FMOV  W13, H28
    FSUB  D20, D8, D13
    FNMUL  H26, H20, H18
    FNMUL  D28, D20, D0
    FMSUB  H22, H31, H10, H24
    FNEG  S30, S3
    FSUB  S12, S30, S28
    FNMADD  D24, D4, D18, D19
    FNMSUB  S28, S8, S4, S2
    FCSEL  D30, D3, D16, VC
    FMOV  H23, H16
    FDIV  D20, D25, D31
    FMSUB  H13, H27, H30, H22
    FNMADD  D16, D31, D6, D29
    FNMSUB  H6, H3, H22, H14
    FSUB  H1, H24, H23
    FMSUB  D22, D26, D13, D1
    FSQRT  H19, H11
    FMOV  W4, H12
    FMSUB  D24, D22, D19, D19
    FMOV  D27, D24
    FMOV  H0, #-4.00000000
    FMOV  S3, S22
    FCSEL  H25, H0, H6, NE
    FMOV  D18, #4.25000000
    FADD  D30, D16, D3
    FCSEL  H0, H20, H27, CC
    FNEG  H8, H18
    FMOV  W12, S0
    FMOV  D0, X10
    FNEG  S18, S25
    FNMADD  S12, S8, S30, S18
    FMSUB  H8, H0, H0, H0
    FNEG  D4, D8
    FNEG  D6, D12
    FDIV  D24, D4, D6
    FNMSUB  D3, D24, D24, D24
    FNEG  D19, D3
    FNMADD  H22, H28, H19, H19
    FABS  H28, H0
    FMADD  H20, H29, H28, H10
    FDIV  H4, H9, H29
    FMADD  H27, H27, H11, H31
    FNMUL  H14, H30, H2
    FADD  D19, D26, D10
    FNEG  D8, D10
    FADD  D28, D18, D5
    FMOV  H18, W15
    FDIV  H16, H14, H22
    FNMADD  S2, S16, S28, S4
    FNMUL  S11, S19, S2
    FMOV  H2, #-21.00000000
    FMUL  D30, D11, D8
    FMOV  H31, W28
    FADD  H28, H31, H23
    FMSUB  H10, H28, H20, H2
    FADD  S24, S27, S18
    FCSEL  D3, D30, D30, AL
    FABS  H19, H3
    FNMSUB  S30, S10, S10, S19
    FMOV  H26, H24
    FNMUL  S5, S16, S26
    FMSUB  D16, D5, D5, D30
    FMUL  H27, H13, H28
    FMSUB  S18, S14, S9, S27
    FMOV  S20, W15
    FMOV  X4, D18
    FDIV  S24, S2, S1
    FMADD  S3, S23, S18, S5
    FMUL  H22, H8, H1
    FMUL  H19, H31, H26
    FMOV  D2, D22
    FNEG  H4, H6
    FMOV  W5, S19
    FMOV  D11, X12
    FNMSUB  H22, H15, H2, H5
    FDIV  S9, S4, S23
    FNMSUB  D1, D27, D8, D24
    FMUL  H14, H30, H12
    FNEG  S8, S11
    FMOV  S13, W24
    FNMUL  H12, H3, H13
    FSUB  S4, S1, S11
    FABS  S24, S14
    FADD  D6, D16, D22
    FMUL  H10, H12, H12
    FABS  S18, S24
    FDIV  D26, D6, D4
    FABS  D22, D26
    FABS  S30, S8
    FNMADD  H28, H30, H30, H20
    FMUL  S20, S10, S9
    FABS  D2, D20
    FNMSUB  S12, S28, S2, S2
    FADD  S1, S12, S12
    FMSUB  D5, D1, D1, D1
    FSQRT  D30, D18
    FMUL  H4, H5, H30
    FMOV  W12, S22
    FMSUB  D6, D27, D28, D4
    FSUB  D22, D18, D16
    FNMSUB  D30, D4, D6, D16
    FNMSUB  H26, H3, H15, H27
    FABS  H10, H31
    FADD  H15, H10, H29
    FCSEL  H5, H17, H6, CC
    FNEG  D27, D3
    FMOV  X6, D27
    FMOV  S31, #-0.65625000
    FMOV  S12, #9.50000000
    FCSEL  S1, S31, S17, LS
    FSQRT  D28, D28
    FMOV  H16, #4.00000000
    FDIV  D17, D1, D5
    FADD  H4, H12, H15
    FNMSUB  D15, D4, D16, D22
    FMOV  H22, #-0.78125000
    FDIV  D16, D15, D28
    FMUL  H27, H26, H17
    FMUL  H10, H22, H22
    FSQRT  H31, H16
    FMOV  H28, H27
    FNEG  H22, H30
    FMOV  H16, H22
    FMSUB  S27, S31, S16, S10
    FMADD  H17, H28, H27, H28
    FNMADD  H5, H21, H9, H0
    FADD  S4, S23, S6
    FMOV  X29, H27
    FMADD  D1, D16, D14, D31
    FMOV  S26, #0.45312500
    FMOV  S12, S29
    FNMADD  H3, H14, H19, H16
    FMADD  H6, H23, H24, H9
    FMOV  D27, D21
    FABS  S7, S6
    FNEG  D29, D26
    FCSEL  H0, H1, H4, CS
    FABS  S22, S17
    FNMSUB  H30, H22, H5, H3
    FCSEL  S21, S30, S23, MI
    FMADD  S15, S12, S7, S21
    FNMADD  D12, D15, D15, D29
    FMOV  W6, H27
    FNMADD  D19, D12, D12, D0
    FNMADD  S4, S7, S24, S27
    FMOV  H17, #-8.50000000
    FNMSUB  H31, H0, H26, H15
    FMOV  H10, #-1.93750000
    FMOV  H12, W10
    FMUL  D7, D2, D22
    FNMSUB  H29, H31, H7, H8
    FCSEL  H14, H19, H17, HI
    FMADD  D26, D26, D30, D8
    FMSUB  H3, H2, H4, H21
    FDIV  D23, D27, D6
    FSUB  D24, D17, D17
    FNMADD  S4, S20, S22, S28
    FMOV  S27, #0.19531250
    FSQRT  S19, S14
    FABS  H9, H24
    FMOV  X25, H29
    FABS  H22, H27
    FCSEL  D0, D23, D12, AL
    FMUL  S6, S4, S26
    FMUL  D20, D0, D16
    FSQRT  H31, H6
    FSUB  S29, S0, S10
    FCSEL  H30, H3, H7, CS
    FMOV  H16, H22
    FCSEL  S21, S9, S20, VC
    FMOV  S26, W18
    FMOV  W17, H19
    FADD  D17, D21, D21
    FMSUB  S28, S31, S26, S16
    FNEG  S9, S29
    FNMUL  H8, H30, H30
    FMOV  D24, X6
    FMOV  D14, #-0.18750000
    FMOV  H12, #-1.75000000
    FSUB  D2, D28, D9
    FMOV  D8, D8
    FMSUB  H20, H8, H14, H17
    FSUB  D6, D24, D24
    FMOV  H22, W4
    SUBS  X21, X21, #0x1
    B.NE  TSRTFloatMovMadd_label_7
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X2, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x9f, LSL #0
    MRS  X2, FPSR
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7ff8, LSL #48
    FMOV  X2, D0
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D1
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D2
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D3
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7fc0, LSL #16
    FMOV  X2, D4
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V5.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x8000, LSL #0
    FMOV  X2, D5
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D6
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D7
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x8000, LSL #0
    FMOV  X2, D8
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    FMOV  X2, D9
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xbfc0, LSL #0
    FMOV  X2, D10
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D11
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xbf00, LSL #0
    FMOV  X2, D12
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D13
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xbfc8, LSL #48
    FMOV  X2, D14
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D15
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D16
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D17
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D18
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D19
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D20
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V21.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D21
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V22.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D22
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7ff8, LSL #48
    FMOV  X2, D23
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D24
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xc400, LSL #0
    FMOV  X2, D25
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D26
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x3e48, LSL #16
    FMOV  X2, D27
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D29
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D30
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X2, D31
    SUB  X16, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X24
    FMOV  D2, X25
    FMOV  V2.D[1], X3
    FMOV  D3, X3
    FMOV  V3.D[1], X23
    FMOV  D4, X8
    FMOV  V4.D[1], X13
    FMOV  D5, X12
    FMOV  V5.D[1], X3
    FMOV  D6, X8
    FMOV  V6.D[1], X21
    FMOV  D7, X9
    FMOV  V7.D[1], X18
    FMOV  D8, X18
    FMOV  V8.D[1], X10
    FMOV  D9, X8
    FMOV  V9.D[1], X14
    FMOV  D10, X4
    FMOV  V10.D[1], X6
    FMOV  D11, X15
    FMOV  V11.D[1], X9
    FMOV  D12, X13
    FMOV  V12.D[1], X14
    FMOV  D13, X21
    FMOV  V13.D[1], X19
    FMOV  D14, X8
    FMOV  V14.D[1], X10
    FMOV  D15, X15
    FMOV  V15.D[1], X18
    FMOV  D16, X10
    FMOV  V16.D[1], X27
    FMOV  D17, X18
    FMOV  V17.D[1], X3
    FMOV  D18, X5
    FMOV  V18.D[1], X28
    FMOV  D19, X29
    FMOV  V19.D[1], X18
    FMOV  D20, X23
    FMOV  V20.D[1], X27
    FMOV  D21, X4
    FMOV  V21.D[1], X28
    FMOV  D22, X14
    FMOV  V22.D[1], X2
    FMOV  D23, X25
    FMOV  V23.D[1], X12
    FMOV  D24, X19
    FMOV  V24.D[1], X4
    FMOV  D25, X13
    FMOV  V25.D[1], X14
    FMOV  D26, X15
    FMOV  V26.D[1], X13
    FMOV  D27, X2
    FMOV  V27.D[1], X4
    FMOV  D28, X2
    FMOV  V28.D[1], X12
    FMOV  D29, X27
    FMOV  V29.D[1], X3
    FMOV  D30, X25
    FMOV  V30.D[1], X28
    FMOV  D31, X21
    FMOV  V31.D[1], X29
    MOVZ  X11, #0xf, LSL #0
TSRTFloatMovMadd_label_8:
    FDIV  D3, D22, D28
    FMOV  S5, S25
    FSUB  D11, D26, D24
    FMOV  S1, #-17.00000000
    FNMUL  D18, D27, D20
    FMOV  X17, H29
    FNEG  D21, D30
    FMOV  W13, H18
    FSUB  D2, D31, D31
    FCSEL  H9, H11, H11, GE
    FMADD  H27, H3, H1, H21
    FMOV  H9, H9
    FSQRT  S19, S9
    FMADD  D30, D28, D5, D27
    FSQRT  S11, S2
    FMOV  S30, #7.75000000
    FSQRT  S12, S30
    FMOV  X21, H11
    FNMSUB  D19, D19, D12, D12
    FNEG  D22, D17
    FMADD  S31, S19, S31, S14
    FMSUB  D28, D29, D21, D7
    FDIV  D25, D23, D21
    FNMSUB  H11, H11, H5, H16
    FADD  S18, S25, S18
    FMOV  S30, S15
    FADD  H3, H13, H9
    FABS  H1, H13
    FNMUL  D20, D4, D7
    FMSUB  H5, H28, H20, H28
    FMOV  X14, D18
    FMOV  S12, S22
    FADD  D4, D30, D11
    FNMUL  D17, D4, D1
    FMOV  H9, #-2.00000000
    FSQRT  D2, D12
    FCSEL  S14, S31, S5, LE
    FMOV  W9, H17
    FABS  H4, H3
    FNMADD  S15, S4, S9, S21
    FMOV  W12, S15
    FMUL  D27, D2, D2
    FNMSUB  D17, D27, D14, D14
    FABS  D21, D7
    FMSUB  D7, D7, D6, D24
    FDIV  D1, D24, D30
    FNMADD  S4, S14, S29, S28
    FMOV  D6, D8
    FMOV  D27, D25
    FMADD  H19, H28, H18, H17
    FNMADD  D11, D12, D6, D21
    FMUL  D2, D26, D0
    FSQRT  S0, S4
    FCSEL  S14, S27, S28, GT
    FMOV  D8, D20
    FNMADD  H26, H18, H20, H29
    FSUB  S31, S11, S7
    FCSEL  S28, S0, S26, HI
    FMUL  S21, S31, S19
    FMSUB  H15, H21, H28, H2
    FNMADD  D2, D8, D14, D1
    FNMUL  D11, D2, D15
    FMSUB  H29, H28, H18, H30
    FSUB  D15, D1, D23
    FNEG  H24, H19
    FNMSUB  H1, H13, H8, H5
    FDIV  H25, H7, H25
    FMUL  H9, H23, H11
    FMOV  W9, H0
    FNMADD  D7, D10, D14, D21
    FNMSUB  S27, S6, S11, S15
    FNMSUB  S26, S24, S22, S30
    FMOV  H19, W4
    FNMUL  S6, S21, S15
    FMOV  D10, X10
    FMSUB  H14, H9, H29, H25
    FDIV  H29, H14, H1
    FMADD  H2, H6, H29, H29
    FMADD  S0, S27, S26, S7
    FMOV  S27, W6
    FABS  D21, D10
    FSQRT  D23, D21
    FMSUB  S1, S2, S27, S19
    FMADD  D27, D23, D23, D0
    FDIV  S9, S27, S1
    FMOV  S19, S18
    FMADD  S8, S9, S22, S13
    FMSUB  S26, S20, S14, S3
    FABS  H25, H4
    FMOV  S21, #0.17968750
    FMADD  D10, D9, D25, D29
    FNMUL  D7, D14, D15
    FNMUL  S22, S29, S28
    FMADD  S18, S25, S22, S15
    FMOV  D20, #0.93750000
    FMOV  S27, S13
    FMOV  H25, X12
    FSQRT  D23, D21
    FMADD  H11, H19, H27, H7
    FSUB  D27, D23, D20
    FNMSUB  D23, D11, D11, D11
    FSUB  D21, D10, D25
    FMSUB  S4, S20, S26, S21
    FNMSUB  D11, D4, D8, D27
    FMOV  H21, #0.17968750
    FMOV  W5, H18
    FMSUB  H26, H24, H21, H23
    FABS  S9, S11
    FMOV  S20, #-26.00000000
    FNMADD  H14, H26, H26, H20
    FMOV  X13, D14
    FNMUL  H19, H28, H25
    FMADD  S29, S26, S1, S25
    FNMUL  H7, H5, H3
    FCSEL  D18, D21, D6, AL
    FMOV  D21, #-0.17968750
    FNMSUB  D8, D23, D26, D31
    FCSEL  S26, S20, S2, PL
    FNMSUB  S2, S13, S30, S30
    FMUL  D11, D2, D19
    FMOV  X2, H11
    FMADD  S4, S26, S8, S21
    FNEG  S20, S9
    FMOV  H14, X8
    FMADD  H26, H14, H7, H18
    FMOV  X3, D26
    FMOV  W24, S20
    FNEG  H8, H29
    FNMUL  D2, D4, D4
    FDIV  H21, H8, H8
    FNEG  S14, S2
    FNMADD  S26, S14, S21, S22
    FMSUB  H11, H5, H18, H6
    FNMUL  S23, S4, S31
    FMOV  X16, D22
    FSUB  H6, H11, H18
    FMOV  D9, #3.00000000
    FADD  H8, H19, H18
    FNMADD  H7, H15, H29, H19
    FMUL  S11, S16, S1
    FMADD  S18, S19, S19, S31
    FMOV  S20, S5
    FMOV  S2, S11
    FMUL  D14, D18, D18
    FMOV  W25, S0
    FMOV  S22, #-1.81250000
    FMOV  D4, D7
    FABS  S31, S4
    FMSUB  S11, S8, S6, S20
    FMOV  X3, H2
    FADD  S0, S9, S22
    FMOV  H18, H23
    FMSUB  D4, D18, D0, D26
    FNMSUB  H26, H14, H14, H4
    FNMADD  D7, D11, D26, D26
    FNMADD  S21, S7, S31, S7
    FSUB  H31, H19, H2
    FMOV  H7, X5
    FMOV  W12, S19
    FMSUB  S15, S27, S2, S2
    FNEG  D6, D12
    FABS  S20, S20
    FMOV  D23, #15.50000000
    FMOV  H22, #6.25000000
    FMUL  S19, S24, S8
    FNMUL  H27, H15, H7
    FNMADD  S2, S21, S31, S20
    FMOV  H29, #1.12500000
    FMUL  D9, D6, D6
    FADD  D8, D27, D23
    FCSEL  H18, H30, H22, EQ
    FSUB  D14, D9, D18
    FMOV  S6, W8
    FCSEL  S22, S20, S6, NV
    FMSUB  S27, S29, S19, S22
    FMOV  W17, H14
    FCSEL  S12, S27, S27, HI
    FNMUL  H24, H8, H26
    FNMUL  H26, H2, H24
    FDIV  S19, S29, S26
    FCSEL  D26, D12, D19, CS
    FMOV  H6, W10
    FMOV  W16, H3
    FMOV  X25, D31
    FDIV  S24, S24, S3
    FDIV  H20, H23, H14
    FMOV  S14, #1.12500000
    FSQRT  S22, S26
    FNMADD  D12, D5, D0, D8
    FMSUB  S18, S10, S3, S27
    FMUL  H9, H0, H6
    FMOV  H8, W28
    FMOV  D31, X18
    FABS  D23, D31
    FNMADD  H31, H24, H24, H8
    FSQRT  D2, D23
    FABS  D26, D9
    FABS  D10, D31
    FMOV  X9, H20
    FMOV  W4, H10
    SUBS  X11, X11, #0x1
    B.NE  TSRTFloatMovMadd_label_8
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    SUB  X19, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    SUB  X19, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x8000, LSL #0
    SUB  X19, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x8000, LSL #0
    SUB  X19, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    SUB  X19, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X19, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    SUB  X19, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x8000, LSL #0
    SUB  X19, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X19, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x9f, LSL #0
    MRS  X19, FPSR
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xbfe8, LSL #16
    FMOV  X19, D0
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V1.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    FMOV  X19, D1
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V2.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7ff8, LSL #48
    FMOV  X19, D2
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V3.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X19, D3
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V4.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, D4
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V5.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, D5
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V6.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    FMOV  X19, D6
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, D7
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    FMOV  X19, D8
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X19, D9
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X19, D10
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, D11
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc02f, LSL #48
    FMOV  X19, D12
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X19, V13.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X19, D13
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V14.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3f90, LSL #16
    FMOV  X19, D14
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    FMOV  X19, D15
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X19, V16.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X19, D16
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V17.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, D17
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V18.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, D18
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V19.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    FMOV  X19, D19
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X19, D20
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V21.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    FMOV  X19, D21
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V22.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, D22
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V23.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0x7fff, LSL #48
    FMOV  X19, D23
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V24.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    FMOV  X19, D24
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V25.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, D25
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X19, D26
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V27.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, D27
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V28.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x8000, LSL #16
    FMOV  X19, D28
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V29.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x3c80, LSL #0
    FMOV  X19, D29
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    FMOV  X19, D30
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X19, D31
    SUB  X29, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x275b, LSL #0
    MOVK  X2, #0xb568, LSL #16
    MOVK  X2, #0x739c, LSL #32
    MOVK  X2, #0xe981, LSL #48
    MOVZ  X3, #0xb737, LSL #0
    MOVK  X3, #0xea6, LSL #16
    MOVK  X3, #0xdf99, LSL #32
    MOVK  X3, #0xdf81, LSL #48
    MOVZ  X4, #0xfccb, LSL #0
    MOVK  X4, #0xb30a, LSL #16
    MOVK  X4, #0xf8dc, LSL #32
    MOVK  X4, #0xadf5, LSL #48
    MOVZ  X5, #0x51e8, LSL #0
    MOVK  X5, #0xe4ae, LSL #16
    MOVK  X5, #0x6226, LSL #32
    MOVK  X5, #0xa740, LSL #48
    MOVZ  X6, #0x698f, LSL #0
    MOVK  X6, #0x9a06, LSL #16
    MOVK  X6, #0xdf30, LSL #32
    MOVK  X6, #0x1bf6, LSL #48
    MOVZ  X8, #0x1db5, LSL #0
    MOVK  X8, #0xb8f8, LSL #16
    MOVK  X8, #0x88c1, LSL #32
    MOVK  X8, #0x780, LSL #48
    MOVZ  X9, #0xe153, LSL #0
    MOVK  X9, #0x5b2a, LSL #16
    MOVK  X9, #0x5f87, LSL #32
    MOVK  X9, #0x6d79, LSL #48
    MOVZ  X10, #0xcd00, LSL #0
    MOVK  X10, #0xc303, LSL #16
    MOVK  X10, #0xc1, LSL #32
    MOVK  X10, #0x5e95, LSL #48
    MOVZ  X11, #0xbe4, LSL #0
    MOVK  X11, #0x55a9, LSL #16
    MOVK  X11, #0x59fd, LSL #32
    MOVK  X11, #0xac1c, LSL #48
    MOVZ  X12, #0xba62, LSL #0
    MOVK  X12, #0x6f22, LSL #16
    MOVK  X12, #0x5982, LSL #32
    MOVK  X12, #0x5fd9, LSL #48
    MOVZ  X13, #0x6fb3, LSL #0
    MOVK  X13, #0xf329, LSL #16
    MOVK  X13, #0x4771, LSL #32
    MOVK  X13, #0x1c48, LSL #48
    MOVZ  X14, #0xbd64, LSL #0
    MOVK  X14, #0x3136, LSL #16
    MOVK  X14, #0xe586, LSL #32
    MOVK  X14, #0x7ce4, LSL #48
    MOVZ  X15, #0x7815, LSL #0
    MOVK  X15, #0xcd7c, LSL #16
    MOVK  X15, #0xb1cd, LSL #32
    MOVK  X15, #0x602a, LSL #48
    MOVZ  X16, #0x842e, LSL #0
    MOVK  X16, #0xc8d9, LSL #16
    MOVK  X16, #0xea2f, LSL #32
    MOVK  X16, #0x6cc7, LSL #48
    MOVZ  X17, #0x1646, LSL #0
    MOVK  X17, #0xb274, LSL #16
    MOVK  X17, #0xff1d, LSL #32
    MOVK  X17, #0xe65e, LSL #48
    MOVZ  X18, #0xaf5, LSL #0
    MOVK  X18, #0x3835, LSL #16
    MOVK  X18, #0xe8ec, LSL #32
    MOVK  X18, #0x8ac8, LSL #48
    MOVZ  X19, #0xa96f, LSL #0
    MOVK  X19, #0xf623, LSL #16
    MOVK  X19, #0x5fea, LSL #32
    MOVK  X19, #0x7fda, LSL #48
    MOVZ  X21, #0x688c, LSL #0
    MOVK  X21, #0x4070, LSL #16
    MOVK  X21, #0xcf10, LSL #32
    MOVK  X21, #0xcc81, LSL #48
    MOVZ  X23, #0x4c50, LSL #0
    MOVK  X23, #0x6cc4, LSL #16
    MOVK  X23, #0x574f, LSL #32
    MOVK  X23, #0x5f7e, LSL #48
    MOVZ  X24, #0x8731, LSL #0
    MOVK  X24, #0x635a, LSL #16
    MOVK  X24, #0x7dd0, LSL #32
    MOVK  X24, #0xcb4e, LSL #48
    MOVZ  X25, #0x5c4e, LSL #0
    MOVK  X25, #0xfe36, LSL #16
    MOVK  X25, #0x5763, LSL #32
    MOVK  X25, #0xb3c0, LSL #48
    MOVZ  X27, #0xa9a7, LSL #0
    MOVK  X27, #0x32de, LSL #16
    MOVK  X27, #0x508c, LSL #32
    MOVK  X27, #0xe966, LSL #48
    MOVZ  X28, #0xcdfd, LSL #0
    MOVK  X28, #0x53ae, LSL #16
    MOVK  X28, #0x7d5a, LSL #32
    MOVK  X28, #0xed7e, LSL #48
    MOVZ  X29, #0xd5e8, LSL #0
    MOVK  X29, #0xa764, LSL #16
    MOVK  X29, #0x9983, LSL #32
    MOVK  X29, #0xbab9, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X15
    FMOV  D3, X28
    FMOV  V3.D[1], X29
    FMOV  D4, X3
    FMOV  V4.D[1], X19
    FMOV  D5, X23
    FMOV  V5.D[1], X18
    FMOV  D6, X28
    FMOV  V6.D[1], X14
    FMOV  D7, X11
    FMOV  V7.D[1], X8
    FMOV  D8, X3
    FMOV  V8.D[1], X25
    FMOV  D9, X9
    FMOV  V9.D[1], X6
    FMOV  D10, X17
    FMOV  V10.D[1], X2
    FMOV  D11, X10
    FMOV  V11.D[1], X12
    FMOV  D12, X25
    FMOV  V12.D[1], X6
    FMOV  D13, X14
    FMOV  V13.D[1], X4
    FMOV  D14, X23
    FMOV  V14.D[1], X2
    FMOV  D15, X16
    FMOV  V15.D[1], X5
    FMOV  D16, X14
    FMOV  V16.D[1], X2
    FMOV  D17, X28
    FMOV  V17.D[1], X14
    FMOV  D18, X11
    FMOV  V18.D[1], X6
    FMOV  D19, X23
    FMOV  V19.D[1], X4
    FMOV  D20, X15
    FMOV  V20.D[1], X9
    FMOV  D21, X5
    FMOV  V21.D[1], X17
    FMOV  D22, X8
    FMOV  V22.D[1], X12
    FMOV  D23, X16
    FMOV  V23.D[1], X25
    FMOV  D24, X17
    FMOV  V24.D[1], X9
    FMOV  D25, X28
    FMOV  V25.D[1], X18
    FMOV  D26, X10
    FMOV  V26.D[1], X3
    FMOV  D27, X5
    FMOV  V27.D[1], X4
    FMOV  D28, X2
    FMOV  V28.D[1], X5
    FMOV  D29, X24
    FMOV  V29.D[1], X2
    FMOV  D30, X10
    FMOV  V30.D[1], X29
    FMOV  D31, X5
    FMOV  V31.D[1], X8
    MOVZ  X12, #0xf, LSL #0
TSRTFloatMovMadd_label_9:
    FMOV  H27, H18
    FADD  D1, D26, D30
    FNMADD  S29, S24, S25, S24
    FNMSUB  D2, D31, D29, D1
    FMOV  H31, #25.00000000
    FMOV  X25, D2
    FMOV  S5, W6
    FMOV  H17, #-26.00000000
    FABS  D23, D22
    FMOV  H25, H5
    FNMSUB  S10, S28, S17, S17
    FABS  H2, H23
    FMOV  S21, S25
    FNMSUB  D14, D31, D27, D10
    FCSEL  S29, S14, S21, NV
    FMUL  S18, S2, S2
    FMOV  W6, H29
    FADD  D24, D26, D5
    FNMUL  H28, H3, H5
    FCSEL  H22, H29, H2, VC
    FNEG  H30, H14
    FCSEL  H27, H26, H2, AL
    FDIV  H29, H30, H24
    FSUB  D21, D22, D11
    FNMSUB  D3, D15, D29, D23
    FDIV  H22, H26, H17
    FABS  S25, S13
    FMSUB  D14, D14, D23, D16
    FNMADD  S31, S14, S4, S6
    FCSEL  S2, S8, S14, NV
    FMOV  W25, H21
    FNMSUB  S1, S18, S27, S18
    FNMADD  S21, S1, S28, S1
    FMOV  W10, S22
    FNEG  H5, H2
    FCSEL  D13, D3, D5, LE
    FSUB  H5, H25, H13
    FNMSUB  D10, D21, D31, D31
    FMADD  S8, S5, S5, S5
    FSQRT  H24, H8
    FSQRT  H18, H24
    FMADD  H23, H17, H18, H10
    FCSEL  D5, D15, D21, LE
    FDIV  D16, D30, D31
    FMADD  S3, S1, S28, S18
    FSQRT  D28, D23
    FCSEL  S14, S10, S4, NE
    FABS  H25, H12
    FMOV  D10, D17
    FSQRT  H13, H1
    FMOV  H15, X17
    FCSEL  S2, S5, S13, HI
    FSUB  D21, D10, D14
    FADD  H14, H28, H21
    FNMADD  H8, H3, H25, H14
    FNEG  H21, H18
    FNMUL  S5, S15, S21
    FMOV  H6, H8
    FMADD  H17, H2, H2, H16
    FADD  S13, S17, S5
    FMOV  W16, H6
    FSUB  H24, H2, H13
    FNMADD  H25, H13, H5, H31
    FMADD  D17, D3, D11, D30
    FMOV  X29, H26
    FABS  H26, H13
    FADD  H1, H27, H27
    FCSEL  H5, H31, H31, AL
    FMOV  W10, H26
    FSQRT  S10, S12
    FMADD  H21, H15, H10, H24
    FMSUB  D10, D2, D22, D4
    FSQRT  S31, S30
    FMOV  W9, H23
    FMOV  D12, D10
    FMOV  D10, #-2.87500000
    FSQRT  S30, S8
    FMSUB  S23, S17, S30, S10
    FNMUL  H17, H17, H31
    FDIV  S15, S21, S5
    FMSUB  D8, D1, D15, D12
    FMUL  D28, D13, D8
    FMOV  W9, H25
    FNMADD  D24, D17, D28, D17
    FNMSUB  H31, H24, H24, H24
    FNMSUB  D30, D23, D23, D31
    FABS  H27, H6
    FSUB  S10, S0, S19
    FSUB  S13, S22, S13
    FNMSUB  D5, D27, D29, D7
    FMOV  X11, H31
    FMOV  S22, S15
    FMSUB  S15, S1, S0, S22
    FMOV  S31, S27
    FMOV  S24, S6
    FMOV  S19, #-13.00000000
    FNEG  D7, D2
    FMSUB  S27, S30, S7, S20
    FDIV  H29, H13, H15
    FABS  H8, H5
    FSUB  S21, S27, S29
    FADD  H22, H10, H21
    FNMADD  H27, H22, H8, H22
    FADD  D23, D27, D16
    FADD  H15, H23, H24
    FABS  D22, D19
    FMSUB  S23, S31, S15, S22
    FMADD  D25, D10, D15, D25
    FMOV  D1, D1
    FMOV  X23, H13
    FSQRT  D0, D4
    FMUL  D4, D9, D10
    FNMUL  S6, S27, S1
    FMOV  H9, W4
    FMOV  W27, H11
    FSUB  H10, H7, H3
    FNEG  S29, S31
    FCSEL  S20, S2, S29, NE
    FMOV  X4, D30
    FSUB  S27, S5, S21
    FSUB  H21, H4, H23
    FMOV  S1, S21
    FSQRT  D7, D10
    FMSUB  H10, H7, H1, H9
    FNMUL  D13, D10, D20
    FCSEL  S2, S30, S6, HI
    FMOV  H6, X15
    FSUB  D29, D0, D0
    FSQRT  H5, H13
    FMSUB  D30, D2, D5, D5
    FCSEL  D20, D6, D27, AL
    FABS  S5, S29
    FABS  S31, S20
    FNMADD  H15, H31, H31, H31
    FMSUB  H21, H5, H25, H5
    FABS  H27, H15
    FNEG  D0, D27
    FMUL  D5, D30, D21
    FCSEL  D21, D24, D5, AL
    FSQRT  D5, D21
    FADD  H1, H0, H5
    FNEG  D30, D0
    FSQRT  H0, H26
    FMOV  S5, #-0.48437500
    FADD  D26, D29, D22
    FABS  S13, S25
    FNMUL  D31, D20, D19
    FMUL  S15, S25, S13
    FMOV  W23, S9
    FABS  S27, S22
    FCSEL  H21, H26, H17, CC
    FCSEL  S26, S12, S6, LS
    FABS  H2, H1
    FMOV  H29, X16
    FNMADD  S24, S31, S27, S0
    FMOV  D20, #-15.50000000
    FMOV  D6, D21
    FNEG  H27, H26
    FMOV  D31, #4.75000000
    FMOV  S19, S6
    FSQRT  S20, S19
    FNEG  H26, H27
    FMOV  W29, H5
    FCSEL  H5, H24, H30, VS
    FCSEL  D6, D15, D5, LE
    FMOV  D25, X27
    FMOV  X23, D31
    FMOV  W29, S2
    FMOV  D24, #-3.00000000
    FNEG  S5, S24
    FNEG  D15, D5
    FMOV  W11, S29
    FSUB  H0, H20, H15
    FMSUB  S15, S26, S0, S25
    FSUB  H0, H15, H15
    FABS  H5, H0
    FNMADD  S20, S5, S6, S28
    FADD  H17, H31, H28
    FMADD  S31, S20, S3, S7
    FADD  H19, H9, H19
    FMOV  H21, H26
    FNMSUB  H9, H8, H10, H31
    FCSEL  H1, H19, H29, LT
    FMUL  H26, H6, H29
    FMOV  S6, #-0.48437500
    FCSEL  D19, D6, D29, PL
    FMOV  D30, D14
    FMOV  H14, W6
    FMUL  H20, H23, H21
    FMOV  H23, H19
    FABS  D19, D19
    FMOV  S6, W24
    FMSUB  H28, H23, H18, H14
    FMOV  W14, S17
    FNMADD  H2, H6, H19, H30
    FNEG  S24, S9
    FNMUL  H21, H26, H24
    FNEG  H18, H1
    FABS  D17, D18
    FMOV  D29, D17
    SUBS  X12, X12, #0x1
    B.NE  TSRTFloatMovMadd_label_9
    MOVZ  X8, #0x275b, LSL #0
    MOVK  X8, #0xb568, LSL #16
    MOVK  X8, #0x739c, LSL #32
    MOVK  X8, #0xe981, LSL #48
    SUB  X21, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xb737, LSL #0
    MOVK  X8, #0xea6, LSL #16
    MOVK  X8, #0xdf99, LSL #32
    MOVK  X8, #0xdf81, LSL #48
    SUB  X21, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x731, LSL #0
    SUB  X21, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x8000, LSL #0
    SUB  X21, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x6fb3, LSL #0
    MOVK  X8, #0xf329, LSL #16
    MOVK  X8, #0x4771, LSL #32
    MOVK  X8, #0x1c48, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X21, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x7815, LSL #0
    MOVK  X8, #0xcd7c, LSL #16
    MOVK  X8, #0xb1cd, LSL #32
    MOVK  X8, #0x602a, LSL #48
    SUB  X21, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x8000, LSL #0
    SUB  X21, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x1646, LSL #0
    MOVK  X8, #0xb274, LSL #16
    MOVK  X8, #0xff1d, LSL #32
    MOVK  X8, #0xe65e, LSL #48
    SUB  X21, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xaf5, LSL #0
    MOVK  X8, #0x3835, LSL #16
    MOVK  X8, #0xe8ec, LSL #32
    MOVK  X8, #0x8ac8, LSL #48
    SUB  X21, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xa96f, LSL #0
    MOVK  X8, #0xf623, LSL #16
    MOVK  X8, #0x5fea, LSL #32
    MOVK  X8, #0x7fda, LSL #48
    SUB  X21, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x4013, LSL #48
    SUB  X21, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x8731, LSL #0
    MOVK  X8, #0x635a, LSL #16
    MOVK  X8, #0x7dd0, LSL #32
    MOVK  X8, #0xcb4e, LSL #48
    SUB  X21, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xcd00, LSL #0
    SUB  X21, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xcd00, LSL #0
    SUB  X21, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xcdfd, LSL #0
    MOVK  X8, #0x53ae, LSL #16
    MOVK  X8, #0x7d5a, LSL #32
    MOVK  X8, #0xed7e, LSL #48
    SUB  X21, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x7bff, LSL #0
    SUB  X21, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x9f, LSL #0
    MRS  X21, FPSR
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D0
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x8000, LSL #0
    FMOV  X21, D1
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V2.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D2
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D3
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D4
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D5
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x8731, LSL #0
    MOVK  X8, #0x635a, LSL #16
    FMOV  X21, D6
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D7
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D8
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D9
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D10
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xba62, LSL #0
    MOVK  X8, #0x6f22, LSL #16
    MOVK  X8, #0x5982, LSL #32
    MOVK  X8, #0x5fd9, LSL #48
    FMOV  X21, V11.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xcd00, LSL #0
    MOVK  X8, #0xc303, LSL #16
    MOVK  X8, #0xc1, LSL #32
    MOVK  X8, #0x5e95, LSL #48
    FMOV  X21, D11
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D12
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D13
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D14
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D15
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x7ff8, LSL #48
    FMOV  X21, D16
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D17
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D18
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xbef8, LSL #16
    FMOV  X21, D19
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D20
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D21
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xc150, LSL #16
    FMOV  X21, D22
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D23
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x8000, LSL #16
    FMOV  X21, D24
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xcd00, LSL #0
    FMOV  X21, D25
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x8000, LSL #0
    FMOV  X21, D26
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0xf815, LSL #0
    FMOV  X21, D27
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D28
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D29
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D30
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D31
    SUB  X5, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X18
    FMOV  V0.D[1], X6
    FMOV  D1, X11
    FMOV  V1.D[1], X16
    FMOV  D2, X25
    FMOV  V2.D[1], X23
    FMOV  D3, X19
    FMOV  V3.D[1], X24
    FMOV  D4, X29
    FMOV  V4.D[1], X28
    FMOV  D5, X17
    FMOV  V5.D[1], X21
    FMOV  D6, X27
    FMOV  V6.D[1], X10
    FMOV  D7, X6
    FMOV  V7.D[1], X4
    FMOV  D8, X23
    FMOV  V8.D[1], X14
    FMOV  D9, X21
    FMOV  V9.D[1], X2
    FMOV  D10, X15
    FMOV  V10.D[1], X5
    FMOV  D11, X11
    FMOV  V11.D[1], X14
    FMOV  D12, X29
    FMOV  V12.D[1], X29
    FMOV  D13, X27
    FMOV  V13.D[1], X8
    FMOV  D14, X9
    FMOV  V14.D[1], X15
    FMOV  D15, X5
    FMOV  V15.D[1], X2
    FMOV  D16, X14
    FMOV  V16.D[1], X13
    FMOV  D17, X16
    FMOV  V17.D[1], X14
    FMOV  D18, X14
    FMOV  V18.D[1], X18
    FMOV  D19, X11
    FMOV  V19.D[1], X15
    FMOV  D20, X6
    FMOV  V20.D[1], X24
    FMOV  D21, X8
    FMOV  V21.D[1], X8
    FMOV  D22, X21
    FMOV  V22.D[1], X28
    FMOV  D23, X29
    FMOV  V23.D[1], X29
    FMOV  D24, X8
    FMOV  V24.D[1], X14
    FMOV  D25, X12
    FMOV  V25.D[1], X6
    FMOV  D26, X2
    FMOV  V26.D[1], X8
    FMOV  D27, X11
    FMOV  V27.D[1], X9
    FMOV  D28, X11
    FMOV  V28.D[1], X13
    FMOV  D29, X6
    FMOV  V29.D[1], X19
    FMOV  D30, X3
    FMOV  V30.D[1], X4
    FMOV  D31, X8
    FMOV  V31.D[1], X5
    MOVZ  X21, #0xf, LSL #0
TSRTFloatMovMadd_label_10:
    FSQRT  H3, H17
    FMOV  S23, W24
    FMOV  W3, H29
    FNMADD  H18, H26, H25, H26
    FNMUL  H20, H31, H18
    FMOV  S19, #0.19531250
    FMOV  H8, W3
    FADD  D3, D30, D8
    FMOV  W29, H3
    FABS  H8, H28
    FMOV  D24, #-0.20312500
    FMUL  S27, S23, S23
    FCSEL  H11, H27, H27, VS
    FMOV  X3, H30
    FMOV  S20, #-4.50000000
    FADD  H28, H20, H19
    FABS  S2, S28
    FNMADD  H28, H24, H2, H11
    FMOV  S3, W21
    FSQRT  D17, D28
    FMUL  S25, S17, S8
    FADD  D23, D3, D25
    FDIV  D27, D29, D30
    FSQRT  S28, S2
    FSUB  D2, D17, D3
    FMSUB  H20, H10, H11, H27
    FSUB  D8, D30, D20
    FMADD  D26, D8, D14, D24
    FMADD  D3, D15, D13, D16
    FNMUL  D31, D17, D20
    FABS  H20, H29
    FMUL  S19, S29, S4
    FNMUL  D10, D1, D20
    FMADD  S13, S26, S28, S26
    FNMUL  D28, D16, D8
    FNEG  H8, H30
    FNMSUB  S16, S23, S8, S3
    FDIV  S23, S25, S2
    FDIV  D11, D13, D23
    FMSUB  D27, D10, D31, D11
    FMOV  S4, W11
    FMOV  S15, #0.19531250
    FMOV  D2, X24
    FSQRT  S11, S28
    FMOV  S17, W8
    FMOV  H13, W11
    FMOV  S1, W10
    FMOV  D31, X11
    FMOV  X27, H11
    FMUL  S10, S27, S16
    FMSUB  D23, D10, D4, D20
    FMOV  D24, #-0.34375000
    FSUB  D26, D24, D13
    FMOV  W8, H15
    FNMSUB  D13, D31, D26, D26
    FMOV  W8, H23
    FNMUL  S31, S2, S1
    FMUL  H28, H17, H17
    FNMADD  S2, S28, S13, S13
    FMADD  H1, H19, H2, H31
    FDIV  H31, H7, H13
    FABS  S17, S9
    FMUL  S23, S13, S9
    FDIV  H30, H13, H1
    FMOV  H26, W29
    FMOV  S27, S29
    FMUL  D28, D21, D10
    FSUB  D15, D11, D1
    FMOV  H20, #-1.75000000
    FNMUL  S24, S29, S28
    FMOV  H21, W14
    FNMUL  D28, D31, D15
    FMOV  D2, D30
    FMOV  W19, S17
    FCSEL  H10, H14, H30, LE
    FMOV  W9, H20
    FMADD  D7, D10, D24, D28
    FNMUL  D17, D28, D27
    FMOV  S16, S23
    FSQRT  D29, D21
    FNMADD  H31, H29, H29, H26
    FMOV  H19, H2
    FDIV  S24, S19, S19
    FSQRT  S14, S7
    FMUL  H9, H31, H11
    FMOV  S11, W23
    FNEG  H13, H24
    FDIV  S30, S13, S11
    FMSUB  S15, S14, S30, S16
    FNEG  D14, D9
    FDIV  S19, S15, S17
    FCSEL  S24, S14, S18, GT
    FABS  H20, H19
    FMSUB  H11, H20, H20, H20
    FMOV  H18, W19
    FMSUB  D10, D24, D24, D18
    FNEG  S27, S11
    FNMUL  S21, S10, S27
    FSQRT  H11, H7
    FMUL  D24, D14, D20
    FMADD  S23, S9, S29, S27
    FNMUL  H16, H20, H23
    FCSEL  H20, H4, H21, CC
    FABS  H14, H14
    FNMADD  S31, S24, S28, S23
    FMUL  D30, D28, D10
    FMUL  H23, H18, H10
    FDIV  H29, H30, H13
    FMSUB  S24, S27, S28, S15
    FMOV  H9, W10
    FSQRT  D30, D21
    FNMADD  D28, D30, D20, D30
    FSQRT  S27, S24
    FCSEL  S30, S9, S31, GT
    FABS  D24, D30
    FMOV  D30, X17
    FDIV  H20, H30, H16
    FDIV  H31, H14, H28
    FSQRT  D16, D11
    FNMSUB  D7, D27, D24, D23
    FMUL  D21, D16, D20
    FNMSUB  H11, H21, H31, H29
    FNMSUB  S4, S11, S11, S11
    FABS  H21, H7
    FNMUL  H20, H4, H21
    FMADD  D4, D22, D19, D20
    FNMADD  S15, S25, S15, S29
    FMOV  X3, D5
    FMOV  X19, D13
    FNMSUB  D9, D15, D28, D18
    FMSUB  H22, H2, H17, H26
    FNMSUB  S10, S6, S3, S5
    FNMUL  S21, S14, S11
    FNMSUB  D17, D15, D3, D27
    FCSEL  H18, H6, H9, LE
    FMOV  H28, X11
    FNMUL  H30, H18, H22
    FABS  S5, S16
    FNMADD  S1, S22, S30, S26
    FMOV  W27, H21
    FSQRT  H2, H18
    FMOV  D14, X11
    FMOV  S24, W8
    FMOV  D20, X19
    FMADD  H30, H17, H10, H1
    FMADD  D29, D19, D24, D20
    FNMUL  H16, H14, H14
    FSUB  D24, D30, D29
    FMUL  S23, S5, S28
    FNEG  D31, D24
    FMADD  H1, H2, H4, H4
    FCSEL  S2, S31, S1, HI
    FABS  S1, S2
    FSUB  S22, S23, S1
    FNMADD  H17, H22, H22, H16
    FDIV  D6, D1, D17
    FADD  S19, S0, S16
    FMOV  S16, S2
    FMOV  W8, H30
    FMOV  W8, S27
    FNMUL  S26, S7, S13
    FSQRT  H23, H24
    FMADD  H3, H2, H31, H22
    FMUL  S17, S19, S25
    FMSUB  S24, S19, S14, S27
    FNEG  H4, H19
    FMOV  W6, S19
    FMOV  H14, X21
    FDIV  H22, H14, H16
    FNMUL  S13, S26, S22
    FMOV  S31, #-1.25000000
    FMOV  W12, S4
    FMOV  S0, W6
    FNMADD  H1, H31, H1, H6
    FMUL  S30, S0, S23
    FMOV  X9, H24
    FNMSUB  H4, H3, H30, H1
    FMADD  S24, S17, S17, S17
    FMOV  X12, H24
    FMSUB  S31, S26, S4, S4
    FNMSUB  S27, S13, S13, S31
    FNEG  H25, H4
    FNMADD  S13, S6, S2, S25
    FMSUB  S7, S8, S15, S0
    FSQRT  H19, H8
    FNMSUB  H14, H23, H22, H25
    FNEG  S16, S15
    FCSEL  S31, S30, S13, VC
    FNMSUB  H30, H23, H15, H7
    FCSEL  S1, S26, S29, MI
    FMOV  D13, #19.00000000
    FNMADD  S3, S29, S7, S28
    FADD  D4, D27, D27
    FNMSUB  H23, H19, H3, H30
    FMSUB  H29, H15, H31, H23
    FADD  D25, D1, D29
    FNMADD  H2, H4, H14, H13
    FDIV  S6, S25, S16
    FNMUL  H13, H6, H6
    FNMSUB  S16, S2, S2, S13
    SUBS  X21, X21, #0x1
    B.NE  TSRTFloatMovMadd_label_10
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    SUB  X2, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    SUB  X2, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X2, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x9f, LSL #0
    MRS  X2, FPSR
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D0
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D1
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X2, D2
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X2, D3
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D4
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V5.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D5
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X2, D6
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X2, D7
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X2, D8
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    FMOV  X2, D9
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X2, D10
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X2, D11
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D12
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X2, D13
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X2, D14
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X2, D15
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D16
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D17
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D18
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X2, D19
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X2, D20
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V21.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    FMOV  X2, D21
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V22.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7c00, LSL #0
    FMOV  X2, D22
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X2, D23
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D24
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D25
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    FMOV  X2, D26
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D27
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X2, D29
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D30
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X2, D31
    SUB  X25, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
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
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X2
    FMOV  V3.D[1], X16
    FMOV  D4, X15
    FMOV  V4.D[1], X23
    FMOV  D5, X23
    FMOV  V5.D[1], X11
    FMOV  D6, X28
    FMOV  V6.D[1], X27
    FMOV  D7, X6
    FMOV  V7.D[1], X9
    FMOV  D8, X8
    FMOV  V8.D[1], X14
    FMOV  D9, X24
    FMOV  V9.D[1], X9
    FMOV  D10, X29
    FMOV  V10.D[1], X19
    FMOV  D11, X14
    FMOV  V11.D[1], X2
    FMOV  D12, X19
    FMOV  V12.D[1], X18
    FMOV  D13, X13
    FMOV  V13.D[1], X11
    FMOV  D14, X16
    FMOV  V14.D[1], X18
    FMOV  D15, X24
    FMOV  V15.D[1], X2
    FMOV  D16, X16
    FMOV  V16.D[1], X2
    FMOV  D17, X13
    FMOV  V17.D[1], X21
    FMOV  D18, X23
    FMOV  V18.D[1], X28
    FMOV  D19, X4
    FMOV  V19.D[1], X17
    FMOV  D20, X14
    FMOV  V20.D[1], X27
    FMOV  D21, X23
    FMOV  V21.D[1], X17
    FMOV  D22, X8
    FMOV  V22.D[1], X12
    FMOV  D23, X10
    FMOV  V23.D[1], X28
    FMOV  D24, X21
    FMOV  V24.D[1], X16
    FMOV  D25, X10
    FMOV  V25.D[1], X16
    FMOV  D26, X8
    FMOV  V26.D[1], X10
    FMOV  D27, X4
    FMOV  V27.D[1], X5
    FMOV  D28, X25
    FMOV  V28.D[1], X4
    FMOV  D29, X15
    FMOV  V29.D[1], X4
    FMOV  D30, X19
    FMOV  V30.D[1], X5
    FMOV  D31, X11
    FMOV  V31.D[1], X25
    MOVZ  X17, #0xf, LSL #0
TSRTFloatMovMadd_label_11:
    FMOV  D17, X17
    FMADD  S11, S24, S29, S27
    FMOV  H18, X18
    FNMADD  H5, H26, H26, H18
    FMOV  W10, H28
    FABS  H22, H31
    FCSEL  S19, S30, S11, CS
    FSQRT  H17, H22
    FMADD  S23, S5, S19, S25
    FABS  S28, S17
    FSQRT  S12, S23
    FMOV  H8, #-0.28125000
    FMOV  H13, H28
    FMOV  S18, S12
    FNMSUB  H31, H18, H13, H8
    FMOV  W25, H29
    FSQRT  S12, S30
    FCSEL  H30, H17, H24, NV
    FDIV  S18, S28, S18
    FMSUB  S25, S12, S10, S24
    FMADD  H8, H2, H13, H15
    FMOV  X18, D8
    FADD  D8, D22, D8
    FMOV  W24, S22
    FMOV  S23, W10
    FMUL  H11, H7, H6
    FMUL  D24, D26, D6
    FADD  H17, H28, H22
    FSQRT  D29, D18
    FMOV  W10, S31
    FSUB  H31, H17, H29
    FMUL  D5, D31, D30
    FMOV  W16, H23
    FMOV  S12, #-8.50000000
    FNEG  H13, H8
    FMOV  S2, #6.25000000
    FNMSUB  S19, S5, S26, S11
    FCSEL  H10, H24, H13, LS
    FMSUB  S6, S12, S25, S10
    FMOV  H15, X10
    FMADD  H31, H15, H6, H4
    FMOV  H10, H2
    FSQRT  S18, S22
    FMUL  S13, S10, S8
    FMSUB  H30, H13, H31, H19
    FMOV  S23, S30
    FMUL  H15, H23, H18
    FSUB  S8, S18, S23
    FSUB  S22, S3, S23
    FMOV  H18, X3
    FNMUL  D7, D21, D29
    FCSEL  D31, D4, D20, AL
    FSQRT  S3, S30
    FNMUL  S26, S11, S26
    FDIV  S20, S17, S2
    FMOV  W19, H20
    FMOV  D23, D31
    FNEG  D6, D23
    FMOV  W21, H7
    FSQRT  D17, D18
    FCSEL  H30, H26, H15, MI
    FDIV  H10, H6, H22
    FDIV  S18, S10, S17
    FMSUB  D19, D18, D30, D8
    FCSEL  H4, H3, H19, VS
    FNEG  S17, S2
    FMUL  H2, H2, H0
    FMOV  X4, D9
    FSQRT  H9, H10
    FDIV  S10, S13, S19
    FMADD  D3, D13, D17, D16
    FMOV  H0, #2.37500000
    FMOV  H6, #3.87500000
    FDIV  S20, S26, S15
    FNMADD  S23, S15, S14, S26
    FSQRT  H15, H2
    FMOV  D31, #-13.00000000
    FMOV  X9, D31
    FMUL  S22, S4, S0
    FABS  S11, S10
    FMSUB  S30, S15, S15, S6
    FMOV  H18, #13.50000000
    FMUL  D26, D9, D22
    FMOV  H7, X14
    FCSEL  D31, D23, D15, CC
    FSQRT  D4, D20
    FNEG  D14, D4
    FMSUB  H15, H7, H31, H18
    FMOV  H23, #1.12500000
    FABS  H20, H20
    FMSUB  H10, H3, H11, H11
    FCSEL  H16, H0, H10, MI
    FSQRT  H19, H26
    FMOV  S22, W8
    FMUL  S6, S30, S15
    FMOV  S10, W21
    FMUL  H31, H14, H14
    FMUL  H2, H20, H23
    FMOV  D4, D16
    FNEG  D0, D19
    FMOV  W12, S2
    FMOV  H2, X5
    FDIV  S23, S2, S2
    FNMSUB  H7, H6, H10, H31
    FMADD  D20, D23, D22, D22
    FMOV  S26, #-2.75000000
    FADD  D30, D7, D7
    FSQRT  H10, H4
    FMSUB  S19, S10, S6, S0
    FNMSUB  H0, H19, H20, H30
    FADD  H2, H31, H26
    FADD  H22, H2, H2
    FMOV  D16, D0
    FSQRT  D20, D22
    FABS  S31, S16
    FSQRT  H16, H20
    FMUL  H14, H16, H16
    FNMUL  H10, H31, H14
    FADD  S23, S5, S5
    FSQRT  S5, S3
    FSUB  S31, S20, S17
    FSUB  D2, D1, D10
    FNMSUB  D3, D17, D26, D25
    FSUB  S1, S10, S22
    FCSEL  D15, D30, D0, AL
    FDIV  D7, D17, D4
    FCSEL  D20, D1, D8, MI
    FNEG  H14, H1
    FMOV  D16, X19
    FMOV  D26, #0.50000000
    FSQRT  S1, S26
    FABS  S30, S1
    FNMSUB  D22, D16, D30, D23
    FMOV  D6, X13
    FMOV  H10, #-6.75000000
    FMADD  S30, S2, S7, S2
    FSUB  H23, H22, H31
    FMSUB  H8, H15, H3, H6
    FDIV  D31, D5, D20
    FMOV  H19, #-0.14062500
    FNMUL  S2, S10, S19
    FMOV  H4, #0.62500000
    FNMADD  D16, D30, D8, D30
    FMSUB  D26, D1, D14, D16
    FCSEL  D7, D23, D2, NE
    FABS  S14, S4
    FMOV  X27, D14
    FMOV  D3, D7
    FABS  S22, S3
    FSQRT  H16, H26
    FMADD  S20, S31, S16, S22
    FNMSUB  H7, H30, H22, H14
    FNEG  D30, D4
    FMADD  H4, H6, H7, H26
    FNEG  D3, D15
    FSUB  H10, H22, H4
    FNEG  D2, D29
    FDIV  D29, D13, D8
    FNMUL  H14, H29, H28
    FDIV  H22, H5, H22
    FMSUB  H16, H4, H17, H9
    FMOV  S23, #1.56250000
    FMOV  H7, X17
    FADD  D31, D23, D2
    FSQRT  H6, H7
    FNMADD  S26, S6, S10, S6
    FMOV  W2, H26
    FMSUB  S13, S31, S20, S14
    FABS  H2, H11
    FMOV  S6, W25
    FNEG  H28, H30
    FMADD  H29, H28, H13, H13
    FDIV  S26, S2, S6
    FSUB  H8, H16, H3
    FADD  D29, D8, D22
    FNMSUB  S14, S29, S26, S29
    FMOV  D3, #5.75000000
    FADD  S2, S30, S6
    FADD  H29, H24, H8
    FNMADD  H6, H2, H24, H11
    FMUL  D16, D29, D12
    FMUL  D10, D14, D14
    FMOV  W10, S10
    FDIV  H13, H8, H10
    FMADD  S5, S20, S12, S31
    FMOV  D28, X25
    FNEG  H22, H11
    FADD  D31, D6, D2
    FMUL  H24, H14, H26
    FMOV  H11, X28
    FNMSUB  H29, H13, H7, H3
    FMOV  W28, S31
    FSUB  H6, H29, H16
    FMUL  H2, H5, H22
    FMOV  W8, S2
    FNMSUB  H5, H6, H24, H21
    FMOV  D12, X10
    FMADD  S20, S12, S11, S5
    FMUL  H10, H20, H20
    FMOV  S29, #13.50000000
    SUBS  X17, X17, #0x1
    B.NE  TSRTFloatMovMadd_label_11
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X11, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    SUB  X11, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X11, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X11, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x8000, LSL #0
    SUB  X11, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc02a, LSL #48
    SUB  X11, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X11, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    SUB  X11, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x3900, LSL #0
    SUB  X11, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X11, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x9f, LSL #0
    MRS  X11, FPSR
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V0.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D0
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D1
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x8000, LSL #0
    FMOV  X11, D2
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4017, LSL #48
    FMOV  X11, D3
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X11, D4
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V5.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X11, D5
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V6.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X11, D6
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x1, LSL #0
    FMOV  X11, D7
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X11, D8
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V9.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X11, D9
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D10
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D11
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D12
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x7e00, LSL #0
    FMOV  X11, D13
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    FMOV  X11, D14
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D15
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D16
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xc0c8, LSL #16
    FMOV  X11, D17
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V18.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x4ac0, LSL #0
    FMOV  X11, D18
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xb080, LSL #0
    FMOV  X11, D19
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D20
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X11, V21.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X11, D21
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x8000, LSL #0
    FMOV  X11, D22
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x3fc8, LSL #16
    FMOV  X11, D23
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D24
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D25
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x7fc0, LSL #16
    FMOV  X11, D26
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X11, V27.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    FMOV  X11, D27
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D28
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0x4158, LSL #16
    FMOV  X11, D29
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x3900, LSL #0
    MOVK  X15, #0x8000, LSL #48
    FMOV  X11, D30
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X11, D31
    SUB  X29, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xe69c, LSL #0
    MOVK  X2, #0xff31, LSL #16
    MOVK  X2, #0x1c53, LSL #32
    MOVK  X2, #0x77b9, LSL #48
    MOVZ  X3, #0x2b40, LSL #0
    MOVK  X3, #0x2e3f, LSL #16
    MOVK  X3, #0xe3e1, LSL #32
    MOVK  X3, #0x8b95, LSL #48
    MOVZ  X4, #0x5e02, LSL #0
    MOVK  X4, #0xbcbc, LSL #16
    MOVK  X4, #0xc908, LSL #32
    MOVK  X4, #0x3f9c, LSL #48
    MOVZ  X5, #0x25fe, LSL #0
    MOVK  X5, #0xec38, LSL #16
    MOVK  X5, #0x427c, LSL #32
    MOVK  X5, #0xc40a, LSL #48
    MOVZ  X6, #0x2f4e, LSL #0
    MOVK  X6, #0xa00a, LSL #16
    MOVK  X6, #0xd826, LSL #32
    MOVK  X6, #0x4561, LSL #48
    MOVZ  X8, #0xa433, LSL #0
    MOVK  X8, #0xaf39, LSL #16
    MOVK  X8, #0x633d, LSL #32
    MOVK  X8, #0x89c7, LSL #48
    MOVZ  X9, #0xc31b, LSL #0
    MOVK  X9, #0x3932, LSL #16
    MOVK  X9, #0x9603, LSL #32
    MOVK  X9, #0x90b9, LSL #48
    MOVZ  X10, #0xffa6, LSL #0
    MOVK  X10, #0x3a84, LSL #16
    MOVK  X10, #0xb01f, LSL #32
    MOVK  X10, #0x3944, LSL #48
    MOVZ  X11, #0xb9d3, LSL #0
    MOVK  X11, #0xd015, LSL #16
    MOVK  X11, #0x26fc, LSL #32
    MOVK  X11, #0xb60b, LSL #48
    MOVZ  X12, #0xd67f, LSL #0
    MOVK  X12, #0x912d, LSL #16
    MOVK  X12, #0x29fe, LSL #32
    MOVK  X12, #0x23b, LSL #48
    MOVZ  X13, #0x48d7, LSL #0
    MOVK  X13, #0x64ec, LSL #16
    MOVK  X13, #0xddc, LSL #32
    MOVK  X13, #0x3964, LSL #48
    MOVZ  X14, #0x4654, LSL #0
    MOVK  X14, #0x6b58, LSL #16
    MOVK  X14, #0x2265, LSL #32
    MOVK  X14, #0xb475, LSL #48
    MOVZ  X15, #0xb666, LSL #0
    MOVK  X15, #0x1965, LSL #16
    MOVK  X15, #0xe2d6, LSL #32
    MOVK  X15, #0x593, LSL #48
    MOVZ  X16, #0x834a, LSL #0
    MOVK  X16, #0xc1a9, LSL #16
    MOVK  X16, #0xf7c2, LSL #32
    MOVK  X16, #0x61c6, LSL #48
    MOVZ  X17, #0x7f1, LSL #0
    MOVK  X17, #0x85c0, LSL #16
    MOVK  X17, #0xb767, LSL #32
    MOVK  X17, #0xccb7, LSL #48
    MOVZ  X18, #0xdd56, LSL #0
    MOVK  X18, #0xec89, LSL #16
    MOVK  X18, #0xf0a4, LSL #32
    MOVK  X18, #0x4905, LSL #48
    MOVZ  X19, #0xc95e, LSL #0
    MOVK  X19, #0x7bc7, LSL #16
    MOVK  X19, #0x3fb5, LSL #32
    MOVK  X19, #0x8d1, LSL #48
    MOVZ  X21, #0x8d16, LSL #0
    MOVK  X21, #0x347c, LSL #16
    MOVK  X21, #0xf8a1, LSL #32
    MOVK  X21, #0x7c87, LSL #48
    MOVZ  X23, #0xbc62, LSL #0
    MOVK  X23, #0x9715, LSL #16
    MOVK  X23, #0xb624, LSL #32
    MOVK  X23, #0xa531, LSL #48
    MOVZ  X24, #0x801d, LSL #0
    MOVK  X24, #0xd879, LSL #16
    MOVK  X24, #0x77cf, LSL #32
    MOVK  X24, #0x5fcb, LSL #48
    MOVZ  X25, #0x9d7a, LSL #0
    MOVK  X25, #0x91ae, LSL #16
    MOVK  X25, #0xd1a, LSL #32
    MOVK  X25, #0xbe14, LSL #48
    MOVZ  X27, #0x47d9, LSL #0
    MOVK  X27, #0xf320, LSL #16
    MOVK  X27, #0x6a33, LSL #32
    MOVK  X27, #0x88e9, LSL #48
    MOVZ  X28, #0xfa11, LSL #0
    MOVK  X28, #0xc094, LSL #16
    MOVK  X28, #0xdec7, LSL #32
    MOVK  X28, #0xce24, LSL #48
    MOVZ  X29, #0x4fd5, LSL #0
    MOVK  X29, #0x897b, LSL #16
    MOVK  X29, #0xb7e4, LSL #32
    MOVK  X29, #0x78a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X21
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X23
    FMOV  V3.D[1], X2
    FMOV  D4, X3
    FMOV  V4.D[1], X28
    FMOV  D5, X6
    FMOV  V5.D[1], X27
    FMOV  D6, X23
    FMOV  V6.D[1], X3
    FMOV  D7, X10
    FMOV  V7.D[1], X10
    FMOV  D8, X23
    FMOV  V8.D[1], X2
    FMOV  D9, X24
    FMOV  V9.D[1], X16
    FMOV  D10, X10
    FMOV  V10.D[1], X25
    FMOV  D11, X14
    FMOV  V11.D[1], X14
    FMOV  D12, X25
    FMOV  V12.D[1], X24
    FMOV  D13, X24
    FMOV  V13.D[1], X28
    FMOV  D14, X16
    FMOV  V14.D[1], X15
    FMOV  D15, X15
    FMOV  V15.D[1], X6
    FMOV  D16, X18
    FMOV  V16.D[1], X14
    FMOV  D17, X14
    FMOV  V17.D[1], X3
    FMOV  D18, X9
    FMOV  V18.D[1], X11
    FMOV  D19, X8
    FMOV  V19.D[1], X8
    FMOV  D20, X29
    FMOV  V20.D[1], X29
    FMOV  D21, X9
    FMOV  V21.D[1], X19
    FMOV  D22, X9
    FMOV  V22.D[1], X8
    FMOV  D23, X13
    FMOV  V23.D[1], X17
    FMOV  D24, X11
    FMOV  V24.D[1], X2
    FMOV  D25, X25
    FMOV  V25.D[1], X21
    FMOV  D26, X13
    FMOV  V26.D[1], X21
    FMOV  D27, X5
    FMOV  V27.D[1], X27
    FMOV  D28, X6
    FMOV  V28.D[1], X25
    FMOV  D29, X14
    FMOV  V29.D[1], X11
    FMOV  D30, X2
    FMOV  V30.D[1], X13
    FMOV  D31, X11
    FMOV  V31.D[1], X6
    MOVZ  X3, #0xf, LSL #0
TSRTFloatMovMadd_label_12:
    FCSEL  H30, H28, H26, LS
    FSUB  H17, H24, H25
    FNMADD  D18, D27, D23, D17
    FNMSUB  D19, D30, D18, D21
    FMOV  S3, W24
    FMSUB  H27, H19, H3, H29
    FSQRT  H21, H27
    FMOV  H4, X3
    FCSEL  D16, D4, D4, LT
    FSUB  D23, D31, D31
    FMOV  X11, H23
    FMADD  S11, S16, S16, S21
    FSUB  S23, S11, S11
    FDIV  H21, H14, H0
    FNMUL  S18, S0, S14
    FMOV  W13, S15
    FABS  D0, D20
    FMOV  X6, D3
    FSQRT  D28, D17
    FSQRT  H27, H4
    FMOV  S4, W8
    FCSEL  D16, D7, D3, GT
    FNMADD  D14, D17, D22, D6
    FNMADD  D19, D0, D21, D14
    FADD  D0, D28, D28
    FMOV  W8, H18
    FDIV  H14, H4, H0
    FMOV  X13, D19
    FMADD  S31, S23, S27, S23
    FSQRT  D17, D16
    FDIV  D11, D31, D14
    FNMUL  S15, S11, S17
    FNMUL  S3, S15, S17
    FNMUL  H17, H7, H29
    FMOV  S20, S6
    FMADD  D23, D6, D6, D20
    FMUL  H14, H12, H19
    FMSUB  H19, H17, H29, H4
    FMADD  H28, H19, H28, H25
    FMOV  S11, #-0.42187500
    FADD  S6, S25, S0
    FNMUL  H21, H28, H30
    FMOV  D20, X29
    FDIV  S29, S14, S20
    FMOV  S22, #-1.56250000
    FMUL  S15, S1, S7
    FSQRT  H14, H25
    FMOV  H12, W2
    FNMUL  H18, H23, H11
    FMOV  X21, H18
    FADD  S27, S14, S15
    FMOV  S17, W14
    FSUB  S30, S12, S12
    FADD  D15, D6, D21
    FMSUB  D6, D22, D3, D29
    FABS  H21, H27
    FNEG  S20, S21
    FMOV  S14, S17
    FMOV  S18, S30
    FMSUB  H1, H14, H18, H18
    FDIV  H7, H1, H18
    FMSUB  S3, S7, S15, S12
    FNMSUB  S18, S3, S3, S6
    FDIV  H22, H20, H18
    FMOV  H17, H20
    FMADD  H15, H27, H25, H30
    FMOV  S19, #-0.17968750
    FNEG  D29, D14
    FADD  D23, D3, D24
    FSQRT  S21, S16
    FDIV  S6, S5, S11
    FNMUL  S5, S31, S11
    FMOV  H30, #4.00000000
    FNMSUB  S16, S30, S30, S29
    FSUB  D3, D16, D17
    FNMSUB  S7, S21, S3, S5
    FNMUL  S12, S21, S6
    FABS  D1, D12
    FADD  S27, S1, S1
    FNMADD  D1, D23, D27, D19
    FMUL  D24, D15, D1
    FDIV  S27, S22, S27
    FADD  H5, H27, H7
    FMOV  H6, W13
    FABS  D20, D24
    FMSUB  D23, D5, D20, D20
    FMOV  S7, S23
    FADD  S24, S7, S2
    FMUL  H25, H24, H6
    FNMADD  S31, S10, S28, S24
    FMADD  H29, H0, H27, H18
    FSUB  S23, S3, S0
    FCSEL  D16, D17, D10, MI
    FNMUL  H2, H10, H21
    FADD  D6, D27, D16
    FNEG  H20, H24
    FNMUL  D3, D6, D25
    FMOV  D28, #-0.40625000
    FMOV  X24, H5
    FSUB  D10, D26, D12
    FMUL  H7, H26, H2
    FABS  H17, H11
    FNMSUB  S2, S10, S31, S29
    FSQRT  D10, D28
    FADD  H21, H20, H23
    FSUB  D0, D30, D3
    FNMUL  H29, H0, H10
    FMOV  W24, S7
    FABS  D22, D29
    FNEG  S25, S21
    FMOV  D21, D17
    FMOV  X16, H2
    FMOV  D17, X21
    FMUL  H28, H25, H22
    FMOV  X12, D21
    FADD  S2, S17, S17
    FNMSUB  D23, D2, D28, D29
    FMOV  X6, H27
    FCSEL  D10, D30, D3, GT
    FMOV  S29, S13
    FMOV  H0, X10
    FMOV  W19, H6
    FSQRT  S17, S24
    FSUB  S21, S29, S10
    FMOV  D24, X19
    FMSUB  H3, H5, H28, H26
    FNMADD  D22, D9, D11, D24
    FMOV  H6, W24
    FMSUB  H9, H1, H21, H11
    FMADD  D26, D30, D22, D20
    FSUB  D13, D14, D24
    FABS  S25, S28
    FNMADD  S28, S23, S3, S23
    FSQRT  H11, H0
    FMOV  X5, D11
    FNMSUB  H7, H6, H17, H9
    FNMADD  S2, S13, S7, S13
    FMOV  H5, W3
    FMOV  S30, S28
    FMUL  H23, H5, H26
    FMOV  D3, D23
    FMADD  S27, S3, S3, S25
    FMOV  H5, X17
    FMADD  D21, D5, D30, D30
    FNMADD  S11, S22, S21, S21
    FADD  S23, S2, S27
    FSUB  D28, D13, D28
    FDIV  H29, H28, H11
    FNMSUB  H1, H23, H23, H18
    FADD  S26, S13, S1
    FADD  H9, H26, H29
    FADD  D21, D18, D4
    FSUB  S5, S1, S23
    FNMADD  H7, H29, H27, H26
    FSQRT  D22, D28
    FMOV  H13, H25
    FCSEL  D23, D3, D12, GT
    FMUL  D6, D31, D31
    FMSUB  S30, S24, S22, S30
    FMADD  S24, S2, S3, S27
    FCSEL  H3, H13, H9, PL
    FMSUB  S11, S10, S21, S21
    FMOV  D17, #2.12500000
    FMOV  X4, D23
    FNEG  H31, H17
    FMOV  S1, W10
    FMUL  D29, D5, D26
    FMOV  W17, S24
    FMADD  H2, H3, H7, H7
    FSUB  S4, S31, S6
    FNEG  H28, H30
    FNMADD  S10, S11, S1, S28
    FMOV  W2, S30
    FNEG  D26, D29
    FADD  S22, S2, S2
    FMSUB  D23, D8, D22, D26
    FNMSUB  D25, D4, D23, D23
    FNMUL  H17, H25, H25
    FSQRT  S8, S17
    FMOV  S17, #0.59375000
    FMOV  X23, H17
    FNMUL  H24, H22, H10
    FMOV  S5, #17.00000000
    FNEG  S10, S26
    FMOV  W6, S8
    FMOV  W13, H24
    FMOV  H29, H31
    FMOV  X11, D29
    FNMADD  H7, H5, H5, H10
    FNMADD  S4, S19, S3, S29
    FMUL  S17, S8, S16
    FABS  D6, D4
    FSQRT  H2, H27
    FSQRT  H24, H14
    FDIV  S25, S15, S2
    FMOV  W15, H30
    FNMADD  H4, H1, H8, H8
    FDIV  D15, D4, D27
    FNEG  S10, S11
    FMOV  S29, S21
    SUBS  X3, X3, #0x1
    B.NE  TSRTFloatMovMadd_label_12
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    SUB  X18, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    SUB  X18, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffa6, LSL #0
    MOVK  X28, #0x3a84, LSL #16
    MOVK  X28, #0xb01f, LSL #32
    MOVK  X28, #0x3944, LSL #48
    SUB  X18, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    SUB  X18, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    SUB  X18, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x4654, LSL #0
    MOVK  X28, #0x6b58, LSL #16
    MOVK  X28, #0x2265, LSL #32
    MOVK  X28, #0xb475, LSL #48
    SUB  X18, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    SUB  X18, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X18, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    SUB  X18, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x9d7a, LSL #0
    MOVK  X28, #0x91ae, LSL #16
    MOVK  X28, #0xd1a, LSL #32
    MOVK  X28, #0xbe14, LSL #48
    SUB  X18, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x47d9, LSL #0
    MOVK  X28, #0xf320, LSL #16
    MOVK  X28, #0x6a33, LSL #32
    MOVK  X28, #0x88e9, LSL #48
    SUB  X18, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x4fd5, LSL #0
    MOVK  X28, #0x897b, LSL #16
    MOVK  X28, #0xb7e4, LSL #32
    MOVK  X28, #0x78a, LSL #48
    SUB  X18, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x9f, LSL #0
    MRS  X18, FPSR
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffa6, LSL #0
    FMOV  X18, D0
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0xffa6, LSL #0
    MOVK  X28, #0x3a84, LSL #16
    FMOV  X18, D1
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D2
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    FMOV  X18, D3
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    FMOV  X18, D4
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x4188, LSL #16
    FMOV  X18, D5
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D6
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    FMOV  X18, D7
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D8
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x7e00, LSL #0
    FMOV  X18, D9
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    FMOV  X18, D10
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D11
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D12
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    FMOV  X18, D13
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x4654, LSL #0
    MOVK  X28, #0x6b58, LSL #16
    FMOV  X18, D14
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7ff8, LSL #48
    FMOV  X18, D15
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    FMOV  X18, D16
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    FMOV  X18, D17
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D18
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0xbe38, LSL #16
    FMOV  X18, D19
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    FMOV  X18, D20
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D21
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D22
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #48
    FMOV  X18, D23
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x4107, LSL #0
    FMOV  X18, D24
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x7fc0, LSL #16
    FMOV  X18, D25
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #48
    FMOV  X18, D26
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D27
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    FMOV  X18, D28
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, D29
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x8000, LSL #16
    FMOV  X18, D30
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X28, #0x8000, LSL #0
    FMOV  X18, D31
    SUB  X9, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X24
    FMOV  V0.D[1], X18
    FMOV  D1, X9
    FMOV  V1.D[1], X15
    FMOV  D2, X19
    FMOV  V2.D[1], X28
    FMOV  D3, X16
    FMOV  V3.D[1], X21
    FMOV  D4, X25
    FMOV  V4.D[1], X17
    FMOV  D5, X29
    FMOV  V5.D[1], X27
    FMOV  D6, X13
    FMOV  V6.D[1], X23
    FMOV  D7, X12
    FMOV  V7.D[1], X16
    FMOV  D8, X14
    FMOV  V8.D[1], X18
    FMOV  D9, X12
    FMOV  V9.D[1], X19
    FMOV  D10, X23
    FMOV  V10.D[1], X25
    FMOV  D11, X14
    FMOV  V11.D[1], X15
    FMOV  D12, X23
    FMOV  V12.D[1], X27
    FMOV  D13, X8
    FMOV  V13.D[1], X23
    FMOV  D14, X28
    FMOV  V14.D[1], X5
    FMOV  D15, X11
    FMOV  V15.D[1], X14
    FMOV  D16, X29
    FMOV  V16.D[1], X8
    FMOV  D17, X13
    FMOV  V17.D[1], X28
    FMOV  D18, X4
    FMOV  V18.D[1], X11
    FMOV  D19, X24
    FMOV  V19.D[1], X9
    FMOV  D20, X6
    FMOV  V20.D[1], X9
    FMOV  D21, X14
    FMOV  V21.D[1], X12
    FMOV  D22, X23
    FMOV  V22.D[1], X29
    FMOV  D23, X4
    FMOV  V23.D[1], X9
    FMOV  D24, X29
    FMOV  V24.D[1], X15
    FMOV  D25, X9
    FMOV  V25.D[1], X8
    FMOV  D26, X2
    FMOV  V26.D[1], X29
    FMOV  D27, X24
    FMOV  V27.D[1], X10
    FMOV  D28, X11
    FMOV  V28.D[1], X21
    FMOV  D29, X5
    FMOV  V29.D[1], X17
    FMOV  D30, X17
    FMOV  V30.D[1], X3
    FMOV  D31, X23
    FMOV  V31.D[1], X14
    MOVZ  X9, #0xf, LSL #0
TSRTFloatMovMadd_label_13:
    FMADD  D30, D31, D26, D22
    FMADD  H26, H30, H23, H30
    FMOV  H13, #-24.00000000
    FMOV  S27, W11
    FCSEL  S13, S28, S28, AL
    FMSUB  D30, D13, D24, D25
    FMOV  H28, H26
    FSUB  D12, D30, D29
    FMOV  W11, S12
    FMOV  D16, X18
    FADD  S4, S28, S16
    FMOV  X17, H4
    FCSEL  S21, S23, S31, LT
    FSUB  H6, H3, H27
    FMOV  X23, H9
    FABS  S12, S9
    FMOV  D16, D7
    FMOV  D4, D26
    FNMSUB  S25, S31, S12, S18
    FADD  D22, D6, D4
    FMOV  H13, H24
    FMOV  W18, S2
    FABS  S3, S24
    FCSEL  S24, S22, S3, GE
    FCSEL  H31, H10, H24, EQ
    FNEG  D9, D0
    FNMADD  H7, H28, H19, H12
    FMOV  S23, S24
    FCSEL  H29, H30, H24, LS
    FNMUL  S12, S16, S23
    FNMSUB  S22, S21, S21, S25
    FMOV  H10, #-25.00000000
    FMOV  S12, W18
    FABS  D28, D10
    FSQRT  S21, S28
    FCSEL  H2, H29, H21, MI
    FCSEL  H21, H12, H12, GE
    FNEG  S28, S21
    FMOV  H6, X2
    FDIV  S19, S13, S13
    FMADD  H10, H7, H22, H19
    FDIV  H7, H31, H9
    FSUB  H24, H2, H7
    FDIV  H9, H24, H24
    FSUB  H0, H28, H10
    FCSEL  D21, D29, D6, HI
    FNEG  S22, S9
    FNMSUB  S13, S24, S0, S22
    FMOV  S31, S21
    FMOV  H30, X12
    FMSUB  H3, H13, H31, H24
    FMSUB  D31, D30, D3, D30
    FDIV  S23, S9, S28
    FMUL  H19, H18, H7
    FSQRT  D7, D26
    FMOV  H25, #2.62500000
    FNMSUB  S21, S26, S4, S20
    FABS  H3, H31
    FCSEL  D18, D20, D21, CC
    FMADD  H2, H29, H4, H19
    FNMUL  H10, H20, H14
    FMOV  W18, H6
    FDIV  H26, H13, H5
    FNMUL  H24, H0, H1
    FNMSUB  S28, S18, S23, S3
    FSUB  H6, H25, H24
    FSUB  S25, S6, S28
    FMOV  S28, S26
    FNMSUB  H20, H7, H2, H7
    FSUB  H4, H25, H7
    FSUB  D22, D10, D10
    FSUB  H6, H22, H22
    FSUB  H30, H28, H6
    FMOV  D22, #12.50000000
    FMSUB  H24, H22, H20, H4
    FCSEL  H9, H30, H30, CC
    FNMADD  D31, D24, D24, D24
    FABS  H10, H9
    FMOV  X3, D10
    FMOV  S24, S16
    FNMSUB  D5, D18, D24, D8
    FSUB  D1, D22, D6
    FMOV  H20, H27
    FMOV  X27, D9
    FNMADD  D22, D21, D1, D1
    FSUB  D7, D0, D14
    FDIV  S14, S25, S10
    FADD  S18, S24, S6
    FADD  H2, H31, H26
    FNMADD  D16, D26, D31, D29
    FMOV  D31, X28
    FMOV  X3, D7
    FNMADD  D4, D22, D5, D18
    FMUL  H30, H16, H29
    FMUL  S6, S2, S20
    FNMSUB  D0, D14, D14, D6
    FDIV  D5, D31, D25
    FCSEL  D31, D4, D5, LT
    FSUB  H8, H0, H0
    FMOV  S24, S8
    FSUB  H18, H24, H24
    FNMUL  D28, D30, D18
    FABS  D7, D28
    FSQRT  S29, S31
    FMOV  W11, S7
    FNMADD  S6, S29, S26, S20
    FNMUL  D20, D30, D22
    FNMADD  S31, S14, S20, S4
    FSQRT  D7, D19
    FMADD  S24, S6, S3, S30
    FMSUB  S2, S14, S28, S25
    FADD  D0, D1, D13
    FNEG  S4, S0
    FNMUL  D0, D5, D16
    FMADD  H20, H6, H27, H7
    FNMSUB  H18, H4, H11, H12
    FMADD  H10, H24, H16, H10
    FMUL  S25, S0, S7
    FABS  D27, D11
    FABS  S24, S10
    FNMADD  H7, H15, H25, H26
    FMOV  D8, D21
    FDIV  D13, D2, D16
    FABS  S12, S0
    FMADD  S22, S31, S24, S13
    FMOV  X21, D7
    FNMUL  H4, H27, H20
    FSUB  D3, D18, D12
    FMSUB  D15, D31, D4, D22
    FADD  D2, D8, D15
    FNEG  H24, H16
    FNMADD  S27, S3, S9, S11
    FADD  D22, D2, D27
    FMOV  S0, S6
    FNMSUB  S21, S22, S3, S0
    FMUL  D4, D21, D24
    FCSEL  H27, H23, H29, VS
    FMADD  D31, D27, D10, D4
    FNMADD  S13, S11, S14, S25
    FNEG  S2, S22
    FMSUB  D20, D12, D24, D5
    FNEG  D16, D21
    FMOV  W18, S17
    FMUL  D7, D26, D7
    FMOV  W3, S4
    FMOV  X3, H6
    FMADD  S17, S29, S21, S2
    FMOV  X12, H30
    FNMUL  D8, D17, D17
    FMOV  S0, S11
    FMOV  X4, D5
    FMSUB  H22, H5, H30, H20
    FNEG  D23, D30
    FSUB  D12, D30, D6
    FABS  S24, S25
    FADD  S9, S24, S16
    FMSUB  H2, H20, H31, H12
    FNMSUB  H30, H15, H2, H2
    FSQRT  H5, H23
    FMSUB  S17, S22, S22, S7
    FCSEL  D24, D8, D17, GE
    FMOV  S22, #-11.00000000
    FMOV  W6, H30
    FADD  H23, H9, H9
    FMOV  S7, #11.00000000
    FSQRT  D26, D0
    FABS  S25, S5
    FMSUB  D6, D13, D25, D23
    FADD  S15, S21, S7
    FMSUB  S16, S22, S22, S26
    FNMSUB  H26, H6, H24, H15
    FSUB  H5, H16, H16
    FMOV  H23, X4
    FNMUL  D20, D26, D5
    FMOV  D8, X4
    FMOV  X18, H8
    FSQRT  H7, H23
    FABS  S2, S20
    FMOV  S30, #-4.50000000
    FMADD  D24, D7, D30, D7
    FMSUB  S26, S2, S2, S2
    FADD  D8, D26, D24
    FMOV  H9, H5
    FMOV  X23, D18
    FMUL  S5, S23, S4
    FMSUB  D16, D14, D25, D12
    FDIV  D12, D26, D12
    FMSUB  H24, H24, H22, H12
    FMSUB  D21, D11, D17, D4
    FMOV  H12, H10
    FNMADD  S14, S12, S25, S3
    FNMUL  D4, D26, D6
    FABS  D20, D4
    FDIV  H2, H3, H0
    FMUL  D26, D9, D8
    FMOV  H9, X25
    FMOV  S0, #0.56250000
    FADD  H3, H0, H16
    FSUB  S0, S30, S14
    FMOV  X3, D20
    SUBS  X9, X9, #0x1
    B.NE  TSRTFloatMovMadd_label_13
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7ff8, LSL #48
    SUB  X8, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    SUB  X8, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    SUB  X8, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    SUB  X8, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X8, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x9f, LSL #0
    MRS  X8, FPSR
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xc090, LSL #16
    FMOV  X8, D0
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4029, LSL #48
    FMOV  X8, D1
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X8, D2
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D3
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    FMOV  X8, D4
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D5
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D6
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D7
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D8
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D9
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X8, D10
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V11.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D11
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X8, D12
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V13.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X8, D13
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    FMOV  X8, D14
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V15.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x4130, LSL #16
    FMOV  X8, D15
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D16
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D17
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X8, D18
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X8, D19
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D20
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D21
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xc130, LSL #16
    FMOV  X8, D22
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D23
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D24
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D25
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D26
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D27
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    FMOV  X8, D28
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D29
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xc090, LSL #16
    FMOV  X8, D30
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X8, D31
    SUB  X10, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTFloatMovMadd_TestFail
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
    FMOV  V0.D[1], X24
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X23
    FMOV  V2.D[1], X27
    FMOV  D3, X27
    FMOV  V3.D[1], X12
    FMOV  D4, X24
    FMOV  V4.D[1], X29
    FMOV  D5, X4
    FMOV  V5.D[1], X3
    FMOV  D6, X2
    FMOV  V6.D[1], X18
    FMOV  D7, X24
    FMOV  V7.D[1], X8
    FMOV  D8, X19
    FMOV  V8.D[1], X24
    FMOV  D9, X28
    FMOV  V9.D[1], X27
    FMOV  D10, X4
    FMOV  V10.D[1], X14
    FMOV  D11, X18
    FMOV  V11.D[1], X5
    FMOV  D12, X14
    FMOV  V12.D[1], X25
    FMOV  D13, X23
    FMOV  V13.D[1], X17
    FMOV  D14, X10
    FMOV  V14.D[1], X5
    FMOV  D15, X28
    FMOV  V15.D[1], X12
    FMOV  D16, X2
    FMOV  V16.D[1], X24
    FMOV  D17, X16
    FMOV  V17.D[1], X14
    FMOV  D18, X17
    FMOV  V18.D[1], X3
    FMOV  D19, X16
    FMOV  V19.D[1], X19
    FMOV  D20, X19
    FMOV  V20.D[1], X3
    FMOV  D21, X24
    FMOV  V21.D[1], X6
    FMOV  D22, X10
    FMOV  V22.D[1], X10
    FMOV  D23, X16
    FMOV  V23.D[1], X14
    FMOV  D24, X6
    FMOV  V24.D[1], X5
    FMOV  D25, X10
    FMOV  V25.D[1], X10
    FMOV  D26, X24
    FMOV  V26.D[1], X6
    FMOV  D27, X23
    FMOV  V27.D[1], X14
    FMOV  D28, X12
    FMOV  V28.D[1], X19
    FMOV  D29, X21
    FMOV  V29.D[1], X15
    FMOV  D30, X6
    FMOV  V30.D[1], X21
    FMOV  D31, X10
    FMOV  V31.D[1], X23
    MOVZ  X17, #0xf, LSL #0
TSRTFloatMovMadd_label_14:
    FADD  D9, D22, D27
    FABS  H0, H28
    FMADD  D21, D29, D29, D30
    FMOV  W14, H9
    FSUB  S27, S20, S26
    FABS  D30, D23
    FMUL  S13, S27, S27
    FMADD  H0, H0, H21, H31
    FMOV  H22, H30
    FMOV  W12, S22
    FABS  S30, S0
    FNMADD  H5, H24, H30, H30
    FMOV  H26, W16
    FADD  D2, D13, D26
    FADD  D15, D2, D2
    FMOV  H23, W10
    FCSEL  D28, D23, D23, NE
    FSUB  D13, D5, D28
    FNEG  D24, D15
    FMOV  S26, #-0.45312500
    FMOV  W10, S13
    FABS  H27, H24
    FMOV  H29, W15
    FMSUB  H30, H26, H27, H29
    FADD  H5, H22, H20
    FMUL  D22, D15, D31
    FCSEL  D31, D6, D1, PL
    FDIV  S15, S24, S14
    FMADD  D14, D7, D0, D31
    FMOV  S29, S8
    FCSEL  D2, D7, D18, CS
    FADD  H21, H18, H21
    FADD  H18, H10, H21
    FSUB  D7, D30, D2
    FSUB  D28, D0, D28
    FNMADD  H6, H25, H27, H9
    FMOV  S31, S28
    FMOV  S0, W23
    FMOV  W12, H7
    FABS  H26, H29
    FADD  S8, S14, S18
    FSUB  D23, D22, D26
    FSQRT  D1, D0
    FNMSUB  D10, D5, D15, D1
    FDIV  S21, S15, S8
    FNMUL  D30, D21, D18
    FMOV  H7, #-1.62500000
    FADD  H26, H6, H10
    FMOV  H10, H30
    FDIV  S29, S7, S7
    FNEG  D18, D29
    FMOV  X29, D23
    FMADD  S2, S31, S0, S31
    FMOV  S31, #10.00000000
    FABS  D27, D31
    FMUL  D15, D27, D16
    FSQRT  S24, S15
    FNMUL  D14, D18, D26
    FSQRT  S26, S2
    FMOV  H22, X28
    FNMADD  H15, H24, H14, H3
    FNMADD  S31, S15, S26, S22
    FNEG  D18, D10
    FMOV  D6, D18
    FNMUL  D2, D6, D31
    FABS  D14, D3
    FCSEL  S7, S2, S15, NE
    FMSUB  H10, H19, H8, H5
    FMSUB  H3, H3, H29, H24
    FSUB  H30, H13, H30
    FMOV  S1, #0.16406250
    FMADD  D23, D12, D7, D13
    FMOV  D12, X17
    FCSEL  D7, D16, D17, LT
    FMADD  S0, S2, S24, S22
    FMUL  H26, H0, H3
    FADD  D18, D26, D26
    FSQRT  S13, S7
    FMOV  H0, X12
    FMADD  S6, S9, S30, S1
    FNMADD  H19, H5, H31, H0
    FCSEL  D5, D12, D14, LS
    FNMUL  H15, H18, H1
    FMOV  W3, H23
    FMOV  H29, H6
    FMOV  W13, S29
    FABS  D6, D22
    FMOV  X24, D10
    FSUB  S14, S19, S6
    FSQRT  S12, S15
    FCSEL  S26, S5, S13, PL
    FMOV  X9, D14
    FNMSUB  H15, H12, H26, H26
    FMUL  S8, S7, S19
    FNMUL  D10, D11, D18
    FMOV  S13, W3
    FMADD  H12, H24, H20, H31
    FMOV  S5, #-6.75000000
    FMADD  D22, D30, D21, D31
    FMOV  D30, X12
    FCSEL  D14, D0, D24, LT
    FMOV  D0, D15
    FMOV  S23, W15
    FMOV  W10, H23
    FDIV  H15, H0, H10
    FMOV  X25, H17
    FMOV  D0, X8
    FSQRT  D17, D14
    FMOV  H11, W29
    FABS  S23, S15
    FNEG  H14, H30
    FABS  D21, D22
    FMOV  S18, #13.00000000
    FMOV  W12, S8
    FMOV  H31, X9
    FDIV  H15, H18, H0
    FMUL  S18, S5, S21
    FMOV  H24, X17
    FNMUL  D30, D17, D24
    FNEG  H20, H11
    FMADD  S22, S20, S14, S30
    FSUB  H24, H22, H31
    FNEG  H8, H23
    FMADD  D17, D8, D8, D15
    FCSEL  S10, S17, S13, VS
    FDIV  H11, H10, H18
    FNMADD  S8, S11, S12, S24
    FSQRT  S17, S4
    FMOV  X23, D22
    FNMSUB  S22, S9, S23, S30
    FMSUB  D30, D2, D14, D2
    FMADD  D11, D16, D10, D14
    FMOV  H0, H26
    FMSUB  H11, H11, H18, H10
    FMUL  S4, S10, S17
    FMOV  D21, D17
    FDIV  S9, S9, S28
    FCSEL  S2, S31, S15, CC
    FNEG  D14, D11
    FMOV  D23, D8
    FMUL  H12, H4, H4
    FCSEL  D17, D12, D9, GT
    FADD  D31, D14, D0
    FCSEL  D4, D17, D31, GE
    FNMUL  S14, S22, S2
    FADD  S0, S30, S30
    FNMSUB  H16, H4, H23, H21
    FMUL  D10, D16, D16
    FSQRT  H26, H0
    FMOV  S17, W25
    FMUL  S4, S17, S10
    FSQRT  H18, H4
    FSUB  D30, D26, D18
    FMUL  S17, S14, S14
    FMADD  H11, H17, H17, H17
    FNMSUB  D28, D30, D30, D11
    FMADD  S8, S13, S24, S6
    FMUL  S15, S2, S12
    FMADD  D22, D14, D11, D17
    FMOV  X16, D10
    FCSEL  S18, S23, S2, NE
    FMOV  D12, X15
    FNMSUB  S14, S24, S11, S25
    FMOV  H26, W9
    FMOV  H21, H5
    FMUL  D16, D8, D21
    FDIV  D30, D22, D14
    FMOV  D2, D17
    FNEG  D5, D12
    FMOV  D6, X3
    FMUL  S9, S4, S16
    FMOV  X25, D26
    FNMSUB  S8, S18, S15, S5
    FMOV  S31, W24
    FNEG  H23, H8
    FNMUL  H13, H6, H28
    FMUL  H22, H30, H9
    FDIV  H9, H2, H2
    FSUB  S24, S9, S31
    FNMUL  H14, H22, H22
    FMOV  S2, #30.00000000
    FCSEL  D10, D20, D13, EQ
    FNMADD  S26, S23, S4, S23
    FNMADD  D20, D26, D26, D24
    FMOV  W8, H20
    FMUL  D30, D14, D2
    FSQRT  H22, H30
    FNEG  H17, H22
    FADD  S9, S17, S0
    FSQRT  D20, D10
    FNEG  D24, D17
    FMADD  S22, S24, S24, S24
    FCSEL  H31, H22, H20, VS
    FMOV  D0, X15
    FMSUB  H8, H31, H23, H9
    FCSEL  H20, H0, H8, VS
    FMOV  D10, X28
    FMOV  D23, X23
    FSUB  S9, S15, S2
    FMOV  D30, #-26.00000000
    SUBS  X17, X17, #0x1
    B.NE  TSRTFloatMovMadd_label_14
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    SUB  X2, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X2, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x9f, LSL #0
    MRS  X2, FPSR
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X2, D0
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x3e28, LSL #16
    FMOV  X2, D1
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x41f0, LSL #16
    FMOV  X2, D2
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x7e00, LSL #0
    FMOV  X2, D3
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D4
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V5.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0x7fff, LSL #48
    FMOV  X2, D5
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D6
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8000, LSL #0
    FMOV  X2, D7
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D8
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xc1f0, LSL #16
    FMOV  X2, D9
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X2, D10
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D11
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X2, D12
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8000, LSL #0
    FMOV  X2, D13
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8000, LSL #0
    FMOV  X2, D14
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D15
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D16
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8000, LSL #0
    FMOV  X2, D17
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    FMOV  X2, D18
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8000, LSL #0
    FMOV  X2, D19
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D20
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V21.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D21
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V22.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D22
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D23
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8000, LSL #0
    MOVK  X11, #0x8000, LSL #48
    FMOV  X2, D24
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X2, V25.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X2, D25
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    FMOV  X2, D26
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x4120, LSL #16
    FMOV  X2, D27
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D29
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0xc03a, LSL #48
    FMOV  X2, D30
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X2, D31
    SUB  X21, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0xeef5, LSL #0
    MOVK  X2, #0x7a1e, LSL #16
    MOVK  X2, #0x7ec3, LSL #32
    MOVK  X2, #0x44d8, LSL #48
    MOVZ  X3, #0x1bf1, LSL #0
    MOVK  X3, #0xf76c, LSL #16
    MOVK  X3, #0xbcbd, LSL #32
    MOVK  X3, #0xa3d3, LSL #48
    MOVZ  X4, #0xe873, LSL #0
    MOVK  X4, #0x6637, LSL #16
    MOVK  X4, #0xfda, LSL #32
    MOVK  X4, #0xbf91, LSL #48
    MOVZ  X5, #0x86d4, LSL #0
    MOVK  X5, #0x5947, LSL #16
    MOVK  X5, #0x4149, LSL #32
    MOVK  X5, #0xf47c, LSL #48
    MOVZ  X6, #0xefb0, LSL #0
    MOVK  X6, #0x1bc5, LSL #16
    MOVK  X6, #0x133c, LSL #32
    MOVK  X6, #0xfab1, LSL #48
    MOVZ  X8, #0xf787, LSL #0
    MOVK  X8, #0xb9ec, LSL #16
    MOVK  X8, #0xfbf9, LSL #32
    MOVK  X8, #0x970c, LSL #48
    MOVZ  X9, #0xd0e0, LSL #0
    MOVK  X9, #0xef49, LSL #16
    MOVK  X9, #0x5a34, LSL #32
    MOVK  X9, #0x8b98, LSL #48
    MOVZ  X10, #0x46cb, LSL #0
    MOVK  X10, #0xb88a, LSL #16
    MOVK  X10, #0xbf1a, LSL #32
    MOVK  X10, #0x785a, LSL #48
    MOVZ  X11, #0xd1b5, LSL #0
    MOVK  X11, #0x7be1, LSL #16
    MOVK  X11, #0xeda8, LSL #32
    MOVK  X11, #0xb30c, LSL #48
    MOVZ  X12, #0x431, LSL #0
    MOVK  X12, #0xbe07, LSL #16
    MOVK  X12, #0x28ad, LSL #32
    MOVK  X12, #0xaf8a, LSL #48
    MOVZ  X13, #0x563d, LSL #0
    MOVK  X13, #0x95a, LSL #16
    MOVK  X13, #0xc3, LSL #32
    MOVK  X13, #0xff0f, LSL #48
    MOVZ  X14, #0x5f75, LSL #0
    MOVK  X14, #0xda75, LSL #16
    MOVK  X14, #0x619e, LSL #32
    MOVK  X14, #0x1056, LSL #48
    MOVZ  X15, #0xb3bf, LSL #0
    MOVK  X15, #0x4bb3, LSL #16
    MOVK  X15, #0x8aa2, LSL #32
    MOVK  X15, #0xbbab, LSL #48
    MOVZ  X16, #0xb1a1, LSL #0
    MOVK  X16, #0x17f8, LSL #16
    MOVK  X16, #0x55d9, LSL #32
    MOVK  X16, #0x8038, LSL #48
    MOVZ  X17, #0xf760, LSL #0
    MOVK  X17, #0xa73b, LSL #16
    MOVK  X17, #0x1d86, LSL #32
    MOVK  X17, #0x4739, LSL #48
    MOVZ  X18, #0xc12c, LSL #0
    MOVK  X18, #0xbdea, LSL #16
    MOVK  X18, #0xc858, LSL #32
    MOVK  X18, #0x4b0f, LSL #48
    MOVZ  X19, #0x6642, LSL #0
    MOVK  X19, #0xbc3, LSL #16
    MOVK  X19, #0x616c, LSL #32
    MOVK  X19, #0x473c, LSL #48
    MOVZ  X21, #0xb70b, LSL #0
    MOVK  X21, #0x835, LSL #16
    MOVK  X21, #0x8a3a, LSL #32
    MOVK  X21, #0x4597, LSL #48
    MOVZ  X23, #0xda85, LSL #0
    MOVK  X23, #0x817e, LSL #16
    MOVK  X23, #0xbe58, LSL #32
    MOVK  X23, #0xc33e, LSL #48
    MOVZ  X24, #0x8fab, LSL #0
    MOVK  X24, #0x4210, LSL #16
    MOVK  X24, #0xf5f6, LSL #32
    MOVK  X24, #0x3095, LSL #48
    MOVZ  X25, #0xf1e6, LSL #0
    MOVK  X25, #0x219f, LSL #16
    MOVK  X25, #0x504a, LSL #32
    MOVK  X25, #0xe405, LSL #48
    MOVZ  X27, #0x9aad, LSL #0
    MOVK  X27, #0xd88c, LSL #16
    MOVK  X27, #0x3dc9, LSL #32
    MOVK  X27, #0x4330, LSL #48
    MOVZ  X28, #0xe842, LSL #0
    MOVK  X28, #0x5f30, LSL #16
    MOVK  X28, #0x3992, LSL #32
    MOVK  X28, #0x48ac, LSL #48
    MOVZ  X29, #0xeb5, LSL #0
    MOVK  X29, #0x94c2, LSL #16
    MOVK  X29, #0x3852, LSL #32
    MOVK  X29, #0x951c, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X8
    FMOV  D3, X16
    FMOV  V3.D[1], X3
    FMOV  D4, X16
    FMOV  V4.D[1], X2
    FMOV  D5, X23
    FMOV  V5.D[1], X19
    FMOV  D6, X18
    FMOV  V6.D[1], X10
    FMOV  D7, X13
    FMOV  V7.D[1], X10
    FMOV  D8, X16
    FMOV  V8.D[1], X19
    FMOV  D9, X15
    FMOV  V9.D[1], X16
    FMOV  D10, X21
    FMOV  V10.D[1], X2
    FMOV  D11, X18
    FMOV  V11.D[1], X6
    FMOV  D12, X6
    FMOV  V12.D[1], X10
    FMOV  D13, X17
    FMOV  V13.D[1], X14
    FMOV  D14, X2
    FMOV  V14.D[1], X15
    FMOV  D15, X18
    FMOV  V15.D[1], X25
    FMOV  D16, X16
    FMOV  V16.D[1], X25
    FMOV  D17, X4
    FMOV  V17.D[1], X15
    FMOV  D18, X23
    FMOV  V18.D[1], X19
    FMOV  D19, X28
    FMOV  V19.D[1], X27
    FMOV  D20, X19
    FMOV  V20.D[1], X10
    FMOV  D21, X25
    FMOV  V21.D[1], X6
    FMOV  D22, X15
    FMOV  V22.D[1], X2
    FMOV  D23, X28
    FMOV  V23.D[1], X16
    FMOV  D24, X12
    FMOV  V24.D[1], X5
    FMOV  D25, X5
    FMOV  V25.D[1], X5
    FMOV  D26, X19
    FMOV  V26.D[1], X4
    FMOV  D27, X25
    FMOV  V27.D[1], X21
    FMOV  D28, X17
    FMOV  V28.D[1], X18
    FMOV  D29, X17
    FMOV  V29.D[1], X5
    FMOV  D30, X16
    FMOV  V30.D[1], X17
    FMOV  D31, X15
    FMOV  V31.D[1], X11
    MOVZ  X17, #0xf, LSL #0
TSRTFloatMovMadd_label_15:
    FMOV  W5, S31
    FMOV  D25, D30
    FNEG  D18, D23
    FMSUB  S7, S28, S22, S29
    FMOV  W4, S24
    FCSEL  S8, S25, S27, VC
    FMOV  D20, D8
    FCSEL  D4, D18, D18, MI
    FMOV  H30, H26
    FMOV  D12, X5
    FNEG  H13, H7
    FCSEL  H14, H13, H13, MI
    FMOV  W15, H4
    FSUB  S2, S20, S14
    FNMADD  S31, S30, S30, S2
    FNMADD  D2, D12, D12, D12
    FSUB  S30, S17, S31
    FABS  H23, H30
    FNMSUB  D29, D2, D23, D23
    FMOV  H26, X2
    FADD  D13, D19, D2
    FSUB  S18, S13, S20
    FCSEL  H25, H15, H8, AL
    FSQRT  H30, H19
    FMOV  H22, H10
    FNEG  S2, S26
    FSUB  S13, S16, S18
    FMOV  S28, S7
    FNMUL  D20, D3, D27
    FABS  D16, D5
    FMADD  D23, D10, D16, D20
    FMOV  D24, D23
    FABS  D31, D24
    FMOV  S24, S31
    FMOV  X25, H24
    FMOV  S15, W28
    FMUL  D8, D2, D28
    FMSUB  D10, D13, D25, D22
    FMSUB  D19, D30, D10, D8
    FMOV  S22, S19
    FMOV  X2, H15
    FMUL  D16, D22, D22
    FMSUB  S20, S16, S16, S16
    FMOV  W14, H20
    FNMUL  H18, H5, H12
    FMSUB  D27, D11, D17, D26
    FNMADD  H12, H1, H19, H9
    FNMSUB  D23, D30, D16, D22
    FDIV  H10, H17, H18
    FMUL  D20, D2, D18
    FMSUB  D13, D6, D3, D17
    FMADD  S17, S23, S31, S30
    FSQRT  H5, H21
    FABS  D8, D2
    FSUB  D11, D15, D13
    FMUL  D26, D22, D19
    FMOV  S1, S5
    FMUL  S15, S27, S10
    FSQRT  D24, D12
    FSQRT  S25, S15
    FMOV  D10, #0.17968750
    FNMADD  S28, S20, S16, S1
    FMUL  S31, S8, S24
    FSUB  H24, H13, H26
    FABS  H15, H24
    FNMSUB  D26, D11, D31, D10
    FMOV  S6, W29
    FMOV  H13, #0.87500000
    FCSEL  H5, H17, H17, PL
    FSUB  H17, H25, H25
    FCSEL  S27, S6, S26, PL
    FNMSUB  S20, S8, S16, S10
    FNMUL  H19, H28, H27
    FABS  D25, D20
    FCSEL  S24, S25, S13, LE
    FNMADD  D12, D19, D19, D17
    FMOV  H17, X6
    FNMADD  D31, D12, D24, D15
    FMOV  S1, S31
    FMADD  H11, H5, H1, H17
    FMOV  S12, W6
    FMADD  S21, S30, S13, S2
    FSQRT  D30, D15
    FMOV  D6, X23
    FSUB  H13, H6, H21
    FNEG  S10, S26
    FMOV  S15, S27
    FNMSUB  H16, H24, H31, H19
    FMADD  D21, D12, D2, D30
    FMOV  D6, X8
    FMOV  X21, H21
    FDIV  H28, H2, H17
    FMOV  S19, #1.12500000
    FNMUL  H8, H29, H29
    FNMSUB  H1, H8, H15, H28
    FCSEL  H17, H11, H1, GE
    FMUL  H31, H6, H13
    FMADD  D1, D10, D10, D16
    FADD  H21, H31, H19
    FADD  D2, D17, D17
    FMADD  S17, S1, S21, S2
    FMOV  S31, #-0.26562500
    FCSEL  D30, D0, D4, CS
    FNMSUB  H11, H0, H9, H6
    FMOV  H25, #0.15625000
    FMOV  X3, D0
    FDIV  H0, H28, H2
    FSUB  D15, D11, D30
    FMOV  D13, #-7.75000000
    FNMADD  D24, D28, D6, D29
    FABS  H4, H26
    FMUL  S16, S30, S21
    FMUL  S11, S24, S13
    FMOV  W13, H11
    FNMSUB  H9, H25, H2, H1
    FMOV  S13, W4
    FMSUB  D2, D17, D9, D13
    FMOV  W14, S31
    FMOV  H10, X19
    FMSUB  H30, H16, H2, H2
    FMOV  W19, S0
    FMOV  H11, #0.93750000
    FMADD  H2, H11, H30, H10
    FADD  D31, D2, D2
    FMOV  D24, #0.87500000
    FNMUL  D17, D31, D4
    FNMADD  S26, S24, S24, S15
    FNEG  H10, H26
    FADD  S26, S17, S17
    FCSEL  D31, D10, D10, VC
    FNEG  S6, S26
    FDIV  D9, D31, D31
    FSUB  D4, D6, D6
    FNEG  D13, D9
    FMADD  S17, S13, S13, S4
    FNMUL  D16, D6, D7
    FMOV  S1, W15
    FMOV  S11, #-23.00000000
    FMOV  H0, H21
    FNEG  S4, S7
    FMADD  H15, H29, H17, H11
    FMADD  S13, S27, S10, S18
    FCSEL  H24, H21, H15, LT
    FMUL  S21, S20, S12
    FNMUL  S29, S28, S23
    FABS  D31, D13
    FMOV  D6, D4
    FMOV  W28, S23
    FMOV  D26, #-0.40625000
    FSQRT  D9, D24
    FABS  D7, D9
    FNMADD  D9, D21, D16, D16
    FNEG  H4, H9
    FSQRT  S13, S6
    FMOV  X4, H29
    FMOV  H15, #-0.17187500
    FNMSUB  H9, H15, H9, H0
    FNMSUB  H23, H26, H26, H26
    FDIV  S13, S4, S23
    FNMUL  D24, D7, D9
    FNEG  S29, S31
    FDIV  H15, H24, H29
    FMOV  S21, #0.37500000
    FMADD  D31, D21, D1, D13
    FCSEL  D4, D15, D31, PL
    FNMSUB  D21, D10, D14, D8
    FDIV  D10, D13, D15
    FMOV  X13, H22
    FADD  H14, H6, H19
    FADD  H0, H15, H5
    FMOV  S15, W15
    FMUL  S6, S8, S6
    FMOV  S9, S13
    FMOV  X3, H6
    FMUL  D24, D0, D27
    FMOV  X27, H25
    FMUL  H16, H12, H22
    FSQRT  D25, D2
    FMADD  D5, D17, D14, D14
    FMOV  S22, W25
    FSUB  H1, H9, H11
    FMOV  D26, X14
    FNMUL  S2, S16, S26
    FMOV  W14, S4
    FABS  H19, H10
    FMOV  D29, D5
    FMADD  H6, H22, H15, H29
    FCSEL  H29, H25, H19, PL
    FSUB  S25, S24, S24
    FMUL  H24, H25, H1
    FMUL  H12, H24, H2
    FMUL  S8, S6, S21
    FSUB  D17, D29, D15
    FSUB  H19, H12, H17
    FABS  S31, S19
    FMADD  H4, H31, H14, H31
    FMOV  X24, H4
    FMADD  H24, H9, H19, H11
    FNMSUB  D21, D20, D18, D14
    FNMADD  D14, D17, D24, D31
    SUBS  X17, X17, #0x1
    B.NE  TSRTFloatMovMadd_label_15
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xefb0, LSL #0
    MOVK  X18, #0x1bc5, LSL #16
    MOVK  X18, #0x133c, LSL #32
    MOVK  X18, #0xfab1, LSL #48
    SUB  X16, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xf787, LSL #0
    MOVK  X18, #0xb9ec, LSL #16
    MOVK  X18, #0xfbf9, LSL #32
    MOVK  X18, #0x970c, LSL #48
    SUB  X16, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xd0e0, LSL #0
    MOVK  X18, #0xef49, LSL #16
    MOVK  X18, #0x5a34, LSL #32
    MOVK  X18, #0x8b98, LSL #48
    SUB  X16, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x46cb, LSL #0
    MOVK  X18, #0xb88a, LSL #16
    MOVK  X18, #0xbf1a, LSL #32
    MOVK  X18, #0x785a, LSL #48
    SUB  X16, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x431, LSL #0
    MOVK  X18, #0xbe07, LSL #16
    MOVK  X18, #0x28ad, LSL #32
    MOVK  X18, #0xaf8a, LSL #48
    SUB  X16, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X16, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x7e00, LSL #0
    SUB  X16, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xda85, LSL #0
    MOVK  X18, #0x817e, LSL #16
    MOVK  X18, #0xbe58, LSL #32
    MOVK  X18, #0xc33e, LSL #48
    SUB  X16, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x3100, LSL #0
    SUB  X16, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X16, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xeb5, LSL #0
    MOVK  X18, #0x94c2, LSL #16
    MOVK  X18, #0x3852, LSL #32
    MOVK  X18, #0x951c, LSL #48
    SUB  X16, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x9f, LSL #0
    MRS  X16, FPSR
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x7e00, LSL #0
    FMOV  X16, D0
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D1
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D2
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x1bf1, LSL #0
    MOVK  X18, #0xf76c, LSL #16
    MOVK  X18, #0xbcbd, LSL #32
    MOVK  X18, #0xa3d3, LSL #48
    FMOV  X16, V3.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xb1a1, LSL #0
    MOVK  X18, #0x17f8, LSL #16
    MOVK  X18, #0x55d9, LSL #32
    MOVK  X18, #0x8038, LSL #48
    FMOV  X16, D3
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D4
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D5
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D6
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D7
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D8
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    FMOV  X16, D9
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7ff8, LSL #48
    FMOV  X16, D10
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xc1b8, LSL #16
    FMOV  X16, D11
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D12
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x7fc0, LSL #16
    FMOV  X16, D13
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #48
    FMOV  X16, D14
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D15
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x8000, LSL #0
    FMOV  X16, D16
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D17
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x8000, LSL #0
    FMOV  X16, D18
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D19
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x8000, LSL #16
    FMOV  X16, D20
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D21
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D22
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D23
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D24
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D25
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xbe88, LSL #16
    FMOV  X16, D26
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0xeb5, LSL #0
    MOVK  X18, #0x94c2, LSL #16
    FMOV  X16, D27
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x8000, LSL #0
    FMOV  X16, D28
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D29
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D30
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X16, D31
    SUB  X11, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X19
    FMOV  V0.D[1], X4
    FMOV  D1, X9
    FMOV  V1.D[1], X23
    FMOV  D2, X25
    FMOV  V2.D[1], X3
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X15
    FMOV  V4.D[1], X14
    FMOV  D5, X27
    FMOV  V5.D[1], X28
    FMOV  D6, X24
    FMOV  V6.D[1], X14
    FMOV  D7, X24
    FMOV  V7.D[1], X4
    FMOV  D8, X16
    FMOV  V8.D[1], X25
    FMOV  D9, X18
    FMOV  V9.D[1], X19
    FMOV  D10, X12
    FMOV  V10.D[1], X28
    FMOV  D11, X6
    FMOV  V11.D[1], X27
    FMOV  D12, X27
    FMOV  V12.D[1], X12
    FMOV  D13, X11
    FMOV  V13.D[1], X28
    FMOV  D14, X11
    FMOV  V14.D[1], X2
    FMOV  D15, X13
    FMOV  V15.D[1], X25
    FMOV  D16, X28
    FMOV  V16.D[1], X23
    FMOV  D17, X24
    FMOV  V17.D[1], X28
    FMOV  D18, X3
    FMOV  V18.D[1], X13
    FMOV  D19, X19
    FMOV  V19.D[1], X29
    FMOV  D20, X21
    FMOV  V20.D[1], X19
    FMOV  D21, X17
    FMOV  V21.D[1], X16
    FMOV  D22, X6
    FMOV  V22.D[1], X25
    FMOV  D23, X18
    FMOV  V23.D[1], X24
    FMOV  D24, X14
    FMOV  V24.D[1], X8
    FMOV  D25, X10
    FMOV  V25.D[1], X13
    FMOV  D26, X2
    FMOV  V26.D[1], X5
    FMOV  D27, X9
    FMOV  V27.D[1], X11
    FMOV  D28, X12
    FMOV  V28.D[1], X6
    FMOV  D29, X11
    FMOV  V29.D[1], X10
    FMOV  D30, X9
    FMOV  V30.D[1], X6
    FMOV  D31, X12
    FMOV  V31.D[1], X29
    MOVZ  X24, #0xf, LSL #0
TSRTFloatMovMadd_label_16:
    FNMUL  S16, S23, S24
    FNEG  S20, S25
    FMOV  D21, #-0.56250000
    FMOV  S12, S30
    FMADD  H9, H20, H27, H27
    FCSEL  D25, D26, D29, HI
    FMOV  W13, S28
    FMOV  D3, D31
    FDIV  H4, H16, H16
    FDIV  H18, H9, H9
    FSUB  D7, D21, D18
    FDIV  H8, H4, H4
    FMOV  W29, S12
    FNMUL  H28, H3, H8
    FMOV  H11, #0.43750000
    FSQRT  S30, S28
    FNEG  H20, H25
    FSQRT  H31, H20
    FMOV  H18, H31
    FNMSUB  S11, S30, S7, S30
    FMOV  H28, W16
    FSQRT  S4, S28
    FSUB  S24, S11, S18
    FNMUL  D20, D4, D4
    FNMUL  H25, H24, H24
    FMOV  S4, #7.00000000
    FSUB  H3, H4, H25
    FMSUB  D23, D3, D20, D20
    FMSUB  S12, S12, S3, S22
    FMOV  S18, #-19.00000000
    FDIV  D8, D3, D14
    FMADD  D29, D30, D11, D16
    FMOV  X10, D3
    FMOV  S11, #11.50000000
    FNMSUB  H3, H0, H19, H18
    FMOV  D24, #0.21875000
    FNMUL  H7, H7, H22
    FMADD  H19, H26, H21, H9
    FDIV  H26, H8, H26
    FDIV  S16, S19, S12
    FNMSUB  H9, H7, H11, H23
    FMOV  W17, S16
    FABS  D14, D9
    FCSEL  D21, D11, D26, AL
    FMOV  H22, W5
    FNEG  D28, D29
    FNMADD  H29, H28, H14, H21
    FSUB  S14, S29, S3
    FCSEL  D23, D24, D14, HI
    FDIV  S29, S23, S22
    FABS  S21, S21
    FMUL  S19, S28, S16
    FSUB  H3, H31, H4
    FMOV  W8, H19
    FDIV  H26, H15, H3
    FMOV  D15, X11
    FMADD  S14, S22, S11, S16
    FSQRT  S3, S20
    FDIV  S19, S4, S1
    FMOV  H9, X8
    FDIV  S4, S18, S30
    FNEG  D8, D4
    FNEG  H16, H9
    FMOV  X19, H19
    FMADD  H31, H16, H21, H8
    FSUB  D22, D3, D31
    FMUL  H28, H29, H29
    FNMUL  H9, H14, H2
    FCSEL  S23, S15, S9, LT
    FADD  D30, D22, D23
    FMUL  S8, S26, S30
    FNMSUB  S19, S28, S8, S28
    FMOV  H29, X24
    FNMSUB  S30, S12, S7, S4
    FDIV  D21, D29, D10
    FABS  D26, D1
    FDIV  S15, S28, S26
    FNMUL  S11, S0, S21
    FDIV  D18, D9, D6
    FSUB  S12, S17, S29
    FMADD  H3, H12, H13, H31
    FMADD  S20, S4, S7, S3
    FMOV  H9, H0
    FSUB  D29, D12, D15
    FMOV  W10, H8
    FMOV  H22, X4
    FABS  H31, H23
    FMOV  D6, D29
    FNMSUB  D17, D18, D18, D31
    FNEG  S10, S18
    FNMUL  H31, H14, H22
    FNEG  S1, S9
    FCSEL  H26, H6, H20, NV
    FMOV  S0, #-5.50000000
    FMUL  S22, S31, S11
    FMUL  D31, D17, D26
    FNMADD  S2, S22, S22, S0
    FNMUL  H29, H1, H1
    FMADD  D8, D10, D2, D31
    FMSUB  S11, S29, S29, S8
    FMOV  S12, S11
    FMOV  H11, H12
    FNMADD  D8, D11, D11, D11
    FMOV  S15, S8
    FSQRT  S20, S15
    FNMADD  S10, S20, S20, S20
    FMOV  W29, H7
    FADD  S11, S31, S5
    FMOV  H12, H11
    FNMADD  H23, H28, H27, H30
    FMSUB  D29, D4, D31, D9
    FMOV  D22, #1.12500000
    FADD  D4, D15, D20
    FMOV  H9, H8
    FMOV  S11, W19
    FMOV  D7, X14
    FMOV  D14, D10
    FNEG  D5, D12
    FDIV  S27, S14, S23
    FMOV  W21, S7
    FNMUL  H0, H25, H27
    FSUB  S20, S17, S0
    FCSEL  S6, S29, S29, LT
    FABS  D29, D20
    FNMADD  D25, D5, D22, D5
    FNMUL  S12, S4, S4
    FDIV  H23, H11, H9
    FMOV  W13, S29
    FMOV  D14, D8
    FMOV  W10, H14
    FMOV  X13, D23
    FMOV  W16, S12
    FADD  D27, D6, D26
    FMOV  S20, S27
    FMOV  D10, #-1.12500000
    FCSEL  S23, S20, S20, LS
    FNEG  S17, S17
    FMADD  H6, H23, H17, H10
    FDIV  D15, D25, D25
    FADD  S0, S15, S15
    FMSUB  H7, H0, H0, H6
    FMOV  H17, #0.13281250
    FNEG  S11, S13
    FMSUB  D25, D16, D29, D15
    FMSUB  D27, D30, D4, D19
    FCSEL  S6, S14, S29, LE
    FMSUB  H20, H25, H23, H2
    FABS  H8, H26
    FMUL  S4, S16, S28
    FNMUL  H19, H4, H29
    FNEG  D23, D3
    FMUL  D25, D20, D8
    FNMUL  S28, S7, S6
    FMUL  D13, D27, D28
    FMOV  H7, H13
    FMADD  D9, D23, D17, D25
    FMADD  S3, S7, S9, S7
    FMOV  X14, D11
    FABS  H13, H19
    FNMUL  D8, D3, D26
    FABS  H0, H13
    FMADD  S15, S30, S0, S8
    FNEG  H27, H2
    FABS  D2, D22
    FADD  S10, S12, S20
    FMOV  H20, X16
    FSQRT  D8, D19
    FNMSUB  D11, D28, D17, D18
    FNEG  S28, S12
    FMSUB  S4, S1, S11, S5
    FABS  S25, S14
    FMOV  W10, S4
    FABS  H9, H2
    FDIV  S22, S9, S27
    FABS  D6, D28
    FMOV  H26, W2
    FABS  D4, D22
    FMOV  X5, D4
    FCSEL  S13, S20, S20, LT
    FNEG  D19, D25
    FABS  S9, S26
    FDIV  S17, S15, S15
    FCSEL  H27, H8, H8, LS
    FCSEL  H22, H6, H6, CC
    FMOV  H2, W25
    FNMSUB  D18, D13, D2, D17
    FNMADD  S14, S19, S19, S22
    FMADD  S11, S10, S27, S9
    FMOV  X23, D18
    FCSEL  S26, S14, S11, HI
    FMOV  H14, W14
    FNMADD  D17, D26, D23, D26
    FNEG  S6, S29
    FNMSUB  S20, S10, S11, S14
    FNEG  S8, S22
    FMOV  S4, S6
    FABS  H13, H18
    FNMUL  D9, D11, D1
    FNMUL  S10, S8, S15
    FMOV  H6, #1.87500000
    SUBS  X24, X24, #0x1
    B.NE  TSRTFloatMovMadd_label_16
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7fc0, LSL #16
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x7e00, LSL #0
    SUB  X27, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X27, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X27, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7fc0, LSL #16
    SUB  X27, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    SUB  X27, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X27, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x8000, LSL #0
    SUB  X27, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x9f, LSL #0
    MRS  X27, FPSR
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V0.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D0
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V1.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    FMOV  X27, D1
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D2
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D3
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V4.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    FMOV  X27, D4
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X27, D5
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x3f80, LSL #0
    FMOV  X27, D6
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V7.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D7
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    FMOV  X27, D8
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X27, D9
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V10.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xffc0, LSL #16
    FMOV  X27, D10
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D11
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V12.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    FMOV  X27, D12
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D13
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D14
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7fc0, LSL #16
    FMOV  X27, D15
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x8000, LSL #0
    FMOV  X27, D16
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D17
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V18.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D18
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V19.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X27, D19
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V20.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D20
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff8, LSL #48
    FMOV  X27, D21
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D22
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #48
    FMOV  X27, D23
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x3fcc, LSL #48
    FMOV  X27, D24
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D25
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x8000, LSL #16
    FMOV  X27, D26
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D27
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D28
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, D29
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V30.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7fc0, LSL #16
    FMOV  X27, D30
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x7ff8, LSL #48
    FMOV  X27, D31
    SUB  X15, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, TSRTFloatMovMadd_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X24
    FMOV  D3, X21
    FMOV  V3.D[1], X16
    FMOV  D4, X19
    FMOV  V4.D[1], X27
    FMOV  D5, X15
    FMOV  V5.D[1], X4
    FMOV  D6, X25
    FMOV  V6.D[1], X25
    FMOV  D7, X29
    FMOV  V7.D[1], X17
    FMOV  D8, X24
    FMOV  V8.D[1], X3
    FMOV  D9, X6
    FMOV  V9.D[1], X8
    FMOV  D10, X28
    FMOV  V10.D[1], X14
    FMOV  D11, X21
    FMOV  V11.D[1], X21
    FMOV  D12, X23
    FMOV  V12.D[1], X29
    FMOV  D13, X6
    FMOV  V13.D[1], X4
    FMOV  D14, X28
    FMOV  V14.D[1], X4
    FMOV  D15, X15
    FMOV  V15.D[1], X10
    FMOV  D16, X13
    FMOV  V16.D[1], X18
    FMOV  D17, X4
    FMOV  V17.D[1], X12
    FMOV  D18, X19
    FMOV  V18.D[1], X6
    FMOV  D19, X6
    FMOV  V19.D[1], X25
    FMOV  D20, X10
    FMOV  V20.D[1], X29
    FMOV  D21, X16
    FMOV  V21.D[1], X28
    FMOV  D22, X8
    FMOV  V22.D[1], X2
    FMOV  D23, X17
    FMOV  V23.D[1], X4
    FMOV  D24, X13
    FMOV  V24.D[1], X27
    FMOV  D25, X5
    FMOV  V25.D[1], X10
    FMOV  D26, X12
    FMOV  V26.D[1], X14
    FMOV  D27, X3
    FMOV  V27.D[1], X12
    FMOV  D28, X3
    FMOV  V28.D[1], X15
    FMOV  D29, X17
    FMOV  V29.D[1], X11
    FMOV  D30, X15
    FMOV  V30.D[1], X6
    FMOV  D31, X29
    FMOV  V31.D[1], X18
    MOVZ  X29, #0xf, LSL #0
TSRTFloatMovMadd_label_17:
    FNEG  H12, H26
    FMOV  D21, #8.00000000
    FNMSUB  H11, H24, H12, H29
    FMOV  W3, S11
    FABS  D13, D25
    FSUB  S29, S31, S27
    FMOV  D13, #4.50000000
    FMADD  S27, S30, S13, S21
    FADD  H11, H27, H29
    FSQRT  H18, H23
    FMOV  H30, H22
    FMUL  D12, D18, D11
    FNEG  H12, H30
    FMSUB  D1, D12, D12, D12
    FSUB  S14, S1, S1
    FMOV  W15, H14
    FNMADD  S26, S28, S29, S9
    FADD  H30, H19, H19
    FMOV  S12, #19.00000000
    FDIV  S27, S1, S3
    FNMUL  S25, S25, S21
    FADD  D1, D22, D16
    FMOV  X21, D11
    FMADD  D9, D28, D1, D8
    FNMADD  H29, H3, H11, H23
    FNMADD  D18, D10, D7, D25
    FMOV  D21, #0.24218750
    FADD  D3, D23, D17
    FMOV  W10, H30
    FMOV  H19, X12
    FMOV  X27, H9
    FMADD  D16, D19, D26, D19
    FCSEL  S30, S16, S29, CC
    FSQRT  H14, H27
    FMOV  S31, W8
    FMADD  H11, H21, H31, H3
    FNMSUB  H10, H12, H18, H30
    FMOV  D3, X18
    FMSUB  S17, S11, S14, S14
    FMADD  H18, H3, H3, H17
    FSUB  S12, S18, S6
    FSUB  D25, D10, D10
    FMOV  D6, #2.37500000
    FMOV  X27, H6
    FMOV  D11, #-0.42187500
    FNMUL  S26, S12, S31
    FADD  H12, H11, H26
    FMOV  H11, W6
    FCSEL  H18, H11, H25, NE
    FSUB  S3, S18, S4
    FSUB  S17, S3, S3
    FMOV  D29, X8
    FABS  D27, D17
    FMSUB  S30, S5, S12, S27
    FNMSUB  D21, D29, D30, D29
    FSUB  S16, S15, S16
    FADD  H9, H5, H15
    FDIV  S10, S3, S18
    FMSUB  D31, D1, D7, D7
    FSQRT  D30, D26
    FMOV  H1, #-1.25000000
    FABS  D26, D27
    FADD  D14, D5, D4
    FNEG  S12, S21
    FMUL  S17, S16, S16
    FNMADD  D4, D31, D9, D12
    FMSUB  S29, S14, S4, S4
    FNMSUB  S11, S10, S26, S10
    FABS  D27, D11
    FMOV  D12, X5
    FNEG  H15, H12
    FDIV  H5, H26, H16
    FNMUL  D25, D1, D24
    FSQRT  S18, S18
    FMADD  D31, D30, D29, D5
    FMUL  H21, H6, H18
    FMOV  S12, W28
    FMOV  W13, S12
    FADD  H16, H31, H21
    FNEG  D9, D15
    FCSEL  D10, D25, D27, LT
    FABS  H11, H16
    FADD  D3, D17, D17
    FNMSUB  H5, H3, H9, H10
    FDIV  S14, S11, S11
    FMOV  W23, S14
    FCSEL  D7, D15, D31, LS
    FSQRT  S12, S20
    FNEG  D25, D25
    FMOV  H18, H6
    FABS  D3, D14
    FMOV  H15, W27
    FMADD  D29, D15, D18, D11
    FNEG  D31, D13
    FNMUL  S20, S23, S26
    FNEG  D11, D31
    FABS  H18, H19
    FABS  H17, H11
    FMOV  H30, #-3.37500000
    FMOV  S10, #-0.18750000
    FNMSUB  H11, H25, H3, H30
    FNMSUB  D6, D11, D18, D20
    FADD  S11, S17, S20
    FCSEL  D25, D27, D5, EQ
    FMOV  W24, H29
    FMADD  H21, H12, H12, H16
    FNMADD  H20, H7, H6, H6
    FADD  H9, H20, H10
    FADD  S10, S17, S9
    FMSUB  D9, D25, D21, D25
    FADD  S6, S11, S16
    FMOV  D13, D10
    FADD  S17, S9, S9
    FNMSUB  H29, H13, H7, H21
    FNEG  D14, D1
    FNEG  S12, S6
    FABS  H21, H12
    FMOV  H9, X6
    FMOV  S10, #-1.06250000
    FNMSUB  D16, D17, D10, D21
    FNMADD  H10, H29, H9, H29
    FDIV  S17, S10, S10
    FMUL  D21, D17, D17
    FMUL  H6, H21, H16
    FNEG  H1, H14
    FMOV  X11, H1
    FCSEL  D1, D12, D12, EQ
    FDIV  D20, D12, D22
    FMOV  H25, #-0.45312500
    FMSUB  S17, S11, S30, S16
    FSUB  S10, S8, S26
    FNMUL  S14, S18, S10
    FDIV  D8, D11, D11
    FNMADD  S30, S24, S3, S15
    FMUL  S16, S0, S12
    FMSUB  S18, S25, S1, S30
    FNMSUB  D11, D6, D18, D8
    FSQRT  H8, H27
    FMUL  H30, H11, H9
    FABS  S7, S30
    FDIV  H26, H7, H7
    FABS  H12, H5
    FNEG  H13, H17
    FMOV  D21, #27.00000000
    FABS  S22, S21
    FNMADD  H18, H22, H22, H14
    FNEG  D1, D12
    FMOV  D30, X8
    FMSUB  D29, D8, D26, D26
    FADD  H25, H29, H1
    FMADD  H9, H16, H25, H30
    FNMSUB  S26, S18, S9, S13
    FMSUB  S18, S26, S26, S26
    FNEG  D27, D20
    FMSUB  D9, D27, D22, D18
    FNMUL  H6, H9, H29
    FNMADD  H1, H16, H18, H12
    FMOV  H21, H0
    FMSUB  H30, H25, H18, H0
    FNEG  S8, S0
    FSUB  H13, H21, H21
    FNEG  H26, H4
    FNMUL  H4, H2, H16
    FCSEL  D0, D8, D0, VC
    FMADD  S17, S1, S23, S0
    FMOV  X4, D26
    FNEG  S21, S29
    FMOV  H0, #21.00000000
    FNMSUB  H11, H31, H15, H25
    FSUB  H18, H24, H18
    FNMUL  H8, H0, H21
    FMOV  D24, D4
    FNMSUB  H27, H24, H30, H6
    FMOV  W8, S13
    FMOV  D22, D17
    FCSEL  D12, D22, D22, CS
    FABS  D29, D12
    FNEG  H1, H18
    FNMSUB  D4, D29, D27, D8
    FMSUB  H22, H11, H11, H3
    FMADD  H29, H1, H1, H1
    FMADD  S24, S29, S29, S4
    FNMADD  S11, S22, S22, S24
    FSQRT  H23, H28
    FNEG  H9, H9
    FCSEL  H26, H21, H28, HI
    FSUB  S12, S1, S3
    FADD  S28, S29, S30
    FMOV  S15, S24
    FDIV  H22, H15, H17
    FMADD  H24, H21, H9, H1
    FMOV  D8, #0.19531250
    FNEG  D3, D6
    FSUB  D25, D11, D3
    FABS  H3, H22
    FDIV  S11, S28, S12
    FMOV  W28, S24
    FABS  S4, S11
    FMOV  S21, W17
    FABS  D11, D8
    SUBS  X29, X29, #0x1
    B.NE  TSRTFloatMovMadd_label_17
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    SUB  X14, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x8000, LSL #0
    SUB  X14, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    SUB  X14, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x3d00, LSL #0
    SUB  X14, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    SUB  X14, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7fc0, LSL #16
    SUB  X14, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    SUB  X14, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    SUB  X14, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x9f, LSL #0
    MRS  X14, FPSR
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x4d40, LSL #0
    FMOV  X14, D0
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xfe00, LSL #0
    FMOV  X14, D1
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    FMOV  X14, V2.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    MOVK  X9, #0xffff, LSL #32
    MOVK  X9, #0xffff, LSL #48
    FMOV  X14, D2
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    FMOV  X14, D3
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7fc0, LSL #16
    FMOV  X14, D4
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    FMOV  X14, D5
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x8000, LSL #0
    FMOV  X14, D6
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    FMOV  X14, D7
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x3fc9, LSL #48
    FMOV  X14, D8
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x8000, LSL #0
    FMOV  X14, D9
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7fc0, LSL #16
    FMOV  X14, D10
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x3fc9, LSL #48
    FMOV  X14, D11
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7fc0, LSL #16
    FMOV  X14, D12
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xffc0, LSL #16
    FMOV  X14, D14
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7fc0, LSL #16
    FMOV  X14, D16
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    FMOV  X14, D18
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    FMOV  X14, D19
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x7ff8, LSL #48
    FMOV  X14, D20
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0xffff, LSL #0
    MOVK  X9, #0xffff, LSL #16
    FMOV  X14, D21
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    FMOV  X14, D22
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    FMOV  X14, D24
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    FMOV  X14, D27
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    FMOV  X14, D29
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x7e00, LSL #0
    FMOV  X14, D30
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xc012, LSL #48
    FMOV  X14, D31
    SUB  X25, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x6abd, LSL #0
    MOVK  X2, #0x1a30, LSL #16
    MOVK  X2, #0x2340, LSL #32
    MOVK  X2, #0x8bde, LSL #48
    MOVZ  X3, #0xa604, LSL #0
    MOVK  X3, #0x1712, LSL #16
    MOVK  X3, #0x5751, LSL #32
    MOVK  X3, #0xfde4, LSL #48
    MOVZ  X4, #0x2927, LSL #0
    MOVK  X4, #0xf29c, LSL #16
    MOVK  X4, #0x530b, LSL #32
    MOVK  X4, #0xb9dc, LSL #48
    MOVZ  X5, #0x7894, LSL #0
    MOVK  X5, #0x3fa5, LSL #16
    MOVK  X5, #0xee6f, LSL #32
    MOVK  X5, #0x8d6d, LSL #48
    MOVZ  X6, #0xb2c, LSL #0
    MOVK  X6, #0xd559, LSL #16
    MOVK  X6, #0x7198, LSL #32
    MOVK  X6, #0x1626, LSL #48
    MOVZ  X8, #0x80db, LSL #0
    MOVK  X8, #0xeea1, LSL #16
    MOVK  X8, #0xa84f, LSL #32
    MOVK  X8, #0x6a5a, LSL #48
    MOVZ  X9, #0xac7e, LSL #0
    MOVK  X9, #0xcebb, LSL #16
    MOVK  X9, #0x5d9e, LSL #32
    MOVK  X9, #0x87df, LSL #48
    MOVZ  X10, #0x8403, LSL #0
    MOVK  X10, #0x4ded, LSL #16
    MOVK  X10, #0xc12a, LSL #32
    MOVK  X10, #0x714f, LSL #48
    MOVZ  X11, #0x85f4, LSL #0
    MOVK  X11, #0xd28b, LSL #16
    MOVK  X11, #0xd935, LSL #32
    MOVK  X11, #0x337a, LSL #48
    MOVZ  X12, #0xd47f, LSL #0
    MOVK  X12, #0xd642, LSL #16
    MOVK  X12, #0x212b, LSL #32
    MOVK  X12, #0x91a3, LSL #48
    MOVZ  X13, #0xdba4, LSL #0
    MOVK  X13, #0x6cca, LSL #16
    MOVK  X13, #0xdb10, LSL #32
    MOVK  X13, #0x30ed, LSL #48
    MOVZ  X14, #0xfc65, LSL #0
    MOVK  X14, #0x76c0, LSL #16
    MOVK  X14, #0x8a3c, LSL #32
    MOVK  X14, #0xf4e5, LSL #48
    MOVZ  X15, #0xc488, LSL #0
    MOVK  X15, #0x3e07, LSL #16
    MOVK  X15, #0x1137, LSL #32
    MOVK  X15, #0x47ca, LSL #48
    MOVZ  X16, #0x65db, LSL #0
    MOVK  X16, #0x55bb, LSL #16
    MOVK  X16, #0x5bb1, LSL #32
    MOVK  X16, #0x67ef, LSL #48
    MOVZ  X17, #0xd458, LSL #0
    MOVK  X17, #0x9edb, LSL #16
    MOVK  X17, #0xb916, LSL #32
    MOVK  X17, #0x50c4, LSL #48
    MOVZ  X18, #0xa267, LSL #0
    MOVK  X18, #0xb12f, LSL #16
    MOVK  X18, #0x48a6, LSL #32
    MOVK  X18, #0xad2e, LSL #48
    MOVZ  X19, #0xc853, LSL #0
    MOVK  X19, #0x8140, LSL #16
    MOVK  X19, #0x5f27, LSL #32
    MOVK  X19, #0x7bda, LSL #48
    MOVZ  X21, #0xe501, LSL #0
    MOVK  X21, #0x64f5, LSL #16
    MOVK  X21, #0x9f93, LSL #32
    MOVK  X21, #0xe3e8, LSL #48
    MOVZ  X23, #0xd62a, LSL #0
    MOVK  X23, #0x8609, LSL #16
    MOVK  X23, #0x812d, LSL #32
    MOVK  X23, #0x37c0, LSL #48
    MOVZ  X24, #0xc7f0, LSL #0
    MOVK  X24, #0x7932, LSL #16
    MOVK  X24, #0x8f8b, LSL #32
    MOVK  X24, #0xbe0c, LSL #48
    MOVZ  X25, #0xc657, LSL #0
    MOVK  X25, #0x2222, LSL #16
    MOVK  X25, #0x1f29, LSL #32
    MOVK  X25, #0xb69, LSL #48
    MOVZ  X27, #0xc93d, LSL #0
    MOVK  X27, #0x78a4, LSL #16
    MOVK  X27, #0xa621, LSL #32
    MOVK  X27, #0xb187, LSL #48
    MOVZ  X28, #0x2672, LSL #0
    MOVK  X28, #0x6e39, LSL #16
    MOVK  X28, #0xd2d0, LSL #32
    MOVK  X28, #0x9293, LSL #48
    MOVZ  X29, #0x4cad, LSL #0
    MOVK  X29, #0x26e, LSL #16
    MOVK  X29, #0x19a, LSL #32
    MOVK  X29, #0x397, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X4
    FMOV  D3, X3
    FMOV  V3.D[1], X11
    FMOV  D4, X29
    FMOV  V4.D[1], X8
    FMOV  D5, X17
    FMOV  V5.D[1], X5
    FMOV  D6, X5
    FMOV  V6.D[1], X2
    FMOV  D7, X3
    FMOV  V7.D[1], X12
    FMOV  D8, X24
    FMOV  V8.D[1], X2
    FMOV  D9, X3
    FMOV  V9.D[1], X9
    FMOV  D10, X8
    FMOV  V10.D[1], X9
    FMOV  D11, X18
    FMOV  V11.D[1], X25
    FMOV  D12, X2
    FMOV  V12.D[1], X8
    FMOV  D13, X2
    FMOV  V13.D[1], X15
    FMOV  D14, X14
    FMOV  V14.D[1], X15
    FMOV  D15, X13
    FMOV  V15.D[1], X16
    FMOV  D16, X2
    FMOV  V16.D[1], X16
    FMOV  D17, X3
    FMOV  V17.D[1], X28
    FMOV  D18, X8
    FMOV  V18.D[1], X21
    FMOV  D19, X8
    FMOV  V19.D[1], X24
    FMOV  D20, X21
    FMOV  V20.D[1], X16
    FMOV  D21, X17
    FMOV  V21.D[1], X29
    FMOV  D22, X2
    FMOV  V22.D[1], X5
    FMOV  D23, X13
    FMOV  V23.D[1], X27
    FMOV  D24, X27
    FMOV  V24.D[1], X8
    FMOV  D25, X16
    FMOV  V25.D[1], X27
    FMOV  D26, X17
    FMOV  V26.D[1], X8
    FMOV  D27, X6
    FMOV  V27.D[1], X25
    FMOV  D28, X12
    FMOV  V28.D[1], X13
    FMOV  D29, X11
    FMOV  V29.D[1], X2
    FMOV  D30, X23
    FMOV  V30.D[1], X16
    FMOV  D31, X13
    FMOV  V31.D[1], X12
    MOVZ  X18, #0xf, LSL #0
TSRTFloatMovMadd_label_18:
    FCSEL  H6, H27, H25, GE
    FNMSUB  H30, H29, H21, H29
    FSQRT  H6, H30
    FSQRT  S7, S24
    FDIV  D11, D7, D28
    FMUL  S30, S6, S26
    FMOV  D19, #28.00000000
    FMOV  H29, W18
    FNMADD  H20, H11, H31, H29
    FMADD  H10, H20, H20, H30
    FMADD  D6, D19, D10, D10
    FMSUB  H7, H23, H6, H6
    FSQRT  D6, D7
    FMOV  X12, D28
    FMOV  S11, #0.75000000
    FMOV  S19, #-2.00000000
    FMUL  H10, H20, H0
    FADD  H28, H24, H20
    FMUL  D25, D31, D9
    FMSUB  S21, S7, S27, S30
    FMOV  X25, H4
    FMOV  W10, H28
    FSQRT  S0, S29
    FSQRT  D20, D19
    FNMADD  D7, D6, D30, D13
    FADD  H4, H18, H13
    FSUB  H26, H7, H31
    FNEG  H24, H20
    FDIV  S20, S15, S19
    FMOV  W13, S24
    FCSEL  S7, S21, S25, NE
    FMUL  D31, D11, D10
    FABS  D10, D20
    FMOV  H11, H31
    FMOV  X28, D7
    FMOV  H24, H11
    FCSEL  S19, S20, S24, LT
    FMOV  H24, W27
    FMOV  D23, D19
    FCSEL  S11, S24, S10, LE
    FMOV  X2, D31
    FSUB  H21, H23, H0
    FMUL  D28, D11, D26
    FMOV  X15, D4
    FMOV  X12, D28
    FSUB  D7, D0, D16
    FADD  D25, D24, D28
    FNEG  D15, D9
    FMSUB  H20, H5, H14, H6
    FMOV  X29, D31
    FNMSUB  D16, D7, D12, D20
    FCSEL  D12, D18, D16, AL
    FMADD  H18, H24, H4, H14
    FNEG  D23, D8
    FNMSUB  S28, S30, S19, S2
    FNMUL  H14, H22, H24
    FMOV  X21, H7
    FMOV  H30, H15
    FDIV  H16, H4, H11
    FMOV  D6, #26.00000000
    FNMADD  S31, S30, S21, S28
    FMOV  X3, D31
    FSUB  D8, D3, D16
    FABS  D0, D6
    FADD  H4, H18, H12
    FMSUB  D24, D23, D4, D23
    FDIV  S6, S0, S14
    FNMUL  D20, D6, D24
    FMOV  X15, D8
    FCSEL  D31, D20, D20, NV
    FNMSUB  H16, H31, H31, H25
    FNMSUB  D15, D26, D20, D9
    FMADD  S6, S10, S5, S29
    FMADD  H24, H8, H24, H6
    FMADD  S29, S18, S4, S11
    FMOV  S5, S28
    FNMSUB  H21, H20, H18, H7
    FABS  S0, S20
    FMOV  H3, W13
    FMUL  H20, H12, H17
    FSQRT  S12, S16
    FSQRT  H16, H23
    FDIV  S14, S24, S16
    FCSEL  H23, H15, H12, CS
    FNMADD  H12, H14, H6, H23
    FMOV  S14, #-2.87500000
    FMOV  D28, X17
    FADD  D11, D29, D29
    FDIV  S30, S28, S14
    FSUB  H17, H12, H3
    FNEG  S9, S5
    FMOV  W14, H21
    FMADD  S8, S0, S20, S30
    FMOV  S7, W27
    FMOV  W3, H28
    FSQRT  S12, S7
    FMOV  H23, W13
    FMSUB  H14, H8, H17, H8
    FNEG  S21, S14
    FADD  D29, D23, D23
    FSUB  S5, S11, S16
    FSUB  H15, H12, H5
    FNMADD  S24, S9, S9, S29
    FMSUB  H0, H24, H21, H24
    FNMUL  S29, S15, S0
    FNMSUB  H8, H27, H19, H15
    FMOV  W17, S22
    FMOV  H6, #-0.31250000
    FMOV  D24, X28
    FADD  H21, H20, H13
    FSQRT  H20, H8
    FNMSUB  H14, H27, H23, H21
    FNMUL  D19, D19, D13
    FMUL  H27, H0, H26
    FNMADD  S5, S26, S31, S11
    FMOV  D12, #-0.93750000
    FMOV  S8, W3
    FMADD  S16, S5, S14, S5
    FNMSUB  D5, D20, D27, D16
    FSQRT  H26, H29
    FMOV  W15, S6
    FMOV  D29, D24
    FMOV  H11, W10
    FMSUB  D31, D11, D26, D29
    FSUB  H11, H12, H31
    FMUL  D21, D22, D19
    FMSUB  H23, H5, H5, H8
    FADD  H13, H23, H23
    FMOV  S0, #24.00000000
    FMSUB  D23, D11, D0, D11
    FCSEL  D6, D21, D21, NE
    FMOV  H5, H13
    FMOV  X23, D20
    FSUB  D14, D6, D9
    FMOV  H11, #0.50000000
    FNMADD  S9, S23, S1, S23
    FNMADD  S1, S5, S20, S9
    FABS  D0, D12
    FMOV  H21, H14
    FNMUL  D31, D0, D21
    FMOV  H12, X12
    FMADD  H26, H12, H12, H1
    FSUB  H22, H11, H26
    FMOV  D6, X12
    FMUL  S16, S6, S6
    FNEG  D6, D31
    FDIV  S31, S22, S6
    FNEG  D29, D31
    FNEG  D21, D16
    FMOV  H26, H29
    FMOV  S29, S21
    FMOV  D8, D26
    FMOV  H5, W3
    FNMADD  D31, D5, D29, D29
    FNEG  D20, D8
    FMOV  D19, X5
    FNMSUB  D12, D1, D19, D31
    FCSEL  D0, D20, D20, CC
    FNMSUB  D16, D14, D0, D12
    FSQRT  S22, S0
    FMSUB  H8, H15, H14, H29
    FMOV  S0, W18
    FSQRT  D6, D8
    FSUB  H1, H13, H30
    FNMADD  D29, D6, D3, D28
    FNMSUB  D3, D17, D2, D15
    FDIV  D9, D24, D22
    FMADD  D31, D31, D24, D28
    FSUB  D22, D28, D13
    FMOV  D2, D26
    FSQRT  S6, S2
    FSQRT  D17, D16
    FADD  H30, H0, H17
    FNMUL  H21, H6, H28
    FMADD  D16, D22, D3, D22
    FMOV  S5, W3
    FCSEL  H12, H16, H1, GT
    FNEG  S20, S21
    FDIV  S8, S29, S20
    FMUL  S0, S30, S5
    FSQRT  H22, H12
    FMUL  H2, H22, H0
    FNEG  H30, H10
    FMOV  X9, H2
    FABS  D2, D30
    FMOV  X2, H2
    FMADD  H24, H9, H31, H9
    FSQRT  D0, D24
    FMUL  S16, S8, S4
    FMSUB  S9, S0, S16, S0
    FMUL  D14, D16, D30
    FMOV  W15, H11
    FABS  S11, S3
    FNMSUB  S3, S30, S3, S8
    FMUL  D21, D6, D12
    FSUB  D28, D12, D27
    FABS  S12, S30
    FCSEL  H4, H30, H22, VS
    FMOV  X28, D26
    FMADD  D8, D6, D26, D14
    SUBS  X18, X18, #0x1
    B.NE  TSRTFloatMovMadd_label_18
    MOVZ  X16, #0x8000, LSL #0
    SUB  X4, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7894, LSL #0
    MOVK  X16, #0x3fa5, LSL #16
    MOVK  X16, #0xee6f, LSL #32
    MOVK  X16, #0x8d6d, LSL #48
    SUB  X4, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xb2c, LSL #0
    MOVK  X16, #0xd559, LSL #16
    MOVK  X16, #0x7198, LSL #32
    MOVK  X16, #0x1626, LSL #48
    SUB  X4, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x80db, LSL #0
    MOVK  X16, #0xeea1, LSL #16
    MOVK  X16, #0xa84f, LSL #32
    MOVK  X16, #0x6a5a, LSL #48
    SUB  X4, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8001, LSL #0
    SUB  X4, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    SUB  X4, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    SUB  X4, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x3800, LSL #0
    SUB  X4, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xc853, LSL #0
    MOVK  X16, #0x8140, LSL #16
    MOVK  X16, #0x5f27, LSL #32
    MOVK  X16, #0x7bda, LSL #48
    SUB  X4, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    SUB  X4, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xc7f0, LSL #0
    MOVK  X16, #0x7932, LSL #16
    MOVK  X16, #0x8f8b, LSL #32
    MOVK  X16, #0xbe0c, LSL #48
    SUB  X4, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xc93d, LSL #0
    MOVK  X16, #0x78a4, LSL #16
    MOVK  X16, #0xa621, LSL #32
    MOVK  X16, #0xb187, LSL #48
    SUB  X4, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    SUB  X4, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x9f, LSL #0
    MRS  X4, FPSR
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D0
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D1
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X4, D2
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V3.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X4, D3
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D4
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D5
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V6.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D6
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0xc93d, LSL #0
    MOVK  X16, #0x78a4, LSL #16
    FMOV  X4, D7
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D8
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X4, D9
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #16
    FMOV  X4, D10
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D11
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V12.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X4, D12
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V13.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D13
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D14
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V15.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x3ba4, LSL #0
    FMOV  X4, D15
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x7fc0, LSL #16
    FMOV  X4, D16
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D17
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V18.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7e00, LSL #0
    FMOV  X4, D18
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x7894, LSL #0
    MOVK  X16, #0x3fa5, LSL #16
    MOVK  X16, #0xee6f, LSL #32
    MOVK  X16, #0x8d6d, LSL #48
    FMOV  X4, D19
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V20.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    MOVK  X16, #0x8000, LSL #16
    FMOV  X4, D20
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D21
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D22
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D23
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D24
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D25
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D26
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D27
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V28.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D28
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x8000, LSL #48
    FMOV  X4, D29
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x8000, LSL #0
    FMOV  X4, D30
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X4, D31
    SUB  X11, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTFloatMovMadd_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X6, #0x0, LSL #0
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
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X13
    FMOV  V0.D[1], X9
    FMOV  D1, X28
    FMOV  V1.D[1], X12
    FMOV  D2, X11
    FMOV  V2.D[1], X19
    FMOV  D3, X16
    FMOV  V3.D[1], X10
    FMOV  D4, X24
    FMOV  V4.D[1], X27
    FMOV  D5, X25
    FMOV  V5.D[1], X29
    FMOV  D6, X23
    FMOV  V6.D[1], X21
    FMOV  D7, X17
    FMOV  V7.D[1], X18
    FMOV  D8, X5
    FMOV  V8.D[1], X5
    FMOV  D9, X15
    FMOV  V9.D[1], X11
    FMOV  D10, X28
    FMOV  V10.D[1], X6
    FMOV  D11, X16
    FMOV  V11.D[1], X15
    FMOV  D12, X15
    FMOV  V12.D[1], X4
    FMOV  D13, X2
    FMOV  V13.D[1], X10
    FMOV  D14, X8
    FMOV  V14.D[1], X21
    FMOV  D15, X14
    FMOV  V15.D[1], X5
    FMOV  D16, X16
    FMOV  V16.D[1], X4
    FMOV  D17, X12
    FMOV  V17.D[1], X3
    FMOV  D18, X23
    FMOV  V18.D[1], X28
    FMOV  D19, X3
    FMOV  V19.D[1], X3
    FMOV  D20, X14
    FMOV  V20.D[1], X29
    FMOV  D21, X2
    FMOV  V21.D[1], X17
    FMOV  D22, X27
    FMOV  V22.D[1], X21
    FMOV  D23, X15
    FMOV  V23.D[1], X29
    FMOV  D24, X23
    FMOV  V24.D[1], X21
    FMOV  D25, X6
    FMOV  V25.D[1], X8
    FMOV  D26, X16
    FMOV  V26.D[1], X15
    FMOV  D27, X5
    FMOV  V27.D[1], X24
    FMOV  D28, X8
    FMOV  V28.D[1], X4
    FMOV  D29, X17
    FMOV  V29.D[1], X25
    FMOV  D30, X11
    FMOV  V30.D[1], X8
    FMOV  D31, X18
    FMOV  V31.D[1], X24
    MOVZ  X10, #0xf, LSL #0
TSRTFloatMovMadd_label_19:
    FMOV  S18, #-28.00000000
    FDIV  D21, D31, D31
    FNMUL  D15, D26, D26
    FADD  H16, H28, H30
    FSQRT  S27, S16
    FNMSUB  D23, D29, D18, D22
    FDIV  S13, S25, S27
    FNMUL  S24, S24, S15
    FCSEL  D0, D13, D13, AL
    FMOV  S25, S0
    FNEG  D1, D25
    FABS  S22, S24
    FMOV  S21, #-5.00000000
    FMOV  D8, D22
    FMOV  H28, #2.12500000
    FNMSUB  H9, H1, H1, H28
    FMSUB  D22, D21, D9, D21
    FMOV  X18, D23
    FCSEL  S23, S22, S22, CC
    FNMSUB  H3, H8, H23, H8
    FNEG  D24, D30
    FADD  H22, H10, H3
    FABS  D21, D8
    FMUL  H30, H12, H18
    FMOV  W28, S24
    FMADD  D29, D8, D28, D29
    FMOV  X23, D2
    FMOV  D0, D9
    FNMSUB  D10, D21, D25, D1
    FSQRT  D23, D14
    FSQRT  S16, S17
    FMOV  X12, D15
    FMADD  D17, D25, D19, D31
    FMUL  S15, S14, S0
    FDIV  D24, D3, D25
    FNMUL  H27, H17, H23
    FDIV  H23, H16, H16
    FMOV  H21, #0.15625000
    FMOV  H13, H21
    FMSUB  H16, H13, H3, H30
    FMUL  S1, S16, S23
    FABS  H12, H10
    FMUL  D21, D1, D1
    FMSUB  D28, D29, D21, D15
    FMOV  H16, H27
    FNMADD  S17, S12, S24, S16
    FMOV  H25, H17
    FMADD  H27, H25, H25, H25
    FNMSUB  H8, H27, H28, H28
    FABS  S1, S8
    FNEG  D8, D1
    FMADD  S30, S8, S8, S8
    FMOV  D31, X10
    FMOV  D9, X9
    FCSEL  D25, D30, D9, VC
    FMOV  X29, H31
    FMSUB  H28, H21, H14, H7
    FADD  S30, S0, S13
    FCSEL  H9, H8, H30, CS
    FMSUB  H23, H31, H25, H26
    FMOV  H14, W12
    FNMADD  D1, D4, D12, D9
    FNMADD  S7, S3, S20, S26
    FMUL  S17, S12, S4
    FDIV  H27, H3, H31
    FNMUL  S25, S7, S25
    FSQRT  H7, H10
    FMADD  S21, S7, S31, S9
    FMUL  D24, D24, D21
    FNMUL  S3, S0, S10
    FADD  D10, D17, D25
    FMOV  X3, D28
    FMOV  S26, S10
    FCSEL  S13, S24, S24, MI
    FNMUL  D16, D13, D3
    FMOV  X27, H23
    FSUB  H23, H14, H8
    FMOV  S17, #-1.25000000
    FMOV  H9, X28
    FNEG  D25, D27
    FMSUB  D21, D1, D16, D23
    FNMADD  H8, H26, H26, H17
    FMUL  D0, D8, D25
    FMOV  X23, D30
    FMSUB  H26, H14, H9, H0
    FNMUL  S16, S26, S21
    FNEG  H31, H6
    FADD  S1, S17, S27
    FADD  H23, H20, H16
    FADD  D14, D0, D6
    FNMSUB  D26, D5, D26, D20
    FNMADD  H25, H4, H7, H8
    FNMSUB  D28, D13, D31, D24
    FSQRT  S24, S23
    FSQRT  D3, D27
    FADD  H13, H17, H10
    FMOV  H9, H0
    FMOV  H6, X13
    FMSUB  D31, D9, D6, D1
    FNMUL  S0, S24, S31
    FCSEL  D10, D3, D13, VC
    FNMUL  H16, H25, H25
    FNMUL  H13, H28, H26
    FMADD  D20, D13, D0, D16
    FMADD  D25, D20, D12, D10
    FMOV  D7, #18.00000000
    FMOV  H5, H7
    FMUL  D0, D25, D14
    FADD  D10, D5, D0
    FMSUB  H16, H24, H2, H31
    FSUB  S23, S26, S2
    FABS  D30, D27
    FDIV  S5, S15, S31
    FSQRT  H12, H29
    FDIV  D6, D25, D28
    FDIV  D27, D3, D1
    FMOV  H0, W28
    FNMSUB  H8, H16, H6, H0
    FNMSUB  D7, D30, D23, D8
    FMOV  H13, W29
    FABS  S25, S12
    FNMUL  D1, D10, D10
    FDIV  H0, H1, H13
    FMOV  S30, W27
    FMOV  H14, #-13.00000000
    FSQRT  S13, S25
    FDIV  S26, S7, S0
    FNMADD  S31, S30, S26, S5
    FSQRT  S30, S31
    FCSEL  S5, S14, S27, VS
    FDIV  H10, H13, H2
    FMOV  S24, S5
    FMADD  S31, S24, S30, S10
    FMOV  H13, #-6.75000000
    FDIV  H26, H6, H18
    FDIV  D3, D27, D16
    FSUB  D1, D31, D8
    FADD  H6, H18, H10
    FMSUB  H15, H2, H12, H7
    FCSEL  S14, S1, S22, VC
    FSUB  H10, H7, H21
    FMOV  X15, H26
    FNMADD  H8, H28, H2, H23
    FMOV  H18, X10
    FMOV  W27, H14
    FMSUB  S25, S5, S6, S22
    FADD  S13, S25, S11
    FMOV  X16, H4
    FCSEL  S27, S10, S1, VS
    FNMUL  H12, H17, H16
    FNMSUB  S31, S1, S18, S26
    FMSUB  H6, H28, H31, H17
    FMSUB  D30, D31, D15, D16
    FMOV  X15, D31
    FADD  D28, D16, D30
    FMADD  D7, D27, D26, D3
    FMOV  X21, D6
    FCSEL  H23, H26, H29, NV
    FMOV  D26, #-8.00000000
    FMOV  H14, H0
    FNMUL  S5, S25, S17
    FMOV  D27, #2.00000000
    FSUB  D0, D13, D22
    FMOV  D31, D7
    FCSEL  S15, S26, S28, LT
    FMOV  D26, #-2.62500000
    FMADD  H10, H8, H31, H12
    FADD  H13, H10, H23
    FNMUL  S22, S27, S26
    FSUB  H4, H22, H18
    FSUB  S29, S13, S5
    FMOV  S10, #0.93750000
    FNMUL  D18, D10, D10
    FSQRT  S10, S18
    FDIV  S6, S29, S14
    FMSUB  D27, D0, D10, D10
    FNMUL  D17, D27, D2
    FSQRT  D26, D17
    FNEG  S13, S5
    FNEG  S1, S15
    FNMUL  D10, D6, D4
    FMOV  H29, W9
    FMUL  H18, H26, H26
    FNEG  H27, H13
    FADD  H15, H29, H29
    FMOV  W2, H10
    FNMADD  D23, D1, D15, D15
    FMOV  H26, W5
    FNMUL  S29, S18, S18
    FDIV  H12, H26, H26
    FMUL  D14, D12, D29
    FMOV  S5, #0.31250000
    FMOV  S29, W15
    FNMADD  D17, D23, D29, D29
    FMOV  W23, S14
    FDIV  D12, D31, D5
    FMOV  H29, #-1.18750000
    FMOV  W27, S27
    FMOV  H14, #0.39062500
    FSQRT  H1, H12
    SUBS  X10, X10, #0x1
    B.NE  TSRTFloatMovMadd_label_19
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    SUB  X6, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8002, LSL #0
    SUB  X6, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8000, LSL #0
    SUB  X6, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X6, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x1, LSL #0
    SUB  X6, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x9f, LSL #0
    MRS  X6, FPSR
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D0
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D1
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D2
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    FMOV  X6, D3
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8001, LSL #0
    FMOV  X6, D4
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x3ea0, LSL #16
    FMOV  X6, D5
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7fc0, LSL #16
    FMOV  X6, D6
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    FMOV  X6, D7
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8000, LSL #0
    FMOV  X6, D8
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    FMOV  X6, D10
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D11
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    FMOV  X6, D12
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    FMOV  X6, D13
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x3640, LSL #0
    FMOV  X6, D14
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D16
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D17
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D20
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D21
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #16
    FMOV  X6, D22
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x8000, LSL #48
    FMOV  X6, D23
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x8000, LSL #0
    FMOV  X6, D27
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0xbcc0, LSL #0
    FMOV  X6, D29
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
    MOVZ  X11, #0x0, LSL #0
    MOVK  X11, #0x7ff8, LSL #48
    FMOV  X6, D31
    SUB  X24, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTFloatMovMadd_TestFail
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
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X25
    FMOV  V2.D[1], X21
    FMOV  D3, X12
    FMOV  V3.D[1], X4
    FMOV  D4, X29
    FMOV  V4.D[1], X4
    FMOV  D5, X12
    FMOV  V5.D[1], X3
    FMOV  D6, X6
    FMOV  V6.D[1], X11
    FMOV  D7, X5
    FMOV  V7.D[1], X2
    FMOV  D8, X25
    FMOV  V8.D[1], X25
    FMOV  D9, X16
    FMOV  V9.D[1], X27
    FMOV  D10, X19
    FMOV  V10.D[1], X14
    FMOV  D11, X5
    FMOV  V11.D[1], X21
    FMOV  D12, X28
    FMOV  V12.D[1], X17
    FMOV  D13, X15
    FMOV  V13.D[1], X12
    FMOV  D14, X27
    FMOV  V14.D[1], X10
    FMOV  D15, X11
    FMOV  V15.D[1], X4
    FMOV  D16, X29
    FMOV  V16.D[1], X18
    FMOV  D17, X12
    FMOV  V17.D[1], X12
    FMOV  D18, X6
    FMOV  V18.D[1], X11
    FMOV  D19, X3
    FMOV  V19.D[1], X14
    FMOV  D20, X2
    FMOV  V20.D[1], X3
    FMOV  D21, X23
    FMOV  V21.D[1], X6
    FMOV  D22, X8
    FMOV  V22.D[1], X19
    FMOV  D23, X8
    FMOV  V23.D[1], X2
    FMOV  D24, X15
    FMOV  V24.D[1], X13
    FMOV  D25, X17
    FMOV  V25.D[1], X4
    FMOV  D26, X25
    FMOV  V26.D[1], X17
    FMOV  D27, X13
    FMOV  V27.D[1], X10
    FMOV  D28, X29
    FMOV  V28.D[1], X4
    FMOV  D29, X14
    FMOV  V29.D[1], X11
    FMOV  D30, X14
    FMOV  V30.D[1], X18
    FMOV  D31, X13
    FMOV  V31.D[1], X3
    MOVZ  X4, #0xf, LSL #0
TSRTFloatMovMadd_label_20:
    FMOV  X29, H24
    FMOV  H1, X4
    FCSEL  S6, S18, S25, MI
    FADD  S23, S28, S27
    FMSUB  S16, S23, S26, S23
    FMOV  H21, H30
    FCSEL  S4, S6, S6, NE
    FNMUL  D10, D22, D29
    FSQRT  H24, H31
    FNMADD  D11, D4, D1, D10
    FDIV  S15, S24, S16
    FABS  D1, D15
    FMUL  S27, S11, S21
    FMOV  S19, S1
    FMOV  H26, H30
    FMUL  D15, D26, D26
    FNMSUB  S4, S15, S27, S15
    FNEG  D11, D19
    FDIV  S15, S11, S11
    FSUB  H31, H4, H15
    FADD  S24, S17, S21
    FNMADD  D25, D26, D2, D23
    FMOV  W3, H15
    FMOV  X27, D3
    FMADD  S3, S31, S0, S14
    FSUB  D21, D11, D16
    FMADD  D19, D24, D0, D7
    FMOV  H10, W8
    FNEG  D11, D14
    FDIV  S31, S21, S2
    FMOV  X19, H10
    FSQRT  D4, D18
    FNMUL  D15, D10, D9
    FNMADD  D2, D27, D6, D18
    FMUL  H18, H16, H0
    FNEG  D26, D25
    FMSUB  S17, S4, S18, S2
    FNMUL  D0, D17, D19
    FMOV  H18, H3
    FMOV  W5, S15
    FMOV  D21, D11
    FNMUL  H7, H5, H18
    FSQRT  D6, D0
    FSQRT  S0, S26
    FMUL  D16, D0, D31
    FMSUB  D15, D6, D7, D16
    FMSUB  D26, D21, D15, D15
    FMSUB  S15, S11, S26, S21
    FMOV  D3, #0.62500000
    FNEG  S6, S14
    FSUB  S0, S10, S17
    FMUL  H18, H6, H18
    FMOV  S19, S7
    FNMSUB  S5, S30, S27, S14
    FNMSUB  D4, D11, D18, D28
    FMOV  X25, H15
    FSUB  H28, H13, H16
    FMUL  D6, D6, D24
    FADD  D25, D9, D13
    FNMADD  S24, S25, S16, S22
    FMOV  S25, W16
    FMSUB  D15, D25, D19, D5
    FMOV  D16, D3
    FNEG  S9, S11
    FABS  H13, H28
    FDIV  H11, H4, H16
    FSUB  S27, S13, S9
    FNEG  D28, D0
    FABS  S13, S15
    FCSEL  D0, D13, D6, CC
    FNMSUB  H13, H24, H11, H27
    FSUB  S22, S28, S13
    FNMADD  S5, S22, S22, S0
    FABS  S15, S7
    FNMSUB  H25, H4, H23, H28
    FMOV  S16, #-13.50000000
    FMOV  W3, S6
    FMOV  S11, S17
    FCSEL  S13, S30, S4, NV
    FMOV  S0, #26.00000000
    FMSUB  S14, S18, S5, S31
    FCSEL  D19, D17, D22, CC
    FMADD  D6, D22, D3, D14
    FNMSUB  D18, D15, D1, D11
    FSUB  D27, D29, D19
    FNMADD  D17, D28, D3, D3
    FNEG  D24, D26
    FNMUL  S5, S18, S0
    FNMADD  D22, D25, D17, D6
    FMUL  H4, H27, H13
    FMOV  W16, H16
    FNMUL  D27, D24, D24
    FNEG  H31, H4
    FMSUB  H30, H27, H22, H5
    FCSEL  S22, S30, S30, EQ
    FMOV  H30, #-0.37500000
    FCSEL  S3, S31, S31, GE
    FNMUL  S31, S22, S22
    FMOV  X16, D30
    FSUB  S24, S3, S31
    FNMSUB  H5, H18, H10, H15
    FNMADD  D3, D30, D17, D27
    FNEG  D11, D16
    FMOV  W9, H13
    FMOV  D14, D21
    FMADD  D22, D0, D28, D6
    FMADD  H21, H4, H31, H7
    FNMSUB  H30, H22, H30, H29
    FDIV  H25, H21, H24
    FSUB  H1, H21, H4
    FDIV  H13, H18, H26
    FSQRT  D18, D28
    FMSUB  S0, S26, S1, S13
    FMADD  S24, S11, S0, S5
    FCSEL  D16, D25, D3, EQ
    FNMADD  S5, S16, S14, S30
    FCSEL  H30, H18, H5, LS
    FMADD  H4, H30, H24, H30
    FNMUL  D12, D18, D2
    FCSEL  H24, H18, H12, LT
    FABS  H17, H26
    FMSUB  H6, H7, H23, H27
    FNMSUB  D29, D24, D11, D3
    FSQRT  S7, S19
    FMOV  W29, S15
    FABS  H21, H13
    FMOV  H28, X19
    FMADD  H14, H24, H13, H0
    FMOV  X3, H0
    FMOV  S26, S26
    FNMADD  D11, D29, D26, D4
    FMADD  S26, S21, S6, S21
    FNEG  S30, S11
    FNEG  D0, D28
    FMOV  D6, X19
    FMADD  S27, S30, S6, S17
    FABS  D2, D1
    FMOV  H28, W15
    FSQRT  S18, S14
    FMOV  S30, #1.25000000
    FADD  S29, S0, S30
    FNMSUB  D1, D18, D7, D9
    FCSEL  H21, H27, H28, AL
    FCSEL  D14, D1, D26, NE
    FMOV  H0, H2
    FNMSUB  H19, H29, H14, H14
    FADD  S9, S0, S30
    FNMADD  D7, D21, D9, D19
    FSUB  H9, H13, H12
    FMOV  W15, S18
    FMADD  D6, D17, D20, D25
    FNEG  S2, S2
    FMOV  S27, S3
    FMOV  H11, W29
    FMOV  H28, #-0.75000000
    FNEG  H26, H24
    FMOV  H18, #-14.00000000
    FABS  S29, S7
    FMOV  X28, D29
    FSUB  S14, S9, S28
    FNEG  S9, S6
    FMOV  S12, W9
    FMOV  S24, W8
    FMSUB  S29, S14, S27, S24
    FNMUL  D0, D2, D12
    FCSEL  H27, H0, H29, PL
    FADD  D19, D24, D27
    FCSEL  D20, D19, D9, CS
    FADD  H14, H20, H18
    FMOV  H0, W28
    FMUL  S3, S26, S10
    FMOV  H7, H14
    FNEG  D19, D0
    FSUB  D0, D11, D3
    FMOV  H20, X4
    FMOV  S2, S0
    FMOV  H29, H2
    FMUL  H11, H20, H29
    FMOV  S17, #8.50000000
    FMOV  S10, S17
    FNMADD  S12, S7, S17, S10
    FNEG  H28, H19
    FMOV  H19, H12
    FNMUL  S27, S28, S4
    FMADD  H9, H11, H27, H27
    FNMSUB  D24, D9, D9, D19
    FMOV  H11, W25
    FSQRT  H6, H12
    FNMUL  S31, S26, S13
    FNMADD  S13, S20, S23, S18
    FMOV  H20, #-0.53125000
    FNMADD  S27, S30, S24, S8
    FMOV  H12, W15
    FDIV  S26, S25, S17
    FABS  D18, D2
    FMADD  H17, H26, H11, H12
    FDIV  H3, H6, H13
    FMSUB  D23, D17, D15, D18
    FNMUL  H25, H28, H20
    FSUB  D14, D25, D23
    SUBS  X4, X4, #0x1
    B.NE  TSRTFloatMovMadd_label_20
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xb600, LSL #0
    SUB  X18, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    SUB  X18, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X18, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    SUB  X18, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X18, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x8000, LSL #0
    SUB  X18, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x9f, LSL #0
    MRS  X18, FPSR
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D0
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D1
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D2
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x7e00, LSL #0
    FMOV  X18, D3
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D4
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    FMOV  X18, D5
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D6
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xcb00, LSL #0
    FMOV  X18, D7
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X18, V8.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X18, D8
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D9
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x4108, LSL #16
    FMOV  X18, D10
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D11
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D12
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    FMOV  X18, D13
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D14
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x8000, LSL #0
    FMOV  X18, D15
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D16
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D17
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D18
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D19
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0xb840, LSL #0
    FMOV  X18, D20
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D21
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D22
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D23
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D24
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x8000, LSL #0
    FMOV  X18, D25
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D26
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x7fc0, LSL #16
    FMOV  X18, D27
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x8000, LSL #0
    FMOV  X18, D28
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, D29
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x3fa0, LSL #16
    FMOV  X18, D30
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0x8000, LSL #16
    FMOV  X18, D31
    SUB  X2, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTFloatMovMadd_TestFail

TSRTFloatMovMadd_TestEnd:
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
TSRTFloatMovMadd_TestFail:
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
