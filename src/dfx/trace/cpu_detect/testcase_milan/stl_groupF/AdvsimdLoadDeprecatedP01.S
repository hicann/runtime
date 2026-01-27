.global AdvsimdLoadDeprecatedP01

.text
.p2align 4

AdvsimdLoadDeprecatedP01:

AdvsimdLoadDeprecatedP01_TestBegin:
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
    MOVZ  X2, #0x66df, LSL #0
    MOVK  X2, #0x5c80, LSL #16
    MOVK  X2, #0x3101, LSL #32
    MOVK  X2, #0xf18b, LSL #48
    MOVZ  X3, #0x11cf, LSL #0
    MOVK  X3, #0x3f7f, LSL #16
    MOVK  X3, #0x3ec7, LSL #32
    MOVK  X3, #0x684d, LSL #48
    MOVZ  X4, #0x768f, LSL #0
    MOVK  X4, #0xa7fe, LSL #16
    MOVK  X4, #0x50f3, LSL #32
    MOVK  X4, #0x89ad, LSL #48
    MOVZ  X5, #0xfa5a, LSL #0
    MOVK  X5, #0x3ac4, LSL #16
    MOVK  X5, #0x8e70, LSL #32
    MOVK  X5, #0xfab6, LSL #48
    MOVZ  X7, #0x9285, LSL #0
    MOVK  X7, #0xe6b0, LSL #16
    MOVK  X7, #0x2c15, LSL #32
    MOVK  X7, #0xf66a, LSL #48
    MOVZ  X9, #0xe96c, LSL #0
    MOVK  X9, #0x33a0, LSL #16
    MOVK  X9, #0xbb0b, LSL #32
    MOVK  X9, #0x5a4d, LSL #48
    MOVZ  X10, #0x5ba, LSL #0
    MOVK  X10, #0xfbeb, LSL #16
    MOVK  X10, #0xb5c5, LSL #32
    MOVK  X10, #0x53ca, LSL #48
    MOVZ  X11, #0x1db8, LSL #0
    MOVK  X11, #0x9620, LSL #16
    MOVK  X11, #0x4a55, LSL #32
    MOVK  X11, #0xcfd0, LSL #48
    MOVZ  X12, #0x6d58, LSL #0
    MOVK  X12, #0xc8d7, LSL #16
    MOVK  X12, #0x93aa, LSL #32
    MOVK  X12, #0xf92f, LSL #48
    MOVZ  X14, #0xe988, LSL #0
    MOVK  X14, #0xa9f4, LSL #16
    MOVK  X14, #0xdc8f, LSL #32
    MOVK  X14, #0x38ec, LSL #48
    MOVZ  X15, #0x3ac4, LSL #0
    MOVK  X15, #0xa605, LSL #16
    MOVK  X15, #0xd88d, LSL #32
    MOVK  X15, #0x889, LSL #48
    MOVZ  X16, #0x16df, LSL #0
    MOVK  X16, #0x2c43, LSL #16
    MOVK  X16, #0x6ddd, LSL #32
    MOVK  X16, #0xe444, LSL #48
    MOVZ  X17, #0xb4c, LSL #0
    MOVK  X17, #0x1d01, LSL #16
    MOVK  X17, #0xf9da, LSL #32
    MOVK  X17, #0x5f85, LSL #48
    MOVZ  X18, #0x2a84, LSL #0
    MOVK  X18, #0xdf28, LSL #16
    MOVK  X18, #0x6d28, LSL #32
    MOVK  X18, #0xf7f8, LSL #48
    MOVZ  X19, #0x6689, LSL #0
    MOVK  X19, #0x52e3, LSL #16
    MOVK  X19, #0xce8e, LSL #32
    MOVK  X19, #0x461, LSL #48
    MOVZ  X20, #0xb11e, LSL #0
    MOVK  X20, #0x6813, LSL #16
    MOVK  X20, #0x328f, LSL #32
    MOVK  X20, #0x5ab8, LSL #48
    MOVZ  X21, #0xcf86, LSL #0
    MOVK  X21, #0xa71f, LSL #16
    MOVK  X21, #0xab32, LSL #32
    MOVK  X21, #0x51be, LSL #48
    MOVZ  X22, #0x7b83, LSL #0
    MOVK  X22, #0xf1c6, LSL #16
    MOVK  X22, #0x4291, LSL #32
    MOVK  X22, #0x18f5, LSL #48
    MOVZ  X23, #0x3029, LSL #0
    MOVK  X23, #0x2db5, LSL #16
    MOVK  X23, #0x1405, LSL #32
    MOVK  X23, #0xe929, LSL #48
    MOVZ  X24, #0x9a24, LSL #0
    MOVK  X24, #0xb6c, LSL #16
    MOVK  X24, #0x3d78, LSL #32
    MOVK  X24, #0x6e8e, LSL #48
    MOVZ  X26, #0x7a1, LSL #0
    MOVK  X26, #0x3b16, LSL #16
    MOVK  X26, #0xc108, LSL #32
    MOVK  X26, #0x51cf, LSL #48
    MOVZ  X27, #0x2442, LSL #0
    MOVK  X27, #0xcd29, LSL #16
    MOVK  X27, #0x6c65, LSL #32
    MOVK  X27, #0xf375, LSL #48
    MOVZ  X28, #0xff1a, LSL #0
    MOVK  X28, #0xaa8a, LSL #16
    MOVK  X28, #0xb8b1, LSL #32
    MOVK  X28, #0x458b, LSL #48
    MOVZ  X29, #0x55b9, LSL #0
    MOVK  X29, #0x437c, LSL #16
    MOVK  X29, #0x75e0, LSL #32
    MOVK  X29, #0xe8eb, LSL #48
    MOVZ  X9, #0x2b21, LSL #0
    MOVK  X9, #0x9edd, LSL #16
    MOVK  X9, #0xc2cd, LSL #32
    MOVK  X9, #0x4763, LSL #48
    MSR  FPCR, X9
    MOVZ  X9, #0xe03a, LSL #0
    MOVK  X9, #0xcd72, LSL #16
    MOVK  X9, #0x4037, LSL #32
    MOVK  X9, #0x28a7, LSL #48
    MSR  FPSR, X9
    MRS  X3, FPSR
    MOVZ  X16, #0xff60, LSL #0
    MOVK  X16, #0x7ff, LSL #16
    MOVK  X16, #0xffff, LSL #32
    MOVK  X16, #0xffff, LSL #48
    AND  X3, X3, X16
    MOVZ  X16, #0x0, LSL #0
    ORR  X3, X3, X16
    MSR  FPSR, X3
    ISB  SY
    ANDS  X26, X3, #0x7070707070707070
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X7
    FMOV  D3, X16
    FMOV  V3.D[1], X23
    FMOV  D4, X12
    FMOV  V4.D[1], X22
    FMOV  D5, X16
    FMOV  V5.D[1], X3
    FMOV  D6, X29
    FMOV  V6.D[1], X27
    FMOV  D7, X2
    FMOV  V7.D[1], X9
    FMOV  D8, X12
    FMOV  V8.D[1], X2
    FMOV  D9, X9
    FMOV  V9.D[1], X29
    FMOV  D10, X28
    FMOV  V10.D[1], X23
    FMOV  D11, X14
    FMOV  V11.D[1], X16
    FMOV  D12, X16
    FMOV  V12.D[1], X10
    FMOV  D13, X18
    FMOV  V13.D[1], X28
    FMOV  D14, X3
    FMOV  V14.D[1], X2
    FMOV  D15, X9
    FMOV  V15.D[1], X9
    FMOV  D16, X5
    FMOV  V16.D[1], X26
    FMOV  D17, X20
    FMOV  V17.D[1], X18
    FMOV  D18, X5
    FMOV  V18.D[1], X19
    FMOV  D19, X3
    FMOV  V19.D[1], X5
    FMOV  D20, X15
    FMOV  V20.D[1], X18
    FMOV  D21, X28
    FMOV  V21.D[1], X9
    FMOV  D22, X10
    FMOV  V22.D[1], X21
    FMOV  D23, X26
    FMOV  V23.D[1], X12
    FMOV  D24, X21
    FMOV  V24.D[1], X20
    FMOV  D25, X27
    FMOV  V25.D[1], X9
    FMOV  D26, X14
    FMOV  V26.D[1], X9
    FMOV  D27, X14
    FMOV  V27.D[1], X10
    FMOV  D28, X5
    FMOV  V28.D[1], X18
    FMOV  D29, X7
    FMOV  V29.D[1], X21
    FMOV  D30, X12
    FMOV  V30.D[1], X22
    FMOV  D31, X5
    FMOV  V31.D[1], X14
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X17, #0x0, LSL #0
    ADD  X22, X30, X17
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X22]
    LD1R { V6.8H }, [X22]
    ADD  X22, X22, X3, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X22]
    LD1R { V30.16B }, [X22]
    ADD  X22, X22, X3
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X22]
    LD1R { V6.2D }, [X22]
    ADD  X22, X22, X3
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X22]
    LD1R { V5.4S }, [X22]
    ADD  X22, X22, X3, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X22]
    LD1R { V29.8H }, [X22]
    ADD  X22, X22, X3, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X22]
    LD1R { V31.8B }, [X22]
    ADD  X22, X22, X3, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X22]
    LD1R { V20.1D }, [X22]
    ADD  X22, X22, X3
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X22]
    LD1R { V14.2S }, [X22]
    ADD  X22, X22, X3
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X22]
    LD1R { V28.4H }, [X22]
    ADD  X22, X22, X3
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X22]
    LD1R { V10.8B }, [X22]
    ADD  X22, X22, X3, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X22]
    MOV  X29, X22
    LD1R { V23.16B }, [X29], #1
    ADD  X22, X22, X3
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X22]
    MOV  X29, X22
    LD1R { V5.16B }, [X29], #1
    ADD  X22, X22, X3, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X22]
    MOV  X29, X22
    LD1R { V8.8B }, [X29], #1
    ADD  X22, X22, X3
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X22]
    MOV  X29, X22
    LD1R { V28.4H }, [X29], #2
    ADD  X22, X22, X3
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X22]
    MOV  X29, X22
    LD1R { V2.8H }, [X29], #2
    ADD  X22, X22, X3
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X22]
    MOV  X29, X22
    LD1R { V10.2S }, [X29], #4
    ADD  X22, X22, X3, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X22]
    MOV  X29, X22
    LD1R { V14.2S }, [X29], #4
    ADD  X22, X22, X3
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X22]
    MOV  X29, X22
    LD1R { V11.4S }, [X29], #4
    ADD  X22, X22, X3
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X22]
    MOV  X29, X22
    LD1R { V13.1D }, [X29], #8
    ADD  X22, X22, X3, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X22]
    MOV  X29, X22
    LD1R { V2.1D }, [X29], #8
    ADD  X22, X22, X3
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X22]
    MOV  X29, X22
    LD1R { V4.2D }, [X29], #8
    ADD  X22, X22, X3, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X22]
    MOV  X29, X22
    LD1R { V13.8H }, [X29], #2
    ADD  X22, X22, X3, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X22]
    LD1R { V12.16B }, [X22], X26
    ADD  X22, X22, X3, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X22]
    LD1R { V20.16B }, [X22], X26
    ADD  X22, X22, X3
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X22]
    LD1R { V22.2D }, [X22], X26
    ADD  X22, X22, X3, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X22]
    LD1R { V19.4S }, [X22], X26
    ADD  X22, X22, X3
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X22]
    LD1R { V19.8H }, [X22], X26
    ADD  X22, X22, X3
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X22]
    LD1R { V0.8B }, [X22], X26
    ADD  X22, X22, X3, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X22]
    LD1R { V4.1D }, [X22], X26
    ADD  X22, X22, X3
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X22]
    LD1R { V16.2S }, [X22], X26
    ADD  X22, X22, X3, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X22]
    LD1R { V11.4H }, [X22], X26
    ADD  X22, X22, X3, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X22]
    LD1R { V26.8B }, [X22], X26
    ADD  X22, X22, X3
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X4, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X4, FPSR
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D0
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V1.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D1
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D2
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D3
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D4
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V5.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D5
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D6
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V7.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D7
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D8
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V9.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D9
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D10
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D11
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D12
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V13.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D13
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D14
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D15
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V16.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D16
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V17.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D17
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D18
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V19.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D19
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D20
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V21.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D21
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D22
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V23.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D23
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V24.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D24
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V25.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D25
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D26
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V27.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D27
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V28.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D28
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V29.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D29
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, V30.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D30
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X4, D31
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X16
    FMOV  D3, X23
    FMOV  V3.D[1], X4
    FMOV  D4, X20
    FMOV  V4.D[1], X15
    FMOV  D5, X22
    FMOV  V5.D[1], X12
    FMOV  D6, X22
    FMOV  V6.D[1], X11
    FMOV  D7, X22
    FMOV  V7.D[1], X3
    FMOV  D8, X19
    FMOV  V8.D[1], X18
    FMOV  D9, X4
    FMOV  V9.D[1], X18
    FMOV  D10, X22
    FMOV  V10.D[1], X24
    FMOV  D11, X2
    FMOV  V11.D[1], X22
    FMOV  D12, X14
    FMOV  V12.D[1], X9
    FMOV  D13, X12
    FMOV  V13.D[1], X19
    FMOV  D14, X16
    FMOV  V14.D[1], X7
    FMOV  D15, X11
    FMOV  V15.D[1], X2
    FMOV  D16, X3
    FMOV  V16.D[1], X22
    FMOV  D17, X27
    FMOV  V17.D[1], X11
    FMOV  D18, X17
    FMOV  V18.D[1], X12
    FMOV  D19, X17
    FMOV  V19.D[1], X4
    FMOV  D20, X29
    FMOV  V20.D[1], X11
    FMOV  D21, X2
    FMOV  V21.D[1], X4
    FMOV  D22, X18
    FMOV  V22.D[1], X4
    FMOV  D23, X18
    FMOV  V23.D[1], X14
    FMOV  D24, X27
    FMOV  V24.D[1], X4
    FMOV  D25, X16
    FMOV  V25.D[1], X15
    FMOV  D26, X9
    FMOV  V26.D[1], X18
    FMOV  D27, X12
    FMOV  V27.D[1], X27
    FMOV  D28, X22
    FMOV  V28.D[1], X15
    FMOV  D29, X28
    FMOV  V29.D[1], X2
    FMOV  D30, X17
    FMOV  V30.D[1], X14
    FMOV  D31, X28
    FMOV  V31.D[1], X18
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X2, #0x500, LSL #0
    ADD  X4, X30, X2, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X4]
    LD1R { V31.8H }, [X4]
    ADD  X4, X4, X17
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X4]
    LD1R { V12.16B }, [X4]
    ADD  X4, X4, X17, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X4]
    LD1R { V31.2D }, [X4]
    ADD  X4, X4, X17
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X4]
    LD1R { V22.4S }, [X4]
    ADD  X4, X4, X17, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X4]
    LD1R { V15.8H }, [X4]
    ADD  X4, X4, X17, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X4]
    LD1R { V17.4H }, [X4]
    ADD  X4, X4, X17, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X4]
    LD1R { V13.1D }, [X4]
    ADD  X4, X4, X17, ASR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X4]
    LD1R { V3.2S }, [X4]
    ADD  X4, X4, X17
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X4]
    LD1R { V1.4H }, [X4]
    ADD  X4, X4, X17, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X4]
    LD1R { V20.8B }, [X4]
    ADD  X4, X4, X17
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X4]
    MOV  X23, X4
    LD1R { V21.16B }, [X23], #1
    ADD  X4, X4, X17, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X4]
    MOV  X23, X4
    LD1R { V10.16B }, [X23], #1
    ADD  X4, X4, X17, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X4]
    MOV  X23, X4
    LD1R { V19.8B }, [X23], #1
    ADD  X4, X4, X17, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X4]
    MOV  X23, X4
    LD1R { V6.4H }, [X23], #2
    ADD  X4, X4, X17, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X4]
    MOV  X23, X4
    LD1R { V31.8H }, [X23], #2
    ADD  X4, X4, X17, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X4]
    MOV  X23, X4
    LD1R { V10.2S }, [X23], #4
    ADD  X4, X4, X17, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X4]
    MOV  X23, X4
    LD1R { V19.2S }, [X23], #4
    ADD  X4, X4, X17, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X4]
    MOV  X23, X4
    LD1R { V29.4S }, [X23], #4
    ADD  X4, X4, X17, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X4]
    MOV  X23, X4
    LD1R { V31.1D }, [X23], #8
    ADD  X4, X4, X17, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X4]
    MOV  X23, X4
    LD1R { V22.1D }, [X23], #8
    ADD  X4, X4, X17, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X4]
    MOV  X23, X4
    LD1R { V15.2D }, [X23], #8
    ADD  X4, X4, X17, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X4]
    MOV  X23, X4
    LD1R { V14.8H }, [X23], #2
    ADD  X4, X4, X17
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X4]
    LD1R { V12.4S }, [X4], X15
    ADD  X4, X4, X17, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X4]
    LD1R { V0.16B }, [X4], X15
    ADD  X4, X4, X17, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X4]
    LD1R { V0.2D }, [X4], X15
    ADD  X4, X4, X17, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X4]
    LD1R { V2.4S }, [X4], X15
    ADD  X4, X4, X17, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X4]
    LD1R { V0.8H }, [X4], X15
    ADD  X4, X4, X17
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X4]
    LD1R { V24.2S }, [X4], X15
    ADD  X4, X4, X17
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X4]
    LD1R { V10.1D }, [X4], X15
    ADD  X4, X4, X17, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X4]
    LD1R { V29.2S }, [X4], X15
    ADD  X4, X4, X17
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X4]
    LD1R { V23.4H }, [X4], X15
    ADD  X4, X4, X17
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X4]
    LD1R { V22.8B }, [X4], X15
    ADD  X4, X4, X17
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X29, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    MRS  X29, FPSR
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V0.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D0
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D1
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V2.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D2
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D3
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V4.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D4
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V5.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D5
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D6
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V7.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D7
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V8.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D8
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V9.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D9
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D10
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V11.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D11
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V12.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D12
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D13
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V14.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D14
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V15.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D15
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V16.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D16
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D17
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V18.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D18
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D19
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D20
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V21.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D21
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D22
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D23
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D24
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V25.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D25
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V26.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D26
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V27.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D27
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V28.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D28
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D29
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, V30.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D30
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X29, D31
    SUB  X27, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X2
    FMOV  V2.D[1], X10
    FMOV  D3, X28
    FMOV  V3.D[1], X15
    FMOV  D4, X20
    FMOV  V4.D[1], X27
    FMOV  D5, X3
    FMOV  V5.D[1], X12
    FMOV  D6, X18
    FMOV  V6.D[1], X28
    FMOV  D7, X28
    FMOV  V7.D[1], X22
    FMOV  D8, X5
    FMOV  V8.D[1], X20
    FMOV  D9, X17
    FMOV  V9.D[1], X21
    FMOV  D10, X18
    FMOV  V10.D[1], X17
    FMOV  D11, X3
    FMOV  V11.D[1], X15
    FMOV  D12, X18
    FMOV  V12.D[1], X7
    FMOV  D13, X5
    FMOV  V13.D[1], X12
    FMOV  D14, X16
    FMOV  V14.D[1], X18
    FMOV  D15, X14
    FMOV  V15.D[1], X28
    FMOV  D16, X18
    FMOV  V16.D[1], X21
    FMOV  D17, X28
    FMOV  V17.D[1], X28
    FMOV  D18, X3
    FMOV  V18.D[1], X3
    FMOV  D19, X12
    FMOV  V19.D[1], X18
    FMOV  D20, X24
    FMOV  V20.D[1], X23
    FMOV  D21, X2
    FMOV  V21.D[1], X18
    FMOV  D22, X27
    FMOV  V22.D[1], X14
    FMOV  D23, X2
    FMOV  V23.D[1], X14
    FMOV  D24, X2
    FMOV  V24.D[1], X21
    FMOV  D25, X2
    FMOV  V25.D[1], X20
    FMOV  D26, X14
    FMOV  V26.D[1], X27
    FMOV  D27, X20
    FMOV  V27.D[1], X12
    FMOV  D28, X22
    FMOV  V28.D[1], X26
    FMOV  D29, X26
    FMOV  V29.D[1], X24
    FMOV  D30, X14
    FMOV  V30.D[1], X22
    FMOV  D31, X7
    FMOV  V31.D[1], X4
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X18, #0xa00, LSL #0
    ADD  X20, X30, X18, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X20]
    LD1R { V0.16B }, [X20]
    ADD  X20, X20, X3
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X20]
    LD1R { V6.16B }, [X20]
    ADD  X20, X20, X3, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X20]
    LD1R { V7.2D }, [X20]
    ADD  X20, X20, X3, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X20]
    LD1R { V16.4S }, [X20]
    ADD  X20, X20, X3, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X20]
    LD1R { V24.8H }, [X20]
    ADD  X20, X20, X3, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X20]
    LD1R { V28.8B }, [X20]
    ADD  X20, X20, X3, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X20]
    LD1R { V30.1D }, [X20]
    ADD  X20, X20, X3, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X20]
    LD1R { V6.2S }, [X20]
    ADD  X20, X20, X3, ASR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X20]
    LD1R { V21.4H }, [X20]
    ADD  X20, X20, X3, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X20]
    LD1R { V28.8B }, [X20]
    ADD  X20, X20, X3, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X20]
    MOV  X11, X20
    LD1R { V5.16B }, [X11], #1
    ADD  X20, X20, X3, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X20]
    MOV  X11, X20
    LD1R { V11.16B }, [X11], #1
    ADD  X20, X20, X3
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X20]
    MOV  X11, X20
    LD1R { V17.8B }, [X11], #1
    ADD  X20, X20, X3, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X20]
    MOV  X11, X20
    LD1R { V16.4H }, [X11], #2
    ADD  X20, X20, X3
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X20]
    MOV  X11, X20
    LD1R { V9.8H }, [X11], #2
    ADD  X20, X20, X3, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X20]
    MOV  X11, X20
    LD1R { V14.4S }, [X11], #4
    ADD  X20, X20, X3, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X20]
    MOV  X11, X20
    LD1R { V7.2S }, [X11], #4
    ADD  X20, X20, X3, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X20]
    MOV  X11, X20
    LD1R { V30.4S }, [X11], #4
    ADD  X20, X20, X3, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X20]
    MOV  X11, X20
    LD1R { V17.1D }, [X11], #8
    ADD  X20, X20, X3, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X20]
    MOV  X11, X20
    LD1R { V28.1D }, [X11], #8
    ADD  X20, X20, X3, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X20]
    MOV  X11, X20
    LD1R { V31.2D }, [X11], #8
    ADD  X20, X20, X3, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X20]
    MOV  X11, X20
    LD1R { V24.4H }, [X11], #2
    ADD  X20, X20, X3, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X20]
    LD1R { V5.2D }, [X20], X12
    ADD  X20, X20, X3
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X20]
    LD1R { V28.16B }, [X20], X12
    ADD  X20, X20, X3, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X20]
    LD1R { V26.2D }, [X20], X12
    ADD  X20, X20, X3
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X20]
    LD1R { V1.4S }, [X20], X12
    ADD  X20, X20, X3, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X20]
    LD1R { V31.8H }, [X20], X12
    ADD  X20, X20, X3, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X20]
    LD1R { V11.8B }, [X20], X12
    ADD  X20, X20, X3, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X20]
    LD1R { V3.1D }, [X20], X12
    ADD  X20, X20, X3
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X20]
    LD1R { V12.2S }, [X20], X12
    ADD  X20, X20, X3, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X20]
    LD1R { V13.4H }, [X20], X12
    ADD  X20, X20, X3, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X20]
    LD1R { V27.8B }, [X20], X12
    ADD  X20, X20, X3, LSR #0
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D0
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D1
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V2.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D2
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D3
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D4
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D5
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D6
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D7
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D8
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D9
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V10.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D10
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D11
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D12
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D13
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V14.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D14
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D15
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D16
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D17
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V18.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D18
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V19.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D19
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V20.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D20
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D21
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D22
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V23.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D23
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D24
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V25.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D25
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V26.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D26
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D27
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V28.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D28
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V29.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D29
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V30.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D30
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V31.D[1]
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D31
    SUB  X7, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X7
    FMOV  D3, X24
    FMOV  V3.D[1], X20
    FMOV  D4, X19
    FMOV  V4.D[1], X17
    FMOV  D5, X29
    FMOV  V5.D[1], X2
    FMOV  D6, X20
    FMOV  V6.D[1], X2
    FMOV  D7, X16
    FMOV  V7.D[1], X22
    FMOV  D8, X9
    FMOV  V8.D[1], X26
    FMOV  D9, X26
    FMOV  V9.D[1], X17
    FMOV  D10, X28
    FMOV  V10.D[1], X11
    FMOV  D11, X2
    FMOV  V11.D[1], X28
    FMOV  D12, X24
    FMOV  V12.D[1], X23
    FMOV  D13, X29
    FMOV  V13.D[1], X23
    FMOV  D14, X10
    FMOV  V14.D[1], X27
    FMOV  D15, X16
    FMOV  V15.D[1], X16
    FMOV  D16, X16
    FMOV  V16.D[1], X10
    FMOV  D17, X26
    FMOV  V17.D[1], X7
    FMOV  D18, X24
    FMOV  V18.D[1], X12
    FMOV  D19, X10
    FMOV  V19.D[1], X10
    FMOV  D20, X5
    FMOV  V20.D[1], X24
    FMOV  D21, X19
    FMOV  V21.D[1], X20
    FMOV  D22, X11
    FMOV  V22.D[1], X19
    FMOV  D23, X4
    FMOV  V23.D[1], X28
    FMOV  D24, X4
    FMOV  V24.D[1], X22
    FMOV  D25, X20
    FMOV  V25.D[1], X23
    FMOV  D26, X7
    FMOV  V26.D[1], X22
    FMOV  D27, X12
    FMOV  V27.D[1], X16
    FMOV  D28, X9
    FMOV  V28.D[1], X28
    FMOV  D29, X7
    FMOV  V29.D[1], X4
    FMOV  D30, X18
    FMOV  V30.D[1], X27
    FMOV  D31, X27
    FMOV  V31.D[1], X17
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X26, #0xf00, LSL #0
    ADD  X2, X30, X26, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X2]
    LD1R { V19.8H }, [X2]
    ADD  X2, X2, X19, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X2]
    LD1R { V8.16B }, [X2]
    ADD  X2, X2, X19, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X2]
    LD1R { V24.2D }, [X2]
    ADD  X2, X2, X19, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X2]
    LD1R { V26.4S }, [X2]
    ADD  X2, X2, X19, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X2]
    LD1R { V8.8H }, [X2]
    ADD  X2, X2, X19, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X2]
    LD1R { V15.1D }, [X2]
    ADD  X2, X2, X19, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X2]
    LD1R { V16.1D }, [X2]
    ADD  X2, X2, X19, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X2]
    LD1R { V0.2S }, [X2]
    ADD  X2, X2, X19, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X2]
    LD1R { V10.4H }, [X2]
    ADD  X2, X2, X19
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X2]
    LD1R { V31.8B }, [X2]
    ADD  X2, X2, X19, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X2]
    MOV  X17, X2
    LD1R { V21.16B }, [X17], #1
    ADD  X2, X2, X19, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X2]
    MOV  X17, X2
    LD1R { V15.16B }, [X17], #1
    ADD  X2, X2, X19, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X2]
    MOV  X17, X2
    LD1R { V25.8B }, [X17], #1
    ADD  X2, X2, X19
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X2]
    MOV  X17, X2
    LD1R { V3.4H }, [X17], #2
    ADD  X2, X2, X19, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X2]
    MOV  X17, X2
    LD1R { V4.8H }, [X17], #2
    ADD  X2, X2, X19
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X2]
    MOV  X17, X2
    LD1R { V13.2S }, [X17], #4
    ADD  X2, X2, X19
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X2]
    MOV  X17, X2
    LD1R { V2.2S }, [X17], #4
    ADD  X2, X2, X19
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X2]
    MOV  X17, X2
    LD1R { V8.4S }, [X17], #4
    ADD  X2, X2, X19
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X2]
    MOV  X17, X2
    LD1R { V9.2D }, [X17], #8
    ADD  X2, X2, X19
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X2]
    MOV  X17, X2
    LD1R { V3.1D }, [X17], #8
    ADD  X2, X2, X19
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X2]
    MOV  X17, X2
    LD1R { V11.2D }, [X17], #8
    ADD  X2, X2, X19, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X2]
    MOV  X17, X2
    LD1R { V4.8H }, [X17], #2
    ADD  X2, X2, X19, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X2]
    LD1R { V2.2D }, [X2], X15
    ADD  X2, X2, X19
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X2]
    LD1R { V24.16B }, [X2], X15
    ADD  X2, X2, X19, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X2]
    LD1R { V6.2D }, [X2], X15
    ADD  X2, X2, X19, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X2]
    LD1R { V29.4S }, [X2], X15
    ADD  X2, X2, X19, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X2]
    LD1R { V12.8H }, [X2], X15
    ADD  X2, X2, X19, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X2]
    LD1R { V11.4H }, [X2], X15
    ADD  X2, X2, X19, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X2]
    LD1R { V14.1D }, [X2], X15
    ADD  X2, X2, X19
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X2]
    LD1R { V27.2S }, [X2], X15
    ADD  X2, X2, X19, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X2]
    LD1R { V21.4H }, [X2], X15
    ADD  X2, X2, X19
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X2]
    LD1R { V15.8B }, [X2], X15
    ADD  X2, X2, X19, LSR #0
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    SUB  X18, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D0
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V1.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D1
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D2
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D3
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V4.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D4
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V5.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D5
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D6
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D7
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V8.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D8
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V9.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D9
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D10
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D11
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D12
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D13
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D14
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D15
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D16
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V17.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D17
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V18.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D18
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D19
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V20.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D20
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D21
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V22.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D22
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V23.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D23
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V24.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D24
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D25
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V26.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D26
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D27
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D28
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V29.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D29
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, V30.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D30
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X22, #0xa5a5, LSL #0
    MOVK  X22, #0xa5a5, LSL #16
    MOVK  X22, #0xa5a5, LSL #32
    MOVK  X22, #0xa5a5, LSL #48
    FMOV  X18, D31
    SUB  X11, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X12
    FMOV  V2.D[1], X5
    FMOV  D3, X14
    FMOV  V3.D[1], X10
    FMOV  D4, X23
    FMOV  V4.D[1], X27
    FMOV  D5, X10
    FMOV  V5.D[1], X26
    FMOV  D6, X23
    FMOV  V6.D[1], X19
    FMOV  D7, X24
    FMOV  V7.D[1], X26
    FMOV  D8, X14
    FMOV  V8.D[1], X23
    FMOV  D9, X12
    FMOV  V9.D[1], X22
    FMOV  D10, X9
    FMOV  V10.D[1], X9
    FMOV  D11, X15
    FMOV  V11.D[1], X10
    FMOV  D12, X2
    FMOV  V12.D[1], X16
    FMOV  D13, X10
    FMOV  V13.D[1], X3
    FMOV  D14, X26
    FMOV  V14.D[1], X16
    FMOV  D15, X9
    FMOV  V15.D[1], X5
    FMOV  D16, X5
    FMOV  V16.D[1], X28
    FMOV  D17, X15
    FMOV  V17.D[1], X7
    FMOV  D18, X28
    FMOV  V18.D[1], X12
    FMOV  D19, X11
    FMOV  V19.D[1], X16
    FMOV  D20, X9
    FMOV  V20.D[1], X15
    FMOV  D21, X12
    FMOV  V21.D[1], X5
    FMOV  D22, X7
    FMOV  V22.D[1], X2
    FMOV  D23, X5
    FMOV  V23.D[1], X2
    FMOV  D24, X29
    FMOV  V24.D[1], X16
    FMOV  D25, X14
    FMOV  V25.D[1], X29
    FMOV  D26, X4
    FMOV  V26.D[1], X28
    FMOV  D27, X22
    FMOV  V27.D[1], X11
    FMOV  D28, X18
    FMOV  V28.D[1], X10
    FMOV  D29, X24
    FMOV  V29.D[1], X28
    FMOV  D30, X26
    FMOV  V30.D[1], X12
    FMOV  D31, X20
    FMOV  V31.D[1], X20
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X15, #0x1400, LSL #0
    ADD  X22, X30, X15
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X22]
    LD1R { V9.4S }, [X22]
    ADD  X22, X22, X27, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X22]
    LD1R { V13.16B }, [X22]
    ADD  X22, X22, X27, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X22]
    LD1R { V0.2D }, [X22]
    ADD  X22, X22, X27, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X22]
    LD1R { V22.4S }, [X22]
    ADD  X22, X22, X27
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X22]
    LD1R { V4.8H }, [X22]
    ADD  X22, X22, X27, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X22]
    LD1R { V20.1D }, [X22]
    ADD  X22, X22, X27, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X22]
    LD1R { V0.1D }, [X22]
    ADD  X22, X22, X27
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X22]
    LD1R { V2.2S }, [X22]
    ADD  X22, X22, X27, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X22]
    LD1R { V10.4H }, [X22]
    ADD  X22, X22, X27
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X22]
    LD1R { V14.8B }, [X22]
    ADD  X22, X22, X27
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X22]
    MOV  X24, X22
    LD1R { V31.16B }, [X24], #1
    ADD  X22, X22, X27
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X22]
    MOV  X24, X22
    LD1R { V5.16B }, [X24], #1
    ADD  X22, X22, X27, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X22]
    MOV  X24, X22
    LD1R { V1.8B }, [X24], #1
    ADD  X22, X22, X27, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X22]
    MOV  X24, X22
    LD1R { V2.4H }, [X24], #2
    ADD  X22, X22, X27, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X22]
    MOV  X24, X22
    LD1R { V17.8H }, [X24], #2
    ADD  X22, X22, X27, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X22]
    MOV  X24, X22
    LD1R { V0.2S }, [X24], #4
    ADD  X22, X22, X27
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X22]
    MOV  X24, X22
    LD1R { V1.2S }, [X24], #4
    ADD  X22, X22, X27
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X22]
    MOV  X24, X22
    LD1R { V4.4S }, [X24], #4
    ADD  X22, X22, X27
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X22]
    MOV  X24, X22
    LD1R { V14.2D }, [X24], #8
    ADD  X22, X22, X27
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X22]
    MOV  X24, X22
    LD1R { V3.1D }, [X24], #8
    ADD  X22, X22, X27, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X22]
    MOV  X24, X22
    LD1R { V25.2D }, [X24], #8
    ADD  X22, X22, X27
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X22]
    MOV  X24, X22
    LD1R { V8.8H }, [X24], #2
    ADD  X22, X22, X27
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X22]
    LD1R { V1.8H }, [X22], X17
    ADD  X22, X22, X27, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X22]
    LD1R { V0.16B }, [X22], X17
    ADD  X22, X22, X27, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X22]
    LD1R { V27.2D }, [X22], X17
    ADD  X22, X22, X27, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X22]
    LD1R { V17.4S }, [X22], X17
    ADD  X22, X22, X27, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X22]
    LD1R { V10.8H }, [X22], X17
    ADD  X22, X22, X27, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X22]
    LD1R { V8.4H }, [X22], X17
    ADD  X22, X22, X27, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X22]
    LD1R { V15.1D }, [X22], X17
    ADD  X22, X22, X27
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X22]
    LD1R { V6.2S }, [X22], X17
    ADD  X22, X22, X27, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X22]
    LD1R { V5.4H }, [X22], X17
    ADD  X22, X22, X27
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X22]
    LD1R { V4.8B }, [X22], X17
    ADD  X22, X22, X27, LSR #0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V0.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D0
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V1.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D1
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D2
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D3
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D4
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D5
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D6
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V7.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D7
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D8
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V9.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D9
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D10
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D11
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V12.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D12
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V13.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D13
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V14.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D14
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D15
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V16.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D16
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V17.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D17
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V18.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D18
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V19.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D19
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D20
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V21.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D21
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V22.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D22
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V23.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D23
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V24.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D24
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V25.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D25
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V26.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D26
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V27.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D27
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V28.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D28
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V29.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D29
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V30.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D30
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, V31.D[1]
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X7, D31
    SUB  X26, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X24
    FMOV  D3, X5
    FMOV  V3.D[1], X14
    FMOV  D4, X20
    FMOV  V4.D[1], X16
    FMOV  D5, X5
    FMOV  V5.D[1], X23
    FMOV  D6, X28
    FMOV  V6.D[1], X29
    FMOV  D7, X29
    FMOV  V7.D[1], X29
    FMOV  D8, X18
    FMOV  V8.D[1], X21
    FMOV  D9, X21
    FMOV  V9.D[1], X22
    FMOV  D10, X16
    FMOV  V10.D[1], X11
    FMOV  D11, X18
    FMOV  V11.D[1], X23
    FMOV  D12, X12
    FMOV  V12.D[1], X16
    FMOV  D13, X4
    FMOV  V13.D[1], X2
    FMOV  D14, X2
    FMOV  V14.D[1], X28
    FMOV  D15, X17
    FMOV  V15.D[1], X15
    FMOV  D16, X20
    FMOV  V16.D[1], X9
    FMOV  D17, X5
    FMOV  V17.D[1], X22
    FMOV  D18, X10
    FMOV  V18.D[1], X24
    FMOV  D19, X28
    FMOV  V19.D[1], X4
    FMOV  D20, X19
    FMOV  V20.D[1], X9
    FMOV  D21, X28
    FMOV  V21.D[1], X19
    FMOV  D22, X2
    FMOV  V22.D[1], X27
    FMOV  D23, X15
    FMOV  V23.D[1], X27
    FMOV  D24, X22
    FMOV  V24.D[1], X24
    FMOV  D25, X4
    FMOV  V25.D[1], X27
    FMOV  D26, X29
    FMOV  V26.D[1], X12
    FMOV  D27, X2
    FMOV  V27.D[1], X15
    FMOV  D28, X29
    FMOV  V28.D[1], X29
    FMOV  D29, X24
    FMOV  V29.D[1], X28
    FMOV  D30, X20
    FMOV  V30.D[1], X15
    FMOV  D31, X5
    FMOV  V31.D[1], X21
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X9, #0x40, LSL #0
    MOVZ  X14, #0x1900, LSL #0
    ADD  X19, X30, X14, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X19]
    LD1R { V10.2D }, [X19]
    ADD  X19, X19, X9
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X19]
    LD1R { V19.16B }, [X19]
    ADD  X19, X19, X9, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X19]
    LD1R { V6.2D }, [X19]
    ADD  X19, X19, X9, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X19]
    LD1R { V31.4S }, [X19]
    ADD  X19, X19, X9, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X19]
    LD1R { V5.8H }, [X19]
    ADD  X19, X19, X9
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X19]
    LD1R { V16.8B }, [X19]
    ADD  X19, X19, X9
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X19]
    LD1R { V19.1D }, [X19]
    ADD  X19, X19, X9, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X19]
    LD1R { V28.2S }, [X19]
    ADD  X19, X19, X9, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X19]
    LD1R { V4.4H }, [X19]
    ADD  X19, X19, X9, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X19]
    LD1R { V11.8B }, [X19]
    ADD  X19, X19, X9
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X19]
    MOV  X7, X19
    LD1R { V15.16B }, [X7], #1
    ADD  X19, X19, X9
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X19]
    MOV  X7, X19
    LD1R { V21.16B }, [X7], #1
    ADD  X19, X19, X9
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X19]
    MOV  X7, X19
    LD1R { V28.8B }, [X7], #1
    ADD  X19, X19, X9
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X19]
    MOV  X7, X19
    LD1R { V4.4H }, [X7], #2
    ADD  X19, X19, X9, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X19]
    MOV  X7, X19
    LD1R { V10.8H }, [X7], #2
    ADD  X19, X19, X9
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X19]
    MOV  X7, X19
    LD1R { V18.2S }, [X7], #4
    ADD  X19, X19, X9
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X19]
    MOV  X7, X19
    LD1R { V26.2S }, [X7], #4
    ADD  X19, X19, X9, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X19]
    MOV  X7, X19
    LD1R { V11.4S }, [X7], #4
    ADD  X19, X19, X9, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X19]
    MOV  X7, X19
    LD1R { V4.1D }, [X7], #8
    ADD  X19, X19, X9, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X19]
    MOV  X7, X19
    LD1R { V16.1D }, [X7], #8
    ADD  X19, X19, X9, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X19]
    MOV  X7, X19
    LD1R { V29.2D }, [X7], #8
    ADD  X19, X19, X9
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X19]
    MOV  X7, X19
    LD1R { V20.4H }, [X7], #2
    ADD  X19, X19, X9, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X19]
    LD1R { V0.4S }, [X19], X24
    ADD  X19, X19, X9, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X19]
    LD1R { V9.16B }, [X19], X24
    ADD  X19, X19, X9, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X19]
    LD1R { V21.2D }, [X19], X24
    ADD  X19, X19, X9
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X19]
    LD1R { V11.4S }, [X19], X24
    ADD  X19, X19, X9, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X19]
    LD1R { V18.8H }, [X19], X24
    ADD  X19, X19, X9
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X19]
    LD1R { V5.2S }, [X19], X24
    ADD  X19, X19, X9, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X19]
    LD1R { V3.1D }, [X19], X24
    ADD  X19, X19, X9
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X19]
    LD1R { V16.2S }, [X19], X24
    ADD  X19, X19, X9, ASR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X19]
    LD1R { V11.4H }, [X19], X24
    ADD  X19, X19, X9, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X19]
    LD1R { V7.8B }, [X19], X24
    ADD  X19, X19, X9, ASR #0
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X11, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V0.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D0
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V1.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D1
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V2.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D2
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D3
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D4
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V5.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D5
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V6.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D6
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D7
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V8.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D8
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V9.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D9
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V10.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D10
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D11
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V12.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D12
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V13.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D13
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V14.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D14
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V15.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D15
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D16
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V17.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D17
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V18.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D18
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D19
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D20
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V21.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D21
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V22.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D22
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V23.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D23
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V24.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D24
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V25.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D25
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D26
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V27.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D27
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D28
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V29.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D29
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V30.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D30
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, V31.D[1]
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X11, D31
    SUB  X15, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X23
    FMOV  D3, X15
    FMOV  V3.D[1], X19
    FMOV  D4, X15
    FMOV  V4.D[1], X4
    FMOV  D5, X21
    FMOV  V5.D[1], X21
    FMOV  D6, X12
    FMOV  V6.D[1], X24
    FMOV  D7, X14
    FMOV  V7.D[1], X4
    FMOV  D8, X9
    FMOV  V8.D[1], X17
    FMOV  D9, X12
    FMOV  V9.D[1], X29
    FMOV  D10, X29
    FMOV  V10.D[1], X5
    FMOV  D11, X28
    FMOV  V11.D[1], X10
    FMOV  D12, X14
    FMOV  V12.D[1], X18
    FMOV  D13, X22
    FMOV  V13.D[1], X5
    FMOV  D14, X24
    FMOV  V14.D[1], X19
    FMOV  D15, X2
    FMOV  V15.D[1], X11
    FMOV  D16, X10
    FMOV  V16.D[1], X19
    FMOV  D17, X3
    FMOV  V17.D[1], X16
    FMOV  D18, X19
    FMOV  V18.D[1], X10
    FMOV  D19, X19
    FMOV  V19.D[1], X24
    FMOV  D20, X16
    FMOV  V20.D[1], X27
    FMOV  D21, X10
    FMOV  V21.D[1], X19
    FMOV  D22, X4
    FMOV  V22.D[1], X11
    FMOV  D23, X9
    FMOV  V23.D[1], X27
    FMOV  D24, X5
    FMOV  V24.D[1], X28
    FMOV  D25, X28
    FMOV  V25.D[1], X12
    FMOV  D26, X9
    FMOV  V26.D[1], X26
    FMOV  D27, X27
    FMOV  V27.D[1], X29
    FMOV  D28, X18
    FMOV  V28.D[1], X21
    FMOV  D29, X27
    FMOV  V29.D[1], X3
    FMOV  D30, X24
    FMOV  V30.D[1], X28
    FMOV  D31, X29
    FMOV  V31.D[1], X21
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X14, #0x1e00, LSL #0
    ADD  X24, X30, X14
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X24]
    LD1R { V28.8H }, [X24]
    ADD  X24, X24, X4, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X24]
    LD1R { V21.16B }, [X24]
    ADD  X24, X24, X4, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X24]
    LD1R { V30.2D }, [X24]
    ADD  X24, X24, X4, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X24]
    LD1R { V16.4S }, [X24]
    ADD  X24, X24, X4, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X24]
    LD1R { V5.8H }, [X24]
    ADD  X24, X24, X4, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X24]
    LD1R { V27.1D }, [X24]
    ADD  X24, X24, X4, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X24]
    LD1R { V28.1D }, [X24]
    ADD  X24, X24, X4
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X24]
    LD1R { V12.2S }, [X24]
    ADD  X24, X24, X4, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X24]
    LD1R { V0.4H }, [X24]
    ADD  X24, X24, X4, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X24]
    LD1R { V14.8B }, [X24]
    ADD  X24, X24, X4, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X24]
    MOV  X23, X24
    LD1R { V26.16B }, [X23], #1
    ADD  X24, X24, X4
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X24]
    MOV  X23, X24
    LD1R { V18.16B }, [X23], #1
    ADD  X24, X24, X4
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X24]
    MOV  X23, X24
    LD1R { V23.8B }, [X23], #1
    ADD  X24, X24, X4, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X24]
    MOV  X23, X24
    LD1R { V18.4H }, [X23], #2
    ADD  X24, X24, X4, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X24]
    MOV  X23, X24
    LD1R { V3.8H }, [X23], #2
    ADD  X24, X24, X4, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X24]
    MOV  X23, X24
    LD1R { V0.2S }, [X23], #4
    ADD  X24, X24, X4
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X24]
    MOV  X23, X24
    LD1R { V22.2S }, [X23], #4
    ADD  X24, X24, X4, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X24]
    MOV  X23, X24
    LD1R { V24.4S }, [X23], #4
    ADD  X24, X24, X4, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X24]
    MOV  X23, X24
    LD1R { V23.1D }, [X23], #8
    ADD  X24, X24, X4, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X24]
    MOV  X23, X24
    LD1R { V5.1D }, [X23], #8
    ADD  X24, X24, X4
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X24]
    MOV  X23, X24
    LD1R { V26.2D }, [X23], #8
    ADD  X24, X24, X4, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X24]
    MOV  X23, X24
    LD1R { V0.4H }, [X23], #2
    ADD  X24, X24, X4, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X24]
    LD1R { V30.2D }, [X24], X9
    ADD  X24, X24, X4, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X24]
    LD1R { V17.16B }, [X24], X9
    ADD  X24, X24, X4, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X24]
    LD1R { V1.2D }, [X24], X9
    ADD  X24, X24, X4, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X24]
    LD1R { V2.4S }, [X24], X9
    ADD  X24, X24, X4, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X24]
    LD1R { V21.8H }, [X24], X9
    ADD  X24, X24, X4
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X24]
    LD1R { V4.8B }, [X24], X9
    ADD  X24, X24, X4, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X24]
    LD1R { V20.1D }, [X24], X9
    ADD  X24, X24, X4, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X24]
    LD1R { V12.2S }, [X24], X9
    ADD  X24, X24, X4, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X24]
    LD1R { V7.4H }, [X24], X9
    ADD  X24, X24, X4
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X24]
    LD1R { V0.8B }, [X24], X9
    ADD  X24, X24, X4, ASR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X12, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D0
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D1
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V2.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D2
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V3.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D3
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D4
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D5
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V6.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D6
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D7
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V8.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D8
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V9.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D9
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V10.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D10
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V11.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D11
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D12
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D13
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D14
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V15.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D15
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V16.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D16
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V17.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D17
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D18
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V19.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D19
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D20
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V21.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D21
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D22
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D23
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V24.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D24
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D25
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V26.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D26
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D27
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D28
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V29.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D29
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D30
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X12, D31
    SUB  X2, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X10
    FMOV  V3.D[1], X17
    FMOV  D4, X24
    FMOV  V4.D[1], X28
    FMOV  D5, X16
    FMOV  V5.D[1], X3
    FMOV  D6, X18
    FMOV  V6.D[1], X11
    FMOV  D7, X10
    FMOV  V7.D[1], X11
    FMOV  D8, X2
    FMOV  V8.D[1], X19
    FMOV  D9, X17
    FMOV  V9.D[1], X2
    FMOV  D10, X27
    FMOV  V10.D[1], X7
    FMOV  D11, X5
    FMOV  V11.D[1], X26
    FMOV  D12, X26
    FMOV  V12.D[1], X7
    FMOV  D13, X14
    FMOV  V13.D[1], X14
    FMOV  D14, X12
    FMOV  V14.D[1], X7
    FMOV  D15, X17
    FMOV  V15.D[1], X26
    FMOV  D16, X21
    FMOV  V16.D[1], X17
    FMOV  D17, X28
    FMOV  V17.D[1], X24
    FMOV  D18, X14
    FMOV  V18.D[1], X15
    FMOV  D19, X12
    FMOV  V19.D[1], X18
    FMOV  D20, X16
    FMOV  V20.D[1], X5
    FMOV  D21, X21
    FMOV  V21.D[1], X22
    FMOV  D22, X28
    FMOV  V22.D[1], X23
    FMOV  D23, X7
    FMOV  V23.D[1], X28
    FMOV  D24, X29
    FMOV  V24.D[1], X28
    FMOV  D25, X16
    FMOV  V25.D[1], X29
    FMOV  D26, X23
    FMOV  V26.D[1], X11
    FMOV  D27, X27
    FMOV  V27.D[1], X21
    FMOV  D28, X5
    FMOV  V28.D[1], X20
    FMOV  D29, X21
    FMOV  V29.D[1], X2
    FMOV  D30, X24
    FMOV  V30.D[1], X7
    FMOV  D31, X26
    FMOV  V31.D[1], X26
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X27, #0x2300, LSL #0
    ADD  X14, X30, X27, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X14]
    LD1R { V17.4S }, [X14]
    ADD  X14, X14, X2
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X14]
    LD1R { V31.16B }, [X14]
    ADD  X14, X14, X2, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X14]
    LD1R { V25.2D }, [X14]
    ADD  X14, X14, X2
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X14]
    LD1R { V7.4S }, [X14]
    ADD  X14, X14, X2, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X14]
    LD1R { V29.8H }, [X14]
    ADD  X14, X14, X2, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X14]
    LD1R { V11.1D }, [X14]
    ADD  X14, X14, X2
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X14]
    LD1R { V0.1D }, [X14]
    ADD  X14, X14, X2, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X14]
    LD1R { V16.2S }, [X14]
    ADD  X14, X14, X2, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X14]
    LD1R { V10.4H }, [X14]
    ADD  X14, X14, X2
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X14]
    LD1R { V12.8B }, [X14]
    ADD  X14, X14, X2
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X14]
    MOV  X7, X14
    LD1R { V5.8B }, [X7], #1
    ADD  X14, X14, X2
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X14]
    MOV  X7, X14
    LD1R { V14.16B }, [X7], #1
    ADD  X14, X14, X2, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X14]
    MOV  X7, X14
    LD1R { V15.8B }, [X7], #1
    ADD  X14, X14, X2, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X14]
    MOV  X7, X14
    LD1R { V16.4H }, [X7], #2
    ADD  X14, X14, X2, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X14]
    MOV  X7, X14
    LD1R { V26.8H }, [X7], #2
    ADD  X14, X14, X2, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X14]
    MOV  X7, X14
    LD1R { V29.4S }, [X7], #4
    ADD  X14, X14, X2, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X14]
    MOV  X7, X14
    LD1R { V16.2S }, [X7], #4
    ADD  X14, X14, X2, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X14]
    MOV  X7, X14
    LD1R { V19.4S }, [X7], #4
    ADD  X14, X14, X2, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X14]
    MOV  X7, X14
    LD1R { V30.1D }, [X7], #8
    ADD  X14, X14, X2, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X14]
    MOV  X7, X14
    LD1R { V15.1D }, [X7], #8
    ADD  X14, X14, X2
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X14]
    MOV  X7, X14
    LD1R { V21.2D }, [X7], #8
    ADD  X14, X14, X2, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X14]
    MOV  X7, X14
    LD1R { V20.8H }, [X7], #2
    ADD  X14, X14, X2, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X14]
    LD1R { V22.2D }, [X14], X24
    ADD  X14, X14, X2, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X14]
    LD1R { V30.16B }, [X14], X24
    ADD  X14, X14, X2, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X14]
    LD1R { V13.2D }, [X14], X24
    ADD  X14, X14, X2, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X14]
    LD1R { V12.4S }, [X14], X24
    ADD  X14, X14, X2
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X14]
    LD1R { V10.8H }, [X14], X24
    ADD  X14, X14, X2, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X14]
    LD1R { V7.1D }, [X14], X24
    ADD  X14, X14, X2, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X14]
    LD1R { V9.1D }, [X14], X24
    ADD  X14, X14, X2, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X14]
    LD1R { V27.2S }, [X14], X24
    ADD  X14, X14, X2
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X14]
    LD1R { V29.4H }, [X14], X24
    ADD  X14, X14, X2, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X14]
    LD1R { V23.8B }, [X14], X24
    ADD  X14, X14, X2, LSR #0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X9, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V1.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V2.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V4.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V6.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V12.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V26.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, V31.D[1]
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X21, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X27
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X22
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X21
    FMOV  D4, X20
    FMOV  V4.D[1], X24
    FMOV  D5, X11
    FMOV  V5.D[1], X24
    FMOV  D6, X2
    FMOV  V6.D[1], X12
    FMOV  D7, X5
    FMOV  V7.D[1], X3
    FMOV  D8, X11
    FMOV  V8.D[1], X9
    FMOV  D9, X27
    FMOV  V9.D[1], X12
    FMOV  D10, X7
    FMOV  V10.D[1], X17
    FMOV  D11, X28
    FMOV  V11.D[1], X16
    FMOV  D12, X16
    FMOV  V12.D[1], X27
    FMOV  D13, X28
    FMOV  V13.D[1], X18
    FMOV  D14, X3
    FMOV  V14.D[1], X10
    FMOV  D15, X19
    FMOV  V15.D[1], X4
    FMOV  D16, X15
    FMOV  V16.D[1], X12
    FMOV  D17, X16
    FMOV  V17.D[1], X2
    FMOV  D18, X10
    FMOV  V18.D[1], X7
    FMOV  D19, X3
    FMOV  V19.D[1], X28
    FMOV  D20, X3
    FMOV  V20.D[1], X26
    FMOV  D21, X7
    FMOV  V21.D[1], X14
    FMOV  D22, X28
    FMOV  V22.D[1], X10
    FMOV  D23, X7
    FMOV  V23.D[1], X23
    FMOV  D24, X7
    FMOV  V24.D[1], X17
    FMOV  D25, X4
    FMOV  V25.D[1], X7
    FMOV  D26, X2
    FMOV  V26.D[1], X2
    FMOV  D27, X4
    FMOV  V27.D[1], X4
    FMOV  D28, X3
    FMOV  V28.D[1], X12
    FMOV  D29, X26
    FMOV  V29.D[1], X16
    FMOV  D30, X28
    FMOV  V30.D[1], X5
    FMOV  D31, X14
    FMOV  V31.D[1], X26
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X24, #0x2800, LSL #0
    ADD  X18, X30, X24, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X18]
    LD1R { V4.4S }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X18]
    LD1R { V5.16B }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X18]
    LD1R { V14.2D }, [X18]
    ADD  X18, X18, X7
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X18]
    LD1R { V29.4S }, [X18]
    ADD  X18, X18, X7
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X18]
    LD1R { V22.8H }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X18]
    LD1R { V15.1D }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X18]
    LD1R { V16.1D }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X18]
    LD1R { V24.2S }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X18]
    LD1R { V31.4H }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X18]
    LD1R { V21.8B }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X18]
    MOV  X23, X18
    LD1R { V23.16B }, [X23], #1
    ADD  X18, X18, X7, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X18]
    MOV  X23, X18
    LD1R { V11.16B }, [X23], #1
    ADD  X18, X18, X7
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X18]
    MOV  X23, X18
    LD1R { V20.8B }, [X23], #1
    ADD  X18, X18, X7, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X18]
    MOV  X23, X18
    LD1R { V8.4H }, [X23], #2
    ADD  X18, X18, X7, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X18]
    MOV  X23, X18
    LD1R { V29.8H }, [X23], #2
    ADD  X18, X18, X7, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X18]
    MOV  X23, X18
    LD1R { V23.2S }, [X23], #4
    ADD  X18, X18, X7
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X18]
    MOV  X23, X18
    LD1R { V24.2S }, [X23], #4
    ADD  X18, X18, X7
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X18]
    MOV  X23, X18
    LD1R { V3.4S }, [X23], #4
    ADD  X18, X18, X7
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X18]
    MOV  X23, X18
    LD1R { V6.1D }, [X23], #8
    ADD  X18, X18, X7, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X18]
    MOV  X23, X18
    LD1R { V1.1D }, [X23], #8
    ADD  X18, X18, X7, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X18]
    MOV  X23, X18
    LD1R { V25.2D }, [X23], #8
    ADD  X18, X18, X7, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X18]
    MOV  X23, X18
    LD1R { V7.4H }, [X23], #2
    ADD  X18, X18, X7, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X18]
    LD1R { V14.16B }, [X18], X20
    ADD  X18, X18, X7, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X18]
    LD1R { V12.16B }, [X18], X20
    ADD  X18, X18, X7, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X18]
    LD1R { V3.2D }, [X18], X20
    ADD  X18, X18, X7, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X18]
    LD1R { V6.4S }, [X18], X20
    ADD  X18, X18, X7, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X18]
    LD1R { V29.8H }, [X18], X20
    ADD  X18, X18, X7
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X18]
    LD1R { V13.4H }, [X18], X20
    ADD  X18, X18, X7, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X18]
    LD1R { V5.1D }, [X18], X20
    ADD  X18, X18, X7, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X18]
    LD1R { V9.2S }, [X18], X20
    ADD  X18, X18, X7, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X18]
    LD1R { V3.4H }, [X18], X20
    ADD  X18, X18, X7, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X18]
    LD1R { V7.8B }, [X18], X20
    ADD  X18, X18, X7
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X29, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X29, FPSR
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V0.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D0
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D1
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V2.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D2
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D3
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V4.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D4
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D5
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V6.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D6
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D7
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D8
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D9
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V10.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D10
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V11.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D11
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V12.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D12
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D13
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V14.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D14
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D15
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D16
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V17.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D17
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V18.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D18
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V19.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D19
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D20
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D21
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V22.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D22
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D23
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D24
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V25.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D25
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V26.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D26
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V27.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D27
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V28.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D28
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V29.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D29
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, V30.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D30
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X29, D31
    SUB  X21, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X9
    FMOV  D3, X11
    FMOV  V3.D[1], X15
    FMOV  D4, X9
    FMOV  V4.D[1], X3
    FMOV  D5, X16
    FMOV  V5.D[1], X15
    FMOV  D6, X27
    FMOV  V6.D[1], X2
    FMOV  D7, X3
    FMOV  V7.D[1], X15
    FMOV  D8, X16
    FMOV  V8.D[1], X17
    FMOV  D9, X19
    FMOV  V9.D[1], X7
    FMOV  D10, X24
    FMOV  V10.D[1], X7
    FMOV  D11, X12
    FMOV  V11.D[1], X23
    FMOV  D12, X24
    FMOV  V12.D[1], X23
    FMOV  D13, X28
    FMOV  V13.D[1], X16
    FMOV  D14, X27
    FMOV  V14.D[1], X12
    FMOV  D15, X28
    FMOV  V15.D[1], X9
    FMOV  D16, X5
    FMOV  V16.D[1], X4
    FMOV  D17, X10
    FMOV  V17.D[1], X18
    FMOV  D18, X19
    FMOV  V18.D[1], X21
    FMOV  D19, X7
    FMOV  V19.D[1], X2
    FMOV  D20, X14
    FMOV  V20.D[1], X10
    FMOV  D21, X14
    FMOV  V21.D[1], X26
    FMOV  D22, X22
    FMOV  V22.D[1], X4
    FMOV  D23, X28
    FMOV  V23.D[1], X27
    FMOV  D24, X22
    FMOV  V24.D[1], X4
    FMOV  D25, X23
    FMOV  V25.D[1], X4
    FMOV  D26, X18
    FMOV  V26.D[1], X26
    FMOV  D27, X9
    FMOV  V27.D[1], X11
    FMOV  D28, X17
    FMOV  V28.D[1], X5
    FMOV  D29, X22
    FMOV  V29.D[1], X7
    FMOV  D30, X28
    FMOV  V30.D[1], X10
    FMOV  D31, X21
    FMOV  V31.D[1], X2
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X19, #0x2d00, LSL #0
    ADD  X5, X30, X19, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X5]
    LD1R { V8.16B }, [X5]
    ADD  X5, X5, X20, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X5]
    LD1R { V26.16B }, [X5]
    ADD  X5, X5, X20
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X5]
    LD1R { V21.2D }, [X5]
    ADD  X5, X5, X20, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X5]
    LD1R { V23.4S }, [X5]
    ADD  X5, X5, X20, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X5]
    LD1R { V24.8H }, [X5]
    ADD  X5, X5, X20
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X5]
    LD1R { V23.8B }, [X5]
    ADD  X5, X5, X20, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X5]
    LD1R { V31.1D }, [X5]
    ADD  X5, X5, X20, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X5]
    LD1R { V22.2S }, [X5]
    ADD  X5, X5, X20
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X5]
    LD1R { V4.4H }, [X5]
    ADD  X5, X5, X20
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X5]
    LD1R { V25.8B }, [X5]
    ADD  X5, X5, X20, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X5]
    MOV  X26, X5
    LD1R { V12.16B }, [X26], #1
    ADD  X5, X5, X20, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X5]
    MOV  X26, X5
    LD1R { V7.16B }, [X26], #1
    ADD  X5, X5, X20
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X5]
    MOV  X26, X5
    LD1R { V3.8B }, [X26], #1
    ADD  X5, X5, X20
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X5]
    MOV  X26, X5
    LD1R { V6.4H }, [X26], #2
    ADD  X5, X5, X20, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X5]
    MOV  X26, X5
    LD1R { V26.8H }, [X26], #2
    ADD  X5, X5, X20
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X5]
    MOV  X26, X5
    LD1R { V5.4S }, [X26], #4
    ADD  X5, X5, X20, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X5]
    MOV  X26, X5
    LD1R { V7.2S }, [X26], #4
    ADD  X5, X5, X20, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X5]
    MOV  X26, X5
    LD1R { V3.4S }, [X26], #4
    ADD  X5, X5, X20, LSR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X5]
    MOV  X26, X5
    LD1R { V21.1D }, [X26], #8
    ADD  X5, X5, X20, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X5]
    MOV  X26, X5
    LD1R { V26.1D }, [X26], #8
    ADD  X5, X5, X20, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X5]
    MOV  X26, X5
    LD1R { V30.2D }, [X26], #8
    ADD  X5, X5, X20, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X5]
    MOV  X26, X5
    LD1R { V27.4H }, [X26], #2
    ADD  X5, X5, X20
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X5]
    LD1R { V0.2D }, [X5], X10
    ADD  X5, X5, X20, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X5]
    LD1R { V25.16B }, [X5], X10
    ADD  X5, X5, X20
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X5]
    LD1R { V28.2D }, [X5], X10
    ADD  X5, X5, X20, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X5]
    LD1R { V19.4S }, [X5], X10
    ADD  X5, X5, X20, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X5]
    LD1R { V7.8H }, [X5], X10
    ADD  X5, X5, X20, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X5]
    LD1R { V8.8B }, [X5], X10
    ADD  X5, X5, X20
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X5]
    LD1R { V25.1D }, [X5], X10
    ADD  X5, X5, X20
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X5]
    LD1R { V20.2S }, [X5], X10
    ADD  X5, X5, X20, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X5]
    LD1R { V21.4H }, [X5], X10
    ADD  X5, X5, X20, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X5]
    LD1R { V8.8B }, [X5], X10
    ADD  X5, X5, X20
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D0
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V1.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D1
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D2
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V3.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D3
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D4
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V5.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D5
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D6
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D7
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D8
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V9.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D9
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V10.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D10
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D11
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D12
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V13.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D13
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V14.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D14
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V15.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D15
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V16.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D16
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V17.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D17
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V18.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D18
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D19
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D20
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D21
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D22
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D23
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V24.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D24
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D25
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D26
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D27
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D28
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V29.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D29
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V30.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D30
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D31
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X15
    FMOV  D3, X19
    FMOV  V3.D[1], X4
    FMOV  D4, X14
    FMOV  V4.D[1], X2
    FMOV  D5, X11
    FMOV  V5.D[1], X12
    FMOV  D6, X14
    FMOV  V6.D[1], X21
    FMOV  D7, X2
    FMOV  V7.D[1], X4
    FMOV  D8, X26
    FMOV  V8.D[1], X18
    FMOV  D9, X24
    FMOV  V9.D[1], X16
    FMOV  D10, X18
    FMOV  V10.D[1], X16
    FMOV  D11, X27
    FMOV  V11.D[1], X28
    FMOV  D12, X20
    FMOV  V12.D[1], X5
    FMOV  D13, X15
    FMOV  V13.D[1], X26
    FMOV  D14, X29
    FMOV  V14.D[1], X23
    FMOV  D15, X11
    FMOV  V15.D[1], X19
    FMOV  D16, X26
    FMOV  V16.D[1], X22
    FMOV  D17, X20
    FMOV  V17.D[1], X24
    FMOV  D18, X10
    FMOV  V18.D[1], X29
    FMOV  D19, X27
    FMOV  V19.D[1], X26
    FMOV  D20, X27
    FMOV  V20.D[1], X7
    FMOV  D21, X2
    FMOV  V21.D[1], X21
    FMOV  D22, X12
    FMOV  V22.D[1], X12
    FMOV  D23, X26
    FMOV  V23.D[1], X24
    FMOV  D24, X24
    FMOV  V24.D[1], X17
    FMOV  D25, X3
    FMOV  V25.D[1], X21
    FMOV  D26, X29
    FMOV  V26.D[1], X22
    FMOV  D27, X9
    FMOV  V27.D[1], X3
    FMOV  D28, X20
    FMOV  V28.D[1], X11
    FMOV  D29, X14
    FMOV  V29.D[1], X22
    FMOV  D30, X11
    FMOV  V30.D[1], X12
    FMOV  D31, X5
    FMOV  V31.D[1], X23
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X21, #0x0, LSL #0
    ADD  X7, X30, X21
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X7]
    LD1R { V2.4S }, [X7]
    ADD  X7, X7, X11, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X7]
    LD1R { V1.16B }, [X7]
    ADD  X7, X7, X11, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X7]
    LD1R { V1.2D }, [X7]
    ADD  X7, X7, X11, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X7]
    LD1R { V20.4S }, [X7]
    ADD  X7, X7, X11, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X7]
    LD1R { V4.8H }, [X7]
    ADD  X7, X7, X11, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X7]
    LD1R { V24.2S }, [X7]
    ADD  X7, X7, X11, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X7]
    LD1R { V30.1D }, [X7]
    ADD  X7, X7, X11, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X7]
    LD1R { V27.2S }, [X7]
    ADD  X7, X7, X11
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X7]
    LD1R { V15.4H }, [X7]
    ADD  X7, X7, X11, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X7]
    LD1R { V26.8B }, [X7]
    ADD  X7, X7, X11, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X7]
    MOV  X29, X7
    LD1R { V7.16B }, [X29], #1
    ADD  X7, X7, X11
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X7]
    MOV  X29, X7
    LD1R { V21.16B }, [X29], #1
    ADD  X7, X7, X11, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X7]
    MOV  X29, X7
    LD1R { V23.8B }, [X29], #1
    ADD  X7, X7, X11
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X7]
    MOV  X29, X7
    LD1R { V6.4H }, [X29], #2
    ADD  X7, X7, X11, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X7]
    MOV  X29, X7
    LD1R { V15.8H }, [X29], #2
    ADD  X7, X7, X11
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X7]
    MOV  X29, X7
    LD1R { V31.4S }, [X29], #4
    ADD  X7, X7, X11, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X7]
    MOV  X29, X7
    LD1R { V19.2S }, [X29], #4
    ADD  X7, X7, X11, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X7]
    MOV  X29, X7
    LD1R { V24.4S }, [X29], #4
    ADD  X7, X7, X11, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X7]
    MOV  X29, X7
    LD1R { V21.2D }, [X29], #8
    ADD  X7, X7, X11, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X7]
    MOV  X29, X7
    LD1R { V19.1D }, [X29], #8
    ADD  X7, X7, X11, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X7]
    MOV  X29, X7
    LD1R { V20.2D }, [X29], #8
    ADD  X7, X7, X11, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X7]
    MOV  X29, X7
    LD1R { V25.4H }, [X29], #2
    ADD  X7, X7, X11
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X7]
    LD1R { V31.2D }, [X7], X4
    ADD  X7, X7, X11, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X7]
    LD1R { V25.16B }, [X7], X4
    ADD  X7, X7, X11, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X7]
    LD1R { V24.2D }, [X7], X4
    ADD  X7, X7, X11, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X7]
    LD1R { V29.4S }, [X7], X4
    ADD  X7, X7, X11, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X7]
    LD1R { V15.8H }, [X7], X4
    ADD  X7, X7, X11
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X7]
    LD1R { V17.2S }, [X7], X4
    ADD  X7, X7, X11, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X7]
    LD1R { V30.1D }, [X7], X4
    ADD  X7, X7, X11, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X7]
    LD1R { V21.2S }, [X7], X4
    ADD  X7, X7, X11, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X7]
    LD1R { V9.4H }, [X7], X4
    ADD  X7, X7, X11, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X7]
    LD1R { V13.8B }, [X7], X4
    ADD  X7, X7, X11
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X3, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X3, FPSR
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V0.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D0
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V1.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D1
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V2.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D2
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V3.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D3
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V4.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D4
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V5.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D5
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D6
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V7.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D7
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V8.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D8
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D9
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V10.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D10
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V11.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D11
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V12.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D12
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D13
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V14.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D14
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V15.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D15
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V16.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D16
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D17
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V18.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D18
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V19.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D19
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V20.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D20
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D21
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V22.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D22
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D23
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V24.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D24
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V25.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D25
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D26
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D27
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V28.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D28
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V29.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D29
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D30
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, V31.D[1]
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X3, D31
    SUB  X28, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X22
    FMOV  D2, X29
    FMOV  V2.D[1], X3
    FMOV  D3, X9
    FMOV  V3.D[1], X27
    FMOV  D4, X24
    FMOV  V4.D[1], X15
    FMOV  D5, X14
    FMOV  V5.D[1], X5
    FMOV  D6, X26
    FMOV  V6.D[1], X12
    FMOV  D7, X17
    FMOV  V7.D[1], X11
    FMOV  D8, X26
    FMOV  V8.D[1], X5
    FMOV  D9, X2
    FMOV  V9.D[1], X14
    FMOV  D10, X27
    FMOV  V10.D[1], X14
    FMOV  D11, X5
    FMOV  V11.D[1], X22
    FMOV  D12, X21
    FMOV  V12.D[1], X19
    FMOV  D13, X19
    FMOV  V13.D[1], X28
    FMOV  D14, X16
    FMOV  V14.D[1], X4
    FMOV  D15, X18
    FMOV  V15.D[1], X19
    FMOV  D16, X12
    FMOV  V16.D[1], X10
    FMOV  D17, X18
    FMOV  V17.D[1], X4
    FMOV  D18, X5
    FMOV  V18.D[1], X28
    FMOV  D19, X29
    FMOV  V19.D[1], X23
    FMOV  D20, X2
    FMOV  V20.D[1], X17
    FMOV  D21, X27
    FMOV  V21.D[1], X27
    FMOV  D22, X7
    FMOV  V22.D[1], X14
    FMOV  D23, X26
    FMOV  V23.D[1], X15
    FMOV  D24, X24
    FMOV  V24.D[1], X23
    FMOV  D25, X18
    FMOV  V25.D[1], X21
    FMOV  D26, X22
    FMOV  V26.D[1], X21
    FMOV  D27, X23
    FMOV  V27.D[1], X28
    FMOV  D28, X5
    FMOV  V28.D[1], X3
    FMOV  D29, X24
    FMOV  V29.D[1], X21
    FMOV  D30, X18
    FMOV  V30.D[1], X26
    FMOV  D31, X11
    FMOV  V31.D[1], X5
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X14, #0x500, LSL #0
    ADD  X17, X30, X14, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X17]
    LD1R { V31.16B }, [X17]
    ADD  X17, X17, X10
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X17]
    LD1R { V16.16B }, [X17]
    ADD  X17, X17, X10, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X17]
    LD1R { V18.2D }, [X17]
    ADD  X17, X17, X10, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X17]
    LD1R { V9.4S }, [X17]
    ADD  X17, X17, X10, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X17]
    LD1R { V5.8H }, [X17]
    ADD  X17, X17, X10, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X17]
    LD1R { V10.4H }, [X17]
    ADD  X17, X17, X10, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X17]
    LD1R { V30.1D }, [X17]
    ADD  X17, X17, X10, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X17]
    LD1R { V0.2S }, [X17]
    ADD  X17, X17, X10, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X17]
    LD1R { V19.4H }, [X17]
    ADD  X17, X17, X10, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X17]
    LD1R { V18.8B }, [X17]
    ADD  X17, X17, X10, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X17]
    MOV  X4, X17
    LD1R { V27.8B }, [X4], #1
    ADD  X17, X17, X10
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X17]
    MOV  X4, X17
    LD1R { V28.16B }, [X4], #1
    ADD  X17, X17, X10
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X17]
    MOV  X4, X17
    LD1R { V26.8B }, [X4], #1
    ADD  X17, X17, X10
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X17]
    MOV  X4, X17
    LD1R { V4.4H }, [X4], #2
    ADD  X17, X17, X10
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X17]
    MOV  X4, X17
    LD1R { V30.8H }, [X4], #2
    ADD  X17, X17, X10, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X17]
    MOV  X4, X17
    LD1R { V23.2S }, [X4], #4
    ADD  X17, X17, X10, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X17]
    MOV  X4, X17
    LD1R { V31.2S }, [X4], #4
    ADD  X17, X17, X10, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X17]
    MOV  X4, X17
    LD1R { V22.4S }, [X4], #4
    ADD  X17, X17, X10, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X17]
    MOV  X4, X17
    LD1R { V2.2D }, [X4], #8
    ADD  X17, X17, X10, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X17]
    MOV  X4, X17
    LD1R { V28.1D }, [X4], #8
    ADD  X17, X17, X10, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X17]
    MOV  X4, X17
    LD1R { V2.2D }, [X4], #8
    ADD  X17, X17, X10, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X17]
    MOV  X4, X17
    LD1R { V2.4H }, [X4], #2
    ADD  X17, X17, X10
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X17]
    LD1R { V29.8H }, [X17], X19
    ADD  X17, X17, X10, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X17]
    LD1R { V4.16B }, [X17], X19
    ADD  X17, X17, X10, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X17]
    LD1R { V14.2D }, [X17], X19
    ADD  X17, X17, X10, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X17]
    LD1R { V19.4S }, [X17], X19
    ADD  X17, X17, X10, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X17]
    LD1R { V18.8H }, [X17], X19
    ADD  X17, X17, X10, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X17]
    LD1R { V3.1D }, [X17], X19
    ADD  X17, X17, X10, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X17]
    LD1R { V4.1D }, [X17], X19
    ADD  X17, X17, X10, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X17]
    LD1R { V9.2S }, [X17], X19
    ADD  X17, X17, X10
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X17]
    LD1R { V21.4H }, [X17], X19
    ADD  X17, X17, X10, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X17]
    LD1R { V22.8B }, [X17], X19
    ADD  X17, X17, X10, LSR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X12, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D0
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D1
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D2
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D3
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D4
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D5
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V6.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D6
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V7.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D7
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V8.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D8
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D9
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D10
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V11.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D11
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V12.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D12
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D13
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V14.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D14
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V15.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D15
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V16.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D16
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V17.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D17
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V18.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D18
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V19.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D19
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V20.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D20
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D21
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D22
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D23
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V24.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D24
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D25
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D26
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D27
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D28
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V29.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D29
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D30
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X12, D31
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X22
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X16
    FMOV  V3.D[1], X15
    FMOV  D4, X14
    FMOV  V4.D[1], X16
    FMOV  D5, X7
    FMOV  V5.D[1], X10
    FMOV  D6, X29
    FMOV  V6.D[1], X24
    FMOV  D7, X28
    FMOV  V7.D[1], X27
    FMOV  D8, X22
    FMOV  V8.D[1], X24
    FMOV  D9, X5
    FMOV  V9.D[1], X2
    FMOV  D10, X3
    FMOV  V10.D[1], X24
    FMOV  D11, X21
    FMOV  V11.D[1], X11
    FMOV  D12, X19
    FMOV  V12.D[1], X2
    FMOV  D13, X19
    FMOV  V13.D[1], X26
    FMOV  D14, X27
    FMOV  V14.D[1], X10
    FMOV  D15, X26
    FMOV  V15.D[1], X7
    FMOV  D16, X12
    FMOV  V16.D[1], X19
    FMOV  D17, X12
    FMOV  V17.D[1], X21
    FMOV  D18, X27
    FMOV  V18.D[1], X29
    FMOV  D19, X20
    FMOV  V19.D[1], X27
    FMOV  D20, X19
    FMOV  V20.D[1], X17
    FMOV  D21, X3
    FMOV  V21.D[1], X14
    FMOV  D22, X12
    FMOV  V22.D[1], X12
    FMOV  D23, X4
    FMOV  V23.D[1], X26
    FMOV  D24, X10
    FMOV  V24.D[1], X12
    FMOV  D25, X22
    FMOV  V25.D[1], X29
    FMOV  D26, X20
    FMOV  V26.D[1], X27
    FMOV  D27, X27
    FMOV  V27.D[1], X26
    FMOV  D28, X9
    FMOV  V28.D[1], X15
    FMOV  D29, X5
    FMOV  V29.D[1], X23
    FMOV  D30, X21
    FMOV  V30.D[1], X10
    FMOV  D31, X14
    FMOV  V31.D[1], X11
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X20, #0xa00, LSL #0
    ADD  X21, X30, X20, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X21]
    LD1R { V20.8H }, [X21]
    ADD  X21, X21, X24, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X21]
    LD1R { V7.16B }, [X21]
    ADD  X21, X21, X24
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X21]
    LD1R { V4.2D }, [X21]
    ADD  X21, X21, X24, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X21]
    LD1R { V15.4S }, [X21]
    ADD  X21, X21, X24
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X21]
    LD1R { V7.8H }, [X21]
    ADD  X21, X21, X24
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X21]
    LD1R { V25.1D }, [X21]
    ADD  X21, X21, X24, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X21]
    LD1R { V24.1D }, [X21]
    ADD  X21, X21, X24
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X21]
    LD1R { V24.2S }, [X21]
    ADD  X21, X21, X24
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X21]
    LD1R { V10.4H }, [X21]
    ADD  X21, X21, X24, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X21]
    LD1R { V19.8B }, [X21]
    ADD  X21, X21, X24, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X21]
    MOV  X28, X21
    LD1R { V8.16B }, [X28], #1
    ADD  X21, X21, X24
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X21]
    MOV  X28, X21
    LD1R { V17.16B }, [X28], #1
    ADD  X21, X21, X24
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X21]
    MOV  X28, X21
    LD1R { V15.8B }, [X28], #1
    ADD  X21, X21, X24
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X21]
    MOV  X28, X21
    LD1R { V18.4H }, [X28], #2
    ADD  X21, X21, X24
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X21]
    MOV  X28, X21
    LD1R { V11.8H }, [X28], #2
    ADD  X21, X21, X24, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X21]
    MOV  X28, X21
    LD1R { V4.2S }, [X28], #4
    ADD  X21, X21, X24, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X21]
    MOV  X28, X21
    LD1R { V6.2S }, [X28], #4
    ADD  X21, X21, X24
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X21]
    MOV  X28, X21
    LD1R { V4.4S }, [X28], #4
    ADD  X21, X21, X24
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X21]
    MOV  X28, X21
    LD1R { V30.1D }, [X28], #8
    ADD  X21, X21, X24, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X21]
    MOV  X28, X21
    LD1R { V13.1D }, [X28], #8
    ADD  X21, X21, X24
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X21]
    MOV  X28, X21
    LD1R { V1.2D }, [X28], #8
    ADD  X21, X21, X24, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X21]
    MOV  X28, X21
    LD1R { V31.4H }, [X28], #2
    ADD  X21, X21, X24, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X21]
    LD1R { V11.2D }, [X21], X14
    ADD  X21, X21, X24
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X21]
    LD1R { V3.16B }, [X21], X14
    ADD  X21, X21, X24
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X21]
    LD1R { V6.2D }, [X21], X14
    ADD  X21, X21, X24
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X21]
    LD1R { V30.4S }, [X21], X14
    ADD  X21, X21, X24
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X21]
    LD1R { V16.8H }, [X21], X14
    ADD  X21, X21, X24, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X21]
    LD1R { V9.4H }, [X21], X14
    ADD  X21, X21, X24
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X21]
    LD1R { V13.1D }, [X21], X14
    ADD  X21, X21, X24
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X21]
    LD1R { V3.2S }, [X21], X14
    ADD  X21, X21, X24, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X21]
    LD1R { V27.4H }, [X21], X14
    ADD  X21, X21, X24, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X21]
    LD1R { V7.8B }, [X21], X14
    ADD  X21, X21, X24, ASR #0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X26, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V0.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D0
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V1.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D1
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V2.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D2
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D3
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V4.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D4
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V5.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D5
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V6.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D6
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D7
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V8.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D8
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D9
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D10
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V11.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D11
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V12.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D12
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D13
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V14.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D14
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D15
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V16.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D16
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V17.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D17
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D18
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D19
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V20.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D20
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V21.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D21
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V22.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D22
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V23.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D23
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D24
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D25
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V26.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D26
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D27
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V28.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D28
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V29.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D29
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, V30.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D30
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X26, D31
    SUB  X2, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X21
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X24
    FMOV  D3, X10
    FMOV  V3.D[1], X23
    FMOV  D4, X29
    FMOV  V4.D[1], X12
    FMOV  D5, X20
    FMOV  V5.D[1], X18
    FMOV  D6, X21
    FMOV  V6.D[1], X22
    FMOV  D7, X11
    FMOV  V7.D[1], X16
    FMOV  D8, X29
    FMOV  V8.D[1], X29
    FMOV  D9, X12
    FMOV  V9.D[1], X29
    FMOV  D10, X23
    FMOV  V10.D[1], X20
    FMOV  D11, X26
    FMOV  V11.D[1], X5
    FMOV  D12, X27
    FMOV  V12.D[1], X29
    FMOV  D13, X3
    FMOV  V13.D[1], X20
    FMOV  D14, X11
    FMOV  V14.D[1], X21
    FMOV  D15, X20
    FMOV  V15.D[1], X11
    FMOV  D16, X29
    FMOV  V16.D[1], X28
    FMOV  D17, X22
    FMOV  V17.D[1], X15
    FMOV  D18, X28
    FMOV  V18.D[1], X23
    FMOV  D19, X16
    FMOV  V19.D[1], X24
    FMOV  D20, X24
    FMOV  V20.D[1], X20
    FMOV  D21, X27
    FMOV  V21.D[1], X24
    FMOV  D22, X23
    FMOV  V22.D[1], X17
    FMOV  D23, X3
    FMOV  V23.D[1], X29
    FMOV  D24, X5
    FMOV  V24.D[1], X28
    FMOV  D25, X11
    FMOV  V25.D[1], X7
    FMOV  D26, X12
    FMOV  V26.D[1], X10
    FMOV  D27, X27
    FMOV  V27.D[1], X7
    FMOV  D28, X22
    FMOV  V28.D[1], X29
    FMOV  D29, X10
    FMOV  V29.D[1], X15
    FMOV  D30, X21
    FMOV  V30.D[1], X5
    FMOV  D31, X7
    FMOV  V31.D[1], X27
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X11, #0xf00, LSL #0
    ADD  X3, X30, X11
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X3]
    LD1R { V15.8H }, [X3]
    ADD  X3, X3, X5, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X3]
    LD1R { V19.16B }, [X3]
    ADD  X3, X3, X5
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X3]
    LD1R { V12.2D }, [X3]
    ADD  X3, X3, X5, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X3]
    LD1R { V9.4S }, [X3]
    ADD  X3, X3, X5, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X3]
    LD1R { V5.8H }, [X3]
    ADD  X3, X3, X5, ASR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X3]
    LD1R { V29.4H }, [X3]
    ADD  X3, X3, X5, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X3]
    LD1R { V24.1D }, [X3]
    ADD  X3, X3, X5
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X3]
    LD1R { V8.2S }, [X3]
    ADD  X3, X3, X5, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X3]
    LD1R { V20.4H }, [X3]
    ADD  X3, X3, X5, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X3]
    LD1R { V28.8B }, [X3]
    ADD  X3, X3, X5, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X3]
    MOV  X20, X3
    LD1R { V11.8B }, [X20], #1
    ADD  X3, X3, X5
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X3]
    MOV  X20, X3
    LD1R { V25.16B }, [X20], #1
    ADD  X3, X3, X5
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X3]
    MOV  X20, X3
    LD1R { V24.8B }, [X20], #1
    ADD  X3, X3, X5, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X3]
    MOV  X20, X3
    LD1R { V4.4H }, [X20], #2
    ADD  X3, X3, X5
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X3]
    MOV  X20, X3
    LD1R { V22.8H }, [X20], #2
    ADD  X3, X3, X5
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X3]
    MOV  X20, X3
    LD1R { V26.2S }, [X20], #4
    ADD  X3, X3, X5, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X3]
    MOV  X20, X3
    LD1R { V26.2S }, [X20], #4
    ADD  X3, X3, X5
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X3]
    MOV  X20, X3
    LD1R { V9.4S }, [X20], #4
    ADD  X3, X3, X5
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X3]
    MOV  X20, X3
    LD1R { V20.1D }, [X20], #8
    ADD  X3, X3, X5, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X3]
    MOV  X20, X3
    LD1R { V22.1D }, [X20], #8
    ADD  X3, X3, X5, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X3]
    MOV  X20, X3
    LD1R { V21.2D }, [X20], #8
    ADD  X3, X3, X5, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X3]
    MOV  X20, X3
    LD1R { V22.4H }, [X20], #2
    ADD  X3, X3, X5
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X3]
    LD1R { V2.16B }, [X3], X19
    ADD  X3, X3, X5, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X3]
    LD1R { V21.16B }, [X3], X19
    ADD  X3, X3, X5
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X3]
    LD1R { V1.2D }, [X3], X19
    ADD  X3, X3, X5
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X3]
    LD1R { V25.4S }, [X3], X19
    ADD  X3, X3, X5, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X3]
    LD1R { V0.8H }, [X3], X19
    ADD  X3, X3, X5, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X3]
    LD1R { V10.4H }, [X3], X19
    ADD  X3, X3, X5, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X3]
    LD1R { V7.1D }, [X3], X19
    ADD  X3, X3, X5
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X3]
    LD1R { V23.2S }, [X3], X19
    ADD  X3, X3, X5, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X3]
    LD1R { V29.4H }, [X3], X19
    ADD  X3, X3, X5
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X3]
    LD1R { V9.8B }, [X3], X19
    ADD  X3, X3, X5, LSR #0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X9, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V0.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V1.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V2.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V5.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V6.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V12.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V15.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, V31.D[1]
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X7, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X17
    FMOV  D3, X18
    FMOV  V3.D[1], X7
    FMOV  D4, X7
    FMOV  V4.D[1], X12
    FMOV  D5, X19
    FMOV  V5.D[1], X20
    FMOV  D6, X9
    FMOV  V6.D[1], X9
    FMOV  D7, X29
    FMOV  V7.D[1], X12
    FMOV  D8, X14
    FMOV  V8.D[1], X12
    FMOV  D9, X9
    FMOV  V9.D[1], X29
    FMOV  D10, X17
    FMOV  V10.D[1], X22
    FMOV  D11, X9
    FMOV  V11.D[1], X5
    FMOV  D12, X7
    FMOV  V12.D[1], X12
    FMOV  D13, X26
    FMOV  V13.D[1], X14
    FMOV  D14, X27
    FMOV  V14.D[1], X26
    FMOV  D15, X3
    FMOV  V15.D[1], X7
    FMOV  D16, X20
    FMOV  V16.D[1], X29
    FMOV  D17, X28
    FMOV  V17.D[1], X14
    FMOV  D18, X9
    FMOV  V18.D[1], X26
    FMOV  D19, X28
    FMOV  V19.D[1], X19
    FMOV  D20, X28
    FMOV  V20.D[1], X23
    FMOV  D21, X26
    FMOV  V21.D[1], X23
    FMOV  D22, X21
    FMOV  V22.D[1], X28
    FMOV  D23, X21
    FMOV  V23.D[1], X12
    FMOV  D24, X4
    FMOV  V24.D[1], X18
    FMOV  D25, X18
    FMOV  V25.D[1], X14
    FMOV  D26, X7
    FMOV  V26.D[1], X16
    FMOV  D27, X26
    FMOV  V27.D[1], X16
    FMOV  D28, X29
    FMOV  V28.D[1], X18
    FMOV  D29, X28
    FMOV  V29.D[1], X7
    FMOV  D30, X19
    FMOV  V30.D[1], X9
    FMOV  D31, X22
    FMOV  V31.D[1], X4
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X9, #0x1400, LSL #0
    ADD  X22, X30, X9, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X22]
    LD1R { V12.4S }, [X22]
    ADD  X22, X22, X5, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X22]
    LD1R { V1.16B }, [X22]
    ADD  X22, X22, X5, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X22]
    LD1R { V7.2D }, [X22]
    ADD  X22, X22, X5
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X22]
    LD1R { V28.4S }, [X22]
    ADD  X22, X22, X5, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X22]
    LD1R { V15.8H }, [X22]
    ADD  X22, X22, X5, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X22]
    LD1R { V5.8B }, [X22]
    ADD  X22, X22, X5, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X22]
    LD1R { V4.1D }, [X22]
    ADD  X22, X22, X5, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X22]
    LD1R { V14.2S }, [X22]
    ADD  X22, X22, X5, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X22]
    LD1R { V25.4H }, [X22]
    ADD  X22, X22, X5
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X22]
    LD1R { V26.8B }, [X22]
    ADD  X22, X22, X5
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X22]
    MOV  X28, X22
    LD1R { V17.8B }, [X28], #1
    ADD  X22, X22, X5
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X22]
    MOV  X28, X22
    LD1R { V6.16B }, [X28], #1
    ADD  X22, X22, X5, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X22]
    MOV  X28, X22
    LD1R { V10.8B }, [X28], #1
    ADD  X22, X22, X5, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X22]
    MOV  X28, X22
    LD1R { V16.4H }, [X28], #2
    ADD  X22, X22, X5, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X22]
    MOV  X28, X22
    LD1R { V12.8H }, [X28], #2
    ADD  X22, X22, X5, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X22]
    MOV  X28, X22
    LD1R { V14.2S }, [X28], #4
    ADD  X22, X22, X5, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X22]
    MOV  X28, X22
    LD1R { V11.2S }, [X28], #4
    ADD  X22, X22, X5
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X22]
    MOV  X28, X22
    LD1R { V18.4S }, [X28], #4
    ADD  X22, X22, X5
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X22]
    MOV  X28, X22
    LD1R { V5.2D }, [X28], #8
    ADD  X22, X22, X5, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X22]
    MOV  X28, X22
    LD1R { V19.1D }, [X28], #8
    ADD  X22, X22, X5, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X22]
    MOV  X28, X22
    LD1R { V9.2D }, [X28], #8
    ADD  X22, X22, X5
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X22]
    MOV  X28, X22
    LD1R { V20.8H }, [X28], #2
    ADD  X22, X22, X5
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X22]
    LD1R { V17.4S }, [X22], X7
    ADD  X22, X22, X5
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X22]
    LD1R { V28.16B }, [X22], X7
    ADD  X22, X22, X5, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X22]
    LD1R { V15.2D }, [X22], X7
    ADD  X22, X22, X5
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X22]
    LD1R { V1.4S }, [X22], X7
    ADD  X22, X22, X5, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X22]
    LD1R { V31.8H }, [X22], X7
    ADD  X22, X22, X5
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X22]
    LD1R { V24.4H }, [X22], X7
    ADD  X22, X22, X5
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X22]
    LD1R { V7.1D }, [X22], X7
    ADD  X22, X22, X5, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X22]
    LD1R { V3.2S }, [X22], X7
    ADD  X22, X22, X5
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X22]
    LD1R { V31.4H }, [X22], X7
    ADD  X22, X22, X5, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X22]
    LD1R { V6.8B }, [X22], X7
    ADD  X22, X22, X5, ASR #0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X2, FPSR
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V0.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D0
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V1.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D1
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V2.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D2
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D3
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D4
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D5
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V6.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D6
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D7
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D8
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V9.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D9
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D10
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D11
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V12.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D12
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D13
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D14
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D15
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D16
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V17.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D17
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V18.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D18
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D19
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D20
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D21
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D22
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V23.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D23
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D24
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D25
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D26
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V27.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D27
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V28.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D28
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V29.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D29
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, V30.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D30
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X2, D31
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X12
    FMOV  D3, X7
    FMOV  V3.D[1], X3
    FMOV  D4, X2
    FMOV  V4.D[1], X24
    FMOV  D5, X4
    FMOV  V5.D[1], X21
    FMOV  D6, X22
    FMOV  V6.D[1], X15
    FMOV  D7, X26
    FMOV  V7.D[1], X15
    FMOV  D8, X7
    FMOV  V8.D[1], X5
    FMOV  D9, X17
    FMOV  V9.D[1], X20
    FMOV  D10, X11
    FMOV  V10.D[1], X22
    FMOV  D11, X16
    FMOV  V11.D[1], X15
    FMOV  D12, X2
    FMOV  V12.D[1], X9
    FMOV  D13, X22
    FMOV  V13.D[1], X3
    FMOV  D14, X21
    FMOV  V14.D[1], X3
    FMOV  D15, X29
    FMOV  V15.D[1], X16
    FMOV  D16, X7
    FMOV  V16.D[1], X19
    FMOV  D17, X4
    FMOV  V17.D[1], X11
    FMOV  D18, X12
    FMOV  V18.D[1], X15
    FMOV  D19, X9
    FMOV  V19.D[1], X11
    FMOV  D20, X4
    FMOV  V20.D[1], X11
    FMOV  D21, X10
    FMOV  V21.D[1], X9
    FMOV  D22, X27
    FMOV  V22.D[1], X9
    FMOV  D23, X2
    FMOV  V23.D[1], X10
    FMOV  D24, X7
    FMOV  V24.D[1], X17
    FMOV  D25, X12
    FMOV  V25.D[1], X26
    FMOV  D26, X3
    FMOV  V26.D[1], X20
    FMOV  D27, X19
    FMOV  V27.D[1], X20
    FMOV  D28, X17
    FMOV  V28.D[1], X23
    FMOV  D29, X15
    FMOV  V29.D[1], X24
    FMOV  D30, X27
    FMOV  V30.D[1], X18
    FMOV  D31, X3
    FMOV  V31.D[1], X5
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X27, #0x1900, LSL #0
    ADD  X11, X30, X27, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X11]
    LD1R { V11.4S }, [X11]
    ADD  X11, X11, X19, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X11]
    LD1R { V12.16B }, [X11]
    ADD  X11, X11, X19, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X11]
    LD1R { V21.2D }, [X11]
    ADD  X11, X11, X19
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X11]
    LD1R { V26.4S }, [X11]
    ADD  X11, X11, X19, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X11]
    LD1R { V12.8H }, [X11]
    ADD  X11, X11, X19
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X11]
    LD1R { V24.8B }, [X11]
    ADD  X11, X11, X19, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X11]
    LD1R { V4.1D }, [X11]
    ADD  X11, X11, X19, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X11]
    LD1R { V11.2S }, [X11]
    ADD  X11, X11, X19
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X11]
    LD1R { V31.4H }, [X11]
    ADD  X11, X11, X19, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X11]
    LD1R { V5.8B }, [X11]
    ADD  X11, X11, X19
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X11]
    MOV  X17, X11
    LD1R { V3.8B }, [X17], #1
    ADD  X11, X11, X19, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X11]
    MOV  X17, X11
    LD1R { V10.16B }, [X17], #1
    ADD  X11, X11, X19, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X11]
    MOV  X17, X11
    LD1R { V12.8B }, [X17], #1
    ADD  X11, X11, X19
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X11]
    MOV  X17, X11
    LD1R { V14.4H }, [X17], #2
    ADD  X11, X11, X19, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X11]
    MOV  X17, X11
    LD1R { V3.8H }, [X17], #2
    ADD  X11, X11, X19
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X11]
    MOV  X17, X11
    LD1R { V2.2S }, [X17], #4
    ADD  X11, X11, X19
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X11]
    MOV  X17, X11
    LD1R { V1.2S }, [X17], #4
    ADD  X11, X11, X19
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X11]
    MOV  X17, X11
    LD1R { V27.4S }, [X17], #4
    ADD  X11, X11, X19, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X11]
    MOV  X17, X11
    LD1R { V4.2D }, [X17], #8
    ADD  X11, X11, X19, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X11]
    MOV  X17, X11
    LD1R { V0.1D }, [X17], #8
    ADD  X11, X11, X19, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X11]
    MOV  X17, X11
    LD1R { V18.2D }, [X17], #8
    ADD  X11, X11, X19, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X11]
    MOV  X17, X11
    LD1R { V23.8H }, [X17], #2
    ADD  X11, X11, X19
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X11]
    LD1R { V28.16B }, [X11], X23
    ADD  X11, X11, X19, LSR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X11]
    LD1R { V8.16B }, [X11], X23
    ADD  X11, X11, X19
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X11]
    LD1R { V6.2D }, [X11], X23
    ADD  X11, X11, X19, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X11]
    LD1R { V27.4S }, [X11], X23
    ADD  X11, X11, X19
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X11]
    LD1R { V25.8H }, [X11], X23
    ADD  X11, X11, X19, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X11]
    LD1R { V21.1D }, [X11], X23
    ADD  X11, X11, X19, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X11]
    LD1R { V5.1D }, [X11], X23
    ADD  X11, X11, X19, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X11]
    LD1R { V4.2S }, [X11], X23
    ADD  X11, X11, X19
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X11]
    LD1R { V0.4H }, [X11], X23
    ADD  X11, X11, X19
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X11]
    LD1R { V16.8B }, [X11], X23
    ADD  X11, X11, X19
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X9, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V6.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V7.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V15.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V23.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V26.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V29.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X5, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X23
    FMOV  D2, X22
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X27
    FMOV  D4, X5
    FMOV  V4.D[1], X7
    FMOV  D5, X18
    FMOV  V5.D[1], X4
    FMOV  D6, X24
    FMOV  V6.D[1], X21
    FMOV  D7, X5
    FMOV  V7.D[1], X20
    FMOV  D8, X5
    FMOV  V8.D[1], X24
    FMOV  D9, X7
    FMOV  V9.D[1], X23
    FMOV  D10, X22
    FMOV  V10.D[1], X17
    FMOV  D11, X14
    FMOV  V11.D[1], X24
    FMOV  D12, X10
    FMOV  V12.D[1], X23
    FMOV  D13, X16
    FMOV  V13.D[1], X29
    FMOV  D14, X14
    FMOV  V14.D[1], X23
    FMOV  D15, X16
    FMOV  V15.D[1], X10
    FMOV  D16, X9
    FMOV  V16.D[1], X15
    FMOV  D17, X29
    FMOV  V17.D[1], X5
    FMOV  D18, X17
    FMOV  V18.D[1], X2
    FMOV  D19, X22
    FMOV  V19.D[1], X17
    FMOV  D20, X20
    FMOV  V20.D[1], X11
    FMOV  D21, X11
    FMOV  V21.D[1], X2
    FMOV  D22, X9
    FMOV  V22.D[1], X9
    FMOV  D23, X17
    FMOV  V23.D[1], X14
    FMOV  D24, X3
    FMOV  V24.D[1], X21
    FMOV  D25, X29
    FMOV  V25.D[1], X22
    FMOV  D26, X14
    FMOV  V26.D[1], X9
    FMOV  D27, X29
    FMOV  V27.D[1], X17
    FMOV  D28, X21
    FMOV  V28.D[1], X27
    FMOV  D29, X22
    FMOV  V29.D[1], X4
    FMOV  D30, X16
    FMOV  V30.D[1], X4
    FMOV  D31, X22
    FMOV  V31.D[1], X11
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X2, #0x1e00, LSL #0
    ADD  X23, X30, X2
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X23]
    LD1R { V11.8H }, [X23]
    ADD  X23, X23, X16, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X23]
    LD1R { V28.16B }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X23]
    LD1R { V29.2D }, [X23]
    ADD  X23, X23, X16, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X23]
    LD1R { V23.4S }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X23]
    LD1R { V28.8H }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X23]
    LD1R { V3.2S }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X23]
    LD1R { V29.1D }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X23]
    LD1R { V18.2S }, [X23]
    ADD  X23, X23, X16, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X23]
    LD1R { V3.4H }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X23]
    LD1R { V0.8B }, [X23]
    ADD  X23, X23, X16
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X23]
    MOV  X27, X23
    LD1R { V27.8B }, [X27], #1
    ADD  X23, X23, X16, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X23]
    MOV  X27, X23
    LD1R { V12.16B }, [X27], #1
    ADD  X23, X23, X16, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X23]
    MOV  X27, X23
    LD1R { V24.8B }, [X27], #1
    ADD  X23, X23, X16, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X23]
    MOV  X27, X23
    LD1R { V7.4H }, [X27], #2
    ADD  X23, X23, X16
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X23]
    MOV  X27, X23
    LD1R { V8.8H }, [X27], #2
    ADD  X23, X23, X16, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X23]
    MOV  X27, X23
    LD1R { V15.2S }, [X27], #4
    ADD  X23, X23, X16, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X23]
    MOV  X27, X23
    LD1R { V6.2S }, [X27], #4
    ADD  X23, X23, X16, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X23]
    MOV  X27, X23
    LD1R { V0.4S }, [X27], #4
    ADD  X23, X23, X16
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X23]
    MOV  X27, X23
    LD1R { V20.2D }, [X27], #8
    ADD  X23, X23, X16, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X23]
    MOV  X27, X23
    LD1R { V31.1D }, [X27], #8
    ADD  X23, X23, X16, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X23]
    MOV  X27, X23
    LD1R { V10.2D }, [X27], #8
    ADD  X23, X23, X16, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X23]
    MOV  X27, X23
    LD1R { V19.4H }, [X27], #2
    ADD  X23, X23, X16, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X23]
    LD1R { V9.16B }, [X23], X7
    ADD  X23, X23, X16, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X23]
    LD1R { V2.16B }, [X23], X7
    ADD  X23, X23, X16, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X23]
    LD1R { V0.2D }, [X23], X7
    ADD  X23, X23, X16, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X23]
    LD1R { V21.4S }, [X23], X7
    ADD  X23, X23, X16
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X23]
    LD1R { V18.8H }, [X23], X7
    ADD  X23, X23, X16, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X23]
    LD1R { V20.1D }, [X23], X7
    ADD  X23, X23, X16, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X23]
    LD1R { V6.1D }, [X23], X7
    ADD  X23, X23, X16
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X23]
    LD1R { V16.2S }, [X23], X7
    ADD  X23, X23, X16, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X23]
    LD1R { V1.4H }, [X23], X7
    ADD  X23, X23, X16, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X23]
    LD1R { V31.8B }, [X23], X7
    ADD  X23, X23, X16, LSR #0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X21, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D0
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D3
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V5.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D5
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D6
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V9.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D10
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V11.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D11
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V12.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V13.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D16
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D17
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V21.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V22.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V23.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D24
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V25.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D25
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V26.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, V30.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X7
    FMOV  V2.D[1], X21
    FMOV  D3, X14
    FMOV  V3.D[1], X17
    FMOV  D4, X28
    FMOV  V4.D[1], X23
    FMOV  D5, X18
    FMOV  V5.D[1], X19
    FMOV  D6, X16
    FMOV  V6.D[1], X16
    FMOV  D7, X2
    FMOV  V7.D[1], X27
    FMOV  D8, X19
    FMOV  V8.D[1], X15
    FMOV  D9, X21
    FMOV  V9.D[1], X5
    FMOV  D10, X23
    FMOV  V10.D[1], X22
    FMOV  D11, X21
    FMOV  V11.D[1], X28
    FMOV  D12, X27
    FMOV  V12.D[1], X12
    FMOV  D13, X19
    FMOV  V13.D[1], X24
    FMOV  D14, X12
    FMOV  V14.D[1], X12
    FMOV  D15, X10
    FMOV  V15.D[1], X4
    FMOV  D16, X27
    FMOV  V16.D[1], X12
    FMOV  D17, X19
    FMOV  V17.D[1], X14
    FMOV  D18, X4
    FMOV  V18.D[1], X4
    FMOV  D19, X18
    FMOV  V19.D[1], X27
    FMOV  D20, X15
    FMOV  V20.D[1], X26
    FMOV  D21, X19
    FMOV  V21.D[1], X19
    FMOV  D22, X29
    FMOV  V22.D[1], X20
    FMOV  D23, X11
    FMOV  V23.D[1], X10
    FMOV  D24, X5
    FMOV  V24.D[1], X11
    FMOV  D25, X19
    FMOV  V25.D[1], X11
    FMOV  D26, X27
    FMOV  V26.D[1], X16
    FMOV  D27, X16
    FMOV  V27.D[1], X15
    FMOV  D28, X20
    FMOV  V28.D[1], X28
    FMOV  D29, X7
    FMOV  V29.D[1], X29
    FMOV  D30, X19
    FMOV  V30.D[1], X7
    FMOV  D31, X19
    FMOV  V31.D[1], X16
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X7, #0x2300, LSL #0
    ADD  X24, X30, X7
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X24]
    LD1R { V17.8H }, [X24]
    ADD  X24, X24, X17, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X24]
    LD1R { V11.16B }, [X24]
    ADD  X24, X24, X17, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X24]
    LD1R { V9.2D }, [X24]
    ADD  X24, X24, X17, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X24]
    LD1R { V14.4S }, [X24]
    ADD  X24, X24, X17, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X24]
    LD1R { V30.8H }, [X24]
    ADD  X24, X24, X17, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X24]
    LD1R { V20.1D }, [X24]
    ADD  X24, X24, X17
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X24]
    LD1R { V3.1D }, [X24]
    ADD  X24, X24, X17
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X24]
    LD1R { V19.2S }, [X24]
    ADD  X24, X24, X17
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X24]
    LD1R { V28.4H }, [X24]
    ADD  X24, X24, X17, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X24]
    LD1R { V26.8B }, [X24]
    ADD  X24, X24, X17, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X24]
    MOV  X11, X24
    LD1R { V18.16B }, [X11], #1
    ADD  X24, X24, X17, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X24]
    MOV  X11, X24
    LD1R { V19.16B }, [X11], #1
    ADD  X24, X24, X17
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X24]
    MOV  X11, X24
    LD1R { V13.8B }, [X11], #1
    ADD  X24, X24, X17
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X24]
    MOV  X11, X24
    LD1R { V16.4H }, [X11], #2
    ADD  X24, X24, X17
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X24]
    MOV  X11, X24
    LD1R { V3.8H }, [X11], #2
    ADD  X24, X24, X17
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X24]
    MOV  X11, X24
    LD1R { V25.2S }, [X11], #4
    ADD  X24, X24, X17, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X24]
    MOV  X11, X24
    LD1R { V17.2S }, [X11], #4
    ADD  X24, X24, X17, ASR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X24]
    MOV  X11, X24
    LD1R { V11.4S }, [X11], #4
    ADD  X24, X24, X17
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X24]
    MOV  X11, X24
    LD1R { V12.2D }, [X11], #8
    ADD  X24, X24, X17
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X24]
    MOV  X11, X24
    LD1R { V31.1D }, [X11], #8
    ADD  X24, X24, X17, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X24]
    MOV  X11, X24
    LD1R { V23.2D }, [X11], #8
    ADD  X24, X24, X17, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X24]
    MOV  X11, X24
    LD1R { V3.8H }, [X11], #2
    ADD  X24, X24, X17
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X24]
    LD1R { V25.2D }, [X24], X20
    ADD  X24, X24, X17, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X24]
    LD1R { V26.16B }, [X24], X20
    ADD  X24, X24, X17
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X24]
    LD1R { V24.2D }, [X24], X20
    ADD  X24, X24, X17
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X24]
    LD1R { V5.4S }, [X24], X20
    ADD  X24, X24, X17, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X24]
    LD1R { V21.8H }, [X24], X20
    ADD  X24, X24, X17, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X24]
    LD1R { V29.8B }, [X24], X20
    ADD  X24, X24, X17, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X24]
    LD1R { V25.1D }, [X24], X20
    ADD  X24, X24, X17
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X24]
    LD1R { V19.2S }, [X24], X20
    ADD  X24, X24, X17, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X24]
    LD1R { V11.4H }, [X24], X20
    ADD  X24, X24, X17, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X24]
    LD1R { V14.8B }, [X24], X20
    ADD  X24, X24, X17, LSR #0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X16, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D0
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D1
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V2.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D2
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V3.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D3
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D4
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D5
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V6.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D6
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V7.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D7
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D8
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D9
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V10.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D10
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D11
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D12
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D13
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D14
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D15
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D16
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D17
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V18.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D18
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D19
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D20
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D21
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D22
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V23.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D23
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V24.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D24
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D25
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V26.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D26
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V27.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D27
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D28
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D29
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, V30.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D30
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X16, D31
    SUB  X18, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X27
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X5
    FMOV  V3.D[1], X3
    FMOV  D4, X24
    FMOV  V4.D[1], X22
    FMOV  D5, X28
    FMOV  V5.D[1], X9
    FMOV  D6, X29
    FMOV  V6.D[1], X26
    FMOV  D7, X28
    FMOV  V7.D[1], X24
    FMOV  D8, X9
    FMOV  V8.D[1], X24
    FMOV  D9, X20
    FMOV  V9.D[1], X2
    FMOV  D10, X10
    FMOV  V10.D[1], X27
    FMOV  D11, X11
    FMOV  V11.D[1], X5
    FMOV  D12, X23
    FMOV  V12.D[1], X15
    FMOV  D13, X11
    FMOV  V13.D[1], X15
    FMOV  D14, X22
    FMOV  V14.D[1], X19
    FMOV  D15, X23
    FMOV  V15.D[1], X5
    FMOV  D16, X20
    FMOV  V16.D[1], X12
    FMOV  D17, X19
    FMOV  V17.D[1], X21
    FMOV  D18, X22
    FMOV  V18.D[1], X4
    FMOV  D19, X4
    FMOV  V19.D[1], X19
    FMOV  D20, X24
    FMOV  V20.D[1], X11
    FMOV  D21, X19
    FMOV  V21.D[1], X21
    FMOV  D22, X15
    FMOV  V22.D[1], X2
    FMOV  D23, X14
    FMOV  V23.D[1], X29
    FMOV  D24, X27
    FMOV  V24.D[1], X10
    FMOV  D25, X17
    FMOV  V25.D[1], X23
    FMOV  D26, X22
    FMOV  V26.D[1], X19
    FMOV  D27, X23
    FMOV  V27.D[1], X26
    FMOV  D28, X14
    FMOV  V28.D[1], X3
    FMOV  D29, X22
    FMOV  V29.D[1], X16
    FMOV  D30, X24
    FMOV  V30.D[1], X29
    FMOV  D31, X26
    FMOV  V31.D[1], X7
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X15, #0x2800, LSL #0
    ADD  X12, X30, X15, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X12]
    LD1R { V12.8H }, [X12]
    ADD  X12, X12, X19
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X12]
    LD1R { V23.16B }, [X12]
    ADD  X12, X12, X19, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X12]
    LD1R { V19.2D }, [X12]
    ADD  X12, X12, X19, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X12]
    LD1R { V12.4S }, [X12]
    ADD  X12, X12, X19
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X12]
    LD1R { V23.8H }, [X12]
    ADD  X12, X12, X19, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X12]
    LD1R { V28.2S }, [X12]
    ADD  X12, X12, X19, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X12]
    LD1R { V16.1D }, [X12]
    ADD  X12, X12, X19, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X12]
    LD1R { V10.2S }, [X12]
    ADD  X12, X12, X19
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X12]
    LD1R { V6.4H }, [X12]
    ADD  X12, X12, X19, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X12]
    LD1R { V27.8B }, [X12]
    ADD  X12, X12, X19, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X12]
    MOV  X28, X12
    LD1R { V1.16B }, [X28], #1
    ADD  X12, X12, X19, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X12]
    MOV  X28, X12
    LD1R { V25.16B }, [X28], #1
    ADD  X12, X12, X19, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X12]
    MOV  X28, X12
    LD1R { V19.8B }, [X28], #1
    ADD  X12, X12, X19, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X12]
    MOV  X28, X12
    LD1R { V8.4H }, [X28], #2
    ADD  X12, X12, X19, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X12]
    MOV  X28, X12
    LD1R { V0.8H }, [X28], #2
    ADD  X12, X12, X19
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X12]
    MOV  X28, X12
    LD1R { V30.2S }, [X28], #4
    ADD  X12, X12, X19
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X12]
    MOV  X28, X12
    LD1R { V28.2S }, [X28], #4
    ADD  X12, X12, X19, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X12]
    MOV  X28, X12
    LD1R { V31.4S }, [X28], #4
    ADD  X12, X12, X19, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X12]
    MOV  X28, X12
    LD1R { V3.1D }, [X28], #8
    ADD  X12, X12, X19, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X12]
    MOV  X28, X12
    LD1R { V24.1D }, [X28], #8
    ADD  X12, X12, X19, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X12]
    MOV  X28, X12
    LD1R { V18.2D }, [X28], #8
    ADD  X12, X12, X19
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X12]
    MOV  X28, X12
    LD1R { V0.8H }, [X28], #2
    ADD  X12, X12, X19
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X12]
    LD1R { V26.4S }, [X12], X26
    ADD  X12, X12, X19, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X12]
    LD1R { V31.16B }, [X12], X26
    ADD  X12, X12, X19, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X12]
    LD1R { V5.2D }, [X12], X26
    ADD  X12, X12, X19
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X12]
    LD1R { V27.4S }, [X12], X26
    ADD  X12, X12, X19
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X12]
    LD1R { V30.8H }, [X12], X26
    ADD  X12, X12, X19, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X12]
    LD1R { V6.8B }, [X12], X26
    ADD  X12, X12, X19, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X12]
    LD1R { V17.1D }, [X12], X26
    ADD  X12, X12, X19, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X12]
    LD1R { V10.2S }, [X12], X26
    ADD  X12, X12, X19, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X12]
    LD1R { V6.4H }, [X12], X26
    ADD  X12, X12, X19
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X12]
    LD1R { V18.8B }, [X12], X26
    ADD  X12, X12, X19
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X16, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D0
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D1
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V2.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D2
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D3
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D4
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D5
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D6
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V7.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D7
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D8
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D9
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D10
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V11.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D11
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D12
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V13.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D13
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V14.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D14
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D15
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D16
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D17
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D18
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D19
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V20.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D20
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D21
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D22
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V23.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D23
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D24
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V25.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D25
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V26.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D26
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V27.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D27
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D28
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V29.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D29
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V30.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D30
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, V31.D[1]
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X16, D31
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP01_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X21
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X15
    FMOV  D3, X11
    FMOV  V3.D[1], X4
    FMOV  D4, X29
    FMOV  V4.D[1], X22
    FMOV  D5, X3
    FMOV  V5.D[1], X19
    FMOV  D6, X19
    FMOV  V6.D[1], X2
    FMOV  D7, X4
    FMOV  V7.D[1], X2
    FMOV  D8, X19
    FMOV  V8.D[1], X17
    FMOV  D9, X28
    FMOV  V9.D[1], X2
    FMOV  D10, X29
    FMOV  V10.D[1], X12
    FMOV  D11, X11
    FMOV  V11.D[1], X19
    FMOV  D12, X29
    FMOV  V12.D[1], X15
    FMOV  D13, X2
    FMOV  V13.D[1], X7
    FMOV  D14, X26
    FMOV  V14.D[1], X12
    FMOV  D15, X14
    FMOV  V15.D[1], X29
    FMOV  D16, X5
    FMOV  V16.D[1], X2
    FMOV  D17, X21
    FMOV  V17.D[1], X15
    FMOV  D18, X29
    FMOV  V18.D[1], X29
    FMOV  D19, X2
    FMOV  V19.D[1], X23
    FMOV  D20, X4
    FMOV  V20.D[1], X11
    FMOV  D21, X18
    FMOV  V21.D[1], X23
    FMOV  D22, X10
    FMOV  V22.D[1], X20
    FMOV  D23, X10
    FMOV  V23.D[1], X10
    FMOV  D24, X21
    FMOV  V24.D[1], X18
    FMOV  D25, X7
    FMOV  V25.D[1], X11
    FMOV  D26, X28
    FMOV  V26.D[1], X26
    FMOV  D27, X16
    FMOV  V27.D[1], X5
    FMOV  D28, X2
    FMOV  V28.D[1], X2
    FMOV  D29, X7
    FMOV  V29.D[1], X3
    FMOV  D30, X29
    FMOV  V30.D[1], X11
    FMOV  D31, X15
    FMOV  V31.D[1], X23
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X3, #0x2d00, LSL #0
    ADD  X5, X30, X3
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X5]
    LD1R { V26.16B }, [X5]
    ADD  X5, X5, X17
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X5]
    LD1R { V10.16B }, [X5]
    ADD  X5, X5, X17, LSR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X5]
    LD1R { V8.2D }, [X5]
    ADD  X5, X5, X17, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X5]
    LD1R { V26.4S }, [X5]
    ADD  X5, X5, X17
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X5]
    LD1R { V4.8H }, [X5]
    ADD  X5, X5, X17, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X5]
    LD1R { V26.8B }, [X5]
    ADD  X5, X5, X17
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X5]
    LD1R { V6.1D }, [X5]
    ADD  X5, X5, X17, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X5]
    LD1R { V28.2S }, [X5]
    ADD  X5, X5, X17, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X5]
    LD1R { V11.4H }, [X5]
    ADD  X5, X5, X17, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X5]
    LD1R { V21.8B }, [X5]
    ADD  X5, X5, X17, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X5]
    MOV  X19, X5
    LD1R { V26.16B }, [X19], #1
    ADD  X5, X5, X17, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X5]
    MOV  X19, X5
    LD1R { V25.16B }, [X19], #1
    ADD  X5, X5, X17, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X5]
    MOV  X19, X5
    LD1R { V15.8B }, [X19], #1
    ADD  X5, X5, X17, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X5]
    MOV  X19, X5
    LD1R { V2.4H }, [X19], #2
    ADD  X5, X5, X17
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X5]
    MOV  X19, X5
    LD1R { V26.8H }, [X19], #2
    ADD  X5, X5, X17, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X5]
    MOV  X19, X5
    LD1R { V13.2S }, [X19], #4
    ADD  X5, X5, X17
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X5]
    MOV  X19, X5
    LD1R { V8.2S }, [X19], #4
    ADD  X5, X5, X17, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X5]
    MOV  X19, X5
    LD1R { V31.4S }, [X19], #4
    ADD  X5, X5, X17, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X5]
    MOV  X19, X5
    LD1R { V24.2D }, [X19], #8
    ADD  X5, X5, X17
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X5]
    MOV  X19, X5
    LD1R { V28.1D }, [X19], #8
    ADD  X5, X5, X17
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X5]
    MOV  X19, X5
    LD1R { V9.2D }, [X19], #8
    ADD  X5, X5, X17
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X5]
    MOV  X19, X5
    LD1R { V8.4H }, [X19], #2
    ADD  X5, X5, X17, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X5]
    LD1R { V29.8H }, [X5], X23
    ADD  X5, X5, X17, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X5]
    LD1R { V13.16B }, [X5], X23
    ADD  X5, X5, X17
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X5]
    LD1R { V27.2D }, [X5], X23
    ADD  X5, X5, X17
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X5]
    LD1R { V14.4S }, [X5], X23
    ADD  X5, X5, X17, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X5]
    LD1R { V11.8H }, [X5], X23
    ADD  X5, X5, X17, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X5]
    LD1R { V19.4H }, [X5], X23
    ADD  X5, X5, X17, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X5]
    LD1R { V0.1D }, [X5], X23
    ADD  X5, X5, X17, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X5]
    LD1R { V3.2S }, [X5], X23
    ADD  X5, X5, X17, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X5]
    LD1R { V13.4H }, [X5], X23
    ADD  X5, X5, X17
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X5]
    LD1R { V9.8B }, [X5], X23
    ADD  X5, X5, X17
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X7, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D0
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V1.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D1
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D2
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D3
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V4.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D4
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V5.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D5
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D6
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V7.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D7
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D8
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D9
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D10
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D11
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V12.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D12
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D13
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V14.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D14
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D15
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V16.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D16
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V17.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D17
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V18.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D18
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D19
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V20.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D20
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D21
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V22.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D22
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V23.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D23
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V24.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D24
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V25.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D25
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V26.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D26
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V27.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D27
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D28
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V29.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D29
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V30.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D30
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, V31.D[1]
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X7, D31
    SUB  X15, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP01_TestFail

AdvsimdLoadDeprecatedP01_TestEnd:
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
AdvsimdLoadDeprecatedP01_TestFail:
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
