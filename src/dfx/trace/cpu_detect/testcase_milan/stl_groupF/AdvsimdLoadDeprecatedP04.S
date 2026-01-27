.global AdvsimdLoadDeprecatedP04

.text
.p2align 4

AdvsimdLoadDeprecatedP04:

AdvsimdLoadDeprecatedP04_TestBegin:
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
    MOVZ  X2, #0xd184, LSL #0
    MOVK  X2, #0x5282, LSL #16
    MOVK  X2, #0x86d2, LSL #32
    MOVK  X2, #0x77e3, LSL #48
    MOVZ  X3, #0x8df3, LSL #0
    MOVK  X3, #0x938c, LSL #16
    MOVK  X3, #0xb768, LSL #32
    MOVK  X3, #0xde43, LSL #48
    MOVZ  X4, #0x8a43, LSL #0
    MOVK  X4, #0xeab6, LSL #16
    MOVK  X4, #0xff18, LSL #32
    MOVK  X4, #0xea64, LSL #48
    MOVZ  X5, #0x170c, LSL #0
    MOVK  X5, #0xab7e, LSL #16
    MOVK  X5, #0x1d91, LSL #32
    MOVK  X5, #0xe304, LSL #48
    MOVZ  X6, #0xa839, LSL #0
    MOVK  X6, #0x5e22, LSL #16
    MOVK  X6, #0x94ba, LSL #32
    MOVK  X6, #0x67f0, LSL #48
    MOVZ  X7, #0x233e, LSL #0
    MOVK  X7, #0x29fb, LSL #16
    MOVK  X7, #0xd497, LSL #32
    MOVK  X7, #0xe1e7, LSL #48
    MOVZ  X8, #0xff48, LSL #0
    MOVK  X8, #0xe0d0, LSL #16
    MOVK  X8, #0x150f, LSL #32
    MOVK  X8, #0x8897, LSL #48
    MOVZ  X9, #0x91c8, LSL #0
    MOVK  X9, #0x43e, LSL #16
    MOVK  X9, #0x9af3, LSL #32
    MOVK  X9, #0xac1c, LSL #48
    MOVZ  X11, #0x87f4, LSL #0
    MOVK  X11, #0x3889, LSL #16
    MOVK  X11, #0x7eca, LSL #32
    MOVK  X11, #0x37d4, LSL #48
    MOVZ  X12, #0x3ac3, LSL #0
    MOVK  X12, #0x6f5, LSL #16
    MOVK  X12, #0xe3be, LSL #32
    MOVK  X12, #0x87b5, LSL #48
    MOVZ  X13, #0x2b74, LSL #0
    MOVK  X13, #0x5cda, LSL #16
    MOVK  X13, #0x3334, LSL #32
    MOVK  X13, #0x5428, LSL #48
    MOVZ  X14, #0xbe97, LSL #0
    MOVK  X14, #0x1f70, LSL #16
    MOVK  X14, #0x47c9, LSL #32
    MOVK  X14, #0x6549, LSL #48
    MOVZ  X15, #0x44ed, LSL #0
    MOVK  X15, #0xc783, LSL #16
    MOVK  X15, #0x2680, LSL #32
    MOVK  X15, #0x4d79, LSL #48
    MOVZ  X16, #0x80a1, LSL #0
    MOVK  X16, #0x32a8, LSL #16
    MOVK  X16, #0xd081, LSL #32
    MOVK  X16, #0x817b, LSL #48
    MOVZ  X17, #0x8b14, LSL #0
    MOVK  X17, #0xb7fb, LSL #16
    MOVK  X17, #0x4a03, LSL #32
    MOVK  X17, #0x707c, LSL #48
    MOVZ  X19, #0x8bb2, LSL #0
    MOVK  X19, #0x6589, LSL #16
    MOVK  X19, #0x682b, LSL #32
    MOVK  X19, #0xecce, LSL #48
    MOVZ  X20, #0xc407, LSL #0
    MOVK  X20, #0x61b9, LSL #16
    MOVK  X20, #0xb510, LSL #32
    MOVK  X20, #0x4b3c, LSL #48
    MOVZ  X21, #0x86ff, LSL #0
    MOVK  X21, #0xf376, LSL #16
    MOVK  X21, #0x2529, LSL #32
    MOVK  X21, #0xa4d3, LSL #48
    MOVZ  X22, #0xfbdd, LSL #0
    MOVK  X22, #0xe2d5, LSL #16
    MOVK  X22, #0x2b10, LSL #32
    MOVK  X22, #0xc5b7, LSL #48
    MOVZ  X23, #0xc2ac, LSL #0
    MOVK  X23, #0x6203, LSL #16
    MOVK  X23, #0x7359, LSL #32
    MOVK  X23, #0xc0b, LSL #48
    MOVZ  X25, #0x42fd, LSL #0
    MOVK  X25, #0x6d7c, LSL #16
    MOVK  X25, #0x8d8b, LSL #32
    MOVK  X25, #0x5e59, LSL #48
    MOVZ  X26, #0x8a59, LSL #0
    MOVK  X26, #0x3e35, LSL #16
    MOVK  X26, #0xc5c2, LSL #32
    MOVK  X26, #0x2f51, LSL #48
    MOVZ  X27, #0xe3b9, LSL #0
    MOVK  X27, #0xfe07, LSL #16
    MOVK  X27, #0x3153, LSL #32
    MOVK  X27, #0xae3f, LSL #48
    MOVZ  X28, #0xe499, LSL #0
    MOVK  X28, #0xdde3, LSL #16
    MOVK  X28, #0x9a0d, LSL #32
    MOVK  X28, #0xb5e7, LSL #48
    MOVZ  X15, #0x93ce, LSL #0
    MOVK  X15, #0x3724, LSL #16
    MOVK  X15, #0xf160, LSL #32
    MOVK  X15, #0xfb03, LSL #48
    MSR  FPCR, X15
    MOVZ  X15, #0xc8e3, LSL #0
    MOVK  X15, #0xa053, LSL #16
    MOVK  X15, #0xa68f, LSL #32
    MOVK  X15, #0xd0e7, LSL #48
    MSR  FPSR, X15
    MRS  X13, FPSR
    MOVZ  X21, #0xff60, LSL #0
    MOVK  X21, #0x7ff, LSL #16
    MOVK  X21, #0xffff, LSL #32
    MOVK  X21, #0xffff, LSL #48
    AND  X13, X13, X21
    MOVZ  X21, #0x0, LSL #0
    ORR  X13, X13, X21
    MSR  FPSR, X13
    ISB  SY
    ANDS  W20, W15, #0xffffff8f
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
    FMOV  D0, X21
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X25
    FMOV  V2.D[1], X26
    FMOV  D3, X27
    FMOV  V3.D[1], X8
    FMOV  D4, X5
    FMOV  V4.D[1], X11
    FMOV  D5, X2
    FMOV  V5.D[1], X13
    FMOV  D6, X13
    FMOV  V6.D[1], X23
    FMOV  D7, X11
    FMOV  V7.D[1], X19
    FMOV  D8, X16
    FMOV  V8.D[1], X13
    FMOV  D9, X14
    FMOV  V9.D[1], X6
    FMOV  D10, X21
    FMOV  V10.D[1], X7
    FMOV  D11, X2
    FMOV  V11.D[1], X23
    FMOV  D12, X16
    FMOV  V12.D[1], X28
    FMOV  D13, X15
    FMOV  V13.D[1], X21
    FMOV  D14, X6
    FMOV  V14.D[1], X12
    FMOV  D15, X25
    FMOV  V15.D[1], X2
    FMOV  D16, X20
    FMOV  V16.D[1], X22
    FMOV  D17, X22
    FMOV  V17.D[1], X4
    FMOV  D18, X16
    FMOV  V18.D[1], X2
    FMOV  D19, X23
    FMOV  V19.D[1], X15
    FMOV  D20, X20
    FMOV  V20.D[1], X20
    FMOV  D21, X16
    FMOV  V21.D[1], X4
    FMOV  D22, X2
    FMOV  V22.D[1], X3
    FMOV  D23, X28
    FMOV  V23.D[1], X28
    FMOV  D24, X17
    FMOV  V24.D[1], X22
    FMOV  D25, X21
    FMOV  V25.D[1], X21
    FMOV  D26, X2
    FMOV  V26.D[1], X3
    FMOV  D27, X16
    FMOV  V27.D[1], X14
    FMOV  D28, X16
    FMOV  V28.D[1], X4
    FMOV  D29, X16
    FMOV  V29.D[1], X19
    FMOV  D30, X5
    FMOV  V30.D[1], X25
    FMOV  D31, X21
    FMOV  V31.D[1], X2
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X19, #0x0, LSL #0
    ADD  X25, X30, X19, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X25]
    LD4R { V18.4S, V19.4S, V20.4S, V21.4S }, [X25]
    ADD  X25, X25, X7, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X25]
    LD4R { V4.16B, V5.16B, V6.16B, V7.16B }, [X25]
    ADD  X25, X25, X7, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X25]
    LD4R { V21.2D, V22.2D, V23.2D, V24.2D }, [X25]
    ADD  X25, X25, X7, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X25]
    LD4R { V21.4S, V22.4S, V23.4S, V24.4S }, [X25]
    ADD  X25, X25, X7, ASR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X25]
    LD4R { V10.8H, V11.8H, V12.8H, V13.8H }, [X25]
    ADD  X25, X25, X7, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X25]
    LD4R { V22.4H, V23.4H, V24.4H, V25.4H }, [X25]
    ADD  X25, X25, X7, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X25]
    LD4R { V0.1D, V1.1D, V2.1D, V3.1D }, [X25]
    ADD  X25, X25, X7, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X25]
    LD4R { V18.2S, V19.2S, V20.2S, V21.2S }, [X25]
    ADD  X25, X25, X7
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X25]
    LD4R { V20.4H, V21.4H, V22.4H, V23.4H }, [X25]
    ADD  X25, X25, X7, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X25]
    LD4R { V0.8B, V1.8B, V2.8B, V3.8B }, [X25]
    ADD  X25, X25, X7
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X25]
    MOV  X8, X25
    LD4R { V14.2S, V15.2S, V16.2S, V17.2S }, [X8], #16
    ADD  X25, X25, X7
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X25]
    MOV  X8, X25
    LD4R { V20.2S, V21.2S, V22.2S, V23.2S }, [X8], #16
    ADD  X25, X25, X7, ASR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X25]
    MOV  X8, X25
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X8], #16
    ADD  X25, X25, X7, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X25]
    MOV  X8, X25
    LD4R { V29.1D, V30.1D, V31.1D, V0.1D }, [X8], #32
    ADD  X25, X25, X7, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X25]
    MOV  X8, X25
    LD4R { V10.1D, V11.1D, V12.1D, V13.1D }, [X8], #32
    ADD  X25, X25, X7, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X25]
    MOV  X8, X25
    LD4R { V20.2D, V21.2D, V22.2D, V23.2D }, [X8], #32
    ADD  X25, X25, X7, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X25]
    MOV  X8, X25
    LD4R { V10.16B, V11.16B, V12.16B, V13.16B }, [X8], #4
    ADD  X25, X25, X7
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X25]
    MOV  X8, X25
    LD4R { V27.16B, V28.16B, V29.16B, V30.16B }, [X8], #4
    ADD  X25, X25, X7, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X25]
    MOV  X8, X25
    LD4R { V10.8B, V11.8B, V12.8B, V13.8B }, [X8], #4
    ADD  X25, X25, X7, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X25]
    MOV  X8, X25
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X8], #8
    ADD  X25, X25, X7
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X25]
    MOV  X8, X25
    LD4R { V14.8H, V15.8H, V16.8H, V17.8H }, [X8], #8
    ADD  X25, X25, X7, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X25]
    MOV  X8, X25
    LD4R { V12.4H, V13.4H, V14.4H, V15.4H }, [X8], #8
    ADD  X25, X25, X7, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X25]
    LD4R { V6.4S, V7.4S, V8.4S, V9.4S }, [X25], X12
    ADD  X25, X25, X7, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X25]
    LD4R { V16.16B, V17.16B, V18.16B, V19.16B }, [X25], X12
    ADD  X25, X25, X7, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X25]
    LD4R { V27.2D, V28.2D, V29.2D, V30.2D }, [X25], X12
    ADD  X25, X25, X7, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X25]
    LD4R { V20.4S, V21.4S, V22.4S, V23.4S }, [X25], X12
    ADD  X25, X25, X7
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X25]
    LD4R { V15.8H, V16.8H, V17.8H, V18.8H }, [X25], X12
    ADD  X25, X25, X7
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X25]
    LD4R { V23.4H, V24.4H, V25.4H, V26.4H }, [X25], X12
    ADD  X25, X25, X7
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X25]
    LD4R { V27.1D, V28.1D, V29.1D, V30.1D }, [X25], X12
    ADD  X25, X25, X7, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X25]
    LD4R { V6.2S, V7.2S, V8.2S, V9.2S }, [X25], X12
    ADD  X25, X25, X7, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X25]
    LD4R { V3.4H, V4.4H, V5.4H, V6.4H }, [X25], X12
    ADD  X25, X25, X7, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X25]
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X25], X12
    ADD  X25, X25, X7, ASR #0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X4, FPSR
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D0
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D1
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D2
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V3.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D3
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D4
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D5
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V6.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D6
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D7
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V8.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D8
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V9.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D9
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D10
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D11
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V12.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D12
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V13.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D13
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D14
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D15
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, V16.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D16
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, V17.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D17
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D18
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, V19.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D19
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D20
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, V21.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D21
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D22
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D23
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D24
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D25
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D26
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D27
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V28.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D28
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D29
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V30.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D30
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X4, D31
    SUB  X15, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X21
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X15
    FMOV  V3.D[1], X12
    FMOV  D4, X27
    FMOV  V4.D[1], X25
    FMOV  D5, X4
    FMOV  V5.D[1], X25
    FMOV  D6, X27
    FMOV  V6.D[1], X12
    FMOV  D7, X27
    FMOV  V7.D[1], X11
    FMOV  D8, X22
    FMOV  V8.D[1], X21
    FMOV  D9, X28
    FMOV  V9.D[1], X16
    FMOV  D10, X9
    FMOV  V10.D[1], X7
    FMOV  D11, X25
    FMOV  V11.D[1], X9
    FMOV  D12, X22
    FMOV  V12.D[1], X14
    FMOV  D13, X17
    FMOV  V13.D[1], X15
    FMOV  D14, X17
    FMOV  V14.D[1], X22
    FMOV  D15, X11
    FMOV  V15.D[1], X22
    FMOV  D16, X5
    FMOV  V16.D[1], X17
    FMOV  D17, X9
    FMOV  V17.D[1], X5
    FMOV  D18, X13
    FMOV  V18.D[1], X8
    FMOV  D19, X8
    FMOV  V19.D[1], X26
    FMOV  D20, X21
    FMOV  V20.D[1], X13
    FMOV  D21, X22
    FMOV  V21.D[1], X28
    FMOV  D22, X7
    FMOV  V22.D[1], X28
    FMOV  D23, X4
    FMOV  V23.D[1], X4
    FMOV  D24, X5
    FMOV  V24.D[1], X28
    FMOV  D25, X27
    FMOV  V25.D[1], X12
    FMOV  D26, X4
    FMOV  V26.D[1], X23
    FMOV  D27, X28
    FMOV  V27.D[1], X13
    FMOV  D28, X11
    FMOV  V28.D[1], X3
    FMOV  D29, X20
    FMOV  V29.D[1], X8
    FMOV  D30, X20
    FMOV  V30.D[1], X9
    FMOV  D31, X19
    FMOV  V31.D[1], X15
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X9, #0x40, LSL #0
    MOVZ  X17, #0x500, LSL #0
    ADD  X13, X30, X17, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X13]
    LD4R { V25.4S, V26.4S, V27.4S, V28.4S }, [X13]
    ADD  X13, X13, X9
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X13]
    LD4R { V20.16B, V21.16B, V22.16B, V23.16B }, [X13]
    ADD  X13, X13, X9, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X13]
    LD4R { V8.2D, V9.2D, V10.2D, V11.2D }, [X13]
    ADD  X13, X13, X9, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X13]
    LD4R { V12.4S, V13.4S, V14.4S, V15.4S }, [X13]
    ADD  X13, X13, X9, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X13]
    LD4R { V12.8H, V13.8H, V14.8H, V15.8H }, [X13]
    ADD  X13, X13, X9, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X13]
    LD4R { V8.8B, V9.8B, V10.8B, V11.8B }, [X13]
    ADD  X13, X13, X9
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X13]
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X13]
    ADD  X13, X13, X9, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X13]
    LD4R { V10.2S, V11.2S, V12.2S, V13.2S }, [X13]
    ADD  X13, X13, X9, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X13]
    LD4R { V7.4H, V8.4H, V9.4H, V10.4H }, [X13]
    ADD  X13, X13, X9, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X13]
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X13]
    ADD  X13, X13, X9, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X13]
    MOV  X2, X13
    LD4R { V15.4S, V16.4S, V17.4S, V18.4S }, [X2], #16
    ADD  X13, X13, X9
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X13]
    MOV  X2, X13
    LD4R { V4.2S, V5.2S, V6.2S, V7.2S }, [X2], #16
    ADD  X13, X13, X9, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X13]
    MOV  X2, X13
    LD4R { V6.4S, V7.4S, V8.4S, V9.4S }, [X2], #16
    ADD  X13, X13, X9, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X13]
    MOV  X2, X13
    LD4R { V9.2D, V10.2D, V11.2D, V12.2D }, [X2], #32
    ADD  X13, X13, X9
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X13]
    MOV  X2, X13
    LD4R { V16.1D, V17.1D, V18.1D, V19.1D }, [X2], #32
    ADD  X13, X13, X9, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X13]
    MOV  X2, X13
    LD4R { V25.2D, V26.2D, V27.2D, V28.2D }, [X2], #32
    ADD  X13, X13, X9
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X13]
    MOV  X2, X13
    LD4R { V23.16B, V24.16B, V25.16B, V26.16B }, [X2], #4
    ADD  X13, X13, X9, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X13]
    MOV  X2, X13
    LD4R { V24.16B, V25.16B, V26.16B, V27.16B }, [X2], #4
    ADD  X13, X13, X9, LSR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X13]
    MOV  X2, X13
    LD4R { V4.8B, V5.8B, V6.8B, V7.8B }, [X2], #4
    ADD  X13, X13, X9
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X13]
    MOV  X2, X13
    LD4R { V16.4H, V17.4H, V18.4H, V19.4H }, [X2], #8
    ADD  X13, X13, X9, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X13]
    MOV  X2, X13
    LD4R { V9.8H, V10.8H, V11.8H, V12.8H }, [X2], #8
    ADD  X13, X13, X9
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X13]
    MOV  X2, X13
    LD4R { V16.8H, V17.8H, V18.8H, V19.8H }, [X2], #8
    ADD  X13, X13, X9, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X13]
    LD4R { V16.16B, V17.16B, V18.16B, V19.16B }, [X13], X4
    ADD  X13, X13, X9, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X13]
    LD4R { V4.16B, V5.16B, V6.16B, V7.16B }, [X13], X4
    ADD  X13, X13, X9, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X13]
    LD4R { V23.2D, V24.2D, V25.2D, V26.2D }, [X13], X4
    ADD  X13, X13, X9, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X13]
    LD4R { V10.4S, V11.4S, V12.4S, V13.4S }, [X13], X4
    ADD  X13, X13, X9
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X13]
    LD4R { V25.8H, V26.8H, V27.8H, V28.8H }, [X13], X4
    ADD  X13, X13, X9, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X13]
    LD4R { V31.8B, V0.8B, V1.8B, V2.8B }, [X13], X4
    ADD  X13, X13, X9, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X13]
    LD4R { V16.1D, V17.1D, V18.1D, V19.1D }, [X13], X4
    ADD  X13, X13, X9
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X13]
    LD4R { V4.2S, V5.2S, V6.2S, V7.2S }, [X13], X4
    ADD  X13, X13, X9, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X13]
    LD4R { V7.4H, V8.4H, V9.4H, V10.4H }, [X13], X4
    ADD  X13, X13, X9, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X13]
    LD4R { V30.8B, V31.8B, V0.8B, V1.8B }, [X13], X4
    ADD  X13, X13, X9, LSR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X23, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X23, FPSR
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V0.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D0
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V1.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D1
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D2
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V3.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D3
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D4
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D5
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D6
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V7.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D7
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D8
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D9
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D10
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V11.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D11
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V12.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D12
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V13.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D13
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V14.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D14
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V15.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D15
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D16
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V17.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D17
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V18.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D18
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V19.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D19
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V20.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D20
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V21.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D21
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D22
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V23.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D23
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V24.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D24
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V25.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D25
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V26.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D26
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V27.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D27
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V28.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D28
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, V29.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D29
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D30
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X23, D31
    SUB  X12, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D0, X22
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X6
    FMOV  D3, X12
    FMOV  V3.D[1], X27
    FMOV  D4, X4
    FMOV  V4.D[1], X4
    FMOV  D5, X27
    FMOV  V5.D[1], X3
    FMOV  D6, X27
    FMOV  V6.D[1], X5
    FMOV  D7, X20
    FMOV  V7.D[1], X28
    FMOV  D8, X12
    FMOV  V8.D[1], X15
    FMOV  D9, X25
    FMOV  V9.D[1], X26
    FMOV  D10, X13
    FMOV  V10.D[1], X19
    FMOV  D11, X22
    FMOV  V11.D[1], X21
    FMOV  D12, X2
    FMOV  V12.D[1], X23
    FMOV  D13, X21
    FMOV  V13.D[1], X28
    FMOV  D14, X25
    FMOV  V14.D[1], X15
    FMOV  D15, X23
    FMOV  V15.D[1], X28
    FMOV  D16, X19
    FMOV  V16.D[1], X8
    FMOV  D17, X15
    FMOV  V17.D[1], X12
    FMOV  D18, X27
    FMOV  V18.D[1], X13
    FMOV  D19, X16
    FMOV  V19.D[1], X23
    FMOV  D20, X9
    FMOV  V20.D[1], X16
    FMOV  D21, X11
    FMOV  V21.D[1], X4
    FMOV  D22, X28
    FMOV  V22.D[1], X6
    FMOV  D23, X15
    FMOV  V23.D[1], X7
    FMOV  D24, X6
    FMOV  V24.D[1], X8
    FMOV  D25, X5
    FMOV  V25.D[1], X12
    FMOV  D26, X28
    FMOV  V26.D[1], X8
    FMOV  D27, X4
    FMOV  V27.D[1], X9
    FMOV  D28, X25
    FMOV  V28.D[1], X15
    FMOV  D29, X6
    FMOV  V29.D[1], X19
    FMOV  D30, X15
    FMOV  V30.D[1], X6
    FMOV  D31, X20
    FMOV  V31.D[1], X8
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X14, #0xa00, LSL #0
    ADD  X19, X30, X14
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X19]
    LD4R { V21.16B, V22.16B, V23.16B, V24.16B }, [X19]
    ADD  X19, X19, X4, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X19]
    LD4R { V15.16B, V16.16B, V17.16B, V18.16B }, [X19]
    ADD  X19, X19, X4, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X19]
    LD4R { V20.2D, V21.2D, V22.2D, V23.2D }, [X19]
    ADD  X19, X19, X4, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X19]
    LD4R { V26.4S, V27.4S, V28.4S, V29.4S }, [X19]
    ADD  X19, X19, X4, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X19]
    LD4R { V21.8H, V22.8H, V23.8H, V24.8H }, [X19]
    ADD  X19, X19, X4, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X19]
    LD4R { V21.4H, V22.4H, V23.4H, V24.4H }, [X19]
    ADD  X19, X19, X4
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X19]
    LD4R { V25.1D, V26.1D, V27.1D, V28.1D }, [X19]
    ADD  X19, X19, X4, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X19]
    LD4R { V30.2S, V31.2S, V0.2S, V1.2S }, [X19]
    ADD  X19, X19, X4, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X19]
    LD4R { V0.4H, V1.4H, V2.4H, V3.4H }, [X19]
    ADD  X19, X19, X4, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X19]
    LD4R { V24.8B, V25.8B, V26.8B, V27.8B }, [X19]
    ADD  X19, X19, X4, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X19]
    MOV  X6, X19
    LD4R { V30.4S, V31.4S, V0.4S, V1.4S }, [X6], #16
    ADD  X19, X19, X4, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X19]
    MOV  X6, X19
    LD4R { V26.2S, V27.2S, V28.2S, V29.2S }, [X6], #16
    ADD  X19, X19, X4
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X19]
    MOV  X6, X19
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X6], #16
    ADD  X19, X19, X4, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X19]
    MOV  X6, X19
    LD4R { V22.1D, V23.1D, V24.1D, V25.1D }, [X6], #32
    ADD  X19, X19, X4, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X19]
    MOV  X6, X19
    LD4R { V10.1D, V11.1D, V12.1D, V13.1D }, [X6], #32
    ADD  X19, X19, X4, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X19]
    MOV  X6, X19
    LD4R { V28.2D, V29.2D, V30.2D, V31.2D }, [X6], #32
    ADD  X19, X19, X4
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X19]
    MOV  X6, X19
    LD4R { V12.8B, V13.8B, V14.8B, V15.8B }, [X6], #4
    ADD  X19, X19, X4, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X19]
    MOV  X6, X19
    LD4R { V22.16B, V23.16B, V24.16B, V25.16B }, [X6], #4
    ADD  X19, X19, X4
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X19]
    MOV  X6, X19
    LD4R { V27.8B, V28.8B, V29.8B, V30.8B }, [X6], #4
    ADD  X19, X19, X4, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X19]
    MOV  X6, X19
    LD4R { V12.4H, V13.4H, V14.4H, V15.4H }, [X6], #8
    ADD  X19, X19, X4, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X19]
    MOV  X6, X19
    LD4R { V28.8H, V29.8H, V30.8H, V31.8H }, [X6], #8
    ADD  X19, X19, X4, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X19]
    MOV  X6, X19
    LD4R { V12.8H, V13.8H, V14.8H, V15.8H }, [X6], #8
    ADD  X19, X19, X4, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X19]
    LD4R { V14.4S, V15.4S, V16.4S, V17.4S }, [X19], X15
    ADD  X19, X19, X4
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X19]
    LD4R { V20.16B, V21.16B, V22.16B, V23.16B }, [X19], X15
    ADD  X19, X19, X4, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X19]
    LD4R { V31.2D, V0.2D, V1.2D, V2.2D }, [X19], X15
    ADD  X19, X19, X4, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X19]
    LD4R { V31.4S, V0.4S, V1.4S, V2.4S }, [X19], X15
    ADD  X19, X19, X4, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X19]
    LD4R { V20.8H, V21.8H, V22.8H, V23.8H }, [X19], X15
    ADD  X19, X19, X4, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X19]
    LD4R { V31.1D, V0.1D, V1.1D, V2.1D }, [X19], X15
    ADD  X19, X19, X4
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X19]
    LD4R { V13.1D, V14.1D, V15.1D, V16.1D }, [X19], X15
    ADD  X19, X19, X4, LSR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X19]
    LD4R { V14.2S, V15.2S, V16.2S, V17.2S }, [X19], X15
    ADD  X19, X19, X4, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X19]
    LD4R { V4.4H, V5.4H, V6.4H, V7.4H }, [X19], X15
    ADD  X19, X19, X4
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X19]
    LD4R { V4.8B, V5.8B, V6.8B, V7.8B }, [X19], X15
    ADD  X19, X19, X4, LSR #0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X3, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X3, FPSR
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D0
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D1
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D2
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D3
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D4
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D5
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D6
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D7
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V8.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D8
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V9.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D9
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D10
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D11
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V12.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D12
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D13
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D14
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D15
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D16
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D17
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V18.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D18
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V19.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D19
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V20.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D20
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V21.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D21
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V22.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D22
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V23.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D23
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V24.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D24
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V25.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D25
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D26
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D27
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V28.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D28
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V29.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D29
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, V30.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D30
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X3, D31
    SUB  X21, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D1, X23
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X6
    FMOV  D3, X19
    FMOV  V3.D[1], X14
    FMOV  D4, X8
    FMOV  V4.D[1], X5
    FMOV  D5, X17
    FMOV  V5.D[1], X7
    FMOV  D6, X7
    FMOV  V6.D[1], X28
    FMOV  D7, X12
    FMOV  V7.D[1], X13
    FMOV  D8, X7
    FMOV  V8.D[1], X27
    FMOV  D9, X4
    FMOV  V9.D[1], X23
    FMOV  D10, X6
    FMOV  V10.D[1], X21
    FMOV  D11, X19
    FMOV  V11.D[1], X6
    FMOV  D12, X15
    FMOV  V12.D[1], X7
    FMOV  D13, X17
    FMOV  V13.D[1], X20
    FMOV  D14, X28
    FMOV  V14.D[1], X6
    FMOV  D15, X12
    FMOV  V15.D[1], X21
    FMOV  D16, X8
    FMOV  V16.D[1], X8
    FMOV  D17, X19
    FMOV  V17.D[1], X26
    FMOV  D18, X2
    FMOV  V18.D[1], X15
    FMOV  D19, X12
    FMOV  V19.D[1], X19
    FMOV  D20, X11
    FMOV  V20.D[1], X17
    FMOV  D21, X17
    FMOV  V21.D[1], X20
    FMOV  D22, X9
    FMOV  V22.D[1], X27
    FMOV  D23, X15
    FMOV  V23.D[1], X25
    FMOV  D24, X15
    FMOV  V24.D[1], X16
    FMOV  D25, X28
    FMOV  V25.D[1], X27
    FMOV  D26, X27
    FMOV  V26.D[1], X7
    FMOV  D27, X26
    FMOV  V27.D[1], X11
    FMOV  D28, X8
    FMOV  V28.D[1], X19
    FMOV  D29, X12
    FMOV  V29.D[1], X22
    FMOV  D30, X3
    FMOV  V30.D[1], X21
    FMOV  D31, X14
    FMOV  V31.D[1], X23
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X19, #0xf00, LSL #0
    ADD  X22, X30, X19
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X22]
    LD4R { V18.16B, V19.16B, V20.16B, V21.16B }, [X22]
    ADD  X22, X22, X6
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X22]
    LD4R { V23.16B, V24.16B, V25.16B, V26.16B }, [X22]
    ADD  X22, X22, X6, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X22]
    LD4R { V13.2D, V14.2D, V15.2D, V16.2D }, [X22]
    ADD  X22, X22, X6
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X22]
    LD4R { V13.4S, V14.4S, V15.4S, V16.4S }, [X22]
    ADD  X22, X22, X6, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X22]
    LD4R { V14.8H, V15.8H, V16.8H, V17.8H }, [X22]
    ADD  X22, X22, X6, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X22]
    LD4R { V26.4H, V27.4H, V28.4H, V29.4H }, [X22]
    ADD  X22, X22, X6
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X22]
    LD4R { V14.1D, V15.1D, V16.1D, V17.1D }, [X22]
    ADD  X22, X22, X6
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X22]
    LD4R { V31.2S, V0.2S, V1.2S, V2.2S }, [X22]
    ADD  X22, X22, X6, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X22]
    LD4R { V16.4H, V17.4H, V18.4H, V19.4H }, [X22]
    ADD  X22, X22, X6, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X22]
    LD4R { V31.8B, V0.8B, V1.8B, V2.8B }, [X22]
    ADD  X22, X22, X6, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X22]
    MOV  X21, X22
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X21], #16
    ADD  X22, X22, X6
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X22]
    MOV  X21, X22
    LD4R { V26.2S, V27.2S, V28.2S, V29.2S }, [X21], #16
    ADD  X22, X22, X6, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X22]
    MOV  X21, X22
    LD4R { V8.4S, V9.4S, V10.4S, V11.4S }, [X21], #16
    ADD  X22, X22, X6, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X22]
    MOV  X21, X22
    LD4R { V2.1D, V3.1D, V4.1D, V5.1D }, [X21], #32
    ADD  X22, X22, X6, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X22]
    MOV  X21, X22
    LD4R { V15.1D, V16.1D, V17.1D, V18.1D }, [X21], #32
    ADD  X22, X22, X6, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X22]
    MOV  X21, X22
    LD4R { V26.2D, V27.2D, V28.2D, V29.2D }, [X21], #32
    ADD  X22, X22, X6, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X22]
    MOV  X21, X22
    LD4R { V2.8B, V3.8B, V4.8B, V5.8B }, [X21], #4
    ADD  X22, X22, X6, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X22]
    MOV  X21, X22
    LD4R { V8.16B, V9.16B, V10.16B, V11.16B }, [X21], #4
    ADD  X22, X22, X6, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X22]
    MOV  X21, X22
    LD4R { V15.8B, V16.8B, V17.8B, V18.8B }, [X21], #4
    ADD  X22, X22, X6, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X22]
    MOV  X21, X22
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X21], #8
    ADD  X22, X22, X6, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X22]
    MOV  X21, X22
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X21], #8
    ADD  X22, X22, X6, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X22]
    MOV  X21, X22
    LD4R { V2.8H, V3.8H, V4.8H, V5.8H }, [X21], #8
    ADD  X22, X22, X6
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X22]
    LD4R { V20.16B, V21.16B, V22.16B, V23.16B }, [X22], X3
    ADD  X22, X22, X6, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X22]
    LD4R { V15.16B, V16.16B, V17.16B, V18.16B }, [X22], X3
    ADD  X22, X22, X6, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X22]
    LD4R { V8.2D, V9.2D, V10.2D, V11.2D }, [X22], X3
    ADD  X22, X22, X6, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X22]
    LD4R { V26.4S, V27.4S, V28.4S, V29.4S }, [X22], X3
    ADD  X22, X22, X6, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X22]
    LD4R { V17.8H, V18.8H, V19.8H, V20.8H }, [X22], X3
    ADD  X22, X22, X6
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X22]
    LD4R { V2.8B, V3.8B, V4.8B, V5.8B }, [X22], X3
    ADD  X22, X22, X6
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X22]
    LD4R { V22.1D, V23.1D, V24.1D, V25.1D }, [X22], X3
    ADD  X22, X22, X6, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X22]
    LD4R { V12.2S, V13.2S, V14.2S, V15.2S }, [X22], X3
    ADD  X22, X22, X6
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X22]
    LD4R { V3.4H, V4.4H, V5.4H, V6.4H }, [X22], X3
    ADD  X22, X22, X6, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X22]
    LD4R { V27.8B, V28.8B, V29.8B, V30.8B }, [X22], X3
    ADD  X22, X22, X6, LSR #0
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X14, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D0
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D1
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D2
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D3
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D4
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D5
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D6
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V7.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D7
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V8.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D8
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V9.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D9
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V10.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D10
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V11.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D11
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D12
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D13
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D14
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D15
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V16.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D16
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V17.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D17
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V18.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D18
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V19.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D19
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V20.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D20
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V21.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D21
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D22
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D23
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D24
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D25
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, V26.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D26
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D27
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D28
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D29
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D30
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    FMOV  X14, D31
    SUB  X4, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X9
    FMOV  V2.D[1], X22
    FMOV  D3, X16
    FMOV  V3.D[1], X2
    FMOV  D4, X6
    FMOV  V4.D[1], X12
    FMOV  D5, X26
    FMOV  V5.D[1], X8
    FMOV  D6, X4
    FMOV  V6.D[1], X4
    FMOV  D7, X12
    FMOV  V7.D[1], X6
    FMOV  D8, X2
    FMOV  V8.D[1], X16
    FMOV  D9, X2
    FMOV  V9.D[1], X17
    FMOV  D10, X6
    FMOV  V10.D[1], X14
    FMOV  D11, X3
    FMOV  V11.D[1], X7
    FMOV  D12, X16
    FMOV  V12.D[1], X23
    FMOV  D13, X9
    FMOV  V13.D[1], X21
    FMOV  D14, X14
    FMOV  V14.D[1], X19
    FMOV  D15, X12
    FMOV  V15.D[1], X22
    FMOV  D16, X21
    FMOV  V16.D[1], X19
    FMOV  D17, X25
    FMOV  V17.D[1], X26
    FMOV  D18, X11
    FMOV  V18.D[1], X3
    FMOV  D19, X27
    FMOV  V19.D[1], X27
    FMOV  D20, X2
    FMOV  V20.D[1], X28
    FMOV  D21, X6
    FMOV  V21.D[1], X23
    FMOV  D22, X22
    FMOV  V22.D[1], X25
    FMOV  D23, X20
    FMOV  V23.D[1], X22
    FMOV  D24, X5
    FMOV  V24.D[1], X28
    FMOV  D25, X22
    FMOV  V25.D[1], X6
    FMOV  D26, X6
    FMOV  V26.D[1], X19
    FMOV  D27, X7
    FMOV  V27.D[1], X26
    FMOV  D28, X3
    FMOV  V28.D[1], X19
    FMOV  D29, X9
    FMOV  V29.D[1], X14
    FMOV  D30, X3
    FMOV  V30.D[1], X12
    FMOV  D31, X22
    FMOV  V31.D[1], X8
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X15, #0x1400, LSL #0
    ADD  X3, X30, X15, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X3]
    LD4R { V10.16B, V11.16B, V12.16B, V13.16B }, [X3]
    ADD  X3, X3, X11, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X3]
    LD4R { V6.16B, V7.16B, V8.16B, V9.16B }, [X3]
    ADD  X3, X3, X11
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X3]
    LD4R { V20.2D, V21.2D, V22.2D, V23.2D }, [X3]
    ADD  X3, X3, X11, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X3]
    LD4R { V25.4S, V26.4S, V27.4S, V28.4S }, [X3]
    ADD  X3, X3, X11, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X3]
    LD4R { V2.8H, V3.8H, V4.8H, V5.8H }, [X3]
    ADD  X3, X3, X11, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X3]
    LD4R { V14.2S, V15.2S, V16.2S, V17.2S }, [X3]
    ADD  X3, X3, X11, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X3]
    LD4R { V1.1D, V2.1D, V3.1D, V4.1D }, [X3]
    ADD  X3, X3, X11, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X3]
    LD4R { V24.2S, V25.2S, V26.2S, V27.2S }, [X3]
    ADD  X3, X3, X11, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X3]
    LD4R { V25.4H, V26.4H, V27.4H, V28.4H }, [X3]
    ADD  X3, X3, X11, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X3]
    LD4R { V1.8B, V2.8B, V3.8B, V4.8B }, [X3]
    ADD  X3, X3, X11
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X3]
    MOV  X6, X3
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X6], #16
    ADD  X3, X3, X11, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X3]
    MOV  X6, X3
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X6], #16
    ADD  X3, X3, X11, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X3]
    MOV  X6, X3
    LD4R { V13.4S, V14.4S, V15.4S, V16.4S }, [X6], #16
    ADD  X3, X3, X11, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X3]
    MOV  X6, X3
    LD4R { V13.2D, V14.2D, V15.2D, V16.2D }, [X6], #32
    ADD  X3, X3, X11, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X3]
    MOV  X6, X3
    LD4R { V18.1D, V19.1D, V20.1D, V21.1D }, [X6], #32
    ADD  X3, X3, X11, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X3]
    MOV  X6, X3
    LD4R { V13.2D, V14.2D, V15.2D, V16.2D }, [X6], #32
    ADD  X3, X3, X11
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X3]
    MOV  X6, X3
    LD4R { V18.16B, V19.16B, V20.16B, V21.16B }, [X6], #4
    ADD  X3, X3, X11, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X3]
    MOV  X6, X3
    LD4R { V13.16B, V14.16B, V15.16B, V16.16B }, [X6], #4
    ADD  X3, X3, X11, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X3]
    MOV  X6, X3
    LD4R { V13.8B, V14.8B, V15.8B, V16.8B }, [X6], #4
    ADD  X3, X3, X11, ASR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X3]
    MOV  X6, X3
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X6], #8
    ADD  X3, X3, X11
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X3]
    MOV  X6, X3
    LD4R { V18.8H, V19.8H, V20.8H, V21.8H }, [X6], #8
    ADD  X3, X3, X11, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X3]
    MOV  X6, X3
    LD4R { V28.4H, V29.4H, V30.4H, V31.4H }, [X6], #8
    ADD  X3, X3, X11, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X3]
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X3], X23
    ADD  X3, X3, X11
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X3]
    LD4R { V23.16B, V24.16B, V25.16B, V26.16B }, [X3], X23
    ADD  X3, X3, X11
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X3]
    LD4R { V11.2D, V12.2D, V13.2D, V14.2D }, [X3], X23
    ADD  X3, X3, X11, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X3]
    LD4R { V18.4S, V19.4S, V20.4S, V21.4S }, [X3], X23
    ADD  X3, X3, X11, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X3]
    LD4R { V23.8H, V24.8H, V25.8H, V26.8H }, [X3], X23
    ADD  X3, X3, X11
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X3]
    LD4R { V23.2S, V24.2S, V25.2S, V26.2S }, [X3], X23
    ADD  X3, X3, X11, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X3]
    LD4R { V28.1D, V29.1D, V30.1D, V31.1D }, [X3], X23
    ADD  X3, X3, X11, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X3]
    LD4R { V19.2S, V20.2S, V21.2S, V22.2S }, [X3], X23
    ADD  X3, X3, X11, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X3]
    LD4R { V9.4H, V10.4H, V11.4H, V12.4H }, [X3], X23
    ADD  X3, X3, X11, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X3]
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X3], X23
    ADD  X3, X3, X11
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X21, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D0
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V3.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D3
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V5.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D5
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D6
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D10
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D11
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V13.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D16
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D17
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D24
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D25
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  V1.D[1], X21
    FMOV  D2, X25
    FMOV  V2.D[1], X27
    FMOV  D3, X23
    FMOV  V3.D[1], X20
    FMOV  D4, X14
    FMOV  V4.D[1], X9
    FMOV  D5, X19
    FMOV  V5.D[1], X25
    FMOV  D6, X2
    FMOV  V6.D[1], X20
    FMOV  D7, X26
    FMOV  V7.D[1], X17
    FMOV  D8, X25
    FMOV  V8.D[1], X27
    FMOV  D9, X16
    FMOV  V9.D[1], X26
    FMOV  D10, X2
    FMOV  V10.D[1], X6
    FMOV  D11, X12
    FMOV  V11.D[1], X7
    FMOV  D12, X21
    FMOV  V12.D[1], X13
    FMOV  D13, X7
    FMOV  V13.D[1], X8
    FMOV  D14, X6
    FMOV  V14.D[1], X28
    FMOV  D15, X8
    FMOV  V15.D[1], X22
    FMOV  D16, X23
    FMOV  V16.D[1], X14
    FMOV  D17, X6
    FMOV  V17.D[1], X7
    FMOV  D18, X8
    FMOV  V18.D[1], X6
    FMOV  D19, X14
    FMOV  V19.D[1], X20
    FMOV  D20, X23
    FMOV  V20.D[1], X22
    FMOV  D21, X9
    FMOV  V21.D[1], X13
    FMOV  D22, X15
    FMOV  V22.D[1], X26
    FMOV  D23, X20
    FMOV  V23.D[1], X20
    FMOV  D24, X20
    FMOV  V24.D[1], X5
    FMOV  D25, X25
    FMOV  V25.D[1], X3
    FMOV  D26, X19
    FMOV  V26.D[1], X19
    FMOV  D27, X3
    FMOV  V27.D[1], X19
    FMOV  D28, X5
    FMOV  V28.D[1], X27
    FMOV  D29, X27
    FMOV  V29.D[1], X15
    FMOV  D30, X11
    FMOV  V30.D[1], X7
    FMOV  D31, X25
    FMOV  V31.D[1], X3
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X26, #0x1900, LSL #0
    ADD  X13, X30, X26, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X13]
    LD4R { V25.4S, V26.4S, V27.4S, V28.4S }, [X13]
    ADD  X13, X13, X16, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X13]
    LD4R { V14.16B, V15.16B, V16.16B, V17.16B }, [X13]
    ADD  X13, X13, X16, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X13]
    LD4R { V23.2D, V24.2D, V25.2D, V26.2D }, [X13]
    ADD  X13, X13, X16, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X13]
    LD4R { V5.4S, V6.4S, V7.4S, V8.4S }, [X13]
    ADD  X13, X13, X16
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X13]
    LD4R { V24.8H, V25.8H, V26.8H, V27.8H }, [X13]
    ADD  X13, X13, X16
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X13]
    LD4R { V31.4H, V0.4H, V1.4H, V2.4H }, [X13]
    ADD  X13, X13, X16, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X13]
    LD4R { V14.1D, V15.1D, V16.1D, V17.1D }, [X13]
    ADD  X13, X13, X16, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X13]
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X13]
    ADD  X13, X13, X16
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X13]
    LD4R { V0.4H, V1.4H, V2.4H, V3.4H }, [X13]
    ADD  X13, X13, X16
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X13]
    LD4R { V14.8B, V15.8B, V16.8B, V17.8B }, [X13]
    ADD  X13, X13, X16, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X13]
    MOV  X3, X13
    LD4R { V25.4S, V26.4S, V27.4S, V28.4S }, [X3], #16
    ADD  X13, X13, X16, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X13]
    MOV  X3, X13
    LD4R { V8.2S, V9.2S, V10.2S, V11.2S }, [X3], #16
    ADD  X13, X13, X16
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X13]
    MOV  X3, X13
    LD4R { V8.4S, V9.4S, V10.4S, V11.4S }, [X3], #16
    ADD  X13, X13, X16, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X13]
    MOV  X3, X13
    LD4R { V25.1D, V26.1D, V27.1D, V28.1D }, [X3], #32
    ADD  X13, X13, X16, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X13]
    MOV  X3, X13
    LD4R { V30.1D, V31.1D, V0.1D, V1.1D }, [X3], #32
    ADD  X13, X13, X16, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X13]
    MOV  X3, X13
    LD4R { V25.2D, V26.2D, V27.2D, V28.2D }, [X3], #32
    ADD  X13, X13, X16, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X13]
    MOV  X3, X13
    LD4R { V30.8B, V31.8B, V0.8B, V1.8B }, [X3], #4
    ADD  X13, X13, X16, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X13]
    MOV  X3, X13
    LD4R { V14.16B, V15.16B, V16.16B, V17.16B }, [X3], #4
    ADD  X13, X13, X16, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X13]
    MOV  X3, X13
    LD4R { V14.8B, V15.8B, V16.8B, V17.8B }, [X3], #4
    ADD  X13, X13, X16, LSR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X13]
    MOV  X3, X13
    LD4R { V25.4H, V26.4H, V27.4H, V28.4H }, [X3], #8
    ADD  X13, X13, X16, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X13]
    MOV  X3, X13
    LD4R { V14.8H, V15.8H, V16.8H, V17.8H }, [X3], #8
    ADD  X13, X13, X16, LSR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X13]
    MOV  X3, X13
    LD4R { V25.8H, V26.8H, V27.8H, V28.8H }, [X3], #8
    ADD  X13, X13, X16, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X13]
    LD4R { V30.16B, V31.16B, V0.16B, V1.16B }, [X13], X25
    ADD  X13, X13, X16
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X13]
    LD4R { V17.16B, V18.16B, V19.16B, V20.16B }, [X13], X25
    ADD  X13, X13, X16, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X13]
    LD4R { V14.2D, V15.2D, V16.2D, V17.2D }, [X13], X25
    ADD  X13, X13, X16, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X13]
    LD4R { V1.4S, V2.4S, V3.4S, V4.4S }, [X13], X25
    ADD  X13, X13, X16, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X13]
    LD4R { V1.8H, V2.8H, V3.8H, V4.8H }, [X13], X25
    ADD  X13, X13, X16, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X13]
    LD4R { V0.4H, V1.4H, V2.4H, V3.4H }, [X13], X25
    ADD  X13, X13, X16, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X13]
    LD4R { V4.1D, V5.1D, V6.1D, V7.1D }, [X13], X25
    ADD  X13, X13, X16, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X13]
    LD4R { V15.2S, V16.2S, V17.2S, V18.2S }, [X13], X25
    ADD  X13, X13, X16, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X13]
    LD4R { V1.4H, V2.4H, V3.4H, V4.4H }, [X13], X25
    ADD  X13, X13, X16
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X13]
    LD4R { V28.8B, V29.8B, V30.8B, V31.8B }, [X13], X25
    ADD  X13, X13, X16, LSR #0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X8, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D0
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D1
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D2
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D3
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D4
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D5
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D6
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D7
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V8.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D8
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V9.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D9
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V10.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D10
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D11
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V12.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D12
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V13.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D13
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V14.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D14
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V15.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D15
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D16
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V17.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D17
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D18
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V19.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D19
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V20.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D20
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V21.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D21
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V22.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D22
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V23.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D23
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V24.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D24
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V25.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D25
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V26.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D26
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, V27.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D27
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D28
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D29
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D30
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X8, D31
    SUB  X5, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X12
    FMOV  V3.D[1], X5
    FMOV  D4, X15
    FMOV  V4.D[1], X6
    FMOV  D5, X19
    FMOV  V5.D[1], X13
    FMOV  D6, X23
    FMOV  V6.D[1], X26
    FMOV  D7, X26
    FMOV  V7.D[1], X4
    FMOV  D8, X22
    FMOV  V8.D[1], X8
    FMOV  D9, X17
    FMOV  V9.D[1], X15
    FMOV  D10, X6
    FMOV  V10.D[1], X3
    FMOV  D11, X11
    FMOV  V11.D[1], X22
    FMOV  D12, X27
    FMOV  V12.D[1], X14
    FMOV  D13, X28
    FMOV  V13.D[1], X15
    FMOV  D14, X12
    FMOV  V14.D[1], X23
    FMOV  D15, X23
    FMOV  V15.D[1], X15
    FMOV  D16, X17
    FMOV  V16.D[1], X21
    FMOV  D17, X12
    FMOV  V17.D[1], X21
    FMOV  D18, X4
    FMOV  V18.D[1], X14
    FMOV  D19, X4
    FMOV  V19.D[1], X28
    FMOV  D20, X7
    FMOV  V20.D[1], X22
    FMOV  D21, X9
    FMOV  V21.D[1], X21
    FMOV  D22, X7
    FMOV  V22.D[1], X2
    FMOV  D23, X14
    FMOV  V23.D[1], X14
    FMOV  D24, X20
    FMOV  V24.D[1], X23
    FMOV  D25, X12
    FMOV  V25.D[1], X16
    FMOV  D26, X20
    FMOV  V26.D[1], X16
    FMOV  D27, X20
    FMOV  V27.D[1], X7
    FMOV  D28, X17
    FMOV  V28.D[1], X26
    FMOV  D29, X23
    FMOV  V29.D[1], X23
    FMOV  D30, X11
    FMOV  V30.D[1], X12
    FMOV  D31, X23
    FMOV  V31.D[1], X16
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X25, #0x1e00, LSL #0
    ADD  X20, X30, X25, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X20]
    LD4R { V16.16B, V17.16B, V18.16B, V19.16B }, [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X20]
    LD4R { V12.16B, V13.16B, V14.16B, V15.16B }, [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X20]
    LD4R { V29.2D, V30.2D, V31.2D, V0.2D }, [X20]
    ADD  X20, X20, X8, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X20]
    LD4R { V0.4S, V1.4S, V2.4S, V3.4S }, [X20]
    ADD  X20, X20, X8
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X20]
    LD4R { V25.8H, V26.8H, V27.8H, V28.8H }, [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X20]
    LD4R { V14.1D, V15.1D, V16.1D, V17.1D }, [X20]
    ADD  X20, X20, X8
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X20]
    LD4R { V10.1D, V11.1D, V12.1D, V13.1D }, [X20]
    ADD  X20, X20, X8, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X20]
    LD4R { V4.2S, V5.2S, V6.2S, V7.2S }, [X20]
    ADD  X20, X20, X8
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X20]
    LD4R { V0.4H, V1.4H, V2.4H, V3.4H }, [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X20]
    LD4R { V7.8B, V8.8B, V9.8B, V10.8B }, [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X20]
    MOV  X2, X20
    LD4R { V31.2S, V0.2S, V1.2S, V2.2S }, [X2], #16
    ADD  X20, X20, X8, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X20]
    MOV  X2, X20
    LD4R { V1.2S, V2.2S, V3.2S, V4.2S }, [X2], #16
    ADD  X20, X20, X8, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X20]
    MOV  X2, X20
    LD4R { V3.4S, V4.4S, V5.4S, V6.4S }, [X2], #16
    ADD  X20, X20, X8, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X20]
    MOV  X2, X20
    LD4R { V19.2D, V20.2D, V21.2D, V22.2D }, [X2], #32
    ADD  X20, X20, X8
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X20]
    MOV  X2, X20
    LD4R { V8.1D, V9.1D, V10.1D, V11.1D }, [X2], #32
    ADD  X20, X20, X8
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X20]
    MOV  X2, X20
    LD4R { V11.2D, V12.2D, V13.2D, V14.2D }, [X2], #32
    ADD  X20, X20, X8, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X20]
    MOV  X2, X20
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X2], #4
    ADD  X20, X20, X8, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X20]
    MOV  X2, X20
    LD4R { V26.16B, V27.16B, V28.16B, V29.16B }, [X2], #4
    ADD  X20, X20, X8
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X20]
    MOV  X2, X20
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X2], #4
    ADD  X20, X20, X8
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X20]
    MOV  X2, X20
    LD4R { V21.4H, V22.4H, V23.4H, V24.4H }, [X2], #8
    ADD  X20, X20, X8
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X20]
    MOV  X2, X20
    LD4R { V6.8H, V7.8H, V8.8H, V9.8H }, [X2], #8
    ADD  X20, X20, X8, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X20]
    MOV  X2, X20
    LD4R { V11.4H, V12.4H, V13.4H, V14.4H }, [X2], #8
    ADD  X20, X20, X8, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X20]
    LD4R { V29.2D, V30.2D, V31.2D, V0.2D }, [X20], X26
    ADD  X20, X20, X8, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X20]
    LD4R { V21.16B, V22.16B, V23.16B, V24.16B }, [X20], X26
    ADD  X20, X20, X8
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X20]
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X20], X26
    ADD  X20, X20, X8, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X20]
    LD4R { V23.4S, V24.4S, V25.4S, V26.4S }, [X20], X26
    ADD  X20, X20, X8, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X20]
    LD4R { V16.8H, V17.8H, V18.8H, V19.8H }, [X20], X26
    ADD  X20, X20, X8
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X20]
    LD4R { V25.8B, V26.8B, V27.8B, V28.8B }, [X20], X26
    ADD  X20, X20, X8
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X20]
    LD4R { V6.1D, V7.1D, V8.1D, V9.1D }, [X20], X26
    ADD  X20, X20, X8, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X20]
    LD4R { V13.2S, V14.2S, V15.2S, V16.2S }, [X20], X26
    ADD  X20, X20, X8
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X20]
    LD4R { V12.4H, V13.4H, V14.4H, V15.4H }, [X20], X26
    ADD  X20, X20, X8, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X20]
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X20], X26
    ADD  X20, X20, X8, ASR #0
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X6, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X6, FPSR
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V0.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D0
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D1
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D2
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V3.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D3
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V4.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D4
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V5.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D5
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D6
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D7
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V8.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D8
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D9
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V10.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D10
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V11.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D11
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D12
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V13.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D13
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D14
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D15
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D16
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V17.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D17
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V18.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D18
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V19.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D19
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D20
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V21.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D21
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V22.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D22
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D23
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D24
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D25
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D26
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D27
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D28
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V29.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D29
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V30.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D30
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, V31.D[1]
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X6, D31
    SUB  X21, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X23
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X15
    FMOV  V3.D[1], X28
    FMOV  D4, X8
    FMOV  V4.D[1], X16
    FMOV  D5, X14
    FMOV  V5.D[1], X7
    FMOV  D6, X14
    FMOV  V6.D[1], X20
    FMOV  D7, X11
    FMOV  V7.D[1], X15
    FMOV  D8, X20
    FMOV  V8.D[1], X16
    FMOV  D9, X4
    FMOV  V9.D[1], X27
    FMOV  D10, X25
    FMOV  V10.D[1], X11
    FMOV  D11, X21
    FMOV  V11.D[1], X20
    FMOV  D12, X7
    FMOV  V12.D[1], X16
    FMOV  D13, X4
    FMOV  V13.D[1], X4
    FMOV  D14, X13
    FMOV  V14.D[1], X26
    FMOV  D15, X15
    FMOV  V15.D[1], X16
    FMOV  D16, X22
    FMOV  V16.D[1], X25
    FMOV  D17, X27
    FMOV  V17.D[1], X21
    FMOV  D18, X28
    FMOV  V18.D[1], X25
    FMOV  D19, X21
    FMOV  V19.D[1], X19
    FMOV  D20, X9
    FMOV  V20.D[1], X16
    FMOV  D21, X3
    FMOV  V21.D[1], X28
    FMOV  D22, X25
    FMOV  V22.D[1], X11
    FMOV  D23, X23
    FMOV  V23.D[1], X6
    FMOV  D24, X26
    FMOV  V24.D[1], X22
    FMOV  D25, X11
    FMOV  V25.D[1], X9
    FMOV  D26, X5
    FMOV  V26.D[1], X9
    FMOV  D27, X28
    FMOV  V27.D[1], X16
    FMOV  D28, X15
    FMOV  V28.D[1], X28
    FMOV  D29, X22
    FMOV  V29.D[1], X27
    FMOV  D30, X16
    FMOV  V30.D[1], X14
    FMOV  D31, X6
    FMOV  V31.D[1], X2
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X6, #0x2300, LSL #0
    ADD  X16, X30, X6, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X16]
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X16]
    ADD  X16, X16, X20, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X16]
    LD4R { V31.16B, V0.16B, V1.16B, V2.16B }, [X16]
    ADD  X16, X16, X20
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X16]
    LD4R { V21.2D, V22.2D, V23.2D, V24.2D }, [X16]
    ADD  X16, X16, X20
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X16]
    LD4R { V3.4S, V4.4S, V5.4S, V6.4S }, [X16]
    ADD  X16, X16, X20
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X16]
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X16]
    ADD  X16, X16, X20, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X16]
    LD4R { V3.1D, V4.1D, V5.1D, V6.1D }, [X16]
    ADD  X16, X16, X20, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X16]
    LD4R { V2.1D, V3.1D, V4.1D, V5.1D }, [X16]
    ADD  X16, X16, X20, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X16]
    LD4R { V21.2S, V22.2S, V23.2S, V24.2S }, [X16]
    ADD  X16, X16, X20
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X16]
    LD4R { V17.4H, V18.4H, V19.4H, V20.4H }, [X16]
    ADD  X16, X16, X20, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X16]
    LD4R { V26.8B, V27.8B, V28.8B, V29.8B }, [X16]
    ADD  X16, X16, X20, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X16]
    MOV  X5, X16
    LD4R { V17.4S, V18.4S, V19.4S, V20.4S }, [X5], #16
    ADD  X16, X16, X20, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X16]
    MOV  X5, X16
    LD4R { V26.2S, V27.2S, V28.2S, V29.2S }, [X5], #16
    ADD  X16, X16, X20, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X16]
    MOV  X5, X16
    LD4R { V17.4S, V18.4S, V19.4S, V20.4S }, [X5], #16
    ADD  X16, X16, X20, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X16]
    MOV  X5, X16
    LD4R { V21.2D, V22.2D, V23.2D, V24.2D }, [X5], #32
    ADD  X16, X16, X20, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X16]
    MOV  X5, X16
    LD4R { V25.1D, V26.1D, V27.1D, V28.1D }, [X5], #32
    ADD  X16, X16, X20
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X16]
    MOV  X5, X16
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X5], #32
    ADD  X16, X16, X20
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X16]
    MOV  X5, X16
    LD4R { V18.16B, V19.16B, V20.16B, V21.16B }, [X5], #4
    ADD  X16, X16, X20
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X16]
    MOV  X5, X16
    LD4R { V18.16B, V19.16B, V20.16B, V21.16B }, [X5], #4
    ADD  X16, X16, X20
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X16]
    MOV  X5, X16
    LD4R { V26.8B, V27.8B, V28.8B, V29.8B }, [X5], #4
    ADD  X16, X16, X20
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X16]
    MOV  X5, X16
    LD4R { V22.4H, V23.4H, V24.4H, V25.4H }, [X5], #8
    ADD  X16, X16, X20, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X16]
    MOV  X5, X16
    LD4R { V18.8H, V19.8H, V20.8H, V21.8H }, [X5], #8
    ADD  X16, X16, X20, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X16]
    MOV  X5, X16
    LD4R { V13.8H, V14.8H, V15.8H, V16.8H }, [X5], #8
    ADD  X16, X16, X20
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X16]
    LD4R { V26.2D, V27.2D, V28.2D, V29.2D }, [X16], X23
    ADD  X16, X16, X20
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X16]
    LD4R { V22.16B, V23.16B, V24.16B, V25.16B }, [X16], X23
    ADD  X16, X16, X20, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X16]
    LD4R { V13.2D, V14.2D, V15.2D, V16.2D }, [X16], X23
    ADD  X16, X16, X20, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X16]
    LD4R { V26.4S, V27.4S, V28.4S, V29.4S }, [X16], X23
    ADD  X16, X16, X20, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X16]
    LD4R { V19.8H, V20.8H, V21.8H, V22.8H }, [X16], X23
    ADD  X16, X16, X20, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X16]
    LD4R { V19.2S, V20.2S, V21.2S, V22.2S }, [X16], X23
    ADD  X16, X16, X20, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X16]
    LD4R { V26.1D, V27.1D, V28.1D, V29.1D }, [X16], X23
    ADD  X16, X16, X20, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X16]
    LD4R { V13.2S, V14.2S, V15.2S, V16.2S }, [X16], X23
    ADD  X16, X16, X20, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X16]
    LD4R { V12.4H, V13.4H, V14.4H, V15.4H }, [X16], X23
    ADD  X16, X16, X20, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X16]
    LD4R { V19.8B, V20.8B, V21.8B, V22.8B }, [X16], X23
    ADD  X16, X16, X20, LSR #0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V0.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D0
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V1.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D1
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D2
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D3
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D4
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V5.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D5
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V6.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D6
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V7.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D7
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V8.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D8
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V9.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D9
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V10.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D10
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V11.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D11
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D12
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D13
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D14
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D15
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D16
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V17.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D17
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V18.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D18
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D19
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D20
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D21
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D22
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V23.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D23
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V24.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D24
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V25.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D25
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D26
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D27
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D28
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D29
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V30.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D30
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, V31.D[1]
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X11, D31
    SUB  X9, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X23
    FMOV  D3, X9
    FMOV  V3.D[1], X25
    FMOV  D4, X6
    FMOV  V4.D[1], X15
    FMOV  D5, X15
    FMOV  V5.D[1], X13
    FMOV  D6, X16
    FMOV  V6.D[1], X6
    FMOV  D7, X21
    FMOV  V7.D[1], X8
    FMOV  D8, X20
    FMOV  V8.D[1], X13
    FMOV  D9, X19
    FMOV  V9.D[1], X22
    FMOV  D10, X26
    FMOV  V10.D[1], X28
    FMOV  D11, X8
    FMOV  V11.D[1], X14
    FMOV  D12, X5
    FMOV  V12.D[1], X21
    FMOV  D13, X21
    FMOV  V13.D[1], X22
    FMOV  D14, X25
    FMOV  V14.D[1], X17
    FMOV  D15, X7
    FMOV  V15.D[1], X17
    FMOV  D16, X21
    FMOV  V16.D[1], X13
    FMOV  D17, X8
    FMOV  V17.D[1], X28
    FMOV  D18, X15
    FMOV  V18.D[1], X12
    FMOV  D19, X21
    FMOV  V19.D[1], X16
    FMOV  D20, X16
    FMOV  V20.D[1], X21
    FMOV  D21, X16
    FMOV  V21.D[1], X21
    FMOV  D22, X7
    FMOV  V22.D[1], X17
    FMOV  D23, X28
    FMOV  V23.D[1], X11
    FMOV  D24, X5
    FMOV  V24.D[1], X15
    FMOV  D25, X5
    FMOV  V25.D[1], X27
    FMOV  D26, X12
    FMOV  V26.D[1], X21
    FMOV  D27, X8
    FMOV  V27.D[1], X11
    FMOV  D28, X20
    FMOV  V28.D[1], X3
    FMOV  D29, X19
    FMOV  V29.D[1], X17
    FMOV  D30, X9
    FMOV  V30.D[1], X17
    FMOV  D31, X12
    FMOV  V31.D[1], X4
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X16, #0x2800, LSL #0
    ADD  X2, X30, X16, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X2]
    LD4R { V21.2D, V22.2D, V23.2D, V24.2D }, [X2]
    ADD  X2, X2, X3, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X2]
    LD4R { V11.16B, V12.16B, V13.16B, V14.16B }, [X2]
    ADD  X2, X2, X3, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X2]
    LD4R { V12.2D, V13.2D, V14.2D, V15.2D }, [X2]
    ADD  X2, X2, X3, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X2]
    LD4R { V8.4S, V9.4S, V10.4S, V11.4S }, [X2]
    ADD  X2, X2, X3, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X2]
    LD4R { V23.8H, V24.8H, V25.8H, V26.8H }, [X2]
    ADD  X2, X2, X3, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X2]
    LD4R { V8.2S, V9.2S, V10.2S, V11.2S }, [X2]
    ADD  X2, X2, X3
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X2]
    LD4R { V9.1D, V10.1D, V11.1D, V12.1D }, [X2]
    ADD  X2, X2, X3, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X2]
    LD4R { V31.2S, V0.2S, V1.2S, V2.2S }, [X2]
    ADD  X2, X2, X3
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X2]
    LD4R { V21.4H, V22.4H, V23.4H, V24.4H }, [X2]
    ADD  X2, X2, X3, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X2]
    LD4R { V11.8B, V12.8B, V13.8B, V14.8B }, [X2]
    ADD  X2, X2, X3, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X2]
    MOV  X11, X2
    LD4R { V10.2S, V11.2S, V12.2S, V13.2S }, [X11], #16
    ADD  X2, X2, X3, ASR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X2]
    MOV  X11, X2
    LD4R { V8.2S, V9.2S, V10.2S, V11.2S }, [X11], #16
    ADD  X2, X2, X3, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X2]
    MOV  X11, X2
    LD4R { V19.4S, V20.4S, V21.4S, V22.4S }, [X11], #16
    ADD  X2, X2, X3, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X2]
    MOV  X11, X2
    LD4R { V31.2D, V0.2D, V1.2D, V2.2D }, [X11], #32
    ADD  X2, X2, X3, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X2]
    MOV  X11, X2
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X11], #32
    ADD  X2, X2, X3, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X2]
    MOV  X11, X2
    LD4R { V17.2D, V18.2D, V19.2D, V20.2D }, [X11], #32
    ADD  X2, X2, X3
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X2]
    MOV  X11, X2
    LD4R { V8.16B, V9.16B, V10.16B, V11.16B }, [X11], #4
    ADD  X2, X2, X3
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X2]
    MOV  X11, X2
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X11], #4
    ADD  X2, X2, X3
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X2]
    MOV  X11, X2
    LD4R { V17.8B, V18.8B, V19.8B, V20.8B }, [X11], #4
    ADD  X2, X2, X3, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X2]
    MOV  X11, X2
    LD4R { V17.4H, V18.4H, V19.4H, V20.4H }, [X11], #8
    ADD  X2, X2, X3, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X2]
    MOV  X11, X2
    LD4R { V25.8H, V26.8H, V27.8H, V28.8H }, [X11], #8
    ADD  X2, X2, X3, ASR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X2]
    MOV  X11, X2
    LD4R { V17.8H, V18.8H, V19.8H, V20.8H }, [X11], #8
    ADD  X2, X2, X3, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X2]
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X2], X20
    ADD  X2, X2, X3, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X2]
    LD4R { V17.16B, V18.16B, V19.16B, V20.16B }, [X2], X20
    ADD  X2, X2, X3
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X2]
    LD4R { V8.2D, V9.2D, V10.2D, V11.2D }, [X2], X20
    ADD  X2, X2, X3, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X2]
    LD4R { V30.4S, V31.4S, V0.4S, V1.4S }, [X2], X20
    ADD  X2, X2, X3, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X2]
    LD4R { V10.8H, V11.8H, V12.8H, V13.8H }, [X2], X20
    ADD  X2, X2, X3, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X2]
    LD4R { V2.2S, V3.2S, V4.2S, V5.2S }, [X2], X20
    ADD  X2, X2, X3, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X2]
    LD4R { V30.1D, V31.1D, V0.1D, V1.1D }, [X2], X20
    ADD  X2, X2, X3, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X2]
    LD4R { V8.2S, V9.2S, V10.2S, V11.2S }, [X2], X20
    ADD  X2, X2, X3, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X2]
    LD4R { V7.4H, V8.4H, V9.4H, V10.4H }, [X2], X20
    ADD  X2, X2, X3, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X2]
    LD4R { V6.8B, V7.8B, V8.8B, V9.8B }, [X2], X20
    ADD  X2, X2, X3, ASR #0
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X13, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D0
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D1
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D2
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D3
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D4
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D5
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D6
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D7
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D8
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D9
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D10
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D11
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V12.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D12
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V13.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D13
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D14
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V15.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D15
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V16.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D16
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V17.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D17
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V18.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D18
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V19.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D19
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V20.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D20
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D21
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D22
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D23
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D24
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V25.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D25
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V26.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D26
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V27.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D27
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V28.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D28
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, V29.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D29
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D30
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X13, D31
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  V0.D[1], X23
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X25
    FMOV  V3.D[1], X26
    FMOV  D4, X20
    FMOV  V4.D[1], X25
    FMOV  D5, X3
    FMOV  V5.D[1], X20
    FMOV  D6, X19
    FMOV  V6.D[1], X28
    FMOV  D7, X26
    FMOV  V7.D[1], X11
    FMOV  D8, X27
    FMOV  V8.D[1], X8
    FMOV  D9, X6
    FMOV  V9.D[1], X15
    FMOV  D10, X21
    FMOV  V10.D[1], X5
    FMOV  D11, X12
    FMOV  V11.D[1], X23
    FMOV  D12, X22
    FMOV  V12.D[1], X8
    FMOV  D13, X13
    FMOV  V13.D[1], X20
    FMOV  D14, X3
    FMOV  V14.D[1], X13
    FMOV  D15, X12
    FMOV  V15.D[1], X6
    FMOV  D16, X6
    FMOV  V16.D[1], X9
    FMOV  D17, X15
    FMOV  V17.D[1], X16
    FMOV  D18, X2
    FMOV  V18.D[1], X12
    FMOV  D19, X8
    FMOV  V19.D[1], X27
    FMOV  D20, X2
    FMOV  V20.D[1], X3
    FMOV  D21, X7
    FMOV  V21.D[1], X4
    FMOV  D22, X8
    FMOV  V22.D[1], X17
    FMOV  D23, X28
    FMOV  V23.D[1], X16
    FMOV  D24, X22
    FMOV  V24.D[1], X13
    FMOV  D25, X3
    FMOV  V25.D[1], X23
    FMOV  D26, X6
    FMOV  V26.D[1], X4
    FMOV  D27, X23
    FMOV  V27.D[1], X13
    FMOV  D28, X5
    FMOV  V28.D[1], X6
    FMOV  D29, X19
    FMOV  V29.D[1], X4
    FMOV  D30, X13
    FMOV  V30.D[1], X16
    FMOV  D31, X28
    FMOV  V31.D[1], X6
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X3, #0x2d00, LSL #0
    ADD  X20, X30, X3, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X20]
    LD4R { V15.4S, V16.4S, V17.4S, V18.4S }, [X20]
    ADD  X20, X20, X16, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X20]
    LD4R { V27.16B, V28.16B, V29.16B, V30.16B }, [X20]
    ADD  X20, X20, X16
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X20]
    LD4R { V12.2D, V13.2D, V14.2D, V15.2D }, [X20]
    ADD  X20, X20, X16, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X20]
    LD4R { V10.4S, V11.4S, V12.4S, V13.4S }, [X20]
    ADD  X20, X20, X16
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X20]
    LD4R { V11.8H, V12.8H, V13.8H, V14.8H }, [X20]
    ADD  X20, X20, X16
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X20]
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X20]
    ADD  X20, X20, X16
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X20]
    LD4R { V10.1D, V11.1D, V12.1D, V13.1D }, [X20]
    ADD  X20, X20, X16
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X20]
    LD4R { V1.2S, V2.2S, V3.2S, V4.2S }, [X20]
    ADD  X20, X20, X16, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X20]
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X20]
    ADD  X20, X20, X16
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X20]
    LD4R { V11.8B, V12.8B, V13.8B, V14.8B }, [X20]
    ADD  X20, X20, X16
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X20]
    MOV  X19, X20
    LD4R { V11.2S, V12.2S, V13.2S, V14.2S }, [X19], #16
    ADD  X20, X20, X16, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X20]
    MOV  X19, X20
    LD4R { V1.2S, V2.2S, V3.2S, V4.2S }, [X19], #16
    ADD  X20, X20, X16, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X20]
    MOV  X19, X20
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X19], #16
    ADD  X20, X20, X16, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X20]
    MOV  X19, X20
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X19], #32
    ADD  X20, X20, X16, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X20]
    MOV  X19, X20
    LD4R { V11.1D, V12.1D, V13.1D, V14.1D }, [X19], #32
    ADD  X20, X20, X16
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X20]
    MOV  X19, X20
    LD4R { V27.2D, V28.2D, V29.2D, V30.2D }, [X19], #32
    ADD  X20, X20, X16, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X20]
    MOV  X19, X20
    LD4R { V27.16B, V28.16B, V29.16B, V30.16B }, [X19], #4
    ADD  X20, X20, X16, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X20]
    MOV  X19, X20
    LD4R { V11.16B, V12.16B, V13.16B, V14.16B }, [X19], #4
    ADD  X20, X20, X16, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X20]
    MOV  X19, X20
    LD4R { V11.8B, V12.8B, V13.8B, V14.8B }, [X19], #4
    ADD  X20, X20, X16, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X20]
    MOV  X19, X20
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X19], #8
    ADD  X20, X20, X16, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X20]
    MOV  X19, X20
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X19], #8
    ADD  X20, X20, X16
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X20]
    MOV  X19, X20
    LD4R { V1.4H, V2.4H, V3.4H, V4.4H }, [X19], #8
    ADD  X20, X20, X16
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X20]
    LD4R { V11.16B, V12.16B, V13.16B, V14.16B }, [X20], X13
    ADD  X20, X20, X16
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X20]
    LD4R { V11.16B, V12.16B, V13.16B, V14.16B }, [X20], X13
    ADD  X20, X20, X16
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X20]
    LD4R { V20.2D, V21.2D, V22.2D, V23.2D }, [X20], X13
    ADD  X20, X20, X16, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X20]
    LD4R { V1.4S, V2.4S, V3.4S, V4.4S }, [X20], X13
    ADD  X20, X20, X16, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X20]
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X20], X13
    ADD  X20, X20, X16, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X20]
    LD4R { V11.4H, V12.4H, V13.4H, V14.4H }, [X20], X13
    ADD  X20, X20, X16
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X20]
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X20], X13
    ADD  X20, X20, X16, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X20]
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X20], X13
    ADD  X20, X20, X16, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X20]
    LD4R { V1.4H, V2.4H, V3.4H, V4.4H }, [X20], X13
    ADD  X20, X20, X16, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X20]
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X20], X13
    ADD  X20, X20, X16
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V0.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D0
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D1
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D2
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D3
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D4
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V5.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D5
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V6.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D6
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V7.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D7
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V8.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D8
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V9.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D9
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D10
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D11
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D12
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D13
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D14
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V15.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D15
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V16.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D16
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V17.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D17
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V18.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D18
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V19.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D19
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D20
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D21
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D22
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D23
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V24.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D24
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D25
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D26
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D27
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D28
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V29.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D29
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D30
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V31.D[1]
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D31
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D1, X21
    FMOV  V1.D[1], X26
    FMOV  D2, X22
    FMOV  V2.D[1], X25
    FMOV  D3, X9
    FMOV  V3.D[1], X8
    FMOV  D4, X23
    FMOV  V4.D[1], X13
    FMOV  D5, X2
    FMOV  V5.D[1], X14
    FMOV  D6, X9
    FMOV  V6.D[1], X19
    FMOV  D7, X17
    FMOV  V7.D[1], X22
    FMOV  D8, X21
    FMOV  V8.D[1], X3
    FMOV  D9, X5
    FMOV  V9.D[1], X28
    FMOV  D10, X17
    FMOV  V10.D[1], X9
    FMOV  D11, X14
    FMOV  V11.D[1], X21
    FMOV  D12, X28
    FMOV  V12.D[1], X26
    FMOV  D13, X12
    FMOV  V13.D[1], X2
    FMOV  D14, X3
    FMOV  V14.D[1], X2
    FMOV  D15, X9
    FMOV  V15.D[1], X21
    FMOV  D16, X13
    FMOV  V16.D[1], X8
    FMOV  D17, X20
    FMOV  V17.D[1], X27
    FMOV  D18, X8
    FMOV  V18.D[1], X25
    FMOV  D19, X17
    FMOV  V19.D[1], X12
    FMOV  D20, X4
    FMOV  V20.D[1], X12
    FMOV  D21, X23
    FMOV  V21.D[1], X20
    FMOV  D22, X19
    FMOV  V22.D[1], X19
    FMOV  D23, X21
    FMOV  V23.D[1], X22
    FMOV  D24, X21
    FMOV  V24.D[1], X27
    FMOV  D25, X11
    FMOV  V25.D[1], X11
    FMOV  D26, X20
    FMOV  V26.D[1], X21
    FMOV  D27, X19
    FMOV  V27.D[1], X15
    FMOV  D28, X6
    FMOV  V28.D[1], X7
    FMOV  D29, X19
    FMOV  V29.D[1], X7
    FMOV  D30, X13
    FMOV  V30.D[1], X8
    FMOV  D31, X25
    FMOV  V31.D[1], X4
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X17, #0x0, LSL #0
    ADD  X25, X30, X17
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X25]
    LD4R { V26.4S, V27.4S, V28.4S, V29.4S }, [X25]
    ADD  X25, X25, X27, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X25]
    LD4R { V26.16B, V27.16B, V28.16B, V29.16B }, [X25]
    ADD  X25, X25, X27, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X25]
    LD4R { V10.2D, V11.2D, V12.2D, V13.2D }, [X25]
    ADD  X25, X25, X27
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X25]
    LD4R { V21.4S, V22.4S, V23.4S, V24.4S }, [X25]
    ADD  X25, X25, X27, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X25]
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X25]
    ADD  X25, X25, X27
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X25]
    LD4R { V18.4H, V19.4H, V20.4H, V21.4H }, [X25]
    ADD  X25, X25, X27, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X25]
    LD4R { V11.1D, V12.1D, V13.1D, V14.1D }, [X25]
    ADD  X25, X25, X27, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X25]
    LD4R { V16.2S, V17.2S, V18.2S, V19.2S }, [X25]
    ADD  X25, X25, X27
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X25]
    LD4R { V18.4H, V19.4H, V20.4H, V21.4H }, [X25]
    ADD  X25, X25, X27, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X25]
    LD4R { V26.8B, V27.8B, V28.8B, V29.8B }, [X25]
    ADD  X25, X25, X27, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X25]
    MOV  X22, X25
    LD4R { V20.4S, V21.4S, V22.4S, V23.4S }, [X22], #16
    ADD  X25, X25, X27, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X25]
    MOV  X22, X25
    LD4R { V28.2S, V29.2S, V30.2S, V31.2S }, [X22], #16
    ADD  X25, X25, X27
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X25]
    MOV  X22, X25
    LD4R { V28.4S, V29.4S, V30.4S, V31.4S }, [X22], #16
    ADD  X25, X25, X27
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X25]
    MOV  X22, X25
    LD4R { V3.1D, V4.1D, V5.1D, V6.1D }, [X22], #32
    ADD  X25, X25, X27, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X25]
    MOV  X22, X25
    LD4R { V23.1D, V24.1D, V25.1D, V26.1D }, [X22], #32
    ADD  X25, X25, X27, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X25]
    MOV  X22, X25
    LD4R { V28.2D, V29.2D, V30.2D, V31.2D }, [X22], #32
    ADD  X25, X25, X27, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X25]
    MOV  X22, X25
    LD4R { V28.8B, V29.8B, V30.8B, V31.8B }, [X22], #4
    ADD  X25, X25, X27
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X25]
    MOV  X22, X25
    LD4R { V21.16B, V22.16B, V23.16B, V24.16B }, [X22], #4
    ADD  X25, X25, X27, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X25]
    MOV  X22, X25
    LD4R { V28.8B, V29.8B, V30.8B, V31.8B }, [X22], #4
    ADD  X25, X25, X27, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X25]
    MOV  X22, X25
    LD4R { V22.4H, V23.4H, V24.4H, V25.4H }, [X22], #8
    ADD  X25, X25, X27, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X25]
    MOV  X22, X25
    LD4R { V28.8H, V29.8H, V30.8H, V31.8H }, [X22], #8
    ADD  X25, X25, X27, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X25]
    MOV  X22, X25
    LD4R { V11.4H, V12.4H, V13.4H, V14.4H }, [X22], #8
    ADD  X25, X25, X27, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X25]
    LD4R { V22.16B, V23.16B, V24.16B, V25.16B }, [X25], X14
    ADD  X25, X25, X27, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X25]
    LD4R { V3.16B, V4.16B, V5.16B, V6.16B }, [X25], X14
    ADD  X25, X25, X27
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X25]
    LD4R { V28.2D, V29.2D, V30.2D, V31.2D }, [X25], X14
    ADD  X25, X25, X27, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X25]
    LD4R { V5.4S, V6.4S, V7.4S, V8.4S }, [X25], X14
    ADD  X25, X25, X27, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X25]
    LD4R { V28.8H, V29.8H, V30.8H, V31.8H }, [X25], X14
    ADD  X25, X25, X27, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X25]
    LD4R { V3.8B, V4.8B, V5.8B, V6.8B }, [X25], X14
    ADD  X25, X25, X27, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X25]
    LD4R { V22.1D, V23.1D, V24.1D, V25.1D }, [X25], X14
    ADD  X25, X25, X27, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X25]
    LD4R { V3.2S, V4.2S, V5.2S, V6.2S }, [X25], X14
    ADD  X25, X25, X27, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X25]
    LD4R { V17.4H, V18.4H, V19.4H, V20.4H }, [X25], X14
    ADD  X25, X25, X27
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X25]
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X25], X14
    ADD  X25, X25, X27, ASR #0
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X21, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D0
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D3
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D5
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D6
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V9.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D10
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D11
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V15.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D16
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D17
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V21.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D24
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D25
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V29.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V30.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X15, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  V0.D[1], X20
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X25
    FMOV  D3, X15
    FMOV  V3.D[1], X3
    FMOV  D4, X12
    FMOV  V4.D[1], X5
    FMOV  D5, X14
    FMOV  V5.D[1], X17
    FMOV  D6, X19
    FMOV  V6.D[1], X11
    FMOV  D7, X12
    FMOV  V7.D[1], X21
    FMOV  D8, X9
    FMOV  V8.D[1], X2
    FMOV  D9, X20
    FMOV  V9.D[1], X16
    FMOV  D10, X20
    FMOV  V10.D[1], X19
    FMOV  D11, X15
    FMOV  V11.D[1], X11
    FMOV  D12, X25
    FMOV  V12.D[1], X22
    FMOV  D13, X16
    FMOV  V13.D[1], X12
    FMOV  D14, X11
    FMOV  V14.D[1], X4
    FMOV  D15, X12
    FMOV  V15.D[1], X16
    FMOV  D16, X22
    FMOV  V16.D[1], X12
    FMOV  D17, X27
    FMOV  V17.D[1], X13
    FMOV  D18, X19
    FMOV  V18.D[1], X27
    FMOV  D19, X12
    FMOV  V19.D[1], X11
    FMOV  D20, X27
    FMOV  V20.D[1], X11
    FMOV  D21, X25
    FMOV  V21.D[1], X6
    FMOV  D22, X27
    FMOV  V22.D[1], X22
    FMOV  D23, X5
    FMOV  V23.D[1], X5
    FMOV  D24, X25
    FMOV  V24.D[1], X6
    FMOV  D25, X19
    FMOV  V25.D[1], X22
    FMOV  D26, X7
    FMOV  V26.D[1], X11
    FMOV  D27, X4
    FMOV  V27.D[1], X15
    FMOV  D28, X25
    FMOV  V28.D[1], X9
    FMOV  D29, X27
    FMOV  V29.D[1], X19
    FMOV  D30, X7
    FMOV  V30.D[1], X21
    FMOV  D31, X5
    FMOV  V31.D[1], X2
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X7, #0x500, LSL #0
    ADD  X3, X30, X7, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X3]
    LD4R { V13.2D, V14.2D, V15.2D, V16.2D }, [X3]
    ADD  X3, X3, X16, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X3]
    LD4R { V31.16B, V0.16B, V1.16B, V2.16B }, [X3]
    ADD  X3, X3, X16
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X3]
    LD4R { V16.2D, V17.2D, V18.2D, V19.2D }, [X3]
    ADD  X3, X3, X16
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X3]
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X3]
    ADD  X3, X3, X16, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X3]
    LD4R { V2.8H, V3.8H, V4.8H, V5.8H }, [X3]
    ADD  X3, X3, X16, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X3]
    LD4R { V7.1D, V8.1D, V9.1D, V10.1D }, [X3]
    ADD  X3, X3, X16
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X3]
    LD4R { V4.1D, V5.1D, V6.1D, V7.1D }, [X3]
    ADD  X3, X3, X16
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X3]
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X3]
    ADD  X3, X3, X16, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X3]
    LD4R { V12.4H, V13.4H, V14.4H, V15.4H }, [X3]
    ADD  X3, X3, X16, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X3]
    LD4R { V6.8B, V7.8B, V8.8B, V9.8B }, [X3]
    ADD  X3, X3, X16, ASR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X3]
    MOV  X4, X3
    LD4R { V3.2S, V4.2S, V5.2S, V6.2S }, [X4], #16
    ADD  X3, X3, X16, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X3]
    MOV  X4, X3
    LD4R { V12.2S, V13.2S, V14.2S, V15.2S }, [X4], #16
    ADD  X3, X3, X16, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X3]
    MOV  X4, X3
    LD4R { V6.4S, V7.4S, V8.4S, V9.4S }, [X4], #16
    ADD  X3, X3, X16, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X3]
    MOV  X4, X3
    LD4R { V2.2D, V3.2D, V4.2D, V5.2D }, [X4], #32
    ADD  X3, X3, X16, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X3]
    MOV  X4, X3
    LD4R { V22.1D, V23.1D, V24.1D, V25.1D }, [X4], #32
    ADD  X3, X3, X16, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X3]
    MOV  X4, X3
    LD4R { V2.2D, V3.2D, V4.2D, V5.2D }, [X4], #32
    ADD  X3, X3, X16
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X3]
    MOV  X4, X3
    LD4R { V10.8B, V11.8B, V12.8B, V13.8B }, [X4], #4
    ADD  X3, X3, X16, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X3]
    MOV  X4, X3
    LD4R { V10.16B, V11.16B, V12.16B, V13.16B }, [X4], #4
    ADD  X3, X3, X16, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X3]
    MOV  X4, X3
    LD4R { V2.8B, V3.8B, V4.8B, V5.8B }, [X4], #4
    ADD  X3, X3, X16, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X3]
    MOV  X4, X3
    LD4R { V2.4H, V3.4H, V4.4H, V5.4H }, [X4], #8
    ADD  X3, X3, X16, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X3]
    MOV  X4, X3
    LD4R { V22.8H, V23.8H, V24.8H, V25.8H }, [X4], #8
    ADD  X3, X3, X16, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X3]
    MOV  X4, X3
    LD4R { V21.4H, V22.4H, V23.4H, V24.4H }, [X4], #8
    ADD  X3, X3, X16, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X3]
    LD4R { V2.2D, V3.2D, V4.2D, V5.2D }, [X3], X28
    ADD  X3, X3, X16
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X3]
    LD4R { V2.16B, V3.16B, V4.16B, V5.16B }, [X3], X28
    ADD  X3, X3, X16
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X3]
    LD4R { V10.2D, V11.2D, V12.2D, V13.2D }, [X3], X28
    ADD  X3, X3, X16, ASR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X3]
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X3], X28
    ADD  X3, X3, X16, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X3]
    LD4R { V27.8H, V28.8H, V29.8H, V30.8H }, [X3], X28
    ADD  X3, X3, X16, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X3]
    LD4R { V22.1D, V23.1D, V24.1D, V25.1D }, [X3], X28
    ADD  X3, X3, X16, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X3]
    LD4R { V27.1D, V28.1D, V29.1D, V30.1D }, [X3], X28
    ADD  X3, X3, X16
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X3]
    LD4R { V10.2S, V11.2S, V12.2S, V13.2S }, [X3], X28
    ADD  X3, X3, X16, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X3]
    LD4R { V10.4H, V11.4H, V12.4H, V13.4H }, [X3], X28
    ADD  X3, X3, X16, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X3]
    LD4R { V24.8B, V25.8B, V26.8B, V27.8B }, [X3], X28
    ADD  X3, X3, X16, LSR #0
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X27, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X27, FPSR
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V0.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D0
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V1.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D1
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V2.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D2
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V3.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D3
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V4.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D4
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V5.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D5
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V6.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D6
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V7.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D7
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V8.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D8
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V9.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D9
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V10.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D10
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V11.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D11
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V12.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D12
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D13
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V14.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D14
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D15
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V16.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D16
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V17.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D17
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V18.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D18
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V19.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D19
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V20.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D20
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D21
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D22
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D23
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D24
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D25
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D26
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D27
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D28
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D29
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X27, V30.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D30
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, V31.D[1]
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X27, D31
    SUB  X25, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D2, X3
    FMOV  V2.D[1], X4
    FMOV  D3, X9
    FMOV  V3.D[1], X16
    FMOV  D4, X3
    FMOV  V4.D[1], X23
    FMOV  D5, X6
    FMOV  V5.D[1], X15
    FMOV  D6, X6
    FMOV  V6.D[1], X22
    FMOV  D7, X19
    FMOV  V7.D[1], X20
    FMOV  D8, X8
    FMOV  V8.D[1], X23
    FMOV  D9, X4
    FMOV  V9.D[1], X13
    FMOV  D10, X26
    FMOV  V10.D[1], X28
    FMOV  D11, X16
    FMOV  V11.D[1], X22
    FMOV  D12, X3
    FMOV  V12.D[1], X13
    FMOV  D13, X21
    FMOV  V13.D[1], X22
    FMOV  D14, X22
    FMOV  V14.D[1], X13
    FMOV  D15, X28
    FMOV  V15.D[1], X5
    FMOV  D16, X2
    FMOV  V16.D[1], X3
    FMOV  D17, X4
    FMOV  V17.D[1], X16
    FMOV  D18, X5
    FMOV  V18.D[1], X19
    FMOV  D19, X13
    FMOV  V19.D[1], X21
    FMOV  D20, X23
    FMOV  V20.D[1], X17
    FMOV  D21, X28
    FMOV  V21.D[1], X16
    FMOV  D22, X3
    FMOV  V22.D[1], X20
    FMOV  D23, X13
    FMOV  V23.D[1], X9
    FMOV  D24, X9
    FMOV  V24.D[1], X26
    FMOV  D25, X7
    FMOV  V25.D[1], X26
    FMOV  D26, X7
    FMOV  V26.D[1], X5
    FMOV  D27, X14
    FMOV  V27.D[1], X2
    FMOV  D28, X14
    FMOV  V28.D[1], X5
    FMOV  D29, X20
    FMOV  V29.D[1], X8
    FMOV  D30, X21
    FMOV  V30.D[1], X22
    FMOV  D31, X16
    FMOV  V31.D[1], X4
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X12, #0xa00, LSL #0
    ADD  X28, X30, X12, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X28]
    LD4R { V3.8H, V4.8H, V5.8H, V6.8H }, [X28]
    ADD  X28, X28, X19
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X28]
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X28]
    ADD  X28, X28, X19, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X28]
    LD4R { V31.2D, V0.2D, V1.2D, V2.2D }, [X28]
    ADD  X28, X28, X19
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X28]
    LD4R { V24.4S, V25.4S, V26.4S, V27.4S }, [X28]
    ADD  X28, X28, X19
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X28]
    LD4R { V29.8H, V30.8H, V31.8H, V0.8H }, [X28]
    ADD  X28, X28, X19
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X28]
    LD4R { V13.2S, V14.2S, V15.2S, V16.2S }, [X28]
    ADD  X28, X28, X19
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X28]
    LD4R { V3.1D, V4.1D, V5.1D, V6.1D }, [X28]
    ADD  X28, X28, X19, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X28]
    LD4R { V9.2S, V10.2S, V11.2S, V12.2S }, [X28]
    ADD  X28, X28, X19, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X28]
    LD4R { V24.4H, V25.4H, V26.4H, V27.4H }, [X28]
    ADD  X28, X28, X19, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X28]
    LD4R { V13.8B, V14.8B, V15.8B, V16.8B }, [X28]
    ADD  X28, X28, X19, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X28]
    MOV  X8, X28
    LD4R { V29.2S, V30.2S, V31.2S, V0.2S }, [X8], #16
    ADD  X28, X28, X19
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X28]
    MOV  X8, X28
    LD4R { V12.2S, V13.2S, V14.2S, V15.2S }, [X8], #16
    ADD  X28, X28, X19
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X28]
    MOV  X8, X28
    LD4R { V14.4S, V15.4S, V16.4S, V17.4S }, [X8], #16
    ADD  X28, X28, X19, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X28]
    MOV  X8, X28
    LD4R { V11.1D, V12.1D, V13.1D, V14.1D }, [X8], #32
    ADD  X28, X28, X19
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X28]
    MOV  X8, X28
    LD4R { V24.1D, V25.1D, V26.1D, V27.1D }, [X8], #32
    ADD  X28, X28, X19
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X28]
    MOV  X8, X28
    LD4R { V24.2D, V25.2D, V26.2D, V27.2D }, [X8], #32
    ADD  X28, X28, X19, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X28]
    MOV  X8, X28
    LD4R { V14.16B, V15.16B, V16.16B, V17.16B }, [X8], #4
    ADD  X28, X28, X19
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X28]
    MOV  X8, X28
    LD4R { V9.16B, V10.16B, V11.16B, V12.16B }, [X8], #4
    ADD  X28, X28, X19, LSR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X28]
    MOV  X8, X28
    LD4R { V9.8B, V10.8B, V11.8B, V12.8B }, [X8], #4
    ADD  X28, X28, X19, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X28]
    MOV  X8, X28
    LD4R { V9.4H, V10.4H, V11.4H, V12.4H }, [X8], #8
    ADD  X28, X28, X19, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X28]
    MOV  X8, X28
    LD4R { V23.8H, V24.8H, V25.8H, V26.8H }, [X8], #8
    ADD  X28, X28, X19
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X28]
    MOV  X8, X28
    LD4R { V14.4H, V15.4H, V16.4H, V17.4H }, [X8], #8
    ADD  X28, X28, X19
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X28]
    LD4R { V23.16B, V24.16B, V25.16B, V26.16B }, [X28], X11
    ADD  X28, X28, X19, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X28]
    LD4R { V9.16B, V10.16B, V11.16B, V12.16B }, [X28], X11
    ADD  X28, X28, X19, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X28]
    LD4R { V14.2D, V15.2D, V16.2D, V17.2D }, [X28], X11
    ADD  X28, X28, X19, LSR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X28]
    LD4R { V14.4S, V15.4S, V16.4S, V17.4S }, [X28], X11
    ADD  X28, X28, X19, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X28]
    LD4R { V23.8H, V24.8H, V25.8H, V26.8H }, [X28], X11
    ADD  X28, X28, X19, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X28]
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X28], X11
    ADD  X28, X28, X19, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X28]
    LD4R { V9.1D, V10.1D, V11.1D, V12.1D }, [X28], X11
    ADD  X28, X28, X19, LSR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X28]
    LD4R { V23.2S, V24.2S, V25.2S, V26.2S }, [X28], X11
    ADD  X28, X28, X19, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X28]
    LD4R { V14.4H, V15.4H, V16.4H, V17.4H }, [X28], X11
    ADD  X28, X28, X19, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X28]
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X28], X11
    ADD  X28, X28, X19, LSR #0
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X21, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D0
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D3
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D5
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D6
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D10
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D11
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D16
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V17.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D17
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V20.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V21.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V22.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D24
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D25
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V27.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D1, X25
    FMOV  V1.D[1], X21
    FMOV  D2, X28
    FMOV  V2.D[1], X2
    FMOV  D3, X27
    FMOV  V3.D[1], X9
    FMOV  D4, X5
    FMOV  V4.D[1], X13
    FMOV  D5, X20
    FMOV  V5.D[1], X21
    FMOV  D6, X4
    FMOV  V6.D[1], X19
    FMOV  D7, X22
    FMOV  V7.D[1], X5
    FMOV  D8, X6
    FMOV  V8.D[1], X19
    FMOV  D9, X9
    FMOV  V9.D[1], X13
    FMOV  D10, X22
    FMOV  V10.D[1], X28
    FMOV  D11, X21
    FMOV  V11.D[1], X23
    FMOV  D12, X23
    FMOV  V12.D[1], X26
    FMOV  D13, X3
    FMOV  V13.D[1], X23
    FMOV  D14, X20
    FMOV  V14.D[1], X28
    FMOV  D15, X25
    FMOV  V15.D[1], X21
    FMOV  D16, X9
    FMOV  V16.D[1], X8
    FMOV  D17, X2
    FMOV  V17.D[1], X25
    FMOV  D18, X4
    FMOV  V18.D[1], X14
    FMOV  D19, X22
    FMOV  V19.D[1], X3
    FMOV  D20, X5
    FMOV  V20.D[1], X25
    FMOV  D21, X25
    FMOV  V21.D[1], X15
    FMOV  D22, X2
    FMOV  V22.D[1], X13
    FMOV  D23, X3
    FMOV  V23.D[1], X20
    FMOV  D24, X23
    FMOV  V24.D[1], X21
    FMOV  D25, X26
    FMOV  V25.D[1], X13
    FMOV  D26, X2
    FMOV  V26.D[1], X13
    FMOV  D27, X15
    FMOV  V27.D[1], X8
    FMOV  D28, X13
    FMOV  V28.D[1], X2
    FMOV  D29, X16
    FMOV  V29.D[1], X13
    FMOV  D30, X26
    FMOV  V30.D[1], X26
    FMOV  D31, X26
    FMOV  V31.D[1], X2
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X9, #0xf00, LSL #0
    ADD  X16, X30, X9, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X16]
    LD4R { V21.4S, V22.4S, V23.4S, V24.4S }, [X16]
    ADD  X16, X16, X20
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X16]
    LD4R { V18.16B, V19.16B, V20.16B, V21.16B }, [X16]
    ADD  X16, X16, X20
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X16]
    LD4R { V10.2D, V11.2D, V12.2D, V13.2D }, [X16]
    ADD  X16, X16, X20, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X16]
    LD4R { V18.4S, V19.4S, V20.4S, V21.4S }, [X16]
    ADD  X16, X16, X20
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X16]
    LD4R { V27.8H, V28.8H, V29.8H, V30.8H }, [X16]
    ADD  X16, X16, X20
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X16]
    LD4R { V21.1D, V22.1D, V23.1D, V24.1D }, [X16]
    ADD  X16, X16, X20, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X16]
    LD4R { V27.1D, V28.1D, V29.1D, V30.1D }, [X16]
    ADD  X16, X16, X20
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X16]
    LD4R { V31.2S, V0.2S, V1.2S, V2.2S }, [X16]
    ADD  X16, X16, X20
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X16]
    LD4R { V22.4H, V23.4H, V24.4H, V25.4H }, [X16]
    ADD  X16, X16, X20
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X16]
    LD4R { V18.8B, V19.8B, V20.8B, V21.8B }, [X16]
    ADD  X16, X16, X20, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X16]
    MOV  X7, X16
    LD4R { V12.4S, V13.4S, V14.4S, V15.4S }, [X7], #16
    ADD  X16, X16, X20, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X16]
    MOV  X7, X16
    LD4R { V18.2S, V19.2S, V20.2S, V21.2S }, [X7], #16
    ADD  X16, X16, X20, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X16]
    MOV  X7, X16
    LD4R { V24.4S, V25.4S, V26.4S, V27.4S }, [X7], #16
    ADD  X16, X16, X20
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X16]
    MOV  X7, X16
    LD4R { V12.1D, V13.1D, V14.1D, V15.1D }, [X7], #32
    ADD  X16, X16, X20
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X16]
    MOV  X7, X16
    LD4R { V30.1D, V31.1D, V0.1D, V1.1D }, [X7], #32
    ADD  X16, X16, X20
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X16]
    MOV  X7, X16
    LD4R { V12.2D, V13.2D, V14.2D, V15.2D }, [X7], #32
    ADD  X16, X16, X20, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X16]
    MOV  X7, X16
    LD4R { V18.16B, V19.16B, V20.16B, V21.16B }, [X7], #4
    ADD  X16, X16, X20
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X16]
    MOV  X7, X16
    LD4R { V18.16B, V19.16B, V20.16B, V21.16B }, [X7], #4
    ADD  X16, X16, X20
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X16]
    MOV  X7, X16
    LD4R { V12.8B, V13.8B, V14.8B, V15.8B }, [X7], #4
    ADD  X16, X16, X20, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X16]
    MOV  X7, X16
    LD4R { V30.4H, V31.4H, V0.4H, V1.4H }, [X7], #8
    ADD  X16, X16, X20
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X16]
    MOV  X7, X16
    LD4R { V12.8H, V13.8H, V14.8H, V15.8H }, [X7], #8
    ADD  X16, X16, X20, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X16]
    MOV  X7, X16
    LD4R { V30.8H, V31.8H, V0.8H, V1.8H }, [X7], #8
    ADD  X16, X16, X20, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X16]
    LD4R { V12.4S, V13.4S, V14.4S, V15.4S }, [X16], X12
    ADD  X16, X16, X20, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X16]
    LD4R { V29.16B, V30.16B, V31.16B, V0.16B }, [X16], X12
    ADD  X16, X16, X20, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X16]
    LD4R { V12.2D, V13.2D, V14.2D, V15.2D }, [X16], X12
    ADD  X16, X16, X20, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X16]
    LD4R { V12.4S, V13.4S, V14.4S, V15.4S }, [X16], X12
    ADD  X16, X16, X20, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X16]
    LD4R { V18.8H, V19.8H, V20.8H, V21.8H }, [X16], X12
    ADD  X16, X16, X20, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X16]
    LD4R { V18.8B, V19.8B, V20.8B, V21.8B }, [X16], X12
    ADD  X16, X16, X20, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X16]
    LD4R { V30.1D, V31.1D, V0.1D, V1.1D }, [X16], X12
    ADD  X16, X16, X20, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X16]
    LD4R { V12.2S, V13.2S, V14.2S, V15.2S }, [X16], X12
    ADD  X16, X16, X20
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X16]
    LD4R { V30.4H, V31.4H, V0.4H, V1.4H }, [X16], X12
    ADD  X16, X16, X20, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X16]
    LD4R { V12.8B, V13.8B, V14.8B, V15.8B }, [X16], X12
    ADD  X16, X16, X20, LSR #0
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X5, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    MRS  X5, FPSR
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V0.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D0
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V1.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D1
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V2.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D2
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V3.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D3
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V4.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D4
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V5.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D5
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V6.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D6
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V7.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D7
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V8.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D8
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V9.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D9
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V10.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D10
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V11.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D11
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D12
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V13.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D13
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D14
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D15
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V16.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D16
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V17.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D17
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V18.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D18
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V19.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D19
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D20
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D21
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V22.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D22
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D23
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V24.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D24
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V25.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D25
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V26.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D26
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V27.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D27
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V28.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D28
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, V29.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D29
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D30
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X5, D31
    SUB  X21, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X22
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X16
    FMOV  V3.D[1], X21
    FMOV  D4, X17
    FMOV  V4.D[1], X26
    FMOV  D5, X25
    FMOV  V5.D[1], X5
    FMOV  D6, X19
    FMOV  V6.D[1], X25
    FMOV  D7, X11
    FMOV  V7.D[1], X17
    FMOV  D8, X27
    FMOV  V8.D[1], X2
    FMOV  D9, X25
    FMOV  V9.D[1], X25
    FMOV  D10, X6
    FMOV  V10.D[1], X14
    FMOV  D11, X27
    FMOV  V11.D[1], X21
    FMOV  D12, X15
    FMOV  V12.D[1], X16
    FMOV  D13, X7
    FMOV  V13.D[1], X5
    FMOV  D14, X26
    FMOV  V14.D[1], X2
    FMOV  D15, X19
    FMOV  V15.D[1], X25
    FMOV  D16, X21
    FMOV  V16.D[1], X17
    FMOV  D17, X21
    FMOV  V17.D[1], X28
    FMOV  D18, X12
    FMOV  V18.D[1], X23
    FMOV  D19, X27
    FMOV  V19.D[1], X6
    FMOV  D20, X6
    FMOV  V20.D[1], X27
    FMOV  D21, X2
    FMOV  V21.D[1], X11
    FMOV  D22, X9
    FMOV  V22.D[1], X15
    FMOV  D23, X11
    FMOV  V23.D[1], X27
    FMOV  D24, X12
    FMOV  V24.D[1], X17
    FMOV  D25, X5
    FMOV  V25.D[1], X8
    FMOV  D26, X4
    FMOV  V26.D[1], X14
    FMOV  D27, X12
    FMOV  V27.D[1], X2
    FMOV  D28, X7
    FMOV  V28.D[1], X17
    FMOV  D29, X12
    FMOV  V29.D[1], X25
    FMOV  D30, X12
    FMOV  V30.D[1], X23
    FMOV  D31, X13
    FMOV  V31.D[1], X5
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X2, #0x1400, LSL #0
    ADD  X9, X30, X2, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X9]
    LD4R { V22.8H, V23.8H, V24.8H, V25.8H }, [X9]
    ADD  X9, X9, X4, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X9]
    LD4R { V5.16B, V6.16B, V7.16B, V8.16B }, [X9]
    ADD  X9, X9, X4, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X9]
    LD4R { V3.2D, V4.2D, V5.2D, V6.2D }, [X9]
    ADD  X9, X9, X4
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X9]
    LD4R { V31.4S, V0.4S, V1.4S, V2.4S }, [X9]
    ADD  X9, X9, X4, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X9]
    LD4R { V20.8H, V21.8H, V22.8H, V23.8H }, [X9]
    ADD  X9, X9, X4
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X9]
    LD4R { V13.1D, V14.1D, V15.1D, V16.1D }, [X9]
    ADD  X9, X9, X4
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X9]
    LD4R { V19.1D, V20.1D, V21.1D, V22.1D }, [X9]
    ADD  X9, X9, X4, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X9]
    LD4R { V15.2S, V16.2S, V17.2S, V18.2S }, [X9]
    ADD  X9, X9, X4, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X9]
    LD4R { V25.4H, V26.4H, V27.4H, V28.4H }, [X9]
    ADD  X9, X9, X4
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X9]
    LD4R { V31.8B, V0.8B, V1.8B, V2.8B }, [X9]
    ADD  X9, X9, X4, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X9]
    MOV  X12, X9
    LD4R { V25.4S, V26.4S, V27.4S, V28.4S }, [X12], #16
    ADD  X9, X9, X4
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X9]
    MOV  X12, X9
    LD4R { V9.2S, V10.2S, V11.2S, V12.2S }, [X12], #16
    ADD  X9, X9, X4, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X9]
    MOV  X12, X9
    LD4R { V0.4S, V1.4S, V2.4S, V3.4S }, [X12], #16
    ADD  X9, X9, X4, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X9]
    MOV  X12, X9
    LD4R { V19.1D, V20.1D, V21.1D, V22.1D }, [X12], #32
    ADD  X9, X9, X4, ASR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X9]
    MOV  X12, X9
    LD4R { V26.1D, V27.1D, V28.1D, V29.1D }, [X12], #32
    ADD  X9, X9, X4, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X9]
    MOV  X12, X9
    LD4R { V17.2D, V18.2D, V19.2D, V20.2D }, [X12], #32
    ADD  X9, X9, X4
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X9]
    MOV  X12, X9
    LD4R { V10.16B, V11.16B, V12.16B, V13.16B }, [X12], #4
    ADD  X9, X9, X4
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X9]
    MOV  X12, X9
    LD4R { V26.16B, V27.16B, V28.16B, V29.16B }, [X12], #4
    ADD  X9, X9, X4
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X9]
    MOV  X12, X9
    LD4R { V17.8B, V18.8B, V19.8B, V20.8B }, [X12], #4
    ADD  X9, X9, X4, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X9]
    MOV  X12, X9
    LD4R { V17.4H, V18.4H, V19.4H, V20.4H }, [X12], #8
    ADD  X9, X9, X4, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X9]
    MOV  X12, X9
    LD4R { V17.8H, V18.8H, V19.8H, V20.8H }, [X12], #8
    ADD  X9, X9, X4
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X9]
    MOV  X12, X9
    LD4R { V18.4H, V19.4H, V20.4H, V21.4H }, [X12], #8
    ADD  X9, X9, X4, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X9]
    LD4R { V18.8H, V19.8H, V20.8H, V21.8H }, [X9], X17
    ADD  X9, X9, X4, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X9]
    LD4R { V10.16B, V11.16B, V12.16B, V13.16B }, [X9], X17
    ADD  X9, X9, X4
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X9]
    LD4R { V10.2D, V11.2D, V12.2D, V13.2D }, [X9], X17
    ADD  X9, X9, X4, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X9]
    LD4R { V4.4S, V5.4S, V6.4S, V7.4S }, [X9], X17
    ADD  X9, X9, X4, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X9]
    LD4R { V23.8H, V24.8H, V25.8H, V26.8H }, [X9], X17
    ADD  X9, X9, X4
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X9]
    LD4R { V10.4H, V11.4H, V12.4H, V13.4H }, [X9], X17
    ADD  X9, X9, X4, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X9]
    LD4R { V12.1D, V13.1D, V14.1D, V15.1D }, [X9], X17
    ADD  X9, X9, X4, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X9]
    LD4R { V3.2S, V4.2S, V5.2S, V6.2S }, [X9], X17
    ADD  X9, X9, X4
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X9]
    LD4R { V11.4H, V12.4H, V13.4H, V14.4H }, [X9], X17
    ADD  X9, X9, X4, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X9]
    LD4R { V7.8B, V8.8B, V9.8B, V10.8B }, [X9], X17
    ADD  X9, X9, X4, ASR #0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X13, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V0.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D0
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V1.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D1
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V2.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D2
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D3
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D4
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D5
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D6
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D7
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D8
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D9
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D10
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D11
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D12
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D13
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D14
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D15
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D16
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V17.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D17
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V18.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D18
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V19.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D19
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V20.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D20
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V21.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D21
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D22
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V23.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D23
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V24.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D24
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V25.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D25
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V26.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D26
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V27.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D27
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V28.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D28
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V29.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D29
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, V30.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D30
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X13, D31
    SUB  X11, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  V1.D[1], X25
    FMOV  D2, X21
    FMOV  V2.D[1], X26
    FMOV  D3, X13
    FMOV  V3.D[1], X3
    FMOV  D4, X21
    FMOV  V4.D[1], X17
    FMOV  D5, X16
    FMOV  V5.D[1], X16
    FMOV  D6, X26
    FMOV  V6.D[1], X25
    FMOV  D7, X28
    FMOV  V7.D[1], X23
    FMOV  D8, X2
    FMOV  V8.D[1], X6
    FMOV  D9, X27
    FMOV  V9.D[1], X21
    FMOV  D10, X23
    FMOV  V10.D[1], X27
    FMOV  D11, X7
    FMOV  V11.D[1], X19
    FMOV  D12, X2
    FMOV  V12.D[1], X13
    FMOV  D13, X19
    FMOV  V13.D[1], X14
    FMOV  D14, X7
    FMOV  V14.D[1], X2
    FMOV  D15, X6
    FMOV  V15.D[1], X5
    FMOV  D16, X13
    FMOV  V16.D[1], X12
    FMOV  D17, X25
    FMOV  V17.D[1], X19
    FMOV  D18, X27
    FMOV  V18.D[1], X22
    FMOV  D19, X25
    FMOV  V19.D[1], X9
    FMOV  D20, X27
    FMOV  V20.D[1], X3
    FMOV  D21, X13
    FMOV  V21.D[1], X23
    FMOV  D22, X26
    FMOV  V22.D[1], X21
    FMOV  D23, X25
    FMOV  V23.D[1], X13
    FMOV  D24, X28
    FMOV  V24.D[1], X11
    FMOV  D25, X12
    FMOV  V25.D[1], X23
    FMOV  D26, X16
    FMOV  V26.D[1], X20
    FMOV  D27, X20
    FMOV  V27.D[1], X28
    FMOV  D28, X13
    FMOV  V28.D[1], X13
    FMOV  D29, X28
    FMOV  V29.D[1], X2
    FMOV  D30, X4
    FMOV  V30.D[1], X17
    FMOV  D31, X12
    FMOV  V31.D[1], X9
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X9, #0x1900, LSL #0
    ADD  X7, X30, X9, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X7]
    LD4R { V0.4S, V1.4S, V2.4S, V3.4S }, [X7]
    ADD  X7, X7, X12, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X7]
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X7]
    ADD  X7, X7, X12
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X7]
    LD4R { V8.2D, V9.2D, V10.2D, V11.2D }, [X7]
    ADD  X7, X7, X12
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X7]
    LD4R { V29.4S, V30.4S, V31.4S, V0.4S }, [X7]
    ADD  X7, X7, X12, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X7]
    LD4R { V30.8H, V31.8H, V0.8H, V1.8H }, [X7]
    ADD  X7, X7, X12
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X7]
    LD4R { V30.4H, V31.4H, V0.4H, V1.4H }, [X7]
    ADD  X7, X7, X12, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X7]
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X7]
    ADD  X7, X7, X12, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X7]
    LD4R { V11.2S, V12.2S, V13.2S, V14.2S }, [X7]
    ADD  X7, X7, X12, ASR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X7]
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X7]
    ADD  X7, X7, X12, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X7]
    LD4R { V28.8B, V29.8B, V30.8B, V31.8B }, [X7]
    ADD  X7, X7, X12
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X7]
    MOV  X13, X7
    LD4R { V1.4S, V2.4S, V3.4S, V4.4S }, [X13], #16
    ADD  X7, X7, X12
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X7]
    MOV  X13, X7
    LD4R { V20.2S, V21.2S, V22.2S, V23.2S }, [X13], #16
    ADD  X7, X7, X12, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X7]
    MOV  X13, X7
    LD4R { V11.4S, V12.4S, V13.4S, V14.4S }, [X13], #16
    ADD  X7, X7, X12
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X7]
    MOV  X13, X7
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X13], #32
    ADD  X7, X7, X12, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X7]
    MOV  X13, X7
    LD4R { V28.1D, V29.1D, V30.1D, V31.1D }, [X13], #32
    ADD  X7, X7, X12
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X7]
    MOV  X13, X7
    LD4R { V11.2D, V12.2D, V13.2D, V14.2D }, [X13], #32
    ADD  X7, X7, X12, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X7]
    MOV  X13, X7
    LD4R { V26.16B, V27.16B, V28.16B, V29.16B }, [X13], #4
    ADD  X7, X7, X12
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X7]
    MOV  X13, X7
    LD4R { V20.16B, V21.16B, V22.16B, V23.16B }, [X13], #4
    ADD  X7, X7, X12
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X7]
    MOV  X13, X7
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X13], #4
    ADD  X7, X7, X12, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X7]
    MOV  X13, X7
    LD4R { V11.4H, V12.4H, V13.4H, V14.4H }, [X13], #8
    ADD  X7, X7, X12, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X7]
    MOV  X13, X7
    LD4R { V1.8H, V2.8H, V3.8H, V4.8H }, [X13], #8
    ADD  X7, X7, X12
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X7]
    MOV  X13, X7
    LD4R { V20.8H, V21.8H, V22.8H, V23.8H }, [X13], #8
    ADD  X7, X7, X12, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X7]
    LD4R { V20.16B, V21.16B, V22.16B, V23.16B }, [X7], X26
    ADD  X7, X7, X12
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X7]
    LD4R { V20.16B, V21.16B, V22.16B, V23.16B }, [X7], X26
    ADD  X7, X7, X12, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X7]
    LD4R { V20.2D, V21.2D, V22.2D, V23.2D }, [X7], X26
    ADD  X7, X7, X12, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X7]
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X7], X26
    ADD  X7, X7, X12, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X7]
    LD4R { V29.8H, V30.8H, V31.8H, V0.8H }, [X7], X26
    ADD  X7, X7, X12
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X7]
    LD4R { V26.4H, V27.4H, V28.4H, V29.4H }, [X7], X26
    ADD  X7, X7, X12, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X7]
    LD4R { V7.1D, V8.1D, V9.1D, V10.1D }, [X7], X26
    ADD  X7, X7, X12, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X7]
    LD4R { V1.2S, V2.2S, V3.2S, V4.2S }, [X7], X26
    ADD  X7, X7, X12
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X7]
    LD4R { V1.4H, V2.4H, V3.4H, V4.4H }, [X7], X26
    ADD  X7, X7, X12, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X7]
    LD4R { V11.8B, V12.8B, V13.8B, V14.8B }, [X7], X26
    ADD  X7, X7, X12, LSR #0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X2, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X2, FPSR
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V0.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D0
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D1
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D2
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V3.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D3
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V4.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D4
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D5
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V6.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D6
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D7
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D8
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D9
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D10
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D11
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D12
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D13
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D14
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D15
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D16
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V17.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D17
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V18.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D18
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V19.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D19
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D20
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D21
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D22
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V23.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D23
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V24.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D24
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V25.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D25
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D26
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D27
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D28
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X2, V29.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D29
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V30.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D30
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, V31.D[1]
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    FMOV  X2, D31
    SUB  X19, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X23
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X4
    FMOV  V3.D[1], X12
    FMOV  D4, X25
    FMOV  V4.D[1], X6
    FMOV  D5, X19
    FMOV  V5.D[1], X23
    FMOV  D6, X21
    FMOV  V6.D[1], X8
    FMOV  D7, X11
    FMOV  V7.D[1], X22
    FMOV  D8, X13
    FMOV  V8.D[1], X20
    FMOV  D9, X26
    FMOV  V9.D[1], X7
    FMOV  D10, X14
    FMOV  V10.D[1], X19
    FMOV  D11, X19
    FMOV  V11.D[1], X7
    FMOV  D12, X17
    FMOV  V12.D[1], X5
    FMOV  D13, X22
    FMOV  V13.D[1], X27
    FMOV  D14, X5
    FMOV  V14.D[1], X9
    FMOV  D15, X21
    FMOV  V15.D[1], X21
    FMOV  D16, X22
    FMOV  V16.D[1], X27
    FMOV  D17, X27
    FMOV  V17.D[1], X17
    FMOV  D18, X28
    FMOV  V18.D[1], X23
    FMOV  D19, X20
    FMOV  V19.D[1], X14
    FMOV  D20, X4
    FMOV  V20.D[1], X17
    FMOV  D21, X12
    FMOV  V21.D[1], X21
    FMOV  D22, X4
    FMOV  V22.D[1], X2
    FMOV  D23, X14
    FMOV  V23.D[1], X9
    FMOV  D24, X20
    FMOV  V24.D[1], X9
    FMOV  D25, X13
    FMOV  V25.D[1], X15
    FMOV  D26, X12
    FMOV  V26.D[1], X14
    FMOV  D27, X8
    FMOV  V27.D[1], X14
    FMOV  D28, X22
    FMOV  V28.D[1], X28
    FMOV  D29, X12
    FMOV  V29.D[1], X28
    FMOV  D30, X17
    FMOV  V30.D[1], X26
    FMOV  D31, X9
    FMOV  V31.D[1], X23
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X12, #0x1e00, LSL #0
    ADD  X14, X30, X12
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X14]
    LD4R { V23.8H, V24.8H, V25.8H, V26.8H }, [X14]
    ADD  X14, X14, X16, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X14]
    LD4R { V27.16B, V28.16B, V29.16B, V30.16B }, [X14]
    ADD  X14, X14, X16
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X14]
    LD4R { V6.2D, V7.2D, V8.2D, V9.2D }, [X14]
    ADD  X14, X14, X16
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X14]
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X14]
    ADD  X14, X14, X16, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X14]
    LD4R { V0.8H, V1.8H, V2.8H, V3.8H }, [X14]
    ADD  X14, X14, X16, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X14]
    LD4R { V7.1D, V8.1D, V9.1D, V10.1D }, [X14]
    ADD  X14, X14, X16, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X14]
    LD4R { V2.1D, V3.1D, V4.1D, V5.1D }, [X14]
    ADD  X14, X14, X16, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X14]
    LD4R { V18.2S, V19.2S, V20.2S, V21.2S }, [X14]
    ADD  X14, X14, X16
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X14]
    LD4R { V18.4H, V19.4H, V20.4H, V21.4H }, [X14]
    ADD  X14, X14, X16, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X14]
    LD4R { V27.8B, V28.8B, V29.8B, V30.8B }, [X14]
    ADD  X14, X14, X16, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X14]
    MOV  X11, X14
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X11], #16
    ADD  X14, X14, X16, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X14]
    MOV  X11, X14
    LD4R { V0.2S, V1.2S, V2.2S, V3.2S }, [X11], #16
    ADD  X14, X14, X16, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X14]
    MOV  X11, X14
    LD4R { V7.4S, V8.4S, V9.4S, V10.4S }, [X11], #16
    ADD  X14, X14, X16
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X14]
    MOV  X11, X14
    LD4R { V27.2D, V28.2D, V29.2D, V30.2D }, [X11], #32
    ADD  X14, X14, X16, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X14]
    MOV  X11, X14
    LD4R { V0.1D, V1.1D, V2.1D, V3.1D }, [X11], #32
    ADD  X14, X14, X16
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X14]
    MOV  X11, X14
    LD4R { V27.2D, V28.2D, V29.2D, V30.2D }, [X11], #32
    ADD  X14, X14, X16, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X14]
    MOV  X11, X14
    LD4R { V0.8B, V1.8B, V2.8B, V3.8B }, [X11], #4
    ADD  X14, X14, X16, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X14]
    MOV  X11, X14
    LD4R { V0.16B, V1.16B, V2.16B, V3.16B }, [X11], #4
    ADD  X14, X14, X16
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X14]
    MOV  X11, X14
    LD4R { V0.8B, V1.8B, V2.8B, V3.8B }, [X11], #4
    ADD  X14, X14, X16, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X14]
    MOV  X11, X14
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X11], #8
    ADD  X14, X14, X16
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X14]
    MOV  X11, X14
    LD4R { V0.8H, V1.8H, V2.8H, V3.8H }, [X11], #8
    ADD  X14, X14, X16
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X14]
    MOV  X11, X14
    LD4R { V27.8H, V28.8H, V29.8H, V30.8H }, [X11], #8
    ADD  X14, X14, X16, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X14]
    LD4R { V0.2D, V1.2D, V2.2D, V3.2D }, [X14], X13
    ADD  X14, X14, X16, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X14]
    LD4R { V0.16B, V1.16B, V2.16B, V3.16B }, [X14], X13
    ADD  X14, X14, X16, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X14]
    LD4R { V0.2D, V1.2D, V2.2D, V3.2D }, [X14], X13
    ADD  X14, X14, X16, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X14]
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X14], X13
    ADD  X14, X14, X16, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X14]
    LD4R { V30.8H, V31.8H, V0.8H, V1.8H }, [X14], X13
    ADD  X14, X14, X16
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X14]
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X14], X13
    ADD  X14, X14, X16
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X14]
    LD4R { V17.1D, V18.1D, V19.1D, V20.1D }, [X14], X13
    ADD  X14, X14, X16, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X14]
    LD4R { V18.2S, V19.2S, V20.2S, V21.2S }, [X14], X13
    ADD  X14, X14, X16
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X14]
    LD4R { V11.4H, V12.4H, V13.4H, V14.4H }, [X14], X13
    ADD  X14, X14, X16
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X14]
    LD4R { V30.8B, V31.8B, V0.8B, V1.8B }, [X14], X13
    ADD  X14, X14, X16
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X19, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D0
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V1.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D1
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V2.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D2
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V3.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D3
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V4.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D4
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V5.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D5
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D6
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V7.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D7
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V8.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D8
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V9.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D9
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V10.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D10
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D11
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D12
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V13.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D13
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V14.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D14
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D15
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V16.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D16
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V17.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D17
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V18.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D18
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V19.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D19
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D20
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V21.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D21
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D22
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V23.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D23
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V24.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D24
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V25.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D25
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V26.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D26
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V27.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D27
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V28.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D28
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, V29.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D29
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D30
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X19, D31
    SUB  X3, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X25
    FMOV  D2, X22
    FMOV  V2.D[1], X28
    FMOV  D3, X3
    FMOV  V3.D[1], X5
    FMOV  D4, X3
    FMOV  V4.D[1], X21
    FMOV  D5, X27
    FMOV  V5.D[1], X9
    FMOV  D6, X19
    FMOV  V6.D[1], X25
    FMOV  D7, X15
    FMOV  V7.D[1], X20
    FMOV  D8, X13
    FMOV  V8.D[1], X14
    FMOV  D9, X7
    FMOV  V9.D[1], X17
    FMOV  D10, X8
    FMOV  V10.D[1], X14
    FMOV  D11, X25
    FMOV  V11.D[1], X27
    FMOV  D12, X12
    FMOV  V12.D[1], X20
    FMOV  D13, X26
    FMOV  V13.D[1], X7
    FMOV  D14, X14
    FMOV  V14.D[1], X9
    FMOV  D15, X19
    FMOV  V15.D[1], X28
    FMOV  D16, X21
    FMOV  V16.D[1], X21
    FMOV  D17, X12
    FMOV  V17.D[1], X25
    FMOV  D18, X28
    FMOV  V18.D[1], X7
    FMOV  D19, X14
    FMOV  V19.D[1], X2
    FMOV  D20, X13
    FMOV  V20.D[1], X22
    FMOV  D21, X27
    FMOV  V21.D[1], X12
    FMOV  D22, X3
    FMOV  V22.D[1], X8
    FMOV  D23, X4
    FMOV  V23.D[1], X5
    FMOV  D24, X6
    FMOV  V24.D[1], X11
    FMOV  D25, X9
    FMOV  V25.D[1], X22
    FMOV  D26, X13
    FMOV  V26.D[1], X22
    FMOV  D27, X20
    FMOV  V27.D[1], X15
    FMOV  D28, X2
    FMOV  V28.D[1], X27
    FMOV  D29, X27
    FMOV  V29.D[1], X22
    FMOV  D30, X9
    FMOV  V30.D[1], X21
    FMOV  D31, X8
    FMOV  V31.D[1], X4
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X28, #0x2300, LSL #0
    ADD  X5, X30, X28
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X5]
    LD4R { V7.4S, V8.4S, V9.4S, V10.4S }, [X5]
    ADD  X5, X5, X22, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X5]
    LD4R { V4.16B, V5.16B, V6.16B, V7.16B }, [X5]
    ADD  X5, X5, X22, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X5]
    LD4R { V2.2D, V3.2D, V4.2D, V5.2D }, [X5]
    ADD  X5, X5, X22
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X5]
    LD4R { V15.4S, V16.4S, V17.4S, V18.4S }, [X5]
    ADD  X5, X5, X22
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X5]
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X5]
    ADD  X5, X5, X22, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X5]
    LD4R { V23.1D, V24.1D, V25.1D, V26.1D }, [X5]
    ADD  X5, X5, X22, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X5]
    LD4R { V17.1D, V18.1D, V19.1D, V20.1D }, [X5]
    ADD  X5, X5, X22, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X5]
    LD4R { V18.2S, V19.2S, V20.2S, V21.2S }, [X5]
    ADD  X5, X5, X22
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X5]
    LD4R { V21.4H, V22.4H, V23.4H, V24.4H }, [X5]
    ADD  X5, X5, X22, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X5]
    LD4R { V13.8B, V14.8B, V15.8B, V16.8B }, [X5]
    ADD  X5, X5, X22, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X5]
    MOV  X7, X5
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X7], #16
    ADD  X5, X5, X22
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X5]
    MOV  X7, X5
    LD4R { V8.2S, V9.2S, V10.2S, V11.2S }, [X7], #16
    ADD  X5, X5, X22, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X5]
    MOV  X7, X5
    LD4R { V25.4S, V26.4S, V27.4S, V28.4S }, [X7], #16
    ADD  X5, X5, X22, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X5]
    MOV  X7, X5
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X7], #32
    ADD  X5, X5, X22
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X5]
    MOV  X7, X5
    LD4R { V8.1D, V9.1D, V10.1D, V11.1D }, [X7], #32
    ADD  X5, X5, X22, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X5]
    MOV  X7, X5
    LD4R { V12.2D, V13.2D, V14.2D, V15.2D }, [X7], #32
    ADD  X5, X5, X22, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X5]
    MOV  X7, X5
    LD4R { V21.16B, V22.16B, V23.16B, V24.16B }, [X7], #4
    ADD  X5, X5, X22
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X5]
    MOV  X7, X5
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X7], #4
    ADD  X5, X5, X22, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X5]
    MOV  X7, X5
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X7], #4
    ADD  X5, X5, X22, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X5]
    MOV  X7, X5
    LD4R { V21.4H, V22.4H, V23.4H, V24.4H }, [X7], #8
    ADD  X5, X5, X22
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X5]
    MOV  X7, X5
    LD4R { V21.8H, V22.8H, V23.8H, V24.8H }, [X7], #8
    ADD  X5, X5, X22, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X5]
    MOV  X7, X5
    LD4R { V24.4H, V25.4H, V26.4H, V27.4H }, [X7], #8
    ADD  X5, X5, X22
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X5]
    LD4R { V1.2D, V2.2D, V3.2D, V4.2D }, [X5], X2
    ADD  X5, X5, X22, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X5]
    LD4R { V22.16B, V23.16B, V24.16B, V25.16B }, [X5], X2
    ADD  X5, X5, X22, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X5]
    LD4R { V21.2D, V22.2D, V23.2D, V24.2D }, [X5], X2
    ADD  X5, X5, X22, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X5]
    LD4R { V21.4S, V22.4S, V23.4S, V24.4S }, [X5], X2
    ADD  X5, X5, X22, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X5]
    LD4R { V1.8H, V2.8H, V3.8H, V4.8H }, [X5], X2
    ADD  X5, X5, X22, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X5]
    LD4R { V1.1D, V2.1D, V3.1D, V4.1D }, [X5], X2
    ADD  X5, X5, X22, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X5]
    LD4R { V21.1D, V22.1D, V23.1D, V24.1D }, [X5], X2
    ADD  X5, X5, X22, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X5]
    LD4R { V21.2S, V22.2S, V23.2S, V24.2S }, [X5], X2
    ADD  X5, X5, X22, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X5]
    LD4R { V1.4H, V2.4H, V3.4H, V4.4H }, [X5], X2
    ADD  X5, X5, X22, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X5]
    LD4R { V9.8B, V10.8B, V11.8B, V12.8B }, [X5], X2
    ADD  X5, X5, X22, ASR #0
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X20, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    MRS  X20, FPSR
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V0.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D0
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V1.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D1
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V2.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D2
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V3.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D3
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D4
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V5.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D5
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V6.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D6
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V7.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D7
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V8.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D8
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V9.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D9
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V10.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D10
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V11.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D11
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V12.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D12
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V13.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D13
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V14.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D14
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V15.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D15
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V16.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D16
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V17.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D17
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V18.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D18
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V19.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D19
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V20.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D20
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V21.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D21
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V22.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D22
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V23.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D23
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V24.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D24
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V25.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D25
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V26.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D26
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X20, V27.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D27
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V28.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D28
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V29.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D29
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V30.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D30
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, V31.D[1]
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X20, D31
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X9
    FMOV  D3, X21
    FMOV  V3.D[1], X23
    FMOV  D4, X23
    FMOV  V4.D[1], X19
    FMOV  D5, X21
    FMOV  V5.D[1], X28
    FMOV  D6, X20
    FMOV  V6.D[1], X2
    FMOV  D7, X4
    FMOV  V7.D[1], X12
    FMOV  D8, X25
    FMOV  V8.D[1], X23
    FMOV  D9, X11
    FMOV  V9.D[1], X9
    FMOV  D10, X7
    FMOV  V10.D[1], X26
    FMOV  D11, X6
    FMOV  V11.D[1], X17
    FMOV  D12, X12
    FMOV  V12.D[1], X14
    FMOV  D13, X28
    FMOV  V13.D[1], X22
    FMOV  D14, X23
    FMOV  V14.D[1], X27
    FMOV  D15, X25
    FMOV  V15.D[1], X26
    FMOV  D16, X27
    FMOV  V16.D[1], X21
    FMOV  D17, X21
    FMOV  V17.D[1], X14
    FMOV  D18, X13
    FMOV  V18.D[1], X4
    FMOV  D19, X16
    FMOV  V19.D[1], X21
    FMOV  D20, X17
    FMOV  V20.D[1], X16
    FMOV  D21, X5
    FMOV  V21.D[1], X11
    FMOV  D22, X25
    FMOV  V22.D[1], X2
    FMOV  D23, X19
    FMOV  V23.D[1], X14
    FMOV  D24, X7
    FMOV  V24.D[1], X9
    FMOV  D25, X14
    FMOV  V25.D[1], X21
    FMOV  D26, X26
    FMOV  V26.D[1], X7
    FMOV  D27, X6
    FMOV  V27.D[1], X25
    FMOV  D28, X22
    FMOV  V28.D[1], X25
    FMOV  D29, X9
    FMOV  V29.D[1], X12
    FMOV  D30, X26
    FMOV  V30.D[1], X8
    FMOV  D31, X25
    FMOV  V31.D[1], X4
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X2, #0x2800, LSL #0
    ADD  X27, X30, X2, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X27]
    LD4R { V4.2D, V5.2D, V6.2D, V7.2D }, [X27]
    ADD  X27, X27, X23
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X27]
    LD4R { V31.16B, V0.16B, V1.16B, V2.16B }, [X27]
    ADD  X27, X27, X23
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X27]
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X27]
    ADD  X27, X27, X23, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X27]
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X27]
    ADD  X27, X27, X23, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X27]
    LD4R { V4.8H, V5.8H, V6.8H, V7.8H }, [X27]
    ADD  X27, X27, X23, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X27]
    LD4R { V22.1D, V23.1D, V24.1D, V25.1D }, [X27]
    ADD  X27, X27, X23
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X27]
    LD4R { V29.1D, V30.1D, V31.1D, V0.1D }, [X27]
    ADD  X27, X27, X23, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X27]
    LD4R { V22.2S, V23.2S, V24.2S, V25.2S }, [X27]
    ADD  X27, X27, X23
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X27]
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X27]
    ADD  X27, X27, X23, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X27]
    LD4R { V22.8B, V23.8B, V24.8B, V25.8B }, [X27]
    ADD  X27, X27, X23, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X27]
    MOV  X19, X27
    LD4R { V4.2S, V5.2S, V6.2S, V7.2S }, [X19], #16
    ADD  X27, X27, X23, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X27]
    MOV  X19, X27
    LD4R { V23.2S, V24.2S, V25.2S, V26.2S }, [X19], #16
    ADD  X27, X27, X23, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X27]
    MOV  X19, X27
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X19], #16
    ADD  X27, X27, X23
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X27]
    MOV  X19, X27
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X19], #32
    ADD  X27, X27, X23, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X27]
    MOV  X19, X27
    LD4R { V25.1D, V26.1D, V27.1D, V28.1D }, [X19], #32
    ADD  X27, X27, X23, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X27]
    MOV  X19, X27
    LD4R { V25.2D, V26.2D, V27.2D, V28.2D }, [X19], #32
    ADD  X27, X27, X23, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X27]
    MOV  X19, X27
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X19], #4
    ADD  X27, X27, X23
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X27]
    MOV  X19, X27
    LD4R { V15.16B, V16.16B, V17.16B, V18.16B }, [X19], #4
    ADD  X27, X27, X23, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X27]
    MOV  X19, X27
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X19], #4
    ADD  X27, X27, X23, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X27]
    MOV  X19, X27
    LD4R { V5.4H, V6.4H, V7.4H, V8.4H }, [X19], #8
    ADD  X27, X27, X23, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X27]
    MOV  X19, X27
    LD4R { V15.8H, V16.8H, V17.8H, V18.8H }, [X19], #8
    ADD  X27, X27, X23, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X27]
    MOV  X19, X27
    LD4R { V5.4H, V6.4H, V7.4H, V8.4H }, [X19], #8
    ADD  X27, X27, X23, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X27]
    LD4R { V15.2D, V16.2D, V17.2D, V18.2D }, [X27], X8
    ADD  X27, X27, X23, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X27]
    LD4R { V5.16B, V6.16B, V7.16B, V8.16B }, [X27], X8
    ADD  X27, X27, X23
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X27]
    LD4R { V5.2D, V6.2D, V7.2D, V8.2D }, [X27], X8
    ADD  X27, X27, X23, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X27]
    LD4R { V15.4S, V16.4S, V17.4S, V18.4S }, [X27], X8
    ADD  X27, X27, X23
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X27]
    LD4R { V15.8H, V16.8H, V17.8H, V18.8H }, [X27], X8
    ADD  X27, X27, X23, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X27]
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X27], X8
    ADD  X27, X27, X23
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X27]
    LD4R { V16.1D, V17.1D, V18.1D, V19.1D }, [X27], X8
    ADD  X27, X27, X23, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X27]
    LD4R { V27.2S, V28.2S, V29.2S, V30.2S }, [X27], X8
    ADD  X27, X27, X23, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X27]
    LD4R { V22.4H, V23.4H, V24.4H, V25.4H }, [X27], X8
    ADD  X27, X27, X23, ASR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X27]
    LD4R { V31.8B, V0.8B, V1.8B, V2.8B }, [X27], X8
    ADD  X27, X27, X23, LSR #0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X15, FPSR
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D0
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D1
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D2
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V3.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D3
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D4
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V5.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D5
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V6.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D6
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V7.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D7
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V8.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D8
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V9.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D9
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V10.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D10
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V11.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D11
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V12.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D12
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D13
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D14
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V15.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D15
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D16
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D17
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D18
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D19
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V20.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D20
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V21.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D21
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D22
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D23
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D24
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D25
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D26
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D27
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D28
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D29
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D30
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X15, D31
    SUB  X11, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
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
    FMOV  D1, X23
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X13
    FMOV  D3, X13
    FMOV  V3.D[1], X7
    FMOV  D4, X4
    FMOV  V4.D[1], X26
    FMOV  D5, X27
    FMOV  V5.D[1], X6
    FMOV  D6, X12
    FMOV  V6.D[1], X2
    FMOV  D7, X12
    FMOV  V7.D[1], X12
    FMOV  D8, X27
    FMOV  V8.D[1], X7
    FMOV  D9, X7
    FMOV  V9.D[1], X5
    FMOV  D10, X28
    FMOV  V10.D[1], X25
    FMOV  D11, X27
    FMOV  V11.D[1], X11
    FMOV  D12, X14
    FMOV  V12.D[1], X27
    FMOV  D13, X13
    FMOV  V13.D[1], X8
    FMOV  D14, X17
    FMOV  V14.D[1], X14
    FMOV  D15, X6
    FMOV  V15.D[1], X28
    FMOV  D16, X16
    FMOV  V16.D[1], X7
    FMOV  D17, X25
    FMOV  V17.D[1], X19
    FMOV  D18, X3
    FMOV  V18.D[1], X8
    FMOV  D19, X26
    FMOV  V19.D[1], X2
    FMOV  D20, X23
    FMOV  V20.D[1], X15
    FMOV  D21, X13
    FMOV  V21.D[1], X4
    FMOV  D22, X12
    FMOV  V22.D[1], X20
    FMOV  D23, X8
    FMOV  V23.D[1], X28
    FMOV  D24, X5
    FMOV  V24.D[1], X16
    FMOV  D25, X22
    FMOV  V25.D[1], X15
    FMOV  D26, X20
    FMOV  V26.D[1], X12
    FMOV  D27, X17
    FMOV  V27.D[1], X15
    FMOV  D28, X26
    FMOV  V28.D[1], X26
    FMOV  D29, X16
    FMOV  V29.D[1], X4
    FMOV  D30, X8
    FMOV  V30.D[1], X7
    FMOV  D31, X23
    FMOV  V31.D[1], X11
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X4, #0x2d00, LSL #0
    ADD  X25, X30, X4, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X25]
    LD4R { V13.4S, V14.4S, V15.4S, V16.4S }, [X25]
    ADD  X25, X25, X26, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X25]
    LD4R { V8.16B, V9.16B, V10.16B, V11.16B }, [X25]
    ADD  X25, X25, X26, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X25]
    LD4R { V18.2D, V19.2D, V20.2D, V21.2D }, [X25]
    ADD  X25, X25, X26
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X25]
    LD4R { V13.4S, V14.4S, V15.4S, V16.4S }, [X25]
    ADD  X25, X25, X26
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X25]
    LD4R { V30.8H, V31.8H, V0.8H, V1.8H }, [X25]
    ADD  X25, X25, X26, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X25]
    LD4R { V13.2S, V14.2S, V15.2S, V16.2S }, [X25]
    ADD  X25, X25, X26, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X25]
    LD4R { V9.1D, V10.1D, V11.1D, V12.1D }, [X25]
    ADD  X25, X25, X26, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X25]
    LD4R { V10.2S, V11.2S, V12.2S, V13.2S }, [X25]
    ADD  X25, X25, X26, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X25]
    LD4R { V18.4H, V19.4H, V20.4H, V21.4H }, [X25]
    ADD  X25, X25, X26
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X25]
    LD4R { V11.8B, V12.8B, V13.8B, V14.8B }, [X25]
    ADD  X25, X25, X26
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X25]
    MOV  X9, X25
    LD4R { V18.2S, V19.2S, V20.2S, V21.2S }, [X9], #16
    ADD  X25, X25, X26, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X25]
    MOV  X9, X25
    LD4R { V19.2S, V20.2S, V21.2S, V22.2S }, [X9], #16
    ADD  X25, X25, X26, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X25]
    MOV  X9, X25
    LD4R { V17.4S, V18.4S, V19.4S, V20.4S }, [X9], #16
    ADD  X25, X25, X26, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X25]
    MOV  X9, X25
    LD4R { V23.1D, V24.1D, V25.1D, V26.1D }, [X9], #32
    ADD  X25, X25, X26, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X25]
    MOV  X9, X25
    LD4R { V0.1D, V1.1D, V2.1D, V3.1D }, [X9], #32
    ADD  X25, X25, X26, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X25]
    MOV  X9, X25
    LD4R { V23.2D, V24.2D, V25.2D, V26.2D }, [X9], #32
    ADD  X25, X25, X26
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X25]
    MOV  X9, X25
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X9], #4
    ADD  X25, X25, X26, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X25]
    MOV  X9, X25
    LD4R { V5.16B, V6.16B, V7.16B, V8.16B }, [X9], #4
    ADD  X25, X25, X26, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X25]
    MOV  X9, X25
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X9], #4
    ADD  X25, X25, X26, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X25]
    MOV  X9, X25
    LD4R { V0.4H, V1.4H, V2.4H, V3.4H }, [X9], #8
    ADD  X25, X25, X26, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X25]
    MOV  X9, X25
    LD4R { V9.8H, V10.8H, V11.8H, V12.8H }, [X9], #8
    ADD  X25, X25, X26, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X25]
    MOV  X9, X25
    LD4R { V5.4H, V6.4H, V7.4H, V8.4H }, [X9], #8
    ADD  X25, X25, X26, LSR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X25]
    LD4R { V0.16B, V1.16B, V2.16B, V3.16B }, [X25], X3
    ADD  X25, X25, X26
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X25]
    LD4R { V0.16B, V1.16B, V2.16B, V3.16B }, [X25], X3
    ADD  X25, X25, X26, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X25]
    LD4R { V5.2D, V6.2D, V7.2D, V8.2D }, [X25], X3
    ADD  X25, X25, X26
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X25]
    LD4R { V5.4S, V6.4S, V7.4S, V8.4S }, [X25], X3
    ADD  X25, X25, X26, LSR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X25]
    LD4R { V0.8H, V1.8H, V2.8H, V3.8H }, [X25], X3
    ADD  X25, X25, X26
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X25]
    LD4R { V9.8B, V10.8B, V11.8B, V12.8B }, [X25], X3
    ADD  X25, X25, X26, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X25]
    LD4R { V5.1D, V6.1D, V7.1D, V8.1D }, [X25], X3
    ADD  X25, X25, X26
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X25]
    LD4R { V18.2S, V19.2S, V20.2S, V21.2S }, [X25], X3
    ADD  X25, X25, X26, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X25]
    LD4R { V5.4H, V6.4H, V7.4H, V8.4H }, [X25], X3
    ADD  X25, X25, X26
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X25]
    LD4R { V18.8B, V19.8B, V20.8B, V21.8B }, [X25], X3
    ADD  X25, X25, X26
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X11, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V0.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D0
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V1.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D1
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V2.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D2
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V3.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D3
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V4.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D4
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V5.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D5
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V6.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D6
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D7
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D8
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V9.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D9
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D10
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D11
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D12
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D13
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D14
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D15
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D16
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V17.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D17
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V18.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D18
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D19
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D20
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D21
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D22
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D23
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D24
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D25
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D26
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V27.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D27
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V28.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D28
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V29.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D29
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V30.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D30
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, V31.D[1]
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X11, D31
    SUB  X12, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP04_TestFail

AdvsimdLoadDeprecatedP04_TestEnd:
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
AdvsimdLoadDeprecatedP04_TestFail:
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
