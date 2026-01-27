.global DataReverseAdvsimdVectorP01

.text
.p2align 4

DataReverseAdvsimdVectorP01:

DataReverseAdvsimdVectorP01_TestBegin:
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
    MOVZ  X2, #0x8843, LSL #0
    MOVK  X2, #0x3627, LSL #16
    MOVK  X2, #0xdde8, LSL #32
    MOVK  X2, #0x9d00, LSL #48
    MOVZ  X3, #0x279, LSL #0
    MOVK  X3, #0x6c78, LSL #16
    MOVK  X3, #0xad06, LSL #32
    MOVK  X3, #0x4f47, LSL #48
    MOVZ  X4, #0x8f69, LSL #0
    MOVK  X4, #0xe02b, LSL #16
    MOVK  X4, #0x978d, LSL #32
    MOVK  X4, #0x6e25, LSL #48
    MOVZ  X5, #0x19c2, LSL #0
    MOVK  X5, #0x7eae, LSL #16
    MOVK  X5, #0x387, LSL #32
    MOVK  X5, #0x4d6, LSL #48
    MOVZ  X6, #0x6fc1, LSL #0
    MOVK  X6, #0x5444, LSL #16
    MOVK  X6, #0x66b5, LSL #32
    MOVK  X6, #0x9f2e, LSL #48
    MOVZ  X7, #0x26e3, LSL #0
    MOVK  X7, #0x14c0, LSL #16
    MOVK  X7, #0xedc6, LSL #32
    MOVK  X7, #0x7dea, LSL #48
    MOVZ  X8, #0xed6c, LSL #0
    MOVK  X8, #0x1ad5, LSL #16
    MOVK  X8, #0x9f13, LSL #32
    MOVK  X8, #0xf63b, LSL #48
    MOVZ  X9, #0xd21e, LSL #0
    MOVK  X9, #0xc4, LSL #16
    MOVK  X9, #0xaafa, LSL #32
    MOVK  X9, #0x3a7a, LSL #48
    MOVZ  X10, #0xcf3, LSL #0
    MOVK  X10, #0x2be8, LSL #16
    MOVK  X10, #0xa427, LSL #32
    MOVK  X10, #0x9d55, LSL #48
    MOVZ  X11, #0xba60, LSL #0
    MOVK  X11, #0xe520, LSL #16
    MOVK  X11, #0x4376, LSL #32
    MOVK  X11, #0x8aaa, LSL #48
    MOVZ  X12, #0x866f, LSL #0
    MOVK  X12, #0x3452, LSL #16
    MOVK  X12, #0xfc1e, LSL #32
    MOVK  X12, #0xd988, LSL #48
    MOVZ  X13, #0x923a, LSL #0
    MOVK  X13, #0xfc42, LSL #16
    MOVK  X13, #0x1736, LSL #32
    MOVK  X13, #0x7ec6, LSL #48
    MOVZ  X16, #0x41d4, LSL #0
    MOVK  X16, #0x1d66, LSL #16
    MOVK  X16, #0xc803, LSL #32
    MOVK  X16, #0x866, LSL #48
    MOVZ  X17, #0x26c7, LSL #0
    MOVK  X17, #0x5259, LSL #16
    MOVK  X17, #0xf4cb, LSL #32
    MOVK  X17, #0xdf74, LSL #48
    MOVZ  X18, #0x5dec, LSL #0
    MOVK  X18, #0x3eb8, LSL #16
    MOVK  X18, #0xa540, LSL #32
    MOVK  X18, #0x96d9, LSL #48
    MOVZ  X19, #0x6be0, LSL #0
    MOVK  X19, #0xe515, LSL #16
    MOVK  X19, #0x6576, LSL #32
    MOVK  X19, #0x8e97, LSL #48
    MOVZ  X20, #0x46fa, LSL #0
    MOVK  X20, #0x59d8, LSL #16
    MOVK  X20, #0x2da8, LSL #32
    MOVK  X20, #0xf906, LSL #48
    MOVZ  X21, #0xc641, LSL #0
    MOVK  X21, #0xa8a1, LSL #16
    MOVK  X21, #0x1ff6, LSL #32
    MOVK  X21, #0x36b8, LSL #48
    MOVZ  X23, #0x6383, LSL #0
    MOVK  X23, #0xd3b8, LSL #16
    MOVK  X23, #0x9103, LSL #32
    MOVK  X23, #0xd018, LSL #48
    MOVZ  X24, #0x2ad3, LSL #0
    MOVK  X24, #0xb177, LSL #16
    MOVK  X24, #0xf832, LSL #32
    MOVK  X24, #0x366d, LSL #48
    MOVZ  X25, #0xbec2, LSL #0
    MOVK  X25, #0x9bd5, LSL #16
    MOVK  X25, #0x7762, LSL #32
    MOVK  X25, #0xf447, LSL #48
    MOVZ  X26, #0x1fdb, LSL #0
    MOVK  X26, #0xe560, LSL #16
    MOVK  X26, #0x981e, LSL #32
    MOVK  X26, #0x2498, LSL #48
    MOVZ  X27, #0x8ada, LSL #0
    MOVK  X27, #0xe187, LSL #16
    MOVK  X27, #0x6201, LSL #32
    MOVK  X27, #0x495b, LSL #48
    MOVZ  X29, #0x5802, LSL #0
    MOVK  X29, #0x9c30, LSL #16
    MOVK  X29, #0x3511, LSL #32
    MOVK  X29, #0x24b2, LSL #48
    MOVZ  X18, #0x4d81, LSL #0
    MOVK  X18, #0xf108, LSL #16
    MOVK  X18, #0xaa09, LSL #32
    MOVK  X18, #0x57a3, LSL #48
    MSR  FPCR, X18
    MOVZ  X18, #0xee01, LSL #0
    MOVK  X18, #0xc30f, LSL #16
    MOVK  X18, #0xbd88, LSL #32
    MOVK  X18, #0x4567, LSL #48
    MSR  FPSR, X18
    MRS  X8, FPSR
    MOVZ  X7, #0xff60, LSL #0
    MOVK  X7, #0x7ff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    AND  X8, X8, X7
    MOVZ  X7, #0x0, LSL #0
    ORR  X8, X8, X7
    MSR  FPSR, X8
    ISB  SY
    SUBS  X29, X17, X12, ASR #12
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X21
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X7
    FMOV  D3, X26
    FMOV  V3.D[1], X8
    FMOV  D4, X10
    FMOV  V4.D[1], X13
    FMOV  D5, X24
    FMOV  V5.D[1], X16
    FMOV  D6, X2
    FMOV  V6.D[1], X16
    FMOV  D7, X19
    FMOV  V7.D[1], X8
    FMOV  D8, X3
    FMOV  V8.D[1], X18
    FMOV  D9, X16
    FMOV  V9.D[1], X13
    FMOV  D10, X4
    FMOV  V10.D[1], X12
    FMOV  D11, X19
    FMOV  V11.D[1], X7
    FMOV  D12, X25
    FMOV  V12.D[1], X17
    FMOV  D13, X7
    FMOV  V13.D[1], X6
    FMOV  D14, X3
    FMOV  V14.D[1], X6
    FMOV  D15, X12
    FMOV  V15.D[1], X24
    FMOV  D16, X25
    FMOV  V16.D[1], X10
    FMOV  D17, X19
    FMOV  V17.D[1], X24
    FMOV  D18, X3
    FMOV  V18.D[1], X3
    FMOV  D19, X18
    FMOV  V19.D[1], X19
    FMOV  D20, X11
    FMOV  V20.D[1], X11
    FMOV  D21, X25
    FMOV  V21.D[1], X9
    FMOV  D22, X29
    FMOV  V22.D[1], X26
    FMOV  D23, X29
    FMOV  V23.D[1], X8
    FMOV  D24, X18
    FMOV  V24.D[1], X2
    FMOV  D25, X27
    FMOV  V25.D[1], X25
    FMOV  D26, X23
    FMOV  V26.D[1], X12
    FMOV  D27, X8
    FMOV  V27.D[1], X2
    FMOV  D28, X6
    FMOV  V28.D[1], X16
    FMOV  D29, X24
    FMOV  V29.D[1], X5
    FMOV  D30, X4
    FMOV  V30.D[1], X12
    FMOV  D31, X7
    FMOV  V31.D[1], X26
    ABS  V18.2D, V25.2D
    ADD  V27.16B, V20.16B, V19.16B
    ADDHN  V12.8B, V23.8H, V23.8H
    ADDHN2  V5.4S, V30.2D, V5.2D
    ADDP  D16, V24.2D
    ADDP  V6.8B, V31.8B, V26.8B
    ADDV  B2, V25.16B
    ADDV  H15, V29.8H
    ADDV  S0, V22.4S
    AESD  V24.16B, V28.16B
    AESE  V29.16B, V17.16B
    AESIMC  V19.16B, V13.16B
    AESMC  V14.16B, V23.16B
    AND  V13.16B, V17.16B, V22.16B
    BIC  V9.4H, #0xe6
    BIC  V30.2S, #0xba, LSL #16
    BIC  V25.8B, V10.8B, V25.8B
    BIF  V26.16B, V31.16B, V7.16B
    BIT  V20.16B, V8.16B, V10.16B
    BSL  V23.8B, V22.8B, V22.8B
    CLS  V28.2S, V3.2S
    CLZ  V21.2S, V17.2S
    CNT  V4.16B, V3.16B
    DUP B10, V10.B[0x0]
    DUP D17, V11.D[0x1]
    DUP H3, V22.H[0x6]
    DUP S7, V11.S[0x3]
    DUP  V8.16B, V31.B[0x6]
    DUP V1.2D, V1.D[0x1]
    DUP  V31.8H, V11.H[0x4]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x6968, LSL #0
    MOVK  X20, #0x6969, LSL #16
    FMOV  X21, D0
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V2.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa0, LSL #0
    FMOV  X21, D2
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    FMOV  X21, D3
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x404, LSL #0
    MOVK  X20, #0x404, LSL #16
    MOVK  X20, #0x404, LSL #32
    MOVK  X20, #0x404, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x404, LSL #0
    MOVK  X20, #0x404, LSL #16
    MOVK  X20, #0x404, LSL #32
    MOVK  X20, #0x404, LSL #48
    FMOV  X21, D4
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b4, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb4b4, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, V5.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D5
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b4, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb4b4, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, D6
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    FMOV  X21, D7
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a18, LSL #0
    MOVK  X20, #0x5a18, LSL #16
    MOVK  X20, #0x5a18, LSL #32
    MOVK  X20, #0x5a18, LSL #48
    FMOV  X21, D9
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a, LSL #0
    FMOV  X21, D10
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V11.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D11
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b4, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb4b4, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, D12
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V13.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xd2d0, LSL #0
    FMOV  X21, D15
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b4, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb4b4, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, D16
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D17
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V20.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x1, LSL #0
    MOVK  X20, #0x1, LSL #32
    FMOV  X21, D21
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V22.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5252, LSL #0
    MOVK  X20, #0x5252, LSL #16
    MOVK  X20, #0x5252, LSL #32
    MOVK  X20, #0x5252, LSL #48
    FMOV  X21, V24.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5252, LSL #0
    MOVK  X20, #0x5252, LSL #16
    MOVK  X20, #0x5252, LSL #32
    MOVK  X20, #0x5252, LSL #48
    FMOV  X21, D24
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D25
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V26.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b4, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb4b4, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, V27.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b4, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb4b4, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, D27
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D28
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x6363, LSL #0
    MOVK  X20, #0x6363, LSL #16
    MOVK  X20, #0x6363, LSL #32
    MOVK  X20, #0x6363, LSL #48
    FMOV  X21, V29.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x6363, LSL #0
    MOVK  X20, #0x6363, LSL #16
    MOVK  X20, #0x6363, LSL #32
    MOVK  X20, #0x6363, LSL #48
    FMOV  X21, D29
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a40, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a40, LSL #48
    FMOV  X21, D30
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X19
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X25
    FMOV  V2.D[1], X26
    FMOV  D3, X17
    FMOV  V3.D[1], X3
    FMOV  D4, X18
    FMOV  V4.D[1], X7
    FMOV  D5, X7
    FMOV  V5.D[1], X19
    FMOV  D6, X7
    FMOV  V6.D[1], X11
    FMOV  D7, X19
    FMOV  V7.D[1], X29
    FMOV  D8, X23
    FMOV  V8.D[1], X9
    FMOV  D9, X29
    FMOV  V9.D[1], X12
    FMOV  D10, X12
    FMOV  V10.D[1], X18
    FMOV  D11, X11
    FMOV  V11.D[1], X7
    FMOV  D12, X5
    FMOV  V12.D[1], X18
    FMOV  D13, X29
    FMOV  V13.D[1], X9
    FMOV  D14, X11
    FMOV  V14.D[1], X12
    FMOV  D15, X9
    FMOV  V15.D[1], X17
    FMOV  D16, X9
    FMOV  V16.D[1], X11
    FMOV  D17, X25
    FMOV  V17.D[1], X10
    FMOV  D18, X7
    FMOV  V18.D[1], X7
    FMOV  D19, X26
    FMOV  V19.D[1], X25
    FMOV  D20, X23
    FMOV  V20.D[1], X5
    FMOV  D21, X18
    FMOV  V21.D[1], X26
    FMOV  D22, X25
    FMOV  V22.D[1], X26
    FMOV  D23, X29
    FMOV  V23.D[1], X4
    FMOV  D24, X10
    FMOV  V24.D[1], X25
    FMOV  D25, X2
    FMOV  V25.D[1], X26
    FMOV  D26, X2
    FMOV  V26.D[1], X11
    FMOV  D27, X2
    FMOV  V27.D[1], X3
    FMOV  D28, X3
    FMOV  V28.D[1], X10
    FMOV  D29, X26
    FMOV  V29.D[1], X7
    FMOV  D30, X11
    FMOV  V30.D[1], X29
    FMOV  D31, X18
    FMOV  V31.D[1], X29
    DUP V8.8B, W5
    DUP V16.2D, X12
    DUP V13.8H, W10
    DUP V11.2S, W7
    EOR  V22.16B, V5.16B, V28.16B
    EXT  V28.16B, V19.16B, V31.16B, #0x4
    EXT  V7.8B, V27.8B, V30.8B, #0x4
    SUB  V5.2D, V25.2D, V26.2D
    SUBHN  V0.8B, V29.8H, V29.8H
    SUBHN2  V26.4S, V23.2D, V6.2D
    TRN1  V23.4H, V10.4H, V24.4H
    TRN2  V24.2D, V3.2D, V19.2D
    UZP1  V29.4H, V30.4H, V12.4H
    UZP2  V21.4H, V25.4H, V3.4H
    XTN  V1.4H, V25.4S
    XTN2  V2.16B, V18.8H
    ZIP1  V20.2S, V18.2S, V31.2S
    ZIP2  V9.2S, V4.2S, V30.2S
    INS V31.B[0x1], V30.B[0x2]
    INS V4.D[0x1], V14.D[0x1]
    INS V6.H[0x3], V19.H[0x0]
    INS V25.S[0x0], V15.S[0x2]
    INS V15.B[0x1], W10
    INS V12.D[0x1], X13
    INS V27.H[0x0], W11
    INS V17.S[0x2], W25
    MLA  V3.8H, V3.8H, V3.H[0x3]
    MLA  V18.4S, V10.4S, V19.S[0x2]
    MLA  V30.16B, V10.16B, V10.16B
    MLS  V10.8H, V19.8H, V10.H[0x0]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D0
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xc1fe, LSL #0
    MOVK  X20, #0xc1fe, LSL #16
    MOVK  X20, #0xc1fe, LSL #32
    MOVK  X20, #0xc1fe, LSL #48
    FMOV  X21, V3.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xc1fe, LSL #0
    MOVK  X20, #0xc1fe, LSL #16
    MOVK  X20, #0xc1fe, LSL #32
    MOVK  X20, #0xc1fe, LSL #48
    FMOV  X21, D3
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D5
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D6
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xf2b6, LSL #0
    MOVK  X20, #0xf2b6, LSL #16
    MOVK  X20, #0xf2b6, LSL #32
    MOVK  X20, #0xf2b6, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xf2b6, LSL #0
    MOVK  X20, #0xf2b6, LSL #16
    MOVK  X20, #0xf2b6, LSL #32
    MOVK  X20, #0xf2b6, LSL #48
    FMOV  X21, D10
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D11
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V12.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V13.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V15.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V16.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D16
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D17
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xc1fe, LSL #0
    MOVK  X20, #0x4985, LSL #16
    MOVK  X20, #0xc1fe, LSL #32
    MOVK  X20, #0x4985, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xc1fe, LSL #0
    MOVK  X20, #0x4985, LSL #16
    MOVK  X20, #0xc1fe, LSL #32
    MOVK  X20, #0x4985, LSL #48
    FMOV  X21, D18
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D22
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V24.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D24
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V25.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D25
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V27.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xfefe, LSL #0
    MOVK  X20, #0xfefe, LSL #16
    MOVK  X20, #0xfefe, LSL #32
    MOVK  X20, #0xfefe, LSL #48
    FMOV  X21, V30.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xfefe, LSL #0
    MOVK  X20, #0xfefe, LSL #16
    MOVK  X20, #0xfefe, LSL #32
    MOVK  X20, #0xfefe, LSL #48
    FMOV  X21, D30
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X18
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X25
    FMOV  D3, X17
    FMOV  V3.D[1], X12
    FMOV  D4, X5
    FMOV  V4.D[1], X11
    FMOV  D5, X7
    FMOV  V5.D[1], X19
    FMOV  D6, X11
    FMOV  V6.D[1], X13
    FMOV  D7, X9
    FMOV  V7.D[1], X7
    FMOV  D8, X9
    FMOV  V8.D[1], X19
    FMOV  D9, X18
    FMOV  V9.D[1], X27
    FMOV  D10, X27
    FMOV  V10.D[1], X3
    FMOV  D11, X17
    FMOV  V11.D[1], X17
    FMOV  D12, X3
    FMOV  V12.D[1], X25
    FMOV  D13, X2
    FMOV  V13.D[1], X7
    FMOV  D14, X25
    FMOV  V14.D[1], X6
    FMOV  D15, X4
    FMOV  V15.D[1], X3
    FMOV  D16, X4
    FMOV  V16.D[1], X23
    FMOV  D17, X6
    FMOV  V17.D[1], X25
    FMOV  D18, X3
    FMOV  V18.D[1], X17
    FMOV  D19, X3
    FMOV  V19.D[1], X16
    FMOV  D20, X10
    FMOV  V20.D[1], X5
    FMOV  D21, X12
    FMOV  V21.D[1], X12
    FMOV  D22, X11
    FMOV  V22.D[1], X2
    FMOV  D23, X16
    FMOV  V23.D[1], X13
    FMOV  D24, X9
    FMOV  V24.D[1], X29
    FMOV  D25, X25
    FMOV  V25.D[1], X12
    FMOV  D26, X16
    FMOV  V26.D[1], X25
    FMOV  D27, X19
    FMOV  V27.D[1], X4
    FMOV  D28, X7
    FMOV  V28.D[1], X12
    FMOV  D29, X12
    FMOV  V29.D[1], X24
    FMOV  D30, X16
    FMOV  V30.D[1], X6
    FMOV  D31, X19
    FMOV  V31.D[1], X2
    MLS  V20.8H, V31.8H, V23.8H
    MOV V15.B[0x7], V26.B[0x5]
    MOV V28.D[0x0], V24.D[0x1]
    MOV V2.H[0x2], V23.H[0x3]
    MOV V4.S[0x3], V29.S[0x0]
    MOV V19.B[0x6], W6
    MOV V31.D[0x0], X17
    MOV V30.H[0x2], W26
    MOV V29.S[0x1], W26
    MOV B1, V21.B[0x3]
    MOV D21, V24.D[0x1]
    MOV H12, V25.H[0x7]
    MOV S13, V11.S[0x3]
    MOV  W16, V14.S[0x2]
    MOV  X6, V10.D[0x0]
    MOV  V14.8B, V23.8B
    MOVI  V6.8H, #0xf9
    MOVI  V23.4S, #0xac, LSL #16
    MOVI  V24.2S, #0xe4, MSL #8
    MOVI  V16.2D, #18374966855136706815
    MOVI  V10.16B, #0xb6
    MUL  V22.4H, V27.4H, V0.H[0x4]
    MUL  V18.2S, V7.2S, V25.S[0x2]
    MUL  V3.16B, V3.16B, V27.16B
    MVN  V17.16B, V25.16B
    MVNI  V25.8H, #0x38, LSL #8
    MVNI  V8.2S, #0xf6, LSL #8
    MVNI  V0.4S, #0x95, MSL #16
    NEG  V7.16B, V7.16B
    NOT  V5.8B, V26.8B
    ORN  V27.8B, V11.8B, V27.8B
    ORR  V11.4H, #0xf4, LSL #8
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X21, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xff6a, LSL #16
    MOVK  X20, #0xff6a, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xff6a, LSL #16
    MOVK  X20, #0xff6a, LSL #48
    FMOV  X21, D0
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a, LSL #0
    FMOV  X21, D1
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa4a4, LSL #0
    MOVK  X20, #0xa4a4, LSL #16
    MOVK  X20, #0xa4a4, LSL #32
    MOVK  X20, #0xa4a4, LSL #48
    FMOV  X21, V3.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa4a4, LSL #0
    MOVK  X20, #0xa4a4, LSL #16
    MOVK  X20, #0xa4a4, LSL #32
    MOVK  X20, #0xa4a4, LSL #48
    FMOV  X21, D3
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X21, D5
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xf9, LSL #0
    MOVK  X20, #0xf9, LSL #16
    MOVK  X20, #0xf9, LSL #32
    MOVK  X20, #0xf9, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xf9, LSL #0
    MOVK  X20, #0xf9, LSL #16
    MOVK  X20, #0xf9, LSL #32
    MOVK  X20, #0xf9, LSL #48
    FMOV  X21, D6
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa6a6, LSL #0
    MOVK  X20, #0xa6a6, LSL #16
    MOVK  X20, #0xa6a6, LSL #32
    MOVK  X20, #0xa6a6, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa6a6, LSL #0
    MOVK  X20, #0xa6a6, LSL #16
    MOVK  X20, #0xa6a6, LSL #32
    MOVK  X20, #0xa6a6, LSL #48
    FMOV  X21, D7
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x9ff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0x9ff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D8
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V9.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb6b6, LSL #0
    MOVK  X20, #0xb6b6, LSL #16
    MOVK  X20, #0xb6b6, LSL #32
    MOVK  X20, #0xb6b6, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb6b6, LSL #0
    MOVK  X20, #0xb6b6, LSL #16
    MOVK  X20, #0xb6b6, LSL #32
    MOVK  X20, #0xb6b6, LSL #48
    FMOV  X21, D10
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xfe5a, LSL #0
    MOVK  X20, #0xfe5a, LSL #16
    MOVK  X20, #0xfe5a, LSL #32
    MOVK  X20, #0xfe5a, LSL #48
    FMOV  X21, D11
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    FMOV  X21, D12
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    FMOV  X21, D13
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V15.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xff, LSL #0
    MOVK  X20, #0xff00, LSL #32
    MOVK  X20, #0xff00, LSL #48
    FMOV  X21, V16.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xff, LSL #0
    MOVK  X20, #0xff00, LSL #32
    MOVK  X20, #0xff00, LSL #48
    FMOV  X21, D16
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X21, D17
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x67a4, LSL #0
    MOVK  X20, #0xef2b, LSL #16
    MOVK  X20, #0x67a4, LSL #32
    MOVK  X20, #0xef2b, LSL #48
    FMOV  X21, D18
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xf2b6, LSL #0
    MOVK  X20, #0xf2b6, LSL #16
    MOVK  X20, #0xf2b6, LSL #32
    MOVK  X20, #0xf2b6, LSL #48
    FMOV  X21, V20.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xf2b6, LSL #0
    MOVK  X20, #0xf2b6, LSL #16
    MOVK  X20, #0xf2b6, LSL #32
    MOVK  X20, #0xf2b6, LSL #48
    FMOV  X21, D20
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x67a4, LSL #0
    MOVK  X20, #0x67a4, LSL #16
    MOVK  X20, #0x67a4, LSL #32
    MOVK  X20, #0x67a4, LSL #48
    FMOV  X21, D22
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xac, LSL #16
    MOVK  X20, #0xac, LSL #48
    FMOV  X21, V23.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xac, LSL #16
    MOVK  X20, #0xac, LSL #48
    FMOV  X21, D23
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xe4ff, LSL #0
    MOVK  X20, #0xe4ff, LSL #32
    FMOV  X21, D24
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xc7ff, LSL #0
    MOVK  X20, #0xc7ff, LSL #16
    MOVK  X20, #0xc7ff, LSL #32
    MOVK  X20, #0xc7ff, LSL #48
    FMOV  X21, V25.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xc7ff, LSL #0
    MOVK  X20, #0xc7ff, LSL #16
    MOVK  X20, #0xc7ff, LSL #32
    MOVK  X20, #0xc7ff, LSL #48
    FMOV  X21, D25
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V26.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D27
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V29.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V30.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X24
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X10
    FMOV  D3, X27
    FMOV  V3.D[1], X18
    FMOV  D4, X7
    FMOV  V4.D[1], X23
    FMOV  D5, X13
    FMOV  V5.D[1], X5
    FMOV  D6, X5
    FMOV  V6.D[1], X12
    FMOV  D7, X16
    FMOV  V7.D[1], X11
    FMOV  D8, X7
    FMOV  V8.D[1], X18
    FMOV  D9, X7
    FMOV  V9.D[1], X29
    FMOV  D10, X24
    FMOV  V10.D[1], X6
    FMOV  D11, X24
    FMOV  V11.D[1], X16
    FMOV  D12, X5
    FMOV  V12.D[1], X26
    FMOV  D13, X19
    FMOV  V13.D[1], X23
    FMOV  D14, X4
    FMOV  V14.D[1], X19
    FMOV  D15, X2
    FMOV  V15.D[1], X12
    FMOV  D16, X2
    FMOV  V16.D[1], X9
    FMOV  D17, X23
    FMOV  V17.D[1], X19
    FMOV  D18, X10
    FMOV  V18.D[1], X16
    FMOV  D19, X25
    FMOV  V19.D[1], X11
    FMOV  D20, X18
    FMOV  V20.D[1], X27
    FMOV  D21, X16
    FMOV  V21.D[1], X10
    FMOV  D22, X27
    FMOV  V22.D[1], X5
    FMOV  D23, X23
    FMOV  V23.D[1], X7
    FMOV  D24, X26
    FMOV  V24.D[1], X29
    FMOV  D25, X4
    FMOV  V25.D[1], X10
    FMOV  D26, X5
    FMOV  V26.D[1], X29
    FMOV  D27, X29
    FMOV  V27.D[1], X23
    FMOV  D28, X26
    FMOV  V28.D[1], X19
    FMOV  D29, X4
    FMOV  V29.D[1], X2
    FMOV  D30, X4
    FMOV  V30.D[1], X11
    FMOV  D31, X13
    FMOV  V31.D[1], X3
    ORR  V30.16B, V30.16B, V27.16B
    PMUL  V12.8B, V25.8B, V29.8B
    PMULL  V2.8H, V24.8B, V26.8B
    PMULL2  V29.1Q, V4.2D, V28.2D
    RADDHN  V20.4H, V23.4S, V31.4S
    RADDHN2  V14.4S, V13.2D, V22.2D
    RBIT  V31.8B, V8.8B
    REV16  V15.8B, V3.8B
    REV32  V23.4H, V23.4H
    REV64  V22.4H, V21.4H
    RSHRN V17.8B, V5.8H, #7
    RSHRN V21.4H, V28.4S, #12
    RSHRN V25.2S, V16.2D, #15
    RSHRN2 V4.16B, V11.8H, #4
    RSHRN2 V8.8H, V19.4S, #16
    RSHRN2 V1.4S, V10.2D, #18
    RSUBHN  V6.4H, V9.4S, V11.4S
    RSUBHN2  V3.8H, V19.4S, V3.4S
    SHL  V27.16B, V19.16B, #0x3
    SHL V5.2D, V13.2D, #0x22
    SHL  V9.4H, V13.4H, #0x5
    SHL  V26.2S, V19.2S, #0xc
    SHLL  V16.2D, V13.2S, #32
    SHLL2  V24.8H, V13.16B, #8
    SHRN V19.8B, V28.8H, #1
    SHRN V11.4H, V10.4S, #7
    SHRN V10.2S, V18.2D, #5
    SHRN2 V18.16B, V7.8H, #2
    SHRN2 V7.8H, V0.4S, #5
    SHRN2 V28.4S, V28.2D, #19
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D0
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x9697, LSL #0
    MOVK  X20, #0x9696, LSL #16
    MOVK  X20, #0x9697, LSL #32
    MOVK  X20, #0x9696, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x1144, LSL #0
    MOVK  X20, #0x1144, LSL #16
    MOVK  X20, #0x1144, LSL #32
    MOVK  X20, #0x1144, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x1144, LSL #0
    MOVK  X20, #0x1144, LSL #16
    MOVK  X20, #0x1144, LSL #32
    MOVK  X20, #0x1144, LSL #48
    FMOV  X21, D2
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D3
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa6a6, LSL #0
    MOVK  X20, #0xa6a6, LSL #16
    MOVK  X20, #0xa6a6, LSL #32
    MOVK  X20, #0xa6a6, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x6968, LSL #32
    MOVK  X20, #0x6969, LSL #48
    FMOV  X21, V5.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x6968, LSL #32
    MOVK  X20, #0x6969, LSL #48
    FMOV  X21, D5
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D6
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xd2d2, LSL #0
    MOVK  X20, #0xd2d2, LSL #16
    MOVK  X20, #0xd2d2, LSL #32
    MOVK  X20, #0xd2d2, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x4b40, LSL #0
    MOVK  X20, #0x4b40, LSL #16
    MOVK  X20, #0x4b40, LSL #32
    MOVK  X20, #0x4b40, LSL #48
    FMOV  X21, D9
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xd2d2, LSL #0
    MOVK  X20, #0xd2d2, LSL #16
    MOVK  X20, #0xd2d2, LSL #32
    MOVK  X20, #0xd2d2, LSL #48
    FMOV  X21, D10
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b4, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb4b4, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, D11
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x4444, LSL #0
    MOVK  X20, #0x4444, LSL #16
    MOVK  X20, #0x4444, LSL #32
    MOVK  X20, #0x4444, LSL #48
    FMOV  X21, D12
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V13.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b5, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb4b5, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V16.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D16
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb5b5, LSL #0
    MOVK  X20, #0xb5b5, LSL #16
    MOVK  X20, #0xb5b5, LSL #32
    MOVK  X20, #0xb5b5, LSL #48
    FMOV  X21, D17
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x9696, LSL #0
    MOVK  X20, #0x9696, LSL #16
    MOVK  X20, #0x9696, LSL #32
    MOVK  X20, #0x9696, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x2d2d, LSL #0
    MOVK  X20, #0x2d2d, LSL #16
    MOVK  X20, #0x2d2d, LSL #32
    MOVK  X20, #0x2d2d, LSL #48
    FMOV  X21, D19
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b5, LSL #0
    MOVK  X20, #0xb4b5, LSL #16
    MOVK  X20, #0xb4b5, LSL #32
    MOVK  X20, #0xb4b5, LSL #48
    FMOV  X21, D20
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa5a6, LSL #0
    MOVK  X20, #0xa5a6, LSL #16
    MOVK  X20, #0xa5a6, LSL #32
    MOVK  X20, #0xa5a6, LSL #48
    FMOV  X21, D21
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a00, LSL #0
    MOVK  X20, #0x5a00, LSL #16
    MOVK  X20, #0x5a00, LSL #32
    MOVK  X20, #0x5a00, LSL #48
    FMOV  X21, V24.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a00, LSL #0
    MOVK  X20, #0x5a00, LSL #16
    MOVK  X20, #0x5a00, LSL #32
    MOVK  X20, #0x5a00, LSL #48
    FMOV  X21, D24
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb4b5, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb4b5, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, D25
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa000, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa000, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X21, D26
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xd0d0, LSL #0
    MOVK  X20, #0xd0d0, LSL #16
    MOVK  X20, #0xd0d0, LSL #32
    MOVK  X20, #0xd0d0, LSL #48
    FMOV  X21, V27.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xd0d0, LSL #0
    MOVK  X20, #0xd0d0, LSL #16
    MOVK  X20, #0xd0d0, LSL #32
    MOVK  X20, #0xd0d0, LSL #48
    FMOV  X21, D27
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x4b4b, LSL #0
    MOVK  X20, #0x4b4b, LSL #16
    MOVK  X20, #0x4b4b, LSL #32
    MOVK  X20, #0x4b4b, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x1144, LSL #0
    MOVK  X20, #0x1144, LSL #16
    MOVK  X20, #0x1144, LSL #32
    MOVK  X20, #0x1144, LSL #48
    FMOV  X21, V29.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x1144, LSL #0
    MOVK  X20, #0x1144, LSL #16
    MOVK  X20, #0x1144, LSL #32
    MOVK  X20, #0x1144, LSL #48
    FMOV  X21, D29
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V30.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X24
    FMOV  D1, X19
    FMOV  V1.D[1], X26
    FMOV  D2, X25
    FMOV  V2.D[1], X29
    FMOV  D3, X10
    FMOV  V3.D[1], X26
    FMOV  D4, X19
    FMOV  V4.D[1], X24
    FMOV  D5, X4
    FMOV  V5.D[1], X24
    FMOV  D6, X9
    FMOV  V6.D[1], X9
    FMOV  D7, X23
    FMOV  V7.D[1], X27
    FMOV  D8, X27
    FMOV  V8.D[1], X9
    FMOV  D9, X16
    FMOV  V9.D[1], X26
    FMOV  D10, X18
    FMOV  V10.D[1], X19
    FMOV  D11, X13
    FMOV  V11.D[1], X10
    FMOV  D12, X17
    FMOV  V12.D[1], X27
    FMOV  D13, X2
    FMOV  V13.D[1], X18
    FMOV  D14, X9
    FMOV  V14.D[1], X11
    FMOV  D15, X9
    FMOV  V15.D[1], X26
    FMOV  D16, X2
    FMOV  V16.D[1], X17
    FMOV  D17, X19
    FMOV  V17.D[1], X10
    FMOV  D18, X11
    FMOV  V18.D[1], X17
    FMOV  D19, X9
    FMOV  V19.D[1], X9
    FMOV  D20, X25
    FMOV  V20.D[1], X16
    FMOV  D21, X13
    FMOV  V21.D[1], X19
    FMOV  D22, X16
    FMOV  V22.D[1], X16
    FMOV  D23, X6
    FMOV  V23.D[1], X23
    FMOV  D24, X9
    FMOV  V24.D[1], X2
    FMOV  D25, X24
    FMOV  V25.D[1], X12
    FMOV  D26, X23
    FMOV  V26.D[1], X29
    FMOV  D27, X25
    FMOV  V27.D[1], X5
    FMOV  D28, X23
    FMOV  V28.D[1], X7
    FMOV  D29, X7
    FMOV  V29.D[1], X9
    FMOV  D30, X6
    FMOV  V30.D[1], X29
    FMOV  D31, X29
    FMOV  V31.D[1], X18
    SLI V3.2D, V26.2D, #0x6
    SLI  V29.8H, V29.8H, #0x9
    SLI  V24.4S, V28.4S, #0x9
    SRI  V27.16B, V25.16B, #8
    SRI V12.2D, V2.2D, #28
    SRI  V4.8H, V23.8H, #1
    SRI  V1.2S, V20.2S, #16
    TBL  V7.8B, { V8.16B, V9.16B, V10.16B, V11.16B }, V31.8B
    TBL  V30.16B, { V15.16B }, V30.16B
    TBL  V6.8B, { V16.16B, V17.16B, V18.16B }, V16.8B
    TBL  V26.8B, { V22.16B, V23.16B }, V15.8B
    TBX  V18.16B, { V19.16B, V20.16B, V21.16B, V22.16B }, V20.16B
    TBX  V10.16B, { V20.16B }, V13.16B
    TBX  V2.16B, { V20.16B, V21.16B, V22.16B }, V17.16B
    TBX  V15.8B, { V16.16B, V17.16B }, V15.8B
    CMEQ  V19.2D, V20.2D, V20.2D
    CMEQ  V17.4S, V8.4S, #0
    CMGE  V22.4H, V13.4H, V5.4H
    CMGE  V9.2S, V16.2S, #0
    CMGT  V23.2S, V23.2S, V28.2S
    CMGT  V16.16B, V11.16B, #0
    CMHI  V11.8B, V0.8B, V14.8B
    CMHS  V13.2D, V14.2D, V20.2D
    CMLE  V25.2D, V0.2D, #0
    CMLT  V5.8H, V21.8H, #0
    CMTST  V21.16B, V8.16B, V20.16B
    FCMEQ  V28.2S, V20.2S, V28.2S
    FCMEQ  V8.4S, V8.4S, #0.0
    FCMGE  V20.2S, V14.2S, V20.2S
    FCMGE  V0.4S, V0.4S, #0.0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D0
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x969a, LSL #0
    MOVK  X20, #0x9696, LSL #16
    MOVK  X20, #0x9696, LSL #32
    MOVK  X20, #0x9696, LSL #48
    FMOV  X21, V3.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x969a, LSL #0
    MOVK  X20, #0x9696, LSL #16
    MOVK  X20, #0x9696, LSL #32
    MOVK  X20, #0x9696, LSL #48
    FMOV  X21, D3
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x2d2d, LSL #0
    MOVK  X20, #0x2d2d, LSL #16
    MOVK  X20, #0x2d2d, LSL #32
    MOVK  X20, #0x2d2d, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x2d2d, LSL #0
    MOVK  X20, #0x2d2d, LSL #16
    MOVK  X20, #0x2d2d, LSL #32
    MOVK  X20, #0x2d2d, LSL #48
    FMOV  X21, D4
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D5
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D6
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D7
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D8
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D9
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D10
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D11
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0x5a55, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V12.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0x5a55, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, V13.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D13
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, V16.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D16
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D17
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D19
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D20
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, V21.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D21
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D22
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D23
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb45a, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb45a, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, V24.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb45a, LSL #0
    MOVK  X20, #0xb4b4, LSL #16
    MOVK  X20, #0xb45a, LSL #32
    MOVK  X20, #0xb4b4, LSL #48
    FMOV  X21, D24
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D25
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D26
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V27.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D28
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb45a, LSL #0
    MOVK  X20, #0xb45a, LSL #16
    MOVK  X20, #0xb45a, LSL #32
    MOVK  X20, #0xb45a, LSL #48
    FMOV  X21, V29.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xb45a, LSL #0
    MOVK  X20, #0xb45a, LSL #16
    MOVK  X20, #0xb45a, LSL #32
    MOVK  X20, #0xb45a, LSL #48
    FMOV  X21, D29
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D30
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X18
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X19
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X17
    FMOV  D4, X2
    FMOV  V4.D[1], X4
    FMOV  D5, X26
    FMOV  V5.D[1], X5
    FMOV  D6, X23
    FMOV  V6.D[1], X13
    FMOV  D7, X4
    FMOV  V7.D[1], X5
    FMOV  D8, X13
    FMOV  V8.D[1], X16
    FMOV  D9, X26
    FMOV  V9.D[1], X27
    FMOV  D10, X7
    FMOV  V10.D[1], X16
    FMOV  D11, X17
    FMOV  V11.D[1], X29
    FMOV  D12, X9
    FMOV  V12.D[1], X17
    FMOV  D13, X5
    FMOV  V13.D[1], X18
    FMOV  D14, X7
    FMOV  V14.D[1], X27
    FMOV  D15, X17
    FMOV  V15.D[1], X23
    FMOV  D16, X2
    FMOV  V16.D[1], X4
    FMOV  D17, X27
    FMOV  V17.D[1], X24
    FMOV  D18, X26
    FMOV  V18.D[1], X26
    FMOV  D19, X7
    FMOV  V19.D[1], X18
    FMOV  D20, X17
    FMOV  V20.D[1], X3
    FMOV  D21, X12
    FMOV  V21.D[1], X2
    FMOV  D22, X6
    FMOV  V22.D[1], X5
    FMOV  D23, X4
    FMOV  V23.D[1], X10
    FMOV  D24, X4
    FMOV  V24.D[1], X3
    FMOV  D25, X18
    FMOV  V25.D[1], X23
    FMOV  D26, X6
    FMOV  V26.D[1], X5
    FMOV  D27, X27
    FMOV  V27.D[1], X13
    FMOV  D28, X24
    FMOV  V28.D[1], X23
    FMOV  D29, X10
    FMOV  V29.D[1], X16
    FMOV  D30, X6
    FMOV  V30.D[1], X10
    FMOV  D31, X23
    FMOV  V31.D[1], X13
    FCMGT  V6.4S, V31.4S, #0.0
    FCMLE  V11.2S, V22.2S, #0.0
    FCMLT  V13.4S, V28.4S, #0.0
    FCMEQ  V23.4H, V27.4H, V25.4H
    FCMEQ  V5.8H, V30.8H, #0.0
    FCMGE  V15.4H, V29.4H, V26.4H
    FCMGE  V14.8H, V8.8H, #0.0
    FCMGT  V1.8H, V25.8H, V24.8H
    FCMGT  V26.8H, V16.8H, #0.0
    FCMLE  V8.8H, V18.8H, #0.0
    FCMLT  V2.8H, V22.8H, #0.0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X21, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D0
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D1
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V2.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D2
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V3.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D3
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D5
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D6
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D8
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V9.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D10
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D11
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V12.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, D13
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D14
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D15
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V16.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D16
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D17
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V20.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V21.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V22.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D23
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V24.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D24
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V25.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D25
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, V26.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0xffff, LSL #0
    MOVK  X20, #0xffff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    FMOV  X21, D26
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V27.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V29.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V30.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X5
    FMOV  D3, X2
    FMOV  V3.D[1], X23
    FMOV  D4, X19
    FMOV  V4.D[1], X29
    FMOV  D5, X19
    FMOV  V5.D[1], X4
    FMOV  D6, X9
    FMOV  V6.D[1], X25
    FMOV  D7, X16
    FMOV  V7.D[1], X7
    FMOV  D8, X8
    FMOV  V8.D[1], X7
    FMOV  D9, X9
    FMOV  V9.D[1], X18
    FMOV  D10, X29
    FMOV  V10.D[1], X26
    FMOV  D11, X26
    FMOV  V11.D[1], X21
    FMOV  D12, X25
    FMOV  V12.D[1], X8
    FMOV  D13, X7
    FMOV  V13.D[1], X7
    FMOV  D14, X6
    FMOV  V14.D[1], X10
    FMOV  D15, X6
    FMOV  V15.D[1], X12
    FMOV  D16, X29
    FMOV  V16.D[1], X27
    FMOV  D17, X19
    FMOV  V17.D[1], X20
    FMOV  D18, X21
    FMOV  V18.D[1], X8
    FMOV  D19, X18
    FMOV  V19.D[1], X5
    FMOV  D20, X9
    FMOV  V20.D[1], X19
    FMOV  D21, X23
    FMOV  V21.D[1], X25
    FMOV  D22, X8
    FMOV  V22.D[1], X26
    FMOV  D23, X18
    FMOV  V23.D[1], X5
    FMOV  D24, X18
    FMOV  V24.D[1], X5
    FMOV  D25, X9
    FMOV  V25.D[1], X24
    FMOV  D26, X9
    FMOV  V26.D[1], X6
    FMOV  D27, X5
    FMOV  V27.D[1], X6
    FMOV  D28, X23
    FMOV  V28.D[1], X8
    FMOV  D29, X4
    FMOV  V29.D[1], X16
    FMOV  D30, X20
    FMOV  V30.D[1], X7
    FMOV  D31, X7
    FMOV  V31.D[1], X29
    ABS  V1.2D, V25.2D
    ADD  V31.8B, V23.8B, V29.8B
    ADDHN  V19.8B, V24.8H, V24.8H
    ADDHN2  V11.8H, V20.4S, V0.4S
    ADDP  D21, V28.2D
    ADDP  V22.4H, V8.4H, V27.4H
    ADDV  B4, V26.16B
    ADDV  H30, V16.8H
    ADDV  S23, V14.4S
    AESD  V17.16B, V7.16B
    AESE  V3.16B, V24.16B
    AESIMC  V10.16B, V2.16B
    AESMC  V24.16B, V20.16B
    AND  V2.16B, V16.16B, V28.16B
    BIC  V7.8H, #0xe5
    BIC  V18.4S, #0x9c, LSL #16
    BIC  V27.16B, V20.16B, V5.16B
    BIF  V20.8B, V29.8B, V20.8B
    BIT  V0.16B, V9.16B, V28.16B
    BSL  V26.16B, V28.16B, V16.16B
    CLS  V13.16B, V8.16B
    CLZ  V8.4S, V5.4S
    CNT  V25.16B, V28.16B
    DUP B12, V9.B[0xb]
    DUP D15, V14.D[0x0]
    DUP H14, V9.H[0x0]
    DUP S28, V16.S[0x3]
    DUP  V6.8B, V16.B[0x6]
    DUP V16.2D, V16.D[0x0]
    DUP  V5.8H, V9.H[0x5]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V0.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5b, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, V1.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5b, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, D1
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V2.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x6363, LSL #0
    MOVK  X7, #0x6363, LSL #16
    MOVK  X7, #0x6363, LSL #32
    MOVK  X7, #0x6363, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x6363, LSL #0
    MOVK  X7, #0x6363, LSL #16
    MOVK  X7, #0x6363, LSL #32
    MOVK  X7, #0x6363, LSL #48
    FMOV  X9, D3
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x50, LSL #0
    FMOV  X9, D4
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V5.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa500, LSL #0
    MOVK  X7, #0xa500, LSL #16
    MOVK  X7, #0xa500, LSL #32
    MOVK  X7, #0xa500, LSL #48
    FMOV  X9, V7.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa500, LSL #0
    MOVK  X7, #0xa500, LSL #16
    MOVK  X7, #0xa500, LSL #32
    MOVK  X7, #0xa500, LSL #48
    FMOV  X9, D7
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4b4b, LSL #0
    MOVK  X7, #0x4b4b, LSL #16
    MOVK  X7, #0x4b4b, LSL #32
    MOVK  X7, #0x4b4b, LSL #48
    FMOV  X9, V11.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X9, D12
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D13
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    FMOV  X9, D14
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5252, LSL #0
    MOVK  X7, #0x5252, LSL #16
    MOVK  X7, #0x5252, LSL #32
    MOVK  X7, #0x5252, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5252, LSL #0
    MOVK  X7, #0x5252, LSL #16
    MOVK  X7, #0x5252, LSL #32
    MOVK  X7, #0x5252, LSL #48
    FMOV  X9, D17
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa521, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa521, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa521, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa521, LSL #48
    FMOV  X9, D18
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4b4b, LSL #0
    MOVK  X7, #0x4b4b, LSL #16
    MOVK  X7, #0x4b4b, LSL #32
    MOVK  X7, #0x4b4b, LSL #48
    FMOV  X9, D19
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4b4a, LSL #0
    MOVK  X7, #0x4b4b, LSL #16
    MOVK  X7, #0x4b4b, LSL #32
    MOVK  X7, #0x4b4b, LSL #48
    FMOV  X9, D21
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4b4a, LSL #0
    MOVK  X7, #0x4b4a, LSL #16
    MOVK  X7, #0x4b4a, LSL #32
    MOVK  X7, #0x4b4a, LSL #48
    FMOV  X9, D22
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x9694, LSL #0
    MOVK  X7, #0x9696, LSL #16
    FMOV  X9, D23
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x404, LSL #0
    MOVK  X7, #0x404, LSL #16
    MOVK  X7, #0x404, LSL #32
    MOVK  X7, #0x404, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x404, LSL #0
    MOVK  X7, #0x404, LSL #16
    MOVK  X7, #0x404, LSL #32
    MOVK  X7, #0x404, LSL #48
    FMOV  X9, D25
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V26.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D27
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X9, D28
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V29.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2d28, LSL #0
    FMOV  X9, D30
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4a4a, LSL #0
    MOVK  X7, #0x4a4a, LSL #16
    MOVK  X7, #0x4a4a, LSL #32
    MOVK  X7, #0x4a4a, LSL #48
    FMOV  X9, D31
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X21
    FMOV  V2.D[1], X26
    FMOV  D3, X2
    FMOV  V3.D[1], X18
    FMOV  D4, X26
    FMOV  V4.D[1], X16
    FMOV  D5, X3
    FMOV  V5.D[1], X24
    FMOV  D6, X18
    FMOV  V6.D[1], X8
    FMOV  D7, X3
    FMOV  V7.D[1], X13
    FMOV  D8, X19
    FMOV  V8.D[1], X8
    FMOV  D9, X17
    FMOV  V9.D[1], X12
    FMOV  D10, X21
    FMOV  V10.D[1], X8
    FMOV  D11, X2
    FMOV  V11.D[1], X10
    FMOV  D12, X27
    FMOV  V12.D[1], X24
    FMOV  D13, X4
    FMOV  V13.D[1], X18
    FMOV  D14, X12
    FMOV  V14.D[1], X5
    FMOV  D15, X26
    FMOV  V15.D[1], X21
    FMOV  D16, X24
    FMOV  V16.D[1], X19
    FMOV  D17, X6
    FMOV  V17.D[1], X13
    FMOV  D18, X23
    FMOV  V18.D[1], X13
    FMOV  D19, X18
    FMOV  V19.D[1], X24
    FMOV  D20, X17
    FMOV  V20.D[1], X25
    FMOV  D21, X18
    FMOV  V21.D[1], X5
    FMOV  D22, X12
    FMOV  V22.D[1], X4
    FMOV  D23, X25
    FMOV  V23.D[1], X3
    FMOV  D24, X29
    FMOV  V24.D[1], X8
    FMOV  D25, X19
    FMOV  V25.D[1], X23
    FMOV  D26, X3
    FMOV  V26.D[1], X17
    FMOV  D27, X2
    FMOV  V27.D[1], X5
    FMOV  D28, X3
    FMOV  V28.D[1], X20
    FMOV  D29, X10
    FMOV  V29.D[1], X24
    FMOV  D30, X19
    FMOV  V30.D[1], X5
    FMOV  D31, X29
    FMOV  V31.D[1], X3
    DUP V30.8B, W27
    DUP V9.2D, X23
    DUP V3.8H, W21
    DUP V13.2S, W5
    EOR  V8.16B, V24.16B, V24.16B
    EXT  V17.16B, V29.16B, V29.16B, #0xb
    EXT  V21.8B, V28.8B, V27.8B, #0x3
    SUB  V25.2D, V25.2D, V23.2D
    SUBHN  V2.4H, V26.4S, V31.4S
    SUBHN2  V28.4S, V5.2D, V12.2D
    TRN1  V11.2D, V31.2D, V23.2D
    TRN2  V15.8H, V20.8H, V20.8H
    UZP1  V6.2S, V12.2S, V0.2S
    UZP2  V14.4S, V29.4S, V22.4S
    XTN  V7.4H, V4.4S
    XTN2  V4.4S, V24.2D
    ZIP1  V24.2S, V27.2S, V5.2S
    ZIP2  V31.8B, V1.8B, V27.8B
    INS V20.B[0x1], V0.B[0xb]
    INS V12.D[0x0], V12.D[0x0]
    INS V16.H[0x6], V29.H[0x6]
    INS V5.S[0x2], V18.S[0x0]
    INS V18.B[0x3], W4
    INS V0.D[0x1], X2
    INS V23.H[0x7], W12
    INS V26.S[0x0], W20
    MLA  V1.8H, V1.8H, V1.H[0x3]
    MLA  V29.2S, V27.2S, V10.S[0x1]
    MLA  V22.8B, V10.8B, V10.8B
    MLS  V19.4H, V27.4H, V10.H[0x1]
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V0.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xc1fe, LSL #0
    MOVK  X7, #0xc1fe, LSL #16
    MOVK  X7, #0xc1fe, LSL #32
    MOVK  X7, #0xc1fe, LSL #48
    FMOV  X9, V1.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xc1fe, LSL #0
    MOVK  X7, #0xc1fe, LSL #16
    MOVK  X7, #0xc1fe, LSL #32
    MOVK  X7, #0xc1fe, LSL #48
    FMOV  X9, D1
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D2
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V4.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V5.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V11.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V12.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V15.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x894c, LSL #0
    MOVK  X7, #0x894c, LSL #16
    MOVK  X7, #0x894c, LSL #32
    MOVK  X7, #0x894c, LSL #48
    FMOV  X9, D19
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xfefe, LSL #0
    MOVK  X7, #0xfefe, LSL #16
    MOVK  X7, #0xfefe, LSL #32
    MOVK  X7, #0xfefe, LSL #48
    FMOV  X9, D22
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V23.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D25
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V26.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xc1fe, LSL #0
    MOVK  X7, #0x4985, LSL #16
    MOVK  X7, #0xc1fe, LSL #32
    MOVK  X7, #0x4985, LSL #48
    FMOV  X9, D29
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X24
    FMOV  V2.D[1], X10
    FMOV  D3, X16
    FMOV  V3.D[1], X6
    FMOV  D4, X29
    FMOV  V4.D[1], X21
    FMOV  D5, X20
    FMOV  V5.D[1], X18
    FMOV  D6, X21
    FMOV  V6.D[1], X4
    FMOV  D7, X6
    FMOV  V7.D[1], X25
    FMOV  D8, X6
    FMOV  V8.D[1], X10
    FMOV  D9, X6
    FMOV  V9.D[1], X21
    FMOV  D10, X18
    FMOV  V10.D[1], X13
    FMOV  D11, X20
    FMOV  V11.D[1], X21
    FMOV  D12, X10
    FMOV  V12.D[1], X3
    FMOV  D13, X23
    FMOV  V13.D[1], X21
    FMOV  D14, X21
    FMOV  V14.D[1], X8
    FMOV  D15, X29
    FMOV  V15.D[1], X3
    FMOV  D16, X13
    FMOV  V16.D[1], X3
    FMOV  D17, X3
    FMOV  V17.D[1], X10
    FMOV  D18, X18
    FMOV  V18.D[1], X19
    FMOV  D19, X25
    FMOV  V19.D[1], X21
    FMOV  D20, X25
    FMOV  V20.D[1], X29
    FMOV  D21, X4
    FMOV  V21.D[1], X5
    FMOV  D22, X8
    FMOV  V22.D[1], X5
    FMOV  D23, X26
    FMOV  V23.D[1], X19
    FMOV  D24, X10
    FMOV  V24.D[1], X25
    FMOV  D25, X27
    FMOV  V25.D[1], X3
    FMOV  D26, X23
    FMOV  V26.D[1], X4
    FMOV  D27, X3
    FMOV  V27.D[1], X2
    FMOV  D28, X3
    FMOV  V28.D[1], X24
    FMOV  D29, X19
    FMOV  V29.D[1], X25
    FMOV  D30, X20
    FMOV  V30.D[1], X16
    FMOV  D31, X17
    FMOV  V31.D[1], X6
    MLS  V25.16B, V28.16B, V22.16B
    MOV V29.B[0x7], V23.B[0x3]
    MOV V21.D[0x1], V26.D[0x0]
    MOV V3.H[0x1], V27.H[0x0]
    MOV V22.S[0x0], V30.S[0x1]
    MOV V20.B[0x7], W3
    MOV V16.D[0x0], X29
    MOV V17.H[0x7], W27
    MOV V30.S[0x1], W20
    MOV B0, V24.B[0xf]
    MOV D15, V31.D[0x0]
    MOV H2, V12.H[0x7]
    MOV S28, V5.S[0x3]
    MOV  W6, V7.S[0x1]
    MOV  X24, V8.D[0x1]
    MOV  V5.16B, V14.16B
    MOVI  V9.8H, #0x2b
    MOVI  V8.4S, #0xc5
    MOVI  V14.2S, #0x2a, MSL #16
    MOVI  V13.2D, #72056498804555775
    MOVI  V1.8B, #0x83
    MUL  V12.4H, V11.4H, V12.H[0x7]
    MUL  V19.4S, V19.4S, V23.S[0x1]
    MUL  V6.16B, V10.16B, V10.16B
    MVN  V7.8B, V26.8B
    MVNI  V27.8H, #0xd3, LSL #8
    MVNI  V26.2S, #0x6b, LSL #24
    MVNI  V4.2S, #0xfe, MSL #16
    NEG  V24.2D, V11.2D
    NOT  V23.16B, V10.16B
    ORN  V10.16B, V10.16B, V18.16B
    ORR  V18.4H, #0xb3
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    SUB  X9, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5, LSL #0
    FMOV  X9, D0
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x8383, LSL #0
    MOVK  X7, #0x8383, LSL #16
    MOVK  X7, #0x8383, LSL #32
    MOVK  X7, #0x8383, LSL #48
    FMOV  X9, D1
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    FMOV  X9, D2
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xff01, LSL #16
    MOVK  X7, #0xff01, LSL #48
    FMOV  X9, D4
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V5.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5959, LSL #0
    MOVK  X7, #0x5959, LSL #16
    MOVK  X7, #0x5959, LSL #32
    MOVK  X7, #0x5959, LSL #48
    FMOV  X9, V6.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5959, LSL #0
    MOVK  X7, #0x5959, LSL #16
    MOVK  X7, #0x5959, LSL #32
    MOVK  X7, #0x5959, LSL #48
    FMOV  X9, D6
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, D7
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xc5, LSL #0
    MOVK  X7, #0xc5, LSL #32
    FMOV  X9, V8.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xc5, LSL #0
    MOVK  X7, #0xc5, LSL #32
    FMOV  X9, D8
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2b, LSL #0
    MOVK  X7, #0x2b, LSL #16
    MOVK  X7, #0x2b, LSL #32
    MOVK  X7, #0x2b, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2b, LSL #0
    MOVK  X7, #0x2b, LSL #16
    MOVK  X7, #0x2b, LSL #32
    MOVK  X7, #0x2b, LSL #48
    FMOV  X9, D9
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D10
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V11.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x1c59, LSL #0
    MOVK  X7, #0x1c59, LSL #16
    MOVK  X7, #0x1c59, LSL #32
    MOVK  X7, #0x1c59, LSL #48
    FMOV  X9, D12
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xff00, LSL #16
    MOVK  X7, #0xff00, LSL #32
    MOVK  X7, #0xff, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xff00, LSL #16
    MOVK  X7, #0xff00, LSL #32
    MOVK  X7, #0xff, LSL #48
    FMOV  X9, D13
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0x2a, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x2a, LSL #48
    FMOV  X9, D14
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5b7, LSL #0
    MOVK  X7, #0xa5b7, LSL #16
    MOVK  X7, #0xa5b7, LSL #32
    MOVK  X7, #0xa5b7, LSL #48
    FMOV  X9, D18
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x1c59, LSL #0
    MOVK  X7, #0xa3e0, LSL #16
    MOVK  X7, #0x1c59, LSL #32
    MOVK  X7, #0xa3e0, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x1c59, LSL #0
    MOVK  X7, #0xa3e0, LSL #16
    MOVK  X7, #0x1c59, LSL #32
    MOVK  X7, #0xa3e0, LSL #48
    FMOV  X9, D19
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, V23.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, D23
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5b, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5b, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, D24
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4c4c, LSL #0
    MOVK  X7, #0x4c4c, LSL #16
    MOVK  X7, #0x4c4c, LSL #32
    MOVK  X7, #0x4c4c, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4c4c, LSL #0
    MOVK  X7, #0x4c4c, LSL #16
    MOVK  X7, #0x4c4c, LSL #32
    MOVK  X7, #0x4c4c, LSL #48
    FMOV  X9, D25
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0x94ff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0x94ff, LSL #48
    FMOV  X9, D26
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2cff, LSL #0
    MOVK  X7, #0x2cff, LSL #16
    MOVK  X7, #0x2cff, LSL #32
    MOVK  X7, #0x2cff, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2cff, LSL #0
    MOVK  X7, #0x2cff, LSL #16
    MOVK  X7, #0x2cff, LSL #32
    MOVK  X7, #0x2cff, LSL #48
    FMOV  X9, D27
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X9, D28
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V29.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V31.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X8
    FMOV  V2.D[1], X6
    FMOV  D3, X4
    FMOV  V3.D[1], X21
    FMOV  D4, X17
    FMOV  V4.D[1], X16
    FMOV  D5, X17
    FMOV  V5.D[1], X3
    FMOV  D6, X18
    FMOV  V6.D[1], X26
    FMOV  D7, X6
    FMOV  V7.D[1], X20
    FMOV  D8, X2
    FMOV  V8.D[1], X12
    FMOV  D9, X3
    FMOV  V9.D[1], X27
    FMOV  D10, X10
    FMOV  V10.D[1], X12
    FMOV  D11, X4
    FMOV  V11.D[1], X24
    FMOV  D12, X25
    FMOV  V12.D[1], X18
    FMOV  D13, X23
    FMOV  V13.D[1], X10
    FMOV  D14, X16
    FMOV  V14.D[1], X2
    FMOV  D15, X10
    FMOV  V15.D[1], X18
    FMOV  D16, X4
    FMOV  V16.D[1], X3
    FMOV  D17, X8
    FMOV  V17.D[1], X26
    FMOV  D18, X17
    FMOV  V18.D[1], X26
    FMOV  D19, X16
    FMOV  V19.D[1], X18
    FMOV  D20, X29
    FMOV  V20.D[1], X25
    FMOV  D21, X19
    FMOV  V21.D[1], X2
    FMOV  D22, X23
    FMOV  V22.D[1], X24
    FMOV  D23, X10
    FMOV  V23.D[1], X13
    FMOV  D24, X5
    FMOV  V24.D[1], X10
    FMOV  D25, X27
    FMOV  V25.D[1], X26
    FMOV  D26, X16
    FMOV  V26.D[1], X23
    FMOV  D27, X10
    FMOV  V27.D[1], X13
    FMOV  D28, X4
    FMOV  V28.D[1], X21
    FMOV  D29, X23
    FMOV  V29.D[1], X23
    FMOV  D30, X8
    FMOV  V30.D[1], X2
    FMOV  D31, X23
    FMOV  V31.D[1], X18
    ORR  V13.16B, V28.16B, V30.16B
    PMUL  V16.8B, V27.8B, V21.8B
    PMULL  V10.1Q, V18.1D, V24.1D
    PMULL2  V28.1Q, V31.2D, V26.2D
    RADDHN  V19.4H, V1.4S, V25.4S
    RADDHN2  V2.16B, V11.8H, V23.8H
    RBIT  V22.8B, V29.8B
    REV16  V12.8B, V5.8B
    REV32  V11.16B, V5.16B
    REV64  V4.8B, V24.8B
    RSHRN V7.8B, V18.8H, #2
    RSHRN V20.4H, V29.4S, #3
    RSHRN V1.2S, V18.2D, #18
    RSHRN2 V27.16B, V9.8H, #4
    RSHRN2 V30.8H, V5.4S, #9
    RSHRN2 V9.4S, V24.2D, #5
    RSUBHN  V3.8B, V17.8H, V3.8H
    RSUBHN2  V26.16B, V24.8H, V14.8H
    SHL  V31.8B, V21.8B, #0x3
    SHL V6.2D, V8.2D, #0xb
    SHL  V17.8H, V29.8H, #0x4
    SHL  V0.2S, V23.2S, #0x6
    SHLL  V14.2D, V8.2S, #32
    SHLL2  V21.8H, V29.16B, #8
    SHRN V25.8B, V29.8H, #5
    SHRN V15.4H, V15.4S, #4
    SHRN V23.2S, V24.2D, #12
    SHRN2 V18.16B, V5.8H, #5
    SHRN2 V5.8H, V24.4S, #8
    SHRN2 V8.4S, V24.2D, #28
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x6940, LSL #0
    MOVK  X7, #0x6969, LSL #16
    MOVK  X7, #0x6940, LSL #32
    MOVK  X7, #0x6969, LSL #48
    FMOV  X9, D0
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x6969, LSL #0
    MOVK  X7, #0x6969, LSL #16
    MOVK  X7, #0x6969, LSL #32
    MOVK  X7, #0x6969, LSL #48
    FMOV  X9, D1
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4b4b, LSL #0
    MOVK  X7, #0x4b4b, LSL #16
    MOVK  X7, #0x4b4b, LSL #32
    MOVK  X7, #0x4b4b, LSL #48
    FMOV  X9, V2.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D3
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V5.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2800, LSL #0
    MOVK  X7, #0x2d2d, LSL #16
    MOVK  X7, #0x2d2d, LSL #32
    MOVK  X7, #0x2d2d, LSL #48
    FMOV  X9, V6.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2800, LSL #0
    MOVK  X7, #0x2d2d, LSL #16
    MOVK  X7, #0x2d2d, LSL #32
    MOVK  X7, #0x2d2d, LSL #48
    FMOV  X9, D6
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x6969, LSL #0
    MOVK  X7, #0x6969, LSL #16
    MOVK  X7, #0x6969, LSL #32
    MOVK  X7, #0x6969, LSL #48
    FMOV  X9, D7
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2d2d, LSL #0
    MOVK  X7, #0x2d2d, LSL #16
    MOVK  X7, #0x2d2d, LSL #32
    MOVK  X7, #0x2d2d, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4411, LSL #0
    MOVK  X7, #0x4411, LSL #16
    MOVK  X7, #0x4411, LSL #32
    MOVK  X7, #0x4411, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4411, LSL #0
    MOVK  X7, #0x4411, LSL #16
    MOVK  X7, #0x4411, LSL #32
    MOVK  X7, #0x4411, LSL #48
    FMOV  X9, D10
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V11.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, D15
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x1111, LSL #0
    MOVK  X7, #0x1111, LSL #16
    MOVK  X7, #0x1111, LSL #32
    MOVK  X7, #0x1111, LSL #48
    FMOV  X9, D16
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a50, LSL #0
    MOVK  X7, #0x5a50, LSL #16
    MOVK  X7, #0x5a50, LSL #32
    MOVK  X7, #0x5a50, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a50, LSL #0
    MOVK  X7, #0x5a50, LSL #16
    MOVK  X7, #0x5a50, LSL #32
    MOVK  X7, #0x5a50, LSL #48
    FMOV  X9, D17
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2d2d, LSL #0
    MOVK  X7, #0x2d2d, LSL #16
    MOVK  X7, #0x2d2d, LSL #32
    MOVK  X7, #0x2d2d, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4b4b, LSL #0
    MOVK  X7, #0x4b4b, LSL #16
    MOVK  X7, #0x4b4b, LSL #32
    MOVK  X7, #0x4b4b, LSL #48
    FMOV  X9, D19
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xb4b5, LSL #0
    MOVK  X7, #0xb4b5, LSL #16
    MOVK  X7, #0xb4b5, LSL #32
    MOVK  X7, #0xb4b5, LSL #48
    FMOV  X9, D20
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa500, LSL #0
    MOVK  X7, #0xa500, LSL #16
    MOVK  X7, #0xa500, LSL #32
    MOVK  X7, #0xa500, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa500, LSL #0
    MOVK  X7, #0xa500, LSL #16
    MOVK  X7, #0xa500, LSL #32
    MOVK  X7, #0xa500, LSL #48
    FMOV  X9, D21
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, D23
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2d2d, LSL #0
    MOVK  X7, #0x2d2d, LSL #16
    MOVK  X7, #0x2d2d, LSL #32
    MOVK  X7, #0x2d2d, LSL #48
    FMOV  X9, D25
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4411, LSL #0
    MOVK  X7, #0x4411, LSL #16
    MOVK  X7, #0x4411, LSL #32
    MOVK  X7, #0x4411, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4411, LSL #0
    MOVK  X7, #0x4411, LSL #16
    MOVK  X7, #0x4411, LSL #32
    MOVK  X7, #0x4411, LSL #48
    FMOV  X9, D28
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V29.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xd2d3, LSL #0
    MOVK  X7, #0xd2d3, LSL #16
    MOVK  X7, #0xd2d3, LSL #32
    MOVK  X7, #0xd2d3, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x2828, LSL #0
    MOVK  X7, #0x2828, LSL #16
    MOVK  X7, #0x2828, LSL #32
    MOVK  X7, #0x2828, LSL #48
    FMOV  X9, D31
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X23
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X12
    FMOV  V3.D[1], X12
    FMOV  D4, X21
    FMOV  V4.D[1], X5
    FMOV  D5, X16
    FMOV  V5.D[1], X3
    FMOV  D6, X17
    FMOV  V6.D[1], X18
    FMOV  D7, X26
    FMOV  V7.D[1], X6
    FMOV  D8, X16
    FMOV  V8.D[1], X8
    FMOV  D9, X12
    FMOV  V9.D[1], X17
    FMOV  D10, X20
    FMOV  V10.D[1], X29
    FMOV  D11, X25
    FMOV  V11.D[1], X13
    FMOV  D12, X26
    FMOV  V12.D[1], X5
    FMOV  D13, X18
    FMOV  V13.D[1], X8
    FMOV  D14, X18
    FMOV  V14.D[1], X21
    FMOV  D15, X26
    FMOV  V15.D[1], X23
    FMOV  D16, X17
    FMOV  V16.D[1], X26
    FMOV  D17, X21
    FMOV  V17.D[1], X20
    FMOV  D18, X17
    FMOV  V18.D[1], X25
    FMOV  D19, X8
    FMOV  V19.D[1], X13
    FMOV  D20, X8
    FMOV  V20.D[1], X17
    FMOV  D21, X13
    FMOV  V21.D[1], X25
    FMOV  D22, X19
    FMOV  V22.D[1], X16
    FMOV  D23, X6
    FMOV  V23.D[1], X5
    FMOV  D24, X12
    FMOV  V24.D[1], X6
    FMOV  D25, X16
    FMOV  V25.D[1], X21
    FMOV  D26, X6
    FMOV  V26.D[1], X29
    FMOV  D27, X13
    FMOV  V27.D[1], X13
    FMOV  D28, X3
    FMOV  V28.D[1], X6
    FMOV  D29, X13
    FMOV  V29.D[1], X16
    FMOV  D30, X20
    FMOV  V30.D[1], X18
    FMOV  D31, X26
    FMOV  V31.D[1], X26
    SLI V21.2D, V22.2D, #0x1
    SLI  V27.8H, V23.8H, #0x0
    SLI  V28.4S, V20.4S, #0x14
    SRI  V1.8B, V29.8B, #6
    SRI V4.2D, V19.2D, #20
    SRI  V25.4H, V16.4H, #13
    SRI  V29.2S, V26.2S, #15
    TBL  V0.8B, { V10.16B, V11.16B, V12.16B, V13.16B }, V31.8B
    TBL  V22.16B, { V13.16B }, V30.16B
    TBL  V2.16B, { V14.16B, V15.16B, V16.16B }, V23.16B
    TBL  V16.16B, { V9.16B, V10.16B }, V9.16B
    TBX  V9.8B, { V11.16B, V12.16B, V13.16B, V14.16B }, V7.8B
    TBX  V23.8B, { V5.16B }, V30.8B
    TBX  V24.16B, { V13.16B, V14.16B, V15.16B }, V31.16B
    TBX  V26.8B, { V6.16B, V7.16B }, V11.8B
    CMEQ  V13.2D, V15.2D, V17.2D
    CMEQ  V5.4H, V8.4H, #0
    CMGE  V11.8B, V30.8B, V15.8B
    CMGE  V6.8B, V31.8B, #0
    CMGT  V8.4S, V17.4S, V12.4S
    CMGT  V18.2S, V3.2S, #0
    CMHI  V31.16B, V31.16B, V17.16B
    CMHS  V3.16B, V3.16B, V19.16B
    CMLE  V14.8B, V19.8B, #0
    CMLT  V20.4S, V30.4S, #0
    CMTST  V17.16B, V7.16B, V7.16B
    FCMEQ  V10.2D, V10.2D, V12.2D
    FCMEQ  V15.2D, V15.2D, #0.0
    FCMGE  V30.2S, V30.2S, V12.2S
    FCMGE  V12.4S, V19.4S, #0.0
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D0
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa6a6, LSL #0
    MOVK  X7, #0xa6a6, LSL #16
    MOVK  X7, #0xa6a6, LSL #32
    MOVK  X7, #0xa6a6, LSL #48
    FMOV  X9, D1
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D2
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D3
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0xaa5a, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V4.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0xaa5a, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D5
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D6
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V7.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D8
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D10
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D11
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D12
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D13
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D14
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D15
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D16
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D17
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D18
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D20
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4b4b, LSL #0
    MOVK  X7, #0x4b4b, LSL #16
    MOVK  X7, #0x4b4b, LSL #32
    MOVK  X7, #0x4b4b, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4b4b, LSL #0
    MOVK  X7, #0x4b4b, LSL #16
    MOVK  X7, #0x4b4b, LSL #32
    MOVK  X7, #0x4b4b, LSL #48
    FMOV  X9, D21
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D22
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0x5a55, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0x5a55, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0x5a55, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0x5a55, LSL #48
    FMOV  X9, D28
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x4b4b, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0x4b4b, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D30
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D31
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X23
    FMOV  V2.D[1], X5
    FMOV  D3, X4
    FMOV  V3.D[1], X4
    FMOV  D4, X21
    FMOV  V4.D[1], X8
    FMOV  D5, X5
    FMOV  V5.D[1], X10
    FMOV  D6, X16
    FMOV  V6.D[1], X12
    FMOV  D7, X12
    FMOV  V7.D[1], X25
    FMOV  D8, X10
    FMOV  V8.D[1], X25
    FMOV  D9, X10
    FMOV  V9.D[1], X24
    FMOV  D10, X2
    FMOV  V10.D[1], X19
    FMOV  D11, X20
    FMOV  V11.D[1], X3
    FMOV  D12, X17
    FMOV  V12.D[1], X29
    FMOV  D13, X18
    FMOV  V13.D[1], X20
    FMOV  D14, X24
    FMOV  V14.D[1], X25
    FMOV  D15, X18
    FMOV  V15.D[1], X26
    FMOV  D16, X13
    FMOV  V16.D[1], X29
    FMOV  D17, X4
    FMOV  V17.D[1], X12
    FMOV  D18, X18
    FMOV  V18.D[1], X3
    FMOV  D19, X27
    FMOV  V19.D[1], X4
    FMOV  D20, X27
    FMOV  V20.D[1], X20
    FMOV  D21, X17
    FMOV  V21.D[1], X13
    FMOV  D22, X13
    FMOV  V22.D[1], X16
    FMOV  D23, X23
    FMOV  V23.D[1], X2
    FMOV  D24, X26
    FMOV  V24.D[1], X24
    FMOV  D25, X27
    FMOV  V25.D[1], X6
    FMOV  D26, X6
    FMOV  V26.D[1], X16
    FMOV  D27, X20
    FMOV  V27.D[1], X17
    FMOV  D28, X24
    FMOV  V28.D[1], X8
    FMOV  D29, X5
    FMOV  V29.D[1], X12
    FMOV  D30, X17
    FMOV  V30.D[1], X19
    FMOV  D31, X29
    FMOV  V31.D[1], X13
    FCMGT  V26.2D, V23.2D, #0.0
    FCMLE  V8.2S, V29.2S, #0.0
    FCMLT  V15.2D, V28.2D, #0.0
    FCMEQ  V5.8H, V25.8H, V24.8H
    FCMEQ  V0.4H, V30.4H, #0.0
    FCMGE  V6.8H, V11.8H, V31.8H
    FCMGE  V29.4H, V29.4H, #0.0
    FCMGT  V7.4H, V27.4H, V27.4H
    FCMGT  V2.8H, V22.8H, #0.0
    FCMLE  V18.8H, V13.8H, #0.0
    FCMLT  V27.4H, V31.4H, #0.0
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D0
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V1.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D2
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V4.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V5.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D5
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V6.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D6
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D7
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D8
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V11.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V12.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V15.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D15
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D18
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V23.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D26
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xffff, LSL #0
    MOVK  X7, #0xffff, LSL #16
    MOVK  X7, #0xffff, LSL #32
    MOVK  X7, #0xffff, LSL #48
    FMOV  X9, D27
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, D29
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V31.D[1]
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X11, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, DataReverseAdvsimdVectorP01_TestFail

DataReverseAdvsimdVectorP01_TestEnd:
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
DataReverseAdvsimdVectorP01_TestFail:
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
