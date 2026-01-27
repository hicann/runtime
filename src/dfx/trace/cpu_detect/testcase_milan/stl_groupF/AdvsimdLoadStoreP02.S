.global AdvsimdLoadStoreP02

.text
.p2align 4

AdvsimdLoadStoreP02:

AdvsimdLoadStoreP02_TestBegin:
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
    MOVZ  X2, #0x47ae, LSL #0
    MOVK  X2, #0x254e, LSL #16
    MOVK  X2, #0xe919, LSL #32
    MOVK  X2, #0xf1e6, LSL #48
    MOVZ  X4, #0x31a8, LSL #0
    MOVK  X4, #0x2ac, LSL #16
    MOVK  X4, #0x194c, LSL #32
    MOVK  X4, #0x41d8, LSL #48
    MOVZ  X5, #0x7c7d, LSL #0
    MOVK  X5, #0xacd, LSL #16
    MOVK  X5, #0xb458, LSL #32
    MOVK  X5, #0x1650, LSL #48
    MOVZ  X7, #0x6c17, LSL #0
    MOVK  X7, #0x967d, LSL #16
    MOVK  X7, #0x42c9, LSL #32
    MOVK  X7, #0x5d2d, LSL #48
    MOVZ  X9, #0x9d84, LSL #0
    MOVK  X9, #0xa856, LSL #16
    MOVK  X9, #0x4a14, LSL #32
    MOVK  X9, #0x2145, LSL #48
    MOVZ  X10, #0x1aeb, LSL #0
    MOVK  X10, #0xd0fd, LSL #16
    MOVK  X10, #0xe2c, LSL #32
    MOVK  X10, #0x657e, LSL #48
    MOVZ  X11, #0x8932, LSL #0
    MOVK  X11, #0x42dd, LSL #16
    MOVK  X11, #0x1075, LSL #32
    MOVK  X11, #0x6a69, LSL #48
    MOVZ  X12, #0x70c0, LSL #0
    MOVK  X12, #0xd48a, LSL #16
    MOVK  X12, #0x887a, LSL #32
    MOVK  X12, #0x6d55, LSL #48
    MOVZ  X13, #0xb7ca, LSL #0
    MOVK  X13, #0x39f9, LSL #16
    MOVK  X13, #0xab5, LSL #32
    MOVK  X13, #0xcd7b, LSL #48
    MOVZ  X14, #0xe6b3, LSL #0
    MOVK  X14, #0x8e22, LSL #16
    MOVK  X14, #0x2163, LSL #32
    MOVK  X14, #0x57bd, LSL #48
    MOVZ  X15, #0xcf89, LSL #0
    MOVK  X15, #0x9f42, LSL #16
    MOVK  X15, #0x29e7, LSL #32
    MOVK  X15, #0xb129, LSL #48
    MOVZ  X16, #0x4499, LSL #0
    MOVK  X16, #0x805d, LSL #16
    MOVK  X16, #0x264, LSL #32
    MOVK  X16, #0x8d93, LSL #48
    MOVZ  X17, #0x1728, LSL #0
    MOVK  X17, #0x8a89, LSL #16
    MOVK  X17, #0x3857, LSL #32
    MOVK  X17, #0x1dd, LSL #48
    MOVZ  X18, #0x3b4a, LSL #0
    MOVK  X18, #0xe1cc, LSL #16
    MOVK  X18, #0xcfa2, LSL #32
    MOVK  X18, #0xc466, LSL #48
    MOVZ  X19, #0xcc40, LSL #0
    MOVK  X19, #0xba87, LSL #16
    MOVK  X19, #0xdc89, LSL #32
    MOVK  X19, #0x8f1b, LSL #48
    MOVZ  X20, #0x552b, LSL #0
    MOVK  X20, #0x71, LSL #16
    MOVK  X20, #0x2bfb, LSL #32
    MOVK  X20, #0x9d1, LSL #48
    MOVZ  X21, #0x1e, LSL #0
    MOVK  X21, #0xc6e5, LSL #16
    MOVK  X21, #0x2589, LSL #32
    MOVK  X21, #0xdff1, LSL #48
    MOVZ  X22, #0x32b7, LSL #0
    MOVK  X22, #0x3197, LSL #16
    MOVK  X22, #0xb6a4, LSL #32
    MOVK  X22, #0xfb13, LSL #48
    MOVZ  X23, #0x1341, LSL #0
    MOVK  X23, #0xf719, LSL #16
    MOVK  X23, #0x3701, LSL #32
    MOVK  X23, #0xa7bc, LSL #48
    MOVZ  X24, #0x37af, LSL #0
    MOVK  X24, #0x3ef3, LSL #16
    MOVK  X24, #0x59a4, LSL #32
    MOVK  X24, #0xa478, LSL #48
    MOVZ  X25, #0x6824, LSL #0
    MOVK  X25, #0x3d20, LSL #16
    MOVK  X25, #0x8e6d, LSL #32
    MOVK  X25, #0xfe7f, LSL #48
    MOVZ  X26, #0x14af, LSL #0
    MOVK  X26, #0x93b1, LSL #16
    MOVK  X26, #0xe751, LSL #32
    MOVK  X26, #0x4d98, LSL #48
    MOVZ  X27, #0x871d, LSL #0
    MOVK  X27, #0x6615, LSL #16
    MOVK  X27, #0x7996, LSL #32
    MOVK  X27, #0x992a, LSL #48
    MOVZ  X29, #0xf89, LSL #0
    MOVK  X29, #0xaeaf, LSL #16
    MOVK  X29, #0xa12e, LSL #32
    MOVK  X29, #0xa789, LSL #48
    MOVZ  X7, #0x70ba, LSL #0
    MOVK  X7, #0xad41, LSL #16
    MOVK  X7, #0x6e65, LSL #32
    MOVK  X7, #0x696a, LSL #48
    MSR  FPCR, X7
    MOVZ  X7, #0xbb84, LSL #0
    MOVK  X7, #0x2005, LSL #16
    MOVK  X7, #0x803b, LSL #32
    MOVK  X7, #0x72be, LSL #48
    MSR  FPSR, X7
    MRS  X29, FPSR
    MOVZ  X17, #0xff60, LSL #0
    MOVK  X17, #0x7ff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    AND  X29, X29, X17
    MOVZ  X17, #0x0, LSL #0
    ORR  X29, X29, X17
    MSR  FPSR, X29
    ISB  SY
    ADDS  W25, W25, W4, SXTW #0
    MOV  X30, X1
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X22
    FMOV  V2.D[1], X25
    FMOV  D3, X23
    FMOV  V3.D[1], X4
    FMOV  D4, X16
    FMOV  V4.D[1], X9
    FMOV  D5, X27
    FMOV  V5.D[1], X13
    FMOV  D6, X9
    FMOV  V6.D[1], X10
    FMOV  D7, X5
    FMOV  V7.D[1], X22
    FMOV  D8, X24
    FMOV  V8.D[1], X4
    FMOV  D9, X21
    FMOV  V9.D[1], X23
    FMOV  D10, X25
    FMOV  V10.D[1], X18
    FMOV  D11, X13
    FMOV  V11.D[1], X22
    FMOV  D12, X16
    FMOV  V12.D[1], X9
    FMOV  D13, X12
    FMOV  V13.D[1], X13
    FMOV  D14, X18
    FMOV  V14.D[1], X24
    FMOV  D15, X20
    FMOV  V15.D[1], X22
    FMOV  D16, X27
    FMOV  V16.D[1], X24
    FMOV  D17, X5
    FMOV  V17.D[1], X20
    FMOV  D18, X16
    FMOV  V18.D[1], X10
    FMOV  D19, X9
    FMOV  V19.D[1], X11
    FMOV  D20, X23
    FMOV  V20.D[1], X19
    FMOV  D21, X12
    FMOV  V21.D[1], X2
    FMOV  D22, X15
    FMOV  V22.D[1], X20
    FMOV  D23, X13
    FMOV  V23.D[1], X25
    FMOV  D24, X26
    FMOV  V24.D[1], X22
    FMOV  D25, X10
    FMOV  V25.D[1], X14
    FMOV  D26, X26
    FMOV  V26.D[1], X27
    FMOV  D27, X21
    FMOV  V27.D[1], X19
    FMOV  D28, X13
    FMOV  V28.D[1], X19
    FMOV  D29, X14
    FMOV  V29.D[1], X22
    FMOV  D30, X12
    FMOV  V30.D[1], X23
    FMOV  D31, X11
    FMOV  V31.D[1], X14
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X12, #0x0, LSL #0
    ADD  X29, X30, X12, LSR #0
    ST1 { V29.2S, V30.2S }, [X29]
    LD1 { V7.4H, V8.4H }, [X29]
    ADD  X29, X29, X15, ASR #0
    ST1 { V24.1D, V25.1D }, [X29]
    LD1 { V6.1D, V7.1D }, [X29]
    ADD  X29, X29, X15, ASR #0
    ST1 { V7.2S, V8.2S }, [X29]
    LD1 { V14.2S, V15.2S }, [X29]
    ADD  X29, X29, X15
    ST1 { V11.4H, V12.4H }, [X29]
    LD1 { V27.4H, V28.4H }, [X29]
    ADD  X29, X29, X15, LSR #0
    ST1 { V14.8B, V15.8B }, [X29]
    LD1 { V19.8B, V20.8B }, [X29]
    ADD  X29, X29, X15
    MOV  X5, X29
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X5], #64
    MOV  X5, X29
    LD1 { V15.4S, V16.4S, V17.4S, V18.4S }, [X5], #64
    ADD  X29, X29, X15, LSR #0
    MOV  X5, X29
    ST1 { V15.16B, V16.16B, V17.16B, V18.16B }, [X5], #64
    MOV  X5, X29
    LD1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X5], #64
    ADD  X29, X29, X15, LSR #0
    MOV  X5, X29
    ST1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X5], #64
    MOV  X5, X29
    LD1 { V10.2D, V11.2D, V12.2D, V13.2D }, [X5], #64
    ADD  X29, X29, X15, ASR #0
    MOV  X5, X29
    ST1 { V10.4S, V11.4S, V12.4S, V13.4S }, [X5], #64
    MOV  X5, X29
    LD1 { V10.4S, V11.4S, V12.4S, V13.4S }, [X5], #64
    ADD  X29, X29, X15, ASR #0
    MOV  X5, X29
    ST1 { V10.8H, V11.8H, V12.8H, V13.8H }, [X5], #64
    MOV  X5, X29
    LD1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X5], #64
    ADD  X29, X29, X15
    MOV  X5, X29
    ST1 { V15.1D, V16.1D, V17.1D, V18.1D }, [X5], #32
    MOV  X5, X29
    LD1 { V15.4H, V16.4H, V17.4H, V18.4H }, [X5], #32
    ADD  X29, X29, X15
    MOV  X5, X29
    ST1 { V15.1D, V16.1D, V17.1D, V18.1D }, [X5], #32
    MOV  X5, X29
    LD1 { V6.1D, V7.1D, V8.1D, V9.1D }, [X5], #32
    ADD  X29, X29, X15, ASR #0
    MOV  X5, X29
    ST1 { V14.2S, V15.2S, V16.2S, V17.2S }, [X5], #32
    MOV  X5, X29
    LD1 { V11.2S, V12.2S, V13.2S, V14.2S }, [X5], #32
    ADD  X29, X29, X15, LSR #0
    MOV  X5, X29
    ST1 { V1.4H, V2.4H, V3.4H, V4.4H }, [X5], #32
    MOV  X5, X29
    LD1 { V24.4H, V25.4H, V26.4H, V27.4H }, [X5], #32
    ADD  X29, X29, X15
    MOV  X5, X29
    ST1 { V24.8B, V25.8B, V26.8B, V27.8B }, [X5], #32
    MOV  X5, X29
    LD1 { V15.8B, V16.8B, V17.8B, V18.8B }, [X5], #32
    ADD  X29, X29, X15, LSR #0
    ST1 { V6.2D, V7.2D, V8.2D, V9.2D }, [X29], X14
    LD1 { V0.4S, V1.4S, V2.4S, V3.4S }, [X29], X14
    ADD  X29, X29, X15, ASR #0
    ST1 { V11.16B, V12.16B, V13.16B, V14.16B }, [X29], X14
    LD1 { V11.16B, V12.16B, V13.16B, V14.16B }, [X29], X14
    ADD  X29, X29, X15, ASR #0
    ST1 { V13.2D, V14.2D, V15.2D, V16.2D }, [X29], X14
    LD1 { V23.2D, V24.2D, V25.2D, V26.2D }, [X29], X14
    ADD  X29, X29, X15, ASR #0
    ST1 { V23.4S, V24.4S, V25.4S, V26.4S }, [X29], X14
    LD1 { V11.4S, V12.4S, V13.4S, V14.4S }, [X29], X14
    ADD  X29, X29, X15, LSR #0
    ST1 { V7.8H, V8.8H, V9.8H, V10.8H }, [X29], X14
    LD1 { V7.8H, V8.8H, V9.8H, V10.8H }, [X29], X14
    ADD  X29, X29, X15, ASR #0
    ST1 { V11.2S, V12.2S, V13.2S, V14.2S }, [X29], X14
    LD1 { V24.4H, V25.4H, V26.4H, V27.4H }, [X29], X14
    ADD  X29, X29, X15, LSR #0
    ST1 { V0.1D, V1.1D, V2.1D, V3.1D }, [X29], X14
    LD1 { V13.1D, V14.1D, V15.1D, V16.1D }, [X29], X14
    ADD  X29, X29, X15, ASR #0
    ST1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X29], X14
    LD1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X29], X14
    ADD  X29, X29, X15, ASR #0
    ST1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X29], X14
    LD1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X29], X14
    ADD  X29, X29, X15, ASR #0
    ST1 { V8.8B, V9.8B, V10.8B, V11.8B }, [X29], X14
    LD1 { V26.8B, V27.8B, V28.8B, V29.8B }, [X29], X14
    ADD  X29, X29, X15, ASR #0
    MOV  X5, X29
    ST1 { V24.2D }, [X5], #16
    MOV  X5, X29
    LD1 { V24.2D }, [X5], #16
    ADD  X29, X29, X15, LSR #0
    MOV  X5, X29
    ST1 { V24.16B }, [X5], #16
    MOV  X5, X29
    LD1 { V9.16B }, [X5], #16
    ADD  X29, X29, X15, LSR #0
    MOV  X5, X29
    ST1 { V22.2D }, [X5], #16
    MOV  X5, X29
    LD1 { V10.2D }, [X5], #16
    ADD  X29, X29, X15, LSR #0
    MOV  X5, X29
    ST1 { V9.4S }, [X5], #16
    MOV  X5, X29
    LD1 { V9.4S }, [X5], #16
    ADD  X29, X29, X15, LSR #0
    MOV  X5, X29
    ST1 { V9.8H }, [X5], #16
    MOV  X5, X29
    LD1 { V22.8H }, [X5], #16
    ADD  X29, X29, X15, LSR #0
    MOV  X5, X29
    ST1 { V10.4H }, [X5], #8
    MOV  X5, X29
    LD1 { V9.2S }, [X5], #8
    ADD  X29, X29, X15, LSR #0
    MOV  X5, X29
    ST1 { V22.1D }, [X5], #8
    MOV  X5, X29
    LD1 { V21.1D }, [X5], #8
    ADD  X29, X29, X15, ASR #0
    MOV  X5, X29
    ST1 { V30.2S }, [X5], #8
    MOV  X5, X29
    LD1 { V16.2S }, [X5], #8
    ADD  X29, X29, X15
    MOV  X5, X29
    ST1 { V25.4H }, [X5], #8
    MOV  X5, X29
    LD1 { V6.4H }, [X5], #8
    ADD  X29, X29, X15
    MOV  X5, X29
    ST1 { V24.8B }, [X5], #8
    MOV  X5, X29
    LD1 { V7.8B }, [X5], #8
    ADD  X29, X29, X15
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X13, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D0
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D1
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D2
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D3
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, V4.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D4
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, V5.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D5
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D6
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D7
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D8
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D9
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D10
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D11
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D12
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D13
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D14
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D15
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D16
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D17
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D18
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D19
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D20
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D21
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D22
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D23
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D24
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D25
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D26
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D27
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D28
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D29
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, V30.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D30
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, V31.D[1]
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X13, D31
    SUB  X22, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X27
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X12
    FMOV  D3, X25
    FMOV  V3.D[1], X23
    FMOV  D4, X13
    FMOV  V4.D[1], X29
    FMOV  D5, X21
    FMOV  V5.D[1], X7
    FMOV  D6, X25
    FMOV  V6.D[1], X2
    FMOV  D7, X11
    FMOV  V7.D[1], X17
    FMOV  D8, X5
    FMOV  V8.D[1], X21
    FMOV  D9, X20
    FMOV  V9.D[1], X2
    FMOV  D10, X5
    FMOV  V10.D[1], X14
    FMOV  D11, X10
    FMOV  V11.D[1], X9
    FMOV  D12, X25
    FMOV  V12.D[1], X10
    FMOV  D13, X14
    FMOV  V13.D[1], X18
    FMOV  D14, X9
    FMOV  V14.D[1], X27
    FMOV  D15, X27
    FMOV  V15.D[1], X17
    FMOV  D16, X12
    FMOV  V16.D[1], X16
    FMOV  D17, X26
    FMOV  V17.D[1], X12
    FMOV  D18, X23
    FMOV  V18.D[1], X5
    FMOV  D19, X4
    FMOV  V19.D[1], X29
    FMOV  D20, X10
    FMOV  V20.D[1], X12
    FMOV  D21, X7
    FMOV  V21.D[1], X2
    FMOV  D22, X7
    FMOV  V22.D[1], X4
    FMOV  D23, X26
    FMOV  V23.D[1], X10
    FMOV  D24, X25
    FMOV  V24.D[1], X26
    FMOV  D25, X29
    FMOV  V25.D[1], X22
    FMOV  D26, X18
    FMOV  V26.D[1], X9
    FMOV  D27, X11
    FMOV  V27.D[1], X26
    FMOV  D28, X7
    FMOV  V28.D[1], X7
    FMOV  D29, X29
    FMOV  V29.D[1], X21
    FMOV  D30, X25
    FMOV  V30.D[1], X29
    FMOV  D31, X10
    FMOV  V31.D[1], X20
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X23, #0x500, LSL #0
    ADD  X2, X30, X23
    ST1 { V26.8B, V27.8B }, [X2]
    LD1 { V7.8B, V8.8B }, [X2]
    ADD  X2, X2, X17
    ST1 { V21.1D, V22.1D }, [X2]
    LD1 { V15.1D, V16.1D }, [X2]
    ADD  X2, X2, X17, ASR #0
    ST1 { V17.2S, V18.2S }, [X2]
    LD1 { V17.2S, V18.2S }, [X2]
    ADD  X2, X2, X17
    ST1 { V17.4H, V18.4H }, [X2]
    LD1 { V18.4H, V19.4H }, [X2]
    ADD  X2, X2, X17
    ST1 { V15.8B, V16.8B }, [X2]
    LD1 { V17.8B, V18.8B }, [X2]
    ADD  X2, X2, X17, LSR #0
    MOV  X24, X2
    ST1 { V1.16B, V2.16B, V3.16B, V4.16B }, [X24], #64
    MOV  X24, X2
    LD1 { V5.4S, V6.4S, V7.4S, V8.4S }, [X24], #64
    ADD  X2, X2, X17, LSR #0
    MOV  X24, X2
    ST1 { V5.16B, V6.16B, V7.16B, V8.16B }, [X24], #64
    MOV  X24, X2
    LD1 { V1.16B, V2.16B, V3.16B, V4.16B }, [X24], #64
    ADD  X2, X2, X17
    MOV  X24, X2
    ST1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X24], #64
    MOV  X24, X2
    LD1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X24], #64
    ADD  X2, X2, X17, ASR #0
    MOV  X24, X2
    ST1 { V29.4S, V30.4S, V31.4S, V0.4S }, [X24], #64
    MOV  X24, X2
    LD1 { V5.4S, V6.4S, V7.4S, V8.4S }, [X24], #64
    ADD  X2, X2, X17, ASR #0
    MOV  X24, X2
    ST1 { V5.8H, V6.8H, V7.8H, V8.8H }, [X24], #64
    MOV  X24, X2
    LD1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X24], #64
    ADD  X2, X2, X17, ASR #0
    MOV  X24, X2
    ST1 { V1.8B, V2.8B, V3.8B, V4.8B }, [X24], #32
    MOV  X24, X2
    LD1 { V29.2S, V30.2S, V31.2S, V0.2S }, [X24], #32
    ADD  X2, X2, X17
    MOV  X24, X2
    ST1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X24], #32
    MOV  X24, X2
    LD1 { V1.1D, V2.1D, V3.1D, V4.1D }, [X24], #32
    ADD  X2, X2, X17, ASR #0
    MOV  X24, X2
    ST1 { V14.2S, V15.2S, V16.2S, V17.2S }, [X24], #32
    MOV  X24, X2
    LD1 { V5.2S, V6.2S, V7.2S, V8.2S }, [X24], #32
    ADD  X2, X2, X17
    MOV  X24, X2
    ST1 { V23.4H, V24.4H, V25.4H, V26.4H }, [X24], #32
    MOV  X24, X2
    LD1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X24], #32
    ADD  X2, X2, X17, ASR #0
    MOV  X24, X2
    ST1 { V7.8B, V8.8B, V9.8B, V10.8B }, [X24], #32
    MOV  X24, X2
    LD1 { V7.8B, V8.8B, V9.8B, V10.8B }, [X24], #32
    ADD  X2, X2, X17
    ST1 { V20.16B, V21.16B, V22.16B, V23.16B }, [X2], X7
    LD1 { V21.16B, V22.16B, V23.16B, V24.16B }, [X2], X7
    ADD  X2, X2, X17, ASR #0
    ST1 { V4.16B, V5.16B, V6.16B, V7.16B }, [X2], X7
    LD1 { V14.16B, V15.16B, V16.16B, V17.16B }, [X2], X7
    ADD  X2, X2, X17
    ST1 { V14.2D, V15.2D, V16.2D, V17.2D }, [X2], X7
    LD1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X2], X7
    ADD  X2, X2, X17, LSR #0
    ST1 { V21.4S, V22.4S, V23.4S, V24.4S }, [X2], X7
    LD1 { V3.4S, V4.4S, V5.4S, V6.4S }, [X2], X7
    ADD  X2, X2, X17, ASR #0
    ST1 { V29.8H, V30.8H, V31.8H, V0.8H }, [X2], X7
    LD1 { V20.8H, V21.8H, V22.8H, V23.8H }, [X2], X7
    ADD  X2, X2, X17, LSR #0
    ST1 { V28.8B, V29.8B, V30.8B, V31.8B }, [X2], X7
    LD1 { V28.1D, V29.1D, V30.1D, V31.1D }, [X2], X7
    ADD  X2, X2, X17, ASR #0
    ST1 { V28.1D, V29.1D, V30.1D, V31.1D }, [X2], X7
    LD1 { V28.1D, V29.1D, V30.1D, V31.1D }, [X2], X7
    ADD  X2, X2, X17, ASR #0
    ST1 { V28.2S, V29.2S, V30.2S, V31.2S }, [X2], X7
    LD1 { V0.2S, V1.2S, V2.2S, V3.2S }, [X2], X7
    ADD  X2, X2, X17, LSR #0
    ST1 { V20.4H, V21.4H, V22.4H, V23.4H }, [X2], X7
    LD1 { V20.4H, V21.4H, V22.4H, V23.4H }, [X2], X7
    ADD  X2, X2, X17, ASR #0
    ST1 { V0.8B, V1.8B, V2.8B, V3.8B }, [X2], X7
    LD1 { V10.8B, V11.8B, V12.8B, V13.8B }, [X2], X7
    ADD  X2, X2, X17, ASR #0
    MOV  X24, X2
    ST1 { V20.16B }, [X24], #16
    MOV  X24, X2
    LD1 { V31.8H }, [X24], #16
    ADD  X2, X2, X17, ASR #0
    MOV  X24, X2
    ST1 { V10.16B }, [X24], #16
    MOV  X24, X2
    LD1 { V2.16B }, [X24], #16
    ADD  X2, X2, X17, LSR #0
    MOV  X24, X2
    ST1 { V23.2D }, [X24], #16
    MOV  X24, X2
    LD1 { V23.2D }, [X24], #16
    ADD  X2, X2, X17, LSR #0
    MOV  X24, X2
    ST1 { V13.4S }, [X24], #16
    MOV  X24, X2
    LD1 { V20.4S }, [X24], #16
    ADD  X2, X2, X17, ASR #0
    MOV  X24, X2
    ST1 { V2.8H }, [X24], #16
    MOV  X24, X2
    LD1 { V2.8H }, [X24], #16
    ADD  X2, X2, X17, ASR #0
    MOV  X24, X2
    ST1 { V23.2S }, [X24], #8
    MOV  X24, X2
    LD1 { V13.8B }, [X24], #8
    ADD  X2, X2, X17
    MOV  X24, X2
    ST1 { V2.1D }, [X24], #8
    MOV  X24, X2
    LD1 { V7.1D }, [X24], #8
    ADD  X2, X2, X17, LSR #0
    MOV  X24, X2
    ST1 { V20.2S }, [X24], #8
    MOV  X24, X2
    LD1 { V4.2S }, [X24], #8
    ADD  X2, X2, X17, LSR #0
    MOV  X24, X2
    ST1 { V7.4H }, [X24], #8
    MOV  X24, X2
    LD1 { V24.4H }, [X24], #8
    ADD  X2, X2, X17
    MOV  X24, X2
    ST1 { V24.8B }, [X24], #8
    MOV  X24, X2
    LD1 { V28.8B }, [X24], #8
    ADD  X2, X2, X17, ASR #0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X13, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D0
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D1
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D2
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D3
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D4
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, V5.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D5
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, V6.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D6
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D7
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D8
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D9
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D10
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D11
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D12
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D13
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D14
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D15
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D16
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D17
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D18
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D19
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D20
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D21
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D22
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D23
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D24
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, V25.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D25
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, V26.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D26
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, V27.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D27
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D28
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D29
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D30
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X13, D31
    SUB  X11, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X25
    FMOV  V2.D[1], X15
    FMOV  D3, X25
    FMOV  V3.D[1], X18
    FMOV  D4, X17
    FMOV  V4.D[1], X20
    FMOV  D5, X15
    FMOV  V5.D[1], X22
    FMOV  D6, X13
    FMOV  V6.D[1], X19
    FMOV  D7, X18
    FMOV  V7.D[1], X15
    FMOV  D8, X29
    FMOV  V8.D[1], X11
    FMOV  D9, X11
    FMOV  V9.D[1], X22
    FMOV  D10, X25
    FMOV  V10.D[1], X13
    FMOV  D11, X19
    FMOV  V11.D[1], X16
    FMOV  D12, X23
    FMOV  V12.D[1], X18
    FMOV  D13, X12
    FMOV  V13.D[1], X25
    FMOV  D14, X25
    FMOV  V14.D[1], X16
    FMOV  D15, X4
    FMOV  V15.D[1], X24
    FMOV  D16, X7
    FMOV  V16.D[1], X4
    FMOV  D17, X13
    FMOV  V17.D[1], X25
    FMOV  D18, X27
    FMOV  V18.D[1], X15
    FMOV  D19, X17
    FMOV  V19.D[1], X5
    FMOV  D20, X17
    FMOV  V20.D[1], X23
    FMOV  D21, X12
    FMOV  V21.D[1], X19
    FMOV  D22, X12
    FMOV  V22.D[1], X12
    FMOV  D23, X22
    FMOV  V23.D[1], X25
    FMOV  D24, X21
    FMOV  V24.D[1], X10
    FMOV  D25, X9
    FMOV  V25.D[1], X2
    FMOV  D26, X5
    FMOV  V26.D[1], X27
    FMOV  D27, X10
    FMOV  V27.D[1], X18
    FMOV  D28, X22
    FMOV  V28.D[1], X7
    FMOV  D29, X11
    FMOV  V29.D[1], X7
    FMOV  D30, X13
    FMOV  V30.D[1], X17
    FMOV  D31, X29
    FMOV  V31.D[1], X23
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X12, #0xa00, LSL #0
    ADD  X22, X30, X12, LSR #0
    ST1 { V4.1D, V5.1D }, [X22]
    LD1 { V22.8B, V23.8B }, [X22]
    ADD  X22, X22, X4
    ST1 { V29.1D, V30.1D }, [X22]
    LD1 { V4.1D, V5.1D }, [X22]
    ADD  X22, X22, X4
    ST1 { V10.2S, V11.2S }, [X22]
    LD1 { V25.2S, V26.2S }, [X22]
    ADD  X22, X22, X4
    ST1 { V0.4H, V1.4H }, [X22]
    LD1 { V16.4H, V17.4H }, [X22]
    ADD  X22, X22, X4, LSR #0
    ST1 { V4.8B, V5.8B }, [X22]
    LD1 { V18.8B, V19.8B }, [X22]
    ADD  X22, X22, X4
    MOV  X29, X22
    ST1 { V27.16B, V28.16B, V29.16B, V30.16B }, [X29], #64
    MOV  X29, X22
    LD1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X29], #64
    ADD  X22, X22, X4
    MOV  X29, X22
    ST1 { V4.16B, V5.16B, V6.16B, V7.16B }, [X29], #64
    MOV  X29, X22
    LD1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X29], #64
    ADD  X22, X22, X4, ASR #0
    MOV  X29, X22
    ST1 { V15.2D, V16.2D, V17.2D, V18.2D }, [X29], #64
    MOV  X29, X22
    LD1 { V25.2D, V26.2D, V27.2D, V28.2D }, [X29], #64
    ADD  X22, X22, X4, ASR #0
    MOV  X29, X22
    ST1 { V25.4S, V26.4S, V27.4S, V28.4S }, [X29], #64
    MOV  X29, X22
    LD1 { V20.4S, V21.4S, V22.4S, V23.4S }, [X29], #64
    ADD  X22, X22, X4
    MOV  X29, X22
    ST1 { V20.8H, V21.8H, V22.8H, V23.8H }, [X29], #64
    MOV  X29, X22
    LD1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X29], #64
    ADD  X22, X22, X4
    MOV  X29, X22
    ST1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X29], #32
    MOV  X29, X22
    LD1 { V25.4H, V26.4H, V27.4H, V28.4H }, [X29], #32
    ADD  X22, X22, X4
    MOV  X29, X22
    ST1 { V15.1D, V16.1D, V17.1D, V18.1D }, [X29], #32
    MOV  X29, X22
    LD1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X29], #32
    ADD  X22, X22, X4, ASR #0
    MOV  X29, X22
    ST1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X29], #32
    MOV  X29, X22
    LD1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X29], #32
    ADD  X22, X22, X4, LSR #0
    MOV  X29, X22
    ST1 { V15.4H, V16.4H, V17.4H, V18.4H }, [X29], #32
    MOV  X29, X22
    LD1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X29], #32
    ADD  X22, X22, X4
    MOV  X29, X22
    ST1 { V25.8B, V26.8B, V27.8B, V28.8B }, [X29], #32
    MOV  X29, X22
    LD1 { V25.8B, V26.8B, V27.8B, V28.8B }, [X29], #32
    ADD  X22, X22, X4, LSR #0
    ST1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X22], X5
    LD1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X22], X5
    ADD  X22, X22, X4, LSR #0
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X22], X5
    LD1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X22], X5
    ADD  X22, X22, X4
    ST1 { V25.2D, V26.2D, V27.2D, V28.2D }, [X22], X5
    LD1 { V25.2D, V26.2D, V27.2D, V28.2D }, [X22], X5
    ADD  X22, X22, X4, LSR #0
    ST1 { V9.4S, V10.4S, V11.4S, V12.4S }, [X22], X5
    LD1 { V15.4S, V16.4S, V17.4S, V18.4S }, [X22], X5
    ADD  X22, X22, X4, ASR #0
    ST1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X22], X5
    LD1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X22], X5
    ADD  X22, X22, X4, LSR #0
    ST1 { V9.8B, V10.8B, V11.8B, V12.8B }, [X22], X5
    LD1 { V15.8B, V16.8B, V17.8B, V18.8B }, [X22], X5
    ADD  X22, X22, X4, LSR #0
    ST1 { V25.1D, V26.1D, V27.1D, V28.1D }, [X22], X5
    LD1 { V25.1D, V26.1D, V27.1D, V28.1D }, [X22], X5
    ADD  X22, X22, X4, ASR #0
    ST1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X22], X5
    LD1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X22], X5
    ADD  X22, X22, X4, ASR #0
    ST1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X22], X5
    LD1 { V15.4H, V16.4H, V17.4H, V18.4H }, [X22], X5
    ADD  X22, X22, X4
    ST1 { V15.8B, V16.8B, V17.8B, V18.8B }, [X22], X5
    LD1 { V9.8B, V10.8B, V11.8B, V12.8B }, [X22], X5
    ADD  X22, X22, X4, ASR #0
    MOV  X29, X22
    ST1 { V12.16B }, [X29], #16
    MOV  X29, X22
    LD1 { V12.4S }, [X29], #16
    ADD  X22, X22, X4
    MOV  X29, X22
    ST1 { V31.16B }, [X29], #16
    MOV  X29, X22
    LD1 { V31.16B }, [X29], #16
    ADD  X22, X22, X4
    MOV  X29, X22
    ST1 { V31.2D }, [X29], #16
    MOV  X29, X22
    LD1 { V31.2D }, [X29], #16
    ADD  X22, X22, X4, ASR #0
    MOV  X29, X22
    ST1 { V26.4S }, [X29], #16
    MOV  X29, X22
    LD1 { V26.4S }, [X29], #16
    ADD  X22, X22, X4, ASR #0
    MOV  X29, X22
    ST1 { V9.8H }, [X29], #16
    MOV  X29, X22
    LD1 { V9.8H }, [X29], #16
    ADD  X22, X22, X4, LSR #0
    MOV  X29, X22
    ST1 { V26.1D }, [X29], #8
    MOV  X29, X22
    LD1 { V26.1D }, [X29], #8
    ADD  X22, X22, X4, ASR #0
    MOV  X29, X22
    ST1 { V26.1D }, [X29], #8
    MOV  X29, X22
    LD1 { V28.1D }, [X29], #8
    ADD  X22, X22, X4, ASR #0
    MOV  X29, X22
    ST1 { V28.2S }, [X29], #8
    MOV  X29, X22
    LD1 { V18.2S }, [X29], #8
    ADD  X22, X22, X4
    MOV  X29, X22
    ST1 { V18.4H }, [X29], #8
    MOV  X29, X22
    LD1 { V14.4H }, [X29], #8
    ADD  X22, X22, X4, LSR #0
    MOV  X29, X22
    ST1 { V14.8B }, [X29], #8
    MOV  X29, X22
    LD1 { V20.8B }, [X29], #8
    ADD  X22, X22, X4, ASR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X23, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X23, FPSR
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V0.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D0
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V1.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D1
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V2.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D2
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V3.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D3
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D4
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D5
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V6.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D6
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V7.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D7
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V8.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D8
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D9
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D10
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V11.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D11
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V12.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D12
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V13.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D13
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D14
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D15
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D16
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V17.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D17
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V18.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D18
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D19
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V20.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D20
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V21.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D21
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V22.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D22
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V23.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D23
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V24.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D24
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D25
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D26
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D27
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X23, V28.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D28
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V29.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D29
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V30.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D30
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, V31.D[1]
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X23, D31
    SUB  X13, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X23
    FMOV  D1, X22
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X26
    FMOV  D3, X26
    FMOV  V3.D[1], X9
    FMOV  D4, X16
    FMOV  V4.D[1], X25
    FMOV  D5, X22
    FMOV  V5.D[1], X10
    FMOV  D6, X18
    FMOV  V6.D[1], X15
    FMOV  D7, X24
    FMOV  V7.D[1], X20
    FMOV  D8, X9
    FMOV  V8.D[1], X9
    FMOV  D9, X21
    FMOV  V9.D[1], X19
    FMOV  D10, X11
    FMOV  V10.D[1], X17
    FMOV  D11, X20
    FMOV  V11.D[1], X26
    FMOV  D12, X4
    FMOV  V12.D[1], X13
    FMOV  D13, X2
    FMOV  V13.D[1], X15
    FMOV  D14, X18
    FMOV  V14.D[1], X2
    FMOV  D15, X27
    FMOV  V15.D[1], X11
    FMOV  D16, X9
    FMOV  V16.D[1], X22
    FMOV  D17, X15
    FMOV  V17.D[1], X26
    FMOV  D18, X15
    FMOV  V18.D[1], X22
    FMOV  D19, X23
    FMOV  V19.D[1], X14
    FMOV  D20, X16
    FMOV  V20.D[1], X25
    FMOV  D21, X14
    FMOV  V21.D[1], X26
    FMOV  D22, X12
    FMOV  V22.D[1], X26
    FMOV  D23, X21
    FMOV  V23.D[1], X29
    FMOV  D24, X25
    FMOV  V24.D[1], X25
    FMOV  D25, X22
    FMOV  V25.D[1], X20
    FMOV  D26, X19
    FMOV  V26.D[1], X26
    FMOV  D27, X13
    FMOV  V27.D[1], X23
    FMOV  D28, X7
    FMOV  V28.D[1], X2
    FMOV  D29, X21
    FMOV  V29.D[1], X18
    FMOV  D30, X21
    FMOV  V30.D[1], X14
    FMOV  D31, X13
    FMOV  V31.D[1], X2
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X24, #0xf00, LSL #0
    ADD  X15, X30, X24, ASR #0
    ST1 { V26.2S, V27.2S }, [X15]
    LD1 { V31.2S, V0.2S }, [X15]
    ADD  X15, X15, X20
    ST1 { V31.1D, V0.1D }, [X15]
    LD1 { V17.1D, V18.1D }, [X15]
    ADD  X15, X15, X20
    ST1 { V17.2S, V18.2S }, [X15]
    LD1 { V15.2S, V16.2S }, [X15]
    ADD  X15, X15, X20, ASR #0
    ST1 { V28.4H, V29.4H }, [X15]
    LD1 { V27.4H, V28.4H }, [X15]
    ADD  X15, X15, X20, LSR #0
    ST1 { V27.8B, V28.8B }, [X15]
    LD1 { V8.8B, V9.8B }, [X15]
    ADD  X15, X15, X20
    MOV  X2, X15
    ST1 { V4.8H, V5.8H, V6.8H, V7.8H }, [X2], #64
    MOV  X2, X15
    LD1 { V17.8H, V18.8H, V19.8H, V20.8H }, [X2], #64
    ADD  X15, X15, X20, ASR #0
    MOV  X2, X15
    ST1 { V15.16B, V16.16B, V17.16B, V18.16B }, [X2], #64
    MOV  X2, X15
    LD1 { V10.16B, V11.16B, V12.16B, V13.16B }, [X2], #64
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V10.2D, V11.2D, V12.2D, V13.2D }, [X2], #64
    MOV  X2, X15
    LD1 { V6.2D, V7.2D, V8.2D, V9.2D }, [X2], #64
    ADD  X15, X15, X20, ASR #0
    MOV  X2, X15
    ST1 { V24.4S, V25.4S, V26.4S, V27.4S }, [X2], #64
    MOV  X2, X15
    LD1 { V15.4S, V16.4S, V17.4S, V18.4S }, [X2], #64
    ADD  X15, X15, X20
    MOV  X2, X15
    ST1 { V6.8H, V7.8H, V8.8H, V9.8H }, [X2], #64
    MOV  X2, X15
    LD1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X2], #64
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X2], #32
    MOV  X2, X15
    LD1 { V10.2S, V11.2S, V12.2S, V13.2S }, [X2], #32
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V15.1D, V16.1D, V17.1D, V18.1D }, [X2], #32
    MOV  X2, X15
    LD1 { V24.1D, V25.1D, V26.1D, V27.1D }, [X2], #32
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V10.2S, V11.2S, V12.2S, V13.2S }, [X2], #32
    MOV  X2, X15
    LD1 { V27.2S, V28.2S, V29.2S, V30.2S }, [X2], #32
    ADD  X15, X15, X20
    MOV  X2, X15
    ST1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X2], #32
    MOV  X2, X15
    LD1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X2], #32
    ADD  X15, X15, X20
    MOV  X2, X15
    ST1 { V16.8B, V17.8B, V18.8B, V19.8B }, [X2], #32
    MOV  X2, X15
    LD1 { V16.8B, V17.8B, V18.8B, V19.8B }, [X2], #32
    ADD  X15, X15, X20, LSR #0
    ST1 { V16.2D, V17.2D, V18.2D, V19.2D }, [X15], X18
    LD1 { V16.2D, V17.2D, V18.2D, V19.2D }, [X15], X18
    ADD  X15, X15, X20, LSR #0
    ST1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X15], X18
    LD1 { V10.16B, V11.16B, V12.16B, V13.16B }, [X15], X18
    ADD  X15, X15, X20
    ST1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X15], X18
    LD1 { V10.2D, V11.2D, V12.2D, V13.2D }, [X15], X18
    ADD  X15, X15, X20, LSR #0
    ST1 { V16.4S, V17.4S, V18.4S, V19.4S }, [X15], X18
    LD1 { V16.4S, V17.4S, V18.4S, V19.4S }, [X15], X18
    ADD  X15, X15, X20
    ST1 { V10.8H, V11.8H, V12.8H, V13.8H }, [X15], X18
    LD1 { V26.8H, V27.8H, V28.8H, V29.8H }, [X15], X18
    ADD  X15, X15, X20
    ST1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X15], X18
    LD1 { V10.4H, V11.4H, V12.4H, V13.4H }, [X15], X18
    ADD  X15, X15, X20, ASR #0
    ST1 { V26.1D, V27.1D, V28.1D, V29.1D }, [X15], X18
    LD1 { V16.1D, V17.1D, V18.1D, V19.1D }, [X15], X18
    ADD  X15, X15, X20
    ST1 { V10.2S, V11.2S, V12.2S, V13.2S }, [X15], X18
    LD1 { V10.2S, V11.2S, V12.2S, V13.2S }, [X15], X18
    ADD  X15, X15, X20, ASR #0
    ST1 { V27.4H, V28.4H, V29.4H, V30.4H }, [X15], X18
    LD1 { V26.4H, V27.4H, V28.4H, V29.4H }, [X15], X18
    ADD  X15, X15, X20
    ST1 { V26.8B, V27.8B, V28.8B, V29.8B }, [X15], X18
    LD1 { V26.8B, V27.8B, V28.8B, V29.8B }, [X15], X18
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V19.2D }, [X2], #16
    MOV  X2, X15
    LD1 { V19.8H }, [X2], #16
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V18.16B }, [X2], #16
    MOV  X2, X15
    LD1 { V18.16B }, [X2], #16
    ADD  X15, X15, X20
    MOV  X2, X15
    ST1 { V19.2D }, [X2], #16
    MOV  X2, X15
    LD1 { V23.2D }, [X2], #16
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V18.4S }, [X2], #16
    MOV  X2, X15
    LD1 { V8.4S }, [X2], #16
    ADD  X15, X15, X20
    MOV  X2, X15
    ST1 { V8.8H }, [X2], #16
    MOV  X2, X15
    LD1 { V2.8H }, [X2], #16
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V2.8B }, [X2], #8
    MOV  X2, X15
    LD1 { V19.8B }, [X2], #8
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V19.1D }, [X2], #8
    MOV  X2, X15
    LD1 { V8.1D }, [X2], #8
    ADD  X15, X15, X20
    MOV  X2, X15
    ST1 { V6.2S }, [X2], #8
    MOV  X2, X15
    LD1 { V7.2S }, [X2], #8
    ADD  X15, X15, X20
    MOV  X2, X15
    ST1 { V8.4H }, [X2], #8
    MOV  X2, X15
    LD1 { V10.4H }, [X2], #8
    ADD  X15, X15, X20, LSR #0
    MOV  X2, X15
    ST1 { V30.8B }, [X2], #8
    MOV  X2, X15
    LD1 { V13.8B }, [X2], #8
    ADD  X15, X15, X20, ASR #0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X17, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D0
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, V1.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D1
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D2
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, V3.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D3
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, V4.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D4
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, V5.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D5
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D6
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D7
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D8
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D9
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D10
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D11
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D12
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D13
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, V14.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D14
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, V15.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D15
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D16
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D17
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D18
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D19
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, V20.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D20
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, V21.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D21
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, V22.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D22
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D23
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D24
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D25
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D26
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D27
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D28
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D29
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D30
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    FMOV  X17, D31
    SUB  X12, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X22
    FMOV  D2, X29
    FMOV  V2.D[1], X25
    FMOV  D3, X14
    FMOV  V3.D[1], X26
    FMOV  D4, X2
    FMOV  V4.D[1], X26
    FMOV  D5, X26
    FMOV  V5.D[1], X29
    FMOV  D6, X7
    FMOV  V6.D[1], X7
    FMOV  D7, X18
    FMOV  V7.D[1], X11
    FMOV  D8, X14
    FMOV  V8.D[1], X26
    FMOV  D9, X15
    FMOV  V9.D[1], X27
    FMOV  D10, X9
    FMOV  V10.D[1], X14
    FMOV  D11, X25
    FMOV  V11.D[1], X29
    FMOV  D12, X17
    FMOV  V12.D[1], X2
    FMOV  D13, X24
    FMOV  V13.D[1], X4
    FMOV  D14, X21
    FMOV  V14.D[1], X10
    FMOV  D15, X20
    FMOV  V15.D[1], X24
    FMOV  D16, X20
    FMOV  V16.D[1], X23
    FMOV  D17, X27
    FMOV  V17.D[1], X2
    FMOV  D18, X7
    FMOV  V18.D[1], X18
    FMOV  D19, X20
    FMOV  V19.D[1], X29
    FMOV  D20, X2
    FMOV  V20.D[1], X9
    FMOV  D21, X27
    FMOV  V21.D[1], X13
    FMOV  D22, X15
    FMOV  V22.D[1], X9
    FMOV  D23, X15
    FMOV  V23.D[1], X10
    FMOV  D24, X2
    FMOV  V24.D[1], X4
    FMOV  D25, X18
    FMOV  V25.D[1], X4
    FMOV  D26, X5
    FMOV  V26.D[1], X5
    FMOV  D27, X11
    FMOV  V27.D[1], X22
    FMOV  D28, X21
    FMOV  V28.D[1], X21
    FMOV  D29, X19
    FMOV  V29.D[1], X23
    FMOV  D30, X12
    FMOV  V30.D[1], X25
    FMOV  D31, X21
    FMOV  V31.D[1], X18
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X18, #0x1400, LSL #0
    ADD  X23, X30, X18, LSR #0
    ST1 { V22.1D, V23.1D }, [X23]
    LD1 { V16.8B, V17.8B }, [X23]
    ADD  X23, X23, X5, LSR #0
    ST1 { V16.1D, V17.1D }, [X23]
    LD1 { V27.1D, V28.1D }, [X23]
    ADD  X23, X23, X5
    ST1 { V24.2S, V25.2S }, [X23]
    LD1 { V24.2S, V25.2S }, [X23]
    ADD  X23, X23, X5, ASR #0
    ST1 { V1.4H, V2.4H }, [X23]
    LD1 { V20.4H, V21.4H }, [X23]
    ADD  X23, X23, X5, LSR #0
    ST1 { V30.8B, V31.8B }, [X23]
    LD1 { V17.8B, V18.8B }, [X23]
    ADD  X23, X23, X5, ASR #0
    MOV  X4, X23
    ST1 { V12.2D, V13.2D, V14.2D, V15.2D }, [X4], #64
    MOV  X4, X23
    LD1 { V24.16B, V25.16B, V26.16B, V27.16B }, [X4], #64
    ADD  X23, X23, X5, LSR #0
    MOV  X4, X23
    ST1 { V19.16B, V20.16B, V21.16B, V22.16B }, [X4], #64
    MOV  X4, X23
    LD1 { V31.16B, V0.16B, V1.16B, V2.16B }, [X4], #64
    ADD  X23, X23, X5, ASR #0
    MOV  X4, X23
    ST1 { V24.2D, V25.2D, V26.2D, V27.2D }, [X4], #64
    MOV  X4, X23
    LD1 { V19.2D, V20.2D, V21.2D, V22.2D }, [X4], #64
    ADD  X23, X23, X5
    MOV  X4, X23
    ST1 { V20.4S, V21.4S, V22.4S, V23.4S }, [X4], #64
    MOV  X4, X23
    LD1 { V23.4S, V24.4S, V25.4S, V26.4S }, [X4], #64
    ADD  X23, X23, X5, ASR #0
    MOV  X4, X23
    ST1 { V10.8H, V11.8H, V12.8H, V13.8H }, [X4], #64
    MOV  X4, X23
    LD1 { V10.8H, V11.8H, V12.8H, V13.8H }, [X4], #64
    ADD  X23, X23, X5
    MOV  X4, X23
    ST1 { V10.4H, V11.4H, V12.4H, V13.4H }, [X4], #32
    MOV  X4, X23
    LD1 { V11.2S, V12.2S, V13.2S, V14.2S }, [X4], #32
    ADD  X23, X23, X5
    MOV  X4, X23
    ST1 { V23.1D, V24.1D, V25.1D, V26.1D }, [X4], #32
    MOV  X4, X23
    LD1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X4], #32
    ADD  X23, X23, X5
    MOV  X4, X23
    ST1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X4], #32
    MOV  X4, X23
    LD1 { V23.2S, V24.2S, V25.2S, V26.2S }, [X4], #32
    ADD  X23, X23, X5
    MOV  X4, X23
    ST1 { V23.4H, V24.4H, V25.4H, V26.4H }, [X4], #32
    MOV  X4, X23
    LD1 { V4.4H, V5.4H, V6.4H, V7.4H }, [X4], #32
    ADD  X23, X23, X5, LSR #0
    MOV  X4, X23
    ST1 { V4.8B, V5.8B, V6.8B, V7.8B }, [X4], #32
    MOV  X4, X23
    LD1 { V23.8B, V24.8B, V25.8B, V26.8B }, [X4], #32
    ADD  X23, X23, X5, ASR #0
    ST1 { V23.8H, V24.8H, V25.8H, V26.8H }, [X23], X13
    LD1 { V22.2D, V23.2D, V24.2D, V25.2D }, [X23], X13
    ADD  X23, X23, X5, ASR #0
    ST1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X23], X13
    LD1 { V6.16B, V7.16B, V8.16B, V9.16B }, [X23], X13
    ADD  X23, X23, X5, ASR #0
    ST1 { V6.2D, V7.2D, V8.2D, V9.2D }, [X23], X13
    LD1 { V6.2D, V7.2D, V8.2D, V9.2D }, [X23], X13
    ADD  X23, X23, X5, LSR #0
    ST1 { V6.4S, V7.4S, V8.4S, V9.4S }, [X23], X13
    LD1 { V7.4S, V8.4S, V9.4S, V10.4S }, [X23], X13
    ADD  X23, X23, X5, LSR #0
    ST1 { V7.8H, V8.8H, V9.8H, V10.8H }, [X23], X13
    LD1 { V23.8H, V24.8H, V25.8H, V26.8H }, [X23], X13
    ADD  X23, X23, X5
    ST1 { V27.4H, V28.4H, V29.4H, V30.4H }, [X23], X13
    LD1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X23], X13
    ADD  X23, X23, X5, ASR #0
    ST1 { V24.1D, V25.1D, V26.1D, V27.1D }, [X23], X13
    LD1 { V6.1D, V7.1D, V8.1D, V9.1D }, [X23], X13
    ADD  X23, X23, X5
    ST1 { V0.2S, V1.2S, V2.2S, V3.2S }, [X23], X13
    LD1 { V13.2S, V14.2S, V15.2S, V16.2S }, [X23], X13
    ADD  X23, X23, X5, LSR #0
    ST1 { V12.4H, V13.4H, V14.4H, V15.4H }, [X23], X13
    LD1 { V0.4H, V1.4H, V2.4H, V3.4H }, [X23], X13
    ADD  X23, X23, X5, ASR #0
    ST1 { V6.8B, V7.8B, V8.8B, V9.8B }, [X23], X13
    LD1 { V2.8B, V3.8B, V4.8B, V5.8B }, [X23], X13
    ADD  X23, X23, X5
    MOV  X4, X23
    ST1 { V16.4S }, [X4], #16
    MOV  X4, X23
    LD1 { V8.2D }, [X4], #16
    ADD  X23, X23, X5, ASR #0
    MOV  X4, X23
    ST1 { V1.16B }, [X4], #16
    MOV  X4, X23
    LD1 { V24.16B }, [X4], #16
    ADD  X23, X23, X5, ASR #0
    MOV  X4, X23
    ST1 { V5.2D }, [X4], #16
    MOV  X4, X23
    LD1 { V7.2D }, [X4], #16
    ADD  X23, X23, X5, LSR #0
    MOV  X4, X23
    ST1 { V3.4S }, [X4], #16
    MOV  X4, X23
    LD1 { V1.4S }, [X4], #16
    ADD  X23, X23, X5, ASR #0
    MOV  X4, X23
    ST1 { V24.8H }, [X4], #16
    MOV  X4, X23
    LD1 { V5.8H }, [X4], #16
    ADD  X23, X23, X5
    MOV  X4, X23
    ST1 { V5.8B }, [X4], #8
    MOV  X4, X23
    LD1 { V3.2S }, [X4], #8
    ADD  X23, X23, X5, LSR #0
    MOV  X4, X23
    ST1 { V1.1D }, [X4], #8
    MOV  X4, X23
    LD1 { V5.1D }, [X4], #8
    ADD  X23, X23, X5, ASR #0
    MOV  X4, X23
    ST1 { V3.2S }, [X4], #8
    MOV  X4, X23
    LD1 { V1.2S }, [X4], #8
    ADD  X23, X23, X5, LSR #0
    MOV  X4, X23
    ST1 { V7.4H }, [X4], #8
    MOV  X4, X23
    LD1 { V11.4H }, [X4], #8
    ADD  X23, X23, X5
    MOV  X4, X23
    ST1 { V1.8B }, [X4], #8
    MOV  X4, X23
    LD1 { V1.8B }, [X4], #8
    ADD  X23, X23, X5, ASR #0
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X29, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    MRS  X29, FPSR
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D0
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D1
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D2
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D3
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D4
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D5
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D6
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D7
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D8
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D9
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D10
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D11
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D12
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D13
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D14
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D15
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D16
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D17
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D18
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, V19.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D19
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, V20.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D20
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, V21.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D21
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D22
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D23
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D24
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D25
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D26
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, V27.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D27
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D28
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, V29.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D29
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, V30.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D30
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, V31.D[1]
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    FMOV  X29, D31
    SUB  X12, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X23
    FMOV  D3, X20
    FMOV  V3.D[1], X21
    FMOV  D4, X19
    FMOV  V4.D[1], X19
    FMOV  D5, X11
    FMOV  V5.D[1], X13
    FMOV  D6, X14
    FMOV  V6.D[1], X9
    FMOV  D7, X7
    FMOV  V7.D[1], X5
    FMOV  D8, X19
    FMOV  V8.D[1], X19
    FMOV  D9, X10
    FMOV  V9.D[1], X23
    FMOV  D10, X20
    FMOV  V10.D[1], X24
    FMOV  D11, X26
    FMOV  V11.D[1], X11
    FMOV  D12, X24
    FMOV  V12.D[1], X24
    FMOV  D13, X26
    FMOV  V13.D[1], X20
    FMOV  D14, X4
    FMOV  V14.D[1], X25
    FMOV  D15, X19
    FMOV  V15.D[1], X19
    FMOV  D16, X11
    FMOV  V16.D[1], X14
    FMOV  D17, X2
    FMOV  V17.D[1], X14
    FMOV  D18, X7
    FMOV  V18.D[1], X20
    FMOV  D19, X5
    FMOV  V19.D[1], X5
    FMOV  D20, X13
    FMOV  V20.D[1], X18
    FMOV  D21, X21
    FMOV  V21.D[1], X11
    FMOV  D22, X27
    FMOV  V22.D[1], X26
    FMOV  D23, X26
    FMOV  V23.D[1], X23
    FMOV  D24, X9
    FMOV  V24.D[1], X5
    FMOV  D25, X10
    FMOV  V25.D[1], X24
    FMOV  D26, X21
    FMOV  V26.D[1], X26
    FMOV  D27, X18
    FMOV  V27.D[1], X14
    FMOV  D28, X10
    FMOV  V28.D[1], X23
    FMOV  D29, X10
    FMOV  V29.D[1], X10
    FMOV  D30, X12
    FMOV  V30.D[1], X4
    FMOV  D31, X5
    FMOV  V31.D[1], X2
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X25, #0x1900, LSL #0
    ADD  X12, X30, X25, ASR #0
    ST1 { V13.8B, V14.8B }, [X12]
    LD1 { V1.1D, V2.1D }, [X12]
    ADD  X12, X12, X15, ASR #0
    ST1 { V17.1D, V18.1D }, [X12]
    LD1 { V28.1D, V29.1D }, [X12]
    ADD  X12, X12, X15
    ST1 { V28.2S, V29.2S }, [X12]
    LD1 { V20.2S, V21.2S }, [X12]
    ADD  X12, X12, X15
    ST1 { V20.4H, V21.4H }, [X12]
    LD1 { V20.4H, V21.4H }, [X12]
    ADD  X12, X12, X15
    ST1 { V24.8B, V25.8B }, [X12]
    LD1 { V31.8B, V0.8B }, [X12]
    ADD  X12, X12, X15
    MOV  X13, X12
    ST1 { V31.8H, V0.8H, V1.8H, V2.8H }, [X13], #64
    MOV  X13, X12
    LD1 { V0.16B, V1.16B, V2.16B, V3.16B }, [X13], #64
    ADD  X12, X12, X15
    MOV  X13, X12
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X13], #64
    MOV  X13, X12
    LD1 { V8.16B, V9.16B, V10.16B, V11.16B }, [X13], #64
    ADD  X12, X12, X15
    MOV  X13, X12
    ST1 { V8.2D, V9.2D, V10.2D, V11.2D }, [X13], #64
    MOV  X13, X12
    LD1 { V24.2D, V25.2D, V26.2D, V27.2D }, [X13], #64
    ADD  X12, X12, X15
    MOV  X13, X12
    ST1 { V24.4S, V25.4S, V26.4S, V27.4S }, [X13], #64
    MOV  X13, X12
    LD1 { V9.4S, V10.4S, V11.4S, V12.4S }, [X13], #64
    ADD  X12, X12, X15, LSR #0
    MOV  X13, X12
    ST1 { V0.8H, V1.8H, V2.8H, V3.8H }, [X13], #64
    MOV  X13, X12
    LD1 { V24.8H, V25.8H, V26.8H, V27.8H }, [X13], #64
    ADD  X12, X12, X15, ASR #0
    MOV  X13, X12
    ST1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X13], #32
    MOV  X13, X12
    LD1 { V27.1D, V28.1D, V29.1D, V30.1D }, [X13], #32
    ADD  X12, X12, X15, ASR #0
    MOV  X13, X12
    ST1 { V27.1D, V28.1D, V29.1D, V30.1D }, [X13], #32
    MOV  X13, X12
    LD1 { V27.1D, V28.1D, V29.1D, V30.1D }, [X13], #32
    ADD  X12, X12, X15
    MOV  X13, X12
    ST1 { V27.2S, V28.2S, V29.2S, V30.2S }, [X13], #32
    MOV  X13, X12
    LD1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X13], #32
    ADD  X12, X12, X15, LSR #0
    MOV  X13, X12
    ST1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X13], #32
    MOV  X13, X12
    LD1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X13], #32
    ADD  X12, X12, X15, ASR #0
    MOV  X13, X12
    ST1 { V3.8B, V4.8B, V5.8B, V6.8B }, [X13], #32
    MOV  X13, X12
    LD1 { V27.8B, V28.8B, V29.8B, V30.8B }, [X13], #32
    ADD  X12, X12, X15
    ST1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X12], X10
    LD1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X12], X10
    ADD  X12, X12, X15, LSR #0
    ST1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X12], X10
    LD1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X12], X10
    ADD  X12, X12, X15, ASR #0
    ST1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X12], X10
    LD1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X12], X10
    ADD  X12, X12, X15, ASR #0
    ST1 { V9.4S, V10.4S, V11.4S, V12.4S }, [X12], X10
    LD1 { V9.4S, V10.4S, V11.4S, V12.4S }, [X12], X10
    ADD  X12, X12, X15, ASR #0
    ST1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X12], X10
    LD1 { V3.8H, V4.8H, V5.8H, V6.8H }, [X12], X10
    ADD  X12, X12, X15, ASR #0
    ST1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X12], X10
    LD1 { V27.8B, V28.8B, V29.8B, V30.8B }, [X12], X10
    ADD  X12, X12, X15, LSR #0
    ST1 { V27.1D, V28.1D, V29.1D, V30.1D }, [X12], X10
    LD1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X12], X10
    ADD  X12, X12, X15
    ST1 { V3.2S, V4.2S, V5.2S, V6.2S }, [X12], X10
    LD1 { V3.2S, V4.2S, V5.2S, V6.2S }, [X12], X10
    ADD  X12, X12, X15, ASR #0
    ST1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X12], X10
    LD1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X12], X10
    ADD  X12, X12, X15, ASR #0
    ST1 { V3.8B, V4.8B, V5.8B, V6.8B }, [X12], X10
    LD1 { V3.8B, V4.8B, V5.8B, V6.8B }, [X12], X10
    ADD  X12, X12, X15, ASR #0
    MOV  X13, X12
    ST1 { V30.2D }, [X13], #16
    MOV  X13, X12
    LD1 { V30.8H }, [X13], #16
    ADD  X12, X12, X15, ASR #0
    MOV  X13, X12
    ST1 { V30.16B }, [X13], #16
    MOV  X13, X12
    LD1 { V1.16B }, [X13], #16
    ADD  X12, X12, X15
    MOV  X13, X12
    ST1 { V6.2D }, [X13], #16
    MOV  X13, X12
    LD1 { V6.2D }, [X13], #16
    ADD  X12, X12, X15, LSR #0
    MOV  X13, X12
    ST1 { V6.4S }, [X13], #16
    MOV  X13, X12
    LD1 { V27.4S }, [X13], #16
    ADD  X12, X12, X15, LSR #0
    MOV  X13, X12
    ST1 { V1.8H }, [X13], #16
    MOV  X13, X12
    LD1 { V23.8H }, [X13], #16
    ADD  X12, X12, X15, ASR #0
    MOV  X13, X12
    ST1 { V23.2S }, [X13], #8
    MOV  X13, X12
    LD1 { V5.2S }, [X13], #8
    ADD  X12, X12, X15
    MOV  X13, X12
    ST1 { V27.1D }, [X13], #8
    MOV  X13, X12
    LD1 { V21.1D }, [X13], #8
    ADD  X12, X12, X15, LSR #0
    MOV  X13, X12
    ST1 { V27.2S }, [X13], #8
    MOV  X13, X12
    LD1 { V29.2S }, [X13], #8
    ADD  X12, X12, X15, LSR #0
    MOV  X13, X12
    ST1 { V13.4H }, [X13], #8
    MOV  X13, X12
    LD1 { V17.4H }, [X13], #8
    ADD  X12, X12, X15
    MOV  X13, X12
    ST1 { V20.8B }, [X13], #8
    MOV  X13, X12
    LD1 { V8.8B }, [X13], #8
    ADD  X12, X12, X15
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D0
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D1
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D2
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D3
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D4
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D5
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D6
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V7.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D7
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D8
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D9
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D10
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D11
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D12
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V13.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D13
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V14.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D14
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V15.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D15
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V16.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D16
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D17
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V18.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D18
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V19.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D19
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D20
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D21
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V22.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D22
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D23
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D24
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D25
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D26
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D27
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D28
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D29
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D30
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D31
    SUB  X27, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X14
    FMOV  V2.D[1], X16
    FMOV  D3, X23
    FMOV  V3.D[1], X25
    FMOV  D4, X17
    FMOV  V4.D[1], X5
    FMOV  D5, X23
    FMOV  V5.D[1], X22
    FMOV  D6, X16
    FMOV  V6.D[1], X17
    FMOV  D7, X27
    FMOV  V7.D[1], X26
    FMOV  D8, X20
    FMOV  V8.D[1], X9
    FMOV  D9, X16
    FMOV  V9.D[1], X9
    FMOV  D10, X13
    FMOV  V10.D[1], X12
    FMOV  D11, X13
    FMOV  V11.D[1], X26
    FMOV  D12, X18
    FMOV  V12.D[1], X13
    FMOV  D13, X19
    FMOV  V13.D[1], X19
    FMOV  D14, X27
    FMOV  V14.D[1], X21
    FMOV  D15, X24
    FMOV  V15.D[1], X18
    FMOV  D16, X20
    FMOV  V16.D[1], X13
    FMOV  D17, X23
    FMOV  V17.D[1], X4
    FMOV  D18, X15
    FMOV  V18.D[1], X13
    FMOV  D19, X9
    FMOV  V19.D[1], X17
    FMOV  D20, X27
    FMOV  V20.D[1], X12
    FMOV  D21, X19
    FMOV  V21.D[1], X10
    FMOV  D22, X13
    FMOV  V22.D[1], X13
    FMOV  D23, X4
    FMOV  V23.D[1], X17
    FMOV  D24, X17
    FMOV  V24.D[1], X16
    FMOV  D25, X2
    FMOV  V25.D[1], X5
    FMOV  D26, X23
    FMOV  V26.D[1], X20
    FMOV  D27, X12
    FMOV  V27.D[1], X24
    FMOV  D28, X15
    FMOV  V28.D[1], X22
    FMOV  D29, X21
    FMOV  V29.D[1], X23
    FMOV  D30, X9
    FMOV  V30.D[1], X21
    FMOV  D31, X15
    FMOV  V31.D[1], X21
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X23, #0x1e00, LSL #0
    ADD  X18, X30, X23
    ST1 { V17.2S, V18.2S }, [X18]
    LD1 { V8.1D, V9.1D }, [X18]
    ADD  X18, X18, X24, ASR #0
    ST1 { V19.1D, V20.1D }, [X18]
    LD1 { V2.1D, V3.1D }, [X18]
    ADD  X18, X18, X24, ASR #0
    ST1 { V28.2S, V29.2S }, [X18]
    LD1 { V23.2S, V24.2S }, [X18]
    ADD  X18, X18, X24, ASR #0
    ST1 { V26.4H, V27.4H }, [X18]
    LD1 { V26.4H, V27.4H }, [X18]
    ADD  X18, X18, X24, LSR #0
    ST1 { V8.8B, V9.8B }, [X18]
    LD1 { V20.8B, V21.8B }, [X18]
    ADD  X18, X18, X24, LSR #0
    MOV  X16, X18
    ST1 { V23.4S, V24.4S, V25.4S, V26.4S }, [X16], #64
    MOV  X16, X18
    LD1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X16], #64
    ADD  X18, X18, X24, ASR #0
    MOV  X16, X18
    ST1 { V15.16B, V16.16B, V17.16B, V18.16B }, [X16], #64
    MOV  X16, X18
    LD1 { V19.16B, V20.16B, V21.16B, V22.16B }, [X16], #64
    ADD  X18, X18, X24, LSR #0
    MOV  X16, X18
    ST1 { V19.2D, V20.2D, V21.2D, V22.2D }, [X16], #64
    MOV  X16, X18
    LD1 { V15.2D, V16.2D, V17.2D, V18.2D }, [X16], #64
    ADD  X18, X18, X24
    MOV  X16, X18
    ST1 { V15.4S, V16.4S, V17.4S, V18.4S }, [X16], #64
    MOV  X16, X18
    LD1 { V23.4S, V24.4S, V25.4S, V26.4S }, [X16], #64
    ADD  X18, X18, X24
    MOV  X16, X18
    ST1 { V23.8H, V24.8H, V25.8H, V26.8H }, [X16], #64
    MOV  X16, X18
    LD1 { V22.8H, V23.8H, V24.8H, V25.8H }, [X16], #64
    ADD  X18, X18, X24
    MOV  X16, X18
    ST1 { V28.8B, V29.8B, V30.8B, V31.8B }, [X16], #32
    MOV  X16, X18
    LD1 { V16.1D, V17.1D, V18.1D, V19.1D }, [X16], #32
    ADD  X18, X18, X24, LSR #0
    MOV  X16, X18
    ST1 { V31.1D, V0.1D, V1.1D, V2.1D }, [X16], #32
    MOV  X16, X18
    LD1 { V18.1D, V19.1D, V20.1D, V21.1D }, [X16], #32
    ADD  X18, X18, X24, ASR #0
    MOV  X16, X18
    ST1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X16], #32
    MOV  X16, X18
    LD1 { V31.2S, V0.2S, V1.2S, V2.2S }, [X16], #32
    ADD  X18, X18, X24, LSR #0
    MOV  X16, X18
    ST1 { V22.4H, V23.4H, V24.4H, V25.4H }, [X16], #32
    MOV  X16, X18
    LD1 { V5.4H, V6.4H, V7.4H, V8.4H }, [X16], #32
    ADD  X18, X18, X24, ASR #0
    MOV  X16, X18
    ST1 { V5.8B, V6.8B, V7.8B, V8.8B }, [X16], #32
    MOV  X16, X18
    LD1 { V5.8B, V6.8B, V7.8B, V8.8B }, [X16], #32
    ADD  X18, X18, X24
    ST1 { V5.8H, V6.8H, V7.8H, V8.8H }, [X18], X11
    LD1 { V5.2D, V6.2D, V7.2D, V8.2D }, [X18], X11
    ADD  X18, X18, X24, ASR #0
    ST1 { V31.16B, V0.16B, V1.16B, V2.16B }, [X18], X11
    LD1 { V16.16B, V17.16B, V18.16B, V19.16B }, [X18], X11
    ADD  X18, X18, X24
    ST1 { V5.2D, V6.2D, V7.2D, V8.2D }, [X18], X11
    LD1 { V22.2D, V23.2D, V24.2D, V25.2D }, [X18], X11
    ADD  X18, X18, X24, ASR #0
    ST1 { V22.4S, V23.4S, V24.4S, V25.4S }, [X18], X11
    LD1 { V22.4S, V23.4S, V24.4S, V25.4S }, [X18], X11
    ADD  X18, X18, X24
    ST1 { V16.8H, V17.8H, V18.8H, V19.8H }, [X18], X11
    LD1 { V5.8H, V6.8H, V7.8H, V8.8H }, [X18], X11
    ADD  X18, X18, X24
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X18], X11
    LD1 { V16.1D, V17.1D, V18.1D, V19.1D }, [X18], X11
    ADD  X18, X18, X24
    ST1 { V5.1D, V6.1D, V7.1D, V8.1D }, [X18], X11
    LD1 { V30.1D, V31.1D, V0.1D, V1.1D }, [X18], X11
    ADD  X18, X18, X24
    ST1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X18], X11
    LD1 { V5.2S, V6.2S, V7.2S, V8.2S }, [X18], X11
    ADD  X18, X18, X24, LSR #0
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X18], X11
    LD1 { V18.4H, V19.4H, V20.4H, V21.4H }, [X18], X11
    ADD  X18, X18, X24, ASR #0
    ST1 { V5.8B, V6.8B, V7.8B, V8.8B }, [X18], X11
    LD1 { V5.8B, V6.8B, V7.8B, V8.8B }, [X18], X11
    ADD  X18, X18, X24, ASR #0
    MOV  X16, X18
    ST1 { V7.8H }, [X16], #16
    MOV  X16, X18
    LD1 { V16.2D }, [X16], #16
    ADD  X18, X18, X24, LSR #0
    MOV  X16, X18
    ST1 { V5.16B }, [X16], #16
    MOV  X16, X18
    LD1 { V5.16B }, [X16], #16
    ADD  X18, X18, X24
    MOV  X16, X18
    ST1 { V16.2D }, [X16], #16
    MOV  X16, X18
    LD1 { V31.2D }, [X16], #16
    ADD  X18, X18, X24, ASR #0
    MOV  X16, X18
    ST1 { V5.4S }, [X16], #16
    MOV  X16, X18
    LD1 { V5.4S }, [X16], #16
    ADD  X18, X18, X24, ASR #0
    MOV  X16, X18
    ST1 { V5.8H }, [X16], #16
    MOV  X16, X18
    LD1 { V5.8H }, [X16], #16
    ADD  X18, X18, X24, ASR #0
    MOV  X16, X18
    ST1 { V5.4H }, [X16], #8
    MOV  X16, X18
    LD1 { V16.4H }, [X16], #8
    ADD  X18, X18, X24, ASR #0
    MOV  X16, X18
    ST1 { V31.1D }, [X16], #8
    MOV  X16, X18
    LD1 { V14.1D }, [X16], #8
    ADD  X18, X18, X24
    MOV  X16, X18
    ST1 { V22.2S }, [X16], #8
    MOV  X16, X18
    LD1 { V5.2S }, [X16], #8
    ADD  X18, X18, X24, LSR #0
    MOV  X16, X18
    ST1 { V0.4H }, [X16], #8
    MOV  X16, X18
    LD1 { V27.4H }, [X16], #8
    ADD  X18, X18, X24, ASR #0
    MOV  X16, X18
    ST1 { V4.8B }, [X16], #8
    MOV  X16, X18
    LD1 { V31.8B }, [X16], #8
    ADD  X18, X18, X24, ASR #0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X4, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X4, FPSR
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D0
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D1
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D2
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V3.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D3
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, V4.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D4
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D5
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V6.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D6
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D7
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D8
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D9
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, V10.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D10
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, V11.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D11
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D12
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, V13.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D13
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D14
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V15.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D15
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D16
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D17
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V18.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D18
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D19
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V20.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D20
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D21
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D22
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D23
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D24
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D25
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D26
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D27
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D28
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, V29.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D29
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D30
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X4, D31
    SUB  X14, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X4
    FMOV  D3, X15
    FMOV  V3.D[1], X18
    FMOV  D4, X23
    FMOV  V4.D[1], X13
    FMOV  D5, X11
    FMOV  V5.D[1], X4
    FMOV  D6, X2
    FMOV  V6.D[1], X17
    FMOV  D7, X23
    FMOV  V7.D[1], X29
    FMOV  D8, X2
    FMOV  V8.D[1], X26
    FMOV  D9, X15
    FMOV  V9.D[1], X10
    FMOV  D10, X14
    FMOV  V10.D[1], X21
    FMOV  D11, X15
    FMOV  V11.D[1], X4
    FMOV  D12, X4
    FMOV  V12.D[1], X2
    FMOV  D13, X14
    FMOV  V13.D[1], X24
    FMOV  D14, X13
    FMOV  V14.D[1], X20
    FMOV  D15, X25
    FMOV  V15.D[1], X26
    FMOV  D16, X7
    FMOV  V16.D[1], X7
    FMOV  D17, X16
    FMOV  V17.D[1], X4
    FMOV  D18, X24
    FMOV  V18.D[1], X18
    FMOV  D19, X5
    FMOV  V19.D[1], X17
    FMOV  D20, X10
    FMOV  V20.D[1], X16
    FMOV  D21, X25
    FMOV  V21.D[1], X13
    FMOV  D22, X21
    FMOV  V22.D[1], X7
    FMOV  D23, X15
    FMOV  V23.D[1], X11
    FMOV  D24, X5
    FMOV  V24.D[1], X19
    FMOV  D25, X19
    FMOV  V25.D[1], X29
    FMOV  D26, X4
    FMOV  V26.D[1], X23
    FMOV  D27, X29
    FMOV  V27.D[1], X4
    FMOV  D28, X16
    FMOV  V28.D[1], X13
    FMOV  D29, X15
    FMOV  V29.D[1], X11
    FMOV  D30, X7
    FMOV  V30.D[1], X12
    FMOV  D31, X19
    FMOV  V31.D[1], X13
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X24, #0x2300, LSL #0
    ADD  X5, X30, X24
    ST1 { V25.2S, V26.2S }, [X5]
    LD1 { V1.4H, V2.4H }, [X5]
    ADD  X5, X5, X2, ASR #0
    ST1 { V18.1D, V19.1D }, [X5]
    LD1 { V5.1D, V6.1D }, [X5]
    ADD  X5, X5, X2, ASR #0
    ST1 { V16.2S, V17.2S }, [X5]
    LD1 { V21.2S, V22.2S }, [X5]
    ADD  X5, X5, X2, ASR #0
    ST1 { V5.4H, V6.4H }, [X5]
    LD1 { V24.4H, V25.4H }, [X5]
    ADD  X5, X5, X2, LSR #0
    ST1 { V1.8B, V2.8B }, [X5]
    LD1 { V28.8B, V29.8B }, [X5]
    ADD  X5, X5, X2, ASR #0
    MOV  X7, X5
    ST1 { V7.2D, V8.2D, V9.2D, V10.2D }, [X7], #64
    MOV  X7, X5
    LD1 { V24.4S, V25.4S, V26.4S, V27.4S }, [X7], #64
    ADD  X5, X5, X2, LSR #0
    MOV  X7, X5
    ST1 { V29.16B, V30.16B, V31.16B, V0.16B }, [X7], #64
    MOV  X7, X5
    LD1 { V12.16B, V13.16B, V14.16B, V15.16B }, [X7], #64
    ADD  X5, X5, X2
    MOV  X7, X5
    ST1 { V12.2D, V13.2D, V14.2D, V15.2D }, [X7], #64
    MOV  X7, X5
    LD1 { V7.2D, V8.2D, V9.2D, V10.2D }, [X7], #64
    ADD  X5, X5, X2
    MOV  X7, X5
    ST1 { V24.4S, V25.4S, V26.4S, V27.4S }, [X7], #64
    MOV  X7, X5
    LD1 { V16.4S, V17.4S, V18.4S, V19.4S }, [X7], #64
    ADD  X5, X5, X2, ASR #0
    MOV  X7, X5
    ST1 { V7.8H, V8.8H, V9.8H, V10.8H }, [X7], #64
    MOV  X7, X5
    LD1 { V7.8H, V8.8H, V9.8H, V10.8H }, [X7], #64
    ADD  X5, X5, X2
    MOV  X7, X5
    ST1 { V7.1D, V8.1D, V9.1D, V10.1D }, [X7], #32
    MOV  X7, X5
    LD1 { V7.1D, V8.1D, V9.1D, V10.1D }, [X7], #32
    ADD  X5, X5, X2, LSR #0
    MOV  X7, X5
    ST1 { V7.1D, V8.1D, V9.1D, V10.1D }, [X7], #32
    MOV  X7, X5
    LD1 { V24.1D, V25.1D, V26.1D, V27.1D }, [X7], #32
    ADD  X5, X5, X2
    MOV  X7, X5
    ST1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X7], #32
    MOV  X7, X5
    LD1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X7], #32
    ADD  X5, X5, X2
    MOV  X7, X5
    ST1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X7], #32
    MOV  X7, X5
    LD1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X7], #32
    ADD  X5, X5, X2, LSR #0
    MOV  X7, X5
    ST1 { V24.8B, V25.8B, V26.8B, V27.8B }, [X7], #32
    MOV  X7, X5
    LD1 { V24.8B, V25.8B, V26.8B, V27.8B }, [X7], #32
    ADD  X5, X5, X2
    ST1 { V24.8H, V25.8H, V26.8H, V27.8H }, [X5], X29
    LD1 { V16.4S, V17.4S, V18.4S, V19.4S }, [X5], X29
    ADD  X5, X5, X2, ASR #0
    ST1 { V16.16B, V17.16B, V18.16B, V19.16B }, [X5], X29
    LD1 { V30.16B, V31.16B, V0.16B, V1.16B }, [X5], X29
    ADD  X5, X5, X2, LSR #0
    ST1 { V7.2D, V8.2D, V9.2D, V10.2D }, [X5], X29
    LD1 { V16.2D, V17.2D, V18.2D, V19.2D }, [X5], X29
    ADD  X5, X5, X2, ASR #0
    ST1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X5], X29
    LD1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X5], X29
    ADD  X5, X5, X2
    ST1 { V16.8H, V17.8H, V18.8H, V19.8H }, [X5], X29
    LD1 { V16.8H, V17.8H, V18.8H, V19.8H }, [X5], X29
    ADD  X5, X5, X2, ASR #0
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X5], X29
    LD1 { V30.8B, V31.8B, V0.8B, V1.8B }, [X5], X29
    ADD  X5, X5, X2, LSR #0
    ST1 { V16.1D, V17.1D, V18.1D, V19.1D }, [X5], X29
    LD1 { V16.1D, V17.1D, V18.1D, V19.1D }, [X5], X29
    ADD  X5, X5, X2, LSR #0
    ST1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X5], X29
    LD1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X5], X29
    ADD  X5, X5, X2
    ST1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X5], X29
    LD1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X5], X29
    ADD  X5, X5, X2, LSR #0
    ST1 { V7.8B, V8.8B, V9.8B, V10.8B }, [X5], X29
    LD1 { V16.8B, V17.8B, V18.8B, V19.8B }, [X5], X29
    ADD  X5, X5, X2, ASR #0
    MOV  X7, X5
    ST1 { V18.8H }, [X7], #16
    MOV  X7, X5
    LD1 { V18.16B }, [X7], #16
    ADD  X5, X5, X2, LSR #0
    MOV  X7, X5
    ST1 { V18.16B }, [X7], #16
    MOV  X7, X5
    LD1 { V16.16B }, [X7], #16
    ADD  X5, X5, X2, ASR #0
    MOV  X7, X5
    ST1 { V19.2D }, [X7], #16
    MOV  X7, X5
    LD1 { V8.2D }, [X7], #16
    ADD  X5, X5, X2, LSR #0
    MOV  X7, X5
    ST1 { V16.4S }, [X7], #16
    MOV  X7, X5
    LD1 { V16.4S }, [X7], #16
    ADD  X5, X5, X2, ASR #0
    MOV  X7, X5
    ST1 { V16.8H }, [X7], #16
    MOV  X7, X5
    LD1 { V19.8H }, [X7], #16
    ADD  X5, X5, X2
    MOV  X7, X5
    ST1 { V19.2S }, [X7], #8
    MOV  X7, X5
    LD1 { V19.8B }, [X7], #8
    ADD  X5, X5, X2, ASR #0
    MOV  X7, X5
    ST1 { V19.1D }, [X7], #8
    MOV  X7, X5
    LD1 { V7.1D }, [X7], #8
    ADD  X5, X5, X2, LSR #0
    MOV  X7, X5
    ST1 { V19.2S }, [X7], #8
    MOV  X7, X5
    LD1 { V3.2S }, [X7], #8
    ADD  X5, X5, X2, LSR #0
    MOV  X7, X5
    ST1 { V12.4H }, [X7], #8
    MOV  X7, X5
    LD1 { V12.4H }, [X7], #8
    ADD  X5, X5, X2, ASR #0
    MOV  X7, X5
    ST1 { V28.8B }, [X7], #8
    MOV  X7, X5
    LD1 { V9.8B }, [X7], #8
    ADD  X5, X5, X2, LSR #0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X14, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D0
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D1
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D2
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D3
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, V4.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D4
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D5
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D6
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D7
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D8
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D9
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D10
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, V11.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D11
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D12
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, V13.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D13
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, V14.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D14
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, V15.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D15
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D16
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D17
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D18
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D19
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, V20.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D20
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D21
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D22
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, V23.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D23
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D24
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D25
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D26
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D27
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D28
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D29
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D30
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X14, D31
    SUB  X17, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X15
    FMOV  V3.D[1], X13
    FMOV  D4, X9
    FMOV  V4.D[1], X26
    FMOV  D5, X5
    FMOV  V5.D[1], X13
    FMOV  D6, X11
    FMOV  V6.D[1], X18
    FMOV  D7, X15
    FMOV  V7.D[1], X29
    FMOV  D8, X27
    FMOV  V8.D[1], X29
    FMOV  D9, X12
    FMOV  V9.D[1], X17
    FMOV  D10, X18
    FMOV  V10.D[1], X13
    FMOV  D11, X26
    FMOV  V11.D[1], X7
    FMOV  D12, X2
    FMOV  V12.D[1], X11
    FMOV  D13, X4
    FMOV  V13.D[1], X15
    FMOV  D14, X10
    FMOV  V14.D[1], X23
    FMOV  D15, X23
    FMOV  V15.D[1], X19
    FMOV  D16, X4
    FMOV  V16.D[1], X26
    FMOV  D17, X2
    FMOV  V17.D[1], X19
    FMOV  D18, X16
    FMOV  V18.D[1], X19
    FMOV  D19, X9
    FMOV  V19.D[1], X16
    FMOV  D20, X19
    FMOV  V20.D[1], X17
    FMOV  D21, X14
    FMOV  V21.D[1], X17
    FMOV  D22, X21
    FMOV  V22.D[1], X13
    FMOV  D23, X12
    FMOV  V23.D[1], X16
    FMOV  D24, X24
    FMOV  V24.D[1], X12
    FMOV  D25, X12
    FMOV  V25.D[1], X24
    FMOV  D26, X19
    FMOV  V26.D[1], X4
    FMOV  D27, X20
    FMOV  V27.D[1], X13
    FMOV  D28, X17
    FMOV  V28.D[1], X15
    FMOV  D29, X27
    FMOV  V29.D[1], X24
    FMOV  D30, X14
    FMOV  V30.D[1], X25
    FMOV  D31, X17
    FMOV  V31.D[1], X18
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X9, #0x2800, LSL #0
    ADD  X16, X30, X9, LSR #0
    ST1 { V29.8B, V30.8B }, [X16]
    LD1 { V0.1D, V1.1D }, [X16]
    ADD  X16, X16, X21, ASR #0
    ST1 { V27.1D, V28.1D }, [X16]
    LD1 { V2.1D, V3.1D }, [X16]
    ADD  X16, X16, X21, LSR #0
    ST1 { V2.2S, V3.2S }, [X16]
    LD1 { V27.2S, V28.2S }, [X16]
    ADD  X16, X16, X21
    ST1 { V5.4H, V6.4H }, [X16]
    LD1 { V8.4H, V9.4H }, [X16]
    ADD  X16, X16, X21, LSR #0
    ST1 { V31.8B, V0.8B }, [X16]
    LD1 { V27.8B, V28.8B }, [X16]
    ADD  X16, X16, X21
    MOV  X26, X16
    ST1 { V0.8H, V1.8H, V2.8H, V3.8H }, [X26], #64
    MOV  X26, X16
    LD1 { V6.8H, V7.8H, V8.8H, V9.8H }, [X26], #64
    ADD  X16, X16, X21, ASR #0
    MOV  X26, X16
    ST1 { V6.16B, V7.16B, V8.16B, V9.16B }, [X26], #64
    MOV  X26, X16
    LD1 { V30.16B, V31.16B, V0.16B, V1.16B }, [X26], #64
    ADD  X16, X16, X21
    MOV  X26, X16
    ST1 { V30.2D, V31.2D, V0.2D, V1.2D }, [X26], #64
    MOV  X26, X16
    LD1 { V15.2D, V16.2D, V17.2D, V18.2D }, [X26], #64
    ADD  X16, X16, X21, LSR #0
    MOV  X26, X16
    ST1 { V2.4S, V3.4S, V4.4S, V5.4S }, [X26], #64
    MOV  X26, X16
    LD1 { V4.4S, V5.4S, V6.4S, V7.4S }, [X26], #64
    ADD  X16, X16, X21, LSR #0
    MOV  X26, X16
    ST1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X26], #64
    MOV  X26, X16
    LD1 { V18.8H, V19.8H, V20.8H, V21.8H }, [X26], #64
    ADD  X16, X16, X21, LSR #0
    MOV  X26, X16
    ST1 { V18.8B, V19.8B, V20.8B, V21.8B }, [X26], #32
    MOV  X26, X16
    LD1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X26], #32
    ADD  X16, X16, X21, ASR #0
    MOV  X26, X16
    ST1 { V4.1D, V5.1D, V6.1D, V7.1D }, [X26], #32
    MOV  X26, X16
    LD1 { V4.1D, V5.1D, V6.1D, V7.1D }, [X26], #32
    ADD  X16, X16, X21, ASR #0
    MOV  X26, X16
    ST1 { V4.2S, V5.2S, V6.2S, V7.2S }, [X26], #32
    MOV  X26, X16
    LD1 { V4.2S, V5.2S, V6.2S, V7.2S }, [X26], #32
    ADD  X16, X16, X21
    MOV  X26, X16
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X26], #32
    MOV  X26, X16
    LD1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X26], #32
    ADD  X16, X16, X21, LSR #0
    MOV  X26, X16
    ST1 { V7.8B, V8.8B, V9.8B, V10.8B }, [X26], #32
    MOV  X26, X16
    LD1 { V16.8B, V17.8B, V18.8B, V19.8B }, [X26], #32
    ADD  X16, X16, X21
    ST1 { V17.2D, V18.2D, V19.2D, V20.2D }, [X16], X13
    LD1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X16], X13
    ADD  X16, X16, X21, LSR #0
    ST1 { V3.16B, V4.16B, V5.16B, V6.16B }, [X16], X13
    LD1 { V17.16B, V18.16B, V19.16B, V20.16B }, [X16], X13
    ADD  X16, X16, X21, ASR #0
    ST1 { V4.2D, V5.2D, V6.2D, V7.2D }, [X16], X13
    LD1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X16], X13
    ADD  X16, X16, X21
    ST1 { V11.4S, V12.4S, V13.4S, V14.4S }, [X16], X13
    LD1 { V10.4S, V11.4S, V12.4S, V13.4S }, [X16], X13
    ADD  X16, X16, X21, LSR #0
    ST1 { V3.8H, V4.8H, V5.8H, V6.8H }, [X16], X13
    LD1 { V3.8H, V4.8H, V5.8H, V6.8H }, [X16], X13
    ADD  X16, X16, X21
    ST1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X16], X13
    LD1 { V2.4H, V3.4H, V4.4H, V5.4H }, [X16], X13
    ADD  X16, X16, X21, LSR #0
    ST1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X16], X13
    LD1 { V4.1D, V5.1D, V6.1D, V7.1D }, [X16], X13
    ADD  X16, X16, X21, LSR #0
    ST1 { V17.2S, V18.2S, V19.2S, V20.2S }, [X16], X13
    LD1 { V12.2S, V13.2S, V14.2S, V15.2S }, [X16], X13
    ADD  X16, X16, X21, LSR #0
    ST1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X16], X13
    LD1 { V17.4H, V18.4H, V19.4H, V20.4H }, [X16], X13
    ADD  X16, X16, X21, LSR #0
    ST1 { V15.8B, V16.8B, V17.8B, V18.8B }, [X16], X13
    LD1 { V3.8B, V4.8B, V5.8B, V6.8B }, [X16], X13
    ADD  X16, X16, X21
    MOV  X26, X16
    ST1 { V2.4S }, [X26], #16
    MOV  X26, X16
    LD1 { V2.8H }, [X26], #16
    ADD  X16, X16, X21
    MOV  X26, X16
    ST1 { V2.16B }, [X26], #16
    MOV  X26, X16
    LD1 { V23.16B }, [X26], #16
    ADD  X16, X16, X21, ASR #0
    MOV  X26, X16
    ST1 { V7.2D }, [X26], #16
    MOV  X26, X16
    LD1 { V18.2D }, [X26], #16
    ADD  X16, X16, X21
    MOV  X26, X16
    ST1 { V3.4S }, [X26], #16
    MOV  X26, X16
    LD1 { V2.4S }, [X26], #16
    ADD  X16, X16, X21
    MOV  X26, X16
    ST1 { V23.8H }, [X26], #16
    MOV  X26, X16
    LD1 { V3.8H }, [X26], #16
    ADD  X16, X16, X21, ASR #0
    MOV  X26, X16
    ST1 { V18.2S }, [X26], #8
    MOV  X26, X16
    LD1 { V18.8B }, [X26], #8
    ADD  X16, X16, X21, ASR #0
    MOV  X26, X16
    ST1 { V3.1D }, [X26], #8
    MOV  X26, X16
    LD1 { V9.1D }, [X26], #8
    ADD  X16, X16, X21, LSR #0
    MOV  X26, X16
    ST1 { V9.2S }, [X26], #8
    MOV  X26, X16
    LD1 { V7.2S }, [X26], #8
    ADD  X16, X16, X21, ASR #0
    MOV  X26, X16
    ST1 { V18.4H }, [X26], #8
    MOV  X26, X16
    LD1 { V15.4H }, [X26], #8
    ADD  X16, X16, X21, ASR #0
    MOV  X26, X16
    ST1 { V15.8B }, [X26], #8
    MOV  X26, X16
    LD1 { V10.8B }, [X26], #8
    ADD  X16, X16, X21, ASR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X15, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X15, FPSR
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D0
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D1
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D2
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D3
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D4
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D5
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D6
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D7
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D8
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D9
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D10
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, V11.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D11
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D12
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D13
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D14
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D15
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D16
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D17
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D18
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D19
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D20
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D21
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, V22.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D22
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D23
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, V24.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D24
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, V25.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D25
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D26
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D27
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D28
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, V29.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D29
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D30
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X15, D31
    SUB  X2, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X22
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X26
    FMOV  D4, X27
    FMOV  V4.D[1], X16
    FMOV  D5, X25
    FMOV  V5.D[1], X19
    FMOV  D6, X15
    FMOV  V6.D[1], X26
    FMOV  D7, X22
    FMOV  V7.D[1], X5
    FMOV  D8, X29
    FMOV  V8.D[1], X7
    FMOV  D9, X24
    FMOV  V9.D[1], X16
    FMOV  D10, X14
    FMOV  V10.D[1], X2
    FMOV  D11, X4
    FMOV  V11.D[1], X27
    FMOV  D12, X12
    FMOV  V12.D[1], X9
    FMOV  D13, X16
    FMOV  V13.D[1], X13
    FMOV  D14, X15
    FMOV  V14.D[1], X4
    FMOV  D15, X15
    FMOV  V15.D[1], X5
    FMOV  D16, X17
    FMOV  V16.D[1], X4
    FMOV  D17, X29
    FMOV  V17.D[1], X19
    FMOV  D18, X26
    FMOV  V18.D[1], X17
    FMOV  D19, X13
    FMOV  V19.D[1], X29
    FMOV  D20, X20
    FMOV  V20.D[1], X29
    FMOV  D21, X17
    FMOV  V21.D[1], X22
    FMOV  D22, X21
    FMOV  V22.D[1], X5
    FMOV  D23, X10
    FMOV  V23.D[1], X15
    FMOV  D24, X13
    FMOV  V24.D[1], X9
    FMOV  D25, X17
    FMOV  V25.D[1], X12
    FMOV  D26, X29
    FMOV  V26.D[1], X13
    FMOV  D27, X19
    FMOV  V27.D[1], X24
    FMOV  D28, X16
    FMOV  V28.D[1], X25
    FMOV  D29, X27
    FMOV  V29.D[1], X11
    FMOV  D30, X25
    FMOV  V30.D[1], X26
    FMOV  D31, X12
    FMOV  V31.D[1], X25
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X15, #0x2d00, LSL #0
    ADD  X2, X30, X15
    ST1 { V19.4H, V20.4H }, [X2]
    LD1 { V18.4H, V19.4H }, [X2]
    ADD  X2, X2, X5, ASR #0
    ST1 { V2.1D, V3.1D }, [X2]
    LD1 { V10.1D, V11.1D }, [X2]
    ADD  X2, X2, X5
    ST1 { V1.2S, V2.2S }, [X2]
    LD1 { V3.2S, V4.2S }, [X2]
    ADD  X2, X2, X5
    ST1 { V10.4H, V11.4H }, [X2]
    LD1 { V11.4H, V12.4H }, [X2]
    ADD  X2, X2, X5
    ST1 { V11.8B, V12.8B }, [X2]
    LD1 { V10.8B, V11.8B }, [X2]
    ADD  X2, X2, X5
    MOV  X25, X2
    ST1 { V2.16B, V3.16B, V4.16B, V5.16B }, [X25], #64
    MOV  X25, X2
    LD1 { V4.2D, V5.2D, V6.2D, V7.2D }, [X25], #64
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V2.16B, V3.16B, V4.16B, V5.16B }, [X25], #64
    MOV  X25, X2
    LD1 { V10.16B, V11.16B, V12.16B, V13.16B }, [X25], #64
    ADD  X2, X2, X5
    MOV  X25, X2
    ST1 { V18.2D, V19.2D, V20.2D, V21.2D }, [X25], #64
    MOV  X25, X2
    LD1 { V11.2D, V12.2D, V13.2D, V14.2D }, [X25], #64
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V11.4S, V12.4S, V13.4S, V14.4S }, [X25], #64
    MOV  X25, X2
    LD1 { V4.4S, V5.4S, V6.4S, V7.4S }, [X25], #64
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V4.8H, V5.8H, V6.8H, V7.8H }, [X25], #64
    MOV  X25, X2
    LD1 { V4.8H, V5.8H, V6.8H, V7.8H }, [X25], #64
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X25], #32
    MOV  X25, X2
    LD1 { V18.4H, V19.4H, V20.4H, V21.4H }, [X25], #32
    ADD  X2, X2, X5, ASR #0
    MOV  X25, X2
    ST1 { V18.1D, V19.1D, V20.1D, V21.1D }, [X25], #32
    MOV  X25, X2
    LD1 { V20.1D, V21.1D, V22.1D, V23.1D }, [X25], #32
    ADD  X2, X2, X5, ASR #0
    MOV  X25, X2
    ST1 { V4.2S, V5.2S, V6.2S, V7.2S }, [X25], #32
    MOV  X25, X2
    LD1 { V4.2S, V5.2S, V6.2S, V7.2S }, [X25], #32
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V20.4H, V21.4H, V22.4H, V23.4H }, [X25], #32
    MOV  X25, X2
    LD1 { V22.4H, V23.4H, V24.4H, V25.4H }, [X25], #32
    ADD  X2, X2, X5
    MOV  X25, X2
    ST1 { V22.8B, V23.8B, V24.8B, V25.8B }, [X25], #32
    MOV  X25, X2
    LD1 { V22.8B, V23.8B, V24.8B, V25.8B }, [X25], #32
    ADD  X2, X2, X5, LSR #0
    ST1 { V4.4S, V5.4S, V6.4S, V7.4S }, [X2], X24
    LD1 { V4.8H, V5.8H, V6.8H, V7.8H }, [X2], X24
    ADD  X2, X2, X5, LSR #0
    ST1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X2], X24
    LD1 { V29.16B, V30.16B, V31.16B, V0.16B }, [X2], X24
    ADD  X2, X2, X5, LSR #0
    ST1 { V4.2D, V5.2D, V6.2D, V7.2D }, [X2], X24
    LD1 { V4.2D, V5.2D, V6.2D, V7.2D }, [X2], X24
    ADD  X2, X2, X5
    ST1 { V29.4S, V30.4S, V31.4S, V0.4S }, [X2], X24
    LD1 { V22.4S, V23.4S, V24.4S, V25.4S }, [X2], X24
    ADD  X2, X2, X5
    ST1 { V4.8H, V5.8H, V6.8H, V7.8H }, [X2], X24
    LD1 { V29.8H, V30.8H, V31.8H, V0.8H }, [X2], X24
    ADD  X2, X2, X5
    ST1 { V29.4H, V30.4H, V31.4H, V0.4H }, [X2], X24
    LD1 { V10.8B, V11.8B, V12.8B, V13.8B }, [X2], X24
    ADD  X2, X2, X5
    ST1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X2], X24
    LD1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X2], X24
    ADD  X2, X2, X5
    ST1 { V29.2S, V30.2S, V31.2S, V0.2S }, [X2], X24
    LD1 { V4.2S, V5.2S, V6.2S, V7.2S }, [X2], X24
    ADD  X2, X2, X5, LSR #0
    ST1 { V10.4H, V11.4H, V12.4H, V13.4H }, [X2], X24
    LD1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X2], X24
    ADD  X2, X2, X5, ASR #0
    ST1 { V4.8B, V5.8B, V6.8B, V7.8B }, [X2], X24
    LD1 { V10.8B, V11.8B, V12.8B, V13.8B }, [X2], X24
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V11.2D }, [X25], #16
    MOV  X25, X2
    LD1 { V6.8H }, [X25], #16
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V6.16B }, [X25], #16
    MOV  X25, X2
    LD1 { V31.16B }, [X25], #16
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V10.2D }, [X25], #16
    MOV  X25, X2
    LD1 { V6.2D }, [X25], #16
    ADD  X2, X2, X5, ASR #0
    MOV  X25, X2
    ST1 { V31.4S }, [X25], #16
    MOV  X25, X2
    LD1 { V10.4S }, [X25], #16
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V6.8H }, [X25], #16
    MOV  X25, X2
    LD1 { V31.8H }, [X25], #16
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V31.2S }, [X25], #8
    MOV  X25, X2
    LD1 { V31.4H }, [X25], #8
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V31.1D }, [X25], #8
    MOV  X25, X2
    LD1 { V0.1D }, [X25], #8
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V1.2S }, [X25], #8
    MOV  X25, X2
    LD1 { V24.2S }, [X25], #8
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V8.4H }, [X25], #8
    MOV  X25, X2
    LD1 { V14.4H }, [X25], #8
    ADD  X2, X2, X5, LSR #0
    MOV  X25, X2
    ST1 { V26.8B }, [X25], #8
    MOV  X25, X2
    LD1 { V25.8B }, [X25], #8
    ADD  X2, X2, X5, LSR #0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X22, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X22, FPSR
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D0
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, V1.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D1
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, V2.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D2
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D3
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D4
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D5
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D6
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D7
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, V8.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D8
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D9
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D10
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D11
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V12.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D12
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D13
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V14.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D14
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, V15.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D15
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, V16.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D16
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, V17.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D17
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D18
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D19
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D20
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D21
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D22
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D23
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D24
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D25
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, V26.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D26
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, V27.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D27
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, V28.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D28
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D29
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D30
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X22, D31
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X18
    FMOV  V2.D[1], X24
    FMOV  D3, X29
    FMOV  V3.D[1], X23
    FMOV  D4, X27
    FMOV  V4.D[1], X16
    FMOV  D5, X23
    FMOV  V5.D[1], X2
    FMOV  D6, X2
    FMOV  V6.D[1], X24
    FMOV  D7, X19
    FMOV  V7.D[1], X5
    FMOV  D8, X26
    FMOV  V8.D[1], X7
    FMOV  D9, X29
    FMOV  V9.D[1], X20
    FMOV  D10, X19
    FMOV  V10.D[1], X17
    FMOV  D11, X14
    FMOV  V11.D[1], X16
    FMOV  D12, X7
    FMOV  V12.D[1], X18
    FMOV  D13, X23
    FMOV  V13.D[1], X19
    FMOV  D14, X21
    FMOV  V14.D[1], X12
    FMOV  D15, X17
    FMOV  V15.D[1], X17
    FMOV  D16, X11
    FMOV  V16.D[1], X18
    FMOV  D17, X19
    FMOV  V17.D[1], X7
    FMOV  D18, X12
    FMOV  V18.D[1], X13
    FMOV  D19, X17
    FMOV  V19.D[1], X29
    FMOV  D20, X24
    FMOV  V20.D[1], X14
    FMOV  D21, X24
    FMOV  V21.D[1], X14
    FMOV  D22, X17
    FMOV  V22.D[1], X9
    FMOV  D23, X22
    FMOV  V23.D[1], X18
    FMOV  D24, X19
    FMOV  V24.D[1], X27
    FMOV  D25, X29
    FMOV  V25.D[1], X5
    FMOV  D26, X2
    FMOV  V26.D[1], X18
    FMOV  D27, X4
    FMOV  V27.D[1], X4
    FMOV  D28, X26
    FMOV  V28.D[1], X5
    FMOV  D29, X5
    FMOV  V29.D[1], X15
    FMOV  D30, X15
    FMOV  V30.D[1], X17
    FMOV  D31, X29
    FMOV  V31.D[1], X12
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X4, #0x0, LSL #0
    ADD  X19, X30, X4, ASR #0
    ST1 { V28.4H, V29.4H }, [X19]
    LD1 { V29.1D, V30.1D }, [X19]
    ADD  X19, X19, X17
    ST1 { V25.1D, V26.1D }, [X19]
    LD1 { V31.1D, V0.1D }, [X19]
    ADD  X19, X19, X17, ASR #0
    ST1 { V26.2S, V27.2S }, [X19]
    LD1 { V4.2S, V5.2S }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V31.4H, V0.4H }, [X19]
    LD1 { V7.4H, V8.4H }, [X19]
    ADD  X19, X19, X17, LSR #0
    ST1 { V4.8B, V5.8B }, [X19]
    LD1 { V9.8B, V10.8B }, [X19]
    ADD  X19, X19, X17, ASR #0
    MOV  X7, X19
    ST1 { V7.2D, V8.2D, V9.2D, V10.2D }, [X7], #64
    MOV  X7, X19
    LD1 { V4.16B, V5.16B, V6.16B, V7.16B }, [X7], #64
    ADD  X19, X19, X17, LSR #0
    MOV  X7, X19
    ST1 { V4.16B, V5.16B, V6.16B, V7.16B }, [X7], #64
    MOV  X7, X19
    LD1 { V24.16B, V25.16B, V26.16B, V27.16B }, [X7], #64
    ADD  X19, X19, X17, ASR #0
    MOV  X7, X19
    ST1 { V24.2D, V25.2D, V26.2D, V27.2D }, [X7], #64
    MOV  X7, X19
    LD1 { V12.2D, V13.2D, V14.2D, V15.2D }, [X7], #64
    ADD  X19, X19, X17
    MOV  X7, X19
    ST1 { V12.4S, V13.4S, V14.4S, V15.4S }, [X7], #64
    MOV  X7, X19
    LD1 { V24.4S, V25.4S, V26.4S, V27.4S }, [X7], #64
    ADD  X19, X19, X17
    MOV  X7, X19
    ST1 { V24.8H, V25.8H, V26.8H, V27.8H }, [X7], #64
    MOV  X7, X19
    LD1 { V12.8H, V13.8H, V14.8H, V15.8H }, [X7], #64
    ADD  X19, X19, X17
    MOV  X7, X19
    ST1 { V29.2S, V30.2S, V31.2S, V0.2S }, [X7], #32
    MOV  X7, X19
    LD1 { V29.2S, V30.2S, V31.2S, V0.2S }, [X7], #32
    ADD  X19, X19, X17, ASR #0
    MOV  X7, X19
    ST1 { V14.1D, V15.1D, V16.1D, V17.1D }, [X7], #32
    MOV  X7, X19
    LD1 { V24.1D, V25.1D, V26.1D, V27.1D }, [X7], #32
    ADD  X19, X19, X17, LSR #0
    MOV  X7, X19
    ST1 { V24.2S, V25.2S, V26.2S, V27.2S }, [X7], #32
    MOV  X7, X19
    LD1 { V14.2S, V15.2S, V16.2S, V17.2S }, [X7], #32
    ADD  X19, X19, X17, ASR #0
    MOV  X7, X19
    ST1 { V29.4H, V30.4H, V31.4H, V0.4H }, [X7], #32
    MOV  X7, X19
    LD1 { V26.4H, V27.4H, V28.4H, V29.4H }, [X7], #32
    ADD  X19, X19, X17
    MOV  X7, X19
    ST1 { V26.8B, V27.8B, V28.8B, V29.8B }, [X7], #32
    MOV  X7, X19
    LD1 { V13.8B, V14.8B, V15.8B, V16.8B }, [X7], #32
    ADD  X19, X19, X17, ASR #0
    ST1 { V13.8H, V14.8H, V15.8H, V16.8H }, [X19], X23
    LD1 { V17.16B, V18.16B, V19.16B, V20.16B }, [X19], X23
    ADD  X19, X19, X17, ASR #0
    ST1 { V17.16B, V18.16B, V19.16B, V20.16B }, [X19], X23
    LD1 { V6.16B, V7.16B, V8.16B, V9.16B }, [X19], X23
    ADD  X19, X19, X17, LSR #0
    ST1 { V16.2D, V17.2D, V18.2D, V19.2D }, [X19], X23
    LD1 { V26.2D, V27.2D, V28.2D, V29.2D }, [X19], X23
    ADD  X19, X19, X17, ASR #0
    ST1 { V16.4S, V17.4S, V18.4S, V19.4S }, [X19], X23
    LD1 { V10.4S, V11.4S, V12.4S, V13.4S }, [X19], X23
    ADD  X19, X19, X17, LSR #0
    ST1 { V8.8H, V9.8H, V10.8H, V11.8H }, [X19], X23
    LD1 { V8.8H, V9.8H, V10.8H, V11.8H }, [X19], X23
    ADD  X19, X19, X17, ASR #0
    ST1 { V7.1D, V8.1D, V9.1D, V10.1D }, [X19], X23
    LD1 { V14.4H, V15.4H, V16.4H, V17.4H }, [X19], X23
    ADD  X19, X19, X17
    ST1 { V12.1D, V13.1D, V14.1D, V15.1D }, [X19], X23
    LD1 { V13.1D, V14.1D, V15.1D, V16.1D }, [X19], X23
    ADD  X19, X19, X17, ASR #0
    ST1 { V13.2S, V14.2S, V15.2S, V16.2S }, [X19], X23
    LD1 { V28.2S, V29.2S, V30.2S, V31.2S }, [X19], X23
    ADD  X19, X19, X17
    ST1 { V29.4H, V30.4H, V31.4H, V0.4H }, [X19], X23
    LD1 { V12.4H, V13.4H, V14.4H, V15.4H }, [X19], X23
    ADD  X19, X19, X17
    ST1 { V12.8B, V13.8B, V14.8B, V15.8B }, [X19], X23
    LD1 { V13.8B, V14.8B, V15.8B, V16.8B }, [X19], X23
    ADD  X19, X19, X17
    MOV  X7, X19
    ST1 { V28.8H }, [X7], #16
    MOV  X7, X19
    LD1 { V28.2D }, [X7], #16
    ADD  X19, X19, X17
    MOV  X7, X19
    ST1 { V16.16B }, [X7], #16
    MOV  X7, X19
    LD1 { V29.16B }, [X7], #16
    ADD  X19, X19, X17
    MOV  X7, X19
    ST1 { V15.2D }, [X7], #16
    MOV  X7, X19
    LD1 { V16.2D }, [X7], #16
    ADD  X19, X19, X17, LSR #0
    MOV  X7, X19
    ST1 { V16.4S }, [X7], #16
    MOV  X7, X19
    LD1 { V15.4S }, [X7], #16
    ADD  X19, X19, X17, ASR #0
    MOV  X7, X19
    ST1 { V15.8H }, [X7], #16
    MOV  X7, X19
    LD1 { V15.8H }, [X7], #16
    ADD  X19, X19, X17, LSR #0
    MOV  X7, X19
    ST1 { V29.2S }, [X7], #8
    MOV  X7, X19
    LD1 { V16.4H }, [X7], #8
    ADD  X19, X19, X17
    MOV  X7, X19
    ST1 { V15.1D }, [X7], #8
    MOV  X7, X19
    LD1 { V16.1D }, [X7], #8
    ADD  X19, X19, X17
    MOV  X7, X19
    ST1 { V15.2S }, [X7], #8
    MOV  X7, X19
    LD1 { V17.2S }, [X7], #8
    ADD  X19, X19, X17, LSR #0
    MOV  X7, X19
    ST1 { V6.4H }, [X7], #8
    MOV  X7, X19
    LD1 { V17.4H }, [X7], #8
    ADD  X19, X19, X17, ASR #0
    MOV  X7, X19
    ST1 { V20.8B }, [X7], #8
    MOV  X7, X19
    LD1 { V19.8B }, [X7], #8
    ADD  X19, X19, X17, LSR #0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D0
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, V1.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D1
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, V2.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D2
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, V3.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D3
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D4
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D5
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D6
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D7
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D8
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D9
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D10
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D11
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D12
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D13
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D14
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D15
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D16
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D17
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D18
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D19
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D20
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, V21.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D21
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, V22.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D22
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, V23.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D23
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D24
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D25
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D26
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D27
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D28
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D29
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D30
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X10, D31
    SUB  X20, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X29
    FMOV  V2.D[1], X4
    FMOV  D3, X18
    FMOV  V3.D[1], X24
    FMOV  D4, X18
    FMOV  V4.D[1], X27
    FMOV  D5, X7
    FMOV  V5.D[1], X17
    FMOV  D6, X25
    FMOV  V6.D[1], X20
    FMOV  D7, X18
    FMOV  V7.D[1], X7
    FMOV  D8, X29
    FMOV  V8.D[1], X22
    FMOV  D9, X24
    FMOV  V9.D[1], X19
    FMOV  D10, X27
    FMOV  V10.D[1], X29
    FMOV  D11, X16
    FMOV  V11.D[1], X2
    FMOV  D12, X27
    FMOV  V12.D[1], X19
    FMOV  D13, X11
    FMOV  V13.D[1], X17
    FMOV  D14, X27
    FMOV  V14.D[1], X23
    FMOV  D15, X25
    FMOV  V15.D[1], X18
    FMOV  D16, X29
    FMOV  V16.D[1], X21
    FMOV  D17, X20
    FMOV  V17.D[1], X10
    FMOV  D18, X9
    FMOV  V18.D[1], X29
    FMOV  D19, X29
    FMOV  V19.D[1], X24
    FMOV  D20, X17
    FMOV  V20.D[1], X13
    FMOV  D21, X19
    FMOV  V21.D[1], X4
    FMOV  D22, X5
    FMOV  V22.D[1], X27
    FMOV  D23, X11
    FMOV  V23.D[1], X25
    FMOV  D24, X15
    FMOV  V24.D[1], X23
    FMOV  D25, X23
    FMOV  V25.D[1], X22
    FMOV  D26, X7
    FMOV  V26.D[1], X9
    FMOV  D27, X10
    FMOV  V27.D[1], X24
    FMOV  D28, X24
    FMOV  V28.D[1], X25
    FMOV  D29, X23
    FMOV  V29.D[1], X23
    FMOV  D30, X10
    FMOV  V30.D[1], X18
    FMOV  D31, X26
    FMOV  V31.D[1], X2
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X22, #0x500, LSL #0
    ADD  X18, X30, X22, LSR #0
    ST1 { V23.4H, V24.4H }, [X18]
    LD1 { V8.2S, V9.2S }, [X18]
    ADD  X18, X18, X20
    ST1 { V25.1D, V26.1D }, [X18]
    LD1 { V23.1D, V24.1D }, [X18]
    ADD  X18, X18, X20
    ST1 { V8.2S, V9.2S }, [X18]
    LD1 { V4.2S, V5.2S }, [X18]
    ADD  X18, X18, X20, LSR #0
    ST1 { V13.4H, V14.4H }, [X18]
    LD1 { V3.4H, V4.4H }, [X18]
    ADD  X18, X18, X20, ASR #0
    ST1 { V0.8B, V1.8B }, [X18]
    LD1 { V25.8B, V26.8B }, [X18]
    ADD  X18, X18, X20, LSR #0
    MOV  X27, X18
    ST1 { V4.2D, V5.2D, V6.2D, V7.2D }, [X27], #64
    MOV  X27, X18
    LD1 { V31.4S, V0.4S, V1.4S, V2.4S }, [X27], #64
    ADD  X18, X18, X20
    MOV  X27, X18
    ST1 { V31.16B, V0.16B, V1.16B, V2.16B }, [X27], #64
    MOV  X27, X18
    LD1 { V8.16B, V9.16B, V10.16B, V11.16B }, [X27], #64
    ADD  X18, X18, X20, ASR #0
    MOV  X27, X18
    ST1 { V8.2D, V9.2D, V10.2D, V11.2D }, [X27], #64
    MOV  X27, X18
    LD1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X27], #64
    ADD  X18, X18, X20, LSR #0
    MOV  X27, X18
    ST1 { V17.4S, V18.4S, V19.4S, V20.4S }, [X27], #64
    MOV  X27, X18
    LD1 { V8.4S, V9.4S, V10.4S, V11.4S }, [X27], #64
    ADD  X18, X18, X20, ASR #0
    MOV  X27, X18
    ST1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X27], #64
    MOV  X27, X18
    LD1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X27], #64
    ADD  X18, X18, X20
    MOV  X27, X18
    ST1 { V8.2S, V9.2S, V10.2S, V11.2S }, [X27], #32
    MOV  X27, X18
    LD1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X27], #32
    ADD  X18, X18, X20
    MOV  X27, X18
    ST1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X27], #32
    MOV  X27, X18
    LD1 { V8.1D, V9.1D, V10.1D, V11.1D }, [X27], #32
    ADD  X18, X18, X20
    MOV  X27, X18
    ST1 { V1.2S, V2.2S, V3.2S, V4.2S }, [X27], #32
    MOV  X27, X18
    LD1 { V1.2S, V2.2S, V3.2S, V4.2S }, [X27], #32
    ADD  X18, X18, X20, ASR #0
    MOV  X27, X18
    ST1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X27], #32
    MOV  X27, X18
    LD1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X27], #32
    ADD  X18, X18, X20, LSR #0
    MOV  X27, X18
    ST1 { V8.8B, V9.8B, V10.8B, V11.8B }, [X27], #32
    MOV  X27, X18
    LD1 { V22.8B, V23.8B, V24.8B, V25.8B }, [X27], #32
    ADD  X18, X18, X20
    ST1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X18], X29
    LD1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X18], X29
    ADD  X18, X18, X20
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X18], X29
    LD1 { V20.16B, V21.16B, V22.16B, V23.16B }, [X18], X29
    ADD  X18, X18, X20
    ST1 { V20.2D, V21.2D, V22.2D, V23.2D }, [X18], X29
    LD1 { V8.2D, V9.2D, V10.2D, V11.2D }, [X18], X29
    ADD  X18, X18, X20, LSR #0
    ST1 { V8.4S, V9.4S, V10.4S, V11.4S }, [X18], X29
    LD1 { V8.4S, V9.4S, V10.4S, V11.4S }, [X18], X29
    ADD  X18, X18, X20
    ST1 { V8.8H, V9.8H, V10.8H, V11.8H }, [X18], X29
    LD1 { V19.8H, V20.8H, V21.8H, V22.8H }, [X18], X29
    ADD  X18, X18, X20
    ST1 { V1.1D, V2.1D, V3.1D, V4.1D }, [X18], X29
    LD1 { V2.8B, V3.8B, V4.8B, V5.8B }, [X18], X29
    ADD  X18, X18, X20
    ST1 { V19.1D, V20.1D, V21.1D, V22.1D }, [X18], X29
    LD1 { V15.1D, V16.1D, V17.1D, V18.1D }, [X18], X29
    ADD  X18, X18, X20, ASR #0
    ST1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X18], X29
    LD1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X18], X29
    ADD  X18, X18, X20, LSR #0
    ST1 { V2.4H, V3.4H, V4.4H, V5.4H }, [X18], X29
    LD1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X18], X29
    ADD  X18, X18, X20, ASR #0
    ST1 { V8.8B, V9.8B, V10.8B, V11.8B }, [X18], X29
    LD1 { V0.8B, V1.8B, V2.8B, V3.8B }, [X18], X29
    ADD  X18, X18, X20, ASR #0
    MOV  X27, X18
    ST1 { V16.8H }, [X27], #16
    MOV  X27, X18
    LD1 { V22.8H }, [X27], #16
    ADD  X18, X18, X20
    MOV  X27, X18
    ST1 { V3.16B }, [X27], #16
    MOV  X27, X18
    LD1 { V9.16B }, [X27], #16
    ADD  X18, X18, X20
    MOV  X27, X18
    ST1 { V2.2D }, [X27], #16
    MOV  X27, X18
    LD1 { V3.2D }, [X27], #16
    ADD  X18, X18, X20, ASR #0
    MOV  X27, X18
    ST1 { V9.4S }, [X27], #16
    MOV  X27, X18
    LD1 { V16.4S }, [X27], #16
    ADD  X18, X18, X20, ASR #0
    MOV  X27, X18
    ST1 { V16.8H }, [X27], #16
    MOV  X27, X18
    LD1 { V2.8H }, [X27], #16
    ADD  X18, X18, X20
    MOV  X27, X18
    ST1 { V1.8B }, [X27], #8
    MOV  X27, X18
    LD1 { V1.8B }, [X27], #8
    ADD  X18, X18, X20
    MOV  X27, X18
    ST1 { V1.1D }, [X27], #8
    MOV  X27, X18
    LD1 { V24.1D }, [X27], #8
    ADD  X18, X18, X20, ASR #0
    MOV  X27, X18
    ST1 { V2.2S }, [X27], #8
    MOV  X27, X18
    LD1 { V31.2S }, [X27], #8
    ADD  X18, X18, X20, ASR #0
    MOV  X27, X18
    ST1 { V3.4H }, [X27], #8
    MOV  X27, X18
    LD1 { V4.4H }, [X27], #8
    ADD  X18, X18, X20
    MOV  X27, X18
    ST1 { V24.8B }, [X27], #8
    MOV  X27, X18
    LD1 { V10.8B }, [X27], #8
    ADD  X18, X18, X20, LSR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X9, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V6.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V7.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V12.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V23.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V29.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X4
    FMOV  V3.D[1], X4
    FMOV  D4, X16
    FMOV  V4.D[1], X14
    FMOV  D5, X24
    FMOV  V5.D[1], X15
    FMOV  D6, X21
    FMOV  V6.D[1], X24
    FMOV  D7, X10
    FMOV  V7.D[1], X11
    FMOV  D8, X27
    FMOV  V8.D[1], X20
    FMOV  D9, X18
    FMOV  V9.D[1], X19
    FMOV  D10, X26
    FMOV  V10.D[1], X27
    FMOV  D11, X19
    FMOV  V11.D[1], X7
    FMOV  D12, X23
    FMOV  V12.D[1], X25
    FMOV  D13, X22
    FMOV  V13.D[1], X20
    FMOV  D14, X27
    FMOV  V14.D[1], X21
    FMOV  D15, X21
    FMOV  V15.D[1], X23
    FMOV  D16, X2
    FMOV  V16.D[1], X7
    FMOV  D17, X16
    FMOV  V17.D[1], X24
    FMOV  D18, X9
    FMOV  V18.D[1], X20
    FMOV  D19, X14
    FMOV  V19.D[1], X15
    FMOV  D20, X16
    FMOV  V20.D[1], X7
    FMOV  D21, X12
    FMOV  V21.D[1], X15
    FMOV  D22, X13
    FMOV  V22.D[1], X27
    FMOV  D23, X17
    FMOV  V23.D[1], X4
    FMOV  D24, X17
    FMOV  V24.D[1], X15
    FMOV  D25, X21
    FMOV  V25.D[1], X18
    FMOV  D26, X26
    FMOV  V26.D[1], X14
    FMOV  D27, X17
    FMOV  V27.D[1], X13
    FMOV  D28, X25
    FMOV  V28.D[1], X18
    FMOV  D29, X4
    FMOV  V29.D[1], X14
    FMOV  D30, X14
    FMOV  V30.D[1], X17
    FMOV  D31, X7
    FMOV  V31.D[1], X16
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X16, #0xa00, LSL #0
    ADD  X21, X30, X16
    ST1 { V3.4H, V4.4H }, [X21]
    LD1 { V19.1D, V20.1D }, [X21]
    ADD  X21, X21, X26
    ST1 { V25.1D, V26.1D }, [X21]
    LD1 { V0.1D, V1.1D }, [X21]
    ADD  X21, X21, X26
    ST1 { V3.2S, V4.2S }, [X21]
    LD1 { V14.2S, V15.2S }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V23.4H, V24.4H }, [X21]
    LD1 { V2.4H, V3.4H }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V31.8B, V0.8B }, [X21]
    LD1 { V21.8B, V22.8B }, [X21]
    ADD  X21, X21, X26, LSR #0
    MOV  X27, X21
    ST1 { V19.2D, V20.2D, V21.2D, V22.2D }, [X27], #64
    MOV  X27, X21
    LD1 { V4.8H, V5.8H, V6.8H, V7.8H }, [X27], #64
    ADD  X21, X21, X26
    MOV  X27, X21
    ST1 { V1.16B, V2.16B, V3.16B, V4.16B }, [X27], #64
    MOV  X27, X21
    LD1 { V17.16B, V18.16B, V19.16B, V20.16B }, [X27], #64
    ADD  X21, X21, X26, LSR #0
    MOV  X27, X21
    ST1 { V17.2D, V18.2D, V19.2D, V20.2D }, [X27], #64
    MOV  X27, X21
    LD1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X27], #64
    ADD  X21, X21, X26, ASR #0
    MOV  X27, X21
    ST1 { V29.4S, V30.4S, V31.4S, V0.4S }, [X27], #64
    MOV  X27, X21
    LD1 { V18.4S, V19.4S, V20.4S, V21.4S }, [X27], #64
    ADD  X21, X21, X26, LSR #0
    MOV  X27, X21
    ST1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X27], #64
    MOV  X27, X21
    LD1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X27], #64
    ADD  X21, X21, X26, LSR #0
    MOV  X27, X21
    ST1 { V1.4H, V2.4H, V3.4H, V4.4H }, [X27], #32
    MOV  X27, X21
    LD1 { V1.8B, V2.8B, V3.8B, V4.8B }, [X27], #32
    ADD  X21, X21, X26, ASR #0
    MOV  X27, X21
    ST1 { V18.1D, V19.1D, V20.1D, V21.1D }, [X27], #32
    MOV  X27, X21
    LD1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X27], #32
    ADD  X21, X21, X26
    MOV  X27, X21
    ST1 { V1.2S, V2.2S, V3.2S, V4.2S }, [X27], #32
    MOV  X27, X21
    LD1 { V18.2S, V19.2S, V20.2S, V21.2S }, [X27], #32
    ADD  X21, X21, X26, ASR #0
    MOV  X27, X21
    ST1 { V29.4H, V30.4H, V31.4H, V0.4H }, [X27], #32
    MOV  X27, X21
    LD1 { V1.4H, V2.4H, V3.4H, V4.4H }, [X27], #32
    ADD  X21, X21, X26
    MOV  X27, X21
    ST1 { V18.8B, V19.8B, V20.8B, V21.8B }, [X27], #32
    MOV  X27, X21
    LD1 { V29.8B, V30.8B, V31.8B, V0.8B }, [X27], #32
    ADD  X21, X21, X26, LSR #0
    ST1 { V1.4S, V2.4S, V3.4S, V4.4S }, [X21], X15
    LD1 { V18.4S, V19.4S, V20.4S, V21.4S }, [X21], X15
    ADD  X21, X21, X26, LSR #0
    ST1 { V18.16B, V19.16B, V20.16B, V21.16B }, [X21], X15
    LD1 { V18.16B, V19.16B, V20.16B, V21.16B }, [X21], X15
    ADD  X21, X21, X26, LSR #0
    ST1 { V18.2D, V19.2D, V20.2D, V21.2D }, [X21], X15
    LD1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X21], X15
    ADD  X21, X21, X26
    ST1 { V1.4S, V2.4S, V3.4S, V4.4S }, [X21], X15
    LD1 { V18.4S, V19.4S, V20.4S, V21.4S }, [X21], X15
    ADD  X21, X21, X26
    ST1 { V18.8H, V19.8H, V20.8H, V21.8H }, [X21], X15
    LD1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X21], X15
    ADD  X21, X21, X26, LSR #0
    ST1 { V29.2S, V30.2S, V31.2S, V0.2S }, [X21], X15
    LD1 { V18.1D, V19.1D, V20.1D, V21.1D }, [X21], X15
    ADD  X21, X21, X26, ASR #0
    ST1 { V1.1D, V2.1D, V3.1D, V4.1D }, [X21], X15
    LD1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X21], X15
    ADD  X21, X21, X26, ASR #0
    ST1 { V18.2S, V19.2S, V20.2S, V21.2S }, [X21], X15
    LD1 { V18.2S, V19.2S, V20.2S, V21.2S }, [X21], X15
    ADD  X21, X21, X26, ASR #0
    ST1 { V18.4H, V19.4H, V20.4H, V21.4H }, [X21], X15
    LD1 { V1.4H, V2.4H, V3.4H, V4.4H }, [X21], X15
    ADD  X21, X21, X26
    ST1 { V1.8B, V2.8B, V3.8B, V4.8B }, [X21], X15
    LD1 { V1.8B, V2.8B, V3.8B, V4.8B }, [X21], X15
    ADD  X21, X21, X26, ASR #0
    MOV  X27, X21
    ST1 { V2.16B }, [X27], #16
    MOV  X27, X21
    LD1 { V2.8H }, [X27], #16
    ADD  X21, X21, X26, LSR #0
    MOV  X27, X21
    ST1 { V30.16B }, [X27], #16
    MOV  X27, X21
    LD1 { V20.16B }, [X27], #16
    ADD  X21, X21, X26, ASR #0
    MOV  X27, X21
    ST1 { V1.2D }, [X27], #16
    MOV  X27, X21
    LD1 { V18.2D }, [X27], #16
    ADD  X21, X21, X26, LSR #0
    MOV  X27, X21
    ST1 { V20.4S }, [X27], #16
    MOV  X27, X21
    LD1 { V30.4S }, [X27], #16
    ADD  X21, X21, X26, LSR #0
    MOV  X27, X21
    ST1 { V18.8H }, [X27], #16
    MOV  X27, X21
    LD1 { V18.8H }, [X27], #16
    ADD  X21, X21, X26
    MOV  X27, X21
    ST1 { V18.8B }, [X27], #8
    MOV  X27, X21
    LD1 { V20.8B }, [X27], #8
    ADD  X21, X21, X26, ASR #0
    MOV  X27, X21
    ST1 { V2.1D }, [X27], #8
    MOV  X27, X21
    LD1 { V22.1D }, [X27], #8
    ADD  X21, X21, X26, LSR #0
    MOV  X27, X21
    ST1 { V30.2S }, [X27], #8
    MOV  X27, X21
    LD1 { V20.2S }, [X27], #8
    ADD  X21, X21, X26, LSR #0
    MOV  X27, X21
    ST1 { V20.4H }, [X27], #8
    MOV  X27, X21
    LD1 { V30.4H }, [X27], #8
    ADD  X21, X21, X26, ASR #0
    MOV  X27, X21
    ST1 { V5.8B }, [X27], #8
    MOV  X27, X21
    LD1 { V13.8B }, [X27], #8
    ADD  X21, X21, X26
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X12, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D0
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D1
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D2
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D3
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D4
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D5
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D6
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D7
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V8.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D8
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V9.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D9
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V10.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D10
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V11.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D11
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V12.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D12
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D13
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D14
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D15
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V16.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D16
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D17
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D18
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D19
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D20
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D21
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D22
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V23.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D23
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V24.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D24
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D25
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V26.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D26
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D27
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, V28.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D28
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D29
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D30
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X12, D31
    SUB  X2, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X29
    FMOV  D1, X23
    FMOV  V1.D[1], X22
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X18
    FMOV  V3.D[1], X20
    FMOV  D4, X19
    FMOV  V4.D[1], X25
    FMOV  D5, X9
    FMOV  V5.D[1], X7
    FMOV  D6, X21
    FMOV  V6.D[1], X14
    FMOV  D7, X20
    FMOV  V7.D[1], X2
    FMOV  D8, X16
    FMOV  V8.D[1], X18
    FMOV  D9, X22
    FMOV  V9.D[1], X26
    FMOV  D10, X17
    FMOV  V10.D[1], X25
    FMOV  D11, X29
    FMOV  V11.D[1], X11
    FMOV  D12, X27
    FMOV  V12.D[1], X2
    FMOV  D13, X2
    FMOV  V13.D[1], X9
    FMOV  D14, X9
    FMOV  V14.D[1], X5
    FMOV  D15, X18
    FMOV  V15.D[1], X24
    FMOV  D16, X7
    FMOV  V16.D[1], X9
    FMOV  D17, X19
    FMOV  V17.D[1], X7
    FMOV  D18, X10
    FMOV  V18.D[1], X12
    FMOV  D19, X18
    FMOV  V19.D[1], X15
    FMOV  D20, X29
    FMOV  V20.D[1], X23
    FMOV  D21, X2
    FMOV  V21.D[1], X10
    FMOV  D22, X4
    FMOV  V22.D[1], X5
    FMOV  D23, X5
    FMOV  V23.D[1], X25
    FMOV  D24, X23
    FMOV  V24.D[1], X11
    FMOV  D25, X5
    FMOV  V25.D[1], X2
    FMOV  D26, X14
    FMOV  V26.D[1], X9
    FMOV  D27, X19
    FMOV  V27.D[1], X26
    FMOV  D28, X24
    FMOV  V28.D[1], X13
    FMOV  D29, X27
    FMOV  V29.D[1], X4
    FMOV  D30, X5
    FMOV  V30.D[1], X5
    FMOV  D31, X9
    FMOV  V31.D[1], X23
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X16, #0xf00, LSL #0
    ADD  X25, X30, X16, ASR #0
    ST1 { V22.8B, V23.8B }, [X25]
    LD1 { V10.2S, V11.2S }, [X25]
    ADD  X25, X25, X19
    ST1 { V26.1D, V27.1D }, [X25]
    LD1 { V19.1D, V20.1D }, [X25]
    ADD  X25, X25, X19, LSR #0
    ST1 { V10.2S, V11.2S }, [X25]
    LD1 { V13.2S, V14.2S }, [X25]
    ADD  X25, X25, X19, ASR #0
    ST1 { V13.4H, V14.4H }, [X25]
    LD1 { V31.4H, V0.4H }, [X25]
    ADD  X25, X25, X19
    ST1 { V30.8B, V31.8B }, [X25]
    LD1 { V9.8B, V10.8B }, [X25]
    ADD  X25, X25, X19
    MOV  X10, X25
    ST1 { V4.4S, V5.4S, V6.4S, V7.4S }, [X10], #64
    MOV  X10, X25
    LD1 { V26.4S, V27.4S, V28.4S, V29.4S }, [X10], #64
    ADD  X25, X25, X19, LSR #0
    MOV  X10, X25
    ST1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X10], #64
    MOV  X10, X25
    LD1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X10], #64
    ADD  X25, X25, X19
    MOV  X10, X25
    ST1 { V26.2D, V27.2D, V28.2D, V29.2D }, [X10], #64
    MOV  X10, X25
    LD1 { V26.2D, V27.2D, V28.2D, V29.2D }, [X10], #64
    ADD  X25, X25, X19
    MOV  X10, X25
    ST1 { V26.4S, V27.4S, V28.4S, V29.4S }, [X10], #64
    MOV  X10, X25
    LD1 { V2.4S, V3.4S, V4.4S, V5.4S }, [X10], #64
    ADD  X25, X25, X19
    MOV  X10, X25
    ST1 { V2.8H, V3.8H, V4.8H, V5.8H }, [X10], #64
    MOV  X10, X25
    LD1 { V2.8H, V3.8H, V4.8H, V5.8H }, [X10], #64
    ADD  X25, X25, X19, ASR #0
    MOV  X10, X25
    ST1 { V2.2S, V3.2S, V4.2S, V5.2S }, [X10], #32
    MOV  X10, X25
    LD1 { V26.2S, V27.2S, V28.2S, V29.2S }, [X10], #32
    ADD  X25, X25, X19, ASR #0
    MOV  X10, X25
    ST1 { V26.1D, V27.1D, V28.1D, V29.1D }, [X10], #32
    MOV  X10, X25
    LD1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X10], #32
    ADD  X25, X25, X19, ASR #0
    MOV  X10, X25
    ST1 { V6.2S, V7.2S, V8.2S, V9.2S }, [X10], #32
    MOV  X10, X25
    LD1 { V26.2S, V27.2S, V28.2S, V29.2S }, [X10], #32
    ADD  X25, X25, X19
    MOV  X10, X25
    ST1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X10], #32
    MOV  X10, X25
    LD1 { V26.4H, V27.4H, V28.4H, V29.4H }, [X10], #32
    ADD  X25, X25, X19
    MOV  X10, X25
    ST1 { V26.8B, V27.8B, V28.8B, V29.8B }, [X10], #32
    MOV  X10, X25
    LD1 { V7.8B, V8.8B, V9.8B, V10.8B }, [X10], #32
    ADD  X25, X25, X19, ASR #0
    ST1 { V30.8H, V31.8H, V0.8H, V1.8H }, [X25], X4
    LD1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X25], X4
    ADD  X25, X25, X19, ASR #0
    ST1 { V7.16B, V8.16B, V9.16B, V10.16B }, [X25], X4
    LD1 { V30.16B, V31.16B, V0.16B, V1.16B }, [X25], X4
    ADD  X25, X25, X19, LSR #0
    ST1 { V30.2D, V31.2D, V0.2D, V1.2D }, [X25], X4
    LD1 { V7.2D, V8.2D, V9.2D, V10.2D }, [X25], X4
    ADD  X25, X25, X19
    ST1 { V7.4S, V8.4S, V9.4S, V10.4S }, [X25], X4
    LD1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X25], X4
    ADD  X25, X25, X19, ASR #0
    ST1 { V26.8H, V27.8H, V28.8H, V29.8H }, [X25], X4
    LD1 { V7.8H, V8.8H, V9.8H, V10.8H }, [X25], X4
    ADD  X25, X25, X19
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X25], X4
    LD1 { V30.1D, V31.1D, V0.1D, V1.1D }, [X25], X4
    ADD  X25, X25, X19, ASR #0
    ST1 { V7.1D, V8.1D, V9.1D, V10.1D }, [X25], X4
    LD1 { V26.1D, V27.1D, V28.1D, V29.1D }, [X25], X4
    ADD  X25, X25, X19
    ST1 { V20.2S, V21.2S, V22.2S, V23.2S }, [X25], X4
    LD1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X25], X4
    ADD  X25, X25, X19, ASR #0
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X25], X4
    LD1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X25], X4
    ADD  X25, X25, X19, ASR #0
    ST1 { V13.8B, V14.8B, V15.8B, V16.8B }, [X25], X4
    LD1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X25], X4
    ADD  X25, X25, X19, LSR #0
    MOV  X10, X25
    ST1 { V1.8H }, [X10], #16
    MOV  X10, X25
    LD1 { V12.16B }, [X10], #16
    ADD  X25, X25, X19, LSR #0
    MOV  X10, X25
    ST1 { V8.16B }, [X10], #16
    MOV  X10, X25
    LD1 { V1.16B }, [X10], #16
    ADD  X25, X25, X19, LSR #0
    MOV  X10, X25
    ST1 { V9.2D }, [X10], #16
    MOV  X10, X25
    LD1 { V15.2D }, [X10], #16
    ADD  X25, X25, X19, ASR #0
    MOV  X10, X25
    ST1 { V23.4S }, [X10], #16
    MOV  X10, X25
    LD1 { V8.4S }, [X10], #16
    ADD  X25, X25, X19
    MOV  X10, X25
    ST1 { V8.8H }, [X10], #16
    MOV  X10, X25
    LD1 { V23.8H }, [X10], #16
    ADD  X25, X25, X19, LSR #0
    MOV  X10, X25
    ST1 { V12.1D }, [X10], #8
    MOV  X10, X25
    LD1 { V9.4H }, [X10], #8
    ADD  X25, X25, X19, ASR #0
    MOV  X10, X25
    ST1 { V9.1D }, [X10], #8
    MOV  X10, X25
    LD1 { V30.1D }, [X10], #8
    ADD  X25, X25, X19, LSR #0
    MOV  X10, X25
    ST1 { V15.2S }, [X10], #8
    MOV  X10, X25
    LD1 { V6.2S }, [X10], #8
    ADD  X25, X25, X19, LSR #0
    MOV  X10, X25
    ST1 { V30.4H }, [X10], #8
    MOV  X10, X25
    LD1 { V9.4H }, [X10], #8
    ADD  X25, X25, X19, LSR #0
    MOV  X10, X25
    ST1 { V9.8B }, [X10], #8
    MOV  X10, X25
    LD1 { V12.8B }, [X10], #8
    ADD  X25, X25, X19, ASR #0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X5, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    MRS  X5, FPSR
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V0.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D0
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V1.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D1
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V2.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D2
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V3.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D3
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V4.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D4
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V5.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D5
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V6.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D6
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V7.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D7
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V8.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D8
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V9.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D9
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D10
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D11
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D12
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V13.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D13
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D14
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D15
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, V16.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D16
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, V17.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D17
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, V18.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D18
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V19.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D19
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D20
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D21
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V22.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D22
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D23
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, V24.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D24
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, V25.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D25
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D26
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D27
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V28.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D28
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V29.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D29
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D30
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X5, D31
    SUB  X27, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X23
    FMOV  D2, X22
    FMOV  V2.D[1], X25
    FMOV  D3, X26
    FMOV  V3.D[1], X7
    FMOV  D4, X23
    FMOV  V4.D[1], X2
    FMOV  D5, X11
    FMOV  V5.D[1], X22
    FMOV  D6, X20
    FMOV  V6.D[1], X21
    FMOV  D7, X11
    FMOV  V7.D[1], X5
    FMOV  D8, X24
    FMOV  V8.D[1], X9
    FMOV  D9, X7
    FMOV  V9.D[1], X17
    FMOV  D10, X5
    FMOV  V10.D[1], X5
    FMOV  D11, X15
    FMOV  V11.D[1], X13
    FMOV  D12, X19
    FMOV  V12.D[1], X19
    FMOV  D13, X12
    FMOV  V13.D[1], X21
    FMOV  D14, X29
    FMOV  V14.D[1], X25
    FMOV  D15, X7
    FMOV  V15.D[1], X17
    FMOV  D16, X27
    FMOV  V16.D[1], X22
    FMOV  D17, X23
    FMOV  V17.D[1], X19
    FMOV  D18, X21
    FMOV  V18.D[1], X27
    FMOV  D19, X15
    FMOV  V19.D[1], X24
    FMOV  D20, X10
    FMOV  V20.D[1], X7
    FMOV  D21, X15
    FMOV  V21.D[1], X24
    FMOV  D22, X10
    FMOV  V22.D[1], X4
    FMOV  D23, X24
    FMOV  V23.D[1], X4
    FMOV  D24, X15
    FMOV  V24.D[1], X21
    FMOV  D25, X10
    FMOV  V25.D[1], X17
    FMOV  D26, X20
    FMOV  V26.D[1], X9
    FMOV  D27, X11
    FMOV  V27.D[1], X24
    FMOV  D28, X16
    FMOV  V28.D[1], X12
    FMOV  D29, X9
    FMOV  V29.D[1], X17
    FMOV  D30, X2
    FMOV  V30.D[1], X19
    FMOV  D31, X2
    FMOV  V31.D[1], X10
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X12, #0x1400, LSL #0
    ADD  X15, X30, X12, LSR #0
    ST1 { V10.8B, V11.8B }, [X15]
    LD1 { V29.4H, V30.4H }, [X15]
    ADD  X15, X15, X14
    ST1 { V15.1D, V16.1D }, [X15]
    LD1 { V23.1D, V24.1D }, [X15]
    ADD  X15, X15, X14
    ST1 { V13.2S, V14.2S }, [X15]
    LD1 { V26.2S, V27.2S }, [X15]
    ADD  X15, X15, X14, ASR #0
    ST1 { V29.4H, V30.4H }, [X15]
    LD1 { V0.4H, V1.4H }, [X15]
    ADD  X15, X15, X14, LSR #0
    ST1 { V23.8B, V24.8B }, [X15]
    LD1 { V19.8B, V20.8B }, [X15]
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V20.4S, V21.4S, V22.4S, V23.4S }, [X9], #64
    MOV  X9, X15
    LD1 { V3.8H, V4.8H, V5.8H, V6.8H }, [X9], #64
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V3.16B, V4.16B, V5.16B, V6.16B }, [X9], #64
    MOV  X9, X15
    LD1 { V20.16B, V21.16B, V22.16B, V23.16B }, [X9], #64
    ADD  X15, X15, X14
    MOV  X9, X15
    ST1 { V20.2D, V21.2D, V22.2D, V23.2D }, [X9], #64
    MOV  X9, X15
    LD1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X9], #64
    ADD  X15, X15, X14
    MOV  X9, X15
    ST1 { V3.4S, V4.4S, V5.4S, V6.4S }, [X9], #64
    MOV  X9, X15
    LD1 { V3.4S, V4.4S, V5.4S, V6.4S }, [X9], #64
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V3.8H, V4.8H, V5.8H, V6.8H }, [X9], #64
    MOV  X9, X15
    LD1 { V30.8H, V31.8H, V0.8H, V1.8H }, [X9], #64
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V2.4H, V3.4H, V4.4H, V5.4H }, [X9], #32
    MOV  X9, X15
    LD1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X9], #32
    ADD  X15, X15, X14, LSR #0
    MOV  X9, X15
    ST1 { V30.1D, V31.1D, V0.1D, V1.1D }, [X9], #32
    MOV  X9, X15
    LD1 { V30.1D, V31.1D, V0.1D, V1.1D }, [X9], #32
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V3.2S, V4.2S, V5.2S, V6.2S }, [X9], #32
    MOV  X9, X15
    LD1 { V20.2S, V21.2S, V22.2S, V23.2S }, [X9], #32
    ADD  X15, X15, X14
    MOV  X9, X15
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X9], #32
    MOV  X9, X15
    LD1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X9], #32
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V3.8B, V4.8B, V5.8B, V6.8B }, [X9], #32
    MOV  X9, X15
    LD1 { V30.8B, V31.8B, V0.8B, V1.8B }, [X9], #32
    ADD  X15, X15, X14, LSR #0
    ST1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X15], X17
    LD1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X15], X17
    ADD  X15, X15, X14
    ST1 { V20.16B, V21.16B, V22.16B, V23.16B }, [X15], X17
    LD1 { V30.16B, V31.16B, V0.16B, V1.16B }, [X15], X17
    ADD  X15, X15, X14
    ST1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X15], X17
    LD1 { V20.2D, V21.2D, V22.2D, V23.2D }, [X15], X17
    ADD  X15, X15, X14, LSR #0
    ST1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X15], X17
    LD1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X15], X17
    ADD  X15, X15, X14, LSR #0
    ST1 { V20.8H, V21.8H, V22.8H, V23.8H }, [X15], X17
    LD1 { V3.8H, V4.8H, V5.8H, V6.8H }, [X15], X17
    ADD  X15, X15, X14, ASR #0
    ST1 { V3.8B, V4.8B, V5.8B, V6.8B }, [X15], X17
    LD1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X15], X17
    ADD  X15, X15, X14, ASR #0
    ST1 { V20.1D, V21.1D, V22.1D, V23.1D }, [X15], X17
    LD1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X15], X17
    ADD  X15, X15, X14
    ST1 { V30.2S, V31.2S, V0.2S, V1.2S }, [X15], X17
    LD1 { V20.2S, V21.2S, V22.2S, V23.2S }, [X15], X17
    ADD  X15, X15, X14, LSR #0
    ST1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X15], X17
    LD1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X15], X17
    ADD  X15, X15, X14, LSR #0
    ST1 { V30.8B, V31.8B, V0.8B, V1.8B }, [X15], X17
    LD1 { V30.8B, V31.8B, V0.8B, V1.8B }, [X15], X17
    ADD  X15, X15, X14, LSR #0
    MOV  X9, X15
    ST1 { V1.2D }, [X9], #16
    MOV  X9, X15
    LD1 { V5.2D }, [X9], #16
    ADD  X15, X15, X14
    MOV  X9, X15
    ST1 { V5.16B }, [X9], #16
    MOV  X9, X15
    LD1 { V6.16B }, [X9], #16
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V6.2D }, [X9], #16
    MOV  X9, X15
    LD1 { V5.2D }, [X9], #16
    ADD  X15, X15, X14, LSR #0
    MOV  X9, X15
    ST1 { V30.4S }, [X9], #16
    MOV  X9, X15
    LD1 { V6.4S }, [X9], #16
    ADD  X15, X15, X14, LSR #0
    MOV  X9, X15
    ST1 { V6.8H }, [X9], #16
    MOV  X9, X15
    LD1 { V6.8H }, [X9], #16
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V5.8B }, [X9], #8
    MOV  X9, X15
    LD1 { V30.8B }, [X9], #8
    ADD  X15, X15, X14, LSR #0
    MOV  X9, X15
    ST1 { V6.1D }, [X9], #8
    MOV  X9, X15
    LD1 { V6.1D }, [X9], #8
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V22.2S }, [X9], #8
    MOV  X9, X15
    LD1 { V13.2S }, [X9], #8
    ADD  X15, X15, X14, ASR #0
    MOV  X9, X15
    ST1 { V17.4H }, [X9], #8
    MOV  X9, X15
    LD1 { V23.4H }, [X9], #8
    ADD  X15, X15, X14, LSR #0
    MOV  X9, X15
    ST1 { V25.8B }, [X9], #8
    MOV  X9, X15
    LD1 { V31.8B }, [X9], #8
    ADD  X15, X15, X14
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X23, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    MRS  X23, FPSR
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V0.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D0
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V1.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D1
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V2.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D2
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V3.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D3
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D4
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D5
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D6
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V7.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D7
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V8.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D8
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V9.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D9
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V10.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D10
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V11.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D11
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V12.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D12
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V13.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D13
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V14.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D14
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V15.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D15
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V16.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D16
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V17.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D17
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V18.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D18
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D19
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V20.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D20
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V21.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D21
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D22
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D23
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V24.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D24
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V25.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D25
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D26
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D27
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, V28.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D28
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D29
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D30
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X23, D31
    SUB  X21, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X4
    FMOV  V2.D[1], X22
    FMOV  D3, X9
    FMOV  V3.D[1], X19
    FMOV  D4, X25
    FMOV  V4.D[1], X11
    FMOV  D5, X4
    FMOV  V5.D[1], X24
    FMOV  D6, X16
    FMOV  V6.D[1], X29
    FMOV  D7, X12
    FMOV  V7.D[1], X4
    FMOV  D8, X27
    FMOV  V8.D[1], X16
    FMOV  D9, X16
    FMOV  V9.D[1], X27
    FMOV  D10, X11
    FMOV  V10.D[1], X21
    FMOV  D11, X5
    FMOV  V11.D[1], X18
    FMOV  D12, X2
    FMOV  V12.D[1], X2
    FMOV  D13, X7
    FMOV  V13.D[1], X7
    FMOV  D14, X22
    FMOV  V14.D[1], X7
    FMOV  D15, X11
    FMOV  V15.D[1], X7
    FMOV  D16, X18
    FMOV  V16.D[1], X25
    FMOV  D17, X19
    FMOV  V17.D[1], X13
    FMOV  D18, X18
    FMOV  V18.D[1], X5
    FMOV  D19, X26
    FMOV  V19.D[1], X18
    FMOV  D20, X7
    FMOV  V20.D[1], X19
    FMOV  D21, X23
    FMOV  V21.D[1], X14
    FMOV  D22, X16
    FMOV  V22.D[1], X25
    FMOV  D23, X12
    FMOV  V23.D[1], X11
    FMOV  D24, X20
    FMOV  V24.D[1], X23
    FMOV  D25, X12
    FMOV  V25.D[1], X22
    FMOV  D26, X22
    FMOV  V26.D[1], X14
    FMOV  D27, X4
    FMOV  V27.D[1], X7
    FMOV  D28, X10
    FMOV  V28.D[1], X11
    FMOV  D29, X27
    FMOV  V29.D[1], X2
    FMOV  D30, X17
    FMOV  V30.D[1], X29
    FMOV  D31, X14
    FMOV  V31.D[1], X11
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X24, #0x1900, LSL #0
    ADD  X18, X30, X24, ASR #0
    ST1 { V26.2S, V27.2S }, [X18]
    LD1 { V20.4H, V21.4H }, [X18]
    ADD  X18, X18, X17, ASR #0
    ST1 { V10.1D, V11.1D }, [X18]
    LD1 { V15.1D, V16.1D }, [X18]
    ADD  X18, X18, X17, LSR #0
    ST1 { V30.2S, V31.2S }, [X18]
    LD1 { V27.2S, V28.2S }, [X18]
    ADD  X18, X18, X17
    ST1 { V27.4H, V28.4H }, [X18]
    LD1 { V6.4H, V7.4H }, [X18]
    ADD  X18, X18, X17, LSR #0
    ST1 { V0.8B, V1.8B }, [X18]
    LD1 { V29.8B, V30.8B }, [X18]
    ADD  X18, X18, X17, ASR #0
    MOV  X19, X18
    ST1 { V12.16B, V13.16B, V14.16B, V15.16B }, [X19], #64
    MOV  X19, X18
    LD1 { V21.2D, V22.2D, V23.2D, V24.2D }, [X19], #64
    ADD  X18, X18, X17, ASR #0
    MOV  X19, X18
    ST1 { V20.16B, V21.16B, V22.16B, V23.16B }, [X19], #64
    MOV  X19, X18
    LD1 { V30.16B, V31.16B, V0.16B, V1.16B }, [X19], #64
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V30.2D, V31.2D, V0.2D, V1.2D }, [X19], #64
    MOV  X19, X18
    LD1 { V12.2D, V13.2D, V14.2D, V15.2D }, [X19], #64
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V12.4S, V13.4S, V14.4S, V15.4S }, [X19], #64
    MOV  X19, X18
    LD1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X19], #64
    ADD  X18, X18, X17, LSR #0
    MOV  X19, X18
    ST1 { V30.8H, V31.8H, V0.8H, V1.8H }, [X19], #64
    MOV  X19, X18
    LD1 { V20.8H, V21.8H, V22.8H, V23.8H }, [X19], #64
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V20.1D, V21.1D, V22.1D, V23.1D }, [X19], #32
    MOV  X19, X18
    LD1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X19], #32
    ADD  X18, X18, X17, ASR #0
    MOV  X19, X18
    ST1 { V7.1D, V8.1D, V9.1D, V10.1D }, [X19], #32
    MOV  X19, X18
    LD1 { V20.1D, V21.1D, V22.1D, V23.1D }, [X19], #32
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V14.2S, V15.2S, V16.2S, V17.2S }, [X19], #32
    MOV  X19, X18
    LD1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X19], #32
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X19], #32
    MOV  X19, X18
    LD1 { V14.4H, V15.4H, V16.4H, V17.4H }, [X19], #32
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X19], #32
    MOV  X19, X18
    LD1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X19], #32
    ADD  X18, X18, X17
    ST1 { V7.4S, V8.4S, V9.4S, V10.4S }, [X18], X29
    LD1 { V30.8H, V31.8H, V0.8H, V1.8H }, [X18], X29
    ADD  X18, X18, X17, LSR #0
    ST1 { V14.16B, V15.16B, V16.16B, V17.16B }, [X18], X29
    LD1 { V7.16B, V8.16B, V9.16B, V10.16B }, [X18], X29
    ADD  X18, X18, X17, LSR #0
    ST1 { V7.2D, V8.2D, V9.2D, V10.2D }, [X18], X29
    LD1 { V14.2D, V15.2D, V16.2D, V17.2D }, [X18], X29
    ADD  X18, X18, X17
    ST1 { V20.4S, V21.4S, V22.4S, V23.4S }, [X18], X29
    LD1 { V20.4S, V21.4S, V22.4S, V23.4S }, [X18], X29
    ADD  X18, X18, X17, ASR #0
    ST1 { V20.8H, V21.8H, V22.8H, V23.8H }, [X18], X29
    LD1 { V20.8H, V21.8H, V22.8H, V23.8H }, [X18], X29
    ADD  X18, X18, X17
    ST1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X18], X29
    LD1 { V7.8B, V8.8B, V9.8B, V10.8B }, [X18], X29
    ADD  X18, X18, X17
    ST1 { V14.1D, V15.1D, V16.1D, V17.1D }, [X18], X29
    LD1 { V20.1D, V21.1D, V22.1D, V23.1D }, [X18], X29
    ADD  X18, X18, X17
    ST1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X18], X29
    LD1 { V14.2S, V15.2S, V16.2S, V17.2S }, [X18], X29
    ADD  X18, X18, X17, ASR #0
    ST1 { V14.4H, V15.4H, V16.4H, V17.4H }, [X18], X29
    LD1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X18], X29
    ADD  X18, X18, X17, ASR #0
    ST1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X18], X29
    LD1 { V15.8B, V16.8B, V17.8B, V18.8B }, [X18], X29
    ADD  X18, X18, X17, LSR #0
    MOV  X19, X18
    ST1 { V17.2D }, [X19], #16
    MOV  X19, X18
    LD1 { V21.4S }, [X19], #16
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V21.16B }, [X19], #16
    MOV  X19, X18
    LD1 { V21.16B }, [X19], #16
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V16.2D }, [X19], #16
    MOV  X19, X18
    LD1 { V20.2D }, [X19], #16
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V21.4S }, [X19], #16
    MOV  X19, X18
    LD1 { V16.4S }, [X19], #16
    ADD  X18, X18, X17, LSR #0
    MOV  X19, X18
    ST1 { V16.8H }, [X19], #16
    MOV  X19, X18
    LD1 { V16.8H }, [X19], #16
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V20.1D }, [X19], #8
    MOV  X19, X18
    LD1 { V21.8B }, [X19], #8
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V21.1D }, [X19], #8
    MOV  X19, X18
    LD1 { V26.1D }, [X19], #8
    ADD  X18, X18, X17
    MOV  X19, X18
    ST1 { V30.2S }, [X19], #8
    MOV  X19, X18
    LD1 { V17.2S }, [X19], #8
    ADD  X18, X18, X17, LSR #0
    MOV  X19, X18
    ST1 { V6.4H }, [X19], #8
    MOV  X19, X18
    LD1 { V15.4H }, [X19], #8
    ADD  X18, X18, X17, LSR #0
    MOV  X19, X18
    ST1 { V12.8B }, [X19], #8
    MOV  X19, X18
    LD1 { V30.8B }, [X19], #8
    ADD  X18, X18, X17
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D0
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D1
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V2.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D2
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V3.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D3
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V4.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D4
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V5.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D5
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D6
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D7
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D8
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D9
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V10.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D10
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D11
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D12
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V13.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D13
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D14
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D15
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D16
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D17
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D18
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V19.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D19
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D20
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D21
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D22
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D23
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D24
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V25.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D25
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D26
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D27
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D28
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D29
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D30
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D31
    SUB  X14, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  D0, X25
    FMOV  V0.D[1], X22
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X2
    FMOV  V3.D[1], X5
    FMOV  D4, X25
    FMOV  V4.D[1], X27
    FMOV  D5, X18
    FMOV  V5.D[1], X26
    FMOV  D6, X4
    FMOV  V6.D[1], X2
    FMOV  D7, X18
    FMOV  V7.D[1], X4
    FMOV  D8, X13
    FMOV  V8.D[1], X13
    FMOV  D9, X10
    FMOV  V9.D[1], X23
    FMOV  D10, X25
    FMOV  V10.D[1], X26
    FMOV  D11, X12
    FMOV  V11.D[1], X15
    FMOV  D12, X25
    FMOV  V12.D[1], X24
    FMOV  D13, X23
    FMOV  V13.D[1], X14
    FMOV  D14, X10
    FMOV  V14.D[1], X15
    FMOV  D15, X2
    FMOV  V15.D[1], X10
    FMOV  D16, X10
    FMOV  V16.D[1], X23
    FMOV  D17, X18
    FMOV  V17.D[1], X25
    FMOV  D18, X16
    FMOV  V18.D[1], X16
    FMOV  D19, X5
    FMOV  V19.D[1], X11
    FMOV  D20, X10
    FMOV  V20.D[1], X11
    FMOV  D21, X29
    FMOV  V21.D[1], X16
    FMOV  D22, X15
    FMOV  V22.D[1], X18
    FMOV  D23, X5
    FMOV  V23.D[1], X12
    FMOV  D24, X22
    FMOV  V24.D[1], X16
    FMOV  D25, X26
    FMOV  V25.D[1], X18
    FMOV  D26, X18
    FMOV  V26.D[1], X16
    FMOV  D27, X10
    FMOV  V27.D[1], X24
    FMOV  D28, X14
    FMOV  V28.D[1], X4
    FMOV  D29, X7
    FMOV  V29.D[1], X13
    FMOV  D30, X17
    FMOV  V30.D[1], X25
    FMOV  D31, X15
    FMOV  V31.D[1], X7
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X18, #0x1e00, LSL #0
    ADD  X12, X30, X18, LSR #0
    ST1 { V30.1D, V31.1D }, [X12]
    LD1 { V5.8B, V6.8B }, [X12]
    ADD  X12, X12, X11, LSR #0
    ST1 { V28.1D, V29.1D }, [X12]
    LD1 { V2.1D, V3.1D }, [X12]
    ADD  X12, X12, X11, ASR #0
    ST1 { V2.2S, V3.2S }, [X12]
    LD1 { V30.2S, V31.2S }, [X12]
    ADD  X12, X12, X11, LSR #0
    ST1 { V5.4H, V6.4H }, [X12]
    LD1 { V24.4H, V25.4H }, [X12]
    ADD  X12, X12, X11
    ST1 { V30.8B, V31.8B }, [X12]
    LD1 { V31.8B, V0.8B }, [X12]
    ADD  X12, X12, X11
    MOV  X15, X12
    ST1 { V2.2D, V3.2D, V4.2D, V5.2D }, [X15], #64
    MOV  X15, X12
    LD1 { V17.8H, V18.8H, V19.8H, V20.8H }, [X15], #64
    ADD  X12, X12, X11, LSR #0
    MOV  X15, X12
    ST1 { V17.16B, V18.16B, V19.16B, V20.16B }, [X15], #64
    MOV  X15, X12
    LD1 { V14.16B, V15.16B, V16.16B, V17.16B }, [X15], #64
    ADD  X12, X12, X11, LSR #0
    MOV  X15, X12
    ST1 { V14.2D, V15.2D, V16.2D, V17.2D }, [X15], #64
    MOV  X15, X12
    LD1 { V16.2D, V17.2D, V18.2D, V19.2D }, [X15], #64
    ADD  X12, X12, X11, ASR #0
    MOV  X15, X12
    ST1 { V31.4S, V0.4S, V1.4S, V2.4S }, [X15], #64
    MOV  X15, X12
    LD1 { V31.4S, V0.4S, V1.4S, V2.4S }, [X15], #64
    ADD  X12, X12, X11, ASR #0
    MOV  X15, X12
    ST1 { V16.8H, V17.8H, V18.8H, V19.8H }, [X15], #64
    MOV  X15, X12
    LD1 { V18.8H, V19.8H, V20.8H, V21.8H }, [X15], #64
    ADD  X12, X12, X11, LSR #0
    MOV  X15, X12
    ST1 { V18.1D, V19.1D, V20.1D, V21.1D }, [X15], #32
    MOV  X15, X12
    LD1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X15], #32
    ADD  X12, X12, X11, ASR #0
    MOV  X15, X12
    ST1 { V16.1D, V17.1D, V18.1D, V19.1D }, [X15], #32
    MOV  X15, X12
    LD1 { V17.1D, V18.1D, V19.1D, V20.1D }, [X15], #32
    ADD  X12, X12, X11, LSR #0
    MOV  X15, X12
    ST1 { V17.2S, V18.2S, V19.2S, V20.2S }, [X15], #32
    MOV  X15, X12
    LD1 { V17.2S, V18.2S, V19.2S, V20.2S }, [X15], #32
    ADD  X12, X12, X11
    MOV  X15, X12
    ST1 { V17.4H, V18.4H, V19.4H, V20.4H }, [X15], #32
    MOV  X15, X12
    LD1 { V17.4H, V18.4H, V19.4H, V20.4H }, [X15], #32
    ADD  X12, X12, X11, LSR #0
    MOV  X15, X12
    ST1 { V17.8B, V18.8B, V19.8B, V20.8B }, [X15], #32
    MOV  X15, X12
    LD1 { V8.8B, V9.8B, V10.8B, V11.8B }, [X15], #32
    ADD  X12, X12, X11, LSR #0
    ST1 { V8.8H, V9.8H, V10.8H, V11.8H }, [X12], X16
    LD1 { V3.8H, V4.8H, V5.8H, V6.8H }, [X12], X16
    ADD  X12, X12, X11
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X12], X16
    LD1 { V1.16B, V2.16B, V3.16B, V4.16B }, [X12], X16
    ADD  X12, X12, X11, LSR #0
    ST1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X12], X16
    LD1 { V8.2D, V9.2D, V10.2D, V11.2D }, [X12], X16
    ADD  X12, X12, X11, ASR #0
    ST1 { V1.4S, V2.4S, V3.4S, V4.4S }, [X12], X16
    LD1 { V25.4S, V26.4S, V27.4S, V28.4S }, [X12], X16
    ADD  X12, X12, X11, LSR #0
    ST1 { V8.8H, V9.8H, V10.8H, V11.8H }, [X12], X16
    LD1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X12], X16
    ADD  X12, X12, X11
    ST1 { V6.1D, V7.1D, V8.1D, V9.1D }, [X12], X16
    LD1 { V6.4H, V7.4H, V8.4H, V9.4H }, [X12], X16
    ADD  X12, X12, X11, ASR #0
    ST1 { V6.1D, V7.1D, V8.1D, V9.1D }, [X12], X16
    LD1 { V1.1D, V2.1D, V3.1D, V4.1D }, [X12], X16
    ADD  X12, X12, X11, ASR #0
    ST1 { V13.2S, V14.2S, V15.2S, V16.2S }, [X12], X16
    LD1 { V6.2S, V7.2S, V8.2S, V9.2S }, [X12], X16
    ADD  X12, X12, X11, LSR #0
    ST1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X12], X16
    LD1 { V13.4H, V14.4H, V15.4H, V16.4H }, [X12], X16
    ADD  X12, X12, X11
    ST1 { V10.8B, V11.8B, V12.8B, V13.8B }, [X12], X16
    LD1 { V9.8B, V10.8B, V11.8B, V12.8B }, [X12], X16
    ADD  X12, X12, X11
    MOV  X15, X12
    ST1 { V6.2D }, [X15], #16
    MOV  X15, X12
    LD1 { V10.8H }, [X15], #16
    ADD  X12, X12, X11
    MOV  X15, X12
    ST1 { V16.16B }, [X15], #16
    MOV  X15, X12
    LD1 { V3.16B }, [X15], #16
    ADD  X12, X12, X11, LSR #0
    MOV  X15, X12
    ST1 { V7.2D }, [X15], #16
    MOV  X15, X12
    LD1 { V30.2D }, [X15], #16
    ADD  X12, X12, X11, LSR #0
    MOV  X15, X12
    ST1 { V3.4S }, [X15], #16
    MOV  X15, X12
    LD1 { V9.4S }, [X15], #16
    ADD  X12, X12, X11, ASR #0
    MOV  X15, X12
    ST1 { V12.8H }, [X15], #16
    MOV  X15, X12
    LD1 { V2.8H }, [X15], #16
    ADD  X12, X12, X11, ASR #0
    MOV  X15, X12
    ST1 { V11.4H }, [X15], #8
    MOV  X15, X12
    LD1 { V27.2S }, [X15], #8
    ADD  X12, X12, X11, LSR #0
    MOV  X15, X12
    ST1 { V30.1D }, [X15], #8
    MOV  X15, X12
    LD1 { V21.1D }, [X15], #8
    ADD  X12, X12, X11
    MOV  X15, X12
    ST1 { V21.2S }, [X15], #8
    MOV  X15, X12
    LD1 { V28.2S }, [X15], #8
    ADD  X12, X12, X11
    MOV  X15, X12
    ST1 { V27.4H }, [X15], #8
    MOV  X15, X12
    LD1 { V2.4H }, [X15], #8
    ADD  X12, X12, X11
    MOV  X15, X12
    ST1 { V28.8B }, [X15], #8
    MOV  X15, X12
    LD1 { V24.8B }, [X15], #8
    ADD  X12, X12, X11, LSR #0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D0
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D1
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D2
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D3
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D4
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D5
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D6
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D7
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D8
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D9
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D10
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D11
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D12
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D13
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D14
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D15
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D16
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D17
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D18
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D19
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D20
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D21
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, V22.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D22
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, V23.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D23
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D24
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D25
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, V26.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D26
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D27
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D28
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, V29.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D29
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D30
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X17, D31
    SUB  X25, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  D0, X24
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X11
    FMOV  D3, X21
    FMOV  V3.D[1], X12
    FMOV  D4, X21
    FMOV  V4.D[1], X15
    FMOV  D5, X26
    FMOV  V5.D[1], X20
    FMOV  D6, X25
    FMOV  V6.D[1], X21
    FMOV  D7, X13
    FMOV  V7.D[1], X16
    FMOV  D8, X15
    FMOV  V8.D[1], X26
    FMOV  D9, X23
    FMOV  V9.D[1], X25
    FMOV  D10, X17
    FMOV  V10.D[1], X4
    FMOV  D11, X23
    FMOV  V11.D[1], X13
    FMOV  D12, X15
    FMOV  V12.D[1], X15
    FMOV  D13, X27
    FMOV  V13.D[1], X14
    FMOV  D14, X22
    FMOV  V14.D[1], X13
    FMOV  D15, X10
    FMOV  V15.D[1], X27
    FMOV  D16, X26
    FMOV  V16.D[1], X17
    FMOV  D17, X2
    FMOV  V17.D[1], X25
    FMOV  D18, X19
    FMOV  V18.D[1], X24
    FMOV  D19, X19
    FMOV  V19.D[1], X18
    FMOV  D20, X21
    FMOV  V20.D[1], X7
    FMOV  D21, X2
    FMOV  V21.D[1], X13
    FMOV  D22, X20
    FMOV  V22.D[1], X29
    FMOV  D23, X19
    FMOV  V23.D[1], X25
    FMOV  D24, X17
    FMOV  V24.D[1], X14
    FMOV  D25, X14
    FMOV  V25.D[1], X2
    FMOV  D26, X27
    FMOV  V26.D[1], X14
    FMOV  D27, X15
    FMOV  V27.D[1], X13
    FMOV  D28, X12
    FMOV  V28.D[1], X20
    FMOV  D29, X16
    FMOV  V29.D[1], X10
    FMOV  D30, X15
    FMOV  V30.D[1], X5
    FMOV  D31, X14
    FMOV  V31.D[1], X21
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X29, #0x2300, LSL #0
    ADD  X23, X30, X29
    ST1 { V12.1D, V13.1D }, [X23]
    LD1 { V11.2S, V12.2S }, [X23]
    ADD  X23, X23, X2
    ST1 { V28.1D, V29.1D }, [X23]
    LD1 { V15.1D, V16.1D }, [X23]
    ADD  X23, X23, X2, ASR #0
    ST1 { V11.2S, V12.2S }, [X23]
    LD1 { V1.2S, V2.2S }, [X23]
    ADD  X23, X23, X2, LSR #0
    ST1 { V1.4H, V2.4H }, [X23]
    LD1 { V26.4H, V27.4H }, [X23]
    ADD  X23, X23, X2
    ST1 { V30.8B, V31.8B }, [X23]
    LD1 { V19.8B, V20.8B }, [X23]
    ADD  X23, X23, X2, LSR #0
    MOV  X17, X23
    ST1 { V31.2D, V0.2D, V1.2D, V2.2D }, [X17], #64
    MOV  X17, X23
    LD1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X17], #64
    ADD  X23, X23, X2
    MOV  X17, X23
    ST1 { V3.16B, V4.16B, V5.16B, V6.16B }, [X17], #64
    MOV  X17, X23
    LD1 { V23.16B, V24.16B, V25.16B, V26.16B }, [X17], #64
    ADD  X23, X23, X2, ASR #0
    MOV  X17, X23
    ST1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X17], #64
    MOV  X17, X23
    LD1 { V21.2D, V22.2D, V23.2D, V24.2D }, [X17], #64
    ADD  X23, X23, X2, LSR #0
    MOV  X17, X23
    ST1 { V26.4S, V27.4S, V28.4S, V29.4S }, [X17], #64
    MOV  X17, X23
    LD1 { V3.4S, V4.4S, V5.4S, V6.4S }, [X17], #64
    ADD  X23, X23, X2, ASR #0
    MOV  X17, X23
    ST1 { V29.8H, V30.8H, V31.8H, V0.8H }, [X17], #64
    MOV  X17, X23
    LD1 { V11.8H, V12.8H, V13.8H, V14.8H }, [X17], #64
    ADD  X23, X23, X2, ASR #0
    MOV  X17, X23
    ST1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X17], #32
    MOV  X17, X23
    LD1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X17], #32
    ADD  X23, X23, X2
    MOV  X17, X23
    ST1 { V11.1D, V12.1D, V13.1D, V14.1D }, [X17], #32
    MOV  X17, X23
    LD1 { V21.1D, V22.1D, V23.1D, V24.1D }, [X17], #32
    ADD  X23, X23, X2, ASR #0
    MOV  X17, X23
    ST1 { V31.2S, V0.2S, V1.2S, V2.2S }, [X17], #32
    MOV  X17, X23
    LD1 { V31.2S, V0.2S, V1.2S, V2.2S }, [X17], #32
    ADD  X23, X23, X2, ASR #0
    MOV  X17, X23
    ST1 { V21.4H, V22.4H, V23.4H, V24.4H }, [X17], #32
    MOV  X17, X23
    LD1 { V11.4H, V12.4H, V13.4H, V14.4H }, [X17], #32
    ADD  X23, X23, X2, LSR #0
    MOV  X17, X23
    ST1 { V31.8B, V0.8B, V1.8B, V2.8B }, [X17], #32
    MOV  X17, X23
    LD1 { V31.8B, V0.8B, V1.8B, V2.8B }, [X17], #32
    ADD  X23, X23, X2, LSR #0
    ST1 { V11.2D, V12.2D, V13.2D, V14.2D }, [X23], X18
    LD1 { V21.16B, V22.16B, V23.16B, V24.16B }, [X23], X18
    ADD  X23, X23, X2, ASR #0
    ST1 { V31.16B, V0.16B, V1.16B, V2.16B }, [X23], X18
    LD1 { V31.16B, V0.16B, V1.16B, V2.16B }, [X23], X18
    ADD  X23, X23, X2, LSR #0
    ST1 { V21.2D, V22.2D, V23.2D, V24.2D }, [X23], X18
    LD1 { V24.2D, V25.2D, V26.2D, V27.2D }, [X23], X18
    ADD  X23, X23, X2
    ST1 { V31.4S, V0.4S, V1.4S, V2.4S }, [X23], X18
    LD1 { V31.4S, V0.4S, V1.4S, V2.4S }, [X23], X18
    ADD  X23, X23, X2
    ST1 { V24.8H, V25.8H, V26.8H, V27.8H }, [X23], X18
    LD1 { V16.8H, V17.8H, V18.8H, V19.8H }, [X23], X18
    ADD  X23, X23, X2, ASR #0
    ST1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X23], X18
    LD1 { V11.2S, V12.2S, V13.2S, V14.2S }, [X23], X18
    ADD  X23, X23, X2, ASR #0
    ST1 { V10.1D, V11.1D, V12.1D, V13.1D }, [X23], X18
    LD1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X23], X18
    ADD  X23, X23, X2, ASR #0
    ST1 { V31.2S, V0.2S, V1.2S, V2.2S }, [X23], X18
    LD1 { V10.2S, V11.2S, V12.2S, V13.2S }, [X23], X18
    ADD  X23, X23, X2, LSR #0
    ST1 { V10.4H, V11.4H, V12.4H, V13.4H }, [X23], X18
    LD1 { V31.4H, V0.4H, V1.4H, V2.4H }, [X23], X18
    ADD  X23, X23, X2, ASR #0
    ST1 { V18.8B, V19.8B, V20.8B, V21.8B }, [X23], X18
    LD1 { V18.8B, V19.8B, V20.8B, V21.8B }, [X23], X18
    ADD  X23, X23, X2
    MOV  X17, X23
    ST1 { V14.2D }, [X17], #16
    MOV  X17, X23
    LD1 { V26.4S }, [X17], #16
    ADD  X23, X23, X2
    MOV  X17, X23
    ST1 { V24.16B }, [X17], #16
    MOV  X17, X23
    LD1 { V14.16B }, [X17], #16
    ADD  X23, X23, X2, LSR #0
    MOV  X17, X23
    ST1 { V14.2D }, [X17], #16
    MOV  X17, X23
    LD1 { V11.2D }, [X17], #16
    ADD  X23, X23, X2, ASR #0
    MOV  X17, X23
    ST1 { V11.4S }, [X17], #16
    MOV  X17, X23
    LD1 { V11.4S }, [X17], #16
    ADD  X23, X23, X2, ASR #0
    MOV  X17, X23
    ST1 { V11.8H }, [X17], #16
    MOV  X17, X23
    LD1 { V11.8H }, [X17], #16
    ADD  X23, X23, X2, LSR #0
    MOV  X17, X23
    ST1 { V11.1D }, [X17], #8
    MOV  X17, X23
    LD1 { V14.2S }, [X17], #8
    ADD  X23, X23, X2, ASR #0
    MOV  X17, X23
    ST1 { V14.1D }, [X17], #8
    MOV  X17, X23
    LD1 { V31.1D }, [X17], #8
    ADD  X23, X23, X2, ASR #0
    MOV  X17, X23
    ST1 { V8.2S }, [X17], #8
    MOV  X17, X23
    LD1 { V16.2S }, [X17], #8
    ADD  X23, X23, X2
    MOV  X17, X23
    ST1 { V5.4H }, [X17], #8
    MOV  X17, X23
    LD1 { V19.4H }, [X17], #8
    ADD  X23, X23, X2, LSR #0
    MOV  X17, X23
    ST1 { V8.8B }, [X17], #8
    MOV  X17, X23
    LD1 { V13.8B }, [X17], #8
    ADD  X23, X23, X2, ASR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X10, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D0
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D1
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D2
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D3
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D4
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D5
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D6
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V7.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D7
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V8.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D8
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V9.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D9
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D10
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D11
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D12
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D13
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D14
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D15
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D16
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D17
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D18
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D19
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D20
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D21
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D22
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D23
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D24
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D25
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D26
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D27
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V28.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D28
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V29.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D29
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, V30.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D30
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X10, D31
    SUB  X20, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
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
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
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
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X25
    FMOV  V2.D[1], X15
    FMOV  D3, X25
    FMOV  V3.D[1], X29
    FMOV  D4, X25
    FMOV  V4.D[1], X11
    FMOV  D5, X15
    FMOV  V5.D[1], X2
    FMOV  D6, X14
    FMOV  V6.D[1], X21
    FMOV  D7, X16
    FMOV  V7.D[1], X5
    FMOV  D8, X18
    FMOV  V8.D[1], X22
    FMOV  D9, X21
    FMOV  V9.D[1], X18
    FMOV  D10, X2
    FMOV  V10.D[1], X29
    FMOV  D11, X25
    FMOV  V11.D[1], X15
    FMOV  D12, X10
    FMOV  V12.D[1], X25
    FMOV  D13, X13
    FMOV  V13.D[1], X13
    FMOV  D14, X15
    FMOV  V14.D[1], X9
    FMOV  D15, X27
    FMOV  V15.D[1], X24
    FMOV  D16, X15
    FMOV  V16.D[1], X26
    FMOV  D17, X19
    FMOV  V17.D[1], X15
    FMOV  D18, X13
    FMOV  V18.D[1], X17
    FMOV  D19, X29
    FMOV  V19.D[1], X20
    FMOV  D20, X10
    FMOV  V20.D[1], X22
    FMOV  D21, X13
    FMOV  V21.D[1], X15
    FMOV  D22, X12
    FMOV  V22.D[1], X11
    FMOV  D23, X27
    FMOV  V23.D[1], X14
    FMOV  D24, X2
    FMOV  V24.D[1], X16
    FMOV  D25, X15
    FMOV  V25.D[1], X20
    FMOV  D26, X13
    FMOV  V26.D[1], X29
    FMOV  D27, X25
    FMOV  V27.D[1], X7
    FMOV  D28, X9
    FMOV  V28.D[1], X27
    FMOV  D29, X14
    FMOV  V29.D[1], X11
    FMOV  D30, X13
    FMOV  V30.D[1], X21
    FMOV  D31, X17
    FMOV  V31.D[1], X9
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X4, #0x2800, LSL #0
    ADD  X21, X30, X4
    ST1 { V27.2S, V28.2S }, [X21]
    LD1 { V17.2S, V18.2S }, [X21]
    ADD  X21, X21, X14, LSR #0
    ST1 { V25.1D, V26.1D }, [X21]
    LD1 { V30.1D, V31.1D }, [X21]
    ADD  X21, X21, X14
    ST1 { V30.2S, V31.2S }, [X21]
    LD1 { V16.2S, V17.2S }, [X21]
    ADD  X21, X21, X14, LSR #0
    ST1 { V16.4H, V17.4H }, [X21]
    LD1 { V17.4H, V18.4H }, [X21]
    ADD  X21, X21, X14
    ST1 { V17.8B, V18.8B }, [X21]
    LD1 { V30.8B, V31.8B }, [X21]
    ADD  X21, X21, X14, LSR #0
    MOV  X12, X21
    ST1 { V14.16B, V15.16B, V16.16B, V17.16B }, [X12], #64
    MOV  X12, X21
    LD1 { V12.8H, V13.8H, V14.8H, V15.8H }, [X12], #64
    ADD  X21, X21, X14, LSR #0
    MOV  X12, X21
    ST1 { V12.16B, V13.16B, V14.16B, V15.16B }, [X12], #64
    MOV  X12, X21
    LD1 { V2.16B, V3.16B, V4.16B, V5.16B }, [X12], #64
    ADD  X21, X21, X14
    MOV  X12, X21
    ST1 { V19.2D, V20.2D, V21.2D, V22.2D }, [X12], #64
    MOV  X12, X21
    LD1 { V18.2D, V19.2D, V20.2D, V21.2D }, [X12], #64
    ADD  X21, X21, X14, LSR #0
    MOV  X12, X21
    ST1 { V2.4S, V3.4S, V4.4S, V5.4S }, [X12], #64
    MOV  X12, X21
    LD1 { V13.4S, V14.4S, V15.4S, V16.4S }, [X12], #64
    ADD  X21, X21, X14, ASR #0
    MOV  X12, X21
    ST1 { V18.8H, V19.8H, V20.8H, V21.8H }, [X12], #64
    MOV  X12, X21
    LD1 { V19.8H, V20.8H, V21.8H, V22.8H }, [X12], #64
    ADD  X21, X21, X14
    MOV  X12, X21
    ST1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X12], #32
    MOV  X12, X21
    LD1 { V2.4H, V3.4H, V4.4H, V5.4H }, [X12], #32
    ADD  X21, X21, X14
    MOV  X12, X21
    ST1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X12], #32
    MOV  X12, X21
    LD1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X12], #32
    ADD  X21, X21, X14, LSR #0
    MOV  X12, X21
    ST1 { V2.2S, V3.2S, V4.2S, V5.2S }, [X12], #32
    MOV  X12, X21
    LD1 { V0.2S, V1.2S, V2.2S, V3.2S }, [X12], #32
    ADD  X21, X21, X14, ASR #0
    MOV  X12, X21
    ST1 { V0.4H, V1.4H, V2.4H, V3.4H }, [X12], #32
    MOV  X12, X21
    LD1 { V1.4H, V2.4H, V3.4H, V4.4H }, [X12], #32
    ADD  X21, X21, X14, LSR #0
    MOV  X12, X21
    ST1 { V1.8B, V2.8B, V3.8B, V4.8B }, [X12], #32
    MOV  X12, X21
    LD1 { V9.8B, V10.8B, V11.8B, V12.8B }, [X12], #32
    ADD  X21, X21, X14, ASR #0
    ST1 { V9.4S, V10.4S, V11.4S, V12.4S }, [X21], X24
    LD1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X21], X24
    ADD  X21, X21, X14, LSR #0
    ST1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X21], X24
    LD1 { V29.16B, V30.16B, V31.16B, V0.16B }, [X21], X24
    ADD  X21, X21, X14, ASR #0
    ST1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X21], X24
    LD1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X21], X24
    ADD  X21, X21, X14, LSR #0
    ST1 { V15.4S, V16.4S, V17.4S, V18.4S }, [X21], X24
    LD1 { V9.4S, V10.4S, V11.4S, V12.4S }, [X21], X24
    ADD  X21, X21, X14
    ST1 { V20.8H, V21.8H, V22.8H, V23.8H }, [X21], X24
    LD1 { V29.8H, V30.8H, V31.8H, V0.8H }, [X21], X24
    ADD  X21, X21, X14
    ST1 { V13.2S, V14.2S, V15.2S, V16.2S }, [X21], X24
    LD1 { V12.4H, V13.4H, V14.4H, V15.4H }, [X21], X24
    ADD  X21, X21, X14, ASR #0
    ST1 { V1.1D, V2.1D, V3.1D, V4.1D }, [X21], X24
    LD1 { V1.1D, V2.1D, V3.1D, V4.1D }, [X21], X24
    ADD  X21, X21, X14, ASR #0
    ST1 { V5.2S, V6.2S, V7.2S, V8.2S }, [X21], X24
    LD1 { V5.2S, V6.2S, V7.2S, V8.2S }, [X21], X24
    ADD  X21, X21, X14
    ST1 { V31.4H, V0.4H, V1.4H, V2.4H }, [X21], X24
    LD1 { V31.4H, V0.4H, V1.4H, V2.4H }, [X21], X24
    ADD  X21, X21, X14, ASR #0
    ST1 { V12.8B, V13.8B, V14.8B, V15.8B }, [X21], X24
    LD1 { V14.8B, V15.8B, V16.8B, V17.8B }, [X21], X24
    ADD  X21, X21, X14, ASR #0
    MOV  X12, X21
    ST1 { V16.4S }, [X12], #16
    MOV  X12, X21
    LD1 { V12.8H }, [X12], #16
    ADD  X21, X21, X14, LSR #0
    MOV  X12, X21
    ST1 { V2.16B }, [X12], #16
    MOV  X12, X21
    LD1 { V13.16B }, [X12], #16
    ADD  X21, X21, X14
    MOV  X12, X21
    ST1 { V31.2D }, [X12], #16
    MOV  X12, X21
    LD1 { V31.2D }, [X12], #16
    ADD  X21, X21, X14, ASR #0
    MOV  X12, X21
    ST1 { V6.4S }, [X12], #16
    MOV  X12, X21
    LD1 { V10.4S }, [X12], #16
    ADD  X21, X21, X14, LSR #0
    MOV  X12, X21
    ST1 { V31.8H }, [X12], #16
    MOV  X12, X21
    LD1 { V7.8H }, [X12], #16
    ADD  X21, X21, X14, ASR #0
    MOV  X12, X21
    ST1 { V7.8B }, [X12], #8
    MOV  X12, X21
    LD1 { V5.8B }, [X12], #8
    ADD  X21, X21, X14
    MOV  X12, X21
    ST1 { V5.1D }, [X12], #8
    MOV  X12, X21
    LD1 { V25.1D }, [X12], #8
    ADD  X21, X21, X14, ASR #0
    MOV  X12, X21
    ST1 { V10.2S }, [X12], #8
    MOV  X12, X21
    LD1 { V13.2S }, [X12], #8
    ADD  X21, X21, X14, LSR #0
    MOV  X12, X21
    ST1 { V13.4H }, [X12], #8
    MOV  X12, X21
    LD1 { V2.4H }, [X12], #8
    ADD  X21, X21, X14, LSR #0
    MOV  X12, X21
    ST1 { V13.8B }, [X12], #8
    MOV  X12, X21
    LD1 { V21.8B }, [X12], #8
    ADD  X21, X21, X14, LSR #0
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X25, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X25, FPSR
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D0
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V1.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D1
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D2
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D3
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D4
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V5.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D5
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D6
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D7
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D8
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D9
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D10
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D11
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D12
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D13
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V14.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D14
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V15.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D15
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V16.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D16
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V17.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D17
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V18.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D18
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V19.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D19
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V20.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D20
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D21
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V22.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D22
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V23.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D23
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V24.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D24
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V25.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D25
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V26.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D26
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V27.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D27
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V28.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D28
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V29.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D29
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, V30.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D30
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X25, D31
    SUB  X26, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP02_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
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
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
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
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
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
    FMOV  D0, X22
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X18
    FMOV  V3.D[1], X2
    FMOV  D4, X2
    FMOV  V4.D[1], X20
    FMOV  D5, X11
    FMOV  V5.D[1], X16
    FMOV  D6, X19
    FMOV  V6.D[1], X26
    FMOV  D7, X2
    FMOV  V7.D[1], X22
    FMOV  D8, X14
    FMOV  V8.D[1], X10
    FMOV  D9, X11
    FMOV  V9.D[1], X24
    FMOV  D10, X15
    FMOV  V10.D[1], X10
    FMOV  D11, X5
    FMOV  V11.D[1], X2
    FMOV  D12, X20
    FMOV  V12.D[1], X4
    FMOV  D13, X24
    FMOV  V13.D[1], X21
    FMOV  D14, X13
    FMOV  V14.D[1], X22
    FMOV  D15, X17
    FMOV  V15.D[1], X25
    FMOV  D16, X10
    FMOV  V16.D[1], X9
    FMOV  D17, X9
    FMOV  V17.D[1], X20
    FMOV  D18, X5
    FMOV  V18.D[1], X10
    FMOV  D19, X18
    FMOV  V19.D[1], X25
    FMOV  D20, X9
    FMOV  V20.D[1], X21
    FMOV  D21, X16
    FMOV  V21.D[1], X9
    FMOV  D22, X18
    FMOV  V22.D[1], X27
    FMOV  D23, X27
    FMOV  V23.D[1], X5
    FMOV  D24, X17
    FMOV  V24.D[1], X27
    FMOV  D25, X16
    FMOV  V25.D[1], X20
    FMOV  D26, X18
    FMOV  V26.D[1], X14
    FMOV  D27, X10
    FMOV  V27.D[1], X13
    FMOV  D28, X15
    FMOV  V28.D[1], X19
    FMOV  D29, X21
    FMOV  V29.D[1], X16
    FMOV  D30, X17
    FMOV  V30.D[1], X16
    FMOV  D31, X7
    FMOV  V31.D[1], X21
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X24, #0x2d00, LSL #0
    ADD  X22, X30, X24, ASR #0
    ST1 { V19.8B, V20.8B }, [X22]
    LD1 { V30.1D, V31.1D }, [X22]
    ADD  X22, X22, X16
    ST1 { V30.1D, V31.1D }, [X22]
    LD1 { V26.1D, V27.1D }, [X22]
    ADD  X22, X22, X16
    ST1 { V26.2S, V27.2S }, [X22]
    LD1 { V10.2S, V11.2S }, [X22]
    ADD  X22, X22, X16, ASR #0
    ST1 { V28.4H, V29.4H }, [X22]
    LD1 { V9.4H, V10.4H }, [X22]
    ADD  X22, X22, X16
    ST1 { V24.8B, V25.8B }, [X22]
    LD1 { V2.8B, V3.8B }, [X22]
    ADD  X22, X22, X16, LSR #0
    MOV  X23, X22
    ST1 { V2.16B, V3.16B, V4.16B, V5.16B }, [X23], #64
    MOV  X23, X22
    LD1 { V18.2D, V19.2D, V20.2D, V21.2D }, [X23], #64
    ADD  X22, X22, X16
    MOV  X23, X22
    ST1 { V27.16B, V28.16B, V29.16B, V30.16B }, [X23], #64
    MOV  X23, X22
    LD1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X23], #64
    ADD  X22, X22, X16
    MOV  X23, X22
    ST1 { V18.2D, V19.2D, V20.2D, V21.2D }, [X23], #64
    MOV  X23, X22
    LD1 { V18.2D, V19.2D, V20.2D, V21.2D }, [X23], #64
    ADD  X22, X22, X16, ASR #0
    MOV  X23, X22
    ST1 { V9.4S, V10.4S, V11.4S, V12.4S }, [X23], #64
    MOV  X23, X22
    LD1 { V27.4S, V28.4S, V29.4S, V30.4S }, [X23], #64
    ADD  X22, X22, X16
    MOV  X23, X22
    ST1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X23], #64
    MOV  X23, X22
    LD1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X23], #64
    ADD  X22, X22, X16, LSR #0
    MOV  X23, X22
    ST1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X23], #32
    MOV  X23, X22
    LD1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X23], #32
    ADD  X22, X22, X16
    MOV  X23, X22
    ST1 { V0.1D, V1.1D, V2.1D, V3.1D }, [X23], #32
    MOV  X23, X22
    LD1 { V0.1D, V1.1D, V2.1D, V3.1D }, [X23], #32
    ADD  X22, X22, X16, LSR #0
    MOV  X23, X22
    ST1 { V0.2S, V1.2S, V2.2S, V3.2S }, [X23], #32
    MOV  X23, X22
    LD1 { V27.2S, V28.2S, V29.2S, V30.2S }, [X23], #32
    ADD  X22, X22, X16
    MOV  X23, X22
    ST1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X23], #32
    MOV  X23, X22
    LD1 { V0.4H, V1.4H, V2.4H, V3.4H }, [X23], #32
    ADD  X22, X22, X16, ASR #0
    MOV  X23, X22
    ST1 { V27.8B, V28.8B, V29.8B, V30.8B }, [X23], #32
    MOV  X23, X22
    LD1 { V9.8B, V10.8B, V11.8B, V12.8B }, [X23], #32
    ADD  X22, X22, X16
    ST1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X22], X13
    LD1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X22], X13
    ADD  X22, X22, X16, LSR #0
    ST1 { V0.16B, V1.16B, V2.16B, V3.16B }, [X22], X13
    LD1 { V0.16B, V1.16B, V2.16B, V3.16B }, [X22], X13
    ADD  X22, X22, X16
    ST1 { V0.2D, V1.2D, V2.2D, V3.2D }, [X22], X13
    LD1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X22], X13
    ADD  X22, X22, X16, ASR #0
    ST1 { V27.4S, V28.4S, V29.4S, V30.4S }, [X22], X13
    LD1 { V0.4S, V1.4S, V2.4S, V3.4S }, [X22], X13
    ADD  X22, X22, X16, LSR #0
    ST1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X22], X13
    LD1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X22], X13
    ADD  X22, X22, X16, LSR #0
    ST1 { V15.4H, V16.4H, V17.4H, V18.4H }, [X22], X13
    LD1 { V12.1D, V13.1D, V14.1D, V15.1D }, [X22], X13
    ADD  X22, X22, X16
    ST1 { V0.1D, V1.1D, V2.1D, V3.1D }, [X22], X13
    LD1 { V0.1D, V1.1D, V2.1D, V3.1D }, [X22], X13
    ADD  X22, X22, X16, ASR #0
    ST1 { V28.2S, V29.2S, V30.2S, V31.2S }, [X22], X13
    LD1 { V27.2S, V28.2S, V29.2S, V30.2S }, [X22], X13
    ADD  X22, X22, X16, LSR #0
    ST1 { V0.4H, V1.4H, V2.4H, V3.4H }, [X22], X13
    LD1 { V31.4H, V0.4H, V1.4H, V2.4H }, [X22], X13
    ADD  X22, X22, X16, ASR #0
    ST1 { V2.8B, V3.8B, V4.8B, V5.8B }, [X22], X13
    LD1 { V2.8B, V3.8B, V4.8B, V5.8B }, [X22], X13
    ADD  X22, X22, X16
    MOV  X23, X22
    ST1 { V30.4S }, [X23], #16
    MOV  X23, X22
    LD1 { V16.8H }, [X23], #16
    ADD  X22, X22, X16
    MOV  X23, X22
    ST1 { V29.16B }, [X23], #16
    MOV  X23, X22
    LD1 { V29.16B }, [X23], #16
    ADD  X22, X22, X16
    MOV  X23, X22
    ST1 { V16.2D }, [X23], #16
    MOV  X23, X22
    LD1 { V16.2D }, [X23], #16
    ADD  X22, X22, X16, ASR #0
    MOV  X23, X22
    ST1 { V16.4S }, [X23], #16
    MOV  X23, X22
    LD1 { V25.4S }, [X23], #16
    ADD  X22, X22, X16, LSR #0
    MOV  X23, X22
    ST1 { V29.8H }, [X23], #16
    MOV  X23, X22
    LD1 { V10.8H }, [X23], #16
    ADD  X22, X22, X16, LSR #0
    MOV  X23, X22
    ST1 { V10.1D }, [X23], #8
    MOV  X23, X22
    LD1 { V10.2S }, [X23], #8
    ADD  X22, X22, X16, ASR #0
    MOV  X23, X22
    ST1 { V13.1D }, [X23], #8
    MOV  X23, X22
    LD1 { V7.1D }, [X23], #8
    ADD  X22, X22, X16
    MOV  X23, X22
    ST1 { V25.2S }, [X23], #8
    MOV  X23, X22
    LD1 { V19.2S }, [X23], #8
    ADD  X22, X22, X16, ASR #0
    MOV  X23, X22
    ST1 { V7.4H }, [X23], #8
    MOV  X23, X22
    LD1 { V27.4H }, [X23], #8
    ADD  X22, X22, X16, ASR #0
    MOV  X23, X22
    ST1 { V10.8B }, [X23], #8
    MOV  X23, X22
    LD1 { V5.8B }, [X23], #8
    ADD  X22, X22, X16, ASR #0
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X14, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D0
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D1
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D2
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D3
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D4
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D5
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, V6.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D6
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D7
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, V8.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D8
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D9
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D10
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D11
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D12
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D13
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D14
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D15
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D16
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, V17.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D17
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D18
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D19
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, V20.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D20
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, V21.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D21
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, V22.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D22
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, V23.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D23
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, V24.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D24
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D25
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D26
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D27
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D28
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D29
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D30
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X14, D31
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP02_TestFail

AdvsimdLoadStoreP02_TestEnd:
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
AdvsimdLoadStoreP02_TestFail:
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
