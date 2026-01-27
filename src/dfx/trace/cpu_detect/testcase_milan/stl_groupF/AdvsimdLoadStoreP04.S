.global AdvsimdLoadStoreP04

.text
.p2align 4

AdvsimdLoadStoreP04:

AdvsimdLoadStoreP04_TestBegin:
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
    MOVZ  X2, #0x967b, LSL #0
    MOVK  X2, #0xb301, LSL #16
    MOVK  X2, #0xc6d1, LSL #32
    MOVK  X2, #0x8dae, LSL #48
    MOVZ  X3, #0x7a2, LSL #0
    MOVK  X3, #0xdbcd, LSL #16
    MOVK  X3, #0x178f, LSL #32
    MOVK  X3, #0x244e, LSL #48
    MOVZ  X4, #0x17a8, LSL #0
    MOVK  X4, #0x91ce, LSL #16
    MOVK  X4, #0x84d2, LSL #32
    MOVK  X4, #0x16e1, LSL #48
    MOVZ  X5, #0x277d, LSL #0
    MOVK  X5, #0x7b2d, LSL #16
    MOVK  X5, #0x5e66, LSL #32
    MOVK  X5, #0xdf0c, LSL #48
    MOVZ  X6, #0x53d6, LSL #0
    MOVK  X6, #0x44, LSL #16
    MOVK  X6, #0x2fb6, LSL #32
    MOVK  X6, #0x2b6f, LSL #48
    MOVZ  X7, #0x9df0, LSL #0
    MOVK  X7, #0x5510, LSL #16
    MOVK  X7, #0xed21, LSL #32
    MOVK  X7, #0xdcdc, LSL #48
    MOVZ  X8, #0xa47f, LSL #0
    MOVK  X8, #0x92fe, LSL #16
    MOVK  X8, #0x1d9c, LSL #32
    MOVK  X8, #0x40a2, LSL #48
    MOVZ  X9, #0xd453, LSL #0
    MOVK  X9, #0x6523, LSL #16
    MOVK  X9, #0x3960, LSL #32
    MOVK  X9, #0xfc7c, LSL #48
    MOVZ  X10, #0xfb7, LSL #0
    MOVK  X10, #0x6b99, LSL #16
    MOVK  X10, #0x21e7, LSL #32
    MOVK  X10, #0x1b89, LSL #48
    MOVZ  X11, #0x2c02, LSL #0
    MOVK  X11, #0x9dc8, LSL #16
    MOVK  X11, #0xe5c, LSL #32
    MOVK  X11, #0xeaf6, LSL #48
    MOVZ  X13, #0x5710, LSL #0
    MOVK  X13, #0x7c63, LSL #16
    MOVK  X13, #0x5ddf, LSL #32
    MOVK  X13, #0x3ecd, LSL #48
    MOVZ  X14, #0x92d6, LSL #0
    MOVK  X14, #0xfe09, LSL #16
    MOVK  X14, #0x14ef, LSL #32
    MOVK  X14, #0x1e47, LSL #48
    MOVZ  X15, #0xdcbf, LSL #0
    MOVK  X15, #0xd80, LSL #16
    MOVK  X15, #0x2649, LSL #32
    MOVK  X15, #0xd645, LSL #48
    MOVZ  X16, #0x8939, LSL #0
    MOVK  X16, #0x7904, LSL #16
    MOVK  X16, #0x2637, LSL #32
    MOVK  X16, #0x883, LSL #48
    MOVZ  X17, #0xdd09, LSL #0
    MOVK  X17, #0xc194, LSL #16
    MOVK  X17, #0x48f7, LSL #32
    MOVK  X17, #0xd468, LSL #48
    MOVZ  X18, #0x6b1c, LSL #0
    MOVK  X18, #0x693b, LSL #16
    MOVK  X18, #0x4771, LSL #32
    MOVK  X18, #0x9db3, LSL #48
    MOVZ  X19, #0xe287, LSL #0
    MOVK  X19, #0x55c3, LSL #16
    MOVK  X19, #0xad47, LSL #32
    MOVK  X19, #0x6702, LSL #48
    MOVZ  X20, #0xd7fe, LSL #0
    MOVK  X20, #0x1b32, LSL #16
    MOVK  X20, #0x68c6, LSL #32
    MOVK  X20, #0xd414, LSL #48
    MOVZ  X21, #0x512c, LSL #0
    MOVK  X21, #0x629f, LSL #16
    MOVK  X21, #0xd102, LSL #32
    MOVK  X21, #0xdbf3, LSL #48
    MOVZ  X22, #0x949, LSL #0
    MOVK  X22, #0x6d0d, LSL #16
    MOVK  X22, #0x27e6, LSL #32
    MOVK  X22, #0x6f91, LSL #48
    MOVZ  X23, #0xc90e, LSL #0
    MOVK  X23, #0x6939, LSL #16
    MOVK  X23, #0x80c5, LSL #32
    MOVK  X23, #0x8fc4, LSL #48
    MOVZ  X25, #0x198c, LSL #0
    MOVK  X25, #0x50ee, LSL #16
    MOVK  X25, #0xfe23, LSL #32
    MOVK  X25, #0x14fc, LSL #48
    MOVZ  X26, #0x32ca, LSL #0
    MOVK  X26, #0xb4c4, LSL #16
    MOVK  X26, #0x6b21, LSL #32
    MOVK  X26, #0xead5, LSL #48
    MOVZ  X27, #0x1e4a, LSL #0
    MOVK  X27, #0x846a, LSL #16
    MOVK  X27, #0xd2d0, LSL #32
    MOVK  X27, #0x230a, LSL #48
    MOVZ  X28, #0xbc2e, LSL #0
    MOVK  X28, #0x3106, LSL #16
    MOVK  X28, #0x888e, LSL #32
    MOVK  X28, #0xf946, LSL #48
    MOVZ  X4, #0x3fd2, LSL #0
    MOVK  X4, #0xb69b, LSL #16
    MOVK  X4, #0x997e, LSL #32
    MOVK  X4, #0x1eba, LSL #48
    MSR  FPCR, X4
    MOVZ  X4, #0x42c8, LSL #0
    MOVK  X4, #0x8d97, LSL #16
    MOVK  X4, #0x74b9, LSL #32
    MOVK  X4, #0x48e4, LSL #48
    MSR  FPSR, X4
    MRS  X21, FPSR
    MOVZ  X16, #0xff60, LSL #0
    MOVK  X16, #0x7ff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    AND  X21, X21, X16
    MOVZ  X16, #0x0, LSL #0
    ORR  X21, X21, X16
    MSR  FPSR, X21
    ISB  SY
    ADDS  X21, X14, #0xc10, LSL #12
    MOV  X30, X1
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X4
    FMOV  D3, X7
    FMOV  V3.D[1], X19
    FMOV  D4, X14
    FMOV  V4.D[1], X22
    FMOV  D5, X9
    FMOV  V5.D[1], X16
    FMOV  D6, X8
    FMOV  V6.D[1], X16
    FMOV  D7, X2
    FMOV  V7.D[1], X13
    FMOV  D8, X9
    FMOV  V8.D[1], X6
    FMOV  D9, X21
    FMOV  V9.D[1], X2
    FMOV  D10, X27
    FMOV  V10.D[1], X15
    FMOV  D11, X13
    FMOV  V11.D[1], X18
    FMOV  D12, X21
    FMOV  V12.D[1], X13
    FMOV  D13, X11
    FMOV  V13.D[1], X23
    FMOV  D14, X20
    FMOV  V14.D[1], X4
    FMOV  D15, X20
    FMOV  V15.D[1], X2
    FMOV  D16, X19
    FMOV  V16.D[1], X14
    FMOV  D17, X19
    FMOV  V17.D[1], X10
    FMOV  D18, X17
    FMOV  V18.D[1], X7
    FMOV  D19, X5
    FMOV  V19.D[1], X18
    FMOV  D20, X25
    FMOV  V20.D[1], X13
    FMOV  D21, X8
    FMOV  V21.D[1], X3
    FMOV  D22, X15
    FMOV  V22.D[1], X13
    FMOV  D23, X6
    FMOV  V23.D[1], X17
    FMOV  D24, X2
    FMOV  V24.D[1], X3
    FMOV  D25, X11
    FMOV  V25.D[1], X15
    FMOV  D26, X13
    FMOV  V26.D[1], X7
    FMOV  D27, X8
    FMOV  V27.D[1], X4
    FMOV  D28, X21
    FMOV  V28.D[1], X9
    FMOV  D29, X16
    FMOV  V29.D[1], X8
    FMOV  D30, X25
    FMOV  V30.D[1], X10
    FMOV  D31, X22
    FMOV  V31.D[1], X14
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X5, #0x0, LSL #0
    ADD  X26, X30, X5
    MOV  X22, X26
    ST1 { V30.16B, V31.16B }, [X22], #32
    MOV  X22, X26
    LD1 { V10.16B, V11.16B }, [X22], #32
    ADD  X26, X26, X19, LSR #0
    MOV  X22, X26
    ST1 { V26.2D, V27.2D }, [X22], #32
    MOV  X22, X26
    LD1 { V10.2D, V11.2D }, [X22], #32
    ADD  X26, X26, X19
    MOV  X22, X26
    ST1 { V10.4S, V11.4S }, [X22], #32
    MOV  X22, X26
    LD1 { V3.4S, V4.4S }, [X22], #32
    ADD  X26, X26, X19, LSR #0
    MOV  X22, X26
    ST1 { V3.8H, V4.8H }, [X22], #32
    MOV  X22, X26
    LD1 { V4.8H, V5.8H }, [X22], #32
    ADD  X26, X26, X19, LSR #0
    MOV  X22, X26
    ST1 { V4.4H, V5.4H }, [X22], #16
    MOV  X22, X26
    LD1 { V31.2S, V0.2S }, [X22], #16
    ADD  X26, X26, X19, LSR #0
    MOV  X22, X26
    ST1 { V16.1D, V17.1D }, [X22], #16
    MOV  X22, X26
    LD1 { V18.1D, V19.1D }, [X22], #16
    ADD  X26, X26, X19
    MOV  X22, X26
    ST1 { V2.2S, V3.2S }, [X22], #16
    MOV  X22, X26
    LD1 { V26.2S, V27.2S }, [X22], #16
    ADD  X26, X26, X19
    MOV  X22, X26
    ST1 { V26.4H, V27.4H }, [X22], #16
    MOV  X22, X26
    LD1 { V0.4H, V1.4H }, [X22], #16
    ADD  X26, X26, X19, LSR #0
    MOV  X22, X26
    ST1 { V23.8B, V24.8B }, [X22], #16
    MOV  X22, X26
    LD1 { V15.8B, V16.8B }, [X22], #16
    ADD  X26, X26, X19
    ST1 { V30.4S, V31.4S }, [X26], X10
    LD1 { V30.2D, V31.2D }, [X26], X10
    ADD  X26, X26, X19
    ST1 { V19.16B, V20.16B }, [X26], X10
    LD1 { V11.16B, V12.16B }, [X26], X10
    ADD  X26, X26, X19, ASR #0
    ST1 { V11.2D, V12.2D }, [X26], X10
    LD1 { V14.2D, V15.2D }, [X26], X10
    ADD  X26, X26, X19
    ST1 { V0.4S, V1.4S }, [X26], X10
    LD1 { V10.4S, V11.4S }, [X26], X10
    ADD  X26, X26, X19, LSR #0
    ST1 { V15.8H, V16.8H }, [X26], X10
    LD1 { V2.8H, V3.8H }, [X26], X10
    ADD  X26, X26, X19, ASR #0
    ST1 { V10.1D, V11.1D }, [X26], X10
    LD1 { V30.1D, V31.1D }, [X26], X10
    ADD  X26, X26, X19, ASR #0
    ST1 { V30.1D, V31.1D }, [X26], X10
    LD1 { V30.1D, V31.1D }, [X26], X10
    ADD  X26, X26, X19, ASR #0
    ST1 { V2.2S, V3.2S }, [X26], X10
    LD1 { V2.2S, V3.2S }, [X26], X10
    ADD  X26, X26, X19, ASR #0
    ST1 { V25.4H, V26.4H }, [X26], X10
    LD1 { V27.4H, V28.4H }, [X26], X10
    ADD  X26, X26, X19, LSR #0
    ST1 { V30.8B, V31.8B }, [X26], X10
    LD1 { V31.8B, V0.8B }, [X26], X10
    ADD  X26, X26, X19, ASR #0
    ST1 { V0.H }[0x0], [X26]
    LD1 { V11.H }[0x6], [X26]
    ADD  X26, X26, X19
    ST1 { V31.S }[0x0], [X26]
    LD1 { V10.S }[0x0], [X26]
    ADD  X26, X26, X19, ASR #0
    ST1 { V11.D }[0x0], [X26]
    LD1 { V31.D }[0x1], [X26]
    ADD  X26, X26, X19, ASR #0
    ST1 { V31.B }[0xd], [X26]
    LD1 { V30.B }[0x1], [X26]
    ADD  X26, X26, X19
    MOV  X22, X26
    ST1 { V30.H }[0x2], [X22], #2
    MOV  X22, X26
    LD1 { V0.H }[0x2], [X22], #2
    ADD  X26, X26, X19, ASR #0
    ST1 { V10.H }[0x4], [X26], X10
    LD1 { V10.H }[0x6], [X26], X10
    ADD  X26, X26, X19
    MOV  X22, X26
    ST1 { V27.S }[0x0], [X22], #4
    MOV  X22, X26
    LD1 { V11.S }[0x1], [X22], #4
    ADD  X26, X26, X19
    ST1 { V10.S }[0x0], [X26], X10
    LD1 { V10.S }[0x0], [X26], X10
    ADD  X26, X26, X19, ASR #0
    MOV  X22, X26
    ST1 { V10.D }[0x0], [X22], #8
    MOV  X22, X26
    LD1 { V10.D }[0x1], [X22], #8
    ADD  X26, X26, X19
    ST1 { V0.D }[0x0], [X26], X10
    LD1 { V0.D }[0x1], [X26], X10
    ADD  X26, X26, X19
    MOV  X22, X26
    ST1 { V11.B }[0x5], [X22], #1
    MOV  X22, X26
    LD1 { V27.B }[0x6], [X22], #1
    ADD  X26, X26, X19, ASR #0
    ST1 { V27.B }[0x7], [X26], X10
    LD1 { V27.B }[0x6], [X26], X10
    ADD  X26, X26, X19, ASR #0
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V0.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D0
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D1
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D2
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D3
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V4.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D4
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V5.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D5
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V6.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D6
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V7.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D7
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V8.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D8
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V9.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D9
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V10.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D10
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a5a, LSL #32
    FMOV  X17, V11.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D11
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V12.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D12
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V13.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D13
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D14
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V15.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D15
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D16
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V17.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D17
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D18
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D19
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V20.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D20
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V21.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D21
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V22.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D22
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V23.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D23
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V24.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D24
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V25.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D25
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D26
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D27
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D28
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V29.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D29
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D30
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V31.D[1]
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D31
    SUB  X15, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X20
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X10
    FMOV  D3, X10
    FMOV  V3.D[1], X25
    FMOV  D4, X8
    FMOV  V4.D[1], X6
    FMOV  D5, X16
    FMOV  V5.D[1], X21
    FMOV  D6, X7
    FMOV  V6.D[1], X2
    FMOV  D7, X19
    FMOV  V7.D[1], X22
    FMOV  D8, X16
    FMOV  V8.D[1], X10
    FMOV  D9, X4
    FMOV  V9.D[1], X9
    FMOV  D10, X20
    FMOV  V10.D[1], X23
    FMOV  D11, X26
    FMOV  V11.D[1], X28
    FMOV  D12, X11
    FMOV  V12.D[1], X23
    FMOV  D13, X9
    FMOV  V13.D[1], X14
    FMOV  D14, X14
    FMOV  V14.D[1], X17
    FMOV  D15, X2
    FMOV  V15.D[1], X6
    FMOV  D16, X5
    FMOV  V16.D[1], X6
    FMOV  D17, X2
    FMOV  V17.D[1], X15
    FMOV  D18, X5
    FMOV  V18.D[1], X16
    FMOV  D19, X26
    FMOV  V19.D[1], X10
    FMOV  D20, X28
    FMOV  V20.D[1], X10
    FMOV  D21, X5
    FMOV  V21.D[1], X22
    FMOV  D22, X23
    FMOV  V22.D[1], X5
    FMOV  D23, X26
    FMOV  V23.D[1], X20
    FMOV  D24, X9
    FMOV  V24.D[1], X15
    FMOV  D25, X15
    FMOV  V25.D[1], X16
    FMOV  D26, X7
    FMOV  V26.D[1], X25
    FMOV  D27, X14
    FMOV  V27.D[1], X6
    FMOV  D28, X9
    FMOV  V28.D[1], X23
    FMOV  D29, X6
    FMOV  V29.D[1], X20
    FMOV  D30, X6
    FMOV  V30.D[1], X9
    FMOV  D31, X18
    FMOV  V31.D[1], X5
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X5, #0x500, LSL #0
    ADD  X23, X30, X5
    MOV  X28, X23
    ST1 { V29.16B, V30.16B }, [X28], #32
    MOV  X28, X23
    LD1 { V21.16B, V22.16B }, [X28], #32
    ADD  X23, X23, X4, ASR #0
    MOV  X28, X23
    ST1 { V27.2D, V28.2D }, [X28], #32
    MOV  X28, X23
    LD1 { V19.2D, V20.2D }, [X28], #32
    ADD  X23, X23, X4, LSR #0
    MOV  X28, X23
    ST1 { V21.4S, V22.4S }, [X28], #32
    MOV  X28, X23
    LD1 { V25.4S, V26.4S }, [X28], #32
    ADD  X23, X23, X4, ASR #0
    MOV  X28, X23
    ST1 { V25.8H, V26.8H }, [X28], #32
    MOV  X28, X23
    LD1 { V24.8H, V25.8H }, [X28], #32
    ADD  X23, X23, X4, LSR #0
    MOV  X28, X23
    ST1 { V19.2S, V20.2S }, [X28], #16
    MOV  X28, X23
    LD1 { V7.8B, V8.8B }, [X28], #16
    ADD  X23, X23, X4, LSR #0
    MOV  X28, X23
    ST1 { V7.1D, V8.1D }, [X28], #16
    MOV  X28, X23
    LD1 { V12.1D, V13.1D }, [X28], #16
    ADD  X23, X23, X4
    MOV  X28, X23
    ST1 { V24.2S, V25.2S }, [X28], #16
    MOV  X28, X23
    LD1 { V22.2S, V23.2S }, [X28], #16
    ADD  X23, X23, X4, ASR #0
    MOV  X28, X23
    ST1 { V22.4H, V23.4H }, [X28], #16
    MOV  X28, X23
    LD1 { V25.4H, V26.4H }, [X28], #16
    ADD  X23, X23, X4, LSR #0
    MOV  X28, X23
    ST1 { V25.8B, V26.8B }, [X28], #16
    MOV  X28, X23
    LD1 { V20.8B, V21.8B }, [X28], #16
    ADD  X23, X23, X4, LSR #0
    ST1 { V20.2D, V21.2D }, [X23], X6
    LD1 { V2.2D, V3.2D }, [X23], X6
    ADD  X23, X23, X4, LSR #0
    ST1 { V28.16B, V29.16B }, [X23], X6
    LD1 { V24.16B, V25.16B }, [X23], X6
    ADD  X23, X23, X4, LSR #0
    ST1 { V24.2D, V25.2D }, [X23], X6
    LD1 { V20.2D, V21.2D }, [X23], X6
    ADD  X23, X23, X4, LSR #0
    ST1 { V20.4S, V21.4S }, [X23], X6
    LD1 { V14.4S, V15.4S }, [X23], X6
    ADD  X23, X23, X4, LSR #0
    ST1 { V14.8H, V15.8H }, [X23], X6
    LD1 { V22.8H, V23.8H }, [X23], X6
    ADD  X23, X23, X4, ASR #0
    ST1 { V22.4H, V23.4H }, [X23], X6
    LD1 { V0.2S, V1.2S }, [X23], X6
    ADD  X23, X23, X4, LSR #0
    ST1 { V0.1D, V1.1D }, [X23], X6
    LD1 { V2.1D, V3.1D }, [X23], X6
    ADD  X23, X23, X4, LSR #0
    ST1 { V2.2S, V3.2S }, [X23], X6
    LD1 { V23.2S, V24.2S }, [X23], X6
    ADD  X23, X23, X4, ASR #0
    ST1 { V20.4H, V21.4H }, [X23], X6
    LD1 { V2.4H, V3.4H }, [X23], X6
    ADD  X23, X23, X4, ASR #0
    ST1 { V26.8B, V27.8B }, [X23], X6
    LD1 { V8.8B, V9.8B }, [X23], X6
    ADD  X23, X23, X4, ASR #0
    ST1 { V24.H }[0x1], [X23]
    LD1 { V27.H }[0x7], [X23]
    ADD  X23, X23, X4, LSR #0
    ST1 { V10.S }[0x2], [X23]
    LD1 { V15.S }[0x3], [X23]
    ADD  X23, X23, X4, ASR #0
    ST1 { V3.D }[0x0], [X23]
    LD1 { V24.D }[0x0], [X23]
    ADD  X23, X23, X4
    ST1 { V31.B }[0x8], [X23]
    LD1 { V10.B }[0x6], [X23]
    ADD  X23, X23, X4, ASR #0
    MOV  X28, X23
    ST1 { V13.H }[0x1], [X28], #2
    MOV  X28, X23
    LD1 { V3.H }[0x2], [X28], #2
    ADD  X23, X23, X4, ASR #0
    ST1 { V9.H }[0x4], [X23], X6
    LD1 { V31.H }[0x3], [X23], X6
    ADD  X23, X23, X4, ASR #0
    MOV  X28, X23
    ST1 { V10.S }[0x0], [X28], #4
    MOV  X28, X23
    LD1 { V13.S }[0x0], [X28], #4
    ADD  X23, X23, X4, ASR #0
    ST1 { V24.S }[0x0], [X23], X6
    LD1 { V9.S }[0x1], [X23], X6
    ADD  X23, X23, X4, ASR #0
    MOV  X28, X23
    ST1 { V9.D }[0x1], [X28], #8
    MOV  X28, X23
    LD1 { V9.D }[0x1], [X28], #8
    ADD  X23, X23, X4
    ST1 { V3.D }[0x1], [X23], X6
    LD1 { V13.D }[0x1], [X23], X6
    ADD  X23, X23, X4, ASR #0
    MOV  X28, X23
    ST1 { V9.B }[0x8], [X28], #1
    MOV  X28, X23
    LD1 { V30.B }[0x5], [X28], #1
    ADD  X23, X23, X4, ASR #0
    ST1 { V30.B }[0x1], [X23], X6
    LD1 { V30.B }[0x9], [X23], X6
    ADD  X23, X23, X4
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X19, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D0
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V1.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D1
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V2.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D2
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V3.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D3
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D4
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V5.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D5
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D6
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D7
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D8
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D9
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V10.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D10
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V11.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D11
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D12
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V13.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D13
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D14
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V15.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D15
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V16.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D16
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V17.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D17
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V18.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D18
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V19.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D19
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V20.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D20
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V21.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D21
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D22
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V23.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D23
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V24.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D24
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V25.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D25
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D26
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V27.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D27
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V28.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D28
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V29.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D29
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V30.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, D30
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X19, V31.D[1]
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    FMOV  X19, D31
    SUB  X25, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X20
    FMOV  V2.D[1], X28
    FMOV  D3, X5
    FMOV  V3.D[1], X27
    FMOV  D4, X8
    FMOV  V4.D[1], X5
    FMOV  D5, X17
    FMOV  V5.D[1], X5
    FMOV  D6, X3
    FMOV  V6.D[1], X16
    FMOV  D7, X23
    FMOV  V7.D[1], X8
    FMOV  D8, X26
    FMOV  V8.D[1], X2
    FMOV  D9, X5
    FMOV  V9.D[1], X11
    FMOV  D10, X15
    FMOV  V10.D[1], X11
    FMOV  D11, X9
    FMOV  V11.D[1], X20
    FMOV  D12, X6
    FMOV  V12.D[1], X15
    FMOV  D13, X15
    FMOV  V13.D[1], X10
    FMOV  D14, X21
    FMOV  V14.D[1], X27
    FMOV  D15, X22
    FMOV  V15.D[1], X28
    FMOV  D16, X13
    FMOV  V16.D[1], X20
    FMOV  D17, X10
    FMOV  V17.D[1], X3
    FMOV  D18, X22
    FMOV  V18.D[1], X28
    FMOV  D19, X21
    FMOV  V19.D[1], X22
    FMOV  D20, X23
    FMOV  V20.D[1], X21
    FMOV  D21, X11
    FMOV  V21.D[1], X25
    FMOV  D22, X10
    FMOV  V22.D[1], X22
    FMOV  D23, X27
    FMOV  V23.D[1], X11
    FMOV  D24, X4
    FMOV  V24.D[1], X16
    FMOV  D25, X11
    FMOV  V25.D[1], X22
    FMOV  D26, X9
    FMOV  V26.D[1], X8
    FMOV  D27, X10
    FMOV  V27.D[1], X11
    FMOV  D28, X17
    FMOV  V28.D[1], X2
    FMOV  D29, X3
    FMOV  V29.D[1], X14
    FMOV  D30, X8
    FMOV  V30.D[1], X17
    FMOV  D31, X4
    FMOV  V31.D[1], X22
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X8, #0xa00, LSL #0
    ADD  X26, X30, X8
    MOV  X11, X26
    ST1 { V15.16B, V16.16B }, [X11], #32
    MOV  X11, X26
    LD1 { V12.16B, V13.16B }, [X11], #32
    ADD  X26, X26, X7, ASR #0
    MOV  X11, X26
    ST1 { V29.2D, V30.2D }, [X11], #32
    MOV  X11, X26
    LD1 { V30.2D, V31.2D }, [X11], #32
    ADD  X26, X26, X7, LSR #0
    MOV  X11, X26
    ST1 { V12.4S, V13.4S }, [X11], #32
    MOV  X11, X26
    LD1 { V28.4S, V29.4S }, [X11], #32
    ADD  X26, X26, X7, LSR #0
    MOV  X11, X26
    ST1 { V30.8H, V31.8H }, [X11], #32
    MOV  X11, X26
    LD1 { V1.8H, V2.8H }, [X11], #32
    ADD  X26, X26, X7
    MOV  X11, X26
    ST1 { V28.1D, V29.1D }, [X11], #16
    MOV  X11, X26
    LD1 { V20.4H, V21.4H }, [X11], #16
    ADD  X26, X26, X7
    MOV  X11, X26
    ST1 { V1.1D, V2.1D }, [X11], #16
    MOV  X11, X26
    LD1 { V20.1D, V21.1D }, [X11], #16
    ADD  X26, X26, X7
    MOV  X11, X26
    ST1 { V20.2S, V21.2S }, [X11], #16
    MOV  X11, X26
    LD1 { V26.2S, V27.2S }, [X11], #16
    ADD  X26, X26, X7, ASR #0
    MOV  X11, X26
    ST1 { V16.4H, V17.4H }, [X11], #16
    MOV  X11, X26
    LD1 { V16.4H, V17.4H }, [X11], #16
    ADD  X26, X26, X7
    MOV  X11, X26
    ST1 { V27.8B, V28.8B }, [X11], #16
    MOV  X11, X26
    LD1 { V16.8B, V17.8B }, [X11], #16
    ADD  X26, X26, X7
    ST1 { V1.2D, V2.2D }, [X26], X16
    LD1 { V20.2D, V21.2D }, [X26], X16
    ADD  X26, X26, X7, LSR #0
    ST1 { V20.16B, V21.16B }, [X26], X16
    LD1 { V20.16B, V21.16B }, [X26], X16
    ADD  X26, X26, X7, LSR #0
    ST1 { V19.2D, V20.2D }, [X26], X16
    LD1 { V16.2D, V17.2D }, [X26], X16
    ADD  X26, X26, X7, ASR #0
    ST1 { V0.4S, V1.4S }, [X26], X16
    LD1 { V5.4S, V6.4S }, [X26], X16
    ADD  X26, X26, X7, LSR #0
    ST1 { V14.8H, V15.8H }, [X26], X16
    LD1 { V20.8H, V21.8H }, [X26], X16
    ADD  X26, X26, X7, ASR #0
    ST1 { V22.8B, V23.8B }, [X26], X16
    LD1 { V30.2S, V31.2S }, [X26], X16
    ADD  X26, X26, X7
    ST1 { V30.1D, V31.1D }, [X26], X16
    LD1 { V23.1D, V24.1D }, [X26], X16
    ADD  X26, X26, X7, ASR #0
    ST1 { V23.2S, V24.2S }, [X26], X16
    LD1 { V9.2S, V10.2S }, [X26], X16
    ADD  X26, X26, X7, ASR #0
    ST1 { V16.4H, V17.4H }, [X26], X16
    LD1 { V14.4H, V15.4H }, [X26], X16
    ADD  X26, X26, X7
    ST1 { V14.8B, V15.8B }, [X26], X16
    LD1 { V23.8B, V24.8B }, [X26], X16
    ADD  X26, X26, X7, ASR #0
    ST1 { V24.H }[0x5], [X26]
    LD1 { V30.H }[0x3], [X26]
    ADD  X26, X26, X7
    ST1 { V21.S }[0x2], [X26]
    LD1 { V22.S }[0x1], [X26]
    ADD  X26, X26, X7, LSR #0
    ST1 { V9.D }[0x0], [X26]
    LD1 { V14.D }[0x0], [X26]
    ADD  X26, X26, X7
    ST1 { V10.B }[0x8], [X26]
    LD1 { V15.B }[0xc], [X26]
    ADD  X26, X26, X7, LSR #0
    MOV  X11, X26
    ST1 { V22.H }[0x6], [X11], #2
    MOV  X11, X26
    LD1 { V24.H }[0x3], [X11], #2
    ADD  X26, X26, X7, LSR #0
    ST1 { V14.H }[0x1], [X26], X16
    LD1 { V22.H }[0x3], [X26], X16
    ADD  X26, X26, X7
    MOV  X11, X26
    ST1 { V30.S }[0x0], [X11], #4
    MOV  X11, X26
    LD1 { V9.S }[0x2], [X11], #4
    ADD  X26, X26, X7, LSR #0
    ST1 { V24.S }[0x2], [X26], X16
    LD1 { V10.S }[0x0], [X26], X16
    ADD  X26, X26, X7
    MOV  X11, X26
    ST1 { V9.D }[0x1], [X11], #8
    MOV  X11, X26
    LD1 { V21.D }[0x0], [X11], #8
    ADD  X26, X26, X7, LSR #0
    ST1 { V21.D }[0x1], [X26], X16
    LD1 { V21.D }[0x0], [X26], X16
    ADD  X26, X26, X7, LSR #0
    MOV  X11, X26
    ST1 { V15.B }[0xc], [X11], #1
    MOV  X11, X26
    LD1 { V15.B }[0x2], [X11], #1
    ADD  X26, X26, X7
    ST1 { V10.B }[0x1], [X26], X16
    LD1 { V9.B }[0xf], [X26], X16
    ADD  X26, X26, X7, ASR #0
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X2, FPSR
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V0.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D0
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V1.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D1
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V2.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D2
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V3.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D3
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V4.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D4
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D5
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V6.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D6
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D7
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D8
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    FMOV  X2, V9.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D9
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D10
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V11.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D11
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V12.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D12
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D13
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D14
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a00, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D15
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V16.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D16
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V17.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D17
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V18.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D18
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V19.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D19
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D20
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D21
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D22
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D23
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D24
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V25.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D25
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D26
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D27
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V28.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D28
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V29.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D29
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    FMOV  X2, D30
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D31
    SUB  X15, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X23
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X2
    FMOV  V3.D[1], X10
    FMOV  D4, X21
    FMOV  V4.D[1], X8
    FMOV  D5, X14
    FMOV  V5.D[1], X4
    FMOV  D6, X19
    FMOV  V6.D[1], X4
    FMOV  D7, X11
    FMOV  V7.D[1], X21
    FMOV  D8, X20
    FMOV  V8.D[1], X8
    FMOV  D9, X17
    FMOV  V9.D[1], X19
    FMOV  D10, X4
    FMOV  V10.D[1], X26
    FMOV  D11, X21
    FMOV  V11.D[1], X16
    FMOV  D12, X14
    FMOV  V12.D[1], X15
    FMOV  D13, X11
    FMOV  V13.D[1], X8
    FMOV  D14, X14
    FMOV  V14.D[1], X16
    FMOV  D15, X28
    FMOV  V15.D[1], X2
    FMOV  D16, X20
    FMOV  V16.D[1], X4
    FMOV  D17, X25
    FMOV  V17.D[1], X17
    FMOV  D18, X14
    FMOV  V18.D[1], X16
    FMOV  D19, X10
    FMOV  V19.D[1], X15
    FMOV  D20, X18
    FMOV  V20.D[1], X13
    FMOV  D21, X20
    FMOV  V21.D[1], X13
    FMOV  D22, X17
    FMOV  V22.D[1], X11
    FMOV  D23, X8
    FMOV  V23.D[1], X13
    FMOV  D24, X6
    FMOV  V24.D[1], X28
    FMOV  D25, X5
    FMOV  V25.D[1], X11
    FMOV  D26, X25
    FMOV  V26.D[1], X19
    FMOV  D27, X28
    FMOV  V27.D[1], X20
    FMOV  D28, X14
    FMOV  V28.D[1], X20
    FMOV  D29, X26
    FMOV  V29.D[1], X14
    FMOV  D30, X28
    FMOV  V30.D[1], X9
    FMOV  D31, X22
    FMOV  V31.D[1], X18
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X18, #0x40, LSL #0
    MOVZ  X13, #0xf00, LSL #0
    ADD  X16, X30, X13, LSR #0
    MOV  X4, X16
    ST1 { V22.16B, V23.16B }, [X4], #32
    MOV  X4, X16
    LD1 { V9.16B, V10.16B }, [X4], #32
    ADD  X16, X16, X18
    MOV  X4, X16
    ST1 { V9.2D, V10.2D }, [X4], #32
    MOV  X4, X16
    LD1 { V6.2D, V7.2D }, [X4], #32
    ADD  X16, X16, X18, LSR #0
    MOV  X4, X16
    ST1 { V6.4S, V7.4S }, [X4], #32
    MOV  X4, X16
    LD1 { V24.4S, V25.4S }, [X4], #32
    ADD  X16, X16, X18, ASR #0
    MOV  X4, X16
    ST1 { V12.8H, V13.8H }, [X4], #32
    MOV  X4, X16
    LD1 { V17.8H, V18.8H }, [X4], #32
    ADD  X16, X16, X18, ASR #0
    MOV  X4, X16
    ST1 { V24.8B, V25.8B }, [X4], #16
    MOV  X4, X16
    LD1 { V0.1D, V1.1D }, [X4], #16
    ADD  X16, X16, X18
    MOV  X4, X16
    ST1 { V17.1D, V18.1D }, [X4], #16
    MOV  X4, X16
    LD1 { V2.1D, V3.1D }, [X4], #16
    ADD  X16, X16, X18, LSR #0
    MOV  X4, X16
    ST1 { V1.2S, V2.2S }, [X4], #16
    MOV  X4, X16
    LD1 { V9.2S, V10.2S }, [X4], #16
    ADD  X16, X16, X18
    MOV  X4, X16
    ST1 { V9.4H, V10.4H }, [X4], #16
    MOV  X4, X16
    LD1 { V31.4H, V0.4H }, [X4], #16
    ADD  X16, X16, X18, LSR #0
    MOV  X4, X16
    ST1 { V31.8B, V0.8B }, [X4], #16
    MOV  X4, X16
    LD1 { V8.8B, V9.8B }, [X4], #16
    ADD  X16, X16, X18, LSR #0
    ST1 { V18.16B, V19.16B }, [X16], X22
    LD1 { V15.4S, V16.4S }, [X16], X22
    ADD  X16, X16, X18, LSR #0
    ST1 { V4.16B, V5.16B }, [X16], X22
    LD1 { V30.16B, V31.16B }, [X16], X22
    ADD  X16, X16, X18
    ST1 { V4.2D, V5.2D }, [X16], X22
    LD1 { V7.2D, V8.2D }, [X16], X22
    ADD  X16, X16, X18, LSR #0
    ST1 { V30.4S, V31.4S }, [X16], X22
    LD1 { V27.4S, V28.4S }, [X16], X22
    ADD  X16, X16, X18
    ST1 { V4.8H, V5.8H }, [X16], X22
    LD1 { V23.8H, V24.8H }, [X16], X22
    ADD  X16, X16, X18, ASR #0
    ST1 { V27.4H, V28.4H }, [X16], X22
    LD1 { V6.2S, V7.2S }, [X16], X22
    ADD  X16, X16, X18, ASR #0
    ST1 { V5.1D, V6.1D }, [X16], X22
    LD1 { V11.1D, V12.1D }, [X16], X22
    ADD  X16, X16, X18, LSR #0
    ST1 { V15.2S, V16.2S }, [X16], X22
    LD1 { V25.2S, V26.2S }, [X16], X22
    ADD  X16, X16, X18, ASR #0
    ST1 { V23.4H, V24.4H }, [X16], X22
    LD1 { V10.4H, V11.4H }, [X16], X22
    ADD  X16, X16, X18
    ST1 { V12.8B, V13.8B }, [X16], X22
    LD1 { V27.8B, V28.8B }, [X16], X22
    ADD  X16, X16, X18, ASR #0
    ST1 { V27.H }[0x0], [X16]
    LD1 { V13.H }[0x2], [X16]
    ADD  X16, X16, X18, LSR #0
    ST1 { V11.S }[0x1], [X16]
    LD1 { V16.S }[0x0], [X16]
    ADD  X16, X16, X18, ASR #0
    ST1 { V10.D }[0x0], [X16]
    LD1 { V23.D }[0x1], [X16]
    ADD  X16, X16, X18
    ST1 { V13.B }[0x1], [X16]
    LD1 { V4.B }[0x5], [X16]
    ADD  X16, X16, X18, ASR #0
    MOV  X4, X16
    ST1 { V16.H }[0x5], [X4], #2
    MOV  X4, X16
    LD1 { V27.H }[0x7], [X4], #2
    ADD  X16, X16, X18, LSR #0
    ST1 { V27.H }[0x6], [X16], X22
    LD1 { V16.H }[0x5], [X16], X22
    ADD  X16, X16, X18, ASR #0
    MOV  X4, X16
    ST1 { V4.S }[0x0], [X4], #4
    MOV  X4, X16
    LD1 { V11.S }[0x1], [X4], #4
    ADD  X16, X16, X18, LSR #0
    ST1 { V23.S }[0x0], [X16], X22
    LD1 { V13.S }[0x3], [X16], X22
    ADD  X16, X16, X18, LSR #0
    MOV  X4, X16
    ST1 { V13.D }[0x1], [X4], #8
    MOV  X4, X16
    LD1 { V23.D }[0x1], [X4], #8
    ADD  X16, X16, X18, LSR #0
    ST1 { V11.D }[0x0], [X16], X22
    LD1 { V11.D }[0x0], [X16], X22
    ADD  X16, X16, X18
    MOV  X4, X16
    ST1 { V11.B }[0xc], [X4], #1
    MOV  X4, X16
    LD1 { V13.B }[0xe], [X4], #1
    ADD  X16, X16, X18
    ST1 { V23.B }[0x1], [X16], X22
    LD1 { V11.B }[0x1], [X16], X22
    ADD  X16, X16, X18, ASR #0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X19, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D0
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V1.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D1
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V2.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D2
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V3.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D3
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D4
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V5.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D5
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V6.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D6
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D7
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V8.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D8
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D9
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D10
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D11
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D12
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    FMOV  X19, V13.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D13
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D14
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V15.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D15
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V16.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D16
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V17.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D17
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V18.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D18
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V19.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D19
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V20.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D20
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V21.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D21
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D22
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V23.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D23
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V24.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D24
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V25.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D25
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D26
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V27.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D27
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X19, V28.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D28
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V29.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D29
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V30.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D30
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, V31.D[1]
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X19, D31
    SUB  X26, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X23
    FMOV  V2.D[1], X3
    FMOV  D3, X10
    FMOV  V3.D[1], X26
    FMOV  D4, X4
    FMOV  V4.D[1], X3
    FMOV  D5, X18
    FMOV  V5.D[1], X15
    FMOV  D6, X6
    FMOV  V6.D[1], X10
    FMOV  D7, X28
    FMOV  V7.D[1], X25
    FMOV  D8, X9
    FMOV  V8.D[1], X14
    FMOV  D9, X7
    FMOV  V9.D[1], X21
    FMOV  D10, X7
    FMOV  V10.D[1], X19
    FMOV  D11, X7
    FMOV  V11.D[1], X4
    FMOV  D12, X10
    FMOV  V12.D[1], X11
    FMOV  D13, X19
    FMOV  V13.D[1], X18
    FMOV  D14, X5
    FMOV  V14.D[1], X8
    FMOV  D15, X10
    FMOV  V15.D[1], X8
    FMOV  D16, X16
    FMOV  V16.D[1], X5
    FMOV  D17, X9
    FMOV  V17.D[1], X11
    FMOV  D18, X10
    FMOV  V18.D[1], X4
    FMOV  D19, X15
    FMOV  V19.D[1], X22
    FMOV  D20, X13
    FMOV  V20.D[1], X17
    FMOV  D21, X7
    FMOV  V21.D[1], X8
    FMOV  D22, X8
    FMOV  V22.D[1], X5
    FMOV  D23, X23
    FMOV  V23.D[1], X18
    FMOV  D24, X28
    FMOV  V24.D[1], X7
    FMOV  D25, X10
    FMOV  V25.D[1], X10
    FMOV  D26, X21
    FMOV  V26.D[1], X7
    FMOV  D27, X14
    FMOV  V27.D[1], X9
    FMOV  D28, X8
    FMOV  V28.D[1], X28
    FMOV  D29, X8
    FMOV  V29.D[1], X11
    FMOV  D30, X17
    FMOV  V30.D[1], X23
    FMOV  D31, X18
    FMOV  V31.D[1], X6
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X5, #0x1400, LSL #0
    ADD  X21, X30, X5
    MOV  X9, X21
    ST1 { V8.16B, V9.16B }, [X9], #32
    MOV  X9, X21
    LD1 { V27.16B, V28.16B }, [X9], #32
    ADD  X21, X21, X14, LSR #0
    MOV  X9, X21
    ST1 { V19.2D, V20.2D }, [X9], #32
    MOV  X9, X21
    LD1 { V26.2D, V27.2D }, [X9], #32
    ADD  X21, X21, X14
    MOV  X9, X21
    ST1 { V5.4S, V6.4S }, [X9], #32
    MOV  X9, X21
    LD1 { V13.4S, V14.4S }, [X9], #32
    ADD  X21, X21, X14, ASR #0
    MOV  X9, X21
    ST1 { V13.8H, V14.8H }, [X9], #32
    MOV  X9, X21
    LD1 { V30.8H, V31.8H }, [X9], #32
    ADD  X21, X21, X14, ASR #0
    MOV  X9, X21
    ST1 { V30.4H, V31.4H }, [X9], #16
    MOV  X9, X21
    LD1 { V0.8B, V1.8B }, [X9], #16
    ADD  X21, X21, X14
    MOV  X9, X21
    ST1 { V20.1D, V21.1D }, [X9], #16
    MOV  X9, X21
    LD1 { V13.1D, V14.1D }, [X9], #16
    ADD  X21, X21, X14, LSR #0
    MOV  X9, X21
    ST1 { V0.2S, V1.2S }, [X9], #16
    MOV  X9, X21
    LD1 { V6.2S, V7.2S }, [X9], #16
    ADD  X21, X21, X14, ASR #0
    MOV  X9, X21
    ST1 { V6.4H, V7.4H }, [X9], #16
    MOV  X9, X21
    LD1 { V30.4H, V31.4H }, [X9], #16
    ADD  X21, X21, X14
    MOV  X9, X21
    ST1 { V30.8B, V31.8B }, [X9], #16
    MOV  X9, X21
    LD1 { V28.8B, V29.8B }, [X9], #16
    ADD  X21, X21, X14, ASR #0
    ST1 { V28.4S, V29.4S }, [X21], X10
    LD1 { V10.4S, V11.4S }, [X21], X10
    ADD  X21, X21, X14
    ST1 { V10.16B, V11.16B }, [X21], X10
    LD1 { V6.16B, V7.16B }, [X21], X10
    ADD  X21, X21, X14, LSR #0
    ST1 { V6.2D, V7.2D }, [X21], X10
    LD1 { V28.2D, V29.2D }, [X21], X10
    ADD  X21, X21, X14, ASR #0
    ST1 { V28.4S, V29.4S }, [X21], X10
    LD1 { V14.4S, V15.4S }, [X21], X10
    ADD  X21, X21, X14
    ST1 { V14.8H, V15.8H }, [X21], X10
    LD1 { V31.8H, V0.8H }, [X21], X10
    ADD  X21, X21, X14
    ST1 { V30.1D, V31.1D }, [X21], X10
    LD1 { V13.4H, V14.4H }, [X21], X10
    ADD  X21, X21, X14
    ST1 { V31.1D, V0.1D }, [X21], X10
    LD1 { V5.1D, V6.1D }, [X21], X10
    ADD  X21, X21, X14, ASR #0
    ST1 { V27.2S, V28.2S }, [X21], X10
    LD1 { V5.2S, V6.2S }, [X21], X10
    ADD  X21, X21, X14, ASR #0
    ST1 { V13.4H, V14.4H }, [X21], X10
    LD1 { V8.4H, V9.4H }, [X21], X10
    ADD  X21, X21, X14, ASR #0
    ST1 { V2.8B, V3.8B }, [X21], X10
    LD1 { V23.8B, V24.8B }, [X21], X10
    ADD  X21, X21, X14
    ST1 { V1.H }[0x6], [X21]
    LD1 { V0.H }[0x0], [X21]
    ADD  X21, X21, X14
    ST1 { V22.S }[0x0], [X21]
    LD1 { V2.S }[0x3], [X21]
    ADD  X21, X21, X14, ASR #0
    ST1 { V14.D }[0x1], [X21]
    LD1 { V28.D }[0x0], [X21]
    ADD  X21, X21, X14, LSR #0
    ST1 { V23.B }[0xa], [X21]
    LD1 { V1.B }[0xf], [X21]
    ADD  X21, X21, X14, ASR #0
    MOV  X9, X21
    ST1 { V5.H }[0x6], [X9], #2
    MOV  X9, X21
    LD1 { V22.H }[0x1], [X9], #2
    ADD  X21, X21, X14
    ST1 { V0.H }[0x3], [X21], X10
    LD1 { V13.H }[0x2], [X21], X10
    ADD  X21, X21, X14
    MOV  X9, X21
    ST1 { V13.S }[0x2], [X9], #4
    MOV  X9, X21
    LD1 { V5.S }[0x3], [X9], #4
    ADD  X21, X21, X14, ASR #0
    ST1 { V22.S }[0x1], [X21], X10
    LD1 { V23.S }[0x2], [X21], X10
    ADD  X21, X21, X14, ASR #0
    MOV  X9, X21
    ST1 { V1.D }[0x1], [X9], #8
    MOV  X9, X21
    LD1 { V14.D }[0x1], [X9], #8
    ADD  X21, X21, X14, ASR #0
    ST1 { V5.D }[0x0], [X21], X10
    LD1 { V13.D }[0x0], [X21], X10
    ADD  X21, X21, X14
    MOV  X9, X21
    ST1 { V13.B }[0xb], [X9], #1
    MOV  X9, X21
    LD1 { V1.B }[0xd], [X9], #1
    ADD  X21, X21, X14
    ST1 { V14.B }[0x2], [X21], X10
    LD1 { V5.B }[0xf], [X21], X10
    ADD  X21, X21, X14, ASR #0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X18, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D1
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D2
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V3.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D3
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V4.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D4
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a00, LSL #48
    FMOV  X18, V5.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D5
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D6
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D7
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D8
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D9
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D10
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D11
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D12
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D13
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D14
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D15
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V16.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D16
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V17.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D17
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V18.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D18
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D19
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V20.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D20
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V21.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D21
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V22.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D22
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    FMOV  X18, V23.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D23
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D24
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V25.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D25
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V26.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D26
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, V27.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D27
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, D28
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D29
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X18, D31
    SUB  X7, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X23
    FMOV  D1, X25
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X19
    FMOV  V3.D[1], X15
    FMOV  D4, X6
    FMOV  V4.D[1], X5
    FMOV  D5, X3
    FMOV  V5.D[1], X7
    FMOV  D6, X8
    FMOV  V6.D[1], X20
    FMOV  D7, X19
    FMOV  V7.D[1], X8
    FMOV  D8, X19
    FMOV  V8.D[1], X3
    FMOV  D9, X20
    FMOV  V9.D[1], X27
    FMOV  D10, X25
    FMOV  V10.D[1], X11
    FMOV  D11, X2
    FMOV  V11.D[1], X6
    FMOV  D12, X27
    FMOV  V12.D[1], X19
    FMOV  D13, X14
    FMOV  V13.D[1], X15
    FMOV  D14, X26
    FMOV  V14.D[1], X16
    FMOV  D15, X20
    FMOV  V15.D[1], X21
    FMOV  D16, X23
    FMOV  V16.D[1], X6
    FMOV  D17, X28
    FMOV  V17.D[1], X3
    FMOV  D18, X9
    FMOV  V18.D[1], X28
    FMOV  D19, X18
    FMOV  V19.D[1], X21
    FMOV  D20, X22
    FMOV  V20.D[1], X27
    FMOV  D21, X8
    FMOV  V21.D[1], X11
    FMOV  D22, X19
    FMOV  V22.D[1], X28
    FMOV  D23, X4
    FMOV  V23.D[1], X8
    FMOV  D24, X15
    FMOV  V24.D[1], X21
    FMOV  D25, X15
    FMOV  V25.D[1], X7
    FMOV  D26, X3
    FMOV  V26.D[1], X26
    FMOV  D27, X2
    FMOV  V27.D[1], X9
    FMOV  D28, X21
    FMOV  V28.D[1], X8
    FMOV  D29, X25
    FMOV  V29.D[1], X26
    FMOV  D30, X25
    FMOV  V30.D[1], X25
    FMOV  D31, X7
    FMOV  V31.D[1], X20
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X8, #0x1900, LSL #0
    ADD  X2, X30, X8, LSR #0
    MOV  X25, X2
    ST1 { V25.16B, V26.16B }, [X25], #32
    MOV  X25, X2
    LD1 { V15.16B, V16.16B }, [X25], #32
    ADD  X2, X2, X23
    MOV  X25, X2
    ST1 { V23.2D, V24.2D }, [X25], #32
    MOV  X25, X2
    LD1 { V7.2D, V8.2D }, [X25], #32
    ADD  X2, X2, X23, LSR #0
    MOV  X25, X2
    ST1 { V15.4S, V16.4S }, [X25], #32
    MOV  X25, X2
    LD1 { V0.4S, V1.4S }, [X25], #32
    ADD  X2, X2, X23
    MOV  X25, X2
    ST1 { V7.8H, V8.8H }, [X25], #32
    MOV  X25, X2
    LD1 { V13.8H, V14.8H }, [X25], #32
    ADD  X2, X2, X23
    MOV  X25, X2
    ST1 { V0.4H, V1.4H }, [X25], #16
    MOV  X25, X2
    LD1 { V23.1D, V24.1D }, [X25], #16
    ADD  X2, X2, X23, LSR #0
    MOV  X25, X2
    ST1 { V23.1D, V24.1D }, [X25], #16
    MOV  X25, X2
    LD1 { V10.1D, V11.1D }, [X25], #16
    ADD  X2, X2, X23, LSR #0
    MOV  X25, X2
    ST1 { V13.2S, V14.2S }, [X25], #16
    MOV  X25, X2
    LD1 { V1.2S, V2.2S }, [X25], #16
    ADD  X2, X2, X23, LSR #0
    MOV  X25, X2
    ST1 { V1.4H, V2.4H }, [X25], #16
    MOV  X25, X2
    LD1 { V16.4H, V17.4H }, [X25], #16
    ADD  X2, X2, X23, ASR #0
    MOV  X25, X2
    ST1 { V28.8B, V29.8B }, [X25], #16
    MOV  X25, X2
    LD1 { V17.8B, V18.8B }, [X25], #16
    ADD  X2, X2, X23, LSR #0
    ST1 { V10.2D, V11.2D }, [X2], X13
    LD1 { V12.16B, V13.16B }, [X2], X13
    ADD  X2, X2, X23, ASR #0
    ST1 { V12.16B, V13.16B }, [X2], X13
    LD1 { V3.16B, V4.16B }, [X2], X13
    ADD  X2, X2, X23, ASR #0
    ST1 { V3.2D, V4.2D }, [X2], X13
    LD1 { V27.2D, V28.2D }, [X2], X13
    ADD  X2, X2, X23, LSR #0
    ST1 { V27.4S, V28.4S }, [X2], X13
    LD1 { V8.4S, V9.4S }, [X2], X13
    ADD  X2, X2, X23, ASR #0
    ST1 { V17.8H, V18.8H }, [X2], X13
    LD1 { V10.8H, V11.8H }, [X2], X13
    ADD  X2, X2, X23, LSR #0
    ST1 { V30.1D, V31.1D }, [X2], X13
    LD1 { V27.2S, V28.2S }, [X2], X13
    ADD  X2, X2, X23, LSR #0
    ST1 { V10.1D, V11.1D }, [X2], X13
    LD1 { V3.1D, V4.1D }, [X2], X13
    ADD  X2, X2, X23, ASR #0
    ST1 { V8.2S, V9.2S }, [X2], X13
    LD1 { V12.2S, V13.2S }, [X2], X13
    ADD  X2, X2, X23, LSR #0
    ST1 { V12.4H, V13.4H }, [X2], X13
    LD1 { V30.4H, V31.4H }, [X2], X13
    ADD  X2, X2, X23, ASR #0
    ST1 { V30.8B, V31.8B }, [X2], X13
    LD1 { V8.8B, V9.8B }, [X2], X13
    ADD  X2, X2, X23, ASR #0
    ST1 { V28.H }[0x4], [X2]
    LD1 { V31.H }[0x5], [X2]
    ADD  X2, X2, X23
    ST1 { V3.S }[0x3], [X2]
    LD1 { V28.S }[0x0], [X2]
    ADD  X2, X2, X23
    ST1 { V31.D }[0x1], [X2]
    LD1 { V30.D }[0x0], [X2]
    ADD  X2, X2, X23, LSR #0
    ST1 { V4.B }[0xf], [X2]
    LD1 { V13.B }[0xf], [X2]
    ADD  X2, X2, X23
    MOV  X25, X2
    ST1 { V13.H }[0x1], [X25], #2
    MOV  X25, X2
    LD1 { V12.H }[0x7], [X25], #2
    ADD  X2, X2, X23, LSR #0
    ST1 { V8.H }[0x7], [X2], X13
    LD1 { V3.H }[0x0], [X2], X13
    ADD  X2, X2, X23, LSR #0
    MOV  X25, X2
    ST1 { V9.S }[0x1], [X25], #4
    MOV  X25, X2
    LD1 { V13.S }[0x3], [X25], #4
    ADD  X2, X2, X23, ASR #0
    ST1 { V28.S }[0x2], [X2], X13
    LD1 { V31.S }[0x3], [X2], X13
    ADD  X2, X2, X23, ASR #0
    MOV  X25, X2
    ST1 { V31.D }[0x1], [X25], #8
    MOV  X25, X2
    LD1 { V9.D }[0x1], [X25], #8
    ADD  X2, X2, X23
    ST1 { V3.D }[0x0], [X2], X13
    LD1 { V4.D }[0x1], [X2], X13
    ADD  X2, X2, X23
    MOV  X25, X2
    ST1 { V9.B }[0x2], [X25], #1
    MOV  X25, X2
    LD1 { V31.B }[0xb], [X25], #1
    ADD  X2, X2, X23
    ST1 { V13.B }[0x0], [X2], X13
    LD1 { V13.B }[0x6], [X2], X13
    ADD  X2, X2, X23
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X6, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X6, FPSR
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V0.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D0
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D1
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D2
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D3
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V4.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D4
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V5.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D5
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V6.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D6
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V7.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D7
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D8
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D9
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D10
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D11
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V12.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D12
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V13.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D13
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V14.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D14
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V15.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D15
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D16
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V17.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D17
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D18
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V19.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D19
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V20.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D20
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V21.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D21
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V22.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D22
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D23
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D24
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V25.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D25
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V26.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D26
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D27
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D28
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, V29.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D29
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X6, D30
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa500, LSL #16
    FMOV  X6, V31.D[1]
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X6, D31
    SUB  X21, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X16
    FMOV  D3, X6
    FMOV  V3.D[1], X28
    FMOV  D4, X2
    FMOV  V4.D[1], X18
    FMOV  D5, X28
    FMOV  V5.D[1], X2
    FMOV  D6, X13
    FMOV  V6.D[1], X25
    FMOV  D7, X2
    FMOV  V7.D[1], X13
    FMOV  D8, X11
    FMOV  V8.D[1], X2
    FMOV  D9, X14
    FMOV  V9.D[1], X2
    FMOV  D10, X2
    FMOV  V10.D[1], X11
    FMOV  D11, X19
    FMOV  V11.D[1], X6
    FMOV  D12, X14
    FMOV  V12.D[1], X16
    FMOV  D13, X3
    FMOV  V13.D[1], X22
    FMOV  D14, X7
    FMOV  V14.D[1], X27
    FMOV  D15, X4
    FMOV  V15.D[1], X6
    FMOV  D16, X2
    FMOV  V16.D[1], X18
    FMOV  D17, X16
    FMOV  V17.D[1], X20
    FMOV  D18, X21
    FMOV  V18.D[1], X19
    FMOV  D19, X17
    FMOV  V19.D[1], X8
    FMOV  D20, X28
    FMOV  V20.D[1], X6
    FMOV  D21, X4
    FMOV  V21.D[1], X14
    FMOV  D22, X4
    FMOV  V22.D[1], X9
    FMOV  D23, X8
    FMOV  V23.D[1], X27
    FMOV  D24, X17
    FMOV  V24.D[1], X8
    FMOV  D25, X26
    FMOV  V25.D[1], X5
    FMOV  D26, X27
    FMOV  V26.D[1], X8
    FMOV  D27, X3
    FMOV  V27.D[1], X11
    FMOV  D28, X18
    FMOV  V28.D[1], X18
    FMOV  D29, X11
    FMOV  V29.D[1], X7
    FMOV  D30, X23
    FMOV  V30.D[1], X20
    FMOV  D31, X10
    FMOV  V31.D[1], X2
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X10, #0x1e00, LSL #0
    ADD  X26, X30, X10
    MOV  X6, X26
    ST1 { V26.16B, V27.16B }, [X6], #32
    MOV  X6, X26
    LD1 { V2.16B, V3.16B }, [X6], #32
    ADD  X26, X26, X25, ASR #0
    MOV  X6, X26
    ST1 { V23.2D, V24.2D }, [X6], #32
    MOV  X6, X26
    LD1 { V10.2D, V11.2D }, [X6], #32
    ADD  X26, X26, X25, LSR #0
    MOV  X6, X26
    ST1 { V2.4S, V3.4S }, [X6], #32
    MOV  X6, X26
    LD1 { V0.4S, V1.4S }, [X6], #32
    ADD  X26, X26, X25
    MOV  X6, X26
    ST1 { V0.8H, V1.8H }, [X6], #32
    MOV  X6, X26
    LD1 { V6.8H, V7.8H }, [X6], #32
    ADD  X26, X26, X25
    MOV  X6, X26
    ST1 { V6.4H, V7.4H }, [X6], #16
    MOV  X6, X26
    LD1 { V7.1D, V8.1D }, [X6], #16
    ADD  X26, X26, X25, ASR #0
    MOV  X6, X26
    ST1 { V7.1D, V8.1D }, [X6], #16
    MOV  X6, X26
    LD1 { V11.1D, V12.1D }, [X6], #16
    ADD  X26, X26, X25
    MOV  X6, X26
    ST1 { V11.2S, V12.2S }, [X6], #16
    MOV  X6, X26
    LD1 { V8.2S, V9.2S }, [X6], #16
    ADD  X26, X26, X25, LSR #0
    MOV  X6, X26
    ST1 { V16.4H, V17.4H }, [X6], #16
    MOV  X6, X26
    LD1 { V6.4H, V7.4H }, [X6], #16
    ADD  X26, X26, X25, LSR #0
    MOV  X6, X26
    ST1 { V22.8B, V23.8B }, [X6], #16
    MOV  X6, X26
    LD1 { V16.8B, V17.8B }, [X6], #16
    ADD  X26, X26, X25, LSR #0
    ST1 { V22.2D, V23.2D }, [X26], X22
    LD1 { V4.4S, V5.4S }, [X26], X22
    ADD  X26, X26, X25
    ST1 { V27.16B, V28.16B }, [X26], X22
    LD1 { V7.16B, V8.16B }, [X26], X22
    ADD  X26, X26, X25, LSR #0
    ST1 { V25.2D, V26.2D }, [X26], X22
    LD1 { V2.2D, V3.2D }, [X26], X22
    ADD  X26, X26, X25
    ST1 { V3.4S, V4.4S }, [X26], X22
    LD1 { V29.4S, V30.4S }, [X26], X22
    ADD  X26, X26, X25, ASR #0
    ST1 { V6.8H, V7.8H }, [X26], X22
    LD1 { V11.8H, V12.8H }, [X26], X22
    ADD  X26, X26, X25, ASR #0
    ST1 { V11.4H, V12.4H }, [X26], X22
    LD1 { V9.1D, V10.1D }, [X26], X22
    ADD  X26, X26, X25, ASR #0
    ST1 { V8.1D, V9.1D }, [X26], X22
    LD1 { V1.1D, V2.1D }, [X26], X22
    ADD  X26, X26, X25, ASR #0
    ST1 { V31.2S, V0.2S }, [X26], X22
    LD1 { V31.2S, V0.2S }, [X26], X22
    ADD  X26, X26, X25, ASR #0
    ST1 { V29.4H, V30.4H }, [X26], X22
    LD1 { V6.4H, V7.4H }, [X26], X22
    ADD  X26, X26, X25
    ST1 { V31.8B, V0.8B }, [X26], X22
    LD1 { V8.8B, V9.8B }, [X26], X22
    ADD  X26, X26, X25, LSR #0
    ST1 { V7.H }[0x4], [X26]
    LD1 { V12.H }[0x0], [X26]
    ADD  X26, X26, X25, ASR #0
    ST1 { V6.S }[0x1], [X26]
    LD1 { V31.S }[0x3], [X26]
    ADD  X26, X26, X25, ASR #0
    ST1 { V8.D }[0x1], [X26]
    LD1 { V8.D }[0x0], [X26]
    ADD  X26, X26, X25
    ST1 { V1.B }[0x8], [X26]
    LD1 { V6.B }[0x3], [X26]
    ADD  X26, X26, X25, ASR #0
    MOV  X6, X26
    ST1 { V9.H }[0x7], [X6], #2
    MOV  X6, X26
    LD1 { V1.H }[0x3], [X6], #2
    ADD  X26, X26, X25, ASR #0
    ST1 { V31.H }[0x2], [X26], X22
    LD1 { V9.H }[0x1], [X26], X22
    ADD  X26, X26, X25, LSR #0
    MOV  X6, X26
    ST1 { V12.S }[0x0], [X6], #4
    MOV  X6, X26
    LD1 { V31.S }[0x2], [X6], #4
    ADD  X26, X26, X25
    ST1 { V8.S }[0x3], [X26], X22
    LD1 { V12.S }[0x2], [X26], X22
    ADD  X26, X26, X25, LSR #0
    MOV  X6, X26
    ST1 { V9.D }[0x1], [X6], #8
    MOV  X6, X26
    LD1 { V8.D }[0x0], [X6], #8
    ADD  X26, X26, X25, LSR #0
    ST1 { V31.D }[0x0], [X26], X22
    LD1 { V6.D }[0x0], [X26], X22
    ADD  X26, X26, X25
    MOV  X6, X26
    ST1 { V12.B }[0x9], [X6], #1
    MOV  X6, X26
    LD1 { V2.B }[0x5], [X6], #1
    ADD  X26, X26, X25, ASR #0
    ST1 { V1.B }[0x8], [X26], X22
    LD1 { V13.B }[0x6], [X26], X22
    ADD  X26, X26, X25, LSR #0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X8, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D0
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    FMOV  X8, D1
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D2
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V3.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D3
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V4.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D4
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V5.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D5
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D6
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D7
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, D8
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D9
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D10
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V11.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D11
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V12.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D12
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V13.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a00, LSL #48
    FMOV  X8, D13
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V14.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D14
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D15
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D16
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D17
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V18.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D18
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V19.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D19
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V20.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D20
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V21.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D21
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V22.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D22
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V23.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D23
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V24.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D24
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V25.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D25
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V26.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D26
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V27.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D27
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V28.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D28
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V29.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D29
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V30.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D30
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, V31.D[1]
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X8, D31
    SUB  X16, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X23
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X22
    FMOV  V3.D[1], X5
    FMOV  D4, X25
    FMOV  V4.D[1], X6
    FMOV  D5, X7
    FMOV  V5.D[1], X27
    FMOV  D6, X21
    FMOV  V6.D[1], X14
    FMOV  D7, X9
    FMOV  V7.D[1], X18
    FMOV  D8, X19
    FMOV  V8.D[1], X22
    FMOV  D9, X5
    FMOV  V9.D[1], X5
    FMOV  D10, X6
    FMOV  V10.D[1], X8
    FMOV  D11, X22
    FMOV  V11.D[1], X3
    FMOV  D12, X4
    FMOV  V12.D[1], X11
    FMOV  D13, X18
    FMOV  V13.D[1], X4
    FMOV  D14, X26
    FMOV  V14.D[1], X13
    FMOV  D15, X21
    FMOV  V15.D[1], X23
    FMOV  D16, X10
    FMOV  V16.D[1], X18
    FMOV  D17, X23
    FMOV  V17.D[1], X9
    FMOV  D18, X19
    FMOV  V18.D[1], X3
    FMOV  D19, X4
    FMOV  V19.D[1], X10
    FMOV  D20, X13
    FMOV  V20.D[1], X4
    FMOV  D21, X20
    FMOV  V21.D[1], X3
    FMOV  D22, X16
    FMOV  V22.D[1], X17
    FMOV  D23, X27
    FMOV  V23.D[1], X18
    FMOV  D24, X15
    FMOV  V24.D[1], X25
    FMOV  D25, X26
    FMOV  V25.D[1], X13
    FMOV  D26, X6
    FMOV  V26.D[1], X16
    FMOV  D27, X8
    FMOV  V27.D[1], X13
    FMOV  D28, X21
    FMOV  V28.D[1], X10
    FMOV  D29, X20
    FMOV  V29.D[1], X8
    FMOV  D30, X2
    FMOV  V30.D[1], X6
    FMOV  D31, X27
    FMOV  V31.D[1], X21
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X18, #0x40, LSL #0
    MOVZ  X17, #0x2300, LSL #0
    ADD  X20, X30, X17, ASR #0
    MOV  X5, X20
    ST1 { V24.16B, V25.16B }, [X5], #32
    MOV  X5, X20
    LD1 { V9.16B, V10.16B }, [X5], #32
    ADD  X20, X20, X18, LSR #0
    MOV  X5, X20
    ST1 { V29.2D, V30.2D }, [X5], #32
    MOV  X5, X20
    LD1 { V27.2D, V28.2D }, [X5], #32
    ADD  X20, X20, X18, LSR #0
    MOV  X5, X20
    ST1 { V9.4S, V10.4S }, [X5], #32
    MOV  X5, X20
    LD1 { V17.4S, V18.4S }, [X5], #32
    ADD  X20, X20, X18
    MOV  X5, X20
    ST1 { V1.8H, V2.8H }, [X5], #32
    MOV  X5, X20
    LD1 { V28.8H, V29.8H }, [X5], #32
    ADD  X20, X20, X18, ASR #0
    MOV  X5, X20
    ST1 { V28.1D, V29.1D }, [X5], #16
    MOV  X5, X20
    LD1 { V1.8B, V2.8B }, [X5], #16
    ADD  X20, X20, X18, ASR #0
    MOV  X5, X20
    ST1 { V17.1D, V18.1D }, [X5], #16
    MOV  X5, X20
    LD1 { V14.1D, V15.1D }, [X5], #16
    ADD  X20, X20, X18
    MOV  X5, X20
    ST1 { V1.2S, V2.2S }, [X5], #16
    MOV  X5, X20
    LD1 { V21.2S, V22.2S }, [X5], #16
    ADD  X20, X20, X18, ASR #0
    MOV  X5, X20
    ST1 { V21.4H, V22.4H }, [X5], #16
    MOV  X5, X20
    LD1 { V5.4H, V6.4H }, [X5], #16
    ADD  X20, X20, X18
    MOV  X5, X20
    ST1 { V20.8B, V21.8B }, [X5], #16
    MOV  X5, X20
    LD1 { V26.8B, V27.8B }, [X5], #16
    ADD  X20, X20, X18, LSR #0
    ST1 { V26.2D, V27.2D }, [X20], X10
    LD1 { V17.2D, V18.2D }, [X20], X10
    ADD  X20, X20, X18
    ST1 { V14.16B, V15.16B }, [X20], X10
    LD1 { V19.16B, V20.16B }, [X20], X10
    ADD  X20, X20, X18, LSR #0
    ST1 { V5.2D, V6.2D }, [X20], X10
    LD1 { V27.2D, V28.2D }, [X20], X10
    ADD  X20, X20, X18
    ST1 { V17.4S, V18.4S }, [X20], X10
    LD1 { V12.4S, V13.4S }, [X20], X10
    ADD  X20, X20, X18, LSR #0
    ST1 { V27.8H, V28.8H }, [X20], X10
    LD1 { V1.8H, V2.8H }, [X20], X10
    ADD  X20, X20, X18, LSR #0
    ST1 { V1.2S, V2.2S }, [X20], X10
    LD1 { V17.2S, V18.2S }, [X20], X10
    ADD  X20, X20, X18, ASR #0
    ST1 { V17.1D, V18.1D }, [X20], X10
    LD1 { V2.1D, V3.1D }, [X20], X10
    ADD  X20, X20, X18
    ST1 { V19.2S, V20.2S }, [X20], X10
    LD1 { V25.2S, V26.2S }, [X20], X10
    ADD  X20, X20, X18, LSR #0
    ST1 { V25.4H, V26.4H }, [X20], X10
    LD1 { V27.4H, V28.4H }, [X20], X10
    ADD  X20, X20, X18, LSR #0
    ST1 { V12.8B, V13.8B }, [X20], X10
    LD1 { V29.8B, V30.8B }, [X20], X10
    ADD  X20, X20, X18, LSR #0
    ST1 { V2.H }[0x2], [X20]
    LD1 { V21.H }[0x0], [X20]
    ADD  X20, X20, X18, ASR #0
    ST1 { V29.S }[0x2], [X20]
    LD1 { V17.S }[0x0], [X20]
    ADD  X20, X20, X18, LSR #0
    ST1 { V3.D }[0x0], [X20]
    LD1 { V29.D }[0x1], [X20]
    ADD  X20, X20, X18, ASR #0
    ST1 { V29.B }[0xb], [X20]
    LD1 { V12.B }[0xf], [X20]
    ADD  X20, X20, X18, LSR #0
    MOV  X5, X20
    ST1 { V17.H }[0x1], [X5], #2
    MOV  X5, X20
    LD1 { V3.H }[0x4], [X5], #2
    ADD  X20, X20, X18, ASR #0
    ST1 { V28.H }[0x0], [X20], X10
    LD1 { V17.H }[0x7], [X20], X10
    ADD  X20, X20, X18, LSR #0
    MOV  X5, X20
    ST1 { V3.S }[0x2], [X5], #4
    MOV  X5, X20
    LD1 { V29.S }[0x2], [X5], #4
    ADD  X20, X20, X18, ASR #0
    ST1 { V21.S }[0x0], [X20], X10
    LD1 { V3.S }[0x2], [X20], X10
    ADD  X20, X20, X18, ASR #0
    MOV  X5, X20
    ST1 { V12.D }[0x1], [X5], #8
    MOV  X5, X20
    LD1 { V21.D }[0x1], [X5], #8
    ADD  X20, X20, X18, LSR #0
    ST1 { V29.D }[0x0], [X20], X10
    LD1 { V1.D }[0x1], [X20], X10
    ADD  X20, X20, X18
    MOV  X5, X20
    ST1 { V1.B }[0x3], [X5], #1
    MOV  X5, X20
    LD1 { V22.B }[0x6], [X5], #1
    ADD  X20, X20, X18, LSR #0
    ST1 { V21.B }[0xc], [X20], X10
    LD1 { V21.B }[0xd], [X20], X10
    ADD  X20, X20, X18, LSR #0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X2, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X2, FPSR
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V0.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D0
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V1.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D1
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D2
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    FMOV  X2, V3.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D3
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V4.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D4
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V5.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D5
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D6
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D7
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D8
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V9.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D9
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V10.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D10
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V11.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D11
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa500, LSL #48
    FMOV  X2, V12.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D12
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D13
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D14
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D15
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V16.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D16
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V17.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D17
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D18
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D19
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V20.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D20
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa500, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D21
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V22.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D22
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V23.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D23
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V24.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D24
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D25
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D26
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D27
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D28
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V29.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D29
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D30
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, V31.D[1]
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X2, D31
    SUB  X14, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X21
    FMOV  D1, X22
    FMOV  V1.D[1], X25
    FMOV  D2, X23
    FMOV  V2.D[1], X27
    FMOV  D3, X5
    FMOV  V3.D[1], X3
    FMOV  D4, X18
    FMOV  V4.D[1], X8
    FMOV  D5, X19
    FMOV  V5.D[1], X19
    FMOV  D6, X17
    FMOV  V6.D[1], X23
    FMOV  D7, X28
    FMOV  V7.D[1], X5
    FMOV  D8, X6
    FMOV  V8.D[1], X23
    FMOV  D9, X26
    FMOV  V9.D[1], X21
    FMOV  D10, X8
    FMOV  V10.D[1], X15
    FMOV  D11, X28
    FMOV  V11.D[1], X19
    FMOV  D12, X21
    FMOV  V12.D[1], X14
    FMOV  D13, X27
    FMOV  V13.D[1], X3
    FMOV  D14, X20
    FMOV  V14.D[1], X25
    FMOV  D15, X8
    FMOV  V15.D[1], X17
    FMOV  D16, X11
    FMOV  V16.D[1], X9
    FMOV  D17, X7
    FMOV  V17.D[1], X11
    FMOV  D18, X16
    FMOV  V18.D[1], X16
    FMOV  D19, X21
    FMOV  V19.D[1], X18
    FMOV  D20, X3
    FMOV  V20.D[1], X14
    FMOV  D21, X19
    FMOV  V21.D[1], X27
    FMOV  D22, X11
    FMOV  V22.D[1], X7
    FMOV  D23, X10
    FMOV  V23.D[1], X13
    FMOV  D24, X8
    FMOV  V24.D[1], X23
    FMOV  D25, X22
    FMOV  V25.D[1], X11
    FMOV  D26, X17
    FMOV  V26.D[1], X4
    FMOV  D27, X8
    FMOV  V27.D[1], X10
    FMOV  D28, X18
    FMOV  V28.D[1], X15
    FMOV  D29, X17
    FMOV  V29.D[1], X13
    FMOV  D30, X8
    FMOV  V30.D[1], X23
    FMOV  D31, X22
    FMOV  V31.D[1], X15
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X6, #0x2800, LSL #0
    ADD  X7, X30, X6, LSR #0
    MOV  X10, X7
    ST1 { V12.16B, V13.16B }, [X10], #32
    MOV  X10, X7
    LD1 { V18.16B, V19.16B }, [X10], #32
    ADD  X7, X7, X2
    MOV  X10, X7
    ST1 { V14.2D, V15.2D }, [X10], #32
    MOV  X10, X7
    LD1 { V30.2D, V31.2D }, [X10], #32
    ADD  X7, X7, X2, ASR #0
    MOV  X10, X7
    ST1 { V21.4S, V22.4S }, [X10], #32
    MOV  X10, X7
    LD1 { V15.4S, V16.4S }, [X10], #32
    ADD  X7, X7, X2
    MOV  X10, X7
    ST1 { V18.8H, V19.8H }, [X10], #32
    MOV  X10, X7
    LD1 { V1.8H, V2.8H }, [X10], #32
    ADD  X7, X7, X2
    MOV  X10, X7
    ST1 { V15.2S, V16.2S }, [X10], #16
    MOV  X10, X7
    LD1 { V26.1D, V27.1D }, [X10], #16
    ADD  X7, X7, X2, LSR #0
    MOV  X10, X7
    ST1 { V7.1D, V8.1D }, [X10], #16
    MOV  X10, X7
    LD1 { V5.1D, V6.1D }, [X10], #16
    ADD  X7, X7, X2, LSR #0
    MOV  X10, X7
    ST1 { V30.2S, V31.2S }, [X10], #16
    MOV  X10, X7
    LD1 { V0.2S, V1.2S }, [X10], #16
    ADD  X7, X7, X2, ASR #0
    MOV  X10, X7
    ST1 { V26.4H, V27.4H }, [X10], #16
    MOV  X10, X7
    LD1 { V26.4H, V27.4H }, [X10], #16
    ADD  X7, X7, X2
    MOV  X10, X7
    ST1 { V11.8B, V12.8B }, [X10], #16
    MOV  X10, X7
    LD1 { V10.8B, V11.8B }, [X10], #16
    ADD  X7, X7, X2
    ST1 { V0.4S, V1.4S }, [X7], X20
    LD1 { V17.4S, V18.4S }, [X7], X20
    ADD  X7, X7, X2, ASR #0
    ST1 { V10.16B, V11.16B }, [X7], X20
    LD1 { V14.16B, V15.16B }, [X7], X20
    ADD  X7, X7, X2, LSR #0
    ST1 { V5.2D, V6.2D }, [X7], X20
    LD1 { V9.2D, V10.2D }, [X7], X20
    ADD  X7, X7, X2, ASR #0
    ST1 { V14.4S, V15.4S }, [X7], X20
    LD1 { V2.4S, V3.4S }, [X7], X20
    ADD  X7, X7, X2, LSR #0
    ST1 { V26.8H, V27.8H }, [X7], X20
    LD1 { V18.8H, V19.8H }, [X7], X20
    ADD  X7, X7, X2, ASR #0
    ST1 { V9.1D, V10.1D }, [X7], X20
    LD1 { V24.1D, V25.1D }, [X7], X20
    ADD  X7, X7, X2
    ST1 { V17.1D, V18.1D }, [X7], X20
    LD1 { V24.1D, V25.1D }, [X7], X20
    ADD  X7, X7, X2, ASR #0
    ST1 { V24.2S, V25.2S }, [X7], X20
    LD1 { V9.2S, V10.2S }, [X7], X20
    ADD  X7, X7, X2, ASR #0
    ST1 { V25.4H, V26.4H }, [X7], X20
    LD1 { V14.4H, V15.4H }, [X7], X20
    ADD  X7, X7, X2, LSR #0
    ST1 { V9.8B, V10.8B }, [X7], X20
    LD1 { V23.8B, V24.8B }, [X7], X20
    ADD  X7, X7, X2
    ST1 { V14.H }[0x0], [X7]
    LD1 { V26.H }[0x6], [X7]
    ADD  X7, X7, X2
    ST1 { V19.S }[0x0], [X7]
    LD1 { V19.S }[0x1], [X7]
    ADD  X7, X7, X2, ASR #0
    ST1 { V3.D }[0x1], [X7]
    LD1 { V18.D }[0x1], [X7]
    ADD  X7, X7, X2, LSR #0
    ST1 { V24.B }[0x7], [X7]
    LD1 { V3.B }[0x4], [X7]
    ADD  X7, X7, X2
    MOV  X10, X7
    ST1 { V15.H }[0x6], [X10], #2
    MOV  X10, X7
    LD1 { V15.H }[0x6], [X10], #2
    ADD  X7, X7, X2
    ST1 { V26.H }[0x2], [X7], X20
    LD1 { V9.H }[0x0], [X7], X20
    ADD  X7, X7, X2, LSR #0
    MOV  X10, X7
    ST1 { V19.S }[0x1], [X10], #4
    MOV  X10, X7
    LD1 { V26.S }[0x1], [X10], #4
    ADD  X7, X7, X2
    ST1 { V3.S }[0x2], [X7], X20
    LD1 { V19.S }[0x3], [X7], X20
    ADD  X7, X7, X2, ASR #0
    MOV  X10, X7
    ST1 { V9.D }[0x1], [X10], #8
    MOV  X10, X7
    LD1 { V9.D }[0x1], [X10], #8
    ADD  X7, X7, X2, ASR #0
    ST1 { V26.D }[0x1], [X7], X20
    LD1 { V1.D }[0x1], [X7], X20
    ADD  X7, X7, X2, ASR #0
    MOV  X10, X7
    ST1 { V19.B }[0xc], [X10], #1
    MOV  X10, X7
    LD1 { V9.B }[0x0], [X10], #1
    ADD  X7, X7, X2, LSR #0
    ST1 { V9.B }[0x8], [X7], X20
    LD1 { V6.B }[0x1], [X7], X20
    ADD  X7, X7, X2, LSR #0
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X9, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D0
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a5a, LSL #32
    FMOV  X9, V1.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D1
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D2
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D3
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V4.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D4
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D5
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D6
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V7.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D7
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D8
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a00, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D9
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D10
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D11
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V12.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D12
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D13
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D14
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D15
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D16
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D17
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D18
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D19
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D20
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D21
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D22
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D23
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D24
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D25
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a5a, LSL #32
    FMOV  X9, V26.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D26
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D27
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D28
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V29.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D29
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D30
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, V31.D[1]
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X9, D31
    SUB  X21, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X22
    FMOV  V2.D[1], X25
    FMOV  D3, X23
    FMOV  V3.D[1], X21
    FMOV  D4, X13
    FMOV  V4.D[1], X20
    FMOV  D5, X15
    FMOV  V5.D[1], X17
    FMOV  D6, X17
    FMOV  V6.D[1], X15
    FMOV  D7, X18
    FMOV  V7.D[1], X9
    FMOV  D8, X14
    FMOV  V8.D[1], X7
    FMOV  D9, X9
    FMOV  V9.D[1], X7
    FMOV  D10, X28
    FMOV  V10.D[1], X10
    FMOV  D11, X18
    FMOV  V11.D[1], X22
    FMOV  D12, X9
    FMOV  V12.D[1], X11
    FMOV  D13, X15
    FMOV  V13.D[1], X13
    FMOV  D14, X9
    FMOV  V14.D[1], X26
    FMOV  D15, X2
    FMOV  V15.D[1], X14
    FMOV  D16, X8
    FMOV  V16.D[1], X23
    FMOV  D17, X2
    FMOV  V17.D[1], X9
    FMOV  D18, X3
    FMOV  V18.D[1], X22
    FMOV  D19, X10
    FMOV  V19.D[1], X10
    FMOV  D20, X28
    FMOV  V20.D[1], X5
    FMOV  D21, X15
    FMOV  V21.D[1], X9
    FMOV  D22, X9
    FMOV  V22.D[1], X19
    FMOV  D23, X11
    FMOV  V23.D[1], X10
    FMOV  D24, X20
    FMOV  V24.D[1], X18
    FMOV  D25, X25
    FMOV  V25.D[1], X9
    FMOV  D26, X9
    FMOV  V26.D[1], X28
    FMOV  D27, X28
    FMOV  V27.D[1], X18
    FMOV  D28, X14
    FMOV  V28.D[1], X14
    FMOV  D29, X17
    FMOV  V29.D[1], X4
    FMOV  D30, X23
    FMOV  V30.D[1], X9
    FMOV  D31, X3
    FMOV  V31.D[1], X3
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X22, #0x2d00, LSL #0
    ADD  X20, X30, X22, ASR #0
    MOV  X15, X20
    ST1 { V8.16B, V9.16B }, [X15], #32
    MOV  X15, X20
    LD1 { V30.16B, V31.16B }, [X15], #32
    ADD  X20, X20, X8
    MOV  X15, X20
    ST1 { V28.2D, V29.2D }, [X15], #32
    MOV  X15, X20
    LD1 { V11.2D, V12.2D }, [X15], #32
    ADD  X20, X20, X8, ASR #0
    MOV  X15, X20
    ST1 { V30.4S, V31.4S }, [X15], #32
    MOV  X15, X20
    LD1 { V14.4S, V15.4S }, [X15], #32
    ADD  X20, X20, X8
    MOV  X15, X20
    ST1 { V11.8H, V12.8H }, [X15], #32
    MOV  X15, X20
    LD1 { V9.8H, V10.8H }, [X15], #32
    ADD  X20, X20, X8, LSR #0
    MOV  X15, X20
    ST1 { V9.1D, V10.1D }, [X15], #16
    MOV  X15, X20
    LD1 { V28.1D, V29.1D }, [X15], #16
    ADD  X20, X20, X8, ASR #0
    MOV  X15, X20
    ST1 { V14.1D, V15.1D }, [X15], #16
    MOV  X15, X20
    LD1 { V25.1D, V26.1D }, [X15], #16
    ADD  X20, X20, X8, LSR #0
    MOV  X15, X20
    ST1 { V28.2S, V29.2S }, [X15], #16
    MOV  X15, X20
    LD1 { V24.2S, V25.2S }, [X15], #16
    ADD  X20, X20, X8, ASR #0
    MOV  X15, X20
    ST1 { V12.4H, V13.4H }, [X15], #16
    MOV  X15, X20
    LD1 { V6.4H, V7.4H }, [X15], #16
    ADD  X20, X20, X8, ASR #0
    MOV  X15, X20
    ST1 { V28.8B, V29.8B }, [X15], #16
    MOV  X15, X20
    LD1 { V10.8B, V11.8B }, [X15], #16
    ADD  X20, X20, X8, ASR #0
    ST1 { V10.8H, V11.8H }, [X20], X16
    LD1 { V18.4S, V19.4S }, [X20], X16
    ADD  X20, X20, X8
    ST1 { V24.16B, V25.16B }, [X20], X16
    LD1 { V13.16B, V14.16B }, [X20], X16
    ADD  X20, X20, X8, LSR #0
    ST1 { V13.2D, V14.2D }, [X20], X16
    LD1 { V28.2D, V29.2D }, [X20], X16
    ADD  X20, X20, X8, LSR #0
    ST1 { V9.4S, V10.4S }, [X20], X16
    LD1 { V17.4S, V18.4S }, [X20], X16
    ADD  X20, X20, X8
    ST1 { V15.8H, V16.8H }, [X20], X16
    LD1 { V9.8H, V10.8H }, [X20], X16
    ADD  X20, X20, X8, LSR #0
    ST1 { V28.1D, V29.1D }, [X20], X16
    LD1 { V14.8B, V15.8B }, [X20], X16
    ADD  X20, X20, X8, ASR #0
    ST1 { V18.1D, V19.1D }, [X20], X16
    LD1 { V22.1D, V23.1D }, [X20], X16
    ADD  X20, X20, X8, LSR #0
    ST1 { V9.2S, V10.2S }, [X20], X16
    LD1 { V2.2S, V3.2S }, [X20], X16
    ADD  X20, X20, X8
    ST1 { V1.4H, V2.4H }, [X20], X16
    LD1 { V29.4H, V30.4H }, [X20], X16
    ADD  X20, X20, X8, LSR #0
    ST1 { V7.8B, V8.8B }, [X20], X16
    LD1 { V24.8B, V25.8B }, [X20], X16
    ADD  X20, X20, X8
    ST1 { V17.H }[0x4], [X20]
    LD1 { V11.H }[0x2], [X20]
    ADD  X20, X20, X8, LSR #0
    ST1 { V10.S }[0x2], [X20]
    LD1 { V10.S }[0x0], [X20]
    ADD  X20, X20, X8, ASR #0
    ST1 { V3.D }[0x0], [X20]
    LD1 { V12.D }[0x0], [X20]
    ADD  X20, X20, X8, ASR #0
    ST1 { V30.B }[0x2], [X20]
    LD1 { V30.B }[0x2], [X20]
    ADD  X20, X20, X8, ASR #0
    MOV  X15, X20
    ST1 { V25.H }[0x0], [X15], #2
    MOV  X15, X20
    LD1 { V14.H }[0x0], [X15], #2
    ADD  X20, X20, X8, ASR #0
    ST1 { V11.H }[0x2], [X20], X16
    LD1 { V15.H }[0x3], [X20], X16
    ADD  X20, X20, X8, ASR #0
    MOV  X15, X20
    ST1 { V10.S }[0x3], [X15], #4
    MOV  X15, X20
    LD1 { V18.S }[0x1], [X15], #4
    ADD  X20, X20, X8
    ST1 { V30.S }[0x0], [X20], X16
    LD1 { V17.S }[0x1], [X20], X16
    ADD  X20, X20, X8, LSR #0
    MOV  X15, X20
    ST1 { V14.D }[0x1], [X15], #8
    MOV  X15, X20
    LD1 { V27.D }[0x1], [X15], #8
    ADD  X20, X20, X8, LSR #0
    ST1 { V15.D }[0x0], [X20], X16
    LD1 { V18.D }[0x1], [X20], X16
    ADD  X20, X20, X8
    MOV  X15, X20
    ST1 { V18.B }[0x6], [X15], #1
    MOV  X15, X20
    LD1 { V16.B }[0x0], [X15], #1
    ADD  X20, X20, X8
    ST1 { V27.B }[0xd], [X20], X16
    LD1 { V31.B }[0x3], [X20], X16
    ADD  X20, X20, X8, ASR #0
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X23, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X23, FPSR
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V0.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D0
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V1.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D1
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D2
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V3.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D3
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V4.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D4
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V5.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D5
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D6
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V7.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D7
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V8.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D8
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V9.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D9
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V10.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D10
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V11.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D11
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V12.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D12
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V13.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D13
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D14
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D15
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V16.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D16
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V17.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D17
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V18.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D18
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D19
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V20.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D20
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V21.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D21
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D22
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D23
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V24.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D24
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D25
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D26
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D27
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V28.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D28
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D29
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D30
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, V31.D[1]
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X23, D31
    SUB  X19, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X19
    FMOV  D3, X27
    FMOV  V3.D[1], X28
    FMOV  D4, X7
    FMOV  V4.D[1], X2
    FMOV  D5, X6
    FMOV  V5.D[1], X20
    FMOV  D6, X6
    FMOV  V6.D[1], X19
    FMOV  D7, X17
    FMOV  V7.D[1], X27
    FMOV  D8, X27
    FMOV  V8.D[1], X16
    FMOV  D9, X15
    FMOV  V9.D[1], X7
    FMOV  D10, X5
    FMOV  V10.D[1], X10
    FMOV  D11, X25
    FMOV  V11.D[1], X22
    FMOV  D12, X2
    FMOV  V12.D[1], X22
    FMOV  D13, X17
    FMOV  V13.D[1], X22
    FMOV  D14, X16
    FMOV  V14.D[1], X13
    FMOV  D15, X23
    FMOV  V15.D[1], X21
    FMOV  D16, X13
    FMOV  V16.D[1], X10
    FMOV  D17, X6
    FMOV  V17.D[1], X2
    FMOV  D18, X13
    FMOV  V18.D[1], X2
    FMOV  D19, X18
    FMOV  V19.D[1], X6
    FMOV  D20, X19
    FMOV  V20.D[1], X25
    FMOV  D21, X26
    FMOV  V21.D[1], X11
    FMOV  D22, X22
    FMOV  V22.D[1], X4
    FMOV  D23, X25
    FMOV  V23.D[1], X26
    FMOV  D24, X25
    FMOV  V24.D[1], X19
    FMOV  D25, X15
    FMOV  V25.D[1], X27
    FMOV  D26, X13
    FMOV  V26.D[1], X15
    FMOV  D27, X19
    FMOV  V27.D[1], X4
    FMOV  D28, X5
    FMOV  V28.D[1], X15
    FMOV  D29, X5
    FMOV  V29.D[1], X14
    FMOV  D30, X6
    FMOV  V30.D[1], X16
    FMOV  D31, X25
    FMOV  V31.D[1], X17
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X25, #0x0, LSL #0
    ADD  X6, X30, X25, LSR #0
    MOV  X21, X6
    ST1 { V7.16B, V8.16B }, [X21], #32
    MOV  X21, X6
    LD1 { V0.16B, V1.16B }, [X21], #32
    ADD  X6, X6, X11, ASR #0
    MOV  X21, X6
    ST1 { V27.2D, V28.2D }, [X21], #32
    MOV  X21, X6
    LD1 { V25.2D, V26.2D }, [X21], #32
    ADD  X6, X6, X11, ASR #0
    MOV  X21, X6
    ST1 { V29.4S, V30.4S }, [X21], #32
    MOV  X21, X6
    LD1 { V6.4S, V7.4S }, [X21], #32
    ADD  X6, X6, X11, LSR #0
    MOV  X21, X6
    ST1 { V0.8H, V1.8H }, [X21], #32
    MOV  X21, X6
    LD1 { V10.8H, V11.8H }, [X21], #32
    ADD  X6, X6, X11, LSR #0
    MOV  X21, X6
    ST1 { V11.1D, V12.1D }, [X21], #16
    MOV  X21, X6
    LD1 { V10.8B, V11.8B }, [X21], #16
    ADD  X6, X6, X11, LSR #0
    MOV  X21, X6
    ST1 { V6.1D, V7.1D }, [X21], #16
    MOV  X21, X6
    LD1 { V24.1D, V25.1D }, [X21], #16
    ADD  X6, X6, X11, ASR #0
    MOV  X21, X6
    ST1 { V24.2S, V25.2S }, [X21], #16
    MOV  X21, X6
    LD1 { V8.2S, V9.2S }, [X21], #16
    ADD  X6, X6, X11, ASR #0
    MOV  X21, X6
    ST1 { V10.4H, V11.4H }, [X21], #16
    MOV  X21, X6
    LD1 { V10.4H, V11.4H }, [X21], #16
    ADD  X6, X6, X11
    MOV  X21, X6
    ST1 { V9.8B, V10.8B }, [X21], #16
    MOV  X21, X6
    LD1 { V14.8B, V15.8B }, [X21], #16
    ADD  X6, X6, X11, LSR #0
    ST1 { V7.8H, V8.8H }, [X6], X27
    LD1 { V16.2D, V17.2D }, [X6], X27
    ADD  X6, X6, X11
    ST1 { V16.16B, V17.16B }, [X6], X27
    LD1 { V13.16B, V14.16B }, [X6], X27
    ADD  X6, X6, X11, ASR #0
    ST1 { V13.2D, V14.2D }, [X6], X27
    LD1 { V30.2D, V31.2D }, [X6], X27
    ADD  X6, X6, X11, ASR #0
    ST1 { V15.4S, V16.4S }, [X6], X27
    LD1 { V2.4S, V3.4S }, [X6], X27
    ADD  X6, X6, X11, LSR #0
    ST1 { V30.8H, V31.8H }, [X6], X27
    LD1 { V2.8H, V3.8H }, [X6], X27
    ADD  X6, X6, X11, LSR #0
    ST1 { V20.4H, V21.4H }, [X6], X27
    LD1 { V24.2S, V25.2S }, [X6], X27
    ADD  X6, X6, X11
    ST1 { V24.1D, V25.1D }, [X6], X27
    LD1 { V9.1D, V10.1D }, [X6], X27
    ADD  X6, X6, X11
    ST1 { V2.2S, V3.2S }, [X6], X27
    LD1 { V2.2S, V3.2S }, [X6], X27
    ADD  X6, X6, X11
    ST1 { V18.4H, V19.4H }, [X6], X27
    LD1 { V30.4H, V31.4H }, [X6], X27
    ADD  X6, X6, X11, LSR #0
    ST1 { V30.8B, V31.8B }, [X6], X27
    LD1 { V20.8B, V21.8B }, [X6], X27
    ADD  X6, X6, X11, ASR #0
    ST1 { V20.H }[0x0], [X6]
    LD1 { V24.H }[0x1], [X6]
    ADD  X6, X6, X11, ASR #0
    ST1 { V0.S }[0x3], [X6]
    LD1 { V0.S }[0x2], [X6]
    ADD  X6, X6, X11, LSR #0
    ST1 { V21.D }[0x0], [X6]
    LD1 { V20.D }[0x1], [X6]
    ADD  X6, X6, X11
    ST1 { V24.B }[0x5], [X6]
    LD1 { V24.B }[0x5], [X6]
    ADD  X6, X6, X11
    MOV  X21, X6
    ST1 { V0.H }[0x0], [X21], #2
    MOV  X21, X6
    LD1 { V30.H }[0x5], [X21], #2
    ADD  X6, X6, X11, LSR #0
    ST1 { V2.H }[0x0], [X6], X27
    LD1 { V21.H }[0x4], [X6], X27
    ADD  X6, X6, X11, LSR #0
    MOV  X21, X6
    ST1 { V30.S }[0x1], [X21], #4
    MOV  X21, X6
    LD1 { V2.S }[0x1], [X21], #4
    ADD  X6, X6, X11
    ST1 { V2.S }[0x2], [X6], X27
    LD1 { V30.S }[0x2], [X6], X27
    ADD  X6, X6, X11, ASR #0
    MOV  X21, X6
    ST1 { V24.D }[0x0], [X21], #8
    MOV  X21, X6
    LD1 { V2.D }[0x1], [X21], #8
    ADD  X6, X6, X11
    ST1 { V21.D }[0x1], [X6], X27
    LD1 { V25.D }[0x1], [X6], X27
    ADD  X6, X6, X11, LSR #0
    MOV  X21, X6
    ST1 { V25.B }[0x4], [X21], #1
    MOV  X21, X6
    LD1 { V9.B }[0xe], [X21], #1
    ADD  X6, X6, X11, ASR #0
    ST1 { V30.B }[0x1], [X6], X27
    LD1 { V24.B }[0x6], [X6], X27
    ADD  X6, X6, X11
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X5, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MRS  X5, FPSR
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V0.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D0
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V1.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D1
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V2.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D2
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V3.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D3
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V4.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D4
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V5.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D5
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V6.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D6
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V7.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D7
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V8.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D8
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a, LSL #48
    FMOV  X5, V9.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D9
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D10
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D11
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V12.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D12
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V13.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D13
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D14
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D15
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V16.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D16
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V17.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D17
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V18.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D18
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V19.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D19
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V20.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D20
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D21
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V22.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D22
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V23.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D23
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V24.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D24
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D25
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V26.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D26
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V27.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D27
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V28.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D28
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, V29.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D29
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D30
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X5, D31
    SUB  X28, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X11
    FMOV  D3, X14
    FMOV  V3.D[1], X7
    FMOV  D4, X28
    FMOV  V4.D[1], X26
    FMOV  D5, X5
    FMOV  V5.D[1], X9
    FMOV  D6, X9
    FMOV  V6.D[1], X16
    FMOV  D7, X2
    FMOV  V7.D[1], X21
    FMOV  D8, X7
    FMOV  V8.D[1], X22
    FMOV  D9, X9
    FMOV  V9.D[1], X9
    FMOV  D10, X25
    FMOV  V10.D[1], X2
    FMOV  D11, X17
    FMOV  V11.D[1], X3
    FMOV  D12, X19
    FMOV  V12.D[1], X11
    FMOV  D13, X19
    FMOV  V13.D[1], X20
    FMOV  D14, X27
    FMOV  V14.D[1], X5
    FMOV  D15, X23
    FMOV  V15.D[1], X20
    FMOV  D16, X17
    FMOV  V16.D[1], X10
    FMOV  D17, X7
    FMOV  V17.D[1], X13
    FMOV  D18, X28
    FMOV  V18.D[1], X17
    FMOV  D19, X23
    FMOV  V19.D[1], X4
    FMOV  D20, X8
    FMOV  V20.D[1], X25
    FMOV  D21, X8
    FMOV  V21.D[1], X16
    FMOV  D22, X4
    FMOV  V22.D[1], X11
    FMOV  D23, X14
    FMOV  V23.D[1], X22
    FMOV  D24, X22
    FMOV  V24.D[1], X13
    FMOV  D25, X7
    FMOV  V25.D[1], X17
    FMOV  D26, X11
    FMOV  V26.D[1], X5
    FMOV  D27, X25
    FMOV  V27.D[1], X9
    FMOV  D28, X26
    FMOV  V28.D[1], X20
    FMOV  D29, X27
    FMOV  V29.D[1], X10
    FMOV  D30, X17
    FMOV  V30.D[1], X9
    FMOV  D31, X21
    FMOV  V31.D[1], X20
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X17, #0x500, LSL #0
    ADD  X11, X30, X17, ASR #0
    MOV  X22, X11
    ST1 { V25.16B, V26.16B }, [X22], #32
    MOV  X22, X11
    LD1 { V19.16B, V20.16B }, [X22], #32
    ADD  X11, X11, X4, ASR #0
    MOV  X22, X11
    ST1 { V17.2D, V18.2D }, [X22], #32
    MOV  X22, X11
    LD1 { V17.2D, V18.2D }, [X22], #32
    ADD  X11, X11, X4
    MOV  X22, X11
    ST1 { V27.4S, V28.4S }, [X22], #32
    MOV  X22, X11
    LD1 { V27.4S, V28.4S }, [X22], #32
    ADD  X11, X11, X4, LSR #0
    MOV  X22, X11
    ST1 { V27.8H, V28.8H }, [X22], #32
    MOV  X22, X11
    LD1 { V29.8H, V30.8H }, [X22], #32
    ADD  X11, X11, X4, ASR #0
    MOV  X22, X11
    ST1 { V18.8B, V19.8B }, [X22], #16
    MOV  X22, X11
    LD1 { V23.8B, V24.8B }, [X22], #16
    ADD  X11, X11, X4
    MOV  X22, X11
    ST1 { V23.1D, V24.1D }, [X22], #16
    MOV  X22, X11
    LD1 { V17.1D, V18.1D }, [X22], #16
    ADD  X11, X11, X4, LSR #0
    MOV  X22, X11
    ST1 { V17.2S, V18.2S }, [X22], #16
    MOV  X22, X11
    LD1 { V19.2S, V20.2S }, [X22], #16
    ADD  X11, X11, X4
    MOV  X22, X11
    ST1 { V19.4H, V20.4H }, [X22], #16
    MOV  X22, X11
    LD1 { V21.4H, V22.4H }, [X22], #16
    ADD  X11, X11, X4
    MOV  X22, X11
    ST1 { V21.8B, V22.8B }, [X22], #16
    MOV  X22, X11
    LD1 { V7.8B, V8.8B }, [X22], #16
    ADD  X11, X11, X4
    ST1 { V7.8H, V8.8H }, [X11], X19
    LD1 { V0.4S, V1.4S }, [X11], X19
    ADD  X11, X11, X4
    ST1 { V0.16B, V1.16B }, [X11], X19
    LD1 { V28.16B, V29.16B }, [X11], X19
    ADD  X11, X11, X4, LSR #0
    ST1 { V28.2D, V29.2D }, [X11], X19
    LD1 { V16.2D, V17.2D }, [X11], X19
    ADD  X11, X11, X4
    ST1 { V12.4S, V13.4S }, [X11], X19
    LD1 { V12.4S, V13.4S }, [X11], X19
    ADD  X11, X11, X4
    ST1 { V11.8H, V12.8H }, [X11], X19
    LD1 { V21.8H, V22.8H }, [X11], X19
    ADD  X11, X11, X4
    ST1 { V31.4H, V0.4H }, [X11], X19
    LD1 { V28.4H, V29.4H }, [X11], X19
    ADD  X11, X11, X4, ASR #0
    ST1 { V22.1D, V23.1D }, [X11], X19
    LD1 { V11.1D, V12.1D }, [X11], X19
    ADD  X11, X11, X4, ASR #0
    ST1 { V10.2S, V11.2S }, [X11], X19
    LD1 { V1.2S, V2.2S }, [X11], X19
    ADD  X11, X11, X4, LSR #0
    ST1 { V16.4H, V17.4H }, [X11], X19
    LD1 { V10.4H, V11.4H }, [X11], X19
    ADD  X11, X11, X4, LSR #0
    ST1 { V28.8B, V29.8B }, [X11], X19
    LD1 { V22.8B, V23.8B }, [X11], X19
    ADD  X11, X11, X4, LSR #0
    ST1 { V11.H }[0x7], [X11]
    LD1 { V31.H }[0x1], [X11]
    ADD  X11, X11, X4, ASR #0
    ST1 { V12.S }[0x2], [X11]
    LD1 { V0.S }[0x2], [X11]
    ADD  X11, X11, X4, ASR #0
    ST1 { V2.D }[0x0], [X11]
    LD1 { V2.D }[0x1], [X11]
    ADD  X11, X11, X4
    ST1 { V1.B }[0xe], [X11]
    LD1 { V1.B }[0x4], [X11]
    ADD  X11, X11, X4
    MOV  X22, X11
    ST1 { V23.H }[0x2], [X22], #2
    MOV  X22, X11
    LD1 { V12.H }[0x5], [X22], #2
    ADD  X11, X11, X4
    ST1 { V1.H }[0x7], [X11], X19
    LD1 { V1.H }[0x6], [X11], X19
    ADD  X11, X11, X4, LSR #0
    MOV  X22, X11
    ST1 { V2.S }[0x2], [X22], #4
    MOV  X22, X11
    LD1 { V23.S }[0x0], [X22], #4
    ADD  X11, X11, X4, LSR #0
    ST1 { V10.S }[0x0], [X11], X19
    LD1 { V10.S }[0x1], [X11], X19
    ADD  X11, X11, X4, LSR #0
    MOV  X22, X11
    ST1 { V0.D }[0x1], [X22], #8
    MOV  X22, X11
    LD1 { V0.D }[0x1], [X22], #8
    ADD  X11, X11, X4
    ST1 { V23.D }[0x0], [X11], X19
    LD1 { V11.D }[0x0], [X11], X19
    ADD  X11, X11, X4, ASR #0
    MOV  X22, X11
    ST1 { V10.B }[0x1], [X22], #1
    MOV  X22, X11
    LD1 { V5.B }[0x7], [X22], #1
    ADD  X11, X11, X4
    ST1 { V0.B }[0x5], [X11], X19
    LD1 { V24.B }[0x4], [X11], X19
    ADD  X11, X11, X4, ASR #0
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X13, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D0
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa500, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D1
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V2.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D2
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V3.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D3
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V4.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D4
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V5.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D5
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V6.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D6
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D7
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D8
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V9.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D9
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D10
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D11
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    FMOV  X13, V12.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D12
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V13.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D13
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V14.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D14
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V15.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D15
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D16
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D17
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D18
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D19
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D20
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V21.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D21
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D22
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D23
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D24
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V25.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D25
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V26.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D26
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V27.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D27
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D28
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D29
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V30.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D30
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, V31.D[1]
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X13, D31
    SUB  X28, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X28
    FMOV  D3, X17
    FMOV  V3.D[1], X8
    FMOV  D4, X2
    FMOV  V4.D[1], X2
    FMOV  D5, X7
    FMOV  V5.D[1], X14
    FMOV  D6, X11
    FMOV  V6.D[1], X15
    FMOV  D7, X14
    FMOV  V7.D[1], X25
    FMOV  D8, X9
    FMOV  V8.D[1], X2
    FMOV  D9, X11
    FMOV  V9.D[1], X28
    FMOV  D10, X3
    FMOV  V10.D[1], X23
    FMOV  D11, X27
    FMOV  V11.D[1], X25
    FMOV  D12, X23
    FMOV  V12.D[1], X5
    FMOV  D13, X2
    FMOV  V13.D[1], X7
    FMOV  D14, X3
    FMOV  V14.D[1], X17
    FMOV  D15, X16
    FMOV  V15.D[1], X22
    FMOV  D16, X6
    FMOV  V16.D[1], X11
    FMOV  D17, X5
    FMOV  V17.D[1], X21
    FMOV  D18, X18
    FMOV  V18.D[1], X17
    FMOV  D19, X16
    FMOV  V19.D[1], X23
    FMOV  D20, X23
    FMOV  V20.D[1], X25
    FMOV  D21, X9
    FMOV  V21.D[1], X28
    FMOV  D22, X13
    FMOV  V22.D[1], X15
    FMOV  D23, X15
    FMOV  V23.D[1], X22
    FMOV  D24, X9
    FMOV  V24.D[1], X9
    FMOV  D25, X15
    FMOV  V25.D[1], X19
    FMOV  D26, X15
    FMOV  V26.D[1], X16
    FMOV  D27, X16
    FMOV  V27.D[1], X13
    FMOV  D28, X11
    FMOV  V28.D[1], X23
    FMOV  D29, X4
    FMOV  V29.D[1], X9
    FMOV  D30, X15
    FMOV  V30.D[1], X11
    FMOV  D31, X10
    FMOV  V31.D[1], X20
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X17, #0xa00, LSL #0
    ADD  X23, X30, X17, ASR #0
    MOV  X15, X23
    ST1 { V3.16B, V4.16B }, [X15], #32
    MOV  X15, X23
    LD1 { V29.16B, V30.16B }, [X15], #32
    ADD  X23, X23, X14
    MOV  X15, X23
    ST1 { V10.2D, V11.2D }, [X15], #32
    MOV  X15, X23
    LD1 { V18.2D, V19.2D }, [X15], #32
    ADD  X23, X23, X14, ASR #0
    MOV  X15, X23
    ST1 { V18.4S, V19.4S }, [X15], #32
    MOV  X15, X23
    LD1 { V13.4S, V14.4S }, [X15], #32
    ADD  X23, X23, X14, ASR #0
    MOV  X15, X23
    ST1 { V13.8H, V14.8H }, [X15], #32
    MOV  X15, X23
    LD1 { V17.8H, V18.8H }, [X15], #32
    ADD  X23, X23, X14, ASR #0
    MOV  X15, X23
    ST1 { V29.4H, V30.4H }, [X15], #16
    MOV  X15, X23
    LD1 { V30.8B, V31.8B }, [X15], #16
    ADD  X23, X23, X14
    MOV  X15, X23
    ST1 { V30.1D, V31.1D }, [X15], #16
    MOV  X15, X23
    LD1 { V11.1D, V12.1D }, [X15], #16
    ADD  X23, X23, X14
    MOV  X15, X23
    ST1 { V11.2S, V12.2S }, [X15], #16
    MOV  X15, X23
    LD1 { V10.2S, V11.2S }, [X15], #16
    ADD  X23, X23, X14
    MOV  X15, X23
    ST1 { V17.4H, V18.4H }, [X15], #16
    MOV  X15, X23
    LD1 { V29.4H, V30.4H }, [X15], #16
    ADD  X23, X23, X14, ASR #0
    MOV  X15, X23
    ST1 { V29.8B, V30.8B }, [X15], #16
    MOV  X15, X23
    LD1 { V0.8B, V1.8B }, [X15], #16
    ADD  X23, X23, X14, LSR #0
    ST1 { V0.4S, V1.4S }, [X23], X21
    LD1 { V30.8H, V31.8H }, [X23], X21
    ADD  X23, X23, X14, LSR #0
    ST1 { V10.16B, V11.16B }, [X23], X21
    LD1 { V11.16B, V12.16B }, [X23], X21
    ADD  X23, X23, X14
    ST1 { V30.2D, V31.2D }, [X23], X21
    LD1 { V3.2D, V4.2D }, [X23], X21
    ADD  X23, X23, X14
    ST1 { V28.4S, V29.4S }, [X23], X21
    LD1 { V26.4S, V27.4S }, [X23], X21
    ADD  X23, X23, X14
    ST1 { V11.8H, V12.8H }, [X23], X21
    LD1 { V5.8H, V6.8H }, [X23], X21
    ADD  X23, X23, X14, LSR #0
    ST1 { V5.8B, V6.8B }, [X23], X21
    LD1 { V25.1D, V26.1D }, [X23], X21
    ADD  X23, X23, X14, LSR #0
    ST1 { V25.1D, V26.1D }, [X23], X21
    LD1 { V17.1D, V18.1D }, [X23], X21
    ADD  X23, X23, X14, LSR #0
    ST1 { V17.2S, V18.2S }, [X23], X21
    LD1 { V25.2S, V26.2S }, [X23], X21
    ADD  X23, X23, X14, ASR #0
    ST1 { V26.4H, V27.4H }, [X23], X21
    LD1 { V26.4H, V27.4H }, [X23], X21
    ADD  X23, X23, X14, ASR #0
    ST1 { V25.8B, V26.8B }, [X23], X21
    LD1 { V5.8B, V6.8B }, [X23], X21
    ADD  X23, X23, X14
    ST1 { V27.H }[0x3], [X23]
    LD1 { V11.H }[0x5], [X23]
    ADD  X23, X23, X14
    ST1 { V5.S }[0x2], [X23]
    LD1 { V18.S }[0x2], [X23]
    ADD  X23, X23, X14, LSR #0
    ST1 { V4.D }[0x0], [X23]
    LD1 { V5.D }[0x1], [X23]
    ADD  X23, X23, X14, LSR #0
    ST1 { V5.B }[0x3], [X23]
    LD1 { V27.B }[0xb], [X23]
    ADD  X23, X23, X14, LSR #0
    MOV  X15, X23
    ST1 { V6.H }[0x2], [X15], #2
    MOV  X15, X23
    LD1 { V5.H }[0x6], [X15], #2
    ADD  X23, X23, X14, LSR #0
    ST1 { V11.H }[0x7], [X23], X21
    LD1 { V6.H }[0x7], [X23], X21
    ADD  X23, X23, X14
    MOV  X15, X23
    ST1 { V27.S }[0x0], [X15], #4
    MOV  X15, X23
    LD1 { V11.S }[0x0], [X15], #4
    ADD  X23, X23, X14, LSR #0
    ST1 { V11.S }[0x0], [X23], X21
    LD1 { V4.S }[0x3], [X23], X21
    ADD  X23, X23, X14, ASR #0
    MOV  X15, X23
    ST1 { V4.D }[0x0], [X15], #8
    MOV  X15, X23
    LD1 { V11.D }[0x0], [X15], #8
    ADD  X23, X23, X14, ASR #0
    ST1 { V5.D }[0x0], [X23], X21
    LD1 { V19.D }[0x1], [X23], X21
    ADD  X23, X23, X14, LSR #0
    MOV  X15, X23
    ST1 { V6.B }[0xf], [X15], #1
    MOV  X15, X23
    LD1 { V9.B }[0x4], [X15], #1
    ADD  X23, X23, X14
    ST1 { V11.B }[0x9], [X23], X21
    LD1 { V21.B }[0x9], [X23], X21
    ADD  X23, X23, X14
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X2, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X2, FPSR
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D0
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D1
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V2.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D2
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D3
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V4.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D4
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D5
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D6
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D7
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D8
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V9.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a00, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D9
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D10
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    FMOV  X2, V11.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D11
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D12
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D13
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V14.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D14
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D15
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V16.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D16
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D17
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D18
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V19.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D19
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D20
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D21
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D22
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V23.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D23
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V24.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D24
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D25
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D26
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a00, LSL #16
    FMOV  X2, V27.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D27
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, V28.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D28
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D29
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V30.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D30
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X2, D31
    SUB  X28, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X23
    FMOV  D2, X25
    FMOV  V2.D[1], X21
    FMOV  D3, X28
    FMOV  V3.D[1], X27
    FMOV  D4, X19
    FMOV  V4.D[1], X7
    FMOV  D5, X20
    FMOV  V5.D[1], X27
    FMOV  D6, X20
    FMOV  V6.D[1], X23
    FMOV  D7, X11
    FMOV  V7.D[1], X4
    FMOV  D8, X25
    FMOV  V8.D[1], X13
    FMOV  D9, X4
    FMOV  V9.D[1], X15
    FMOV  D10, X8
    FMOV  V10.D[1], X25
    FMOV  D11, X28
    FMOV  V11.D[1], X6
    FMOV  D12, X22
    FMOV  V12.D[1], X22
    FMOV  D13, X11
    FMOV  V13.D[1], X27
    FMOV  D14, X9
    FMOV  V14.D[1], X18
    FMOV  D15, X16
    FMOV  V15.D[1], X10
    FMOV  D16, X27
    FMOV  V16.D[1], X6
    FMOV  D17, X26
    FMOV  V17.D[1], X20
    FMOV  D18, X3
    FMOV  V18.D[1], X17
    FMOV  D19, X13
    FMOV  V19.D[1], X11
    FMOV  D20, X4
    FMOV  V20.D[1], X10
    FMOV  D21, X10
    FMOV  V21.D[1], X13
    FMOV  D22, X9
    FMOV  V22.D[1], X10
    FMOV  D23, X23
    FMOV  V23.D[1], X16
    FMOV  D24, X16
    FMOV  V24.D[1], X25
    FMOV  D25, X20
    FMOV  V25.D[1], X11
    FMOV  D26, X17
    FMOV  V26.D[1], X5
    FMOV  D27, X5
    FMOV  V27.D[1], X26
    FMOV  D28, X9
    FMOV  V28.D[1], X22
    FMOV  D29, X6
    FMOV  V29.D[1], X16
    FMOV  D30, X16
    FMOV  V30.D[1], X13
    FMOV  D31, X3
    FMOV  V31.D[1], X14
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X19, #0xf00, LSL #0
    ADD  X22, X30, X19, LSR #0
    MOV  X15, X22
    ST1 { V28.16B, V29.16B }, [X15], #32
    MOV  X15, X22
    LD1 { V11.16B, V12.16B }, [X15], #32
    ADD  X22, X22, X14, ASR #0
    MOV  X15, X22
    ST1 { V11.2D, V12.2D }, [X15], #32
    MOV  X15, X22
    LD1 { V28.2D, V29.2D }, [X15], #32
    ADD  X22, X22, X14, ASR #0
    MOV  X15, X22
    ST1 { V28.4S, V29.4S }, [X15], #32
    MOV  X15, X22
    LD1 { V20.4S, V21.4S }, [X15], #32
    ADD  X22, X22, X14, LSR #0
    MOV  X15, X22
    ST1 { V20.8H, V21.8H }, [X15], #32
    MOV  X15, X22
    LD1 { V4.8H, V5.8H }, [X15], #32
    ADD  X22, X22, X14
    MOV  X15, X22
    ST1 { V4.2S, V5.2S }, [X15], #16
    MOV  X15, X22
    LD1 { V20.4H, V21.4H }, [X15], #16
    ADD  X22, X22, X14
    MOV  X15, X22
    ST1 { V20.1D, V21.1D }, [X15], #16
    MOV  X15, X22
    LD1 { V29.1D, V30.1D }, [X15], #16
    ADD  X22, X22, X14
    MOV  X15, X22
    ST1 { V4.2S, V5.2S }, [X15], #16
    MOV  X15, X22
    LD1 { V20.2S, V21.2S }, [X15], #16
    ADD  X22, X22, X14
    MOV  X15, X22
    ST1 { V16.4H, V17.4H }, [X15], #16
    MOV  X15, X22
    LD1 { V11.4H, V12.4H }, [X15], #16
    ADD  X22, X22, X14, LSR #0
    MOV  X15, X22
    ST1 { V18.8B, V19.8B }, [X15], #16
    MOV  X15, X22
    LD1 { V17.8B, V18.8B }, [X15], #16
    ADD  X22, X22, X14
    ST1 { V10.16B, V11.16B }, [X22], X2
    LD1 { V18.2D, V19.2D }, [X22], X2
    ADD  X22, X22, X14, ASR #0
    ST1 { V11.16B, V12.16B }, [X22], X2
    LD1 { V6.16B, V7.16B }, [X22], X2
    ADD  X22, X22, X14
    ST1 { V23.2D, V24.2D }, [X22], X2
    LD1 { V12.2D, V13.2D }, [X22], X2
    ADD  X22, X22, X14, ASR #0
    ST1 { V6.4S, V7.4S }, [X22], X2
    LD1 { V26.4S, V27.4S }, [X22], X2
    ADD  X22, X22, X14, LSR #0
    ST1 { V26.8H, V27.8H }, [X22], X2
    LD1 { V20.8H, V21.8H }, [X22], X2
    ADD  X22, X22, X14
    ST1 { V19.2S, V20.2S }, [X22], X2
    LD1 { V24.1D, V25.1D }, [X22], X2
    ADD  X22, X22, X14, LSR #0
    ST1 { V24.1D, V25.1D }, [X22], X2
    LD1 { V21.1D, V22.1D }, [X22], X2
    ADD  X22, X22, X14, ASR #0
    ST1 { V21.2S, V22.2S }, [X22], X2
    LD1 { V30.2S, V31.2S }, [X22], X2
    ADD  X22, X22, X14, ASR #0
    ST1 { V12.4H, V13.4H }, [X22], X2
    LD1 { V23.4H, V24.4H }, [X22], X2
    ADD  X22, X22, X14, LSR #0
    ST1 { V23.8B, V24.8B }, [X22], X2
    LD1 { V26.8B, V27.8B }, [X22], X2
    ADD  X22, X22, X14, LSR #0
    ST1 { V26.H }[0x5], [X22]
    LD1 { V20.H }[0x6], [X22]
    ADD  X22, X22, X14
    ST1 { V27.S }[0x0], [X22]
    LD1 { V13.S }[0x2], [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V13.D }[0x1], [X22]
    LD1 { V27.D }[0x1], [X22]
    ADD  X22, X22, X14, LSR #0
    ST1 { V30.B }[0x8], [X22]
    LD1 { V26.B }[0xd], [X22]
    ADD  X22, X22, X14, LSR #0
    MOV  X15, X22
    ST1 { V31.H }[0x2], [X15], #2
    MOV  X15, X22
    LD1 { V13.H }[0x3], [X15], #2
    ADD  X22, X22, X14, LSR #0
    ST1 { V13.H }[0x4], [X22], X2
    LD1 { V13.H }[0x4], [X22], X2
    ADD  X22, X22, X14, ASR #0
    MOV  X15, X22
    ST1 { V20.S }[0x3], [X15], #4
    MOV  X15, X22
    LD1 { V30.S }[0x1], [X15], #4
    ADD  X22, X22, X14
    ST1 { V26.S }[0x2], [X22], X2
    LD1 { V20.S }[0x1], [X22], X2
    ADD  X22, X22, X14, ASR #0
    MOV  X15, X22
    ST1 { V13.D }[0x1], [X15], #8
    MOV  X15, X22
    LD1 { V13.D }[0x0], [X15], #8
    ADD  X22, X22, X14
    ST1 { V20.D }[0x1], [X22], X2
    LD1 { V20.D }[0x1], [X22], X2
    ADD  X22, X22, X14, ASR #0
    MOV  X15, X22
    ST1 { V13.B }[0x4], [X15], #1
    MOV  X15, X22
    LD1 { V6.B }[0x9], [X15], #1
    ADD  X22, X22, X14, ASR #0
    ST1 { V20.B }[0x7], [X22], X2
    LD1 { V27.B }[0xa], [X22], X2
    ADD  X22, X22, X14, LSR #0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X16, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D0
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D1
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V2.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D2
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V3.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D3
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D4
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D5
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa500, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D6
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D7
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D8
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D9
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V10.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D10
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D11
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D12
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V13.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D13
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V14.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D14
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D15
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V16.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D16
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D17
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V18.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D18
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D19
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    FMOV  X16, D20
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D21
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V22.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D22
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D23
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D24
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D25
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D26
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa500, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V27.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D27
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, V28.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D28
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D29
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    FMOV  X16, D30
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X16, D31
    SUB  X25, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X23
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X2
    FMOV  V3.D[1], X5
    FMOV  D4, X10
    FMOV  V4.D[1], X28
    FMOV  D5, X16
    FMOV  V5.D[1], X5
    FMOV  D6, X25
    FMOV  V6.D[1], X27
    FMOV  D7, X13
    FMOV  V7.D[1], X6
    FMOV  D8, X8
    FMOV  V8.D[1], X8
    FMOV  D9, X22
    FMOV  V9.D[1], X21
    FMOV  D10, X5
    FMOV  V10.D[1], X4
    FMOV  D11, X8
    FMOV  V11.D[1], X11
    FMOV  D12, X3
    FMOV  V12.D[1], X6
    FMOV  D13, X7
    FMOV  V13.D[1], X28
    FMOV  D14, X21
    FMOV  V14.D[1], X21
    FMOV  D15, X23
    FMOV  V15.D[1], X20
    FMOV  D16, X19
    FMOV  V16.D[1], X21
    FMOV  D17, X14
    FMOV  V17.D[1], X6
    FMOV  D18, X7
    FMOV  V18.D[1], X15
    FMOV  D19, X5
    FMOV  V19.D[1], X4
    FMOV  D20, X22
    FMOV  V20.D[1], X20
    FMOV  D21, X13
    FMOV  V21.D[1], X4
    FMOV  D22, X14
    FMOV  V22.D[1], X2
    FMOV  D23, X28
    FMOV  V23.D[1], X19
    FMOV  D24, X21
    FMOV  V24.D[1], X16
    FMOV  D25, X10
    FMOV  V25.D[1], X26
    FMOV  D26, X11
    FMOV  V26.D[1], X17
    FMOV  D27, X9
    FMOV  V27.D[1], X7
    FMOV  D28, X21
    FMOV  V28.D[1], X27
    FMOV  D29, X22
    FMOV  V29.D[1], X5
    FMOV  D30, X26
    FMOV  V30.D[1], X4
    FMOV  D31, X3
    FMOV  V31.D[1], X16
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X26, #0x1400, LSL #0
    ADD  X11, X30, X26
    MOV  X27, X11
    ST1 { V23.16B, V24.16B }, [X27], #32
    MOV  X27, X11
    LD1 { V30.16B, V31.16B }, [X27], #32
    ADD  X11, X11, X6
    MOV  X27, X11
    ST1 { V28.2D, V29.2D }, [X27], #32
    MOV  X27, X11
    LD1 { V8.2D, V9.2D }, [X27], #32
    ADD  X11, X11, X6
    MOV  X27, X11
    ST1 { V8.4S, V9.4S }, [X27], #32
    MOV  X27, X11
    LD1 { V3.4S, V4.4S }, [X27], #32
    ADD  X11, X11, X6, ASR #0
    MOV  X27, X11
    ST1 { V3.8H, V4.8H }, [X27], #32
    MOV  X27, X11
    LD1 { V5.8H, V6.8H }, [X27], #32
    ADD  X11, X11, X6
    MOV  X27, X11
    ST1 { V5.4H, V6.4H }, [X27], #16
    MOV  X27, X11
    LD1 { V6.2S, V7.2S }, [X27], #16
    ADD  X11, X11, X6, ASR #0
    MOV  X27, X11
    ST1 { V6.1D, V7.1D }, [X27], #16
    MOV  X27, X11
    LD1 { V18.1D, V19.1D }, [X27], #16
    ADD  X11, X11, X6
    MOV  X27, X11
    ST1 { V18.2S, V19.2S }, [X27], #16
    MOV  X27, X11
    LD1 { V11.2S, V12.2S }, [X27], #16
    ADD  X11, X11, X6
    MOV  X27, X11
    ST1 { V11.4H, V12.4H }, [X27], #16
    MOV  X27, X11
    LD1 { V25.4H, V26.4H }, [X27], #16
    ADD  X11, X11, X6
    MOV  X27, X11
    ST1 { V14.8B, V15.8B }, [X27], #16
    MOV  X27, X11
    LD1 { V1.8B, V2.8B }, [X27], #16
    ADD  X11, X11, X6, LSR #0
    ST1 { V5.16B, V6.16B }, [X11], X23
    LD1 { V26.2D, V27.2D }, [X11], X23
    ADD  X11, X11, X6, ASR #0
    ST1 { V12.16B, V13.16B }, [X11], X23
    LD1 { V12.16B, V13.16B }, [X11], X23
    ADD  X11, X11, X6
    ST1 { V29.2D, V30.2D }, [X11], X23
    LD1 { V0.2D, V1.2D }, [X11], X23
    ADD  X11, X11, X6, LSR #0
    ST1 { V20.4S, V21.4S }, [X11], X23
    LD1 { V31.4S, V0.4S }, [X11], X23
    ADD  X11, X11, X6
    ST1 { V12.8H, V13.8H }, [X11], X23
    LD1 { V5.8H, V6.8H }, [X11], X23
    ADD  X11, X11, X6, LSR #0
    ST1 { V28.1D, V29.1D }, [X11], X23
    LD1 { V0.1D, V1.1D }, [X11], X23
    ADD  X11, X11, X6, ASR #0
    ST1 { V5.1D, V6.1D }, [X11], X23
    LD1 { V19.1D, V20.1D }, [X11], X23
    ADD  X11, X11, X6
    ST1 { V28.2S, V29.2S }, [X11], X23
    LD1 { V7.2S, V8.2S }, [X11], X23
    ADD  X11, X11, X6, LSR #0
    ST1 { V19.4H, V20.4H }, [X11], X23
    LD1 { V27.4H, V28.4H }, [X11], X23
    ADD  X11, X11, X6
    ST1 { V0.8B, V1.8B }, [X11], X23
    LD1 { V7.8B, V8.8B }, [X11], X23
    ADD  X11, X11, X6, LSR #0
    ST1 { V31.H }[0x7], [X11]
    LD1 { V24.H }[0x0], [X11]
    ADD  X11, X11, X6, LSR #0
    ST1 { V7.S }[0x0], [X11]
    LD1 { V24.S }[0x3], [X11]
    ADD  X11, X11, X6
    ST1 { V8.D }[0x0], [X11]
    LD1 { V30.D }[0x1], [X11]
    ADD  X11, X11, X6, LSR #0
    ST1 { V24.B }[0xb], [X11]
    LD1 { V31.B }[0xf], [X11]
    ADD  X11, X11, X6
    MOV  X27, X11
    ST1 { V31.H }[0x3], [X27], #2
    MOV  X27, X11
    LD1 { V30.H }[0x1], [X27], #2
    ADD  X11, X11, X6
    ST1 { V28.H }[0x0], [X11], X23
    LD1 { V23.H }[0x5], [X11], X23
    ADD  X11, X11, X6, ASR #0
    MOV  X27, X11
    ST1 { V30.S }[0x2], [X27], #4
    MOV  X27, X11
    LD1 { V0.S }[0x0], [X27], #4
    ADD  X11, X11, X6
    ST1 { V23.S }[0x2], [X11], X23
    LD1 { V31.S }[0x3], [X11], X23
    ADD  X11, X11, X6
    MOV  X27, X11
    ST1 { V0.D }[0x0], [X27], #8
    MOV  X27, X11
    LD1 { V26.D }[0x1], [X27], #8
    ADD  X11, X11, X6
    ST1 { V15.D }[0x0], [X11], X23
    LD1 { V6.D }[0x1], [X11], X23
    ADD  X11, X11, X6
    MOV  X27, X11
    ST1 { V0.B }[0x2], [X27], #1
    MOV  X27, X11
    LD1 { V11.B }[0x0], [X27], #1
    ADD  X11, X11, X6, LSR #0
    ST1 { V6.B }[0xe], [X11], X23
    LD1 { V12.B }[0x9], [X11], X23
    ADD  X11, X11, X6, ASR #0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D0
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D1
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D2
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V3.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D3
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V4.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D4
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V5.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D5
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D6
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D7
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D8
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D9
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D10
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D11
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a00, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D12
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D13
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V14.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D14
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V15.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D15
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D16
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D17
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D18
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D19
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D20
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V21.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D21
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D22
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D23
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D24
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D25
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D26
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D27
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D28
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V29.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D29
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D30
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X28, D31
    SUB  X4, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X21
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X8
    FMOV  V3.D[1], X19
    FMOV  D4, X20
    FMOV  V4.D[1], X3
    FMOV  D5, X28
    FMOV  V5.D[1], X15
    FMOV  D6, X20
    FMOV  V6.D[1], X28
    FMOV  D7, X9
    FMOV  V7.D[1], X14
    FMOV  D8, X25
    FMOV  V8.D[1], X25
    FMOV  D9, X20
    FMOV  V9.D[1], X23
    FMOV  D10, X2
    FMOV  V10.D[1], X21
    FMOV  D11, X7
    FMOV  V11.D[1], X23
    FMOV  D12, X18
    FMOV  V12.D[1], X23
    FMOV  D13, X26
    FMOV  V13.D[1], X26
    FMOV  D14, X17
    FMOV  V14.D[1], X5
    FMOV  D15, X8
    FMOV  V15.D[1], X3
    FMOV  D16, X10
    FMOV  V16.D[1], X16
    FMOV  D17, X2
    FMOV  V17.D[1], X18
    FMOV  D18, X18
    FMOV  V18.D[1], X26
    FMOV  D19, X28
    FMOV  V19.D[1], X9
    FMOV  D20, X11
    FMOV  V20.D[1], X19
    FMOV  D21, X21
    FMOV  V21.D[1], X8
    FMOV  D22, X28
    FMOV  V22.D[1], X21
    FMOV  D23, X5
    FMOV  V23.D[1], X15
    FMOV  D24, X20
    FMOV  V24.D[1], X28
    FMOV  D25, X16
    FMOV  V25.D[1], X23
    FMOV  D26, X9
    FMOV  V26.D[1], X9
    FMOV  D27, X5
    FMOV  V27.D[1], X25
    FMOV  D28, X27
    FMOV  V28.D[1], X22
    FMOV  D29, X13
    FMOV  V29.D[1], X2
    FMOV  D30, X7
    FMOV  V30.D[1], X15
    FMOV  D31, X22
    FMOV  V31.D[1], X27
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X27, #0x1900, LSL #0
    ADD  X7, X30, X27
    MOV  X19, X7
    ST1 { V24.16B, V25.16B }, [X19], #32
    MOV  X19, X7
    LD1 { V2.16B, V3.16B }, [X19], #32
    ADD  X7, X7, X6, ASR #0
    MOV  X19, X7
    ST1 { V30.2D, V31.2D }, [X19], #32
    MOV  X19, X7
    LD1 { V20.2D, V21.2D }, [X19], #32
    ADD  X7, X7, X6, ASR #0
    MOV  X19, X7
    ST1 { V20.4S, V21.4S }, [X19], #32
    MOV  X19, X7
    LD1 { V29.4S, V30.4S }, [X19], #32
    ADD  X7, X7, X6
    MOV  X19, X7
    ST1 { V29.8H, V30.8H }, [X19], #32
    MOV  X19, X7
    LD1 { V26.8H, V27.8H }, [X19], #32
    ADD  X7, X7, X6
    MOV  X19, X7
    ST1 { V3.8B, V4.8B }, [X19], #16
    MOV  X19, X7
    LD1 { V31.4H, V0.4H }, [X19], #16
    ADD  X7, X7, X6
    MOV  X19, X7
    ST1 { V26.1D, V27.1D }, [X19], #16
    MOV  X19, X7
    LD1 { V23.1D, V24.1D }, [X19], #16
    ADD  X7, X7, X6, LSR #0
    MOV  X19, X7
    ST1 { V23.2S, V24.2S }, [X19], #16
    MOV  X19, X7
    LD1 { V30.2S, V31.2S }, [X19], #16
    ADD  X7, X7, X6, ASR #0
    MOV  X19, X7
    ST1 { V31.4H, V0.4H }, [X19], #16
    MOV  X19, X7
    LD1 { V30.4H, V31.4H }, [X19], #16
    ADD  X7, X7, X6
    MOV  X19, X7
    ST1 { V8.8B, V9.8B }, [X19], #16
    MOV  X19, X7
    LD1 { V8.8B, V9.8B }, [X19], #16
    ADD  X7, X7, X6, LSR #0
    ST1 { V16.2D, V17.2D }, [X7], X9
    LD1 { V19.4S, V20.4S }, [X7], X9
    ADD  X7, X7, X6
    ST1 { V22.16B, V23.16B }, [X7], X9
    LD1 { V26.16B, V27.16B }, [X7], X9
    ADD  X7, X7, X6, ASR #0
    ST1 { V10.2D, V11.2D }, [X7], X9
    LD1 { V10.2D, V11.2D }, [X7], X9
    ADD  X7, X7, X6, LSR #0
    ST1 { V19.4S, V20.4S }, [X7], X9
    LD1 { V30.4S, V31.4S }, [X7], X9
    ADD  X7, X7, X6, LSR #0
    ST1 { V12.8H, V13.8H }, [X7], X9
    LD1 { V15.8H, V16.8H }, [X7], X9
    ADD  X7, X7, X6, LSR #0
    ST1 { V15.4H, V16.4H }, [X7], X9
    LD1 { V31.1D, V0.1D }, [X7], X9
    ADD  X7, X7, X6, ASR #0
    ST1 { V9.1D, V10.1D }, [X7], X9
    LD1 { V4.1D, V5.1D }, [X7], X9
    ADD  X7, X7, X6, LSR #0
    ST1 { V4.2S, V5.2S }, [X7], X9
    LD1 { V13.2S, V14.2S }, [X7], X9
    ADD  X7, X7, X6, ASR #0
    ST1 { V31.4H, V0.4H }, [X7], X9
    LD1 { V20.4H, V21.4H }, [X7], X9
    ADD  X7, X7, X6, LSR #0
    ST1 { V20.8B, V21.8B }, [X7], X9
    LD1 { V31.8B, V0.8B }, [X7], X9
    ADD  X7, X7, X6, LSR #0
    ST1 { V31.H }[0x5], [X7]
    LD1 { V10.H }[0x1], [X7]
    ADD  X7, X7, X6, ASR #0
    ST1 { V0.S }[0x2], [X7]
    LD1 { V21.S }[0x3], [X7]
    ADD  X7, X7, X6, LSR #0
    ST1 { V13.D }[0x1], [X7]
    LD1 { V31.D }[0x1], [X7]
    ADD  X7, X7, X6, LSR #0
    ST1 { V14.B }[0xd], [X7]
    LD1 { V13.B }[0x2], [X7]
    ADD  X7, X7, X6, ASR #0
    MOV  X19, X7
    ST1 { V10.H }[0x7], [X19], #2
    MOV  X19, X7
    LD1 { V0.H }[0x4], [X19], #2
    ADD  X7, X7, X6
    ST1 { V31.H }[0x3], [X7], X9
    LD1 { V10.H }[0x0], [X7], X9
    ADD  X7, X7, X6, LSR #0
    MOV  X19, X7
    ST1 { V13.S }[0x2], [X19], #4
    MOV  X19, X7
    LD1 { V31.S }[0x2], [X19], #4
    ADD  X7, X7, X6
    ST1 { V0.S }[0x0], [X7], X9
    LD1 { V13.S }[0x0], [X7], X9
    ADD  X7, X7, X6, LSR #0
    MOV  X19, X7
    ST1 { V31.D }[0x1], [X19], #8
    MOV  X19, X7
    LD1 { V0.D }[0x1], [X19], #8
    ADD  X7, X7, X6
    ST1 { V21.D }[0x1], [X7], X9
    LD1 { V12.D }[0x1], [X7], X9
    ADD  X7, X7, X6, ASR #0
    MOV  X19, X7
    ST1 { V13.B }[0x1], [X19], #1
    MOV  X19, X7
    LD1 { V8.B }[0xa], [X19], #1
    ADD  X7, X7, X6, ASR #0
    ST1 { V10.B }[0x0], [X7], X9
    LD1 { V29.B }[0x4], [X7], X9
    ADD  X7, X7, X6, ASR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X15, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X15, FPSR
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D0
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V1.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D1
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V2.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D2
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V3.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D3
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D4
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D5
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V6.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D6
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V7.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D7
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa5, LSL #16
    FMOV  X15, V8.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D8
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D9
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V10.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D10
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V11.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D11
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D12
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D13
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D14
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V15.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D15
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V16.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D16
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V17.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D17
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V18.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D18
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V19.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D19
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D20
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V21.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D21
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V22.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D22
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D23
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D24
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V25.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D25
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D26
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D27
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V28.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D28
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V29.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D29
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, V30.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D30
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X15, D31
    SUB  X21, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X21
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X22
    FMOV  V3.D[1], X5
    FMOV  D4, X14
    FMOV  V4.D[1], X27
    FMOV  D5, X4
    FMOV  V5.D[1], X23
    FMOV  D6, X14
    FMOV  V6.D[1], X8
    FMOV  D7, X13
    FMOV  V7.D[1], X21
    FMOV  D8, X8
    FMOV  V8.D[1], X28
    FMOV  D9, X19
    FMOV  V9.D[1], X6
    FMOV  D10, X5
    FMOV  V10.D[1], X22
    FMOV  D11, X6
    FMOV  V11.D[1], X16
    FMOV  D12, X20
    FMOV  V12.D[1], X17
    FMOV  D13, X20
    FMOV  V13.D[1], X3
    FMOV  D14, X11
    FMOV  V14.D[1], X4
    FMOV  D15, X5
    FMOV  V15.D[1], X7
    FMOV  D16, X19
    FMOV  V16.D[1], X14
    FMOV  D17, X18
    FMOV  V17.D[1], X10
    FMOV  D18, X2
    FMOV  V18.D[1], X16
    FMOV  D19, X4
    FMOV  V19.D[1], X2
    FMOV  D20, X18
    FMOV  V20.D[1], X10
    FMOV  D21, X15
    FMOV  V21.D[1], X25
    FMOV  D22, X17
    FMOV  V22.D[1], X21
    FMOV  D23, X22
    FMOV  V23.D[1], X16
    FMOV  D24, X25
    FMOV  V24.D[1], X6
    FMOV  D25, X17
    FMOV  V25.D[1], X25
    FMOV  D26, X3
    FMOV  V26.D[1], X25
    FMOV  D27, X28
    FMOV  V27.D[1], X21
    FMOV  D28, X2
    FMOV  V28.D[1], X20
    FMOV  D29, X8
    FMOV  V29.D[1], X5
    FMOV  D30, X8
    FMOV  V30.D[1], X14
    FMOV  D31, X26
    FMOV  V31.D[1], X28
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X5, #0x1e00, LSL #0
    ADD  X3, X30, X5, ASR #0
    MOV  X17, X3
    ST1 { V24.16B, V25.16B }, [X17], #32
    MOV  X17, X3
    LD1 { V1.16B, V2.16B }, [X17], #32
    ADD  X3, X3, X7, LSR #0
    MOV  X17, X3
    ST1 { V3.2D, V4.2D }, [X17], #32
    MOV  X17, X3
    LD1 { V26.2D, V27.2D }, [X17], #32
    ADD  X3, X3, X7, ASR #0
    MOV  X17, X3
    ST1 { V1.4S, V2.4S }, [X17], #32
    MOV  X17, X3
    LD1 { V27.4S, V28.4S }, [X17], #32
    ADD  X3, X3, X7, LSR #0
    MOV  X17, X3
    ST1 { V30.8H, V31.8H }, [X17], #32
    MOV  X17, X3
    LD1 { V14.8H, V15.8H }, [X17], #32
    ADD  X3, X3, X7, ASR #0
    MOV  X17, X3
    ST1 { V26.2S, V27.2S }, [X17], #16
    MOV  X17, X3
    LD1 { V11.1D, V12.1D }, [X17], #16
    ADD  X3, X3, X7, LSR #0
    MOV  X17, X3
    ST1 { V14.1D, V15.1D }, [X17], #16
    MOV  X17, X3
    LD1 { V28.1D, V29.1D }, [X17], #16
    ADD  X3, X3, X7
    MOV  X17, X3
    ST1 { V28.2S, V29.2S }, [X17], #16
    MOV  X17, X3
    LD1 { V6.2S, V7.2S }, [X17], #16
    ADD  X3, X3, X7
    MOV  X17, X3
    ST1 { V11.4H, V12.4H }, [X17], #16
    MOV  X17, X3
    LD1 { V11.4H, V12.4H }, [X17], #16
    ADD  X3, X3, X7
    MOV  X17, X3
    ST1 { V6.8B, V7.8B }, [X17], #16
    MOV  X17, X3
    LD1 { V29.8B, V30.8B }, [X17], #16
    ADD  X3, X3, X7
    ST1 { V11.2D, V12.2D }, [X3], X25
    LD1 { V14.16B, V15.16B }, [X3], X25
    ADD  X3, X3, X7
    ST1 { V14.16B, V15.16B }, [X3], X25
    LD1 { V22.16B, V23.16B }, [X3], X25
    ADD  X3, X3, X7, LSR #0
    ST1 { V29.2D, V30.2D }, [X3], X25
    LD1 { V11.2D, V12.2D }, [X3], X25
    ADD  X3, X3, X7
    ST1 { V11.4S, V12.4S }, [X3], X25
    LD1 { V18.4S, V19.4S }, [X3], X25
    ADD  X3, X3, X7, ASR #0
    ST1 { V22.8H, V23.8H }, [X3], X25
    LD1 { V22.8H, V23.8H }, [X3], X25
    ADD  X3, X3, X7
    ST1 { V18.2S, V19.2S }, [X3], X25
    LD1 { V4.1D, V5.1D }, [X3], X25
    ADD  X3, X3, X7, ASR #0
    ST1 { V4.1D, V5.1D }, [X3], X25
    LD1 { V10.1D, V11.1D }, [X3], X25
    ADD  X3, X3, X7
    ST1 { V10.2S, V11.2S }, [X3], X25
    LD1 { V1.2S, V2.2S }, [X3], X25
    ADD  X3, X3, X7, ASR #0
    ST1 { V22.4H, V23.4H }, [X3], X25
    LD1 { V22.4H, V23.4H }, [X3], X25
    ADD  X3, X3, X7
    ST1 { V1.8B, V2.8B }, [X3], X25
    LD1 { V18.8B, V19.8B }, [X3], X25
    ADD  X3, X3, X7
    ST1 { V18.H }[0x4], [X3]
    LD1 { V18.H }[0x5], [X3]
    ADD  X3, X3, X7
    ST1 { V18.S }[0x2], [X3]
    LD1 { V10.S }[0x2], [X3]
    ADD  X3, X3, X7, ASR #0
    ST1 { V19.D }[0x0], [X3]
    LD1 { V12.D }[0x1], [X3]
    ADD  X3, X3, X7, ASR #0
    ST1 { V10.B }[0xc], [X3]
    LD1 { V1.B }[0x7], [X3]
    ADD  X3, X3, X7, LSR #0
    MOV  X17, X3
    ST1 { V12.H }[0x6], [X17], #2
    MOV  X17, X3
    LD1 { V19.H }[0x1], [X17], #2
    ADD  X3, X3, X7, LSR #0
    ST1 { V1.H }[0x3], [X3], X25
    LD1 { V18.H }[0x2], [X3], X25
    ADD  X3, X3, X7, LSR #0
    MOV  X17, X3
    ST1 { V18.S }[0x0], [X17], #4
    MOV  X17, X3
    LD1 { V10.S }[0x2], [X17], #4
    ADD  X3, X3, X7
    ST1 { V23.S }[0x2], [X3], X25
    LD1 { V1.S }[0x3], [X3], X25
    ADD  X3, X3, X7, LSR #0
    MOV  X17, X3
    ST1 { V19.D }[0x0], [X17], #8
    MOV  X17, X3
    LD1 { V23.D }[0x1], [X17], #8
    ADD  X3, X3, X7, LSR #0
    ST1 { V1.D }[0x1], [X3], X25
    LD1 { V19.D }[0x1], [X3], X25
    ADD  X3, X3, X7, ASR #0
    MOV  X17, X3
    ST1 { V19.B }[0x3], [X17], #1
    MOV  X17, X3
    LD1 { V12.B }[0x9], [X17], #1
    ADD  X3, X3, X7
    ST1 { V10.B }[0xb], [X3], X25
    LD1 { V1.B }[0xe], [X3], X25
    ADD  X3, X3, X7, LSR #0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X15, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    MRS  X15, FPSR
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V0.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D0
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    MOVK  X26, #0x5a, LSL #48
    FMOV  X15, V1.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a, LSL #48
    FMOV  X15, D1
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D2
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V3.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D3
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D4
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V5.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D5
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D6
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D7
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V8.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D8
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V9.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D9
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    FMOV  X15, V10.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D10
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D11
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V12.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D12
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V13.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D13
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D14
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D15
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V16.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D16
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V17.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D17
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D18
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D19
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V20.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D20
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V21.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D21
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D22
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V23.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D23
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V24.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D24
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V25.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D25
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D26
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V27.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D27
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D28
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D29
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D30
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, V31.D[1]
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    FMOV  X15, D31
    SUB  X4, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X22
    FMOV  D2, X27
    FMOV  V2.D[1], X25
    FMOV  D3, X14
    FMOV  V3.D[1], X14
    FMOV  D4, X25
    FMOV  V4.D[1], X14
    FMOV  D5, X10
    FMOV  V5.D[1], X27
    FMOV  D6, X13
    FMOV  V6.D[1], X9
    FMOV  D7, X19
    FMOV  V7.D[1], X11
    FMOV  D8, X22
    FMOV  V8.D[1], X26
    FMOV  D9, X10
    FMOV  V9.D[1], X6
    FMOV  D10, X14
    FMOV  V10.D[1], X15
    FMOV  D11, X17
    FMOV  V11.D[1], X4
    FMOV  D12, X28
    FMOV  V12.D[1], X8
    FMOV  D13, X19
    FMOV  V13.D[1], X4
    FMOV  D14, X2
    FMOV  V14.D[1], X9
    FMOV  D15, X19
    FMOV  V15.D[1], X5
    FMOV  D16, X27
    FMOV  V16.D[1], X8
    FMOV  D17, X7
    FMOV  V17.D[1], X19
    FMOV  D18, X25
    FMOV  V18.D[1], X2
    FMOV  D19, X20
    FMOV  V19.D[1], X21
    FMOV  D20, X18
    FMOV  V20.D[1], X20
    FMOV  D21, X9
    FMOV  V21.D[1], X11
    FMOV  D22, X20
    FMOV  V22.D[1], X27
    FMOV  D23, X8
    FMOV  V23.D[1], X5
    FMOV  D24, X6
    FMOV  V24.D[1], X4
    FMOV  D25, X2
    FMOV  V25.D[1], X20
    FMOV  D26, X17
    FMOV  V26.D[1], X14
    FMOV  D27, X9
    FMOV  V27.D[1], X22
    FMOV  D28, X28
    FMOV  V28.D[1], X3
    FMOV  D29, X26
    FMOV  V29.D[1], X28
    FMOV  D30, X19
    FMOV  V30.D[1], X10
    FMOV  D31, X25
    FMOV  V31.D[1], X2
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X9, #0x40, LSL #0
    MOVZ  X14, #0x2300, LSL #0
    ADD  X3, X30, X14, LSR #0
    MOV  X8, X3
    ST1 { V27.16B, V28.16B }, [X8], #32
    MOV  X8, X3
    LD1 { V17.16B, V18.16B }, [X8], #32
    ADD  X3, X3, X9
    MOV  X8, X3
    ST1 { V16.2D, V17.2D }, [X8], #32
    MOV  X8, X3
    LD1 { V26.2D, V27.2D }, [X8], #32
    ADD  X3, X3, X9
    MOV  X8, X3
    ST1 { V30.4S, V31.4S }, [X8], #32
    MOV  X8, X3
    LD1 { V8.4S, V9.4S }, [X8], #32
    ADD  X3, X3, X9, LSR #0
    MOV  X8, X3
    ST1 { V0.8H, V1.8H }, [X8], #32
    MOV  X8, X3
    LD1 { V5.8H, V6.8H }, [X8], #32
    ADD  X3, X3, X9, ASR #0
    MOV  X8, X3
    ST1 { V8.4H, V9.4H }, [X8], #16
    MOV  X8, X3
    LD1 { V16.1D, V17.1D }, [X8], #16
    ADD  X3, X3, X9, ASR #0
    MOV  X8, X3
    ST1 { V16.1D, V17.1D }, [X8], #16
    MOV  X8, X3
    LD1 { V11.1D, V12.1D }, [X8], #16
    ADD  X3, X3, X9, LSR #0
    MOV  X8, X3
    ST1 { V5.2S, V6.2S }, [X8], #16
    MOV  X8, X3
    LD1 { V20.2S, V21.2S }, [X8], #16
    ADD  X3, X3, X9, ASR #0
    MOV  X8, X3
    ST1 { V11.4H, V12.4H }, [X8], #16
    MOV  X8, X3
    LD1 { V31.4H, V0.4H }, [X8], #16
    ADD  X3, X3, X9
    MOV  X8, X3
    ST1 { V20.8B, V21.8B }, [X8], #16
    MOV  X8, X3
    LD1 { V4.8B, V5.8B }, [X8], #16
    ADD  X3, X3, X9, LSR #0
    ST1 { V4.4S, V5.4S }, [X3], X5
    LD1 { V8.2D, V9.2D }, [X3], X5
    ADD  X3, X3, X9, LSR #0
    ST1 { V31.16B, V0.16B }, [X3], X5
    LD1 { V11.16B, V12.16B }, [X3], X5
    ADD  X3, X3, X9, ASR #0
    ST1 { V8.2D, V9.2D }, [X3], X5
    LD1 { V18.2D, V19.2D }, [X3], X5
    ADD  X3, X3, X9
    ST1 { V18.4S, V19.4S }, [X3], X5
    LD1 { V18.4S, V19.4S }, [X3], X5
    ADD  X3, X3, X9, LSR #0
    ST1 { V30.8H, V31.8H }, [X3], X5
    LD1 { V15.8H, V16.8H }, [X3], X5
    ADD  X3, X3, X9, ASR #0
    ST1 { V15.2S, V16.2S }, [X3], X5
    LD1 { V16.1D, V17.1D }, [X3], X5
    ADD  X3, X3, X9, ASR #0
    ST1 { V3.1D, V4.1D }, [X3], X5
    LD1 { V23.1D, V24.1D }, [X3], X5
    ADD  X3, X3, X9, ASR #0
    ST1 { V11.2S, V12.2S }, [X3], X5
    LD1 { V1.2S, V2.2S }, [X3], X5
    ADD  X3, X3, X9, LSR #0
    ST1 { V23.4H, V24.4H }, [X3], X5
    LD1 { V11.4H, V12.4H }, [X3], X5
    ADD  X3, X3, X9
    ST1 { V18.8B, V19.8B }, [X3], X5
    LD1 { V30.8B, V31.8B }, [X3], X5
    ADD  X3, X3, X9, ASR #0
    ST1 { V11.H }[0x6], [X3]
    LD1 { V8.H }[0x3], [X3]
    ADD  X3, X3, X9
    ST1 { V17.S }[0x2], [X3]
    LD1 { V3.S }[0x2], [X3]
    ADD  X3, X3, X9, ASR #0
    ST1 { V12.D }[0x0], [X3]
    LD1 { V17.D }[0x0], [X3]
    ADD  X3, X3, X9, LSR #0
    ST1 { V2.B }[0x4], [X3]
    LD1 { V18.B }[0x2], [X3]
    ADD  X3, X3, X9, LSR #0
    MOV  X8, X3
    ST1 { V17.H }[0x0], [X8], #2
    MOV  X8, X3
    LD1 { V19.H }[0x7], [X8], #2
    ADD  X3, X3, X9, LSR #0
    ST1 { V1.H }[0x1], [X3], X5
    LD1 { V2.H }[0x5], [X3], X5
    ADD  X3, X3, X9, ASR #0
    MOV  X8, X3
    ST1 { V2.S }[0x1], [X8], #4
    MOV  X8, X3
    LD1 { V12.S }[0x1], [X8], #4
    ADD  X3, X3, X9, LSR #0
    ST1 { V3.S }[0x1], [X3], X5
    LD1 { V17.S }[0x2], [X3], X5
    ADD  X3, X3, X9, ASR #0
    MOV  X8, X3
    ST1 { V18.D }[0x0], [X8], #8
    MOV  X8, X3
    LD1 { V18.D }[0x0], [X8], #8
    ADD  X3, X3, X9, LSR #0
    ST1 { V12.D }[0x1], [X3], X5
    LD1 { V3.D }[0x1], [X3], X5
    ADD  X3, X3, X9, ASR #0
    MOV  X8, X3
    ST1 { V3.B }[0x8], [X8], #1
    MOV  X8, X3
    LD1 { V12.B }[0x6], [X8], #1
    ADD  X3, X3, X9, LSR #0
    ST1 { V18.B }[0x5], [X3], X5
    LD1 { V3.B }[0x2], [X3], X5
    ADD  X3, X3, X9, LSR #0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X19, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D0
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V1.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D1
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    FMOV  X19, V2.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D2
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V3.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D3
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V4.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D4
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V5.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D5
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D6
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V7.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D7
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    FMOV  X19, D8
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D9
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V10.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D10
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D11
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa500, LSL #48
    FMOV  X19, D12
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V13.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D13
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D14
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V15.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D15
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V16.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D16
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    FMOV  X19, V17.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D17
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V18.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D18
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V19.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D19
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D20
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V21.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D21
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D22
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V23.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D23
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V24.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D24
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V25.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D25
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V26.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D26
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V27.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D27
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V28.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D28
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, V29.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D29
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D30
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X19, D31
    SUB  X22, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X22
    FMOV  V2.D[1], X26
    FMOV  D3, X17
    FMOV  V3.D[1], X26
    FMOV  D4, X23
    FMOV  V4.D[1], X17
    FMOV  D5, X15
    FMOV  V5.D[1], X8
    FMOV  D6, X4
    FMOV  V6.D[1], X23
    FMOV  D7, X11
    FMOV  V7.D[1], X27
    FMOV  D8, X15
    FMOV  V8.D[1], X4
    FMOV  D9, X19
    FMOV  V9.D[1], X2
    FMOV  D10, X16
    FMOV  V10.D[1], X2
    FMOV  D11, X23
    FMOV  V11.D[1], X21
    FMOV  D12, X10
    FMOV  V12.D[1], X22
    FMOV  D13, X13
    FMOV  V13.D[1], X10
    FMOV  D14, X26
    FMOV  V14.D[1], X10
    FMOV  D15, X25
    FMOV  V15.D[1], X19
    FMOV  D16, X17
    FMOV  V16.D[1], X11
    FMOV  D17, X15
    FMOV  V17.D[1], X21
    FMOV  D18, X10
    FMOV  V18.D[1], X27
    FMOV  D19, X25
    FMOV  V19.D[1], X19
    FMOV  D20, X7
    FMOV  V20.D[1], X16
    FMOV  D21, X15
    FMOV  V21.D[1], X15
    FMOV  D22, X7
    FMOV  V22.D[1], X4
    FMOV  D23, X25
    FMOV  V23.D[1], X3
    FMOV  D24, X7
    FMOV  V24.D[1], X15
    FMOV  D25, X18
    FMOV  V25.D[1], X23
    FMOV  D26, X6
    FMOV  V26.D[1], X7
    FMOV  D27, X6
    FMOV  V27.D[1], X27
    FMOV  D28, X2
    FMOV  V28.D[1], X22
    FMOV  D29, X21
    FMOV  V29.D[1], X28
    FMOV  D30, X25
    FMOV  V30.D[1], X22
    FMOV  D31, X22
    FMOV  V31.D[1], X28
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X25, #0x2800, LSL #0
    ADD  X27, X30, X25
    MOV  X7, X27
    ST1 { V2.16B, V3.16B }, [X7], #32
    MOV  X7, X27
    LD1 { V4.16B, V5.16B }, [X7], #32
    ADD  X27, X27, X13, ASR #0
    MOV  X7, X27
    ST1 { V25.2D, V26.2D }, [X7], #32
    MOV  X7, X27
    LD1 { V11.2D, V12.2D }, [X7], #32
    ADD  X27, X27, X13, LSR #0
    MOV  X7, X27
    ST1 { V29.4S, V30.4S }, [X7], #32
    MOV  X7, X27
    LD1 { V21.4S, V22.4S }, [X7], #32
    ADD  X27, X27, X13, ASR #0
    MOV  X7, X27
    ST1 { V21.8H, V22.8H }, [X7], #32
    MOV  X7, X27
    LD1 { V18.8H, V19.8H }, [X7], #32
    ADD  X27, X27, X13
    MOV  X7, X27
    ST1 { V18.1D, V19.1D }, [X7], #16
    MOV  X7, X27
    LD1 { V14.4H, V15.4H }, [X7], #16
    ADD  X27, X27, X13, LSR #0
    MOV  X7, X27
    ST1 { V11.1D, V12.1D }, [X7], #16
    MOV  X7, X27
    LD1 { V20.1D, V21.1D }, [X7], #16
    ADD  X27, X27, X13
    MOV  X7, X27
    ST1 { V20.2S, V21.2S }, [X7], #16
    MOV  X7, X27
    LD1 { V2.2S, V3.2S }, [X7], #16
    ADD  X27, X27, X13, LSR #0
    MOV  X7, X27
    ST1 { V2.4H, V3.4H }, [X7], #16
    MOV  X7, X27
    LD1 { V28.4H, V29.4H }, [X7], #16
    ADD  X27, X27, X13, ASR #0
    MOV  X7, X27
    ST1 { V28.8B, V29.8B }, [X7], #16
    MOV  X7, X27
    LD1 { V9.8B, V10.8B }, [X7], #16
    ADD  X27, X27, X13
    ST1 { V9.8H, V10.8H }, [X27], X10
    LD1 { V29.8H, V30.8H }, [X27], X10
    ADD  X27, X27, X13, LSR #0
    ST1 { V29.16B, V30.16B }, [X27], X10
    LD1 { V2.16B, V3.16B }, [X27], X10
    ADD  X27, X27, X13, LSR #0
    ST1 { V2.2D, V3.2D }, [X27], X10
    LD1 { V16.2D, V17.2D }, [X27], X10
    ADD  X27, X27, X13
    ST1 { V16.4S, V17.4S }, [X27], X10
    LD1 { V22.4S, V23.4S }, [X27], X10
    ADD  X27, X27, X13
    ST1 { V22.8H, V23.8H }, [X27], X10
    LD1 { V29.8H, V30.8H }, [X27], X10
    ADD  X27, X27, X13, ASR #0
    ST1 { V1.8B, V2.8B }, [X27], X10
    LD1 { V5.1D, V6.1D }, [X27], X10
    ADD  X27, X27, X13
    ST1 { V29.1D, V30.1D }, [X27], X10
    LD1 { V1.1D, V2.1D }, [X27], X10
    ADD  X27, X27, X13, ASR #0
    ST1 { V2.2S, V3.2S }, [X27], X10
    LD1 { V16.2S, V17.2S }, [X27], X10
    ADD  X27, X27, X13, LSR #0
    ST1 { V6.4H, V7.4H }, [X27], X10
    LD1 { V22.4H, V23.4H }, [X27], X10
    ADD  X27, X27, X13, ASR #0
    ST1 { V25.8B, V26.8B }, [X27], X10
    LD1 { V6.8B, V7.8B }, [X27], X10
    ADD  X27, X27, X13, LSR #0
    ST1 { V11.H }[0x5], [X27]
    LD1 { V3.H }[0x3], [X27]
    ADD  X27, X27, X13
    ST1 { V17.S }[0x1], [X27]
    LD1 { V2.S }[0x1], [X27]
    ADD  X27, X27, X13
    ST1 { V1.D }[0x0], [X27]
    LD1 { V6.D }[0x1], [X27]
    ADD  X27, X27, X13, ASR #0
    ST1 { V23.B }[0xf], [X27]
    LD1 { V11.B }[0x8], [X27]
    ADD  X27, X27, X13, ASR #0
    MOV  X7, X27
    ST1 { V2.H }[0x0], [X7], #2
    MOV  X7, X27
    LD1 { V2.H }[0x1], [X7], #2
    ADD  X27, X27, X13
    ST1 { V7.H }[0x4], [X27], X10
    LD1 { V26.H }[0x7], [X27], X10
    ADD  X27, X27, X13
    MOV  X7, X27
    ST1 { V2.S }[0x3], [X7], #4
    MOV  X7, X27
    LD1 { V1.S }[0x2], [X7], #4
    ADD  X27, X27, X13
    ST1 { V1.S }[0x0], [X27], X10
    LD1 { V23.S }[0x2], [X27], X10
    ADD  X27, X27, X13, LSR #0
    MOV  X7, X27
    ST1 { V23.D }[0x0], [X7], #8
    MOV  X7, X27
    LD1 { V2.D }[0x1], [X7], #8
    ADD  X27, X27, X13, ASR #0
    ST1 { V2.D }[0x0], [X27], X10
    LD1 { V7.D }[0x1], [X27], X10
    ADD  X27, X27, X13, LSR #0
    MOV  X7, X27
    ST1 { V7.B }[0x0], [X7], #1
    MOV  X7, X27
    LD1 { V1.B }[0x6], [X7], #1
    ADD  X27, X27, X13, LSR #0
    ST1 { V1.B }[0xd], [X27], X10
    LD1 { V23.B }[0x5], [X27], X10
    ADD  X27, X27, X13, ASR #0
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X28, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V0.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D0
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D1
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V2.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D2
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D3
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V4.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D4
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V5.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D5
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D6
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V7.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D7
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V8.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D8
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D9
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V10.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D10
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a00, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D11
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V12.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D12
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D13
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D14
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D15
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D16
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D17
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V18.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D18
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V19.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D19
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D20
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D21
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D22
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X28, V23.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D23
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D24
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D25
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    FMOV  X28, V26.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D26
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D27
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D28
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D29
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D30
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X28, D31
    SUB  X14, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP04_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X22
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X25
    FMOV  D3, X17
    FMOV  V3.D[1], X3
    FMOV  D4, X4
    FMOV  V4.D[1], X18
    FMOV  D5, X26
    FMOV  V5.D[1], X3
    FMOV  D6, X7
    FMOV  V6.D[1], X9
    FMOV  D7, X17
    FMOV  V7.D[1], X3
    FMOV  D8, X19
    FMOV  V8.D[1], X5
    FMOV  D9, X5
    FMOV  V9.D[1], X25
    FMOV  D10, X11
    FMOV  V10.D[1], X2
    FMOV  D11, X11
    FMOV  V11.D[1], X21
    FMOV  D12, X23
    FMOV  V12.D[1], X2
    FMOV  D13, X23
    FMOV  V13.D[1], X23
    FMOV  D14, X9
    FMOV  V14.D[1], X28
    FMOV  D15, X20
    FMOV  V15.D[1], X22
    FMOV  D16, X21
    FMOV  V16.D[1], X28
    FMOV  D17, X7
    FMOV  V17.D[1], X14
    FMOV  D18, X13
    FMOV  V18.D[1], X22
    FMOV  D19, X10
    FMOV  V19.D[1], X2
    FMOV  D20, X13
    FMOV  V20.D[1], X8
    FMOV  D21, X22
    FMOV  V21.D[1], X6
    FMOV  D22, X23
    FMOV  V22.D[1], X19
    FMOV  D23, X10
    FMOV  V23.D[1], X27
    FMOV  D24, X27
    FMOV  V24.D[1], X28
    FMOV  D25, X15
    FMOV  V25.D[1], X5
    FMOV  D26, X18
    FMOV  V26.D[1], X27
    FMOV  D27, X7
    FMOV  V27.D[1], X17
    FMOV  D28, X10
    FMOV  V28.D[1], X3
    FMOV  D29, X11
    FMOV  V29.D[1], X3
    FMOV  D30, X11
    FMOV  V30.D[1], X2
    FMOV  D31, X26
    FMOV  V31.D[1], X21
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X27, #0x2d00, LSL #0
    ADD  X6, X30, X27
    MOV  X19, X6
    ST1 { V24.16B, V25.16B }, [X19], #32
    MOV  X19, X6
    LD1 { V23.16B, V24.16B }, [X19], #32
    ADD  X6, X6, X13, LSR #0
    MOV  X19, X6
    ST1 { V27.2D, V28.2D }, [X19], #32
    MOV  X19, X6
    LD1 { V26.2D, V27.2D }, [X19], #32
    ADD  X6, X6, X13, LSR #0
    MOV  X19, X6
    ST1 { V30.4S, V31.4S }, [X19], #32
    MOV  X19, X6
    LD1 { V20.4S, V21.4S }, [X19], #32
    ADD  X6, X6, X13, LSR #0
    MOV  X19, X6
    ST1 { V20.8H, V21.8H }, [X19], #32
    MOV  X19, X6
    LD1 { V14.8H, V15.8H }, [X19], #32
    ADD  X6, X6, X13, ASR #0
    MOV  X19, X6
    ST1 { V3.1D, V4.1D }, [X19], #16
    MOV  X19, X6
    LD1 { V13.8B, V14.8B }, [X19], #16
    ADD  X6, X6, X13
    MOV  X19, X6
    ST1 { V26.1D, V27.1D }, [X19], #16
    MOV  X19, X6
    LD1 { V10.1D, V11.1D }, [X19], #16
    ADD  X6, X6, X13
    MOV  X19, X6
    ST1 { V10.2S, V11.2S }, [X19], #16
    MOV  X19, X6
    LD1 { V22.2S, V23.2S }, [X19], #16
    ADD  X6, X6, X13
    MOV  X19, X6
    ST1 { V14.4H, V15.4H }, [X19], #16
    MOV  X19, X6
    LD1 { V31.4H, V0.4H }, [X19], #16
    ADD  X6, X6, X13
    MOV  X19, X6
    ST1 { V22.8B, V23.8B }, [X19], #16
    MOV  X19, X6
    LD1 { V30.8B, V31.8B }, [X19], #16
    ADD  X6, X6, X13, ASR #0
    ST1 { V14.2D, V15.2D }, [X6], X11
    LD1 { V14.2D, V15.2D }, [X6], X11
    ADD  X6, X6, X13, ASR #0
    ST1 { V17.16B, V18.16B }, [X6], X11
    LD1 { V5.16B, V6.16B }, [X6], X11
    ADD  X6, X6, X13, ASR #0
    ST1 { V5.2D, V6.2D }, [X6], X11
    LD1 { V18.2D, V19.2D }, [X6], X11
    ADD  X6, X6, X13, ASR #0
    ST1 { V18.4S, V19.4S }, [X6], X11
    LD1 { V13.4S, V14.4S }, [X6], X11
    ADD  X6, X6, X13
    ST1 { V5.8H, V6.8H }, [X6], X11
    LD1 { V11.8H, V12.8H }, [X6], X11
    ADD  X6, X6, X13
    ST1 { V14.1D, V15.1D }, [X6], X11
    LD1 { V9.1D, V10.1D }, [X6], X11
    ADD  X6, X6, X13, LSR #0
    ST1 { V30.1D, V31.1D }, [X6], X11
    LD1 { V9.1D, V10.1D }, [X6], X11
    ADD  X6, X6, X13, LSR #0
    ST1 { V11.2S, V12.2S }, [X6], X11
    LD1 { V14.2S, V15.2S }, [X6], X11
    ADD  X6, X6, X13, ASR #0
    ST1 { V13.4H, V14.4H }, [X6], X11
    LD1 { V7.4H, V8.4H }, [X6], X11
    ADD  X6, X6, X13, LSR #0
    ST1 { V9.8B, V10.8B }, [X6], X11
    LD1 { V5.8B, V6.8B }, [X6], X11
    ADD  X6, X6, X13, ASR #0
    ST1 { V7.H }[0x0], [X6]
    LD1 { V19.H }[0x0], [X6]
    ADD  X6, X6, X13
    ST1 { V19.S }[0x2], [X6]
    LD1 { V7.S }[0x3], [X6]
    ADD  X6, X6, X13
    ST1 { V15.D }[0x0], [X6]
    LD1 { V18.D }[0x1], [X6]
    ADD  X6, X6, X13, LSR #0
    ST1 { V8.B }[0xb], [X6]
    LD1 { V15.B }[0x5], [X6]
    ADD  X6, X6, X13, LSR #0
    MOV  X19, X6
    ST1 { V15.H }[0x3], [X19], #2
    MOV  X19, X6
    LD1 { V15.H }[0x0], [X19], #2
    ADD  X6, X6, X13
    ST1 { V7.H }[0x5], [X6], X11
    LD1 { V19.H }[0x7], [X6], X11
    ADD  X6, X6, X13
    MOV  X19, X6
    ST1 { V15.S }[0x2], [X19], #4
    MOV  X19, X6
    LD1 { V7.S }[0x1], [X19], #4
    ADD  X6, X6, X13, ASR #0
    ST1 { V7.S }[0x0], [X6], X11
    LD1 { V15.S }[0x3], [X6], X11
    ADD  X6, X6, X13, ASR #0
    MOV  X19, X6
    ST1 { V15.D }[0x1], [X19], #8
    MOV  X19, X6
    LD1 { V7.D }[0x1], [X19], #8
    ADD  X6, X6, X13, ASR #0
    ST1 { V19.D }[0x1], [X6], X11
    LD1 { V16.D }[0x0], [X6], X11
    ADD  X6, X6, X13
    MOV  X19, X6
    ST1 { V16.B }[0x5], [X19], #1
    MOV  X19, X6
    LD1 { V5.B }[0x4], [X19], #1
    ADD  X6, X6, X13
    ST1 { V5.B }[0x1], [X6], X11
    LD1 { V28.B }[0x0], [X6], X11
    ADD  X6, X6, X13, LSR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X23, FPSR
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V0.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D0
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V1.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D1
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V2.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D2
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V3.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D3
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V4.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D4
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D5
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D6
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V7.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X23, D7
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D8
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D9
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D10
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V11.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D11
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V12.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D12
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V13.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D13
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D14
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V15.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D15
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V16.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    FMOV  X23, D16
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V17.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D17
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V18.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D18
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    FMOV  X23, V19.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D19
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V20.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D20
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V21.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D21
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D22
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D23
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V24.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D24
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V25.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D25
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V26.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D26
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V27.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D27
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V28.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D28
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V29.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D29
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D30
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D31
    SUB  X3, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP04_TestFail

AdvsimdLoadStoreP04_TestEnd:
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
AdvsimdLoadStoreP04_TestFail:
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
