.global TSRTAdvsimdVectorSecureHashStandard

.text
.p2align 4

TSRTAdvsimdVectorSecureHashStandard:

TSRTAdvsimdVectorSecureHashStandard_TestBegin:
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
    MOVZ  X2, #0x1b4e, LSL #0
    MOVK  X2, #0x27b3, LSL #16
    MOVK  X2, #0x87b8, LSL #32
    MOVK  X2, #0xae7e, LSL #48
    MOVZ  X3, #0xc977, LSL #0
    MOVK  X3, #0xdb29, LSL #16
    MOVK  X3, #0xcdda, LSL #32
    MOVK  X3, #0x55e4, LSL #48
    MOVZ  X5, #0x1b01, LSL #0
    MOVK  X5, #0x2adb, LSL #16
    MOVK  X5, #0x78c6, LSL #32
    MOVK  X5, #0x7806, LSL #48
    MOVZ  X6, #0xcb04, LSL #0
    MOVK  X6, #0xd289, LSL #16
    MOVK  X6, #0x3af2, LSL #32
    MOVK  X6, #0x959b, LSL #48
    MOVZ  X8, #0xbfa4, LSL #0
    MOVK  X8, #0x468d, LSL #16
    MOVK  X8, #0x307c, LSL #32
    MOVK  X8, #0xc0ae, LSL #48
    MOVZ  X9, #0xca8d, LSL #0
    MOVK  X9, #0x1f9e, LSL #16
    MOVK  X9, #0x2c76, LSL #32
    MOVK  X9, #0xe41d, LSL #48
    MOVZ  X10, #0x84b5, LSL #0
    MOVK  X10, #0xf2ec, LSL #16
    MOVK  X10, #0xfd02, LSL #32
    MOVK  X10, #0x572d, LSL #48
    MOVZ  X11, #0xfafd, LSL #0
    MOVK  X11, #0x3cb5, LSL #16
    MOVK  X11, #0xee52, LSL #32
    MOVK  X11, #0xccb6, LSL #48
    MOVZ  X12, #0xd471, LSL #0
    MOVK  X12, #0xac0b, LSL #16
    MOVK  X12, #0x31ef, LSL #32
    MOVK  X12, #0xa659, LSL #48
    MOVZ  X13, #0x6dce, LSL #0
    MOVK  X13, #0x88fe, LSL #16
    MOVK  X13, #0x6301, LSL #32
    MOVK  X13, #0x462a, LSL #48
    MOVZ  X14, #0x8cfa, LSL #0
    MOVK  X14, #0x9346, LSL #16
    MOVK  X14, #0x49f6, LSL #32
    MOVK  X14, #0xd9ab, LSL #48
    MOVZ  X15, #0xf31b, LSL #0
    MOVK  X15, #0x1408, LSL #16
    MOVK  X15, #0x6984, LSL #32
    MOVK  X15, #0x9629, LSL #48
    MOVZ  X16, #0xb08c, LSL #0
    MOVK  X16, #0xdf85, LSL #16
    MOVK  X16, #0x1727, LSL #32
    MOVK  X16, #0x9bfc, LSL #48
    MOVZ  X17, #0x2a3e, LSL #0
    MOVK  X17, #0xa59b, LSL #16
    MOVK  X17, #0x107d, LSL #32
    MOVK  X17, #0x4091, LSL #48
    MOVZ  X18, #0xae31, LSL #0
    MOVK  X18, #0x3f0e, LSL #16
    MOVK  X18, #0xf9cc, LSL #32
    MOVK  X18, #0x139e, LSL #48
    MOVZ  X19, #0x5c88, LSL #0
    MOVK  X19, #0x492e, LSL #16
    MOVK  X19, #0xb35d, LSL #32
    MOVK  X19, #0x6b4d, LSL #48
    MOVZ  X20, #0x4b55, LSL #0
    MOVK  X20, #0x9867, LSL #16
    MOVK  X20, #0x80de, LSL #32
    MOVK  X20, #0x107c, LSL #48
    MOVZ  X21, #0x803e, LSL #0
    MOVK  X21, #0xa2cd, LSL #16
    MOVK  X21, #0x792, LSL #32
    MOVK  X21, #0x87e0, LSL #48
    MOVZ  X22, #0x8071, LSL #0
    MOVK  X22, #0x7f92, LSL #16
    MOVK  X22, #0x83d2, LSL #32
    MOVK  X22, #0x93f2, LSL #48
    MOVZ  X24, #0x81cf, LSL #0
    MOVK  X24, #0xfa31, LSL #16
    MOVK  X24, #0xce02, LSL #32
    MOVK  X24, #0xd748, LSL #48
    MOVZ  X25, #0x6a2f, LSL #0
    MOVK  X25, #0xea08, LSL #16
    MOVK  X25, #0x212a, LSL #32
    MOVK  X25, #0xa4b, LSL #48
    MOVZ  X27, #0xd0bb, LSL #0
    MOVK  X27, #0x7dae, LSL #16
    MOVK  X27, #0x43a7, LSL #32
    MOVK  X27, #0x6f90, LSL #48
    MOVZ  X28, #0x59f4, LSL #0
    MOVK  X28, #0x8f0e, LSL #16
    MOVK  X28, #0x8932, LSL #32
    MOVK  X28, #0xc230, LSL #48
    MOVZ  X29, #0x7f45, LSL #0
    MOVK  X29, #0xd613, LSL #16
    MOVK  X29, #0x3b32, LSL #32
    MOVK  X29, #0x31ce, LSL #48
    MOVZ  X9, #0xaa5a, LSL #0
    MOVK  X9, #0xd409, LSL #16
    MOVK  X9, #0x28e9, LSL #32
    MOVK  X9, #0x28af, LSL #48
    MSR  FPCR, X9
    MOVZ  X9, #0x178f, LSL #0
    MOVK  X9, #0x8cc9, LSL #16
    MOVK  X9, #0xbc82, LSL #32
    MOVK  X9, #0x785, LSL #48
    MSR  FPSR, X9
    MRS  X21, FPSR
    MOVZ  X3, #0xff60, LSL #0
    MOVK  X3, #0x7ff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X21, X21, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X21, X21, X3
    MSR  FPSR, X21
    ISB  SY
    SUBS  W28, W2, W27, LSL #19
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x1adc, LSL #0
    MOVK  X2, #0x6965, LSL #16
    MOVK  X2, #0xc352, LSL #32
    MOVK  X2, #0xcac9, LSL #48
    MOVZ  X3, #0x39f1, LSL #0
    MOVK  X3, #0x434a, LSL #16
    MOVK  X3, #0xc56, LSL #32
    MOVK  X3, #0xf8f9, LSL #48
    MOVZ  X5, #0xe37b, LSL #0
    MOVK  X5, #0xc6a9, LSL #16
    MOVK  X5, #0x47b4, LSL #32
    MOVK  X5, #0xbacd, LSL #48
    MOVZ  X6, #0xada1, LSL #0
    MOVK  X6, #0xc7f2, LSL #16
    MOVK  X6, #0x9416, LSL #32
    MOVK  X6, #0xb8a, LSL #48
    MOVZ  X8, #0x12e5, LSL #0
    MOVK  X8, #0xc0c3, LSL #16
    MOVK  X8, #0xee75, LSL #32
    MOVK  X8, #0x6eeb, LSL #48
    MOVZ  X9, #0x5a1e, LSL #0
    MOVK  X9, #0x937f, LSL #16
    MOVK  X9, #0x4317, LSL #32
    MOVK  X9, #0xbb15, LSL #48
    MOVZ  X10, #0x2439, LSL #0
    MOVK  X10, #0x676f, LSL #16
    MOVK  X10, #0x24e4, LSL #32
    MOVK  X10, #0xbf3d, LSL #48
    MOVZ  X11, #0x6ed5, LSL #0
    MOVK  X11, #0xd8b0, LSL #16
    MOVK  X11, #0xa95, LSL #32
    MOVK  X11, #0xacaf, LSL #48
    MOVZ  X12, #0x63a9, LSL #0
    MOVK  X12, #0xf5fb, LSL #16
    MOVK  X12, #0x82ed, LSL #32
    MOVK  X12, #0x4cca, LSL #48
    MOVZ  X13, #0xdd46, LSL #0
    MOVK  X13, #0x48d2, LSL #16
    MOVK  X13, #0x7b54, LSL #32
    MOVK  X13, #0x95de, LSL #48
    MOVZ  X14, #0x3176, LSL #0
    MOVK  X14, #0x882d, LSL #16
    MOVK  X14, #0x7854, LSL #32
    MOVK  X14, #0xc1ae, LSL #48
    MOVZ  X15, #0x7db5, LSL #0
    MOVK  X15, #0xc021, LSL #16
    MOVK  X15, #0x6787, LSL #32
    MOVK  X15, #0x175c, LSL #48
    MOVZ  X16, #0xad87, LSL #0
    MOVK  X16, #0x6c56, LSL #16
    MOVK  X16, #0xafd9, LSL #32
    MOVK  X16, #0xffe8, LSL #48
    MOVZ  X17, #0xddac, LSL #0
    MOVK  X17, #0x1e98, LSL #16
    MOVK  X17, #0x4e65, LSL #32
    MOVK  X17, #0x2fc6, LSL #48
    MOVZ  X18, #0xcd21, LSL #0
    MOVK  X18, #0x7274, LSL #16
    MOVK  X18, #0x2bfd, LSL #32
    MOVK  X18, #0x62c, LSL #48
    MOVZ  X19, #0xf86c, LSL #0
    MOVK  X19, #0x9684, LSL #16
    MOVK  X19, #0xb49d, LSL #32
    MOVK  X19, #0xc9cb, LSL #48
    MOVZ  X20, #0xb88, LSL #0
    MOVK  X20, #0x4d36, LSL #16
    MOVK  X20, #0x89f1, LSL #32
    MOVK  X20, #0xead1, LSL #48
    MOVZ  X21, #0xa96d, LSL #0
    MOVK  X21, #0xa9f4, LSL #16
    MOVK  X21, #0x4450, LSL #32
    MOVK  X21, #0x7dc0, LSL #48
    MOVZ  X22, #0xff25, LSL #0
    MOVK  X22, #0x6105, LSL #16
    MOVK  X22, #0x172, LSL #32
    MOVK  X22, #0xf3d1, LSL #48
    MOVZ  X24, #0x6c6e, LSL #0
    MOVK  X24, #0x3dd2, LSL #16
    MOVK  X24, #0xbc6f, LSL #32
    MOVK  X24, #0xefa7, LSL #48
    MOVZ  X25, #0xfb1c, LSL #0
    MOVK  X25, #0x860a, LSL #16
    MOVK  X25, #0x43a8, LSL #32
    MOVK  X25, #0xa026, LSL #48
    MOVZ  X27, #0x8411, LSL #0
    MOVK  X27, #0xad9c, LSL #16
    MOVK  X27, #0x97e4, LSL #32
    MOVK  X27, #0xb19d, LSL #48
    MOVZ  X28, #0xfb63, LSL #0
    MOVK  X28, #0xad1e, LSL #16
    MOVK  X28, #0xd3ed, LSL #32
    MOVK  X28, #0x1c07, LSL #48
    MOVZ  X29, #0x7c08, LSL #0
    MOVK  X29, #0x9d49, LSL #16
    MOVK  X29, #0xcfa6, LSL #32
    MOVK  X29, #0x6d55, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X19
    FMOV  D3, X11
    FMOV  V3.D[1], X22
    FMOV  D4, X18
    FMOV  V4.D[1], X24
    FMOV  D5, X6
    FMOV  V5.D[1], X5
    FMOV  D6, X5
    FMOV  V6.D[1], X25
    FMOV  D7, X6
    FMOV  V7.D[1], X11
    FMOV  D8, X19
    FMOV  V8.D[1], X16
    FMOV  D9, X14
    FMOV  V9.D[1], X12
    FMOV  D10, X6
    FMOV  V10.D[1], X25
    FMOV  D11, X2
    FMOV  V11.D[1], X21
    FMOV  D12, X19
    FMOV  V12.D[1], X5
    FMOV  D13, X17
    FMOV  V13.D[1], X8
    FMOV  D14, X17
    FMOV  V14.D[1], X8
    FMOV  D15, X12
    FMOV  V15.D[1], X25
    FMOV  D16, X25
    FMOV  V16.D[1], X8
    FMOV  D17, X24
    FMOV  V17.D[1], X14
    FMOV  D18, X29
    FMOV  V18.D[1], X3
    FMOV  D19, X2
    FMOV  V19.D[1], X21
    FMOV  D20, X6
    FMOV  V20.D[1], X3
    FMOV  D21, X27
    FMOV  V21.D[1], X19
    FMOV  D22, X13
    FMOV  V22.D[1], X12
    FMOV  D23, X11
    FMOV  V23.D[1], X9
    FMOV  D24, X14
    FMOV  V24.D[1], X5
    FMOV  D25, X14
    FMOV  V25.D[1], X12
    FMOV  D26, X21
    FMOV  V26.D[1], X25
    FMOV  D27, X17
    FMOV  V27.D[1], X8
    FMOV  D28, X27
    FMOV  V28.D[1], X18
    FMOV  D29, X29
    FMOV  V29.D[1], X13
    FMOV  D30, X3
    FMOV  V30.D[1], X22
    FMOV  D31, X6
    FMOV  V31.D[1], X16
    MOVZ  X18, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_0:
    SHA1P  Q28, S24, V21.4S
    SHA1P  Q1, S23, V26.4S
    SHA1C  Q3, S20, V1.4S
    SHA1C  Q30, S27, V25.4S
    SHA256SU0  V19.4S, V31.4S
    SHA1SU0  V24.4S, V22.4S, V28.4S
    SHA1M  Q16, S29, V29.4S
    SHA1SU1  V29.4S, V3.4S
    SHA256H2  Q17, Q29, V24.4S
    SHA1M  Q23, S17, V17.4S
    SHA1SU0  V22.4S, V16.4S, V23.4S
    SHA256H  Q24, Q19, V19.4S
    SHA256H2  Q25, Q30, V22.4S
    SHA256H2  Q3, Q24, V25.4S
    SHA1P  Q28, S22, V20.4S
    SHA1C  Q22, S4, V6.4S
    SHA256SU0  V29.4S, V2.4S
    SHA1C  Q2, S31, V0.4S
    SHA256H2  Q24, Q25, V15.4S
    SHA1M  Q27, S8, V3.4S
    SHA1SU1  V4.4S, V14.4S
    SHA1P  Q23, S18, V20.4S
    SHA256H  Q14, Q27, V23.4S
    SHA256H2  Q27, Q26, V11.4S
    SHA256H2  Q6, Q28, V13.4S
    SHA256H2  Q13, Q10, V4.4S
    SHA256H  Q30, Q26, V19.4S
    SHA1SU1  V31.4S, V13.4S
    SHA1SU0  V11.4S, V31.4S, V27.4S
    SHA256H  Q3, Q2, V6.4S
    SHA1M  Q6, S30, V3.4S
    SHA1M  Q3, S24, V14.4S
    SHA256SU1  V0.4S, V29.4S, V11.4S
    SHA256SU0  V23.4S, V22.4S
    SHA1M  Q26, S6, V6.4S
    SHA1M  Q18, S3, V10.4S
    SHA1P  Q28, S18, V18.4S
    SHA1P  Q17, S28, V28.4S
    SHA1C  Q31, S23, V17.4S
    SHA256SU0  V10.4S, V31.4S
    SHA256SU0  V25.4S, V26.4S
    SHA1P  Q27, S10, V25.4S
    SHA1SU0  V24.4S, V27.4S, V0.4S
    SHA1SU0  V3.4S, V16.4S, V11.4S
    SHA1C  Q15, S10, V0.4S
    SHA1SU1  V27.4S, V6.4S
    SHA1P  Q6, S11, V19.4S
    SHA1SU1  V2.4S, V31.4S
    SHA256H  Q17, Q16, V24.4S
    SHA256SU0  V14.4S, V4.4S
    SHA1P  Q31, S26, V8.4S
    SHA256SU0  V18.4S, V5.4S
    SHA1M  Q8, S27, V15.4S
    SHA256H2  Q11, Q3, V14.4S
    SHA1SU1  V28.4S, V31.4S
    SHA256H  Q3, Q28, V11.4S
    SHA1C  Q15, S27, V18.4S
    SHA1M  Q10, S8, V6.4S
    SHA256SU1  V23.4S, V17.4S, V2.4S
    SHA256H2  Q8, Q3, V10.4S
    SHA1P  Q28, S18, V8.4S
    SHA256H  Q16, Q15, V28.4S
    SHA256H2  Q14, Q23, V16.4S
    SHA256SU0  V4.4S, V17.4S
    SHA1P  Q25, S24, V20.4S
    SHA256H2  Q0, Q15, V18.4S
    SHA1SU1  V8.4S, V8.4S
    SHA1C  Q20, S24, V8.4S
    SHA1SU1  V28.4S, V22.4S
    SHA256SU1  V11.4S, V23.4S, V18.4S
    SHA1C  Q18, S31, V13.4S
    SHA256H2  Q16, Q3, V30.4S
    SHA1SU1  V8.4S, V16.4S
    SHA256SU1  V5.4S, V25.4S, V14.4S
    SHA256H  Q10, Q20, V4.4S
    SHA256H  Q19, Q5, V18.4S
    SHA256H  Q18, Q29, V11.4S
    SHA256SU1  V6.4S, V0.4S, V0.4S
    SHA256SU0  V16.4S, V28.4S
    SHA1P  Q24, S8, V8.4S
    SHA1C  Q15, S24, V24.4S
    SHA1M  Q22, S14, V15.4S
    SHA1M  Q4, S10, V22.4S
    SHA1SU0  V17.4S, V4.4S, V6.4S
    SHA256SU1  V10.4S, V19.4S, V19.4S
    SHA1SU1  V31.4S, V10.4S
    SHA256H2  Q0, Q31, V17.4S
    SHA1P  Q25, S16, V0.4S
    SHA256SU1  V10.4S, V18.4S, V18.4S
    SHA1SU0  V15.4S, V10.4S, V10.4S
    SHA1P  Q10, S25, V15.4S
    SHA1C  Q6, S22, V27.4S
    SHA1C  Q14, S0, V1.4S
    SHA1P  Q15, S29, V3.4S
    SHA1SU0  V30.4S, V18.4S, V13.4S
    SHA1C  Q18, S0, V9.4S
    SHA1SU1  V9.4S, V27.4S
    SHA1M  Q8, S23, V29.4S
    SHA1C  Q25, S13, V24.4S
    SHA256H2  Q16, Q9, V28.4S
    SHA1P  Q3, S19, V30.4S
    SHA256H2  Q31, Q18, V3.4S
    SHA256SU0  V22.4S, V25.4S
    SHA1P  Q4, S6, V15.4S
    SHA1SU1  V28.4S, V13.4S
    SHA1M  Q9, S10, V5.4S
    SHA1P  Q29, S31, V8.4S
    SHA256SU0  V24.4S, V22.4S
    SHA1SU0  V27.4S, V9.4S, V14.4S
    SHA256H  Q31, Q10, V27.4S
    SHA1SU0  V10.4S, V31.4S, V20.4S
    SHA1C  Q8, S10, V10.4S
    SHA256H2  Q17, Q29, V16.4S
    SHA1P  Q0, S24, V4.4S
    SHA256SU1  V1.4S, V0.4S, V28.4S
    SHA1SU0  V20.4S, V8.4S, V8.4S
    SHA1P  Q15, S17, V20.4S
    SHA256H  Q10, Q1, V15.4S
    SHA256SU0  V23.4S, V16.4S
    SHA1SU1  V27.4S, V6.4S
    SHA1C  Q17, S22, V11.4S
    SHA1M  Q19, S30, V7.4S
    SHA1C  Q9, S23, V12.4S
    SHA1P  Q3, S25, V14.4S
    SHA1M  Q13, S26, V17.4S
    SHA256H2  Q31, Q2, V19.4S
    SHA256SU0  V4.4S, V30.4S
    SHA1C  Q5, S21, V0.4S
    SHA256H2  Q6, Q12, V8.4S
    SHA1SU1  V16.4S, V31.4S
    SHA1P  Q1, S9, V13.4S
    SHA1SU1  V20.4S, V4.4S
    SHA256H  Q4, Q6, V3.4S
    SHA1C  Q15, S20, V2.4S
    SHA1M  Q23, S10, V4.4S
    SHA256H2  Q28, Q5, V1.4S
    SHA1P  Q11, S27, V16.4S
    SHA1SU1  V27.4S, V15.4S
    SHA256SU1  V6.4S, V2.4S, V23.4S
    SHA1P  Q23, S28, V28.4S
    SHA256SU0  V28.4S, V23.4S
    SHA256H  Q4, Q6, V28.4S
    SHA1C  Q5, S27, V24.4S
    SHA1SU1  V7.4S, V4.4S
    SHA1C  Q4, S11, V11.4S
    SHA1P  Q26, S7, V19.4S
    SHA1SU1  V22.4S, V4.4S
    SHA256H  Q4, Q22, V5.4S
    SHA256H  Q27, Q26, V26.4S
    SHA1P  Q9, S4, V4.4S
    SHA1SU0  V23.4S, V9.4S, V27.4S
    SHA256SU0  V10.4S, V19.4S
    SHA1C  Q4, S14, V23.4S
    SHA1P  Q14, S11, V29.4S
    SHA1SU0  V1.4S, V22.4S, V12.4S
    SHA1SU1  V7.4S, V4.4S
    SHA1P  Q31, S22, V20.4S
    SHA256H  Q11, Q24, V11.4S
    SHA256H2  Q23, Q7, V5.4S
    SHA256H2  Q5, Q29, V3.4S
    SHA256H2  Q29, Q0, V20.4S
    SHA256H2  Q26, Q14, V11.4S
    SHA256SU0  V28.4S, V18.4S
    SHA256SU1  V7.4S, V3.4S, V28.4S
    SHA256H  Q19, Q25, V17.4S
    SHA1C  Q20, S19, V5.4S
    SHA1P  Q24, S18, V29.4S
    SHA256SU0  V19.4S, V31.4S
    SHA256H2  Q27, Q19, V26.4S
    SHA256H2  Q19, Q24, V27.4S
    SHA256H2  Q31, Q7, V20.4S
    SHA1P  Q0, S19, V10.4S
    SHA1P  Q19, S23, V31.4S
    SHA256H2  Q27, Q19, V0.4S
    SHA1C  Q10, S27, V27.4S
    SHA256SU0  V20.4S, V10.4S
    SHA256SU1  V3.4S, V20.4S, V20.4S
    SHA1P  Q4, S3, V3.4S
    SHA1SU1  V26.4S, V1.4S
    SHA1SU0  V23.4S, V26.4S, V4.4S
    SHA1M  Q5, S30, V17.4S
    SHA1C  Q7, S26, V21.4S
    SHA1SU0  V1.4S, V7.4S, V8.4S
    SHA256SU1  V8.4S, V1.4S, V23.4S
    SHA1SU0  V17.4S, V15.4S, V6.4S
    SHA256H  Q24, Q21, V30.4S
    SHA1C  Q28, S21, V12.4S
    SHA256H  Q1, Q13, V16.4S
    SHA256SU1  V27.4S, V3.4S, V30.4S
    SHA1SU0  V3.4S, V9.4S, V19.4S
    SHA256H  Q30, Q23, V4.4S
    SHA1C  Q12, S1, V27.4S
    SHA256SU1  V4.4S, V12.4S, V12.4S
    SHA256H2  Q7, Q4, V4.4S
    SHA256SU1  V10.4S, V8.4S, V5.4S
    SHA256H  Q4, Q7, V15.4S
    SHA256H  Q6, Q4, V20.4S
    SHA1SU1  V16.4S, V2.4S
    SHA1P  Q2, S17, V16.4S
    SHA1C  Q16, S28, V5.4S
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_0
    MOVZ  X25, #0x1adc, LSL #0
    MOVK  X25, #0x6965, LSL #16
    MOVK  X25, #0xc352, LSL #32
    MOVK  X25, #0xcac9, LSL #48
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x39f1, LSL #0
    MOVK  X25, #0x434a, LSL #16
    MOVK  X25, #0xc56, LSL #32
    MOVK  X25, #0xf8f9, LSL #48
    SUB  X8, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xada1, LSL #0
    MOVK  X25, #0xc7f2, LSL #16
    MOVK  X25, #0x9416, LSL #32
    MOVK  X25, #0xb8a, LSL #48
    SUB  X8, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x5a1e, LSL #0
    MOVK  X25, #0x937f, LSL #16
    MOVK  X25, #0x4317, LSL #32
    MOVK  X25, #0xbb15, LSL #48
    SUB  X8, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x2439, LSL #0
    MOVK  X25, #0x676f, LSL #16
    MOVK  X25, #0x24e4, LSL #32
    MOVK  X25, #0xbf3d, LSL #48
    SUB  X8, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x6ed5, LSL #0
    MOVK  X25, #0xd8b0, LSL #16
    MOVK  X25, #0xa95, LSL #32
    MOVK  X25, #0xacaf, LSL #48
    SUB  X8, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x63a9, LSL #0
    MOVK  X25, #0xf5fb, LSL #16
    MOVK  X25, #0x82ed, LSL #32
    MOVK  X25, #0x4cca, LSL #48
    SUB  X8, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xdd46, LSL #0
    MOVK  X25, #0x48d2, LSL #16
    MOVK  X25, #0x7b54, LSL #32
    MOVK  X25, #0x95de, LSL #48
    SUB  X8, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x3176, LSL #0
    MOVK  X25, #0x882d, LSL #16
    MOVK  X25, #0x7854, LSL #32
    MOVK  X25, #0xc1ae, LSL #48
    SUB  X8, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x7db5, LSL #0
    MOVK  X25, #0xc021, LSL #16
    MOVK  X25, #0x6787, LSL #32
    MOVK  X25, #0x175c, LSL #48
    SUB  X8, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xad87, LSL #0
    MOVK  X25, #0x6c56, LSL #16
    MOVK  X25, #0xafd9, LSL #32
    MOVK  X25, #0xffe8, LSL #48
    SUB  X8, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xddac, LSL #0
    MOVK  X25, #0x1e98, LSL #16
    MOVK  X25, #0x4e65, LSL #32
    MOVK  X25, #0x2fc6, LSL #48
    SUB  X8, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x0, LSL #0
    SUB  X8, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xf86c, LSL #0
    MOVK  X25, #0x9684, LSL #16
    MOVK  X25, #0xb49d, LSL #32
    MOVK  X25, #0xc9cb, LSL #48
    SUB  X8, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xb88, LSL #0
    MOVK  X25, #0x4d36, LSL #16
    MOVK  X25, #0x89f1, LSL #32
    MOVK  X25, #0xead1, LSL #48
    SUB  X8, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xa96d, LSL #0
    MOVK  X25, #0xa9f4, LSL #16
    MOVK  X25, #0x4450, LSL #32
    MOVK  X25, #0x7dc0, LSL #48
    SUB  X8, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xff25, LSL #0
    MOVK  X25, #0x6105, LSL #16
    MOVK  X25, #0x172, LSL #32
    MOVK  X25, #0xf3d1, LSL #48
    SUB  X8, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x6c6e, LSL #0
    MOVK  X25, #0x3dd2, LSL #16
    MOVK  X25, #0xbc6f, LSL #32
    MOVK  X25, #0xefa7, LSL #48
    SUB  X8, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x8411, LSL #0
    MOVK  X25, #0xad9c, LSL #16
    MOVK  X25, #0x97e4, LSL #32
    MOVK  X25, #0xb19d, LSL #48
    SUB  X8, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xfb63, LSL #0
    MOVK  X25, #0xad1e, LSL #16
    MOVK  X25, #0xd3ed, LSL #32
    MOVK  X25, #0x1c07, LSL #48
    SUB  X8, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x7c08, LSL #0
    MOVK  X25, #0x9d49, LSL #16
    MOVK  X25, #0xcfa6, LSL #32
    MOVK  X25, #0x6d55, LSL #48
    SUB  X8, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xcf21, LSL #0
    MOVK  X25, #0xcdf3, LSL #16
    MOVK  X25, #0xbaad, LSL #32
    MOVK  X25, #0xb255, LSL #48
    FMOV  X8, V0.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x2e65, LSL #0
    MOVK  X25, #0x9d86, LSL #16
    MOVK  X25, #0x7cfd, LSL #32
    MOVK  X25, #0x9c68, LSL #48
    FMOV  X8, D0
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xd2bf, LSL #0
    MOVK  X25, #0x79ab, LSL #16
    MOVK  X25, #0xc91, LSL #32
    MOVK  X25, #0x51bc, LSL #48
    FMOV  X8, V1.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xfcd8, LSL #0
    MOVK  X25, #0xc260, LSL #16
    MOVK  X25, #0x8f24, LSL #32
    MOVK  X25, #0xb1e9, LSL #48
    FMOV  X8, D1
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x5414, LSL #0
    MOVK  X25, #0x6799, LSL #16
    MOVK  X25, #0x407f, LSL #32
    MOVK  X25, #0xc2ff, LSL #48
    FMOV  X8, V2.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x2153, LSL #0
    MOVK  X25, #0x5a61, LSL #16
    MOVK  X25, #0xb6d4, LSL #32
    MOVK  X25, #0x1552, LSL #48
    FMOV  X8, D2
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xf6b9, LSL #0
    MOVK  X25, #0x34a9, LSL #16
    MOVK  X25, #0x7375, LSL #32
    MOVK  X25, #0x167b, LSL #48
    FMOV  X8, V3.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x3a94, LSL #0
    MOVK  X25, #0x860d, LSL #16
    MOVK  X25, #0x1c33, LSL #32
    MOVK  X25, #0x840c, LSL #48
    FMOV  X8, D3
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xa6bb, LSL #0
    MOVK  X25, #0x1f5e, LSL #16
    MOVK  X25, #0x32e0, LSL #32
    MOVK  X25, #0xb87d, LSL #48
    FMOV  X8, V4.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xa51b, LSL #0
    MOVK  X25, #0x5774, LSL #16
    MOVK  X25, #0xe5f3, LSL #32
    MOVK  X25, #0xf8ac, LSL #48
    FMOV  X8, D4
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x316b, LSL #0
    MOVK  X25, #0x9fa4, LSL #16
    MOVK  X25, #0xacfb, LSL #32
    MOVK  X25, #0x3d5, LSL #48
    FMOV  X8, V5.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x5e4e, LSL #0
    MOVK  X25, #0x8dd3, LSL #16
    MOVK  X25, #0x874d, LSL #32
    MOVK  X25, #0xa659, LSL #48
    FMOV  X8, D5
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x4b44, LSL #0
    MOVK  X25, #0x8272, LSL #16
    MOVK  X25, #0xef72, LSL #32
    MOVK  X25, #0x99b3, LSL #48
    FMOV  X8, V6.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x894d, LSL #0
    MOVK  X25, #0x1575, LSL #16
    MOVK  X25, #0x3785, LSL #32
    MOVK  X25, #0x63d8, LSL #48
    FMOV  X8, D6
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xd29e, LSL #0
    MOVK  X25, #0x1657, LSL #16
    MOVK  X25, #0x8ac3, LSL #32
    MOVK  X25, #0xfd58, LSL #48
    FMOV  X8, V7.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xa9f0, LSL #0
    MOVK  X25, #0x57ef, LSL #16
    MOVK  X25, #0x627a, LSL #32
    MOVK  X25, #0x7edd, LSL #48
    FMOV  X8, D7
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x26e4, LSL #0
    MOVK  X25, #0xa892, LSL #16
    MOVK  X25, #0x74bb, LSL #32
    MOVK  X25, #0x7f9a, LSL #48
    FMOV  X8, V8.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xb8d4, LSL #0
    MOVK  X25, #0x970b, LSL #16
    MOVK  X25, #0x8fd4, LSL #32
    MOVK  X25, #0x1d2d, LSL #48
    FMOV  X8, D8
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xc2e4, LSL #0
    MOVK  X25, #0x9074, LSL #16
    MOVK  X25, #0x5414, LSL #32
    MOVK  X25, #0xa4d3, LSL #48
    FMOV  X8, V9.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xda3c, LSL #0
    MOVK  X25, #0x73ac, LSL #16
    MOVK  X25, #0x7dbe, LSL #32
    MOVK  X25, #0xeb69, LSL #48
    FMOV  X8, D9
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x9437, LSL #0
    MOVK  X25, #0x8427, LSL #16
    MOVK  X25, #0xd6e1, LSL #32
    MOVK  X25, #0x6ed8, LSL #48
    FMOV  X8, V10.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xafdd, LSL #0
    MOVK  X25, #0x3cd6, LSL #16
    MOVK  X25, #0x744d, LSL #32
    MOVK  X25, #0xbb4d, LSL #48
    FMOV  X8, D10
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xf79d, LSL #0
    MOVK  X25, #0x747b, LSL #16
    MOVK  X25, #0x7727, LSL #32
    MOVK  X25, #0x7439, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x42fe, LSL #0
    MOVK  X25, #0xaaef, LSL #16
    MOVK  X25, #0xf259, LSL #32
    MOVK  X25, #0xd73e, LSL #48
    FMOV  X8, D11
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xd46f, LSL #0
    MOVK  X25, #0xc946, LSL #16
    MOVK  X25, #0x3fde, LSL #32
    MOVK  X25, #0xb083, LSL #48
    FMOV  X8, V12.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xe3c2, LSL #0
    MOVK  X25, #0x789, LSL #16
    MOVK  X25, #0xaf24, LSL #32
    MOVK  X25, #0x74d4, LSL #48
    FMOV  X8, D12
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x5ad5, LSL #0
    MOVK  X25, #0xfe18, LSL #16
    MOVK  X25, #0xa039, LSL #32
    MOVK  X25, #0x2926, LSL #48
    FMOV  X8, V13.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x974d, LSL #0
    MOVK  X25, #0x1004, LSL #16
    MOVK  X25, #0x9986, LSL #32
    MOVK  X25, #0x40f0, LSL #48
    FMOV  X8, D13
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xa109, LSL #0
    MOVK  X25, #0x3b86, LSL #16
    MOVK  X25, #0xe7fb, LSL #32
    MOVK  X25, #0xb8bf, LSL #48
    FMOV  X8, V14.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xa684, LSL #0
    MOVK  X25, #0x754b, LSL #16
    MOVK  X25, #0xe7d6, LSL #32
    MOVK  X25, #0x638a, LSL #48
    FMOV  X8, D14
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xd3e6, LSL #0
    MOVK  X25, #0x4c3, LSL #16
    MOVK  X25, #0xdf9, LSL #32
    MOVK  X25, #0xe1a0, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x2940, LSL #0
    MOVK  X25, #0x5e80, LSL #16
    MOVK  X25, #0x51b, LSL #32
    MOVK  X25, #0xe314, LSL #48
    FMOV  X8, D15
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xc122, LSL #0
    MOVK  X25, #0x5c81, LSL #16
    MOVK  X25, #0xcc91, LSL #32
    MOVK  X25, #0x34a1, LSL #48
    FMOV  X8, V16.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x1c03, LSL #0
    MOVK  X25, #0xf7c7, LSL #16
    MOVK  X25, #0x4202, LSL #32
    MOVK  X25, #0x4770, LSL #48
    FMOV  X8, D16
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xfa8e, LSL #0
    MOVK  X25, #0x2177, LSL #16
    MOVK  X25, #0xa63d, LSL #32
    MOVK  X25, #0x3b79, LSL #48
    FMOV  X8, V17.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x4506, LSL #0
    MOVK  X25, #0xa288, LSL #16
    MOVK  X25, #0x65ae, LSL #32
    MOVK  X25, #0x3b3, LSL #48
    FMOV  X8, D17
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x4ac5, LSL #0
    MOVK  X25, #0xb0, LSL #16
    MOVK  X25, #0x25c1, LSL #32
    MOVK  X25, #0xaeed, LSL #48
    FMOV  X8, V18.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x69b1, LSL #0
    MOVK  X25, #0xc3a8, LSL #16
    MOVK  X25, #0x7093, LSL #32
    MOVK  X25, #0x5dd3, LSL #48
    FMOV  X8, D18
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x457c, LSL #0
    MOVK  X25, #0x1b5b, LSL #16
    MOVK  X25, #0x3195, LSL #32
    MOVK  X25, #0xf070, LSL #48
    FMOV  X8, V19.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x3b01, LSL #0
    MOVK  X25, #0xa5d8, LSL #16
    MOVK  X25, #0x795a, LSL #32
    MOVK  X25, #0x4cb6, LSL #48
    FMOV  X8, D19
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x5826, LSL #0
    MOVK  X25, #0x76c8, LSL #16
    MOVK  X25, #0xd36f, LSL #32
    MOVK  X25, #0xeb1f, LSL #48
    FMOV  X8, V20.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x6dce, LSL #0
    MOVK  X25, #0x8c46, LSL #16
    MOVK  X25, #0xe328, LSL #32
    MOVK  X25, #0x16c8, LSL #48
    FMOV  X8, D20
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xf86c, LSL #0
    MOVK  X25, #0x9684, LSL #16
    MOVK  X25, #0xb49d, LSL #32
    MOVK  X25, #0xc9cb, LSL #48
    FMOV  X8, V21.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x8411, LSL #0
    MOVK  X25, #0xad9c, LSL #16
    MOVK  X25, #0x97e4, LSL #32
    MOVK  X25, #0xb19d, LSL #48
    FMOV  X8, D21
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x49ea, LSL #0
    MOVK  X25, #0x7471, LSL #16
    MOVK  X25, #0xcb38, LSL #32
    MOVK  X25, #0x1a56, LSL #48
    FMOV  X8, V22.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xf0bd, LSL #0
    MOVK  X25, #0xb3c8, LSL #16
    MOVK  X25, #0xafdd, LSL #32
    MOVK  X25, #0xe577, LSL #48
    FMOV  X8, D22
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xd6ce, LSL #0
    MOVK  X25, #0xa5ee, LSL #16
    MOVK  X25, #0xd989, LSL #32
    MOVK  X25, #0x7724, LSL #48
    FMOV  X8, V23.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x4291, LSL #0
    MOVK  X25, #0x8148, LSL #16
    MOVK  X25, #0x3590, LSL #32
    MOVK  X25, #0x69b1, LSL #48
    FMOV  X8, D23
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x7fd2, LSL #0
    MOVK  X25, #0x9d2e, LSL #16
    MOVK  X25, #0xcae4, LSL #32
    MOVK  X25, #0x233a, LSL #48
    FMOV  X8, V24.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xa884, LSL #0
    MOVK  X25, #0xd783, LSL #16
    MOVK  X25, #0x7906, LSL #32
    MOVK  X25, #0xd78a, LSL #48
    FMOV  X8, D24
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x473e, LSL #0
    MOVK  X25, #0x507c, LSL #16
    MOVK  X25, #0x8531, LSL #32
    MOVK  X25, #0xe65, LSL #48
    FMOV  X8, V25.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x7e50, LSL #0
    MOVK  X25, #0x6d6b, LSL #16
    MOVK  X25, #0xe9bb, LSL #32
    MOVK  X25, #0x876e, LSL #48
    FMOV  X8, D25
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x4cf2, LSL #0
    MOVK  X25, #0x6fe9, LSL #16
    MOVK  X25, #0x9c5c, LSL #32
    MOVK  X25, #0xdcad, LSL #48
    FMOV  X8, V26.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x1edc, LSL #0
    MOVK  X25, #0x6ed, LSL #16
    MOVK  X25, #0x7a1c, LSL #32
    MOVK  X25, #0x39ec, LSL #48
    FMOV  X8, D26
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xda7f, LSL #0
    MOVK  X25, #0xbea1, LSL #16
    MOVK  X25, #0xfb6, LSL #32
    MOVK  X25, #0x34e4, LSL #48
    FMOV  X8, V27.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x176f, LSL #0
    MOVK  X25, #0x82b1, LSL #16
    MOVK  X25, #0xc051, LSL #32
    MOVK  X25, #0xa61f, LSL #48
    FMOV  X8, D27
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x2cc2, LSL #0
    MOVK  X25, #0x840f, LSL #16
    MOVK  X25, #0x8b43, LSL #32
    MOVK  X25, #0x2fd4, LSL #48
    FMOV  X8, V28.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xc77e, LSL #0
    MOVK  X25, #0x991c, LSL #16
    MOVK  X25, #0xd42c, LSL #32
    MOVK  X25, #0xdbd8, LSL #48
    FMOV  X8, D28
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x5939, LSL #0
    MOVK  X25, #0x98ab, LSL #16
    MOVK  X25, #0xe635, LSL #32
    MOVK  X25, #0xcac9, LSL #48
    FMOV  X8, V29.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xdf45, LSL #0
    MOVK  X25, #0x552b, LSL #16
    MOVK  X25, #0xf3d8, LSL #32
    MOVK  X25, #0xd030, LSL #48
    FMOV  X8, D29
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x2527, LSL #0
    MOVK  X25, #0x5bd4, LSL #16
    MOVK  X25, #0x6218, LSL #32
    MOVK  X25, #0xf910, LSL #48
    FMOV  X8, V30.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xc713, LSL #0
    MOVK  X25, #0x45f, LSL #16
    MOVK  X25, #0x47e3, LSL #32
    MOVK  X25, #0xa8b6, LSL #48
    FMOV  X8, D30
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0x7368, LSL #0
    MOVK  X25, #0xa5c5, LSL #16
    MOVK  X25, #0xb03e, LSL #32
    MOVK  X25, #0xf9a5, LSL #48
    FMOV  X8, V31.D[1]
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X25, #0xe25, LSL #0
    MOVK  X25, #0xea0f, LSL #16
    MOVK  X25, #0xd4bb, LSL #32
    MOVK  X25, #0xe115, LSL #48
    FMOV  X8, D31
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X27
    FMOV  V0.D[1], X12
    FMOV  D1, X15
    FMOV  V1.D[1], X11
    FMOV  D2, X2
    FMOV  V2.D[1], X29
    FMOV  D3, X28
    FMOV  V3.D[1], X16
    FMOV  D4, X25
    FMOV  V4.D[1], X17
    FMOV  D5, X18
    FMOV  V5.D[1], X10
    FMOV  D6, X22
    FMOV  V6.D[1], X21
    FMOV  D7, X24
    FMOV  V7.D[1], X21
    FMOV  D8, X14
    FMOV  V8.D[1], X15
    FMOV  D9, X24
    FMOV  V9.D[1], X21
    FMOV  D10, X20
    FMOV  V10.D[1], X6
    FMOV  D11, X16
    FMOV  V11.D[1], X8
    FMOV  D12, X8
    FMOV  V12.D[1], X19
    FMOV  D13, X28
    FMOV  V13.D[1], X16
    FMOV  D14, X24
    FMOV  V14.D[1], X6
    FMOV  D15, X19
    FMOV  V15.D[1], X5
    FMOV  D16, X18
    FMOV  V16.D[1], X8
    FMOV  D17, X6
    FMOV  V17.D[1], X19
    FMOV  D18, X21
    FMOV  V18.D[1], X3
    FMOV  D19, X13
    FMOV  V19.D[1], X13
    FMOV  D20, X15
    FMOV  V20.D[1], X2
    FMOV  D21, X9
    FMOV  V21.D[1], X28
    FMOV  D22, X12
    FMOV  V22.D[1], X14
    FMOV  D23, X22
    FMOV  V23.D[1], X14
    FMOV  D24, X13
    FMOV  V24.D[1], X18
    FMOV  D25, X15
    FMOV  V25.D[1], X17
    FMOV  D26, X17
    FMOV  V26.D[1], X16
    FMOV  D27, X3
    FMOV  V27.D[1], X2
    FMOV  D28, X3
    FMOV  V28.D[1], X25
    FMOV  D29, X24
    FMOV  V29.D[1], X20
    FMOV  D30, X27
    FMOV  V30.D[1], X13
    FMOV  D31, X9
    FMOV  V31.D[1], X2
    MOVZ  X8, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_1:
    SHA1M  Q21, S22, V19.4S
    SHA1C  Q2, S21, V21.4S
    SHA1P  Q2, S24, V26.4S
    SHA256H  Q28, Q30, V25.4S
    SHA1SU0  V8.4S, V31.4S, V31.4S
    SHA1SU1  V18.4S, V8.4S
    SHA256H  Q26, Q2, V27.4S
    SHA256H2  Q9, Q28, V29.4S
    SHA1C  Q31, S9, V9.4S
    SHA1C  Q9, S31, V31.4S
    SHA1M  Q10, S23, V9.4S
    SHA1M  Q8, S10, V26.4S
    SHA1C  Q10, S18, V18.4S
    SHA1SU1  V31.4S, V10.4S
    SHA256H  Q9, Q31, V18.4S
    SHA256SU0  V2.4S, V9.4S
    SHA1C  Q23, S19, V2.4S
    SHA256SU0  V29.4S, V23.4S
    SHA256SU1  V22.4S, V29.4S, V29.4S
    SHA1SU1  V21.4S, V8.4S
    SHA1SU0  V23.4S, V22.4S, V21.4S
    SHA1M  Q22, S14, V2.4S
    SHA256SU0  V26.4S, V7.4S
    SHA1P  Q27, S25, V28.4S
    SHA1P  Q31, S29, V23.4S
    SHA256H2  Q24, Q15, V27.4S
    SHA256H  Q27, Q2, V23.4S
    SHA1SU1  V25.4S, V26.4S
    SHA256SU0  V2.4S, V6.4S
    SHA1SU0  V14.4S, V21.4S, V20.4S
    SHA256SU1  V29.4S, V10.4S, V20.4S
    SHA256H  Q8, Q29, V14.4S
    SHA1M  Q18, S10, V29.4S
    SHA256H  Q7, Q27, V8.4S
    SHA256SU0  V28.4S, V22.4S
    SHA256SU1  V19.4S, V8.4S, V10.4S
    SHA256SU0  V6.4S, V24.4S
    SHA1P  Q9, S17, V21.4S
    SHA256H  Q15, Q18, V18.4S
    SHA1M  Q23, S31, V25.4S
    SHA256H  Q21, Q7, V9.4S
    SHA256H2  Q8, Q28, V2.4S
    SHA256H2  Q17, Q23, V19.4S
    SHA1P  Q14, S16, V6.4S
    SHA256SU0  V20.4S, V14.4S
    SHA1SU0  V17.4S, V20.4S, V20.4S
    SHA1SU0  V10.4S, V17.4S, V15.4S
    SHA256H2  Q7, Q23, V21.4S
    SHA1M  Q14, S7, V10.4S
    SHA256SU1  V23.4S, V14.4S, V14.4S
    SHA256H  Q22, Q8, V23.4S
    SHA256SU0  V31.4S, V27.4S
    SHA1SU0  V21.4S, V4.4S, V19.4S
    SHA256SU1  V6.4S, V8.4S, V24.4S
    SHA256SU1  V15.4S, V7.4S, V29.4S
    SHA1SU0  V10.4S, V14.4S, V20.4S
    SHA1C  Q14, S7, V10.4S
    SHA1SU1  V8.4S, V3.4S
    SHA1SU0  V4.4S, V6.4S, V10.4S
    SHA1SU1  V17.4S, V4.4S
    SHA1SU0  V2.4S, V23.4S, V26.4S
    SHA256H2  Q29, Q26, V26.4S
    SHA1P  Q7, S21, V21.4S
    SHA1C  Q27, S14, V15.4S
    SHA1SU1  V23.4S, V31.4S
    SHA256H  Q10, Q22, V29.4S
    SHA1C  Q14, S17, V8.4S
    SHA256H  Q24, Q2, V29.4S
    SHA1P  Q2, S24, V31.4S
    SHA256SU1  V4.4S, V14.4S, V14.4S
    SHA256SU0  V22.4S, V4.4S
    SHA1C  Q21, S10, V22.4S
    SHA256H2  Q16, Q18, V26.4S
    SHA1M  Q15, S2, V27.4S
    SHA1C  Q19, S2, V23.4S
    SHA256H2  Q3, Q15, V19.4S
    SHA256H2  Q4, Q7, V7.4S
    SHA1SU0  V6.4S, V4.4S, V4.4S
    SHA256H2  Q26, Q21, V3.4S
    SHA1C  Q27, S26, V16.4S
    SHA256SU0  V26.4S, V27.4S
    SHA1SU0  V17.4S, V26.4S, V26.4S
    SHA256SU0  V14.4S, V17.4S
    SHA1SU0  V17.4S, V14.4S, V6.4S
    SHA1C  Q6, S3, V27.4S
    SHA1C  Q21, S8, V11.4S
    SHA1SU1  V18.4S, V30.4S
    SHA256SU1  V22.4S, V5.4S, V21.4S
    SHA256H2  Q16, Q11, V7.4S
    SHA256SU1  V4.4S, V14.4S, V24.4S
    SHA256SU0  V26.4S, V31.4S
    SHA256H2  Q29, Q2, V8.4S
    SHA256SU0  V11.4S, V27.4S
    SHA256SU1  V30.4S, V29.4S, V17.4S
    SHA256SU1  V3.4S, V18.4S, V6.4S
    SHA256H2  Q8, Q22, V4.4S
    SHA1SU1  V17.4S, V16.4S
    SHA1SU0  V6.4S, V26.4S, V8.4S
    SHA1M  Q5, S12, V6.4S
    SHA256H  Q31, Q5, V11.4S
    SHA1C  Q27, S18, V30.4S
    SHA256SU0  V21.4S, V31.4S
    SHA1M  Q18, S3, V27.4S
    SHA1SU0  V2.4S, V17.4S, V21.4S
    SHA256H2  Q17, Q18, V18.4S
    SHA1SU0  V24.4S, V2.4S, V2.4S
    SHA256H  Q27, Q17, V17.4S
    SHA256H2  Q3, Q24, V27.4S
    SHA1SU1  V29.4S, V8.4S
    SHA1SU1  V27.4S, V13.4S
    SHA256SU0  V11.4S, V22.4S
    SHA1SU0  V16.4S, V1.4S, V14.4S
    SHA1C  Q24, S3, V30.4S
    SHA256H  Q22, Q22, V18.4S
    SHA256SU0  V14.4S, V25.4S
    SHA256SU1  V26.4S, V4.4S, V29.4S
    SHA1M  Q12, S12, V2.4S
    SHA1SU1  V2.4S, V31.4S
    SHA1M  Q21, S16, V27.4S
    SHA256SU1  V5.4S, V21.4S, V21.4S
    SHA1C  Q13, S22, V11.4S
    SHA1P  Q8, S14, V24.4S
    SHA1SU0  V3.4S, V13.4S, V8.4S
    SHA256SU0  V17.4S, V3.4S
    SHA1C  Q16, S17, V26.4S
    SHA1C  Q25, S5, V5.4S
    SHA256SU0  V6.4S, V25.4S
    SHA1SU0  V18.4S, V12.4S, V2.4S
    SHA1P  Q17, S16, V16.4S
    SHA1P  Q16, S6, V6.4S
    SHA1M  Q3, S16, V16.4S
    SHA1C  Q6, S18, V3.4S
    SHA1SU0  V26.4S, V26.4S, V17.4S
    SHA256SU1  V17.4S, V26.4S, V26.4S
    SHA256SU1  V24.4S, V6.4S, V17.4S
    SHA256SU0  V14.4S, V18.4S
    SHA256H  Q16, Q27, V26.4S
    SHA256SU0  V29.4S, V22.4S
    SHA256SU0  V6.4S, V24.4S
    SHA1P  Q17, S2, V12.4S
    SHA256SU0  V12.4S, V4.4S
    SHA1P  Q3, S25, V18.4S
    SHA1C  Q5, S20, V16.4S
    SHA256H  Q25, Q9, V16.4S
    SHA1C  Q16, S12, V25.4S
    SHA1SU1  V26.4S, V5.4S
    SHA256H2  Q27, Q9, V15.4S
    SHA1P  Q18, S29, V14.4S
    SHA1M  Q22, S31, V21.4S
    SHA256SU1  V21.4S, V18.4S, V30.4S
    SHA1P  Q20, S20, V8.4S
    SHA256H2  Q8, Q6, V3.4S
    SHA1SU0  V4.4S, V17.4S, V21.4S
    SHA256SU1  V31.4S, V3.4S, V13.4S
    SHA256SU1  V30.4S, V8.4S, V13.4S
    SHA256SU0  V18.4S, V10.4S
    SHA1SU1  V9.4S, V22.4S
    SHA256H2  Q24, Q16, V9.4S
    SHA1M  Q25, S24, V18.4S
    SHA1P  Q2, S4, V26.4S
    SHA1SU0  V24.4S, V2.4S, V25.4S
    SHA1SU0  V14.4S, V27.4S, V24.4S
    SHA1SU1  V29.4S, V20.4S
    SHA1M  Q20, S31, V31.4S
    SHA1SU1  V4.4S, V1.4S
    SHA1P  Q13, S4, V30.4S
    SHA256SU1  V6.4S, V14.4S, V14.4S
    SHA256SU1  V8.4S, V20.4S, V29.4S
    SHA1C  Q27, S13, V13.4S
    SHA1SU1  V17.4S, V6.4S
    SHA1M  Q12, S27, V8.4S
    SHA1M  Q1, S17, V17.4S
    SHA1P  Q22, S1, V1.4S
    SHA256H2  Q8, Q12, V22.4S
    SHA256SU1  V2.4S, V31.4S, V22.4S
    SHA256H  Q4, Q17, V3.4S
    SHA1M  Q15, S31, V27.4S
    SHA1SU1  V24.4S, V27.4S
    SHA1SU1  V17.4S, V18.4S
    SHA1P  Q22, S8, V14.4S
    SHA256SU1  V8.4S, V25.4S, V2.4S
    SHA256SU0  V1.4S, V2.4S
    SHA1SU0  V3.4S, V21.4S, V6.4S
    SHA256SU0  V20.4S, V9.4S
    SHA256H2  Q27, Q12, V1.4S
    SHA1P  Q29, S27, V20.4S
    SHA256SU1  V21.4S, V3.4S, V8.4S
    SHA1SU0  V2.4S, V29.4S, V29.4S
    SHA1C  Q30, S22, V2.4S
    SHA256SU1  V8.4S, V21.4S, V4.4S
    SHA1M  Q1, S31, V17.4S
    SHA1P  Q12, S30, V1.4S
    SHA1C  Q9, S8, V12.4S
    SHA256H  Q22, Q15, V15.4S
    SHA1C  Q27, S24, V6.4S
    SHA256H2  Q20, Q27, V22.4S
    SHA1P  Q25, S9, V20.4S
    SHA1SU1  V17.4S, V15.4S
    SHA1M  Q29, S12, V9.4S
    SHA1C  Q20, S20, V21.4S
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_1
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X24, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D0
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D1
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D2
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D3
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D4
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D5
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D6
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D7
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D8
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D9
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D10
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D11
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D12
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D13
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D14
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D15
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D16
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D17
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D18
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D19
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D20
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D22
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D23
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D24
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D25
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D26
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D27
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D28
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D29
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D30
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X5
    FMOV  D3, X16
    FMOV  V3.D[1], X19
    FMOV  D4, X9
    FMOV  V4.D[1], X20
    FMOV  D5, X5
    FMOV  V5.D[1], X18
    FMOV  D6, X22
    FMOV  V6.D[1], X12
    FMOV  D7, X28
    FMOV  V7.D[1], X21
    FMOV  D8, X6
    FMOV  V8.D[1], X6
    FMOV  D9, X8
    FMOV  V9.D[1], X9
    FMOV  D10, X20
    FMOV  V10.D[1], X19
    FMOV  D11, X17
    FMOV  V11.D[1], X28
    FMOV  D12, X10
    FMOV  V12.D[1], X25
    FMOV  D13, X17
    FMOV  V13.D[1], X15
    FMOV  D14, X11
    FMOV  V14.D[1], X14
    FMOV  D15, X24
    FMOV  V15.D[1], X8
    FMOV  D16, X24
    FMOV  V16.D[1], X2
    FMOV  D17, X21
    FMOV  V17.D[1], X22
    FMOV  D18, X17
    FMOV  V18.D[1], X24
    FMOV  D19, X27
    FMOV  V19.D[1], X16
    FMOV  D20, X28
    FMOV  V20.D[1], X25
    FMOV  D21, X15
    FMOV  V21.D[1], X19
    FMOV  D22, X3
    FMOV  V22.D[1], X15
    FMOV  D23, X22
    FMOV  V23.D[1], X22
    FMOV  D24, X3
    FMOV  V24.D[1], X14
    FMOV  D25, X16
    FMOV  V25.D[1], X29
    FMOV  D26, X6
    FMOV  V26.D[1], X3
    FMOV  D27, X27
    FMOV  V27.D[1], X14
    FMOV  D28, X12
    FMOV  V28.D[1], X16
    FMOV  D29, X27
    FMOV  V29.D[1], X21
    FMOV  D30, X19
    FMOV  V30.D[1], X19
    FMOV  D31, X9
    FMOV  V31.D[1], X6
    MOVZ  X9, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_2:
    SHA1SU1  V20.4S, V22.4S
    SHA1M  Q20, S30, V26.4S
    SHA1C  Q29, S24, V20.4S
    SHA1SU1  V6.4S, V28.4S
    SHA1SU1  V9.4S, V6.4S
    SHA256H2  Q24, Q27, V25.4S
    SHA256H  Q12, Q31, V31.4S
    SHA256SU1  V11.4S, V29.4S, V12.4S
    SHA256H2  Q17, Q9, V11.4S
    SHA1P  Q25, S24, V24.4S
    SHA256H2  Q23, Q25, V25.4S
    SHA1SU0  V5.4S, V15.4S, V17.4S
    SHA1P  Q22, S5, V5.4S
    SHA1C  Q15, S19, V22.4S
    SHA1P  Q30, S23, V15.4S
    SHA1SU0  V27.4S, V16.4S, V13.4S
    SHA1SU0  V19.4S, V6.4S, V26.4S
    SHA1M  Q15, S18, V17.4S
    SHA1SU1  V11.4S, V17.4S
    SHA1M  Q6, S7, V27.4S
    SHA1SU1  V26.4S, V28.4S
    SHA256SU0  V18.4S, V11.4S
    SHA256SU0  V9.4S, V29.4S
    SHA1SU0  V27.4S, V18.4S, V30.4S
    SHA256SU1  V23.4S, V14.4S, V0.4S
    SHA1C  Q24, S22, V1.4S
    SHA1P  Q14, S24, V24.4S
    SHA1M  Q29, S24, V10.4S
    SHA1SU1  V20.4S, V29.4S
    SHA256H2  Q28, Q26, V6.4S
    SHA1M  Q13, S20, V14.4S
    SHA1SU0  V24.4S, V12.4S, V15.4S
    SHA1C  Q0, S0, V19.4S
    SHA1SU0  V25.4S, V9.4S, V13.4S
    SHA256H  Q11, Q24, V28.4S
    SHA256H  Q16, Q11, V11.4S
    SHA256H2  Q14, Q25, V16.4S
    SHA256H  Q6, Q27, V14.4S
    SHA256SU0  V29.4S, V0.4S
    SHA1SU0  V16.4S, V2.4S, V23.4S
    SHA1C  Q20, S6, V6.4S
    SHA1C  Q18, S20, V12.4S
    SHA256H  Q26, Q29, V30.4S
    SHA1C  Q22, S26, V14.4S
    SHA1M  Q12, S18, V22.4S
    SHA256H2  Q23, Q12, V12.4S
    SHA1C  Q6, S23, V23.4S
    SHA256H2  Q24, Q16, V16.4S
    SHA1SU1  V22.4S, V6.4S
    SHA1C  Q20, S22, V21.4S
    SHA256H  Q28, Q30, V20.4S
    SHA1SU0  V15.4S, V21.4S, V28.4S
    SHA256SU1  V25.4S, V15.4S, V24.4S
    SHA1C  Q6, S11, V25.4S
    SHA256H2  Q26, Q8, V24.4S
    SHA1P  Q23, S12, V25.4S
    SHA256H  Q19, Q20, V7.4S
    SHA256SU1  V18.4S, V5.4S, V20.4S
    SHA1M  Q0, S7, V11.4S
    SHA256H2  Q14, Q14, V7.4S
    SHA1SU0  V15.4S, V1.4S, V11.4S
    SHA1P  Q7, S0, V12.4S
    SHA1M  Q30, S31, V16.4S
    SHA1SU0  V22.4S, V14.4S, V26.4S
    SHA1SU1  V14.4S, V22.4S
    SHA256SU1  V8.4S, V17.4S, V18.4S
    SHA1SU0  V22.4S, V30.4S, V7.4S
    SHA1SU1  V0.4S, V23.4S
    SHA1P  Q18, S19, V8.4S
    SHA1M  Q2, S22, V14.4S
    SHA256SU1  V21.4S, V6.4S, V15.4S
    SHA1P  Q11, S18, V21.4S
    SHA1SU0  V21.4S, V0.4S, V0.4S
    SHA1M  Q8, S2, V21.4S
    SHA1M  Q28, S24, V8.4S
    SHA1SU0  V15.4S, V28.4S, V19.4S
    SHA1M  Q7, S11, V15.4S
    SHA256SU1  V5.4S, V14.4S, V2.4S
    SHA1SU1  V25.4S, V19.4S
    SHA1SU1  V26.4S, V29.4S
    SHA1C  Q21, S6, V24.4S
    SHA1SU0  V15.4S, V28.4S, V8.4S
    SHA1M  Q14, S23, V4.4S
    SHA256SU1  V11.4S, V0.4S, V0.4S
    SHA1P  Q0, S13, V19.4S
    SHA256H  Q8, Q7, V25.4S
    SHA1P  Q18, S22, V8.4S
    SHA1SU0  V13.4S, V15.4S, V18.4S
    SHA1SU0  V1.4S, V23.4S, V13.4S
    SHA256H  Q24, Q11, V5.4S
    SHA1P  Q15, S0, V1.4S
    SHA256SU1  V2.4S, V14.4S, V14.4S
    SHA1SU1  V31.4S, V15.4S
    SHA256SU1  V15.4S, V21.4S, V27.4S
    SHA1M  Q13, S15, V31.4S
    SHA1SU1  V11.4S, V10.4S
    SHA256SU1  V23.4S, V13.4S, V24.4S
    SHA1M  Q18, S2, V2.4S
    SHA256H2  Q28, Q26, V11.4S
    SHA1P  Q10, S18, V23.4S
    SHA1SU0  V5.4S, V10.4S, V10.4S
    SHA256SU0  V7.4S, V28.4S
    SHA256H  Q19, Q7, V5.4S
    SHA256H2  Q1, Q20, V1.4S
    SHA256H2  Q14, Q28, V21.4S
    SHA256H  Q18, Q4, V8.4S
    SHA1P  Q0, S26, V14.4S
    SHA1SU0  V6.4S, V17.4S, V9.4S
    SHA256H2  Q27, Q21, V23.4S
    SHA256H2  Q26, Q24, V28.4S
    SHA1M  Q8, S17, V26.4S
    SHA1M  Q14, S13, V7.4S
    SHA1SU0  V15.4S, V26.4S, V7.4S
    SHA1P  Q17, S8, V18.4S
    SHA256SU1  V2.4S, V14.4S, V17.4S
    SHA1M  Q4, S6, V0.4S
    SHA1C  Q26, S19, V19.4S
    SHA1SU1  V31.4S, V27.4S
    SHA1C  Q15, S2, V2.4S
    SHA256H2  Q27, Q26, V15.4S
    SHA1SU0  V11.4S, V1.4S, V1.4S
    SHA1SU1  V9.4S, V27.4S
    SHA1SU0  V28.4S, V9.4S, V4.4S
    SHA256H  Q20, Q28, V28.4S
    SHA256H  Q1, Q11, V31.4S
    SHA256H2  Q7, Q28, V20.4S
    SHA1SU0  V27.4S, V1.4S, V1.4S
    SHA256SU0  V31.4S, V7.4S
    SHA256SU0  V8.4S, V27.4S
    SHA1SU1  V18.4S, V8.4S
    SHA256SU1  V27.4S, V31.4S, V31.4S
    SHA1SU0  V17.4S, V27.4S, V27.4S
    SHA1P  Q7, S18, V6.4S
    SHA256H2  Q8, Q31, V17.4S
    SHA1M  Q24, S8, V8.4S
    SHA1M  Q21, S20, V7.4S
    SHA256SU1  V23.4S, V21.4S, V24.4S
    SHA1M  Q31, S29, V23.4S
    SHA256H  Q1, Q19, V31.4S
    SHA1SU1  V6.4S, V10.4S
    SHA256SU1  V19.4S, V23.4S, V16.4S
    SHA256SU1  V29.4S, V20.4S, V8.4S
    SHA1M  Q9, S31, V10.4S
    SHA256H2  Q18, Q29, V29.4S
    SHA1SU1  V27.4S, V6.4S
    SHA1SU1  V8.4S, V14.4S
    SHA256H2  Q21, Q9, V31.4S
    SHA256SU1  V31.4S, V23.4S, V23.4S
    SHA256SU1  V24.4S, V29.4S, V17.4S
    SHA1P  Q7, S26, V31.4S
    SHA1M  Q23, S21, V16.4S
    SHA256H  Q26, Q3, V10.4S
    SHA1SU0  V10.4S, V8.4S, V17.4S
    SHA1P  Q14, S1, V7.4S
    SHA1SU0  V7.4S, V24.4S, V27.4S
    SHA256H2  Q9, Q14, V7.4S
    SHA1SU1  V6.4S, V18.4S
    SHA1M  Q27, S19, V23.4S
    SHA1P  Q17, S27, V26.4S
    SHA256SU0  V29.4S, V17.4S
    SHA1M  Q31, S9, V9.4S
    SHA1SU1  V24.4S, V10.4S
    SHA1SU1  V21.4S, V24.4S
    SHA256SU1  V26.4S, V21.4S, V29.4S
    SHA1SU0  V3.4S, V27.4S, V6.4S
    SHA1M  Q27, S26, V26.4S
    SHA1SU0  V1.4S, V27.4S, V27.4S
    SHA256SU1  V16.4S, V31.4S, V1.4S
    SHA1P  Q14, S3, V16.4S
    SHA1P  Q27, S10, V27.4S
    SHA1SU0  V18.4S, V26.4S, V8.4S
    SHA256SU0  V21.4S, V30.4S
    SHA1M  Q8, S27, V10.4S
    SHA1SU1  V19.4S, V27.4S
    SHA256SU0  V1.4S, V0.4S
    SHA256H2  Q31, Q30, V11.4S
    SHA1SU0  V26.4S, V18.4S, V8.4S
    SHA256H2  Q9, Q11, V5.4S
    SHA1C  Q17, S1, V3.4S
    SHA256H  Q18, Q8, V1.4S
    SHA1P  Q5, S8, V8.4S
    SHA1SU0  V11.4S, V31.4S, V21.4S
    SHA1SU0  V24.4S, V17.4S, V26.4S
    SHA256H2  Q3, Q19, V19.4S
    SHA1SU0  V26.4S, V9.4S, V11.4S
    SHA256H2  Q10, Q24, V14.4S
    SHA256H2  Q30, Q5, V18.4S
    SHA1M  Q18, S26, V30.4S
    SHA1SU1  V16.4S, V14.4S
    SHA1P  Q1, S18, V10.4S
    SHA256SU0  V27.4S, V1.4S
    SHA1C  Q21, S16, V3.4S
    SHA1SU1  V29.4S, V12.4S
    SHA1P  Q10, S29, V21.4S
    SHA1M  Q6, S10, V21.4S
    SHA1SU1  V1.4S, V27.4S
    SHA256SU1  V14.4S, V6.4S, V6.4S
    SHA1P  Q11, S1, V14.4S
    SHA1SU0  V1.4S, V4.4S, V12.4S
    SHA256H  Q26, Q13, V22.4S
    SUBS  X9, X9, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_2
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xffff, LSL #0
    MOVK  X27, #0xffff, LSL #16
    MOVK  X27, #0xffff, LSL #32
    MOVK  X27, #0xffff, LSL #48
    SUB  X29, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X29, FPSR
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x10a, LSL #0
    MOVK  X27, #0x8b9c, LSL #16
    MOVK  X27, #0x9796, LSL #32
    MOVK  X27, #0xc683, LSL #48
    FMOV  X29, V0.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xecb4, LSL #0
    MOVK  X27, #0x8783, LSL #16
    MOVK  X27, #0x3079, LSL #32
    MOVK  X27, #0x271, LSL #48
    FMOV  X29, D0
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xe52d, LSL #0
    MOVK  X27, #0xb9a3, LSL #16
    MOVK  X27, #0xe543, LSL #32
    MOVK  X27, #0x662c, LSL #48
    FMOV  X29, V1.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x6af, LSL #0
    MOVK  X27, #0xaeda, LSL #16
    MOVK  X27, #0xaa38, LSL #32
    MOVK  X27, #0x39d0, LSL #48
    FMOV  X29, D1
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xebeb, LSL #0
    MOVK  X27, #0xe1c3, LSL #16
    MOVK  X27, #0x9eff, LSL #32
    MOVK  X27, #0xc54a, LSL #48
    FMOV  X29, V2.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x5cd8, LSL #0
    MOVK  X27, #0x74a5, LSL #16
    MOVK  X27, #0x2183, LSL #32
    MOVK  X27, #0x514c, LSL #48
    FMOV  X29, D2
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x8ae6, LSL #0
    MOVK  X27, #0xd8ca, LSL #16
    MOVK  X27, #0xb0da, LSL #32
    MOVK  X27, #0x4660, LSL #48
    FMOV  X29, V3.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x3ef2, LSL #0
    MOVK  X27, #0x88cb, LSL #16
    MOVK  X27, #0x19dd, LSL #32
    MOVK  X27, #0x7db6, LSL #48
    FMOV  X29, D3
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xa547, LSL #0
    MOVK  X27, #0x519c, LSL #16
    MOVK  X27, #0xc9c2, LSL #32
    MOVK  X27, #0x43ca, LSL #48
    FMOV  X29, V4.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x4089, LSL #0
    MOVK  X27, #0xac, LSL #16
    MOVK  X27, #0xeea7, LSL #32
    MOVK  X27, #0x7138, LSL #48
    FMOV  X29, D4
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xefee, LSL #0
    MOVK  X27, #0x5e51, LSL #16
    MOVK  X27, #0xb420, LSL #32
    MOVK  X27, #0x8c94, LSL #48
    FMOV  X29, V5.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x24b5, LSL #0
    MOVK  X27, #0x86d, LSL #16
    MOVK  X27, #0x5521, LSL #32
    MOVK  X27, #0x97b2, LSL #48
    FMOV  X29, D5
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf160, LSL #0
    MOVK  X27, #0x4074, LSL #16
    MOVK  X27, #0x745c, LSL #32
    MOVK  X27, #0x5c2, LSL #48
    FMOV  X29, V6.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x3e1a, LSL #0
    MOVK  X27, #0xedc4, LSL #16
    MOVK  X27, #0x2d28, LSL #32
    MOVK  X27, #0xe137, LSL #48
    FMOV  X29, D6
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x1f07, LSL #0
    MOVK  X27, #0x19b, LSL #16
    MOVK  X27, #0xeb79, LSL #32
    MOVK  X27, #0x86a6, LSL #48
    FMOV  X29, V7.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xaeaa, LSL #0
    MOVK  X27, #0xc706, LSL #16
    MOVK  X27, #0xa0b6, LSL #32
    MOVK  X27, #0x9023, LSL #48
    FMOV  X29, D7
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x596e, LSL #0
    MOVK  X27, #0xc235, LSL #16
    MOVK  X27, #0x4d28, LSL #32
    MOVK  X27, #0x7e7d, LSL #48
    FMOV  X29, V8.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x958f, LSL #0
    MOVK  X27, #0xc999, LSL #16
    MOVK  X27, #0x7944, LSL #32
    MOVK  X27, #0xbb70, LSL #48
    FMOV  X29, D8
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x8aed, LSL #0
    MOVK  X27, #0xef74, LSL #16
    MOVK  X27, #0x40c9, LSL #32
    MOVK  X27, #0x6b94, LSL #48
    FMOV  X29, V9.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x332f, LSL #0
    MOVK  X27, #0xdcd0, LSL #16
    MOVK  X27, #0x6c5d, LSL #32
    MOVK  X27, #0x2b3f, LSL #48
    FMOV  X29, D9
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x480, LSL #0
    MOVK  X27, #0xa100, LSL #16
    MOVK  X27, #0x7735, LSL #32
    MOVK  X27, #0x11ab, LSL #48
    FMOV  X29, V10.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x80cd, LSL #0
    MOVK  X27, #0x527e, LSL #16
    MOVK  X27, #0x1948, LSL #32
    MOVK  X27, #0xb9c1, LSL #48
    FMOV  X29, D10
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x4385, LSL #0
    MOVK  X27, #0x18bb, LSL #16
    MOVK  X27, #0xd3f4, LSL #32
    MOVK  X27, #0xe767, LSL #48
    FMOV  X29, V11.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x6b36, LSL #0
    MOVK  X27, #0x97a5, LSL #16
    MOVK  X27, #0x11ab, LSL #32
    MOVK  X27, #0x6228, LSL #48
    FMOV  X29, D11
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x690e, LSL #0
    MOVK  X27, #0x68f1, LSL #16
    MOVK  X27, #0x1d27, LSL #32
    MOVK  X27, #0x5102, LSL #48
    FMOV  X29, V12.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x707, LSL #0
    MOVK  X27, #0xc0ca, LSL #16
    MOVK  X27, #0x5441, LSL #32
    MOVK  X27, #0x85fb, LSL #48
    FMOV  X29, D12
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xde4c, LSL #0
    MOVK  X27, #0x79f8, LSL #16
    MOVK  X27, #0xdeca, LSL #32
    MOVK  X27, #0xf36f, LSL #48
    FMOV  X29, V13.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf931, LSL #0
    MOVK  X27, #0xb1f3, LSL #16
    MOVK  X27, #0x46ca, LSL #32
    MOVK  X27, #0x1622, LSL #48
    FMOV  X29, D13
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x91fb, LSL #0
    MOVK  X27, #0xd7b8, LSL #16
    MOVK  X27, #0x9822, LSL #32
    MOVK  X27, #0x7d56, LSL #48
    FMOV  X29, V14.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x9c05, LSL #0
    MOVK  X27, #0x6dc2, LSL #16
    MOVK  X27, #0x726, LSL #32
    MOVK  X27, #0x8ffa, LSL #48
    FMOV  X29, D14
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xa9cf, LSL #0
    MOVK  X27, #0x9476, LSL #16
    MOVK  X27, #0x64b1, LSL #32
    MOVK  X27, #0x47cd, LSL #48
    FMOV  X29, V15.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x41bc, LSL #0
    MOVK  X27, #0x54a2, LSL #16
    MOVK  X27, #0xf00, LSL #32
    MOVK  X27, #0x5c45, LSL #48
    FMOV  X29, D15
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x5ecb, LSL #0
    MOVK  X27, #0xb2a4, LSL #16
    MOVK  X27, #0xf3d8, LSL #32
    MOVK  X27, #0x5b00, LSL #48
    FMOV  X29, V16.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x3117, LSL #0
    MOVK  X27, #0x456a, LSL #16
    MOVK  X27, #0xeed0, LSL #32
    MOVK  X27, #0xe210, LSL #48
    FMOV  X29, D16
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xe72c, LSL #0
    MOVK  X27, #0x5f7, LSL #16
    MOVK  X27, #0x2c58, LSL #32
    MOVK  X27, #0xbf11, LSL #48
    FMOV  X29, V17.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf39, LSL #0
    MOVK  X27, #0x5b7a, LSL #16
    MOVK  X27, #0x6d32, LSL #32
    MOVK  X27, #0x322f, LSL #48
    FMOV  X29, D17
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x54fc, LSL #0
    MOVK  X27, #0x11c1, LSL #16
    MOVK  X27, #0x5478, LSL #32
    MOVK  X27, #0xa77c, LSL #48
    FMOV  X29, V18.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xd906, LSL #0
    MOVK  X27, #0x9695, LSL #16
    MOVK  X27, #0xbdb5, LSL #32
    MOVK  X27, #0x3e94, LSL #48
    FMOV  X29, D18
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x7f74, LSL #0
    MOVK  X27, #0x60bf, LSL #16
    MOVK  X27, #0x2e28, LSL #32
    MOVK  X27, #0x2c01, LSL #48
    FMOV  X29, V19.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x6b7e, LSL #0
    MOVK  X27, #0x9343, LSL #16
    MOVK  X27, #0xcc79, LSL #32
    MOVK  X27, #0x2121, LSL #48
    FMOV  X29, D19
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x81cc, LSL #0
    MOVK  X27, #0x14ab, LSL #16
    MOVK  X27, #0x1a81, LSL #32
    MOVK  X27, #0x1d04, LSL #48
    FMOV  X29, V20.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x8a3d, LSL #0
    MOVK  X27, #0x5fa, LSL #16
    MOVK  X27, #0x942b, LSL #32
    MOVK  X27, #0x79fd, LSL #48
    FMOV  X29, D20
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x8582, LSL #0
    MOVK  X27, #0x7980, LSL #16
    MOVK  X27, #0xc401, LSL #32
    MOVK  X27, #0xa808, LSL #48
    FMOV  X29, V21.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xa77d, LSL #0
    MOVK  X27, #0x23b2, LSL #16
    MOVK  X27, #0x70ed, LSL #32
    MOVK  X27, #0xbdc3, LSL #48
    FMOV  X29, D21
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xb053, LSL #0
    MOVK  X27, #0x754b, LSL #16
    MOVK  X27, #0x4817, LSL #32
    MOVK  X27, #0xe3c2, LSL #48
    FMOV  X29, V22.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xb123, LSL #0
    MOVK  X27, #0x699, LSL #16
    MOVK  X27, #0x8d4e, LSL #32
    MOVK  X27, #0xf4d0, LSL #48
    FMOV  X29, D22
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x444a, LSL #0
    MOVK  X27, #0x3e3c, LSL #16
    MOVK  X27, #0x8eed, LSL #32
    MOVK  X27, #0x3443, LSL #48
    FMOV  X29, V23.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x9bb0, LSL #0
    MOVK  X27, #0xcea9, LSL #16
    MOVK  X27, #0x7733, LSL #32
    MOVK  X27, #0xeab4, LSL #48
    FMOV  X29, D23
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xea6e, LSL #0
    MOVK  X27, #0x24d1, LSL #16
    MOVK  X27, #0xcd12, LSL #32
    MOVK  X27, #0x75a0, LSL #48
    FMOV  X29, V24.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xc2ca, LSL #0
    MOVK  X27, #0x119d, LSL #16
    MOVK  X27, #0x371f, LSL #32
    MOVK  X27, #0x14c8, LSL #48
    FMOV  X29, D24
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xc4f5, LSL #0
    MOVK  X27, #0xe3af, LSL #16
    MOVK  X27, #0xb68f, LSL #32
    MOVK  X27, #0x2add, LSL #48
    FMOV  X29, V25.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xed10, LSL #0
    MOVK  X27, #0xc413, LSL #16
    MOVK  X27, #0xb2d6, LSL #32
    MOVK  X27, #0x6dc5, LSL #48
    FMOV  X29, D25
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x2bc3, LSL #0
    MOVK  X27, #0x8555, LSL #16
    MOVK  X27, #0xcc61, LSL #32
    MOVK  X27, #0x7066, LSL #48
    FMOV  X29, V26.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x8051, LSL #0
    MOVK  X27, #0xbe5b, LSL #16
    MOVK  X27, #0x519d, LSL #32
    MOVK  X27, #0x1706, LSL #48
    FMOV  X29, D26
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x464f, LSL #0
    MOVK  X27, #0x274c, LSL #16
    MOVK  X27, #0x7faa, LSL #32
    MOVK  X27, #0x46e0, LSL #48
    FMOV  X29, V27.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x5c95, LSL #0
    MOVK  X27, #0x848a, LSL #16
    MOVK  X27, #0x32, LSL #32
    MOVK  X27, #0x840, LSL #48
    FMOV  X29, D27
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x7ce9, LSL #0
    MOVK  X27, #0xb6c5, LSL #16
    MOVK  X27, #0x36d3, LSL #32
    MOVK  X27, #0x49f3, LSL #48
    FMOV  X29, V28.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x9d1d, LSL #0
    MOVK  X27, #0xce5d, LSL #16
    MOVK  X27, #0xa99a, LSL #32
    MOVK  X27, #0x9491, LSL #48
    FMOV  X29, D28
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x2dd9, LSL #0
    MOVK  X27, #0xba3, LSL #16
    MOVK  X27, #0xe934, LSL #32
    MOVK  X27, #0x1f8f, LSL #48
    FMOV  X29, V29.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xfb45, LSL #0
    MOVK  X27, #0xe163, LSL #16
    MOVK  X27, #0xec52, LSL #32
    MOVK  X27, #0xc1af, LSL #48
    FMOV  X29, D29
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x824c, LSL #0
    MOVK  X27, #0x53c, LSL #16
    MOVK  X27, #0xfba7, LSL #32
    MOVK  X27, #0x7a9, LSL #48
    FMOV  X29, V30.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf777, LSL #0
    MOVK  X27, #0x2074, LSL #16
    MOVK  X27, #0x41b8, LSL #32
    MOVK  X27, #0x21f9, LSL #48
    FMOV  X29, D30
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xee57, LSL #0
    MOVK  X27, #0x10fc, LSL #16
    MOVK  X27, #0x407e, LSL #32
    MOVK  X27, #0xdeb6, LSL #48
    FMOV  X29, V31.D[1]
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x3fce, LSL #0
    MOVK  X27, #0xd473, LSL #16
    MOVK  X27, #0xc60d, LSL #32
    MOVK  X27, #0xec09, LSL #48
    FMOV  X29, D31
    SUB  X19, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x8fcb, LSL #0
    MOVK  X2, #0xc5c0, LSL #16
    MOVK  X2, #0x7040, LSL #32
    MOVK  X2, #0x3b70, LSL #48
    MOVZ  X3, #0x1714, LSL #0
    MOVK  X3, #0x2030, LSL #16
    MOVK  X3, #0xaf, LSL #32
    MOVK  X3, #0xcd95, LSL #48
    MOVZ  X5, #0xd2d2, LSL #0
    MOVK  X5, #0x7a5c, LSL #16
    MOVK  X5, #0x7fae, LSL #32
    MOVK  X5, #0xcdb0, LSL #48
    MOVZ  X6, #0x8a7d, LSL #0
    MOVK  X6, #0xd34, LSL #16
    MOVK  X6, #0x682, LSL #32
    MOVK  X6, #0x250b, LSL #48
    MOVZ  X8, #0x8e1d, LSL #0
    MOVK  X8, #0xe02, LSL #16
    MOVK  X8, #0xe575, LSL #32
    MOVK  X8, #0xe160, LSL #48
    MOVZ  X9, #0xb580, LSL #0
    MOVK  X9, #0xb4fc, LSL #16
    MOVK  X9, #0xb345, LSL #32
    MOVK  X9, #0xe495, LSL #48
    MOVZ  X10, #0x7454, LSL #0
    MOVK  X10, #0x4466, LSL #16
    MOVK  X10, #0x96bb, LSL #32
    MOVK  X10, #0x19d0, LSL #48
    MOVZ  X11, #0x98fc, LSL #0
    MOVK  X11, #0x2485, LSL #16
    MOVK  X11, #0x837f, LSL #32
    MOVK  X11, #0xe5c9, LSL #48
    MOVZ  X12, #0x94ee, LSL #0
    MOVK  X12, #0x7d74, LSL #16
    MOVK  X12, #0xc657, LSL #32
    MOVK  X12, #0x5768, LSL #48
    MOVZ  X13, #0xe463, LSL #0
    MOVK  X13, #0x16a2, LSL #16
    MOVK  X13, #0xf4ea, LSL #32
    MOVK  X13, #0xb97e, LSL #48
    MOVZ  X14, #0xa4e, LSL #0
    MOVK  X14, #0x964b, LSL #16
    MOVK  X14, #0x4664, LSL #32
    MOVK  X14, #0x2c0e, LSL #48
    MOVZ  X15, #0xbb93, LSL #0
    MOVK  X15, #0x8317, LSL #16
    MOVK  X15, #0x675b, LSL #32
    MOVK  X15, #0xa209, LSL #48
    MOVZ  X16, #0x7cd8, LSL #0
    MOVK  X16, #0xa914, LSL #16
    MOVK  X16, #0xf0fb, LSL #32
    MOVK  X16, #0x50b6, LSL #48
    MOVZ  X17, #0xc350, LSL #0
    MOVK  X17, #0x1644, LSL #16
    MOVK  X17, #0x8413, LSL #32
    MOVK  X17, #0x88d9, LSL #48
    MOVZ  X18, #0xfc78, LSL #0
    MOVK  X18, #0xff44, LSL #16
    MOVK  X18, #0x60d0, LSL #32
    MOVK  X18, #0xf917, LSL #48
    MOVZ  X19, #0xf9f2, LSL #0
    MOVK  X19, #0x138a, LSL #16
    MOVK  X19, #0x4136, LSL #32
    MOVK  X19, #0x3b8f, LSL #48
    MOVZ  X20, #0x88ea, LSL #0
    MOVK  X20, #0xf66b, LSL #16
    MOVK  X20, #0xb2b5, LSL #32
    MOVK  X20, #0x36c3, LSL #48
    MOVZ  X21, #0xe984, LSL #0
    MOVK  X21, #0x7fa2, LSL #16
    MOVK  X21, #0xdc5b, LSL #32
    MOVK  X21, #0x8bf3, LSL #48
    MOVZ  X22, #0xa90d, LSL #0
    MOVK  X22, #0x9028, LSL #16
    MOVK  X22, #0x27e8, LSL #32
    MOVK  X22, #0xf344, LSL #48
    MOVZ  X24, #0x9759, LSL #0
    MOVK  X24, #0x6a5b, LSL #16
    MOVK  X24, #0x5dc7, LSL #32
    MOVK  X24, #0x91bf, LSL #48
    MOVZ  X25, #0xc837, LSL #0
    MOVK  X25, #0x79e2, LSL #16
    MOVK  X25, #0xbb08, LSL #32
    MOVK  X25, #0x273f, LSL #48
    MOVZ  X27, #0x4224, LSL #0
    MOVK  X27, #0x5a46, LSL #16
    MOVK  X27, #0x2472, LSL #32
    MOVK  X27, #0xcafe, LSL #48
    MOVZ  X28, #0xfe68, LSL #0
    MOVK  X28, #0xd355, LSL #16
    MOVK  X28, #0xa022, LSL #32
    MOVK  X28, #0x66a4, LSL #48
    MOVZ  X29, #0x8426, LSL #0
    MOVK  X29, #0x597f, LSL #16
    MOVK  X29, #0xe86a, LSL #32
    MOVK  X29, #0x77a0, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X24
    FMOV  D2, X22
    FMOV  V2.D[1], X27
    FMOV  D3, X11
    FMOV  V3.D[1], X22
    FMOV  D4, X18
    FMOV  V4.D[1], X3
    FMOV  D5, X11
    FMOV  V5.D[1], X28
    FMOV  D6, X29
    FMOV  V6.D[1], X19
    FMOV  D7, X19
    FMOV  V7.D[1], X15
    FMOV  D8, X6
    FMOV  V8.D[1], X6
    FMOV  D9, X6
    FMOV  V9.D[1], X29
    FMOV  D10, X24
    FMOV  V10.D[1], X14
    FMOV  D11, X3
    FMOV  V11.D[1], X12
    FMOV  D12, X21
    FMOV  V12.D[1], X9
    FMOV  D13, X14
    FMOV  V13.D[1], X5
    FMOV  D14, X25
    FMOV  V14.D[1], X22
    FMOV  D15, X9
    FMOV  V15.D[1], X3
    FMOV  D16, X8
    FMOV  V16.D[1], X27
    FMOV  D17, X2
    FMOV  V17.D[1], X22
    FMOV  D18, X15
    FMOV  V18.D[1], X19
    FMOV  D19, X14
    FMOV  V19.D[1], X6
    FMOV  D20, X3
    FMOV  V20.D[1], X2
    FMOV  D21, X18
    FMOV  V21.D[1], X29
    FMOV  D22, X2
    FMOV  V22.D[1], X22
    FMOV  D23, X10
    FMOV  V23.D[1], X18
    FMOV  D24, X15
    FMOV  V24.D[1], X14
    FMOV  D25, X3
    FMOV  V25.D[1], X13
    FMOV  D26, X29
    FMOV  V26.D[1], X17
    FMOV  D27, X5
    FMOV  V27.D[1], X28
    FMOV  D28, X13
    FMOV  V28.D[1], X29
    FMOV  D29, X2
    FMOV  V29.D[1], X16
    FMOV  D30, X3
    FMOV  V30.D[1], X17
    FMOV  D31, X29
    FMOV  V31.D[1], X3
    MOVZ  X6, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_3:
    SHA1M  Q26, S17, V22.4S
    SHA1M  Q5, S25, V30.4S
    SHA1P  Q1, S26, V31.4S
    SHA256H2  Q23, Q23, V5.4S
    SHA1SU0  V19.4S, V28.4S, V23.4S
    SHA256H  Q13, Q29, V29.4S
    SHA1C  Q15, S1, V27.4S
    SHA256H  Q30, Q19, V15.4S
    SHA1M  Q18, S30, V30.4S
    SHA256H2  Q26, Q13, V13.4S
    SHA256SU1  V6.4S, V26.4S, V18.4S
    SHA256H  Q17, Q6, V6.4S
    SHA1M  Q30, S24, V17.4S
    SHA1C  Q1, S20, V27.4S
    SHA1M  Q15, S29, V28.4S
    SHA256SU1  V27.4S, V31.4S, V27.4S
    SHA1P  Q5, S11, V27.4S
    SHA1M  Q27, S19, V12.4S
    SHA256SU0  V23.4S, V4.4S
    SHA256H2  Q24, Q23, V17.4S
    SHA256H  Q4, Q25, V18.4S
    SHA256H2  Q11, Q7, V22.4S
    SHA1M  Q16, S18, V1.4S
    SHA256H  Q7, Q14, V8.4S
    SHA1SU0  V22.4S, V27.4S, V16.4S
    SHA1C  Q20, S31, V7.4S
    SHA256SU0  V29.4S, V11.4S
    SHA1SU0  V6.4S, V22.4S, V29.4S
    SHA1M  Q13, S5, V20.4S
    SHA1SU1  V28.4S, V15.4S
    SHA256H  Q31, Q30, V28.4S
    SHA1SU0  V8.4S, V24.4S, V6.4S
    SHA1C  Q17, S8, V13.4S
    SHA1P  Q23, S4, V17.4S
    SHA1C  Q12, S31, V31.4S
    SHA1SU0  V8.4S, V23.4S, V12.4S
    SHA1SU0  V7.4S, V6.4S, V27.4S
    SHA256SU0  V18.4S, V2.4S
    SHA1P  Q6, S17, V3.4S
    SHA256SU0  V3.4S, V5.4S
    SHA256SU0  V27.4S, V14.4S
    SHA256H  Q4, Q7, V23.4S
    SHA1SU1  V30.4S, V22.4S
    SHA256SU1  V23.4S, V2.4S, V26.4S
    SHA1P  Q13, S8, V6.4S
    SHA1SU0  V24.4S, V9.4S, V9.4S
    SHA1P  Q2, S16, V28.4S
    SHA1SU0  V17.4S, V18.4S, V30.4S
    SHA1M  Q8, S24, V23.4S
    SHA1SU1  V15.4S, V13.4S
    SHA1C  Q22, S3, V3.4S
    SHA1M  Q14, S22, V27.4S
    SHA256SU1  V3.4S, V2.4S, V14.4S
    SHA1M  Q5, S15, V4.4S
    SHA1SU1  V24.4S, V17.4S
    SHA1SU1  V16.4S, V3.4S
    SHA256H  Q3, Q5, V5.4S
    SHA256H2  Q22, Q8, V3.4S
    SHA1C  Q4, S24, V22.4S
    SHA256SU0  V15.4S, V4.4S
    SHA256H  Q27, Q15, V16.4S
    SHA256H  Q16, Q8, V28.4S
    SHA1SU0  V4.4S, V16.4S, V29.4S
    SHA1M  Q31, S3, V28.4S
    SHA256SU0  V14.4S, V23.4S
    SHA1C  Q13, S27, V30.4S
    SHA256SU0  V17.4S, V2.4S
    SHA1P  Q5, S20, V26.4S
    SHA256H2  Q3, Q2, V29.4S
    SHA1SU1  V30.4S, V22.4S
    SHA256SU1  V16.4S, V28.4S, V18.4S
    SHA1SU0  V15.4S, V4.4S, V30.4S
    SHA256SU0  V27.4S, V31.4S
    SHA256SU0  V6.4S, V24.4S
    SHA1C  Q30, S13, V6.4S
    SHA1C  Q6, S15, V30.4S
    SHA256SU1  V31.4S, V6.4S, V6.4S
    SHA1P  Q23, S31, V16.4S
    SHA1P  Q2, S3, V3.4S
    SHA1M  Q3, S5, V5.4S
    SHA1P  Q8, S3, V27.4S
    SHA256SU0  V26.4S, V23.4S
    SHA1M  Q18, S17, V2.4S
    SHA256H2  Q30, Q8, V28.4S
    SHA256H  Q31, Q14, V30.4S
    SHA256SU0  V7.4S, V26.4S
    SHA256H2  Q4, Q18, V18.4S
    SHA1M  Q6, S7, V31.4S
    SHA1M  Q24, S4, V6.4S
    SHA256SU0  V17.4S, V5.4S
    SHA1SU1  V23.4S, V15.4S
    SHA1M  Q15, S6, V5.4S
    SHA1P  Q28, S17, V16.4S
    SHA256H  Q8, Q27, V0.4S
    SHA256H  Q4, Q0, V11.4S
    SHA1P  Q3, S0, V18.4S
    SHA1SU1  V0.4S, V13.4S
    SHA1C  Q2, S31, V28.4S
    SHA256H  Q13, Q19, V26.4S
    SHA256H  Q5, Q15, V15.4S
    SHA256H2  Q27, Q6, V23.4S
    SHA1P  Q17, S24, V8.4S
    SHA256H  Q28, Q17, V13.4S
    SHA1SU1  V13.4S, V0.4S
    SHA256H2  Q6, Q13, V27.4S
    SHA1SU0  V24.4S, V3.4S, V4.4S
    SHA256H  Q8, Q2, V24.4S
    SHA256SU0  V13.4S, V8.4S
    SHA1P  Q11, S5, V6.4S
    SHA1M  Q30, S13, V11.4S
    SHA1SU1  V23.4S, V30.4S
    SHA256H  Q0, Q23, V28.4S
    SHA1P  Q16, S15, V30.4S
    SHA1SU1  V2.4S, V10.4S
    SHA256H2  Q23, Q11, V28.4S
    SHA1C  Q3, S23, V15.4S
    SHA256SU0  V4.4S, V5.4S
    SHA256SU1  V10.4S, V15.4S, V11.4S
    SHA256H  Q19, Q28, V25.4S
    SHA1M  Q30, S10, V13.4S
    SHA256SU0  V26.4S, V11.4S
    SHA256H2  Q28, Q16, V4.4S
    SHA1P  Q27, S12, V30.4S
    SHA1M  Q13, S30, V21.4S
    SHA256H2  Q18, Q28, V9.4S
    SHA1C  Q30, S29, V14.4S
    SHA1P  Q5, S16, V18.4S
    SHA256SU0  V6.4S, V26.4S
    SHA256H2  Q26, Q19, V13.4S
    SHA256H2  Q15, Q3, V30.4S
    SHA256H2  Q12, Q0, V27.4S
    SHA1SU1  V13.4S, V2.4S
    SHA256SU1  V25.4S, V5.4S, V13.4S
    SHA1C  Q11, S25, V15.4S
    SHA256H2  Q25, Q12, V11.4S
    SHA1C  Q29, S25, V6.4S
    SHA256SU0  V24.4S, V26.4S
    SHA1C  Q0, S24, V29.4S
    SHA256SU1  V23.4S, V19.4S, V20.4S
    SHA1M  Q30, S18, V7.4S
    SHA256H2  Q25, Q22, V13.4S
    SHA256SU0  V13.4S, V3.4S
    SHA256SU1  V19.4S, V31.4S, V1.4S
    SHA1M  Q26, S25, V6.4S
    SHA256SU0  V27.4S, V11.4S
    SHA1SU1  V11.4S, V1.4S
    SHA1C  Q3, S13, V29.4S
    SHA1P  Q5, S4, V9.4S
    SHA1M  Q21, S3, V3.4S
    SHA1P  Q25, S5, V19.4S
    SHA1SU0  V1.4S, V25.4S, V30.4S
    SHA1SU0  V6.4S, V11.4S, V12.4S
    SHA256SU1  V16.4S, V0.4S, V0.4S
    SHA1C  Q13, S27, V23.4S
    SHA1SU1  V20.4S, V13.4S
    SHA256SU1  V4.4S, V21.4S, V26.4S
    SHA1P  Q29, S16, V6.4S
    SHA1C  Q15, S20, V29.4S
    SHA1SU0  V13.4S, V15.4S, V4.4S
    SHA256H  Q31, Q1, V1.4S
    SHA1SU1  V3.4S, V13.4S
    SHA256H2  Q4, Q3, V3.4S
    SHA1SU1  V6.4S, V31.4S
    SHA1SU0  V5.4S, V4.4S, V4.4S
    SHA256SU0  V0.4S, V5.4S
    SHA1SU0  V16.4S, V6.4S, V0.4S
    SHA1M  Q15, S24, V19.4S
    SHA256H  Q7, Q16, V16.4S
    SHA1SU1  V1.4S, V28.4S
    SHA1SU0  V16.4S, V18.4S, V23.4S
    SHA256SU1  V29.4S, V24.4S, V7.4S
    SHA1P  Q4, S18, V27.4S
    SHA256H  Q26, Q2, V9.4S
    SHA256H  Q3, Q11, V15.4S
    SHA1P  Q27, S27, V29.4S
    SHA256H  Q30, Q1, V7.4S
    SHA256H  Q31, Q28, V27.4S
    SHA1P  Q7, S5, V0.4S
    SHA256H2  Q13, Q22, V3.4S
    SHA1C  Q22, S26, V4.4S
    SHA1M  Q6, S30, V5.4S
    SHA256H  Q19, Q1, V19.4S
    SHA1SU0  V23.4S, V20.4S, V1.4S
    SHA256SU1  V20.4S, V0.4S, V12.4S
    SHA256H  Q9, Q16, V16.4S
    SHA256SU1  V29.4S, V9.4S, V31.4S
    SHA256H  Q26, Q30, V19.4S
    SHA1C  Q30, S22, V6.4S
    SHA256H  Q4, Q23, V7.4S
    SHA1SU0  V2.4S, V13.4S, V20.4S
    SHA256H  Q6, Q29, V26.4S
    SHA1SU1  V20.4S, V30.4S
    SHA256H2  Q22, Q20, V6.4S
    SHA256SU1  V11.4S, V7.4S, V4.4S
    SHA256H2  Q6, Q22, V11.4S
    SHA256H2  Q23, Q6, V6.4S
    SHA1C  Q6, S23, V23.4S
    SHA1M  Q22, S6, V2.4S
    SHA256SU1  V19.4S, V3.4S, V10.4S
    SHA1C  Q2, S25, V12.4S
    SUBS  X6, X6, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_3
    MOVZ  X27, #0x8fcb, LSL #0
    MOVK  X27, #0xc5c0, LSL #16
    MOVK  X27, #0x7040, LSL #32
    MOVK  X27, #0x3b70, LSL #48
    SUB  X24, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x1714, LSL #0
    MOVK  X27, #0x2030, LSL #16
    MOVK  X27, #0xaf, LSL #32
    MOVK  X27, #0xcd95, LSL #48
    SUB  X24, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xd2d2, LSL #0
    MOVK  X27, #0x7a5c, LSL #16
    MOVK  X27, #0x7fae, LSL #32
    MOVK  X27, #0xcdb0, LSL #48
    SUB  X24, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x0, LSL #0
    SUB  X24, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x8e1d, LSL #0
    MOVK  X27, #0xe02, LSL #16
    MOVK  X27, #0xe575, LSL #32
    MOVK  X27, #0xe160, LSL #48
    SUB  X24, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xb580, LSL #0
    MOVK  X27, #0xb4fc, LSL #16
    MOVK  X27, #0xb345, LSL #32
    MOVK  X27, #0xe495, LSL #48
    SUB  X24, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x7454, LSL #0
    MOVK  X27, #0x4466, LSL #16
    MOVK  X27, #0x96bb, LSL #32
    MOVK  X27, #0x19d0, LSL #48
    SUB  X24, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x98fc, LSL #0
    MOVK  X27, #0x2485, LSL #16
    MOVK  X27, #0x837f, LSL #32
    MOVK  X27, #0xe5c9, LSL #48
    SUB  X24, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x94ee, LSL #0
    MOVK  X27, #0x7d74, LSL #16
    MOVK  X27, #0xc657, LSL #32
    MOVK  X27, #0x5768, LSL #48
    SUB  X24, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xe463, LSL #0
    MOVK  X27, #0x16a2, LSL #16
    MOVK  X27, #0xf4ea, LSL #32
    MOVK  X27, #0xb97e, LSL #48
    SUB  X24, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xa4e, LSL #0
    MOVK  X27, #0x964b, LSL #16
    MOVK  X27, #0x4664, LSL #32
    MOVK  X27, #0x2c0e, LSL #48
    SUB  X24, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xbb93, LSL #0
    MOVK  X27, #0x8317, LSL #16
    MOVK  X27, #0x675b, LSL #32
    MOVK  X27, #0xa209, LSL #48
    SUB  X24, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x7cd8, LSL #0
    MOVK  X27, #0xa914, LSL #16
    MOVK  X27, #0xf0fb, LSL #32
    MOVK  X27, #0x50b6, LSL #48
    SUB  X24, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xc350, LSL #0
    MOVK  X27, #0x1644, LSL #16
    MOVK  X27, #0x8413, LSL #32
    MOVK  X27, #0x88d9, LSL #48
    SUB  X24, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xfc78, LSL #0
    MOVK  X27, #0xff44, LSL #16
    MOVK  X27, #0x60d0, LSL #32
    MOVK  X27, #0xf917, LSL #48
    SUB  X24, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf9f2, LSL #0
    MOVK  X27, #0x138a, LSL #16
    MOVK  X27, #0x4136, LSL #32
    MOVK  X27, #0x3b8f, LSL #48
    SUB  X24, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x88ea, LSL #0
    MOVK  X27, #0xf66b, LSL #16
    MOVK  X27, #0xb2b5, LSL #32
    MOVK  X27, #0x36c3, LSL #48
    SUB  X24, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xe984, LSL #0
    MOVK  X27, #0x7fa2, LSL #16
    MOVK  X27, #0xdc5b, LSL #32
    MOVK  X27, #0x8bf3, LSL #48
    SUB  X24, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xa90d, LSL #0
    MOVK  X27, #0x9028, LSL #16
    MOVK  X27, #0x27e8, LSL #32
    MOVK  X27, #0xf344, LSL #48
    SUB  X24, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xc837, LSL #0
    MOVK  X27, #0x79e2, LSL #16
    MOVK  X27, #0xbb08, LSL #32
    MOVK  X27, #0x273f, LSL #48
    SUB  X24, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xfe68, LSL #0
    MOVK  X27, #0xd355, LSL #16
    MOVK  X27, #0xa022, LSL #32
    MOVK  X27, #0x66a4, LSL #48
    SUB  X24, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x2304, LSL #0
    MOVK  X27, #0x8dfb, LSL #16
    MOVK  X27, #0xe93f, LSL #32
    MOVK  X27, #0x83e5, LSL #48
    FMOV  X24, V0.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xc52, LSL #0
    MOVK  X27, #0x1614, LSL #16
    MOVK  X27, #0xbd1c, LSL #32
    MOVK  X27, #0xb90f, LSL #48
    FMOV  X24, D0
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x4d76, LSL #0
    MOVK  X27, #0x9a9b, LSL #16
    MOVK  X27, #0xe783, LSL #32
    MOVK  X27, #0xf4f, LSL #48
    FMOV  X24, V1.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xa6c5, LSL #0
    MOVK  X27, #0x8106, LSL #16
    MOVK  X27, #0xbe4a, LSL #32
    MOVK  X27, #0x9eb7, LSL #48
    FMOV  X24, D1
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x7f24, LSL #0
    MOVK  X27, #0x25fa, LSL #16
    MOVK  X27, #0xe88, LSL #32
    MOVK  X27, #0x37f4, LSL #48
    FMOV  X24, V2.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x1764, LSL #0
    MOVK  X27, #0x8ef3, LSL #16
    MOVK  X27, #0xd817, LSL #32
    MOVK  X27, #0x36b9, LSL #48
    FMOV  X24, D2
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x2d35, LSL #0
    MOVK  X27, #0x49b6, LSL #16
    MOVK  X27, #0xcfd6, LSL #32
    MOVK  X27, #0xd444, LSL #48
    FMOV  X24, V3.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xdd6c, LSL #0
    MOVK  X27, #0x832b, LSL #16
    MOVK  X27, #0x5539, LSL #32
    MOVK  X27, #0x3088, LSL #48
    FMOV  X24, D3
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf51f, LSL #0
    MOVK  X27, #0xdbe8, LSL #16
    MOVK  X27, #0x743a, LSL #32
    MOVK  X27, #0xc536, LSL #48
    FMOV  X24, V4.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xe0b9, LSL #0
    MOVK  X27, #0x166b, LSL #16
    MOVK  X27, #0x13ca, LSL #32
    MOVK  X27, #0x19f, LSL #48
    FMOV  X24, D4
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x3f56, LSL #0
    MOVK  X27, #0xeada, LSL #16
    MOVK  X27, #0xca08, LSL #32
    MOVK  X27, #0xdd86, LSL #48
    FMOV  X24, V5.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xa314, LSL #0
    MOVK  X27, #0xd8b4, LSL #16
    MOVK  X27, #0x52a2, LSL #32
    MOVK  X27, #0xd564, LSL #48
    FMOV  X24, D5
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x9c35, LSL #0
    MOVK  X27, #0xff10, LSL #16
    MOVK  X27, #0xe0a0, LSL #32
    MOVK  X27, #0xd5d5, LSL #48
    FMOV  X24, V6.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x397, LSL #0
    MOVK  X27, #0x5040, LSL #16
    MOVK  X27, #0x34c5, LSL #32
    MOVK  X27, #0x8cb, LSL #48
    FMOV  X24, D6
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x13e9, LSL #0
    MOVK  X27, #0x1a18, LSL #16
    MOVK  X27, #0x75bd, LSL #32
    MOVK  X27, #0x39ce, LSL #48
    FMOV  X24, V7.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x3a9c, LSL #0
    MOVK  X27, #0xcbf7, LSL #16
    MOVK  X27, #0x143d, LSL #32
    MOVK  X27, #0x375e, LSL #48
    FMOV  X24, D7
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xb392, LSL #0
    MOVK  X27, #0x6ee6, LSL #16
    MOVK  X27, #0x3d54, LSL #32
    MOVK  X27, #0xfd3c, LSL #48
    FMOV  X24, V8.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xb8d4, LSL #0
    MOVK  X27, #0xaea2, LSL #16
    MOVK  X27, #0xe7af, LSL #32
    MOVK  X27, #0xff64, LSL #48
    FMOV  X24, D8
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xe2a3, LSL #0
    MOVK  X27, #0xba49, LSL #16
    MOVK  X27, #0xa85b, LSL #32
    MOVK  X27, #0xfef5, LSL #48
    FMOV  X24, V9.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x187d, LSL #0
    MOVK  X27, #0x74e9, LSL #16
    MOVK  X27, #0x5bb3, LSL #32
    MOVK  X27, #0x5a39, LSL #48
    FMOV  X24, D9
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x73b9, LSL #0
    MOVK  X27, #0x335d, LSL #16
    MOVK  X27, #0xa7d4, LSL #32
    MOVK  X27, #0x5766, LSL #48
    FMOV  X24, V10.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x95b1, LSL #0
    MOVK  X27, #0x1e6f, LSL #16
    MOVK  X27, #0xa5b4, LSL #32
    MOVK  X27, #0xfa31, LSL #48
    FMOV  X24, D10
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xa69d, LSL #0
    MOVK  X27, #0xf7e2, LSL #16
    MOVK  X27, #0xd5f8, LSL #32
    MOVK  X27, #0x67c2, LSL #48
    FMOV  X24, V11.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf229, LSL #0
    MOVK  X27, #0x3c16, LSL #16
    MOVK  X27, #0xe828, LSL #32
    MOVK  X27, #0xdffc, LSL #48
    FMOV  X24, D11
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x724a, LSL #0
    MOVK  X27, #0x3090, LSL #16
    MOVK  X27, #0x1d29, LSL #32
    MOVK  X27, #0xe770, LSL #48
    FMOV  X24, V12.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x5a4b, LSL #0
    MOVK  X27, #0xc007, LSL #16
    MOVK  X27, #0xf7e8, LSL #32
    MOVK  X27, #0xa642, LSL #48
    FMOV  X24, D12
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x351, LSL #0
    MOVK  X27, #0xaa40, LSL #16
    MOVK  X27, #0x86a1, LSL #32
    MOVK  X27, #0xe362, LSL #48
    FMOV  X24, V13.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x7c4, LSL #0
    MOVK  X27, #0xe97d, LSL #16
    MOVK  X27, #0x9e22, LSL #32
    MOVK  X27, #0xfba8, LSL #48
    FMOV  X24, D13
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xe817, LSL #0
    MOVK  X27, #0x1ee8, LSL #16
    MOVK  X27, #0x833b, LSL #32
    MOVK  X27, #0x986b, LSL #48
    FMOV  X24, V14.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x1c09, LSL #0
    MOVK  X27, #0x3a35, LSL #16
    MOVK  X27, #0xec11, LSL #32
    MOVK  X27, #0xa435, LSL #48
    FMOV  X24, D14
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x4871, LSL #0
    MOVK  X27, #0x41fa, LSL #16
    MOVK  X27, #0x2753, LSL #32
    MOVK  X27, #0x6adf, LSL #48
    FMOV  X24, V15.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xaec8, LSL #0
    MOVK  X27, #0x9267, LSL #16
    MOVK  X27, #0xf1a0, LSL #32
    MOVK  X27, #0xa10c, LSL #48
    FMOV  X24, D15
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x1eda, LSL #0
    MOVK  X27, #0x8442, LSL #16
    MOVK  X27, #0xb916, LSL #32
    MOVK  X27, #0xa1cd, LSL #48
    FMOV  X24, V16.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf604, LSL #0
    MOVK  X27, #0x4644, LSL #16
    MOVK  X27, #0xa219, LSL #32
    MOVK  X27, #0xe11c, LSL #48
    FMOV  X24, D16
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x25f9, LSL #0
    MOVK  X27, #0xc9eb, LSL #16
    MOVK  X27, #0xfa1, LSL #32
    MOVK  X27, #0xb4df, LSL #48
    FMOV  X24, V17.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x3f0d, LSL #0
    MOVK  X27, #0xbefe, LSL #16
    MOVK  X27, #0xc8d0, LSL #32
    MOVK  X27, #0x181f, LSL #48
    FMOV  X24, D17
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x5cb4, LSL #0
    MOVK  X27, #0x3792, LSL #16
    MOVK  X27, #0x6ec7, LSL #32
    MOVK  X27, #0x8204, LSL #48
    FMOV  X24, V18.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x853e, LSL #0
    MOVK  X27, #0xc40c, LSL #16
    MOVK  X27, #0x9d88, LSL #32
    MOVK  X27, #0xc471, LSL #48
    FMOV  X24, D18
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xdd13, LSL #0
    MOVK  X27, #0xef35, LSL #16
    MOVK  X27, #0x5e2, LSL #32
    MOVK  X27, #0x17a9, LSL #48
    FMOV  X24, V19.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xfd15, LSL #0
    MOVK  X27, #0xa5db, LSL #16
    MOVK  X27, #0x387b, LSL #32
    MOVK  X27, #0x5d4c, LSL #48
    FMOV  X24, D19
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf9f1, LSL #0
    MOVK  X27, #0x19bf, LSL #16
    MOVK  X27, #0x4f73, LSL #32
    MOVK  X27, #0xb3af, LSL #48
    FMOV  X24, V20.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf202, LSL #0
    MOVK  X27, #0xc56b, LSL #16
    MOVK  X27, #0x9a8d, LSL #32
    MOVK  X27, #0x49f2, LSL #48
    FMOV  X24, D20
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x3bfd, LSL #0
    MOVK  X27, #0xa658, LSL #16
    MOVK  X27, #0x198a, LSL #32
    MOVK  X27, #0x7952, LSL #48
    FMOV  X24, V21.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xd8e7, LSL #0
    MOVK  X27, #0xa737, LSL #16
    MOVK  X27, #0x37ae, LSL #32
    MOVK  X27, #0xa89e, LSL #48
    FMOV  X24, D21
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf55d, LSL #0
    MOVK  X27, #0xfddf, LSL #16
    MOVK  X27, #0x5320, LSL #32
    MOVK  X27, #0x42a8, LSL #48
    FMOV  X24, V22.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xd093, LSL #0
    MOVK  X27, #0x3638, LSL #16
    MOVK  X27, #0xd356, LSL #32
    MOVK  X27, #0x252e, LSL #48
    FMOV  X24, D22
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xc292, LSL #0
    MOVK  X27, #0x19ca, LSL #16
    MOVK  X27, #0x434e, LSL #32
    MOVK  X27, #0x730a, LSL #48
    FMOV  X24, V23.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x9322, LSL #0
    MOVK  X27, #0x9ba5, LSL #16
    MOVK  X27, #0xbdbd, LSL #32
    MOVK  X27, #0xf2ae, LSL #48
    FMOV  X24, D23
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x4162, LSL #0
    MOVK  X27, #0x3033, LSL #16
    MOVK  X27, #0xcb3b, LSL #32
    MOVK  X27, #0xdda2, LSL #48
    FMOV  X24, V24.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x68f0, LSL #0
    MOVK  X27, #0xdbce, LSL #16
    MOVK  X27, #0x311d, LSL #32
    MOVK  X27, #0x8ee8, LSL #48
    FMOV  X24, D24
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x7507, LSL #0
    MOVK  X27, #0x27c, LSL #16
    MOVK  X27, #0x7258, LSL #32
    MOVK  X27, #0xeace, LSL #48
    FMOV  X24, V25.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xa022, LSL #0
    MOVK  X27, #0xe825, LSL #16
    MOVK  X27, #0x4931, LSL #32
    MOVK  X27, #0xf2ea, LSL #48
    FMOV  X24, D25
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xba4c, LSL #0
    MOVK  X27, #0xffc2, LSL #16
    MOVK  X27, #0x864c, LSL #32
    MOVK  X27, #0xae45, LSL #48
    FMOV  X24, V26.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x37ce, LSL #0
    MOVK  X27, #0x7641, LSL #16
    MOVK  X27, #0xa18, LSL #32
    MOVK  X27, #0xe1e4, LSL #48
    FMOV  X24, D26
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x3e75, LSL #0
    MOVK  X27, #0x8d03, LSL #16
    MOVK  X27, #0xea4c, LSL #32
    MOVK  X27, #0x3821, LSL #48
    FMOV  X24, V27.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x312e, LSL #0
    MOVK  X27, #0x3234, LSL #16
    MOVK  X27, #0x99db, LSL #32
    MOVK  X27, #0xa3c1, LSL #48
    FMOV  X24, D27
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x710e, LSL #0
    MOVK  X27, #0x169, LSL #16
    MOVK  X27, #0x3837, LSL #32
    MOVK  X27, #0x2edd, LSL #48
    FMOV  X24, V28.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x9026, LSL #0
    MOVK  X27, #0x9766, LSL #16
    MOVK  X27, #0x65b5, LSL #32
    MOVK  X27, #0x75be, LSL #48
    FMOV  X24, D28
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xec78, LSL #0
    MOVK  X27, #0x4821, LSL #16
    MOVK  X27, #0xfbde, LSL #32
    MOVK  X27, #0x98ce, LSL #48
    FMOV  X24, V29.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xe78e, LSL #0
    MOVK  X27, #0xb457, LSL #16
    MOVK  X27, #0xc892, LSL #32
    MOVK  X27, #0x6a27, LSL #48
    FMOV  X24, D29
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xd913, LSL #0
    MOVK  X27, #0x42d1, LSL #16
    MOVK  X27, #0x72cc, LSL #32
    MOVK  X27, #0xf1eb, LSL #48
    FMOV  X24, V30.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x5a7e, LSL #0
    MOVK  X27, #0xb96f, LSL #16
    MOVK  X27, #0x52db, LSL #32
    MOVK  X27, #0x2684, LSL #48
    FMOV  X24, D30
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0x5a52, LSL #0
    MOVK  X27, #0x1397, LSL #16
    MOVK  X27, #0xc25, LSL #32
    MOVK  X27, #0x47a5, LSL #48
    FMOV  X24, V31.D[1]
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X27, #0xf2b1, LSL #0
    MOVK  X27, #0x33a6, LSL #16
    MOVK  X27, #0xfa6e, LSL #32
    MOVK  X27, #0x7128, LSL #48
    FMOV  X24, D31
    SUB  X29, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X9
    FMOV  V0.D[1], X18
    FMOV  D1, X13
    FMOV  V1.D[1], X25
    FMOV  D2, X22
    FMOV  V2.D[1], X24
    FMOV  D3, X16
    FMOV  V3.D[1], X15
    FMOV  D4, X5
    FMOV  V4.D[1], X11
    FMOV  D5, X21
    FMOV  V5.D[1], X17
    FMOV  D6, X20
    FMOV  V6.D[1], X27
    FMOV  D7, X28
    FMOV  V7.D[1], X29
    FMOV  D8, X17
    FMOV  V8.D[1], X12
    FMOV  D9, X14
    FMOV  V9.D[1], X20
    FMOV  D10, X5
    FMOV  V10.D[1], X9
    FMOV  D11, X17
    FMOV  V11.D[1], X11
    FMOV  D12, X29
    FMOV  V12.D[1], X20
    FMOV  D13, X25
    FMOV  V13.D[1], X17
    FMOV  D14, X14
    FMOV  V14.D[1], X2
    FMOV  D15, X29
    FMOV  V15.D[1], X25
    FMOV  D16, X25
    FMOV  V16.D[1], X12
    FMOV  D17, X17
    FMOV  V17.D[1], X29
    FMOV  D18, X20
    FMOV  V18.D[1], X14
    FMOV  D19, X29
    FMOV  V19.D[1], X27
    FMOV  D20, X3
    FMOV  V20.D[1], X20
    FMOV  D21, X27
    FMOV  V21.D[1], X25
    FMOV  D22, X20
    FMOV  V22.D[1], X2
    FMOV  D23, X11
    FMOV  V23.D[1], X24
    FMOV  D24, X2
    FMOV  V24.D[1], X27
    FMOV  D25, X17
    FMOV  V25.D[1], X2
    FMOV  D26, X6
    FMOV  V26.D[1], X10
    FMOV  D27, X28
    FMOV  V27.D[1], X14
    FMOV  D28, X13
    FMOV  V28.D[1], X6
    FMOV  D29, X27
    FMOV  V29.D[1], X28
    FMOV  D30, X2
    FMOV  V30.D[1], X9
    FMOV  D31, X22
    FMOV  V31.D[1], X19
    MOVZ  X19, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_4:
    SHA1M  Q17, S20, V29.4S
    SHA1C  Q11, S31, V24.4S
    SHA1M  Q4, S25, V27.4S
    SHA1P  Q1, S28, V17.4S
    SHA1P  Q4, S4, V30.4S
    SHA1M  Q26, S1, V11.4S
    SHA256H2  Q6, Q26, V4.4S
    SHA256SU0  V24.4S, V6.4S
    SHA1C  Q0, S24, V24.4S
    SHA1SU0  V20.4S, V0.4S, V0.4S
    SHA256H  Q16, Q22, V20.4S
    SHA1M  Q20, S16, V23.4S
    SHA1SU1  V6.4S, V4.4S
    SHA1SU1  V27.4S, V14.4S
    SHA1P  Q24, S1, V13.4S
    SHA1M  Q0, S18, V19.4S
    SHA1P  Q22, S20, V19.4S
    SHA256H2  Q30, Q25, V5.4S
    SHA1SU1  V4.4S, V8.4S
    SHA256SU0  V17.4S, V25.4S
    SHA256SU1  V28.4S, V0.4S, V14.4S
    SHA1SU1  V25.4S, V4.4S
    SHA1M  Q26, S24, V23.4S
    SHA256SU0  V14.4S, V4.4S
    SHA1SU0  V19.4S, V30.4S, V6.4S
    SHA1C  Q16, S27, V26.4S
    SHA256SU1  V27.4S, V28.4S, V22.4S
    SHA1SU1  V29.4S, V27.4S
    SHA1SU1  V8.4S, V17.4S
    SHA1SU1  V20.4S, V8.4S
    SHA256SU1  V23.4S, V20.4S, V20.4S
    SHA1SU0  V0.4S, V29.4S, V16.4S
    SHA1SU1  V11.4S, V25.4S
    SHA1SU1  V22.4S, V11.4S
    SHA256SU1  V30.4S, V19.4S, V0.4S
    SHA1P  Q26, S14, V30.4S
    SHA1SU0  V4.4S, V26.4S, V26.4S
    SHA1M  Q8, S4, V7.4S
    SHA1P  Q26, S8, V8.4S
    SHA1SU1  V27.4S, V9.4S
    SHA1P  Q19, S27, V22.4S
    SHA256H2  Q13, Q26, V23.4S
    SHA256H  Q5, Q13, V19.4S
    SHA256H  Q29, Q27, V29.4S
    SHA256H2  Q22, Q5, V1.4S
    SHA1P  Q8, S8, V13.4S
    SHA1SU0  V24.4S, V20.4S, V11.4S
    SHA1M  Q16, S0, V12.4S
    SHA1SU1  V9.4S, V7.4S
    SHA256SU1  V0.4S, V22.4S, V18.4S
    SHA256H  Q19, Q20, V1.4S
    SHA256H  Q25, Q27, V22.4S
    SHA1SU0  V17.4S, V9.4S, V9.4S
    SHA1SU0  V23.4S, V27.4S, V26.4S
    SHA256SU0  V9.4S, V8.4S
    SHA1C  Q26, S24, V24.4S
    SHA1M  Q4, S26, V0.4S
    SHA256H  Q18, Q9, V23.4S
    SHA1SU0  V11.4S, V4.4S, V16.4S
    SHA1SU1  V14.4S, V19.4S
    SHA1P  Q5, S18, V14.4S
    SHA1SU0  V20.4S, V25.4S, V11.4S
    SHA256SU0  V14.4S, V28.4S
    SHA1SU0  V23.4S, V23.4S, V14.4S
    SHA1M  Q11, S23, V23.4S
    SHA1M  Q12, S11, V17.4S
    SHA256H2  Q28, Q12, V12.4S
    SHA1C  Q16, S5, V28.4S
    SHA1M  Q27, S16, V20.4S
    SHA256SU0  V28.4S, V27.4S
    SHA256SU1  V26.4S, V28.4S, V28.4S
    SHA256H2  Q28, Q29, V26.4S
    SHA1P  Q12, S7, V30.4S
    SHA1SU1  V8.4S, V22.4S
    SHA1M  Q29, S26, V23.4S
    SHA1C  Q27, S22, V5.4S
    SHA256SU1  V9.4S, V20.4S, V5.4S
    SHA1C  Q16, S28, V29.4S
    SHA256H  Q14, Q10, V8.4S
    SHA256H2  Q29, Q23, V28.4S
    SHA256SU0  V28.4S, V18.4S
    SHA256H2  Q18, Q3, V25.4S
    SHA1SU0  V30.4S, V13.4S, V10.4S
    SHA256H  Q17, Q27, V30.4S
    SHA1SU1  V7.4S, V9.4S
    SHA1SU0  V9.4S, V7.4S, V17.4S
    SHA1SU1  V3.4S, V9.4S
    SHA1C  Q25, S12, V14.4S
    SHA256H  Q4, Q28, V29.4S
    SHA256SU0  V8.4S, V18.4S
    SHA256H2  Q20, Q16, V16.4S
    SHA256H2  Q18, Q4, V3.4S
    SHA256SU1  V5.4S, V25.4S, V13.4S
    SHA1P  Q25, S8, V8.4S
    SHA1P  Q12, S20, V18.4S
    SHA1M  Q10, S5, V12.4S
    SHA1M  Q5, S10, V10.4S
    SHA1SU1  V23.4S, V25.4S
    SHA1C  Q25, S5, V5.4S
    SHA256H  Q5, Q23, V23.4S
    SHA256SU1  V8.4S, V25.4S, V25.4S
    SHA1M  Q20, S8, V5.4S
    SHA1P  Q16, S0, V28.4S
    SHA256SU0  V13.4S, V5.4S
    SHA1M  Q10, S19, V5.4S
    SHA256H  Q19, Q24, V22.4S
    SHA1M  Q24, S6, V30.4S
    SHA1C  Q3, S2, V19.4S
    SHA1SU1  V8.4S, V27.4S
    SHA1SU1  V19.4S, V11.4S
    SHA1P  Q12, S6, V0.4S
    SHA256SU0  V22.4S, V16.4S
    SHA256SU0  V7.4S, V22.4S
    SHA1M  Q18, S20, V10.4S
    SHA256H2  Q23, Q13, V7.4S
    SHA256H  Q7, Q24, V19.4S
    SHA256H2  Q30, Q8, V3.4S
    SHA1P  Q11, S12, V18.4S
    SHA1SU1  V28.4S, V23.4S
    SHA1C  Q18, S7, V16.4S
    SHA1SU0  V27.4S, V18.4S, V30.4S
    SHA1SU1  V10.4S, V11.4S
    SHA256H  Q11, Q28, V10.4S
    SHA256H  Q30, Q11, V11.4S
    SHA256SU0  V2.4S, V27.4S
    SHA1C  Q27, S2, V30.4S
    SHA256H  Q18, Q6, V14.4S
    SHA256H  Q13, Q3, V16.4S
    SHA256SU0  V28.4S, V22.4S
    SHA256SU1  V10.4S, V22.4S, V19.4S
    SHA256H  Q8, Q28, V11.4S
    SHA1C  Q7, S17, V30.4S
    SHA256SU1  V17.4S, V27.4S, V16.4S
    SHA1SU0  V5.4S, V16.4S, V30.4S
    SHA1P  Q24, S16, V26.4S
    SHA256H2  Q6, Q9, V26.4S
    SHA256H  Q26, Q13, V8.4S
    SHA1SU1  V11.4S, V10.4S
    SHA1P  Q10, S5, V0.4S
    SHA256SU0  V19.4S, V18.4S
    SHA256SU1  V2.4S, V7.4S, V19.4S
    SHA256H  Q14, Q6, V24.4S
    SHA1M  Q5, S14, V11.4S
    SHA1C  Q9, S5, V17.4S
    SHA256H2  Q3, Q26, V9.4S
    SHA1M  Q5, S10, V10.4S
    SHA256H2  Q22, Q2, V3.4S
    SHA256H2  Q19, Q5, V5.4S
    SHA256SU1  V11.4S, V19.4S, V22.4S
    SHA1SU0  V16.4S, V11.4S, V14.4S
    SHA256SU0  V14.4S, V20.4S
    SHA256H  Q28, Q25, V20.4S
    SHA256H  Q3, Q1, V1.4S
    SHA1M  Q26, S7, V4.4S
    SHA256SU0  V9.4S, V13.4S
    SHA256H  Q10, Q9, V25.4S
    SHA1M  Q24, S16, V25.4S
    SHA1P  Q5, S12, V25.4S
    SHA1P  Q20, S10, V9.4S
    SHA256H2  Q9, Q4, V13.4S
    SHA1M  Q25, S6, V20.4S
    SHA256H2  Q17, Q9, V0.4S
    SHA256H2  Q16, Q21, V15.4S
    SHA256SU1  V7.4S, V14.4S, V28.4S
    SHA1C  Q11, S5, V1.4S
    SHA256SU0  V14.4S, V3.4S
    SHA256SU1  V1.4S, V16.4S, V11.4S
    SHA1P  Q12, S24, V26.4S
    SHA1SU1  V2.4S, V7.4S
    SHA256SU1  V18.4S, V30.4S, V2.4S
    SHA256H2  Q20, Q18, V14.4S
    SHA256H2  Q10, Q20, V17.4S
    SHA1P  Q7, S25, V1.4S
    SHA256H2  Q6, Q10, V12.4S
    SHA256SU0  V22.4S, V6.4S
    SHA1SU0  V9.4S, V22.4S, V7.4S
    SHA256SU1  V2.4S, V23.4S, V1.4S
    SHA1P  Q25, S9, V7.4S
    SHA256SU0  V5.4S, V23.4S
    SHA1C  Q4, S4, V28.4S
    SHA256H2  Q30, Q15, V9.4S
    SHA1SU1  V14.4S, V23.4S
    SHA256SU1  V15.4S, V24.4S, V21.4S
    SHA1P  Q1, S18, V6.4S
    SHA256SU0  V7.4S, V9.4S
    SHA1C  Q12, S1, V15.4S
    SHA1P  Q0, S16, V12.4S
    SHA256H2  Q12, Q5, V30.4S
    SHA256SU1  V24.4S, V14.4S, V4.4S
    SHA256H  Q14, Q0, V25.4S
    SHA256SU0  V22.4S, V17.4S
    SHA1C  Q25, S2, V24.4S
    SHA1P  Q1, S25, V15.4S
    SHA256H  Q24, Q12, V7.4S
    SHA1P  Q12, S24, V14.4S
    SHA256SU0  V28.4S, V1.4S
    SHA256H2  Q9, Q28, V28.4S
    SHA256H2  Q1, Q22, V22.4S
    SHA1P  Q22, S2, V14.4S
    SHA256H  Q24, Q1, V9.4S
    SUBS  X19, X19, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_4
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D0
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D1
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D2
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D3
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D4
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D5
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D6
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D7
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D8
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D9
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D10
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D11
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D12
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D13
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D14
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D15
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D16
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D17
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D18
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D19
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D20
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D21
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D22
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D23
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D24
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D25
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D26
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D27
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D28
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D29
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D30
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X2, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  D1, X22
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X27
    FMOV  D3, X2
    FMOV  V3.D[1], X2
    FMOV  D4, X6
    FMOV  V4.D[1], X19
    FMOV  D5, X10
    FMOV  V5.D[1], X18
    FMOV  D6, X12
    FMOV  V6.D[1], X3
    FMOV  D7, X13
    FMOV  V7.D[1], X10
    FMOV  D8, X28
    FMOV  V8.D[1], X6
    FMOV  D9, X9
    FMOV  V9.D[1], X9
    FMOV  D10, X8
    FMOV  V10.D[1], X15
    FMOV  D11, X18
    FMOV  V11.D[1], X11
    FMOV  D12, X27
    FMOV  V12.D[1], X29
    FMOV  D13, X3
    FMOV  V13.D[1], X29
    FMOV  D14, X13
    FMOV  V14.D[1], X14
    FMOV  D15, X17
    FMOV  V15.D[1], X12
    FMOV  D16, X21
    FMOV  V16.D[1], X21
    FMOV  D17, X25
    FMOV  V17.D[1], X21
    FMOV  D18, X10
    FMOV  V18.D[1], X19
    FMOV  D19, X13
    FMOV  V19.D[1], X18
    FMOV  D20, X10
    FMOV  V20.D[1], X19
    FMOV  D21, X21
    FMOV  V21.D[1], X21
    FMOV  D22, X3
    FMOV  V22.D[1], X13
    FMOV  D23, X8
    FMOV  V23.D[1], X9
    FMOV  D24, X27
    FMOV  V24.D[1], X14
    FMOV  D25, X20
    FMOV  V25.D[1], X24
    FMOV  D26, X11
    FMOV  V26.D[1], X13
    FMOV  D27, X12
    FMOV  V27.D[1], X15
    FMOV  D28, X21
    FMOV  V28.D[1], X3
    FMOV  D29, X8
    FMOV  V29.D[1], X12
    FMOV  D30, X5
    FMOV  V30.D[1], X29
    FMOV  D31, X14
    FMOV  V31.D[1], X20
    MOVZ  X14, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_5:
    SHA1SU1  V12.4S, V30.4S
    SHA1SU0  V9.4S, V31.4S, V26.4S
    SHA256H  Q13, Q25, V27.4S
    SHA1SU0  V28.4S, V12.4S, V19.4S
    SHA1C  Q21, S28, V13.4S
    SHA1SU0  V4.4S, V29.4S, V21.4S
    SHA1SU1  V2.4S, V9.4S
    SHA1P  Q28, S4, V4.4S
    SHA1SU0  V27.4S, V22.4S, V28.4S
    SHA256SU1  V9.4S, V27.4S, V2.4S
    SHA1SU0  V15.4S, V9.4S, V9.4S
    SHA1C  Q30, S15, V15.4S
    SHA256H2  Q26, Q30, V30.4S
    SHA256SU0  V31.4S, V26.4S
    SHA1SU0  V21.4S, V31.4S, V31.4S
    SHA1C  Q2, S21, V6.4S
    SHA1M  Q21, S2, V2.4S
    SHA1P  Q2, S7, V4.4S
    SHA256SU0  V28.4S, V25.4S
    SHA1SU1  V22.4S, V4.4S
    SHA1SU0  V15.4S, V8.4S, V15.4S
    SHA1P  Q13, S3, V9.4S
    SHA1SU0  V12.4S, V4.4S, V21.4S
    SHA1P  Q25, S9, V3.4S
    SHA1P  Q8, S5, V9.4S
    SHA256SU0  V19.4S, V9.4S
    SHA256SU0  V26.4S, V19.4S
    SHA256H  Q30, Q28, V26.4S
    SHA256H  Q21, Q24, V8.4S
    SHA256H2  Q31, Q13, V12.4S
    SHA256SU0  V27.4S, V30.4S
    SHA1SU0  V28.4S, V31.4S, V21.4S
    SHA256SU0  V29.4S, V29.4S
    SHA256H2  Q5, Q25, V15.4S
    SHA1M  Q7, S2, V27.4S
    SHA1SU1  V10.4S, V29.4S
    SHA1M  Q6, S10, V24.4S
    SHA1C  Q15, S28, V22.4S
    SHA1M  Q3, S6, V6.4S
    SHA1P  Q31, S5, V7.4S
    SHA256SU1  V4.4S, V31.4S, V15.4S
    SHA256H2  Q20, Q3, V3.4S
    SHA256SU0  V24.4S, V20.4S
    SHA256SU1  V8.4S, V24.4S, V4.4S
    SHA1M  Q25, S3, V23.4S
    SHA1SU0  V12.4S, V15.4S, V22.4S
    SHA256H  Q23, Q0, V14.4S
    SHA256SU1  V19.4S, V20.4S, V20.4S
    SHA256H  Q2, Q21, V10.4S
    SHA1M  Q21, S28, V2.4S
    SHA1SU1  V20.4S, V4.4S
    SHA1SU1  V10.4S, V18.4S
    SHA1SU0  V5.4S, V13.4S, V31.4S
    SHA256H2  Q24, Q23, V10.4S
    SHA1SU0  V10.4S, V24.4S, V24.4S
    SHA1C  Q6, S8, V25.4S
    SHA1P  Q31, S10, V20.4S
    SHA1C  Q15, S6, V5.4S
    SHA1P  Q13, S12, V25.4S
    SHA256SU1  V23.4S, V21.4S, V15.4S
    SHA256H2  Q29, Q13, V13.4S
    SHA256H  Q6, Q23, V23.4S
    SHA256SU0  V20.4S, V6.4S
    SHA256H2  Q18, Q19, V19.4S
    SHA256H2  Q25, Q18, V29.4S
    SHA1P  Q13, S20, V20.4S
    SHA256SU1  V12.4S, V31.4S, V13.4S
    SHA256SU0  V20.4S, V25.4S
    SHA256SU0  V2.4S, V12.4S
    SHA256SU1  V31.4S, V20.4S, V20.4S
    SHA256SU0  V13.4S, V2.4S
    SHA1SU0  V24.4S, V13.4S, V31.4S
    SHA256H  Q5, Q15, V9.4S
    SHA1C  Q4, S2, V11.4S
    SHA1SU1  V12.4S, V11.4S
    SHA1C  Q20, S26, V24.4S
    SHA1P  Q18, S16, V8.4S
    SHA1SU0  V9.4S, V16.4S, V26.4S
    SHA256SU1  V23.4S, V6.4S, V28.4S
    SHA1SU1  V25.4S, V0.4S
    SHA256H2  Q0, Q11, V6.4S
    SHA256SU1  V19.4S, V0.4S, V0.4S
    SHA256SU1  V6.4S, V12.4S, V15.4S
    SHA256SU0  V28.4S, V20.4S
    SHA1C  Q0, S4, V5.4S
    SHA1SU1  V2.4S, V18.4S
    SHA1SU1  V13.4S, V9.4S
    SHA1SU0  V24.4S, V6.4S, V2.4S
    SHA1P  Q16, S24, V23.4S
    SHA1C  Q29, S0, V25.4S
    SHA256H2  Q9, Q28, V29.4S
    SHA1C  Q2, S19, V16.4S
    SHA256H2  Q5, Q2, V2.4S
    SHA1SU0  V4.4S, V13.4S, V5.4S
    SHA256SU1  V6.4S, V4.4S, V4.4S
    SHA1C  Q4, S6, V6.4S
    SHA1SU1  V20.4S, V9.4S
    SHA256SU1  V16.4S, V4.4S, V20.4S
    SHA256H  Q0, Q14, V16.4S
    SHA256SU0  V6.4S, V19.4S
    SHA1SU1  V18.4S, V17.4S
    SHA1C  Q9, S4, V19.4S
    SHA256H2  Q19, Q12, V5.4S
    SHA256SU1  V29.4S, V5.4S, V15.4S
    SHA1SU0  V13.4S, V13.4S, V20.4S
    SHA1SU1  V17.4S, V10.4S
    SHA256SU0  V14.4S, V25.4S
    SHA1SU1  V25.4S, V14.4S
    SHA256SU1  V24.4S, V18.4S, V0.4S
    SHA256H  Q20, Q6, V0.4S
    SHA256SU1  V0.4S, V9.4S, V9.4S
    SHA256H  Q12, Q19, V17.4S
    SHA1P  Q9, S20, V25.4S
    SHA1M  Q15, S24, V0.4S
    SHA1SU0  V5.4S, V9.4S, V15.4S
    SHA256H  Q14, Q13, V5.4S
    SHA256SU1  V13.4S, V14.4S, V12.4S
    SHA1SU1  V4.4S, V13.4S
    SHA1SU1  V25.4S, V4.4S
    SHA1P  Q5, S29, V29.4S
    SHA1P  Q10, S25, V5.4S
    SHA1C  Q15, S6, V30.4S
    SHA256SU1  V12.4S, V10.4S, V15.4S
    SHA1C  Q16, S3, V23.4S
    SHA1P  Q6, S11, V5.4S
    SHA1M  Q17, S21, V6.4S
    SHA1SU0  V19.4S, V18.4S, V10.4S
    SHA1M  Q11, S23, V1.4S
    SHA256SU1  V21.4S, V2.4S, V1.4S
    SHA1P  Q18, S27, V11.4S
    SHA256SU0  V15.4S, V12.4S
    SHA256SU1  V12.4S, V25.4S, V15.4S
    SHA1SU1  V30.4S, V19.4S
    SHA1C  Q25, S7, V28.4S
    SHA256H  Q9, Q17, V9.4S
    SHA256SU1  V27.4S, V24.4S, V6.4S
    SHA1M  Q3, S2, V8.4S
    SHA1SU1  V8.4S, V21.4S
    SHA1P  Q24, S9, V16.4S
    SHA1SU1  V2.4S, V12.4S
    SHA256H  Q21, Q2, V2.4S
    SHA1SU1  V2.4S, V27.4S
    SHA1P  Q6, S30, V18.4S
    SHA1SU1  V15.4S, V3.4S
    SHA1C  Q10, S24, V24.4S
    SHA1C  Q12, S9, V8.4S
    SHA1C  Q8, S15, V2.4S
    SHA1M  Q27, S12, V8.4S
    SHA1SU0  V11.4S, V10.4S, V0.4S
    SHA256SU0  V12.4S, V21.4S
    SHA256H  Q15, Q6, V11.4S
    SHA256H2  Q17, Q15, V15.4S
    SHA1C  Q30, S12, V27.4S
    SHA1M  Q7, S24, V30.4S
    SHA256SU1  V16.4S, V7.4S, V17.4S
    SHA1P  Q6, S16, V16.4S
    SHA256SU0  V9.4S, V6.4S
    SHA1C  Q6, S25, V9.4S
    SHA1M  Q2, S9, V2.4S
    SHA256H  Q30, Q27, V2.4S
    SHA256H  Q19, Q28, V8.4S
    SHA1M  Q27, S19, V18.4S
    SHA1SU0  V15.4S, V5.4S, V18.4S
    SHA256H  Q25, Q1, V12.4S
    SHA1M  Q1, S18, V22.4S
    SHA256SU0  V21.4S, V16.4S
    SHA256H  Q16, Q2, V1.4S
    SHA1C  Q3, S0, V29.4S
    SHA1SU0  V17.4S, V23.4S, V3.4S
    SHA256SU0  V23.4S, V23.4S
    SHA1SU1  V5.4S, V31.4S
    SHA1P  Q3, S30, V16.4S
    SHA1P  Q22, S6, V27.4S
    SHA256SU1  V9.4S, V15.4S, V17.4S
    SHA1SU1  V10.4S, V25.4S
    SHA256H2  Q0, Q8, V22.4S
    SHA256SU0  V8.4S, V21.4S
    SHA256SU0  V25.4S, V8.4S
    SHA1SU0  V7.4S, V9.4S, V25.4S
    SHA256SU1  V29.4S, V23.4S, V23.4S
    SHA256H  Q9, Q10, V29.4S
    SHA1SU1  V12.4S, V9.4S
    SHA1SU1  V2.4S, V5.4S
    SHA1C  Q6, S7, V12.4S
    SHA1P  Q12, S3, V20.4S
    SHA1P  Q9, S12, V17.4S
    SHA1SU0  V16.4S, V0.4S, V6.4S
    SHA256H  Q29, Q16, V2.4S
    SHA1SU0  V19.4S, V9.4S, V14.4S
    SHA256H  Q21, Q29, V19.4S
    SHA256SU0  V15.4S, V26.4S
    SHA256H2  Q5, Q27, V15.4S
    SHA1SU0  V12.4S, V25.4S, V1.4S
    SHA256H  Q31, Q11, V21.4S
    SHA1C  Q20, S20, V3.4S
    SHA1SU0  V6.4S, V18.4S, V17.4S
    SHA1SU1  V27.4S, V4.4S
    SHA1C  Q7, S27, V21.4S
    SHA1SU0  V9.4S, V8.4S, V23.4S
    SHA256SU0  V17.4S, V24.4S
    SUBS  X14, X14, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_5
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X12, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xffff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    SUB  X12, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xca95, LSL #0
    MOVK  X28, #0x608c, LSL #16
    MOVK  X28, #0x105a, LSL #32
    MOVK  X28, #0x4bc6, LSL #48
    FMOV  X12, V0.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x9c56, LSL #0
    MOVK  X28, #0x7594, LSL #16
    MOVK  X28, #0x975a, LSL #32
    MOVK  X28, #0x8e54, LSL #48
    FMOV  X12, D0
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x4ae, LSL #0
    MOVK  X28, #0xb2c4, LSL #16
    MOVK  X28, #0x6f90, LSL #32
    MOVK  X28, #0x7425, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x69e7, LSL #0
    MOVK  X28, #0xe9f5, LSL #16
    MOVK  X28, #0x32ef, LSL #32
    MOVK  X28, #0x77a4, LSL #48
    FMOV  X12, D1
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x430e, LSL #0
    MOVK  X28, #0x145e, LSL #16
    MOVK  X28, #0x6701, LSL #32
    MOVK  X28, #0xa996, LSL #48
    FMOV  X12, V2.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5ae3, LSL #0
    MOVK  X28, #0xa3c4, LSL #16
    MOVK  X28, #0xa5c8, LSL #32
    MOVK  X28, #0xf863, LSL #48
    FMOV  X12, D2
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x3c47, LSL #0
    MOVK  X28, #0x49e0, LSL #16
    MOVK  X28, #0x7e30, LSL #32
    MOVK  X28, #0xc3b7, LSL #48
    FMOV  X12, V3.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xdc, LSL #0
    MOVK  X28, #0xc9b9, LSL #16
    MOVK  X28, #0xdae4, LSL #32
    MOVK  X28, #0xbdc5, LSL #48
    FMOV  X12, D3
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x8846, LSL #0
    MOVK  X28, #0xdea9, LSL #16
    MOVK  X28, #0x3f4d, LSL #32
    MOVK  X28, #0xc70e, LSL #48
    FMOV  X12, V4.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x3ed0, LSL #0
    MOVK  X28, #0x529c, LSL #16
    MOVK  X28, #0xdb33, LSL #32
    MOVK  X28, #0x59de, LSL #48
    FMOV  X12, D4
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x87a2, LSL #0
    MOVK  X28, #0xb55b, LSL #16
    MOVK  X28, #0xe78d, LSL #32
    MOVK  X28, #0x7902, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xb78f, LSL #0
    MOVK  X28, #0x3dc1, LSL #16
    MOVK  X28, #0x50c4, LSL #32
    MOVK  X28, #0xb918, LSL #48
    FMOV  X12, D5
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x4693, LSL #0
    MOVK  X28, #0xda19, LSL #16
    MOVK  X28, #0xfea2, LSL #32
    MOVK  X28, #0xf0b3, LSL #48
    FMOV  X12, V6.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x19a, LSL #0
    MOVK  X28, #0x3bc2, LSL #16
    MOVK  X28, #0x7c6d, LSL #32
    MOVK  X28, #0xfd50, LSL #48
    FMOV  X12, D6
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xa81b, LSL #0
    MOVK  X28, #0x4fe9, LSL #16
    MOVK  X28, #0xdf9d, LSL #32
    MOVK  X28, #0x456e, LSL #48
    FMOV  X12, V7.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xb1ab, LSL #0
    MOVK  X28, #0x1d7b, LSL #16
    MOVK  X28, #0xd925, LSL #32
    MOVK  X28, #0x8952, LSL #48
    FMOV  X12, D7
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xf690, LSL #0
    MOVK  X28, #0xb63, LSL #16
    MOVK  X28, #0x9970, LSL #32
    MOVK  X28, #0x24ca, LSL #48
    FMOV  X12, V8.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xa84b, LSL #0
    MOVK  X28, #0x3ce2, LSL #16
    MOVK  X28, #0x5e2a, LSL #32
    MOVK  X28, #0x120f, LSL #48
    FMOV  X12, D8
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x973a, LSL #0
    MOVK  X28, #0x59f6, LSL #16
    MOVK  X28, #0x6de0, LSL #32
    MOVK  X28, #0x281a, LSL #48
    FMOV  X12, V9.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x1e79, LSL #0
    MOVK  X28, #0x88ec, LSL #16
    MOVK  X28, #0xa7f7, LSL #32
    MOVK  X28, #0x6d7c, LSL #48
    FMOV  X12, D9
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x1195, LSL #0
    MOVK  X28, #0x34c9, LSL #16
    MOVK  X28, #0xca1b, LSL #32
    MOVK  X28, #0x2cb7, LSL #48
    FMOV  X12, V10.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x6081, LSL #0
    MOVK  X28, #0xb6ec, LSL #16
    MOVK  X28, #0xb593, LSL #32
    MOVK  X28, #0x95f3, LSL #48
    FMOV  X12, D10
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xd6a2, LSL #0
    MOVK  X28, #0xb1c1, LSL #16
    MOVK  X28, #0x93a8, LSL #32
    MOVK  X28, #0xb2a6, LSL #48
    FMOV  X12, V11.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xbdc5, LSL #0
    MOVK  X28, #0xd820, LSL #16
    MOVK  X28, #0xddc7, LSL #32
    MOVK  X28, #0xac49, LSL #48
    FMOV  X12, D11
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x27a8, LSL #0
    MOVK  X28, #0xf20a, LSL #16
    MOVK  X28, #0x39c4, LSL #32
    MOVK  X28, #0x1b41, LSL #48
    FMOV  X12, V12.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x1eb5, LSL #0
    MOVK  X28, #0x9eec, LSL #16
    MOVK  X28, #0x4cd6, LSL #32
    MOVK  X28, #0x400f, LSL #48
    FMOV  X12, D12
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x91cf, LSL #0
    MOVK  X28, #0x79f3, LSL #16
    MOVK  X28, #0x2aba, LSL #32
    MOVK  X28, #0x1808, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x779c, LSL #0
    MOVK  X28, #0xafcf, LSL #16
    MOVK  X28, #0xecef, LSL #32
    MOVK  X28, #0x1368, LSL #48
    FMOV  X12, D13
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x4b48, LSL #0
    MOVK  X28, #0xa0db, LSL #16
    MOVK  X28, #0xcef, LSL #32
    MOVK  X28, #0xb6ff, LSL #48
    FMOV  X12, V14.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x3ef7, LSL #0
    MOVK  X28, #0x55f2, LSL #16
    MOVK  X28, #0xbcee, LSL #32
    MOVK  X28, #0x3f51, LSL #48
    FMOV  X12, D14
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x3363, LSL #0
    MOVK  X28, #0x2ec7, LSL #16
    MOVK  X28, #0x7df9, LSL #32
    MOVK  X28, #0x8641, LSL #48
    FMOV  X12, V15.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xf6ce, LSL #0
    MOVK  X28, #0x21d3, LSL #16
    MOVK  X28, #0x74de, LSL #32
    MOVK  X28, #0x77e8, LSL #48
    FMOV  X12, D15
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x34db, LSL #0
    MOVK  X28, #0xa3bc, LSL #16
    MOVK  X28, #0xf5a4, LSL #32
    MOVK  X28, #0xb30e, LSL #48
    FMOV  X12, V16.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xf612, LSL #0
    MOVK  X28, #0xcaac, LSL #16
    MOVK  X28, #0xdad7, LSL #32
    MOVK  X28, #0x3ee1, LSL #48
    FMOV  X12, D16
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xf1a9, LSL #0
    MOVK  X28, #0x6bab, LSL #16
    MOVK  X28, #0x5845, LSL #32
    MOVK  X28, #0x1611, LSL #48
    FMOV  X12, V17.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xf6dc, LSL #0
    MOVK  X28, #0xf68c, LSL #16
    MOVK  X28, #0x9a80, LSL #32
    MOVK  X28, #0xcbc7, LSL #48
    FMOV  X12, D17
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xda82, LSL #0
    MOVK  X28, #0x293, LSL #16
    MOVK  X28, #0xf722, LSL #32
    MOVK  X28, #0x610d, LSL #48
    FMOV  X12, V18.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x7802, LSL #0
    MOVK  X28, #0xa617, LSL #16
    MOVK  X28, #0x1992, LSL #32
    MOVK  X28, #0x257d, LSL #48
    FMOV  X12, D18
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5208, LSL #0
    MOVK  X28, #0xb8af, LSL #16
    MOVK  X28, #0xc689, LSL #32
    MOVK  X28, #0x5413, LSL #48
    FMOV  X12, V19.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x3c02, LSL #0
    MOVK  X28, #0xd790, LSL #16
    MOVK  X28, #0xcde0, LSL #32
    MOVK  X28, #0x7f40, LSL #48
    FMOV  X12, D19
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x3aba, LSL #0
    MOVK  X28, #0x6772, LSL #16
    MOVK  X28, #0xecac, LSL #32
    MOVK  X28, #0xe450, LSL #48
    FMOV  X12, V20.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xb5e9, LSL #0
    MOVK  X28, #0x4375, LSL #16
    MOVK  X28, #0xf0ca, LSL #32
    MOVK  X28, #0xfb3a, LSL #48
    FMOV  X12, D20
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x9c36, LSL #0
    MOVK  X28, #0x2ee4, LSL #16
    MOVK  X28, #0x660, LSL #32
    MOVK  X28, #0xf475, LSL #48
    FMOV  X12, V21.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xbf4e, LSL #0
    MOVK  X28, #0x8855, LSL #16
    MOVK  X28, #0xb50b, LSL #32
    MOVK  X28, #0x3b32, LSL #48
    FMOV  X12, D21
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x9806, LSL #0
    MOVK  X28, #0xc067, LSL #16
    MOVK  X28, #0x4056, LSL #32
    MOVK  X28, #0x53ac, LSL #48
    FMOV  X12, V22.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x981d, LSL #0
    MOVK  X28, #0xc5db, LSL #16
    MOVK  X28, #0xbf1c, LSL #32
    MOVK  X28, #0xdb70, LSL #48
    FMOV  X12, D22
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x4d39, LSL #0
    MOVK  X28, #0xdb36, LSL #16
    MOVK  X28, #0x7831, LSL #32
    MOVK  X28, #0xe425, LSL #48
    FMOV  X12, V23.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x56fe, LSL #0
    MOVK  X28, #0xef12, LSL #16
    MOVK  X28, #0x7519, LSL #32
    MOVK  X28, #0x14f6, LSL #48
    FMOV  X12, D23
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x8662, LSL #0
    MOVK  X28, #0x148d, LSL #16
    MOVK  X28, #0xd73c, LSL #32
    MOVK  X28, #0x4af9, LSL #48
    FMOV  X12, V24.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x910, LSL #0
    MOVK  X28, #0x4a11, LSL #16
    MOVK  X28, #0x9e0, LSL #32
    MOVK  X28, #0x2850, LSL #48
    FMOV  X12, D24
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x8197, LSL #0
    MOVK  X28, #0xdc71, LSL #16
    MOVK  X28, #0x39fc, LSL #32
    MOVK  X28, #0xbd11, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xfa81, LSL #0
    MOVK  X28, #0x6698, LSL #16
    MOVK  X28, #0xd8bb, LSL #32
    MOVK  X28, #0xdf06, LSL #48
    FMOV  X12, D25
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xf77b, LSL #0
    MOVK  X28, #0x5b21, LSL #16
    MOVK  X28, #0xe486, LSL #32
    MOVK  X28, #0x7d8b, LSL #48
    FMOV  X12, V26.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x60a0, LSL #0
    MOVK  X28, #0x9645, LSL #16
    MOVK  X28, #0x21f7, LSL #32
    MOVK  X28, #0xfa7, LSL #48
    FMOV  X12, D26
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x209c, LSL #0
    MOVK  X28, #0xa0f9, LSL #16
    MOVK  X28, #0xa3bc, LSL #32
    MOVK  X28, #0x9795, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x5017, LSL #0
    MOVK  X28, #0xe21e, LSL #16
    MOVK  X28, #0xe1a4, LSL #32
    MOVK  X28, #0xd8ae, LSL #48
    FMOV  X12, D27
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x34e2, LSL #0
    MOVK  X28, #0xe030, LSL #16
    MOVK  X28, #0x8a87, LSL #32
    MOVK  X28, #0x4ef5, LSL #48
    FMOV  X12, V28.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x7cbb, LSL #0
    MOVK  X28, #0xe8ad, LSL #16
    MOVK  X28, #0x3bdd, LSL #32
    MOVK  X28, #0x1f5b, LSL #48
    FMOV  X12, D28
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x721f, LSL #0
    MOVK  X28, #0x377c, LSL #16
    MOVK  X28, #0xf45, LSL #32
    MOVK  X28, #0xdc5b, LSL #48
    FMOV  X12, V29.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x1ee3, LSL #0
    MOVK  X28, #0x9fe6, LSL #16
    MOVK  X28, #0xe3a1, LSL #32
    MOVK  X28, #0x5824, LSL #48
    FMOV  X12, D29
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xcec5, LSL #0
    MOVK  X28, #0x8c04, LSL #16
    MOVK  X28, #0xa200, LSL #32
    MOVK  X28, #0x2a44, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0xafc0, LSL #0
    MOVK  X28, #0xcd42, LSL #16
    MOVK  X28, #0x881f, LSL #32
    MOVK  X28, #0x1580, LSL #48
    FMOV  X12, D30
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x2333, LSL #0
    MOVK  X28, #0x405, LSL #16
    MOVK  X28, #0x9f30, LSL #32
    MOVK  X28, #0x8acd, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x309b, LSL #0
    MOVK  X28, #0x1872, LSL #16
    MOVK  X28, #0x3585, LSL #32
    MOVK  X28, #0xd19b, LSL #48
    FMOV  X12, D31
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0xf0a9, LSL #0
    MOVK  X2, #0x3a0b, LSL #16
    MOVK  X2, #0xd670, LSL #32
    MOVK  X2, #0x57f2, LSL #48
    MOVZ  X3, #0x240, LSL #0
    MOVK  X3, #0xc978, LSL #16
    MOVK  X3, #0x7cae, LSL #32
    MOVK  X3, #0xc608, LSL #48
    MOVZ  X5, #0xb, LSL #0
    MOVK  X5, #0x1fb3, LSL #16
    MOVK  X5, #0xcd8a, LSL #32
    MOVK  X5, #0x6b3c, LSL #48
    MOVZ  X6, #0x9c49, LSL #0
    MOVK  X6, #0x193d, LSL #16
    MOVK  X6, #0x5e1d, LSL #32
    MOVK  X6, #0x6692, LSL #48
    MOVZ  X8, #0xcaac, LSL #0
    MOVK  X8, #0xf587, LSL #16
    MOVK  X8, #0xeace, LSL #32
    MOVK  X8, #0x70af, LSL #48
    MOVZ  X9, #0xdd66, LSL #0
    MOVK  X9, #0x3f8c, LSL #16
    MOVK  X9, #0x7605, LSL #32
    MOVK  X9, #0xf7f0, LSL #48
    MOVZ  X10, #0x67d6, LSL #0
    MOVK  X10, #0xd4c6, LSL #16
    MOVK  X10, #0x2c1e, LSL #32
    MOVK  X10, #0x67f0, LSL #48
    MOVZ  X11, #0xece2, LSL #0
    MOVK  X11, #0x4532, LSL #16
    MOVK  X11, #0xb477, LSL #32
    MOVK  X11, #0xfef3, LSL #48
    MOVZ  X12, #0x838, LSL #0
    MOVK  X12, #0x80dd, LSL #16
    MOVK  X12, #0x891e, LSL #32
    MOVK  X12, #0xfb71, LSL #48
    MOVZ  X13, #0x69bc, LSL #0
    MOVK  X13, #0x6c41, LSL #16
    MOVK  X13, #0xac0a, LSL #32
    MOVK  X13, #0xeec5, LSL #48
    MOVZ  X14, #0x877b, LSL #0
    MOVK  X14, #0x621a, LSL #16
    MOVK  X14, #0x95b3, LSL #32
    MOVK  X14, #0xba3e, LSL #48
    MOVZ  X15, #0x42f9, LSL #0
    MOVK  X15, #0x979e, LSL #16
    MOVK  X15, #0xaae8, LSL #32
    MOVK  X15, #0x65ff, LSL #48
    MOVZ  X16, #0xbc3c, LSL #0
    MOVK  X16, #0xaace, LSL #16
    MOVK  X16, #0xa793, LSL #32
    MOVK  X16, #0x2043, LSL #48
    MOVZ  X17, #0x5e57, LSL #0
    MOVK  X17, #0x8276, LSL #16
    MOVK  X17, #0xf66b, LSL #32
    MOVK  X17, #0x611a, LSL #48
    MOVZ  X18, #0xe374, LSL #0
    MOVK  X18, #0xb6a7, LSL #16
    MOVK  X18, #0x53fd, LSL #32
    MOVK  X18, #0x139f, LSL #48
    MOVZ  X19, #0xd8d9, LSL #0
    MOVK  X19, #0xf9d2, LSL #16
    MOVK  X19, #0x3507, LSL #32
    MOVK  X19, #0x180c, LSL #48
    MOVZ  X20, #0x874, LSL #0
    MOVK  X20, #0xea23, LSL #16
    MOVK  X20, #0x442c, LSL #32
    MOVK  X20, #0x48a2, LSL #48
    MOVZ  X21, #0xc141, LSL #0
    MOVK  X21, #0x4b49, LSL #16
    MOVK  X21, #0xb1e7, LSL #32
    MOVK  X21, #0xcefe, LSL #48
    MOVZ  X22, #0xc1ad, LSL #0
    MOVK  X22, #0x6329, LSL #16
    MOVK  X22, #0x3bf, LSL #32
    MOVK  X22, #0xab8d, LSL #48
    MOVZ  X24, #0x295a, LSL #0
    MOVK  X24, #0x1e85, LSL #16
    MOVK  X24, #0x23bb, LSL #32
    MOVK  X24, #0x3d10, LSL #48
    MOVZ  X25, #0xea62, LSL #0
    MOVK  X25, #0x7702, LSL #16
    MOVK  X25, #0x7347, LSL #32
    MOVK  X25, #0xcd, LSL #48
    MOVZ  X27, #0xe04d, LSL #0
    MOVK  X27, #0x31ee, LSL #16
    MOVK  X27, #0x55a5, LSL #32
    MOVK  X27, #0x9406, LSL #48
    MOVZ  X28, #0x69a8, LSL #0
    MOVK  X28, #0x4783, LSL #16
    MOVK  X28, #0xd544, LSL #32
    MOVK  X28, #0x4548, LSL #48
    MOVZ  X29, #0xc96f, LSL #0
    MOVK  X29, #0xc32e, LSL #16
    MOVK  X29, #0x4f63, LSL #32
    MOVK  X29, #0x108a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X19
    FMOV  V2.D[1], X29
    FMOV  D3, X16
    FMOV  V3.D[1], X10
    FMOV  D4, X24
    FMOV  V4.D[1], X25
    FMOV  D5, X15
    FMOV  V5.D[1], X24
    FMOV  D6, X2
    FMOV  V6.D[1], X20
    FMOV  D7, X6
    FMOV  V7.D[1], X22
    FMOV  D8, X5
    FMOV  V8.D[1], X2
    FMOV  D9, X12
    FMOV  V9.D[1], X9
    FMOV  D10, X2
    FMOV  V10.D[1], X22
    FMOV  D11, X16
    FMOV  V11.D[1], X25
    FMOV  D12, X5
    FMOV  V12.D[1], X18
    FMOV  D13, X29
    FMOV  V13.D[1], X8
    FMOV  D14, X16
    FMOV  V14.D[1], X22
    FMOV  D15, X15
    FMOV  V15.D[1], X24
    FMOV  D16, X21
    FMOV  V16.D[1], X6
    FMOV  D17, X25
    FMOV  V17.D[1], X14
    FMOV  D18, X10
    FMOV  V18.D[1], X9
    FMOV  D19, X2
    FMOV  V19.D[1], X11
    FMOV  D20, X8
    FMOV  V20.D[1], X22
    FMOV  D21, X25
    FMOV  V21.D[1], X9
    FMOV  D22, X18
    FMOV  V22.D[1], X24
    FMOV  D23, X12
    FMOV  V23.D[1], X21
    FMOV  D24, X15
    FMOV  V24.D[1], X3
    FMOV  D25, X10
    FMOV  V25.D[1], X25
    FMOV  D26, X28
    FMOV  V26.D[1], X13
    FMOV  D27, X25
    FMOV  V27.D[1], X29
    FMOV  D28, X3
    FMOV  V28.D[1], X18
    FMOV  D29, X27
    FMOV  V29.D[1], X8
    FMOV  D30, X24
    FMOV  V30.D[1], X29
    FMOV  D31, X17
    FMOV  V31.D[1], X3
    MOVZ  X28, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_6:
    SHA1M  Q21, S31, V30.4S
    SHA1M  Q8, S18, V29.4S
    SHA256SU1  V24.4S, V28.4S, V21.4S
    SHA256H2  Q18, Q25, V24.4S
    SHA1SU1  V0.4S, V19.4S
    SHA256SU0  V3.4S, V8.4S
    SHA1M  Q13, S0, V18.4S
    SHA1P  Q27, S27, V3.4S
    SHA256SU0  V9.4S, V13.4S
    SHA256H2  Q14, Q27, V22.4S
    SHA256H  Q27, Q9, V9.4S
    SHA256H2  Q29, Q27, V27.4S
    SHA1C  Q30, S26, V29.4S
    SHA256H  Q25, Q14, V17.4S
    SHA1C  Q17, S30, V25.4S
    SHA1P  Q19, S9, V26.4S
    SHA1P  Q14, S19, V10.4S
    SHA256SU1  V26.4S, V13.4S, V2.4S
    SHA256H  Q31, Q28, V1.4S
    SHA256SU1  V21.4S, V23.4S, V24.4S
    SHA256H2  Q0, Q17, V8.4S
    SHA1M  Q2, S8, V25.4S
    SHA256SU0  V30.4S, V31.4S
    SHA256H2  Q9, Q25, V26.4S
    SHA256H  Q22, Q6, V29.4S
    SHA1C  Q3, S7, V1.4S
    SHA1SU0  V27.4S, V14.4S, V27.4S
    SHA256SU1  V25.4S, V8.4S, V31.4S
    SHA256H2  Q28, Q25, V0.4S
    SHA1SU1  V0.4S, V27.4S
    SHA1SU0  V27.4S, V21.4S, V9.4S
    SHA1SU1  V8.4S, V2.4S
    SHA256SU0  V31.4S, V30.4S
    SHA1SU0  V25.4S, V22.4S, V28.4S
    SHA256SU1  V14.4S, V31.4S, V8.4S
    SHA256SU1  V18.4S, V14.4S, V0.4S
    SHA1M  Q18, S18, V18.4S
    SHA1M  Q7, S0, V18.4S
    SHA256SU0  V17.4S, V3.4S
    SHA1SU0  V30.4S, V17.4S, V27.4S
    SHA256SU0  V2.4S, V7.4S
    SHA256SU1  V3.4S, V30.4S, V19.4S
    SHA256H  Q0, Q3, V3.4S
    SHA1SU0  V17.4S, V25.4S, V25.4S
    SHA1P  Q1, S2, V17.4S
    SHA1SU1  V28.4S, V1.4S
    SHA256H2  Q3, Q28, V28.4S
    SHA1SU0  V30.4S, V24.4S, V3.4S
    SHA1SU0  V21.4S, V30.4S, V4.4S
    SHA1SU1  V30.4S, V0.4S
    SHA256SU1  V19.4S, V30.4S, V30.4S
    SHA1C  Q27, S14, V19.4S
    SHA1C  Q30, S27, V14.4S
    SHA256H2  Q7, Q21, V21.4S
    SHA1C  Q18, S7, V30.4S
    SHA1M  Q25, S8, V27.4S
    SHA1P  Q27, S25, V2.4S
    SHA256SU0  V25.4S, V18.4S
    SHA256H2  Q7, Q19, V15.4S
    SHA256SU0  V17.4S, V21.4S
    SHA256SU0  V28.4S, V20.4S
    SHA1M  Q0, S20, V23.4S
    SHA256SU0  V14.4S, V26.4S
    SHA256H2  Q2, Q23, V0.4S
    SHA1M  Q18, S2, V23.4S
    SHA256SU0  V23.4S, V23.4S
    SHA256SU0  V20.4S, V12.4S
    SHA256SU0  V2.4S, V25.4S
    SHA256H2  Q4, Q17, V26.4S
    SHA1SU1  V1.4S, V14.4S
    SHA256SU1  V14.4S, V28.4S, V4.4S
    SHA1C  Q0, S14, V7.4S
    SHA1SU0  V8.4S, V2.4S, V27.4S
    SHA256H  Q15, Q20, V0.4S
    SHA1C  Q0, S15, V1.4S
    SHA256SU0  V4.4S, V18.4S
    SHA1SU0  V15.4S, V8.4S, V8.4S
    SHA1SU1  V2.4S, V15.4S
    SHA256SU1  V21.4S, V2.4S, V23.4S
    SHA1C  Q2, S21, V21.4S
    SHA256SU0  V23.4S, V5.4S
    SHA256H2  Q8, Q0, V12.4S
    SHA1M  Q5, S8, V2.4S
    SHA256H2  Q28, Q26, V4.4S
    SHA1SU0  V4.4S, V23.4S, V5.4S
    SHA1SU0  V15.4S, V19.4S, V28.4S
    SHA1P  Q17, S4, V15.4S
    SHA1SU0  V27.4S, V3.4S, V20.4S
    SHA1M  Q14, S23, V9.4S
    SHA256H  Q7, Q9, V3.4S
    SHA256H2  Q25, Q3, V18.4S
    SHA1SU0  V21.4S, V11.4S, V25.4S
    SHA1P  Q1, S30, V19.4S
    SHA256H2  Q5, Q3, V19.4S
    SHA1SU0  V18.4S, V27.4S, V29.4S
    SHA256H  Q28, Q2, V20.4S
    SHA1SU1  V0.4S, V13.4S
    SHA1C  Q25, S28, V0.4S
    SHA1SU1  V12.4S, V1.4S
    SHA256SU0  V11.4S, V14.4S
    SHA256H  Q15, Q17, V17.4S
    SHA256H  Q19, Q5, V12.4S
    SHA256H  Q30, Q19, V21.4S
    SHA1C  Q27, S30, V18.4S
    SHA1C  Q12, S25, V15.4S
    SHA256H  Q17, Q12, V11.4S
    SHA256H2  Q0, Q17, V7.4S
    SHA1M  Q3, S27, V0.4S
    SHA256H  Q26, Q3, V12.4S
    SHA256H2  Q8, Q20, V16.4S
    SHA1C  Q5, S12, V7.4S
    SHA256H  Q12, Q31, V26.4S
    SHA256H2  Q3, Q9, V27.4S
    SHA1SU0  V21.4S, V9.4S, V10.4S
    SHA1SU1  V14.4S, V0.4S
    SHA256SU1  V2.4S, V23.4S, V13.4S
    SHA256H  Q9, Q28, V31.4S
    SHA256H  Q27, Q4, V13.4S
    SHA1SU0  V17.4S, V2.4S, V9.4S
    SHA256H2  Q2, Q8, V14.4S
    SHA256SU0  V23.4S, V2.4S
    SHA256H  Q9, Q26, V5.4S
    SHA1M  Q8, S9, V9.4S
    SHA1SU1  V25.4S, V8.4S
    SHA256H  Q4, Q12, V23.4S
    SHA1SU1  V31.4S, V27.4S
    SHA1C  Q28, S21, V4.4S
    SHA256H  Q8, Q17, V28.4S
    SHA1M  Q19, S8, V3.4S
    SHA1P  Q12, S19, V25.4S
    SHA1SU1  V3.4S, V31.4S
    SHA1SU0  V26.4S, V22.4S, V12.4S
    SHA1M  Q4, S3, V26.4S
    SHA256SU0  V0.4S, V22.4S
    SHA256SU1  V21.4S, V21.4S, V25.4S
    SHA256H2  Q22, Q29, V19.4S
    SHA1M  Q8, S31, V18.4S
    SHA1P  Q9, S31, V30.4S
    SHA256H  Q17, Q23, V12.4S
    SHA1M  Q25, S25, V21.4S
    SHA1SU1  V29.4S, V19.4S
    SHA1C  Q18, S14, V5.4S
    SHA1SU1  V14.4S, V17.4S
    SHA256H2  Q17, Q22, V29.4S
    SHA1M  Q26, S0, V24.4S
    SHA1SU0  V5.4S, V4.4S, V14.4S
    SHA1SU1  V29.4S, V18.4S
    SHA1SU1  V22.4S, V29.4S
    SHA256H  Q3, Q25, V22.4S
    SHA1P  Q18, S3, V3.4S
    SHA1M  Q23, S26, V9.4S
    SHA256SU0  V30.4S, V8.4S
    SHA1C  Q29, S18, V5.4S
    SHA1C  Q22, S29, V29.4S
    SHA1SU1  V5.4S, V22.4S
    SHA1M  Q22, S30, V17.4S
    SHA1SU0  V19.4S, V5.4S, V23.4S
    SHA256SU1  V18.4S, V19.4S, V19.4S
    SHA256SU1  V0.4S, V22.4S, V22.4S
    SHA1SU0  V9.4S, V18.4S, V0.4S
    SHA1M  Q30, S30, V29.4S
    SHA256SU1  V0.4S, V1.4S, V2.4S
    SHA256H2  Q23, Q21, V10.4S
    SHA256SU0  V18.4S, V0.4S
    SHA256H2  Q5, Q10, V12.4S
    SHA1P  Q19, S5, V31.4S
    SHA1SU0  V17.4S, V27.4S, V3.4S
    SHA1M  Q3, S12, V14.4S
    SHA256SU1  V26.4S, V6.4S, V5.4S
    SHA256H  Q22, Q23, V20.4S
    SHA1C  Q8, S25, V6.4S
    SHA256SU1  V24.4S, V26.4S, V3.4S
    SHA256SU0  V4.4S, V17.4S
    SHA256SU0  V17.4S, V18.4S
    SHA256H  Q21, Q24, V30.4S
    SHA1C  Q25, S8, V9.4S
    SHA256H2  Q29, Q25, V4.4S
    SHA1M  Q25, S19, V19.4S
    SHA1SU1  V19.4S, V25.4S
    SHA256SU1  V10.4S, V20.4S, V19.4S
    SHA256SU0  V14.4S, V29.4S
    SHA256SU0  V25.4S, V17.4S
    SHA1C  Q29, S10, V25.4S
    SHA256SU1  V23.4S, V14.4S, V22.4S
    SHA1SU1  V14.4S, V21.4S
    SHA256SU1  V12.4S, V29.4S, V14.4S
    SHA1SU0  V17.4S, V12.4S, V23.4S
    SHA1SU1  V3.4S, V17.4S
    SHA256H2  Q19, Q17, V16.4S
    SHA1P  Q21, S27, V23.4S
    SHA256SU1  V20.4S, V6.4S, V10.4S
    SHA256SU0  V29.4S, V30.4S
    SHA1P  Q9, S6, V23.4S
    SHA1P  Q17, S13, V0.4S
    SHA256H2  Q13, Q5, V14.4S
    SHA1C  Q27, S25, V5.4S
    SHA1SU1  V22.4S, V27.4S
    SHA1SU0  V23.4S, V20.4S, V3.4S
    SHA1M  Q12, S13, V29.4S
    SHA1SU0  V4.4S, V17.4S, V19.4S
    SUBS  X28, X28, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_6
    MOVZ  X15, #0xf0a9, LSL #0
    MOVK  X15, #0x3a0b, LSL #16
    MOVK  X15, #0xd670, LSL #32
    MOVK  X15, #0x57f2, LSL #48
    SUB  X8, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x240, LSL #0
    MOVK  X15, #0xc978, LSL #16
    MOVK  X15, #0x7cae, LSL #32
    MOVK  X15, #0xc608, LSL #48
    SUB  X8, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xb, LSL #0
    MOVK  X15, #0x1fb3, LSL #16
    MOVK  X15, #0xcd8a, LSL #32
    MOVK  X15, #0x6b3c, LSL #48
    SUB  X8, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x9c49, LSL #0
    MOVK  X15, #0x193d, LSL #16
    MOVK  X15, #0x5e1d, LSL #32
    MOVK  X15, #0x6692, LSL #48
    SUB  X8, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xdd66, LSL #0
    MOVK  X15, #0x3f8c, LSL #16
    MOVK  X15, #0x7605, LSL #32
    MOVK  X15, #0xf7f0, LSL #48
    SUB  X8, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x67d6, LSL #0
    MOVK  X15, #0xd4c6, LSL #16
    MOVK  X15, #0x2c1e, LSL #32
    MOVK  X15, #0x67f0, LSL #48
    SUB  X8, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xece2, LSL #0
    MOVK  X15, #0x4532, LSL #16
    MOVK  X15, #0xb477, LSL #32
    MOVK  X15, #0xfef3, LSL #48
    SUB  X8, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x838, LSL #0
    MOVK  X15, #0x80dd, LSL #16
    MOVK  X15, #0x891e, LSL #32
    MOVK  X15, #0xfb71, LSL #48
    SUB  X8, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x69bc, LSL #0
    MOVK  X15, #0x6c41, LSL #16
    MOVK  X15, #0xac0a, LSL #32
    MOVK  X15, #0xeec5, LSL #48
    SUB  X8, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x877b, LSL #0
    MOVK  X15, #0x621a, LSL #16
    MOVK  X15, #0x95b3, LSL #32
    MOVK  X15, #0xba3e, LSL #48
    SUB  X8, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xbc3c, LSL #0
    MOVK  X15, #0xaace, LSL #16
    MOVK  X15, #0xa793, LSL #32
    MOVK  X15, #0x2043, LSL #48
    SUB  X8, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xe374, LSL #0
    MOVK  X15, #0xb6a7, LSL #16
    MOVK  X15, #0x53fd, LSL #32
    MOVK  X15, #0x139f, LSL #48
    SUB  X8, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xd8d9, LSL #0
    MOVK  X15, #0xf9d2, LSL #16
    MOVK  X15, #0x3507, LSL #32
    MOVK  X15, #0x180c, LSL #48
    SUB  X8, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x874, LSL #0
    MOVK  X15, #0xea23, LSL #16
    MOVK  X15, #0x442c, LSL #32
    MOVK  X15, #0x48a2, LSL #48
    SUB  X8, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xc141, LSL #0
    MOVK  X15, #0x4b49, LSL #16
    MOVK  X15, #0xb1e7, LSL #32
    MOVK  X15, #0xcefe, LSL #48
    SUB  X8, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xc1ad, LSL #0
    MOVK  X15, #0x6329, LSL #16
    MOVK  X15, #0x3bf, LSL #32
    MOVK  X15, #0xab8d, LSL #48
    SUB  X8, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x295a, LSL #0
    MOVK  X15, #0x1e85, LSL #16
    MOVK  X15, #0x23bb, LSL #32
    MOVK  X15, #0x3d10, LSL #48
    SUB  X8, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xea62, LSL #0
    MOVK  X15, #0x7702, LSL #16
    MOVK  X15, #0x7347, LSL #32
    MOVK  X15, #0xcd, LSL #48
    SUB  X8, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xe04d, LSL #0
    MOVK  X15, #0x31ee, LSL #16
    MOVK  X15, #0x55a5, LSL #32
    MOVK  X15, #0x9406, LSL #48
    SUB  X8, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x0, LSL #0
    SUB  X8, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xc96f, LSL #0
    MOVK  X15, #0xc32e, LSL #16
    MOVK  X15, #0x4f63, LSL #32
    MOVK  X15, #0x108a, LSL #48
    SUB  X8, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xadd6, LSL #0
    MOVK  X15, #0xf9ab, LSL #16
    MOVK  X15, #0xe410, LSL #32
    MOVK  X15, #0x3044, LSL #48
    FMOV  X8, V0.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x776, LSL #0
    MOVK  X15, #0xda7b, LSL #16
    MOVK  X15, #0xc585, LSL #32
    MOVK  X15, #0x655e, LSL #48
    FMOV  X8, D0
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xa4e9, LSL #0
    MOVK  X15, #0x7771, LSL #16
    MOVK  X15, #0x39f4, LSL #32
    MOVK  X15, #0xbf5d, LSL #48
    FMOV  X8, V1.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x8d01, LSL #0
    MOVK  X15, #0x4e75, LSL #16
    MOVK  X15, #0xaaa8, LSL #32
    MOVK  X15, #0xfbf5, LSL #48
    FMOV  X8, D1
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x2ac4, LSL #0
    MOVK  X15, #0x8d3d, LSL #16
    MOVK  X15, #0xfa35, LSL #32
    MOVK  X15, #0xfaf, LSL #48
    FMOV  X8, V2.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xec5b, LSL #0
    MOVK  X15, #0x5399, LSL #16
    MOVK  X15, #0xba79, LSL #32
    MOVK  X15, #0x91b1, LSL #48
    FMOV  X8, D2
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xb420, LSL #0
    MOVK  X15, #0x34c0, LSL #16
    MOVK  X15, #0xc404, LSL #32
    MOVK  X15, #0x201b, LSL #48
    FMOV  X8, V3.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xe8dc, LSL #0
    MOVK  X15, #0x395, LSL #16
    MOVK  X15, #0xe5fc, LSL #32
    MOVK  X15, #0x5719, LSL #48
    FMOV  X8, D3
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x9667, LSL #0
    MOVK  X15, #0x4f14, LSL #16
    MOVK  X15, #0xd930, LSL #32
    MOVK  X15, #0xec, LSL #48
    FMOV  X8, V4.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x8920, LSL #0
    MOVK  X15, #0xa087, LSL #16
    MOVK  X15, #0x3a2b, LSL #32
    MOVK  X15, #0xf5d7, LSL #48
    FMOV  X8, D4
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xbe43, LSL #0
    MOVK  X15, #0xe9c6, LSL #16
    MOVK  X15, #0x3fc, LSL #32
    MOVK  X15, #0xf529, LSL #48
    FMOV  X8, V5.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xd326, LSL #0
    MOVK  X15, #0x972c, LSL #16
    MOVK  X15, #0x67a2, LSL #32
    MOVK  X15, #0xcd03, LSL #48
    FMOV  X8, D5
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x874, LSL #0
    MOVK  X15, #0xea23, LSL #16
    MOVK  X15, #0x442c, LSL #32
    MOVK  X15, #0x48a2, LSL #48
    FMOV  X8, V6.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xf0a9, LSL #0
    MOVK  X15, #0x3a0b, LSL #16
    MOVK  X15, #0xd670, LSL #32
    MOVK  X15, #0x57f2, LSL #48
    FMOV  X8, D6
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x25f2, LSL #0
    MOVK  X15, #0xe632, LSL #16
    MOVK  X15, #0xdad7, LSL #32
    MOVK  X15, #0xdca1, LSL #48
    FMOV  X8, V7.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x96c8, LSL #0
    MOVK  X15, #0x80f8, LSL #16
    MOVK  X15, #0xf366, LSL #32
    MOVK  X15, #0x7720, LSL #48
    FMOV  X8, D7
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x555d, LSL #0
    MOVK  X15, #0x7098, LSL #16
    MOVK  X15, #0x648d, LSL #32
    MOVK  X15, #0x3eb1, LSL #48
    FMOV  X8, V8.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xd3fe, LSL #0
    MOVK  X15, #0x56e5, LSL #16
    MOVK  X15, #0xae7, LSL #32
    MOVK  X15, #0x743d, LSL #48
    FMOV  X8, D8
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xb1e5, LSL #0
    MOVK  X15, #0x96a9, LSL #16
    MOVK  X15, #0xf698, LSL #32
    MOVK  X15, #0x857b, LSL #48
    FMOV  X8, V9.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x678d, LSL #0
    MOVK  X15, #0x8510, LSL #16
    MOVK  X15, #0x7369, LSL #32
    MOVK  X15, #0xf002, LSL #48
    FMOV  X8, D9
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xda3f, LSL #0
    MOVK  X15, #0x6751, LSL #16
    MOVK  X15, #0x38dd, LSL #32
    MOVK  X15, #0x6a91, LSL #48
    FMOV  X8, V10.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x83c1, LSL #0
    MOVK  X15, #0xb815, LSL #16
    MOVK  X15, #0x7b7a, LSL #32
    MOVK  X15, #0xb2b3, LSL #48
    FMOV  X8, D10
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x22c5, LSL #0
    MOVK  X15, #0x8da5, LSL #16
    MOVK  X15, #0x9bd9, LSL #32
    MOVK  X15, #0x1390, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x3e47, LSL #0
    MOVK  X15, #0xf9da, LSL #16
    MOVK  X15, #0xc6cd, LSL #32
    MOVK  X15, #0xedfe, LSL #48
    FMOV  X8, D11
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x17a1, LSL #0
    MOVK  X15, #0xb7f0, LSL #16
    MOVK  X15, #0x46f3, LSL #32
    MOVK  X15, #0x44a5, LSL #48
    FMOV  X8, V12.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xaf36, LSL #0
    MOVK  X15, #0xd1d7, LSL #16
    MOVK  X15, #0xe46d, LSL #32
    MOVK  X15, #0x4225, LSL #48
    FMOV  X8, D12
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x3c08, LSL #0
    MOVK  X15, #0xe028, LSL #16
    MOVK  X15, #0x598f, LSL #32
    MOVK  X15, #0xdcb3, LSL #48
    FMOV  X8, V13.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xe40c, LSL #0
    MOVK  X15, #0xe1f7, LSL #16
    MOVK  X15, #0xfde6, LSL #32
    MOVK  X15, #0x2244, LSL #48
    FMOV  X8, D13
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x2b43, LSL #0
    MOVK  X15, #0xcc22, LSL #16
    MOVK  X15, #0x7cce, LSL #32
    MOVK  X15, #0x21bc, LSL #48
    FMOV  X8, V14.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xf135, LSL #0
    MOVK  X15, #0x1316, LSL #16
    MOVK  X15, #0x6598, LSL #32
    MOVK  X15, #0xe415, LSL #48
    FMOV  X8, D14
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x9ea, LSL #0
    MOVK  X15, #0x4033, LSL #16
    MOVK  X15, #0x375d, LSL #32
    MOVK  X15, #0xd6be, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xca7, LSL #0
    MOVK  X15, #0x2348, LSL #16
    MOVK  X15, #0xc378, LSL #32
    MOVK  X15, #0x30e, LSL #48
    FMOV  X8, D15
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x9c49, LSL #0
    MOVK  X15, #0x193d, LSL #16
    MOVK  X15, #0x5e1d, LSL #32
    MOVK  X15, #0x6692, LSL #48
    FMOV  X8, V16.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xc141, LSL #0
    MOVK  X15, #0x4b49, LSL #16
    MOVK  X15, #0xb1e7, LSL #32
    MOVK  X15, #0xcefe, LSL #48
    FMOV  X8, D16
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xbcb0, LSL #0
    MOVK  X15, #0x2ed4, LSL #16
    MOVK  X15, #0x2a48, LSL #32
    MOVK  X15, #0x66cf, LSL #48
    FMOV  X8, V17.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xd8fe, LSL #0
    MOVK  X15, #0x2f5c, LSL #16
    MOVK  X15, #0x65e9, LSL #32
    MOVK  X15, #0xdc85, LSL #48
    FMOV  X8, D17
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xb6b7, LSL #0
    MOVK  X15, #0xab73, LSL #16
    MOVK  X15, #0x8011, LSL #32
    MOVK  X15, #0xb9db, LSL #48
    FMOV  X8, V18.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x1490, LSL #0
    MOVK  X15, #0xb473, LSL #16
    MOVK  X15, #0x2588, LSL #32
    MOVK  X15, #0xb06a, LSL #48
    FMOV  X8, D18
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x9c86, LSL #0
    MOVK  X15, #0xdc53, LSL #16
    MOVK  X15, #0x4a18, LSL #32
    MOVK  X15, #0x849c, LSL #48
    FMOV  X8, V19.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x684a, LSL #0
    MOVK  X15, #0x34b1, LSL #16
    MOVK  X15, #0x3217, LSL #32
    MOVK  X15, #0x1e29, LSL #48
    FMOV  X8, D19
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xf61, LSL #0
    MOVK  X15, #0x9b4b, LSL #16
    MOVK  X15, #0xf59e, LSL #32
    MOVK  X15, #0xefc7, LSL #48
    FMOV  X8, V20.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x6b92, LSL #0
    MOVK  X15, #0x8f7a, LSL #16
    MOVK  X15, #0x9484, LSL #32
    MOVK  X15, #0xcd2f, LSL #48
    FMOV  X8, D20
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xca7d, LSL #0
    MOVK  X15, #0xd496, LSL #16
    MOVK  X15, #0xe034, LSL #32
    MOVK  X15, #0x8ea2, LSL #48
    FMOV  X8, V21.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x4810, LSL #0
    MOVK  X15, #0x8e60, LSL #16
    MOVK  X15, #0x3a4d, LSL #32
    MOVK  X15, #0xf600, LSL #48
    FMOV  X8, D21
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x7d0d, LSL #0
    MOVK  X15, #0xbb1e, LSL #16
    MOVK  X15, #0xa6ce, LSL #32
    MOVK  X15, #0xb7e3, LSL #48
    FMOV  X8, V22.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xfe47, LSL #0
    MOVK  X15, #0xc606, LSL #16
    MOVK  X15, #0x2551, LSL #32
    MOVK  X15, #0xaf9c, LSL #48
    FMOV  X8, D22
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x7c3f, LSL #0
    MOVK  X15, #0xdd3f, LSL #16
    MOVK  X15, #0x51c5, LSL #32
    MOVK  X15, #0xa5c2, LSL #48
    FMOV  X8, V23.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x1608, LSL #0
    MOVK  X15, #0x2ed2, LSL #16
    MOVK  X15, #0x14b2, LSL #32
    MOVK  X15, #0xe32a, LSL #48
    FMOV  X8, D23
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x1941, LSL #0
    MOVK  X15, #0xb6b0, LSL #16
    MOVK  X15, #0xf6dd, LSL #32
    MOVK  X15, #0x2094, LSL #48
    FMOV  X8, V24.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5970, LSL #0
    MOVK  X15, #0xd885, LSL #16
    MOVK  X15, #0x2d2a, LSL #32
    MOVK  X15, #0x6bc7, LSL #48
    FMOV  X8, D24
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x6800, LSL #0
    MOVK  X15, #0x2543, LSL #16
    MOVK  X15, #0xd062, LSL #32
    MOVK  X15, #0xe4f5, LSL #48
    FMOV  X8, V25.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xe62a, LSL #0
    MOVK  X15, #0xf01c, LSL #16
    MOVK  X15, #0x1dcb, LSL #32
    MOVK  X15, #0x61, LSL #48
    FMOV  X8, D25
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xf431, LSL #0
    MOVK  X15, #0x7992, LSL #16
    MOVK  X15, #0xdcab, LSL #32
    MOVK  X15, #0xe3bb, LSL #48
    FMOV  X8, V26.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x6b97, LSL #0
    MOVK  X15, #0x1533, LSL #16
    MOVK  X15, #0xb092, LSL #32
    MOVK  X15, #0x5b1e, LSL #48
    FMOV  X8, D26
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x1395, LSL #0
    MOVK  X15, #0x7c96, LSL #16
    MOVK  X15, #0xd3e9, LSL #32
    MOVK  X15, #0x5159, LSL #48
    FMOV  X8, V27.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xd1bd, LSL #0
    MOVK  X15, #0x13e4, LSL #16
    MOVK  X15, #0x287a, LSL #32
    MOVK  X15, #0x290d, LSL #48
    FMOV  X8, D27
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x2b37, LSL #0
    MOVK  X15, #0xe3ab, LSL #16
    MOVK  X15, #0x2aca, LSL #32
    MOVK  X15, #0x14c7, LSL #48
    FMOV  X8, V28.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x847d, LSL #0
    MOVK  X15, #0xae7, LSL #16
    MOVK  X15, #0x85f7, LSL #32
    MOVK  X15, #0x1446, LSL #48
    FMOV  X8, D28
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xf4d9, LSL #0
    MOVK  X15, #0x8721, LSL #16
    MOVK  X15, #0x3cf6, LSL #32
    MOVK  X15, #0xca8f, LSL #48
    FMOV  X8, V29.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x5fe, LSL #0
    MOVK  X15, #0x731b, LSL #16
    MOVK  X15, #0x57f7, LSL #32
    MOVK  X15, #0x3967, LSL #48
    FMOV  X8, D29
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x46a, LSL #0
    MOVK  X15, #0x69a3, LSL #16
    MOVK  X15, #0x3cc1, LSL #32
    MOVK  X15, #0x685e, LSL #48
    FMOV  X8, V30.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0x78c4, LSL #0
    MOVK  X15, #0xb7c6, LSL #16
    MOVK  X15, #0x826e, LSL #32
    MOVK  X15, #0xac86, LSL #48
    FMOV  X8, D30
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xbdc0, LSL #0
    MOVK  X15, #0x6963, LSL #16
    MOVK  X15, #0xa9ce, LSL #32
    MOVK  X15, #0x7856, LSL #48
    FMOV  X8, V31.D[1]
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X15, #0xd7ab, LSL #0
    MOVK  X15, #0xa440, LSL #16
    MOVK  X15, #0x37d6, LSL #32
    MOVK  X15, #0xa3e1, LSL #48
    FMOV  X8, D31
    SUB  X17, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X9
    FMOV  V0.D[1], X20
    FMOV  D1, X21
    FMOV  V1.D[1], X27
    FMOV  D2, X14
    FMOV  V2.D[1], X13
    FMOV  D3, X25
    FMOV  V3.D[1], X24
    FMOV  D4, X16
    FMOV  V4.D[1], X28
    FMOV  D5, X18
    FMOV  V5.D[1], X15
    FMOV  D6, X12
    FMOV  V6.D[1], X29
    FMOV  D7, X22
    FMOV  V7.D[1], X18
    FMOV  D8, X14
    FMOV  V8.D[1], X27
    FMOV  D9, X18
    FMOV  V9.D[1], X13
    FMOV  D10, X19
    FMOV  V10.D[1], X2
    FMOV  D11, X29
    FMOV  V11.D[1], X19
    FMOV  D12, X12
    FMOV  V12.D[1], X28
    FMOV  D13, X10
    FMOV  V13.D[1], X20
    FMOV  D14, X6
    FMOV  V14.D[1], X3
    FMOV  D15, X15
    FMOV  V15.D[1], X6
    FMOV  D16, X29
    FMOV  V16.D[1], X6
    FMOV  D17, X21
    FMOV  V17.D[1], X5
    FMOV  D18, X29
    FMOV  V18.D[1], X14
    FMOV  D19, X8
    FMOV  V19.D[1], X25
    FMOV  D20, X14
    FMOV  V20.D[1], X3
    FMOV  D21, X25
    FMOV  V21.D[1], X22
    FMOV  D22, X2
    FMOV  V22.D[1], X11
    FMOV  D23, X10
    FMOV  V23.D[1], X12
    FMOV  D24, X21
    FMOV  V24.D[1], X20
    FMOV  D25, X5
    FMOV  V25.D[1], X5
    FMOV  D26, X29
    FMOV  V26.D[1], X11
    FMOV  D27, X18
    FMOV  V27.D[1], X28
    FMOV  D28, X9
    FMOV  V28.D[1], X14
    FMOV  D29, X20
    FMOV  V29.D[1], X21
    FMOV  D30, X21
    FMOV  V30.D[1], X13
    FMOV  D31, X3
    FMOV  V31.D[1], X2
    MOVZ  X10, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_7:
    SHA1SU1  V30.4S, V27.4S
    SHA1SU1  V13.4S, V23.4S
    SHA256H  Q26, Q19, V26.4S
    SHA1C  Q20, S25, V31.4S
    SHA1C  Q21, S29, V13.4S
    SHA256SU0  V16.4S, V26.4S
    SHA1M  Q5, S28, V30.4S
    SHA1C  Q5, S20, V5.4S
    SHA256H2  Q6, Q22, V16.4S
    SHA1SU0  V21.4S, V24.4S, V21.4S
    SHA1SU0  V26.4S, V21.4S, V21.4S
    SHA1M  Q12, S6, V26.4S
    SHA1C  Q22, S12, V12.4S
    SHA256SU1  V27.4S, V23.4S, V5.4S
    SHA1SU1  V16.4S, V27.4S
    SHA256SU0  V6.4S, V22.4S
    SHA1SU0  V21.4S, V19.4S, V6.4S
    SHA1SU1  V31.4S, V21.4S
    SHA1C  Q30, S16, V16.4S
    SHA1P  Q16, S31, V31.4S
    SHA1P  Q24, S27, V30.4S
    SHA256SU0  V20.4S, V24.4S
    SHA256H2  Q28, Q20, V13.4S
    SHA256H  Q26, Q28, V16.4S
    SHA1C  Q25, S15, V10.4S
    SHA1SU0  V24.4S, V17.4S, V5.4S
    SHA256SU1  V6.4S, V10.4S, V12.4S
    SHA1P  Q12, S27, V23.4S
    SHA1SU0  V10.4S, V31.4S, V0.4S
    SHA1SU0  V22.4S, V8.4S, V11.4S
    SHA1M  Q19, S25, V11.4S
    SHA1SU0  V8.4S, V15.4S, V11.4S
    SHA256H  Q11, Q5, V11.4S
    SHA1C  Q23, S11, V26.4S
    SHA256SU1  V11.4S, V24.4S, V24.4S
    SHA256SU1  V26.4S, V11.4S, V8.4S
    SHA1SU0  V31.4S, V26.4S, V3.4S
    SHA1M  Q16, S6, V27.4S
    SHA1C  Q21, S12, V12.4S
    SHA1SU1  V15.4S, V31.4S
    SHA1M  Q28, S21, V10.4S
    SHA256SU0  V21.4S, V15.4S
    SHA1SU0  V5.4S, V19.4S, V21.4S
    SHA1M  Q25, S5, V22.4S
    SHA1SU0  V5.4S, V23.4S, V16.4S
    SHA256H  Q24, Q17, V25.4S
    SHA256SU1  V31.4S, V28.4S, V24.4S
    SHA1C  Q6, S5, V31.4S
    SHA256SU1  V22.4S, V3.4S, V22.4S
    SHA1SU1  V0.4S, V25.4S
    SHA1C  Q17, S11, V21.4S
    SHA256SU0  V12.4S, V30.4S
    SHA1P  Q27, S15, V22.4S
    SHA256SU0  V25.4S, V1.4S
    SHA256SU0  V19.4S, V10.4S
    SHA1SU1  V31.4S, V12.4S
    SHA1C  Q1, S23, V6.4S
    SHA256SU1  V22.4S, V18.4S, V4.4S
    SHA1SU0  V16.4S, V26.4S, V26.4S
    SHA1P  Q4, S27, V19.4S
    SHA256SU1  V11.4S, V16.4S, V4.4S
    SHA256H  Q3, Q22, V0.4S
    SHA256SU1  V12.4S, V17.4S, V31.4S
    SHA1SU0  V0.4S, V11.4S, V4.4S
    SHA1SU0  V16.4S, V0.4S, V1.4S
    SHA256H2  Q1, Q12, V12.4S
    SHA256H2  Q31, Q25, V16.4S
    SHA1P  Q17, S3, V1.4S
    SHA1SU1  V28.4S, V17.4S
    SHA256SU0  V21.4S, V31.4S
    SHA1SU0  V31.4S, V28.4S, V21.4S
    SHA1P  Q30, S1, V7.4S
    SHA1P  Q27, S18, V5.4S
    SHA1M  Q24, S24, V7.4S
    SHA1SU1  V7.4S, V23.4S
    SHA256H2  Q26, Q15, V4.4S
    SHA1SU1  V10.4S, V14.4S
    SHA256SU1  V4.4S, V11.4S, V4.4S
    SHA1C  Q3, S0, V23.4S
    SHA1C  Q25, S27, V30.4S
    SHA1SU0  V11.4S, V24.4S, V10.4S
    SHA1SU1  V24.4S, V26.4S
    SHA256SU1  V28.4S, V4.4S, V7.4S
    SHA256SU1  V12.4S, V11.4S, V31.4S
    SHA1M  Q17, S3, V3.4S
    SHA1SU0  V21.4S, V25.4S, V25.4S
    SHA1C  Q5, S28, V2.4S
    SHA1P  Q23, S5, V21.4S
    SHA1M  Q18, S17, V7.4S
    SHA256H2  Q26, Q24, V18.4S
    SHA1C  Q5, S26, V12.4S
    SHA256H  Q24, Q5, V23.4S
    SHA256H2  Q12, Q30, V17.4S
    SHA256H  Q0, Q18, V8.4S
    SHA1SU1  V10.4S, V31.4S
    SHA1M  Q27, S11, V1.4S
    SHA256H  Q8, Q25, V29.4S
    SHA1M  Q1, S14, V17.4S
    SHA256SU0  V4.4S, V24.4S
    SHA1P  Q24, S12, V3.4S
    SHA1SU1  V3.4S, V26.4S
    SHA1SU1  V26.4S, V14.4S
    SHA1P  Q18, S27, V0.4S
    SHA256SU0  V15.4S, V4.4S
    SHA1SU1  V21.4S, V15.4S
    SHA1SU0  V28.4S, V10.4S, V22.4S
    SHA1SU1  V28.4S, V21.4S
    SHA1SU0  V21.4S, V28.4S, V18.4S
    SHA1M  Q12, S21, V26.4S
    SHA1M  Q31, S12, V3.4S
    SHA1SU0  V28.4S, V8.4S, V1.4S
    SHA256SU1  V10.4S, V24.4S, V31.4S
    SHA256SU1  V14.4S, V10.4S, V10.4S
    SHA256H2  Q17, Q28, V28.4S
    SHA1P  Q18, S14, V14.4S
    SHA1P  Q29, S2, V17.4S
    SHA256SU1  V28.4S, V18.4S, V29.4S
    SHA256SU1  V25.4S, V28.4S, V5.4S
    SHA1SU0  V8.4S, V23.4S, V20.4S
    SHA256H  Q28, Q4, V6.4S
    SHA1SU0  V21.4S, V19.4S, V25.4S
    SHA256H2  Q26, Q31, V3.4S
    SHA1P  Q12, S1, V8.4S
    SHA256SU1  V22.4S, V7.4S, V18.4S
    SHA256SU0  V8.4S, V31.4S
    SHA1SU1  V0.4S, V23.4S
    SHA1C  Q1, S10, V0.4S
    SHA256H  Q3, Q23, V11.4S
    SHA256H  Q2, Q26, V2.4S
    SHA256H2  Q5, Q31, V27.4S
    SHA1P  Q24, S28, V5.4S
    SHA1C  Q25, S24, V21.4S
    SHA256H  Q18, Q8, V3.4S
    SHA256SU1  V26.4S, V25.4S, V22.4S
    SHA1SU0  V20.4S, V10.4S, V2.4S
    SHA1P  Q28, S20, V18.4S
    SHA256H  Q4, Q26, V25.4S
    SHA1M  Q24, S28, V29.4S
    SHA256H  Q19, Q12, V4.4S
    SHA256SU1  V27.4S, V19.4S, V9.4S
    SHA1P  Q22, S1, V24.4S
    SHA1SU1  V3.4S, V22.4S
    SHA1SU1  V29.4S, V3.4S
    SHA1SU1  V22.4S, V27.4S
    SHA1P  Q21, S29, V29.4S
    SHA1P  Q2, S0, V23.4S
    SHA1P  Q20, S2, V22.4S
    SHA256SU0  V22.4S, V21.4S
    SHA256SU1  V26.4S, V22.4S, V20.4S
    SHA1P  Q5, S12, V8.4S
    SHA1SU1  V10.4S, V19.4S
    SHA1SU1  V20.4S, V14.4S
    SHA256H  Q7, Q10, V23.4S
    SHA1M  Q31, S15, V27.4S
    SHA1P  Q21, S1, V7.4S
    SHA256H  Q11, Q23, V6.4S
    SHA256H  Q19, Q6, V1.4S
    SHA256H2  Q27, Q14, V8.4S
    SHA256H2  Q14, Q17, V1.4S
    SHA1P  Q25, S14, V11.4S
    SHA256SU0  V8.4S, V26.4S
    SHA256SU0  V26.4S, V5.4S
    SHA1SU1  V2.4S, V20.4S
    SHA1SU1  V7.4S, V31.4S
    SHA256SU0  V12.4S, V21.4S
    SHA256SU1  V31.4S, V31.4S, V12.4S
    SHA256SU1  V22.4S, V19.4S, V19.4S
    SHA256SU0  V28.4S, V27.4S
    SHA1SU0  V10.4S, V25.4S, V28.4S
    SHA1SU0  V9.4S, V7.4S, V10.4S
    SHA1C  Q14, S8, V9.4S
    SHA1M  Q27, S17, V26.4S
    SHA256H  Q17, Q27, V14.4S
    SHA256H2  Q14, Q2, V2.4S
    SHA1C  Q1, S31, V4.4S
    SHA1M  Q27, S22, V22.4S
    SHA1M  Q5, S17, V14.4S
    SHA1SU0  V20.4S, V27.4S, V27.4S
    SHA256H2  Q19, Q1, V18.4S
    SHA256H2  Q12, Q5, V19.4S
    SHA256SU0  V14.4S, V12.4S
    SHA1C  Q9, S20, V20.4S
    SHA256SU0  V25.4S, V27.4S
    SHA1C  Q22, S14, V14.4S
    SHA1SU1  V26.4S, V9.4S
    SHA256H2  Q2, Q26, V26.4S
    SHA1M  Q31, S2, V25.4S
    SHA256SU0  V28.4S, V31.4S
    SHA256H  Q7, Q28, V23.4S
    SHA256H2  Q14, Q22, V22.4S
    SHA256H  Q18, Q7, V16.4S
    SHA1C  Q2, S18, V18.4S
    SHA1SU0  V17.4S, V14.4S, V2.4S
    SHA256SU0  V28.4S, V8.4S
    SHA1M  Q8, S23, V2.4S
    SHA256H2  Q5, Q4, V16.4S
    SHA1C  Q12, S16, V5.4S
    SHA1SU1  V10.4S, V5.4S
    SHA1SU0  V7.4S, V15.4S, V12.4S
    SHA1P  Q5, S7, V4.4S
    SUBS  X10, X10, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_7
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X9, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D0
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D1
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D2
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D3
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D4
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D5
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D6
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D7
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D9
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D10
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D11
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D12
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D13
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D14
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D15
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D16
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D17
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D18
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D19
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D20
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D21
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D22
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D23
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D24
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D25
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D26
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D27
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D28
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D29
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D30
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D31
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  V1.D[1], X22
    FMOV  D2, X25
    FMOV  V2.D[1], X20
    FMOV  D3, X9
    FMOV  V3.D[1], X9
    FMOV  D4, X10
    FMOV  V4.D[1], X15
    FMOV  D5, X22
    FMOV  V5.D[1], X17
    FMOV  D6, X16
    FMOV  V6.D[1], X5
    FMOV  D7, X3
    FMOV  V7.D[1], X11
    FMOV  D8, X13
    FMOV  V8.D[1], X19
    FMOV  D9, X21
    FMOV  V9.D[1], X15
    FMOV  D10, X20
    FMOV  V10.D[1], X16
    FMOV  D11, X25
    FMOV  V11.D[1], X14
    FMOV  D12, X13
    FMOV  V12.D[1], X18
    FMOV  D13, X11
    FMOV  V13.D[1], X15
    FMOV  D14, X11
    FMOV  V14.D[1], X18
    FMOV  D15, X29
    FMOV  V15.D[1], X15
    FMOV  D16, X27
    FMOV  V16.D[1], X20
    FMOV  D17, X3
    FMOV  V17.D[1], X13
    FMOV  D18, X2
    FMOV  V18.D[1], X27
    FMOV  D19, X15
    FMOV  V19.D[1], X10
    FMOV  D20, X13
    FMOV  V20.D[1], X16
    FMOV  D21, X27
    FMOV  V21.D[1], X27
    FMOV  D22, X28
    FMOV  V22.D[1], X15
    FMOV  D23, X25
    FMOV  V23.D[1], X11
    FMOV  D24, X29
    FMOV  V24.D[1], X22
    FMOV  D25, X20
    FMOV  V25.D[1], X24
    FMOV  D26, X27
    FMOV  V26.D[1], X12
    FMOV  D27, X11
    FMOV  V27.D[1], X15
    FMOV  D28, X22
    FMOV  V28.D[1], X9
    FMOV  D29, X15
    FMOV  V29.D[1], X17
    FMOV  D30, X2
    FMOV  V30.D[1], X2
    FMOV  D31, X18
    FMOV  V31.D[1], X8
    MOVZ  X14, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_8:
    SHA256H2  Q19, Q24, V27.4S
    SHA1C  Q5, S30, V26.4S
    SHA1M  Q26, S19, V31.4S
    SHA1SU1  V29.4S, V26.4S
    SHA256H2  Q19, Q5, V5.4S
    SHA256H2  Q21, Q19, V20.4S
    SHA1SU0  V10.4S, V22.4S, V25.4S
    SHA256SU1  V21.4S, V10.4S, V29.4S
    SHA256SU1  V21.4S, V28.4S, V21.4S
    SHA1SU0  V9.4S, V21.4S, V23.4S
    SHA256SU0  V26.4S, V27.4S
    SHA256H  Q5, Q14, V9.4S
    SHA256SU0  V21.4S, V24.4S
    SHA256SU0  V14.4S, V18.4S
    SHA1P  Q29, S29, V26.4S
    SHA1C  Q18, S12, V20.4S
    SHA256H2  Q9, Q0, V18.4S
    SHA1SU0  V31.4S, V27.4S, V18.4S
    SHA1SU1  V10.4S, V2.4S
    SHA1M  Q2, S31, V15.4S
    SHA1P  Q15, S28, V27.4S
    SHA1C  Q25, S26, V17.4S
    SHA256H2  Q31, Q25, V2.4S
    SHA1M  Q23, S5, V5.4S
    SHA1P  Q26, S10, V31.4S
    SHA1M  Q17, S29, V9.4S
    SHA1M  Q12, S26, V26.4S
    SHA1SU0  V18.4S, V15.4S, V12.4S
    SHA1M  Q26, S18, V17.4S
    SHA1M  Q0, S29, V26.4S
    SHA256H2  Q30, Q0, V0.4S
    SHA256SU1  V24.4S, V24.4S, V30.4S
    SHA1C  Q31, S14, V23.4S
    SHA1SU1  V9.4S, V24.4S
    SHA256H  Q10, Q9, V21.4S
    SHA1SU1  V22.4S, V10.4S
    SHA1M  Q10, S31, V22.4S
    SHA256SU1  V2.4S, V1.4S, V17.4S
    SHA256H2  Q14, Q12, V30.4S
    SHA1P  Q25, S8, V4.4S
    SHA256SU1  V21.4S, V31.4S, V4.4S
    SHA256H  Q5, Q22, V9.4S
    SHA1C  Q4, S2, V9.4S
    SHA1P  Q1, S30, V11.4S
    SHA1SU0  V12.4S, V9.4S, V25.4S
    SHA1SU1  V26.4S, V29.4S
    SHA1C  Q15, S8, V9.4S
    SHA256SU0  V23.4S, V5.4S
    SHA1SU0  V28.4S, V12.4S, V26.4S
    SHA256H  Q31, Q14, V15.4S
    SHA1P  Q27, S4, V23.4S
    SHA1SU0  V30.4S, V27.4S, V21.4S
    SHA1P  Q9, S28, V22.4S
    SHA1M  Q14, S8, V31.4S
    SHA1P  Q28, S1, V10.4S
    SHA256SU1  V22.4S, V9.4S, V9.4S
    SHA1SU0  V25.4S, V22.4S, V22.4S
    SHA1M  Q15, S25, V28.4S
    SHA256H2  Q22, Q15, V15.4S
    SHA1P  Q15, S22, V22.4S
    SHA256H  Q5, Q30, V15.4S
    SHA1SU1  V26.4S, V14.4S
    SHA1M  Q25, S5, V30.4S
    SHA1SU0  V14.4S, V25.4S, V25.4S
    SHA1P  Q30, S26, V26.4S
    SHA1C  Q9, S14, V30.4S
    SHA1M  Q23, S5, V11.4S
    SHA1SU0  V22.4S, V9.4S, V5.4S
    SHA1SU0  V26.4S, V20.4S, V29.4S
    SHA256H  Q30, Q21, V16.4S
    SHA256H  Q11, Q23, V29.4S
    SHA1SU0  V27.4S, V26.4S, V26.4S
    SHA256SU0  V25.4S, V10.4S
    SHA1SU0  V5.4S, V29.4S, V15.4S
    SHA1SU0  V29.4S, V22.4S, V3.4S
    SHA1SU0  V14.4S, V25.4S, V18.4S
    SHA256H2  Q20, Q21, V17.4S
    SHA1SU1  V18.4S, V28.4S
    SHA256H2  Q9, Q26, V14.4S
    SHA256SU1  V16.4S, V15.4S, V31.4S
    SHA1SU0  V25.4S, V30.4S, V16.4S
    SHA1SU0  V15.4S, V18.4S, V29.4S
    SHA256SU0  V3.4S, V20.4S
    SHA256H2  Q17, Q3, V9.4S
    SHA1M  Q22, S5, V17.4S
    SHA256SU0  V31.4S, V22.4S
    SHA1M  Q21, S25, V27.4S
    SHA1P  Q10, S15, V21.4S
    SHA256H  Q26, Q11, V31.4S
    SHA1SU0  V17.4S, V26.4S, V26.4S
    SHA1C  Q28, S10, V17.4S
    SHA1P  Q11, S22, V24.4S
    SHA256SU0  V14.4S, V0.4S
    SHA1SU1  V5.4S, V28.4S
    SHA1P  Q17, S17, V13.4S
    SHA256H  Q23, Q10, V17.4S
    SHA256SU1  V27.4S, V9.4S, V9.4S
    SHA256SU1  V25.4S, V5.4S, V8.4S
    SHA256SU0  V28.4S, V2.4S
    SHA256SU1  V22.4S, V24.4S, V22.4S
    SHA1C  Q13, S1, V31.4S
    SHA1SU0  V26.4S, V29.4S, V30.4S
    SHA1SU1  V21.4S, V22.4S
    SHA1P  Q10, S11, V13.4S
    SHA256SU0  V16.4S, V23.4S
    SHA1SU0  V8.4S, V12.4S, V25.4S
    SHA1SU0  V0.4S, V28.4S, V25.4S
    SHA1M  Q17, S16, V26.4S
    SHA1C  Q5, S17, V12.4S
    SHA1SU0  V28.4S, V8.4S, V0.4S
    SHA256H2  Q24, Q5, V10.4S
    SHA256H  Q3, Q14, V27.4S
    SHA256H  Q5, Q21, V24.4S
    SHA256H  Q17, Q28, V3.4S
    SHA1P  Q12, S17, V11.4S
    SHA1P  Q2, S5, V12.4S
    SHA1P  Q16, S5, V26.4S
    SHA256H2  Q26, Q27, V2.4S
    SHA256H  Q30, Q30, V23.4S
    SHA256H  Q0, Q10, V19.4S
    SHA1SU1  V21.4S, V0.4S
    SHA256H  Q8, Q13, V9.4S
    SHA1C  Q25, S5, V10.4S
    SHA1C  Q22, S15, V14.4S
    SHA1SU0  V15.4S, V17.4S, V0.4S
    SHA1C  Q9, S23, V25.4S
    SHA1P  Q24, S25, V14.4S
    SHA256SU1  V19.4S, V9.4S, V8.4S
    SHA1SU0  V8.4S, V22.4S, V26.4S
    SHA1SU1  V28.4S, V8.4S
    SHA1SU0  V3.4S, V16.4S, V10.4S
    SHA1C  Q12, S21, V24.4S
    SHA1P  Q5, S28, V14.4S
    SHA1P  Q30, S5, V5.4S
    SHA1SU1  V5.4S, V30.4S
    SHA1M  Q30, S19, V1.4S
    SHA1P  Q0, S30, V15.4S
    SHA256SU0  V9.4S, V0.4S
    SHA256H2  Q24, Q5, V5.4S
    SHA256H2  Q27, Q9, V19.4S
    SHA256H  Q1, Q24, V24.4S
    SHA256H  Q17, Q12, V3.4S
    SHA1M  Q14, S27, V1.4S
    SHA1SU0  V28.4S, V14.4S, V17.4S
    SHA256H2  Q22, Q9, V5.4S
    SHA1SU1  V5.4S, V30.4S
    SHA256H  Q13, Q25, V11.4S
    SHA256SU0  V17.4S, V3.4S
    SHA1C  Q27, S25, V8.4S
    SHA256SU1  V15.4S, V16.4S, V21.4S
    SHA1P  Q24, S10, V24.4S
    SHA1SU0  V11.4S, V30.4S, V29.4S
    SHA1C  Q21, S31, V13.4S
    SHA1P  Q14, S22, V28.4S
    SHA256SU1  V10.4S, V27.4S, V11.4S
    SHA1SU1  V16.4S, V15.4S
    SHA1M  Q13, S24, V16.4S
    SHA256H2  Q29, Q13, V10.4S
    SHA1P  Q9, S29, V5.4S
    SHA1P  Q25, S21, V9.4S
    SHA1SU0  V15.4S, V25.4S, V25.4S
    SHA256SU0  V30.4S, V17.4S
    SHA256H  Q24, Q30, V14.4S
    SHA256SU1  V31.4S, V15.4S, V15.4S
    SHA1SU1  V19.4S, V31.4S
    SHA1SU1  V8.4S, V24.4S
    SHA1P  Q24, S19, V8.4S
    SHA256SU0  V28.4S, V27.4S
    SHA256SU1  V8.4S, V6.4S, V15.4S
    SHA256SU0  V19.4S, V17.4S
    SHA256SU1  V3.4S, V30.4S, V31.4S
    SHA1C  Q25, S12, V9.4S
    SHA256SU1  V14.4S, V0.4S, V8.4S
    SHA256SU0  V21.4S, V17.4S
    SHA1C  Q22, S16, V27.4S
    SHA1C  Q6, S20, V15.4S
    SHA256SU1  V11.4S, V3.4S, V19.4S
    SHA256SU0  V29.4S, V24.4S
    SHA1C  Q15, S21, V11.4S
    SHA1SU1  V16.4S, V28.4S
    SHA1SU1  V30.4S, V16.4S
    SHA256SU1  V28.4S, V30.4S, V14.4S
    SHA256SU1  V20.4S, V29.4S, V28.4S
    SHA1P  Q31, S6, V6.4S
    SHA1SU0  V8.4S, V15.4S, V22.4S
    SHA256H2  Q28, Q8, V9.4S
    SHA1SU0  V29.4S, V28.4S, V31.4S
    SHA1P  Q30, S25, V20.4S
    SHA1M  Q6, S23, V30.4S
    SHA256H  Q28, Q29, V21.4S
    SHA1M  Q3, S6, V1.4S
    SHA1SU0  V24.4S, V28.4S, V3.4S
    SHA256H  Q27, Q14, V27.4S
    SHA256SU1  V21.4S, V27.4S, V14.4S
    SHA1SU1  V11.4S, V28.4S
    SHA256H2  Q19, Q16, V14.4S
    SHA1M  Q16, S19, V12.4S
    SHA1M  Q31, S13, V31.4S
    SHA1SU0  V29.4S, V15.4S, V7.4S
    SHA256H2  Q17, Q20, V9.4S
    SUBS  X14, X14, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_8
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x0, LSL #0
    SUB  X9, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    SUB  X9, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x3aa2, LSL #0
    MOVK  X3, #0xbadf, LSL #16
    MOVK  X3, #0x1d36, LSL #32
    MOVK  X3, #0xa703, LSL #48
    FMOV  X9, V0.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x627e, LSL #0
    MOVK  X3, #0x5c23, LSL #16
    MOVK  X3, #0xf5b8, LSL #32
    MOVK  X3, #0x1c29, LSL #48
    FMOV  X9, D0
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x2b0e, LSL #0
    MOVK  X3, #0xc352, LSL #16
    MOVK  X3, #0x33fd, LSL #32
    MOVK  X3, #0xf995, LSL #48
    FMOV  X9, V1.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x3b8b, LSL #0
    MOVK  X3, #0xbbe9, LSL #16
    MOVK  X3, #0xfb11, LSL #32
    MOVK  X3, #0x44fc, LSL #48
    FMOV  X9, D1
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xc755, LSL #0
    MOVK  X3, #0x7ce6, LSL #16
    MOVK  X3, #0xa2a, LSL #32
    MOVK  X3, #0x95cc, LSL #48
    FMOV  X9, V2.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xfc51, LSL #0
    MOVK  X3, #0xc2a4, LSL #16
    MOVK  X3, #0xaee6, LSL #32
    MOVK  X3, #0xb32b, LSL #48
    FMOV  X9, D2
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x45d, LSL #0
    MOVK  X3, #0x751b, LSL #16
    MOVK  X3, #0x7c34, LSL #32
    MOVK  X3, #0x46d6, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xa70c, LSL #0
    MOVK  X3, #0xb3c7, LSL #16
    MOVK  X3, #0x6d04, LSL #32
    MOVK  X3, #0x1242, LSL #48
    FMOV  X9, D3
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x8584, LSL #0
    MOVK  X3, #0x5476, LSL #16
    MOVK  X3, #0x1b11, LSL #32
    MOVK  X3, #0xdd0d, LSL #48
    FMOV  X9, V4.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xb929, LSL #0
    MOVK  X3, #0x353e, LSL #16
    MOVK  X3, #0x1373, LSL #32
    MOVK  X3, #0x779c, LSL #48
    FMOV  X9, D4
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xac7d, LSL #0
    MOVK  X3, #0x960f, LSL #16
    MOVK  X3, #0xbe9, LSL #32
    MOVK  X3, #0x96fb, LSL #48
    FMOV  X9, V5.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xfadb, LSL #0
    MOVK  X3, #0x997, LSL #16
    MOVK  X3, #0x84c4, LSL #32
    MOVK  X3, #0x3f48, LSL #48
    FMOV  X9, D5
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x1983, LSL #0
    MOVK  X3, #0x55d7, LSL #16
    MOVK  X3, #0x638b, LSL #32
    MOVK  X3, #0xf94, LSL #48
    FMOV  X9, V6.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x51fc, LSL #0
    MOVK  X3, #0x62e1, LSL #16
    MOVK  X3, #0xcba9, LSL #32
    MOVK  X3, #0xde74, LSL #48
    FMOV  X9, D6
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    FMOV  X9, V7.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xffff, LSL #0
    MOVK  X3, #0xffff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    FMOV  X9, D7
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xadb, LSL #0
    MOVK  X3, #0xda3c, LSL #16
    MOVK  X3, #0xdcac, LSL #32
    MOVK  X3, #0xff20, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xe6a5, LSL #0
    MOVK  X3, #0x1557, LSL #16
    MOVK  X3, #0x176a, LSL #32
    MOVK  X3, #0x7cf3, LSL #48
    FMOV  X9, D8
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x38ff, LSL #0
    MOVK  X3, #0xfe0b, LSL #16
    MOVK  X3, #0xd011, LSL #32
    MOVK  X3, #0x7296, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x95aa, LSL #0
    MOVK  X3, #0x36f6, LSL #16
    MOVK  X3, #0xd53, LSL #32
    MOVK  X3, #0xc6f0, LSL #48
    FMOV  X9, D9
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xe77c, LSL #0
    MOVK  X3, #0xed5, LSL #16
    MOVK  X3, #0x3a26, LSL #32
    MOVK  X3, #0x8737, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x8ed0, LSL #0
    MOVK  X3, #0xc675, LSL #16
    MOVK  X3, #0x3267, LSL #32
    MOVK  X3, #0x408c, LSL #48
    FMOV  X9, D10
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x8135, LSL #0
    MOVK  X3, #0x1817, LSL #16
    MOVK  X3, #0x9a67, LSL #32
    MOVK  X3, #0x5d7, LSL #48
    FMOV  X9, V11.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x60a9, LSL #0
    MOVK  X3, #0xcb74, LSL #16
    MOVK  X3, #0x6f7e, LSL #32
    MOVK  X3, #0xc9b5, LSL #48
    FMOV  X9, D11
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x7e2d, LSL #0
    MOVK  X3, #0x4274, LSL #16
    MOVK  X3, #0x8292, LSL #32
    MOVK  X3, #0x5299, LSL #48
    FMOV  X9, V12.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x2cd7, LSL #0
    MOVK  X3, #0xff91, LSL #16
    MOVK  X3, #0x2601, LSL #32
    MOVK  X3, #0xc5bb, LSL #48
    FMOV  X9, D12
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x287d, LSL #0
    MOVK  X3, #0x4385, LSL #16
    MOVK  X3, #0x956d, LSL #32
    MOVK  X3, #0xb192, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xae0a, LSL #0
    MOVK  X3, #0x4ade, LSL #16
    MOVK  X3, #0xc8b3, LSL #32
    MOVK  X3, #0x2cb2, LSL #48
    FMOV  X9, D13
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x589d, LSL #0
    MOVK  X3, #0x7ac1, LSL #16
    MOVK  X3, #0xe27f, LSL #32
    MOVK  X3, #0x2de5, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x9d6e, LSL #0
    MOVK  X3, #0x9f9b, LSL #16
    MOVK  X3, #0xb958, LSL #32
    MOVK  X3, #0xd16b, LSL #48
    FMOV  X9, D14
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xf5a0, LSL #0
    MOVK  X3, #0x6fd7, LSL #16
    MOVK  X3, #0x8c1c, LSL #32
    MOVK  X3, #0x5f15, LSL #48
    FMOV  X9, V15.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xe295, LSL #0
    MOVK  X3, #0xd939, LSL #16
    MOVK  X3, #0x356e, LSL #32
    MOVK  X3, #0x1405, LSL #48
    FMOV  X9, D15
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x8232, LSL #0
    MOVK  X3, #0x2392, LSL #16
    MOVK  X3, #0x3608, LSL #32
    MOVK  X3, #0x693d, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x16c2, LSL #0
    MOVK  X3, #0xa929, LSL #16
    MOVK  X3, #0xf34b, LSL #32
    MOVK  X3, #0xa0c2, LSL #48
    FMOV  X9, D16
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x6f1, LSL #0
    MOVK  X3, #0x1c8b, LSL #16
    MOVK  X3, #0x41fa, LSL #32
    MOVK  X3, #0x1b32, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x3963, LSL #0
    MOVK  X3, #0x7159, LSL #16
    MOVK  X3, #0xa8c2, LSL #32
    MOVK  X3, #0xce33, LSL #48
    FMOV  X9, D17
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xc26, LSL #0
    MOVK  X3, #0x3edd, LSL #16
    MOVK  X3, #0xbb76, LSL #32
    MOVK  X3, #0x2ecb, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x3198, LSL #0
    MOVK  X3, #0x166c, LSL #16
    MOVK  X3, #0x34d7, LSL #32
    MOVK  X3, #0xe725, LSL #48
    FMOV  X9, D18
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x858a, LSL #0
    MOVK  X3, #0xcbdc, LSL #16
    MOVK  X3, #0x2c2f, LSL #32
    MOVK  X3, #0xf53f, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x7791, LSL #0
    MOVK  X3, #0x79ca, LSL #16
    MOVK  X3, #0x3dac, LSL #32
    MOVK  X3, #0x6f95, LSL #48
    FMOV  X9, D19
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x85f8, LSL #0
    MOVK  X3, #0x35a, LSL #16
    MOVK  X3, #0x4720, LSL #32
    MOVK  X3, #0xac7b, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x3172, LSL #0
    MOVK  X3, #0x7d4b, LSL #16
    MOVK  X3, #0x3408, LSL #32
    MOVK  X3, #0x86ca, LSL #48
    FMOV  X9, D20
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xfd9f, LSL #0
    MOVK  X3, #0x2adb, LSL #16
    MOVK  X3, #0x2af8, LSL #32
    MOVK  X3, #0x4513, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x8548, LSL #0
    MOVK  X3, #0x7c2, LSL #16
    MOVK  X3, #0x9a6d, LSL #32
    MOVK  X3, #0x4be3, LSL #48
    FMOV  X9, D21
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x287d, LSL #0
    MOVK  X3, #0xce1, LSL #16
    MOVK  X3, #0x1f5c, LSL #32
    MOVK  X3, #0x67e, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xf140, LSL #0
    MOVK  X3, #0x5b89, LSL #16
    MOVK  X3, #0xd16d, LSL #32
    MOVK  X3, #0xf0db, LSL #48
    FMOV  X9, D22
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x427b, LSL #0
    MOVK  X3, #0xe466, LSL #16
    MOVK  X3, #0xd1cb, LSL #32
    MOVK  X3, #0xb916, LSL #48
    FMOV  X9, V23.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xd9da, LSL #0
    MOVK  X3, #0xcfc3, LSL #16
    MOVK  X3, #0xb4d1, LSL #32
    MOVK  X3, #0x2fbd, LSL #48
    FMOV  X9, D23
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xc93c, LSL #0
    MOVK  X3, #0xa3a8, LSL #16
    MOVK  X3, #0xb6a2, LSL #32
    MOVK  X3, #0xd390, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x8ba1, LSL #0
    MOVK  X3, #0xe3b7, LSL #16
    MOVK  X3, #0x3e54, LSL #32
    MOVK  X3, #0x261d, LSL #48
    FMOV  X9, D24
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x5cb3, LSL #0
    MOVK  X3, #0xe0a3, LSL #16
    MOVK  X3, #0xd23b, LSL #32
    MOVK  X3, #0x52a9, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x3898, LSL #0
    MOVK  X3, #0x1bc5, LSL #16
    MOVK  X3, #0x3041, LSL #32
    MOVK  X3, #0x7b60, LSL #48
    FMOV  X9, D25
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x818, LSL #0
    MOVK  X3, #0x2baf, LSL #16
    MOVK  X3, #0x91b9, LSL #32
    MOVK  X3, #0x8a73, LSL #48
    FMOV  X9, V26.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x9c68, LSL #0
    MOVK  X3, #0xce14, LSL #16
    MOVK  X3, #0xfec, LSL #32
    MOVK  X3, #0x946e, LSL #48
    FMOV  X9, D26
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xbcd3, LSL #0
    MOVK  X3, #0xc7b2, LSL #16
    MOVK  X3, #0xf016, LSL #32
    MOVK  X3, #0x5110, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x18fa, LSL #0
    MOVK  X3, #0xd48e, LSL #16
    MOVK  X3, #0x7e65, LSL #32
    MOVK  X3, #0xc3ae, LSL #48
    FMOV  X9, D27
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x3165, LSL #0
    MOVK  X3, #0x391a, LSL #16
    MOVK  X3, #0x14e1, LSL #32
    MOVK  X3, #0xb901, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x8b64, LSL #0
    MOVK  X3, #0xe93a, LSL #16
    MOVK  X3, #0x141c, LSL #32
    MOVK  X3, #0x5100, LSL #48
    FMOV  X9, D28
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xae5b, LSL #0
    MOVK  X3, #0xbf10, LSL #16
    MOVK  X3, #0x3829, LSL #32
    MOVK  X3, #0xe2f0, LSL #48
    FMOV  X9, V29.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x67a7, LSL #0
    MOVK  X3, #0x36f5, LSL #16
    MOVK  X3, #0x86d3, LSL #32
    MOVK  X3, #0x92ce, LSL #48
    FMOV  X9, D29
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x4b1e, LSL #0
    MOVK  X3, #0x3ea2, LSL #16
    MOVK  X3, #0x5e2f, LSL #32
    MOVK  X3, #0x1f5b, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x7a2b, LSL #0
    MOVK  X3, #0xd3f8, LSL #16
    MOVK  X3, #0x31bf, LSL #32
    MOVK  X3, #0x8cf3, LSL #48
    FMOV  X9, D30
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0x2adc, LSL #0
    MOVK  X3, #0xe7d3, LSL #16
    MOVK  X3, #0xc61c, LSL #32
    MOVK  X3, #0xb38e, LSL #48
    FMOV  X9, V31.D[1]
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X3, #0xf823, LSL #0
    MOVK  X3, #0x303, LSL #16
    MOVK  X3, #0xa67d, LSL #32
    MOVK  X3, #0xc2a2, LSL #48
    FMOV  X9, D31
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x5d03, LSL #0
    MOVK  X2, #0x1c91, LSL #16
    MOVK  X2, #0xf011, LSL #32
    MOVK  X2, #0xf65d, LSL #48
    MOVZ  X3, #0x93f9, LSL #0
    MOVK  X3, #0x8d95, LSL #16
    MOVK  X3, #0x47de, LSL #32
    MOVK  X3, #0x1e55, LSL #48
    MOVZ  X5, #0xe4dd, LSL #0
    MOVK  X5, #0x6682, LSL #16
    MOVK  X5, #0x20e6, LSL #32
    MOVK  X5, #0xa5a0, LSL #48
    MOVZ  X6, #0x703d, LSL #0
    MOVK  X6, #0x3d74, LSL #16
    MOVK  X6, #0x7301, LSL #32
    MOVK  X6, #0x701b, LSL #48
    MOVZ  X8, #0xf81f, LSL #0
    MOVK  X8, #0x4dd9, LSL #16
    MOVK  X8, #0xfbb1, LSL #32
    MOVK  X8, #0x58a5, LSL #48
    MOVZ  X9, #0xb53d, LSL #0
    MOVK  X9, #0x3706, LSL #16
    MOVK  X9, #0xe4d7, LSL #32
    MOVK  X9, #0x8777, LSL #48
    MOVZ  X10, #0x2f2a, LSL #0
    MOVK  X10, #0x60d4, LSL #16
    MOVK  X10, #0x29db, LSL #32
    MOVK  X10, #0xb3ec, LSL #48
    MOVZ  X11, #0x6794, LSL #0
    MOVK  X11, #0x378a, LSL #16
    MOVK  X11, #0xc9af, LSL #32
    MOVK  X11, #0xd25a, LSL #48
    MOVZ  X12, #0xd90f, LSL #0
    MOVK  X12, #0x2ba, LSL #16
    MOVK  X12, #0x6ffe, LSL #32
    MOVK  X12, #0x3d6e, LSL #48
    MOVZ  X13, #0x5cb8, LSL #0
    MOVK  X13, #0xd781, LSL #16
    MOVK  X13, #0xec7f, LSL #32
    MOVK  X13, #0x5c41, LSL #48
    MOVZ  X14, #0x6edc, LSL #0
    MOVK  X14, #0xca05, LSL #16
    MOVK  X14, #0x8c6c, LSL #32
    MOVK  X14, #0xa5aa, LSL #48
    MOVZ  X15, #0xf40e, LSL #0
    MOVK  X15, #0xae4, LSL #16
    MOVK  X15, #0xf33d, LSL #32
    MOVK  X15, #0x298, LSL #48
    MOVZ  X16, #0xbd19, LSL #0
    MOVK  X16, #0xe21b, LSL #16
    MOVK  X16, #0x63a7, LSL #32
    MOVK  X16, #0x689, LSL #48
    MOVZ  X17, #0xf9d6, LSL #0
    MOVK  X17, #0xfb04, LSL #16
    MOVK  X17, #0x6a85, LSL #32
    MOVK  X17, #0xe875, LSL #48
    MOVZ  X18, #0x74cc, LSL #0
    MOVK  X18, #0xfb3e, LSL #16
    MOVK  X18, #0x2734, LSL #32
    MOVK  X18, #0x5067, LSL #48
    MOVZ  X19, #0x7922, LSL #0
    MOVK  X19, #0x32b8, LSL #16
    MOVK  X19, #0x9d09, LSL #32
    MOVK  X19, #0xe106, LSL #48
    MOVZ  X20, #0xb6c6, LSL #0
    MOVK  X20, #0x6dd0, LSL #16
    MOVK  X20, #0x67fc, LSL #32
    MOVK  X20, #0xfbd, LSL #48
    MOVZ  X21, #0xfc68, LSL #0
    MOVK  X21, #0x68cf, LSL #16
    MOVK  X21, #0xedf7, LSL #32
    MOVK  X21, #0x3e4c, LSL #48
    MOVZ  X22, #0x7b5d, LSL #0
    MOVK  X22, #0xc2a6, LSL #16
    MOVK  X22, #0x9824, LSL #32
    MOVK  X22, #0x69a6, LSL #48
    MOVZ  X24, #0xd11c, LSL #0
    MOVK  X24, #0x3825, LSL #16
    MOVK  X24, #0xd5b6, LSL #32
    MOVK  X24, #0xd61d, LSL #48
    MOVZ  X25, #0x2a6, LSL #0
    MOVK  X25, #0x6943, LSL #16
    MOVK  X25, #0xd3df, LSL #32
    MOVK  X25, #0xe739, LSL #48
    MOVZ  X27, #0xff93, LSL #0
    MOVK  X27, #0xe2a7, LSL #16
    MOVK  X27, #0xd1b0, LSL #32
    MOVK  X27, #0x69e4, LSL #48
    MOVZ  X28, #0x26cc, LSL #0
    MOVK  X28, #0x796a, LSL #16
    MOVK  X28, #0x62c2, LSL #32
    MOVK  X28, #0xd396, LSL #48
    MOVZ  X29, #0x706d, LSL #0
    MOVK  X29, #0x6f1, LSL #16
    MOVK  X29, #0xe809, LSL #32
    MOVK  X29, #0xd016, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X19
    FMOV  V2.D[1], X21
    FMOV  D3, X14
    FMOV  V3.D[1], X27
    FMOV  D4, X2
    FMOV  V4.D[1], X25
    FMOV  D5, X28
    FMOV  V5.D[1], X18
    FMOV  D6, X20
    FMOV  V6.D[1], X11
    FMOV  D7, X6
    FMOV  V7.D[1], X16
    FMOV  D8, X17
    FMOV  V8.D[1], X29
    FMOV  D9, X12
    FMOV  V9.D[1], X2
    FMOV  D10, X13
    FMOV  V10.D[1], X28
    FMOV  D11, X9
    FMOV  V11.D[1], X21
    FMOV  D12, X21
    FMOV  V12.D[1], X13
    FMOV  D13, X25
    FMOV  V13.D[1], X16
    FMOV  D14, X15
    FMOV  V14.D[1], X21
    FMOV  D15, X12
    FMOV  V15.D[1], X21
    FMOV  D16, X2
    FMOV  V16.D[1], X14
    FMOV  D17, X17
    FMOV  V17.D[1], X24
    FMOV  D18, X20
    FMOV  V18.D[1], X13
    FMOV  D19, X16
    FMOV  V19.D[1], X9
    FMOV  D20, X8
    FMOV  V20.D[1], X25
    FMOV  D21, X21
    FMOV  V21.D[1], X19
    FMOV  D22, X20
    FMOV  V22.D[1], X28
    FMOV  D23, X15
    FMOV  V23.D[1], X20
    FMOV  D24, X27
    FMOV  V24.D[1], X5
    FMOV  D25, X10
    FMOV  V25.D[1], X25
    FMOV  D26, X2
    FMOV  V26.D[1], X16
    FMOV  D27, X9
    FMOV  V27.D[1], X16
    FMOV  D28, X12
    FMOV  V28.D[1], X8
    FMOV  D29, X12
    FMOV  V29.D[1], X10
    FMOV  D30, X6
    FMOV  V30.D[1], X10
    FMOV  D31, X2
    FMOV  V31.D[1], X20
    MOVZ  X13, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_9:
    SHA256H  Q8, Q23, V22.4S
    SHA256SU0  V25.4S, V25.4S
    SHA1SU1  V4.4S, V8.4S
    SHA1SU0  V22.4S, V29.4S, V29.4S
    SHA256SU1  V31.4S, V28.4S, V28.4S
    SHA256H  Q17, Q30, V31.4S
    SHA256SU1  V14.4S, V27.4S, V27.4S
    SHA256SU0  V4.4S, V26.4S
    SHA1SU0  V19.4S, V25.4S, V17.4S
    SHA256H  Q16, Q22, V22.4S
    SHA1SU0  V30.4S, V4.4S, V14.4S
    SHA1SU0  V11.4S, V30.4S, V30.4S
    SHA256SU1  V18.4S, V19.4S, V16.4S
    SHA1SU0  V29.4S, V11.4S, V18.4S
    SHA1C  Q8, S29, V24.4S
    SHA1M  Q23, S13, V11.4S
    SHA1P  Q28, S10, V19.4S
    SHA256H  Q26, Q24, V14.4S
    SHA1SU0  V16.4S, V8.4S, V9.4S
    SHA1C  Q12, S31, V13.4S
    SHA256H2  Q29, Q11, V27.4S
    SHA256H2  Q31, Q15, V16.4S
    SHA1P  Q13, S4, V4.4S
    SHA1P  Q4, S14, V17.4S
    SHA256SU1  V18.4S, V8.4S, V6.4S
    SHA256H  Q2, Q5, V30.4S
    SHA256SU1  V19.4S, V4.4S, V28.4S
    SHA256SU1  V10.4S, V31.4S, V19.4S
    SHA1SU1  V26.4S, V15.4S
    SHA1C  Q4, S10, V26.4S
    SHA256SU1  V6.4S, V18.4S, V23.4S
    SHA1SU0  V24.4S, V12.4S, V12.4S
    SHA256SU1  V22.4S, V29.4S, V13.4S
    SHA1C  Q23, S4, V2.4S
    SHA256H2  Q2, Q23, V23.4S
    SHA256SU0  V23.4S, V8.4S
    SHA256H2  Q19, Q23, V23.4S
    SHA1SU1  V25.4S, V10.4S
    SHA1M  Q23, S6, V24.4S
    SHA1SU1  V28.4S, V23.4S
    SHA256H2  Q12, Q22, V22.4S
    SHA256H  Q26, Q12, V2.4S
    SHA1SU1  V5.4S, V19.4S
    SHA1P  Q24, S5, V5.4S
    SHA1SU1  V19.4S, V26.4S
    SHA1M  Q5, S19, V8.4S
    SHA1M  Q6, S25, V5.4S
    SHA1C  Q22, S24, V28.4S
    SHA256H2  Q4, Q22, V22.4S
    SHA1C  Q26, S6, V4.4S
    SHA1SU1  V30.4S, V13.4S
    SHA1M  Q4, S30, V24.4S
    SHA1M  Q19, S15, V1.4S
    SHA1SU0  V8.4S, V8.4S, V9.4S
    SHA256H  Q31, Q3, V12.4S
    SHA1SU0  V30.4S, V13.4S, V12.4S
    SHA256SU0  V13.4S, V11.4S
    SHA1SU1  V23.4S, V2.4S
    SHA1C  Q5, S21, V24.4S
    SHA1C  Q29, S26, V5.4S
    SHA1P  Q12, S19, V29.4S
    SHA1C  Q1, S8, V12.4S
    SHA1SU0  V8.4S, V1.4S, V4.4S
    SHA256H  Q25, Q8, V23.4S
    SHA1SU1  V8.4S, V25.4S
    SHA1SU1  V9.4S, V8.4S
    SHA256SU1  V8.4S, V31.4S, V31.4S
    SHA256SU0  V11.4S, V8.4S
    SHA256SU0  V12.4S, V13.4S
    SHA256SU1  V28.4S, V1.4S, V9.4S
    SHA256H2  Q23, Q12, V12.4S
    SHA1P  Q8, S30, V28.4S
    SHA1C  Q12, S8, V23.4S
    SHA256SU0  V23.4S, V12.4S
    SHA256H2  Q13, Q11, V11.4S
    SHA256H  Q28, Q28, V13.4S
    SHA256SU1  V4.4S, V23.4S, V28.4S
    SHA256SU1  V21.4S, V19.4S, V7.4S
    SHA1P  Q19, S19, V25.4S
    SHA1C  Q5, S15, V11.4S
    SHA1P  Q1, S11, V10.4S
    SHA1P  Q31, S23, V27.4S
    SHA256SU1  V10.4S, V17.4S, V23.4S
    SHA256SU0  V9.4S, V9.4S
    SHA256SU0  V7.4S, V9.4S
    SHA256H  Q17, Q11, V24.4S
    SHA256H2  Q23, Q17, V10.4S
    SHA256H  Q13, Q31, V23.4S
    SHA256SU1  V28.4S, V19.4S, V4.4S
    SHA1SU1  V31.4S, V1.4S
    SHA256SU1  V19.4S, V28.4S, V7.4S
    SHA1C  Q8, S21, V5.4S
    SHA1SU0  V24.4S, V8.4S, V13.4S
    SHA1M  Q4, S31, V31.4S
    SHA1SU0  V12.4S, V4.4S, V4.4S
    SHA256H2  Q27, Q12, V12.4S
    SHA256H  Q13, Q27, V19.4S
    SHA256H  Q1, Q13, V24.4S
    SHA256SU0  V9.4S, V24.4S
    SHA256SU1  V28.4S, V25.4S, V31.4S
    SHA256H  Q11, Q30, V1.4S
    SHA256SU1  V7.4S, V2.4S, V12.4S
    SHA256SU0  V23.4S, V3.4S
    SHA1C  Q13, S19, V27.4S
    SHA1P  Q10, S2, V4.4S
    SHA256H  Q21, Q2, V24.4S
    SHA1P  Q19, S0, V15.4S
    SHA1SU0  V25.4S, V19.4S, V19.4S
    SHA256H  Q27, Q10, V21.4S
    SHA1M  Q31, S1, V27.4S
    SHA256SU1  V1.4S, V1.4S, V28.4S
    SHA1P  Q5, S9, V13.4S
    SHA256H2  Q21, Q14, V5.4S
    SHA1SU1  V3.4S, V11.4S
    SHA256SU0  V9.4S, V23.4S
    SHA1SU1  V13.4S, V31.4S
    SHA1SU1  V27.4S, V7.4S
    SHA1SU0  V8.4S, V3.4S, V13.4S
    SHA1C  Q11, S1, V8.4S
    SHA256H2  Q14, Q25, V27.4S
    SHA256H  Q24, Q9, V11.4S
    SHA1M  Q23, S21, V24.4S
    SHA256SU0  V19.4S, V14.4S
    SHA1SU0  V10.4S, V23.4S, V23.4S
    SHA256SU0  V5.4S, V10.4S
    SHA1M  Q21, S5, V19.4S
    SHA256H  Q10, Q13, V5.4S
    SHA256H  Q4, Q12, V9.4S
    SHA256H  Q28, Q24, V30.4S
    SHA256SU1  V15.4S, V19.4S, V30.4S
    SHA1P  Q31, S8, V29.4S
    SHA1SU0  V11.4S, V12.4S, V5.4S
    SHA256SU1  V14.4S, V9.4S, V10.4S
    SHA256SU1  V29.4S, V21.4S, V15.4S
    SHA1SU0  V8.4S, V16.4S, V18.4S
    SHA1P  Q19, S23, V8.4S
    SHA256SU0  V24.4S, V25.4S
    SHA256H  Q3, Q16, V31.4S
    SHA1C  Q12, S9, V12.4S
    SHA256H  Q8, Q11, V12.4S
    SHA1SU0  V27.4S, V4.4S, V19.4S
    SHA256H  Q15, Q24, V25.4S
    SHA1SU1  V10.4S, V3.4S
    SHA1SU0  V13.4S, V27.4S, V15.4S
    SHA256H  Q1, Q8, V28.4S
    SHA1M  Q30, S13, V13.4S
    SHA256H  Q16, Q10, V10.4S
    SHA256H  Q18, Q16, V30.4S
    SHA1SU1  V5.4S, V14.4S
    SHA1C  Q13, S1, V18.4S
    SHA1SU1  V11.4S, V5.4S
    SHA1P  Q30, S11, V29.4S
    SHA256SU0  V10.4S, V13.4S
    SHA1M  Q16, S10, V11.4S
    SHA1SU0  V19.4S, V16.4S, V16.4S
    SHA256SU0  V18.4S, V30.4S
    SHA256H2  Q14, Q18, V18.4S
    SHA1M  Q8, S14, V14.4S
    SHA256SU0  V27.4S, V8.4S
    SHA1SU0  V13.4S, V4.4S, V27.4S
    SHA1SU0  V28.4S, V19.4S, V19.4S
    SHA256SU1  V15.4S, V28.4S, V13.4S
    SHA1SU0  V3.4S, V23.4S, V14.4S
    SHA1C  Q18, S25, V26.4S
    SHA256H  Q8, Q0, V3.4S
    SHA256H  Q4, Q25, V11.4S
    SHA256H2  Q16, Q31, V22.4S
    SHA1SU1  V30.4S, V6.4S
    SHA1P  Q27, S12, V31.4S
    SHA1P  Q10, S15, V23.4S
    SHA256H2  Q29, Q13, V3.4S
    SHA256H  Q15, Q12, V25.4S
    SHA1P  Q3, S15, V30.4S
    SHA1C  Q19, S27, V4.4S
    SHA1M  Q13, S16, V29.4S
    SHA256H  Q25, Q13, V13.4S
    SHA1C  Q26, S3, V10.4S
    SHA1SU0  V15.4S, V8.4S, V19.4S
    SHA256SU0  V13.4S, V25.4S
    SHA1C  Q11, S18, V18.4S
    SHA1P  Q5, S7, V15.4S
    SHA256H2  Q25, Q26, V5.4S
    SHA1SU1  V4.4S, V13.4S
    SHA1M  Q6, S4, V26.4S
    SHA256H2  Q23, Q6, V25.4S
    SHA1P  Q15, S23, V16.4S
    SHA256SU0  V25.4S, V15.4S
    SHA256H  Q23, Q25, V25.4S
    SHA256H2  Q5, Q23, V23.4S
    SHA1SU0  V30.4S, V25.4S, V11.4S
    SHA1C  Q25, S30, V30.4S
    SHA256SU0  V23.4S, V5.4S
    SHA256H  Q6, Q25, V23.4S
    SHA256H  Q22, Q18, V31.4S
    SHA1C  Q4, S30, V29.4S
    SHA1SU1  V15.4S, V8.4S
    SHA256H2  Q8, Q18, V25.4S
    SHA1M  Q7, S4, V0.4S
    SHA1P  Q11, S26, V12.4S
    SHA1P  Q0, S31, V25.4S
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_9
    MOVZ  X12, #0x5d03, LSL #0
    MOVK  X12, #0x1c91, LSL #16
    MOVK  X12, #0xf011, LSL #32
    MOVK  X12, #0xf65d, LSL #48
    SUB  X16, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x93f9, LSL #0
    MOVK  X12, #0x8d95, LSL #16
    MOVK  X12, #0x47de, LSL #32
    MOVK  X12, #0x1e55, LSL #48
    SUB  X16, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xe4dd, LSL #0
    MOVK  X12, #0x6682, LSL #16
    MOVK  X12, #0x20e6, LSL #32
    MOVK  X12, #0xa5a0, LSL #48
    SUB  X16, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x703d, LSL #0
    MOVK  X12, #0x3d74, LSL #16
    MOVK  X12, #0x7301, LSL #32
    MOVK  X12, #0x701b, LSL #48
    SUB  X16, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf81f, LSL #0
    MOVK  X12, #0x4dd9, LSL #16
    MOVK  X12, #0xfbb1, LSL #32
    MOVK  X12, #0x58a5, LSL #48
    SUB  X16, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xb53d, LSL #0
    MOVK  X12, #0x3706, LSL #16
    MOVK  X12, #0xe4d7, LSL #32
    MOVK  X12, #0x8777, LSL #48
    SUB  X16, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6794, LSL #0
    MOVK  X12, #0x378a, LSL #16
    MOVK  X12, #0xc9af, LSL #32
    MOVK  X12, #0xd25a, LSL #48
    SUB  X16, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X16, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6edc, LSL #0
    MOVK  X12, #0xca05, LSL #16
    MOVK  X12, #0x8c6c, LSL #32
    MOVK  X12, #0xa5aa, LSL #48
    SUB  X16, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf40e, LSL #0
    MOVK  X12, #0xae4, LSL #16
    MOVK  X12, #0xf33d, LSL #32
    MOVK  X12, #0x298, LSL #48
    SUB  X16, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf9d6, LSL #0
    MOVK  X12, #0xfb04, LSL #16
    MOVK  X12, #0x6a85, LSL #32
    MOVK  X12, #0xe875, LSL #48
    SUB  X16, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x74cc, LSL #0
    MOVK  X12, #0xfb3e, LSL #16
    MOVK  X12, #0x2734, LSL #32
    MOVK  X12, #0x5067, LSL #48
    SUB  X16, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7922, LSL #0
    MOVK  X12, #0x32b8, LSL #16
    MOVK  X12, #0x9d09, LSL #32
    MOVK  X12, #0xe106, LSL #48
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xb6c6, LSL #0
    MOVK  X12, #0x6dd0, LSL #16
    MOVK  X12, #0x67fc, LSL #32
    MOVK  X12, #0xfbd, LSL #48
    SUB  X16, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xfc68, LSL #0
    MOVK  X12, #0x68cf, LSL #16
    MOVK  X12, #0xedf7, LSL #32
    MOVK  X12, #0x3e4c, LSL #48
    SUB  X16, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7b5d, LSL #0
    MOVK  X12, #0xc2a6, LSL #16
    MOVK  X12, #0x9824, LSL #32
    MOVK  X12, #0x69a6, LSL #48
    SUB  X16, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xd11c, LSL #0
    MOVK  X12, #0x3825, LSL #16
    MOVK  X12, #0xd5b6, LSL #32
    MOVK  X12, #0xd61d, LSL #48
    SUB  X16, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x2a6, LSL #0
    MOVK  X12, #0x6943, LSL #16
    MOVK  X12, #0xd3df, LSL #32
    MOVK  X12, #0xe739, LSL #48
    SUB  X16, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xff93, LSL #0
    MOVK  X12, #0xe2a7, LSL #16
    MOVK  X12, #0xd1b0, LSL #32
    MOVK  X12, #0x69e4, LSL #48
    SUB  X16, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x26cc, LSL #0
    MOVK  X12, #0x796a, LSL #16
    MOVK  X12, #0x62c2, LSL #32
    MOVK  X12, #0xd396, LSL #48
    SUB  X16, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x706d, LSL #0
    MOVK  X12, #0x6f1, LSL #16
    MOVK  X12, #0xe809, LSL #32
    MOVK  X12, #0xd016, LSL #48
    SUB  X16, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x63ae, LSL #0
    MOVK  X12, #0xbfc8, LSL #16
    MOVK  X12, #0x797b, LSL #32
    MOVK  X12, #0xc2da, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf7cb, LSL #0
    MOVK  X12, #0xf0f5, LSL #16
    MOVK  X12, #0xab9b, LSL #32
    MOVK  X12, #0x9e75, LSL #48
    FMOV  X16, D0
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xcc68, LSL #0
    MOVK  X12, #0xde76, LSL #16
    MOVK  X12, #0xd359, LSL #32
    MOVK  X12, #0x6fe6, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x70e4, LSL #0
    MOVK  X12, #0x180e, LSL #16
    MOVK  X12, #0xd98f, LSL #32
    MOVK  X12, #0xe325, LSL #48
    FMOV  X16, D1
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x2389, LSL #0
    MOVK  X12, #0xa819, LSL #16
    MOVK  X12, #0xa808, LSL #32
    MOVK  X12, #0x9433, LSL #48
    FMOV  X16, V2.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x8665, LSL #0
    MOVK  X12, #0x450c, LSL #16
    MOVK  X12, #0xacc8, LSL #32
    MOVK  X12, #0x9703, LSL #48
    FMOV  X16, D2
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7933, LSL #0
    MOVK  X12, #0x801, LSL #16
    MOVK  X12, #0x7fa5, LSL #32
    MOVK  X12, #0xb12f, LSL #48
    FMOV  X16, V3.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x8b68, LSL #0
    MOVK  X12, #0xee37, LSL #16
    MOVK  X12, #0x7d60, LSL #32
    MOVK  X12, #0xc555, LSL #48
    FMOV  X16, D3
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xdf3e, LSL #0
    MOVK  X12, #0xffce, LSL #16
    MOVK  X12, #0xb62a, LSL #32
    MOVK  X12, #0x3234, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x4d8d, LSL #0
    MOVK  X12, #0x9510, LSL #16
    MOVK  X12, #0x228a, LSL #32
    MOVK  X12, #0x158f, LSL #48
    FMOV  X16, D4
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x342d, LSL #0
    MOVK  X12, #0xe14e, LSL #16
    MOVK  X12, #0x3ebb, LSL #32
    MOVK  X12, #0x4a9f, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x8986, LSL #0
    MOVK  X12, #0x3e20, LSL #16
    MOVK  X12, #0x734a, LSL #32
    MOVK  X12, #0x857, LSL #48
    FMOV  X16, D5
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7f61, LSL #0
    MOVK  X12, #0xf138, LSL #16
    MOVK  X12, #0x6a6, LSL #32
    MOVK  X12, #0x5fca, LSL #48
    FMOV  X16, V6.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x716d, LSL #0
    MOVK  X12, #0x5214, LSL #16
    MOVK  X12, #0x3003, LSL #32
    MOVK  X12, #0x12b0, LSL #48
    FMOV  X16, D6
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x2a08, LSL #0
    MOVK  X12, #0x52f, LSL #16
    MOVK  X12, #0x5774, LSL #32
    MOVK  X12, #0x4e34, LSL #48
    FMOV  X16, V7.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x9c9b, LSL #0
    MOVK  X12, #0x3bb7, LSL #16
    MOVK  X12, #0x69da, LSL #32
    MOVK  X12, #0x8695, LSL #48
    FMOV  X16, D7
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xad02, LSL #0
    MOVK  X12, #0xc031, LSL #16
    MOVK  X12, #0x9bbd, LSL #32
    MOVK  X12, #0x5be5, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xe229, LSL #0
    MOVK  X12, #0xa707, LSL #16
    MOVK  X12, #0x4f05, LSL #32
    MOVK  X12, #0xb13b, LSL #48
    FMOV  X16, D8
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xae3, LSL #0
    MOVK  X12, #0x852a, LSL #16
    MOVK  X12, #0x70ce, LSL #32
    MOVK  X12, #0x32b2, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x41d8, LSL #0
    MOVK  X12, #0xed93, LSL #16
    MOVK  X12, #0xfd67, LSL #32
    MOVK  X12, #0xc3bb, LSL #48
    FMOV  X16, D9
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xdcd7, LSL #0
    MOVK  X12, #0xd1eb, LSL #16
    MOVK  X12, #0xc27b, LSL #32
    MOVK  X12, #0xefd1, LSL #48
    FMOV  X16, V10.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xfc8a, LSL #0
    MOVK  X12, #0x992e, LSL #16
    MOVK  X12, #0x1872, LSL #32
    MOVK  X12, #0x867, LSL #48
    FMOV  X16, D10
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x9434, LSL #0
    MOVK  X12, #0x2977, LSL #16
    MOVK  X12, #0xdf59, LSL #32
    MOVK  X12, #0x6d90, LSL #48
    FMOV  X16, V11.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xd6f, LSL #0
    MOVK  X12, #0x2ef3, LSL #16
    MOVK  X12, #0x2793, LSL #32
    MOVK  X12, #0xa2a8, LSL #48
    FMOV  X16, D11
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xd740, LSL #0
    MOVK  X12, #0xa3e9, LSL #16
    MOVK  X12, #0x43fd, LSL #32
    MOVK  X12, #0xcc9c, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xfd09, LSL #0
    MOVK  X12, #0x2909, LSL #16
    MOVK  X12, #0xf73, LSL #32
    MOVK  X12, #0x7f63, LSL #48
    FMOV  X16, D12
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x243e, LSL #0
    MOVK  X12, #0xf983, LSL #16
    MOVK  X12, #0x9e93, LSL #32
    MOVK  X12, #0xe8ed, LSL #48
    FMOV  X16, V13.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x1284, LSL #0
    MOVK  X12, #0x55ec, LSL #16
    MOVK  X12, #0x949e, LSL #32
    MOVK  X12, #0x7619, LSL #48
    FMOV  X16, D13
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x2cd9, LSL #0
    MOVK  X12, #0xbf16, LSL #16
    MOVK  X12, #0xeff, LSL #32
    MOVK  X12, #0xb843, LSL #48
    FMOV  X16, V14.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xee10, LSL #0
    MOVK  X12, #0xa22e, LSL #16
    MOVK  X12, #0x63, LSL #32
    MOVK  X12, #0xc184, LSL #48
    FMOV  X16, D14
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x5551, LSL #0
    MOVK  X12, #0x414c, LSL #16
    MOVK  X12, #0x32ca, LSL #32
    MOVK  X12, #0xd365, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x990d, LSL #0
    MOVK  X12, #0xe070, LSL #16
    MOVK  X12, #0x9141, LSL #32
    MOVK  X12, #0x8d25, LSL #48
    FMOV  X16, D15
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x3e70, LSL #0
    MOVK  X12, #0x586e, LSL #16
    MOVK  X12, #0x6ac7, LSL #32
    MOVK  X12, #0x939f, LSL #48
    FMOV  X16, V16.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x91e, LSL #0
    MOVK  X12, #0x674c, LSL #16
    MOVK  X12, #0xf41a, LSL #32
    MOVK  X12, #0xefa, LSL #48
    FMOV  X16, D16
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x418e, LSL #0
    MOVK  X12, #0x665a, LSL #16
    MOVK  X12, #0xb4d, LSL #32
    MOVK  X12, #0xa02f, LSL #48
    FMOV  X16, V17.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6c91, LSL #0
    MOVK  X12, #0x4d26, LSL #16
    MOVK  X12, #0xbae3, LSL #32
    MOVK  X12, #0xfec4, LSL #48
    FMOV  X16, D17
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x9e9f, LSL #0
    MOVK  X12, #0x1709, LSL #16
    MOVK  X12, #0x8611, LSL #32
    MOVK  X12, #0xa7c1, LSL #48
    FMOV  X16, V18.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xe139, LSL #0
    MOVK  X12, #0x30ce, LSL #16
    MOVK  X12, #0xc258, LSL #32
    MOVK  X12, #0xe28a, LSL #48
    FMOV  X16, D18
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xff7e, LSL #0
    MOVK  X12, #0x319d, LSL #16
    MOVK  X12, #0x9267, LSL #32
    MOVK  X12, #0x9c9a, LSL #48
    FMOV  X16, V19.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x483e, LSL #0
    MOVK  X12, #0x4e9b, LSL #16
    MOVK  X12, #0x59cd, LSL #32
    MOVK  X12, #0x2c28, LSL #48
    FMOV  X16, D19
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x2a6, LSL #0
    MOVK  X12, #0x6943, LSL #16
    MOVK  X12, #0xd3df, LSL #32
    MOVK  X12, #0xe739, LSL #48
    FMOV  X16, V20.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf81f, LSL #0
    MOVK  X12, #0x4dd9, LSL #16
    MOVK  X12, #0xfbb1, LSL #32
    MOVK  X12, #0x58a5, LSL #48
    FMOV  X16, D20
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x55bf, LSL #0
    MOVK  X12, #0x4ee0, LSL #16
    MOVK  X12, #0x231a, LSL #32
    MOVK  X12, #0x91c1, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x1407, LSL #0
    MOVK  X12, #0xe95f, LSL #16
    MOVK  X12, #0xdcd6, LSL #32
    MOVK  X12, #0x15ea, LSL #48
    FMOV  X16, D21
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xbc35, LSL #0
    MOVK  X12, #0xbfd0, LSL #16
    MOVK  X12, #0x4062, LSL #32
    MOVK  X12, #0x8f3b, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x58de, LSL #0
    MOVK  X12, #0x46db, LSL #16
    MOVK  X12, #0x667b, LSL #32
    MOVK  X12, #0x100, LSL #48
    FMOV  X16, D22
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x5310, LSL #0
    MOVK  X12, #0xe57a, LSL #16
    MOVK  X12, #0x41c0, LSL #32
    MOVK  X12, #0x3047, LSL #48
    FMOV  X16, V23.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf9c6, LSL #0
    MOVK  X12, #0xc21d, LSL #16
    MOVK  X12, #0xbfbe, LSL #32
    MOVK  X12, #0x7a2f, LSL #48
    FMOV  X16, D23
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xfc39, LSL #0
    MOVK  X12, #0xdf86, LSL #16
    MOVK  X12, #0xc669, LSL #32
    MOVK  X12, #0xd445, LSL #48
    FMOV  X16, V24.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xaf39, LSL #0
    MOVK  X12, #0x26ec, LSL #16
    MOVK  X12, #0x214c, LSL #32
    MOVK  X12, #0xefda, LSL #48
    FMOV  X16, D24
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7a06, LSL #0
    MOVK  X12, #0xa31b, LSL #16
    MOVK  X12, #0x321e, LSL #32
    MOVK  X12, #0xc67f, LSL #48
    FMOV  X16, V25.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xa112, LSL #0
    MOVK  X12, #0xc024, LSL #16
    MOVK  X12, #0x264f, LSL #32
    MOVK  X12, #0x99ed, LSL #48
    FMOV  X16, D25
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xd9ba, LSL #0
    MOVK  X12, #0x8505, LSL #16
    MOVK  X12, #0x5550, LSL #32
    MOVK  X12, #0x74f0, LSL #48
    FMOV  X16, V26.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xccd6, LSL #0
    MOVK  X12, #0xf42e, LSL #16
    MOVK  X12, #0xb029, LSL #32
    MOVK  X12, #0xc4e3, LSL #48
    FMOV  X16, D26
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x22b4, LSL #0
    MOVK  X12, #0x932e, LSL #16
    MOVK  X12, #0xd659, LSL #32
    MOVK  X12, #0xf725, LSL #48
    FMOV  X16, V27.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7f43, LSL #0
    MOVK  X12, #0x752e, LSL #16
    MOVK  X12, #0xfba9, LSL #32
    MOVK  X12, #0x20e5, LSL #48
    FMOV  X16, D27
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x30a9, LSL #0
    MOVK  X12, #0x7da4, LSL #16
    MOVK  X12, #0x91e5, LSL #32
    MOVK  X12, #0xa734, LSL #48
    FMOV  X16, V28.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xadc7, LSL #0
    MOVK  X12, #0x7f28, LSL #16
    MOVK  X12, #0xcd6f, LSL #32
    MOVK  X12, #0x9b85, LSL #48
    FMOV  X16, D28
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xa89, LSL #0
    MOVK  X12, #0xc21b, LSL #16
    MOVK  X12, #0xb066, LSL #32
    MOVK  X12, #0xe87b, LSL #48
    FMOV  X16, V29.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x45a9, LSL #0
    MOVK  X12, #0xaa24, LSL #16
    MOVK  X12, #0x24c8, LSL #32
    MOVK  X12, #0x7a24, LSL #48
    FMOV  X16, D29
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xc6eb, LSL #0
    MOVK  X12, #0x5b59, LSL #16
    MOVK  X12, #0x31f9, LSL #32
    MOVK  X12, #0xccc3, LSL #48
    FMOV  X16, V30.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x85d0, LSL #0
    MOVK  X12, #0x4ca2, LSL #16
    MOVK  X12, #0x6e34, LSL #32
    MOVK  X12, #0x72d5, LSL #48
    FMOV  X16, D30
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xa9e9, LSL #0
    MOVK  X12, #0x8f3, LSL #16
    MOVK  X12, #0x8081, LSL #32
    MOVK  X12, #0x902f, LSL #48
    FMOV  X16, V31.D[1]
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf2d7, LSL #0
    MOVK  X12, #0x69cb, LSL #16
    MOVK  X12, #0x5093, LSL #32
    MOVK  X12, #0xf55, LSL #48
    FMOV  X16, D31
    SUB  X10, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X28
    FMOV  V0.D[1], X25
    FMOV  D1, X12
    FMOV  V1.D[1], X11
    FMOV  D2, X15
    FMOV  V2.D[1], X14
    FMOV  D3, X24
    FMOV  V3.D[1], X21
    FMOV  D4, X29
    FMOV  V4.D[1], X17
    FMOV  D5, X27
    FMOV  V5.D[1], X22
    FMOV  D6, X20
    FMOV  V6.D[1], X10
    FMOV  D7, X6
    FMOV  V7.D[1], X15
    FMOV  D8, X9
    FMOV  V8.D[1], X13
    FMOV  D9, X18
    FMOV  V9.D[1], X10
    FMOV  D10, X29
    FMOV  V10.D[1], X18
    FMOV  D11, X25
    FMOV  V11.D[1], X2
    FMOV  D12, X12
    FMOV  V12.D[1], X5
    FMOV  D13, X11
    FMOV  V13.D[1], X2
    FMOV  D14, X19
    FMOV  V14.D[1], X11
    FMOV  D15, X27
    FMOV  V15.D[1], X21
    FMOV  D16, X27
    FMOV  V16.D[1], X10
    FMOV  D17, X13
    FMOV  V17.D[1], X3
    FMOV  D18, X3
    FMOV  V18.D[1], X15
    FMOV  D19, X24
    FMOV  V19.D[1], X9
    FMOV  D20, X28
    FMOV  V20.D[1], X5
    FMOV  D21, X19
    FMOV  V21.D[1], X27
    FMOV  D22, X16
    FMOV  V22.D[1], X11
    FMOV  D23, X24
    FMOV  V23.D[1], X21
    FMOV  D24, X21
    FMOV  V24.D[1], X3
    FMOV  D25, X17
    FMOV  V25.D[1], X29
    FMOV  D26, X8
    FMOV  V26.D[1], X29
    FMOV  D27, X24
    FMOV  V27.D[1], X15
    FMOV  D28, X22
    FMOV  V28.D[1], X22
    FMOV  D29, X29
    FMOV  V29.D[1], X6
    FMOV  D30, X11
    FMOV  V30.D[1], X21
    FMOV  D31, X14
    FMOV  V31.D[1], X6
    MOVZ  X21, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_10:
    SHA1SU0  V27.4S, V23.4S, V26.4S
    SHA256H2  Q0, Q30, V27.4S
    SHA256H  Q11, Q24, V25.4S
    SHA256H2  Q16, Q11, V20.4S
    SHA256H2  Q11, Q31, V0.4S
    SHA256SU0  V0.4S, V29.4S
    SHA1M  Q26, S28, V21.4S
    SHA1SU0  V24.4S, V0.4S, V11.4S
    SHA1SU0  V4.4S, V16.4S, V24.4S
    SHA256SU0  V14.4S, V22.4S
    SHA256H  Q11, Q4, V4.4S
    SHA256H2  Q21, Q26, V14.4S
    SHA256H  Q26, Q11, V21.4S
    SHA1M  Q4, S28, V17.4S
    SHA256H2  Q14, Q16, V30.4S
    SHA256H2  Q25, Q8, V13.4S
    SHA1P  Q19, S26, V15.4S
    SHA1M  Q17, S20, V1.4S
    SHA1C  Q21, S9, V31.4S
    SHA1SU0  V27.4S, V25.4S, V16.4S
    SHA256H2  Q22, Q13, V15.4S
    SHA256H  Q15, Q7, V31.4S
    SHA256H2  Q24, Q2, V24.4S
    SHA256H  Q9, Q22, V15.4S
    SHA256H2  Q25, Q27, V19.4S
    SHA256H2  Q29, Q21, V17.4S
    SHA1M  Q22, S14, V29.4S
    SHA256H  Q11, Q24, V4.4S
    SHA256SU1  V2.4S, V22.4S, V11.4S
    SHA256H  Q29, Q25, V25.4S
    SHA1M  Q11, S29, V29.4S
    SHA256H  Q31, Q9, V11.4S
    SHA256SU1  V27.4S, V2.4S, V31.4S
    SHA1C  Q0, S6, V13.4S
    SHA1P  Q2, S11, V13.4S
    SHA1SU1  V29.4S, V26.4S
    SHA256SU1  V20.4S, V7.4S, V13.4S
    SHA256SU1  V14.4S, V29.4S, V19.4S
    SHA256H  Q16, Q8, V6.4S
    SHA256H  Q9, Q27, V10.4S
    SHA1SU1  V26.4S, V28.4S
    SHA1M  Q10, S1, V1.4S
    SHA256H2  Q31, Q18, V16.4S
    SHA1M  Q24, S8, V29.4S
    SHA1M  Q29, S31, V10.4S
    SHA1P  Q4, S29, V14.4S
    SHA1C  Q29, S24, V2.4S
    SHA1M  Q28, S29, V9.4S
    SHA1P  Q11, S0, V0.4S
    SHA1SU0  V10.4S, V11.4S, V26.4S
    SHA1M  Q11, S4, V22.4S
    SHA1SU0  V14.4S, V20.4S, V28.4S
    SHA1P  Q13, S10, V14.4S
    SHA1SU0  V28.4S, V13.4S, V11.4S
    SHA256H2  Q27, Q21, V22.4S
    SHA1M  Q11, S25, V21.4S
    SHA256SU0  V6.4S, V25.4S
    SHA256SU0  V13.4S, V31.4S
    SHA1SU1  V18.4S, V22.4S
    SHA256SU1  V22.4S, V14.4S, V26.4S
    SHA256H2  Q0, Q12, V6.4S
    SHA256H  Q4, Q8, V16.4S
    SHA1M  Q14, S27, V16.4S
    SHA1P  Q6, S31, V2.4S
    SHA1M  Q16, S22, V22.4S
    SHA1C  Q25, S11, V28.4S
    SHA256H2  Q12, Q4, V25.4S
    SHA1SU1  V29.4S, V13.4S
    SHA1SU1  V13.4S, V29.4S
    SHA1P  Q22, S19, V16.4S
    SHA256H2  Q28, Q22, V18.4S
    SHA256H2  Q29, Q0, V0.4S
    SHA256SU0  V19.4S, V28.4S
    SHA1C  Q11, S6, V13.4S
    SHA1SU0  V16.4S, V14.4S, V11.4S
    SHA1SU1  V18.4S, V12.4S
    SHA1SU1  V14.4S, V29.4S
    SHA1C  Q8, S14, V19.4S
    SHA1SU1  V22.4S, V16.4S
    SHA1SU1  V19.4S, V8.4S
    SHA1SU1  V8.4S, V18.4S
    SHA256H  Q4, Q22, V8.4S
    SHA256H  Q28, Q4, V28.4S
    SHA256H  Q31, Q31, V19.4S
    SHA1C  Q4, S31, V28.4S
    SHA256H  Q8, Q10, V6.4S
    SHA256H2  Q19, Q21, V9.4S
    SHA256H2  Q31, Q0, V31.4S
    SHA1M  Q13, S16, V17.4S
    SHA256H  Q29, Q4, V25.4S
    SHA1P  Q11, S5, V10.4S
    SHA256SU1  V28.4S, V4.4S, V9.4S
    SHA256H2  Q4, Q18, V2.4S
    SHA256SU0  V16.4S, V0.4S
    SHA256H2  Q18, Q31, V31.4S
    SHA256H2  Q2, Q18, V8.4S
    SHA256H  Q21, Q28, V19.4S
    SHA1M  Q12, S4, V13.4S
    SHA256SU0  V10.4S, V2.4S
    SHA256H  Q6, Q29, V29.4S
    SHA256SU1  V13.4S, V11.4S, V11.4S
    SHA1SU0  V19.4S, V12.4S, V16.4S
    SHA1SU0  V29.4S, V1.4S, V10.4S
    SHA256SU1  V28.4S, V6.4S, V21.4S
    SHA1SU0  V21.4S, V13.4S, V19.4S
    SHA1P  Q10, S21, V28.4S
    SHA1SU0  V14.4S, V10.4S, V10.4S
    SHA1M  Q19, S29, V12.4S
    SHA1SU0  V9.4S, V19.4S, V14.4S
    SHA256H2  Q17, Q7, V28.4S
    SHA256SU0  V22.4S, V27.4S
    SHA1M  Q5, S17, V13.4S
    SHA256H2  Q0, Q3, V27.4S
    SHA1SU0  V29.4S, V2.4S, V12.4S
    SHA1SU1  V13.4S, V29.4S
    SHA256SU1  V21.4S, V16.4S, V24.4S
    SHA1M  Q25, S16, V4.4S
    SHA1M  Q18, S3, V4.4S
    SHA256H2  Q11, Q9, V0.4S
    SHA1SU1  V19.4S, V20.4S
    SHA256SU0  V24.4S, V18.4S
    SHA1SU0  V1.4S, V19.4S, V21.4S
    SHA256SU1  V6.4S, V14.4S, V8.4S
    SHA1M  Q16, S5, V0.4S
    SHA256H2  Q4, Q9, V1.4S
    SHA1SU0  V10.4S, V7.4S, V31.4S
    SHA256SU1  V5.4S, V10.4S, V14.4S
    SHA1SU1  V8.4S, V5.4S
    SHA1C  Q31, S2, V22.4S
    SHA1M  Q2, S31, V25.4S
    SHA1SU0  V28.4S, V4.4S, V13.4S
    SHA1SU1  V25.4S, V24.4S
    SHA1SU1  V20.4S, V6.4S
    SHA1SU1  V12.4S, V8.4S
    SHA1M  Q8, S12, V11.4S
    SHA256SU1  V0.4S, V8.4S, V2.4S
    SHA256H  Q3, Q16, V0.4S
    SHA1P  Q0, S28, V28.4S
    SHA256SU1  V16.4S, V25.4S, V20.4S
    SHA1SU0  V19.4S, V17.4S, V3.4S
    SHA256H  Q20, Q16, V19.4S
    SHA256SU1  V12.4S, V20.4S, V20.4S
    SHA1SU0  V3.4S, V0.4S, V12.4S
    SHA1SU0  V8.4S, V11.4S, V23.4S
    SHA1P  Q0, S10, V22.4S
    SHA1C  Q6, S31, V19.4S
    SHA256SU1  V11.4S, V7.4S, V27.4S
    SHA1C  Q10, S4, V16.4S
    SHA1SU0  V13.4S, V13.4S, V1.4S
    SHA1P  Q2, S1, V22.4S
    SHA256SU0  V28.4S, V9.4S
    SHA256H  Q22, Q3, V13.4S
    SHA1M  Q16, S2, V4.4S
    SHA1M  Q12, S0, V8.4S
    SHA256SU1  V27.4S, V12.4S, V8.4S
    SHA256H  Q9, Q22, V6.4S
    SHA1C  Q4, S16, V28.4S
    SHA1M  Q5, S9, V11.4S
    SHA256H2  Q1, Q5, V0.4S
    SHA1SU0  V23.4S, V27.4S, V4.4S
    SHA1M  Q11, S23, V10.4S
    SHA256SU0  V8.4S, V1.4S
    SHA1P  Q3, S8, V29.4S
    SHA256H  Q7, Q1, V3.4S
    SHA256SU0  V2.4S, V7.4S
    SHA1SU0  V27.4S, V11.4S, V11.4S
    SHA256H  Q28, Q4, V27.4S
    SHA1M  Q13, S2, V2.4S
    SHA1SU1  V17.4S, V13.4S
    SHA256H2  Q5, Q17, V28.4S
    SHA1SU0  V10.4S, V13.4S, V3.4S
    SHA1C  Q12, S3, V12.4S
    SHA1M  Q31, S19, V22.4S
    SHA1C  Q3, S12, V29.4S
    SHA1M  Q6, S22, V29.4S
    SHA256H  Q9, Q11, V21.4S
    SHA256SU0  V22.4S, V5.4S
    SHA1C  Q5, S30, V5.4S
    SHA1SU0  V8.4S, V23.4S, V31.4S
    SHA1P  Q27, S12, V4.4S
    SHA1SU1  V19.4S, V21.4S
    SHA256SU1  V2.4S, V5.4S, V10.4S
    SHA256H  Q7, Q8, V2.4S
    SHA1SU1  V13.4S, V7.4S
    SHA1C  Q12, S27, V3.4S
    SHA1P  Q0, S13, V12.4S
    SHA1SU1  V23.4S, V0.4S
    SHA1SU1  V1.4S, V22.4S
    SHA256SU0  V13.4S, V19.4S
    SHA256SU0  V4.4S, V23.4S
    SHA256H  Q21, Q9, V1.4S
    SHA256SU0  V7.4S, V21.4S
    SHA1M  Q22, S13, V7.4S
    SHA1M  Q2, S22, V4.4S
    SHA1SU1  V3.4S, V6.4S
    SHA1P  Q19, S3, V2.4S
    SHA256H2  Q4, Q4, V4.4S
    SHA256SU1  V31.4S, V8.4S, V11.4S
    SHA256SU0  V0.4S, V11.4S
    SHA1P  Q9, S30, V22.4S
    SUBS  X21, X21, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_10
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    SUB  X6, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X6, FPSR
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D0
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D1
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D2
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D3
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D4
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D5
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D6
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D7
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D8
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D9
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D10
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D11
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D12
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D13
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D14
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D15
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D16
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D17
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D18
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D19
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D20
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V21.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D21
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D22
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D23
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D24
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D25
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D26
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D27
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D28
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V29.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D29
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X6, D31
    SUB  X11, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  D1, X27
    FMOV  V1.D[1], X22
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X13
    FMOV  V3.D[1], X28
    FMOV  D4, X18
    FMOV  V4.D[1], X21
    FMOV  D5, X3
    FMOV  V5.D[1], X28
    FMOV  D6, X17
    FMOV  V6.D[1], X5
    FMOV  D7, X13
    FMOV  V7.D[1], X16
    FMOV  D8, X13
    FMOV  V8.D[1], X22
    FMOV  D9, X24
    FMOV  V9.D[1], X11
    FMOV  D10, X15
    FMOV  V10.D[1], X10
    FMOV  D11, X5
    FMOV  V11.D[1], X2
    FMOV  D12, X6
    FMOV  V12.D[1], X20
    FMOV  D13, X13
    FMOV  V13.D[1], X3
    FMOV  D14, X19
    FMOV  V14.D[1], X22
    FMOV  D15, X18
    FMOV  V15.D[1], X22
    FMOV  D16, X3
    FMOV  V16.D[1], X24
    FMOV  D17, X3
    FMOV  V17.D[1], X5
    FMOV  D18, X13
    FMOV  V18.D[1], X27
    FMOV  D19, X14
    FMOV  V19.D[1], X16
    FMOV  D20, X22
    FMOV  V20.D[1], X9
    FMOV  D21, X5
    FMOV  V21.D[1], X29
    FMOV  D22, X10
    FMOV  V22.D[1], X24
    FMOV  D23, X16
    FMOV  V23.D[1], X22
    FMOV  D24, X10
    FMOV  V24.D[1], X6
    FMOV  D25, X20
    FMOV  V25.D[1], X24
    FMOV  D26, X6
    FMOV  V26.D[1], X15
    FMOV  D27, X11
    FMOV  V27.D[1], X8
    FMOV  D28, X12
    FMOV  V28.D[1], X9
    FMOV  D29, X16
    FMOV  V29.D[1], X27
    FMOV  D30, X17
    FMOV  V30.D[1], X16
    FMOV  D31, X29
    FMOV  V31.D[1], X28
    MOVZ  X18, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_11:
    SHA256SU0  V8.4S, V24.4S
    SHA256H2  Q7, Q31, V25.4S
    SHA1SU0  V6.4S, V7.4S, V7.4S
    SHA1C  Q24, S26, V27.4S
    SHA256H2  Q25, Q30, V30.4S
    SHA1SU1  V31.4S, V28.4S
    SHA1C  Q12, S24, V29.4S
    SHA1SU1  V6.4S, V12.4S
    SHA256SU1  V3.4S, V8.4S, V8.4S
    SHA1SU0  V13.4S, V25.4S, V25.4S
    SHA1C  Q8, S23, V13.4S
    SHA256SU0  V28.4S, V31.4S
    SHA256SU1  V5.4S, V6.4S, V10.4S
    SHA1SU0  V0.4S, V8.4S, V5.4S
    SHA1P  Q27, S28, V0.4S
    SHA256SU0  V5.4S, V27.4S
    SHA256SU0  V12.4S, V3.4S
    SHA256H2  Q13, Q5, V5.4S
    SHA256SU0  V9.4S, V29.4S
    SHA256SU1  V10.4S, V9.4S, V12.4S
    SHA256SU1  V26.4S, V13.4S, V10.4S
    SHA1M  Q29, S14, V17.4S
    SHA1C  Q0, S2, V27.4S
    SHA256SU1  V24.4S, V3.4S, V21.4S
    SHA256H2  Q17, Q17, V3.4S
    SHA1M  Q21, S10, V16.4S
    SHA1M  Q28, S23, V21.4S
    SHA1C  Q31, S2, V21.4S
    SHA1C  Q25, S9, V5.4S
    SHA256SU0  V12.4S, V14.4S
    SHA256H2  Q21, Q4, V25.4S
    SHA1M  Q27, S29, V31.4S
    SHA1P  Q5, S27, V24.4S
    SHA1P  Q13, S26, V26.4S
    SHA1SU0  V23.4S, V12.4S, V0.4S
    SHA1P  Q8, S23, V23.4S
    SHA1C  Q6, S17, V5.4S
    SHA1SU0  V17.4S, V13.4S, V13.4S
    SHA1SU0  V13.4S, V28.4S, V8.4S
    SHA256H  Q31, Q21, V6.4S
    SHA256H  Q17, Q22, V31.4S
    SHA256H  Q24, Q17, V13.4S
    SHA1C  Q17, S7, V8.4S
    SHA256SU0  V12.4S, V23.4S
    SHA1SU1  V28.4S, V29.4S
    SHA1SU0  V29.4S, V19.4S, V11.4S
    SHA256SU0  V26.4S, V0.4S
    SHA1SU1  V25.4S, V24.4S
    SHA1M  Q5, S14, V0.4S
    SHA256SU1  V9.4S, V25.4S, V29.4S
    SHA1SU0  V27.4S, V18.4S, V11.4S
    SHA1C  Q0, S27, V19.4S
    SHA1M  Q24, S16, V1.4S
    SHA1M  Q14, S23, V3.4S
    SHA1SU1  V23.4S, V17.4S
    SHA1M  Q3, S28, V23.4S
    SHA256SU0  V16.4S, V12.4S
    SHA1SU1  V21.4S, V16.4S
    SHA1SU0  V28.4S, V26.4S, V26.4S
    SHA1SU1  V26.4S, V28.4S
    SHA256SU0  V16.4S, V9.4S
    SHA256H  Q18, Q5, V26.4S
    SHA1M  Q19, S3, V0.4S
    SHA1M  Q12, S21, V11.4S
    SHA1P  Q29, S19, V18.4S
    SHA256H2  Q0, Q16, V24.4S
    SHA256SU1  V23.4S, V14.4S, V14.4S
    SHA256H  Q27, Q23, V12.4S
    SHA1C  Q1, S27, V27.4S
    SHA1C  Q3, S29, V29.4S
    SHA1M  Q26, S0, V19.4S
    SHA1SU0  V9.4S, V3.4S, V1.4S
    SHA1SU1  V16.4S, V26.4S
    SHA1P  Q21, S9, V28.4S
    SHA1M  Q26, S16, V16.4S
    SHA1SU0  V9.4S, V26.4S, V21.4S
    SHA256SU1  V21.4S, V24.4S, V26.4S
    SHA1C  Q23, S0, V11.4S
    SHA256SU1  V1.4S, V29.4S, V0.4S
    SHA1M  Q19, S19, V6.4S
    SHA1P  Q27, S8, V2.4S
    SHA256SU1  V5.4S, V11.4S, V31.4S
    SHA1SU0  V18.4S, V28.4S, V26.4S
    SHA256SU0  V17.4S, V16.4S
    SHA256SU1  V0.4S, V21.4S, V17.4S
    SHA1M  Q1, S9, V9.4S
    SHA1SU1  V3.4S, V0.4S
    SHA256H2  Q6, Q3, V1.4S
    SHA256SU0  V3.4S, V18.4S
    SHA1M  Q24, S5, V19.4S
    SHA1C  Q29, S12, V3.4S
    SHA1SU0  V14.4S, V29.4S, V23.4S
    SHA256SU0  V19.4S, V6.4S
    SHA256SU0  V8.4S, V5.4S
    SHA1C  Q31, S27, V24.4S
    SHA1SU0  V1.4S, V31.4S, V31.4S
    SHA256H2  Q28, Q1, V1.4S
    SHA1SU1  V17.4S, V14.4S
    SHA1M  Q6, S8, V21.4S
    SHA1SU1  V16.4S, V6.4S
    SHA1C  Q29, S16, V28.4S
    SHA256H  Q6, Q29, V29.4S
    SHA1M  Q26, S19, V17.4S
    SHA256H2  Q9, Q10, V26.4S
    SHA256SU0  V11.4S, V9.4S
    SHA1SU1  V12.4S, V6.4S
    SHA1SU1  V31.4S, V12.4S
    SHA256H  Q2, Q11, V11.4S
    SHA256SU1  V27.4S, V2.4S, V31.4S
    SHA256H  Q3, Q13, V22.4S
    SHA1P  Q6, S18, V23.4S
    SHA256H2  Q5, Q2, V17.4S
    SHA1C  Q1, S13, V11.4S
    SHA256H2  Q2, Q23, V19.4S
    SHA1SU1  V0.4S, V15.4S
    SHA256H2  Q11, Q9, V30.4S
    SHA1M  Q24, S23, V10.4S
    SHA1P  Q22, S5, V24.4S
    SHA256SU0  V15.4S, V3.4S
    SHA256SU1  V28.4S, V15.4S, V11.4S
    SHA256SU1  V21.4S, V22.4S, V6.4S
    SHA256H2  Q11, Q1, V27.4S
    SHA256SU0  V12.4S, V28.4S
    SHA256SU0  V19.4S, V0.4S
    SHA1SU1  V26.4S, V12.4S
    SHA1SU1  V13.4S, V14.4S
    SHA256H  Q8, Q2, V19.4S
    SHA1C  Q28, S23, V21.4S
    SHA1P  Q22, S28, V11.4S
    SHA1C  Q17, S26, V15.4S
    SHA1SU0  V12.4S, V13.4S, V17.4S
    SHA1SU0  V19.4S, V8.4S, V12.4S
    SHA1P  Q0, S22, V22.4S
    SHA256H2  Q11, Q0, V19.4S
    SHA1C  Q22, S4, V10.4S
    SHA1P  Q14, S22, V15.4S
    SHA256H  Q15, Q3, V9.4S
    SHA1M  Q30, S0, V8.4S
    SHA256SU0  V2.4S, V22.4S
    SHA256H2  Q6, Q29, V10.4S
    SHA256H  Q3, Q0, V22.4S
    SHA256H2  Q22, Q4, V24.4S
    SHA1SU1  V21.4S, V17.4S
    SHA1SU0  V8.4S, V31.4S, V11.4S
    SHA1SU0  V4.4S, V14.4S, V30.4S
    SHA1C  Q14, S2, V2.4S
    SHA1SU0  V17.4S, V15.4S, V21.4S
    SHA256SU0  V2.4S, V22.4S
    SHA256SU1  V27.4S, V8.4S, V6.4S
    SHA1SU1  V26.4S, V3.4S
    SHA256SU0  V19.4S, V17.4S
    SHA1SU1  V22.4S, V14.4S
    SHA256H  Q30, Q2, V27.4S
    SHA256SU0  V17.4S, V22.4S
    SHA256H2  Q9, Q17, V4.4S
    SHA1C  Q12, S30, V26.4S
    SHA1C  Q30, S19, V19.4S
    SHA1SU1  V24.4S, V30.4S
    SHA256SU0  V15.4S, V9.4S
    SHA256SU1  V6.4S, V12.4S, V12.4S
    SHA1P  Q0, S24, V22.4S
    SHA256H  Q10, Q6, V0.4S
    SHA1C  Q4, S15, V10.4S
    SHA1M  Q24, S28, V5.4S
    SHA256H2  Q31, Q23, V25.4S
    SHA256SU1  V14.4S, V26.4S, V17.4S
    SHA256H2  Q3, Q20, V1.4S
    SHA1SU0  V23.4S, V3.4S, V18.4S
    SHA256SU0  V3.4S, V28.4S
    SHA256H  Q28, Q10, V25.4S
    SHA1P  Q12, S25, V26.4S
    SHA1SU1  V17.4S, V12.4S
    SHA1SU0  V10.4S, V6.4S, V0.4S
    SHA1M  Q26, S17, V4.4S
    SHA256H2  Q5, Q31, V14.4S
    SHA1SU0  V2.4S, V28.4S, V24.4S
    SHA256H2  Q22, Q26, V26.4S
    SHA1M  Q0, S23, V22.4S
    SHA1M  Q30, S3, V2.4S
    SHA1C  Q19, S5, V30.4S
    SHA1P  Q17, S0, V10.4S
    SHA1SU1  V23.4S, V17.4S
    SHA1P  Q30, S23, V19.4S
    SHA256H2  Q5, Q14, V11.4S
    SHA1SU0  V31.4S, V3.4S, V29.4S
    SHA256SU1  V6.4S, V1.4S, V18.4S
    SHA1P  Q26, S15, V11.4S
    SHA1SU0  V29.4S, V30.4S, V19.4S
    SHA256SU1  V30.4S, V12.4S, V19.4S
    SHA1SU0  V24.4S, V23.4S, V13.4S
    SHA1SU1  V0.4S, V29.4S
    SHA1SU1  V29.4S, V18.4S
    SHA1M  Q10, S30, V17.4S
    SHA256SU0  V25.4S, V5.4S
    SHA256H  Q4, Q19, V7.4S
    SHA1SU0  V2.4S, V24.4S, V2.4S
    SHA256SU0  V7.4S, V10.4S
    SHA256H  Q22, Q31, V29.4S
    SHA256SU1  V28.4S, V4.4S, V26.4S
    SHA1SU0  V4.4S, V25.4S, V2.4S
    SUBS  X18, X18, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_11
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x0, LSL #0
    SUB  X28, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    SUB  X28, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x9a12, LSL #0
    MOVK  X22, #0x1369, LSL #16
    MOVK  X22, #0xe9b4, LSL #32
    MOVK  X22, #0xc910, LSL #48
    FMOV  X28, V0.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xae81, LSL #0
    MOVK  X22, #0x5ac1, LSL #16
    MOVK  X22, #0xfb37, LSL #32
    MOVK  X22, #0x8cee, LSL #48
    FMOV  X28, D0
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x6828, LSL #0
    MOVK  X22, #0xb859, LSL #16
    MOVK  X22, #0xf261, LSL #32
    MOVK  X22, #0x3738, LSL #48
    FMOV  X28, V1.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x9f2d, LSL #0
    MOVK  X22, #0xb27, LSL #16
    MOVK  X22, #0xfd53, LSL #32
    MOVK  X22, #0x1efc, LSL #48
    FMOV  X28, D1
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xdd5f, LSL #0
    MOVK  X22, #0xd223, LSL #16
    MOVK  X22, #0x6b3a, LSL #32
    MOVK  X22, #0x84f1, LSL #48
    FMOV  X28, V2.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xa3b2, LSL #0
    MOVK  X22, #0x90e2, LSL #16
    MOVK  X22, #0x156e, LSL #32
    MOVK  X22, #0x80ad, LSL #48
    FMOV  X28, D2
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x7daa, LSL #0
    MOVK  X22, #0x3619, LSL #16
    MOVK  X22, #0xadb7, LSL #32
    MOVK  X22, #0xbc4f, LSL #48
    FMOV  X28, V3.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xc62b, LSL #0
    MOVK  X22, #0x7705, LSL #16
    MOVK  X22, #0x5f6f, LSL #32
    MOVK  X22, #0x8b8a, LSL #48
    FMOV  X28, D3
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x8dbe, LSL #0
    MOVK  X22, #0x6132, LSL #16
    MOVK  X22, #0xb59a, LSL #32
    MOVK  X22, #0x1377, LSL #48
    FMOV  X28, V4.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xc02e, LSL #0
    MOVK  X22, #0x71b6, LSL #16
    MOVK  X22, #0xab0c, LSL #32
    MOVK  X22, #0xe8df, LSL #48
    FMOV  X28, D4
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x3c51, LSL #0
    MOVK  X22, #0x64c6, LSL #16
    MOVK  X22, #0xa70e, LSL #32
    MOVK  X22, #0xc32a, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x5ec2, LSL #0
    MOVK  X22, #0x66df, LSL #16
    MOVK  X22, #0x27bf, LSL #32
    MOVK  X22, #0x882c, LSL #48
    FMOV  X28, D5
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xa8f7, LSL #0
    MOVK  X22, #0x58f0, LSL #16
    MOVK  X22, #0x987a, LSL #32
    MOVK  X22, #0xa9fe, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x2392, LSL #0
    MOVK  X22, #0xad9b, LSL #16
    MOVK  X22, #0x2525, LSL #32
    MOVK  X22, #0xb698, LSL #48
    FMOV  X28, D6
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x9847, LSL #0
    MOVK  X22, #0xe5ea, LSL #16
    MOVK  X22, #0xc989, LSL #32
    MOVK  X22, #0x78af, LSL #48
    FMOV  X28, V7.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xda6a, LSL #0
    MOVK  X22, #0x8459, LSL #16
    MOVK  X22, #0xa54e, LSL #32
    MOVK  X22, #0x7977, LSL #48
    FMOV  X28, D7
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xb351, LSL #0
    MOVK  X22, #0x8d95, LSL #16
    MOVK  X22, #0xfd53, LSL #32
    MOVK  X22, #0xb220, LSL #48
    FMOV  X28, V8.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x8e93, LSL #0
    MOVK  X22, #0x5b43, LSL #16
    MOVK  X22, #0xca65, LSL #32
    MOVK  X22, #0xc3d, LSL #48
    FMOV  X28, D8
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x9608, LSL #0
    MOVK  X22, #0xeb87, LSL #16
    MOVK  X22, #0xad1d, LSL #32
    MOVK  X22, #0x3b9b, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x3827, LSL #0
    MOVK  X22, #0xf6e9, LSL #16
    MOVK  X22, #0x65ec, LSL #32
    MOVK  X22, #0x43e, LSL #48
    FMOV  X28, D9
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x9521, LSL #0
    MOVK  X22, #0x786b, LSL #16
    MOVK  X22, #0xd799, LSL #32
    MOVK  X22, #0x8f3d, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x6229, LSL #0
    MOVK  X22, #0xb2b0, LSL #16
    MOVK  X22, #0xb2b9, LSL #32
    MOVK  X22, #0xf946, LSL #48
    FMOV  X28, D10
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x8644, LSL #0
    MOVK  X22, #0x32b2, LSL #16
    MOVK  X22, #0x6ef0, LSL #32
    MOVK  X22, #0xaed5, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xed2c, LSL #0
    MOVK  X22, #0xa928, LSL #16
    MOVK  X22, #0xc1f6, LSL #32
    MOVK  X22, #0xf7c, LSL #48
    FMOV  X28, D11
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x9bc6, LSL #0
    MOVK  X22, #0x3b9e, LSL #16
    MOVK  X22, #0xc2fc, LSL #32
    MOVK  X22, #0x2d8d, LSL #48
    FMOV  X28, V12.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x6fe, LSL #0
    MOVK  X22, #0xa649, LSL #16
    MOVK  X22, #0xd6fa, LSL #32
    MOVK  X22, #0xcef8, LSL #48
    FMOV  X28, D12
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xbd16, LSL #0
    MOVK  X22, #0x212c, LSL #16
    MOVK  X22, #0xd9dd, LSL #32
    MOVK  X22, #0xf1ab, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x7a09, LSL #0
    MOVK  X22, #0x509e, LSL #16
    MOVK  X22, #0x672d, LSL #32
    MOVK  X22, #0x87ce, LSL #48
    FMOV  X28, D13
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x1c4f, LSL #0
    MOVK  X22, #0xa3e8, LSL #16
    MOVK  X22, #0x2f5d, LSL #32
    MOVK  X22, #0x7ee9, LSL #48
    FMOV  X28, V14.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x1924, LSL #0
    MOVK  X22, #0x5ef2, LSL #16
    MOVK  X22, #0xc1d0, LSL #32
    MOVK  X22, #0xd1ea, LSL #48
    FMOV  X28, D14
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x5642, LSL #0
    MOVK  X22, #0xb951, LSL #16
    MOVK  X22, #0x4f6a, LSL #32
    MOVK  X22, #0xa6a, LSL #48
    FMOV  X28, V15.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xd920, LSL #0
    MOVK  X22, #0xef2c, LSL #16
    MOVK  X22, #0x8aae, LSL #32
    MOVK  X22, #0xd7b6, LSL #48
    FMOV  X28, D15
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xe876, LSL #0
    MOVK  X22, #0x3643, LSL #16
    MOVK  X22, #0xe0a, LSL #32
    MOVK  X22, #0x785c, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x773c, LSL #0
    MOVK  X22, #0x2b19, LSL #16
    MOVK  X22, #0x3013, LSL #32
    MOVK  X22, #0x81d6, LSL #48
    FMOV  X28, D16
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x569d, LSL #0
    MOVK  X22, #0x8061, LSL #16
    MOVK  X22, #0x6e0c, LSL #32
    MOVK  X22, #0x46b0, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x8ed4, LSL #0
    MOVK  X22, #0x6ea2, LSL #16
    MOVK  X22, #0x5f6a, LSL #32
    MOVK  X22, #0xfc50, LSL #48
    FMOV  X28, D17
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xbd33, LSL #0
    MOVK  X22, #0x4b7a, LSL #16
    MOVK  X22, #0xd33c, LSL #32
    MOVK  X22, #0x19f6, LSL #48
    FMOV  X28, V18.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xfe94, LSL #0
    MOVK  X22, #0x5b13, LSL #16
    MOVK  X22, #0x711f, LSL #32
    MOVK  X22, #0x9958, LSL #48
    FMOV  X28, D18
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x4b57, LSL #0
    MOVK  X22, #0xd86, LSL #16
    MOVK  X22, #0xdc10, LSL #32
    MOVK  X22, #0x962c, LSL #48
    FMOV  X28, V19.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x1b1c, LSL #0
    MOVK  X22, #0x8179, LSL #16
    MOVK  X22, #0x850f, LSL #32
    MOVK  X22, #0x9f05, LSL #48
    FMOV  X28, D19
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X28, V20.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xffff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    FMOV  X28, D20
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x5c83, LSL #0
    MOVK  X22, #0x4e47, LSL #16
    MOVK  X22, #0x2386, LSL #32
    MOVK  X22, #0x1675, LSL #48
    FMOV  X28, V21.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x5e36, LSL #0
    MOVK  X22, #0xc651, LSL #16
    MOVK  X22, #0xb777, LSL #32
    MOVK  X22, #0x1b7e, LSL #48
    FMOV  X28, D21
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xc8e8, LSL #0
    MOVK  X22, #0xd31d, LSL #16
    MOVK  X22, #0x8839, LSL #32
    MOVK  X22, #0xddee, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x2801, LSL #0
    MOVK  X22, #0x8983, LSL #16
    MOVK  X22, #0xd13a, LSL #32
    MOVK  X22, #0x3621, LSL #48
    FMOV  X28, D22
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x6409, LSL #0
    MOVK  X22, #0x47ef, LSL #16
    MOVK  X22, #0x48b4, LSL #32
    MOVK  X22, #0x4fa8, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xa9d3, LSL #0
    MOVK  X22, #0xc60b, LSL #16
    MOVK  X22, #0x535b, LSL #32
    MOVK  X22, #0x62d7, LSL #48
    FMOV  X28, D23
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x4af7, LSL #0
    MOVK  X22, #0x42a5, LSL #16
    MOVK  X22, #0x5dbf, LSL #32
    MOVK  X22, #0x7c5d, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xdd5f, LSL #0
    MOVK  X22, #0xd223, LSL #16
    MOVK  X22, #0x6b3a, LSL #32
    MOVK  X22, #0x84f1, LSL #48
    FMOV  X28, D24
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x56b2, LSL #0
    MOVK  X22, #0x54cc, LSL #16
    MOVK  X22, #0xf381, LSL #32
    MOVK  X22, #0x2baa, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xb1e4, LSL #0
    MOVK  X22, #0xf7b2, LSL #16
    MOVK  X22, #0x1b6, LSL #32
    MOVK  X22, #0x3c50, LSL #48
    FMOV  X28, D25
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x6f08, LSL #0
    MOVK  X22, #0xbfe4, LSL #16
    MOVK  X22, #0x7a2, LSL #32
    MOVK  X22, #0xab9c, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x7b6c, LSL #0
    MOVK  X22, #0x402b, LSL #16
    MOVK  X22, #0x665f, LSL #32
    MOVK  X22, #0xdfc1, LSL #48
    FMOV  X28, D26
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xc104, LSL #0
    MOVK  X22, #0x5cba, LSL #16
    MOVK  X22, #0xa9dd, LSL #32
    MOVK  X22, #0xbca1, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x637e, LSL #0
    MOVK  X22, #0x6209, LSL #16
    MOVK  X22, #0x8480, LSL #32
    MOVK  X22, #0xfbfe, LSL #48
    FMOV  X28, D27
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xa938, LSL #0
    MOVK  X22, #0x61e8, LSL #16
    MOVK  X22, #0xccb1, LSL #32
    MOVK  X22, #0xb7fb, LSL #48
    FMOV  X28, V28.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x4a4e, LSL #0
    MOVK  X22, #0xbba1, LSL #16
    MOVK  X22, #0xb8a0, LSL #32
    MOVK  X22, #0x42db, LSL #48
    FMOV  X28, D28
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x8862, LSL #0
    MOVK  X22, #0x86a, LSL #16
    MOVK  X22, #0xaae8, LSL #32
    MOVK  X22, #0x40fc, LSL #48
    FMOV  X28, V29.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x1e83, LSL #0
    MOVK  X22, #0xc5d5, LSL #16
    MOVK  X22, #0xd20e, LSL #32
    MOVK  X22, #0xd058, LSL #48
    FMOV  X28, D29
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xed16, LSL #0
    MOVK  X22, #0x7ef4, LSL #16
    MOVK  X22, #0xa1dc, LSL #32
    MOVK  X22, #0x86de, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xc5fc, LSL #0
    MOVK  X22, #0x185d, LSL #16
    MOVK  X22, #0x7bf3, LSL #32
    MOVK  X22, #0x846e, LSL #48
    FMOV  X28, D30
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0x4f73, LSL #0
    MOVK  X22, #0x4f47, LSL #16
    MOVK  X22, #0x20e1, LSL #32
    MOVK  X22, #0xcafe, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X22, #0xeb99, LSL #0
    MOVK  X22, #0x30cf, LSL #16
    MOVK  X22, #0x88f0, LSL #32
    MOVK  X22, #0x7b6f, LSL #48
    FMOV  X28, D31
    SUB  X13, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x474e, LSL #0
    MOVK  X2, #0x98c0, LSL #16
    MOVK  X2, #0xc18e, LSL #32
    MOVK  X2, #0x989a, LSL #48
    MOVZ  X3, #0xd821, LSL #0
    MOVK  X3, #0xcb06, LSL #16
    MOVK  X3, #0xad9f, LSL #32
    MOVK  X3, #0x9db6, LSL #48
    MOVZ  X5, #0x7f33, LSL #0
    MOVK  X5, #0xb74f, LSL #16
    MOVK  X5, #0x1a4, LSL #32
    MOVK  X5, #0xd6ea, LSL #48
    MOVZ  X6, #0xa176, LSL #0
    MOVK  X6, #0x1c8c, LSL #16
    MOVK  X6, #0xea2, LSL #32
    MOVK  X6, #0x55ea, LSL #48
    MOVZ  X8, #0x7561, LSL #0
    MOVK  X8, #0x60bc, LSL #16
    MOVK  X8, #0x3a13, LSL #32
    MOVK  X8, #0xfb53, LSL #48
    MOVZ  X9, #0xa2e9, LSL #0
    MOVK  X9, #0xcd37, LSL #16
    MOVK  X9, #0xc65e, LSL #32
    MOVK  X9, #0xa647, LSL #48
    MOVZ  X10, #0xe3dd, LSL #0
    MOVK  X10, #0x2bc6, LSL #16
    MOVK  X10, #0x8410, LSL #32
    MOVK  X10, #0x983c, LSL #48
    MOVZ  X11, #0x75ec, LSL #0
    MOVK  X11, #0x5420, LSL #16
    MOVK  X11, #0x50fe, LSL #32
    MOVK  X11, #0x6a3a, LSL #48
    MOVZ  X12, #0xc086, LSL #0
    MOVK  X12, #0xbcd6, LSL #16
    MOVK  X12, #0x72cc, LSL #32
    MOVK  X12, #0xa4e0, LSL #48
    MOVZ  X13, #0xc142, LSL #0
    MOVK  X13, #0xb698, LSL #16
    MOVK  X13, #0xb657, LSL #32
    MOVK  X13, #0x80b5, LSL #48
    MOVZ  X14, #0xdaa7, LSL #0
    MOVK  X14, #0x211a, LSL #16
    MOVK  X14, #0x823b, LSL #32
    MOVK  X14, #0x711, LSL #48
    MOVZ  X15, #0xaa86, LSL #0
    MOVK  X15, #0x8653, LSL #16
    MOVK  X15, #0xa0d1, LSL #32
    MOVK  X15, #0x5730, LSL #48
    MOVZ  X16, #0xc4a, LSL #0
    MOVK  X16, #0xc64f, LSL #16
    MOVK  X16, #0x7756, LSL #32
    MOVK  X16, #0x9a83, LSL #48
    MOVZ  X17, #0x1470, LSL #0
    MOVK  X17, #0x2cf7, LSL #16
    MOVK  X17, #0xce91, LSL #32
    MOVK  X17, #0x1233, LSL #48
    MOVZ  X18, #0xd2a6, LSL #0
    MOVK  X18, #0xf313, LSL #16
    MOVK  X18, #0xd798, LSL #32
    MOVK  X18, #0xdcde, LSL #48
    MOVZ  X19, #0x6b26, LSL #0
    MOVK  X19, #0x5648, LSL #16
    MOVK  X19, #0xf211, LSL #32
    MOVK  X19, #0xab07, LSL #48
    MOVZ  X20, #0xec50, LSL #0
    MOVK  X20, #0xd230, LSL #16
    MOVK  X20, #0xf09e, LSL #32
    MOVK  X20, #0x48a4, LSL #48
    MOVZ  X21, #0x4687, LSL #0
    MOVK  X21, #0xe2d4, LSL #16
    MOVK  X21, #0x4617, LSL #32
    MOVK  X21, #0x264a, LSL #48
    MOVZ  X22, #0x9114, LSL #0
    MOVK  X22, #0xecb7, LSL #16
    MOVK  X22, #0x2123, LSL #32
    MOVK  X22, #0xbf16, LSL #48
    MOVZ  X24, #0x59e5, LSL #0
    MOVK  X24, #0x529f, LSL #16
    MOVK  X24, #0x27db, LSL #32
    MOVK  X24, #0xe023, LSL #48
    MOVZ  X25, #0xb149, LSL #0
    MOVK  X25, #0x41ae, LSL #16
    MOVK  X25, #0xbe7c, LSL #32
    MOVK  X25, #0x128f, LSL #48
    MOVZ  X27, #0x3514, LSL #0
    MOVK  X27, #0x450, LSL #16
    MOVK  X27, #0xbc4, LSL #32
    MOVK  X27, #0xe1b3, LSL #48
    MOVZ  X28, #0xffa2, LSL #0
    MOVK  X28, #0x17ee, LSL #16
    MOVK  X28, #0x827, LSL #32
    MOVK  X28, #0xdf46, LSL #48
    MOVZ  X29, #0x9cf1, LSL #0
    MOVK  X29, #0xf3ac, LSL #16
    MOVK  X29, #0x36ec, LSL #32
    MOVK  X29, #0x6bf9, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X21
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X13
    FMOV  V3.D[1], X19
    FMOV  D4, X22
    FMOV  V4.D[1], X5
    FMOV  D5, X17
    FMOV  V5.D[1], X8
    FMOV  D6, X29
    FMOV  V6.D[1], X5
    FMOV  D7, X11
    FMOV  V7.D[1], X11
    FMOV  D8, X27
    FMOV  V8.D[1], X12
    FMOV  D9, X19
    FMOV  V9.D[1], X2
    FMOV  D10, X5
    FMOV  V10.D[1], X15
    FMOV  D11, X29
    FMOV  V11.D[1], X6
    FMOV  D12, X19
    FMOV  V12.D[1], X28
    FMOV  D13, X27
    FMOV  V13.D[1], X15
    FMOV  D14, X12
    FMOV  V14.D[1], X28
    FMOV  D15, X24
    FMOV  V15.D[1], X28
    FMOV  D16, X16
    FMOV  V16.D[1], X16
    FMOV  D17, X15
    FMOV  V17.D[1], X22
    FMOV  D18, X9
    FMOV  V18.D[1], X2
    FMOV  D19, X5
    FMOV  V19.D[1], X8
    FMOV  D20, X25
    FMOV  V20.D[1], X24
    FMOV  D21, X18
    FMOV  V21.D[1], X8
    FMOV  D22, X5
    FMOV  V22.D[1], X22
    FMOV  D23, X9
    FMOV  V23.D[1], X13
    FMOV  D24, X27
    FMOV  V24.D[1], X10
    FMOV  D25, X25
    FMOV  V25.D[1], X14
    FMOV  D26, X29
    FMOV  V26.D[1], X22
    FMOV  D27, X13
    FMOV  V27.D[1], X3
    FMOV  D28, X14
    FMOV  V28.D[1], X9
    FMOV  D29, X22
    FMOV  V29.D[1], X11
    FMOV  D30, X13
    FMOV  V30.D[1], X20
    FMOV  D31, X21
    FMOV  V31.D[1], X16
    MOVZ  X8, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_12:
    SHA1SU1  V26.4S, V30.4S
    SHA256SU0  V21.4S, V31.4S
    SHA256SU0  V19.4S, V26.4S
    SHA256SU1  V5.4S, V25.4S, V25.4S
    SHA1M  Q6, S20, V19.4S
    SHA256H2  Q11, Q6, V5.4S
    SHA256H2  Q16, Q28, V29.4S
    SHA256SU1  V12.4S, V11.4S, V24.4S
    SHA1C  Q7, S27, V27.4S
    SHA1M  Q14, S23, V7.4S
    SHA256H2  Q20, Q14, V14.4S
    SHA1M  Q25, S20, V18.4S
    SHA256H  Q28, Q21, V25.4S
    SHA1M  Q27, S30, V16.4S
    SHA1M  Q16, S28, V28.4S
    SHA256SU1  V21.4S, V24.4S, V16.4S
    SHA1C  Q29, S12, V12.4S
    SHA256SU1  V25.4S, V27.4S, V27.4S
    SHA1C  Q4, S25, V29.4S
    SHA1C  Q30, S24, V21.4S
    SHA256SU0  V12.4S, V30.4S
    SHA1P  Q20, S12, V4.4S
    SHA256H  Q23, Q1, V18.4S
    SHA256H  Q19, Q14, V23.4S
    SHA256H2  Q28, Q29, V25.4S
    SHA1SU0  V16.4S, V11.4S, V6.4S
    SHA1SU0  V23.4S, V7.4S, V2.4S
    SHA1SU0  V26.4S, V6.4S, V24.4S
    SHA256SU0  V25.4S, V28.4S
    SHA1C  Q4, S8, V2.4S
    SHA256SU1  V11.4S, V25.4S, V4.4S
    SHA256H2  Q4, Q27, V3.4S
    SHA256H2  Q28, Q30, V26.4S
    SHA1SU1  V14.4S, V27.4S
    SHA1M  Q21, S1, V8.4S
    SHA1M  Q3, S11, V11.4S
    SHA1P  Q12, S23, V16.4S
    SHA256SU0  V31.4S, V20.4S
    SHA256H2  Q24, Q25, V4.4S
    SHA1M  Q20, S31, V8.4S
    SHA256SU1  V11.4S, V3.4S, V28.4S
    SHA256SU1  V2.4S, V12.4S, V24.4S
    SHA1SU1  V8.4S, V19.4S
    SHA1SU1  V18.4S, V2.4S
    SHA256SU0  V16.4S, V11.4S
    SHA1P  Q7, S12, V21.4S
    SHA256SU1  V23.4S, V8.4S, V16.4S
    SHA256H  Q8, Q18, V20.4S
    SHA1P  Q6, S23, V7.4S
    SHA1SU1  V4.4S, V4.4S
    SHA1C  Q23, S14, V14.4S
    SHA1P  Q11, S8, V23.4S
    SHA1M  Q21, S4, V4.4S
    SHA1M  Q2, S6, V21.4S
    SHA1P  Q25, S11, V2.4S
    SHA1M  Q3, S26, V21.4S
    SHA256H2  Q24, Q28, V29.4S
    SHA1SU1  V23.4S, V7.4S
    SHA1SU1  V28.4S, V28.4S
    SHA1C  Q2, S31, V30.4S
    SHA256SU0  V18.4S, V13.4S
    SHA1P  Q13, S0, V23.4S
    SHA1P  Q31, S6, V27.4S
    SHA1SU1  V21.4S, V29.4S
    SHA1P  Q7, S21, V4.4S
    SHA1SU1  V6.4S, V31.4S
    SHA256H  Q4, Q6, V25.4S
    SHA1M  Q11, S13, V18.4S
    SHA256H  Q8, Q7, V4.4S
    SHA256H  Q31, Q11, V28.4S
    SHA256SU1  V14.4S, V2.4S, V3.4S
    SHA1SU0  V6.4S, V8.4S, V8.4S
    SHA1SU1  V19.4S, V31.4S
    SHA256SU0  V29.4S, V14.4S
    SHA256SU1  V23.4S, V6.4S, V19.4S
    SHA256SU1  V13.4S, V24.4S, V24.4S
    SHA1P  Q30, S7, V29.4S
    SHA256H2  Q26, Q30, V23.4S
    SHA256SU1  V28.4S, V26.4S, V13.4S
    SHA1SU1  V19.4S, V6.4S
    SHA1SU1  V23.4S, V11.4S
    SHA256SU1  V9.4S, V22.4S, V29.4S
    SHA1C  Q21, S10, V10.4S
    SHA256H  Q6, Q20, V14.4S
    SHA1SU1  V14.4S, V15.4S
    SHA1SU0  V20.4S, V11.4S, V26.4S
    SHA256H2  Q8, Q15, V28.4S
    SHA1M  Q24, S30, V14.4S
    SHA1C  Q18, S27, V16.4S
    SHA256SU1  V2.4S, V19.4S, V24.4S
    SHA256SU0  V7.4S, V9.4S
    SHA1C  Q15, S13, V2.4S
    SHA256SU1  V3.4S, V15.4S, V15.4S
    SHA256SU1  V10.4S, V21.4S, V8.4S
    SHA256H  Q29, Q28, V10.4S
    SHA256SU1  V10.4S, V18.4S, V20.4S
    SHA1SU0  V13.4S, V7.4S, V3.4S
    SHA256H  Q24, Q6, V29.4S
    SHA1SU0  V20.4S, V13.4S, V24.4S
    SHA1SU0  V26.4S, V10.4S, V10.4S
    SHA256H  Q22, Q23, V23.4S
    SHA256H  Q30, Q22, V22.4S
    SHA256SU0  V8.4S, V30.4S
    SHA1SU1  V6.4S, V20.4S
    SHA256H2  Q13, Q26, V6.4S
    SHA1P  Q6, S8, V13.4S
    SHA1M  Q2, S14, V20.4S
    SHA256H2  Q29, Q18, V27.4S
    SHA256SU1  V30.4S, V27.4S, V12.4S
    SHA1SU1  V11.4S, V7.4S
    SHA1SU1  V22.4S, V21.4S
    SHA1SU1  V28.4S, V1.4S
    SHA1SU0  V12.4S, V31.4S, V10.4S
    SHA256H  Q23, Q14, V25.4S
    SHA256H2  Q24, Q6, V23.4S
    SHA1P  Q8, S8, V12.4S
    SHA256H2  Q14, Q1, V24.4S
    SHA1C  Q26, S7, V14.4S
    SHA1SU0  V24.4S, V28.4S, V11.4S
    SHA256H  Q10, Q29, V30.4S
    SHA256H  Q21, Q2, V22.4S
    SHA256SU0  V2.4S, V21.4S
    SHA1SU1  V23.4S, V8.4S
    SHA256SU1  V11.4S, V10.4S, V10.4S
    SHA1SU0  V25.4S, V11.4S, V26.4S
    SHA256SU0  V27.4S, V24.4S
    SHA1P  Q31, S27, V2.4S
    SHA1C  Q26, S23, V23.4S
    SHA256SU0  V8.4S, V25.4S
    SHA256SU0  V6.4S, V8.4S
    SHA256H  Q18, Q6, V6.4S
    SHA256H  Q11, Q26, V18.4S
    SHA256H  Q26, Q31, V13.4S
    SHA256SU1  V24.4S, V11.4S, V26.4S
    SHA256H2  Q22, Q7, V15.4S
    SHA256H2  Q6, Q7, V26.4S
    SHA1P  Q10, S0, V14.4S
    SHA256H2  Q14, Q22, V15.4S
    SHA1M  Q2, S14, V3.4S
    SHA1SU1  V28.4S, V27.4S
    SHA1SU0  V18.4S, V2.4S, V22.4S
    SHA256SU0  V29.4S, V23.4S
    SHA1C  Q3, S17, V26.4S
    SHA1P  Q31, S21, V20.4S
    SHA256H  Q27, Q18, V2.4S
    SHA1C  Q26, S30, V13.4S
    SHA256H2  Q8, Q13, V28.4S
    SHA256H  Q13, Q3, V8.4S
    SHA1SU1  V21.4S, V29.4S
    SHA256SU1  V11.4S, V13.4S, V31.4S
    SHA1M  Q7, S27, V21.4S
    SHA1C  Q28, S10, V15.4S
    SHA256H  Q21, Q24, V26.4S
    SHA256H  Q30, Q11, V11.4S
    SHA256H  Q26, Q28, V7.4S
    SHA1SU0  V3.4S, V30.4S, V6.4S
    SHA256SU0  V2.4S, V22.4S
    SHA1SU1  V24.4S, V21.4S
    SHA1M  Q6, S24, V2.4S
    SHA256SU1  V23.4S, V26.4S, V3.4S
    SHA256H  Q3, Q6, V6.4S
    SHA1P  Q29, S3, V3.4S
    SHA1C  Q20, S29, V29.4S
    SHA1M  Q2, S20, V23.4S
    SHA1C  Q29, S26, V7.4S
    SHA1SU0  V6.4S, V14.4S, V0.4S
    SHA1SU1  V10.4S, V19.4S
    SHA1M  Q15, S20, V15.4S
    SHA1P  Q22, S5, V30.4S
    SHA256H2  Q23, Q13, V20.4S
    SHA256H2  Q26, Q13, V1.4S
    SHA1M  Q7, S30, V17.4S
    SHA1P  Q19, S2, V22.4S
    SHA1M  Q2, S19, V29.4S
    SHA256SU1  V1.4S, V2.4S, V7.4S
    SHA256SU0  V21.4S, V23.4S
    SHA1P  Q19, S6, V6.4S
    SHA256SU0  V6.4S, V8.4S
    SHA256H  Q7, Q10, V15.4S
    SHA256SU1  V20.4S, V6.4S, V26.4S
    SHA1SU1  V14.4S, V1.4S
    SHA1SU1  V5.4S, V14.4S
    SHA1M  Q28, S20, V5.4S
    SHA256H  Q8, Q28, V0.4S
    SHA1M  Q13, S21, V19.4S
    SHA256H  Q0, Q7, V7.4S
    SHA1P  Q15, S8, V8.4S
    SHA256H  Q29, Q15, V13.4S
    SHA256SU0  V6.4S, V29.4S
    SHA256SU0  V17.4S, V0.4S
    SHA256SU0  V26.4S, V17.4S
    SHA1SU0  V17.4S, V26.4S, V6.4S
    SHA256SU0  V8.4S, V17.4S
    SHA256H2  Q2, Q11, V6.4S
    SHA256H  Q0, Q17, V9.4S
    SHA1SU0  V30.4S, V11.4S, V16.4S
    SHA256H2  Q23, Q7, V28.4S
    SHA256H  Q15, Q6, V14.4S
    SHA256SU0  V21.4S, V1.4S
    SHA1C  Q20, S9, V27.4S
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_12
    MOVZ  X12, #0x474e, LSL #0
    MOVK  X12, #0x98c0, LSL #16
    MOVK  X12, #0xc18e, LSL #32
    MOVK  X12, #0x989a, LSL #48
    SUB  X19, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xd821, LSL #0
    MOVK  X12, #0xcb06, LSL #16
    MOVK  X12, #0xad9f, LSL #32
    MOVK  X12, #0x9db6, LSL #48
    SUB  X19, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7f33, LSL #0
    MOVK  X12, #0xb74f, LSL #16
    MOVK  X12, #0x1a4, LSL #32
    MOVK  X12, #0xd6ea, LSL #48
    SUB  X19, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xa176, LSL #0
    MOVK  X12, #0x1c8c, LSL #16
    MOVK  X12, #0xea2, LSL #32
    MOVK  X12, #0x55ea, LSL #48
    SUB  X19, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    SUB  X19, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xa2e9, LSL #0
    MOVK  X12, #0xcd37, LSL #16
    MOVK  X12, #0xc65e, LSL #32
    MOVK  X12, #0xa647, LSL #48
    SUB  X19, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xe3dd, LSL #0
    MOVK  X12, #0x2bc6, LSL #16
    MOVK  X12, #0x8410, LSL #32
    MOVK  X12, #0x983c, LSL #48
    SUB  X19, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x75ec, LSL #0
    MOVK  X12, #0x5420, LSL #16
    MOVK  X12, #0x50fe, LSL #32
    MOVK  X12, #0x6a3a, LSL #48
    SUB  X19, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xc142, LSL #0
    MOVK  X12, #0xb698, LSL #16
    MOVK  X12, #0xb657, LSL #32
    MOVK  X12, #0x80b5, LSL #48
    SUB  X19, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xdaa7, LSL #0
    MOVK  X12, #0x211a, LSL #16
    MOVK  X12, #0x823b, LSL #32
    MOVK  X12, #0x711, LSL #48
    SUB  X19, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xaa86, LSL #0
    MOVK  X12, #0x8653, LSL #16
    MOVK  X12, #0xa0d1, LSL #32
    MOVK  X12, #0x5730, LSL #48
    SUB  X19, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x1470, LSL #0
    MOVK  X12, #0x2cf7, LSL #16
    MOVK  X12, #0xce91, LSL #32
    MOVK  X12, #0x1233, LSL #48
    SUB  X19, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xd2a6, LSL #0
    MOVK  X12, #0xf313, LSL #16
    MOVK  X12, #0xd798, LSL #32
    MOVK  X12, #0xdcde, LSL #48
    SUB  X19, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xec50, LSL #0
    MOVK  X12, #0xd230, LSL #16
    MOVK  X12, #0xf09e, LSL #32
    MOVK  X12, #0x48a4, LSL #48
    SUB  X19, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x4687, LSL #0
    MOVK  X12, #0xe2d4, LSL #16
    MOVK  X12, #0x4617, LSL #32
    MOVK  X12, #0x264a, LSL #48
    SUB  X19, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x9114, LSL #0
    MOVK  X12, #0xecb7, LSL #16
    MOVK  X12, #0x2123, LSL #32
    MOVK  X12, #0xbf16, LSL #48
    SUB  X19, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x59e5, LSL #0
    MOVK  X12, #0x529f, LSL #16
    MOVK  X12, #0x27db, LSL #32
    MOVK  X12, #0xe023, LSL #48
    SUB  X19, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xb149, LSL #0
    MOVK  X12, #0x41ae, LSL #16
    MOVK  X12, #0xbe7c, LSL #32
    MOVK  X12, #0x128f, LSL #48
    SUB  X19, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x3514, LSL #0
    MOVK  X12, #0x450, LSL #16
    MOVK  X12, #0xbc4, LSL #32
    MOVK  X12, #0xe1b3, LSL #48
    SUB  X19, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xffa2, LSL #0
    MOVK  X12, #0x17ee, LSL #16
    MOVK  X12, #0x827, LSL #32
    MOVK  X12, #0xdf46, LSL #48
    SUB  X19, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x9cf1, LSL #0
    MOVK  X12, #0xf3ac, LSL #16
    MOVK  X12, #0x36ec, LSL #32
    MOVK  X12, #0x6bf9, LSL #48
    SUB  X19, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xa7ca, LSL #0
    MOVK  X12, #0x8cce, LSL #16
    MOVK  X12, #0xfcda, LSL #32
    MOVK  X12, #0x3116, LSL #48
    FMOV  X19, V0.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xdb10, LSL #0
    MOVK  X12, #0x389b, LSL #16
    MOVK  X12, #0xeba4, LSL #32
    MOVK  X12, #0x9dfb, LSL #48
    FMOV  X19, D0
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x142a, LSL #0
    MOVK  X12, #0x3117, LSL #16
    MOVK  X12, #0xa572, LSL #32
    MOVK  X12, #0x887, LSL #48
    FMOV  X19, V1.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xffbe, LSL #0
    MOVK  X12, #0x5d0e, LSL #16
    MOVK  X12, #0x536a, LSL #32
    MOVK  X12, #0x6acd, LSL #48
    FMOV  X19, D1
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x12e3, LSL #0
    MOVK  X12, #0xb8d6, LSL #16
    MOVK  X12, #0x91e5, LSL #32
    MOVK  X12, #0x3e29, LSL #48
    FMOV  X19, V2.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x732c, LSL #0
    MOVK  X12, #0xb239, LSL #16
    MOVK  X12, #0x8a5e, LSL #32
    MOVK  X12, #0xfe3a, LSL #48
    FMOV  X19, D2
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6938, LSL #0
    MOVK  X12, #0x30a0, LSL #16
    MOVK  X12, #0x2409, LSL #32
    MOVK  X12, #0x1bb6, LSL #48
    FMOV  X19, V3.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x4f83, LSL #0
    MOVK  X12, #0x98cd, LSL #16
    MOVK  X12, #0xad6d, LSL #32
    MOVK  X12, #0xded5, LSL #48
    FMOV  X19, D3
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6506, LSL #0
    MOVK  X12, #0x9e7, LSL #16
    MOVK  X12, #0x304b, LSL #32
    MOVK  X12, #0x4af3, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xad2e, LSL #0
    MOVK  X12, #0x491d, LSL #16
    MOVK  X12, #0x9454, LSL #32
    MOVK  X12, #0x996f, LSL #48
    FMOV  X19, D4
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7223, LSL #0
    MOVK  X12, #0x205e, LSL #16
    MOVK  X12, #0x7035, LSL #32
    MOVK  X12, #0xa732, LSL #48
    FMOV  X19, V5.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x81c2, LSL #0
    MOVK  X12, #0x2269, LSL #16
    MOVK  X12, #0x3b39, LSL #32
    MOVK  X12, #0x2e02, LSL #48
    FMOV  X19, D5
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xa84e, LSL #0
    MOVK  X12, #0x2cc6, LSL #16
    MOVK  X12, #0x251e, LSL #32
    MOVK  X12, #0x6299, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xb92c, LSL #0
    MOVK  X12, #0x17bd, LSL #16
    MOVK  X12, #0x441a, LSL #32
    MOVK  X12, #0x3843, LSL #48
    FMOV  X19, D6
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf1fc, LSL #0
    MOVK  X12, #0x5ef0, LSL #16
    MOVK  X12, #0x839b, LSL #32
    MOVK  X12, #0xc8e0, LSL #48
    FMOV  X19, V7.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x3115, LSL #0
    MOVK  X12, #0x1940, LSL #16
    MOVK  X12, #0xffc7, LSL #32
    MOVK  X12, #0x4639, LSL #48
    FMOV  X19, D7
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x77e8, LSL #0
    MOVK  X12, #0x137c, LSL #16
    MOVK  X12, #0xbe24, LSL #32
    MOVK  X12, #0x4a86, LSL #48
    FMOV  X19, V8.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf86, LSL #0
    MOVK  X12, #0xa135, LSL #16
    MOVK  X12, #0x8829, LSL #32
    MOVK  X12, #0x6f2b, LSL #48
    FMOV  X19, D8
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x3c41, LSL #0
    MOVK  X12, #0x1476, LSL #16
    MOVK  X12, #0x5599, LSL #32
    MOVK  X12, #0x82b9, LSL #48
    FMOV  X19, V9.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xb937, LSL #0
    MOVK  X12, #0xebb5, LSL #16
    MOVK  X12, #0x891, LSL #32
    MOVK  X12, #0xd16a, LSL #48
    FMOV  X19, D9
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xe604, LSL #0
    MOVK  X12, #0xa25f, LSL #16
    MOVK  X12, #0x70ba, LSL #32
    MOVK  X12, #0xf355, LSL #48
    FMOV  X19, V10.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7325, LSL #0
    MOVK  X12, #0xf0e4, LSL #16
    MOVK  X12, #0x27cf, LSL #32
    MOVK  X12, #0xc29a, LSL #48
    FMOV  X19, D10
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6dad, LSL #0
    MOVK  X12, #0x4d60, LSL #16
    MOVK  X12, #0x4d15, LSL #32
    MOVK  X12, #0xfb10, LSL #48
    FMOV  X19, V11.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6996, LSL #0
    MOVK  X12, #0xfe02, LSL #16
    MOVK  X12, #0x4b71, LSL #32
    MOVK  X12, #0xe24d, LSL #48
    FMOV  X19, D11
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6bf4, LSL #0
    MOVK  X12, #0x3e6f, LSL #16
    MOVK  X12, #0xa700, LSL #32
    MOVK  X12, #0x2e3e, LSL #48
    FMOV  X19, V12.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xb3f6, LSL #0
    MOVK  X12, #0x96e7, LSL #16
    MOVK  X12, #0x5edf, LSL #32
    MOVK  X12, #0xc020, LSL #48
    FMOV  X19, D12
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x774a, LSL #0
    MOVK  X12, #0xe4f5, LSL #16
    MOVK  X12, #0x98d6, LSL #32
    MOVK  X12, #0x958b, LSL #48
    FMOV  X19, V13.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xb599, LSL #0
    MOVK  X12, #0xd9cc, LSL #16
    MOVK  X12, #0x36af, LSL #32
    MOVK  X12, #0xc1d2, LSL #48
    FMOV  X19, D13
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7c64, LSL #0
    MOVK  X12, #0x9c3b, LSL #16
    MOVK  X12, #0x238e, LSL #32
    MOVK  X12, #0x480a, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xe97, LSL #0
    MOVK  X12, #0x49d5, LSL #16
    MOVK  X12, #0x51b, LSL #32
    MOVK  X12, #0x206f, LSL #48
    FMOV  X19, D14
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xeea6, LSL #0
    MOVK  X12, #0xf0ae, LSL #16
    MOVK  X12, #0x90ae, LSL #32
    MOVK  X12, #0x8238, LSL #48
    FMOV  X19, V15.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x8e4f, LSL #0
    MOVK  X12, #0x6132, LSL #16
    MOVK  X12, #0xff6, LSL #32
    MOVK  X12, #0xcd4c, LSL #48
    FMOV  X19, D15
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6478, LSL #0
    MOVK  X12, #0xf57e, LSL #16
    MOVK  X12, #0x42a1, LSL #32
    MOVK  X12, #0x1f50, LSL #48
    FMOV  X19, V16.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x62c2, LSL #0
    MOVK  X12, #0xcd79, LSL #16
    MOVK  X12, #0xb976, LSL #32
    MOVK  X12, #0xfe5b, LSL #48
    FMOV  X19, D16
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x7e54, LSL #0
    MOVK  X12, #0x5cd2, LSL #16
    MOVK  X12, #0x999d, LSL #32
    MOVK  X12, #0x4176, LSL #48
    FMOV  X19, V17.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xbd6a, LSL #0
    MOVK  X12, #0x2a74, LSL #16
    MOVK  X12, #0x600b, LSL #32
    MOVK  X12, #0xaa69, LSL #48
    FMOV  X19, D17
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xc040, LSL #0
    MOVK  X12, #0xf44e, LSL #16
    MOVK  X12, #0x9ddd, LSL #32
    MOVK  X12, #0xd439, LSL #48
    FMOV  X19, V18.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xd48b, LSL #0
    MOVK  X12, #0xb3c0, LSL #16
    MOVK  X12, #0xc3cb, LSL #32
    MOVK  X12, #0xa680, LSL #48
    FMOV  X19, D18
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x9040, LSL #0
    MOVK  X12, #0xb060, LSL #16
    MOVK  X12, #0x8f4b, LSL #32
    MOVK  X12, #0x7ef4, LSL #48
    FMOV  X19, V19.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x10a3, LSL #0
    MOVK  X12, #0x2063, LSL #16
    MOVK  X12, #0x2f68, LSL #32
    MOVK  X12, #0x9465, LSL #48
    FMOV  X19, D19
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x2dba, LSL #0
    MOVK  X12, #0x4f2f, LSL #16
    MOVK  X12, #0xa812, LSL #32
    MOVK  X12, #0xcbe9, LSL #48
    FMOV  X19, V20.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x3b1d, LSL #0
    MOVK  X12, #0x246f, LSL #16
    MOVK  X12, #0x5f1c, LSL #32
    MOVK  X12, #0xe0b0, LSL #48
    FMOV  X19, D20
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x315c, LSL #0
    MOVK  X12, #0x56a7, LSL #16
    MOVK  X12, #0x1a9c, LSL #32
    MOVK  X12, #0xa874, LSL #48
    FMOV  X19, V21.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xe8e8, LSL #0
    MOVK  X12, #0xe6ae, LSL #16
    MOVK  X12, #0x2426, LSL #32
    MOVK  X12, #0x5e73, LSL #48
    FMOV  X19, D21
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xdfba, LSL #0
    MOVK  X12, #0x91c1, LSL #16
    MOVK  X12, #0xc526, LSL #32
    MOVK  X12, #0x641d, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf352, LSL #0
    MOVK  X12, #0x4b28, LSL #16
    MOVK  X12, #0xde7c, LSL #32
    MOVK  X12, #0x105f, LSL #48
    FMOV  X19, D22
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xfc3d, LSL #0
    MOVK  X12, #0x188d, LSL #16
    MOVK  X12, #0xd111, LSL #32
    MOVK  X12, #0x4e29, LSL #48
    FMOV  X19, V23.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x10ca, LSL #0
    MOVK  X12, #0xfceb, LSL #16
    MOVK  X12, #0x21d9, LSL #32
    MOVK  X12, #0x9356, LSL #48
    FMOV  X19, D23
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xb848, LSL #0
    MOVK  X12, #0x1520, LSL #16
    MOVK  X12, #0x7c25, LSL #32
    MOVK  X12, #0xa885, LSL #48
    FMOV  X19, V24.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xbf53, LSL #0
    MOVK  X12, #0x6342, LSL #16
    MOVK  X12, #0x6db4, LSL #32
    MOVK  X12, #0x6905, LSL #48
    FMOV  X19, D24
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x6129, LSL #0
    MOVK  X12, #0xac31, LSL #16
    MOVK  X12, #0xf932, LSL #32
    MOVK  X12, #0xb410, LSL #48
    FMOV  X19, V25.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xbf1f, LSL #0
    MOVK  X12, #0x77f2, LSL #16
    MOVK  X12, #0xab86, LSL #32
    MOVK  X12, #0xd55f, LSL #48
    FMOV  X19, D25
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xda9d, LSL #0
    MOVK  X12, #0x7440, LSL #16
    MOVK  X12, #0xa95, LSL #32
    MOVK  X12, #0x8f48, LSL #48
    FMOV  X19, V26.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xe0b7, LSL #0
    MOVK  X12, #0x4f0b, LSL #16
    MOVK  X12, #0x7ab9, LSL #32
    MOVK  X12, #0x2789, LSL #48
    FMOV  X19, D26
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x3122, LSL #0
    MOVK  X12, #0xb9a6, LSL #16
    MOVK  X12, #0x443d, LSL #32
    MOVK  X12, #0x3c3f, LSL #48
    FMOV  X19, V27.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xf743, LSL #0
    MOVK  X12, #0x497f, LSL #16
    MOVK  X12, #0x8163, LSL #32
    MOVK  X12, #0x3dc4, LSL #48
    FMOV  X19, D27
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x2102, LSL #0
    MOVK  X12, #0xf181, LSL #16
    MOVK  X12, #0xfd9, LSL #32
    MOVK  X12, #0x1a59, LSL #48
    FMOV  X19, V28.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x8dba, LSL #0
    MOVK  X12, #0x15fb, LSL #16
    MOVK  X12, #0x697b, LSL #32
    MOVK  X12, #0x9d04, LSL #48
    FMOV  X19, D28
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xd415, LSL #0
    MOVK  X12, #0x8dcc, LSL #16
    MOVK  X12, #0x68a, LSL #32
    MOVK  X12, #0x322, LSL #48
    FMOV  X19, V29.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xccfb, LSL #0
    MOVK  X12, #0xe2a5, LSL #16
    MOVK  X12, #0x1053, LSL #32
    MOVK  X12, #0x7786, LSL #48
    FMOV  X19, D29
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x330a, LSL #0
    MOVK  X12, #0x8137, LSL #16
    MOVK  X12, #0xaae1, LSL #32
    MOVK  X12, #0x7c98, LSL #48
    FMOV  X19, V30.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0xbf5c, LSL #0
    MOVK  X12, #0x5c0b, LSL #16
    MOVK  X12, #0x96b6, LSL #32
    MOVK  X12, #0xb8fa, LSL #48
    FMOV  X19, D30
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x3, LSL #0
    MOVK  X12, #0x7b76, LSL #16
    MOVK  X12, #0x7f8d, LSL #32
    MOVK  X12, #0x386d, LSL #48
    FMOV  X19, V31.D[1]
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X12, #0x9139, LSL #0
    MOVK  X12, #0x4026, LSL #16
    MOVK  X12, #0x6517, LSL #32
    MOVK  X12, #0xd182, LSL #48
    FMOV  X19, D31
    SUB  X16, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X29
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X12
    FMOV  D2, X2
    FMOV  V2.D[1], X13
    FMOV  D3, X19
    FMOV  V3.D[1], X17
    FMOV  D4, X16
    FMOV  V4.D[1], X25
    FMOV  D5, X21
    FMOV  V5.D[1], X11
    FMOV  D6, X24
    FMOV  V6.D[1], X22
    FMOV  D7, X6
    FMOV  V7.D[1], X18
    FMOV  D8, X6
    FMOV  V8.D[1], X28
    FMOV  D9, X15
    FMOV  V9.D[1], X6
    FMOV  D10, X22
    FMOV  V10.D[1], X3
    FMOV  D11, X29
    FMOV  V11.D[1], X16
    FMOV  D12, X24
    FMOV  V12.D[1], X27
    FMOV  D13, X10
    FMOV  V13.D[1], X12
    FMOV  D14, X20
    FMOV  V14.D[1], X16
    FMOV  D15, X12
    FMOV  V15.D[1], X3
    FMOV  D16, X20
    FMOV  V16.D[1], X11
    FMOV  D17, X18
    FMOV  V17.D[1], X24
    FMOV  D18, X19
    FMOV  V18.D[1], X29
    FMOV  D19, X3
    FMOV  V19.D[1], X10
    FMOV  D20, X29
    FMOV  V20.D[1], X17
    FMOV  D21, X8
    FMOV  V21.D[1], X2
    FMOV  D22, X17
    FMOV  V22.D[1], X14
    FMOV  D23, X25
    FMOV  V23.D[1], X17
    FMOV  D24, X14
    FMOV  V24.D[1], X16
    FMOV  D25, X25
    FMOV  V25.D[1], X8
    FMOV  D26, X8
    FMOV  V26.D[1], X16
    FMOV  D27, X28
    FMOV  V27.D[1], X15
    FMOV  D28, X11
    FMOV  V28.D[1], X27
    FMOV  D29, X17
    FMOV  V29.D[1], X24
    FMOV  D30, X16
    FMOV  V30.D[1], X28
    FMOV  D31, X16
    FMOV  V31.D[1], X12
    MOVZ  X11, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_13:
    SHA256SU0  V19.4S, V25.4S
    SHA1P  Q22, S24, V26.4S
    SHA1SU1  V12.4S, V23.4S
    SHA1P  Q28, S28, V29.4S
    SHA256H2  Q0, Q28, V31.4S
    SHA1P  Q16, S21, V19.4S
    SHA1C  Q14, S22, V16.4S
    SHA1SU1  V13.4S, V0.4S
    SHA1P  Q30, S20, V30.4S
    SHA1SU0  V20.4S, V30.4S, V27.4S
    SHA1SU0  V18.4S, V12.4S, V12.4S
    SHA1SU0  V27.4S, V18.4S, V20.4S
    SHA1SU0  V21.4S, V14.4S, V27.4S
    SHA1SU0  V20.4S, V13.4S, V13.4S
    SHA1C  Q0, S20, V21.4S
    SHA256H  Q16, Q16, V19.4S
    SHA256H2  Q19, Q22, V18.4S
    SHA256H2  Q13, Q16, V1.4S
    SHA256H2  Q16, Q28, V21.4S
    SHA1M  Q25, S1, V1.4S
    SHA256H2  Q30, Q30, V28.4S
    SHA1C  Q18, S14, V25.4S
    SHA256SU0  V27.4S, V20.4S
    SHA1C  Q28, S5, V17.4S
    SHA256SU0  V12.4S, V0.4S
    SHA1C  Q1, S9, V25.4S
    SHA256SU1  V22.4S, V1.4S, V13.4S
    SHA1SU1  V1.4S, V28.4S
    SHA256SU1  V25.4S, V1.4S, V1.4S
    SHA1M  Q14, S19, V25.4S
    SHA256H2  Q28, Q12, V18.4S
    SHA256H2  Q12, Q22, V22.4S
    SHA1C  Q20, S28, V14.4S
    SHA1SU0  V25.4S, V27.4S, V20.4S
    SHA256H  Q19, Q16, V12.4S
    SHA1P  Q12, S19, V30.4S
    SHA256H2  Q18, Q25, V25.4S
    SHA1SU1  V25.4S, V18.4S
    SHA1SU0  V9.4S, V12.4S, V15.4S
    SHA1M  Q20, S25, V25.4S
    SHA1SU1  V13.4S, V20.4S
    SHA1M  Q17, S9, V13.4S
    SHA256H  Q18, Q9, V26.4S
    SHA256SU1  V19.4S, V31.4S, V24.4S
    SHA1C  Q25, S20, V21.4S
    SHA1C  Q24, S21, V23.4S
    SHA256SU1  V13.4S, V7.4S, V20.4S
    SHA256H  Q1, Q14, V28.4S
    SHA256H  Q23, Q14, V4.4S
    SHA1SU1  V4.4S, V14.4S
    SHA256SU1  V21.4S, V17.4S, V4.4S
    SHA256SU0  V20.4S, V23.4S
    SHA256SU0  V31.4S, V24.4S
    SHA1SU1  V15.4S, V1.4S
    SHA1C  Q7, S18, V18.4S
    SHA256H2  Q24, Q20, V13.4S
    SHA256SU1  V28.4S, V25.4S, V15.4S
    SHA256SU0  V15.4S, V28.4S
    SHA1SU1  V14.4S, V7.4S
    SHA256H2  Q16, Q19, V19.4S
    SHA256SU0  V13.4S, V21.4S
    SHA256SU1  V21.4S, V13.4S, V24.4S
    SHA256SU1  V30.4S, V21.4S, V31.4S
    SHA1M  Q17, S30, V30.4S
    SHA256SU0  V25.4S, V15.4S
    SHA1C  Q30, S25, V14.4S
    SHA1SU1  V9.4S, V30.4S
    SHA1P  Q30, S17, V9.4S
    SHA256H2  Q1, Q30, V30.4S
    SHA1P  Q18, S1, V16.4S
    SHA256SU1  V16.4S, V4.4S, V28.4S
    SHA1SU0  V7.4S, V2.4S, V8.4S
    SHA1P  Q20, S18, V10.4S
    SHA1SU0  V15.4S, V26.4S, V29.4S
    SHA1SU1  V28.4S, V9.4S
    SHA1SU0  V8.4S, V0.4S, V31.4S
    SHA1P  Q1, S14, V5.4S
    SHA256SU0  V30.4S, V5.4S
    SHA1P  Q5, S29, V7.4S
    SHA1M  Q7, S30, V5.4S
    SHA256H  Q19, Q30, V11.4S
    SHA256H2  Q25, Q27, V20.4S
    SHA256H  Q24, Q24, V9.4S
    SHA1SU0  V4.4S, V16.4S, V24.4S
    SHA256H2  Q17, Q25, V1.4S
    SHA1SU1  V2.4S, V19.4S
    SHA1M  Q16, S7, V4.4S
    SHA256SU1  V7.4S, V8.4S, V12.4S
    SHA256SU1  V26.4S, V2.4S, V28.4S
    SHA256H  Q13, Q23, V26.4S
    SHA1SU0  V29.4S, V15.4S, V17.4S
    SHA1M  Q21, S29, V16.4S
    SHA1P  Q14, S13, V21.4S
    SHA1SU0  V8.4S, V7.4S, V14.4S
    SHA256SU0  V26.4S, V5.4S
    SHA1P  Q21, S11, V12.4S
    SHA256H  Q23, Q26, V31.4S
    SHA1P  Q25, S23, V18.4S
    SHA256H2  Q1, Q25, V14.4S
    SHA1SU0  V10.4S, V25.4S, V20.4S
    SHA1SU0  V14.4S, V26.4S, V26.4S
    SHA1SU0  V9.4S, V16.4S, V17.4S
    SHA1C  Q23, S4, V20.4S
    SHA1P  Q30, S5, V29.4S
    SHA1SU0  V19.4S, V24.4S, V16.4S
    SHA1C  Q2, S21, V10.4S
    SHA1M  Q21, S1, V8.4S
    SHA256H2  Q5, Q9, V16.4S
    SHA256H  Q29, Q5, V15.4S
    SHA1SU1  V27.4S, V2.4S
    SHA256H  Q25, Q23, V27.4S
    SHA256SU0  V11.4S, V14.4S
    SHA256SU0  V28.4S, V11.4S
    SHA1C  Q24, S25, V30.4S
    SHA256SU1  V11.4S, V21.4S, V28.4S
    SHA1SU0  V7.4S, V24.4S, V29.4S
    SHA1SU1  V12.4S, V7.4S
    SHA256H  Q26, Q19, V19.4S
    SHA256H2  Q25, Q11, V26.4S
    SHA1M  Q7, S25, V12.4S
    SHA256H  Q30, Q16, V8.4S
    SHA1SU0  V9.4S, V21.4S, V5.4S
    SHA256SU0  V5.4S, V17.4S
    SHA1P  Q31, S31, V22.4S
    SHA256H  Q8, Q12, V21.4S
    SHA1C  Q12, S9, V4.4S
    SHA1SU0  V11.4S, V5.4S, V23.4S
    SHA256SU0  V16.4S, V2.4S
    SHA1M  Q14, S14, V20.4S
    SHA1SU0  V25.4S, V24.4S, V8.4S
    SHA256H2  Q21, Q15, V12.4S
    SHA1P  Q1, S16, V14.4S
    SHA1M  Q26, S28, V0.4S
    SHA256SU0  V5.4S, V11.4S
    SHA256SU0  V4.4S, V11.4S
    SHA1P  Q17, S21, V4.4S
    SHA1P  Q16, S5, V26.4S
    SHA256SU0  V29.4S, V25.4S
    SHA1P  Q23, S30, V7.4S
    SHA256SU1  V22.4S, V29.4S, V17.4S
    SHA256H  Q28, Q31, V16.4S
    SHA1M  Q9, S1, V22.4S
    SHA256H2  Q2, Q23, V28.4S
    SHA256SU0  V11.4S, V2.4S
    SHA256SU1  V30.4S, V11.4S, V9.4S
    SHA1P  Q20, S21, V12.4S
    SHA256SU0  V8.4S, V24.4S
    SHA256SU1  V21.4S, V21.4S, V14.4S
    SHA1P  Q28, S11, V21.4S
    SHA256H  Q9, Q3, V20.4S
    SHA1SU0  V0.4S, V30.4S, V21.4S
    SHA1SU0  V20.4S, V7.4S, V14.4S
    SHA256H2  Q7, Q28, V28.4S
    SHA256SU0  V2.4S, V28.4S
    SHA1M  Q14, S28, V30.4S
    SHA1C  Q15, S17, V10.4S
    SHA1SU1  V4.4S, V5.4S
    SHA256H  Q24, Q4, V8.4S
    SHA1M  Q12, S9, V9.4S
    SHA256SU1  V8.4S, V11.4S, V24.4S
    SHA256SU0  V17.4S, V8.4S
    SHA256H  Q21, Q12, V0.4S
    SHA256SU0  V28.4S, V21.4S
    SHA1SU1  V24.4S, V7.4S
    SHA256SU1  V21.4S, V2.4S, V24.4S
    SHA1SU1  V2.4S, V21.4S
    SHA1C  Q9, S2, V20.4S
    SHA1C  Q11, S14, V28.4S
    SHA256SU0  V24.4S, V9.4S
    SHA1C  Q8, S24, V15.4S
    SHA1C  Q7, S17, V17.4S
    SHA1C  Q30, S7, V7.4S
    SHA256SU1  V4.4S, V11.4S, V11.4S
    SHA1C  Q5, S8, V8.4S
    SHA256SU1  V9.4S, V5.4S, V5.4S
    SHA1M  Q5, S4, V9.4S
    SHA1SU1  V11.4S, V5.4S
    SHA256SU1  V9.4S, V30.4S, V30.4S
    SHA1P  Q5, S9, V9.4S
    SHA256SU0  V24.4S, V11.4S
    SHA256H  Q10, Q5, V24.4S
    SHA1P  Q25, S31, V28.4S
    SHA1M  Q8, S3, V15.4S
    SHA256H2  Q0, Q21, V3.4S
    SHA256SU0  V14.4S, V15.4S
    SHA1SU0  V17.4S, V4.4S, V27.4S
    SHA1C  Q30, S22, V0.4S
    SHA1SU0  V7.4S, V18.4S, V5.4S
    SHA1P  Q2, S16, V19.4S
    SHA256H  Q16, Q10, V2.4S
    SHA256SU0  V2.4S, V10.4S
    SHA256H2  Q19, Q22, V23.4S
    SHA1SU1  V11.4S, V14.4S
    SHA256SU0  V4.4S, V25.4S
    SHA256SU1  V31.4S, V4.4S, V8.4S
    SHA256H  Q8, Q17, V7.4S
    SHA1SU1  V17.4S, V8.4S
    SHA1P  Q23, S17, V17.4S
    SHA256SU0  V25.4S, V23.4S
    SHA1C  Q9, S16, V30.4S
    SUBS  X11, X11, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_13
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    SUB  X25, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    MRS  X25, FPSR
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D0
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D1
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D2
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D3
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D4
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D5
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D6
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D7
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D8
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D9
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D10
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D11
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D12
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D13
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D14
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D15
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D16
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D17
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V18.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D18
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V19.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D19
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D20
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D21
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D22
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D23
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V24.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D24
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D25
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D26
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D27
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D28
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D29
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D30
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X25, D31
    SUB  X16, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X22
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X24
    FMOV  D3, X20
    FMOV  V3.D[1], X20
    FMOV  D4, X6
    FMOV  V4.D[1], X29
    FMOV  D5, X21
    FMOV  V5.D[1], X19
    FMOV  D6, X20
    FMOV  V6.D[1], X9
    FMOV  D7, X20
    FMOV  V7.D[1], X15
    FMOV  D8, X18
    FMOV  V8.D[1], X17
    FMOV  D9, X17
    FMOV  V9.D[1], X14
    FMOV  D10, X11
    FMOV  V10.D[1], X8
    FMOV  D11, X3
    FMOV  V11.D[1], X8
    FMOV  D12, X22
    FMOV  V12.D[1], X3
    FMOV  D13, X20
    FMOV  V13.D[1], X2
    FMOV  D14, X22
    FMOV  V14.D[1], X29
    FMOV  D15, X12
    FMOV  V15.D[1], X28
    FMOV  D16, X24
    FMOV  V16.D[1], X29
    FMOV  D17, X24
    FMOV  V17.D[1], X25
    FMOV  D18, X29
    FMOV  V18.D[1], X27
    FMOV  D19, X15
    FMOV  V19.D[1], X20
    FMOV  D20, X17
    FMOV  V20.D[1], X27
    FMOV  D21, X27
    FMOV  V21.D[1], X10
    FMOV  D22, X10
    FMOV  V22.D[1], X21
    FMOV  D23, X16
    FMOV  V23.D[1], X28
    FMOV  D24, X14
    FMOV  V24.D[1], X11
    FMOV  D25, X19
    FMOV  V25.D[1], X10
    FMOV  D26, X29
    FMOV  V26.D[1], X27
    FMOV  D27, X12
    FMOV  V27.D[1], X6
    FMOV  D28, X6
    FMOV  V28.D[1], X25
    FMOV  D29, X21
    FMOV  V29.D[1], X21
    FMOV  D30, X2
    FMOV  V30.D[1], X9
    FMOV  D31, X25
    FMOV  V31.D[1], X13
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_14:
    SHA256H  Q27, Q27, V28.4S
    SHA256SU0  V21.4S, V23.4S
    SHA256H2  Q5, Q25, V22.4S
    SHA1SU0  V16.4S, V5.4S, V5.4S
    SHA1SU0  V30.4S, V16.4S, V31.4S
    SHA256SU1  V17.4S, V29.4S, V30.4S
    SHA256SU1  V4.4S, V21.4S, V26.4S
    SHA256H  Q21, Q27, V24.4S
    SHA1SU1  V27.4S, V17.4S
    SHA1SU1  V20.4S, V27.4S
    SHA256SU0  V0.4S, V20.4S
    SHA256H  Q11, Q0, V21.4S
    SHA256SU0  V25.4S, V11.4S
    SHA1SU1  V16.4S, V4.4S
    SHA1SU0  V28.4S, V16.4S, V16.4S
    SHA256H2  Q21, Q25, V28.4S
    SHA1P  Q15, S3, V26.4S
    SHA256SU0  V31.4S, V29.4S
    SHA1P  Q28, S27, V30.4S
    SHA256SU0  V27.4S, V9.4S
    SHA256H  Q3, Q18, V23.4S
    SHA1SU1  V4.4S, V31.4S
    SHA1M  Q17, S20, V5.4S
    SHA256H2  Q30, Q7, V9.4S
    SHA1C  Q22, S25, V2.4S
    SHA256H2  Q31, Q3, V21.4S
    SHA1M  Q2, S15, V31.4S
    SHA256SU0  V21.4S, V28.4S
    SHA1M  Q25, S27, V2.4S
    SHA256SU0  V3.4S, V4.4S
    SHA256SU1  V0.4S, V3.4S, V25.4S
    SHA1M  Q26, S17, V22.4S
    SHA256H2  Q15, Q30, V0.4S
    SHA1C  Q22, S21, V21.4S
    SHA256SU1  V29.4S, V15.4S, V22.4S
    SHA256H  Q15, Q18, V29.4S
    SHA1M  Q18, S8, V21.4S
    SHA256H2  Q0, Q23, V15.4S
    SHA256SU1  V15.4S, V18.4S, V0.4S
    SHA1C  Q21, S26, V24.4S
    SHA1P  Q8, S30, V21.4S
    SHA256H2  Q23, Q8, V8.4S
    SHA256SU1  V22.4S, V23.4S, V23.4S
    SHA256SU1  V3.4S, V15.4S, V15.4S
    SHA1P  Q18, S3, V3.4S
    SHA256SU1  V27.4S, V22.4S, V18.4S
    SHA1SU1  V2.4S, V9.4S
    SHA1C  Q25, S7, V6.4S
    SHA256SU0  V29.4S, V27.4S
    SHA256SU0  V28.4S, V18.4S
    SHA1C  Q3, S4, V29.4S
    SHA1SU0  V5.4S, V27.4S, V11.4S
    SHA256SU0  V17.4S, V13.4S
    SHA1SU0  V7.4S, V22.4S, V0.4S
    SHA1SU0  V9.4S, V14.4S, V6.4S
    SHA1SU0  V11.4S, V15.4S, V1.4S
    SHA1SU0  V26.4S, V2.4S, V9.4S
    SHA1SU1  V29.4S, V11.4S
    SHA256SU1  V24.4S, V3.4S, V26.4S
    SHA256H  Q15, Q28, V25.4S
    SHA1SU0  V6.4S, V29.4S, V15.4S
    SHA1M  Q18, S24, V28.4S
    SHA1P  Q4, S17, V5.4S
    SHA1M  Q27, S5, V6.4S
    SHA256H2  Q6, Q7, V18.4S
    SHA1SU0  V13.4S, V4.4S, V27.4S
    SHA1C  Q0, S6, V6.4S
    SHA256SU0  V6.4S, V12.4S
    SHA256SU0  V25.4S, V6.4S
    SHA1P  Q23, S21, V13.4S
    SHA1SU1  V1.4S, V0.4S
    SHA256H  Q17, Q23, V1.4S
    SHA256SU0  V22.4S, V17.4S
    SHA1SU1  V14.4S, V22.4S
    SHA1SU1  V11.4S, V25.4S
    SHA1P  Q22, S14, V14.4S
    SHA1M  Q24, S22, V11.4S
    SHA256SU1  V18.4S, V29.4S, V6.4S
    SHA256H2  Q17, Q27, V14.4S
    SHA256SU0  V6.4S, V1.4S
    SHA1P  Q13, S1, V17.4S
    SHA1SU1  V2.4S, V2.4S
    SHA1M  Q5, S15, V10.4S
    SHA1SU1  V0.4S, V14.4S
    SHA256SU0  V12.4S, V12.4S
    SHA256H2  Q22, Q26, V2.4S
    SHA1P  Q10, S26, V9.4S
    SHA1M  Q27, S12, V13.4S
    SHA1SU1  V26.4S, V24.4S
    SHA1SU0  V7.4S, V6.4S, V18.4S
    SHA256SU1  V15.4S, V0.4S, V27.4S
    SHA1C  Q6, S10, V10.4S
    SHA1SU1  V18.4S, V22.4S
    SHA256SU1  V25.4S, V18.4S, V6.4S
    SHA1SU1  V13.4S, V5.4S
    SHA256SU1  V5.4S, V15.4S, V26.4S
    SHA256SU0  V0.4S, V7.4S
    SHA1SU0  V15.4S, V0.4S, V0.4S
    SHA1C  Q18, S13, V11.4S
    SHA1M  Q0, S25, V5.4S
    SHA1M  Q29, S0, V18.4S
    SHA1C  Q26, S15, V15.4S
    SHA1M  Q15, S9, V26.4S
    SHA256SU0  V11.4S, V29.4S
    SHA256H  Q10, Q15, V11.4S
    SHA1SU0  V22.4S, V29.4S, V5.4S
    SHA1SU0  V5.4S, V29.4S, V13.4S
    SHA256H  Q13, Q27, V30.4S
    SHA256H2  Q7, Q17, V9.4S
    SHA256H2  Q25, Q31, V0.4S
    SHA1SU0  V29.4S, V10.4S, V6.4S
    SHA1SU0  V10.4S, V31.4S, V25.4S
    SHA256SU0  V31.4S, V20.4S
    SHA256H2  Q30, Q20, V5.4S
    SHA256H2  Q24, Q2, V26.4S
    SHA256H2  Q17, Q18, V31.4S
    SHA1C  Q0, S6, V26.4S
    SHA256SU0  V9.4S, V22.4S
    SHA1SU0  V27.4S, V4.4S, V13.4S
    SHA1SU0  V11.4S, V29.4S, V24.4S
    SHA1SU0  V15.4S, V11.4S, V30.4S
    SHA256SU0  V31.4S, V27.4S
    SHA256SU0  V27.4S, V7.4S
    SHA1P  Q25, S31, V9.4S
    SHA1SU0  V11.4S, V25.4S, V10.4S
    SHA1C  Q31, S16, V0.4S
    SHA256H2  Q26, Q31, V27.4S
    SHA1P  Q25, S26, V15.4S
    SHA1SU0  V15.4S, V17.4S, V17.4S
    SHA256SU1  V2.4S, V9.4S, V25.4S
    SHA1M  Q9, S15, V11.4S
    SHA256SU0  V22.4S, V2.4S
    SHA256SU1  V6.4S, V9.4S, V9.4S
    SHA1P  Q24, S22, V22.4S
    SHA1SU1  V13.4S, V24.4S
    SHA1C  Q9, S13, V13.4S
    SHA1M  Q13, S6, V6.4S
    SHA256H  Q4, Q28, V9.4S
    SHA1C  Q29, S13, V4.4S
    SHA1SU0  V28.4S, V10.4S, V30.4S
    SHA256SU1  V2.4S, V24.4S, V29.4S
    SHA256SU0  V25.4S, V27.4S
    SHA1P  Q29, S22, V5.4S
    SHA256H  Q13, Q1, V0.4S
    SHA256SU1  V26.4S, V4.4S, V0.4S
    SHA1SU0  V27.4S, V17.4S, V24.4S
    SHA256SU1  V4.4S, V19.4S, V24.4S
    SHA256H  Q0, Q16, V15.4S
    SHA1SU0  V19.4S, V4.4S, V0.4S
    SHA256SU0  V10.4S, V13.4S
    SHA256H2  Q13, Q29, V29.4S
    SHA256H  Q31, Q28, V14.4S
    SHA1M  Q17, S10, V26.4S
    SHA256H2  Q14, Q17, V5.4S
    SHA1P  Q6, S2, V27.4S
    SHA1SU0  V5.4S, V25.4S, V6.4S
    SHA1M  Q6, S19, V13.4S
    SHA1SU0  V15.4S, V6.4S, V5.4S
    SHA1SU1  V9.4S, V15.4S
    SHA256H  Q16, Q29, V9.4S
    SHA1M  Q13, S31, V31.4S
    SHA1SU0  V22.4S, V13.4S, V14.4S
    SHA1M  Q24, S22, V22.4S
    SHA256H2  Q19, Q24, V24.4S
    SHA1C  Q28, S19, V19.4S
    SHA1SU1  V27.4S, V16.4S
    SHA256SU1  V22.4S, V27.4S, V27.4S
    SHA1SU0  V0.4S, V22.4S, V28.4S
    SHA256H2  Q15, Q16, V13.4S
    SHA256H  Q4, Q22, V2.4S
    SHA1SU0  V25.4S, V1.4S, V4.4S
    SHA256SU1  V22.4S, V31.4S, V15.4S
    SHA256SU0  V29.4S, V31.4S
    SHA1SU0  V17.4S, V27.4S, V17.4S
    SHA256SU0  V26.4S, V0.4S
    SHA256SU1  V6.4S, V25.4S, V31.4S
    SHA256H  Q4, Q22, V27.4S
    SHA1SU1  V24.4S, V0.4S
    SHA256SU1  V19.4S, V31.4S, V18.4S
    SHA256H2  Q25, Q6, V12.4S
    SHA256SU1  V5.4S, V18.4S, V2.4S
    SHA1M  Q16, S25, V21.4S
    SHA1SU0  V13.4S, V21.4S, V18.4S
    SHA256H2  Q15, Q29, V29.4S
    SHA256H2  Q27, Q13, V26.4S
    SHA256H2  Q26, Q27, V31.4S
    SHA256H2  Q0, Q16, V4.4S
    SHA1C  Q1, S26, V24.4S
    SHA1C  Q16, S5, V5.4S
    SHA1C  Q25, S19, V0.4S
    SHA1SU1  V22.4S, V17.4S
    SHA1SU1  V21.4S, V16.4S
    SHA1M  Q6, S22, V21.4S
    SHA1SU1  V28.4S, V15.4S
    SHA1C  Q17, S28, V28.4S
    SHA1SU0  V18.4S, V17.4S, V17.4S
    SHA1M  Q27, S25, V18.4S
    SHA256SU0  V29.4S, V6.4S
    SHA1SU1  V12.4S, V1.4S
    SHA1SU0  V21.4S, V27.4S, V12.4S
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_14
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x0, LSL #0
    SUB  X28, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xffff, LSL #0
    MOVK  X8, #0xffff, LSL #16
    MOVK  X8, #0xffff, LSL #32
    MOVK  X8, #0xffff, LSL #48
    SUB  X28, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xe8ba, LSL #0
    MOVK  X8, #0x5e1f, LSL #16
    MOVK  X8, #0x6228, LSL #32
    MOVK  X8, #0x7a13, LSL #48
    FMOV  X28, V0.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xd98, LSL #0
    MOVK  X8, #0xa121, LSL #16
    MOVK  X8, #0x872b, LSL #32
    MOVK  X8, #0xbfb, LSL #48
    FMOV  X28, D0
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x97e8, LSL #0
    MOVK  X8, #0xe407, LSL #16
    MOVK  X8, #0x5883, LSL #32
    MOVK  X8, #0x7e82, LSL #48
    FMOV  X28, V1.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xae47, LSL #0
    MOVK  X8, #0x54c5, LSL #16
    MOVK  X8, #0xd859, LSL #32
    MOVK  X8, #0x36f7, LSL #48
    FMOV  X28, D1
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x3e93, LSL #0
    MOVK  X8, #0x8f47, LSL #16
    MOVK  X8, #0xd601, LSL #32
    MOVK  X8, #0x4e8e, LSL #48
    FMOV  X28, V2.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xf834, LSL #0
    MOVK  X8, #0x4344, LSL #16
    MOVK  X8, #0x9a5b, LSL #32
    MOVK  X8, #0x756b, LSL #48
    FMOV  X28, D2
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x16d5, LSL #0
    MOVK  X8, #0x692b, LSL #16
    MOVK  X8, #0x3d0d, LSL #32
    MOVK  X8, #0xdf3f, LSL #48
    FMOV  X28, V3.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xe2e6, LSL #0
    MOVK  X8, #0x694f, LSL #16
    MOVK  X8, #0xb864, LSL #32
    MOVK  X8, #0x38d0, LSL #48
    FMOV  X28, D3
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xe7d1, LSL #0
    MOVK  X8, #0x3f99, LSL #16
    MOVK  X8, #0x49f3, LSL #32
    MOVK  X8, #0x9333, LSL #48
    FMOV  X28, V4.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x3ec6, LSL #0
    MOVK  X8, #0xa16e, LSL #16
    MOVK  X8, #0x98a5, LSL #32
    MOVK  X8, #0x1b8f, LSL #48
    FMOV  X28, D4
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x308d, LSL #0
    MOVK  X8, #0x2a8a, LSL #16
    MOVK  X8, #0x5154, LSL #32
    MOVK  X8, #0x9828, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x1ba7, LSL #0
    MOVK  X8, #0xc320, LSL #16
    MOVK  X8, #0x33be, LSL #32
    MOVK  X8, #0x833b, LSL #48
    FMOV  X28, D5
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xd1cc, LSL #0
    MOVK  X8, #0xb768, LSL #16
    MOVK  X8, #0xa8bc, LSL #32
    MOVK  X8, #0xc94, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xb85a, LSL #0
    MOVK  X8, #0x7fe1, LSL #16
    MOVK  X8, #0x2bd7, LSL #32
    MOVK  X8, #0xd9b2, LSL #48
    FMOV  X28, D6
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xb6f6, LSL #0
    MOVK  X8, #0xe26a, LSL #16
    MOVK  X8, #0xc548, LSL #32
    MOVK  X8, #0x17fd, LSL #48
    FMOV  X28, V7.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xc931, LSL #0
    MOVK  X8, #0x4e2a, LSL #16
    MOVK  X8, #0x40b0, LSL #32
    MOVK  X8, #0xd16b, LSL #48
    FMOV  X28, D7
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x7065, LSL #0
    MOVK  X8, #0xfa69, LSL #16
    MOVK  X8, #0xee1a, LSL #32
    MOVK  X8, #0x1aab, LSL #48
    FMOV  X28, V8.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xae3f, LSL #0
    MOVK  X8, #0xcd4b, LSL #16
    MOVK  X8, #0xb42, LSL #32
    MOVK  X8, #0xd983, LSL #48
    FMOV  X28, D8
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x75ef, LSL #0
    MOVK  X8, #0x7a54, LSL #16
    MOVK  X8, #0xf7e7, LSL #32
    MOVK  X8, #0x4a55, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x2a88, LSL #0
    MOVK  X8, #0x7a39, LSL #16
    MOVK  X8, #0x1903, LSL #32
    MOVK  X8, #0x94fb, LSL #48
    FMOV  X28, D9
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x6300, LSL #0
    MOVK  X8, #0x7483, LSL #16
    MOVK  X8, #0x323e, LSL #32
    MOVK  X8, #0x402d, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x7549, LSL #0
    MOVK  X8, #0x5e31, LSL #16
    MOVK  X8, #0x366d, LSL #32
    MOVK  X8, #0x42b4, LSL #48
    FMOV  X28, D10
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x51ee, LSL #0
    MOVK  X8, #0x513e, LSL #16
    MOVK  X8, #0x547, LSL #32
    MOVK  X8, #0xddc5, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xfca5, LSL #0
    MOVK  X8, #0xdadf, LSL #16
    MOVK  X8, #0x416e, LSL #32
    MOVK  X8, #0x824b, LSL #48
    FMOV  X28, D11
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xc5c, LSL #0
    MOVK  X8, #0x7699, LSL #16
    MOVK  X8, #0x7d8d, LSL #32
    MOVK  X8, #0x38e, LSL #48
    FMOV  X28, V12.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xb1ab, LSL #0
    MOVK  X8, #0xb3a2, LSL #16
    MOVK  X8, #0x79af, LSL #32
    MOVK  X8, #0xfe05, LSL #48
    FMOV  X28, D12
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x8140, LSL #0
    MOVK  X8, #0x4cee, LSL #16
    MOVK  X8, #0xdb88, LSL #32
    MOVK  X8, #0xbcec, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x6, LSL #0
    MOVK  X8, #0xbba1, LSL #16
    MOVK  X8, #0xa9d3, LSL #32
    MOVK  X8, #0x2913, LSL #48
    FMOV  X28, D13
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x9d1e, LSL #0
    MOVK  X8, #0x6b91, LSL #16
    MOVK  X8, #0x8d19, LSL #32
    MOVK  X8, #0x3ef, LSL #48
    FMOV  X28, V14.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x1595, LSL #0
    MOVK  X8, #0x8d85, LSL #16
    MOVK  X8, #0xd241, LSL #32
    MOVK  X8, #0x5949, LSL #48
    FMOV  X28, D14
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x7e87, LSL #0
    MOVK  X8, #0xea95, LSL #16
    MOVK  X8, #0x4833, LSL #32
    MOVK  X8, #0x40c7, LSL #48
    FMOV  X28, V15.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xb92b, LSL #0
    MOVK  X8, #0x20d0, LSL #16
    MOVK  X8, #0xf8b0, LSL #32
    MOVK  X8, #0xa2c7, LSL #48
    FMOV  X28, D15
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x823a, LSL #0
    MOVK  X8, #0xb1c6, LSL #16
    MOVK  X8, #0x68e4, LSL #32
    MOVK  X8, #0x1aa7, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xc4f7, LSL #0
    MOVK  X8, #0xd953, LSL #16
    MOVK  X8, #0x9302, LSL #32
    MOVK  X8, #0x6e24, LSL #48
    FMOV  X28, D16
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x32d4, LSL #0
    MOVK  X8, #0x834c, LSL #16
    MOVK  X8, #0xe13a, LSL #32
    MOVK  X8, #0xbd7c, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xbbf5, LSL #0
    MOVK  X8, #0x6e31, LSL #16
    MOVK  X8, #0x2cac, LSL #32
    MOVK  X8, #0xa44c, LSL #48
    FMOV  X28, D17
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xb2ec, LSL #0
    MOVK  X8, #0x17f3, LSL #16
    MOVK  X8, #0x7db1, LSL #32
    MOVK  X8, #0x3589, LSL #48
    FMOV  X28, V18.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xcef1, LSL #0
    MOVK  X8, #0xf7e8, LSL #16
    MOVK  X8, #0xfcd6, LSL #32
    MOVK  X8, #0xcd07, LSL #48
    FMOV  X28, D18
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xa551, LSL #0
    MOVK  X8, #0xc445, LSL #16
    MOVK  X8, #0x926, LSL #32
    MOVK  X8, #0x3e48, LSL #48
    FMOV  X28, V19.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x1fd7, LSL #0
    MOVK  X8, #0xa3c3, LSL #16
    MOVK  X8, #0x86b9, LSL #32
    MOVK  X8, #0x8da2, LSL #48
    FMOV  X28, D19
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x78fd, LSL #0
    MOVK  X8, #0xc7b8, LSL #16
    MOVK  X8, #0xa96a, LSL #32
    MOVK  X8, #0x250b, LSL #48
    FMOV  X28, V20.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xabba, LSL #0
    MOVK  X8, #0x310f, LSL #16
    MOVK  X8, #0xa64f, LSL #32
    MOVK  X8, #0x374b, LSL #48
    FMOV  X28, D20
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x85b0, LSL #0
    MOVK  X8, #0x42fa, LSL #16
    MOVK  X8, #0x132c, LSL #32
    MOVK  X8, #0xfb99, LSL #48
    FMOV  X28, V21.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x23b, LSL #0
    MOVK  X8, #0x33e7, LSL #16
    MOVK  X8, #0x45f8, LSL #32
    MOVK  X8, #0xe944, LSL #48
    FMOV  X28, D21
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x1544, LSL #0
    MOVK  X8, #0xd716, LSL #16
    MOVK  X8, #0x4701, LSL #32
    MOVK  X8, #0xb529, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xf71, LSL #0
    MOVK  X8, #0xd44a, LSL #16
    MOVK  X8, #0x9389, LSL #32
    MOVK  X8, #0x2e88, LSL #48
    FMOV  X28, D22
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xf0d4, LSL #0
    MOVK  X8, #0xf913, LSL #16
    MOVK  X8, #0x8769, LSL #32
    MOVK  X8, #0x37c3, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x5cb3, LSL #0
    MOVK  X8, #0x5886, LSL #16
    MOVK  X8, #0x5e94, LSL #32
    MOVK  X8, #0xd234, LSL #48
    FMOV  X28, D23
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xf3d7, LSL #0
    MOVK  X8, #0xab0e, LSL #16
    MOVK  X8, #0x278c, LSL #32
    MOVK  X8, #0xa3ec, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x50fc, LSL #0
    MOVK  X8, #0xd878, LSL #16
    MOVK  X8, #0x7715, LSL #32
    MOVK  X8, #0xc1c4, LSL #48
    FMOV  X28, D24
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xe34f, LSL #0
    MOVK  X8, #0x8da2, LSL #16
    MOVK  X8, #0x99f6, LSL #32
    MOVK  X8, #0x18ee, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xb48, LSL #0
    MOVK  X8, #0xb92f, LSL #16
    MOVK  X8, #0x331c, LSL #32
    MOVK  X8, #0x3c21, LSL #48
    FMOV  X28, D25
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x752c, LSL #0
    MOVK  X8, #0x27d3, LSL #16
    MOVK  X8, #0xfd06, LSL #32
    MOVK  X8, #0x333e, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xa858, LSL #0
    MOVK  X8, #0xf6ba, LSL #16
    MOVK  X8, #0x5ff2, LSL #32
    MOVK  X8, #0x6ed7, LSL #48
    FMOV  X28, D26
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xf6a4, LSL #0
    MOVK  X8, #0x97c0, LSL #16
    MOVK  X8, #0xe393, LSL #32
    MOVK  X8, #0x8f0f, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x607b, LSL #0
    MOVK  X8, #0x3004, LSL #16
    MOVK  X8, #0xa468, LSL #32
    MOVK  X8, #0xdfb6, LSL #48
    FMOV  X28, D27
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x861e, LSL #0
    MOVK  X8, #0x95ed, LSL #16
    MOVK  X8, #0x2075, LSL #32
    MOVK  X8, #0x2a6e, LSL #48
    FMOV  X28, V28.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x2542, LSL #0
    MOVK  X8, #0x6ada, LSL #16
    MOVK  X8, #0x4348, LSL #32
    MOVK  X8, #0x88a8, LSL #48
    FMOV  X28, D28
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x153a, LSL #0
    MOVK  X8, #0x6038, LSL #16
    MOVK  X8, #0x365e, LSL #32
    MOVK  X8, #0x8594, LSL #48
    FMOV  X28, V29.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x30e5, LSL #0
    MOVK  X8, #0xfe37, LSL #16
    MOVK  X8, #0x5d16, LSL #32
    MOVK  X8, #0xe145, LSL #48
    FMOV  X28, D29
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x531b, LSL #0
    MOVK  X8, #0xe2e1, LSL #16
    MOVK  X8, #0x55f0, LSL #32
    MOVK  X8, #0xcc55, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x7e97, LSL #0
    MOVK  X8, #0xb6e9, LSL #16
    MOVK  X8, #0x17a6, LSL #32
    MOVK  X8, #0x4bd3, LSL #48
    FMOV  X28, D30
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0x9c5a, LSL #0
    MOVK  X8, #0x5d42, LSL #16
    MOVK  X8, #0x96c, LSL #32
    MOVK  X8, #0x8c37, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X8, #0xade, LSL #0
    MOVK  X8, #0xe59a, LSL #16
    MOVK  X8, #0x677c, LSL #32
    MOVK  X8, #0x5682, LSL #48
    FMOV  X28, D31
    SUB  X12, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0xa60d, LSL #0
    MOVK  X2, #0xaf13, LSL #16
    MOVK  X2, #0xae73, LSL #32
    MOVK  X2, #0x32c0, LSL #48
    MOVZ  X3, #0x2df, LSL #0
    MOVK  X3, #0x59bc, LSL #16
    MOVK  X3, #0xd8d1, LSL #32
    MOVK  X3, #0x8460, LSL #48
    MOVZ  X5, #0xb3ac, LSL #0
    MOVK  X5, #0x76cb, LSL #16
    MOVK  X5, #0x999, LSL #32
    MOVK  X5, #0x3c4f, LSL #48
    MOVZ  X6, #0x9946, LSL #0
    MOVK  X6, #0xb085, LSL #16
    MOVK  X6, #0xe99a, LSL #32
    MOVK  X6, #0xb0b5, LSL #48
    MOVZ  X8, #0xfe3e, LSL #0
    MOVK  X8, #0x24bc, LSL #16
    MOVK  X8, #0x5d3b, LSL #32
    MOVK  X8, #0xd915, LSL #48
    MOVZ  X9, #0xe79, LSL #0
    MOVK  X9, #0x66c4, LSL #16
    MOVK  X9, #0xba83, LSL #32
    MOVK  X9, #0x8911, LSL #48
    MOVZ  X10, #0x8159, LSL #0
    MOVK  X10, #0x523b, LSL #16
    MOVK  X10, #0xa75e, LSL #32
    MOVK  X10, #0xb1b3, LSL #48
    MOVZ  X11, #0xac93, LSL #0
    MOVK  X11, #0x8905, LSL #16
    MOVK  X11, #0x5814, LSL #32
    MOVK  X11, #0xe033, LSL #48
    MOVZ  X12, #0x1dc1, LSL #0
    MOVK  X12, #0xfd83, LSL #16
    MOVK  X12, #0x9f26, LSL #32
    MOVK  X12, #0x3764, LSL #48
    MOVZ  X13, #0x231f, LSL #0
    MOVK  X13, #0xb4ee, LSL #16
    MOVK  X13, #0x892, LSL #32
    MOVK  X13, #0xc9d, LSL #48
    MOVZ  X14, #0xa5fa, LSL #0
    MOVK  X14, #0x3204, LSL #16
    MOVK  X14, #0xbc33, LSL #32
    MOVK  X14, #0x4983, LSL #48
    MOVZ  X15, #0xe7db, LSL #0
    MOVK  X15, #0x4ea0, LSL #16
    MOVK  X15, #0x9237, LSL #32
    MOVK  X15, #0xff09, LSL #48
    MOVZ  X16, #0xa129, LSL #0
    MOVK  X16, #0xcb44, LSL #16
    MOVK  X16, #0xe026, LSL #32
    MOVK  X16, #0x74d0, LSL #48
    MOVZ  X17, #0x7e48, LSL #0
    MOVK  X17, #0x630, LSL #16
    MOVK  X17, #0x91ca, LSL #32
    MOVK  X17, #0x4a90, LSL #48
    MOVZ  X18, #0x3ee7, LSL #0
    MOVK  X18, #0xc31e, LSL #16
    MOVK  X18, #0x5d47, LSL #32
    MOVK  X18, #0xc8fd, LSL #48
    MOVZ  X19, #0xfb84, LSL #0
    MOVK  X19, #0x9263, LSL #16
    MOVK  X19, #0xe1c5, LSL #32
    MOVK  X19, #0x1c2c, LSL #48
    MOVZ  X20, #0xd90, LSL #0
    MOVK  X20, #0x432d, LSL #16
    MOVK  X20, #0x7a79, LSL #32
    MOVK  X20, #0xa144, LSL #48
    MOVZ  X21, #0x5c39, LSL #0
    MOVK  X21, #0x984d, LSL #16
    MOVK  X21, #0xb964, LSL #32
    MOVK  X21, #0x354d, LSL #48
    MOVZ  X22, #0xca15, LSL #0
    MOVK  X22, #0xaf89, LSL #16
    MOVK  X22, #0x9ccf, LSL #32
    MOVK  X22, #0x2bd5, LSL #48
    MOVZ  X24, #0x70bd, LSL #0
    MOVK  X24, #0x1465, LSL #16
    MOVK  X24, #0x5807, LSL #32
    MOVK  X24, #0xb5c9, LSL #48
    MOVZ  X25, #0xeb18, LSL #0
    MOVK  X25, #0x9bc9, LSL #16
    MOVK  X25, #0xe054, LSL #32
    MOVK  X25, #0x8baa, LSL #48
    MOVZ  X27, #0xf46c, LSL #0
    MOVK  X27, #0xbecd, LSL #16
    MOVK  X27, #0x3cae, LSL #32
    MOVK  X27, #0x4109, LSL #48
    MOVZ  X28, #0xd2c, LSL #0
    MOVK  X28, #0xef9e, LSL #16
    MOVK  X28, #0xa08c, LSL #32
    MOVK  X28, #0xbf2a, LSL #48
    MOVZ  X29, #0x1bf9, LSL #0
    MOVK  X29, #0xaf9b, LSL #16
    MOVK  X29, #0xb528, LSL #32
    MOVK  X29, #0x1946, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X10
    FMOV  V2.D[1], X22
    FMOV  D3, X24
    FMOV  V3.D[1], X11
    FMOV  D4, X28
    FMOV  V4.D[1], X14
    FMOV  D5, X28
    FMOV  V5.D[1], X17
    FMOV  D6, X5
    FMOV  V6.D[1], X28
    FMOV  D7, X3
    FMOV  V7.D[1], X28
    FMOV  D8, X6
    FMOV  V8.D[1], X14
    FMOV  D9, X19
    FMOV  V9.D[1], X29
    FMOV  D10, X22
    FMOV  V10.D[1], X2
    FMOV  D11, X9
    FMOV  V11.D[1], X13
    FMOV  D12, X3
    FMOV  V12.D[1], X11
    FMOV  D13, X5
    FMOV  V13.D[1], X15
    FMOV  D14, X12
    FMOV  V14.D[1], X19
    FMOV  D15, X10
    FMOV  V15.D[1], X11
    FMOV  D16, X10
    FMOV  V16.D[1], X2
    FMOV  D17, X16
    FMOV  V17.D[1], X16
    FMOV  D18, X22
    FMOV  V18.D[1], X8
    FMOV  D19, X8
    FMOV  V19.D[1], X13
    FMOV  D20, X24
    FMOV  V20.D[1], X20
    FMOV  D21, X19
    FMOV  V21.D[1], X13
    FMOV  D22, X28
    FMOV  V22.D[1], X28
    FMOV  D23, X27
    FMOV  V23.D[1], X18
    FMOV  D24, X17
    FMOV  V24.D[1], X27
    FMOV  D25, X11
    FMOV  V25.D[1], X19
    FMOV  D26, X15
    FMOV  V26.D[1], X8
    FMOV  D27, X5
    FMOV  V27.D[1], X18
    FMOV  D28, X16
    FMOV  V28.D[1], X17
    FMOV  D29, X22
    FMOV  V29.D[1], X28
    FMOV  D30, X20
    FMOV  V30.D[1], X25
    FMOV  D31, X14
    FMOV  V31.D[1], X5
    MOVZ  X13, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_15:
    SHA1M  Q16, S24, V27.4S
    SHA256SU1  V6.4S, V28.4S, V23.4S
    SHA256H  Q4, Q26, V26.4S
    SHA256SU1  V30.4S, V20.4S, V29.4S
    SHA256SU0  V9.4S, V31.4S
    SHA1SU1  V10.4S, V16.4S
    SHA256H2  Q5, Q25, V4.4S
    SHA1SU0  V22.4S, V21.4S, V5.4S
    SHA1P  Q12, S9, V10.4S
    SHA1C  Q5, S6, V6.4S
    SHA1SU0  V31.4S, V30.4S, V3.4S
    SHA256H2  Q6, Q22, V22.4S
    SHA1P  Q29, S6, V12.4S
    SHA1SU1  V27.4S, V29.4S
    SHA256H  Q24, Q5, V5.4S
    SHA256H  Q22, Q31, V6.4S
    SHA1C  Q21, S27, V24.4S
    SHA1SU1  V11.4S, V22.4S
    SHA256SU1  V16.4S, V21.4S, V21.4S
    SHA1M  Q12, S16, V28.4S
    SHA1M  Q15, S11, V12.4S
    SHA1SU0  V25.4S, V31.4S, V1.4S
    SHA1C  Q23, S29, V7.4S
    SHA1C  Q11, S28, V23.4S
    SHA1C  Q30, S1, V24.4S
    SHA1SU1  V3.4S, V8.4S
    SHA1C  Q5, S11, V17.4S
    SHA1SU1  V11.4S, V24.4S
    SHA1C  Q4, S6, V5.4S
    SHA1SU0  V9.4S, V28.4S, V3.4S
    SHA1P  Q27, S26, V27.4S
    SHA1M  Q6, S5, V23.4S
    SHA256H2  Q12, Q28, V17.4S
    SHA256SU1  V24.4S, V25.4S, V15.4S
    SHA1C  Q16, S1, V6.4S
    SHA1SU0  V25.4S, V27.4S, V12.4S
    SHA256SU0  V12.4S, V24.4S
    SHA1SU1  V3.4S, V16.4S
    SHA1M  Q24, S21, V3.4S
    SHA256SU1  V15.4S, V4.4S, V9.4S
    SHA1SU1  V26.4S, V30.4S
    SHA1M  Q5, S11, V25.4S
    SHA1SU0  V25.4S, V12.4S, V24.4S
    SHA256SU0  V11.4S, V15.4S
    SHA256H2  Q30, Q26, V11.4S
    SHA256H2  Q8, Q25, V30.4S
    SHA256H2  Q25, Q5, V8.4S
    SHA1SU1  V15.4S, V15.4S
    SHA256SU1  V5.4S, V18.4S, V28.4S
    SHA256SU0  V24.4S, V3.4S
    SHA1P  Q7, S7, V23.4S
    SHA256H2  Q27, Q28, V15.4S
    SHA1M  Q9, S29, V7.4S
    SHA256H  Q1, Q25, V29.4S
    SHA1SU0  V3.4S, V8.4S, V21.4S
    SHA1C  Q30, S27, V6.4S
    SHA1P  Q8, S4, V6.4S
    SHA1M  Q16, S29, V1.4S
    SHA1C  Q1, S1, V1.4S
    SHA1P  Q11, S20, V21.4S
    SHA1M  Q17, S24, V1.4S
    SHA1P  Q29, S3, V16.4S
    SHA256H2  Q3, Q9, V8.4S
    SHA1SU0  V8.4S, V11.4S, V3.4S
    SHA1C  Q23, S30, V17.4S
    SHA1SU0  V15.4S, V8.4S, V5.4S
    SHA256H  Q9, Q29, V15.4S
    SHA256SU0  V30.4S, V9.4S
    SHA256SU1  V16.4S, V23.4S, V30.4S
    SHA1SU0  V8.4S, V21.4S, V7.4S
    SHA256H  Q29, Q14, V23.4S
    SHA1C  Q21, S31, V5.4S
    SHA1SU1  V9.4S, V1.4S
    SHA256H2  Q15, Q30, V11.4S
    SHA1C  Q17, S19, V13.4S
    SHA1P  Q31, S5, V19.4S
    SHA256SU0  V4.4S, V16.4S
    SHA256SU0  V3.4S, V13.4S
    SHA256H2  Q23, Q21, V6.4S
    SHA256H2  Q13, Q15, V17.4S
    SHA256SU0  V7.4S, V13.4S
    SHA1M  Q5, S9, V8.4S
    SHA1P  Q9, S5, V31.4S
    SHA256SU1  V14.4S, V9.4S, V29.4S
    SHA256H2  Q31, Q27, V23.4S
    SHA256SU0  V29.4S, V31.4S
    SHA1P  Q27, S4, V14.4S
    SHA1SU0  V31.4S, V3.4S, V27.4S
    SHA256H  Q16, Q7, V29.4S
    SHA1M  Q19, S31, V16.4S
    SHA256H2  Q21, Q17, V8.4S
    SHA1SU1  V5.4S, V3.4S
    SHA1P  Q16, S12, V30.4S
    SHA1SU1  V23.4S, V0.4S
    SHA1SU1  V6.4S, V0.4S
    SHA1SU1  V3.4S, V24.4S
    SHA256SU1  V0.4S, V19.4S, V19.4S
    SHA1M  Q29, S17, V12.4S
    SHA1M  Q30, S17, V31.4S
    SHA1SU1  V8.4S, V21.4S
    SHA1SU0  V7.4S, V5.4S, V5.4S
    SHA1SU1  V24.4S, V27.4S
    SHA1P  Q15, S8, V10.4S
    SHA1M  Q4, S6, V15.4S
    SHA256SU0  V27.4S, V30.4S
    SHA256H2  Q21, Q16, V27.4S
    SHA256SU1  V9.4S, V3.4S, V0.4S
    SHA256SU1  V6.4S, V29.4S, V9.4S
    SHA256H  Q17, Q4, V4.4S
    SHA256H2  Q10, Q24, V7.4S
    SHA256SU0  V16.4S, V6.4S
    SHA1C  Q6, S8, V17.4S
    SHA1M  Q4, S23, V23.4S
    SHA1C  Q27, S21, V10.4S
    SHA1SU1  V23.4S, V16.4S
    SHA1C  Q0, S6, V27.4S
    SHA256SU0  V12.4S, V4.4S
    SHA256SU0  V7.4S, V12.4S
    SHA256SU1  V5.4S, V7.4S, V7.4S
    SHA1SU1  V12.4S, V23.4S
    SHA1C  Q24, S0, V12.4S
    SHA256H2  Q3, Q24, V5.4S
    SHA256H  Q9, Q13, V11.4S
    SHA1SU0  V29.4S, V4.4S, V17.4S
    SHA1SU1  V16.4S, V17.4S
    SHA1SU0  V21.4S, V10.4S, V25.4S
    SHA256H  Q5, Q11, V21.4S
    SHA256H  Q8, Q7, V23.4S
    SHA1M  Q6, S16, V29.4S
    SHA1M  Q10, S16, V10.4S
    SHA1P  Q16, S7, V10.4S
    SHA1C  Q27, S4, V14.4S
    SHA256H  Q12, Q7, V28.4S
    SHA256SU1  V11.4S, V29.4S, V1.4S
    SHA1C  Q13, S11, V16.4S
    SHA1M  Q11, S12, V12.4S
    SHA1M  Q21, S31, V3.4S
    SHA1P  Q23, S27, V21.4S
    SHA256H  Q3, Q6, V5.4S
    SHA256H  Q7, Q3, V8.4S
    SHA1C  Q25, S23, V7.4S
    SHA256H2  Q10, Q20, V9.4S
    SHA1M  Q12, S10, V25.4S
    SHA256SU1  V21.4S, V13.4S, V13.4S
    SHA1P  Q29, S11, V21.4S
    SHA1SU1  V20.4S, V12.4S
    SHA1SU0  V5.4S, V29.4S, V20.4S
    SHA1SU1  V21.4S, V31.4S
    SHA256SU1  V17.4S, V17.4S, V15.4S
    SHA1SU1  V15.4S, V29.4S
    SHA256H2  Q8, Q29, V19.4S
    SHA1SU1  V16.4S, V10.4S
    SHA1C  Q23, S16, V2.4S
    SHA256SU0  V4.4S, V24.4S
    SHA256SU0  V11.4S, V18.4S
    SHA1SU1  V16.4S, V2.4S
    SHA256SU0  V31.4S, V21.4S
    SHA256SU0  V3.4S, V8.4S
    SHA256SU1  V24.4S, V23.4S, V3.4S
    SHA1SU0  V25.4S, V31.4S, V15.4S
    SHA256SU0  V9.4S, V4.4S
    SHA256SU1  V13.4S, V16.4S, V16.4S
    SHA1SU0  V2.4S, V5.4S, V24.4S
    SHA256H2  Q24, Q13, V9.4S
    SHA1C  Q6, S11, V19.4S
    SHA1C  Q12, S10, V17.4S
    SHA1SU0  V21.4S, V12.4S, V25.4S
    SHA256SU0  V16.4S, V5.4S
    SHA1M  Q5, S16, V2.4S
    SHA256SU0  V19.4S, V6.4S
    SHA256H  Q2, Q21, V19.4S
    SHA256SU1  V8.4S, V5.4S, V13.4S
    SHA1P  Q9, S24, V2.4S
    SHA1SU0  V3.4S, V8.4S, V25.4S
    SHA1SU0  V20.4S, V3.4S, V3.4S
    SHA1M  Q5, S13, V20.4S
    SHA1SU0  V31.4S, V9.4S, V9.4S
    SHA1M  Q4, S31, V31.4S
    SHA256SU0  V19.4S, V4.4S
    SHA1SU0  V18.4S, V5.4S, V19.4S
    SHA256H2  Q2, Q15, V4.4S
    SHA1M  Q11, S22, V20.4S
    SHA1SU0  V21.4S, V3.4S, V24.4S
    SHA256SU0  V24.4S, V10.4S
    SHA256SU1  V8.4S, V15.4S, V13.4S
    SHA1C  Q3, S6, V21.4S
    SHA256H  Q17, Q26, V16.4S
    SHA1SU0  V15.4S, V2.4S, V17.4S
    SHA256H  Q17, Q5, V4.4S
    SHA1C  Q20, S12, V5.4S
    SHA256SU0  V4.4S, V1.4S
    SHA256H  Q2, Q18, V4.4S
    SHA256SU1  V22.4S, V28.4S, V17.4S
    SHA256SU0  V17.4S, V10.4S
    SHA256SU0  V26.4S, V3.4S
    SHA256H2  Q25, Q11, V11.4S
    SHA256SU1  V6.4S, V8.4S, V24.4S
    SHA1C  Q9, S26, V20.4S
    SHA1SU1  V31.4S, V2.4S
    SHA256SU1  V19.4S, V15.4S, V31.4S
    SUBS  X13, X13, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_15
    MOVZ  X6, #0xa60d, LSL #0
    MOVK  X6, #0xaf13, LSL #16
    MOVK  X6, #0xae73, LSL #32
    MOVK  X6, #0x32c0, LSL #48
    SUB  X12, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x2df, LSL #0
    MOVK  X6, #0x59bc, LSL #16
    MOVK  X6, #0xd8d1, LSL #32
    MOVK  X6, #0x8460, LSL #48
    SUB  X12, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xb3ac, LSL #0
    MOVK  X6, #0x76cb, LSL #16
    MOVK  X6, #0x999, LSL #32
    MOVK  X6, #0x3c4f, LSL #48
    SUB  X12, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xfe3e, LSL #0
    MOVK  X6, #0x24bc, LSL #16
    MOVK  X6, #0x5d3b, LSL #32
    MOVK  X6, #0xd915, LSL #48
    SUB  X12, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xe79, LSL #0
    MOVK  X6, #0x66c4, LSL #16
    MOVK  X6, #0xba83, LSL #32
    MOVK  X6, #0x8911, LSL #48
    SUB  X12, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x8159, LSL #0
    MOVK  X6, #0x523b, LSL #16
    MOVK  X6, #0xa75e, LSL #32
    MOVK  X6, #0xb1b3, LSL #48
    SUB  X12, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xac93, LSL #0
    MOVK  X6, #0x8905, LSL #16
    MOVK  X6, #0x5814, LSL #32
    MOVK  X6, #0xe033, LSL #48
    SUB  X12, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x0, LSL #0
    SUB  X12, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xa5fa, LSL #0
    MOVK  X6, #0x3204, LSL #16
    MOVK  X6, #0xbc33, LSL #32
    MOVK  X6, #0x4983, LSL #48
    SUB  X12, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xe7db, LSL #0
    MOVK  X6, #0x4ea0, LSL #16
    MOVK  X6, #0x9237, LSL #32
    MOVK  X6, #0xff09, LSL #48
    SUB  X12, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xa129, LSL #0
    MOVK  X6, #0xcb44, LSL #16
    MOVK  X6, #0xe026, LSL #32
    MOVK  X6, #0x74d0, LSL #48
    SUB  X12, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x7e48, LSL #0
    MOVK  X6, #0x630, LSL #16
    MOVK  X6, #0x91ca, LSL #32
    MOVK  X6, #0x4a90, LSL #48
    SUB  X12, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x3ee7, LSL #0
    MOVK  X6, #0xc31e, LSL #16
    MOVK  X6, #0x5d47, LSL #32
    MOVK  X6, #0xc8fd, LSL #48
    SUB  X12, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xfb84, LSL #0
    MOVK  X6, #0x9263, LSL #16
    MOVK  X6, #0xe1c5, LSL #32
    MOVK  X6, #0x1c2c, LSL #48
    SUB  X12, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xd90, LSL #0
    MOVK  X6, #0x432d, LSL #16
    MOVK  X6, #0x7a79, LSL #32
    MOVK  X6, #0xa144, LSL #48
    SUB  X12, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x5c39, LSL #0
    MOVK  X6, #0x984d, LSL #16
    MOVK  X6, #0xb964, LSL #32
    MOVK  X6, #0x354d, LSL #48
    SUB  X12, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xca15, LSL #0
    MOVK  X6, #0xaf89, LSL #16
    MOVK  X6, #0x9ccf, LSL #32
    MOVK  X6, #0x2bd5, LSL #48
    SUB  X12, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x70bd, LSL #0
    MOVK  X6, #0x1465, LSL #16
    MOVK  X6, #0x5807, LSL #32
    MOVK  X6, #0xb5c9, LSL #48
    SUB  X12, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xf46c, LSL #0
    MOVK  X6, #0xbecd, LSL #16
    MOVK  X6, #0x3cae, LSL #32
    MOVK  X6, #0x4109, LSL #48
    SUB  X12, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xd2c, LSL #0
    MOVK  X6, #0xef9e, LSL #16
    MOVK  X6, #0xa08c, LSL #32
    MOVK  X6, #0xbf2a, LSL #48
    SUB  X12, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x1bf9, LSL #0
    MOVK  X6, #0xaf9b, LSL #16
    MOVK  X6, #0xb528, LSL #32
    MOVK  X6, #0x1946, LSL #48
    SUB  X12, X6, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x70de, LSL #0
    MOVK  X6, #0x360e, LSL #16
    MOVK  X6, #0x63cf, LSL #32
    MOVK  X6, #0xf270, LSL #48
    FMOV  X12, V0.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x53a6, LSL #0
    MOVK  X6, #0x2bf1, LSL #16
    MOVK  X6, #0xf414, LSL #32
    MOVK  X6, #0xb0b7, LSL #48
    FMOV  X12, D0
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xb2e6, LSL #0
    MOVK  X6, #0xe35b, LSL #16
    MOVK  X6, #0x44a1, LSL #32
    MOVK  X6, #0x7904, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x4ec0, LSL #0
    MOVK  X6, #0x3cc5, LSL #16
    MOVK  X6, #0xfc34, LSL #32
    MOVK  X6, #0xe805, LSL #48
    FMOV  X12, D1
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x2c8e, LSL #0
    MOVK  X6, #0x9c5f, LSL #16
    MOVK  X6, #0xb497, LSL #32
    MOVK  X6, #0xba48, LSL #48
    FMOV  X12, V2.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x3644, LSL #0
    MOVK  X6, #0x601c, LSL #16
    MOVK  X6, #0xbda, LSL #32
    MOVK  X6, #0x7d44, LSL #48
    FMOV  X12, D2
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xe907, LSL #0
    MOVK  X6, #0x3adc, LSL #16
    MOVK  X6, #0x1c23, LSL #32
    MOVK  X6, #0x60e7, LSL #48
    FMOV  X12, V3.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x52de, LSL #0
    MOVK  X6, #0xce25, LSL #16
    MOVK  X6, #0x9fab, LSL #32
    MOVK  X6, #0xb08d, LSL #48
    FMOV  X12, D3
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x4897, LSL #0
    MOVK  X6, #0x682d, LSL #16
    MOVK  X6, #0x4c51, LSL #32
    MOVK  X6, #0x4319, LSL #48
    FMOV  X12, V4.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x74c2, LSL #0
    MOVK  X6, #0x6cc4, LSL #16
    MOVK  X6, #0x9be0, LSL #32
    MOVK  X6, #0xbf19, LSL #48
    FMOV  X12, D4
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x581e, LSL #0
    MOVK  X6, #0xe47f, LSL #16
    MOVK  X6, #0x5bf5, LSL #32
    MOVK  X6, #0x3d8c, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x1034, LSL #0
    MOVK  X6, #0x421a, LSL #16
    MOVK  X6, #0x769f, LSL #32
    MOVK  X6, #0xdddf, LSL #48
    FMOV  X12, D5
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x1505, LSL #0
    MOVK  X6, #0xf49d, LSL #16
    MOVK  X6, #0xf0eb, LSL #32
    MOVK  X6, #0x8ae8, LSL #48
    FMOV  X12, V6.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x64ab, LSL #0
    MOVK  X6, #0xb109, LSL #16
    MOVK  X6, #0x8d6e, LSL #32
    MOVK  X6, #0x8a5e, LSL #48
    FMOV  X12, D6
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xb28d, LSL #0
    MOVK  X6, #0x55f7, LSL #16
    MOVK  X6, #0x97da, LSL #32
    MOVK  X6, #0x30a2, LSL #48
    FMOV  X12, V7.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xefe1, LSL #0
    MOVK  X6, #0xbbd9, LSL #16
    MOVK  X6, #0xd7c0, LSL #32
    MOVK  X6, #0x12a6, LSL #48
    FMOV  X12, D7
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x3915, LSL #0
    MOVK  X6, #0x7c74, LSL #16
    MOVK  X6, #0x8960, LSL #32
    MOVK  X6, #0x6bbe, LSL #48
    FMOV  X12, V8.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xa1af, LSL #0
    MOVK  X6, #0xf694, LSL #16
    MOVK  X6, #0x72da, LSL #32
    MOVK  X6, #0x4147, LSL #48
    FMOV  X12, D8
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x1bea, LSL #0
    MOVK  X6, #0x8d0a, LSL #16
    MOVK  X6, #0x1093, LSL #32
    MOVK  X6, #0x7ded, LSL #48
    FMOV  X12, V9.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xe6c7, LSL #0
    MOVK  X6, #0x754, LSL #16
    MOVK  X6, #0xc9b7, LSL #32
    MOVK  X6, #0x850d, LSL #48
    FMOV  X12, D9
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xf382, LSL #0
    MOVK  X6, #0x721, LSL #16
    MOVK  X6, #0x9d85, LSL #32
    MOVK  X6, #0x63c1, LSL #48
    FMOV  X12, V10.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xf1f, LSL #0
    MOVK  X6, #0x6086, LSL #16
    MOVK  X6, #0xac4e, LSL #32
    MOVK  X6, #0xc8cb, LSL #48
    FMOV  X12, D10
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x42bd, LSL #0
    MOVK  X6, #0xac6d, LSL #16
    MOVK  X6, #0x7990, LSL #32
    MOVK  X6, #0x1126, LSL #48
    FMOV  X12, V11.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xdc5b, LSL #0
    MOVK  X6, #0x7be2, LSL #16
    MOVK  X6, #0xef21, LSL #32
    MOVK  X6, #0xb15, LSL #48
    FMOV  X12, D11
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x42a, LSL #0
    MOVK  X6, #0xac1b, LSL #16
    MOVK  X6, #0x2ad8, LSL #32
    MOVK  X6, #0x40b9, LSL #48
    FMOV  X12, V12.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xcdb4, LSL #0
    MOVK  X6, #0x3ed8, LSL #16
    MOVK  X6, #0x27c6, LSL #32
    MOVK  X6, #0xe8b6, LSL #48
    FMOV  X12, D12
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x9060, LSL #0
    MOVK  X6, #0xe584, LSL #16
    MOVK  X6, #0x1ddd, LSL #32
    MOVK  X6, #0x210c, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x270e, LSL #0
    MOVK  X6, #0x2cc0, LSL #16
    MOVK  X6, #0xc5ce, LSL #32
    MOVK  X6, #0xa40e, LSL #48
    FMOV  X12, D13
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x4489, LSL #0
    MOVK  X6, #0x84, LSL #16
    MOVK  X6, #0x6c83, LSL #32
    MOVK  X6, #0x4e12, LSL #48
    FMOV  X12, V14.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x8edf, LSL #0
    MOVK  X6, #0x8064, LSL #16
    MOVK  X6, #0x92e2, LSL #32
    MOVK  X6, #0x4c06, LSL #48
    FMOV  X12, D14
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xa8e8, LSL #0
    MOVK  X6, #0xe43c, LSL #16
    MOVK  X6, #0x4ecb, LSL #32
    MOVK  X6, #0x7f23, LSL #48
    FMOV  X12, V15.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x8276, LSL #0
    MOVK  X6, #0x369a, LSL #16
    MOVK  X6, #0x3497, LSL #32
    MOVK  X6, #0xaad8, LSL #48
    FMOV  X12, D15
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xc50c, LSL #0
    MOVK  X6, #0x5ad2, LSL #16
    MOVK  X6, #0xc957, LSL #32
    MOVK  X6, #0x8f38, LSL #48
    FMOV  X12, V16.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xc0a2, LSL #0
    MOVK  X6, #0x3ec7, LSL #16
    MOVK  X6, #0x8f6f, LSL #32
    MOVK  X6, #0x1677, LSL #48
    FMOV  X12, D16
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x6ea8, LSL #0
    MOVK  X6, #0x24f8, LSL #16
    MOVK  X6, #0xf297, LSL #32
    MOVK  X6, #0x57ee, LSL #48
    FMOV  X12, V17.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x5275, LSL #0
    MOVK  X6, #0xed3a, LSL #16
    MOVK  X6, #0x88d2, LSL #32
    MOVK  X6, #0x4a57, LSL #48
    FMOV  X12, D17
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x40c5, LSL #0
    MOVK  X6, #0x8a05, LSL #16
    MOVK  X6, #0x1eb6, LSL #32
    MOVK  X6, #0x4aee, LSL #48
    FMOV  X12, V18.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x50f4, LSL #0
    MOVK  X6, #0x8af6, LSL #16
    MOVK  X6, #0xd9a7, LSL #32
    MOVK  X6, #0x9533, LSL #48
    FMOV  X12, D18
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x14d1, LSL #0
    MOVK  X6, #0x988d, LSL #16
    MOVK  X6, #0x3ef0, LSL #32
    MOVK  X6, #0x2e15, LSL #48
    FMOV  X12, V19.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x1d6f, LSL #0
    MOVK  X6, #0x4311, LSL #16
    MOVK  X6, #0x4308, LSL #32
    MOVK  X6, #0x484c, LSL #48
    FMOV  X12, D19
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x13f9, LSL #0
    MOVK  X6, #0xf2e7, LSL #16
    MOVK  X6, #0x241d, LSL #32
    MOVK  X6, #0x84eb, LSL #48
    FMOV  X12, V20.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x539, LSL #0
    MOVK  X6, #0x4e4b, LSL #16
    MOVK  X6, #0xfe1b, LSL #32
    MOVK  X6, #0xe70c, LSL #48
    FMOV  X12, D20
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x3a9b, LSL #0
    MOVK  X6, #0x6a51, LSL #16
    MOVK  X6, #0xc053, LSL #32
    MOVK  X6, #0x8e37, LSL #48
    FMOV  X12, V21.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x4d58, LSL #0
    MOVK  X6, #0x5829, LSL #16
    MOVK  X6, #0x3f57, LSL #32
    MOVK  X6, #0x4d99, LSL #48
    FMOV  X12, D21
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x54d3, LSL #0
    MOVK  X6, #0xb4ba, LSL #16
    MOVK  X6, #0x12d5, LSL #32
    MOVK  X6, #0x6aaf, LSL #48
    FMOV  X12, V22.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xebe7, LSL #0
    MOVK  X6, #0x2fce, LSL #16
    MOVK  X6, #0xed7b, LSL #32
    MOVK  X6, #0x7b4e, LSL #48
    FMOV  X12, D22
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xf7fb, LSL #0
    MOVK  X6, #0x6ee2, LSL #16
    MOVK  X6, #0x7aef, LSL #32
    MOVK  X6, #0xba1, LSL #48
    FMOV  X12, V23.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x2bb3, LSL #0
    MOVK  X6, #0x8fe2, LSL #16
    MOVK  X6, #0x5254, LSL #32
    MOVK  X6, #0x816d, LSL #48
    FMOV  X12, D23
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x64a2, LSL #0
    MOVK  X6, #0x2a68, LSL #16
    MOVK  X6, #0x6702, LSL #32
    MOVK  X6, #0x1ff7, LSL #48
    FMOV  X12, V24.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xfe30, LSL #0
    MOVK  X6, #0xfea6, LSL #16
    MOVK  X6, #0xdef4, LSL #32
    MOVK  X6, #0xa4fb, LSL #48
    FMOV  X12, D24
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x4322, LSL #0
    MOVK  X6, #0x7d0f, LSL #16
    MOVK  X6, #0xea2c, LSL #32
    MOVK  X6, #0x53b5, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x8c13, LSL #0
    MOVK  X6, #0x6d09, LSL #16
    MOVK  X6, #0xbe16, LSL #32
    MOVK  X6, #0x36c7, LSL #48
    FMOV  X12, D25
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x88a4, LSL #0
    MOVK  X6, #0x2298, LSL #16
    MOVK  X6, #0xd585, LSL #32
    MOVK  X6, #0x1f1d, LSL #48
    FMOV  X12, V26.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x64b9, LSL #0
    MOVK  X6, #0xc8ec, LSL #16
    MOVK  X6, #0x7d0, LSL #32
    MOVK  X6, #0x97a0, LSL #48
    FMOV  X12, D26
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xafb4, LSL #0
    MOVK  X6, #0x8392, LSL #16
    MOVK  X6, #0xe34, LSL #32
    MOVK  X6, #0x2833, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xf614, LSL #0
    MOVK  X6, #0xdb8b, LSL #16
    MOVK  X6, #0x9bc, LSL #32
    MOVK  X6, #0x7dbc, LSL #48
    FMOV  X12, D27
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x7e48, LSL #0
    MOVK  X6, #0x630, LSL #16
    MOVK  X6, #0x91ca, LSL #32
    MOVK  X6, #0x4a90, LSL #48
    FMOV  X12, V28.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xa129, LSL #0
    MOVK  X6, #0xcb44, LSL #16
    MOVK  X6, #0xe026, LSL #32
    MOVK  X6, #0x74d0, LSL #48
    FMOV  X12, D28
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x6741, LSL #0
    MOVK  X6, #0x5237, LSL #16
    MOVK  X6, #0x86b5, LSL #32
    MOVK  X6, #0x39da, LSL #48
    FMOV  X12, V29.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x3299, LSL #0
    MOVK  X6, #0xed93, LSL #16
    MOVK  X6, #0xae64, LSL #32
    MOVK  X6, #0x861b, LSL #48
    FMOV  X12, D29
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xd233, LSL #0
    MOVK  X6, #0x8d2c, LSL #16
    MOVK  X6, #0x7cba, LSL #32
    MOVK  X6, #0x5067, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0xb161, LSL #0
    MOVK  X6, #0x6ee2, LSL #16
    MOVK  X6, #0xa8c3, LSL #32
    MOVK  X6, #0x240d, LSL #48
    FMOV  X12, D30
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x6c04, LSL #0
    MOVK  X6, #0xbd59, LSL #16
    MOVK  X6, #0x3fbc, LSL #32
    MOVK  X6, #0xd999, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X6, #0x68cc, LSL #0
    MOVK  X6, #0x65f7, LSL #16
    MOVK  X6, #0x4689, LSL #32
    MOVK  X6, #0x40c9, LSL #48
    FMOV  X12, D31
    SUB  X25, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X28
    FMOV  V0.D[1], X24
    FMOV  D1, X11
    FMOV  V1.D[1], X29
    FMOV  D2, X25
    FMOV  V2.D[1], X14
    FMOV  D3, X22
    FMOV  V3.D[1], X21
    FMOV  D4, X17
    FMOV  V4.D[1], X19
    FMOV  D5, X27
    FMOV  V5.D[1], X20
    FMOV  D6, X25
    FMOV  V6.D[1], X12
    FMOV  D7, X13
    FMOV  V7.D[1], X27
    FMOV  D8, X5
    FMOV  V8.D[1], X5
    FMOV  D9, X14
    FMOV  V9.D[1], X18
    FMOV  D10, X10
    FMOV  V10.D[1], X27
    FMOV  D11, X24
    FMOV  V11.D[1], X18
    FMOV  D12, X15
    FMOV  V12.D[1], X10
    FMOV  D13, X18
    FMOV  V13.D[1], X12
    FMOV  D14, X8
    FMOV  V14.D[1], X17
    FMOV  D15, X27
    FMOV  V15.D[1], X12
    FMOV  D16, X2
    FMOV  V16.D[1], X19
    FMOV  D17, X24
    FMOV  V17.D[1], X21
    FMOV  D18, X22
    FMOV  V18.D[1], X15
    FMOV  D19, X14
    FMOV  V19.D[1], X2
    FMOV  D20, X10
    FMOV  V20.D[1], X8
    FMOV  D21, X11
    FMOV  V21.D[1], X14
    FMOV  D22, X13
    FMOV  V22.D[1], X16
    FMOV  D23, X6
    FMOV  V23.D[1], X2
    FMOV  D24, X3
    FMOV  V24.D[1], X19
    FMOV  D25, X18
    FMOV  V25.D[1], X27
    FMOV  D26, X8
    FMOV  V26.D[1], X5
    FMOV  D27, X2
    FMOV  V27.D[1], X12
    FMOV  D28, X28
    FMOV  V28.D[1], X19
    FMOV  D29, X24
    FMOV  V29.D[1], X8
    FMOV  D30, X20
    FMOV  V30.D[1], X3
    FMOV  D31, X2
    FMOV  V31.D[1], X3
    MOVZ  X16, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_16:
    SHA1SU0  V9.4S, V24.4S, V23.4S
    SHA1C  Q25, S9, V9.4S
    SHA1SU1  V23.4S, V25.4S
    SHA256SU1  V29.4S, V31.4S, V30.4S
    SHA256SU0  V3.4S, V28.4S
    SHA256SU0  V23.4S, V26.4S
    SHA256H2  Q20, Q23, V27.4S
    SHA1P  Q15, S29, V20.4S
    SHA1M  Q0, S3, V3.4S
    SHA256H2  Q20, Q15, V0.4S
    SHA256SU0  V24.4S, V20.4S
    SHA256SU0  V5.4S, V24.4S
    SHA256H  Q22, Q5, V5.4S
    SHA256H  Q9, Q11, V12.4S
    SHA256SU1  V5.4S, V13.4S, V30.4S
    SHA1C  Q30, S25, V16.4S
    SHA1M  Q24, S18, V26.4S
    SHA256H2  Q23, Q18, V29.4S
    SHA256H2  Q31, Q5, V23.4S
    SHA256SU0  V25.4S, V19.4S
    SHA1C  Q28, S29, V20.4S
    SHA256SU0  V20.4S, V7.4S
    SHA1M  Q0, S30, V30.4S
    SHA1SU1  V29.4S, V22.4S
    SHA1C  Q12, S7, V25.4S
    SHA1P  Q15, S3, V16.4S
    SHA1M  Q11, S20, V12.4S
    SHA256H  Q27, Q9, V24.4S
    SHA256H2  Q3, Q31, V15.4S
    SHA256H  Q13, Q27, V29.4S
    SHA256SU1  V18.4S, V11.4S, V28.4S
    SHA1P  Q19, S13, V0.4S
    SHA256SU1  V23.4S, V19.4S, V3.4S
    SHA256H2  Q0, Q23, V23.4S
    SHA256SU0  V20.4S, V0.4S
    SHA256SU0  V15.4S, V12.4S
    SHA256H  Q23, Q15, V15.4S
    SHA1SU1  V26.4S, V18.4S
    SHA256H  Q5, Q26, V20.4S
    SHA1SU1  V19.4S, V23.4S
    SHA1SU0  V13.4S, V19.4S, V19.4S
    SHA1C  Q26, S13, V5.4S
    SHA256H  Q27, Q16, V19.4S
    SHA256H  Q29, Q20, V6.4S
    SHA1SU1  V16.4S, V14.4S
    SHA1M  Q19, S16, V16.4S
    SHA256SU1  V25.4S, V2.4S, V9.4S
    SHA1SU1  V23.4S, V21.4S
    SHA256SU1  V21.4S, V11.4S, V6.4S
    SHA1SU0  V30.4S, V25.4S, V5.4S
    SHA256H  Q28, Q19, V12.4S
    SHA1P  Q0, S20, V9.4S
    SHA256SU1  V20.4S, V20.4S, V12.4S
    SHA256H  Q5, Q23, V0.4S
    SHA256SU1  V2.4S, V28.4S, V20.4S
    SHA1C  Q25, S26, V2.4S
    SHA256H  Q6, Q27, V27.4S
    SHA1P  Q19, S21, V25.4S
    SHA256SU0  V25.4S, V6.4S
    SHA256H  Q6, Q30, V5.4S
    SHA256H2  Q9, Q29, V29.4S
    SHA1SU1  V27.4S, V25.4S
    SHA1P  Q11, S19, V27.4S
    SHA1SU0  V25.4S, V6.4S, V11.4S
    SHA256H  Q12, Q9, V9.4S
    SHA256SU1  V9.4S, V25.4S, V12.4S
    SHA1M  Q29, S28, V24.4S
    SHA1P  Q21, S15, V6.4S
    SHA1SU1  V0.4S, V23.4S
    SHA256SU1  V20.4S, V2.4S, V0.4S
    SHA256SU0  V25.4S, V17.4S
    SHA1SU1  V26.4S, V10.4S
    SHA256H2  Q16, Q26, V30.4S
    SHA1C  Q26, S27, V10.4S
    SHA1C  Q14, S16, V8.4S
    SHA1M  Q24, S27, V12.4S
    SHA1M  Q8, S16, V13.4S
    SHA1SU1  V11.4S, V9.4S
    SHA1P  Q10, S29, V11.4S
    SHA1SU1  V3.4S, V21.4S
    SHA1P  Q28, S10, V24.4S
    SHA256H2  Q15, Q8, V8.4S
    SHA1P  Q21, S3, V15.4S
    SHA256SU0  V6.4S, V20.4S
    SHA1M  Q27, S21, V21.4S
    SHA256SU0  V12.4S, V6.4S
    SHA256SU0  V24.4S, V27.4S
    SHA1C  Q21, S24, V14.4S
    SHA256H2  Q17, Q25, V28.4S
    SHA256SU0  V23.4S, V12.4S
    SHA1P  Q12, S27, V21.4S
    SHA256H  Q10, Q17, V26.4S
    SHA256H  Q25, Q10, V12.4S
    SHA1M  Q20, S23, V23.4S
    SHA256H  Q23, Q12, V20.4S
    SHA256SU0  V10.4S, V25.4S
    SHA256H  Q9, Q22, V23.4S
    SHA256SU0  V23.4S, V10.4S
    SHA256H2  Q20, Q23, V9.4S
    SHA256SU0  V15.4S, V13.4S
    SHA256SU0  V12.4S, V21.4S
    SHA256H  Q25, Q0, V10.4S
    SHA1SU1  V26.4S, V23.4S
    SHA256SU0  V10.4S, V25.4S
    SHA256SU1  V17.4S, V7.4S, V29.4S
    SHA256H  Q22, Q26, V9.4S
    SHA256SU1  V0.4S, V3.4S, V3.4S
    SHA1P  Q21, S5, V19.4S
    SHA1M  Q27, S9, V29.4S
    SHA1P  Q23, S0, V17.4S
    SHA256SU0  V17.4S, V27.4S
    SHA1C  Q24, S17, V21.4S
    SHA256SU1  V29.4S, V15.4S, V23.4S
    SHA1M  Q6, S20, V29.4S
    SHA256H  Q14, Q12, V12.4S
    SHA1C  Q3, S22, V10.4S
    SHA1M  Q27, S3, V14.4S
    SHA1SU1  V22.4S, V24.4S
    SHA1C  Q28, S22, V22.4S
    SHA256SU0  V24.4S, V6.4S
    SHA1P  Q0, S27, V27.4S
    SHA1SU1  V13.4S, V27.4S
    SHA1M  Q6, S14, V13.4S
    SHA256H2  Q8, Q24, V28.4S
    SHA1SU1  V7.4S, V8.4S
    SHA256SU1  V12.4S, V0.4S, V7.4S
    SHA256H  Q7, Q12, V21.4S
    SHA256SU0  V26.4S, V6.4S
    SHA1M  Q3, S26, V7.4S
    SHA256H  Q5, Q18, V17.4S
    SHA1P  Q22, S5, V10.4S
    SHA256SU1  V7.4S, V10.4S, V27.4S
    SHA256H2  Q13, Q26, V7.4S
    SHA256H2  Q12, Q24, V28.4S
    SHA256H2  Q5, Q23, V20.4S
    SHA1M  Q10, S14, V31.4S
    SHA1SU0  V7.4S, V31.4S, V0.4S
    SHA1C  Q0, S31, V27.4S
    SHA256H2  Q29, Q19, V30.4S
    SHA1P  Q20, S22, V12.4S
    SHA1M  Q21, S3, V0.4S
    SHA1SU0  V8.4S, V21.4S, V16.4S
    SHA256H  Q26, Q20, V8.4S
    SHA1SU1  V20.4S, V29.4S
    SHA256H  Q27, Q20, V13.4S
    SHA1C  Q22, S27, V7.4S
    SHA256H  Q7, Q10, V10.4S
    SHA256SU0  V28.4S, V7.4S
    SHA256H  Q24, Q26, V5.4S
    SHA1M  Q23, S24, V28.4S
    SHA1SU0  V7.4S, V22.4S, V23.4S
    SHA1SU0  V10.4S, V18.4S, V22.4S
    SHA1P  Q8, S20, V27.4S
    SHA256SU0  V23.4S, V18.4S
    SHA1M  Q20, S7, V2.4S
    SHA256H2  Q19, Q31, V26.4S
    SHA1SU1  V5.4S, V20.4S
    SHA256SU1  V20.4S, V22.4S, V9.4S
    SHA1M  Q22, S26, V8.4S
    SHA256H2  Q2, Q25, V27.4S
    SHA256SU0  V16.4S, V0.4S
    SHA1C  Q24, S7, V9.4S
    SHA1SU1  V18.4S, V2.4S
    SHA1SU0  V12.4S, V2.4S, V10.4S
    SHA256H  Q27, Q23, V23.4S
    SHA256SU0  V28.4S, V18.4S
    SHA1M  Q9, S28, V19.4S
    SHA1SU0  V7.4S, V16.4S, V9.4S
    SHA256H  Q23, Q27, V7.4S
    SHA256H2  Q8, Q12, V23.4S
    SHA256H2  Q31, Q24, V8.4S
    SHA256H2  Q18, Q22, V22.4S
    SHA1M  Q9, S20, V5.4S
    SHA256SU1  V0.4S, V9.4S, V31.4S
    SHA256SU1  V8.4S, V18.4S, V18.4S
    SHA256H2  Q26, Q8, V8.4S
    SHA1SU0  V29.4S, V26.4S, V0.4S
    SHA1M  Q20, S25, V26.4S
    SHA256H  Q22, Q13, V2.4S
    SHA256H2  Q10, Q26, V7.4S
    SHA1P  Q2, S15, V25.4S
    SHA1SU1  V24.4S, V14.4S
    SHA256H  Q19, Q2, V11.4S
    SHA256H  Q14, Q23, V7.4S
    SHA1M  Q15, S12, V17.4S
    SHA1C  Q23, S30, V26.4S
    SHA1M  Q21, S10, V10.4S
    SHA256H  Q11, Q21, V23.4S
    SHA1P  Q5, S19, V29.4S
    SHA256SU1  V2.4S, V11.4S, V15.4S
    SHA1SU0  V25.4S, V5.4S, V22.4S
    SHA256SU0  V26.4S, V31.4S
    SHA1M  Q8, S17, V14.4S
    SHA1C  Q22, S20, V25.4S
    SHA1SU1  V18.4S, V11.4S
    SHA1P  Q29, S2, V18.4S
    SHA256SU1  V7.4S, V24.4S, V24.4S
    SHA1SU1  V14.4S, V26.4S
    SHA256H  Q5, Q8, V14.4S
    SHA1M  Q12, S22, V22.4S
    SUBS  X16, X16, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_16
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    SUB  X14, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D0
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D1
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D2
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D3
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D4
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D5
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D6
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D7
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D8
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D9
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D10
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D11
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D12
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D13
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D14
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D15
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D16
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D17
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D18
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D19
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D20
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D21
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D22
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D23
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D24
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D25
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D26
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D27
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D28
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D29
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D30
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, D31
    SUB  X20, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  V0.D[1], X24
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X22
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X5
    FMOV  D4, X24
    FMOV  V4.D[1], X25
    FMOV  D5, X3
    FMOV  V5.D[1], X20
    FMOV  D6, X12
    FMOV  V6.D[1], X11
    FMOV  D7, X28
    FMOV  V7.D[1], X11
    FMOV  D8, X3
    FMOV  V8.D[1], X11
    FMOV  D9, X3
    FMOV  V9.D[1], X21
    FMOV  D10, X28
    FMOV  V10.D[1], X16
    FMOV  D11, X5
    FMOV  V11.D[1], X5
    FMOV  D12, X27
    FMOV  V12.D[1], X13
    FMOV  D13, X25
    FMOV  V13.D[1], X14
    FMOV  D14, X15
    FMOV  V14.D[1], X12
    FMOV  D15, X13
    FMOV  V15.D[1], X16
    FMOV  D16, X19
    FMOV  V16.D[1], X29
    FMOV  D17, X11
    FMOV  V17.D[1], X2
    FMOV  D18, X8
    FMOV  V18.D[1], X28
    FMOV  D19, X16
    FMOV  V19.D[1], X17
    FMOV  D20, X12
    FMOV  V20.D[1], X15
    FMOV  D21, X16
    FMOV  V21.D[1], X2
    FMOV  D22, X29
    FMOV  V22.D[1], X5
    FMOV  D23, X22
    FMOV  V23.D[1], X20
    FMOV  D24, X3
    FMOV  V24.D[1], X24
    FMOV  D25, X20
    FMOV  V25.D[1], X5
    FMOV  D26, X17
    FMOV  V26.D[1], X20
    FMOV  D27, X10
    FMOV  V27.D[1], X17
    FMOV  D28, X21
    FMOV  V28.D[1], X2
    FMOV  D29, X21
    FMOV  V29.D[1], X6
    FMOV  D30, X22
    FMOV  V30.D[1], X22
    FMOV  D31, X8
    FMOV  V31.D[1], X13
    MOVZ  X21, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_17:
    SHA1P  Q8, S30, V28.4S
    SHA1P  Q9, S29, V26.4S
    SHA256SU1  V29.4S, V24.4S, V25.4S
    SHA1P  Q27, S29, V8.4S
    SHA1SU0  V3.4S, V31.4S, V27.4S
    SHA1P  Q0, S3, V3.4S
    SHA256H2  Q17, Q0, V9.4S
    SHA256SU0  V11.4S, V23.4S
    SHA256H2  Q10, Q22, V11.4S
    SHA256SU0  V24.4S, V17.4S
    SHA1C  Q23, S10, V10.4S
    SHA256SU1  V3.4S, V23.4S, V23.4S
    SHA1M  Q30, S24, V24.4S
    SHA1SU1  V10.4S, V3.4S
    SHA1M  Q17, S27, V30.4S
    SHA256H  Q22, Q10, V10.4S
    SHA1P  Q28, S22, V22.4S
    SHA256H2  Q10, Q28, V17.4S
    SHA1P  Q9, S24, V1.4S
    SHA1C  Q26, S30, V11.4S
    SHA256SU0  V31.4S, V13.4S
    SHA1M  Q13, S2, V0.4S
    SHA256SU1  V22.4S, V22.4S, V10.4S
    SHA1C  Q24, S2, V8.4S
    SHA256H  Q23, Q13, V5.4S
    SHA1P  Q2, S22, V25.4S
    SHA256H  Q17, Q2, V3.4S
    SHA1SU1  V27.4S, V5.4S
    SHA1P  Q5, S14, V6.4S
    SHA1P  Q28, S1, V31.4S
    SHA256SU0  V13.4S, V31.4S
    SHA1M  Q22, S28, V13.4S
    SHA1P  Q10, S24, V26.4S
    SHA256H2  Q2, Q10, V17.4S
    SHA256SU0  V28.4S, V23.4S
    SHA256H2  Q6, Q22, V27.4S
    SHA1SU1  V27.4S, V2.4S
    SHA256SU0  V11.4S, V28.4S
    SHA256SU0  V2.4S, V9.4S
    SHA256SU1  V10.4S, V21.4S, V6.4S
    SHA1SU0  V30.4S, V10.4S, V27.4S
    SHA1SU1  V11.4S, V5.4S
    SHA1SU1  V14.4S, V16.4S
    SHA1C  Q31, S14, V2.4S
    SHA256SU1  V6.4S, V30.4S, V31.4S
    SHA1C  Q17, S6, V6.4S
    SHA1SU1  V24.4S, V11.4S
    SHA256SU0  V26.4S, V24.4S
    SHA1SU1  V5.4S, V17.4S
    SHA256H2  Q22, Q29, V26.4S
    SHA256H2  Q26, Q5, V5.4S
    SHA1P  Q31, S26, V22.4S
    SHA256SU0  V16.4S, V23.4S
    SHA1SU1  V26.4S, V24.4S
    SHA1SU0  V29.4S, V27.4S, V0.4S
    SHA256H  Q5, Q1, V30.4S
    SHA1P  Q22, S24, V4.4S
    SHA256H2  Q28, Q20, V0.4S
    SHA1P  Q27, S5, V11.4S
    SHA256H2  Q6, Q6, V14.4S
    SHA1C  Q9, S4, V2.4S
    SHA256SU0  V24.4S, V6.4S
    SHA256SU1  V6.4S, V26.4S, V9.4S
    SHA256SU1  V4.4S, V29.4S, V24.4S
    SHA1SU1  V23.4S, V27.4S
    SHA1M  Q29, S28, V31.4S
    SHA1SU1  V31.4S, V23.4S
    SHA1P  Q23, S16, V31.4S
    SHA256SU1  V21.4S, V6.4S, V6.4S
    SHA256SU0  V0.4S, V22.4S
    SHA256SU1  V2.4S, V4.4S, V4.4S
    SHA1SU1  V16.4S, V0.4S
    SHA1C  Q28, S16, V23.4S
    SHA256SU1  V30.4S, V28.4S, V2.4S
    SHA1P  Q4, S29, V30.4S
    SHA256H2  Q22, Q4, V21.4S
    SHA1SU0  V5.4S, V6.4S, V19.4S
    SHA1M  Q29, S8, V22.4S
    SHA1SU0  V26.4S, V15.4S, V2.4S
    SHA256H2  Q31, Q0, V3.4S
    SHA256H  Q1, Q4, V11.4S
    SHA256SU0  V3.4S, V3.4S
    SHA256H  Q30, Q3, V29.4S
    SHA256SU1  V4.4S, V30.4S, V31.4S
    SHA256H2  Q24, Q5, V20.4S
    SHA256SU0  V21.4S, V8.4S
    SHA1P  Q30, S31, V28.4S
    SHA256SU1  V23.4S, V30.4S, V24.4S
    SHA256H2  Q16, Q18, V16.4S
    SHA1SU1  V6.4S, V11.4S
    SHA256SU1  V5.4S, V8.4S, V5.4S
    SHA256SU1  V31.4S, V12.4S, V14.4S
    SHA1SU0  V12.4S, V4.4S, V5.4S
    SHA1SU0  V8.4S, V23.4S, V12.4S
    SHA1M  Q22, S16, V8.4S
    SHA1M  Q28, S6, V31.4S
    SHA256H  Q14, Q26, V26.4S
    SHA1C  Q18, S22, V21.4S
    SHA1SU0  V5.4S, V14.4S, V28.4S
    SHA256SU0  V30.4S, V1.4S
    SHA256SU1  V8.4S, V30.4S, V18.4S
    SHA256SU0  V11.4S, V8.4S
    SHA256SU1  V24.4S, V11.4S, V28.4S
    SHA1P  Q4, S24, V5.4S
    SHA256SU1  V20.4S, V0.4S, V26.4S
    SHA1SU0  V31.4S, V31.4S, V30.4S
    SHA1SU0  V8.4S, V18.4S, V7.4S
    SHA1M  Q23, S20, V13.4S
    SHA1P  Q13, S17, V28.4S
    SHA1SU0  V17.4S, V24.4S, V7.4S
    SHA256H2  Q18, Q2, V3.4S
    SHA1SU0  V1.4S, V15.4S, V16.4S
    SHA256H2  Q5, Q8, V4.4S
    SHA1C  Q15, S14, V0.4S
    SHA1M  Q16, S18, V6.4S
    SHA256H2  Q18, Q9, V7.4S
    SHA256H2  Q26, Q17, V18.4S
    SHA1C  Q3, S23, V31.4S
    SHA1SU1  V22.4S, V13.4S
    SHA1M  Q11, S1, V3.4S
    SHA1SU1  V6.4S, V11.4S
    SHA256SU1  V31.4S, V16.4S, V22.4S
    SHA1P  Q16, S31, V6.4S
    SHA256H  Q18, Q16, V26.4S
    SHA256SU1  V2.4S, V16.4S, V15.4S
    SHA1M  Q28, S18, V2.4S
    SHA256H  Q11, Q5, V5.4S
    SHA1C  Q14, S11, V28.4S
    SHA1C  Q13, S0, V22.4S
    SHA256SU0  V9.4S, V8.4S
    SHA256SU1  V4.4S, V25.4S, V18.4S
    SHA1C  Q8, S21, V2.4S
    SHA256SU0  V21.4S, V9.4S
    SHA1C  Q23, S1, V20.4S
    SHA1M  Q0, S29, V2.4S
    SHA1SU0  V30.4S, V30.4S, V28.4S
    SHA1M  Q18, S10, V7.4S
    SHA256SU0  V7.4S, V4.4S
    SHA256SU1  V10.4S, V31.4S, V0.4S
    SHA256SU0  V11.4S, V10.4S
    SHA256H  Q1, Q18, V8.4S
    SHA256H  Q6, Q1, V7.4S
    SHA1M  Q20, S21, V30.4S
    SHA1M  Q22, S11, V28.4S
    SHA1SU1  V9.4S, V20.4S
    SHA256SU0  V31.4S, V22.4S
    SHA1M  Q16, S13, V23.4S
    SHA1C  Q29, S6, V9.4S
    SHA256SU0  V7.4S, V14.4S
    SHA1P  Q0, S31, V7.4S
    SHA256H2  Q4, Q16, V0.4S
    SHA256H  Q31, Q4, V29.4S
    SHA1SU0  V16.4S, V28.4S, V18.4S
    SHA1SU0  V21.4S, V7.4S, V11.4S
    SHA256H  Q7, Q24, V24.4S
    SHA1SU1  V14.4S, V23.4S
    SHA1M  Q23, S21, V14.4S
    SHA1SU0  V9.4S, V26.4S, V12.4S
    SHA1SU1  V24.4S, V4.4S
    SHA256SU0  V14.4S, V3.4S
    SHA256SU1  V2.4S, V30.4S, V14.4S
    SHA256SU0  V21.4S, V8.4S
    SHA1P  Q10, S12, V25.4S
    SHA1C  Q0, S10, V2.4S
    SHA256H2  Q20, Q21, V0.4S
    SHA1C  Q29, S7, V31.4S
    SHA1C  Q26, S9, V23.4S
    SHA1P  Q23, S24, V16.4S
    SHA256SU0  V11.4S, V20.4S
    SHA1C  Q9, S29, V26.4S
    SHA256H2  Q8, Q23, V23.4S
    SHA256H  Q20, Q9, V9.4S
    SHA1SU1  V29.4S, V20.4S
    SHA1SU1  V20.4S, V29.4S
    SHA1SU1  V14.4S, V11.4S
    SHA1M  Q30, S14, V8.4S
    SHA1SU0  V0.4S, V20.4S, V30.4S
    SHA1SU0  V29.4S, V1.4S, V14.4S
    SHA256SU1  V8.4S, V15.4S, V29.4S
    SHA1M  Q23, S12, V9.4S
    SHA256H2  Q16, Q11, V3.4S
    SHA256SU0  V14.4S, V1.4S
    SHA1C  Q18, S16, V26.4S
    SHA1SU0  V21.4S, V5.4S, V6.4S
    SHA256SU0  V15.4S, V22.4S
    SHA256H2  Q2, Q3, V13.4S
    SHA1C  Q20, S9, V9.4S
    SHA256H2  Q24, Q18, V14.4S
    SHA1M  Q7, S21, V2.4S
    SHA1M  Q26, S15, V0.4S
    SHA1M  Q22, S24, V20.4S
    SHA1SU1  V13.4S, V23.4S
    SHA1SU0  V10.4S, V13.4S, V7.4S
    SHA256H  Q23, Q26, V8.4S
    SHA1SU0  V2.4S, V22.4S, V7.4S
    SHA1SU1  V11.4S, V10.4S
    SHA256H2  Q31, Q11, V2.4S
    SHA1SU0  V3.4S, V31.4S, V23.4S
    SHA256SU1  V9.4S, V22.4S, V23.4S
    SHA1C  Q20, S4, V0.4S
    SUBS  X21, X21, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_17
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x0, LSL #0
    SUB  X12, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x8a10, LSL #0
    MOVK  X11, #0x1787, LSL #16
    MOVK  X11, #0xf52b, LSL #32
    MOVK  X11, #0x9025, LSL #48
    FMOV  X12, V0.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x74c6, LSL #0
    MOVK  X11, #0xcc, LSL #16
    MOVK  X11, #0x1626, LSL #32
    MOVK  X11, #0x9fb3, LSL #48
    FMOV  X12, D0
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x70f4, LSL #0
    MOVK  X11, #0xbeb6, LSL #16
    MOVK  X11, #0xb5d5, LSL #32
    MOVK  X11, #0x60f3, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x567a, LSL #0
    MOVK  X11, #0x101c, LSL #16
    MOVK  X11, #0x3304, LSL #32
    MOVK  X11, #0xdd54, LSL #48
    FMOV  X12, D1
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x7b0d, LSL #0
    MOVK  X11, #0x487d, LSL #16
    MOVK  X11, #0x963f, LSL #32
    MOVK  X11, #0x1bf9, LSL #48
    FMOV  X12, V2.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x5528, LSL #0
    MOVK  X11, #0x3b87, LSL #16
    MOVK  X11, #0x7a79, LSL #32
    MOVK  X11, #0x523c, LSL #48
    FMOV  X12, D2
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x97ea, LSL #0
    MOVK  X11, #0xb6ea, LSL #16
    MOVK  X11, #0x5cec, LSL #32
    MOVK  X11, #0x5083, LSL #48
    FMOV  X12, V3.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xedf9, LSL #0
    MOVK  X11, #0xe4f7, LSL #16
    MOVK  X11, #0x183a, LSL #32
    MOVK  X11, #0x4c98, LSL #48
    FMOV  X12, D3
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x42f5, LSL #0
    MOVK  X11, #0x4e25, LSL #16
    MOVK  X11, #0x225a, LSL #32
    MOVK  X11, #0xad38, LSL #48
    FMOV  X12, V4.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x4f85, LSL #0
    MOVK  X11, #0x6d44, LSL #16
    MOVK  X11, #0x241c, LSL #32
    MOVK  X11, #0x5f1f, LSL #48
    FMOV  X12, D4
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x2078, LSL #0
    MOVK  X11, #0xc3a8, LSL #16
    MOVK  X11, #0x9142, LSL #32
    MOVK  X11, #0xb51, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x7df0, LSL #0
    MOVK  X11, #0xf51, LSL #16
    MOVK  X11, #0x9739, LSL #32
    MOVK  X11, #0x944a, LSL #48
    FMOV  X12, D5
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x5965, LSL #0
    MOVK  X11, #0xd62a, LSL #16
    MOVK  X11, #0xbfa8, LSL #32
    MOVK  X11, #0xf4f0, LSL #48
    FMOV  X12, V6.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x201c, LSL #0
    MOVK  X11, #0xf6a9, LSL #16
    MOVK  X11, #0x59d6, LSL #32
    MOVK  X11, #0x8819, LSL #48
    FMOV  X12, D6
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xf39a, LSL #0
    MOVK  X11, #0xeca7, LSL #16
    MOVK  X11, #0xd60b, LSL #32
    MOVK  X11, #0xabf1, LSL #48
    FMOV  X12, V7.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x73b8, LSL #0
    MOVK  X11, #0x45b, LSL #16
    MOVK  X11, #0x16ed, LSL #32
    MOVK  X11, #0x217c, LSL #48
    FMOV  X12, D7
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xebcb, LSL #0
    MOVK  X11, #0x3e06, LSL #16
    MOVK  X11, #0xfb7d, LSL #32
    MOVK  X11, #0x69b4, LSL #48
    FMOV  X12, V8.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x17, LSL #0
    MOVK  X11, #0x1d26, LSL #16
    MOVK  X11, #0x15a6, LSL #32
    MOVK  X11, #0xf74d, LSL #48
    FMOV  X12, D8
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x73d1, LSL #0
    MOVK  X11, #0x336c, LSL #16
    MOVK  X11, #0x120a, LSL #32
    MOVK  X11, #0x2c33, LSL #48
    FMOV  X12, V9.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x7206, LSL #0
    MOVK  X11, #0xdf65, LSL #16
    MOVK  X11, #0x76ce, LSL #32
    MOVK  X11, #0x10df, LSL #48
    FMOV  X12, D9
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x6d08, LSL #0
    MOVK  X11, #0xbf93, LSL #16
    MOVK  X11, #0x6a68, LSL #32
    MOVK  X11, #0xbe3e, LSL #48
    FMOV  X12, V10.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa998, LSL #0
    MOVK  X11, #0xbc63, LSL #16
    MOVK  X11, #0x7bab, LSL #32
    MOVK  X11, #0xf096, LSL #48
    FMOV  X12, D10
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x2f69, LSL #0
    MOVK  X11, #0x8150, LSL #16
    MOVK  X11, #0x62a8, LSL #32
    MOVK  X11, #0x473f, LSL #48
    FMOV  X12, V11.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xf50f, LSL #0
    MOVK  X11, #0xe3c8, LSL #16
    MOVK  X11, #0xe718, LSL #32
    MOVK  X11, #0xd3a5, LSL #48
    FMOV  X12, D11
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x6548, LSL #0
    MOVK  X11, #0x85e2, LSL #16
    MOVK  X11, #0xdff5, LSL #32
    MOVK  X11, #0xd0d, LSL #48
    FMOV  X12, V12.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa4c8, LSL #0
    MOVK  X11, #0x6dce, LSL #16
    MOVK  X11, #0x688f, LSL #32
    MOVK  X11, #0xbae6, LSL #48
    FMOV  X12, D12
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xc90, LSL #0
    MOVK  X11, #0x4197, LSL #16
    MOVK  X11, #0xfdbd, LSL #32
    MOVK  X11, #0xb489, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xfe8c, LSL #0
    MOVK  X11, #0x7623, LSL #16
    MOVK  X11, #0x7b68, LSL #32
    MOVK  X11, #0xe1d4, LSL #48
    FMOV  X12, D13
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x8783, LSL #0
    MOVK  X11, #0xe43c, LSL #16
    MOVK  X11, #0xfe61, LSL #32
    MOVK  X11, #0x7168, LSL #48
    FMOV  X12, V14.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x3ad7, LSL #0
    MOVK  X11, #0x8bd9, LSL #16
    MOVK  X11, #0x20a6, LSL #32
    MOVK  X11, #0xfcee, LSL #48
    FMOV  X12, D14
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xb3a0, LSL #0
    MOVK  X11, #0x993a, LSL #16
    MOVK  X11, #0xecb8, LSL #32
    MOVK  X11, #0x3bab, LSL #48
    FMOV  X12, V15.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x4a08, LSL #0
    MOVK  X11, #0x68c7, LSL #16
    MOVK  X11, #0x597a, LSL #32
    MOVK  X11, #0xb33c, LSL #48
    FMOV  X12, D15
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x9ba6, LSL #0
    MOVK  X11, #0xd3ca, LSL #16
    MOVK  X11, #0x2cc8, LSL #32
    MOVK  X11, #0x7751, LSL #48
    FMOV  X12, V16.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x67f, LSL #0
    MOVK  X11, #0x16cc, LSL #16
    MOVK  X11, #0xe84, LSL #32
    MOVK  X11, #0x9bbb, LSL #48
    FMOV  X12, D16
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x97cb, LSL #0
    MOVK  X11, #0x2dda, LSL #16
    MOVK  X11, #0x2711, LSL #32
    MOVK  X11, #0x5776, LSL #48
    FMOV  X12, V17.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xd09e, LSL #0
    MOVK  X11, #0x43e2, LSL #16
    MOVK  X11, #0x27a6, LSL #32
    MOVK  X11, #0x3606, LSL #48
    FMOV  X12, D17
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x7d2d, LSL #0
    MOVK  X11, #0x2117, LSL #16
    MOVK  X11, #0xd817, LSL #32
    MOVK  X11, #0x8d5b, LSL #48
    FMOV  X12, V18.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xfa7, LSL #0
    MOVK  X11, #0xdecb, LSL #16
    MOVK  X11, #0xd59f, LSL #32
    MOVK  X11, #0x18d8, LSL #48
    FMOV  X12, D18
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X12, V19.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X12, D19
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xdde9, LSL #0
    MOVK  X11, #0xb99, LSL #16
    MOVK  X11, #0x6797, LSL #32
    MOVK  X11, #0xc76f, LSL #48
    FMOV  X12, V20.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x29f8, LSL #0
    MOVK  X11, #0xbed9, LSL #16
    MOVK  X11, #0x405f, LSL #32
    MOVK  X11, #0x4509, LSL #48
    FMOV  X12, D20
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xfa48, LSL #0
    MOVK  X11, #0xbcb7, LSL #16
    MOVK  X11, #0x6c60, LSL #32
    MOVK  X11, #0x2691, LSL #48
    FMOV  X12, V21.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x8392, LSL #0
    MOVK  X11, #0xca62, LSL #16
    MOVK  X11, #0xe723, LSL #32
    MOVK  X11, #0xccc2, LSL #48
    FMOV  X12, D21
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa078, LSL #0
    MOVK  X11, #0x1a2a, LSL #16
    MOVK  X11, #0x86fc, LSL #32
    MOVK  X11, #0xbbf8, LSL #48
    FMOV  X12, V22.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x6d04, LSL #0
    MOVK  X11, #0x9d43, LSL #16
    MOVK  X11, #0x4fda, LSL #32
    MOVK  X11, #0x7567, LSL #48
    FMOV  X12, D22
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x3c38, LSL #0
    MOVK  X11, #0xdb4a, LSL #16
    MOVK  X11, #0x5552, LSL #32
    MOVK  X11, #0x6ce7, LSL #48
    FMOV  X12, V23.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x9555, LSL #0
    MOVK  X11, #0x51e0, LSL #16
    MOVK  X11, #0x7cba, LSL #32
    MOVK  X11, #0xac2f, LSL #48
    FMOV  X12, D23
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x4de7, LSL #0
    MOVK  X11, #0xbca8, LSL #16
    MOVK  X11, #0x2222, LSL #32
    MOVK  X11, #0xfc07, LSL #48
    FMOV  X12, V24.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xfaed, LSL #0
    MOVK  X11, #0xc1d8, LSL #16
    MOVK  X11, #0x682d, LSL #32
    MOVK  X11, #0x2215, LSL #48
    FMOV  X12, D24
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xffff, LSL #0
    MOVK  X11, #0xffff, LSL #16
    MOVK  X11, #0xffff, LSL #32
    MOVK  X11, #0xffff, LSL #48
    FMOV  X12, D25
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x707f, LSL #0
    MOVK  X11, #0x9a9f, LSL #16
    MOVK  X11, #0xd167, LSL #32
    MOVK  X11, #0x3b61, LSL #48
    FMOV  X12, V26.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xc716, LSL #0
    MOVK  X11, #0xf0a6, LSL #16
    MOVK  X11, #0x9665, LSL #32
    MOVK  X11, #0xc330, LSL #48
    FMOV  X12, D26
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x1e0a, LSL #0
    MOVK  X11, #0xb641, LSL #16
    MOVK  X11, #0x5b8a, LSL #32
    MOVK  X11, #0x8ba2, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x8258, LSL #0
    MOVK  X11, #0x669, LSL #16
    MOVK  X11, #0x312b, LSL #32
    MOVK  X11, #0x4d02, LSL #48
    FMOV  X12, D27
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x7da4, LSL #0
    MOVK  X11, #0x9d1b, LSL #16
    MOVK  X11, #0xcb6f, LSL #32
    MOVK  X11, #0x999a, LSL #48
    FMOV  X12, V28.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xe881, LSL #0
    MOVK  X11, #0x9bb0, LSL #16
    MOVK  X11, #0x6bcd, LSL #32
    MOVK  X11, #0x975c, LSL #48
    FMOV  X12, D28
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x9fa5, LSL #0
    MOVK  X11, #0xf5cc, LSL #16
    MOVK  X11, #0x9b9b, LSL #32
    MOVK  X11, #0x6cc7, LSL #48
    FMOV  X12, V29.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x6d2f, LSL #0
    MOVK  X11, #0x2686, LSL #16
    MOVK  X11, #0x773a, LSL #32
    MOVK  X11, #0x3fff, LSL #48
    FMOV  X12, D29
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xf32b, LSL #0
    MOVK  X11, #0x5557, LSL #16
    MOVK  X11, #0x6a5e, LSL #32
    MOVK  X11, #0xf46a, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x3db9, LSL #0
    MOVK  X11, #0xe855, LSL #16
    MOVK  X11, #0xf38a, LSL #32
    MOVK  X11, #0xa5cc, LSL #48
    FMOV  X12, D30
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0x22b5, LSL #0
    MOVK  X11, #0x7ea4, LSL #16
    MOVK  X11, #0x8cf3, LSL #32
    MOVK  X11, #0xa855, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X11, #0xa665, LSL #0
    MOVK  X11, #0xabf4, LSL #16
    MOVK  X11, #0x96e2, LSL #32
    MOVK  X11, #0xce21, LSL #48
    FMOV  X12, D31
    SUB  X3, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0xeb68, LSL #0
    MOVK  X2, #0xadff, LSL #16
    MOVK  X2, #0x30bf, LSL #32
    MOVK  X2, #0xb76a, LSL #48
    MOVZ  X3, #0x5326, LSL #0
    MOVK  X3, #0xae24, LSL #16
    MOVK  X3, #0xeebf, LSL #32
    MOVK  X3, #0x9389, LSL #48
    MOVZ  X5, #0x2dcf, LSL #0
    MOVK  X5, #0x1a71, LSL #16
    MOVK  X5, #0xe1ae, LSL #32
    MOVK  X5, #0xec0, LSL #48
    MOVZ  X6, #0x69c7, LSL #0
    MOVK  X6, #0x7420, LSL #16
    MOVK  X6, #0x348e, LSL #32
    MOVK  X6, #0xb061, LSL #48
    MOVZ  X8, #0x7d10, LSL #0
    MOVK  X8, #0xee56, LSL #16
    MOVK  X8, #0xcf96, LSL #32
    MOVK  X8, #0x8443, LSL #48
    MOVZ  X9, #0xd22c, LSL #0
    MOVK  X9, #0x7b44, LSL #16
    MOVK  X9, #0xba7f, LSL #32
    MOVK  X9, #0x7f8e, LSL #48
    MOVZ  X10, #0xe955, LSL #0
    MOVK  X10, #0x33c6, LSL #16
    MOVK  X10, #0x7e2d, LSL #32
    MOVK  X10, #0x22b1, LSL #48
    MOVZ  X11, #0x9038, LSL #0
    MOVK  X11, #0x60c2, LSL #16
    MOVK  X11, #0xcfa1, LSL #32
    MOVK  X11, #0x3f0e, LSL #48
    MOVZ  X12, #0xa75c, LSL #0
    MOVK  X12, #0x6398, LSL #16
    MOVK  X12, #0xfb51, LSL #32
    MOVK  X12, #0x649, LSL #48
    MOVZ  X13, #0x3c4b, LSL #0
    MOVK  X13, #0xd89, LSL #16
    MOVK  X13, #0xc49, LSL #32
    MOVK  X13, #0x11ca, LSL #48
    MOVZ  X14, #0x8f9d, LSL #0
    MOVK  X14, #0x4f10, LSL #16
    MOVK  X14, #0x3383, LSL #32
    MOVK  X14, #0x1bd, LSL #48
    MOVZ  X15, #0x25dc, LSL #0
    MOVK  X15, #0xa586, LSL #16
    MOVK  X15, #0xb1a3, LSL #32
    MOVK  X15, #0x9c95, LSL #48
    MOVZ  X16, #0xfa5b, LSL #0
    MOVK  X16, #0xc36e, LSL #16
    MOVK  X16, #0xb02c, LSL #32
    MOVK  X16, #0x2ef1, LSL #48
    MOVZ  X17, #0x3cdf, LSL #0
    MOVK  X17, #0x936f, LSL #16
    MOVK  X17, #0xb051, LSL #32
    MOVK  X17, #0x51b2, LSL #48
    MOVZ  X18, #0x8f60, LSL #0
    MOVK  X18, #0x8ab, LSL #16
    MOVK  X18, #0x976d, LSL #32
    MOVK  X18, #0xc105, LSL #48
    MOVZ  X19, #0x22eb, LSL #0
    MOVK  X19, #0xd77f, LSL #16
    MOVK  X19, #0xc159, LSL #32
    MOVK  X19, #0x9b83, LSL #48
    MOVZ  X20, #0x3ede, LSL #0
    MOVK  X20, #0x8af2, LSL #16
    MOVK  X20, #0x46d0, LSL #32
    MOVK  X20, #0xc7c3, LSL #48
    MOVZ  X21, #0x3362, LSL #0
    MOVK  X21, #0xe60c, LSL #16
    MOVK  X21, #0xf9cd, LSL #32
    MOVK  X21, #0x9df0, LSL #48
    MOVZ  X22, #0x613d, LSL #0
    MOVK  X22, #0x5325, LSL #16
    MOVK  X22, #0xf89c, LSL #32
    MOVK  X22, #0x7053, LSL #48
    MOVZ  X24, #0xc381, LSL #0
    MOVK  X24, #0x4de4, LSL #16
    MOVK  X24, #0x61e3, LSL #32
    MOVK  X24, #0x9193, LSL #48
    MOVZ  X25, #0xc45c, LSL #0
    MOVK  X25, #0x69c2, LSL #16
    MOVK  X25, #0x1bb0, LSL #32
    MOVK  X25, #0xf34c, LSL #48
    MOVZ  X27, #0xfa6a, LSL #0
    MOVK  X27, #0x2a2a, LSL #16
    MOVK  X27, #0x3373, LSL #32
    MOVK  X27, #0xc44d, LSL #48
    MOVZ  X28, #0x5755, LSL #0
    MOVK  X28, #0x1734, LSL #16
    MOVK  X28, #0xa090, LSL #32
    MOVK  X28, #0xa755, LSL #48
    MOVZ  X29, #0x42b1, LSL #0
    MOVK  X29, #0x8c14, LSL #16
    MOVK  X29, #0x987f, LSL #32
    MOVK  X29, #0x74fe, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X22
    FMOV  V2.D[1], X28
    FMOV  D3, X21
    FMOV  V3.D[1], X27
    FMOV  D4, X29
    FMOV  V4.D[1], X8
    FMOV  D5, X9
    FMOV  V5.D[1], X6
    FMOV  D6, X22
    FMOV  V6.D[1], X13
    FMOV  D7, X21
    FMOV  V7.D[1], X14
    FMOV  D8, X5
    FMOV  V8.D[1], X13
    FMOV  D9, X18
    FMOV  V9.D[1], X13
    FMOV  D10, X5
    FMOV  V10.D[1], X29
    FMOV  D11, X18
    FMOV  V11.D[1], X5
    FMOV  D12, X28
    FMOV  V12.D[1], X20
    FMOV  D13, X19
    FMOV  V13.D[1], X20
    FMOV  D14, X3
    FMOV  V14.D[1], X21
    FMOV  D15, X16
    FMOV  V15.D[1], X14
    FMOV  D16, X2
    FMOV  V16.D[1], X22
    FMOV  D17, X28
    FMOV  V17.D[1], X2
    FMOV  D18, X15
    FMOV  V18.D[1], X9
    FMOV  D19, X29
    FMOV  V19.D[1], X22
    FMOV  D20, X17
    FMOV  V20.D[1], X22
    FMOV  D21, X27
    FMOV  V21.D[1], X24
    FMOV  D22, X17
    FMOV  V22.D[1], X27
    FMOV  D23, X28
    FMOV  V23.D[1], X12
    FMOV  D24, X16
    FMOV  V24.D[1], X3
    FMOV  D25, X14
    FMOV  V25.D[1], X12
    FMOV  D26, X28
    FMOV  V26.D[1], X28
    FMOV  D27, X8
    FMOV  V27.D[1], X9
    FMOV  D28, X27
    FMOV  V28.D[1], X2
    FMOV  D29, X5
    FMOV  V29.D[1], X27
    FMOV  D30, X22
    FMOV  V30.D[1], X11
    FMOV  D31, X19
    FMOV  V31.D[1], X12
    MOVZ  X8, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_18:
    SHA1SU1  V2.4S, V28.4S
    SHA1P  Q19, S20, V31.4S
    SHA256SU1  V15.4S, V21.4S, V21.4S
    SHA256H2  Q17, Q15, V23.4S
    SHA256SU1  V5.4S, V30.4S, V29.4S
    SHA256H2  Q21, Q26, V5.4S
    SHA1P  Q23, S25, V25.4S
    SHA1SU1  V18.4S, V21.4S
    SHA256H  Q26, Q27, V27.4S
    SHA1C  Q24, S17, V26.4S
    SHA256SU0  V0.4S, V2.4S
    SHA1SU0  V11.4S, V0.4S, V0.4S
    SHA256SU1  V16.4S, V19.4S, V11.4S
    SHA1C  Q11, S23, V16.4S
    SHA256H2  Q28, Q24, V24.4S
    SHA256SU0  V21.4S, V18.4S
    SHA256SU1  V15.4S, V11.4S, V11.4S
    SHA256H2  Q27, Q15, V28.4S
    SHA1C  Q25, S27, V5.4S
    SHA1SU1  V30.4S, V25.4S
    SHA256SU0  V26.4S, V30.4S
    SHA1SU0  V29.4S, V26.4S, V21.4S
    SHA1SU1  V11.4S, V31.4S
    SHA1P  Q24, S27, V3.4S
    SHA1SU0  V20.4S, V10.4S, V28.4S
    SHA1P  Q5, S26, V15.4S
    SHA256SU0  V31.4S, V17.4S
    SHA1M  Q28, S0, V12.4S
    SHA256H2  Q15, Q1, V0.4S
    SHA256H2  Q21, Q19, V31.4S
    SHA1M  Q2, S22, V26.4S
    SHA256H2  Q12, Q11, V29.4S
    SHA1P  Q16, S24, V5.4S
    SHA256H2  Q3, Q15, V20.4S
    SHA256H  Q10, Q28, V16.4S
    SHA1SU1  V18.4S, V21.4S
    SHA1C  Q27, S2, V12.4S
    SHA1SU0  V17.4S, V10.4S, V27.4S
    SHA1P  Q24, S3, V17.4S
    SHA1M  Q28, S18, V24.4S
    SHA1M  Q30, S19, V22.4S
    SHA1M  Q31, S24, V31.4S
    SHA1M  Q21, S27, V19.4S
    SHA1C  Q22, S20, V16.4S
    SHA1P  Q20, S14, V23.4S
    SHA1C  Q14, S2, V19.4S
    SHA1SU1  V17.4S, V29.4S
    SHA256SU1  V0.4S, V18.4S, V5.4S
    SHA256SU1  V26.4S, V20.4S, V30.4S
    SHA256SU0  V30.4S, V22.4S
    SHA1SU0  V11.4S, V28.4S, V30.4S
    SHA1SU0  V20.4S, V26.4S, V31.4S
    SHA256H2  Q1, Q21, V20.4S
    SHA256SU1  V3.4S, V1.4S, V11.4S
    SHA1C  Q1, S14, V17.4S
    SHA1M  Q24, S1, V0.4S
    SHA256H  Q21, Q24, V3.4S
    SHA1M  Q27, S0, V16.4S
    SHA1SU1  V5.4S, V6.4S
    SHA1C  Q20, S28, V20.4S
    SHA1SU0  V29.4S, V10.4S, V18.4S
    SHA256SU1  V10.4S, V10.4S, V20.4S
    SHA256SU1  V12.4S, V9.4S, V6.4S
    SHA1C  Q15, S19, V29.4S
    SHA1C  Q25, S28, V2.4S
    SHA256SU0  V18.4S, V25.4S
    SHA1SU1  V19.4S, V4.4S
    SHA1SU0  V16.4S, V30.4S, V28.4S
    SHA1P  Q22, S18, V5.4S
    SHA1M  Q23, S19, V13.4S
    SHA1C  Q2, S21, V12.4S
    SHA1M  Q29, S2, V15.4S
    SHA256SU1  V21.4S, V16.4S, V27.4S
    SHA256H  Q20, Q21, V29.4S
    SHA1M  Q6, S10, V22.4S
    SHA256H2  Q9, Q20, V20.4S
    SHA256SU0  V16.4S, V9.4S
    SHA256SU1  V1.4S, V23.4S, V23.4S
    SHA1SU0  V13.4S, V6.4S, V6.4S
    SHA1SU0  V10.4S, V17.4S, V23.4S
    SHA256H2  Q2, Q10, V16.4S
    SHA256H  Q25, Q13, V1.4S
    SHA1C  Q22, S25, V2.4S
    SHA1C  Q20, S12, V16.4S
    SHA256H  Q0, Q12, V0.4S
    SHA1C  Q24, S29, V7.4S
    SHA256H  Q9, Q20, V1.4S
    SHA1C  Q23, S14, V13.4S
    SHA1P  Q21, S30, V22.4S
    SHA1SU1  V10.4S, V11.4S
    SHA256SU0  V13.4S, V6.4S
    SHA1P  Q17, S17, V21.4S
    SHA1SU0  V21.4S, V14.4S, V12.4S
    SHA1SU0  V11.4S, V8.4S, V0.4S
    SHA1P  Q12, S9, V2.4S
    SHA256H  Q25, Q31, V11.4S
    SHA1SU1  V31.4S, V16.4S
    SHA1SU1  V5.4S, V12.4S
    SHA1M  Q2, S31, V10.4S
    SHA256SU0  V12.4S, V23.4S
    SHA1SU1  V9.4S, V12.4S
    SHA1C  Q23, S24, V25.4S
    SHA256H  Q27, Q13, V2.4S
    SHA256H  Q12, Q27, V21.4S
    SHA1C  Q1, S23, V6.4S
    SHA256H  Q14, Q21, V17.4S
    SHA1SU1  V11.4S, V14.4S
    SHA256SU0  V8.4S, V12.4S
    SHA1SU1  V20.4S, V1.4S
    SHA1P  Q16, S20, V11.4S
    SHA256SU0  V24.4S, V9.4S
    SHA1M  Q31, S5, V16.4S
    SHA256H  Q5, Q31, V24.4S
    SHA1P  Q29, S5, V5.4S
    SHA1P  Q14, S29, V8.4S
    SHA1SU0  V2.4S, V14.4S, V12.4S
    SHA1P  Q12, S18, V16.4S
    SHA1P  Q21, S7, V31.4S
    SHA256SU1  V10.4S, V29.4S, V19.4S
    SHA1P  Q1, S15, V18.4S
    SHA1P  Q0, S8, V13.4S
    SHA1C  Q12, S23, V27.4S
    SHA1SU0  V25.4S, V9.4S, V16.4S
    SHA1C  Q6, S9, V13.4S
    SHA1SU1  V27.4S, V2.4S
    SHA1SU0  V20.4S, V25.4S, V1.4S
    SHA256H2  Q24, Q20, V1.4S
    SHA1M  Q14, S0, V8.4S
    SHA256H2  Q19, Q0, V8.4S
    SHA256SU0  V29.4S, V26.4S
    SHA256H  Q1, Q6, V21.4S
    SHA1C  Q8, S27, V5.4S
    SHA256H  Q2, Q12, V24.4S
    SHA1SU0  V26.4S, V10.4S, V16.4S
    SHA1M  Q27, S14, V26.4S
    SHA1SU1  V13.4S, V2.4S
    SHA1C  Q31, S8, V27.4S
    SHA256H  Q20, Q29, V1.4S
    SHA1C  Q29, S19, V13.4S
    SHA1C  Q1, S29, V31.4S
    SHA256SU1  V8.4S, V1.4S, V1.4S
    SHA1C  Q12, S20, V20.4S
    SHA1P  Q26, S8, V12.4S
    SHA256H  Q7, Q10, V3.4S
    SHA1P  Q10, S25, V16.4S
    SHA256SU1  V1.4S, V20.4S, V1.4S
    SHA256H  Q29, Q12, V6.4S
    SHA256SU0  V3.4S, V31.4S
    SHA1P  Q23, S5, V6.4S
    SHA256SU0  V25.4S, V16.4S
    SHA256H2  Q8, Q0, V26.4S
    SHA1C  Q24, S1, V0.4S
    SHA1SU1  V31.4S, V13.4S
    SHA1C  Q27, S29, V24.4S
    SHA256SU0  V29.4S, V23.4S
    SHA1SU0  V2.4S, V29.4S, V7.4S
    SHA256H  Q20, Q8, V8.4S
    SHA1M  Q1, S25, V25.4S
    SHA1P  Q16, S10, V28.4S
    SHA1P  Q12, S0, V16.4S
    SHA1M  Q19, S20, V1.4S
    SHA1P  Q14, S31, V12.4S
    SHA1M  Q12, S3, V19.4S
    SHA256SU1  V3.4S, V12.4S, V27.4S
    SHA1P  Q6, S2, V2.4S
    SHA1SU1  V22.4S, V14.4S
    SHA256SU1  V10.4S, V3.4S, V22.4S
    SHA1P  Q28, S6, V6.4S
    SHA1SU1  V25.4S, V10.4S
    SHA1M  Q22, S28, V25.4S
    SHA1M  Q13, S5, V5.4S
    SHA256H2  Q14, Q30, V25.4S
    SHA1P  Q7, S3, V22.4S
    SHA256H2  Q26, Q31, V10.4S
    SHA256H2  Q28, Q24, V4.4S
    SHA256H2  Q23, Q8, V25.4S
    SHA256H2  Q6, Q16, V19.4S
    SHA1C  Q8, S6, V1.4S
    SHA256H  Q27, Q31, V5.4S
    SHA1C  Q29, S8, V8.4S
    SHA256SU0  V10.4S, V0.4S
    SHA256SU1  V30.4S, V10.4S, V23.4S
    SHA256SU1  V19.4S, V13.4S, V13.4S
    SHA1SU1  V5.4S, V28.4S
    SHA1C  Q3, S27, V27.4S
    SHA1SU0  V13.4S, V29.4S, V26.4S
    SHA256SU1  V6.4S, V13.4S, V7.4S
    SHA1C  Q22, S14, V3.4S
    SHA1C  Q1, S5, V23.4S
    SHA1P  Q20, S20, V30.4S
    SHA1P  Q31, S1, V22.4S
    SHA1SU1  V14.4S, V6.4S
    SHA256H  Q2, Q20, V31.4S
    SHA256SU1  V25.4S, V14.4S, V19.4S
    SHA1SU1  V27.4S, V2.4S
    SHA1SU0  V26.4S, V27.4S, V25.4S
    SHA256SU0  V30.4S, V21.4S
    SHA1SU1  V1.4S, V26.4S
    SHA256SU1  V16.4S, V21.4S, V16.4S
    SHA1P  Q26, S9, V14.4S
    SUBS  X8, X8, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_18
    MOVZ  X13, #0x5326, LSL #0
    MOVK  X13, #0xae24, LSL #16
    MOVK  X13, #0xeebf, LSL #32
    MOVK  X13, #0x9389, LSL #48
    SUB  X24, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x2dcf, LSL #0
    MOVK  X13, #0x1a71, LSL #16
    MOVK  X13, #0xe1ae, LSL #32
    MOVK  X13, #0xec0, LSL #48
    SUB  X24, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x69c7, LSL #0
    MOVK  X13, #0x7420, LSL #16
    MOVK  X13, #0x348e, LSL #32
    MOVK  X13, #0xb061, LSL #48
    SUB  X24, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    SUB  X24, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xd22c, LSL #0
    MOVK  X13, #0x7b44, LSL #16
    MOVK  X13, #0xba7f, LSL #32
    MOVK  X13, #0x7f8e, LSL #48
    SUB  X24, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xe955, LSL #0
    MOVK  X13, #0x33c6, LSL #16
    MOVK  X13, #0x7e2d, LSL #32
    MOVK  X13, #0x22b1, LSL #48
    SUB  X24, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x9038, LSL #0
    MOVK  X13, #0x60c2, LSL #16
    MOVK  X13, #0xcfa1, LSL #32
    MOVK  X13, #0x3f0e, LSL #48
    SUB  X24, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xa75c, LSL #0
    MOVK  X13, #0x6398, LSL #16
    MOVK  X13, #0xfb51, LSL #32
    MOVK  X13, #0x649, LSL #48
    SUB  X24, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x8f9d, LSL #0
    MOVK  X13, #0x4f10, LSL #16
    MOVK  X13, #0x3383, LSL #32
    MOVK  X13, #0x1bd, LSL #48
    SUB  X24, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x25dc, LSL #0
    MOVK  X13, #0xa586, LSL #16
    MOVK  X13, #0xb1a3, LSL #32
    MOVK  X13, #0x9c95, LSL #48
    SUB  X24, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xfa5b, LSL #0
    MOVK  X13, #0xc36e, LSL #16
    MOVK  X13, #0xb02c, LSL #32
    MOVK  X13, #0x2ef1, LSL #48
    SUB  X24, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x3cdf, LSL #0
    MOVK  X13, #0x936f, LSL #16
    MOVK  X13, #0xb051, LSL #32
    MOVK  X13, #0x51b2, LSL #48
    SUB  X24, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x8f60, LSL #0
    MOVK  X13, #0x8ab, LSL #16
    MOVK  X13, #0x976d, LSL #32
    MOVK  X13, #0xc105, LSL #48
    SUB  X24, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x22eb, LSL #0
    MOVK  X13, #0xd77f, LSL #16
    MOVK  X13, #0xc159, LSL #32
    MOVK  X13, #0x9b83, LSL #48
    SUB  X24, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x3ede, LSL #0
    MOVK  X13, #0x8af2, LSL #16
    MOVK  X13, #0x46d0, LSL #32
    MOVK  X13, #0xc7c3, LSL #48
    SUB  X24, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x3362, LSL #0
    MOVK  X13, #0xe60c, LSL #16
    MOVK  X13, #0xf9cd, LSL #32
    MOVK  X13, #0x9df0, LSL #48
    SUB  X24, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x613d, LSL #0
    MOVK  X13, #0x5325, LSL #16
    MOVK  X13, #0xf89c, LSL #32
    MOVK  X13, #0x7053, LSL #48
    SUB  X24, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xc45c, LSL #0
    MOVK  X13, #0x69c2, LSL #16
    MOVK  X13, #0x1bb0, LSL #32
    MOVK  X13, #0xf34c, LSL #48
    SUB  X24, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xfa6a, LSL #0
    MOVK  X13, #0x2a2a, LSL #16
    MOVK  X13, #0x3373, LSL #32
    MOVK  X13, #0xc44d, LSL #48
    SUB  X24, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x5755, LSL #0
    MOVK  X13, #0x1734, LSL #16
    MOVK  X13, #0xa090, LSL #32
    MOVK  X13, #0xa755, LSL #48
    SUB  X24, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x42b1, LSL #0
    MOVK  X13, #0x8c14, LSL #16
    MOVK  X13, #0x987f, LSL #32
    MOVK  X13, #0x74fe, LSL #48
    SUB  X24, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xef38, LSL #0
    MOVK  X13, #0xf8e, LSL #16
    MOVK  X13, #0xd883, LSL #32
    MOVK  X13, #0xe652, LSL #48
    FMOV  X24, V0.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xa479, LSL #0
    MOVK  X13, #0xb5af, LSL #16
    MOVK  X13, #0x568d, LSL #32
    MOVK  X13, #0x5ee, LSL #48
    FMOV  X24, D0
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xc4e1, LSL #0
    MOVK  X13, #0x2e83, LSL #16
    MOVK  X13, #0xe1df, LSL #32
    MOVK  X13, #0x5967, LSL #48
    FMOV  X24, V1.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xed85, LSL #0
    MOVK  X13, #0xfc2a, LSL #16
    MOVK  X13, #0xaa89, LSL #32
    MOVK  X13, #0x9c40, LSL #48
    FMOV  X24, D1
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x17cf, LSL #0
    MOVK  X13, #0x99d3, LSL #16
    MOVK  X13, #0xd8cb, LSL #32
    MOVK  X13, #0x2ad8, LSL #48
    FMOV  X24, V2.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x7e7e, LSL #0
    MOVK  X13, #0xcad9, LSL #16
    MOVK  X13, #0xc964, LSL #32
    MOVK  X13, #0xe705, LSL #48
    FMOV  X24, D2
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x108a, LSL #0
    MOVK  X13, #0x5de3, LSL #16
    MOVK  X13, #0x8377, LSL #32
    MOVK  X13, #0xcc3, LSL #48
    FMOV  X24, V3.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x1902, LSL #0
    MOVK  X13, #0xb917, LSL #16
    MOVK  X13, #0xa3e4, LSL #32
    MOVK  X13, #0x97cd, LSL #48
    FMOV  X24, D3
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x7d10, LSL #0
    MOVK  X13, #0xee56, LSL #16
    MOVK  X13, #0xcf96, LSL #32
    MOVK  X13, #0x8443, LSL #48
    FMOV  X24, V4.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x42b1, LSL #0
    MOVK  X13, #0x8c14, LSL #16
    MOVK  X13, #0x987f, LSL #32
    MOVK  X13, #0x74fe, LSL #48
    FMOV  X24, D4
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xa967, LSL #0
    MOVK  X13, #0xe3aa, LSL #16
    MOVK  X13, #0x900, LSL #32
    MOVK  X13, #0x22eb, LSL #48
    FMOV  X24, V5.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xcf67, LSL #0
    MOVK  X13, #0x3670, LSL #16
    MOVK  X13, #0x98f, LSL #32
    MOVK  X13, #0xb5f7, LSL #48
    FMOV  X24, D5
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xdf94, LSL #0
    MOVK  X13, #0x1819, LSL #16
    MOVK  X13, #0x3ddf, LSL #32
    MOVK  X13, #0x8702, LSL #48
    FMOV  X24, V6.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xddfb, LSL #0
    MOVK  X13, #0x67de, LSL #16
    MOVK  X13, #0xa2, LSL #32
    MOVK  X13, #0xadaa, LSL #48
    FMOV  X24, D6
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x5425, LSL #0
    MOVK  X13, #0x473, LSL #16
    MOVK  X13, #0x9cb9, LSL #32
    MOVK  X13, #0xa33, LSL #48
    FMOV  X24, V7.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x5868, LSL #0
    MOVK  X13, #0x58f6, LSL #16
    MOVK  X13, #0xc6f2, LSL #32
    MOVK  X13, #0xef0a, LSL #48
    FMOV  X24, D7
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xfeb, LSL #0
    MOVK  X13, #0x7b87, LSL #16
    MOVK  X13, #0xce0, LSL #32
    MOVK  X13, #0xbd61, LSL #48
    FMOV  X24, V8.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x667d, LSL #0
    MOVK  X13, #0xeb10, LSL #16
    MOVK  X13, #0xcd97, LSL #32
    MOVK  X13, #0x98fb, LSL #48
    FMOV  X24, D8
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x2694, LSL #0
    MOVK  X13, #0xe7de, LSL #16
    MOVK  X13, #0x8341, LSL #32
    MOVK  X13, #0x12cd, LSL #48
    FMOV  X24, V9.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x7559, LSL #0
    MOVK  X13, #0x295d, LSL #16
    MOVK  X13, #0xcf1a, LSL #32
    MOVK  X13, #0x318e, LSL #48
    FMOV  X24, D9
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x82ab, LSL #0
    MOVK  X13, #0x4597, LSL #16
    MOVK  X13, #0xcb60, LSL #32
    MOVK  X13, #0xd9b1, LSL #48
    FMOV  X24, V10.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x733a, LSL #0
    MOVK  X13, #0xe465, LSL #16
    MOVK  X13, #0x588a, LSL #32
    MOVK  X13, #0x7902, LSL #48
    FMOV  X24, D10
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xf725, LSL #0
    MOVK  X13, #0x498f, LSL #16
    MOVK  X13, #0xa082, LSL #32
    MOVK  X13, #0xdf1c, LSL #48
    FMOV  X24, V11.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x6535, LSL #0
    MOVK  X13, #0xfe31, LSL #16
    MOVK  X13, #0xf881, LSL #32
    MOVK  X13, #0xd8a6, LSL #48
    FMOV  X24, D11
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x982e, LSL #0
    MOVK  X13, #0xea1a, LSL #16
    MOVK  X13, #0x3d9e, LSL #32
    MOVK  X13, #0xfdad, LSL #48
    FMOV  X24, V12.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x1751, LSL #0
    MOVK  X13, #0x422b, LSL #16
    MOVK  X13, #0xa433, LSL #32
    MOVK  X13, #0x4e98, LSL #48
    FMOV  X24, D12
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xa3ca, LSL #0
    MOVK  X13, #0x908b, LSL #16
    MOVK  X13, #0xf016, LSL #32
    MOVK  X13, #0x4acc, LSL #48
    FMOV  X24, V13.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x18af, LSL #0
    MOVK  X13, #0xae7b, LSL #16
    MOVK  X13, #0x9e7d, LSL #32
    MOVK  X13, #0xdd71, LSL #48
    FMOV  X24, D13
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xcf5f, LSL #0
    MOVK  X13, #0xbbbe, LSL #16
    MOVK  X13, #0x7aa5, LSL #32
    MOVK  X13, #0xdb4c, LSL #48
    FMOV  X24, V14.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x3f02, LSL #0
    MOVK  X13, #0x9206, LSL #16
    MOVK  X13, #0x9c2d, LSL #32
    MOVK  X13, #0xc250, LSL #48
    FMOV  X24, D14
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xff37, LSL #0
    MOVK  X13, #0xed98, LSL #16
    MOVK  X13, #0x6641, LSL #32
    MOVK  X13, #0xd71d, LSL #48
    FMOV  X24, V15.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xde93, LSL #0
    MOVK  X13, #0x3d0, LSL #16
    MOVK  X13, #0x1214, LSL #32
    MOVK  X13, #0xef50, LSL #48
    FMOV  X24, D15
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x4c63, LSL #0
    MOVK  X13, #0xe5e8, LSL #16
    MOVK  X13, #0x1b1, LSL #32
    MOVK  X13, #0x2050, LSL #48
    FMOV  X24, V16.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xbe63, LSL #0
    MOVK  X13, #0x9118, LSL #16
    MOVK  X13, #0x2911, LSL #32
    MOVK  X13, #0x7582, LSL #48
    FMOV  X24, D16
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x900e, LSL #0
    MOVK  X13, #0x1e6d, LSL #16
    MOVK  X13, #0xd424, LSL #32
    MOVK  X13, #0x872c, LSL #48
    FMOV  X24, V17.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x8fbf, LSL #0
    MOVK  X13, #0x1bfd, LSL #16
    MOVK  X13, #0x6e40, LSL #32
    MOVK  X13, #0x52c0, LSL #48
    FMOV  X24, D17
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x61a8, LSL #0
    MOVK  X13, #0xf8e3, LSL #16
    MOVK  X13, #0xe25b, LSL #32
    MOVK  X13, #0x7c4, LSL #48
    FMOV  X24, V18.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xee9b, LSL #0
    MOVK  X13, #0xead6, LSL #16
    MOVK  X13, #0xa1d, LSL #32
    MOVK  X13, #0x5373, LSL #48
    FMOV  X24, D18
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xe0f8, LSL #0
    MOVK  X13, #0xf2e1, LSL #16
    MOVK  X13, #0x6f36, LSL #32
    MOVK  X13, #0xf013, LSL #48
    FMOV  X24, V19.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x3b3b, LSL #0
    MOVK  X13, #0x17c6, LSL #16
    MOVK  X13, #0x2cca, LSL #32
    MOVK  X13, #0x6448, LSL #48
    FMOV  X24, D19
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xad2c, LSL #0
    MOVK  X13, #0x76f4, LSL #16
    MOVK  X13, #0xcc34, LSL #32
    MOVK  X13, #0xeeda, LSL #48
    FMOV  X24, V20.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xabf9, LSL #0
    MOVK  X13, #0xfcc9, LSL #16
    MOVK  X13, #0x259e, LSL #32
    MOVK  X13, #0x84ee, LSL #48
    FMOV  X24, D20
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x1330, LSL #0
    MOVK  X13, #0x775e, LSL #16
    MOVK  X13, #0xf804, LSL #32
    MOVK  X13, #0x7536, LSL #48
    FMOV  X24, V21.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xb848, LSL #0
    MOVK  X13, #0xe82, LSL #16
    MOVK  X13, #0xd59b, LSL #32
    MOVK  X13, #0x534e, LSL #48
    FMOV  X24, D21
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x6554, LSL #0
    MOVK  X13, #0xb047, LSL #16
    MOVK  X13, #0x1829, LSL #32
    MOVK  X13, #0xe3af, LSL #48
    FMOV  X24, V22.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x309c, LSL #0
    MOVK  X13, #0xf94, LSL #16
    MOVK  X13, #0x541f, LSL #32
    MOVK  X13, #0x28d2, LSL #48
    FMOV  X24, D22
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xa0ba, LSL #0
    MOVK  X13, #0xb528, LSL #16
    MOVK  X13, #0x538d, LSL #32
    MOVK  X13, #0x56b2, LSL #48
    FMOV  X24, V23.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xc5b9, LSL #0
    MOVK  X13, #0x11b1, LSL #16
    MOVK  X13, #0xdecd, LSL #32
    MOVK  X13, #0x620c, LSL #48
    FMOV  X24, D23
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x7923, LSL #0
    MOVK  X13, #0x574a, LSL #16
    MOVK  X13, #0x9b6f, LSL #32
    MOVK  X13, #0xa652, LSL #48
    FMOV  X24, V24.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x8205, LSL #0
    MOVK  X13, #0x8496, LSL #16
    MOVK  X13, #0x864a, LSL #32
    MOVK  X13, #0x3fbb, LSL #48
    FMOV  X24, D24
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xdb2b, LSL #0
    MOVK  X13, #0x6303, LSL #16
    MOVK  X13, #0x97d8, LSL #32
    MOVK  X13, #0x530a, LSL #48
    FMOV  X24, V25.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x2e86, LSL #0
    MOVK  X13, #0x7545, LSL #16
    MOVK  X13, #0xbede, LSL #32
    MOVK  X13, #0x269c, LSL #48
    FMOV  X24, D25
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x48ed, LSL #0
    MOVK  X13, #0x40f0, LSL #16
    MOVK  X13, #0x29e0, LSL #32
    MOVK  X13, #0x19e3, LSL #48
    FMOV  X24, V26.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xa9d9, LSL #0
    MOVK  X13, #0x380c, LSL #16
    MOVK  X13, #0xb505, LSL #32
    MOVK  X13, #0x3afe, LSL #48
    FMOV  X24, D26
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x7ef4, LSL #0
    MOVK  X13, #0x7b7f, LSL #16
    MOVK  X13, #0x9487, LSL #32
    MOVK  X13, #0xbc5, LSL #48
    FMOV  X24, V27.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xf727, LSL #0
    MOVK  X13, #0x90a4, LSL #16
    MOVK  X13, #0xa47c, LSL #32
    MOVK  X13, #0x83cd, LSL #48
    FMOV  X24, D27
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xccba, LSL #0
    MOVK  X13, #0x35d1, LSL #16
    MOVK  X13, #0x598, LSL #32
    MOVK  X13, #0x6460, LSL #48
    FMOV  X24, V28.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x4edc, LSL #0
    MOVK  X13, #0x8cc2, LSL #16
    MOVK  X13, #0x28c7, LSL #32
    MOVK  X13, #0x3c9b, LSL #48
    FMOV  X24, D28
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x6f83, LSL #0
    MOVK  X13, #0xfc35, LSL #16
    MOVK  X13, #0x3c54, LSL #32
    MOVK  X13, #0x8ba1, LSL #48
    FMOV  X24, V29.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xeb31, LSL #0
    MOVK  X13, #0x43af, LSL #16
    MOVK  X13, #0x4b86, LSL #32
    MOVK  X13, #0xc1c7, LSL #48
    FMOV  X24, D29
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xaa45, LSL #0
    MOVK  X13, #0xba17, LSL #16
    MOVK  X13, #0xf5fa, LSL #32
    MOVK  X13, #0xa206, LSL #48
    FMOV  X24, V30.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x440e, LSL #0
    MOVK  X13, #0x9e3d, LSL #16
    MOVK  X13, #0x709e, LSL #32
    MOVK  X13, #0x729c, LSL #48
    FMOV  X24, D30
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x3649, LSL #0
    MOVK  X13, #0x8dcb, LSL #16
    MOVK  X13, #0x51e0, LSL #32
    MOVK  X13, #0x56a5, LSL #48
    FMOV  X24, V31.D[1]
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x8f8, LSL #0
    MOVK  X13, #0x2d06, LSL #16
    MOVK  X13, #0x4899, LSL #32
    MOVK  X13, #0xff32, LSL #48
    FMOV  X24, D31
    SUB  X2, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X3, #0x0, LSL #0
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
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x0, LSL #0
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X18
    FMOV  D2, X11
    FMOV  V2.D[1], X27
    FMOV  D3, X22
    FMOV  V3.D[1], X17
    FMOV  D4, X28
    FMOV  V4.D[1], X20
    FMOV  D5, X19
    FMOV  V5.D[1], X21
    FMOV  D6, X16
    FMOV  V6.D[1], X14
    FMOV  D7, X21
    FMOV  V7.D[1], X10
    FMOV  D8, X8
    FMOV  V8.D[1], X29
    FMOV  D9, X24
    FMOV  V9.D[1], X6
    FMOV  D10, X28
    FMOV  V10.D[1], X15
    FMOV  D11, X19
    FMOV  V11.D[1], X27
    FMOV  D12, X6
    FMOV  V12.D[1], X17
    FMOV  D13, X3
    FMOV  V13.D[1], X16
    FMOV  D14, X6
    FMOV  V14.D[1], X18
    FMOV  D15, X22
    FMOV  V15.D[1], X17
    FMOV  D16, X25
    FMOV  V16.D[1], X2
    FMOV  D17, X13
    FMOV  V17.D[1], X28
    FMOV  D18, X29
    FMOV  V18.D[1], X8
    FMOV  D19, X19
    FMOV  V19.D[1], X15
    FMOV  D20, X21
    FMOV  V20.D[1], X27
    FMOV  D21, X20
    FMOV  V21.D[1], X2
    FMOV  D22, X19
    FMOV  V22.D[1], X19
    FMOV  D23, X13
    FMOV  V23.D[1], X5
    FMOV  D24, X9
    FMOV  V24.D[1], X14
    FMOV  D25, X11
    FMOV  V25.D[1], X5
    FMOV  D26, X15
    FMOV  V26.D[1], X18
    FMOV  D27, X17
    FMOV  V27.D[1], X17
    FMOV  D28, X18
    FMOV  V28.D[1], X11
    FMOV  D29, X28
    FMOV  V29.D[1], X29
    FMOV  D30, X29
    FMOV  V30.D[1], X12
    FMOV  D31, X2
    FMOV  V31.D[1], X18
    MOVZ  X24, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_19:
    SHA1SU1  V10.4S, V31.4S
    SHA256H  Q21, Q30, V19.4S
    SHA256H  Q15, Q25, V26.4S
    SHA256H2  Q28, Q29, V21.4S
    SHA1SU1  V8.4S, V15.4S
    SHA256H2  Q23, Q28, V8.4S
    SHA256SU0  V25.4S, V27.4S
    SHA1SU1  V9.4S, V10.4S
    SHA256SU1  V4.4S, V9.4S, V9.4S
    SHA256H  Q19, Q24, V25.4S
    SHA256SU1  V5.4S, V23.4S, V23.4S
    SHA1C  Q10, S4, V4.4S
    SHA256H  Q18, Q10, V19.4S
    SHA1P  Q28, S18, V5.4S
    SHA1P  Q5, S21, V18.4S
    SHA1P  Q31, S10, V6.4S
    SHA256H  Q26, Q18, V26.4S
    SHA1SU0  V23.4S, V29.4S, V1.4S
    SHA1SU1  V2.4S, V31.4S
    SHA1P  Q3, S15, V9.4S
    SHA256SU1  V18.4S, V13.4S, V27.4S
    SHA1SU0  V30.4S, V2.4S, V0.4S
    SHA256H2  Q9, Q3, V31.4S
    SHA1SU0  V8.4S, V22.4S, V30.4S
    SHA1C  Q29, S21, V25.4S
    SHA1C  Q6, S31, V13.4S
    SHA256H  Q19, Q26, V18.4S
    SHA1P  Q31, S8, V28.4S
    SHA256H2  Q18, Q9, V7.4S
    SHA256SU0  V31.4S, V29.4S
    SHA1C  Q4, S19, V18.4S
    SHA1C  Q15, S17, V23.4S
    SHA1SU0  V26.4S, V6.4S, V5.4S
    SHA256SU1  V24.4S, V15.4S, V26.4S
    SHA256SU0  V5.4S, V4.4S
    SHA1SU0  V15.4S, V31.4S, V31.4S
    SHA1SU1  V13.4S, V15.4S
    SHA256H2  Q10, Q13, V5.4S
    SHA1M  Q27, S24, V24.4S
    SHA256H  Q26, Q10, V10.4S
    SHA1M  Q31, S26, V26.4S
    SHA1SU0  V7.4S, V27.4S, V27.4S
    SHA1P  Q13, S7, V7.4S
    SHA256SU1  V6.4S, V31.4S, V13.4S
    SHA1P  Q8, S4, V19.4S
    SHA1P  Q27, S22, V18.4S
    SHA1SU0  V23.4S, V11.4S, V3.4S
    SHA256SU1  V28.4S, V9.4S, V17.4S
    SHA256H2  Q15, Q15, V27.4S
    SHA1P  Q4, S24, V20.4S
    SHA1P  Q5, S30, V27.4S
    SHA1SU0  V17.4S, V25.4S, V10.4S
    SHA1P  Q26, S7, V19.4S
    SHA1C  Q20, S26, V8.4S
    SHA256SU1  V27.4S, V4.4S, V15.4S
    SHA1SU0  V31.4S, V17.4S, V6.4S
    SHA256H  Q4, Q23, V18.4S
    SHA1SU1  V18.4S, V5.4S
    SHA1C  Q8, S18, V28.4S
    SHA256H  Q24, Q8, V8.4S
    SHA1SU0  V15.4S, V24.4S, V4.4S
    SHA1SU0  V23.4S, V31.4S, V20.4S
    SHA256H  Q22, Q23, V23.4S
    SHA256SU1  V31.4S, V27.4S, V27.4S
    SHA256SU1  V9.4S, V31.4S, V15.4S
    SHA1P  Q27, S22, V9.4S
    SHA256H  Q26, Q14, V22.4S
    SHA1P  Q19, S31, V0.4S
    SHA256H2  Q31, Q12, V11.4S
    SHA256H2  Q23, Q8, V29.4S
    SHA1P  Q18, S23, V4.4S
    SHA1M  Q20, S12, V30.4S
    SHA256H2  Q11, Q11, V20.4S
    SHA256SU1  V15.4S, V5.4S, V7.4S
    SHA1SU0  V28.4S, V5.4S, V14.4S
    SHA1M  Q30, S23, V27.4S
    SHA1C  Q29, S16, V19.4S
    SHA256H2  Q7, Q22, V7.4S
    SHA256SU1  V8.4S, V30.4S, V28.4S
    SHA1C  Q24, S12, V31.4S
    SHA1SU0  V16.4S, V8.4S, V19.4S
    SHA1SU0  V5.4S, V4.4S, V11.4S
    SHA256H2  Q11, Q24, V5.4S
    SHA1P  Q27, S16, V29.4S
    SHA256SU1  V5.4S, V18.4S, V26.4S
    SHA256SU1  V9.4S, V15.4S, V22.4S
    SHA1SU1  V0.4S, V27.4S
    SHA1C  Q14, S7, V5.4S
    SHA256H  Q18, Q11, V11.4S
    SHA256SU1  V8.4S, V9.4S, V18.4S
    SHA256H2  Q9, Q8, V0.4S
    SHA1P  Q5, S19, V9.4S
    SHA1P  Q24, S14, V14.4S
    SHA256SU1  V15.4S, V5.4S, V24.4S
    SHA256SU1  V27.4S, V14.4S, V19.4S
    SHA1M  Q22, S15, V2.4S
    SHA1SU1  V0.4S, V26.4S
    SHA1SU0  V2.4S, V12.4S, V15.4S
    SHA256SU1  V28.4S, V30.4S, V8.4S
    SHA1M  Q8, S15, V20.4S
    SHA1SU1  V7.4S, V14.4S
    SHA256SU1  V20.4S, V17.4S, V9.4S
    SHA1M  Q12, S22, V9.4S
    SHA256H  Q29, Q28, V31.4S
    SHA256H  Q23, Q20, V21.4S
    SHA256SU0  V18.4S, V31.4S
    SHA1SU1  V5.4S, V12.4S
    SHA1SU1  V30.4S, V0.4S
    SHA1SU0  V16.4S, V23.4S, V27.4S
    SHA256SU0  V24.4S, V7.4S
    SHA1M  Q7, S24, V18.4S
    SHA1P  Q18, S2, V2.4S
    SHA256H2  Q11, Q18, V30.4S
    SHA1C  Q14, S8, V5.4S
    SHA1M  Q22, S16, V7.4S
    SHA256H2  Q28, Q11, V11.4S
    SHA1SU0  V24.4S, V22.4S, V29.4S
    SHA1M  Q15, S24, V24.4S
    SHA256H2  Q24, Q14, V28.4S
    SHA1P  Q9, S15, V24.4S
    SHA256SU1  V14.4S, V29.4S, V19.4S
    SHA256H  Q7, Q8, V22.4S
    SHA1M  Q2, S13, V6.4S
    SHA1C  Q30, S27, V1.4S
    SHA1P  Q31, S4, V1.4S
    SHA256H  Q23, Q16, V1.4S
    SHA1P  Q16, S24, V23.4S
    SHA1M  Q28, S1, V24.4S
    SHA1SU0  V23.4S, V21.4S, V4.4S
    SHA1SU0  V15.4S, V9.4S, V9.4S
    SHA1SU0  V5.4S, V16.4S, V31.4S
    SHA256H2  Q29, Q14, V5.4S
    SHA256SU0  V27.4S, V29.4S
    SHA256H  Q13, Q23, V4.4S
    SHA1SU0  V1.4S, V2.4S, V28.4S
    SHA1M  Q21, S13, V1.4S
    SHA1SU1  V24.4S, V4.4S
    SHA1P  Q14, S7, V7.4S
    SHA256H2  Q6, Q21, V30.4S
    SHA1M  Q9, S6, V6.4S
    SHA256H  Q22, Q14, V9.4S
    SHA1C  Q2, S27, V24.4S
    SHA1C  Q5, S15, V2.4S
    SHA256SU1  V29.4S, V13.4S, V5.4S
    SHA1P  Q31, S22, V22.4S
    SHA256SU0  V4.4S, V3.4S
    SHA256H  Q16, Q4, V31.4S
    SHA256H2  Q7, Q7, V29.4S
    SHA1SU0  V21.4S, V7.4S, V7.4S
    SHA1P  Q5, S16, V21.4S
    SHA1SU0  V15.4S, V31.4S, V11.4S
    SHA1M  Q13, S31, V1.4S
    SHA1C  Q29, S1, V18.4S
    SHA1P  Q16, S31, V16.4S
    SHA256SU1  V2.4S, V13.4S, V2.4S
    SHA256SU0  V28.4S, V26.4S
    SHA1SU0  V21.4S, V25.4S, V22.4S
    SHA256H  Q3, Q21, V11.4S
    SHA1M  Q30, S2, V16.4S
    SHA1SU1  V27.4S, V27.4S
    SHA1C  Q4, S25, V4.4S
    SHA1C  Q16, S10, V24.4S
    SHA1P  Q2, S30, V5.4S
    SHA256H  Q10, Q29, V2.4S
    SHA256H2  Q26, Q10, V15.4S
    SHA256H2  Q14, Q27, V26.4S
    SHA256H2  Q21, Q10, V14.4S
    SHA256H  Q11, Q4, V4.4S
    SHA1P  Q6, S11, V16.4S
    SHA1SU0  V18.4S, V21.4S, V21.4S
    SHA256SU0  V29.4S, V3.4S
    SHA256SU0  V13.4S, V29.4S
    SHA256H2  Q15, Q13, V6.4S
    SHA1P  Q13, S28, V28.4S
    SHA256SU0  V28.4S, V3.4S
    SHA256H  Q21, Q18, V28.4S
    SHA1P  Q16, S13, V21.4S
    SHA1C  Q21, S31, V15.4S
    SHA256H  Q18, Q21, V16.4S
    SHA256SU0  V31.4S, V13.4S
    SHA1SU1  V4.4S, V27.4S
    SHA1C  Q15, S20, V7.4S
    SHA1M  Q25, S14, V20.4S
    SHA1C  Q5, S25, V17.4S
    SHA1SU1  V29.4S, V6.4S
    SHA1P  Q7, S27, V23.4S
    SHA256SU0  V22.4S, V28.4S
    SHA256H  Q17, Q19, V24.4S
    SHA256H2  Q25, Q17, V15.4S
    SHA256SU1  V3.4S, V18.4S, V7.4S
    SHA256H  Q13, Q23, V3.4S
    SHA1SU1  V15.4S, V28.4S
    SHA1M  Q14, S13, V5.4S
    SHA1SU1  V17.4S, V22.4S
    SHA256SU1  V19.4S, V14.4S, V31.4S
    SHA1SU0  V22.4S, V4.4S, V19.4S
    SHA1M  Q14, S22, V22.4S
    SHA1SU1  V6.4S, V29.4S
    SHA1SU1  V31.4S, V7.4S
    SHA1C  Q27, S6, V31.4S
    SUBS  X24, X24, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_19
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    SUB  X10, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D0
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D1
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D2
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D3
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D4
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D5
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D6
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D7
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D8
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D9
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D10
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D11
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D12
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D13
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D14
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D15
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D16
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D17
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D18
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D19
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D20
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D21
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D22
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D23
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D24
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D25
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D26
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D27
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D28
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D29
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D30
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X10, D31
    SUB  X6, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, TSRTAdvsimdVectorSecureHashStandard_TestFail
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
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X21
    FMOV  V2.D[1], X22
    FMOV  D3, X5
    FMOV  V3.D[1], X5
    FMOV  D4, X3
    FMOV  V4.D[1], X13
    FMOV  D5, X2
    FMOV  V5.D[1], X17
    FMOV  D6, X25
    FMOV  V6.D[1], X24
    FMOV  D7, X14
    FMOV  V7.D[1], X25
    FMOV  D8, X21
    FMOV  V8.D[1], X19
    FMOV  D9, X14
    FMOV  V9.D[1], X21
    FMOV  D10, X6
    FMOV  V10.D[1], X19
    FMOV  D11, X21
    FMOV  V11.D[1], X6
    FMOV  D12, X16
    FMOV  V12.D[1], X27
    FMOV  D13, X3
    FMOV  V13.D[1], X18
    FMOV  D14, X14
    FMOV  V14.D[1], X20
    FMOV  D15, X20
    FMOV  V15.D[1], X28
    FMOV  D16, X5
    FMOV  V16.D[1], X5
    FMOV  D17, X12
    FMOV  V17.D[1], X19
    FMOV  D18, X10
    FMOV  V18.D[1], X12
    FMOV  D19, X24
    FMOV  V19.D[1], X6
    FMOV  D20, X16
    FMOV  V20.D[1], X19
    FMOV  D21, X24
    FMOV  V21.D[1], X13
    FMOV  D22, X27
    FMOV  V22.D[1], X19
    FMOV  D23, X9
    FMOV  V23.D[1], X21
    FMOV  D24, X2
    FMOV  V24.D[1], X20
    FMOV  D25, X20
    FMOV  V25.D[1], X8
    FMOV  D26, X6
    FMOV  V26.D[1], X20
    FMOV  D27, X6
    FMOV  V27.D[1], X2
    FMOV  D28, X2
    FMOV  V28.D[1], X25
    FMOV  D29, X5
    FMOV  V29.D[1], X28
    FMOV  D30, X22
    FMOV  V30.D[1], X24
    FMOV  D31, X19
    FMOV  V31.D[1], X24
    MOVZ  X2, #0xf, LSL #0
TSRTAdvsimdVectorSecureHashStandard_label_20:
    SHA1P  Q8, S24, V22.4S
    SHA256SU1  V7.4S, V26.4S, V31.4S
    SHA1P  Q3, S27, V27.4S
    SHA256H  Q7, Q19, V7.4S
    SHA1P  Q10, S28, V29.4S
    SHA256SU0  V7.4S, V10.4S
    SHA1P  Q0, S3, V25.4S
    SHA1M  Q14, S30, V7.4S
    SHA256SU0  V15.4S, V0.4S
    SHA1M  Q14, S15, V15.4S
    SHA256H  Q10, Q8, V14.4S
    SHA256H  Q3, Q10, V23.4S
    SHA1SU1  V15.4S, V24.4S
    SHA1C  Q24, S22, V7.4S
    SHA256SU0  V8.4S, V18.4S
    SHA256H  Q28, Q18, V10.4S
    SHA256H  Q26, Q10, V26.4S
    SHA256SU1  V30.4S, V29.4S, V28.4S
    SHA1SU1  V14.4S, V2.4S
    SHA1M  Q10, S18, V16.4S
    SHA256SU0  V2.4S, V29.4S
    SHA1C  Q28, S2, V3.4S
    SHA1M  Q7, S26, V20.4S
    SHA256H2  Q27, Q8, V14.4S
    SHA256SU0  V0.4S, V28.4S
    SHA1P  Q14, S24, V27.4S
    SHA256H  Q8, Q7, V10.4S
    SHA256H  Q22, Q8, V0.4S
    SHA1SU0  V8.4S, V15.4S, V30.4S
    SHA1P  Q28, S14, V8.4S
    SHA1P  Q30, S28, V11.4S
    SHA256H  Q15, Q22, V22.4S
    SHA1M  Q18, S31, V30.4S
    SHA1C  Q16, S15, V30.4S
    SHA1M  Q14, S16, V16.4S
    SHA256SU1  V15.4S, V14.4S, V18.4S
    SHA1C  Q22, S30, V6.4S
    SHA1SU1  V24.4S, V2.4S
    SHA256H  Q30, Q13, V24.4S
    SHA256H2  Q2, Q24, V4.4S
    SHA1SU0  V7.4S, V11.4S, V16.4S
    SHA256H2  Q0, Q0, V22.4S
    SHA256SU1  V31.4S, V23.4S, V28.4S
    SHA256SU0  V18.4S, V6.4S
    SHA1SU0  V27.4S, V5.4S, V22.4S
    SHA256H  Q28, Q2, V20.4S
    SHA256H  Q6, Q19, V25.4S
    SHA1C  Q5, S15, V28.4S
    SHA256H  Q22, Q5, V5.4S
    SHA1SU1  V28.4S, V0.4S
    SHA256H  Q13, Q28, V18.4S
    SHA256H2  Q3, Q13, V7.4S
    SHA256H  Q28, Q22, V27.4S
    SHA1C  Q15, S28, V28.4S
    SHA1SU1  V16.4S, V31.4S
    SHA256SU1  V18.4S, V3.4S, V3.4S
    SHA1SU1  V31.4S, V18.4S
    SHA256H2  Q20, Q15, V28.4S
    SHA1C  Q0, S31, V16.4S
    SHA256SU0  V8.4S, V6.4S
    SHA256SU1  V28.4S, V20.4S, V20.4S
    SHA256H  Q5, Q28, V0.4S
    SHA256SU1  V2.4S, V5.4S, V8.4S
    SHA256H  Q25, Q2, V2.4S
    SHA1P  Q6, S25, V25.4S
    SHA256SU1  V5.4S, V6.4S, V6.4S
    SHA256SU1  V19.4S, V5.4S, V5.4S
    SHA1C  Q25, S19, V19.4S
    SHA1SU1  V6.4S, V25.4S
    SHA1P  Q25, S23, V6.4S
    SHA1SU1  V19.4S, V25.4S
    SHA256H2  Q6, Q15, V4.4S
    SHA256SU0  V25.4S, V19.4S
    SHA256H2  Q4, Q13, V3.4S
    SHA1SU0  V16.4S, V4.4S, V27.4S
    SHA1SU0  V23.4S, V9.4S, V1.4S
    SHA1C  Q27, S10, V17.4S
    SHA1SU0  V8.4S, V28.4S, V12.4S
    SHA1M  Q0, S23, V7.4S
    SHA1SU0  V13.4S, V12.4S, V3.4S
    SHA1P  Q31, S17, V3.4S
    SHA256H2  Q18, Q8, V12.4S
    SHA256SU1  V28.4S, V3.4S, V25.4S
    SHA1SU1  V15.4S, V2.4S
    SHA256SU0  V17.4S, V28.4S
    SHA256SU1  V12.4S, V27.4S, V6.4S
    SHA1P  Q20, S12, V17.4S
    SHA256H2  Q12, Q15, V20.4S
    SHA256SU1  V2.4S, V28.4S, V31.4S
    SHA256SU0  V4.4S, V16.4S
    SHA256SU0  V16.4S, V0.4S
    SHA256H2  Q10, Q16, V18.4S
    SHA256H2  Q3, Q13, V13.4S
    SHA256H2  Q20, Q2, V3.4S
    SHA256H  Q13, Q10, V10.4S
    SHA256H2  Q17, Q14, V20.4S
    SHA1M  Q10, S13, V12.4S
    SHA1SU1  V8.4S, V26.4S
    SHA1P  Q16, S4, V4.4S
    SHA256H2  Q1, Q16, V16.4S
    SHA1SU1  V31.4S, V1.4S
    SHA256H2  Q1, Q31, V31.4S
    SHA1SU1  V15.4S, V17.4S
    SHA1SU0  V28.4S, V8.4S, V10.4S
    SHA1SU0  V4.4S, V28.4S, V28.4S
    SHA256H  Q25, Q4, V1.4S
    SHA256H  Q12, Q25, V25.4S
    SHA1M  Q28, S15, V15.4S
    SHA256H2  Q4, Q12, V12.4S
    SHA1P  Q3, S28, V28.4S
    SHA256SU0  V2.4S, V3.4S
    SHA1P  Q31, S31, V4.4S
    SHA256H  Q26, Q2, V31.4S
    SHA256SU0  V1.4S, V20.4S
    SHA256SU1  V13.4S, V21.4S, V5.4S
    SHA1P  Q17, S9, V14.4S
    SHA1SU0  V28.4S, V21.4S, V17.4S
    SHA1SU0  V25.4S, V16.4S, V26.4S
    SHA1SU1  V8.4S, V31.4S
    SHA1SU0  V12.4S, V29.4S, V27.4S
    SHA256H  Q31, Q31, V20.4S
    SHA256SU0  V2.4S, V10.4S
    SHA256H  Q21, Q31, V8.4S
    SHA256SU0  V15.4S, V7.4S
    SHA1P  Q26, S6, V21.4S
    SHA1P  Q5, S25, V22.4S
    SHA256SU1  V29.4S, V8.4S, V31.4S
    SHA256SU0  V16.4S, V1.4S
    SHA1P  Q13, S21, V26.4S
    SHA256SU0  V8.4S, V15.4S
    SHA256H2  Q25, Q28, V13.4S
    SHA1SU1  V6.4S, V16.4S
    SHA1C  Q9, S2, V5.4S
    SHA256H  Q16, Q12, V8.4S
    SHA256SU0  V20.4S, V16.4S
    SHA1C  Q27, S29, V29.4S
    SHA1M  Q31, S20, V18.4S
    SHA1C  Q22, S25, V27.4S
    SHA256SU1  V10.4S, V31.4S, V22.4S
    SHA1SU0  V21.4S, V6.4S, V6.4S
    SHA256SU1  V31.4S, V10.4S, V9.4S
    SHA256SU1  V28.4S, V17.4S, V13.4S
    SHA256SU1  V16.4S, V1.4S, V21.4S
    SHA256SU1  V14.4S, V31.4S, V16.4S
    SHA1C  Q7, S28, V28.4S
    SHA256H2  Q29, Q7, V7.4S
    SHA256H  Q6, Q14, V29.4S
    SHA256H2  Q27, Q15, V28.4S
    SHA256H  Q20, Q1, V8.4S
    SHA1M  Q29, S3, V21.4S
    SHA256SU1  V21.4S, V6.4S, V20.4S
    SHA256SU1  V18.4S, V10.4S, V2.4S
    SHA256H2  Q10, Q16, V15.4S
    SHA1C  Q14, S18, V4.4S
    SHA1SU0  V17.4S, V30.4S, V4.4S
    SHA1P  Q7, S28, V16.4S
    SHA256SU0  V25.4S, V25.4S
    SHA256SU0  V28.4S, V19.4S
    SHA1SU0  V31.4S, V14.4S, V17.4S
    SHA256H  Q13, Q27, V29.4S
    SHA1P  Q3, S21, V13.4S
    SHA1C  Q18, S31, V3.4S
    SHA1SU1  V22.4S, V28.4S
    SHA1C  Q1, S25, V18.4S
    SHA256H  Q19, Q1, V22.4S
    SHA1SU0  V28.4S, V10.4S, V7.4S
    SHA1SU1  V15.4S, V28.4S
    SHA256H  Q31, Q31, V15.4S
    SHA1SU1  V17.4S, V31.4S
    SHA1SU0  V20.4S, V19.4S, V17.4S
    SHA1SU0  V14.4S, V8.4S, V22.4S
    SHA256SU0  V3.4S, V18.4S
    SHA1C  Q21, S21, V5.4S
    SHA1SU1  V13.4S, V22.4S
    SHA1SU1  V4.4S, V29.4S
    SHA256H2  Q25, Q4, V2.4S
    SHA1SU0  V15.4S, V29.4S, V14.4S
    SHA1P  Q8, S14, V27.4S
    SHA1M  Q17, S22, V4.4S
    SHA256H  Q10, Q8, V15.4S
    SHA256SU1  V14.4S, V13.4S, V6.4S
    SHA256H  Q18, Q31, V15.4S
    SHA1C  Q15, S16, V0.4S
    SHA256H  Q8, Q20, V21.4S
    SHA1SU1  V22.4S, V7.4S
    SHA256H  Q5, Q18, V14.4S
    SHA1P  Q18, S5, V27.4S
    SHA256SU1  V1.4S, V18.4S, V10.4S
    SHA256SU1  V2.4S, V3.4S, V25.4S
    SHA256SU1  V28.4S, V8.4S, V17.4S
    SHA1M  Q3, S15, V28.4S
    SHA256SU0  V4.4S, V2.4S
    SHA256H2  Q18, Q22, V4.4S
    SHA256SU1  V14.4S, V18.4S, V3.4S
    SHA1C  Q3, S2, V14.4S
    SHA1M  Q29, S1, V1.4S
    SHA1M  Q7, S3, V3.4S
    SHA256H  Q1, Q29, V7.4S
    SHA1P  Q22, S11, V12.4S
    SHA1C  Q27, S0, V28.4S
    SUBS  X2, X2, #0x1
    B.NE  TSRTAdvsimdVectorSecureHashStandard_label_20
    MOVZ  X13, #0x0, LSL #0
    SUB  X17, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    SUB  X17, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xfc9e, LSL #0
    MOVK  X13, #0x8659, LSL #16
    MOVK  X13, #0x15ae, LSL #32
    MOVK  X13, #0xe170, LSL #48
    FMOV  X17, V0.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x2544, LSL #0
    MOVK  X13, #0xddd7, LSL #16
    MOVK  X13, #0x133a, LSL #32
    MOVK  X13, #0xaa42, LSL #48
    FMOV  X17, D0
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x191, LSL #0
    MOVK  X13, #0x2b7f, LSL #16
    MOVK  X13, #0xcc30, LSL #32
    MOVK  X13, #0x4fc2, LSL #48
    FMOV  X17, V1.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xa635, LSL #0
    MOVK  X13, #0xb0a9, LSL #16
    MOVK  X13, #0xd83e, LSL #32
    MOVK  X13, #0xfb1a, LSL #48
    FMOV  X17, D1
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x3f79, LSL #0
    MOVK  X13, #0x9147, LSL #16
    MOVK  X13, #0xedda, LSL #32
    MOVK  X13, #0x1d11, LSL #48
    FMOV  X17, V2.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x53eb, LSL #0
    MOVK  X13, #0x46fb, LSL #16
    MOVK  X13, #0xa255, LSL #32
    MOVK  X13, #0x6bd6, LSL #48
    FMOV  X17, D2
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xdb7b, LSL #0
    MOVK  X13, #0xc096, LSL #16
    MOVK  X13, #0x676e, LSL #32
    MOVK  X13, #0x7a6d, LSL #48
    FMOV  X17, V3.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xbb5f, LSL #0
    MOVK  X13, #0xd5c8, LSL #16
    MOVK  X13, #0xc37d, LSL #32
    MOVK  X13, #0xa908, LSL #48
    FMOV  X17, D3
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xb266, LSL #0
    MOVK  X13, #0x21c6, LSL #16
    MOVK  X13, #0xbbb4, LSL #32
    MOVK  X13, #0x203c, LSL #48
    FMOV  X17, V4.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x20b9, LSL #0
    MOVK  X13, #0xdb1a, LSL #16
    MOVK  X13, #0x7a6d, LSL #32
    MOVK  X13, #0xb439, LSL #48
    FMOV  X17, D4
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x2495, LSL #0
    MOVK  X13, #0x2e10, LSL #16
    MOVK  X13, #0xe351, LSL #32
    MOVK  X13, #0x6812, LSL #48
    FMOV  X17, V5.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x2b31, LSL #0
    MOVK  X13, #0xfd98, LSL #16
    MOVK  X13, #0x7e2a, LSL #32
    MOVK  X13, #0x2a8f, LSL #48
    FMOV  X17, D5
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x1658, LSL #0
    MOVK  X13, #0x3d75, LSL #16
    MOVK  X13, #0xd3de, LSL #32
    MOVK  X13, #0xceae, LSL #48
    FMOV  X17, V6.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x2ccc, LSL #0
    MOVK  X13, #0xaa38, LSL #16
    MOVK  X13, #0xd1a4, LSL #32
    MOVK  X13, #0xcd1a, LSL #48
    FMOV  X17, D6
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xeb35, LSL #0
    MOVK  X13, #0xb7c4, LSL #16
    MOVK  X13, #0xc62, LSL #32
    MOVK  X13, #0xc1c9, LSL #48
    FMOV  X17, V7.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x5415, LSL #0
    MOVK  X13, #0x5e19, LSL #16
    MOVK  X13, #0xeb3, LSL #32
    MOVK  X13, #0x5ace, LSL #48
    FMOV  X17, D7
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x442b, LSL #0
    MOVK  X13, #0x5fb0, LSL #16
    MOVK  X13, #0xd6a1, LSL #32
    MOVK  X13, #0x5130, LSL #48
    FMOV  X17, V8.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x1e69, LSL #0
    MOVK  X13, #0xe598, LSL #16
    MOVK  X13, #0x3185, LSL #32
    MOVK  X13, #0xd015, LSL #48
    FMOV  X17, D8
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xfdff, LSL #0
    MOVK  X13, #0xb0ac, LSL #16
    MOVK  X13, #0xda17, LSL #32
    MOVK  X13, #0x7384, LSL #48
    FMOV  X17, V9.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x889c, LSL #0
    MOVK  X13, #0x6a, LSL #16
    MOVK  X13, #0xc6af, LSL #32
    MOVK  X13, #0xf944, LSL #48
    FMOV  X17, D9
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xbdbc, LSL #0
    MOVK  X13, #0x6857, LSL #16
    MOVK  X13, #0xef1d, LSL #32
    MOVK  X13, #0x793f, LSL #48
    FMOV  X17, V10.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xc115, LSL #0
    MOVK  X13, #0xc73e, LSL #16
    MOVK  X13, #0x34e2, LSL #32
    MOVK  X13, #0xf563, LSL #48
    FMOV  X17, D10
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X17, V11.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xffff, LSL #0
    MOVK  X13, #0xffff, LSL #16
    MOVK  X13, #0xffff, LSL #32
    MOVK  X13, #0xffff, LSL #48
    FMOV  X17, D11
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xd017, LSL #0
    MOVK  X13, #0x77d2, LSL #16
    MOVK  X13, #0xc096, LSL #32
    MOVK  X13, #0xbb96, LSL #48
    FMOV  X17, V12.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x5743, LSL #0
    MOVK  X13, #0xd0fb, LSL #16
    MOVK  X13, #0xa5ae, LSL #32
    MOVK  X13, #0x4612, LSL #48
    FMOV  X17, D12
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xbbff, LSL #0
    MOVK  X13, #0x3b7f, LSL #16
    MOVK  X13, #0x9db9, LSL #32
    MOVK  X13, #0x8963, LSL #48
    FMOV  X17, V13.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xff83, LSL #0
    MOVK  X13, #0x6d18, LSL #16
    MOVK  X13, #0xdacf, LSL #32
    MOVK  X13, #0x5165, LSL #48
    FMOV  X17, D13
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x5d55, LSL #0
    MOVK  X13, #0xa769, LSL #16
    MOVK  X13, #0xd0b1, LSL #32
    MOVK  X13, #0x3c06, LSL #48
    FMOV  X17, V14.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xb0d2, LSL #0
    MOVK  X13, #0x354b, LSL #16
    MOVK  X13, #0xfae3, LSL #32
    MOVK  X13, #0xdd25, LSL #48
    FMOV  X17, D14
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xe503, LSL #0
    MOVK  X13, #0x6e46, LSL #16
    MOVK  X13, #0x5ddd, LSL #32
    MOVK  X13, #0x3c2, LSL #48
    FMOV  X17, V15.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x44c8, LSL #0
    MOVK  X13, #0x582b, LSL #16
    MOVK  X13, #0xe19d, LSL #32
    MOVK  X13, #0x3339, LSL #48
    FMOV  X17, D15
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x6d63, LSL #0
    MOVK  X13, #0x7a79, LSL #16
    MOVK  X13, #0x6ae2, LSL #32
    MOVK  X13, #0xe81b, LSL #48
    FMOV  X17, V16.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x51a4, LSL #0
    MOVK  X13, #0xa97e, LSL #16
    MOVK  X13, #0x2424, LSL #32
    MOVK  X13, #0x5cf2, LSL #48
    FMOV  X17, D16
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x6a3b, LSL #0
    MOVK  X13, #0xbb7e, LSL #16
    MOVK  X13, #0x5656, LSL #32
    MOVK  X13, #0x4b63, LSL #48
    FMOV  X17, V17.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xbb15, LSL #0
    MOVK  X13, #0x73a2, LSL #16
    MOVK  X13, #0x2713, LSL #32
    MOVK  X13, #0x61b2, LSL #48
    FMOV  X17, D17
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x5f57, LSL #0
    MOVK  X13, #0x70b8, LSL #16
    MOVK  X13, #0xef75, LSL #32
    MOVK  X13, #0x9eb3, LSL #48
    FMOV  X17, V18.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x9807, LSL #0
    MOVK  X13, #0x1280, LSL #16
    MOVK  X13, #0xf1, LSL #32
    MOVK  X13, #0x81b7, LSL #48
    FMOV  X17, D18
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x16c1, LSL #0
    MOVK  X13, #0xf4e1, LSL #16
    MOVK  X13, #0x85, LSL #32
    MOVK  X13, #0xbba9, LSL #48
    FMOV  X17, V19.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xc0e, LSL #0
    MOVK  X13, #0x67b4, LSL #16
    MOVK  X13, #0x3704, LSL #32
    MOVK  X13, #0x1e1a, LSL #48
    FMOV  X17, D19
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x3656, LSL #0
    MOVK  X13, #0x4e85, LSL #16
    MOVK  X13, #0xb2a0, LSL #32
    MOVK  X13, #0xd530, LSL #48
    FMOV  X17, V20.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x1fd4, LSL #0
    MOVK  X13, #0xddaf, LSL #16
    MOVK  X13, #0xdf4b, LSL #32
    MOVK  X13, #0x493d, LSL #48
    FMOV  X17, D20
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xdab1, LSL #0
    MOVK  X13, #0x201, LSL #16
    MOVK  X13, #0xac0e, LSL #32
    MOVK  X13, #0x2d6c, LSL #48
    FMOV  X17, V21.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xcb09, LSL #0
    MOVK  X13, #0x6019, LSL #16
    MOVK  X13, #0xdcb5, LSL #32
    MOVK  X13, #0x38e6, LSL #48
    FMOV  X17, D21
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x4fa4, LSL #0
    MOVK  X13, #0x94ce, LSL #16
    MOVK  X13, #0xd301, LSL #32
    MOVK  X13, #0x6ac7, LSL #48
    FMOV  X17, V22.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xa75d, LSL #0
    MOVK  X13, #0xe3ae, LSL #16
    MOVK  X13, #0xc392, LSL #32
    MOVK  X13, #0x1296, LSL #48
    FMOV  X17, D22
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x3da3, LSL #0
    MOVK  X13, #0x9af9, LSL #16
    MOVK  X13, #0x6f83, LSL #32
    MOVK  X13, #0xe3c6, LSL #48
    FMOV  X17, V23.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x7380, LSL #0
    MOVK  X13, #0x383a, LSL #16
    MOVK  X13, #0xc95c, LSL #32
    MOVK  X13, #0x3bbf, LSL #48
    FMOV  X17, D23
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x44dc, LSL #0
    MOVK  X13, #0x3d15, LSL #16
    MOVK  X13, #0x51d0, LSL #32
    MOVK  X13, #0x9a31, LSL #48
    FMOV  X17, V24.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xceb6, LSL #0
    MOVK  X13, #0x9033, LSL #16
    MOVK  X13, #0xa1a7, LSL #32
    MOVK  X13, #0xe830, LSL #48
    FMOV  X17, D24
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x94d7, LSL #0
    MOVK  X13, #0xa6d3, LSL #16
    MOVK  X13, #0xbd1d, LSL #32
    MOVK  X13, #0xc3ed, LSL #48
    FMOV  X17, V25.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x908, LSL #0
    MOVK  X13, #0x7d64, LSL #16
    MOVK  X13, #0xcd9c, LSL #32
    MOVK  X13, #0xf86d, LSL #48
    FMOV  X17, D25
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x536c, LSL #0
    MOVK  X13, #0xbb5, LSL #16
    MOVK  X13, #0x309f, LSL #32
    MOVK  X13, #0xb5f6, LSL #48
    FMOV  X17, V26.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x4a8f, LSL #0
    MOVK  X13, #0x345b, LSL #16
    MOVK  X13, #0x5972, LSL #32
    MOVK  X13, #0x371, LSL #48
    FMOV  X17, D26
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x8d1e, LSL #0
    MOVK  X13, #0x5898, LSL #16
    MOVK  X13, #0x133f, LSL #32
    MOVK  X13, #0xd7d6, LSL #48
    FMOV  X17, V27.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x5740, LSL #0
    MOVK  X13, #0x737a, LSL #16
    MOVK  X13, #0xfd6d, LSL #32
    MOVK  X13, #0xb25c, LSL #48
    FMOV  X17, D27
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xef07, LSL #0
    MOVK  X13, #0x84d7, LSL #16
    MOVK  X13, #0x6b7b, LSL #32
    MOVK  X13, #0x604d, LSL #48
    FMOV  X17, V28.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x4ecf, LSL #0
    MOVK  X13, #0x3381, LSL #16
    MOVK  X13, #0x52d0, LSL #32
    MOVK  X13, #0xe41d, LSL #48
    FMOV  X17, D28
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xa089, LSL #0
    MOVK  X13, #0x9644, LSL #16
    MOVK  X13, #0x5f3c, LSL #32
    MOVK  X13, #0xc347, LSL #48
    FMOV  X17, V29.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x7eca, LSL #0
    MOVK  X13, #0x61b6, LSL #16
    MOVK  X13, #0x1323, LSL #32
    MOVK  X13, #0x83f6, LSL #48
    FMOV  X17, D29
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x1430, LSL #0
    MOVK  X13, #0xbfaa, LSL #16
    MOVK  X13, #0x6b32, LSL #32
    MOVK  X13, #0x9115, LSL #48
    FMOV  X17, V30.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0x959d, LSL #0
    MOVK  X13, #0x998c, LSL #16
    MOVK  X13, #0x969d, LSL #32
    MOVK  X13, #0x4b1f, LSL #48
    FMOV  X17, D30
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xbce4, LSL #0
    MOVK  X13, #0x3ee0, LSL #16
    MOVK  X13, #0x2759, LSL #32
    MOVK  X13, #0x5b41, LSL #48
    FMOV  X17, V31.D[1]
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail
    MOVZ  X13, #0xb6ac, LSL #0
    MOVK  X13, #0x3819, LSL #16
    MOVK  X13, #0x1568, LSL #32
    MOVK  X13, #0x4592, LSL #48
    FMOV  X17, D31
    SUB  X27, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, TSRTAdvsimdVectorSecureHashStandard_TestFail

TSRTAdvsimdVectorSecureHashStandard_TestEnd:
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
TSRTAdvsimdVectorSecureHashStandard_TestFail:
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
