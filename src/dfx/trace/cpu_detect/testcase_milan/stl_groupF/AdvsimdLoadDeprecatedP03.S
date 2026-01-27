.global AdvsimdLoadDeprecatedP03

.text
.p2align 4

AdvsimdLoadDeprecatedP03:

AdvsimdLoadDeprecatedP03_TestBegin:
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
    MOVZ  X2, #0x1dc5, LSL #0
    MOVK  X2, #0x5183, LSL #16
    MOVK  X2, #0x6bff, LSL #32
    MOVK  X2, #0x1b0a, LSL #48
    MOVZ  X3, #0x4af1, LSL #0
    MOVK  X3, #0xdbfa, LSL #16
    MOVK  X3, #0xb844, LSL #32
    MOVK  X3, #0x2ec4, LSL #48
    MOVZ  X4, #0x2dc1, LSL #0
    MOVK  X4, #0xa526, LSL #16
    MOVK  X4, #0xc48d, LSL #32
    MOVK  X4, #0x26ac, LSL #48
    MOVZ  X7, #0x43c2, LSL #0
    MOVK  X7, #0x1c86, LSL #16
    MOVK  X7, #0x6ed7, LSL #32
    MOVK  X7, #0xc4e9, LSL #48
    MOVZ  X8, #0xc6b8, LSL #0
    MOVK  X8, #0x35b1, LSL #16
    MOVK  X8, #0xe85a, LSL #32
    MOVK  X8, #0xfeeb, LSL #48
    MOVZ  X9, #0xe23, LSL #0
    MOVK  X9, #0x5967, LSL #16
    MOVK  X9, #0x1976, LSL #32
    MOVK  X9, #0x1f2f, LSL #48
    MOVZ  X10, #0x265, LSL #0
    MOVK  X10, #0xdeab, LSL #16
    MOVK  X10, #0x7f6, LSL #32
    MOVK  X10, #0x3bb1, LSL #48
    MOVZ  X11, #0x7f3f, LSL #0
    MOVK  X11, #0x5224, LSL #16
    MOVK  X11, #0xb2cd, LSL #32
    MOVK  X11, #0x3f21, LSL #48
    MOVZ  X12, #0x2a82, LSL #0
    MOVK  X12, #0x325f, LSL #16
    MOVK  X12, #0x7d27, LSL #32
    MOVK  X12, #0x89d6, LSL #48
    MOVZ  X13, #0x9e9a, LSL #0
    MOVK  X13, #0xec97, LSL #16
    MOVK  X13, #0xb8a0, LSL #32
    MOVK  X13, #0x9b35, LSL #48
    MOVZ  X14, #0xd78e, LSL #0
    MOVK  X14, #0x1adc, LSL #16
    MOVK  X14, #0x3552, LSL #32
    MOVK  X14, #0xdbbd, LSL #48
    MOVZ  X15, #0xd5a4, LSL #0
    MOVK  X15, #0xb2d3, LSL #16
    MOVK  X15, #0xddbe, LSL #32
    MOVK  X15, #0xf65f, LSL #48
    MOVZ  X16, #0x8b5b, LSL #0
    MOVK  X16, #0x3a23, LSL #16
    MOVK  X16, #0xb0a5, LSL #32
    MOVK  X16, #0x3010, LSL #48
    MOVZ  X17, #0x10ef, LSL #0
    MOVK  X17, #0xdbca, LSL #16
    MOVK  X17, #0x5a23, LSL #32
    MOVK  X17, #0xa20c, LSL #48
    MOVZ  X18, #0x7ae2, LSL #0
    MOVK  X18, #0xfa6, LSL #16
    MOVK  X18, #0x6329, LSL #32
    MOVK  X18, #0x1aab, LSL #48
    MOVZ  X19, #0xe517, LSL #0
    MOVK  X19, #0xb72e, LSL #16
    MOVK  X19, #0x45a, LSL #32
    MOVK  X19, #0x90a8, LSL #48
    MOVZ  X20, #0xd50e, LSL #0
    MOVK  X20, #0x8a37, LSL #16
    MOVK  X20, #0xbe0b, LSL #32
    MOVK  X20, #0x12ef, LSL #48
    MOVZ  X21, #0x72ec, LSL #0
    MOVK  X21, #0x69f4, LSL #16
    MOVK  X21, #0x5119, LSL #32
    MOVK  X21, #0x7455, LSL #48
    MOVZ  X24, #0xa987, LSL #0
    MOVK  X24, #0x48b, LSL #16
    MOVK  X24, #0xcf95, LSL #32
    MOVK  X24, #0xc466, LSL #48
    MOVZ  X25, #0x329d, LSL #0
    MOVK  X25, #0xffdf, LSL #16
    MOVK  X25, #0x3712, LSL #32
    MOVK  X25, #0x9966, LSL #48
    MOVZ  X26, #0x9e6d, LSL #0
    MOVK  X26, #0xebd4, LSL #16
    MOVK  X26, #0xc506, LSL #32
    MOVK  X26, #0x35ce, LSL #48
    MOVZ  X27, #0x6351, LSL #0
    MOVK  X27, #0xe5cd, LSL #16
    MOVK  X27, #0xc95d, LSL #32
    MOVK  X27, #0xd498, LSL #48
    MOVZ  X28, #0x85d6, LSL #0
    MOVK  X28, #0x7388, LSL #16
    MOVK  X28, #0xb5de, LSL #32
    MOVK  X28, #0x412e, LSL #48
    MOVZ  X29, #0xdb27, LSL #0
    MOVK  X29, #0xbcbb, LSL #16
    MOVK  X29, #0x3931, LSL #32
    MOVK  X29, #0x1c87, LSL #48
    MOVZ  X27, #0xbcec, LSL #0
    MOVK  X27, #0xef3a, LSL #16
    MOVK  X27, #0x6476, LSL #32
    MOVK  X27, #0xb428, LSL #48
    MSR  FPCR, X27
    MOVZ  X27, #0xaacb, LSL #0
    MOVK  X27, #0xffb8, LSL #16
    MOVK  X27, #0xf3ac, LSL #32
    MOVK  X27, #0xe994, LSL #48
    MSR  FPSR, X27
    MRS  X13, FPSR
    MOVZ  X28, #0xff60, LSL #0
    MOVK  X28, #0x7ff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    AND  X13, X13, X28
    MOVZ  X28, #0x0, LSL #0
    ORR  X13, X13, X28
    MSR  FPSR, X13
    ISB  SY
    SUBS  W19, W9, W26, ASR #13
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
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X13
    FMOV  D3, X3
    FMOV  V3.D[1], X24
    FMOV  D4, X28
    FMOV  V4.D[1], X19
    FMOV  D5, X13
    FMOV  V5.D[1], X12
    FMOV  D6, X29
    FMOV  V6.D[1], X14
    FMOV  D7, X14
    FMOV  V7.D[1], X21
    FMOV  D8, X26
    FMOV  V8.D[1], X20
    FMOV  D9, X10
    FMOV  V9.D[1], X16
    FMOV  D10, X9
    FMOV  V10.D[1], X4
    FMOV  D11, X10
    FMOV  V11.D[1], X25
    FMOV  D12, X13
    FMOV  V12.D[1], X26
    FMOV  D13, X28
    FMOV  V13.D[1], X10
    FMOV  D14, X18
    FMOV  V14.D[1], X9
    FMOV  D15, X20
    FMOV  V15.D[1], X27
    FMOV  D16, X4
    FMOV  V16.D[1], X17
    FMOV  D17, X11
    FMOV  V17.D[1], X29
    FMOV  D18, X16
    FMOV  V18.D[1], X24
    FMOV  D19, X16
    FMOV  V19.D[1], X13
    FMOV  D20, X12
    FMOV  V20.D[1], X10
    FMOV  D21, X24
    FMOV  V21.D[1], X9
    FMOV  D22, X16
    FMOV  V22.D[1], X28
    FMOV  D23, X20
    FMOV  V23.D[1], X29
    FMOV  D24, X17
    FMOV  V24.D[1], X21
    FMOV  D25, X14
    FMOV  V25.D[1], X18
    FMOV  D26, X29
    FMOV  V26.D[1], X16
    FMOV  D27, X13
    FMOV  V27.D[1], X25
    FMOV  D28, X11
    FMOV  V28.D[1], X21
    FMOV  D29, X9
    FMOV  V29.D[1], X28
    FMOV  D30, X4
    FMOV  V30.D[1], X21
    FMOV  D31, X29
    FMOV  V31.D[1], X20
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X21, #0x0, LSL #0
    ADD  X8, X30, X21
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X8]
    LD3R { V18.16B, V19.16B, V20.16B }, [X8]
    ADD  X8, X8, X10
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X8]
    LD3R { V26.16B, V27.16B, V28.16B }, [X8]
    ADD  X8, X8, X10
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X8]
    LD3R { V5.2D, V6.2D, V7.2D }, [X8]
    ADD  X8, X8, X10
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X8]
    LD3R { V10.4S, V11.4S, V12.4S }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X8]
    LD3R { V2.8H, V3.8H, V4.8H }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X8]
    LD3R { V9.1D, V10.1D, V11.1D }, [X8]
    ADD  X8, X8, X10, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X8]
    LD3R { V0.1D, V1.1D, V2.1D }, [X8]
    ADD  X8, X8, X10
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X8]
    LD3R { V21.2S, V22.2S, V23.2S }, [X8]
    ADD  X8, X8, X10, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X8]
    LD3R { V5.4H, V6.4H, V7.4H }, [X8]
    ADD  X8, X8, X10
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X8]
    LD3R { V8.8B, V9.8B, V10.8B }, [X8]
    ADD  X8, X8, X10
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X8]
    MOV  X14, X8
    LD3R { V2.4S, V3.4S, V4.4S }, [X14], #12
    ADD  X8, X8, X10, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X8]
    MOV  X14, X8
    LD3R { V26.2S, V27.2S, V28.2S }, [X14], #12
    ADD  X8, X8, X10, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X8]
    MOV  X14, X8
    LD3R { V3.4S, V4.4S, V5.4S }, [X14], #12
    ADD  X8, X8, X10, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X8]
    MOV  X14, X8
    LD3R { V0.2D, V1.2D, V2.2D }, [X14], #24
    ADD  X8, X8, X10, ASR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X8]
    MOV  X14, X8
    LD3R { V11.1D, V12.1D, V13.1D }, [X14], #24
    ADD  X8, X8, X10, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X8]
    MOV  X14, X8
    LD3R { V18.2D, V19.2D, V20.2D }, [X14], #24
    ADD  X8, X8, X10, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X8]
    MOV  X14, X8
    LD3R { V6.8B, V7.8B, V8.8B }, [X14], #3
    ADD  X8, X8, X10, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X8]
    MOV  X14, X8
    LD3R { V2.16B, V3.16B, V4.16B }, [X14], #3
    ADD  X8, X8, X10, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X8]
    MOV  X14, X8
    LD3R { V28.8B, V29.8B, V30.8B }, [X14], #3
    ADD  X8, X8, X10
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X8]
    MOV  X14, X8
    LD3R { V5.4H, V6.4H, V7.4H }, [X14], #6
    ADD  X8, X8, X10, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X8]
    MOV  X14, X8
    LD3R { V11.8H, V12.8H, V13.8H }, [X14], #6
    ADD  X8, X8, X10, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X8]
    MOV  X14, X8
    LD3R { V27.4H, V28.4H, V29.4H }, [X14], #6
    ADD  X8, X8, X10, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X8]
    LD3R { V26.16B, V27.16B, V28.16B }, [X8], X18
    ADD  X8, X8, X10
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X8]
    LD3R { V18.16B, V19.16B, V20.16B }, [X8], X18
    ADD  X8, X8, X10, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X8]
    LD3R { V29.2D, V30.2D, V31.2D }, [X8], X18
    ADD  X8, X8, X10, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X8]
    LD3R { V25.4S, V26.4S, V27.4S }, [X8], X18
    ADD  X8, X8, X10, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X8]
    LD3R { V4.8H, V5.8H, V6.8H }, [X8], X18
    ADD  X8, X8, X10, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X8]
    LD3R { V10.2S, V11.2S, V12.2S }, [X8], X18
    ADD  X8, X8, X10
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X8]
    LD3R { V27.1D, V28.1D, V29.1D }, [X8], X18
    ADD  X8, X8, X10, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X8]
    LD3R { V10.2S, V11.2S, V12.2S }, [X8], X18
    ADD  X8, X8, X10, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X8]
    LD3R { V10.4H, V11.4H, V12.4H }, [X8], X18
    ADD  X8, X8, X10, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X8]
    LD3R { V2.8B, V3.8B, V4.8B }, [X8], X18
    ADD  X8, X8, X10
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X25, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X25, FPSR
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V0.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D0
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V1.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D1
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V2.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D2
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V3.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D3
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V4.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D4
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V5.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D5
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V6.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D6
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D7
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D8
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D9
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D10
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D11
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D12
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V13.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D13
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V14.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D14
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D15
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V16.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D16
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V17.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D17
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V18.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D18
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V19.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D19
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V20.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D20
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D21
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D22
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V23.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D23
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V24.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D24
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V25.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D25
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V26.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D26
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D27
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D28
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D29
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V30.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D30
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, V31.D[1]
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    FMOV  X25, D31
    SUB  X2, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X20
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X15
    FMOV  D3, X3
    FMOV  V3.D[1], X29
    FMOV  D4, X25
    FMOV  V4.D[1], X18
    FMOV  D5, X16
    FMOV  V5.D[1], X20
    FMOV  D6, X29
    FMOV  V6.D[1], X13
    FMOV  D7, X11
    FMOV  V7.D[1], X8
    FMOV  D8, X12
    FMOV  V8.D[1], X7
    FMOV  D9, X24
    FMOV  V9.D[1], X12
    FMOV  D10, X16
    FMOV  V10.D[1], X14
    FMOV  D11, X20
    FMOV  V11.D[1], X8
    FMOV  D12, X24
    FMOV  V12.D[1], X12
    FMOV  D13, X18
    FMOV  V13.D[1], X28
    FMOV  D14, X3
    FMOV  V14.D[1], X13
    FMOV  D15, X9
    FMOV  V15.D[1], X28
    FMOV  D16, X27
    FMOV  V16.D[1], X13
    FMOV  D17, X16
    FMOV  V17.D[1], X4
    FMOV  D18, X12
    FMOV  V18.D[1], X13
    FMOV  D19, X2
    FMOV  V19.D[1], X9
    FMOV  D20, X18
    FMOV  V20.D[1], X24
    FMOV  D21, X21
    FMOV  V21.D[1], X20
    FMOV  D22, X3
    FMOV  V22.D[1], X29
    FMOV  D23, X11
    FMOV  V23.D[1], X3
    FMOV  D24, X3
    FMOV  V24.D[1], X19
    FMOV  D25, X17
    FMOV  V25.D[1], X27
    FMOV  D26, X13
    FMOV  V26.D[1], X16
    FMOV  D27, X27
    FMOV  V27.D[1], X29
    FMOV  D28, X29
    FMOV  V28.D[1], X11
    FMOV  D29, X14
    FMOV  V29.D[1], X2
    FMOV  D30, X2
    FMOV  V30.D[1], X18
    FMOV  D31, X3
    FMOV  V31.D[1], X11
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X18, #0x500, LSL #0
    ADD  X14, X30, X18, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X14]
    LD3R { V27.8H, V28.8H, V29.8H }, [X14]
    ADD  X14, X14, X24, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X14]
    LD3R { V5.16B, V6.16B, V7.16B }, [X14]
    ADD  X14, X14, X24
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X14]
    LD3R { V28.2D, V29.2D, V30.2D }, [X14]
    ADD  X14, X14, X24, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X14]
    LD3R { V14.4S, V15.4S, V16.4S }, [X14]
    ADD  X14, X14, X24, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X14]
    LD3R { V4.8H, V5.8H, V6.8H }, [X14]
    ADD  X14, X14, X24, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X14]
    LD3R { V20.4H, V21.4H, V22.4H }, [X14]
    ADD  X14, X14, X24, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X14]
    LD3R { V5.1D, V6.1D, V7.1D }, [X14]
    ADD  X14, X14, X24, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X14]
    LD3R { V4.2S, V5.2S, V6.2S }, [X14]
    ADD  X14, X14, X24, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X14]
    LD3R { V10.4H, V11.4H, V12.4H }, [X14]
    ADD  X14, X14, X24, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X14]
    LD3R { V13.8B, V14.8B, V15.8B }, [X14]
    ADD  X14, X14, X24
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X14]
    MOV  X15, X14
    LD3R { V24.2S, V25.2S, V26.2S }, [X15], #12
    ADD  X14, X14, X24, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X14]
    MOV  X15, X14
    LD3R { V5.2S, V6.2S, V7.2S }, [X15], #12
    ADD  X14, X14, X24, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X14]
    MOV  X15, X14
    LD3R { V10.4S, V11.4S, V12.4S }, [X15], #12
    ADD  X14, X14, X24, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X14]
    MOV  X15, X14
    LD3R { V30.2D, V31.2D, V0.2D }, [X15], #24
    ADD  X14, X14, X24
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X14]
    MOV  X15, X14
    LD3R { V5.1D, V6.1D, V7.1D }, [X15], #24
    ADD  X14, X14, X24, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X14]
    MOV  X15, X14
    LD3R { V10.2D, V11.2D, V12.2D }, [X15], #24
    ADD  X14, X14, X24, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X14]
    MOV  X15, X14
    LD3R { V26.8B, V27.8B, V28.8B }, [X15], #3
    ADD  X14, X14, X24
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X14]
    MOV  X15, X14
    LD3R { V0.16B, V1.16B, V2.16B }, [X15], #3
    ADD  X14, X14, X24
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X14]
    MOV  X15, X14
    LD3R { V19.8B, V20.8B, V21.8B }, [X15], #3
    ADD  X14, X14, X24, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X14]
    MOV  X15, X14
    LD3R { V27.4H, V28.4H, V29.4H }, [X15], #6
    ADD  X14, X14, X24
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X14]
    MOV  X15, X14
    LD3R { V16.8H, V17.8H, V18.8H }, [X15], #6
    ADD  X14, X14, X24, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X14]
    MOV  X15, X14
    LD3R { V19.8H, V20.8H, V21.8H }, [X15], #6
    ADD  X14, X14, X24, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X14]
    LD3R { V17.16B, V18.16B, V19.16B }, [X14], X2
    ADD  X14, X14, X24, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X14]
    LD3R { V17.16B, V18.16B, V19.16B }, [X14], X2
    ADD  X14, X14, X24
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X14]
    LD3R { V6.2D, V7.2D, V8.2D }, [X14], X2
    ADD  X14, X14, X24, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X14]
    LD3R { V3.4S, V4.4S, V5.4S }, [X14], X2
    ADD  X14, X14, X24, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X14]
    LD3R { V25.8H, V26.8H, V27.8H }, [X14], X2
    ADD  X14, X14, X24, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X14]
    LD3R { V17.4H, V18.4H, V19.4H }, [X14], X2
    ADD  X14, X14, X24, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X14]
    LD3R { V31.1D, V0.1D, V1.1D }, [X14], X2
    ADD  X14, X14, X24
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X14]
    LD3R { V13.2S, V14.2S, V15.2S }, [X14], X2
    ADD  X14, X14, X24, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X14]
    LD3R { V3.4H, V4.4H, V5.4H }, [X14], X2
    ADD  X14, X14, X24, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X14]
    LD3R { V29.8B, V30.8B, V31.8B }, [X14], X2
    ADD  X14, X14, X24, LSR #0
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X7, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D0
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D1
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V2.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D2
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D3
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D4
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D5
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V6.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D6
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V7.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D7
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V8.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D8
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V9.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D9
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D10
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D11
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V12.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D12
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D13
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D14
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D15
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V16.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D16
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D17
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D18
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D19
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V20.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D20
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V21.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D21
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D22
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V23.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D23
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D24
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V25.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D25
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V26.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D26
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, V27.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D27
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V28.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D28
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D29
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D30
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    FMOV  X7, D31
    SUB  X4, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
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
    FMOV  D1, X27
    FMOV  V1.D[1], X21
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X12
    FMOV  V3.D[1], X9
    FMOV  D4, X28
    FMOV  V4.D[1], X8
    FMOV  D5, X16
    FMOV  V5.D[1], X9
    FMOV  D6, X27
    FMOV  V6.D[1], X29
    FMOV  D7, X12
    FMOV  V7.D[1], X24
    FMOV  D8, X11
    FMOV  V8.D[1], X25
    FMOV  D9, X7
    FMOV  V9.D[1], X9
    FMOV  D10, X10
    FMOV  V10.D[1], X20
    FMOV  D11, X17
    FMOV  V11.D[1], X16
    FMOV  D12, X10
    FMOV  V12.D[1], X26
    FMOV  D13, X4
    FMOV  V13.D[1], X29
    FMOV  D14, X7
    FMOV  V14.D[1], X3
    FMOV  D15, X24
    FMOV  V15.D[1], X14
    FMOV  D16, X10
    FMOV  V16.D[1], X8
    FMOV  D17, X15
    FMOV  V17.D[1], X28
    FMOV  D18, X17
    FMOV  V18.D[1], X10
    FMOV  D19, X7
    FMOV  V19.D[1], X25
    FMOV  D20, X13
    FMOV  V20.D[1], X18
    FMOV  D21, X7
    FMOV  V21.D[1], X14
    FMOV  D22, X7
    FMOV  V22.D[1], X8
    FMOV  D23, X29
    FMOV  V23.D[1], X21
    FMOV  D24, X17
    FMOV  V24.D[1], X19
    FMOV  D25, X2
    FMOV  V25.D[1], X2
    FMOV  D26, X25
    FMOV  V26.D[1], X25
    FMOV  D27, X15
    FMOV  V27.D[1], X9
    FMOV  D28, X4
    FMOV  V28.D[1], X25
    FMOV  D29, X8
    FMOV  V29.D[1], X18
    FMOV  D30, X18
    FMOV  V30.D[1], X25
    FMOV  D31, X29
    FMOV  V31.D[1], X3
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X29, #0xa00, LSL #0
    ADD  X27, X30, X29, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X27]
    LD3R { V21.16B, V22.16B, V23.16B }, [X27]
    ADD  X27, X27, X2
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X27]
    LD3R { V1.16B, V2.16B, V3.16B }, [X27]
    ADD  X27, X27, X2, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X27]
    LD3R { V27.2D, V28.2D, V29.2D }, [X27]
    ADD  X27, X27, X2, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X27]
    LD3R { V20.4S, V21.4S, V22.4S }, [X27]
    ADD  X27, X27, X2, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X27]
    LD3R { V6.8H, V7.8H, V8.8H }, [X27]
    ADD  X27, X27, X2
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X27]
    LD3R { V9.8B, V10.8B, V11.8B }, [X27]
    ADD  X27, X27, X2
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X27]
    LD3R { V25.1D, V26.1D, V27.1D }, [X27]
    ADD  X27, X27, X2, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X27]
    LD3R { V16.2S, V17.2S, V18.2S }, [X27]
    ADD  X27, X27, X2, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X27]
    LD3R { V21.4H, V22.4H, V23.4H }, [X27]
    ADD  X27, X27, X2
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X27]
    LD3R { V25.8B, V26.8B, V27.8B }, [X27]
    ADD  X27, X27, X2
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X27]
    MOV  X8, X27
    LD3R { V28.2S, V29.2S, V30.2S }, [X8], #12
    ADD  X27, X27, X2, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X27]
    MOV  X8, X27
    LD3R { V13.2S, V14.2S, V15.2S }, [X8], #12
    ADD  X27, X27, X2
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X27]
    MOV  X8, X27
    LD3R { V29.4S, V30.4S, V31.4S }, [X8], #12
    ADD  X27, X27, X2, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X27]
    MOV  X8, X27
    LD3R { V28.1D, V29.1D, V30.1D }, [X8], #24
    ADD  X27, X27, X2, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X27]
    MOV  X8, X27
    LD3R { V3.1D, V4.1D, V5.1D }, [X8], #24
    ADD  X27, X27, X2
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X27]
    MOV  X8, X27
    LD3R { V7.2D, V8.2D, V9.2D }, [X8], #24
    ADD  X27, X27, X2, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X27]
    MOV  X8, X27
    LD3R { V18.16B, V19.16B, V20.16B }, [X8], #3
    ADD  X27, X27, X2, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X27]
    MOV  X8, X27
    LD3R { V21.16B, V22.16B, V23.16B }, [X8], #3
    ADD  X27, X27, X2, ASR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X27]
    MOV  X8, X27
    LD3R { V7.8B, V8.8B, V9.8B }, [X8], #3
    ADD  X27, X27, X2
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X27]
    MOV  X8, X27
    LD3R { V2.4H, V3.4H, V4.4H }, [X8], #6
    ADD  X27, X27, X2, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X27]
    MOV  X8, X27
    LD3R { V10.8H, V11.8H, V12.8H }, [X8], #6
    ADD  X27, X27, X2
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X27]
    MOV  X8, X27
    LD3R { V20.8H, V21.8H, V22.8H }, [X8], #6
    ADD  X27, X27, X2, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X27]
    LD3R { V6.8H, V7.8H, V8.8H }, [X27], X10
    ADD  X27, X27, X2
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X27]
    LD3R { V9.16B, V10.16B, V11.16B }, [X27], X10
    ADD  X27, X27, X2, LSR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X27]
    LD3R { V7.2D, V8.2D, V9.2D }, [X27], X10
    ADD  X27, X27, X2, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X27]
    LD3R { V5.4S, V6.4S, V7.4S }, [X27], X10
    ADD  X27, X27, X2, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X27]
    LD3R { V4.8H, V5.8H, V6.8H }, [X27], X10
    ADD  X27, X27, X2, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X27]
    LD3R { V21.1D, V22.1D, V23.1D }, [X27], X10
    ADD  X27, X27, X2, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X27]
    LD3R { V3.1D, V4.1D, V5.1D }, [X27], X10
    ADD  X27, X27, X2
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X27]
    LD3R { V20.2S, V21.2S, V22.2S }, [X27], X10
    ADD  X27, X27, X2
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X27]
    LD3R { V28.4H, V29.4H, V30.4H }, [X27], X10
    ADD  X27, X27, X2, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X27]
    LD3R { V16.8B, V17.8B, V18.8B }, [X27], X10
    ADD  X27, X27, X2, ASR #0
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X20, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X20, FPSR
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V0.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D0
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V1.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D1
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V2.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D2
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V3.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D3
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D4
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V5.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D5
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V6.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D6
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V7.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D7
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V8.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D8
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V9.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D9
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V10.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D10
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V11.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D11
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V12.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D12
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V13.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D13
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V14.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D14
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V15.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D15
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V16.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D16
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V17.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D17
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V18.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D18
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V19.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D19
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V20.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D20
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V21.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D21
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V22.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D22
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V23.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D23
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V24.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D24
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V25.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D25
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V26.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D26
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V27.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D27
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V28.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D28
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D29
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D30
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, V31.D[1]
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X20, D31
    SUB  X7, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X19
    FMOV  V3.D[1], X25
    FMOV  D4, X14
    FMOV  V4.D[1], X15
    FMOV  D5, X14
    FMOV  V5.D[1], X3
    FMOV  D6, X20
    FMOV  V6.D[1], X11
    FMOV  D7, X14
    FMOV  V7.D[1], X20
    FMOV  D8, X3
    FMOV  V8.D[1], X29
    FMOV  D9, X21
    FMOV  V9.D[1], X9
    FMOV  D10, X4
    FMOV  V10.D[1], X27
    FMOV  D11, X8
    FMOV  V11.D[1], X29
    FMOV  D12, X16
    FMOV  V12.D[1], X19
    FMOV  D13, X8
    FMOV  V13.D[1], X27
    FMOV  D14, X16
    FMOV  V14.D[1], X24
    FMOV  D15, X16
    FMOV  V15.D[1], X12
    FMOV  D16, X27
    FMOV  V16.D[1], X7
    FMOV  D17, X16
    FMOV  V17.D[1], X21
    FMOV  D18, X11
    FMOV  V18.D[1], X19
    FMOV  D19, X8
    FMOV  V19.D[1], X25
    FMOV  D20, X7
    FMOV  V20.D[1], X2
    FMOV  D21, X27
    FMOV  V21.D[1], X26
    FMOV  D22, X16
    FMOV  V22.D[1], X11
    FMOV  D23, X3
    FMOV  V23.D[1], X15
    FMOV  D24, X4
    FMOV  V24.D[1], X27
    FMOV  D25, X16
    FMOV  V25.D[1], X13
    FMOV  D26, X25
    FMOV  V26.D[1], X19
    FMOV  D27, X21
    FMOV  V27.D[1], X29
    FMOV  D28, X18
    FMOV  V28.D[1], X29
    FMOV  D29, X8
    FMOV  V29.D[1], X9
    FMOV  D30, X28
    FMOV  V30.D[1], X8
    FMOV  D31, X17
    FMOV  V31.D[1], X10
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X15, #0xf00, LSL #0
    ADD  X11, X30, X15, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X11]
    LD3R { V2.2D, V3.2D, V4.2D }, [X11]
    ADD  X11, X11, X12
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X11]
    LD3R { V0.16B, V1.16B, V2.16B }, [X11]
    ADD  X11, X11, X12
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X11]
    LD3R { V29.2D, V30.2D, V31.2D }, [X11]
    ADD  X11, X11, X12, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X11]
    LD3R { V26.4S, V27.4S, V28.4S }, [X11]
    ADD  X11, X11, X12
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X11]
    LD3R { V5.8H, V6.8H, V7.8H }, [X11]
    ADD  X11, X11, X12, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X11]
    LD3R { V6.8B, V7.8B, V8.8B }, [X11]
    ADD  X11, X11, X12
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X11]
    LD3R { V20.1D, V21.1D, V22.1D }, [X11]
    ADD  X11, X11, X12, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X11]
    LD3R { V3.2S, V4.2S, V5.2S }, [X11]
    ADD  X11, X11, X12, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X11]
    LD3R { V5.4H, V6.4H, V7.4H }, [X11]
    ADD  X11, X11, X12, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X11]
    LD3R { V30.8B, V31.8B, V0.8B }, [X11]
    ADD  X11, X11, X12
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X11]
    MOV  X19, X11
    LD3R { V26.2S, V27.2S, V28.2S }, [X19], #12
    ADD  X11, X11, X12, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X11]
    MOV  X19, X11
    LD3R { V6.2S, V7.2S, V8.2S }, [X19], #12
    ADD  X11, X11, X12, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X11]
    MOV  X19, X11
    LD3R { V18.4S, V19.4S, V20.4S }, [X19], #12
    ADD  X11, X11, X12, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X11]
    MOV  X19, X11
    LD3R { V31.2D, V0.2D, V1.2D }, [X19], #24
    ADD  X11, X11, X12, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X11]
    MOV  X19, X11
    LD3R { V12.1D, V13.1D, V14.1D }, [X19], #24
    ADD  X11, X11, X12
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X11]
    MOV  X19, X11
    LD3R { V0.2D, V1.2D, V2.2D }, [X19], #24
    ADD  X11, X11, X12, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X11]
    MOV  X19, X11
    LD3R { V6.16B, V7.16B, V8.16B }, [X19], #3
    ADD  X11, X11, X12
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X11]
    MOV  X19, X11
    LD3R { V15.16B, V16.16B, V17.16B }, [X19], #3
    ADD  X11, X11, X12, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X11]
    MOV  X19, X11
    LD3R { V7.8B, V8.8B, V9.8B }, [X19], #3
    ADD  X11, X11, X12, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X11]
    MOV  X19, X11
    LD3R { V11.4H, V12.4H, V13.4H }, [X19], #6
    ADD  X11, X11, X12, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X11]
    MOV  X19, X11
    LD3R { V25.8H, V26.8H, V27.8H }, [X19], #6
    ADD  X11, X11, X12, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X11]
    MOV  X19, X11
    LD3R { V29.4H, V30.4H, V31.4H }, [X19], #6
    ADD  X11, X11, X12
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X11]
    LD3R { V6.2D, V7.2D, V8.2D }, [X11], X2
    ADD  X11, X11, X12, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X11]
    LD3R { V16.16B, V17.16B, V18.16B }, [X11], X2
    ADD  X11, X11, X12, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X11]
    LD3R { V31.2D, V0.2D, V1.2D }, [X11], X2
    ADD  X11, X11, X12, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X11]
    LD3R { V7.4S, V8.4S, V9.4S }, [X11], X2
    ADD  X11, X11, X12, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X11]
    LD3R { V7.8H, V8.8H, V9.8H }, [X11], X2
    ADD  X11, X11, X12, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X11]
    LD3R { V16.2S, V17.2S, V18.2S }, [X11], X2
    ADD  X11, X11, X12, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X11]
    LD3R { V18.1D, V19.1D, V20.1D }, [X11], X2
    ADD  X11, X11, X12, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X11]
    LD3R { V31.2S, V0.2S, V1.2S }, [X11], X2
    ADD  X11, X11, X12
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X11]
    LD3R { V16.4H, V17.4H, V18.4H }, [X11], X2
    ADD  X11, X11, X12, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X11]
    LD3R { V24.8B, V25.8B, V26.8B }, [X11], X2
    ADD  X11, X11, X12, LSR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X13, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D0
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D1
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, V2.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D2
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D3
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D4
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D5
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, V6.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D6
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, V7.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D7
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, V8.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D8
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, V9.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D9
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, V10.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D10
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D11
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V12.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D12
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D13
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D14
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, V15.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D15
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D16
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D17
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D18
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D19
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D20
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D21
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D22
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, V23.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D23
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D24
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D25
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D26
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, V27.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D27
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D28
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D29
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D30
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X13, D31
    SUB  X10, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP03_TestFail
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
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X24
    FMOV  V2.D[1], X3
    FMOV  D3, X15
    FMOV  V3.D[1], X20
    FMOV  D4, X24
    FMOV  V4.D[1], X17
    FMOV  D5, X8
    FMOV  V5.D[1], X24
    FMOV  D6, X9
    FMOV  V6.D[1], X9
    FMOV  D7, X27
    FMOV  V7.D[1], X10
    FMOV  D8, X12
    FMOV  V8.D[1], X9
    FMOV  D9, X8
    FMOV  V9.D[1], X21
    FMOV  D10, X13
    FMOV  V10.D[1], X11
    FMOV  D11, X19
    FMOV  V11.D[1], X20
    FMOV  D12, X26
    FMOV  V12.D[1], X4
    FMOV  D13, X18
    FMOV  V13.D[1], X16
    FMOV  D14, X16
    FMOV  V14.D[1], X14
    FMOV  D15, X15
    FMOV  V15.D[1], X4
    FMOV  D16, X11
    FMOV  V16.D[1], X17
    FMOV  D17, X8
    FMOV  V17.D[1], X26
    FMOV  D18, X21
    FMOV  V18.D[1], X8
    FMOV  D19, X14
    FMOV  V19.D[1], X29
    FMOV  D20, X19
    FMOV  V20.D[1], X11
    FMOV  D21, X8
    FMOV  V21.D[1], X27
    FMOV  D22, X17
    FMOV  V22.D[1], X21
    FMOV  D23, X18
    FMOV  V23.D[1], X13
    FMOV  D24, X15
    FMOV  V24.D[1], X8
    FMOV  D25, X17
    FMOV  V25.D[1], X15
    FMOV  D26, X27
    FMOV  V26.D[1], X3
    FMOV  D27, X11
    FMOV  V27.D[1], X12
    FMOV  D28, X12
    FMOV  V28.D[1], X14
    FMOV  D29, X21
    FMOV  V29.D[1], X11
    FMOV  D30, X8
    FMOV  V30.D[1], X7
    FMOV  D31, X19
    FMOV  V31.D[1], X25
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X9, #0x40, LSL #0
    MOVZ  X13, #0x1400, LSL #0
    ADD  X12, X30, X13
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X12]
    LD3R { V6.4S, V7.4S, V8.4S }, [X12]
    ADD  X12, X12, X9, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X12]
    LD3R { V8.16B, V9.16B, V10.16B }, [X12]
    ADD  X12, X12, X9
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X12]
    LD3R { V27.2D, V28.2D, V29.2D }, [X12]
    ADD  X12, X12, X9
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X12]
    LD3R { V10.4S, V11.4S, V12.4S }, [X12]
    ADD  X12, X12, X9, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X12]
    LD3R { V28.8H, V29.8H, V30.8H }, [X12]
    ADD  X12, X12, X9
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X12]
    LD3R { V28.8B, V29.8B, V30.8B }, [X12]
    ADD  X12, X12, X9
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X12]
    LD3R { V19.1D, V20.1D, V21.1D }, [X12]
    ADD  X12, X12, X9
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X12]
    LD3R { V23.2S, V24.2S, V25.2S }, [X12]
    ADD  X12, X12, X9
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X12]
    LD3R { V29.4H, V30.4H, V31.4H }, [X12]
    ADD  X12, X12, X9
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X12]
    LD3R { V3.8B, V4.8B, V5.8B }, [X12]
    ADD  X12, X12, X9, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X12]
    MOV  X16, X12
    LD3R { V20.4S, V21.4S, V22.4S }, [X16], #12
    ADD  X12, X12, X9
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X12]
    MOV  X16, X12
    LD3R { V22.2S, V23.2S, V24.2S }, [X16], #12
    ADD  X12, X12, X9
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X12]
    MOV  X16, X12
    LD3R { V28.4S, V29.4S, V30.4S }, [X16], #12
    ADD  X12, X12, X9, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X12]
    MOV  X16, X12
    LD3R { V21.2D, V22.2D, V23.2D }, [X16], #24
    ADD  X12, X12, X9, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X12]
    MOV  X16, X12
    LD3R { V31.1D, V0.1D, V1.1D }, [X16], #24
    ADD  X12, X12, X9, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X12]
    MOV  X16, X12
    LD3R { V14.2D, V15.2D, V16.2D }, [X16], #24
    ADD  X12, X12, X9, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X12]
    MOV  X16, X12
    LD3R { V31.8B, V0.8B, V1.8B }, [X16], #3
    ADD  X12, X12, X9, ASR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X12]
    MOV  X16, X12
    LD3R { V20.16B, V21.16B, V22.16B }, [X16], #3
    ADD  X12, X12, X9, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X12]
    MOV  X16, X12
    LD3R { V31.8B, V0.8B, V1.8B }, [X16], #3
    ADD  X12, X12, X9, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X12]
    MOV  X16, X12
    LD3R { V26.4H, V27.4H, V28.4H }, [X16], #6
    ADD  X12, X12, X9
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X12]
    MOV  X16, X12
    LD3R { V12.8H, V13.8H, V14.8H }, [X16], #6
    ADD  X12, X12, X9, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X12]
    MOV  X16, X12
    LD3R { V8.8H, V9.8H, V10.8H }, [X16], #6
    ADD  X12, X12, X9, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X12]
    LD3R { V13.8H, V14.8H, V15.8H }, [X12], X14
    ADD  X12, X12, X9
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X12]
    LD3R { V29.16B, V30.16B, V31.16B }, [X12], X14
    ADD  X12, X12, X9
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X12]
    LD3R { V29.2D, V30.2D, V31.2D }, [X12], X14
    ADD  X12, X12, X9, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X12]
    LD3R { V23.4S, V24.4S, V25.4S }, [X12], X14
    ADD  X12, X12, X9, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X12]
    LD3R { V26.8H, V27.8H, V28.8H }, [X12], X14
    ADD  X12, X12, X9, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X12]
    LD3R { V14.1D, V15.1D, V16.1D }, [X12], X14
    ADD  X12, X12, X9
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X12]
    LD3R { V29.1D, V30.1D, V31.1D }, [X12], X14
    ADD  X12, X12, X9, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X12]
    LD3R { V25.2S, V26.2S, V27.2S }, [X12], X14
    ADD  X12, X12, X9, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X12]
    LD3R { V13.4H, V14.4H, V15.4H }, [X12], X14
    ADD  X12, X12, X9, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X12]
    LD3R { V25.8B, V26.8B, V27.8B }, [X12], X14
    ADD  X12, X12, X9
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V0.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D0
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V1.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D3
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D5
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D6
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V9.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D10
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V11.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D11
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V12.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D15
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D16
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D17
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D18
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V19.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V20.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V21.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V22.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V23.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V24.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D24
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D25
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V29.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V31.D[1]
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X26, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X21
    FMOV  V2.D[1], X29
    FMOV  D3, X26
    FMOV  V3.D[1], X12
    FMOV  D4, X28
    FMOV  V4.D[1], X14
    FMOV  D5, X15
    FMOV  V5.D[1], X17
    FMOV  D6, X25
    FMOV  V6.D[1], X8
    FMOV  D7, X7
    FMOV  V7.D[1], X2
    FMOV  D8, X16
    FMOV  V8.D[1], X25
    FMOV  D9, X29
    FMOV  V9.D[1], X15
    FMOV  D10, X28
    FMOV  V10.D[1], X25
    FMOV  D11, X7
    FMOV  V11.D[1], X24
    FMOV  D12, X24
    FMOV  V12.D[1], X28
    FMOV  D13, X21
    FMOV  V13.D[1], X19
    FMOV  D14, X7
    FMOV  V14.D[1], X16
    FMOV  D15, X16
    FMOV  V15.D[1], X25
    FMOV  D16, X2
    FMOV  V16.D[1], X24
    FMOV  D17, X14
    FMOV  V17.D[1], X19
    FMOV  D18, X27
    FMOV  V18.D[1], X2
    FMOV  D19, X12
    FMOV  V19.D[1], X16
    FMOV  D20, X25
    FMOV  V20.D[1], X4
    FMOV  D21, X11
    FMOV  V21.D[1], X18
    FMOV  D22, X28
    FMOV  V22.D[1], X10
    FMOV  D23, X4
    FMOV  V23.D[1], X19
    FMOV  D24, X3
    FMOV  V24.D[1], X14
    FMOV  D25, X12
    FMOV  V25.D[1], X13
    FMOV  D26, X18
    FMOV  V26.D[1], X16
    FMOV  D27, X4
    FMOV  V27.D[1], X9
    FMOV  D28, X10
    FMOV  V28.D[1], X25
    FMOV  D29, X20
    FMOV  V29.D[1], X20
    FMOV  D30, X24
    FMOV  V30.D[1], X21
    FMOV  D31, X26
    FMOV  V31.D[1], X15
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X10, #0x1900, LSL #0
    ADD  X8, X30, X10, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X8]
    LD3R { V9.16B, V10.16B, V11.16B }, [X8]
    ADD  X8, X8, X28, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X8]
    LD3R { V11.16B, V12.16B, V13.16B }, [X8]
    ADD  X8, X8, X28
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X8]
    LD3R { V15.2D, V16.2D, V17.2D }, [X8]
    ADD  X8, X8, X28, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X8]
    LD3R { V10.4S, V11.4S, V12.4S }, [X8]
    ADD  X8, X8, X28
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X8]
    LD3R { V0.8H, V1.8H, V2.8H }, [X8]
    ADD  X8, X8, X28
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X8]
    LD3R { V9.2S, V10.2S, V11.2S }, [X8]
    ADD  X8, X8, X28, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X8]
    LD3R { V26.1D, V27.1D, V28.1D }, [X8]
    ADD  X8, X8, X28, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X8]
    LD3R { V17.2S, V18.2S, V19.2S }, [X8]
    ADD  X8, X8, X28, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X8]
    LD3R { V4.4H, V5.4H, V6.4H }, [X8]
    ADD  X8, X8, X28, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X8]
    LD3R { V7.8B, V8.8B, V9.8B }, [X8]
    ADD  X8, X8, X28
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X8]
    MOV  X4, X8
    LD3R { V10.2S, V11.2S, V12.2S }, [X4], #12
    ADD  X8, X8, X28, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X8]
    MOV  X4, X8
    LD3R { V13.2S, V14.2S, V15.2S }, [X4], #12
    ADD  X8, X8, X28
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X8]
    MOV  X4, X8
    LD3R { V31.4S, V0.4S, V1.4S }, [X4], #12
    ADD  X8, X8, X28
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X8]
    MOV  X4, X8
    LD3R { V5.1D, V6.1D, V7.1D }, [X4], #24
    ADD  X8, X8, X28
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X8]
    MOV  X4, X8
    LD3R { V3.1D, V4.1D, V5.1D }, [X4], #24
    ADD  X8, X8, X28
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X8]
    MOV  X4, X8
    LD3R { V3.2D, V4.2D, V5.2D }, [X4], #24
    ADD  X8, X8, X28, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X8]
    MOV  X4, X8
    LD3R { V20.8B, V21.8B, V22.8B }, [X4], #3
    ADD  X8, X8, X28
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X8]
    MOV  X4, X8
    LD3R { V10.16B, V11.16B, V12.16B }, [X4], #3
    ADD  X8, X8, X28, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X8]
    MOV  X4, X8
    LD3R { V15.8B, V16.8B, V17.8B }, [X4], #3
    ADD  X8, X8, X28, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X8]
    MOV  X4, X8
    LD3R { V28.4H, V29.4H, V30.4H }, [X4], #6
    ADD  X8, X8, X28
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X8]
    MOV  X4, X8
    LD3R { V11.8H, V12.8H, V13.8H }, [X4], #6
    ADD  X8, X8, X28, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X8]
    MOV  X4, X8
    LD3R { V23.4H, V24.4H, V25.4H }, [X4], #6
    ADD  X8, X8, X28, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X8]
    LD3R { V7.2D, V8.2D, V9.2D }, [X8], X20
    ADD  X8, X8, X28, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X8]
    LD3R { V15.16B, V16.16B, V17.16B }, [X8], X20
    ADD  X8, X8, X28, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X8]
    LD3R { V15.2D, V16.2D, V17.2D }, [X8], X20
    ADD  X8, X8, X28, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X8]
    LD3R { V6.4S, V7.4S, V8.4S }, [X8], X20
    ADD  X8, X8, X28, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X8]
    LD3R { V20.8H, V21.8H, V22.8H }, [X8], X20
    ADD  X8, X8, X28, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X8]
    LD3R { V8.4H, V9.4H, V10.4H }, [X8], X20
    ADD  X8, X8, X28, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X8]
    LD3R { V17.1D, V18.1D, V19.1D }, [X8], X20
    ADD  X8, X8, X28
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X8]
    LD3R { V2.2S, V3.2S, V4.2S }, [X8], X20
    ADD  X8, X8, X28
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X8]
    LD3R { V22.4H, V23.4H, V24.4H }, [X8], X20
    ADD  X8, X8, X28
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X8]
    LD3R { V11.8B, V12.8B, V13.8B }, [X8], X20
    ADD  X8, X8, X28, ASR #0
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X15, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    MRS  X15, FPSR
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V0.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D0
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V1.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D1
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D2
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D3
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D4
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V5.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D5
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V6.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D6
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V7.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D7
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D8
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V9.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D9
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V10.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D10
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D11
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D12
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D13
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V14.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D14
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V15.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D15
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V16.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D16
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D17
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D18
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V19.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D19
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V20.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D20
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V21.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D21
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V22.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D22
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D23
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D24
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D25
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D26
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D27
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D28
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V29.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D29
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X15, V30.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D30
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, V31.D[1]
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X15, D31
    SUB  X14, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
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
    FMOV  D2, X4
    FMOV  V2.D[1], X3
    FMOV  D3, X16
    FMOV  V3.D[1], X14
    FMOV  D4, X20
    FMOV  V4.D[1], X4
    FMOV  D5, X25
    FMOV  V5.D[1], X10
    FMOV  D6, X2
    FMOV  V6.D[1], X2
    FMOV  D7, X16
    FMOV  V7.D[1], X10
    FMOV  D8, X19
    FMOV  V8.D[1], X3
    FMOV  D9, X27
    FMOV  V9.D[1], X14
    FMOV  D10, X7
    FMOV  V10.D[1], X21
    FMOV  D11, X17
    FMOV  V11.D[1], X4
    FMOV  D12, X26
    FMOV  V12.D[1], X18
    FMOV  D13, X3
    FMOV  V13.D[1], X9
    FMOV  D14, X12
    FMOV  V14.D[1], X11
    FMOV  D15, X4
    FMOV  V15.D[1], X26
    FMOV  D16, X7
    FMOV  V16.D[1], X26
    FMOV  D17, X28
    FMOV  V17.D[1], X21
    FMOV  D18, X26
    FMOV  V18.D[1], X17
    FMOV  D19, X13
    FMOV  V19.D[1], X20
    FMOV  D20, X4
    FMOV  V20.D[1], X14
    FMOV  D21, X24
    FMOV  V21.D[1], X28
    FMOV  D22, X4
    FMOV  V22.D[1], X19
    FMOV  D23, X3
    FMOV  V23.D[1], X21
    FMOV  D24, X4
    FMOV  V24.D[1], X27
    FMOV  D25, X9
    FMOV  V25.D[1], X7
    FMOV  D26, X4
    FMOV  V26.D[1], X24
    FMOV  D27, X29
    FMOV  V27.D[1], X9
    FMOV  D28, X28
    FMOV  V28.D[1], X15
    FMOV  D29, X26
    FMOV  V29.D[1], X20
    FMOV  D30, X2
    FMOV  V30.D[1], X14
    FMOV  D31, X14
    FMOV  V31.D[1], X16
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X26, #0x1e00, LSL #0
    ADD  X4, X30, X26, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X4]
    LD3R { V30.4S, V31.4S, V0.4S }, [X4]
    ADD  X4, X4, X7
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X4]
    LD3R { V28.16B, V29.16B, V30.16B }, [X4]
    ADD  X4, X4, X7, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X4]
    LD3R { V26.2D, V27.2D, V28.2D }, [X4]
    ADD  X4, X4, X7
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X4]
    LD3R { V10.4S, V11.4S, V12.4S }, [X4]
    ADD  X4, X4, X7
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X4]
    LD3R { V14.8H, V15.8H, V16.8H }, [X4]
    ADD  X4, X4, X7
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X4]
    LD3R { V17.8B, V18.8B, V19.8B }, [X4]
    ADD  X4, X4, X7, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X4]
    LD3R { V3.1D, V4.1D, V5.1D }, [X4]
    ADD  X4, X4, X7
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X4]
    LD3R { V4.2S, V5.2S, V6.2S }, [X4]
    ADD  X4, X4, X7
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X4]
    LD3R { V25.4H, V26.4H, V27.4H }, [X4]
    ADD  X4, X4, X7, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X4]
    LD3R { V17.8B, V18.8B, V19.8B }, [X4]
    ADD  X4, X4, X7, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X4]
    MOV  X11, X4
    LD3R { V4.2S, V5.2S, V6.2S }, [X11], #12
    ADD  X4, X4, X7, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X4]
    MOV  X11, X4
    LD3R { V9.2S, V10.2S, V11.2S }, [X11], #12
    ADD  X4, X4, X7, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X4]
    MOV  X11, X4
    LD3R { V18.4S, V19.4S, V20.4S }, [X11], #12
    ADD  X4, X4, X7, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X4]
    MOV  X11, X4
    LD3R { V24.1D, V25.1D, V26.1D }, [X11], #24
    ADD  X4, X4, X7
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X4]
    MOV  X11, X4
    LD3R { V16.1D, V17.1D, V18.1D }, [X11], #24
    ADD  X4, X4, X7
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X4]
    MOV  X11, X4
    LD3R { V21.2D, V22.2D, V23.2D }, [X11], #24
    ADD  X4, X4, X7, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X4]
    MOV  X11, X4
    LD3R { V30.8B, V31.8B, V0.8B }, [X11], #3
    ADD  X4, X4, X7, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X4]
    MOV  X11, X4
    LD3R { V9.16B, V10.16B, V11.16B }, [X11], #3
    ADD  X4, X4, X7, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X4]
    MOV  X11, X4
    LD3R { V26.8B, V27.8B, V28.8B }, [X11], #3
    ADD  X4, X4, X7
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X4]
    MOV  X11, X4
    LD3R { V3.4H, V4.4H, V5.4H }, [X11], #6
    ADD  X4, X4, X7, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X4]
    MOV  X11, X4
    LD3R { V6.8H, V7.8H, V8.8H }, [X11], #6
    ADD  X4, X4, X7, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X4]
    MOV  X11, X4
    LD3R { V13.4H, V14.4H, V15.4H }, [X11], #6
    ADD  X4, X4, X7
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X4]
    LD3R { V20.4S, V21.4S, V22.4S }, [X4], X3
    ADD  X4, X4, X7
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X4]
    LD3R { V15.16B, V16.16B, V17.16B }, [X4], X3
    ADD  X4, X4, X7, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X4]
    LD3R { V0.2D, V1.2D, V2.2D }, [X4], X3
    ADD  X4, X4, X7, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X4]
    LD3R { V11.4S, V12.4S, V13.4S }, [X4], X3
    ADD  X4, X4, X7, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X4]
    LD3R { V4.8H, V5.8H, V6.8H }, [X4], X3
    ADD  X4, X4, X7, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X4]
    LD3R { V23.1D, V24.1D, V25.1D }, [X4], X3
    ADD  X4, X4, X7
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X4]
    LD3R { V12.1D, V13.1D, V14.1D }, [X4], X3
    ADD  X4, X4, X7, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X4]
    LD3R { V27.2S, V28.2S, V29.2S }, [X4], X3
    ADD  X4, X4, X7, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X4]
    LD3R { V10.4H, V11.4H, V12.4H }, [X4], X3
    ADD  X4, X4, X7
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X4]
    LD3R { V14.8B, V15.8B, V16.8B }, [X4], X3
    ADD  X4, X4, X7, LSR #0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X16, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D0
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D1
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V2.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D2
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D3
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D4
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D5
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V6.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D6
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V7.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D7
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D8
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D9
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D10
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D11
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D12
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D13
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D14
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D15
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D16
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V17.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D17
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D18
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V19.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D19
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V20.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D20
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D21
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D22
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D23
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D24
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D25
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D26
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D27
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D28
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D29
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D30
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X16, D31
    SUB  X27, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X20
    FMOV  D4, X21
    FMOV  V4.D[1], X12
    FMOV  D5, X3
    FMOV  V5.D[1], X16
    FMOV  D6, X8
    FMOV  V6.D[1], X15
    FMOV  D7, X15
    FMOV  V7.D[1], X11
    FMOV  D8, X27
    FMOV  V8.D[1], X9
    FMOV  D9, X16
    FMOV  V9.D[1], X12
    FMOV  D10, X16
    FMOV  V10.D[1], X20
    FMOV  D11, X2
    FMOV  V11.D[1], X26
    FMOV  D12, X7
    FMOV  V12.D[1], X7
    FMOV  D13, X4
    FMOV  V13.D[1], X25
    FMOV  D14, X24
    FMOV  V14.D[1], X24
    FMOV  D15, X20
    FMOV  V15.D[1], X27
    FMOV  D16, X24
    FMOV  V16.D[1], X15
    FMOV  D17, X28
    FMOV  V17.D[1], X14
    FMOV  D18, X16
    FMOV  V18.D[1], X29
    FMOV  D19, X28
    FMOV  V19.D[1], X16
    FMOV  D20, X15
    FMOV  V20.D[1], X21
    FMOV  D21, X25
    FMOV  V21.D[1], X16
    FMOV  D22, X16
    FMOV  V22.D[1], X21
    FMOV  D23, X3
    FMOV  V23.D[1], X7
    FMOV  D24, X16
    FMOV  V24.D[1], X12
    FMOV  D25, X9
    FMOV  V25.D[1], X10
    FMOV  D26, X29
    FMOV  V26.D[1], X29
    FMOV  D27, X24
    FMOV  V27.D[1], X7
    FMOV  D28, X8
    FMOV  V28.D[1], X18
    FMOV  D29, X14
    FMOV  V29.D[1], X2
    FMOV  D30, X28
    FMOV  V30.D[1], X10
    FMOV  D31, X19
    FMOV  V31.D[1], X16
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X13, #0x2300, LSL #0
    ADD  X4, X30, X13, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X4]
    LD3R { V17.8H, V18.8H, V19.8H }, [X4]
    ADD  X4, X4, X8, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X4]
    LD3R { V22.16B, V23.16B, V24.16B }, [X4]
    ADD  X4, X4, X8, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X4]
    LD3R { V10.2D, V11.2D, V12.2D }, [X4]
    ADD  X4, X4, X8
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X4]
    LD3R { V18.4S, V19.4S, V20.4S }, [X4]
    ADD  X4, X4, X8, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X4]
    LD3R { V30.8H, V31.8H, V0.8H }, [X4]
    ADD  X4, X4, X8, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X4]
    LD3R { V20.8B, V21.8B, V22.8B }, [X4]
    ADD  X4, X4, X8, LSR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X4]
    LD3R { V30.1D, V31.1D, V0.1D }, [X4]
    ADD  X4, X4, X8, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X4]
    LD3R { V9.2S, V10.2S, V11.2S }, [X4]
    ADD  X4, X4, X8, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X4]
    LD3R { V11.4H, V12.4H, V13.4H }, [X4]
    ADD  X4, X4, X8
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X4]
    LD3R { V17.8B, V18.8B, V19.8B }, [X4]
    ADD  X4, X4, X8
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X4]
    MOV  X18, X4
    LD3R { V10.4S, V11.4S, V12.4S }, [X18], #12
    ADD  X4, X4, X8, LSR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X4]
    MOV  X18, X4
    LD3R { V31.2S, V0.2S, V1.2S }, [X18], #12
    ADD  X4, X4, X8
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X4]
    MOV  X18, X4
    LD3R { V5.4S, V6.4S, V7.4S }, [X18], #12
    ADD  X4, X4, X8, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X4]
    MOV  X18, X4
    LD3R { V11.1D, V12.1D, V13.1D }, [X18], #24
    ADD  X4, X4, X8, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X4]
    MOV  X18, X4
    LD3R { V16.1D, V17.1D, V18.1D }, [X18], #24
    ADD  X4, X4, X8, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X4]
    MOV  X18, X4
    LD3R { V31.2D, V0.2D, V1.2D }, [X18], #24
    ADD  X4, X4, X8
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X4]
    MOV  X18, X4
    LD3R { V29.16B, V30.16B, V31.16B }, [X18], #3
    ADD  X4, X4, X8, ASR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X4]
    MOV  X18, X4
    LD3R { V23.16B, V24.16B, V25.16B }, [X18], #3
    ADD  X4, X4, X8
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X4]
    MOV  X18, X4
    LD3R { V8.8B, V9.8B, V10.8B }, [X18], #3
    ADD  X4, X4, X8, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X4]
    MOV  X18, X4
    LD3R { V12.4H, V13.4H, V14.4H }, [X18], #6
    ADD  X4, X4, X8, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X4]
    MOV  X18, X4
    LD3R { V19.8H, V20.8H, V21.8H }, [X18], #6
    ADD  X4, X4, X8, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X4]
    MOV  X18, X4
    LD3R { V29.8H, V30.8H, V31.8H }, [X18], #6
    ADD  X4, X4, X8
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X4]
    LD3R { V23.16B, V24.16B, V25.16B }, [X4], X7
    ADD  X4, X4, X8
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X4]
    LD3R { V9.16B, V10.16B, V11.16B }, [X4], X7
    ADD  X4, X4, X8
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X4]
    LD3R { V5.2D, V6.2D, V7.2D }, [X4], X7
    ADD  X4, X4, X8, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X4]
    LD3R { V11.4S, V12.4S, V13.4S }, [X4], X7
    ADD  X4, X4, X8, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X4]
    LD3R { V13.8H, V14.8H, V15.8H }, [X4], X7
    ADD  X4, X4, X8, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X4]
    LD3R { V26.2S, V27.2S, V28.2S }, [X4], X7
    ADD  X4, X4, X8
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X4]
    LD3R { V23.1D, V24.1D, V25.1D }, [X4], X7
    ADD  X4, X4, X8, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X4]
    LD3R { V23.2S, V24.2S, V25.2S }, [X4], X7
    ADD  X4, X4, X8, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X4]
    LD3R { V7.4H, V8.4H, V9.4H }, [X4], X7
    ADD  X4, X4, X8, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X4]
    LD3R { V6.8B, V7.8B, V8.8B }, [X4], X7
    ADD  X4, X4, X8, LSR #0
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V0.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D0
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V1.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D1
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V2.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D2
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V3.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D3
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V4.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D4
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D5
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D6
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D7
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D8
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V9.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D9
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D10
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D11
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V12.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D12
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D13
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V14.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D14
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V15.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D15
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D16
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D18
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V19.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D19
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V20.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D20
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V21.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D21
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D22
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D23
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D24
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D25
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D26
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D27
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D28
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V29.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D29
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D30
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X28, D31
    SUB  X17, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X18
    FMOV  D3, X9
    FMOV  V3.D[1], X20
    FMOV  D4, X16
    FMOV  V4.D[1], X13
    FMOV  D5, X27
    FMOV  V5.D[1], X16
    FMOV  D6, X18
    FMOV  V6.D[1], X16
    FMOV  D7, X20
    FMOV  V7.D[1], X10
    FMOV  D8, X2
    FMOV  V8.D[1], X10
    FMOV  D9, X3
    FMOV  V9.D[1], X21
    FMOV  D10, X18
    FMOV  V10.D[1], X18
    FMOV  D11, X8
    FMOV  V11.D[1], X25
    FMOV  D12, X8
    FMOV  V12.D[1], X28
    FMOV  D13, X20
    FMOV  V13.D[1], X29
    FMOV  D14, X21
    FMOV  V14.D[1], X8
    FMOV  D15, X25
    FMOV  V15.D[1], X3
    FMOV  D16, X13
    FMOV  V16.D[1], X2
    FMOV  D17, X15
    FMOV  V17.D[1], X25
    FMOV  D18, X14
    FMOV  V18.D[1], X21
    FMOV  D19, X12
    FMOV  V19.D[1], X13
    FMOV  D20, X16
    FMOV  V20.D[1], X11
    FMOV  D21, X24
    FMOV  V21.D[1], X9
    FMOV  D22, X19
    FMOV  V22.D[1], X12
    FMOV  D23, X16
    FMOV  V23.D[1], X21
    FMOV  D24, X17
    FMOV  V24.D[1], X12
    FMOV  D25, X9
    FMOV  V25.D[1], X9
    FMOV  D26, X17
    FMOV  V26.D[1], X18
    FMOV  D27, X3
    FMOV  V27.D[1], X2
    FMOV  D28, X18
    FMOV  V28.D[1], X21
    FMOV  D29, X10
    FMOV  V29.D[1], X8
    FMOV  D30, X16
    FMOV  V30.D[1], X7
    FMOV  D31, X10
    FMOV  V31.D[1], X26
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X28, #0x2800, LSL #0
    ADD  X27, X30, X28, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X27]
    LD3R { V27.8H, V28.8H, V29.8H }, [X27]
    ADD  X27, X27, X4, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X27]
    LD3R { V28.16B, V29.16B, V30.16B }, [X27]
    ADD  X27, X27, X4, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X27]
    LD3R { V4.2D, V5.2D, V6.2D }, [X27]
    ADD  X27, X27, X4
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X27]
    LD3R { V17.4S, V18.4S, V19.4S }, [X27]
    ADD  X27, X27, X4
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X27]
    LD3R { V23.8H, V24.8H, V25.8H }, [X27]
    ADD  X27, X27, X4, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X27]
    LD3R { V30.2S, V31.2S, V0.2S }, [X27]
    ADD  X27, X27, X4
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X27]
    LD3R { V21.1D, V22.1D, V23.1D }, [X27]
    ADD  X27, X27, X4
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X27]
    LD3R { V20.2S, V21.2S, V22.2S }, [X27]
    ADD  X27, X27, X4, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X27]
    LD3R { V0.4H, V1.4H, V2.4H }, [X27]
    ADD  X27, X27, X4, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X27]
    LD3R { V8.8B, V9.8B, V10.8B }, [X27]
    ADD  X27, X27, X4, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X27]
    MOV  X26, X27
    LD3R { V25.2S, V26.2S, V27.2S }, [X26], #12
    ADD  X27, X27, X4, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X27]
    MOV  X26, X27
    LD3R { V7.2S, V8.2S, V9.2S }, [X26], #12
    ADD  X27, X27, X4, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X27]
    MOV  X26, X27
    LD3R { V1.4S, V2.4S, V3.4S }, [X26], #12
    ADD  X27, X27, X4, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X27]
    MOV  X26, X27
    LD3R { V4.1D, V5.1D, V6.1D }, [X26], #24
    ADD  X27, X27, X4
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X27]
    MOV  X26, X27
    LD3R { V14.1D, V15.1D, V16.1D }, [X26], #24
    ADD  X27, X27, X4, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X27]
    MOV  X26, X27
    LD3R { V19.2D, V20.2D, V21.2D }, [X26], #24
    ADD  X27, X27, X4, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X27]
    MOV  X26, X27
    LD3R { V6.16B, V7.16B, V8.16B }, [X26], #3
    ADD  X27, X27, X4, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X27]
    MOV  X26, X27
    LD3R { V5.16B, V6.16B, V7.16B }, [X26], #3
    ADD  X27, X27, X4
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X27]
    MOV  X26, X27
    LD3R { V7.8B, V8.8B, V9.8B }, [X26], #3
    ADD  X27, X27, X4, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X27]
    MOV  X26, X27
    LD3R { V6.4H, V7.4H, V8.4H }, [X26], #6
    ADD  X27, X27, X4
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X27]
    MOV  X26, X27
    LD3R { V22.8H, V23.8H, V24.8H }, [X26], #6
    ADD  X27, X27, X4
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X27]
    MOV  X26, X27
    LD3R { V21.4H, V22.4H, V23.4H }, [X26], #6
    ADD  X27, X27, X4, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X27]
    LD3R { V22.2D, V23.2D, V24.2D }, [X27], X16
    ADD  X27, X27, X4, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X27]
    LD3R { V28.16B, V29.16B, V30.16B }, [X27], X16
    ADD  X27, X27, X4, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X27]
    LD3R { V4.2D, V5.2D, V6.2D }, [X27], X16
    ADD  X27, X27, X4, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X27]
    LD3R { V18.4S, V19.4S, V20.4S }, [X27], X16
    ADD  X27, X27, X4, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X27]
    LD3R { V24.8H, V25.8H, V26.8H }, [X27], X16
    ADD  X27, X27, X4, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X27]
    LD3R { V3.2S, V4.2S, V5.2S }, [X27], X16
    ADD  X27, X27, X4, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X27]
    LD3R { V13.1D, V14.1D, V15.1D }, [X27], X16
    ADD  X27, X27, X4, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X27]
    LD3R { V30.2S, V31.2S, V0.2S }, [X27], X16
    ADD  X27, X27, X4, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X27]
    LD3R { V15.4H, V16.4H, V17.4H }, [X27], X16
    ADD  X27, X27, X4, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X27]
    LD3R { V30.8B, V31.8B, V0.8B }, [X27], X16
    ADD  X27, X27, X4, ASR #0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X18, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V1.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D1
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D2
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D3
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D4
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D5
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D6
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D7
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D8
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D9
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D10
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D11
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D12
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D13
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D14
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D15
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D16
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D17
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V18.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D18
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D19
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V20.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D20
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D21
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V22.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D22
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V23.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D23
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V24.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D24
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V25.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D25
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V26.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D26
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D27
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D28
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, V29.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D29
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X18, D31
    SUB  X3, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
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
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X17
    FMOV  D3, X16
    FMOV  V3.D[1], X26
    FMOV  D4, X10
    FMOV  V4.D[1], X19
    FMOV  D5, X4
    FMOV  V5.D[1], X18
    FMOV  D6, X16
    FMOV  V6.D[1], X11
    FMOV  D7, X27
    FMOV  V7.D[1], X29
    FMOV  D8, X3
    FMOV  V8.D[1], X19
    FMOV  D9, X3
    FMOV  V9.D[1], X28
    FMOV  D10, X28
    FMOV  V10.D[1], X26
    FMOV  D11, X28
    FMOV  V11.D[1], X20
    FMOV  D12, X14
    FMOV  V12.D[1], X12
    FMOV  D13, X25
    FMOV  V13.D[1], X27
    FMOV  D14, X16
    FMOV  V14.D[1], X19
    FMOV  D15, X21
    FMOV  V15.D[1], X21
    FMOV  D16, X9
    FMOV  V16.D[1], X11
    FMOV  D17, X25
    FMOV  V17.D[1], X13
    FMOV  D18, X26
    FMOV  V18.D[1], X9
    FMOV  D19, X3
    FMOV  V19.D[1], X16
    FMOV  D20, X2
    FMOV  V20.D[1], X20
    FMOV  D21, X18
    FMOV  V21.D[1], X14
    FMOV  D22, X8
    FMOV  V22.D[1], X29
    FMOV  D23, X28
    FMOV  V23.D[1], X21
    FMOV  D24, X18
    FMOV  V24.D[1], X29
    FMOV  D25, X16
    FMOV  V25.D[1], X2
    FMOV  D26, X29
    FMOV  V26.D[1], X28
    FMOV  D27, X4
    FMOV  V27.D[1], X25
    FMOV  D28, X29
    FMOV  V28.D[1], X14
    FMOV  D29, X7
    FMOV  V29.D[1], X24
    FMOV  D30, X13
    FMOV  V30.D[1], X24
    FMOV  D31, X21
    FMOV  V31.D[1], X19
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X27, #0x2d00, LSL #0
    ADD  X3, X30, X27, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X3]
    LD3R { V9.4S, V10.4S, V11.4S }, [X3]
    ADD  X3, X3, X20, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X3]
    LD3R { V6.16B, V7.16B, V8.16B }, [X3]
    ADD  X3, X3, X20, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X3]
    LD3R { V6.2D, V7.2D, V8.2D }, [X3]
    ADD  X3, X3, X20, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X3]
    LD3R { V6.4S, V7.4S, V8.4S }, [X3]
    ADD  X3, X3, X20, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X3]
    LD3R { V30.8H, V31.8H, V0.8H }, [X3]
    ADD  X3, X3, X20, ASR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X3]
    LD3R { V26.1D, V27.1D, V28.1D }, [X3]
    ADD  X3, X3, X20, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X3]
    LD3R { V13.1D, V14.1D, V15.1D }, [X3]
    ADD  X3, X3, X20
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X3]
    LD3R { V2.2S, V3.2S, V4.2S }, [X3]
    ADD  X3, X3, X20, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X3]
    LD3R { V16.4H, V17.4H, V18.4H }, [X3]
    ADD  X3, X3, X20, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X3]
    LD3R { V5.8B, V6.8B, V7.8B }, [X3]
    ADD  X3, X3, X20, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X3]
    MOV  X25, X3
    LD3R { V0.4S, V1.4S, V2.4S }, [X25], #12
    ADD  X3, X3, X20, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X3]
    MOV  X25, X3
    LD3R { V3.2S, V4.2S, V5.2S }, [X25], #12
    ADD  X3, X3, X20, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X3]
    MOV  X25, X3
    LD3R { V21.4S, V22.4S, V23.4S }, [X25], #12
    ADD  X3, X3, X20, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X3]
    MOV  X25, X3
    LD3R { V29.2D, V30.2D, V31.2D }, [X25], #24
    ADD  X3, X3, X20, ASR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X3]
    MOV  X25, X3
    LD3R { V31.1D, V0.1D, V1.1D }, [X25], #24
    ADD  X3, X3, X20, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X3]
    MOV  X25, X3
    LD3R { V17.2D, V18.2D, V19.2D }, [X25], #24
    ADD  X3, X3, X20
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X3]
    MOV  X25, X3
    LD3R { V11.8B, V12.8B, V13.8B }, [X25], #3
    ADD  X3, X3, X20, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X3]
    MOV  X25, X3
    LD3R { V31.16B, V0.16B, V1.16B }, [X25], #3
    ADD  X3, X3, X20, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X3]
    MOV  X25, X3
    LD3R { V15.8B, V16.8B, V17.8B }, [X25], #3
    ADD  X3, X3, X20
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X3]
    MOV  X25, X3
    LD3R { V13.4H, V14.4H, V15.4H }, [X25], #6
    ADD  X3, X3, X20
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X3]
    MOV  X25, X3
    LD3R { V12.8H, V13.8H, V14.8H }, [X25], #6
    ADD  X3, X3, X20, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X3]
    MOV  X25, X3
    LD3R { V14.8H, V15.8H, V16.8H }, [X25], #6
    ADD  X3, X3, X20, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X3]
    LD3R { V9.16B, V10.16B, V11.16B }, [X3], X4
    ADD  X3, X3, X20
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X3]
    LD3R { V12.16B, V13.16B, V14.16B }, [X3], X4
    ADD  X3, X3, X20, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X3]
    LD3R { V9.2D, V10.2D, V11.2D }, [X3], X4
    ADD  X3, X3, X20, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X3]
    LD3R { V9.4S, V10.4S, V11.4S }, [X3], X4
    ADD  X3, X3, X20, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X3]
    LD3R { V19.8H, V20.8H, V21.8H }, [X3], X4
    ADD  X3, X3, X20, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X3]
    LD3R { V5.4H, V6.4H, V7.4H }, [X3], X4
    ADD  X3, X3, X20, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X3]
    LD3R { V27.1D, V28.1D, V29.1D }, [X3], X4
    ADD  X3, X3, X20, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X3]
    LD3R { V30.2S, V31.2S, V0.2S }, [X3], X4
    ADD  X3, X3, X20, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X3]
    LD3R { V16.4H, V17.4H, V18.4H }, [X3], X4
    ADD  X3, X3, X20, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X3]
    LD3R { V24.8B, V25.8B, V26.8B }, [X3], X4
    ADD  X3, X3, X20, LSR #0
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X14, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D0
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V1.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D1
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V2.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D2
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D3
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D4
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D5
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D6
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D7
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V8.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D8
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V9.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D9
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V10.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D10
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V11.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D11
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V12.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D12
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V13.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D13
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V14.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D14
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V15.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D15
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D16
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D17
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D18
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V19.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D19
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V20.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D20
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V21.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D21
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V22.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D22
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, V23.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D23
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D24
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D25
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D26
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D27
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D28
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D29
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D30
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    FMOV  X14, D31
    SUB  X16, X26, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X21
    FMOV  D1, X29
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X7
    FMOV  V3.D[1], X25
    FMOV  D4, X12
    FMOV  V4.D[1], X15
    FMOV  D5, X15
    FMOV  V5.D[1], X21
    FMOV  D6, X18
    FMOV  V6.D[1], X24
    FMOV  D7, X24
    FMOV  V7.D[1], X12
    FMOV  D8, X25
    FMOV  V8.D[1], X29
    FMOV  D9, X21
    FMOV  V9.D[1], X17
    FMOV  D10, X29
    FMOV  V10.D[1], X2
    FMOV  D11, X15
    FMOV  V11.D[1], X2
    FMOV  D12, X20
    FMOV  V12.D[1], X16
    FMOV  D13, X9
    FMOV  V13.D[1], X26
    FMOV  D14, X21
    FMOV  V14.D[1], X26
    FMOV  D15, X18
    FMOV  V15.D[1], X9
    FMOV  D16, X7
    FMOV  V16.D[1], X13
    FMOV  D17, X29
    FMOV  V17.D[1], X16
    FMOV  D18, X4
    FMOV  V18.D[1], X12
    FMOV  D19, X11
    FMOV  V19.D[1], X19
    FMOV  D20, X11
    FMOV  V20.D[1], X25
    FMOV  D21, X28
    FMOV  V21.D[1], X25
    FMOV  D22, X7
    FMOV  V22.D[1], X24
    FMOV  D23, X28
    FMOV  V23.D[1], X4
    FMOV  D24, X4
    FMOV  V24.D[1], X21
    FMOV  D25, X18
    FMOV  V25.D[1], X24
    FMOV  D26, X7
    FMOV  V26.D[1], X14
    FMOV  D27, X25
    FMOV  V27.D[1], X18
    FMOV  D28, X26
    FMOV  V28.D[1], X12
    FMOV  D29, X19
    FMOV  V29.D[1], X21
    FMOV  D30, X12
    FMOV  V30.D[1], X25
    FMOV  D31, X19
    FMOV  V31.D[1], X27
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X18, #0x0, LSL #0
    ADD  X2, X30, X18, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X2]
    LD3R { V23.16B, V24.16B, V25.16B }, [X2]
    ADD  X2, X2, X27, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X2]
    LD3R { V14.16B, V15.16B, V16.16B }, [X2]
    ADD  X2, X2, X27, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X2]
    LD3R { V26.2D, V27.2D, V28.2D }, [X2]
    ADD  X2, X2, X27, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X2]
    LD3R { V30.4S, V31.4S, V0.4S }, [X2]
    ADD  X2, X2, X27, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X2]
    LD3R { V16.8H, V17.8H, V18.8H }, [X2]
    ADD  X2, X2, X27, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X2]
    LD3R { V23.4H, V24.4H, V25.4H }, [X2]
    ADD  X2, X2, X27, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X2]
    LD3R { V1.1D, V2.1D, V3.1D }, [X2]
    ADD  X2, X2, X27, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X2]
    LD3R { V8.2S, V9.2S, V10.2S }, [X2]
    ADD  X2, X2, X27, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X2]
    LD3R { V15.4H, V16.4H, V17.4H }, [X2]
    ADD  X2, X2, X27, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X2]
    LD3R { V30.8B, V31.8B, V0.8B }, [X2]
    ADD  X2, X2, X27, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X2]
    MOV  X24, X2
    LD3R { V22.2S, V23.2S, V24.2S }, [X24], #12
    ADD  X2, X2, X27
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X2]
    MOV  X24, X2
    LD3R { V23.2S, V24.2S, V25.2S }, [X24], #12
    ADD  X2, X2, X27, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X2]
    MOV  X24, X2
    LD3R { V10.4S, V11.4S, V12.4S }, [X24], #12
    ADD  X2, X2, X27, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X2]
    MOV  X24, X2
    LD3R { V4.1D, V5.1D, V6.1D }, [X24], #24
    ADD  X2, X2, X27, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X2]
    MOV  X24, X2
    LD3R { V7.1D, V8.1D, V9.1D }, [X24], #24
    ADD  X2, X2, X27, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X2]
    MOV  X24, X2
    LD3R { V6.2D, V7.2D, V8.2D }, [X24], #24
    ADD  X2, X2, X27, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X2]
    MOV  X24, X2
    LD3R { V9.16B, V10.16B, V11.16B }, [X24], #3
    ADD  X2, X2, X27
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X2]
    MOV  X24, X2
    LD3R { V0.16B, V1.16B, V2.16B }, [X24], #3
    ADD  X2, X2, X27, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X2]
    MOV  X24, X2
    LD3R { V16.8B, V17.8B, V18.8B }, [X24], #3
    ADD  X2, X2, X27
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X2]
    MOV  X24, X2
    LD3R { V4.4H, V5.4H, V6.4H }, [X24], #6
    ADD  X2, X2, X27, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X2]
    MOV  X24, X2
    LD3R { V3.8H, V4.8H, V5.8H }, [X24], #6
    ADD  X2, X2, X27
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X2]
    MOV  X24, X2
    LD3R { V24.4H, V25.4H, V26.4H }, [X24], #6
    ADD  X2, X2, X27, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X2]
    LD3R { V14.8H, V15.8H, V16.8H }, [X2], X4
    ADD  X2, X2, X27, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X2]
    LD3R { V12.16B, V13.16B, V14.16B }, [X2], X4
    ADD  X2, X2, X27, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X2]
    LD3R { V21.2D, V22.2D, V23.2D }, [X2], X4
    ADD  X2, X2, X27, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X2]
    LD3R { V21.4S, V22.4S, V23.4S }, [X2], X4
    ADD  X2, X2, X27, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X2]
    LD3R { V24.8H, V25.8H, V26.8H }, [X2], X4
    ADD  X2, X2, X27, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X2]
    LD3R { V4.4H, V5.4H, V6.4H }, [X2], X4
    ADD  X2, X2, X27
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X2]
    LD3R { V20.1D, V21.1D, V22.1D }, [X2], X4
    ADD  X2, X2, X27, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X2]
    LD3R { V7.2S, V8.2S, V9.2S }, [X2], X4
    ADD  X2, X2, X27, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X2]
    LD3R { V31.4H, V0.4H, V1.4H }, [X2], X4
    ADD  X2, X2, X27, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X2]
    LD3R { V24.8B, V25.8B, V26.8B }, [X2], X4
    ADD  X2, X2, X27, ASR #0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X20, FPSR
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V0.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D0
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V1.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D1
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V2.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D2
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V3.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D3
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V4.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D4
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V5.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D5
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V6.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D6
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V7.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D7
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V8.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D8
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V9.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D9
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V10.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D10
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V11.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D11
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V12.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D12
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V13.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D13
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V14.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D14
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V15.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D15
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V16.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D16
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V17.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D17
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V18.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D18
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V19.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D19
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V20.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D20
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V21.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D21
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V22.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D22
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V23.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D23
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V24.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D24
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V25.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D25
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V26.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D26
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V27.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D27
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V28.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D28
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V29.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D29
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D30
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V31.D[1]
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D31
    SUB  X14, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X16
    FMOV  V3.D[1], X27
    FMOV  D4, X15
    FMOV  V4.D[1], X3
    FMOV  D5, X26
    FMOV  V5.D[1], X18
    FMOV  D6, X26
    FMOV  V6.D[1], X28
    FMOV  D7, X16
    FMOV  V7.D[1], X18
    FMOV  D8, X13
    FMOV  V8.D[1], X28
    FMOV  D9, X14
    FMOV  V9.D[1], X2
    FMOV  D10, X26
    FMOV  V10.D[1], X2
    FMOV  D11, X15
    FMOV  V11.D[1], X16
    FMOV  D12, X12
    FMOV  V12.D[1], X7
    FMOV  D13, X18
    FMOV  V13.D[1], X27
    FMOV  D14, X16
    FMOV  V14.D[1], X15
    FMOV  D15, X4
    FMOV  V15.D[1], X16
    FMOV  D16, X11
    FMOV  V16.D[1], X15
    FMOV  D17, X28
    FMOV  V17.D[1], X27
    FMOV  D18, X16
    FMOV  V18.D[1], X7
    FMOV  D19, X15
    FMOV  V19.D[1], X28
    FMOV  D20, X8
    FMOV  V20.D[1], X17
    FMOV  D21, X28
    FMOV  V21.D[1], X14
    FMOV  D22, X11
    FMOV  V22.D[1], X28
    FMOV  D23, X13
    FMOV  V23.D[1], X28
    FMOV  D24, X13
    FMOV  V24.D[1], X19
    FMOV  D25, X16
    FMOV  V25.D[1], X28
    FMOV  D26, X10
    FMOV  V26.D[1], X26
    FMOV  D27, X19
    FMOV  V27.D[1], X19
    FMOV  D28, X27
    FMOV  V28.D[1], X27
    FMOV  D29, X12
    FMOV  V29.D[1], X8
    FMOV  D30, X17
    FMOV  V30.D[1], X29
    FMOV  D31, X29
    FMOV  V31.D[1], X7
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X10, #0x500, LSL #0
    ADD  X13, X30, X10
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X13]
    LD3R { V15.16B, V16.16B, V17.16B }, [X13]
    ADD  X13, X13, X7
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X13]
    LD3R { V0.16B, V1.16B, V2.16B }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X13]
    LD3R { V17.2D, V18.2D, V19.2D }, [X13]
    ADD  X13, X13, X7
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X13]
    LD3R { V29.4S, V30.4S, V31.4S }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X13]
    LD3R { V22.8H, V23.8H, V24.8H }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X13]
    LD3R { V3.2S, V4.2S, V5.2S }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X13]
    LD3R { V13.1D, V14.1D, V15.1D }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X13]
    LD3R { V17.2S, V18.2S, V19.2S }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X13]
    LD3R { V31.4H, V0.4H, V1.4H }, [X13]
    ADD  X13, X13, X7
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X13]
    LD3R { V11.8B, V12.8B, V13.8B }, [X13]
    ADD  X13, X13, X7
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X13]
    MOV  X8, X13
    LD3R { V27.2S, V28.2S, V29.2S }, [X8], #12
    ADD  X13, X13, X7, ASR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X13]
    MOV  X8, X13
    LD3R { V2.2S, V3.2S, V4.2S }, [X8], #12
    ADD  X13, X13, X7, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X13]
    MOV  X8, X13
    LD3R { V21.4S, V22.4S, V23.4S }, [X8], #12
    ADD  X13, X13, X7
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X13]
    MOV  X8, X13
    LD3R { V11.2D, V12.2D, V13.2D }, [X8], #24
    ADD  X13, X13, X7, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X13]
    MOV  X8, X13
    LD3R { V15.1D, V16.1D, V17.1D }, [X8], #24
    ADD  X13, X13, X7
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X13]
    MOV  X8, X13
    LD3R { V23.2D, V24.2D, V25.2D }, [X8], #24
    ADD  X13, X13, X7
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X13]
    MOV  X8, X13
    LD3R { V0.16B, V1.16B, V2.16B }, [X8], #3
    ADD  X13, X13, X7, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X13]
    MOV  X8, X13
    LD3R { V28.16B, V29.16B, V30.16B }, [X8], #3
    ADD  X13, X13, X7
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X13]
    MOV  X8, X13
    LD3R { V2.8B, V3.8B, V4.8B }, [X8], #3
    ADD  X13, X13, X7
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X13]
    MOV  X8, X13
    LD3R { V23.4H, V24.4H, V25.4H }, [X8], #6
    ADD  X13, X13, X7, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X13]
    MOV  X8, X13
    LD3R { V1.8H, V2.8H, V3.8H }, [X8], #6
    ADD  X13, X13, X7, ASR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X13]
    MOV  X8, X13
    LD3R { V10.8H, V11.8H, V12.8H }, [X8], #6
    ADD  X13, X13, X7
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X13]
    LD3R { V18.4S, V19.4S, V20.4S }, [X13], X19
    ADD  X13, X13, X7, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X13]
    LD3R { V14.16B, V15.16B, V16.16B }, [X13], X19
    ADD  X13, X13, X7
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X13]
    LD3R { V2.2D, V3.2D, V4.2D }, [X13], X19
    ADD  X13, X13, X7, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X13]
    LD3R { V13.4S, V14.4S, V15.4S }, [X13], X19
    ADD  X13, X13, X7, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X13]
    LD3R { V26.8H, V27.8H, V28.8H }, [X13], X19
    ADD  X13, X13, X7, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X13]
    LD3R { V29.8B, V30.8B, V31.8B }, [X13], X19
    ADD  X13, X13, X7
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X13]
    LD3R { V31.1D, V0.1D, V1.1D }, [X13], X19
    ADD  X13, X13, X7, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X13]
    LD3R { V1.2S, V2.2S, V3.2S }, [X13], X19
    ADD  X13, X13, X7, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X13]
    LD3R { V13.4H, V14.4H, V15.4H }, [X13], X19
    ADD  X13, X13, X7, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X13]
    LD3R { V2.8B, V3.8B, V4.8B }, [X13], X19
    ADD  X13, X13, X7, ASR #0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X9, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V6.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V7.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V11.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V12.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V26.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V27.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X20, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X20
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X13
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X17
    FMOV  V4.D[1], X12
    FMOV  D5, X13
    FMOV  V5.D[1], X18
    FMOV  D6, X18
    FMOV  V6.D[1], X27
    FMOV  D7, X21
    FMOV  V7.D[1], X26
    FMOV  D8, X19
    FMOV  V8.D[1], X2
    FMOV  D9, X4
    FMOV  V9.D[1], X20
    FMOV  D10, X11
    FMOV  V10.D[1], X28
    FMOV  D11, X4
    FMOV  V11.D[1], X7
    FMOV  D12, X27
    FMOV  V12.D[1], X3
    FMOV  D13, X9
    FMOV  V13.D[1], X16
    FMOV  D14, X29
    FMOV  V14.D[1], X8
    FMOV  D15, X7
    FMOV  V15.D[1], X4
    FMOV  D16, X20
    FMOV  V16.D[1], X24
    FMOV  D17, X24
    FMOV  V17.D[1], X2
    FMOV  D18, X20
    FMOV  V18.D[1], X13
    FMOV  D19, X9
    FMOV  V19.D[1], X25
    FMOV  D20, X3
    FMOV  V20.D[1], X20
    FMOV  D21, X26
    FMOV  V21.D[1], X24
    FMOV  D22, X19
    FMOV  V22.D[1], X2
    FMOV  D23, X24
    FMOV  V23.D[1], X8
    FMOV  D24, X17
    FMOV  V24.D[1], X29
    FMOV  D25, X19
    FMOV  V25.D[1], X20
    FMOV  D26, X14
    FMOV  V26.D[1], X10
    FMOV  D27, X7
    FMOV  V27.D[1], X29
    FMOV  D28, X11
    FMOV  V28.D[1], X2
    FMOV  D29, X24
    FMOV  V29.D[1], X8
    FMOV  D30, X17
    FMOV  V30.D[1], X8
    FMOV  D31, X20
    FMOV  V31.D[1], X7
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X25, #0xa00, LSL #0
    ADD  X7, X30, X25, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X7]
    LD3R { V9.2D, V10.2D, V11.2D }, [X7]
    ADD  X7, X7, X3
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X7]
    LD3R { V12.16B, V13.16B, V14.16B }, [X7]
    ADD  X7, X7, X3, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X7]
    LD3R { V10.2D, V11.2D, V12.2D }, [X7]
    ADD  X7, X7, X3, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X7]
    LD3R { V26.4S, V27.4S, V28.4S }, [X7]
    ADD  X7, X7, X3, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X7]
    LD3R { V22.8H, V23.8H, V24.8H }, [X7]
    ADD  X7, X7, X3, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X7]
    LD3R { V18.8B, V19.8B, V20.8B }, [X7]
    ADD  X7, X7, X3
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X7]
    LD3R { V31.1D, V0.1D, V1.1D }, [X7]
    ADD  X7, X7, X3, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X7]
    LD3R { V15.2S, V16.2S, V17.2S }, [X7]
    ADD  X7, X7, X3
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X7]
    LD3R { V3.4H, V4.4H, V5.4H }, [X7]
    ADD  X7, X7, X3, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X7]
    LD3R { V31.8B, V0.8B, V1.8B }, [X7]
    ADD  X7, X7, X3, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X7]
    MOV  X17, X7
    LD3R { V2.4S, V3.4S, V4.4S }, [X17], #12
    ADD  X7, X7, X3, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X7]
    MOV  X17, X7
    LD3R { V7.2S, V8.2S, V9.2S }, [X17], #12
    ADD  X7, X7, X3
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X7]
    MOV  X17, X7
    LD3R { V24.4S, V25.4S, V26.4S }, [X17], #12
    ADD  X7, X7, X3, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X7]
    MOV  X17, X7
    LD3R { V10.1D, V11.1D, V12.1D }, [X17], #24
    ADD  X7, X7, X3, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X7]
    MOV  X17, X7
    LD3R { V1.1D, V2.1D, V3.1D }, [X17], #24
    ADD  X7, X7, X3, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X7]
    MOV  X17, X7
    LD3R { V7.2D, V8.2D, V9.2D }, [X17], #24
    ADD  X7, X7, X3, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X7]
    MOV  X17, X7
    LD3R { V30.16B, V31.16B, V0.16B }, [X17], #3
    ADD  X7, X7, X3, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X7]
    MOV  X17, X7
    LD3R { V19.16B, V20.16B, V21.16B }, [X17], #3
    ADD  X7, X7, X3, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X7]
    MOV  X17, X7
    LD3R { V11.8B, V12.8B, V13.8B }, [X17], #3
    ADD  X7, X7, X3, LSR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X7]
    MOV  X17, X7
    LD3R { V5.4H, V6.4H, V7.4H }, [X17], #6
    ADD  X7, X7, X3, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X7]
    MOV  X17, X7
    LD3R { V23.8H, V24.8H, V25.8H }, [X17], #6
    ADD  X7, X7, X3, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X7]
    MOV  X17, X7
    LD3R { V0.4H, V1.4H, V2.4H }, [X17], #6
    ADD  X7, X7, X3, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X7]
    LD3R { V3.16B, V4.16B, V5.16B }, [X7], X29
    ADD  X7, X7, X3
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X7]
    LD3R { V29.16B, V30.16B, V31.16B }, [X7], X29
    ADD  X7, X7, X3
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X7]
    LD3R { V14.2D, V15.2D, V16.2D }, [X7], X29
    ADD  X7, X7, X3, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X7]
    LD3R { V24.4S, V25.4S, V26.4S }, [X7], X29
    ADD  X7, X7, X3, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X7]
    LD3R { V1.8H, V2.8H, V3.8H }, [X7], X29
    ADD  X7, X7, X3, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X7]
    LD3R { V5.2S, V6.2S, V7.2S }, [X7], X29
    ADD  X7, X7, X3, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X7]
    LD3R { V13.1D, V14.1D, V15.1D }, [X7], X29
    ADD  X7, X7, X3
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X7]
    LD3R { V31.2S, V0.2S, V1.2S }, [X7], X29
    ADD  X7, X7, X3, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X7]
    LD3R { V12.4H, V13.4H, V14.4H }, [X7], X29
    ADD  X7, X7, X3, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X7]
    LD3R { V5.8B, V6.8B, V7.8B }, [X7], X29
    ADD  X7, X7, X3, LSR #0
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X14
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X4, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X4, FPSR
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D0
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D1
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V2.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D2
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D3
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V4.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D4
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V5.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D5
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V6.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D6
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V7.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D7
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V8.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D8
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V9.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D9
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V10.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D10
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V11.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D11
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V12.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D12
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V13.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D13
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D14
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V15.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D15
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V16.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D16
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V17.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D17
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V18.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D18
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V19.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D19
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V20.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D20
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V21.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D21
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V22.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D22
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V23.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D23
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V24.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D24
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V25.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D25
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V26.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D26
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V27.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D27
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D28
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V29.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D29
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, V30.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D30
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X4, D31
    SUB  X11, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X25
    FMOV  V3.D[1], X10
    FMOV  D4, X27
    FMOV  V4.D[1], X20
    FMOV  D5, X12
    FMOV  V5.D[1], X11
    FMOV  D6, X25
    FMOV  V6.D[1], X25
    FMOV  D7, X21
    FMOV  V7.D[1], X17
    FMOV  D8, X11
    FMOV  V8.D[1], X24
    FMOV  D9, X29
    FMOV  V9.D[1], X11
    FMOV  D10, X20
    FMOV  V10.D[1], X2
    FMOV  D11, X2
    FMOV  V11.D[1], X27
    FMOV  D12, X16
    FMOV  V12.D[1], X16
    FMOV  D13, X10
    FMOV  V13.D[1], X28
    FMOV  D14, X26
    FMOV  V14.D[1], X8
    FMOV  D15, X2
    FMOV  V15.D[1], X4
    FMOV  D16, X2
    FMOV  V16.D[1], X24
    FMOV  D17, X3
    FMOV  V17.D[1], X27
    FMOV  D18, X24
    FMOV  V18.D[1], X16
    FMOV  D19, X19
    FMOV  V19.D[1], X25
    FMOV  D20, X17
    FMOV  V20.D[1], X7
    FMOV  D21, X4
    FMOV  V21.D[1], X17
    FMOV  D22, X26
    FMOV  V22.D[1], X17
    FMOV  D23, X12
    FMOV  V23.D[1], X24
    FMOV  D24, X3
    FMOV  V24.D[1], X14
    FMOV  D25, X7
    FMOV  V25.D[1], X18
    FMOV  D26, X21
    FMOV  V26.D[1], X13
    FMOV  D27, X11
    FMOV  V27.D[1], X4
    FMOV  D28, X12
    FMOV  V28.D[1], X28
    FMOV  D29, X20
    FMOV  V29.D[1], X19
    FMOV  D30, X11
    FMOV  V30.D[1], X9
    FMOV  D31, X10
    FMOV  V31.D[1], X3
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X17, #0xf00, LSL #0
    ADD  X26, X30, X17, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X26]
    LD3R { V15.4S, V16.4S, V17.4S }, [X26]
    ADD  X26, X26, X21, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X26]
    LD3R { V9.16B, V10.16B, V11.16B }, [X26]
    ADD  X26, X26, X21
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X26]
    LD3R { V9.2D, V10.2D, V11.2D }, [X26]
    ADD  X26, X26, X21, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X26]
    LD3R { V23.4S, V24.4S, V25.4S }, [X26]
    ADD  X26, X26, X21, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X26]
    LD3R { V27.8H, V28.8H, V29.8H }, [X26]
    ADD  X26, X26, X21, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X26]
    LD3R { V25.8B, V26.8B, V27.8B }, [X26]
    ADD  X26, X26, X21
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X26]
    LD3R { V6.1D, V7.1D, V8.1D }, [X26]
    ADD  X26, X26, X21, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X26]
    LD3R { V29.2S, V30.2S, V31.2S }, [X26]
    ADD  X26, X26, X21, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X26]
    LD3R { V25.4H, V26.4H, V27.4H }, [X26]
    ADD  X26, X26, X21, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X26]
    LD3R { V27.8B, V28.8B, V29.8B }, [X26]
    ADD  X26, X26, X21
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X26]
    MOV  X12, X26
    LD3R { V16.4S, V17.4S, V18.4S }, [X12], #12
    ADD  X26, X26, X21, ASR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X26]
    MOV  X12, X26
    LD3R { V11.2S, V12.2S, V13.2S }, [X12], #12
    ADD  X26, X26, X21, ASR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X26]
    MOV  X12, X26
    LD3R { V21.4S, V22.4S, V23.4S }, [X12], #12
    ADD  X26, X26, X21, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X26]
    MOV  X12, X26
    LD3R { V1.1D, V2.1D, V3.1D }, [X12], #24
    ADD  X26, X26, X21, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X26]
    MOV  X12, X26
    LD3R { V27.1D, V28.1D, V29.1D }, [X12], #24
    ADD  X26, X26, X21, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X26]
    MOV  X12, X26
    LD3R { V1.2D, V2.2D, V3.2D }, [X12], #24
    ADD  X26, X26, X21, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X26]
    MOV  X12, X26
    LD3R { V30.16B, V31.16B, V0.16B }, [X12], #3
    ADD  X26, X26, X21
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X26]
    MOV  X12, X26
    LD3R { V20.16B, V21.16B, V22.16B }, [X12], #3
    ADD  X26, X26, X21, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X26]
    MOV  X12, X26
    LD3R { V16.8B, V17.8B, V18.8B }, [X12], #3
    ADD  X26, X26, X21
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X26]
    MOV  X12, X26
    LD3R { V2.4H, V3.4H, V4.4H }, [X12], #6
    ADD  X26, X26, X21
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X26]
    MOV  X12, X26
    LD3R { V10.8H, V11.8H, V12.8H }, [X12], #6
    ADD  X26, X26, X21, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X26]
    MOV  X12, X26
    LD3R { V23.8H, V24.8H, V25.8H }, [X12], #6
    ADD  X26, X26, X21
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X26]
    LD3R { V5.4S, V6.4S, V7.4S }, [X26], X15
    ADD  X26, X26, X21
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X26]
    LD3R { V5.16B, V6.16B, V7.16B }, [X26], X15
    ADD  X26, X26, X21
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X26]
    LD3R { V17.2D, V18.2D, V19.2D }, [X26], X15
    ADD  X26, X26, X21, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X26]
    LD3R { V17.4S, V18.4S, V19.4S }, [X26], X15
    ADD  X26, X26, X21, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X26]
    LD3R { V5.8H, V6.8H, V7.8H }, [X26], X15
    ADD  X26, X26, X21, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X26]
    LD3R { V23.2S, V24.2S, V25.2S }, [X26], X15
    ADD  X26, X26, X21, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X26]
    LD3R { V20.1D, V21.1D, V22.1D }, [X26], X15
    ADD  X26, X26, X21, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X26]
    LD3R { V22.2S, V23.2S, V24.2S }, [X26], X15
    ADD  X26, X26, X21, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X26]
    LD3R { V17.4H, V18.4H, V19.4H }, [X26], X15
    ADD  X26, X26, X21
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X26]
    LD3R { V4.8B, V5.8B, V6.8B }, [X26], X15
    ADD  X26, X26, X21, LSR #0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X2
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X27, FPSR
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V0.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D0
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V1.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D1
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D2
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D3
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V4.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D4
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D5
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D6
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V7.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D7
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D8
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V9.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D9
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V10.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D10
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V11.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D11
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V12.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D12
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V13.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D13
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V14.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D14
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V15.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D15
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D16
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D17
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V18.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D18
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V19.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D19
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V20.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D20
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D21
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D22
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D23
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D24
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D25
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D26
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D27
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D28
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D29
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V30.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D30
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, V31.D[1]
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X27, D31
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X24
    FMOV  D3, X10
    FMOV  V3.D[1], X8
    FMOV  D4, X14
    FMOV  V4.D[1], X14
    FMOV  D5, X8
    FMOV  V5.D[1], X3
    FMOV  D6, X27
    FMOV  V6.D[1], X15
    FMOV  D7, X9
    FMOV  V7.D[1], X27
    FMOV  D8, X24
    FMOV  V8.D[1], X4
    FMOV  D9, X3
    FMOV  V9.D[1], X25
    FMOV  D10, X8
    FMOV  V10.D[1], X15
    FMOV  D11, X17
    FMOV  V11.D[1], X25
    FMOV  D12, X29
    FMOV  V12.D[1], X17
    FMOV  D13, X12
    FMOV  V13.D[1], X26
    FMOV  D14, X21
    FMOV  V14.D[1], X11
    FMOV  D15, X15
    FMOV  V15.D[1], X29
    FMOV  D16, X28
    FMOV  V16.D[1], X26
    FMOV  D17, X20
    FMOV  V17.D[1], X3
    FMOV  D18, X28
    FMOV  V18.D[1], X12
    FMOV  D19, X15
    FMOV  V19.D[1], X26
    FMOV  D20, X25
    FMOV  V20.D[1], X18
    FMOV  D21, X18
    FMOV  V21.D[1], X18
    FMOV  D22, X7
    FMOV  V22.D[1], X10
    FMOV  D23, X24
    FMOV  V23.D[1], X9
    FMOV  D24, X27
    FMOV  V24.D[1], X16
    FMOV  D25, X9
    FMOV  V25.D[1], X12
    FMOV  D26, X17
    FMOV  V26.D[1], X21
    FMOV  D27, X18
    FMOV  V27.D[1], X14
    FMOV  D28, X11
    FMOV  V28.D[1], X15
    FMOV  D29, X21
    FMOV  V29.D[1], X18
    FMOV  D30, X7
    FMOV  V30.D[1], X2
    FMOV  D31, X4
    FMOV  V31.D[1], X8
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X21, #0x1400, LSL #0
    ADD  X11, X30, X21, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X11]
    LD3R { V6.16B, V7.16B, V8.16B }, [X11]
    ADD  X11, X11, X27, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X11]
    LD3R { V28.16B, V29.16B, V30.16B }, [X11]
    ADD  X11, X11, X27, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X11]
    LD3R { V12.2D, V13.2D, V14.2D }, [X11]
    ADD  X11, X11, X27, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X11]
    LD3R { V30.4S, V31.4S, V0.4S }, [X11]
    ADD  X11, X11, X27, LSR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X11]
    LD3R { V18.8H, V19.8H, V20.8H }, [X11]
    ADD  X11, X11, X27
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X11]
    LD3R { V31.8B, V0.8B, V1.8B }, [X11]
    ADD  X11, X11, X27
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X11]
    LD3R { V27.1D, V28.1D, V29.1D }, [X11]
    ADD  X11, X11, X27, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X11]
    LD3R { V5.2S, V6.2S, V7.2S }, [X11]
    ADD  X11, X11, X27, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X11]
    LD3R { V19.4H, V20.4H, V21.4H }, [X11]
    ADD  X11, X11, X27
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X11]
    LD3R { V26.8B, V27.8B, V28.8B }, [X11]
    ADD  X11, X11, X27, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X11]
    MOV  X20, X11
    LD3R { V21.2S, V22.2S, V23.2S }, [X20], #12
    ADD  X11, X11, X27
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X11]
    MOV  X20, X11
    LD3R { V3.2S, V4.2S, V5.2S }, [X20], #12
    ADD  X11, X11, X27, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X11]
    MOV  X20, X11
    LD3R { V14.4S, V15.4S, V16.4S }, [X20], #12
    ADD  X11, X11, X27
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X11]
    MOV  X20, X11
    LD3R { V11.2D, V12.2D, V13.2D }, [X20], #24
    ADD  X11, X11, X27, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X11]
    MOV  X20, X11
    LD3R { V7.1D, V8.1D, V9.1D }, [X20], #24
    ADD  X11, X11, X27, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X11]
    MOV  X20, X11
    LD3R { V12.2D, V13.2D, V14.2D }, [X20], #24
    ADD  X11, X11, X27
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X11]
    MOV  X20, X11
    LD3R { V21.8B, V22.8B, V23.8B }, [X20], #3
    ADD  X11, X11, X27, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X11]
    MOV  X20, X11
    LD3R { V6.16B, V7.16B, V8.16B }, [X20], #3
    ADD  X11, X11, X27, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X11]
    MOV  X20, X11
    LD3R { V4.8B, V5.8B, V6.8B }, [X20], #3
    ADD  X11, X11, X27
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X11]
    MOV  X20, X11
    LD3R { V21.4H, V22.4H, V23.4H }, [X20], #6
    ADD  X11, X11, X27, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X11]
    MOV  X20, X11
    LD3R { V20.8H, V21.8H, V22.8H }, [X20], #6
    ADD  X11, X11, X27, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X11]
    MOV  X20, X11
    LD3R { V20.8H, V21.8H, V22.8H }, [X20], #6
    ADD  X11, X11, X27, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X11]
    LD3R { V11.16B, V12.16B, V13.16B }, [X11], X10
    ADD  X11, X11, X27, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X11]
    LD3R { V6.16B, V7.16B, V8.16B }, [X11], X10
    ADD  X11, X11, X27
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X11]
    LD3R { V30.2D, V31.2D, V0.2D }, [X11], X10
    ADD  X11, X11, X27, LSR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X11]
    LD3R { V21.4S, V22.4S, V23.4S }, [X11], X10
    ADD  X11, X11, X27, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X11]
    LD3R { V26.8H, V27.8H, V28.8H }, [X11], X10
    ADD  X11, X11, X27, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X11]
    LD3R { V15.4H, V16.4H, V17.4H }, [X11], X10
    ADD  X11, X11, X27, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X11]
    LD3R { V14.1D, V15.1D, V16.1D }, [X11], X10
    ADD  X11, X11, X27
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X11]
    LD3R { V22.2S, V23.2S, V24.2S }, [X11], X10
    ADD  X11, X11, X27, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X11]
    LD3R { V17.4H, V18.4H, V19.4H }, [X11], X10
    ADD  X11, X11, X27, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X11]
    LD3R { V25.8B, V26.8B, V27.8B }, [X11], X10
    ADD  X11, X11, X27, LSR #0
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X18, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D1
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D2
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D3
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D4
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D5
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D6
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D7
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V8.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D8
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D9
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V10.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D10
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D11
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D12
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V13.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D13
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D14
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D15
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D16
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D17
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D18
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D19
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V20.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D20
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V21.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D21
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D22
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D23
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D24
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D25
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D26
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D27
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D28
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D29
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V30.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, V31.D[1]
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X18, D31
    SUB  X4, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X28
    FMOV  D1, X21
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X19
    FMOV  D3, X28
    FMOV  V3.D[1], X24
    FMOV  D4, X19
    FMOV  V4.D[1], X25
    FMOV  D5, X21
    FMOV  V5.D[1], X12
    FMOV  D6, X18
    FMOV  V6.D[1], X25
    FMOV  D7, X25
    FMOV  V7.D[1], X18
    FMOV  D8, X19
    FMOV  V8.D[1], X3
    FMOV  D9, X9
    FMOV  V9.D[1], X11
    FMOV  D10, X28
    FMOV  V10.D[1], X24
    FMOV  D11, X26
    FMOV  V11.D[1], X28
    FMOV  D12, X9
    FMOV  V12.D[1], X7
    FMOV  D13, X17
    FMOV  V13.D[1], X4
    FMOV  D14, X3
    FMOV  V14.D[1], X16
    FMOV  D15, X24
    FMOV  V15.D[1], X9
    FMOV  D16, X26
    FMOV  V16.D[1], X19
    FMOV  D17, X7
    FMOV  V17.D[1], X12
    FMOV  D18, X15
    FMOV  V18.D[1], X7
    FMOV  D19, X13
    FMOV  V19.D[1], X3
    FMOV  D20, X10
    FMOV  V20.D[1], X24
    FMOV  D21, X11
    FMOV  V21.D[1], X27
    FMOV  D22, X13
    FMOV  V22.D[1], X8
    FMOV  D23, X20
    FMOV  V23.D[1], X2
    FMOV  D24, X13
    FMOV  V24.D[1], X9
    FMOV  D25, X21
    FMOV  V25.D[1], X13
    FMOV  D26, X29
    FMOV  V26.D[1], X7
    FMOV  D27, X13
    FMOV  V27.D[1], X2
    FMOV  D28, X15
    FMOV  V28.D[1], X28
    FMOV  D29, X20
    FMOV  V29.D[1], X18
    FMOV  D30, X27
    FMOV  V30.D[1], X12
    FMOV  D31, X14
    FMOV  V31.D[1], X25
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X15, #0x1900, LSL #0
    ADD  X26, X30, X15
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X26]
    LD3R { V18.16B, V19.16B, V20.16B }, [X26]
    ADD  X26, X26, X25
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X26]
    LD3R { V29.16B, V30.16B, V31.16B }, [X26]
    ADD  X26, X26, X25, ASR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X26]
    LD3R { V18.2D, V19.2D, V20.2D }, [X26]
    ADD  X26, X26, X25, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X26]
    LD3R { V4.4S, V5.4S, V6.4S }, [X26]
    ADD  X26, X26, X25, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X26]
    LD3R { V26.8H, V27.8H, V28.8H }, [X26]
    ADD  X26, X26, X25, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X26]
    LD3R { V2.2S, V3.2S, V4.2S }, [X26]
    ADD  X26, X26, X25, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X26]
    LD3R { V29.1D, V30.1D, V31.1D }, [X26]
    ADD  X26, X26, X25
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X26]
    LD3R { V17.2S, V18.2S, V19.2S }, [X26]
    ADD  X26, X26, X25, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X26]
    LD3R { V7.4H, V8.4H, V9.4H }, [X26]
    ADD  X26, X26, X25, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X26]
    LD3R { V4.8B, V5.8B, V6.8B }, [X26]
    ADD  X26, X26, X25
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X26]
    MOV  X13, X26
    LD3R { V8.4S, V9.4S, V10.4S }, [X13], #12
    ADD  X26, X26, X25
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X26]
    MOV  X13, X26
    LD3R { V18.2S, V19.2S, V20.2S }, [X13], #12
    ADD  X26, X26, X25
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X26]
    MOV  X13, X26
    LD3R { V12.4S, V13.4S, V14.4S }, [X13], #12
    ADD  X26, X26, X25, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X26]
    MOV  X13, X26
    LD3R { V18.1D, V19.1D, V20.1D }, [X13], #24
    ADD  X26, X26, X25, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X26]
    MOV  X13, X26
    LD3R { V2.1D, V3.1D, V4.1D }, [X13], #24
    ADD  X26, X26, X25, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X26]
    MOV  X13, X26
    LD3R { V15.2D, V16.2D, V17.2D }, [X13], #24
    ADD  X26, X26, X25
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X26]
    MOV  X13, X26
    LD3R { V25.16B, V26.16B, V27.16B }, [X13], #3
    ADD  X26, X26, X25, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X26]
    MOV  X13, X26
    LD3R { V20.16B, V21.16B, V22.16B }, [X13], #3
    ADD  X26, X26, X25
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X26]
    MOV  X13, X26
    LD3R { V13.8B, V14.8B, V15.8B }, [X13], #3
    ADD  X26, X26, X25, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X26]
    MOV  X13, X26
    LD3R { V3.4H, V4.4H, V5.4H }, [X13], #6
    ADD  X26, X26, X25
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X26]
    MOV  X13, X26
    LD3R { V17.8H, V18.8H, V19.8H }, [X13], #6
    ADD  X26, X26, X25
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X26]
    MOV  X13, X26
    LD3R { V17.8H, V18.8H, V19.8H }, [X13], #6
    ADD  X26, X26, X25
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X26]
    LD3R { V19.2D, V20.2D, V21.2D }, [X26], X8
    ADD  X26, X26, X25, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X26]
    LD3R { V18.16B, V19.16B, V20.16B }, [X26], X8
    ADD  X26, X26, X25
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X26]
    LD3R { V16.2D, V17.2D, V18.2D }, [X26], X8
    ADD  X26, X26, X25, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X26]
    LD3R { V22.4S, V23.4S, V24.4S }, [X26], X8
    ADD  X26, X26, X25, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X26]
    LD3R { V17.8H, V18.8H, V19.8H }, [X26], X8
    ADD  X26, X26, X25
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X26]
    LD3R { V19.2S, V20.2S, V21.2S }, [X26], X8
    ADD  X26, X26, X25
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X26]
    LD3R { V11.1D, V12.1D, V13.1D }, [X26], X8
    ADD  X26, X26, X25
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X26]
    LD3R { V6.2S, V7.2S, V8.2S }, [X26], X8
    ADD  X26, X26, X25
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X26]
    LD3R { V22.4H, V23.4H, V24.4H }, [X26], X8
    ADD  X26, X26, X25, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X26]
    LD3R { V11.8B, V12.8B, V13.8B }, [X26], X8
    ADD  X26, X26, X25, LSR #0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X7, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V0.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D0
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V1.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D1
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D2
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D3
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D4
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D5
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D6
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D7
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V8.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D8
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V9.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D9
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D10
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V11.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D11
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D12
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V13.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D13
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D14
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D15
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V16.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D16
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V17.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D17
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V18.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D18
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D19
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D20
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D21
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D22
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D23
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D24
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V25.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D25
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V26.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D26
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V27.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D27
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, V28.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D28
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D29
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D30
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X7, D31
    SUB  X21, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X10
    FMOV  D3, X4
    FMOV  V3.D[1], X15
    FMOV  D4, X26
    FMOV  V4.D[1], X16
    FMOV  D5, X3
    FMOV  V5.D[1], X20
    FMOV  D6, X13
    FMOV  V6.D[1], X17
    FMOV  D7, X24
    FMOV  V7.D[1], X9
    FMOV  D8, X21
    FMOV  V8.D[1], X28
    FMOV  D9, X26
    FMOV  V9.D[1], X16
    FMOV  D10, X27
    FMOV  V10.D[1], X10
    FMOV  D11, X7
    FMOV  V11.D[1], X14
    FMOV  D12, X24
    FMOV  V12.D[1], X24
    FMOV  D13, X10
    FMOV  V13.D[1], X7
    FMOV  D14, X9
    FMOV  V14.D[1], X25
    FMOV  D15, X26
    FMOV  V15.D[1], X15
    FMOV  D16, X17
    FMOV  V16.D[1], X21
    FMOV  D17, X18
    FMOV  V17.D[1], X13
    FMOV  D18, X27
    FMOV  V18.D[1], X27
    FMOV  D19, X28
    FMOV  V19.D[1], X7
    FMOV  D20, X18
    FMOV  V20.D[1], X13
    FMOV  D21, X2
    FMOV  V21.D[1], X4
    FMOV  D22, X3
    FMOV  V22.D[1], X4
    FMOV  D23, X2
    FMOV  V23.D[1], X9
    FMOV  D24, X3
    FMOV  V24.D[1], X11
    FMOV  D25, X14
    FMOV  V25.D[1], X26
    FMOV  D26, X17
    FMOV  V26.D[1], X13
    FMOV  D27, X15
    FMOV  V27.D[1], X10
    FMOV  D28, X26
    FMOV  V28.D[1], X3
    FMOV  D29, X29
    FMOV  V29.D[1], X11
    FMOV  D30, X7
    FMOV  V30.D[1], X26
    FMOV  D31, X18
    FMOV  V31.D[1], X16
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X19, #0x1e00, LSL #0
    ADD  X24, X30, X19
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X24]
    LD3R { V21.8H, V22.8H, V23.8H }, [X24]
    ADD  X24, X24, X2, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X24]
    LD3R { V13.16B, V14.16B, V15.16B }, [X24]
    ADD  X24, X24, X2, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X24]
    LD3R { V23.2D, V24.2D, V25.2D }, [X24]
    ADD  X24, X24, X2
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X24]
    LD3R { V29.4S, V30.4S, V31.4S }, [X24]
    ADD  X24, X24, X2, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X24]
    LD3R { V1.8H, V2.8H, V3.8H }, [X24]
    ADD  X24, X24, X2, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X24]
    LD3R { V21.4H, V22.4H, V23.4H }, [X24]
    ADD  X24, X24, X2
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X24]
    LD3R { V18.1D, V19.1D, V20.1D }, [X24]
    ADD  X24, X24, X2, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X24]
    LD3R { V5.2S, V6.2S, V7.2S }, [X24]
    ADD  X24, X24, X2, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X24]
    LD3R { V8.4H, V9.4H, V10.4H }, [X24]
    ADD  X24, X24, X2
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X24]
    LD3R { V5.8B, V6.8B, V7.8B }, [X24]
    ADD  X24, X24, X2
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X24]
    MOV  X18, X24
    LD3R { V10.4S, V11.4S, V12.4S }, [X18], #12
    ADD  X24, X24, X2
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X24]
    MOV  X18, X24
    LD3R { V26.2S, V27.2S, V28.2S }, [X18], #12
    ADD  X24, X24, X2, ASR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X24]
    MOV  X18, X24
    LD3R { V12.4S, V13.4S, V14.4S }, [X18], #12
    ADD  X24, X24, X2, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X24]
    MOV  X18, X24
    LD3R { V13.1D, V14.1D, V15.1D }, [X18], #24
    ADD  X24, X24, X2, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X24]
    MOV  X18, X24
    LD3R { V23.1D, V24.1D, V25.1D }, [X18], #24
    ADD  X24, X24, X2
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X24]
    MOV  X18, X24
    LD3R { V12.2D, V13.2D, V14.2D }, [X18], #24
    ADD  X24, X24, X2, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X24]
    MOV  X18, X24
    LD3R { V20.16B, V21.16B, V22.16B }, [X18], #3
    ADD  X24, X24, X2
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X24]
    MOV  X18, X24
    LD3R { V20.16B, V21.16B, V22.16B }, [X18], #3
    ADD  X24, X24, X2, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X24]
    MOV  X18, X24
    LD3R { V21.8B, V22.8B, V23.8B }, [X18], #3
    ADD  X24, X24, X2, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X24]
    MOV  X18, X24
    LD3R { V26.4H, V27.4H, V28.4H }, [X18], #6
    ADD  X24, X24, X2
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X24]
    MOV  X18, X24
    LD3R { V13.8H, V14.8H, V15.8H }, [X18], #6
    ADD  X24, X24, X2, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X24]
    MOV  X18, X24
    LD3R { V31.8H, V0.8H, V1.8H }, [X18], #6
    ADD  X24, X24, X2
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X24]
    LD3R { V19.8H, V20.8H, V21.8H }, [X24], X4
    ADD  X24, X24, X2, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X24]
    LD3R { V14.16B, V15.16B, V16.16B }, [X24], X4
    ADD  X24, X24, X2
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X24]
    LD3R { V30.2D, V31.2D, V0.2D }, [X24], X4
    ADD  X24, X24, X2, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X24]
    LD3R { V30.4S, V31.4S, V0.4S }, [X24], X4
    ADD  X24, X24, X2, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X24]
    LD3R { V10.8H, V11.8H, V12.8H }, [X24], X4
    ADD  X24, X24, X2
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X24]
    LD3R { V23.1D, V24.1D, V25.1D }, [X24], X4
    ADD  X24, X24, X2, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X24]
    LD3R { V25.1D, V26.1D, V27.1D }, [X24], X4
    ADD  X24, X24, X2, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X24]
    LD3R { V30.2S, V31.2S, V0.2S }, [X24], X4
    ADD  X24, X24, X2, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X24]
    LD3R { V6.4H, V7.4H, V8.4H }, [X24], X4
    ADD  X24, X24, X2, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X24]
    LD3R { V31.8B, V0.8B, V1.8B }, [X24], X4
    ADD  X24, X24, X2, LSR #0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X8, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D0
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D1
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V2.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D2
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V3.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D3
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V4.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D4
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D5
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D6
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D7
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D8
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D9
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V10.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D10
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D11
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V12.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D12
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V13.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D13
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V14.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D14
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D15
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V16.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D16
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V17.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D17
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D18
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V19.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D19
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V20.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D20
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V21.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D21
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D22
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D23
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D24
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D25
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D26
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D27
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D28
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, V29.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D29
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D30
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X8, D31
    SUB  X3, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadDeprecatedP03_TestFail
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
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X10
    FMOV  V2.D[1], X27
    FMOV  D3, X2
    FMOV  V3.D[1], X8
    FMOV  D4, X9
    FMOV  V4.D[1], X18
    FMOV  D5, X11
    FMOV  V5.D[1], X18
    FMOV  D6, X28
    FMOV  V6.D[1], X21
    FMOV  D7, X2
    FMOV  V7.D[1], X12
    FMOV  D8, X9
    FMOV  V8.D[1], X25
    FMOV  D9, X27
    FMOV  V9.D[1], X15
    FMOV  D10, X3
    FMOV  V10.D[1], X29
    FMOV  D11, X13
    FMOV  V11.D[1], X2
    FMOV  D12, X15
    FMOV  V12.D[1], X27
    FMOV  D13, X19
    FMOV  V13.D[1], X9
    FMOV  D14, X4
    FMOV  V14.D[1], X26
    FMOV  D15, X26
    FMOV  V15.D[1], X20
    FMOV  D16, X3
    FMOV  V16.D[1], X16
    FMOV  D17, X13
    FMOV  V17.D[1], X15
    FMOV  D18, X10
    FMOV  V18.D[1], X14
    FMOV  D19, X26
    FMOV  V19.D[1], X2
    FMOV  D20, X17
    FMOV  V20.D[1], X10
    FMOV  D21, X19
    FMOV  V21.D[1], X9
    FMOV  D22, X18
    FMOV  V22.D[1], X28
    FMOV  D23, X24
    FMOV  V23.D[1], X10
    FMOV  D24, X17
    FMOV  V24.D[1], X26
    FMOV  D25, X7
    FMOV  V25.D[1], X12
    FMOV  D26, X8
    FMOV  V26.D[1], X2
    FMOV  D27, X27
    FMOV  V27.D[1], X25
    FMOV  D28, X15
    FMOV  V28.D[1], X17
    FMOV  D29, X4
    FMOV  V29.D[1], X7
    FMOV  D30, X11
    FMOV  V30.D[1], X13
    FMOV  D31, X13
    FMOV  V31.D[1], X12
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X27, #0x2300, LSL #0
    ADD  X19, X30, X27, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X19]
    LD3R { V15.2D, V16.2D, V17.2D }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X19]
    LD3R { V9.16B, V10.16B, V11.16B }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X19]
    LD3R { V21.2D, V22.2D, V23.2D }, [X19]
    ADD  X19, X19, X12, ASR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X19]
    LD3R { V28.4S, V29.4S, V30.4S }, [X19]
    ADD  X19, X19, X12, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X19]
    LD3R { V3.8H, V4.8H, V5.8H }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X19]
    LD3R { V21.4H, V22.4H, V23.4H }, [X19]
    ADD  X19, X19, X12
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X19]
    LD3R { V8.1D, V9.1D, V10.1D }, [X19]
    ADD  X19, X19, X12, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X19]
    LD3R { V19.2S, V20.2S, V21.2S }, [X19]
    ADD  X19, X19, X12
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X19]
    LD3R { V23.4H, V24.4H, V25.4H }, [X19]
    ADD  X19, X19, X12, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X19]
    LD3R { V19.8B, V20.8B, V21.8B }, [X19]
    ADD  X19, X19, X12, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X19]
    MOV  X3, X19
    LD3R { V13.4S, V14.4S, V15.4S }, [X3], #12
    ADD  X19, X19, X12, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X19]
    MOV  X3, X19
    LD3R { V21.2S, V22.2S, V23.2S }, [X3], #12
    ADD  X19, X19, X12, LSR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X19]
    MOV  X3, X19
    LD3R { V16.4S, V17.4S, V18.4S }, [X3], #12
    ADD  X19, X19, X12
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X19]
    MOV  X3, X19
    LD3R { V16.1D, V17.1D, V18.1D }, [X3], #24
    ADD  X19, X19, X12, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X19]
    MOV  X3, X19
    LD3R { V0.1D, V1.1D, V2.1D }, [X3], #24
    ADD  X19, X19, X12
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X19]
    MOV  X3, X19
    LD3R { V19.2D, V20.2D, V21.2D }, [X3], #24
    ADD  X19, X19, X12
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X19]
    MOV  X3, X19
    LD3R { V3.8B, V4.8B, V5.8B }, [X3], #3
    ADD  X19, X19, X12, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X19]
    MOV  X3, X19
    LD3R { V6.16B, V7.16B, V8.16B }, [X3], #3
    ADD  X19, X19, X12, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X19]
    MOV  X3, X19
    LD3R { V31.8B, V0.8B, V1.8B }, [X3], #3
    ADD  X19, X19, X12, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X19]
    MOV  X3, X19
    LD3R { V16.4H, V17.4H, V18.4H }, [X3], #6
    ADD  X19, X19, X12, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X19]
    MOV  X3, X19
    LD3R { V18.8H, V19.8H, V20.8H }, [X3], #6
    ADD  X19, X19, X12, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X19]
    MOV  X3, X19
    LD3R { V6.8H, V7.8H, V8.8H }, [X3], #6
    ADD  X19, X19, X12
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X19]
    LD3R { V27.16B, V28.16B, V29.16B }, [X19], X29
    ADD  X19, X19, X12
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X19]
    LD3R { V21.16B, V22.16B, V23.16B }, [X19], X29
    ADD  X19, X19, X12, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X19]
    LD3R { V0.2D, V1.2D, V2.2D }, [X19], X29
    ADD  X19, X19, X12, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X19]
    LD3R { V24.4S, V25.4S, V26.4S }, [X19], X29
    ADD  X19, X19, X12, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X19]
    LD3R { V11.8H, V12.8H, V13.8H }, [X19], X29
    ADD  X19, X19, X12, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X19]
    LD3R { V22.1D, V23.1D, V24.1D }, [X19], X29
    ADD  X19, X19, X12, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X19]
    LD3R { V28.1D, V29.1D, V30.1D }, [X19], X29
    ADD  X19, X19, X12
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X19]
    LD3R { V1.2S, V2.2S, V3.2S }, [X19], X29
    ADD  X19, X19, X12, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X19]
    LD3R { V3.4H, V4.4H, V5.4H }, [X19], X29
    ADD  X19, X19, X12, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X19]
    LD3R { V19.8B, V20.8B, V21.8B }, [X19], X29
    ADD  X19, X19, X12
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X14, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V0.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D0
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D1
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D2
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D3
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D4
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D5
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V6.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D6
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V7.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D7
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V8.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D8
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D9
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D10
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V11.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D11
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V12.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D12
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V13.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D13
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V14.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D14
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V15.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D15
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D16
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D17
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V18.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D18
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D19
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D20
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D21
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D22
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D23
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D24
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V25.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D25
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V26.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D26
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, V27.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D27
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D28
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D29
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D30
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X14, D31
    SUB  X25, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X19
    FMOV  D4, X28
    FMOV  V4.D[1], X7
    FMOV  D5, X17
    FMOV  V5.D[1], X19
    FMOV  D6, X28
    FMOV  V6.D[1], X27
    FMOV  D7, X3
    FMOV  V7.D[1], X28
    FMOV  D8, X27
    FMOV  V8.D[1], X18
    FMOV  D9, X17
    FMOV  V9.D[1], X20
    FMOV  D10, X12
    FMOV  V10.D[1], X8
    FMOV  D11, X29
    FMOV  V11.D[1], X25
    FMOV  D12, X3
    FMOV  V12.D[1], X24
    FMOV  D13, X15
    FMOV  V13.D[1], X24
    FMOV  D14, X7
    FMOV  V14.D[1], X11
    FMOV  D15, X27
    FMOV  V15.D[1], X27
    FMOV  D16, X3
    FMOV  V16.D[1], X10
    FMOV  D17, X15
    FMOV  V17.D[1], X7
    FMOV  D18, X25
    FMOV  V18.D[1], X21
    FMOV  D19, X3
    FMOV  V19.D[1], X11
    FMOV  D20, X2
    FMOV  V20.D[1], X2
    FMOV  D21, X29
    FMOV  V21.D[1], X16
    FMOV  D22, X10
    FMOV  V22.D[1], X12
    FMOV  D23, X28
    FMOV  V23.D[1], X21
    FMOV  D24, X20
    FMOV  V24.D[1], X12
    FMOV  D25, X14
    FMOV  V25.D[1], X11
    FMOV  D26, X27
    FMOV  V26.D[1], X10
    FMOV  D27, X27
    FMOV  V27.D[1], X21
    FMOV  D28, X25
    FMOV  V28.D[1], X28
    FMOV  D29, X14
    FMOV  V29.D[1], X20
    FMOV  D30, X21
    FMOV  V30.D[1], X29
    FMOV  D31, X8
    FMOV  V31.D[1], X24
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X15, #0x2800, LSL #0
    ADD  X2, X30, X15, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X2]
    LD3R { V24.8H, V25.8H, V26.8H }, [X2]
    ADD  X2, X2, X11, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X2]
    LD3R { V0.16B, V1.16B, V2.16B }, [X2]
    ADD  X2, X2, X11
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X2]
    LD3R { V30.2D, V31.2D, V0.2D }, [X2]
    ADD  X2, X2, X11
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X2]
    LD3R { V26.4S, V27.4S, V28.4S }, [X2]
    ADD  X2, X2, X11, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X2]
    LD3R { V4.8H, V5.8H, V6.8H }, [X2]
    ADD  X2, X2, X11, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X2]
    LD3R { V15.8B, V16.8B, V17.8B }, [X2]
    ADD  X2, X2, X11, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X2]
    LD3R { V23.1D, V24.1D, V25.1D }, [X2]
    ADD  X2, X2, X11, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X2]
    LD3R { V18.2S, V19.2S, V20.2S }, [X2]
    ADD  X2, X2, X11, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X2]
    LD3R { V2.4H, V3.4H, V4.4H }, [X2]
    ADD  X2, X2, X11
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X2]
    LD3R { V16.8B, V17.8B, V18.8B }, [X2]
    ADD  X2, X2, X11, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X2]
    MOV  X10, X2
    LD3R { V10.4S, V11.4S, V12.4S }, [X10], #12
    ADD  X2, X2, X11, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X2]
    MOV  X10, X2
    LD3R { V1.2S, V2.2S, V3.2S }, [X10], #12
    ADD  X2, X2, X11, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X2]
    MOV  X10, X2
    LD3R { V2.4S, V3.4S, V4.4S }, [X10], #12
    ADD  X2, X2, X11, ASR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X2]
    MOV  X10, X2
    LD3R { V4.2D, V5.2D, V6.2D }, [X10], #24
    ADD  X2, X2, X11, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X2]
    MOV  X10, X2
    LD3R { V7.1D, V8.1D, V9.1D }, [X10], #24
    ADD  X2, X2, X11
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X2]
    MOV  X10, X2
    LD3R { V19.2D, V20.2D, V21.2D }, [X10], #24
    ADD  X2, X2, X11, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X2]
    MOV  X10, X2
    LD3R { V28.16B, V29.16B, V30.16B }, [X10], #3
    ADD  X2, X2, X11, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X2]
    MOV  X10, X2
    LD3R { V0.16B, V1.16B, V2.16B }, [X10], #3
    ADD  X2, X2, X11
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X2]
    MOV  X10, X2
    LD3R { V23.8B, V24.8B, V25.8B }, [X10], #3
    ADD  X2, X2, X11
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X2]
    MOV  X10, X2
    LD3R { V30.4H, V31.4H, V0.4H }, [X10], #6
    ADD  X2, X2, X11, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X2]
    MOV  X10, X2
    LD3R { V19.8H, V20.8H, V21.8H }, [X10], #6
    ADD  X2, X2, X11, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X2]
    MOV  X10, X2
    LD3R { V15.4H, V16.4H, V17.4H }, [X10], #6
    ADD  X2, X2, X11
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X2]
    LD3R { V6.2D, V7.2D, V8.2D }, [X2], X12
    ADD  X2, X2, X11
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X2]
    LD3R { V13.16B, V14.16B, V15.16B }, [X2], X12
    ADD  X2, X2, X11, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X2]
    LD3R { V29.2D, V30.2D, V31.2D }, [X2], X12
    ADD  X2, X2, X11, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X2]
    LD3R { V15.4S, V16.4S, V17.4S }, [X2], X12
    ADD  X2, X2, X11, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X2]
    LD3R { V22.8H, V23.8H, V24.8H }, [X2], X12
    ADD  X2, X2, X11
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X2]
    LD3R { V16.8B, V17.8B, V18.8B }, [X2], X12
    ADD  X2, X2, X11
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X2]
    LD3R { V1.1D, V2.1D, V3.1D }, [X2], X12
    ADD  X2, X2, X11, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X2]
    LD3R { V29.2S, V30.2S, V31.2S }, [X2], X12
    ADD  X2, X2, X11, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X2]
    LD3R { V7.4H, V8.4H, V9.4H }, [X2], X12
    ADD  X2, X2, X11
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X2]
    LD3R { V10.8B, V11.8B, V12.8B }, [X2], X12
    ADD  X2, X2, X11, LSR #0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X19, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V0.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D0
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V1.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D1
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V2.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D2
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V3.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D3
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D4
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V5.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D5
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D6
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D7
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D8
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D9
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D10
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D11
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D12
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V13.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D13
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D14
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V15.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D15
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V16.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D16
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V17.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D17
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V18.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D18
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V19.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D19
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V20.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D20
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V21.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D21
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D22
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V23.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D23
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V24.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D24
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V25.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D25
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V26.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D26
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V27.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D27
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, V28.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D28
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V29.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D29
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D30
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X19, D31
    SUB  X29, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP03_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X10
    FMOV  V3.D[1], X2
    FMOV  D4, X10
    FMOV  V4.D[1], X28
    FMOV  D5, X25
    FMOV  V5.D[1], X12
    FMOV  D6, X24
    FMOV  V6.D[1], X12
    FMOV  D7, X2
    FMOV  V7.D[1], X28
    FMOV  D8, X14
    FMOV  V8.D[1], X16
    FMOV  D9, X11
    FMOV  V9.D[1], X27
    FMOV  D10, X26
    FMOV  V10.D[1], X9
    FMOV  D11, X18
    FMOV  V11.D[1], X24
    FMOV  D12, X12
    FMOV  V12.D[1], X3
    FMOV  D13, X16
    FMOV  V13.D[1], X4
    FMOV  D14, X29
    FMOV  V14.D[1], X21
    FMOV  D15, X24
    FMOV  V15.D[1], X15
    FMOV  D16, X16
    FMOV  V16.D[1], X26
    FMOV  D17, X29
    FMOV  V17.D[1], X20
    FMOV  D18, X7
    FMOV  V18.D[1], X18
    FMOV  D19, X18
    FMOV  V19.D[1], X18
    FMOV  D20, X17
    FMOV  V20.D[1], X18
    FMOV  D21, X12
    FMOV  V21.D[1], X18
    FMOV  D22, X8
    FMOV  V22.D[1], X3
    FMOV  D23, X16
    FMOV  V23.D[1], X9
    FMOV  D24, X14
    FMOV  V24.D[1], X4
    FMOV  D25, X27
    FMOV  V25.D[1], X16
    FMOV  D26, X27
    FMOV  V26.D[1], X20
    FMOV  D27, X3
    FMOV  V27.D[1], X21
    FMOV  D28, X27
    FMOV  V28.D[1], X11
    FMOV  D29, X3
    FMOV  V29.D[1], X4
    FMOV  D30, X28
    FMOV  V30.D[1], X13
    FMOV  D31, X9
    FMOV  V31.D[1], X18
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X18, #0x2d00, LSL #0
    ADD  X11, X30, X18, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X11]
    LD3R { V14.4S, V15.4S, V16.4S }, [X11]
    ADD  X11, X11, X25, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X11]
    LD3R { V21.16B, V22.16B, V23.16B }, [X11]
    ADD  X11, X11, X25, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X11]
    LD3R { V15.2D, V16.2D, V17.2D }, [X11]
    ADD  X11, X11, X25, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X11]
    LD3R { V3.4S, V4.4S, V5.4S }, [X11]
    ADD  X11, X11, X25, ASR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X11]
    LD3R { V15.8H, V16.8H, V17.8H }, [X11]
    ADD  X11, X11, X25
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X11]
    LD3R { V2.8B, V3.8B, V4.8B }, [X11]
    ADD  X11, X11, X25
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X11]
    LD3R { V15.1D, V16.1D, V17.1D }, [X11]
    ADD  X11, X11, X25, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X11]
    LD3R { V7.2S, V8.2S, V9.2S }, [X11]
    ADD  X11, X11, X25, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X11]
    LD3R { V18.4H, V19.4H, V20.4H }, [X11]
    ADD  X11, X11, X25, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X11]
    LD3R { V4.8B, V5.8B, V6.8B }, [X11]
    ADD  X11, X11, X25, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X11]
    MOV  X10, X11
    LD3R { V26.2S, V27.2S, V28.2S }, [X10], #12
    ADD  X11, X11, X25
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X11]
    MOV  X10, X11
    LD3R { V16.2S, V17.2S, V18.2S }, [X10], #12
    ADD  X11, X11, X25, ASR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X11]
    MOV  X10, X11
    LD3R { V11.4S, V12.4S, V13.4S }, [X10], #12
    ADD  X11, X11, X25
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X11]
    MOV  X10, X11
    LD3R { V7.2D, V8.2D, V9.2D }, [X10], #24
    ADD  X11, X11, X25, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X11]
    MOV  X10, X11
    LD3R { V23.1D, V24.1D, V25.1D }, [X10], #24
    ADD  X11, X11, X25, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X11]
    MOV  X10, X11
    LD3R { V10.2D, V11.2D, V12.2D }, [X10], #24
    ADD  X11, X11, X25, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X11]
    MOV  X10, X11
    LD3R { V11.16B, V12.16B, V13.16B }, [X10], #3
    ADD  X11, X11, X25, LSR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X11]
    MOV  X10, X11
    LD3R { V26.16B, V27.16B, V28.16B }, [X10], #3
    ADD  X11, X11, X25, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X11]
    MOV  X10, X11
    LD3R { V21.8B, V22.8B, V23.8B }, [X10], #3
    ADD  X11, X11, X25, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X11]
    MOV  X10, X11
    LD3R { V8.4H, V9.4H, V10.4H }, [X10], #6
    ADD  X11, X11, X25, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X11]
    MOV  X10, X11
    LD3R { V9.8H, V10.8H, V11.8H }, [X10], #6
    ADD  X11, X11, X25, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X11]
    MOV  X10, X11
    LD3R { V6.4H, V7.4H, V8.4H }, [X10], #6
    ADD  X11, X11, X25, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X11]
    LD3R { V21.8H, V22.8H, V23.8H }, [X11], X29
    ADD  X11, X11, X25, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X11]
    LD3R { V5.16B, V6.16B, V7.16B }, [X11], X29
    ADD  X11, X11, X25, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X11]
    LD3R { V24.2D, V25.2D, V26.2D }, [X11], X29
    ADD  X11, X11, X25
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X11]
    LD3R { V20.4S, V21.4S, V22.4S }, [X11], X29
    ADD  X11, X11, X25
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X11]
    LD3R { V9.8H, V10.8H, V11.8H }, [X11], X29
    ADD  X11, X11, X25
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X11]
    LD3R { V13.2S, V14.2S, V15.2S }, [X11], X29
    ADD  X11, X11, X25
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X11]
    LD3R { V24.1D, V25.1D, V26.1D }, [X11], X29
    ADD  X11, X11, X25, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X11]
    LD3R { V11.2S, V12.2S, V13.2S }, [X11], X29
    ADD  X11, X11, X25, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X11]
    LD3R { V12.4H, V13.4H, V14.4H }, [X11], X29
    ADD  X11, X11, X25, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X11]
    LD3R { V10.8B, V11.8B, V12.8B }, [X11], X29
    ADD  X11, X11, X25, LSR #0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X12, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V0.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D0
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D1
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D2
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D3
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D4
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D5
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V6.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D6
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V7.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D7
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D8
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V9.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D9
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D10
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D11
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D12
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V13.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D13
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D14
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D15
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D16
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D17
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D18
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D19
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V20.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D20
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V21.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D21
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V22.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D22
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V23.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D23
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D24
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D25
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D26
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D27
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V28.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D28
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V29.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D29
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D30
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X12, D31
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP03_TestFail

AdvsimdLoadDeprecatedP03_TestEnd:
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
AdvsimdLoadDeprecatedP03_TestFail:
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
