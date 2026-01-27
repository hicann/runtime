.global AdvsimdLoadDeprecatedP02

.text
.p2align 4

AdvsimdLoadDeprecatedP02:

AdvsimdLoadDeprecatedP02_TestBegin:
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
    MOVZ  X2, #0x5db2, LSL #0
    MOVK  X2, #0x5189, LSL #16
    MOVK  X2, #0x13fa, LSL #32
    MOVK  X2, #0xaf51, LSL #48
    MOVZ  X3, #0x413b, LSL #0
    MOVK  X3, #0xa526, LSL #16
    MOVK  X3, #0xff0, LSL #32
    MOVK  X3, #0x2a4f, LSL #48
    MOVZ  X4, #0x89a4, LSL #0
    MOVK  X4, #0x254f, LSL #16
    MOVK  X4, #0xb10c, LSL #32
    MOVK  X4, #0x43f, LSL #48
    MOVZ  X5, #0xaff6, LSL #0
    MOVK  X5, #0x1935, LSL #16
    MOVK  X5, #0x5b45, LSL #32
    MOVK  X5, #0xe28d, LSL #48
    MOVZ  X7, #0xdafb, LSL #0
    MOVK  X7, #0xb1aa, LSL #16
    MOVK  X7, #0x834b, LSL #32
    MOVK  X7, #0xdc71, LSL #48
    MOVZ  X9, #0x62a0, LSL #0
    MOVK  X9, #0x40d6, LSL #16
    MOVK  X9, #0x215c, LSL #32
    MOVK  X9, #0x46f, LSL #48
    MOVZ  X10, #0xb75e, LSL #0
    MOVK  X10, #0x4d31, LSL #16
    MOVK  X10, #0x37b2, LSL #32
    MOVK  X10, #0x7928, LSL #48
    MOVZ  X11, #0x50b9, LSL #0
    MOVK  X11, #0x5bdb, LSL #16
    MOVK  X11, #0x5c1f, LSL #32
    MOVK  X11, #0x4a2e, LSL #48
    MOVZ  X12, #0xdc5c, LSL #0
    MOVK  X12, #0xb95e, LSL #16
    MOVK  X12, #0x79f9, LSL #32
    MOVK  X12, #0xfcbf, LSL #48
    MOVZ  X13, #0x5919, LSL #0
    MOVK  X13, #0x9f59, LSL #16
    MOVK  X13, #0xe1a4, LSL #32
    MOVK  X13, #0x6e89, LSL #48
    MOVZ  X14, #0x8f98, LSL #0
    MOVK  X14, #0x383f, LSL #16
    MOVK  X14, #0xd668, LSL #32
    MOVK  X14, #0xbbc1, LSL #48
    MOVZ  X15, #0xc2fa, LSL #0
    MOVK  X15, #0x54c9, LSL #16
    MOVK  X15, #0x1a28, LSL #32
    MOVK  X15, #0x602b, LSL #48
    MOVZ  X16, #0x5c41, LSL #0
    MOVK  X16, #0x59e, LSL #16
    MOVK  X16, #0x29cf, LSL #32
    MOVK  X16, #0x5a17, LSL #48
    MOVZ  X17, #0x3c91, LSL #0
    MOVK  X17, #0xf60b, LSL #16
    MOVK  X17, #0xedb6, LSL #32
    MOVK  X17, #0x7536, LSL #48
    MOVZ  X18, #0x20d, LSL #0
    MOVK  X18, #0x314c, LSL #16
    MOVK  X18, #0xb2db, LSL #32
    MOVK  X18, #0x4201, LSL #48
    MOVZ  X19, #0xcb65, LSL #0
    MOVK  X19, #0x6a26, LSL #16
    MOVK  X19, #0x9553, LSL #32
    MOVK  X19, #0x21c6, LSL #48
    MOVZ  X20, #0x8f5c, LSL #0
    MOVK  X20, #0x5120, LSL #16
    MOVK  X20, #0xe9ba, LSL #32
    MOVK  X20, #0xb1d9, LSL #48
    MOVZ  X21, #0xb084, LSL #0
    MOVK  X21, #0x533f, LSL #16
    MOVK  X21, #0x3bf4, LSL #32
    MOVK  X21, #0x6ac1, LSL #48
    MOVZ  X22, #0x509e, LSL #0
    MOVK  X22, #0xf39c, LSL #16
    MOVK  X22, #0xd3d8, LSL #32
    MOVK  X22, #0xc408, LSL #48
    MOVZ  X23, #0xf911, LSL #0
    MOVK  X23, #0xf4a2, LSL #16
    MOVK  X23, #0x622, LSL #32
    MOVK  X23, #0x27a4, LSL #48
    MOVZ  X24, #0xb145, LSL #0
    MOVK  X24, #0x7e47, LSL #16
    MOVK  X24, #0x27c4, LSL #32
    MOVK  X24, #0x5545, LSL #48
    MOVZ  X25, #0x8ca7, LSL #0
    MOVK  X25, #0xe5d, LSL #16
    MOVK  X25, #0x7d19, LSL #32
    MOVK  X25, #0xed0, LSL #48
    MOVZ  X26, #0x2312, LSL #0
    MOVK  X26, #0xa3ac, LSL #16
    MOVK  X26, #0xcfbb, LSL #32
    MOVK  X26, #0xfdb3, LSL #48
    MOVZ  X27, #0x6910, LSL #0
    MOVK  X27, #0x310, LSL #16
    MOVK  X27, #0xfd8b, LSL #32
    MOVK  X27, #0xae17, LSL #48
    MOVZ  X17, #0x37a6, LSL #0
    MOVK  X17, #0xbd93, LSL #16
    MOVK  X17, #0x97ca, LSL #32
    MOVK  X17, #0xe471, LSL #48
    MSR  FPCR, X17
    MOVZ  X17, #0xdc35, LSL #0
    MOVK  X17, #0x35c2, LSL #16
    MOVK  X17, #0xca48, LSL #32
    MOVK  X17, #0x9777, LSL #48
    MSR  FPSR, X17
    MRS  X4, FPSR
    MOVZ  X20, #0xff60, LSL #0
    MOVK  X20, #0x7ff, LSL #16
    MOVK  X20, #0xffff, LSL #32
    MOVK  X20, #0xffff, LSL #48
    AND  X4, X4, X20
    MOVZ  X20, #0x0, LSL #0
    ORR  X4, X4, X20
    MSR  FPSR, X4
    ISB  SY
    ANDS  W26, W23, #0xff00ffff
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
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X23
    FMOV  D2, X24
    FMOV  V2.D[1], X18
    FMOV  D3, X11
    FMOV  V3.D[1], X16
    FMOV  D4, X23
    FMOV  V4.D[1], X10
    FMOV  D5, X13
    FMOV  V5.D[1], X11
    FMOV  D6, X4
    FMOV  V6.D[1], X11
    FMOV  D7, X21
    FMOV  V7.D[1], X21
    FMOV  D8, X26
    FMOV  V8.D[1], X11
    FMOV  D9, X19
    FMOV  V9.D[1], X4
    FMOV  D10, X13
    FMOV  V10.D[1], X9
    FMOV  D11, X4
    FMOV  V11.D[1], X14
    FMOV  D12, X12
    FMOV  V12.D[1], X9
    FMOV  D13, X18
    FMOV  V13.D[1], X3
    FMOV  D14, X2
    FMOV  V14.D[1], X23
    FMOV  D15, X7
    FMOV  V15.D[1], X11
    FMOV  D16, X27
    FMOV  V16.D[1], X19
    FMOV  D17, X22
    FMOV  V17.D[1], X11
    FMOV  D18, X9
    FMOV  V18.D[1], X13
    FMOV  D19, X11
    FMOV  V19.D[1], X18
    FMOV  D20, X13
    FMOV  V20.D[1], X23
    FMOV  D21, X26
    FMOV  V21.D[1], X4
    FMOV  D22, X2
    FMOV  V22.D[1], X15
    FMOV  D23, X19
    FMOV  V23.D[1], X11
    FMOV  D24, X12
    FMOV  V24.D[1], X11
    FMOV  D25, X3
    FMOV  V25.D[1], X22
    FMOV  D26, X5
    FMOV  V26.D[1], X5
    FMOV  D27, X5
    FMOV  V27.D[1], X16
    FMOV  D28, X16
    FMOV  V28.D[1], X25
    FMOV  D29, X20
    FMOV  V29.D[1], X20
    FMOV  D30, X12
    FMOV  V30.D[1], X23
    FMOV  D31, X19
    FMOV  V31.D[1], X21
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X18, #0x40, LSL #0
    MOVZ  X9, #0x0, LSL #0
    ADD  X27, X30, X9, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X27]
    LD2R { V9.4S, V10.4S }, [X27]
    ADD  X27, X27, X18, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X27]
    LD2R { V12.16B, V13.16B }, [X27]
    ADD  X27, X27, X18, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X27]
    LD2R { V14.2D, V15.2D }, [X27]
    ADD  X27, X27, X18, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X27]
    LD2R { V1.4S, V2.4S }, [X27]
    ADD  X27, X27, X18, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X27]
    LD2R { V24.8H, V25.8H }, [X27]
    ADD  X27, X27, X18, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X27]
    LD2R { V28.1D, V29.1D }, [X27]
    ADD  X27, X27, X18, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X27]
    LD2R { V30.1D, V31.1D }, [X27]
    ADD  X27, X27, X18, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X27]
    LD2R { V13.2S, V14.2S }, [X27]
    ADD  X27, X27, X18
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X27]
    LD2R { V29.4H, V30.4H }, [X27]
    ADD  X27, X27, X18, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X27]
    LD2R { V0.8B, V1.8B }, [X27]
    ADD  X27, X27, X18
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X27]
    MOV  X22, X27
    LD2R { V12.1D, V13.1D }, [X22], #16
    ADD  X27, X27, X18
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X27]
    MOV  X22, X27
    LD2R { V10.1D, V11.1D }, [X22], #16
    ADD  X27, X27, X18, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X27]
    MOV  X22, X27
    LD2R { V17.2D, V18.2D }, [X22], #16
    ADD  X27, X27, X18, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X27]
    MOV  X22, X27
    LD2R { V24.16B, V25.16B }, [X22], #2
    ADD  X27, X27, X18, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X27]
    MOV  X22, X27
    LD2R { V2.16B, V3.16B }, [X22], #2
    ADD  X27, X27, X18
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X27]
    MOV  X22, X27
    LD2R { V31.8B, V0.8B }, [X22], #2
    ADD  X27, X27, X18, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X27]
    MOV  X22, X27
    LD2R { V12.4H, V13.4H }, [X22], #4
    ADD  X27, X27, X18, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X27]
    MOV  X22, X27
    LD2R { V17.8H, V18.8H }, [X22], #4
    ADD  X27, X27, X18
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X27]
    MOV  X22, X27
    LD2R { V2.4S, V3.4S }, [X22], #8
    ADD  X27, X27, X18, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X27]
    MOV  X22, X27
    LD2R { V0.2S, V1.2S }, [X22], #8
    ADD  X27, X27, X18, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X27]
    MOV  X22, X27
    LD2R { V3.4S, V4.4S }, [X22], #8
    ADD  X27, X27, X18
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X27]
    MOV  X22, X27
    LD2R { V11.4H, V12.4H }, [X22], #4
    ADD  X27, X27, X18, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X27]
    LD2R { V5.4S, V6.4S }, [X27], X19
    ADD  X27, X27, X18, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X27]
    LD2R { V13.16B, V14.16B }, [X27], X19
    ADD  X27, X27, X18, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X27]
    LD2R { V20.2D, V21.2D }, [X27], X19
    ADD  X27, X27, X18, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X27]
    LD2R { V26.4S, V27.4S }, [X27], X19
    ADD  X27, X27, X18
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X27]
    LD2R { V0.8H, V1.8H }, [X27], X19
    ADD  X27, X27, X18, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X27]
    LD2R { V18.1D, V19.1D }, [X27], X19
    ADD  X27, X27, X18
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X27]
    LD2R { V10.1D, V11.1D }, [X27], X19
    ADD  X27, X27, X18, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X27]
    LD2R { V15.2S, V16.2S }, [X27], X19
    ADD  X27, X27, X18
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X27]
    LD2R { V24.4H, V25.4H }, [X27], X19
    ADD  X27, X27, X18, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X27]
    LD2R { V6.8B, V7.8B }, [X27], X19
    ADD  X27, X27, X18, LSR #0
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X21, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D0
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V3.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D3
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V5.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D5
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D6
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V9.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V10.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D10
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D11
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V13.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D16
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D17
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V18.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V20.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V21.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V22.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V23.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D24
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D25
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V26.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, V27.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X23, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X2
    FMOV  D3, X26
    FMOV  V3.D[1], X4
    FMOV  D4, X18
    FMOV  V4.D[1], X25
    FMOV  D5, X27
    FMOV  V5.D[1], X3
    FMOV  D6, X12
    FMOV  V6.D[1], X4
    FMOV  D7, X4
    FMOV  V7.D[1], X15
    FMOV  D8, X9
    FMOV  V8.D[1], X23
    FMOV  D9, X12
    FMOV  V9.D[1], X21
    FMOV  D10, X11
    FMOV  V10.D[1], X3
    FMOV  D11, X11
    FMOV  V11.D[1], X3
    FMOV  D12, X27
    FMOV  V12.D[1], X23
    FMOV  D13, X9
    FMOV  V13.D[1], X11
    FMOV  D14, X22
    FMOV  V14.D[1], X3
    FMOV  D15, X27
    FMOV  V15.D[1], X15
    FMOV  D16, X3
    FMOV  V16.D[1], X25
    FMOV  D17, X7
    FMOV  V17.D[1], X14
    FMOV  D18, X13
    FMOV  V18.D[1], X14
    FMOV  D19, X20
    FMOV  V19.D[1], X23
    FMOV  D20, X19
    FMOV  V20.D[1], X22
    FMOV  D21, X10
    FMOV  V21.D[1], X26
    FMOV  D22, X27
    FMOV  V22.D[1], X18
    FMOV  D23, X12
    FMOV  V23.D[1], X26
    FMOV  D24, X25
    FMOV  V24.D[1], X19
    FMOV  D25, X15
    FMOV  V25.D[1], X17
    FMOV  D26, X13
    FMOV  V26.D[1], X27
    FMOV  D27, X23
    FMOV  V27.D[1], X11
    FMOV  D28, X26
    FMOV  V28.D[1], X5
    FMOV  D29, X23
    FMOV  V29.D[1], X14
    FMOV  D30, X16
    FMOV  V30.D[1], X18
    FMOV  D31, X27
    FMOV  V31.D[1], X27
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X17, #0x500, LSL #0
    ADD  X5, X30, X17, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X5]
    LD2R { V28.2D, V29.2D }, [X5]
    ADD  X5, X5, X16, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X5]
    LD2R { V16.16B, V17.16B }, [X5]
    ADD  X5, X5, X16
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X5]
    LD2R { V19.2D, V20.2D }, [X5]
    ADD  X5, X5, X16, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X5]
    LD2R { V12.4S, V13.4S }, [X5]
    ADD  X5, X5, X16, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X5]
    LD2R { V0.8H, V1.8H }, [X5]
    ADD  X5, X5, X16, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X5]
    LD2R { V14.4H, V15.4H }, [X5]
    ADD  X5, X5, X16, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X5]
    LD2R { V26.1D, V27.1D }, [X5]
    ADD  X5, X5, X16
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X5]
    LD2R { V23.2S, V24.2S }, [X5]
    ADD  X5, X5, X16, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X5]
    LD2R { V14.4H, V15.4H }, [X5]
    ADD  X5, X5, X16, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X5]
    LD2R { V31.8B, V0.8B }, [X5]
    ADD  X5, X5, X16, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X5]
    MOV  X24, X5
    LD2R { V14.2D, V15.2D }, [X24], #16
    ADD  X5, X5, X16
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X5]
    MOV  X24, X5
    LD2R { V23.1D, V24.1D }, [X24], #16
    ADD  X5, X5, X16
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X5]
    MOV  X24, X5
    LD2R { V12.2D, V13.2D }, [X24], #16
    ADD  X5, X5, X16
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X5]
    MOV  X24, X5
    LD2R { V20.8B, V21.8B }, [X24], #2
    ADD  X5, X5, X16, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X5]
    MOV  X24, X5
    LD2R { V16.16B, V17.16B }, [X24], #2
    ADD  X5, X5, X16, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X5]
    MOV  X24, X5
    LD2R { V17.8B, V18.8B }, [X24], #2
    ADD  X5, X5, X16
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X5]
    MOV  X24, X5
    LD2R { V18.4H, V19.4H }, [X24], #4
    ADD  X5, X5, X16
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X5]
    MOV  X24, X5
    LD2R { V18.8H, V19.8H }, [X24], #4
    ADD  X5, X5, X16
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X5]
    MOV  X24, X5
    LD2R { V13.4S, V14.4S }, [X24], #8
    ADD  X5, X5, X16
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X5]
    MOV  X24, X5
    LD2R { V28.2S, V29.2S }, [X24], #8
    ADD  X5, X5, X16, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X5]
    MOV  X24, X5
    LD2R { V12.4S, V13.4S }, [X24], #8
    ADD  X5, X5, X16, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X5]
    MOV  X24, X5
    LD2R { V14.4H, V15.4H }, [X24], #4
    ADD  X5, X5, X16, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X5]
    LD2R { V2.16B, V3.16B }, [X5], X14
    ADD  X5, X5, X16, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X5]
    LD2R { V26.16B, V27.16B }, [X5], X14
    ADD  X5, X5, X16, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X5]
    LD2R { V25.2D, V26.2D }, [X5], X14
    ADD  X5, X5, X16, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X5]
    LD2R { V16.4S, V17.4S }, [X5], X14
    ADD  X5, X5, X16
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X5]
    LD2R { V12.8H, V13.8H }, [X5], X14
    ADD  X5, X5, X16, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X5]
    LD2R { V24.1D, V25.1D }, [X5], X14
    ADD  X5, X5, X16, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X5]
    LD2R { V14.1D, V15.1D }, [X5], X14
    ADD  X5, X5, X16, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X5]
    LD2R { V7.2S, V8.2S }, [X5], X14
    ADD  X5, X5, X16, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X5]
    LD2R { V29.4H, V30.4H }, [X5], X14
    ADD  X5, X5, X16, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X5]
    LD2R { V14.8B, V15.8B }, [X5], X14
    ADD  X5, X5, X16
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X21, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D0
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D1
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D2
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V3.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D3
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D4
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V5.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D5
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D6
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D7
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D8
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V9.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D9
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D10
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V11.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D11
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V12.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D12
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V13.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D13
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D14
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D15
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V16.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D16
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D17
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D18
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D19
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D20
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D21
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V22.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D22
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D23
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D24
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D25
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V26.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D26
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, V27.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D27
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V28.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D28
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D29
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D30
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X21, D31
    SUB  X20, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X26
    FMOV  D2, X22
    FMOV  V2.D[1], X25
    FMOV  D3, X27
    FMOV  V3.D[1], X27
    FMOV  D4, X10
    FMOV  V4.D[1], X18
    FMOV  D5, X3
    FMOV  V5.D[1], X7
    FMOV  D6, X5
    FMOV  V6.D[1], X5
    FMOV  D7, X7
    FMOV  V7.D[1], X3
    FMOV  D8, X7
    FMOV  V8.D[1], X23
    FMOV  D9, X20
    FMOV  V9.D[1], X17
    FMOV  D10, X12
    FMOV  V10.D[1], X23
    FMOV  D11, X7
    FMOV  V11.D[1], X19
    FMOV  D12, X22
    FMOV  V12.D[1], X11
    FMOV  D13, X5
    FMOV  V13.D[1], X21
    FMOV  D14, X23
    FMOV  V14.D[1], X16
    FMOV  D15, X19
    FMOV  V15.D[1], X12
    FMOV  D16, X4
    FMOV  V16.D[1], X20
    FMOV  D17, X4
    FMOV  V17.D[1], X10
    FMOV  D18, X7
    FMOV  V18.D[1], X4
    FMOV  D19, X7
    FMOV  V19.D[1], X5
    FMOV  D20, X14
    FMOV  V20.D[1], X12
    FMOV  D21, X7
    FMOV  V21.D[1], X21
    FMOV  D22, X27
    FMOV  V22.D[1], X9
    FMOV  D23, X19
    FMOV  V23.D[1], X14
    FMOV  D24, X2
    FMOV  V24.D[1], X13
    FMOV  D25, X22
    FMOV  V25.D[1], X13
    FMOV  D26, X3
    FMOV  V26.D[1], X16
    FMOV  D27, X16
    FMOV  V27.D[1], X19
    FMOV  D28, X18
    FMOV  V28.D[1], X16
    FMOV  D29, X5
    FMOV  V29.D[1], X17
    FMOV  D30, X26
    FMOV  V30.D[1], X3
    FMOV  D31, X24
    FMOV  V31.D[1], X24
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X18, #0x40, LSL #0
    MOVZ  X7, #0xa00, LSL #0
    ADD  X14, X30, X7, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X14]
    LD2R { V8.16B, V9.16B }, [X14]
    ADD  X14, X14, X18, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X14]
    LD2R { V2.16B, V3.16B }, [X14]
    ADD  X14, X14, X18
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X14]
    LD2R { V9.2D, V10.2D }, [X14]
    ADD  X14, X14, X18, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X14]
    LD2R { V28.4S, V29.4S }, [X14]
    ADD  X14, X14, X18, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X14]
    LD2R { V23.8H, V24.8H }, [X14]
    ADD  X14, X14, X18
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X14]
    LD2R { V25.8B, V26.8B }, [X14]
    ADD  X14, X14, X18, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X14]
    LD2R { V5.1D, V6.1D }, [X14]
    ADD  X14, X14, X18
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X14]
    LD2R { V24.2S, V25.2S }, [X14]
    ADD  X14, X14, X18
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X14]
    LD2R { V26.4H, V27.4H }, [X14]
    ADD  X14, X14, X18, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X14]
    LD2R { V0.8B, V1.8B }, [X14]
    ADD  X14, X14, X18, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X14]
    MOV  X13, X14
    LD2R { V10.2D, V11.2D }, [X13], #16
    ADD  X14, X14, X18
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X14]
    MOV  X13, X14
    LD2R { V19.1D, V20.1D }, [X13], #16
    ADD  X14, X14, X18
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X14]
    MOV  X13, X14
    LD2R { V28.2D, V29.2D }, [X13], #16
    ADD  X14, X14, X18, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X14]
    MOV  X13, X14
    LD2R { V24.8B, V25.8B }, [X13], #2
    ADD  X14, X14, X18, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X14]
    MOV  X13, X14
    LD2R { V26.16B, V27.16B }, [X13], #2
    ADD  X14, X14, X18
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X14]
    MOV  X13, X14
    LD2R { V18.8B, V19.8B }, [X13], #2
    ADD  X14, X14, X18
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X14]
    MOV  X13, X14
    LD2R { V25.4H, V26.4H }, [X13], #4
    ADD  X14, X14, X18
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X14]
    MOV  X13, X14
    LD2R { V2.8H, V3.8H }, [X13], #4
    ADD  X14, X14, X18
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X14]
    MOV  X13, X14
    LD2R { V31.2S, V0.2S }, [X13], #8
    ADD  X14, X14, X18, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X14]
    MOV  X13, X14
    LD2R { V16.2S, V17.2S }, [X13], #8
    ADD  X14, X14, X18, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X14]
    MOV  X13, X14
    LD2R { V4.4S, V5.4S }, [X13], #8
    ADD  X14, X14, X18, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X14]
    MOV  X13, X14
    LD2R { V11.8H, V12.8H }, [X13], #4
    ADD  X14, X14, X18, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X14]
    LD2R { V11.8H, V12.8H }, [X14], X21
    ADD  X14, X14, X18, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X14]
    LD2R { V2.16B, V3.16B }, [X14], X21
    ADD  X14, X14, X18, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X14]
    LD2R { V9.2D, V10.2D }, [X14], X21
    ADD  X14, X14, X18, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X14]
    LD2R { V25.4S, V26.4S }, [X14], X21
    ADD  X14, X14, X18
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X14]
    LD2R { V17.8H, V18.8H }, [X14], X21
    ADD  X14, X14, X18, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X14]
    LD2R { V23.4H, V24.4H }, [X14], X21
    ADD  X14, X14, X18
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X14]
    LD2R { V10.1D, V11.1D }, [X14], X21
    ADD  X14, X14, X18, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X14]
    LD2R { V20.2S, V21.2S }, [X14], X21
    ADD  X14, X14, X18, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X14]
    LD2R { V26.4H, V27.4H }, [X14], X21
    ADD  X14, X14, X18, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X14]
    LD2R { V19.8B, V20.8B }, [X14], X21
    ADD  X14, X14, X18, ASR #0
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X11, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V0.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D0
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D1
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V2.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D2
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V3.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D3
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V4.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D4
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V5.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D5
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V6.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D6
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V7.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D7
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V8.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D8
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V9.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D9
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D10
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D11
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V12.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D12
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V13.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D13
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V14.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D14
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V15.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D15
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D16
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V17.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D17
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V18.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D18
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D19
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D20
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D21
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V22.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D22
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D23
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D24
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V25.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D25
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D26
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D27
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V28.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D28
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V29.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D29
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, V30.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D30
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    FMOV  X11, D31
    SUB  X4, X22, X11
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X23
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X2
    FMOV  D3, X12
    FMOV  V3.D[1], X23
    FMOV  D4, X18
    FMOV  V4.D[1], X22
    FMOV  D5, X7
    FMOV  V5.D[1], X7
    FMOV  D6, X10
    FMOV  V6.D[1], X3
    FMOV  D7, X13
    FMOV  V7.D[1], X24
    FMOV  D8, X20
    FMOV  V8.D[1], X2
    FMOV  D9, X22
    FMOV  V9.D[1], X15
    FMOV  D10, X15
    FMOV  V10.D[1], X2
    FMOV  D11, X18
    FMOV  V11.D[1], X4
    FMOV  D12, X7
    FMOV  V12.D[1], X5
    FMOV  D13, X18
    FMOV  V13.D[1], X24
    FMOV  D14, X19
    FMOV  V14.D[1], X26
    FMOV  D15, X2
    FMOV  V15.D[1], X10
    FMOV  D16, X13
    FMOV  V16.D[1], X25
    FMOV  D17, X7
    FMOV  V17.D[1], X12
    FMOV  D18, X11
    FMOV  V18.D[1], X13
    FMOV  D19, X9
    FMOV  V19.D[1], X17
    FMOV  D20, X20
    FMOV  V20.D[1], X25
    FMOV  D21, X3
    FMOV  V21.D[1], X9
    FMOV  D22, X19
    FMOV  V22.D[1], X2
    FMOV  D23, X27
    FMOV  V23.D[1], X21
    FMOV  D24, X7
    FMOV  V24.D[1], X12
    FMOV  D25, X22
    FMOV  V25.D[1], X20
    FMOV  D26, X13
    FMOV  V26.D[1], X22
    FMOV  D27, X2
    FMOV  V27.D[1], X26
    FMOV  D28, X20
    FMOV  V28.D[1], X18
    FMOV  D29, X14
    FMOV  V29.D[1], X11
    FMOV  D30, X22
    FMOV  V30.D[1], X25
    FMOV  D31, X14
    FMOV  V31.D[1], X24
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X24, #0xf00, LSL #0
    ADD  X19, X30, X24
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X19]
    LD2R { V9.2D, V10.2D }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X19]
    LD2R { V23.16B, V24.16B }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X19]
    LD2R { V21.2D, V22.2D }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X19]
    LD2R { V18.4S, V19.4S }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X19]
    LD2R { V19.8H, V20.8H }, [X19]
    ADD  X19, X19, X12, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X19]
    LD2R { V28.4H, V29.4H }, [X19]
    ADD  X19, X19, X12
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X19]
    LD2R { V8.1D, V9.1D }, [X19]
    ADD  X19, X19, X12, ASR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X19]
    LD2R { V18.2S, V19.2S }, [X19]
    ADD  X19, X19, X12, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X19]
    LD2R { V20.4H, V21.4H }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X19]
    LD2R { V13.8B, V14.8B }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X19]
    MOV  X3, X19
    LD2R { V15.2D, V16.2D }, [X3], #16
    ADD  X19, X19, X12, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X19]
    MOV  X3, X19
    LD2R { V13.1D, V14.1D }, [X3], #16
    ADD  X19, X19, X12, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X19]
    MOV  X3, X19
    LD2R { V7.2D, V8.2D }, [X3], #16
    ADD  X19, X19, X12, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X19]
    MOV  X3, X19
    LD2R { V23.16B, V24.16B }, [X3], #2
    ADD  X19, X19, X12, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X19]
    MOV  X3, X19
    LD2R { V24.16B, V25.16B }, [X3], #2
    ADD  X19, X19, X12, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X19]
    MOV  X3, X19
    LD2R { V8.8B, V9.8B }, [X3], #2
    ADD  X19, X19, X12, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X19]
    MOV  X3, X19
    LD2R { V15.4H, V16.4H }, [X3], #4
    ADD  X19, X19, X12, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X19]
    MOV  X3, X19
    LD2R { V26.8H, V27.8H }, [X3], #4
    ADD  X19, X19, X12, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X19]
    MOV  X3, X19
    LD2R { V10.2S, V11.2S }, [X3], #8
    ADD  X19, X19, X12, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X19]
    MOV  X3, X19
    LD2R { V9.2S, V10.2S }, [X3], #8
    ADD  X19, X19, X12
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X19]
    MOV  X3, X19
    LD2R { V23.4S, V24.4S }, [X3], #8
    ADD  X19, X19, X12
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X19]
    MOV  X3, X19
    LD2R { V30.4H, V31.4H }, [X3], #4
    ADD  X19, X19, X12
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X19]
    LD2R { V21.8H, V22.8H }, [X19], X22
    ADD  X19, X19, X12, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X19]
    LD2R { V11.16B, V12.16B }, [X19], X22
    ADD  X19, X19, X12
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X19]
    LD2R { V22.2D, V23.2D }, [X19], X22
    ADD  X19, X19, X12, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X19]
    LD2R { V0.4S, V1.4S }, [X19], X22
    ADD  X19, X19, X12
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X19]
    LD2R { V30.8H, V31.8H }, [X19], X22
    ADD  X19, X19, X12
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X19]
    LD2R { V31.8B, V0.8B }, [X19], X22
    ADD  X19, X19, X12
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X19]
    LD2R { V20.1D, V21.1D }, [X19], X22
    ADD  X19, X19, X12, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X19]
    LD2R { V2.2S, V3.2S }, [X19], X22
    ADD  X19, X19, X12, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X19]
    LD2R { V11.4H, V12.4H }, [X19], X22
    ADD  X19, X19, X12, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X19]
    LD2R { V9.8B, V10.8B }, [X19], X22
    ADD  X19, X19, X12, LSR #0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D0
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D1
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D2
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D3
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D4
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D5
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V6.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D6
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V7.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D7
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D8
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D9
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D10
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D11
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D12
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D13
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D14
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D15
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D16
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V17.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D17
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D18
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D19
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D20
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V21.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D21
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D22
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V23.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D23
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V24.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D24
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V25.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D25
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V26.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D26
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V27.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D27
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D28
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D29
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V30.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D30
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D31
    SUB  X17, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X23
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X26
    FMOV  D3, X4
    FMOV  V3.D[1], X13
    FMOV  D4, X13
    FMOV  V4.D[1], X20
    FMOV  D5, X26
    FMOV  V5.D[1], X15
    FMOV  D6, X11
    FMOV  V6.D[1], X10
    FMOV  D7, X22
    FMOV  V7.D[1], X11
    FMOV  D8, X26
    FMOV  V8.D[1], X26
    FMOV  D9, X17
    FMOV  V9.D[1], X10
    FMOV  D10, X19
    FMOV  V10.D[1], X18
    FMOV  D11, X17
    FMOV  V11.D[1], X10
    FMOV  D12, X9
    FMOV  V12.D[1], X9
    FMOV  D13, X5
    FMOV  V13.D[1], X21
    FMOV  D14, X17
    FMOV  V14.D[1], X7
    FMOV  D15, X21
    FMOV  V15.D[1], X20
    FMOV  D16, X22
    FMOV  V16.D[1], X18
    FMOV  D17, X3
    FMOV  V17.D[1], X14
    FMOV  D18, X2
    FMOV  V18.D[1], X24
    FMOV  D19, X12
    FMOV  V19.D[1], X13
    FMOV  D20, X18
    FMOV  V20.D[1], X16
    FMOV  D21, X22
    FMOV  V21.D[1], X10
    FMOV  D22, X19
    FMOV  V22.D[1], X22
    FMOV  D23, X21
    FMOV  V23.D[1], X5
    FMOV  D24, X9
    FMOV  V24.D[1], X14
    FMOV  D25, X19
    FMOV  V25.D[1], X5
    FMOV  D26, X7
    FMOV  V26.D[1], X2
    FMOV  D27, X20
    FMOV  V27.D[1], X13
    FMOV  D28, X14
    FMOV  V28.D[1], X7
    FMOV  D29, X5
    FMOV  V29.D[1], X18
    FMOV  D30, X5
    FMOV  V30.D[1], X13
    FMOV  D31, X11
    FMOV  V31.D[1], X9
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X25, #0x1400, LSL #0
    ADD  X4, X30, X25
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X4]
    LD2R { V15.16B, V16.16B }, [X4]
    ADD  X4, X4, X23
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X4]
    LD2R { V8.16B, V9.16B }, [X4]
    ADD  X4, X4, X23, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X4]
    LD2R { V18.2D, V19.2D }, [X4]
    ADD  X4, X4, X23, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X4]
    LD2R { V29.4S, V30.4S }, [X4]
    ADD  X4, X4, X23
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X4]
    LD2R { V7.8H, V8.8H }, [X4]
    ADD  X4, X4, X23, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X4]
    LD2R { V22.4H, V23.4H }, [X4]
    ADD  X4, X4, X23
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X4]
    LD2R { V11.1D, V12.1D }, [X4]
    ADD  X4, X4, X23, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X4]
    LD2R { V14.2S, V15.2S }, [X4]
    ADD  X4, X4, X23, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X4]
    LD2R { V8.4H, V9.4H }, [X4]
    ADD  X4, X4, X23
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X4]
    LD2R { V22.8B, V23.8B }, [X4]
    ADD  X4, X4, X23, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X4]
    MOV  X7, X4
    LD2R { V20.2D, V21.2D }, [X7], #16
    ADD  X4, X4, X23
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X4]
    MOV  X7, X4
    LD2R { V3.1D, V4.1D }, [X7], #16
    ADD  X4, X4, X23, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X4]
    MOV  X7, X4
    LD2R { V8.2D, V9.2D }, [X7], #16
    ADD  X4, X4, X23
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X4]
    MOV  X7, X4
    LD2R { V5.8B, V6.8B }, [X7], #2
    ADD  X4, X4, X23, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X4]
    MOV  X7, X4
    LD2R { V8.16B, V9.16B }, [X7], #2
    ADD  X4, X4, X23
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X4]
    MOV  X7, X4
    LD2R { V5.8B, V6.8B }, [X7], #2
    ADD  X4, X4, X23, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X4]
    MOV  X7, X4
    LD2R { V24.4H, V25.4H }, [X7], #4
    ADD  X4, X4, X23
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X4]
    MOV  X7, X4
    LD2R { V6.8H, V7.8H }, [X7], #4
    ADD  X4, X4, X23, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X4]
    MOV  X7, X4
    LD2R { V18.2S, V19.2S }, [X7], #8
    ADD  X4, X4, X23
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X4]
    MOV  X7, X4
    LD2R { V10.2S, V11.2S }, [X7], #8
    ADD  X4, X4, X23, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X4]
    MOV  X7, X4
    LD2R { V31.4S, V0.4S }, [X7], #8
    ADD  X4, X4, X23
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X4]
    MOV  X7, X4
    LD2R { V1.8H, V2.8H }, [X7], #4
    ADD  X4, X4, X23, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X4]
    LD2R { V26.4S, V27.4S }, [X4], X12
    ADD  X4, X4, X23, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X4]
    LD2R { V24.16B, V25.16B }, [X4], X12
    ADD  X4, X4, X23, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X4]
    LD2R { V31.2D, V0.2D }, [X4], X12
    ADD  X4, X4, X23, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X4]
    LD2R { V14.4S, V15.4S }, [X4], X12
    ADD  X4, X4, X23
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X4]
    LD2R { V19.8H, V20.8H }, [X4], X12
    ADD  X4, X4, X23, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X4]
    LD2R { V31.4H, V0.4H }, [X4], X12
    ADD  X4, X4, X23
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X4]
    LD2R { V3.1D, V4.1D }, [X4], X12
    ADD  X4, X4, X23
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X4]
    LD2R { V6.2S, V7.2S }, [X4], X12
    ADD  X4, X4, X23, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X4]
    LD2R { V22.4H, V23.4H }, [X4], X12
    ADD  X4, X4, X23, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X4]
    LD2R { V8.8B, V9.8B }, [X4], X12
    ADD  X4, X4, X23, LSR #0
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X10, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D0
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V1.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D1
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V2.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D2
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D3
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D4
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D5
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D6
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D7
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D8
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D9
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D10
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D11
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D12
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V13.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D13
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V14.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D14
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V15.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D15
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V16.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D16
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V17.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D17
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D18
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V19.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D19
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V20.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D20
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V21.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D21
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D22
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D23
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V24.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D24
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V25.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D25
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V26.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D26
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V27.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D27
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V28.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D28
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V29.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D29
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, V30.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D30
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X10, D31
    SUB  X24, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X4
    FMOV  V2.D[1], X21
    FMOV  D3, X2
    FMOV  V3.D[1], X7
    FMOV  D4, X23
    FMOV  V4.D[1], X22
    FMOV  D5, X7
    FMOV  V5.D[1], X13
    FMOV  D6, X17
    FMOV  V6.D[1], X24
    FMOV  D7, X13
    FMOV  V7.D[1], X12
    FMOV  D8, X19
    FMOV  V8.D[1], X27
    FMOV  D9, X27
    FMOV  V9.D[1], X2
    FMOV  D10, X21
    FMOV  V10.D[1], X26
    FMOV  D11, X2
    FMOV  V11.D[1], X15
    FMOV  D12, X7
    FMOV  V12.D[1], X15
    FMOV  D13, X20
    FMOV  V13.D[1], X13
    FMOV  D14, X15
    FMOV  V14.D[1], X17
    FMOV  D15, X11
    FMOV  V15.D[1], X14
    FMOV  D16, X12
    FMOV  V16.D[1], X3
    FMOV  D17, X12
    FMOV  V17.D[1], X21
    FMOV  D18, X12
    FMOV  V18.D[1], X2
    FMOV  D19, X17
    FMOV  V19.D[1], X26
    FMOV  D20, X10
    FMOV  V20.D[1], X18
    FMOV  D21, X14
    FMOV  V21.D[1], X20
    FMOV  D22, X14
    FMOV  V22.D[1], X16
    FMOV  D23, X9
    FMOV  V23.D[1], X3
    FMOV  D24, X4
    FMOV  V24.D[1], X12
    FMOV  D25, X27
    FMOV  V25.D[1], X2
    FMOV  D26, X11
    FMOV  V26.D[1], X22
    FMOV  D27, X14
    FMOV  V27.D[1], X10
    FMOV  D28, X15
    FMOV  V28.D[1], X7
    FMOV  D29, X17
    FMOV  V29.D[1], X24
    FMOV  D30, X21
    FMOV  V30.D[1], X27
    FMOV  D31, X18
    FMOV  V31.D[1], X4
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X25, #0x1900, LSL #0
    ADD  X2, X30, X25, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X2]
    LD2R { V7.2D, V8.2D }, [X2]
    ADD  X2, X2, X13
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X2]
    LD2R { V22.16B, V23.16B }, [X2]
    ADD  X2, X2, X13, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X2]
    LD2R { V10.2D, V11.2D }, [X2]
    ADD  X2, X2, X13
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X2]
    LD2R { V26.4S, V27.4S }, [X2]
    ADD  X2, X2, X13, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X2]
    LD2R { V26.8H, V27.8H }, [X2]
    ADD  X2, X2, X13, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X2]
    LD2R { V6.4H, V7.4H }, [X2]
    ADD  X2, X2, X13, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X2]
    LD2R { V9.1D, V10.1D }, [X2]
    ADD  X2, X2, X13, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X2]
    LD2R { V7.2S, V8.2S }, [X2]
    ADD  X2, X2, X13
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X2]
    LD2R { V24.4H, V25.4H }, [X2]
    ADD  X2, X2, X13, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X2]
    LD2R { V29.8B, V30.8B }, [X2]
    ADD  X2, X2, X13, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X2]
    MOV  X26, X2
    LD2R { V5.2D, V6.2D }, [X26], #16
    ADD  X2, X2, X13
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X2]
    MOV  X26, X2
    LD2R { V20.1D, V21.1D }, [X26], #16
    ADD  X2, X2, X13
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X2]
    MOV  X26, X2
    LD2R { V22.2D, V23.2D }, [X26], #16
    ADD  X2, X2, X13, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X2]
    MOV  X26, X2
    LD2R { V14.16B, V15.16B }, [X26], #2
    ADD  X2, X2, X13, ASR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X2]
    MOV  X26, X2
    LD2R { V8.16B, V9.16B }, [X26], #2
    ADD  X2, X2, X13
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X2]
    MOV  X26, X2
    LD2R { V28.8B, V29.8B }, [X26], #2
    ADD  X2, X2, X13
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X2]
    MOV  X26, X2
    LD2R { V22.4H, V23.4H }, [X26], #4
    ADD  X2, X2, X13
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X2]
    MOV  X26, X2
    LD2R { V15.8H, V16.8H }, [X26], #4
    ADD  X2, X2, X13
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X2]
    MOV  X26, X2
    LD2R { V17.4S, V18.4S }, [X26], #8
    ADD  X2, X2, X13, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X2]
    MOV  X26, X2
    LD2R { V31.2S, V0.2S }, [X26], #8
    ADD  X2, X2, X13, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X2]
    MOV  X26, X2
    LD2R { V29.4S, V30.4S }, [X26], #8
    ADD  X2, X2, X13, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X2]
    MOV  X26, X2
    LD2R { V16.4H, V17.4H }, [X26], #4
    ADD  X2, X2, X13, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X2]
    LD2R { V19.8H, V20.8H }, [X2], X20
    ADD  X2, X2, X13, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X2]
    LD2R { V20.16B, V21.16B }, [X2], X20
    ADD  X2, X2, X13, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X2]
    LD2R { V29.2D, V30.2D }, [X2], X20
    ADD  X2, X2, X13, ASR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X2]
    LD2R { V20.4S, V21.4S }, [X2], X20
    ADD  X2, X2, X13, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X2]
    LD2R { V31.8H, V0.8H }, [X2], X20
    ADD  X2, X2, X13
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X2]
    LD2R { V15.4H, V16.4H }, [X2], X20
    ADD  X2, X2, X13
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X2]
    LD2R { V9.1D, V10.1D }, [X2], X20
    ADD  X2, X2, X13, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X2]
    LD2R { V21.2S, V22.2S }, [X2], X20
    ADD  X2, X2, X13, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X2]
    LD2R { V19.4H, V20.4H }, [X2], X20
    ADD  X2, X2, X13, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X2]
    LD2R { V7.8B, V8.8B }, [X2], X20
    ADD  X2, X2, X13, LSR #0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    MRS  X22, FPSR
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V0.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D0
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V1.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D1
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V2.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D2
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V3.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D3
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V4.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D4
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V5.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D5
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V6.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D6
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V7.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D7
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D8
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D9
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D10
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V11.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D11
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V12.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D12
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V13.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D13
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V14.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D14
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D15
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V16.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D16
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D17
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V18.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D18
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D19
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D20
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V21.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D21
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D22
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D23
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D24
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D25
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V26.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D26
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V27.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D27
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D28
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V29.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D29
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V30.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D30
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, V31.D[1]
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X22, D31
    SUB  X5, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X24
    FMOV  V2.D[1], X11
    FMOV  D3, X26
    FMOV  V3.D[1], X5
    FMOV  D4, X17
    FMOV  V4.D[1], X15
    FMOV  D5, X21
    FMOV  V5.D[1], X25
    FMOV  D6, X13
    FMOV  V6.D[1], X23
    FMOV  D7, X22
    FMOV  V7.D[1], X15
    FMOV  D8, X21
    FMOV  V8.D[1], X15
    FMOV  D9, X17
    FMOV  V9.D[1], X13
    FMOV  D10, X24
    FMOV  V10.D[1], X5
    FMOV  D11, X2
    FMOV  V11.D[1], X19
    FMOV  D12, X16
    FMOV  V12.D[1], X20
    FMOV  D13, X19
    FMOV  V13.D[1], X11
    FMOV  D14, X12
    FMOV  V14.D[1], X3
    FMOV  D15, X3
    FMOV  V15.D[1], X10
    FMOV  D16, X14
    FMOV  V16.D[1], X21
    FMOV  D17, X9
    FMOV  V17.D[1], X5
    FMOV  D18, X16
    FMOV  V18.D[1], X21
    FMOV  D19, X16
    FMOV  V19.D[1], X3
    FMOV  D20, X14
    FMOV  V20.D[1], X13
    FMOV  D21, X24
    FMOV  V21.D[1], X26
    FMOV  D22, X26
    FMOV  V22.D[1], X10
    FMOV  D23, X17
    FMOV  V23.D[1], X20
    FMOV  D24, X20
    FMOV  V24.D[1], X21
    FMOV  D25, X4
    FMOV  V25.D[1], X2
    FMOV  D26, X22
    FMOV  V26.D[1], X18
    FMOV  D27, X11
    FMOV  V27.D[1], X2
    FMOV  D28, X7
    FMOV  V28.D[1], X14
    FMOV  D29, X19
    FMOV  V29.D[1], X2
    FMOV  D30, X7
    FMOV  V30.D[1], X4
    FMOV  D31, X16
    FMOV  V31.D[1], X23
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X26, #0x1e00, LSL #0
    ADD  X21, X30, X26, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X21]
    LD2R { V24.4S, V25.4S }, [X21]
    ADD  X21, X21, X22, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X21]
    LD2R { V19.16B, V20.16B }, [X21]
    ADD  X21, X21, X22, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X21]
    LD2R { V5.2D, V6.2D }, [X21]
    ADD  X21, X21, X22, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X21]
    LD2R { V18.4S, V19.4S }, [X21]
    ADD  X21, X21, X22
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X21]
    LD2R { V8.8H, V9.8H }, [X21]
    ADD  X21, X21, X22
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X21]
    LD2R { V30.1D, V31.1D }, [X21]
    ADD  X21, X21, X22, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X21]
    LD2R { V26.1D, V27.1D }, [X21]
    ADD  X21, X21, X22, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X21]
    LD2R { V13.2S, V14.2S }, [X21]
    ADD  X21, X21, X22
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X21]
    LD2R { V5.4H, V6.4H }, [X21]
    ADD  X21, X21, X22, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X21]
    LD2R { V31.8B, V0.8B }, [X21]
    ADD  X21, X21, X22
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X21]
    MOV  X14, X21
    LD2R { V20.2D, V21.2D }, [X14], #16
    ADD  X21, X21, X22, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X21]
    MOV  X14, X21
    LD2R { V15.1D, V16.1D }, [X14], #16
    ADD  X21, X21, X22, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X21]
    MOV  X14, X21
    LD2R { V24.2D, V25.2D }, [X14], #16
    ADD  X21, X21, X22, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X21]
    MOV  X14, X21
    LD2R { V0.8B, V1.8B }, [X14], #2
    ADD  X21, X21, X22, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X21]
    MOV  X14, X21
    LD2R { V7.16B, V8.16B }, [X14], #2
    ADD  X21, X21, X22, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X21]
    MOV  X14, X21
    LD2R { V9.8B, V10.8B }, [X14], #2
    ADD  X21, X21, X22
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X21]
    MOV  X14, X21
    LD2R { V21.4H, V22.4H }, [X14], #4
    ADD  X21, X21, X22, LSR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X21]
    MOV  X14, X21
    LD2R { V7.8H, V8.8H }, [X14], #4
    ADD  X21, X21, X22, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X21]
    MOV  X14, X21
    LD2R { V0.4S, V1.4S }, [X14], #8
    ADD  X21, X21, X22
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X21]
    MOV  X14, X21
    LD2R { V9.2S, V10.2S }, [X14], #8
    ADD  X21, X21, X22, LSR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X21]
    MOV  X14, X21
    LD2R { V19.4S, V20.4S }, [X14], #8
    ADD  X21, X21, X22
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X21]
    MOV  X14, X21
    LD2R { V5.4H, V6.4H }, [X14], #4
    ADD  X21, X21, X22
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X21]
    LD2R { V31.16B, V0.16B }, [X21], X19
    ADD  X21, X21, X22, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X21]
    LD2R { V1.16B, V2.16B }, [X21], X19
    ADD  X21, X21, X22, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X21]
    LD2R { V4.2D, V5.2D }, [X21], X19
    ADD  X21, X21, X22, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X21]
    LD2R { V20.4S, V21.4S }, [X21], X19
    ADD  X21, X21, X22, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X21]
    LD2R { V30.8H, V31.8H }, [X21], X19
    ADD  X21, X21, X22, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X21]
    LD2R { V24.8B, V25.8B }, [X21], X19
    ADD  X21, X21, X22, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X21]
    LD2R { V5.1D, V6.1D }, [X21], X19
    ADD  X21, X21, X22, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X21]
    LD2R { V22.2S, V23.2S }, [X21], X19
    ADD  X21, X21, X22, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X21]
    LD2R { V14.4H, V15.4H }, [X21], X19
    ADD  X21, X21, X22
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X21]
    LD2R { V3.8B, V4.8B }, [X21], X19
    ADD  X21, X21, X22, ASR #0
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X10, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V0.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D0
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V1.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D1
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V2.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D2
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D3
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D4
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D5
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D6
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V7.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D7
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V8.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D8
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D9
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D10
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V11.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D11
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V12.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D12
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D13
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D14
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D15
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D16
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V17.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D17
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V18.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D18
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V19.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D19
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V20.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D20
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V21.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D21
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D22
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D23
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D24
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D25
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D26
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D27
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V28.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D28
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V29.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D29
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V30.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D30
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, V31.D[1]
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X10, D31
    SUB  X25, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X24
    FMOV  V2.D[1], X22
    FMOV  D3, X18
    FMOV  V3.D[1], X27
    FMOV  D4, X10
    FMOV  V4.D[1], X4
    FMOV  D5, X14
    FMOV  V5.D[1], X27
    FMOV  D6, X25
    FMOV  V6.D[1], X25
    FMOV  D7, X10
    FMOV  V7.D[1], X13
    FMOV  D8, X9
    FMOV  V8.D[1], X25
    FMOV  D9, X18
    FMOV  V9.D[1], X19
    FMOV  D10, X9
    FMOV  V10.D[1], X24
    FMOV  D11, X14
    FMOV  V11.D[1], X3
    FMOV  D12, X7
    FMOV  V12.D[1], X7
    FMOV  D13, X17
    FMOV  V13.D[1], X7
    FMOV  D14, X2
    FMOV  V14.D[1], X15
    FMOV  D15, X7
    FMOV  V15.D[1], X3
    FMOV  D16, X22
    FMOV  V16.D[1], X23
    FMOV  D17, X22
    FMOV  V17.D[1], X18
    FMOV  D18, X13
    FMOV  V18.D[1], X25
    FMOV  D19, X26
    FMOV  V19.D[1], X19
    FMOV  D20, X12
    FMOV  V20.D[1], X4
    FMOV  D21, X20
    FMOV  V21.D[1], X19
    FMOV  D22, X17
    FMOV  V22.D[1], X15
    FMOV  D23, X2
    FMOV  V23.D[1], X10
    FMOV  D24, X25
    FMOV  V24.D[1], X21
    FMOV  D25, X23
    FMOV  V25.D[1], X27
    FMOV  D26, X22
    FMOV  V26.D[1], X14
    FMOV  D27, X21
    FMOV  V27.D[1], X13
    FMOV  D28, X17
    FMOV  V28.D[1], X19
    FMOV  D29, X22
    FMOV  V29.D[1], X22
    FMOV  D30, X25
    FMOV  V30.D[1], X23
    FMOV  D31, X14
    FMOV  V31.D[1], X23
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X9, #0x40, LSL #0
    MOVZ  X14, #0x2300, LSL #0
    ADD  X22, X30, X14, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X22]
    LD2R { V10.8H, V11.8H }, [X22]
    ADD  X22, X22, X9, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X22]
    LD2R { V26.16B, V27.16B }, [X22]
    ADD  X22, X22, X9, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X22]
    LD2R { V28.2D, V29.2D }, [X22]
    ADD  X22, X22, X9
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X22]
    LD2R { V22.4S, V23.4S }, [X22]
    ADD  X22, X22, X9, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X22]
    LD2R { V8.8H, V9.8H }, [X22]
    ADD  X22, X22, X9, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X22]
    LD2R { V11.1D, V12.1D }, [X22]
    ADD  X22, X22, X9, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X22]
    LD2R { V26.1D, V27.1D }, [X22]
    ADD  X22, X22, X9, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X22]
    LD2R { V6.2S, V7.2S }, [X22]
    ADD  X22, X22, X9, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X22]
    LD2R { V8.4H, V9.4H }, [X22]
    ADD  X22, X22, X9, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X22]
    LD2R { V31.8B, V0.8B }, [X22]
    ADD  X22, X22, X9
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X22]
    MOV  X4, X22
    LD2R { V10.2D, V11.2D }, [X4], #16
    ADD  X22, X22, X9, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X22]
    MOV  X4, X22
    LD2R { V29.1D, V30.1D }, [X4], #16
    ADD  X22, X22, X9, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X22]
    MOV  X4, X22
    LD2R { V15.2D, V16.2D }, [X4], #16
    ADD  X22, X22, X9, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X22]
    MOV  X4, X22
    LD2R { V25.8B, V26.8B }, [X4], #2
    ADD  X22, X22, X9, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X22]
    MOV  X4, X22
    LD2R { V10.16B, V11.16B }, [X4], #2
    ADD  X22, X22, X9, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X22]
    MOV  X4, X22
    LD2R { V3.8B, V4.8B }, [X4], #2
    ADD  X22, X22, X9
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X22]
    MOV  X4, X22
    LD2R { V31.4H, V0.4H }, [X4], #4
    ADD  X22, X22, X9
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X22]
    MOV  X4, X22
    LD2R { V26.8H, V27.8H }, [X4], #4
    ADD  X22, X22, X9, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X22]
    MOV  X4, X22
    LD2R { V18.4S, V19.4S }, [X4], #8
    ADD  X22, X22, X9
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X22]
    MOV  X4, X22
    LD2R { V24.2S, V25.2S }, [X4], #8
    ADD  X22, X22, X9
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X22]
    MOV  X4, X22
    LD2R { V30.4S, V31.4S }, [X4], #8
    ADD  X22, X22, X9, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X22]
    MOV  X4, X22
    LD2R { V9.4H, V10.4H }, [X4], #4
    ADD  X22, X22, X9
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X22]
    LD2R { V7.8H, V8.8H }, [X22], X12
    ADD  X22, X22, X9
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X22]
    LD2R { V21.16B, V22.16B }, [X22], X12
    ADD  X22, X22, X9, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X22]
    LD2R { V27.2D, V28.2D }, [X22], X12
    ADD  X22, X22, X9, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X22]
    LD2R { V15.4S, V16.4S }, [X22], X12
    ADD  X22, X22, X9, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X22]
    LD2R { V13.8H, V14.8H }, [X22], X12
    ADD  X22, X22, X9, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X22]
    LD2R { V17.4H, V18.4H }, [X22], X12
    ADD  X22, X22, X9, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X22]
    LD2R { V16.1D, V17.1D }, [X22], X12
    ADD  X22, X22, X9, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X22]
    LD2R { V2.2S, V3.2S }, [X22], X12
    ADD  X22, X22, X9
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X22]
    LD2R { V13.4H, V14.4H }, [X22], X12
    ADD  X22, X22, X9, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X22]
    LD2R { V11.8B, V12.8B }, [X22], X12
    ADD  X22, X22, X9, ASR #0
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X26, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D0
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V1.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D1
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D2
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D3
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D4
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V5.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D5
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D6
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V7.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D7
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V8.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D8
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D9
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D10
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D11
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D12
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D13
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D14
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V15.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D15
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V16.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D16
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D17
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D18
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V19.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D19
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V20.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D20
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V21.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D21
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V22.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D22
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V23.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D23
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D24
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D25
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V26.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D26
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V27.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D27
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V28.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D28
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D29
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V30.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D30
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, V31.D[1]
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X26, D31
    SUB  X21, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X21
    FMOV  V0.D[1], X22
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X24
    FMOV  V2.D[1], X23
    FMOV  D3, X19
    FMOV  V3.D[1], X5
    FMOV  D4, X9
    FMOV  V4.D[1], X21
    FMOV  D5, X15
    FMOV  V5.D[1], X27
    FMOV  D6, X19
    FMOV  V6.D[1], X24
    FMOV  D7, X15
    FMOV  V7.D[1], X24
    FMOV  D8, X10
    FMOV  V8.D[1], X5
    FMOV  D9, X26
    FMOV  V9.D[1], X24
    FMOV  D10, X10
    FMOV  V10.D[1], X17
    FMOV  D11, X14
    FMOV  V11.D[1], X19
    FMOV  D12, X2
    FMOV  V12.D[1], X20
    FMOV  D13, X2
    FMOV  V13.D[1], X17
    FMOV  D14, X10
    FMOV  V14.D[1], X9
    FMOV  D15, X14
    FMOV  V15.D[1], X19
    FMOV  D16, X20
    FMOV  V16.D[1], X16
    FMOV  D17, X15
    FMOV  V17.D[1], X10
    FMOV  D18, X20
    FMOV  V18.D[1], X22
    FMOV  D19, X16
    FMOV  V19.D[1], X16
    FMOV  D20, X25
    FMOV  V20.D[1], X24
    FMOV  D21, X14
    FMOV  V21.D[1], X11
    FMOV  D22, X26
    FMOV  V22.D[1], X11
    FMOV  D23, X18
    FMOV  V23.D[1], X10
    FMOV  D24, X24
    FMOV  V24.D[1], X9
    FMOV  D25, X17
    FMOV  V25.D[1], X3
    FMOV  D26, X13
    FMOV  V26.D[1], X2
    FMOV  D27, X18
    FMOV  V27.D[1], X27
    FMOV  D28, X3
    FMOV  V28.D[1], X26
    FMOV  D29, X20
    FMOV  V29.D[1], X14
    FMOV  D30, X11
    FMOV  V30.D[1], X27
    FMOV  D31, X24
    FMOV  V31.D[1], X3
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X21, #0x2800, LSL #0
    ADD  X4, X30, X21, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X4]
    LD2R { V6.8H, V7.8H }, [X4]
    ADD  X4, X4, X25
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X4]
    LD2R { V1.16B, V2.16B }, [X4]
    ADD  X4, X4, X25, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X4]
    LD2R { V26.2D, V27.2D }, [X4]
    ADD  X4, X4, X25
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X4]
    LD2R { V23.4S, V24.4S }, [X4]
    ADD  X4, X4, X25, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X4]
    LD2R { V30.8H, V31.8H }, [X4]
    ADD  X4, X4, X25, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X4]
    LD2R { V17.8B, V18.8B }, [X4]
    ADD  X4, X4, X25, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X4]
    LD2R { V4.1D, V5.1D }, [X4]
    ADD  X4, X4, X25, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X4]
    LD2R { V26.2S, V27.2S }, [X4]
    ADD  X4, X4, X25, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X4]
    LD2R { V9.4H, V10.4H }, [X4]
    ADD  X4, X4, X25, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X4]
    LD2R { V2.8B, V3.8B }, [X4]
    ADD  X4, X4, X25
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X4]
    MOV  X13, X4
    LD2R { V11.1D, V12.1D }, [X13], #16
    ADD  X4, X4, X25
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X4]
    MOV  X13, X4
    LD2R { V15.1D, V16.1D }, [X13], #16
    ADD  X4, X4, X25
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X4]
    MOV  X13, X4
    LD2R { V22.2D, V23.2D }, [X13], #16
    ADD  X4, X4, X25
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X4]
    MOV  X13, X4
    LD2R { V20.16B, V21.16B }, [X13], #2
    ADD  X4, X4, X25, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X4]
    MOV  X13, X4
    LD2R { V10.16B, V11.16B }, [X13], #2
    ADD  X4, X4, X25
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X4]
    MOV  X13, X4
    LD2R { V25.8B, V26.8B }, [X13], #2
    ADD  X4, X4, X25
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X4]
    MOV  X13, X4
    LD2R { V1.4H, V2.4H }, [X13], #4
    ADD  X4, X4, X25
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X4]
    MOV  X13, X4
    LD2R { V4.8H, V5.8H }, [X13], #4
    ADD  X4, X4, X25, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X4]
    MOV  X13, X4
    LD2R { V12.4S, V13.4S }, [X13], #8
    ADD  X4, X4, X25, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X4]
    MOV  X13, X4
    LD2R { V8.2S, V9.2S }, [X13], #8
    ADD  X4, X4, X25
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X4]
    MOV  X13, X4
    LD2R { V15.4S, V16.4S }, [X13], #8
    ADD  X4, X4, X25, LSR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X4]
    MOV  X13, X4
    LD2R { V1.8H, V2.8H }, [X13], #4
    ADD  X4, X4, X25, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X4]
    LD2R { V17.4S, V18.4S }, [X4], X18
    ADD  X4, X4, X25, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X4]
    LD2R { V12.16B, V13.16B }, [X4], X18
    ADD  X4, X4, X25
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X4]
    LD2R { V16.2D, V17.2D }, [X4], X18
    ADD  X4, X4, X25, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X4]
    LD2R { V10.4S, V11.4S }, [X4], X18
    ADD  X4, X4, X25
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X4]
    LD2R { V15.8H, V16.8H }, [X4], X18
    ADD  X4, X4, X25
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X4]
    LD2R { V26.4H, V27.4H }, [X4], X18
    ADD  X4, X4, X25, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X4]
    LD2R { V24.1D, V25.1D }, [X4], X18
    ADD  X4, X4, X25, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X4]
    LD2R { V3.2S, V4.2S }, [X4], X18
    ADD  X4, X4, X25, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X4]
    LD2R { V30.4H, V31.4H }, [X4], X18
    ADD  X4, X4, X25, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X4]
    LD2R { V29.8B, V30.8B }, [X4], X18
    ADD  X4, X4, X25
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X22, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X22, FPSR
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V0.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D0
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V1.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D1
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V2.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D2
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V3.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D3
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D4
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V5.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D5
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V6.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D6
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V7.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D7
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V8.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D8
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D9
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V10.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D10
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V11.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D11
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V12.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D12
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V13.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D13
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V14.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D14
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V15.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D15
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V16.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D16
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V17.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D17
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V18.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D18
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V19.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D19
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V20.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D20
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V21.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D21
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V22.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D22
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V23.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D23
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D24
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D25
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D26
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D27
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, V28.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D28
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V29.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D29
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D30
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X22, D31
    SUB  X12, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X23
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X15
    FMOV  D3, X27
    FMOV  V3.D[1], X4
    FMOV  D4, X21
    FMOV  V4.D[1], X21
    FMOV  D5, X23
    FMOV  V5.D[1], X18
    FMOV  D6, X18
    FMOV  V6.D[1], X11
    FMOV  D7, X10
    FMOV  V7.D[1], X2
    FMOV  D8, X17
    FMOV  V8.D[1], X16
    FMOV  D9, X13
    FMOV  V9.D[1], X9
    FMOV  D10, X19
    FMOV  V10.D[1], X23
    FMOV  D11, X13
    FMOV  V11.D[1], X2
    FMOV  D12, X13
    FMOV  V12.D[1], X3
    FMOV  D13, X10
    FMOV  V13.D[1], X22
    FMOV  D14, X22
    FMOV  V14.D[1], X4
    FMOV  D15, X11
    FMOV  V15.D[1], X2
    FMOV  D16, X20
    FMOV  V16.D[1], X5
    FMOV  D17, X16
    FMOV  V17.D[1], X4
    FMOV  D18, X19
    FMOV  V18.D[1], X10
    FMOV  D19, X7
    FMOV  V19.D[1], X13
    FMOV  D20, X5
    FMOV  V20.D[1], X14
    FMOV  D21, X11
    FMOV  V21.D[1], X2
    FMOV  D22, X25
    FMOV  V22.D[1], X7
    FMOV  D23, X10
    FMOV  V23.D[1], X2
    FMOV  D24, X20
    FMOV  V24.D[1], X14
    FMOV  D25, X25
    FMOV  V25.D[1], X16
    FMOV  D26, X13
    FMOV  V26.D[1], X27
    FMOV  D27, X23
    FMOV  V27.D[1], X22
    FMOV  D28, X10
    FMOV  V28.D[1], X16
    FMOV  D29, X9
    FMOV  V29.D[1], X3
    FMOV  D30, X11
    FMOV  V30.D[1], X10
    FMOV  D31, X19
    FMOV  V31.D[1], X17
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X3, #0x2d00, LSL #0
    ADD  X19, X30, X3
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X19]
    LD2R { V15.2D, V16.2D }, [X19]
    ADD  X19, X19, X27, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X19]
    LD2R { V10.16B, V11.16B }, [X19]
    ADD  X19, X19, X27, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X19]
    LD2R { V0.2D, V1.2D }, [X19]
    ADD  X19, X19, X27, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X19]
    LD2R { V31.4S, V0.4S }, [X19]
    ADD  X19, X19, X27, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X19]
    LD2R { V25.8H, V26.8H }, [X19]
    ADD  X19, X19, X27, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X19]
    LD2R { V7.8B, V8.8B }, [X19]
    ADD  X19, X19, X27, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X19]
    LD2R { V13.1D, V14.1D }, [X19]
    ADD  X19, X19, X27
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X19]
    LD2R { V18.2S, V19.2S }, [X19]
    ADD  X19, X19, X27, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X19]
    LD2R { V20.4H, V21.4H }, [X19]
    ADD  X19, X19, X27
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X19]
    LD2R { V19.8B, V20.8B }, [X19]
    ADD  X19, X19, X27, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X19]
    MOV  X11, X19
    LD2R { V30.1D, V31.1D }, [X11], #16
    ADD  X19, X19, X27, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X19]
    MOV  X11, X19
    LD2R { V21.1D, V22.1D }, [X11], #16
    ADD  X19, X19, X27, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X19]
    MOV  X11, X19
    LD2R { V4.2D, V5.2D }, [X11], #16
    ADD  X19, X19, X27, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X19]
    MOV  X11, X19
    LD2R { V22.8B, V23.8B }, [X11], #2
    ADD  X19, X19, X27, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X19]
    MOV  X11, X19
    LD2R { V20.16B, V21.16B }, [X11], #2
    ADD  X19, X19, X27, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X19]
    MOV  X11, X19
    LD2R { V26.8B, V27.8B }, [X11], #2
    ADD  X19, X19, X27
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X19]
    MOV  X11, X19
    LD2R { V2.4H, V3.4H }, [X11], #4
    ADD  X19, X19, X27, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X19]
    MOV  X11, X19
    LD2R { V10.8H, V11.8H }, [X11], #4
    ADD  X19, X19, X27, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X19]
    MOV  X11, X19
    LD2R { V1.2S, V2.2S }, [X11], #8
    ADD  X19, X19, X27, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X19]
    MOV  X11, X19
    LD2R { V22.2S, V23.2S }, [X11], #8
    ADD  X19, X19, X27
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X19]
    MOV  X11, X19
    LD2R { V13.4S, V14.4S }, [X11], #8
    ADD  X19, X19, X27
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X19]
    MOV  X11, X19
    LD2R { V1.4H, V2.4H }, [X11], #4
    ADD  X19, X19, X27, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X19]
    LD2R { V17.2D, V18.2D }, [X19], X13
    ADD  X19, X19, X27
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X19]
    LD2R { V26.16B, V27.16B }, [X19], X13
    ADD  X19, X19, X27
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X19]
    LD2R { V15.2D, V16.2D }, [X19], X13
    ADD  X19, X19, X27
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X19]
    LD2R { V22.4S, V23.4S }, [X19], X13
    ADD  X19, X19, X27, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X19]
    LD2R { V3.8H, V4.8H }, [X19], X13
    ADD  X19, X19, X27, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X19]
    LD2R { V9.1D, V10.1D }, [X19], X13
    ADD  X19, X19, X27, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X19]
    LD2R { V7.1D, V8.1D }, [X19], X13
    ADD  X19, X19, X27, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X19]
    LD2R { V3.2S, V4.2S }, [X19], X13
    ADD  X19, X19, X27
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X19]
    LD2R { V3.4H, V4.4H }, [X19], X13
    ADD  X19, X19, X27, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X19]
    LD2R { V5.8B, V6.8B }, [X19], X13
    ADD  X19, X19, X27, LSR #0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X20, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X20, FPSR
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V0.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D0
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V1.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D1
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V2.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D2
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V3.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D3
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D4
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V5.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D5
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V6.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D6
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V7.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D7
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V8.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D8
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V9.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D9
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V10.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D10
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V11.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D11
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V12.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D12
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V13.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D13
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V14.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D14
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V15.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D15
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V16.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D16
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V17.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D17
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V18.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D18
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V19.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D19
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V20.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D20
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V21.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D21
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V22.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D22
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V23.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D23
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V24.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D24
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V25.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D25
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V26.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D26
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V27.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D27
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V28.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D28
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, V29.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D29
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D30
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X20, V31.D[1]
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X20, D31
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X20
    FMOV  V0.D[1], X23
    FMOV  D1, X24
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X25
    FMOV  D3, X22
    FMOV  V3.D[1], X11
    FMOV  D4, X12
    FMOV  V4.D[1], X5
    FMOV  D5, X3
    FMOV  V5.D[1], X22
    FMOV  D6, X18
    FMOV  V6.D[1], X27
    FMOV  D7, X20
    FMOV  V7.D[1], X11
    FMOV  D8, X26
    FMOV  V8.D[1], X22
    FMOV  D9, X11
    FMOV  V9.D[1], X3
    FMOV  D10, X9
    FMOV  V10.D[1], X25
    FMOV  D11, X24
    FMOV  V11.D[1], X21
    FMOV  D12, X26
    FMOV  V12.D[1], X21
    FMOV  D13, X13
    FMOV  V13.D[1], X21
    FMOV  D14, X15
    FMOV  V14.D[1], X10
    FMOV  D15, X13
    FMOV  V15.D[1], X16
    FMOV  D16, X16
    FMOV  V16.D[1], X4
    FMOV  D17, X23
    FMOV  V17.D[1], X13
    FMOV  D18, X10
    FMOV  V18.D[1], X12
    FMOV  D19, X2
    FMOV  V19.D[1], X14
    FMOV  D20, X17
    FMOV  V20.D[1], X2
    FMOV  D21, X20
    FMOV  V21.D[1], X10
    FMOV  D22, X3
    FMOV  V22.D[1], X26
    FMOV  D23, X27
    FMOV  V23.D[1], X4
    FMOV  D24, X10
    FMOV  V24.D[1], X9
    FMOV  D25, X23
    FMOV  V25.D[1], X4
    FMOV  D26, X16
    FMOV  V26.D[1], X12
    FMOV  D27, X17
    FMOV  V27.D[1], X23
    FMOV  D28, X16
    FMOV  V28.D[1], X14
    FMOV  D29, X24
    FMOV  V29.D[1], X16
    FMOV  D30, X20
    FMOV  V30.D[1], X13
    FMOV  D31, X2
    FMOV  V31.D[1], X27
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X20, #0x0, LSL #0
    ADD  X23, X30, X20, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X23]
    LD2R { V28.2D, V29.2D }, [X23]
    ADD  X23, X23, X2, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X23]
    LD2R { V10.16B, V11.16B }, [X23]
    ADD  X23, X23, X2, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X23]
    LD2R { V23.2D, V24.2D }, [X23]
    ADD  X23, X23, X2
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X23]
    LD2R { V6.4S, V7.4S }, [X23]
    ADD  X23, X23, X2, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X23]
    LD2R { V25.8H, V26.8H }, [X23]
    ADD  X23, X23, X2, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X23]
    LD2R { V0.1D, V1.1D }, [X23]
    ADD  X23, X23, X2, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X23]
    LD2R { V29.1D, V30.1D }, [X23]
    ADD  X23, X23, X2, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X23]
    LD2R { V10.2S, V11.2S }, [X23]
    ADD  X23, X23, X2, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X23]
    LD2R { V27.4H, V28.4H }, [X23]
    ADD  X23, X23, X2
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X23]
    LD2R { V3.8B, V4.8B }, [X23]
    ADD  X23, X23, X2, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X23]
    MOV  X9, X23
    LD2R { V13.2D, V14.2D }, [X9], #16
    ADD  X23, X23, X2
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X23]
    MOV  X9, X23
    LD2R { V25.1D, V26.1D }, [X9], #16
    ADD  X23, X23, X2, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X23]
    MOV  X9, X23
    LD2R { V25.2D, V26.2D }, [X9], #16
    ADD  X23, X23, X2, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X23]
    MOV  X9, X23
    LD2R { V23.16B, V24.16B }, [X9], #2
    ADD  X23, X23, X2, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X23]
    MOV  X9, X23
    LD2R { V10.16B, V11.16B }, [X9], #2
    ADD  X23, X23, X2, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X23]
    MOV  X9, X23
    LD2R { V25.8B, V26.8B }, [X9], #2
    ADD  X23, X23, X2
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X23]
    MOV  X9, X23
    LD2R { V23.4H, V24.4H }, [X9], #4
    ADD  X23, X23, X2, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X23]
    MOV  X9, X23
    LD2R { V19.8H, V20.8H }, [X9], #4
    ADD  X23, X23, X2, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X23]
    MOV  X9, X23
    LD2R { V29.4S, V30.4S }, [X9], #8
    ADD  X23, X23, X2
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X23]
    MOV  X9, X23
    LD2R { V27.2S, V28.2S }, [X9], #8
    ADD  X23, X23, X2, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X23]
    MOV  X9, X23
    LD2R { V27.4S, V28.4S }, [X9], #8
    ADD  X23, X23, X2, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X23]
    MOV  X9, X23
    LD2R { V31.8H, V0.8H }, [X9], #4
    ADD  X23, X23, X2
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X23]
    LD2R { V16.16B, V17.16B }, [X23], X14
    ADD  X23, X23, X2
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X23]
    LD2R { V24.16B, V25.16B }, [X23], X14
    ADD  X23, X23, X2
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X23]
    LD2R { V6.2D, V7.2D }, [X23], X14
    ADD  X23, X23, X2, ASR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X23]
    LD2R { V4.4S, V5.4S }, [X23], X14
    ADD  X23, X23, X2, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X23]
    LD2R { V25.8H, V26.8H }, [X23], X14
    ADD  X23, X23, X2, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X23]
    LD2R { V19.8B, V20.8B }, [X23], X14
    ADD  X23, X23, X2
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X23]
    LD2R { V27.1D, V28.1D }, [X23], X14
    ADD  X23, X23, X2
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X23]
    LD2R { V27.2S, V28.2S }, [X23], X14
    ADD  X23, X23, X2, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X23]
    LD2R { V20.4H, V21.4H }, [X23], X14
    ADD  X23, X23, X2
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X23]
    LD2R { V10.8B, V11.8B }, [X23], X14
    ADD  X23, X23, X2
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X26, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V0.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D0
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D1
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V2.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D2
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D3
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V4.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D4
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V5.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D5
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V6.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D6
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V7.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D7
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V8.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D8
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V9.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D9
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D10
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D11
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V12.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D12
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V13.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D13
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V14.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D14
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V15.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D15
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V16.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D16
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V17.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D17
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V18.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D18
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D19
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D20
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D21
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V22.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D22
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D23
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V24.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D24
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V25.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D25
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V26.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D26
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D27
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X26, V28.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D28
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V29.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D29
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V30.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D30
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, V31.D[1]
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X26, D31
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X24
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X16
    FMOV  D3, X17
    FMOV  V3.D[1], X16
    FMOV  D4, X2
    FMOV  V4.D[1], X22
    FMOV  D5, X2
    FMOV  V5.D[1], X23
    FMOV  D6, X24
    FMOV  V6.D[1], X11
    FMOV  D7, X21
    FMOV  V7.D[1], X23
    FMOV  D8, X9
    FMOV  V8.D[1], X10
    FMOV  D9, X14
    FMOV  V9.D[1], X23
    FMOV  D10, X2
    FMOV  V10.D[1], X25
    FMOV  D11, X20
    FMOV  V11.D[1], X9
    FMOV  D12, X12
    FMOV  V12.D[1], X23
    FMOV  D13, X4
    FMOV  V13.D[1], X9
    FMOV  D14, X12
    FMOV  V14.D[1], X9
    FMOV  D15, X19
    FMOV  V15.D[1], X16
    FMOV  D16, X22
    FMOV  V16.D[1], X14
    FMOV  D17, X11
    FMOV  V17.D[1], X27
    FMOV  D18, X13
    FMOV  V18.D[1], X12
    FMOV  D19, X3
    FMOV  V19.D[1], X18
    FMOV  D20, X12
    FMOV  V20.D[1], X7
    FMOV  D21, X13
    FMOV  V21.D[1], X18
    FMOV  D22, X18
    FMOV  V22.D[1], X4
    FMOV  D23, X14
    FMOV  V23.D[1], X26
    FMOV  D24, X12
    FMOV  V24.D[1], X15
    FMOV  D25, X18
    FMOV  V25.D[1], X24
    FMOV  D26, X9
    FMOV  V26.D[1], X15
    FMOV  D27, X18
    FMOV  V27.D[1], X2
    FMOV  D28, X24
    FMOV  V28.D[1], X15
    FMOV  D29, X4
    FMOV  V29.D[1], X14
    FMOV  D30, X18
    FMOV  V30.D[1], X23
    FMOV  D31, X4
    FMOV  V31.D[1], X3
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X11, #0x500, LSL #0
    ADD  X16, X30, X11
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X16]
    LD2R { V3.4S, V4.4S }, [X16]
    ADD  X16, X16, X12, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X16]
    LD2R { V0.16B, V1.16B }, [X16]
    ADD  X16, X16, X12, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X16]
    LD2R { V1.2D, V2.2D }, [X16]
    ADD  X16, X16, X12
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X16]
    LD2R { V1.4S, V2.4S }, [X16]
    ADD  X16, X16, X12, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X16]
    LD2R { V17.8H, V18.8H }, [X16]
    ADD  X16, X16, X12, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X16]
    LD2R { V19.2S, V20.2S }, [X16]
    ADD  X16, X16, X12, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X16]
    LD2R { V3.1D, V4.1D }, [X16]
    ADD  X16, X16, X12, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X16]
    LD2R { V22.2S, V23.2S }, [X16]
    ADD  X16, X16, X12, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X16]
    LD2R { V8.4H, V9.4H }, [X16]
    ADD  X16, X16, X12
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X16]
    LD2R { V11.8B, V12.8B }, [X16]
    ADD  X16, X16, X12
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X16]
    MOV  X13, X16
    LD2R { V0.1D, V1.1D }, [X13], #16
    ADD  X16, X16, X12, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X16]
    MOV  X13, X16
    LD2R { V31.1D, V0.1D }, [X13], #16
    ADD  X16, X16, X12
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X16]
    MOV  X13, X16
    LD2R { V11.2D, V12.2D }, [X13], #16
    ADD  X16, X16, X12, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X16]
    MOV  X13, X16
    LD2R { V28.16B, V29.16B }, [X13], #2
    ADD  X16, X16, X12
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X16]
    MOV  X13, X16
    LD2R { V13.16B, V14.16B }, [X13], #2
    ADD  X16, X16, X12, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X16]
    MOV  X13, X16
    LD2R { V22.8B, V23.8B }, [X13], #2
    ADD  X16, X16, X12
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X16]
    MOV  X13, X16
    LD2R { V30.4H, V31.4H }, [X13], #4
    ADD  X16, X16, X12
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X16]
    MOV  X13, X16
    LD2R { V10.8H, V11.8H }, [X13], #4
    ADD  X16, X16, X12, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X16]
    MOV  X13, X16
    LD2R { V12.2S, V13.2S }, [X13], #8
    ADD  X16, X16, X12
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X16]
    MOV  X13, X16
    LD2R { V11.2S, V12.2S }, [X13], #8
    ADD  X16, X16, X12
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X16]
    MOV  X13, X16
    LD2R { V20.4S, V21.4S }, [X13], #8
    ADD  X16, X16, X12, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X16]
    MOV  X13, X16
    LD2R { V3.4H, V4.4H }, [X13], #4
    ADD  X16, X16, X12, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X16]
    LD2R { V4.16B, V5.16B }, [X16], X7
    ADD  X16, X16, X12
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X16]
    LD2R { V29.16B, V30.16B }, [X16], X7
    ADD  X16, X16, X12, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X16]
    LD2R { V9.2D, V10.2D }, [X16], X7
    ADD  X16, X16, X12
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X16]
    LD2R { V5.4S, V6.4S }, [X16], X7
    ADD  X16, X16, X12, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X16]
    LD2R { V5.8H, V6.8H }, [X16], X7
    ADD  X16, X16, X12
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X16]
    LD2R { V3.2S, V4.2S }, [X16], X7
    ADD  X16, X16, X12, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X16]
    LD2R { V18.1D, V19.1D }, [X16], X7
    ADD  X16, X16, X12, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X16]
    LD2R { V7.2S, V8.2S }, [X16], X7
    ADD  X16, X16, X12
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X16]
    LD2R { V6.4H, V7.4H }, [X16], X7
    ADD  X16, X16, X12, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X16]
    LD2R { V15.8B, V16.8B }, [X16], X7
    ADD  X16, X16, X12
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X15, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X15, FPSR
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V0.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D0
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V1.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D1
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V2.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D2
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D3
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D4
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V5.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D5
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D6
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D7
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D8
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V9.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D9
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V10.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D10
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D11
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D12
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D13
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V14.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D14
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D15
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V16.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D16
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V17.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D17
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D18
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D19
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V20.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D20
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V21.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D21
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D22
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D23
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V24.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D24
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V25.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D25
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V26.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D26
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V27.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D27
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V28.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D28
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V29.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D29
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, V30.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D30
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X15, V31.D[1]
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X15, D31
    SUB  X3, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X21
    FMOV  V1.D[1], X23
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X24
    FMOV  V3.D[1], X21
    FMOV  D4, X11
    FMOV  V4.D[1], X24
    FMOV  D5, X16
    FMOV  V5.D[1], X11
    FMOV  D6, X2
    FMOV  V6.D[1], X19
    FMOV  D7, X26
    FMOV  V7.D[1], X12
    FMOV  D8, X26
    FMOV  V8.D[1], X22
    FMOV  D9, X17
    FMOV  V9.D[1], X9
    FMOV  D10, X12
    FMOV  V10.D[1], X4
    FMOV  D11, X12
    FMOV  V11.D[1], X3
    FMOV  D12, X4
    FMOV  V12.D[1], X22
    FMOV  D13, X17
    FMOV  V13.D[1], X26
    FMOV  D14, X12
    FMOV  V14.D[1], X4
    FMOV  D15, X18
    FMOV  V15.D[1], X3
    FMOV  D16, X7
    FMOV  V16.D[1], X7
    FMOV  D17, X21
    FMOV  V17.D[1], X20
    FMOV  D18, X9
    FMOV  V18.D[1], X15
    FMOV  D19, X19
    FMOV  V19.D[1], X18
    FMOV  D20, X7
    FMOV  V20.D[1], X9
    FMOV  D21, X12
    FMOV  V21.D[1], X2
    FMOV  D22, X11
    FMOV  V22.D[1], X18
    FMOV  D23, X17
    FMOV  V23.D[1], X7
    FMOV  D24, X15
    FMOV  V24.D[1], X25
    FMOV  D25, X26
    FMOV  V25.D[1], X9
    FMOV  D26, X9
    FMOV  V26.D[1], X25
    FMOV  D27, X23
    FMOV  V27.D[1], X19
    FMOV  D28, X25
    FMOV  V28.D[1], X3
    FMOV  D29, X3
    FMOV  V29.D[1], X3
    FMOV  D30, X18
    FMOV  V30.D[1], X23
    FMOV  D31, X3
    FMOV  V31.D[1], X17
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X10, #0xa00, LSL #0
    ADD  X20, X30, X10, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X20]
    LD2R { V17.16B, V18.16B }, [X20]
    ADD  X20, X20, X21
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X20]
    LD2R { V26.16B, V27.16B }, [X20]
    ADD  X20, X20, X21
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X20]
    LD2R { V12.2D, V13.2D }, [X20]
    ADD  X20, X20, X21, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X20]
    LD2R { V18.4S, V19.4S }, [X20]
    ADD  X20, X20, X21, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X20]
    LD2R { V31.8H, V0.8H }, [X20]
    ADD  X20, X20, X21, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X20]
    LD2R { V20.8B, V21.8B }, [X20]
    ADD  X20, X20, X21
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X20]
    LD2R { V17.1D, V18.1D }, [X20]
    ADD  X20, X20, X21, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X20]
    LD2R { V24.2S, V25.2S }, [X20]
    ADD  X20, X20, X21, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X20]
    LD2R { V22.4H, V23.4H }, [X20]
    ADD  X20, X20, X21
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X20]
    LD2R { V17.8B, V18.8B }, [X20]
    ADD  X20, X20, X21, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X20]
    MOV  X23, X20
    LD2R { V23.1D, V24.1D }, [X23], #16
    ADD  X20, X20, X21, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X20]
    MOV  X23, X20
    LD2R { V7.1D, V8.1D }, [X23], #16
    ADD  X20, X20, X21
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X20]
    MOV  X23, X20
    LD2R { V19.2D, V20.2D }, [X23], #16
    ADD  X20, X20, X21
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X20]
    MOV  X23, X20
    LD2R { V4.16B, V5.16B }, [X23], #2
    ADD  X20, X20, X21, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X20]
    MOV  X23, X20
    LD2R { V17.16B, V18.16B }, [X23], #2
    ADD  X20, X20, X21
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X20]
    MOV  X23, X20
    LD2R { V5.8B, V6.8B }, [X23], #2
    ADD  X20, X20, X21
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X20]
    MOV  X23, X20
    LD2R { V14.4H, V15.4H }, [X23], #4
    ADD  X20, X20, X21, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X20]
    MOV  X23, X20
    LD2R { V21.8H, V22.8H }, [X23], #4
    ADD  X20, X20, X21
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X20]
    MOV  X23, X20
    LD2R { V19.4S, V20.4S }, [X23], #8
    ADD  X20, X20, X21
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X20]
    MOV  X23, X20
    LD2R { V14.2S, V15.2S }, [X23], #8
    ADD  X20, X20, X21, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X20]
    MOV  X23, X20
    LD2R { V23.4S, V24.4S }, [X23], #8
    ADD  X20, X20, X21
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X20]
    MOV  X23, X20
    LD2R { V24.8H, V25.8H }, [X23], #4
    ADD  X20, X20, X21, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X20]
    LD2R { V20.4S, V21.4S }, [X20], X24
    ADD  X20, X20, X21, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X20]
    LD2R { V10.16B, V11.16B }, [X20], X24
    ADD  X20, X20, X21, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X20]
    LD2R { V17.2D, V18.2D }, [X20], X24
    ADD  X20, X20, X21
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X20]
    LD2R { V28.4S, V29.4S }, [X20], X24
    ADD  X20, X20, X21, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X20]
    LD2R { V24.8H, V25.8H }, [X20], X24
    ADD  X20, X20, X21
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X20]
    LD2R { V8.1D, V9.1D }, [X20], X24
    ADD  X20, X20, X21
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X20]
    LD2R { V7.1D, V8.1D }, [X20], X24
    ADD  X20, X20, X21, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X20]
    LD2R { V21.2S, V22.2S }, [X20], X24
    ADD  X20, X20, X21
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X20]
    LD2R { V24.4H, V25.4H }, [X20], X24
    ADD  X20, X20, X21
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X20]
    LD2R { V16.8B, V17.8B }, [X20], X24
    ADD  X20, X20, X21, ASR #0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X7, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V0.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D0
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V1.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D1
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V2.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D2
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V3.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D3
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V4.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D4
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D5
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D6
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D7
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D8
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D9
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D10
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D11
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V12.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D12
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V13.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D13
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D14
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D15
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D16
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D17
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V18.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D18
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V19.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D19
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V20.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D20
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D21
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D22
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V23.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D23
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D24
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D25
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V26.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D26
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V27.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D27
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V28.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D28
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V29.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D29
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V30.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D30
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, V31.D[1]
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X7, D31
    SUB  X3, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X21
    FMOV  D2, X24
    FMOV  V2.D[1], X25
    FMOV  D3, X26
    FMOV  V3.D[1], X5
    FMOV  D4, X17
    FMOV  V4.D[1], X5
    FMOV  D5, X19
    FMOV  V5.D[1], X11
    FMOV  D6, X18
    FMOV  V6.D[1], X17
    FMOV  D7, X15
    FMOV  V7.D[1], X25
    FMOV  D8, X20
    FMOV  V8.D[1], X21
    FMOV  D9, X2
    FMOV  V9.D[1], X26
    FMOV  D10, X27
    FMOV  V10.D[1], X22
    FMOV  D11, X7
    FMOV  V11.D[1], X27
    FMOV  D12, X5
    FMOV  V12.D[1], X14
    FMOV  D13, X15
    FMOV  V13.D[1], X12
    FMOV  D14, X22
    FMOV  V14.D[1], X22
    FMOV  D15, X14
    FMOV  V15.D[1], X10
    FMOV  D16, X4
    FMOV  V16.D[1], X11
    FMOV  D17, X13
    FMOV  V17.D[1], X16
    FMOV  D18, X4
    FMOV  V18.D[1], X10
    FMOV  D19, X25
    FMOV  V19.D[1], X12
    FMOV  D20, X27
    FMOV  V20.D[1], X27
    FMOV  D21, X22
    FMOV  V21.D[1], X18
    FMOV  D22, X25
    FMOV  V22.D[1], X26
    FMOV  D23, X17
    FMOV  V23.D[1], X16
    FMOV  D24, X24
    FMOV  V24.D[1], X22
    FMOV  D25, X10
    FMOV  V25.D[1], X4
    FMOV  D26, X7
    FMOV  V26.D[1], X12
    FMOV  D27, X16
    FMOV  V27.D[1], X3
    FMOV  D28, X11
    FMOV  V28.D[1], X21
    FMOV  D29, X22
    FMOV  V29.D[1], X22
    FMOV  D30, X11
    FMOV  V30.D[1], X23
    FMOV  D31, X11
    FMOV  V31.D[1], X25
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X11, #0xf00, LSL #0
    ADD  X15, X30, X11, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X15]
    LD2R { V4.16B, V5.16B }, [X15]
    ADD  X15, X15, X14, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X15]
    LD2R { V24.16B, V25.16B }, [X15]
    ADD  X15, X15, X14, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X15]
    LD2R { V30.2D, V31.2D }, [X15]
    ADD  X15, X15, X14, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X15]
    LD2R { V14.4S, V15.4S }, [X15]
    ADD  X15, X15, X14, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X15]
    LD2R { V7.8H, V8.8H }, [X15]
    ADD  X15, X15, X14, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X15]
    LD2R { V31.4H, V0.4H }, [X15]
    ADD  X15, X15, X14
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X15]
    LD2R { V2.1D, V3.1D }, [X15]
    ADD  X15, X15, X14, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X15]
    LD2R { V28.2S, V29.2S }, [X15]
    ADD  X15, X15, X14, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X15]
    LD2R { V22.4H, V23.4H }, [X15]
    ADD  X15, X15, X14, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X15]
    LD2R { V1.8B, V2.8B }, [X15]
    ADD  X15, X15, X14
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X15]
    MOV  X7, X15
    LD2R { V18.1D, V19.1D }, [X7], #16
    ADD  X15, X15, X14
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X15]
    MOV  X7, X15
    LD2R { V25.1D, V26.1D }, [X7], #16
    ADD  X15, X15, X14
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X15]
    MOV  X7, X15
    LD2R { V18.2D, V19.2D }, [X7], #16
    ADD  X15, X15, X14, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X15]
    MOV  X7, X15
    LD2R { V28.16B, V29.16B }, [X7], #2
    ADD  X15, X15, X14
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X15]
    MOV  X7, X15
    LD2R { V30.16B, V31.16B }, [X7], #2
    ADD  X15, X15, X14
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X15]
    MOV  X7, X15
    LD2R { V19.8B, V20.8B }, [X7], #2
    ADD  X15, X15, X14, LSR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X15]
    MOV  X7, X15
    LD2R { V1.4H, V2.4H }, [X7], #4
    ADD  X15, X15, X14, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X15]
    MOV  X7, X15
    LD2R { V15.8H, V16.8H }, [X7], #4
    ADD  X15, X15, X14, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X15]
    MOV  X7, X15
    LD2R { V12.4S, V13.4S }, [X7], #8
    ADD  X15, X15, X14, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X15]
    MOV  X7, X15
    LD2R { V22.2S, V23.2S }, [X7], #8
    ADD  X15, X15, X14
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X15]
    MOV  X7, X15
    LD2R { V24.4S, V25.4S }, [X7], #8
    ADD  X15, X15, X14
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X15]
    MOV  X7, X15
    LD2R { V16.8H, V17.8H }, [X7], #4
    ADD  X15, X15, X14, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X15]
    LD2R { V4.4S, V5.4S }, [X15], X19
    ADD  X15, X15, X14, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X15]
    LD2R { V1.16B, V2.16B }, [X15], X19
    ADD  X15, X15, X14, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X15]
    LD2R { V19.2D, V20.2D }, [X15], X19
    ADD  X15, X15, X14
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X15]
    LD2R { V1.4S, V2.4S }, [X15], X19
    ADD  X15, X15, X14
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X15]
    LD2R { V21.8H, V22.8H }, [X15], X19
    ADD  X15, X15, X14
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X15]
    LD2R { V22.1D, V23.1D }, [X15], X19
    ADD  X15, X15, X14, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X15]
    LD2R { V3.1D, V4.1D }, [X15], X19
    ADD  X15, X15, X14
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X15]
    LD2R { V30.2S, V31.2S }, [X15], X19
    ADD  X15, X15, X14, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X15]
    LD2R { V9.4H, V10.4H }, [X15], X19
    ADD  X15, X15, X14, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X15]
    LD2R { V18.8B, V19.8B }, [X15], X19
    ADD  X15, X15, X14, ASR #0
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X18, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D0
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V1.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D1
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D2
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D3
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D4
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V5.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D5
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D6
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D7
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V8.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D8
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D9
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D10
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D11
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D12
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V13.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D13
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V14.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D14
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V15.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D15
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V16.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D16
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V17.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D17
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D18
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D19
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V20.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D20
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V21.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D21
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D22
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D23
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V24.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D24
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V25.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D25
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D26
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V27.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D27
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D28
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, V29.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D29
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D30
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X18, D31
    SUB  X5, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X16
    FMOV  D3, X25
    FMOV  V3.D[1], X25
    FMOV  D4, X15
    FMOV  V4.D[1], X5
    FMOV  D5, X16
    FMOV  V5.D[1], X9
    FMOV  D6, X11
    FMOV  V6.D[1], X25
    FMOV  D7, X5
    FMOV  V7.D[1], X26
    FMOV  D8, X12
    FMOV  V8.D[1], X20
    FMOV  D9, X27
    FMOV  V9.D[1], X11
    FMOV  D10, X10
    FMOV  V10.D[1], X21
    FMOV  D11, X25
    FMOV  V11.D[1], X22
    FMOV  D12, X18
    FMOV  V12.D[1], X16
    FMOV  D13, X17
    FMOV  V13.D[1], X24
    FMOV  D14, X17
    FMOV  V14.D[1], X4
    FMOV  D15, X14
    FMOV  V15.D[1], X11
    FMOV  D16, X13
    FMOV  V16.D[1], X4
    FMOV  D17, X26
    FMOV  V17.D[1], X20
    FMOV  D18, X13
    FMOV  V18.D[1], X21
    FMOV  D19, X21
    FMOV  V19.D[1], X15
    FMOV  D20, X24
    FMOV  V20.D[1], X17
    FMOV  D21, X20
    FMOV  V21.D[1], X12
    FMOV  D22, X18
    FMOV  V22.D[1], X3
    FMOV  D23, X17
    FMOV  V23.D[1], X10
    FMOV  D24, X24
    FMOV  V24.D[1], X27
    FMOV  D25, X17
    FMOV  V25.D[1], X3
    FMOV  D26, X4
    FMOV  V26.D[1], X26
    FMOV  D27, X25
    FMOV  V27.D[1], X5
    FMOV  D28, X9
    FMOV  V28.D[1], X3
    FMOV  D29, X25
    FMOV  V29.D[1], X24
    FMOV  D30, X7
    FMOV  V30.D[1], X7
    FMOV  D31, X27
    FMOV  V31.D[1], X24
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X24, #0x1400, LSL #0
    ADD  X5, X30, X24
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X5]
    LD2R { V25.2D, V26.2D }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X5]
    LD2R { V2.16B, V3.16B }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X5]
    LD2R { V17.2D, V18.2D }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X5]
    LD2R { V8.4S, V9.4S }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X5]
    LD2R { V3.8H, V4.8H }, [X5]
    ADD  X5, X5, X19, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X5]
    LD2R { V26.1D, V27.1D }, [X5]
    ADD  X5, X5, X19
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X5]
    LD2R { V30.1D, V31.1D }, [X5]
    ADD  X5, X5, X19
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X5]
    LD2R { V0.2S, V1.2S }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X5]
    LD2R { V28.4H, V29.4H }, [X5]
    ADD  X5, X5, X19, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X5]
    LD2R { V4.8B, V5.8B }, [X5]
    ADD  X5, X5, X19
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X5]
    MOV  X21, X5
    LD2R { V30.1D, V31.1D }, [X21], #16
    ADD  X5, X5, X19
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X5]
    MOV  X21, X5
    LD2R { V3.1D, V4.1D }, [X21], #16
    ADD  X5, X5, X19
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X5]
    MOV  X21, X5
    LD2R { V28.2D, V29.2D }, [X21], #16
    ADD  X5, X5, X19
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X5]
    MOV  X21, X5
    LD2R { V24.16B, V25.16B }, [X21], #2
    ADD  X5, X5, X19, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X5]
    MOV  X21, X5
    LD2R { V19.16B, V20.16B }, [X21], #2
    ADD  X5, X5, X19, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X5]
    MOV  X21, X5
    LD2R { V26.8B, V27.8B }, [X21], #2
    ADD  X5, X5, X19, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X5]
    MOV  X21, X5
    LD2R { V5.4H, V6.4H }, [X21], #4
    ADD  X5, X5, X19, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X5]
    MOV  X21, X5
    LD2R { V0.8H, V1.8H }, [X21], #4
    ADD  X5, X5, X19, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X5]
    MOV  X21, X5
    LD2R { V24.4S, V25.4S }, [X21], #8
    ADD  X5, X5, X19
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X5]
    MOV  X21, X5
    LD2R { V16.2S, V17.2S }, [X21], #8
    ADD  X5, X5, X19
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X5]
    MOV  X21, X5
    LD2R { V21.4S, V22.4S }, [X21], #8
    ADD  X5, X5, X19, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X5]
    MOV  X21, X5
    LD2R { V15.8H, V16.8H }, [X21], #4
    ADD  X5, X5, X19
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X5]
    LD2R { V30.4S, V31.4S }, [X5], X17
    ADD  X5, X5, X19, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X5]
    LD2R { V12.16B, V13.16B }, [X5], X17
    ADD  X5, X5, X19, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X5]
    LD2R { V10.2D, V11.2D }, [X5], X17
    ADD  X5, X5, X19, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X5]
    LD2R { V21.4S, V22.4S }, [X5], X17
    ADD  X5, X5, X19
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X5]
    LD2R { V12.8H, V13.8H }, [X5], X17
    ADD  X5, X5, X19, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X5]
    LD2R { V1.1D, V2.1D }, [X5], X17
    ADD  X5, X5, X19, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X5]
    LD2R { V19.1D, V20.1D }, [X5], X17
    ADD  X5, X5, X19, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X5]
    LD2R { V10.2S, V11.2S }, [X5], X17
    ADD  X5, X5, X19, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X5]
    LD2R { V28.4H, V29.4H }, [X5], X17
    ADD  X5, X5, X19, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X5]
    LD2R { V31.8B, V0.8B }, [X5], X17
    ADD  X5, X5, X19, LSR #0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X9, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D0
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D1
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D2
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D3
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D4
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D5
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D6
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V7.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D7
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D8
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D9
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D10
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D11
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V12.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D12
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D13
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D14
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V15.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D15
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D16
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D17
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D18
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D19
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D20
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D21
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D22
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V23.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D23
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D24
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D25
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D26
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D27
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D28
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D29
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D30
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X9, D31
    SUB  X14, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X20
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X3
    FMOV  D3, X16
    FMOV  V3.D[1], X12
    FMOV  D4, X23
    FMOV  V4.D[1], X7
    FMOV  D5, X13
    FMOV  V5.D[1], X16
    FMOV  D6, X4
    FMOV  V6.D[1], X3
    FMOV  D7, X18
    FMOV  V7.D[1], X26
    FMOV  D8, X14
    FMOV  V8.D[1], X3
    FMOV  D9, X12
    FMOV  V9.D[1], X4
    FMOV  D10, X23
    FMOV  V10.D[1], X23
    FMOV  D11, X5
    FMOV  V11.D[1], X2
    FMOV  D12, X19
    FMOV  V12.D[1], X9
    FMOV  D13, X12
    FMOV  V13.D[1], X5
    FMOV  D14, X18
    FMOV  V14.D[1], X24
    FMOV  D15, X14
    FMOV  V15.D[1], X11
    FMOV  D16, X11
    FMOV  V16.D[1], X15
    FMOV  D17, X16
    FMOV  V17.D[1], X12
    FMOV  D18, X18
    FMOV  V18.D[1], X13
    FMOV  D19, X10
    FMOV  V19.D[1], X27
    FMOV  D20, X17
    FMOV  V20.D[1], X20
    FMOV  D21, X22
    FMOV  V21.D[1], X24
    FMOV  D22, X11
    FMOV  V22.D[1], X15
    FMOV  D23, X14
    FMOV  V23.D[1], X20
    FMOV  D24, X24
    FMOV  V24.D[1], X2
    FMOV  D25, X22
    FMOV  V25.D[1], X4
    FMOV  D26, X18
    FMOV  V26.D[1], X11
    FMOV  D27, X13
    FMOV  V27.D[1], X18
    FMOV  D28, X16
    FMOV  V28.D[1], X13
    FMOV  D29, X14
    FMOV  V29.D[1], X19
    FMOV  D30, X25
    FMOV  V30.D[1], X25
    FMOV  D31, X19
    FMOV  V31.D[1], X3
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X22, #0x1900, LSL #0
    ADD  X25, X30, X22, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X25]
    LD2R { V15.8H, V16.8H }, [X25]
    ADD  X25, X25, X20
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X25]
    LD2R { V16.16B, V17.16B }, [X25]
    ADD  X25, X25, X20
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X25]
    LD2R { V27.2D, V28.2D }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X25]
    LD2R { V9.4S, V10.4S }, [X25]
    ADD  X25, X25, X20, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X25]
    LD2R { V8.8H, V9.8H }, [X25]
    ADD  X25, X25, X20, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X25]
    LD2R { V31.4H, V0.4H }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X25]
    LD2R { V5.1D, V6.1D }, [X25]
    ADD  X25, X25, X20, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X25]
    LD2R { V3.2S, V4.2S }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X25]
    LD2R { V2.4H, V3.4H }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X25]
    LD2R { V31.8B, V0.8B }, [X25]
    ADD  X25, X25, X20
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X25]
    MOV  X7, X25
    LD2R { V25.2D, V26.2D }, [X7], #16
    ADD  X25, X25, X20
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X25]
    MOV  X7, X25
    LD2R { V29.1D, V30.1D }, [X7], #16
    ADD  X25, X25, X20, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X25]
    MOV  X7, X25
    LD2R { V5.2D, V6.2D }, [X7], #16
    ADD  X25, X25, X20, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X25]
    MOV  X7, X25
    LD2R { V20.16B, V21.16B }, [X7], #2
    ADD  X25, X25, X20, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X25]
    MOV  X7, X25
    LD2R { V8.16B, V9.16B }, [X7], #2
    ADD  X25, X25, X20, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X25]
    MOV  X7, X25
    LD2R { V12.8B, V13.8B }, [X7], #2
    ADD  X25, X25, X20
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X25]
    MOV  X7, X25
    LD2R { V2.4H, V3.4H }, [X7], #4
    ADD  X25, X25, X20, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X25]
    MOV  X7, X25
    LD2R { V20.8H, V21.8H }, [X7], #4
    ADD  X25, X25, X20, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X25]
    MOV  X7, X25
    LD2R { V13.2S, V14.2S }, [X7], #8
    ADD  X25, X25, X20, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X25]
    MOV  X7, X25
    LD2R { V24.2S, V25.2S }, [X7], #8
    ADD  X25, X25, X20
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X25]
    MOV  X7, X25
    LD2R { V3.4S, V4.4S }, [X7], #8
    ADD  X25, X25, X20, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X25]
    MOV  X7, X25
    LD2R { V21.8H, V22.8H }, [X7], #4
    ADD  X25, X25, X20
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X25]
    LD2R { V31.2D, V0.2D }, [X25], X14
    ADD  X25, X25, X20
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X25]
    LD2R { V7.16B, V8.16B }, [X25], X14
    ADD  X25, X25, X20
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X25]
    LD2R { V6.2D, V7.2D }, [X25], X14
    ADD  X25, X25, X20, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X25]
    LD2R { V0.4S, V1.4S }, [X25], X14
    ADD  X25, X25, X20, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X25]
    LD2R { V3.8H, V4.8H }, [X25], X14
    ADD  X25, X25, X20, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X25]
    LD2R { V25.4H, V26.4H }, [X25], X14
    ADD  X25, X25, X20, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X25]
    LD2R { V22.1D, V23.1D }, [X25], X14
    ADD  X25, X25, X20, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X25]
    LD2R { V15.2S, V16.2S }, [X25], X14
    ADD  X25, X25, X20, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X25]
    LD2R { V4.4H, V5.4H }, [X25], X14
    ADD  X25, X25, X20
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X25]
    LD2R { V4.8B, V5.8B }, [X25], X14
    ADD  X25, X25, X20
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D0
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V1.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D1
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D2
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V3.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D3
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D4
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D5
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D6
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D7
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V8.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D8
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V9.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D9
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V10.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D10
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D11
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D12
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D13
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D14
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D15
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D16
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V17.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D17
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V18.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D18
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D19
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V20.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D20
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V21.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D21
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D22
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D23
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D24
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D25
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D26
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V27.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D27
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D28
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D29
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D30
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, V31.D[1]
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X18, D31
    SUB  X21, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X26
    FMOV  D1, X21
    FMOV  V1.D[1], X27
    FMOV  D2, X22
    FMOV  V2.D[1], X24
    FMOV  D3, X26
    FMOV  V3.D[1], X14
    FMOV  D4, X7
    FMOV  V4.D[1], X22
    FMOV  D5, X18
    FMOV  V5.D[1], X10
    FMOV  D6, X14
    FMOV  V6.D[1], X15
    FMOV  D7, X16
    FMOV  V7.D[1], X25
    FMOV  D8, X14
    FMOV  V8.D[1], X3
    FMOV  D9, X27
    FMOV  V9.D[1], X27
    FMOV  D10, X5
    FMOV  V10.D[1], X11
    FMOV  D11, X25
    FMOV  V11.D[1], X19
    FMOV  D12, X25
    FMOV  V12.D[1], X16
    FMOV  D13, X3
    FMOV  V13.D[1], X18
    FMOV  D14, X14
    FMOV  V14.D[1], X10
    FMOV  D15, X22
    FMOV  V15.D[1], X4
    FMOV  D16, X21
    FMOV  V16.D[1], X18
    FMOV  D17, X20
    FMOV  V17.D[1], X27
    FMOV  D18, X4
    FMOV  V18.D[1], X25
    FMOV  D19, X17
    FMOV  V19.D[1], X4
    FMOV  D20, X10
    FMOV  V20.D[1], X21
    FMOV  D21, X21
    FMOV  V21.D[1], X17
    FMOV  D22, X2
    FMOV  V22.D[1], X7
    FMOV  D23, X9
    FMOV  V23.D[1], X25
    FMOV  D24, X17
    FMOV  V24.D[1], X19
    FMOV  D25, X2
    FMOV  V25.D[1], X3
    FMOV  D26, X15
    FMOV  V26.D[1], X27
    FMOV  D27, X9
    FMOV  V27.D[1], X2
    FMOV  D28, X17
    FMOV  V28.D[1], X9
    FMOV  D29, X13
    FMOV  V29.D[1], X16
    FMOV  D30, X15
    FMOV  V30.D[1], X25
    FMOV  D31, X26
    FMOV  V31.D[1], X3
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X2, #0x1e00, LSL #0
    ADD  X22, X30, X2, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X22]
    LD2R { V23.16B, V24.16B }, [X22]
    ADD  X22, X22, X16, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X22]
    LD2R { V0.16B, V1.16B }, [X22]
    ADD  X22, X22, X16, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X22]
    LD2R { V16.2D, V17.2D }, [X22]
    ADD  X22, X22, X16, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X22]
    LD2R { V10.4S, V11.4S }, [X22]
    ADD  X22, X22, X16, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X22]
    LD2R { V21.8H, V22.8H }, [X22]
    ADD  X22, X22, X16, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X22]
    LD2R { V1.8B, V2.8B }, [X22]
    ADD  X22, X22, X16, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X22]
    LD2R { V25.1D, V26.1D }, [X22]
    ADD  X22, X22, X16
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X22]
    LD2R { V19.2S, V20.2S }, [X22]
    ADD  X22, X22, X16, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X22]
    LD2R { V11.4H, V12.4H }, [X22]
    ADD  X22, X22, X16, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X22]
    LD2R { V30.8B, V31.8B }, [X22]
    ADD  X22, X22, X16, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X22]
    MOV  X23, X22
    LD2R { V1.1D, V2.1D }, [X23], #16
    ADD  X22, X22, X16, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X22]
    MOV  X23, X22
    LD2R { V3.1D, V4.1D }, [X23], #16
    ADD  X22, X22, X16, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X22]
    MOV  X23, X22
    LD2R { V13.2D, V14.2D }, [X23], #16
    ADD  X22, X22, X16, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X22]
    MOV  X23, X22
    LD2R { V5.16B, V6.16B }, [X23], #2
    ADD  X22, X22, X16
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X22]
    MOV  X23, X22
    LD2R { V27.16B, V28.16B }, [X23], #2
    ADD  X22, X22, X16
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X22]
    MOV  X23, X22
    LD2R { V9.8B, V10.8B }, [X23], #2
    ADD  X22, X22, X16, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X22]
    MOV  X23, X22
    LD2R { V11.4H, V12.4H }, [X23], #4
    ADD  X22, X22, X16, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X22]
    MOV  X23, X22
    LD2R { V6.8H, V7.8H }, [X23], #4
    ADD  X22, X22, X16, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X22]
    MOV  X23, X22
    LD2R { V1.4S, V2.4S }, [X23], #8
    ADD  X22, X22, X16
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X22]
    MOV  X23, X22
    LD2R { V8.2S, V9.2S }, [X23], #8
    ADD  X22, X22, X16, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X22]
    MOV  X23, X22
    LD2R { V17.4S, V18.4S }, [X23], #8
    ADD  X22, X22, X16, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X22]
    MOV  X23, X22
    LD2R { V11.8H, V12.8H }, [X23], #4
    ADD  X22, X22, X16, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X22]
    LD2R { V9.8H, V10.8H }, [X22], X9
    ADD  X22, X22, X16, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X22]
    LD2R { V22.16B, V23.16B }, [X22], X9
    ADD  X22, X22, X16, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X22]
    LD2R { V8.2D, V9.2D }, [X22], X9
    ADD  X22, X22, X16
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X22]
    LD2R { V2.4S, V3.4S }, [X22], X9
    ADD  X22, X22, X16, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X22]
    LD2R { V0.8H, V1.8H }, [X22], X9
    ADD  X22, X22, X16, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X22]
    LD2R { V12.2S, V13.2S }, [X22], X9
    ADD  X22, X22, X16
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X22]
    LD2R { V22.1D, V23.1D }, [X22], X9
    ADD  X22, X22, X16, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X22]
    LD2R { V3.2S, V4.2S }, [X22], X9
    ADD  X22, X22, X16
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X22]
    LD2R { V0.4H, V1.4H }, [X22], X9
    ADD  X22, X22, X16, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X22]
    LD2R { V20.8B, V21.8B }, [X22], X9
    ADD  X22, X22, X16
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V0.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D0
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D1
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V2.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D2
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D3
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D4
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V5.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D5
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V6.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D6
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V7.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D7
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V8.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D8
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V9.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D9
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V10.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D10
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V11.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D11
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V12.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D12
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D13
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V14.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D14
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V15.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D15
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V16.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D16
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V17.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D17
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V18.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D18
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D19
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D20
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D21
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D22
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D23
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V24.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D24
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D25
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D26
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V27.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D27
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V28.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D28
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, V29.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D29
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D30
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X11, D31
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X26
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X15
    FMOV  D3, X22
    FMOV  V3.D[1], X4
    FMOV  D4, X18
    FMOV  V4.D[1], X16
    FMOV  D5, X13
    FMOV  V5.D[1], X21
    FMOV  D6, X27
    FMOV  V6.D[1], X9
    FMOV  D7, X22
    FMOV  V7.D[1], X21
    FMOV  D8, X4
    FMOV  V8.D[1], X11
    FMOV  D9, X26
    FMOV  V9.D[1], X15
    FMOV  D10, X10
    FMOV  V10.D[1], X20
    FMOV  D11, X19
    FMOV  V11.D[1], X21
    FMOV  D12, X27
    FMOV  V12.D[1], X15
    FMOV  D13, X16
    FMOV  V13.D[1], X2
    FMOV  D14, X12
    FMOV  V14.D[1], X22
    FMOV  D15, X4
    FMOV  V15.D[1], X15
    FMOV  D16, X25
    FMOV  V16.D[1], X13
    FMOV  D17, X23
    FMOV  V17.D[1], X10
    FMOV  D18, X13
    FMOV  V18.D[1], X22
    FMOV  D19, X23
    FMOV  V19.D[1], X20
    FMOV  D20, X27
    FMOV  V20.D[1], X3
    FMOV  D21, X23
    FMOV  V21.D[1], X5
    FMOV  D22, X2
    FMOV  V22.D[1], X24
    FMOV  D23, X18
    FMOV  V23.D[1], X14
    FMOV  D24, X5
    FMOV  V24.D[1], X5
    FMOV  D25, X20
    FMOV  V25.D[1], X12
    FMOV  D26, X11
    FMOV  V26.D[1], X12
    FMOV  D27, X9
    FMOV  V27.D[1], X10
    FMOV  D28, X12
    FMOV  V28.D[1], X15
    FMOV  D29, X24
    FMOV  V29.D[1], X26
    FMOV  D30, X3
    FMOV  V30.D[1], X12
    FMOV  D31, X13
    FMOV  V31.D[1], X20
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X2, #0x2300, LSL #0
    ADD  X17, X30, X2, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X17]
    LD2R { V19.4S, V20.4S }, [X17]
    ADD  X17, X17, X13, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X17]
    LD2R { V13.16B, V14.16B }, [X17]
    ADD  X17, X17, X13, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X17]
    LD2R { V0.2D, V1.2D }, [X17]
    ADD  X17, X17, X13, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X17]
    LD2R { V0.4S, V1.4S }, [X17]
    ADD  X17, X17, X13, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X17]
    LD2R { V27.8H, V28.8H }, [X17]
    ADD  X17, X17, X13, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X17]
    LD2R { V29.4H, V30.4H }, [X17]
    ADD  X17, X17, X13, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X17]
    LD2R { V27.1D, V28.1D }, [X17]
    ADD  X17, X17, X13
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X17]
    LD2R { V23.2S, V24.2S }, [X17]
    ADD  X17, X17, X13
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X17]
    LD2R { V12.4H, V13.4H }, [X17]
    ADD  X17, X17, X13, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X17]
    LD2R { V2.8B, V3.8B }, [X17]
    ADD  X17, X17, X13, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X17]
    MOV  X21, X17
    LD2R { V10.1D, V11.1D }, [X21], #16
    ADD  X17, X17, X13, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X17]
    MOV  X21, X17
    LD2R { V11.1D, V12.1D }, [X21], #16
    ADD  X17, X17, X13
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X17]
    MOV  X21, X17
    LD2R { V29.2D, V30.2D }, [X21], #16
    ADD  X17, X17, X13, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X17]
    MOV  X21, X17
    LD2R { V6.16B, V7.16B }, [X21], #2
    ADD  X17, X17, X13
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X17]
    MOV  X21, X17
    LD2R { V25.16B, V26.16B }, [X21], #2
    ADD  X17, X17, X13, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X17]
    MOV  X21, X17
    LD2R { V17.8B, V18.8B }, [X21], #2
    ADD  X17, X17, X13, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X17]
    MOV  X21, X17
    LD2R { V12.4H, V13.4H }, [X21], #4
    ADD  X17, X17, X13
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X17]
    MOV  X21, X17
    LD2R { V15.8H, V16.8H }, [X21], #4
    ADD  X17, X17, X13, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X17]
    MOV  X21, X17
    LD2R { V6.4S, V7.4S }, [X21], #8
    ADD  X17, X17, X13
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X17]
    MOV  X21, X17
    LD2R { V12.2S, V13.2S }, [X21], #8
    ADD  X17, X17, X13, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X17]
    MOV  X21, X17
    LD2R { V25.4S, V26.4S }, [X21], #8
    ADD  X17, X17, X13, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X17]
    MOV  X21, X17
    LD2R { V16.8H, V17.8H }, [X21], #4
    ADD  X17, X17, X13, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X17]
    LD2R { V9.2D, V10.2D }, [X17], X23
    ADD  X17, X17, X13, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X17]
    LD2R { V6.16B, V7.16B }, [X17], X23
    ADD  X17, X17, X13, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X17]
    LD2R { V0.2D, V1.2D }, [X17], X23
    ADD  X17, X17, X13, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X17]
    LD2R { V16.4S, V17.4S }, [X17], X23
    ADD  X17, X17, X13
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X17]
    LD2R { V4.8H, V5.8H }, [X17], X23
    ADD  X17, X17, X13
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X17]
    LD2R { V25.2S, V26.2S }, [X17], X23
    ADD  X17, X17, X13, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X17]
    LD2R { V5.1D, V6.1D }, [X17], X23
    ADD  X17, X17, X13, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X17]
    LD2R { V7.2S, V8.2S }, [X17], X23
    ADD  X17, X17, X13, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X17]
    LD2R { V5.4H, V6.4H }, [X17], X23
    ADD  X17, X17, X13
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X17]
    LD2R { V5.8B, V6.8B }, [X17], X23
    ADD  X17, X17, X13
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X16, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D0
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D1
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D2
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D3
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D4
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V5.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D5
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D6
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D7
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D8
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D9
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V10.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D10
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D11
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D12
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D13
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V14.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D14
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D15
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V16.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D16
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V17.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D17
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D18
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V19.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D19
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V20.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D20
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D21
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D22
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D23
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D24
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D25
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D26
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D27
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D28
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V29.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D29
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V30.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D30
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, V31.D[1]
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X16, D31
    SUB  X5, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X24
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X18
    FMOV  D3, X15
    FMOV  V3.D[1], X25
    FMOV  D4, X4
    FMOV  V4.D[1], X4
    FMOV  D5, X27
    FMOV  V5.D[1], X2
    FMOV  D6, X4
    FMOV  V6.D[1], X15
    FMOV  D7, X16
    FMOV  V7.D[1], X23
    FMOV  D8, X17
    FMOV  V8.D[1], X21
    FMOV  D9, X21
    FMOV  V9.D[1], X15
    FMOV  D10, X5
    FMOV  V10.D[1], X18
    FMOV  D11, X19
    FMOV  V11.D[1], X25
    FMOV  D12, X17
    FMOV  V12.D[1], X22
    FMOV  D13, X14
    FMOV  V13.D[1], X13
    FMOV  D14, X23
    FMOV  V14.D[1], X9
    FMOV  D15, X24
    FMOV  V15.D[1], X10
    FMOV  D16, X26
    FMOV  V16.D[1], X25
    FMOV  D17, X10
    FMOV  V17.D[1], X12
    FMOV  D18, X17
    FMOV  V18.D[1], X20
    FMOV  D19, X17
    FMOV  V19.D[1], X7
    FMOV  D20, X22
    FMOV  V20.D[1], X10
    FMOV  D21, X17
    FMOV  V21.D[1], X4
    FMOV  D22, X14
    FMOV  V22.D[1], X21
    FMOV  D23, X13
    FMOV  V23.D[1], X26
    FMOV  D24, X12
    FMOV  V24.D[1], X2
    FMOV  D25, X26
    FMOV  V25.D[1], X2
    FMOV  D26, X7
    FMOV  V26.D[1], X4
    FMOV  D27, X18
    FMOV  V27.D[1], X14
    FMOV  D28, X2
    FMOV  V28.D[1], X5
    FMOV  D29, X24
    FMOV  V29.D[1], X4
    FMOV  D30, X18
    FMOV  V30.D[1], X18
    FMOV  D31, X13
    FMOV  V31.D[1], X11
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X9, #0x2800, LSL #0
    ADD  X5, X30, X9
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X5]
    LD2R { V2.16B, V3.16B }, [X5]
    ADD  X5, X5, X17
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X5]
    LD2R { V17.16B, V18.16B }, [X5]
    ADD  X5, X5, X17, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X5]
    LD2R { V23.2D, V24.2D }, [X5]
    ADD  X5, X5, X17, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X5]
    LD2R { V15.4S, V16.4S }, [X5]
    ADD  X5, X5, X17
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X5]
    LD2R { V30.8H, V31.8H }, [X5]
    ADD  X5, X5, X17, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X5]
    LD2R { V7.8B, V8.8B }, [X5]
    ADD  X5, X5, X17
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X5]
    LD2R { V28.1D, V29.1D }, [X5]
    ADD  X5, X5, X17, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X5]
    LD2R { V10.2S, V11.2S }, [X5]
    ADD  X5, X5, X17
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X5]
    LD2R { V26.4H, V27.4H }, [X5]
    ADD  X5, X5, X17, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X5]
    LD2R { V27.8B, V28.8B }, [X5]
    ADD  X5, X5, X17
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X5]
    MOV  X23, X5
    LD2R { V2.1D, V3.1D }, [X23], #16
    ADD  X5, X5, X17, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X5]
    MOV  X23, X5
    LD2R { V30.1D, V31.1D }, [X23], #16
    ADD  X5, X5, X17, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X5]
    MOV  X23, X5
    LD2R { V6.2D, V7.2D }, [X23], #16
    ADD  X5, X5, X17, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X5]
    MOV  X23, X5
    LD2R { V15.16B, V16.16B }, [X23], #2
    ADD  X5, X5, X17
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X5]
    MOV  X23, X5
    LD2R { V8.16B, V9.16B }, [X23], #2
    ADD  X5, X5, X17, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X5]
    MOV  X23, X5
    LD2R { V28.8B, V29.8B }, [X23], #2
    ADD  X5, X5, X17, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X5]
    MOV  X23, X5
    LD2R { V23.4H, V24.4H }, [X23], #4
    ADD  X5, X5, X17, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X5]
    MOV  X23, X5
    LD2R { V25.8H, V26.8H }, [X23], #4
    ADD  X5, X5, X17, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X5]
    MOV  X23, X5
    LD2R { V31.4S, V0.4S }, [X23], #8
    ADD  X5, X5, X17, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X5]
    MOV  X23, X5
    LD2R { V19.2S, V20.2S }, [X23], #8
    ADD  X5, X5, X17
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X5]
    MOV  X23, X5
    LD2R { V26.4S, V27.4S }, [X23], #8
    ADD  X5, X5, X17
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X5]
    MOV  X23, X5
    LD2R { V1.4H, V2.4H }, [X23], #4
    ADD  X5, X5, X17, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X5]
    LD2R { V16.4S, V17.4S }, [X5], X21
    ADD  X5, X5, X17
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X5]
    LD2R { V23.16B, V24.16B }, [X5], X21
    ADD  X5, X5, X17, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X5]
    LD2R { V3.2D, V4.2D }, [X5], X21
    ADD  X5, X5, X17, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X5]
    LD2R { V29.4S, V30.4S }, [X5], X21
    ADD  X5, X5, X17, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X5]
    LD2R { V17.8H, V18.8H }, [X5], X21
    ADD  X5, X5, X17, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X5]
    LD2R { V13.4H, V14.4H }, [X5], X21
    ADD  X5, X5, X17, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X5]
    LD2R { V30.1D, V31.1D }, [X5], X21
    ADD  X5, X5, X17, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X5]
    LD2R { V27.2S, V28.2S }, [X5], X21
    ADD  X5, X5, X17, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X5]
    LD2R { V22.4H, V23.4H }, [X5], X21
    ADD  X5, X5, X17, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X5]
    LD2R { V5.8B, V6.8B }, [X5], X21
    ADD  X5, X5, X17, LSR #0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X22, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X22, FPSR
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V0.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D0
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V1.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D1
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D2
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V3.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D3
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V4.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D4
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D5
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D6
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V7.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D7
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V8.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D8
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V9.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D9
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V10.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D10
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V11.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D11
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V12.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D12
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V13.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D13
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V14.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D14
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V15.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D15
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V16.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D16
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V17.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D17
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V18.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D18
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D19
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D20
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V21.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D21
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D22
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D23
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V24.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D24
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V25.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D25
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V26.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D26
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D27
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V28.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D28
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, V29.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D29
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V30.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D30
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X22, V31.D[1]
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X22, D31
    SUB  X27, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X21
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X2
    FMOV  D3, X12
    FMOV  V3.D[1], X11
    FMOV  D4, X18
    FMOV  V4.D[1], X27
    FMOV  D5, X17
    FMOV  V5.D[1], X19
    FMOV  D6, X10
    FMOV  V6.D[1], X15
    FMOV  D7, X20
    FMOV  V7.D[1], X17
    FMOV  D8, X21
    FMOV  V8.D[1], X25
    FMOV  D9, X25
    FMOV  V9.D[1], X26
    FMOV  D10, X25
    FMOV  V10.D[1], X25
    FMOV  D11, X12
    FMOV  V11.D[1], X23
    FMOV  D12, X11
    FMOV  V12.D[1], X12
    FMOV  D13, X20
    FMOV  V13.D[1], X14
    FMOV  D14, X16
    FMOV  V14.D[1], X13
    FMOV  D15, X19
    FMOV  V15.D[1], X20
    FMOV  D16, X7
    FMOV  V16.D[1], X3
    FMOV  D17, X23
    FMOV  V17.D[1], X25
    FMOV  D18, X22
    FMOV  V18.D[1], X22
    FMOV  D19, X23
    FMOV  V19.D[1], X14
    FMOV  D20, X21
    FMOV  V20.D[1], X12
    FMOV  D21, X18
    FMOV  V21.D[1], X27
    FMOV  D22, X24
    FMOV  V22.D[1], X27
    FMOV  D23, X13
    FMOV  V23.D[1], X7
    FMOV  D24, X7
    FMOV  V24.D[1], X15
    FMOV  D25, X27
    FMOV  V25.D[1], X14
    FMOV  D26, X11
    FMOV  V26.D[1], X9
    FMOV  D27, X24
    FMOV  V27.D[1], X9
    FMOV  D28, X2
    FMOV  V28.D[1], X26
    FMOV  D29, X4
    FMOV  V29.D[1], X15
    FMOV  D30, X25
    FMOV  V30.D[1], X23
    FMOV  D31, X19
    FMOV  V31.D[1], X17
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X19, #0x2d00, LSL #0
    ADD  X24, X30, X19, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X24]
    LD2R { V31.8H, V0.8H }, [X24]
    ADD  X24, X24, X22, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X24]
    LD2R { V9.16B, V10.16B }, [X24]
    ADD  X24, X24, X22, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X24]
    LD2R { V3.2D, V4.2D }, [X24]
    ADD  X24, X24, X22, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X24]
    LD2R { V16.4S, V17.4S }, [X24]
    ADD  X24, X24, X22, LSR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X24]
    LD2R { V8.8H, V9.8H }, [X24]
    ADD  X24, X24, X22, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X24]
    LD2R { V26.8B, V27.8B }, [X24]
    ADD  X24, X24, X22, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X24]
    LD2R { V21.1D, V22.1D }, [X24]
    ADD  X24, X24, X22, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X24]
    LD2R { V11.2S, V12.2S }, [X24]
    ADD  X24, X24, X22, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X24]
    LD2R { V31.4H, V0.4H }, [X24]
    ADD  X24, X24, X22
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X24]
    LD2R { V6.8B, V7.8B }, [X24]
    ADD  X24, X24, X22, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X24]
    MOV  X15, X24
    LD2R { V17.1D, V18.1D }, [X15], #16
    ADD  X24, X24, X22
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X24]
    MOV  X15, X24
    LD2R { V29.1D, V30.1D }, [X15], #16
    ADD  X24, X24, X22, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X24]
    MOV  X15, X24
    LD2R { V3.2D, V4.2D }, [X15], #16
    ADD  X24, X24, X22, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X24]
    MOV  X15, X24
    LD2R { V9.16B, V10.16B }, [X15], #2
    ADD  X24, X24, X22, LSR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X24]
    MOV  X15, X24
    LD2R { V19.16B, V20.16B }, [X15], #2
    ADD  X24, X24, X22, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X24]
    MOV  X15, X24
    LD2R { V1.8B, V2.8B }, [X15], #2
    ADD  X24, X24, X22, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X24]
    MOV  X15, X24
    LD2R { V7.4H, V8.4H }, [X15], #4
    ADD  X24, X24, X22
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X24]
    MOV  X15, X24
    LD2R { V10.8H, V11.8H }, [X15], #4
    ADD  X24, X24, X22, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X24]
    MOV  X15, X24
    LD2R { V8.2S, V9.2S }, [X15], #8
    ADD  X24, X24, X22
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X24]
    MOV  X15, X24
    LD2R { V23.2S, V24.2S }, [X15], #8
    ADD  X24, X24, X22
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X24]
    MOV  X15, X24
    LD2R { V3.4S, V4.4S }, [X15], #8
    ADD  X24, X24, X22, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X24]
    MOV  X15, X24
    LD2R { V6.4H, V7.4H }, [X15], #4
    ADD  X24, X24, X22
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X24]
    LD2R { V19.2D, V20.2D }, [X24], X16
    ADD  X24, X24, X22, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X24]
    LD2R { V8.16B, V9.16B }, [X24], X16
    ADD  X24, X24, X22, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X24]
    LD2R { V10.2D, V11.2D }, [X24], X16
    ADD  X24, X24, X22
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X24]
    LD2R { V29.4S, V30.4S }, [X24], X16
    ADD  X24, X24, X22, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X24]
    LD2R { V4.8H, V5.8H }, [X24], X16
    ADD  X24, X24, X22
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X24]
    LD2R { V14.2S, V15.2S }, [X24], X16
    ADD  X24, X24, X22, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X24]
    LD2R { V21.1D, V22.1D }, [X24], X16
    ADD  X24, X24, X22
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X24]
    LD2R { V9.2S, V10.2S }, [X24], X16
    ADD  X24, X24, X22
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X24]
    LD2R { V11.4H, V12.4H }, [X24], X16
    ADD  X24, X24, X22
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X24]
    LD2R { V10.8B, V11.8B }, [X24], X16
    ADD  X24, X24, X22
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X12, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D0
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D1
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D2
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V3.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D3
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V4.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D4
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D5
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D6
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D7
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V8.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D8
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D9
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D10
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D11
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D12
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D13
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D14
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D15
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V16.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D16
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D17
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D18
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V19.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D19
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V20.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D20
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D21
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D22
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D23
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D24
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D25
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D26
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D27
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V28.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D28
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V29.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D29
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D30
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X12, D31
    SUB  X27, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP02_TestFail

AdvsimdLoadDeprecatedP02_TestEnd:
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
AdvsimdLoadDeprecatedP02_TestFail:
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
