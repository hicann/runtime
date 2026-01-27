.global AdvsimdLoadStoreP01

.text
.p2align 4

AdvsimdLoadStoreP01:

AdvsimdLoadStoreP01_TestBegin:
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
    MOVZ  X4, #0xc04c, LSL #0
    MOVK  X4, #0xafb7, LSL #16
    MOVK  X4, #0x71c7, LSL #32
    MOVK  X4, #0x3b33, LSL #48
    MOVZ  X5, #0xc076, LSL #0
    MOVK  X5, #0x7e44, LSL #16
    MOVK  X5, #0x753b, LSL #32
    MOVK  X5, #0xa34a, LSL #48
    MOVZ  X6, #0x30e1, LSL #0
    MOVK  X6, #0x6524, LSL #16
    MOVK  X6, #0xd311, LSL #32
    MOVK  X6, #0xc44e, LSL #48
    MOVZ  X7, #0x2231, LSL #0
    MOVK  X7, #0x463, LSL #16
    MOVK  X7, #0xe8dd, LSL #32
    MOVK  X7, #0xdfe7, LSL #48
    MOVZ  X9, #0x2748, LSL #0
    MOVK  X9, #0x29b1, LSL #16
    MOVK  X9, #0x9922, LSL #32
    MOVK  X9, #0xba8c, LSL #48
    MOVZ  X10, #0x134d, LSL #0
    MOVK  X10, #0x8e8f, LSL #16
    MOVK  X10, #0xd57c, LSL #32
    MOVK  X10, #0xf434, LSL #48
    MOVZ  X11, #0x3143, LSL #0
    MOVK  X11, #0x7968, LSL #16
    MOVK  X11, #0xedfd, LSL #32
    MOVK  X11, #0xf990, LSL #48
    MOVZ  X12, #0x2190, LSL #0
    MOVK  X12, #0x9ef3, LSL #16
    MOVK  X12, #0x1538, LSL #32
    MOVK  X12, #0x3d4d, LSL #48
    MOVZ  X13, #0xadd9, LSL #0
    MOVK  X13, #0xa338, LSL #16
    MOVK  X13, #0xeb6c, LSL #32
    MOVK  X13, #0x75b6, LSL #48
    MOVZ  X14, #0x5687, LSL #0
    MOVK  X14, #0x68a0, LSL #16
    MOVK  X14, #0x3bf1, LSL #32
    MOVK  X14, #0x19cc, LSL #48
    MOVZ  X15, #0xbd35, LSL #0
    MOVK  X15, #0x2616, LSL #16
    MOVK  X15, #0x2943, LSL #32
    MOVK  X15, #0xfb37, LSL #48
    MOVZ  X16, #0xe335, LSL #0
    MOVK  X16, #0xe5ef, LSL #16
    MOVK  X16, #0x25cb, LSL #32
    MOVK  X16, #0xff4e, LSL #48
    MOVZ  X17, #0xcb07, LSL #0
    MOVK  X17, #0x3a79, LSL #16
    MOVK  X17, #0xf69c, LSL #32
    MOVK  X17, #0xff44, LSL #48
    MOVZ  X18, #0x1363, LSL #0
    MOVK  X18, #0x33f1, LSL #16
    MOVK  X18, #0xe5f0, LSL #32
    MOVK  X18, #0x9f35, LSL #48
    MOVZ  X19, #0xa15, LSL #0
    MOVK  X19, #0xe819, LSL #16
    MOVK  X19, #0x314, LSL #32
    MOVK  X19, #0x657a, LSL #48
    MOVZ  X20, #0xb1a5, LSL #0
    MOVK  X20, #0x4832, LSL #16
    MOVK  X20, #0xd2c0, LSL #32
    MOVK  X20, #0xff29, LSL #48
    MOVZ  X21, #0xf52e, LSL #0
    MOVK  X21, #0xb67a, LSL #16
    MOVK  X21, #0x8ce8, LSL #32
    MOVK  X21, #0x9f8, LSL #48
    MOVZ  X22, #0x7bf1, LSL #0
    MOVK  X22, #0xe7bb, LSL #16
    MOVK  X22, #0x905, LSL #32
    MOVK  X22, #0xd164, LSL #48
    MOVZ  X23, #0x9745, LSL #0
    MOVK  X23, #0xc5fc, LSL #16
    MOVK  X23, #0x44b9, LSL #32
    MOVK  X23, #0xd6b5, LSL #48
    MOVZ  X24, #0xe53c, LSL #0
    MOVK  X24, #0x5074, LSL #16
    MOVK  X24, #0x8ef0, LSL #32
    MOVK  X24, #0xa127, LSL #48
    MOVZ  X25, #0x32c8, LSL #0
    MOVK  X25, #0xe16, LSL #16
    MOVK  X25, #0x4e07, LSL #32
    MOVK  X25, #0xaed2, LSL #48
    MOVZ  X26, #0x2a2b, LSL #0
    MOVK  X26, #0x1348, LSL #16
    MOVK  X26, #0x71da, LSL #32
    MOVK  X26, #0x35d4, LSL #48
    MOVZ  X28, #0x6d94, LSL #0
    MOVK  X28, #0xdd8b, LSL #16
    MOVK  X28, #0xaa47, LSL #32
    MOVK  X28, #0x714c, LSL #48
    MOVZ  X29, #0x5e71, LSL #0
    MOVK  X29, #0x39ff, LSL #16
    MOVK  X29, #0x30cc, LSL #32
    MOVK  X29, #0x71d3, LSL #48
    MOVZ  X16, #0x5972, LSL #0
    MOVK  X16, #0x5e6a, LSL #16
    MOVK  X16, #0x9a6d, LSL #32
    MOVK  X16, #0xd77, LSL #48
    MSR  FPCR, X16
    MOVZ  X16, #0x9d1c, LSL #0
    MOVK  X16, #0x5aac, LSL #16
    MOVK  X16, #0x3d80, LSL #32
    MOVK  X16, #0x1f05, LSL #48
    MSR  FPSR, X16
    MRS  X28, FPSR
    MOVZ  X26, #0xff60, LSL #0
    MOVK  X26, #0x7ff, LSL #16
    MOVK  X26, #0xffff, LSL #32
    MOVK  X26, #0xffff, LSL #48
    AND  X28, X28, X26
    MOVZ  X26, #0x0, LSL #0
    ORR  X28, X28, X26
    MSR  FPSR, X28
    ISB  SY
    ANDS  X4, X10, #0xffffffffc00001ff
    MOV  X30, X1
    MOVZ  X1, #0x0, LSL #0
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X21
    FMOV  D1, X24
    FMOV  V1.D[1], X29
    FMOV  D2, X23
    FMOV  V2.D[1], X28
    FMOV  D3, X25
    FMOV  V3.D[1], X17
    FMOV  D4, X17
    FMOV  V4.D[1], X7
    FMOV  D5, X5
    FMOV  V5.D[1], X4
    FMOV  D6, X7
    FMOV  V6.D[1], X11
    FMOV  D7, X7
    FMOV  V7.D[1], X4
    FMOV  D8, X18
    FMOV  V8.D[1], X13
    FMOV  D9, X29
    FMOV  V9.D[1], X16
    FMOV  D10, X21
    FMOV  V10.D[1], X5
    FMOV  D11, X23
    FMOV  V11.D[1], X23
    FMOV  D12, X21
    FMOV  V12.D[1], X24
    FMOV  D13, X4
    FMOV  V13.D[1], X11
    FMOV  D14, X4
    FMOV  V14.D[1], X16
    FMOV  D15, X28
    FMOV  V15.D[1], X5
    FMOV  D16, X7
    FMOV  V16.D[1], X21
    FMOV  D17, X26
    FMOV  V17.D[1], X13
    FMOV  D18, X7
    FMOV  V18.D[1], X11
    FMOV  D19, X25
    FMOV  V19.D[1], X17
    FMOV  D20, X20
    FMOV  V20.D[1], X21
    FMOV  D21, X25
    FMOV  V21.D[1], X24
    FMOV  D22, X15
    FMOV  V22.D[1], X17
    FMOV  D23, X15
    FMOV  V23.D[1], X20
    FMOV  D24, X6
    FMOV  V24.D[1], X26
    FMOV  D25, X26
    FMOV  V25.D[1], X14
    FMOV  D26, X10
    FMOV  V26.D[1], X11
    FMOV  D27, X19
    FMOV  V27.D[1], X14
    FMOV  D28, X6
    FMOV  V28.D[1], X23
    FMOV  D29, X17
    FMOV  V29.D[1], X23
    FMOV  D30, X18
    FMOV  V30.D[1], X29
    FMOV  D31, X13
    FMOV  V31.D[1], X17
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X7, #0x0, LSL #0
    ADD  X23, X30, X7, LSR #0
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X23]
    LD1 { V31.16B, V0.16B, V1.16B, V2.16B }, [X23]
    ADD  X23, X23, X25
    ST1 { V30.16B, V31.16B, V0.16B, V1.16B }, [X23]
    LD1 { V1.16B, V2.16B, V3.16B, V4.16B }, [X23]
    ADD  X23, X23, X25
    ST1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X23]
    LD1 { V20.2D, V21.2D, V22.2D, V23.2D }, [X23]
    ADD  X23, X23, X25, LSR #0
    ST1 { V20.4S, V21.4S, V22.4S, V23.4S }, [X23]
    LD1 { V0.4S, V1.4S, V2.4S, V3.4S }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V0.8H, V1.8H, V2.8H, V3.8H }, [X23]
    LD1 { V0.8H, V1.8H, V2.8H, V3.8H }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V0.2S, V1.2S, V2.2S, V3.2S }, [X23]
    LD1 { V0.8B, V1.8B, V2.8B, V3.8B }, [X23]
    ADD  X23, X23, X25, LSR #0
    ST1 { V24.1D, V25.1D, V26.1D, V27.1D }, [X23]
    LD1 { V24.1D, V25.1D, V26.1D, V27.1D }, [X23]
    ADD  X23, X23, X25
    ST1 { V0.2S, V1.2S, V2.2S, V3.2S }, [X23]
    LD1 { V20.2S, V21.2S, V22.2S, V23.2S }, [X23]
    ADD  X23, X23, X25, LSR #0
    ST1 { V24.4H, V25.4H, V26.4H, V27.4H }, [X23]
    LD1 { V0.4H, V1.4H, V2.4H, V3.4H }, [X23]
    ADD  X23, X23, X25, LSR #0
    ST1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X23]
    LD1 { V22.8B, V23.8B, V24.8B, V25.8B }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V3.4S }, [X23]
    LD1 { V27.4S }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V1.16B }, [X23]
    LD1 { V26.16B }, [X23]
    ADD  X23, X23, X25
    ST1 { V27.2D }, [X23]
    LD1 { V27.2D }, [X23]
    ADD  X23, X23, X25
    ST1 { V26.4S }, [X23]
    LD1 { V20.4S }, [X23]
    ADD  X23, X23, X25, LSR #0
    ST1 { V25.8H }, [X23]
    LD1 { V3.8H }, [X23]
    ADD  X23, X23, X25, LSR #0
    ST1 { V0.2S }, [X23]
    LD1 { V25.8B }, [X23]
    ADD  X23, X23, X25
    ST1 { V2.1D }, [X23]
    LD1 { V2.1D }, [X23]
    ADD  X23, X23, X25, LSR #0
    ST1 { V23.2S }, [X23]
    LD1 { V1.2S }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V20.4H }, [X23]
    LD1 { V26.4H }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V1.8B }, [X23]
    LD1 { V23.8B }, [X23]
    ADD  X23, X23, X25
    ST1 { V0.2D, V1.2D, V2.2D }, [X23]
    LD1 { V0.8H, V1.8H, V2.8H }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V29.16B, V30.16B, V31.16B }, [X23]
    LD1 { V7.16B, V8.16B, V9.16B }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V0.2D, V1.2D, V2.2D }, [X23]
    LD1 { V27.2D, V28.2D, V29.2D }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V7.4S, V8.4S, V9.4S }, [X23]
    LD1 { V19.4S, V20.4S, V21.4S }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V26.8H, V27.8H, V28.8H }, [X23]
    LD1 { V24.8H, V25.8H, V26.8H }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V24.4H, V25.4H, V26.4H }, [X23]
    LD1 { V20.8B, V21.8B, V22.8B }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V20.1D, V21.1D, V22.1D }, [X23]
    LD1 { V20.1D, V21.1D, V22.1D }, [X23]
    ADD  X23, X23, X25
    ST1 { V13.2S, V14.2S, V15.2S }, [X23]
    LD1 { V9.2S, V10.2S, V11.2S }, [X23]
    ADD  X23, X23, X25, LSR #0
    ST1 { V13.4H, V14.4H, V15.4H }, [X23]
    LD1 { V0.4H, V1.4H, V2.4H }, [X23]
    ADD  X23, X23, X25, ASR #0
    ST1 { V9.8B, V10.8B, V11.8B }, [X23]
    LD1 { V25.8B, V26.8B, V27.8B }, [X23]
    ADD  X23, X23, X25
    ST1 { V0.2D, V1.2D }, [X23]
    LD1 { V14.8H, V15.8H }, [X23]
    ADD  X23, X23, X25, LSR #0
    ST1 { V14.16B, V15.16B }, [X23]
    LD1 { V0.16B, V1.16B }, [X23]
    ADD  X23, X23, X25
    ST1 { V20.2D, V21.2D }, [X23]
    LD1 { V9.2D, V10.2D }, [X23]
    ADD  X23, X23, X25
    ST1 { V9.4S, V10.4S }, [X23]
    LD1 { V9.4S, V10.4S }, [X23]
    ADD  X23, X23, X25
    ST1 { V10.8H, V11.8H }, [X23]
    LD1 { V20.8H, V21.8H }, [X23]
    ADD  X23, X23, X25, LSR #0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X10, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D0
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D1
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D2
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D3
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V4.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D4
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V5.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D5
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V6.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D6
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V7.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D7
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V8.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D8
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D9
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D10
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D11
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V12.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D12
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V13.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D13
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D14
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D15
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V16.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D16
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V17.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D17
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V18.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D18
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V19.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D19
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D20
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D21
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D22
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D23
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D24
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D25
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D26
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D27
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D28
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D29
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V30.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D30
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, V31.D[1]
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    FMOV  X10, D31
    SUB  X11, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X22
    FMOV  V2.D[1], X23
    FMOV  D3, X25
    FMOV  V3.D[1], X23
    FMOV  D4, X18
    FMOV  V4.D[1], X10
    FMOV  D5, X12
    FMOV  V5.D[1], X12
    FMOV  D6, X5
    FMOV  V6.D[1], X26
    FMOV  D7, X13
    FMOV  V7.D[1], X22
    FMOV  D8, X13
    FMOV  V8.D[1], X23
    FMOV  D9, X11
    FMOV  V9.D[1], X7
    FMOV  D10, X7
    FMOV  V10.D[1], X16
    FMOV  D11, X9
    FMOV  V11.D[1], X25
    FMOV  D12, X9
    FMOV  V12.D[1], X9
    FMOV  D13, X28
    FMOV  V13.D[1], X12
    FMOV  D14, X26
    FMOV  V14.D[1], X18
    FMOV  D15, X5
    FMOV  V15.D[1], X11
    FMOV  D16, X7
    FMOV  V16.D[1], X26
    FMOV  D17, X29
    FMOV  V17.D[1], X17
    FMOV  D18, X9
    FMOV  V18.D[1], X7
    FMOV  D19, X17
    FMOV  V19.D[1], X4
    FMOV  D20, X13
    FMOV  V20.D[1], X20
    FMOV  D21, X28
    FMOV  V21.D[1], X18
    FMOV  D22, X25
    FMOV  V22.D[1], X16
    FMOV  D23, X5
    FMOV  V23.D[1], X14
    FMOV  D24, X14
    FMOV  V24.D[1], X6
    FMOV  D25, X9
    FMOV  V25.D[1], X16
    FMOV  D26, X5
    FMOV  V26.D[1], X4
    FMOV  D27, X26
    FMOV  V27.D[1], X29
    FMOV  D28, X29
    FMOV  V28.D[1], X20
    FMOV  D29, X16
    FMOV  V29.D[1], X23
    FMOV  D30, X15
    FMOV  V30.D[1], X16
    FMOV  D31, X29
    FMOV  V31.D[1], X5
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X9, #0x500, LSL #0
    ADD  X29, X30, X9
    ST1 { V21.8H, V22.8H, V23.8H, V24.8H }, [X29]
    LD1 { V20.2D, V21.2D, V22.2D, V23.2D }, [X29]
    ADD  X29, X29, X17
    ST1 { V28.16B, V29.16B, V30.16B, V31.16B }, [X29]
    LD1 { V27.16B, V28.16B, V29.16B, V30.16B }, [X29]
    ADD  X29, X29, X17
    ST1 { V27.2D, V28.2D, V29.2D, V30.2D }, [X29]
    LD1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X29]
    ADD  X29, X29, X17
    ST1 { V1.4S, V2.4S, V3.4S, V4.4S }, [X29]
    LD1 { V11.4S, V12.4S, V13.4S, V14.4S }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V11.8H, V12.8H, V13.8H, V14.8H }, [X29]
    LD1 { V24.8H, V25.8H, V26.8H, V27.8H }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X29]
    LD1 { V1.4H, V2.4H, V3.4H, V4.4H }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V1.1D, V2.1D, V3.1D, V4.1D }, [X29]
    LD1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V2.2S, V3.2S, V4.2S, V5.2S }, [X29]
    LD1 { V2.2S, V3.2S, V4.2S, V5.2S }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V2.4H, V3.4H, V4.4H, V5.4H }, [X29]
    LD1 { V14.4H, V15.4H, V16.4H, V17.4H }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V1.8B, V2.8B, V3.8B, V4.8B }, [X29]
    LD1 { V25.8B, V26.8B, V27.8B, V28.8B }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V24.8H }, [X29]
    LD1 { V21.2D }, [X29]
    ADD  X29, X29, X17
    ST1 { V15.16B }, [X29]
    LD1 { V4.16B }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V4.2D }, [X29]
    LD1 { V22.2D }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V28.4S }, [X29]
    LD1 { V28.4S }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V28.8H }, [X29]
    LD1 { V4.8H }, [X29]
    ADD  X29, X29, X17
    ST1 { V16.4H }, [X29]
    LD1 { V16.8B }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V25.1D }, [X29]
    LD1 { V15.1D }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V4.2S }, [X29]
    LD1 { V25.2S }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V15.4H }, [X29]
    LD1 { V15.4H }, [X29]
    ADD  X29, X29, X17
    ST1 { V22.8B }, [X29]
    LD1 { V22.8B }, [X29]
    ADD  X29, X29, X17
    ST1 { V19.4S, V20.4S, V21.4S }, [X29]
    LD1 { V10.16B, V11.16B, V12.16B }, [X29]
    ADD  X29, X29, X17
    ST1 { V10.16B, V11.16B, V12.16B }, [X29]
    LD1 { V10.16B, V11.16B, V12.16B }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V10.2D, V11.2D, V12.2D }, [X29]
    LD1 { V19.2D, V20.2D, V21.2D }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V3.4S, V4.4S, V5.4S }, [X29]
    LD1 { V3.4S, V4.4S, V5.4S }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V3.8H, V4.8H, V5.8H }, [X29]
    LD1 { V3.8H, V4.8H, V5.8H }, [X29]
    ADD  X29, X29, X17
    ST1 { V3.1D, V4.1D, V5.1D }, [X29]
    LD1 { V3.1D, V4.1D, V5.1D }, [X29]
    ADD  X29, X29, X17
    ST1 { V21.1D, V22.1D, V23.1D }, [X29]
    LD1 { V10.1D, V11.1D, V12.1D }, [X29]
    ADD  X29, X29, X17
    ST1 { V3.2S, V4.2S, V5.2S }, [X29]
    LD1 { V3.2S, V4.2S, V5.2S }, [X29]
    ADD  X29, X29, X17
    ST1 { V10.4H, V11.4H, V12.4H }, [X29]
    LD1 { V10.4H, V11.4H, V12.4H }, [X29]
    ADD  X29, X29, X17
    ST1 { V18.8B, V19.8B, V20.8B }, [X29]
    LD1 { V20.8B, V21.8B, V22.8B }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V4.8H, V5.8H }, [X29]
    LD1 { V19.8H, V20.8H }, [X29]
    ADD  X29, X29, X17, LSR #0
    ST1 { V19.16B, V20.16B }, [X29]
    LD1 { V4.16B, V5.16B }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V16.2D, V17.2D }, [X29]
    LD1 { V16.2D, V17.2D }, [X29]
    ADD  X29, X29, X17, ASR #0
    ST1 { V11.4S, V12.4S }, [X29]
    LD1 { V19.4S, V20.4S }, [X29]
    ADD  X29, X29, X17
    ST1 { V4.8H, V5.8H }, [X29]
    LD1 { V11.8H, V12.8H }, [X29]
    ADD  X29, X29, X17, ASR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X24, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V0.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D0
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D1
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D2
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D3
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D4
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D5
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V6.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D6
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V7.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D7
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V8.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D8
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V9.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D9
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D10
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D11
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D12
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V13.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D13
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D14
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D15
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D16
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D17
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V18.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D18
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D19
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D20
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D21
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D22
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V23.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D23
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V24.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D24
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D25
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D26
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D27
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D28
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V29.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D29
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V30.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D30
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, V31.D[1]
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X24, D31
    SUB  X11, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X23
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X25
    FMOV  V3.D[1], X13
    FMOV  D4, X18
    FMOV  V4.D[1], X25
    FMOV  D5, X11
    FMOV  V5.D[1], X7
    FMOV  D6, X17
    FMOV  V6.D[1], X23
    FMOV  D7, X17
    FMOV  V7.D[1], X5
    FMOV  D8, X18
    FMOV  V8.D[1], X29
    FMOV  D9, X10
    FMOV  V9.D[1], X6
    FMOV  D10, X5
    FMOV  V10.D[1], X24
    FMOV  D11, X9
    FMOV  V11.D[1], X7
    FMOV  D12, X20
    FMOV  V12.D[1], X20
    FMOV  D13, X13
    FMOV  V13.D[1], X11
    FMOV  D14, X16
    FMOV  V14.D[1], X28
    FMOV  D15, X17
    FMOV  V15.D[1], X29
    FMOV  D16, X7
    FMOV  V16.D[1], X25
    FMOV  D17, X11
    FMOV  V17.D[1], X22
    FMOV  D18, X17
    FMOV  V18.D[1], X6
    FMOV  D19, X18
    FMOV  V19.D[1], X5
    FMOV  D20, X25
    FMOV  V20.D[1], X20
    FMOV  D21, X7
    FMOV  V21.D[1], X18
    FMOV  D22, X21
    FMOV  V22.D[1], X23
    FMOV  D23, X11
    FMOV  V23.D[1], X18
    FMOV  D24, X5
    FMOV  V24.D[1], X13
    FMOV  D25, X7
    FMOV  V25.D[1], X14
    FMOV  D26, X15
    FMOV  V26.D[1], X21
    FMOV  D27, X4
    FMOV  V27.D[1], X10
    FMOV  D28, X11
    FMOV  V28.D[1], X6
    FMOV  D29, X15
    FMOV  V29.D[1], X16
    FMOV  D30, X5
    FMOV  V30.D[1], X16
    FMOV  D31, X14
    FMOV  V31.D[1], X9
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X13, #0xa00, LSL #0
    ADD  X20, X30, X13, ASR #0
    ST1 { V27.16B, V28.16B, V29.16B, V30.16B }, [X20]
    LD1 { V25.2D, V26.2D, V27.2D, V28.2D }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X20]
    LD1 { V15.16B, V16.16B, V17.16B, V18.16B }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V15.2D, V16.2D, V17.2D, V18.2D }, [X20]
    LD1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V29.4S, V30.4S, V31.4S, V0.4S }, [X20]
    LD1 { V6.4S, V7.4S, V8.4S, V9.4S }, [X20]
    ADD  X20, X20, X4
    ST1 { V6.8H, V7.8H, V8.8H, V9.8H }, [X20]
    LD1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X20]
    ADD  X20, X20, X4, ASR #0
    ST1 { V19.2S, V20.2S, V21.2S, V22.2S }, [X20]
    LD1 { V5.1D, V6.1D, V7.1D, V8.1D }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X20]
    LD1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V29.2S, V30.2S, V31.2S, V0.2S }, [X20]
    LD1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V5.4H, V6.4H, V7.4H, V8.4H }, [X20]
    LD1 { V13.4H, V14.4H, V15.4H, V16.4H }, [X20]
    ADD  X20, X20, X4, ASR #0
    ST1 { V30.8B, V31.8B, V0.8B, V1.8B }, [X20]
    LD1 { V6.8B, V7.8B, V8.8B, V9.8B }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V7.16B }, [X20]
    LD1 { V29.8H }, [X20]
    ADD  X20, X20, X4
    ST1 { V17.16B }, [X20]
    LD1 { V25.16B }, [X20]
    ADD  X20, X20, X4, ASR #0
    ST1 { V19.2D }, [X20]
    LD1 { V24.2D }, [X20]
    ADD  X20, X20, X4, ASR #0
    ST1 { V27.4S }, [X20]
    LD1 { V27.4S }, [X20]
    ADD  X20, X20, X4, ASR #0
    ST1 { V15.8H }, [X20]
    LD1 { V31.8H }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V24.8B }, [X20]
    LD1 { V19.1D }, [X20]
    ADD  X20, X20, X4
    ST1 { V25.1D }, [X20]
    LD1 { V15.1D }, [X20]
    ADD  X20, X20, X4, ASR #0
    ST1 { V15.2S }, [X20]
    LD1 { V15.2S }, [X20]
    ADD  X20, X20, X4
    ST1 { V27.4H }, [X20]
    LD1 { V24.4H }, [X20]
    ADD  X20, X20, X4, ASR #0
    ST1 { V9.8B }, [X20]
    LD1 { V25.8B }, [X20]
    ADD  X20, X20, X4
    ST1 { V2.16B, V3.16B, V4.16B }, [X20]
    LD1 { V2.2D, V3.2D, V4.2D }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V25.16B, V26.16B, V27.16B }, [X20]
    LD1 { V25.16B, V26.16B, V27.16B }, [X20]
    ADD  X20, X20, X4
    ST1 { V25.2D, V26.2D, V27.2D }, [X20]
    LD1 { V11.2D, V12.2D, V13.2D }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V2.4S, V3.4S, V4.4S }, [X20]
    LD1 { V21.4S, V22.4S, V23.4S }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V22.8H, V23.8H, V24.8H }, [X20]
    LD1 { V5.8H, V6.8H, V7.8H }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V11.2S, V12.2S, V13.2S }, [X20]
    LD1 { V22.2S, V23.2S, V24.2S }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V22.1D, V23.1D, V24.1D }, [X20]
    LD1 { V18.1D, V19.1D, V20.1D }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V5.2S, V6.2S, V7.2S }, [X20]
    LD1 { V23.2S, V24.2S, V25.2S }, [X20]
    ADD  X20, X20, X4
    ST1 { V18.4H, V19.4H, V20.4H }, [X20]
    LD1 { V2.4H, V3.4H, V4.4H }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V23.8B, V24.8B, V25.8B }, [X20]
    LD1 { V18.8B, V19.8B, V20.8B }, [X20]
    ADD  X20, X20, X4, ASR #0
    ST1 { V2.8H, V3.8H }, [X20]
    LD1 { V6.16B, V7.16B }, [X20]
    ADD  X20, X20, X4, ASR #0
    ST1 { V6.16B, V7.16B }, [X20]
    LD1 { V26.16B, V27.16B }, [X20]
    ADD  X20, X20, X4
    ST1 { V22.2D, V23.2D }, [X20]
    LD1 { V5.2D, V6.2D }, [X20]
    ADD  X20, X20, X4, LSR #0
    ST1 { V26.4S, V27.4S }, [X20]
    LD1 { V22.4S, V23.4S }, [X20]
    ADD  X20, X20, X4
    ST1 { V29.8H, V30.8H }, [X20]
    LD1 { V12.8H, V13.8H }, [X20]
    ADD  X20, X20, X4, LSR #0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X9, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D0
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, V1.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D1
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D2
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D3
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D4
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D5
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D6
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D7
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D8
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D9
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D10
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D11
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D12
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D13
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D14
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D15
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D16
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D17
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D18
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D19
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D20
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D21
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D22
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D23
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D24
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D25
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D26
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D27
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D28
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D29
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D30
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X9, D31
    SUB  X26, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X28
    FMOV  V2.D[1], X20
    FMOV  D3, X9
    FMOV  V3.D[1], X13
    FMOV  D4, X28
    FMOV  V4.D[1], X13
    FMOV  D5, X21
    FMOV  V5.D[1], X19
    FMOV  D6, X23
    FMOV  V6.D[1], X6
    FMOV  D7, X16
    FMOV  V7.D[1], X26
    FMOV  D8, X10
    FMOV  V8.D[1], X9
    FMOV  D9, X15
    FMOV  V9.D[1], X9
    FMOV  D10, X11
    FMOV  V10.D[1], X29
    FMOV  D11, X7
    FMOV  V11.D[1], X19
    FMOV  D12, X20
    FMOV  V12.D[1], X10
    FMOV  D13, X18
    FMOV  V13.D[1], X28
    FMOV  D14, X16
    FMOV  V14.D[1], X29
    FMOV  D15, X20
    FMOV  V15.D[1], X17
    FMOV  D16, X29
    FMOV  V16.D[1], X18
    FMOV  D17, X15
    FMOV  V17.D[1], X11
    FMOV  D18, X23
    FMOV  V18.D[1], X12
    FMOV  D19, X24
    FMOV  V19.D[1], X15
    FMOV  D20, X23
    FMOV  V20.D[1], X28
    FMOV  D21, X19
    FMOV  V21.D[1], X6
    FMOV  D22, X7
    FMOV  V22.D[1], X17
    FMOV  D23, X28
    FMOV  V23.D[1], X23
    FMOV  D24, X12
    FMOV  V24.D[1], X19
    FMOV  D25, X12
    FMOV  V25.D[1], X11
    FMOV  D26, X21
    FMOV  V26.D[1], X25
    FMOV  D27, X15
    FMOV  V27.D[1], X25
    FMOV  D28, X24
    FMOV  V28.D[1], X22
    FMOV  D29, X14
    FMOV  V29.D[1], X6
    FMOV  D30, X18
    FMOV  V30.D[1], X23
    FMOV  D31, X10
    FMOV  V31.D[1], X16
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X16, #0xf00, LSL #0
    ADD  X29, X30, X16, LSR #0
    ST1 { V26.8H, V27.8H, V28.8H, V29.8H }, [X29]
    LD1 { V21.16B, V22.16B, V23.16B, V24.16B }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V31.16B, V0.16B, V1.16B, V2.16B }, [X29]
    LD1 { V3.16B, V4.16B, V5.16B, V6.16B }, [X29]
    ADD  X29, X29, X26
    ST1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X29]
    LD1 { V25.2D, V26.2D, V27.2D, V28.2D }, [X29]
    ADD  X29, X29, X26
    ST1 { V6.4S, V7.4S, V8.4S, V9.4S }, [X29]
    LD1 { V22.4S, V23.4S, V24.4S, V25.4S }, [X29]
    ADD  X29, X29, X26
    ST1 { V21.8H, V22.8H, V23.8H, V24.8H }, [X29]
    LD1 { V4.8H, V5.8H, V6.8H, V7.8H }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V4.4H, V5.4H, V6.4H, V7.4H }, [X29]
    LD1 { V4.4H, V5.4H, V6.4H, V7.4H }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X29]
    LD1 { V21.1D, V22.1D, V23.1D, V24.1D }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V24.2S, V25.2S, V26.2S, V27.2S }, [X29]
    LD1 { V24.2S, V25.2S, V26.2S, V27.2S }, [X29]
    ADD  X29, X29, X26
    ST1 { V23.4H, V24.4H, V25.4H, V26.4H }, [X29]
    LD1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V24.8B, V25.8B, V26.8B, V27.8B }, [X29]
    LD1 { V24.8B, V25.8B, V26.8B, V27.8B }, [X29]
    ADD  X29, X29, X26
    ST1 { V3.16B }, [X29]
    LD1 { V23.16B }, [X29]
    ADD  X29, X29, X26, LSR #0
    ST1 { V7.16B }, [X29]
    LD1 { V7.16B }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V23.2D }, [X29]
    LD1 { V23.2D }, [X29]
    ADD  X29, X29, X26, LSR #0
    ST1 { V24.4S }, [X29]
    LD1 { V3.4S }, [X29]
    ADD  X29, X29, X26
    ST1 { V5.8H }, [X29]
    LD1 { V12.8H }, [X29]
    ADD  X29, X29, X26, LSR #0
    ST1 { V7.1D }, [X29]
    LD1 { V11.8B }, [X29]
    ADD  X29, X29, X26
    ST1 { V23.1D }, [X29]
    LD1 { V7.1D }, [X29]
    ADD  X29, X29, X26
    ST1 { V3.2S }, [X29]
    LD1 { V18.2S }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V18.4H }, [X29]
    LD1 { V15.4H }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V11.8B }, [X29]
    LD1 { V2.8B }, [X29]
    ADD  X29, X29, X26
    ST1 { V4.8H, V5.8H, V6.8H }, [X29]
    LD1 { V18.16B, V19.16B, V20.16B }, [X29]
    ADD  X29, X29, X26, LSR #0
    ST1 { V18.16B, V19.16B, V20.16B }, [X29]
    LD1 { V17.16B, V18.16B, V19.16B }, [X29]
    ADD  X29, X29, X26
    ST1 { V17.2D, V18.2D, V19.2D }, [X29]
    LD1 { V28.2D, V29.2D, V30.2D }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V28.4S, V29.4S, V30.4S }, [X29]
    LD1 { V3.4S, V4.4S, V5.4S }, [X29]
    ADD  X29, X29, X26, LSR #0
    ST1 { V20.8H, V21.8H, V22.8H }, [X29]
    LD1 { V14.8H, V15.8H, V16.8H }, [X29]
    ADD  X29, X29, X26, ASR #0
    ST1 { V12.4H, V13.4H, V14.4H }, [X29]
    LD1 { V19.2S, V20.2S, V21.2S }, [X29]
    ADD  X29, X29, X26, LSR #0
    ST1 { V19.1D, V20.1D, V21.1D }, [X29]
    LD1 { V28.1D, V29.1D, V30.1D }, [X29]
    ADD  X29, X29, X26
    ST1 { V28.2S, V29.2S, V30.2S }, [X29]
    LD1 { V12.2S, V13.2S, V14.2S }, [X29]
    ADD  X29, X29, X26
    ST1 { V17.4H, V18.4H, V19.4H }, [X29]
    LD1 { V17.4H, V18.4H, V19.4H }, [X29]
    ADD  X29, X29, X26
    ST1 { V29.8B, V30.8B, V31.8B }, [X29]
    LD1 { V20.8B, V21.8B, V22.8B }, [X29]
    ADD  X29, X29, X26
    ST1 { V20.2D, V21.2D }, [X29]
    LD1 { V7.4S, V8.4S }, [X29]
    ADD  X29, X29, X26
    ST1 { V13.16B, V14.16B }, [X29]
    LD1 { V13.16B, V14.16B }, [X29]
    ADD  X29, X29, X26, LSR #0
    ST1 { V7.2D, V8.2D }, [X29]
    LD1 { V28.2D, V29.2D }, [X29]
    ADD  X29, X29, X26, LSR #0
    ST1 { V21.4S, V22.4S }, [X29]
    LD1 { V7.4S, V8.4S }, [X29]
    ADD  X29, X29, X26, LSR #0
    ST1 { V15.8H, V16.8H }, [X29]
    LD1 { V15.8H, V16.8H }, [X29]
    ADD  X29, X29, X26
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X18
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X21
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X10, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, V0.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D0
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, V1.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D1
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D2
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D3
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D4
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D5
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D6
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D7
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D8
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, V9.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D9
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, V10.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D10
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D11
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D12
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D13
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D14
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D15
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V16.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D16
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D17
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D18
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D19
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D20
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D21
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D22
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D23
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D24
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D25
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D26
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D27
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D28
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D29
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D30
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, V31.D[1]
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X10, D31
    SUB  X19, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
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
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X21
    FMOV  V2.D[1], X7
    FMOV  D3, X15
    FMOV  V3.D[1], X25
    FMOV  D4, X23
    FMOV  V4.D[1], X13
    FMOV  D5, X16
    FMOV  V5.D[1], X9
    FMOV  D6, X10
    FMOV  V6.D[1], X26
    FMOV  D7, X17
    FMOV  V7.D[1], X5
    FMOV  D8, X11
    FMOV  V8.D[1], X13
    FMOV  D9, X7
    FMOV  V9.D[1], X26
    FMOV  D10, X14
    FMOV  V10.D[1], X13
    FMOV  D11, X10
    FMOV  V11.D[1], X14
    FMOV  D12, X20
    FMOV  V12.D[1], X19
    FMOV  D13, X9
    FMOV  V13.D[1], X10
    FMOV  D14, X14
    FMOV  V14.D[1], X6
    FMOV  D15, X10
    FMOV  V15.D[1], X15
    FMOV  D16, X28
    FMOV  V16.D[1], X13
    FMOV  D17, X4
    FMOV  V17.D[1], X5
    FMOV  D18, X15
    FMOV  V18.D[1], X23
    FMOV  D19, X12
    FMOV  V19.D[1], X21
    FMOV  D20, X9
    FMOV  V20.D[1], X19
    FMOV  D21, X19
    FMOV  V21.D[1], X23
    FMOV  D22, X10
    FMOV  V22.D[1], X19
    FMOV  D23, X7
    FMOV  V23.D[1], X22
    FMOV  D24, X23
    FMOV  V24.D[1], X15
    FMOV  D25, X16
    FMOV  V25.D[1], X26
    FMOV  D26, X20
    FMOV  V26.D[1], X18
    FMOV  D27, X26
    FMOV  V27.D[1], X24
    FMOV  D28, X9
    FMOV  V28.D[1], X26
    FMOV  D29, X24
    FMOV  V29.D[1], X28
    FMOV  D30, X13
    FMOV  V30.D[1], X29
    FMOV  D31, X6
    FMOV  V31.D[1], X12
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X13, #0x1400, LSL #0
    ADD  X11, X30, X13
    ST1 { V10.16B, V11.16B, V12.16B, V13.16B }, [X11]
    LD1 { V16.4S, V17.4S, V18.4S, V19.4S }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X11]
    LD1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V27.2D, V28.2D, V29.2D, V30.2D }, [X11]
    LD1 { V23.2D, V24.2D, V25.2D, V26.2D }, [X11]
    ADD  X11, X11, X17
    ST1 { V16.4S, V17.4S, V18.4S, V19.4S }, [X11]
    LD1 { V0.4S, V1.4S, V2.4S, V3.4S }, [X11]
    ADD  X11, X11, X17
    ST1 { V23.8H, V24.8H, V25.8H, V26.8H }, [X11]
    LD1 { V16.8H, V17.8H, V18.8H, V19.8H }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V31.2S, V0.2S, V1.2S, V2.2S }, [X11]
    LD1 { V28.1D, V29.1D, V30.1D, V31.1D }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V16.1D, V17.1D, V18.1D, V19.1D }, [X11]
    LD1 { V24.1D, V25.1D, V26.1D, V27.1D }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V26.2S, V27.2S, V28.2S, V29.2S }, [X11]
    LD1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X11]
    LD1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V12.8B, V13.8B, V14.8B, V15.8B }, [X11]
    LD1 { V12.8B, V13.8B, V14.8B, V15.8B }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V31.2D }, [X11]
    LD1 { V2.4S }, [X11]
    ADD  X11, X11, X17
    ST1 { V13.16B }, [X11]
    LD1 { V31.16B }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V2.2D }, [X11]
    LD1 { V29.2D }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V16.4S }, [X11]
    LD1 { V28.4S }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V24.8H }, [X11]
    LD1 { V24.8H }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V31.2S }, [X11]
    LD1 { V13.2S }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V13.1D }, [X11]
    LD1 { V31.1D }, [X11]
    ADD  X11, X11, X17
    ST1 { V31.2S }, [X11]
    LD1 { V31.2S }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V29.4H }, [X11]
    LD1 { V29.4H }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V29.8B }, [X11]
    LD1 { V13.8B }, [X11]
    ADD  X11, X11, X17
    ST1 { V10.16B, V11.16B, V12.16B }, [X11]
    LD1 { V10.4S, V11.4S, V12.4S }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V16.16B, V17.16B, V18.16B }, [X11]
    LD1 { V16.16B, V17.16B, V18.16B }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V1.2D, V2.2D, V3.2D }, [X11]
    LD1 { V20.2D, V21.2D, V22.2D }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V10.4S, V11.4S, V12.4S }, [X11]
    LD1 { V28.4S, V29.4S, V30.4S }, [X11]
    ADD  X11, X11, X17
    ST1 { V28.8H, V29.8H, V30.8H }, [X11]
    LD1 { V5.8H, V6.8H, V7.8H }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V1.1D, V2.1D, V3.1D }, [X11]
    LD1 { V6.8B, V7.8B, V8.8B }, [X11]
    ADD  X11, X11, X17
    ST1 { V25.1D, V26.1D, V27.1D }, [X11]
    LD1 { V15.1D, V16.1D, V17.1D }, [X11]
    ADD  X11, X11, X17
    ST1 { V20.2S, V21.2S, V22.2S }, [X11]
    LD1 { V28.2S, V29.2S, V30.2S }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V5.4H, V6.4H, V7.4H }, [X11]
    LD1 { V20.4H, V21.4H, V22.4H }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V20.8B, V21.8B, V22.8B }, [X11]
    LD1 { V1.8B, V2.8B, V3.8B }, [X11]
    ADD  X11, X11, X17
    ST1 { V16.4S, V17.4S }, [X11]
    LD1 { V10.8H, V11.8H }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V28.16B, V29.16B }, [X11]
    LD1 { V15.16B, V16.16B }, [X11]
    ADD  X11, X11, X17, ASR #0
    ST1 { V3.2D, V4.2D }, [X11]
    LD1 { V4.2D, V5.2D }, [X11]
    ADD  X11, X11, X17, LSR #0
    ST1 { V6.4S, V7.4S }, [X11]
    LD1 { V21.4S, V22.4S }, [X11]
    ADD  X11, X11, X17
    ST1 { V4.8H, V5.8H }, [X11]
    LD1 { V5.8H, V6.8H }, [X11]
    ADD  X11, X11, X17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V0.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D0
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D1
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D2
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D3
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V4.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D4
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D5
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V6.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D6
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D7
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V8.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D8
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V9.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D9
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D10
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D11
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D12
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D13
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D14
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D15
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D16
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D17
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D18
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D19
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D20
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D21
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D22
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V23.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D23
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D24
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D25
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D26
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D27
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D28
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D29
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D30
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D31
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X21
    FMOV  D3, X22
    FMOV  V3.D[1], X23
    FMOV  D4, X4
    FMOV  V4.D[1], X12
    FMOV  D5, X18
    FMOV  V5.D[1], X19
    FMOV  D6, X12
    FMOV  V6.D[1], X4
    FMOV  D7, X22
    FMOV  V7.D[1], X4
    FMOV  D8, X6
    FMOV  V8.D[1], X19
    FMOV  D9, X26
    FMOV  V9.D[1], X6
    FMOV  D10, X7
    FMOV  V10.D[1], X23
    FMOV  D11, X28
    FMOV  V11.D[1], X5
    FMOV  D12, X17
    FMOV  V12.D[1], X5
    FMOV  D13, X10
    FMOV  V13.D[1], X23
    FMOV  D14, X11
    FMOV  V14.D[1], X15
    FMOV  D15, X28
    FMOV  V15.D[1], X17
    FMOV  D16, X22
    FMOV  V16.D[1], X6
    FMOV  D17, X23
    FMOV  V17.D[1], X6
    FMOV  D18, X21
    FMOV  V18.D[1], X29
    FMOV  D19, X22
    FMOV  V19.D[1], X23
    FMOV  D20, X26
    FMOV  V20.D[1], X18
    FMOV  D21, X29
    FMOV  V21.D[1], X5
    FMOV  D22, X14
    FMOV  V22.D[1], X18
    FMOV  D23, X6
    FMOV  V23.D[1], X13
    FMOV  D24, X7
    FMOV  V24.D[1], X16
    FMOV  D25, X9
    FMOV  V25.D[1], X22
    FMOV  D26, X18
    FMOV  V26.D[1], X28
    FMOV  D27, X5
    FMOV  V27.D[1], X23
    FMOV  D28, X18
    FMOV  V28.D[1], X13
    FMOV  D29, X26
    FMOV  V29.D[1], X7
    FMOV  D30, X23
    FMOV  V30.D[1], X14
    FMOV  D31, X6
    FMOV  V31.D[1], X16
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X5, #0x1900, LSL #0
    ADD  X11, X30, X5, LSR #0
    ST1 { V29.8H, V30.8H, V31.8H, V0.8H }, [X11]
    LD1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X11]
    LD1 { V27.16B, V28.16B, V29.16B, V30.16B }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V27.2D, V28.2D, V29.2D, V30.2D }, [X11]
    LD1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X11]
    ADD  X11, X11, X26
    ST1 { V21.4S, V22.4S, V23.4S, V24.4S }, [X11]
    LD1 { V16.4S, V17.4S, V18.4S, V19.4S }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X11]
    LD1 { V22.8H, V23.8H, V24.8H, V25.8H }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X11]
    LD1 { V22.2S, V23.2S, V24.2S, V25.2S }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X11]
    LD1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X11]
    ADD  X11, X11, X26
    ST1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X11]
    LD1 { V16.2S, V17.2S, V18.2S, V19.2S }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X11]
    LD1 { V9.4H, V10.4H, V11.4H, V12.4H }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V9.8B, V10.8B, V11.8B, V12.8B }, [X11]
    LD1 { V9.8B, V10.8B, V11.8B, V12.8B }, [X11]
    ADD  X11, X11, X26
    ST1 { V10.8H }, [X11]
    LD1 { V10.2D }, [X11]
    ADD  X11, X11, X26
    ST1 { V10.16B }, [X11]
    LD1 { V10.16B }, [X11]
    ADD  X11, X11, X26
    ST1 { V15.2D }, [X11]
    LD1 { V18.2D }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V0.4S }, [X11]
    LD1 { V0.4S }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V12.8H }, [X11]
    LD1 { V16.8H }, [X11]
    ADD  X11, X11, X26
    ST1 { V10.1D }, [X11]
    LD1 { V17.4H }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V9.1D }, [X11]
    LD1 { V15.1D }, [X11]
    ADD  X11, X11, X26
    ST1 { V0.2S }, [X11]
    LD1 { V0.2S }, [X11]
    ADD  X11, X11, X26
    ST1 { V15.4H }, [X11]
    LD1 { V15.4H }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V17.8B }, [X11]
    LD1 { V12.8B }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V10.2D, V11.2D, V12.2D }, [X11]
    LD1 { V10.8H, V11.8H, V12.8H }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V10.16B, V11.16B, V12.16B }, [X11]
    LD1 { V17.16B, V18.16B, V19.16B }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V17.2D, V18.2D, V19.2D }, [X11]
    LD1 { V27.2D, V28.2D, V29.2D }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V27.4S, V28.4S, V29.4S }, [X11]
    LD1 { V24.4S, V25.4S, V26.4S }, [X11]
    ADD  X11, X11, X26
    ST1 { V24.8H, V25.8H, V26.8H }, [X11]
    LD1 { V1.8H, V2.8H, V3.8H }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V1.2S, V2.2S, V3.2S }, [X11]
    LD1 { V10.2S, V11.2S, V12.2S }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V10.1D, V11.1D, V12.1D }, [X11]
    LD1 { V17.1D, V18.1D, V19.1D }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V17.2S, V18.2S, V19.2S }, [X11]
    LD1 { V24.2S, V25.2S, V26.2S }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V24.4H, V25.4H, V26.4H }, [X11]
    LD1 { V1.4H, V2.4H, V3.4H }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V10.8B, V11.8B, V12.8B }, [X11]
    LD1 { V26.8B, V27.8B, V28.8B }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V31.16B, V0.16B }, [X11]
    LD1 { V11.2D, V12.2D }, [X11]
    ADD  X11, X11, X26, ASR #0
    ST1 { V30.16B, V31.16B }, [X11]
    LD1 { V17.16B, V18.16B }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V11.2D, V12.2D }, [X11]
    LD1 { V1.2D, V2.2D }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V25.4S, V26.4S }, [X11]
    LD1 { V11.4S, V12.4S }, [X11]
    ADD  X11, X11, X26, LSR #0
    ST1 { V17.8H, V18.8H }, [X11]
    LD1 { V25.8H, V26.8H }, [X11]
    ADD  X11, X11, X26
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X24, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D0
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V1.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D1
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D2
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D3
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V4.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D4
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V5.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D5
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V6.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D6
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V7.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D7
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V8.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D8
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D9
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D10
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D11
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D12
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V13.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D13
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V14.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D14
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D15
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D16
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V17.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D17
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V18.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D18
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D19
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V20.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D20
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V21.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D21
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D22
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D23
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D24
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V25.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D25
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V26.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D26
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D27
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D28
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D29
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V30.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D30
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, V31.D[1]
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    FMOV  X24, D31
    SUB  X20, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X29
    FMOV  D3, X26
    FMOV  V3.D[1], X23
    FMOV  D4, X19
    FMOV  V4.D[1], X5
    FMOV  D5, X9
    FMOV  V5.D[1], X13
    FMOV  D6, X11
    FMOV  V6.D[1], X13
    FMOV  D7, X4
    FMOV  V7.D[1], X13
    FMOV  D8, X14
    FMOV  V8.D[1], X28
    FMOV  D9, X12
    FMOV  V9.D[1], X5
    FMOV  D10, X24
    FMOV  V10.D[1], X20
    FMOV  D11, X14
    FMOV  V11.D[1], X17
    FMOV  D12, X15
    FMOV  V12.D[1], X20
    FMOV  D13, X10
    FMOV  V13.D[1], X25
    FMOV  D14, X14
    FMOV  V14.D[1], X25
    FMOV  D15, X22
    FMOV  V15.D[1], X28
    FMOV  D16, X6
    FMOV  V16.D[1], X25
    FMOV  D17, X17
    FMOV  V17.D[1], X5
    FMOV  D18, X21
    FMOV  V18.D[1], X14
    FMOV  D19, X7
    FMOV  V19.D[1], X28
    FMOV  D20, X9
    FMOV  V20.D[1], X13
    FMOV  D21, X4
    FMOV  V21.D[1], X22
    FMOV  D22, X25
    FMOV  V22.D[1], X28
    FMOV  D23, X6
    FMOV  V23.D[1], X16
    FMOV  D24, X10
    FMOV  V24.D[1], X28
    FMOV  D25, X12
    FMOV  V25.D[1], X18
    FMOV  D26, X14
    FMOV  V26.D[1], X18
    FMOV  D27, X28
    FMOV  V27.D[1], X28
    FMOV  D28, X7
    FMOV  V28.D[1], X13
    FMOV  D29, X24
    FMOV  V29.D[1], X23
    FMOV  D30, X24
    FMOV  V30.D[1], X26
    FMOV  D31, X21
    FMOV  V31.D[1], X5
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X17, #0x1e00, LSL #0
    ADD  X29, X30, X17
    ST1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X29]
    LD1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V9.16B, V10.16B, V11.16B, V12.16B }, [X29]
    LD1 { V23.16B, V24.16B, V25.16B, V26.16B }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V24.2D, V25.2D, V26.2D, V27.2D }, [X29]
    LD1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V3.4S, V4.4S, V5.4S, V6.4S }, [X29]
    LD1 { V24.4S, V25.4S, V26.4S, V27.4S }, [X29]
    ADD  X29, X29, X20
    ST1 { V23.8H, V24.8H, V25.8H, V26.8H }, [X29]
    LD1 { V30.8H, V31.8H, V0.8H, V1.8H }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V30.8B, V31.8B, V0.8B, V1.8B }, [X29]
    LD1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X29]
    ADD  X29, X29, X20
    ST1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X29]
    LD1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V3.2S, V4.2S, V5.2S, V6.2S }, [X29]
    LD1 { V3.2S, V4.2S, V5.2S, V6.2S }, [X29]
    ADD  X29, X29, X20
    ST1 { V22.4H, V23.4H, V24.4H, V25.4H }, [X29]
    LD1 { V22.4H, V23.4H, V24.4H, V25.4H }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V25.8B, V26.8B, V27.8B, V28.8B }, [X29]
    LD1 { V25.8B, V26.8B, V27.8B, V28.8B }, [X29]
    ADD  X29, X29, X20
    ST1 { V3.16B }, [X29]
    LD1 { V3.8H }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V26.16B }, [X29]
    LD1 { V15.16B }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V4.2D }, [X29]
    LD1 { V26.2D }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V3.4S }, [X29]
    LD1 { V4.4S }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V22.8H }, [X29]
    LD1 { V22.8H }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V26.1D }, [X29]
    LD1 { V26.8B }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V4.1D }, [X29]
    LD1 { V3.1D }, [X29]
    ADD  X29, X29, X20
    ST1 { V3.2S }, [X29]
    LD1 { V30.2S }, [X29]
    ADD  X29, X29, X20
    ST1 { V15.4H }, [X29]
    LD1 { V23.4H }, [X29]
    ADD  X29, X29, X20
    ST1 { V30.8B }, [X29]
    LD1 { V25.8B }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V9.2D, V10.2D, V11.2D }, [X29]
    LD1 { V21.16B, V22.16B, V23.16B }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V10.16B, V11.16B, V12.16B }, [X29]
    LD1 { V3.16B, V4.16B, V5.16B }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V1.2D, V2.2D, V3.2D }, [X29]
    LD1 { V10.2D, V11.2D, V12.2D }, [X29]
    ADD  X29, X29, X20
    ST1 { V10.4S, V11.4S, V12.4S }, [X29]
    LD1 { V27.4S, V28.4S, V29.4S }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V27.8H, V28.8H, V29.8H }, [X29]
    LD1 { V24.8H, V25.8H, V26.8H }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V21.4H, V22.4H, V23.4H }, [X29]
    LD1 { V22.2S, V23.2S, V24.2S }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V22.1D, V23.1D, V24.1D }, [X29]
    LD1 { V1.1D, V2.1D, V3.1D }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V1.2S, V2.2S, V3.2S }, [X29]
    LD1 { V21.2S, V22.2S, V23.2S }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V21.4H, V22.4H, V23.4H }, [X29]
    LD1 { V27.4H, V28.4H, V29.4H }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V18.8B, V19.8B, V20.8B }, [X29]
    LD1 { V10.8B, V11.8B, V12.8B }, [X29]
    ADD  X29, X29, X20
    ST1 { V10.4S, V11.4S }, [X29]
    LD1 { V10.4S, V11.4S }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V31.16B, V0.16B }, [X29]
    LD1 { V31.16B, V0.16B }, [X29]
    ADD  X29, X29, X20, LSR #0
    ST1 { V27.2D, V28.2D }, [X29]
    LD1 { V19.2D, V20.2D }, [X29]
    ADD  X29, X29, X20
    ST1 { V19.4S, V20.4S }, [X29]
    LD1 { V5.4S, V6.4S }, [X29]
    ADD  X29, X29, X20, ASR #0
    ST1 { V10.8H, V11.8H }, [X29]
    LD1 { V10.8H, V11.8H }, [X29]
    ADD  X29, X29, X20, ASR #0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X5, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X5, FPSR
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V0.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D0
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V1.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D1
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V2.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D2
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V3.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D3
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V4.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D4
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V5.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D5
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V6.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D6
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V7.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D7
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V8.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D8
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V9.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D9
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D10
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D11
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D12
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V13.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D13
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V14.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D14
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D15
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V16.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D16
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V17.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D17
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V18.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D18
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V19.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D19
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D20
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D21
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V22.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D22
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D23
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V24.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D24
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V25.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D25
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D26
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D27
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V28.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D28
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V29.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D29
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D30
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, V31.D[1]
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X5, D31
    SUB  X15, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X25
    FMOV  V2.D[1], X11
    FMOV  D3, X10
    FMOV  V3.D[1], X13
    FMOV  D4, X13
    FMOV  V4.D[1], X23
    FMOV  D5, X26
    FMOV  V5.D[1], X24
    FMOV  D6, X18
    FMOV  V6.D[1], X18
    FMOV  D7, X15
    FMOV  V7.D[1], X9
    FMOV  D8, X25
    FMOV  V8.D[1], X26
    FMOV  D9, X5
    FMOV  V9.D[1], X17
    FMOV  D10, X15
    FMOV  V10.D[1], X15
    FMOV  D11, X29
    FMOV  V11.D[1], X21
    FMOV  D12, X4
    FMOV  V12.D[1], X17
    FMOV  D13, X23
    FMOV  V13.D[1], X13
    FMOV  D14, X16
    FMOV  V14.D[1], X28
    FMOV  D15, X21
    FMOV  V15.D[1], X25
    FMOV  D16, X19
    FMOV  V16.D[1], X22
    FMOV  D17, X14
    FMOV  V17.D[1], X11
    FMOV  D18, X17
    FMOV  V18.D[1], X14
    FMOV  D19, X18
    FMOV  V19.D[1], X24
    FMOV  D20, X14
    FMOV  V20.D[1], X20
    FMOV  D21, X16
    FMOV  V21.D[1], X15
    FMOV  D22, X14
    FMOV  V22.D[1], X12
    FMOV  D23, X14
    FMOV  V23.D[1], X26
    FMOV  D24, X10
    FMOV  V24.D[1], X17
    FMOV  D25, X12
    FMOV  V25.D[1], X12
    FMOV  D26, X21
    FMOV  V26.D[1], X11
    FMOV  D27, X21
    FMOV  V27.D[1], X10
    FMOV  D28, X17
    FMOV  V28.D[1], X12
    FMOV  D29, X20
    FMOV  V29.D[1], X7
    FMOV  D30, X4
    FMOV  V30.D[1], X6
    FMOV  D31, X21
    FMOV  V31.D[1], X11
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X9, #0x2300, LSL #0
    ADD  X20, X30, X9
    ST1 { V21.4S, V22.4S, V23.4S, V24.4S }, [X20]
    LD1 { V2.8H, V3.8H, V4.8H, V5.8H }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V2.16B, V3.16B, V4.16B, V5.16B }, [X20]
    LD1 { V14.16B, V15.16B, V16.16B, V17.16B }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V16.2D, V17.2D, V18.2D, V19.2D }, [X20]
    LD1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V28.4S, V29.4S, V30.4S, V31.4S }, [X20]
    LD1 { V24.4S, V25.4S, V26.4S, V27.4S }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V24.8H, V25.8H, V26.8H, V27.8H }, [X20]
    LD1 { V28.8H, V29.8H, V30.8H, V31.8H }, [X20]
    ADD  X20, X20, X13
    ST1 { V1.2S, V2.2S, V3.2S, V4.2S }, [X20]
    LD1 { V23.4H, V24.4H, V25.4H, V26.4H }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V28.1D, V29.1D, V30.1D, V31.1D }, [X20]
    LD1 { V2.1D, V3.1D, V4.1D, V5.1D }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X20]
    LD1 { V28.2S, V29.2S, V30.2S, V31.2S }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X20]
    LD1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V16.8B, V17.8B, V18.8B, V19.8B }, [X20]
    LD1 { V28.8B, V29.8B, V30.8B, V31.8B }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V30.16B }, [X20]
    LD1 { V1.4S }, [X20]
    ADD  X20, X20, X13
    ST1 { V29.16B }, [X20]
    LD1 { V27.16B }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V2.2D }, [X20]
    LD1 { V18.2D }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V31.4S }, [X20]
    LD1 { V15.4S }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V18.8H }, [X20]
    LD1 { V31.8H }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V27.8B }, [X20]
    LD1 { V29.4H }, [X20]
    ADD  X20, X20, X13
    ST1 { V1.1D }, [X20]
    LD1 { V27.1D }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V27.2S }, [X20]
    LD1 { V1.2S }, [X20]
    ADD  X20, X20, X13
    ST1 { V1.4H }, [X20]
    LD1 { V16.4H }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V29.8B }, [X20]
    LD1 { V18.8B }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V12.8H, V13.8H, V14.8H }, [X20]
    LD1 { V12.2D, V13.2D, V14.2D }, [X20]
    ADD  X20, X20, X13
    ST1 { V12.16B, V13.16B, V14.16B }, [X20]
    LD1 { V12.16B, V13.16B, V14.16B }, [X20]
    ADD  X20, X20, X13
    ST1 { V30.2D, V31.2D, V0.2D }, [X20]
    LD1 { V19.2D, V20.2D, V21.2D }, [X20]
    ADD  X20, X20, X13
    ST1 { V12.4S, V13.4S, V14.4S }, [X20]
    LD1 { V4.4S, V5.4S, V6.4S }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V19.8H, V20.8H, V21.8H }, [X20]
    LD1 { V30.8H, V31.8H, V0.8H }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V4.2S, V5.2S, V6.2S }, [X20]
    LD1 { V4.8B, V5.8B, V6.8B }, [X20]
    ADD  X20, X20, X13
    ST1 { V4.1D, V5.1D, V6.1D }, [X20]
    LD1 { V4.1D, V5.1D, V6.1D }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V4.2S, V5.2S, V6.2S }, [X20]
    LD1 { V4.2S, V5.2S, V6.2S }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V4.4H, V5.4H, V6.4H }, [X20]
    LD1 { V4.4H, V5.4H, V6.4H }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V5.8B, V6.8B, V7.8B }, [X20]
    LD1 { V5.8B, V6.8B, V7.8B }, [X20]
    ADD  X20, X20, X13
    ST1 { V30.4S, V31.4S }, [X20]
    LD1 { V20.8H, V21.8H }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V20.16B, V21.16B }, [X20]
    LD1 { V20.16B, V21.16B }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V20.2D, V21.2D }, [X20]
    LD1 { V20.2D, V21.2D }, [X20]
    ADD  X20, X20, X13, ASR #0
    ST1 { V4.4S, V5.4S }, [X20]
    LD1 { V4.4S, V5.4S }, [X20]
    ADD  X20, X20, X13, LSR #0
    ST1 { V6.8H, V7.8H }, [X20]
    LD1 { V30.8H, V31.8H }, [X20]
    ADD  X20, X20, X13, ASR #0
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X11, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, V0.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D0
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D1
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V2.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D2
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D3
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D4
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V5.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D5
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V6.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D6
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D7
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, V8.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D8
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, V9.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D9
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, V10.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D10
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, V11.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D11
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, V12.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D12
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, V13.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D13
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, V14.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D14
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D15
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D16
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D17
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V18.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D18
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D19
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D20
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D21
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, V22.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D22
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D23
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D24
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D25
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D26
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D27
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D28
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D29
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D30
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X11, D31
    SUB  X16, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP01_TestFail
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
    FMOV  D1, X28
    FMOV  V1.D[1], X24
    FMOV  D2, X22
    FMOV  V2.D[1], X26
    FMOV  D3, X6
    FMOV  V3.D[1], X17
    FMOV  D4, X14
    FMOV  V4.D[1], X6
    FMOV  D5, X10
    FMOV  V5.D[1], X16
    FMOV  D6, X4
    FMOV  V6.D[1], X11
    FMOV  D7, X23
    FMOV  V7.D[1], X19
    FMOV  D8, X18
    FMOV  V8.D[1], X17
    FMOV  D9, X16
    FMOV  V9.D[1], X4
    FMOV  D10, X14
    FMOV  V10.D[1], X20
    FMOV  D11, X6
    FMOV  V11.D[1], X14
    FMOV  D12, X28
    FMOV  V12.D[1], X19
    FMOV  D13, X29
    FMOV  V13.D[1], X11
    FMOV  D14, X19
    FMOV  V14.D[1], X16
    FMOV  D15, X15
    FMOV  V15.D[1], X25
    FMOV  D16, X5
    FMOV  V16.D[1], X9
    FMOV  D17, X29
    FMOV  V17.D[1], X29
    FMOV  D18, X17
    FMOV  V18.D[1], X16
    FMOV  D19, X5
    FMOV  V19.D[1], X15
    FMOV  D20, X9
    FMOV  V20.D[1], X5
    FMOV  D21, X25
    FMOV  V21.D[1], X22
    FMOV  D22, X6
    FMOV  V22.D[1], X7
    FMOV  D23, X4
    FMOV  V23.D[1], X22
    FMOV  D24, X4
    FMOV  V24.D[1], X5
    FMOV  D25, X7
    FMOV  V25.D[1], X29
    FMOV  D26, X13
    FMOV  V26.D[1], X18
    FMOV  D27, X28
    FMOV  V27.D[1], X22
    FMOV  D28, X5
    FMOV  V28.D[1], X21
    FMOV  D29, X28
    FMOV  V29.D[1], X14
    FMOV  D30, X18
    FMOV  V30.D[1], X19
    FMOV  D31, X26
    FMOV  V31.D[1], X6
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X16, #0x2800, LSL #0
    ADD  X4, X30, X16, LSR #0
    ST1 { V6.4S, V7.4S, V8.4S, V9.4S }, [X4]
    LD1 { V27.2D, V28.2D, V29.2D, V30.2D }, [X4]
    ADD  X4, X4, X21
    ST1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X4]
    LD1 { V6.16B, V7.16B, V8.16B, V9.16B }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V19.2D, V20.2D, V21.2D, V22.2D }, [X4]
    LD1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X4]
    ADD  X4, X4, X21
    ST1 { V10.4S, V11.4S, V12.4S, V13.4S }, [X4]
    LD1 { V28.4S, V29.4S, V30.4S, V31.4S }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V3.8H, V4.8H, V5.8H, V6.8H }, [X4]
    LD1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X4]
    LD1 { V30.8B, V31.8B, V0.8B, V1.8B }, [X4]
    ADD  X4, X4, X21
    ST1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X4]
    LD1 { V12.1D, V13.1D, V14.1D, V15.1D }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V11.2S, V12.2S, V13.2S, V14.2S }, [X4]
    LD1 { V19.2S, V20.2S, V21.2S, V22.2S }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V19.4H, V20.4H, V21.4H, V22.4H }, [X4]
    LD1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V3.8B, V4.8B, V5.8B, V6.8B }, [X4]
    LD1 { V7.8B, V8.8B, V9.8B, V10.8B }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V15.2D }, [X4]
    LD1 { V15.16B }, [X4]
    ADD  X4, X4, X21
    ST1 { V1.16B }, [X4]
    LD1 { V12.16B }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V15.2D }, [X4]
    LD1 { V1.2D }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V9.4S }, [X4]
    LD1 { V22.4S }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V22.8H }, [X4]
    LD1 { V22.8H }, [X4]
    ADD  X4, X4, X21
    ST1 { V22.8B }, [X4]
    LD1 { V3.2S }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V3.1D }, [X4]
    LD1 { V6.1D }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V12.2S }, [X4]
    LD1 { V12.2S }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V6.4H }, [X4]
    LD1 { V3.4H }, [X4]
    ADD  X4, X4, X21
    ST1 { V12.8B }, [X4]
    LD1 { V6.8B }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V31.4S, V0.4S, V1.4S }, [X4]
    LD1 { V31.8H, V0.8H, V1.8H }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V31.16B, V0.16B, V1.16B }, [X4]
    LD1 { V12.16B, V13.16B, V14.16B }, [X4]
    ADD  X4, X4, X21
    ST1 { V12.2D, V13.2D, V14.2D }, [X4]
    LD1 { V12.2D, V13.2D, V14.2D }, [X4]
    ADD  X4, X4, X21
    ST1 { V18.4S, V19.4S, V20.4S }, [X4]
    LD1 { V31.4S, V0.4S, V1.4S }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V23.8H, V24.8H, V25.8H }, [X4]
    LD1 { V23.8H, V24.8H, V25.8H }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V12.8B, V13.8B, V14.8B }, [X4]
    LD1 { V18.1D, V19.1D, V20.1D }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V18.1D, V19.1D, V20.1D }, [X4]
    LD1 { V18.1D, V19.1D, V20.1D }, [X4]
    ADD  X4, X4, X21
    ST1 { V31.2S, V0.2S, V1.2S }, [X4]
    LD1 { V31.2S, V0.2S, V1.2S }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V18.4H, V19.4H, V20.4H }, [X4]
    LD1 { V18.4H, V19.4H, V20.4H }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V18.8B, V19.8B, V20.8B }, [X4]
    LD1 { V18.8B, V19.8B, V20.8B }, [X4]
    ADD  X4, X4, X21
    ST1 { V23.2D, V24.2D }, [X4]
    LD1 { V23.16B, V24.16B }, [X4]
    ADD  X4, X4, X21, ASR #0
    ST1 { V23.16B, V24.16B }, [X4]
    LD1 { V12.16B, V13.16B }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V19.2D, V20.2D }, [X4]
    LD1 { V19.2D, V20.2D }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V31.4S, V0.4S }, [X4]
    LD1 { V24.4S, V25.4S }, [X4]
    ADD  X4, X4, X21, LSR #0
    ST1 { V19.8H, V20.8H }, [X4]
    LD1 { V19.8H, V20.8H }, [X4]
    ADD  X4, X4, X21
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X17, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D0
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D1
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V2.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D2
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D3
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D4
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D5
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D6
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D7
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D8
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D9
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D10
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V11.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D11
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V12.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D12
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V13.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D13
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D14
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D15
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V16.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D16
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V17.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D17
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D18
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D19
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D20
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D21
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D22
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V23.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D23
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D24
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D25
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V26.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D26
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V27.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D27
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V28.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D28
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, V29.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D29
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D30
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    FMOV  X17, D31
    SUB  X23, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP01_TestFail
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
    FMOV  D1, X23
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X28
    FMOV  D3, X25
    FMOV  V3.D[1], X24
    FMOV  D4, X20
    FMOV  V4.D[1], X23
    FMOV  D5, X16
    FMOV  V5.D[1], X9
    FMOV  D6, X29
    FMOV  V6.D[1], X25
    FMOV  D7, X13
    FMOV  V7.D[1], X22
    FMOV  D8, X13
    FMOV  V8.D[1], X9
    FMOV  D9, X19
    FMOV  V9.D[1], X28
    FMOV  D10, X17
    FMOV  V10.D[1], X22
    FMOV  D11, X17
    FMOV  V11.D[1], X4
    FMOV  D12, X17
    FMOV  V12.D[1], X10
    FMOV  D13, X21
    FMOV  V13.D[1], X25
    FMOV  D14, X4
    FMOV  V14.D[1], X5
    FMOV  D15, X21
    FMOV  V15.D[1], X22
    FMOV  D16, X21
    FMOV  V16.D[1], X15
    FMOV  D17, X15
    FMOV  V17.D[1], X7
    FMOV  D18, X6
    FMOV  V18.D[1], X23
    FMOV  D19, X11
    FMOV  V19.D[1], X18
    FMOV  D20, X4
    FMOV  V20.D[1], X10
    FMOV  D21, X7
    FMOV  V21.D[1], X17
    FMOV  D22, X17
    FMOV  V22.D[1], X22
    FMOV  D23, X26
    FMOV  V23.D[1], X25
    FMOV  D24, X10
    FMOV  V24.D[1], X17
    FMOV  D25, X13
    FMOV  V25.D[1], X29
    FMOV  D26, X6
    FMOV  V26.D[1], X12
    FMOV  D27, X24
    FMOV  V27.D[1], X17
    FMOV  D28, X20
    FMOV  V28.D[1], X29
    FMOV  D29, X24
    FMOV  V29.D[1], X5
    FMOV  D30, X19
    FMOV  V30.D[1], X10
    FMOV  D31, X6
    FMOV  V31.D[1], X21
    MOVZ  X21, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X28, #0x2d00, LSL #0
    ADD  X26, X30, X28, ASR #0
    ST1 { V24.2D, V25.2D, V26.2D, V27.2D }, [X26]
    LD1 { V4.16B, V5.16B, V6.16B, V7.16B }, [X26]
    ADD  X26, X26, X7, LSR #0
    ST1 { V28.16B, V29.16B, V30.16B, V31.16B }, [X26]
    LD1 { V6.16B, V7.16B, V8.16B, V9.16B }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V5.2D, V6.2D, V7.2D, V8.2D }, [X26]
    LD1 { V1.2D, V2.2D, V3.2D, V4.2D }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V1.4S, V2.4S, V3.4S, V4.4S }, [X26]
    LD1 { V1.4S, V2.4S, V3.4S, V4.4S }, [X26]
    ADD  X26, X26, X7
    ST1 { V1.8H, V2.8H, V3.8H, V4.8H }, [X26]
    LD1 { V3.8H, V4.8H, V5.8H, V6.8H }, [X26]
    ADD  X26, X26, X7
    ST1 { V21.1D, V22.1D, V23.1D, V24.1D }, [X26]
    LD1 { V26.2S, V27.2S, V28.2S, V29.2S }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X26]
    LD1 { V15.1D, V16.1D, V17.1D, V18.1D }, [X26]
    ADD  X26, X26, X7
    ST1 { V26.2S, V27.2S, V28.2S, V29.2S }, [X26]
    LD1 { V2.2S, V3.2S, V4.2S, V5.2S }, [X26]
    ADD  X26, X26, X7, LSR #0
    ST1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X26]
    LD1 { V18.4H, V19.4H, V20.4H, V21.4H }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V18.8B, V19.8B, V20.8B, V21.8B }, [X26]
    LD1 { V23.8B, V24.8B, V25.8B, V26.8B }, [X26]
    ADD  X26, X26, X7
    ST1 { V25.16B }, [X26]
    LD1 { V20.4S }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V4.16B }, [X26]
    LD1 { V25.16B }, [X26]
    ADD  X26, X26, X7
    ST1 { V17.2D }, [X26]
    LD1 { V4.2D }, [X26]
    ADD  X26, X26, X7
    ST1 { V1.4S }, [X26]
    LD1 { V17.4S }, [X26]
    ADD  X26, X26, X7
    ST1 { V26.8H }, [X26]
    LD1 { V18.8H }, [X26]
    ADD  X26, X26, X7
    ST1 { V18.4H }, [X26]
    LD1 { V21.8B }, [X26]
    ADD  X26, X26, X7, LSR #0
    ST1 { V17.1D }, [X26]
    LD1 { V1.1D }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V21.2S }, [X26]
    LD1 { V21.2S }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V21.4H }, [X26]
    LD1 { V17.4H }, [X26]
    ADD  X26, X26, X7
    ST1 { V17.8B }, [X26]
    LD1 { V26.8B }, [X26]
    ADD  X26, X26, X7, LSR #0
    ST1 { V18.2D, V19.2D, V20.2D }, [X26]
    LD1 { V24.16B, V25.16B, V26.16B }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V24.16B, V25.16B, V26.16B }, [X26]
    LD1 { V24.16B, V25.16B, V26.16B }, [X26]
    ADD  X26, X26, X7, LSR #0
    ST1 { V23.2D, V24.2D, V25.2D }, [X26]
    LD1 { V18.2D, V19.2D, V20.2D }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V18.4S, V19.4S, V20.4S }, [X26]
    LD1 { V4.4S, V5.4S, V6.4S }, [X26]
    ADD  X26, X26, X7
    ST1 { V4.8H, V5.8H, V6.8H }, [X26]
    LD1 { V18.8H, V19.8H, V20.8H }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V18.2S, V19.2S, V20.2S }, [X26]
    LD1 { V4.1D, V5.1D, V6.1D }, [X26]
    ADD  X26, X26, X7
    ST1 { V4.1D, V5.1D, V6.1D }, [X26]
    LD1 { V4.1D, V5.1D, V6.1D }, [X26]
    ADD  X26, X26, X7
    ST1 { V4.2S, V5.2S, V6.2S }, [X26]
    LD1 { V23.2S, V24.2S, V25.2S }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V30.4H, V31.4H, V0.4H }, [X26]
    LD1 { V18.4H, V19.4H, V20.4H }, [X26]
    ADD  X26, X26, X7
    ST1 { V21.8B, V22.8B, V23.8B }, [X26]
    LD1 { V4.8B, V5.8B, V6.8B }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V31.2D, V0.2D }, [X26]
    LD1 { V30.16B, V31.16B }, [X26]
    ADD  X26, X26, X7
    ST1 { V4.16B, V5.16B }, [X26]
    LD1 { V4.16B, V5.16B }, [X26]
    ADD  X26, X26, X7
    ST1 { V19.2D, V20.2D }, [X26]
    LD1 { V9.2D, V10.2D }, [X26]
    ADD  X26, X26, X7, LSR #0
    ST1 { V5.4S, V6.4S }, [X26]
    LD1 { V19.4S, V20.4S }, [X26]
    ADD  X26, X26, X7, ASR #0
    ST1 { V9.8H, V10.8H }, [X26]
    LD1 { V9.8H, V10.8H }, [X26]
    ADD  X26, X26, X7, LSR #0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X12, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V0.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D0
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V1.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D1
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V2.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D2
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D3
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D4
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D5
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D6
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V7.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D7
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V8.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D8
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D9
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D10
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V11.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D11
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V12.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D12
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D13
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V14.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D14
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D15
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D16
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D17
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V18.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D18
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D19
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V20.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D20
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D21
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V22.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D22
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D23
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D24
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D25
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V26.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D26
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V27.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D27
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D28
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X12, V29.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D29
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D30
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X12, D31
    SUB  X29, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X22
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X9
    FMOV  D3, X11
    FMOV  V3.D[1], X11
    FMOV  D4, X25
    FMOV  V4.D[1], X19
    FMOV  D5, X9
    FMOV  V5.D[1], X25
    FMOV  D6, X13
    FMOV  V6.D[1], X28
    FMOV  D7, X17
    FMOV  V7.D[1], X25
    FMOV  D8, X14
    FMOV  V8.D[1], X7
    FMOV  D9, X25
    FMOV  V9.D[1], X7
    FMOV  D10, X11
    FMOV  V10.D[1], X10
    FMOV  D11, X10
    FMOV  V11.D[1], X18
    FMOV  D12, X21
    FMOV  V12.D[1], X7
    FMOV  D13, X6
    FMOV  V13.D[1], X21
    FMOV  D14, X28
    FMOV  V14.D[1], X9
    FMOV  D15, X16
    FMOV  V15.D[1], X24
    FMOV  D16, X12
    FMOV  V16.D[1], X18
    FMOV  D17, X13
    FMOV  V17.D[1], X10
    FMOV  D18, X6
    FMOV  V18.D[1], X16
    FMOV  D19, X19
    FMOV  V19.D[1], X22
    FMOV  D20, X18
    FMOV  V20.D[1], X23
    FMOV  D21, X28
    FMOV  V21.D[1], X14
    FMOV  D22, X16
    FMOV  V22.D[1], X25
    FMOV  D23, X15
    FMOV  V23.D[1], X16
    FMOV  D24, X16
    FMOV  V24.D[1], X18
    FMOV  D25, X4
    FMOV  V25.D[1], X14
    FMOV  D26, X23
    FMOV  V26.D[1], X13
    FMOV  D27, X12
    FMOV  V27.D[1], X24
    FMOV  D28, X22
    FMOV  V28.D[1], X23
    FMOV  D29, X6
    FMOV  V29.D[1], X10
    FMOV  D30, X24
    FMOV  V30.D[1], X6
    FMOV  D31, X10
    FMOV  V31.D[1], X4
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X28, #0x0, LSL #0
    ADD  X19, X30, X28, LSR #0
    ST1 { V28.4S, V29.4S, V30.4S, V31.4S }, [X19]
    LD1 { V8.2D, V9.2D, V10.2D, V11.2D }, [X19]
    ADD  X19, X19, X5, LSR #0
    ST1 { V8.16B, V9.16B, V10.16B, V11.16B }, [X19]
    LD1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X19]
    ADD  X19, X19, X5, LSR #0
    ST1 { V15.2D, V16.2D, V17.2D, V18.2D }, [X19]
    LD1 { V26.2D, V27.2D, V28.2D, V29.2D }, [X19]
    ADD  X19, X19, X5
    ST1 { V14.4S, V15.4S, V16.4S, V17.4S }, [X19]
    LD1 { V12.4S, V13.4S, V14.4S, V15.4S }, [X19]
    ADD  X19, X19, X5, LSR #0
    ST1 { V23.8H, V24.8H, V25.8H, V26.8H }, [X19]
    LD1 { V15.8H, V16.8H, V17.8H, V18.8H }, [X19]
    ADD  X19, X19, X5, LSR #0
    ST1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X19]
    LD1 { V19.8B, V20.8B, V21.8B, V22.8B }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V19.1D, V20.1D, V21.1D, V22.1D }, [X19]
    LD1 { V8.1D, V9.1D, V10.1D, V11.1D }, [X19]
    ADD  X19, X19, X5
    ST1 { V8.2S, V9.2S, V10.2S, V11.2S }, [X19]
    LD1 { V15.2S, V16.2S, V17.2S, V18.2S }, [X19]
    ADD  X19, X19, X5, LSR #0
    ST1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X19]
    LD1 { V23.4H, V24.4H, V25.4H, V26.4H }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V23.8B, V24.8B, V25.8B, V26.8B }, [X19]
    LD1 { V23.8B, V24.8B, V25.8B, V26.8B }, [X19]
    ADD  X19, X19, X5, LSR #0
    ST1 { V24.16B }, [X19]
    LD1 { V19.4S }, [X19]
    ADD  X19, X19, X5
    ST1 { V15.16B }, [X19]
    LD1 { V15.16B }, [X19]
    ADD  X19, X19, X5
    ST1 { V26.2D }, [X19]
    LD1 { V18.2D }, [X19]
    ADD  X19, X19, X5
    ST1 { V19.4S }, [X19]
    LD1 { V9.4S }, [X19]
    ADD  X19, X19, X5
    ST1 { V25.8H }, [X19]
    LD1 { V8.8H }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V9.2S }, [X19]
    LD1 { V26.2S }, [X19]
    ADD  X19, X19, X5
    ST1 { V17.1D }, [X19]
    LD1 { V24.1D }, [X19]
    ADD  X19, X19, X5, LSR #0
    ST1 { V15.2S }, [X19]
    LD1 { V10.2S }, [X19]
    ADD  X19, X19, X5, LSR #0
    ST1 { V24.4H }, [X19]
    LD1 { V9.4H }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V9.8B }, [X19]
    LD1 { V17.8B }, [X19]
    ADD  X19, X19, X5
    ST1 { V22.4S, V23.4S, V24.4S }, [X19]
    LD1 { V22.8H, V23.8H, V24.8H }, [X19]
    ADD  X19, X19, X5
    ST1 { V12.16B, V13.16B, V14.16B }, [X19]
    LD1 { V12.16B, V13.16B, V14.16B }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V22.2D, V23.2D, V24.2D }, [X19]
    LD1 { V22.2D, V23.2D, V24.2D }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V12.4S, V13.4S, V14.4S }, [X19]
    LD1 { V7.4S, V8.4S, V9.4S }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V8.8H, V9.8H, V10.8H }, [X19]
    LD1 { V8.8H, V9.8H, V10.8H }, [X19]
    ADD  X19, X19, X5, LSR #0
    ST1 { V14.8B, V15.8B, V16.8B }, [X19]
    LD1 { V14.4H, V15.4H, V16.4H }, [X19]
    ADD  X19, X19, X5
    ST1 { V22.1D, V23.1D, V24.1D }, [X19]
    LD1 { V5.1D, V6.1D, V7.1D }, [X19]
    ADD  X19, X19, X5
    ST1 { V7.2S, V8.2S, V9.2S }, [X19]
    LD1 { V18.2S, V19.2S, V20.2S }, [X19]
    ADD  X19, X19, X5
    ST1 { V10.4H, V11.4H, V12.4H }, [X19]
    LD1 { V29.4H, V30.4H, V31.4H }, [X19]
    ADD  X19, X19, X5
    ST1 { V13.8B, V14.8B, V15.8B }, [X19]
    LD1 { V17.8B, V18.8B, V19.8B }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V29.8H, V30.8H }, [X19]
    LD1 { V9.8H, V10.8H }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V19.16B, V20.16B }, [X19]
    LD1 { V11.16B, V12.16B }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V5.2D, V6.2D }, [X19]
    LD1 { V28.2D, V29.2D }, [X19]
    ADD  X19, X19, X5
    ST1 { V9.4S, V10.4S }, [X19]
    LD1 { V5.4S, V6.4S }, [X19]
    ADD  X19, X19, X5, ASR #0
    ST1 { V11.8H, V12.8H }, [X19]
    LD1 { V19.8H, V20.8H }, [X19]
    ADD  X19, X19, X5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X14, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V0.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D0
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V1.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D1
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V2.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D2
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V3.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D3
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V4.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D4
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V5.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D5
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D6
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D7
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V8.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D8
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D9
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D10
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D11
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D12
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V13.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D13
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D14
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D15
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D16
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D17
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D18
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D19
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V20.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D20
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V21.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D21
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D22
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D23
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D24
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D25
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D26
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, V27.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D27
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D28
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D29
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D30
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  X14, D31
    SUB  X24, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X23
    FMOV  D2, X25
    FMOV  V2.D[1], X4
    FMOV  D3, X29
    FMOV  V3.D[1], X26
    FMOV  D4, X4
    FMOV  V4.D[1], X25
    FMOV  D5, X15
    FMOV  V5.D[1], X21
    FMOV  D6, X24
    FMOV  V6.D[1], X15
    FMOV  D7, X6
    FMOV  V7.D[1], X26
    FMOV  D8, X25
    FMOV  V8.D[1], X7
    FMOV  D9, X15
    FMOV  V9.D[1], X20
    FMOV  D10, X18
    FMOV  V10.D[1], X24
    FMOV  D11, X4
    FMOV  V11.D[1], X28
    FMOV  D12, X24
    FMOV  V12.D[1], X16
    FMOV  D13, X7
    FMOV  V13.D[1], X6
    FMOV  D14, X21
    FMOV  V14.D[1], X25
    FMOV  D15, X23
    FMOV  V15.D[1], X24
    FMOV  D16, X9
    FMOV  V16.D[1], X9
    FMOV  D17, X26
    FMOV  V17.D[1], X9
    FMOV  D18, X21
    FMOV  V18.D[1], X25
    FMOV  D19, X26
    FMOV  V19.D[1], X15
    FMOV  D20, X17
    FMOV  V20.D[1], X4
    FMOV  D21, X21
    FMOV  V21.D[1], X29
    FMOV  D22, X25
    FMOV  V22.D[1], X17
    FMOV  D23, X29
    FMOV  V23.D[1], X26
    FMOV  D24, X16
    FMOV  V24.D[1], X28
    FMOV  D25, X20
    FMOV  V25.D[1], X29
    FMOV  D26, X9
    FMOV  V26.D[1], X6
    FMOV  D27, X16
    FMOV  V27.D[1], X22
    FMOV  D28, X4
    FMOV  V28.D[1], X26
    FMOV  D29, X7
    FMOV  V29.D[1], X28
    FMOV  D30, X28
    FMOV  V30.D[1], X22
    FMOV  D31, X14
    FMOV  V31.D[1], X20
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X18, #0x500, LSL #0
    ADD  X13, X30, X18, ASR #0
    ST1 { V20.4S, V21.4S, V22.4S, V23.4S }, [X13]
    LD1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X13]
    ADD  X13, X13, X7
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X13]
    LD1 { V18.16B, V19.16B, V20.16B, V21.16B }, [X13]
    ADD  X13, X13, X7
    ST1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X13]
    LD1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V18.4S, V19.4S, V20.4S, V21.4S }, [X13]
    LD1 { V18.4S, V19.4S, V20.4S, V21.4S }, [X13]
    ADD  X13, X13, X7
    ST1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X13]
    LD1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X13]
    LD1 { V6.1D, V7.1D, V8.1D, V9.1D }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V18.1D, V19.1D, V20.1D, V21.1D }, [X13]
    LD1 { V25.1D, V26.1D, V27.1D, V28.1D }, [X13]
    ADD  X13, X13, X7
    ST1 { V29.2S, V30.2S, V31.2S, V0.2S }, [X13]
    LD1 { V8.2S, V9.2S, V10.2S, V11.2S }, [X13]
    ADD  X13, X13, X7
    ST1 { V25.4H, V26.4H, V27.4H, V28.4H }, [X13]
    LD1 { V21.4H, V22.4H, V23.4H, V24.4H }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V6.8B, V7.8B, V8.8B, V9.8B }, [X13]
    LD1 { V28.8B, V29.8B, V30.8B, V31.8B }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V22.2D }, [X13]
    LD1 { V7.4S }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V30.16B }, [X13]
    LD1 { V0.16B }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V10.2D }, [X13]
    LD1 { V18.2D }, [X13]
    ADD  X13, X13, X7
    ST1 { V31.4S }, [X13]
    LD1 { V26.4S }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V21.8H }, [X13]
    LD1 { V10.8H }, [X13]
    ADD  X13, X13, X7
    ST1 { V7.4H }, [X13]
    LD1 { V7.2S }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V10.1D }, [X13]
    LD1 { V6.1D }, [X13]
    ADD  X13, X13, X7
    ST1 { V6.2S }, [X13]
    LD1 { V30.2S }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V30.4H }, [X13]
    LD1 { V21.4H }, [X13]
    ADD  X13, X13, X7
    ST1 { V28.8B }, [X13]
    LD1 { V31.8B }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V4.2D, V5.2D, V6.2D }, [X13]
    LD1 { V22.4S, V23.4S, V24.4S }, [X13]
    ADD  X13, X13, X7
    ST1 { V21.16B, V22.16B, V23.16B }, [X13]
    LD1 { V1.16B, V2.16B, V3.16B }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V13.2D, V14.2D, V15.2D }, [X13]
    LD1 { V4.2D, V5.2D, V6.2D }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V1.4S, V2.4S, V3.4S }, [X13]
    LD1 { V21.4S, V22.4S, V23.4S }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V4.8H, V5.8H, V6.8H }, [X13]
    LD1 { V1.8H, V2.8H, V3.8H }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V21.4H, V22.4H, V23.4H }, [X13]
    LD1 { V4.8B, V5.8B, V6.8B }, [X13]
    ADD  X13, X13, X7
    ST1 { V4.1D, V5.1D, V6.1D }, [X13]
    LD1 { V21.1D, V22.1D, V23.1D }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V1.2S, V2.2S, V3.2S }, [X13]
    LD1 { V13.2S, V14.2S, V15.2S }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V13.4H, V14.4H, V15.4H }, [X13]
    LD1 { V13.4H, V14.4H, V15.4H }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V13.8B, V14.8B, V15.8B }, [X13]
    LD1 { V13.8B, V14.8B, V15.8B }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST1 { V14.2D, V15.2D }, [X13]
    LD1 { V14.16B, V15.16B }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V10.16B, V11.16B }, [X13]
    LD1 { V5.16B, V6.16B }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V29.2D, V30.2D }, [X13]
    LD1 { V8.2D, V9.2D }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V10.4S, V11.4S }, [X13]
    LD1 { V1.4S, V2.4S }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST1 { V8.8H, V9.8H }, [X13]
    LD1 { V8.8H, V9.8H }, [X13]
    ADD  X13, X13, X7, LSR #0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D0
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D1
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D2
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, V3.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D3
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D4
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D5
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D6
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D7
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D8
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D9
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D10
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D11
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, V12.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D12
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D13
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D14
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D15
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, V16.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D16
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, V17.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D17
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D18
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, V19.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D19
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, V20.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D20
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D21
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D22
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D23
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D24
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D25
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D26
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D27
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D28
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D29
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D30
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X17, D31
    SUB  X5, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP01_TestFail
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
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X4
    FMOV  D3, X20
    FMOV  V3.D[1], X23
    FMOV  D4, X16
    FMOV  V4.D[1], X5
    FMOV  D5, X5
    FMOV  V5.D[1], X20
    FMOV  D6, X26
    FMOV  V6.D[1], X16
    FMOV  D7, X24
    FMOV  V7.D[1], X24
    FMOV  D8, X13
    FMOV  V8.D[1], X21
    FMOV  D9, X17
    FMOV  V9.D[1], X10
    FMOV  D10, X6
    FMOV  V10.D[1], X17
    FMOV  D11, X14
    FMOV  V11.D[1], X5
    FMOV  D12, X9
    FMOV  V12.D[1], X11
    FMOV  D13, X11
    FMOV  V13.D[1], X28
    FMOV  D14, X10
    FMOV  V14.D[1], X11
    FMOV  D15, X24
    FMOV  V15.D[1], X13
    FMOV  D16, X25
    FMOV  V16.D[1], X11
    FMOV  D17, X16
    FMOV  V17.D[1], X5
    FMOV  D18, X11
    FMOV  V18.D[1], X10
    FMOV  D19, X14
    FMOV  V19.D[1], X9
    FMOV  D20, X9
    FMOV  V20.D[1], X14
    FMOV  D21, X25
    FMOV  V21.D[1], X13
    FMOV  D22, X28
    FMOV  V22.D[1], X10
    FMOV  D23, X25
    FMOV  V23.D[1], X17
    FMOV  D24, X12
    FMOV  V24.D[1], X5
    FMOV  D25, X12
    FMOV  V25.D[1], X24
    FMOV  D26, X14
    FMOV  V26.D[1], X16
    FMOV  D27, X12
    FMOV  V27.D[1], X17
    FMOV  D28, X16
    FMOV  V28.D[1], X28
    FMOV  D29, X4
    FMOV  V29.D[1], X10
    FMOV  D30, X4
    FMOV  V30.D[1], X7
    FMOV  D31, X25
    FMOV  V31.D[1], X16
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X12, #0xa00, LSL #0
    ADD  X9, X30, X12, ASR #0
    ST1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X9]
    LD1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V25.16B, V26.16B, V27.16B, V28.16B }, [X9]
    LD1 { V12.16B, V13.16B, V14.16B, V15.16B }, [X9]
    ADD  X9, X9, X29
    ST1 { V12.2D, V13.2D, V14.2D, V15.2D }, [X9]
    LD1 { V9.2D, V10.2D, V11.2D, V12.2D }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V14.4S, V15.4S, V16.4S, V17.4S }, [X9]
    LD1 { V21.4S, V22.4S, V23.4S, V24.4S }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V21.8H, V22.8H, V23.8H, V24.8H }, [X9]
    LD1 { V16.8H, V17.8H, V18.8H, V19.8H }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V16.8B, V17.8B, V18.8B, V19.8B }, [X9]
    LD1 { V14.4H, V15.4H, V16.4H, V17.4H }, [X9]
    ADD  X9, X9, X29
    ST1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X9]
    LD1 { V22.1D, V23.1D, V24.1D, V25.1D }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V11.2S, V12.2S, V13.2S, V14.2S }, [X9]
    LD1 { V11.2S, V12.2S, V13.2S, V14.2S }, [X9]
    ADD  X9, X9, X29
    ST1 { V25.4H, V26.4H, V27.4H, V28.4H }, [X9]
    LD1 { V25.4H, V26.4H, V27.4H, V28.4H }, [X9]
    ADD  X9, X9, X29
    ST1 { V23.8B, V24.8B, V25.8B, V26.8B }, [X9]
    LD1 { V23.8B, V24.8B, V25.8B, V26.8B }, [X9]
    ADD  X9, X9, X29
    ST1 { V25.2D }, [X9]
    LD1 { V9.8H }, [X9]
    ADD  X9, X9, X29
    ST1 { V13.16B }, [X9]
    LD1 { V18.16B }, [X9]
    ADD  X9, X9, X29
    ST1 { V23.2D }, [X9]
    LD1 { V23.2D }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V15.4S }, [X9]
    LD1 { V15.4S }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V24.8H }, [X9]
    LD1 { V19.8H }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V9.4H }, [X9]
    LD1 { V13.4H }, [X9]
    ADD  X9, X9, X29
    ST1 { V23.1D }, [X9]
    LD1 { V24.1D }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V27.2S }, [X9]
    LD1 { V25.2S }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V13.4H }, [X9]
    LD1 { V30.4H }, [X9]
    ADD  X9, X9, X29
    ST1 { V19.8B }, [X9]
    LD1 { V27.8B }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V15.2D, V16.2D, V17.2D }, [X9]
    LD1 { V1.16B, V2.16B, V3.16B }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V1.16B, V2.16B, V3.16B }, [X9]
    LD1 { V15.16B, V16.16B, V17.16B }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V26.2D, V27.2D, V28.2D }, [X9]
    LD1 { V23.2D, V24.2D, V25.2D }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V23.4S, V24.4S, V25.4S }, [X9]
    LD1 { V26.4S, V27.4S, V28.4S }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V26.8H, V27.8H, V28.8H }, [X9]
    LD1 { V1.8H, V2.8H, V3.8H }, [X9]
    ADD  X9, X9, X29
    ST1 { V13.1D, V14.1D, V15.1D }, [X9]
    LD1 { V13.4H, V14.4H, V15.4H }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V1.1D, V2.1D, V3.1D }, [X9]
    LD1 { V1.1D, V2.1D, V3.1D }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V9.2S, V10.2S, V11.2S }, [X9]
    LD1 { V24.2S, V25.2S, V26.2S }, [X9]
    ADD  X9, X9, X29
    ST1 { V1.4H, V2.4H, V3.4H }, [X9]
    LD1 { V9.4H, V10.4H, V11.4H }, [X9]
    ADD  X9, X9, X29, ASR #0
    ST1 { V13.8B, V14.8B, V15.8B }, [X9]
    LD1 { V13.8B, V14.8B, V15.8B }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V9.16B, V10.16B }, [X9]
    LD1 { V9.16B, V10.16B }, [X9]
    ADD  X9, X9, X29
    ST1 { V24.16B, V25.16B }, [X9]
    LD1 { V2.16B, V3.16B }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V10.2D, V11.2D }, [X9]
    LD1 { V10.2D, V11.2D }, [X9]
    ADD  X9, X9, X29, LSR #0
    ST1 { V2.4S, V3.4S }, [X9]
    LD1 { V24.4S, V25.4S }, [X9]
    ADD  X9, X9, X29
    ST1 { V24.8H, V25.8H }, [X9]
    LD1 { V2.8H, V3.8H }, [X9]
    ADD  X9, X9, X29, LSR #0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X21
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X14, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V0.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D0
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V1.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D1
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D2
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D3
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V4.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D4
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V5.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D5
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V6.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D6
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V7.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D7
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V8.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D8
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V9.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D9
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V10.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D10
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V11.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D11
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V12.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D12
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V13.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D13
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V14.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D14
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V15.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D15
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V16.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D16
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V17.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D17
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D18
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V19.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D19
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V20.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D20
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V21.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D21
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V22.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D22
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V23.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D23
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V24.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D24
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D25
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D26
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D27
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D28
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V29.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D29
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X14, V30.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D30
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, V31.D[1]
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X14, D31
    SUB  X11, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
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
    FMOV  D1, X29
    FMOV  V1.D[1], X24
    FMOV  D2, X25
    FMOV  V2.D[1], X4
    FMOV  D3, X23
    FMOV  V3.D[1], X4
    FMOV  D4, X23
    FMOV  V4.D[1], X18
    FMOV  D5, X26
    FMOV  V5.D[1], X6
    FMOV  D6, X15
    FMOV  V6.D[1], X4
    FMOV  D7, X13
    FMOV  V7.D[1], X15
    FMOV  D8, X9
    FMOV  V8.D[1], X7
    FMOV  D9, X29
    FMOV  V9.D[1], X7
    FMOV  D10, X19
    FMOV  V10.D[1], X21
    FMOV  D11, X13
    FMOV  V11.D[1], X9
    FMOV  D12, X13
    FMOV  V12.D[1], X13
    FMOV  D13, X7
    FMOV  V13.D[1], X7
    FMOV  D14, X17
    FMOV  V14.D[1], X14
    FMOV  D15, X23
    FMOV  V15.D[1], X16
    FMOV  D16, X25
    FMOV  V16.D[1], X25
    FMOV  D17, X26
    FMOV  V17.D[1], X26
    FMOV  D18, X25
    FMOV  V18.D[1], X11
    FMOV  D19, X11
    FMOV  V19.D[1], X9
    FMOV  D20, X18
    FMOV  V20.D[1], X5
    FMOV  D21, X10
    FMOV  V21.D[1], X16
    FMOV  D22, X23
    FMOV  V22.D[1], X9
    FMOV  D23, X23
    FMOV  V23.D[1], X5
    FMOV  D24, X7
    FMOV  V24.D[1], X20
    FMOV  D25, X19
    FMOV  V25.D[1], X14
    FMOV  D26, X20
    FMOV  V26.D[1], X14
    FMOV  D27, X25
    FMOV  V27.D[1], X23
    FMOV  D28, X19
    FMOV  V28.D[1], X29
    FMOV  D29, X25
    FMOV  V29.D[1], X19
    FMOV  D30, X16
    FMOV  V30.D[1], X25
    FMOV  D31, X9
    FMOV  V31.D[1], X26
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X11, #0xf00, LSL #0
    ADD  X25, X30, X11
    ST1 { V23.4S, V24.4S, V25.4S, V26.4S }, [X25]
    LD1 { V28.2D, V29.2D, V30.2D, V31.2D }, [X25]
    ADD  X25, X25, X15
    ST1 { V28.16B, V29.16B, V30.16B, V31.16B }, [X25]
    LD1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X25]
    ADD  X25, X25, X15
    ST1 { V26.2D, V27.2D, V28.2D, V29.2D }, [X25]
    LD1 { V3.2D, V4.2D, V5.2D, V6.2D }, [X25]
    ADD  X25, X25, X15, LSR #0
    ST1 { V3.4S, V4.4S, V5.4S, V6.4S }, [X25]
    LD1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X25]
    ADD  X25, X25, X15, LSR #0
    ST1 { V9.8H, V10.8H, V11.8H, V12.8H }, [X25]
    LD1 { V24.8H, V25.8H, V26.8H, V27.8H }, [X25]
    ADD  X25, X25, X15
    ST1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X25]
    LD1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X25]
    ADD  X25, X25, X15, LSR #0
    ST1 { V9.1D, V10.1D, V11.1D, V12.1D }, [X25]
    LD1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X25]
    ADD  X25, X25, X15, ASR #0
    ST1 { V3.2S, V4.2S, V5.2S, V6.2S }, [X25]
    LD1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X25]
    ADD  X25, X25, X15
    ST1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X25]
    LD1 { V30.4H, V31.4H, V0.4H, V1.4H }, [X25]
    ADD  X25, X25, X15
    ST1 { V23.8B, V24.8B, V25.8B, V26.8B }, [X25]
    LD1 { V11.8B, V12.8B, V13.8B, V14.8B }, [X25]
    ADD  X25, X25, X15
    ST1 { V27.16B }, [X25]
    LD1 { V4.16B }, [X25]
    ADD  X25, X25, X15, ASR #0
    ST1 { V4.16B }, [X25]
    LD1 { V4.16B }, [X25]
    ADD  X25, X25, X15, ASR #0
    ST1 { V4.2D }, [X25]
    LD1 { V4.2D }, [X25]
    ADD  X25, X25, X15, ASR #0
    ST1 { V20.4S }, [X25]
    LD1 { V23.4S }, [X25]
    ADD  X25, X25, X15
    ST1 { V3.8H }, [X25]
    LD1 { V27.8H }, [X25]
    ADD  X25, X25, X15, ASR #0
    ST1 { V31.8B }, [X25]
    LD1 { V26.4H }, [X25]
    ADD  X25, X25, X15
    ST1 { V0.1D }, [X25]
    LD1 { V0.1D }, [X25]
    ADD  X25, X25, X15, LSR #0
    ST1 { V23.2S }, [X25]
    LD1 { V3.2S }, [X25]
    ADD  X25, X25, X15, ASR #0
    ST1 { V0.4H }, [X25]
    LD1 { V0.4H }, [X25]
    ADD  X25, X25, X15
    ST1 { V27.8B }, [X25]
    LD1 { V23.8B }, [X25]
    ADD  X25, X25, X15, ASR #0
    ST1 { V19.2D, V20.2D, V21.2D }, [X25]
    LD1 { V19.16B, V20.16B, V21.16B }, [X25]
    ADD  X25, X25, X15, LSR #0
    ST1 { V19.16B, V20.16B, V21.16B }, [X25]
    LD1 { V2.16B, V3.16B, V4.16B }, [X25]
    ADD  X25, X25, X15
    ST1 { V2.2D, V3.2D, V4.2D }, [X25]
    LD1 { V15.2D, V16.2D, V17.2D }, [X25]
    ADD  X25, X25, X15, LSR #0
    ST1 { V15.4S, V16.4S, V17.4S }, [X25]
    LD1 { V4.4S, V5.4S, V6.4S }, [X25]
    ADD  X25, X25, X15, ASR #0
    ST1 { V4.8H, V5.8H, V6.8H }, [X25]
    LD1 { V18.8H, V19.8H, V20.8H }, [X25]
    ADD  X25, X25, X15
    ST1 { V18.8B, V19.8B, V20.8B }, [X25]
    LD1 { V3.2S, V4.2S, V5.2S }, [X25]
    ADD  X25, X25, X15, ASR #0
    ST1 { V18.1D, V19.1D, V20.1D }, [X25]
    LD1 { V11.1D, V12.1D, V13.1D }, [X25]
    ADD  X25, X25, X15, LSR #0
    ST1 { V11.2S, V12.2S, V13.2S }, [X25]
    LD1 { V31.2S, V0.2S, V1.2S }, [X25]
    ADD  X25, X25, X15, LSR #0
    ST1 { V31.4H, V0.4H, V1.4H }, [X25]
    LD1 { V25.4H, V26.4H, V27.4H }, [X25]
    ADD  X25, X25, X15
    ST1 { V25.8B, V26.8B, V27.8B }, [X25]
    LD1 { V18.8B, V19.8B, V20.8B }, [X25]
    ADD  X25, X25, X15
    ST1 { V19.2D, V20.2D }, [X25]
    LD1 { V15.4S, V16.4S }, [X25]
    ADD  X25, X25, X15
    ST1 { V3.16B, V4.16B }, [X25]
    LD1 { V12.16B, V13.16B }, [X25]
    ADD  X25, X25, X15
    ST1 { V12.2D, V13.2D }, [X25]
    LD1 { V6.2D, V7.2D }, [X25]
    ADD  X25, X25, X15
    ST1 { V6.4S, V7.4S }, [X25]
    LD1 { V3.4S, V4.4S }, [X25]
    ADD  X25, X25, X15
    ST1 { V24.8H, V25.8H }, [X25]
    LD1 { V26.8H, V27.8H }, [X25]
    ADD  X25, X25, X15, ASR #0
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X9, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V2.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V4.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V26.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V28.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, V29.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X18
    FMOV  D3, X7
    FMOV  V3.D[1], X23
    FMOV  D4, X15
    FMOV  V4.D[1], X7
    FMOV  D5, X17
    FMOV  V5.D[1], X17
    FMOV  D6, X12
    FMOV  V6.D[1], X23
    FMOV  D7, X13
    FMOV  V7.D[1], X12
    FMOV  D8, X4
    FMOV  V8.D[1], X19
    FMOV  D9, X4
    FMOV  V9.D[1], X9
    FMOV  D10, X15
    FMOV  V10.D[1], X10
    FMOV  D11, X19
    FMOV  V11.D[1], X6
    FMOV  D12, X28
    FMOV  V12.D[1], X12
    FMOV  D13, X10
    FMOV  V13.D[1], X28
    FMOV  D14, X25
    FMOV  V14.D[1], X20
    FMOV  D15, X16
    FMOV  V15.D[1], X7
    FMOV  D16, X26
    FMOV  V16.D[1], X20
    FMOV  D17, X17
    FMOV  V17.D[1], X25
    FMOV  D18, X15
    FMOV  V18.D[1], X7
    FMOV  D19, X13
    FMOV  V19.D[1], X6
    FMOV  D20, X15
    FMOV  V20.D[1], X7
    FMOV  D21, X10
    FMOV  V21.D[1], X29
    FMOV  D22, X12
    FMOV  V22.D[1], X5
    FMOV  D23, X20
    FMOV  V23.D[1], X17
    FMOV  D24, X19
    FMOV  V24.D[1], X23
    FMOV  D25, X13
    FMOV  V25.D[1], X21
    FMOV  D26, X11
    FMOV  V26.D[1], X4
    FMOV  D27, X19
    FMOV  V27.D[1], X21
    FMOV  D28, X14
    FMOV  V28.D[1], X13
    FMOV  D29, X21
    FMOV  V29.D[1], X7
    FMOV  D30, X12
    FMOV  V30.D[1], X28
    FMOV  D31, X5
    FMOV  V31.D[1], X20
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X28, #0x1400, LSL #0
    ADD  X21, X30, X28
    ST1 { V26.16B, V27.16B, V28.16B, V29.16B }, [X21]
    LD1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X21]
    ADD  X21, X21, X26
    ST1 { V19.16B, V20.16B, V21.16B, V22.16B }, [X21]
    LD1 { V19.16B, V20.16B, V21.16B, V22.16B }, [X21]
    ADD  X21, X21, X26
    ST1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X21]
    LD1 { V12.2D, V13.2D, V14.2D, V15.2D }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V19.4S, V20.4S, V21.4S, V22.4S }, [X21]
    LD1 { V29.4S, V30.4S, V31.4S, V0.4S }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V27.8H, V28.8H, V29.8H, V30.8H }, [X21]
    LD1 { V19.8H, V20.8H, V21.8H, V22.8H }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V19.2S, V20.2S, V21.2S, V22.2S }, [X21]
    LD1 { V10.4H, V11.4H, V12.4H, V13.4H }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V10.1D, V11.1D, V12.1D, V13.1D }, [X21]
    LD1 { V7.1D, V8.1D, V9.1D, V10.1D }, [X21]
    ADD  X21, X21, X26
    ST1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X21]
    LD1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X21]
    LD1 { V12.4H, V13.4H, V14.4H, V15.4H }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V12.8B, V13.8B, V14.8B, V15.8B }, [X21]
    LD1 { V7.8B, V8.8B, V9.8B, V10.8B }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V7.8H }, [X21]
    LD1 { V7.8H }, [X21]
    ADD  X21, X21, X26
    ST1 { V9.16B }, [X21]
    LD1 { V14.16B }, [X21]
    ADD  X21, X21, X26
    ST1 { V10.2D }, [X21]
    LD1 { V20.2D }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V8.4S }, [X21]
    LD1 { V8.4S }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V7.8H }, [X21]
    LD1 { V12.8H }, [X21]
    ADD  X21, X21, X26
    ST1 { V12.1D }, [X21]
    LD1 { V10.1D }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V14.1D }, [X21]
    LD1 { V7.1D }, [X21]
    ADD  X21, X21, X26
    ST1 { V10.2S }, [X21]
    LD1 { V10.2S }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V20.4H }, [X21]
    LD1 { V12.4H }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V10.8B }, [X21]
    LD1 { V14.8B }, [X21]
    ADD  X21, X21, X26
    ST1 { V4.8H, V5.8H, V6.8H }, [X21]
    LD1 { V4.4S, V5.4S, V6.4S }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V5.16B, V6.16B, V7.16B }, [X21]
    LD1 { V5.16B, V6.16B, V7.16B }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V5.2D, V6.2D, V7.2D }, [X21]
    LD1 { V1.2D, V2.2D, V3.2D }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V1.4S, V2.4S, V3.4S }, [X21]
    LD1 { V26.4S, V27.4S, V28.4S }, [X21]
    ADD  X21, X21, X26
    ST1 { V26.8H, V27.8H, V28.8H }, [X21]
    LD1 { V28.8H, V29.8H, V30.8H }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V8.4H, V9.4H, V10.4H }, [X21]
    LD1 { V12.4H, V13.4H, V14.4H }, [X21]
    ADD  X21, X21, X26
    ST1 { V28.1D, V29.1D, V30.1D }, [X21]
    LD1 { V8.1D, V9.1D, V10.1D }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V10.2S, V11.2S, V12.2S }, [X21]
    LD1 { V26.2S, V27.2S, V28.2S }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V26.4H, V27.4H, V28.4H }, [X21]
    LD1 { V1.4H, V2.4H, V3.4H }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V1.8B, V2.8B, V3.8B }, [X21]
    LD1 { V10.8B, V11.8B, V12.8B }, [X21]
    ADD  X21, X21, X26
    ST1 { V8.4S, V9.4S }, [X21]
    LD1 { V29.8H, V30.8H }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V13.16B, V14.16B }, [X21]
    LD1 { V13.16B, V14.16B }, [X21]
    ADD  X21, X21, X26
    ST1 { V11.2D, V12.2D }, [X21]
    LD1 { V31.2D, V0.2D }, [X21]
    ADD  X21, X21, X26, ASR #0
    ST1 { V6.4S, V7.4S }, [X21]
    LD1 { V11.4S, V12.4S }, [X21]
    ADD  X21, X21, X26, LSR #0
    ST1 { V31.8H, V0.8H }, [X21]
    LD1 { V31.8H, V0.8H }, [X21]
    ADD  X21, X21, X26
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X17, X25, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D0
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D1
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D2
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D3
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V4.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D4
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V5.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D5
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V6.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D6
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D7
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D8
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D9
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D10
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V11.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D11
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D12
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D13
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D14
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D15
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V16.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D16
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V17.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D17
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V18.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D18
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V19.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D19
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D20
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V21.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D21
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V22.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D22
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V23.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D23
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V24.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D24
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, V25.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D25
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D26
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D27
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D28
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D29
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D30
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X17, D31
    SUB  X11, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X11
    FMOV  V2.D[1], X9
    FMOV  D3, X9
    FMOV  V3.D[1], X7
    FMOV  D4, X23
    FMOV  V4.D[1], X28
    FMOV  D5, X29
    FMOV  V5.D[1], X11
    FMOV  D6, X22
    FMOV  V6.D[1], X20
    FMOV  D7, X12
    FMOV  V7.D[1], X17
    FMOV  D8, X23
    FMOV  V8.D[1], X10
    FMOV  D9, X23
    FMOV  V9.D[1], X20
    FMOV  D10, X16
    FMOV  V10.D[1], X6
    FMOV  D11, X26
    FMOV  V11.D[1], X23
    FMOV  D12, X7
    FMOV  V12.D[1], X15
    FMOV  D13, X18
    FMOV  V13.D[1], X5
    FMOV  D14, X10
    FMOV  V14.D[1], X18
    FMOV  D15, X12
    FMOV  V15.D[1], X26
    FMOV  D16, X12
    FMOV  V16.D[1], X24
    FMOV  D17, X17
    FMOV  V17.D[1], X13
    FMOV  D18, X9
    FMOV  V18.D[1], X18
    FMOV  D19, X17
    FMOV  V19.D[1], X15
    FMOV  D20, X21
    FMOV  V20.D[1], X14
    FMOV  D21, X11
    FMOV  V21.D[1], X10
    FMOV  D22, X12
    FMOV  V22.D[1], X7
    FMOV  D23, X17
    FMOV  V23.D[1], X23
    FMOV  D24, X25
    FMOV  V24.D[1], X23
    FMOV  D25, X26
    FMOV  V25.D[1], X14
    FMOV  D26, X20
    FMOV  V26.D[1], X20
    FMOV  D27, X6
    FMOV  V27.D[1], X17
    FMOV  D28, X25
    FMOV  V28.D[1], X17
    FMOV  D29, X26
    FMOV  V29.D[1], X24
    FMOV  D30, X9
    FMOV  V30.D[1], X13
    FMOV  D31, X24
    FMOV  V31.D[1], X26
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X18, #0x40, LSL #0
    MOVZ  X9, #0x1900, LSL #0
    ADD  X7, X30, X9
    ST1 { V25.4S, V26.4S, V27.4S, V28.4S }, [X7]
    LD1 { V8.2D, V9.2D, V10.2D, V11.2D }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V8.16B, V9.16B, V10.16B, V11.16B }, [X7]
    LD1 { V19.16B, V20.16B, V21.16B, V22.16B }, [X7]
    ADD  X7, X7, X18
    ST1 { V13.2D, V14.2D, V15.2D, V16.2D }, [X7]
    LD1 { V4.2D, V5.2D, V6.2D, V7.2D }, [X7]
    ADD  X7, X7, X18, LSR #0
    ST1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X7]
    LD1 { V25.4S, V26.4S, V27.4S, V28.4S }, [X7]
    ADD  X7, X7, X18
    ST1 { V14.8H, V15.8H, V16.8H, V17.8H }, [X7]
    LD1 { V14.8H, V15.8H, V16.8H, V17.8H }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V25.2S, V26.2S, V27.2S, V28.2S }, [X7]
    LD1 { V25.4H, V26.4H, V27.4H, V28.4H }, [X7]
    ADD  X7, X7, X18, LSR #0
    ST1 { V4.1D, V5.1D, V6.1D, V7.1D }, [X7]
    LD1 { V8.1D, V9.1D, V10.1D, V11.1D }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V31.2S, V0.2S, V1.2S, V2.2S }, [X7]
    LD1 { V31.2S, V0.2S, V1.2S, V2.2S }, [X7]
    ADD  X7, X7, X18, LSR #0
    ST1 { V8.4H, V9.4H, V10.4H, V11.4H }, [X7]
    LD1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X7]
    ADD  X7, X7, X18, LSR #0
    ST1 { V25.8B, V26.8B, V27.8B, V28.8B }, [X7]
    LD1 { V5.8B, V6.8B, V7.8B, V8.8B }, [X7]
    ADD  X7, X7, X18
    ST1 { V6.8H }, [X7]
    LD1 { V11.16B }, [X7]
    ADD  X7, X7, X18, LSR #0
    ST1 { V16.16B }, [X7]
    LD1 { V30.16B }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V11.2D }, [X7]
    LD1 { V11.2D }, [X7]
    ADD  X7, X7, X18, LSR #0
    ST1 { V7.4S }, [X7]
    LD1 { V4.4S }, [X7]
    ADD  X7, X7, X18
    ST1 { V4.8H }, [X7]
    LD1 { V21.8H }, [X7]
    ADD  X7, X7, X18
    ST1 { V5.4H }, [X7]
    LD1 { V24.1D }, [X7]
    ADD  X7, X7, X18
    ST1 { V8.1D }, [X7]
    LD1 { V16.1D }, [X7]
    ADD  X7, X7, X18
    ST1 { V11.2S }, [X7]
    LD1 { V11.2S }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V10.4H }, [X7]
    LD1 { V7.4H }, [X7]
    ADD  X7, X7, X18
    ST1 { V24.8B }, [X7]
    LD1 { V6.8B }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V6.4S, V7.4S, V8.4S }, [X7]
    LD1 { V5.2D, V6.2D, V7.2D }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V5.16B, V6.16B, V7.16B }, [X7]
    LD1 { V5.16B, V6.16B, V7.16B }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V5.2D, V6.2D, V7.2D }, [X7]
    LD1 { V5.2D, V6.2D, V7.2D }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V29.4S, V30.4S, V31.4S }, [X7]
    LD1 { V29.4S, V30.4S, V31.4S }, [X7]
    ADD  X7, X7, X18
    ST1 { V5.8H, V6.8H, V7.8H }, [X7]
    LD1 { V6.8H, V7.8H, V8.8H }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V6.4H, V7.4H, V8.4H }, [X7]
    LD1 { V5.8B, V6.8B, V7.8B }, [X7]
    ADD  X7, X7, X18
    ST1 { V5.1D, V6.1D, V7.1D }, [X7]
    LD1 { V5.1D, V6.1D, V7.1D }, [X7]
    ADD  X7, X7, X18, LSR #0
    ST1 { V29.2S, V30.2S, V31.2S }, [X7]
    LD1 { V16.2S, V17.2S, V18.2S }, [X7]
    ADD  X7, X7, X18
    ST1 { V8.4H, V9.4H, V10.4H }, [X7]
    LD1 { V8.4H, V9.4H, V10.4H }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V16.8B, V17.8B, V18.8B }, [X7]
    LD1 { V29.8B, V30.8B, V31.8B }, [X7]
    ADD  X7, X7, X18
    ST1 { V5.4S, V6.4S }, [X7]
    LD1 { V17.8H, V18.8H }, [X7]
    ADD  X7, X7, X18
    ST1 { V29.16B, V30.16B }, [X7]
    LD1 { V29.16B, V30.16B }, [X7]
    ADD  X7, X7, X18
    ST1 { V9.2D, V10.2D }, [X7]
    LD1 { V5.2D, V6.2D }, [X7]
    ADD  X7, X7, X18
    ST1 { V29.4S, V30.4S }, [X7]
    LD1 { V29.4S, V30.4S }, [X7]
    ADD  X7, X7, X18, ASR #0
    ST1 { V26.8H, V27.8H }, [X7]
    LD1 { V17.8H, V18.8H }, [X7]
    ADD  X7, X7, X18
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X29, FPSR
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D0
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D1
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D2
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V3.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D3
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D4
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D5
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D6
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D7
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D8
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D9
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D10
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D11
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V12.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D12
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V13.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D13
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V14.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D14
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V15.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D15
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D16
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D17
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D18
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V19.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D19
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V20.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D20
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D21
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V22.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D22
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V23.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D23
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V24.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D24
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V25.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D25
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D26
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V27.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D27
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V28.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D28
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D29
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D30
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D31
    SUB  X15, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X22
    FMOV  D1, X24
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X23
    FMOV  D3, X6
    FMOV  V3.D[1], X18
    FMOV  D4, X6
    FMOV  V4.D[1], X18
    FMOV  D5, X22
    FMOV  V5.D[1], X20
    FMOV  D6, X11
    FMOV  V6.D[1], X29
    FMOV  D7, X24
    FMOV  V7.D[1], X18
    FMOV  D8, X29
    FMOV  V8.D[1], X9
    FMOV  D9, X26
    FMOV  V9.D[1], X25
    FMOV  D10, X7
    FMOV  V10.D[1], X29
    FMOV  D11, X5
    FMOV  V11.D[1], X11
    FMOV  D12, X21
    FMOV  V12.D[1], X15
    FMOV  D13, X17
    FMOV  V13.D[1], X6
    FMOV  D14, X10
    FMOV  V14.D[1], X9
    FMOV  D15, X4
    FMOV  V15.D[1], X14
    FMOV  D16, X22
    FMOV  V16.D[1], X28
    FMOV  D17, X15
    FMOV  V17.D[1], X19
    FMOV  D18, X21
    FMOV  V18.D[1], X29
    FMOV  D19, X18
    FMOV  V19.D[1], X29
    FMOV  D20, X15
    FMOV  V20.D[1], X17
    FMOV  D21, X16
    FMOV  V21.D[1], X10
    FMOV  D22, X22
    FMOV  V22.D[1], X11
    FMOV  D23, X5
    FMOV  V23.D[1], X29
    FMOV  D24, X18
    FMOV  V24.D[1], X29
    FMOV  D25, X10
    FMOV  V25.D[1], X24
    FMOV  D26, X11
    FMOV  V26.D[1], X20
    FMOV  D27, X10
    FMOV  V27.D[1], X11
    FMOV  D28, X25
    FMOV  V28.D[1], X22
    FMOV  D29, X29
    FMOV  V29.D[1], X6
    FMOV  D30, X6
    FMOV  V30.D[1], X10
    FMOV  D31, X14
    FMOV  V31.D[1], X10
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X23, #0x1e00, LSL #0
    ADD  X22, X30, X23, LSR #0
    ST1 { V11.8H, V12.8H, V13.8H, V14.8H }, [X22]
    LD1 { V21.8H, V22.8H, V23.8H, V24.8H }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST1 { V24.16B, V25.16B, V26.16B, V27.16B }, [X22]
    LD1 { V4.16B, V5.16B, V6.16B, V7.16B }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V28.2D, V29.2D, V30.2D, V31.2D }, [X22]
    LD1 { V4.2D, V5.2D, V6.2D, V7.2D }, [X22]
    ADD  X22, X22, X14
    ST1 { V4.4S, V5.4S, V6.4S, V7.4S }, [X22]
    LD1 { V11.4S, V12.4S, V13.4S, V14.4S }, [X22]
    ADD  X22, X22, X14
    ST1 { V11.8H, V12.8H, V13.8H, V14.8H }, [X22]
    LD1 { V25.8H, V26.8H, V27.8H, V28.8H }, [X22]
    ADD  X22, X22, X14
    ST1 { V27.8B, V28.8B, V29.8B, V30.8B }, [X22]
    LD1 { V28.8B, V29.8B, V30.8B, V31.8B }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V18.1D, V19.1D, V20.1D, V21.1D }, [X22]
    LD1 { V3.1D, V4.1D, V5.1D, V6.1D }, [X22]
    ADD  X22, X22, X14
    ST1 { V28.2S, V29.2S, V30.2S, V31.2S }, [X22]
    LD1 { V28.2S, V29.2S, V30.2S, V31.2S }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V3.4H, V4.4H, V5.4H, V6.4H }, [X22]
    LD1 { V11.4H, V12.4H, V13.4H, V14.4H }, [X22]
    ADD  X22, X22, X14
    ST1 { V28.8B, V29.8B, V30.8B, V31.8B }, [X22]
    LD1 { V27.8B, V28.8B, V29.8B, V30.8B }, [X22]
    ADD  X22, X22, X14
    ST1 { V13.4S }, [X22]
    LD1 { V6.16B }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V25.16B }, [X22]
    LD1 { V19.16B }, [X22]
    ADD  X22, X22, X14
    ST1 { V12.2D }, [X22]
    LD1 { V3.2D }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST1 { V29.4S }, [X22]
    LD1 { V31.4S }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST1 { V11.8H }, [X22]
    LD1 { V25.8H }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V6.1D }, [X22]
    LD1 { V11.4H }, [X22]
    ADD  X22, X22, X14
    ST1 { V19.1D }, [X22]
    LD1 { V13.1D }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V13.2S }, [X22]
    LD1 { V12.2S }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST1 { V28.4H }, [X22]
    LD1 { V6.4H }, [X22]
    ADD  X22, X22, X14
    ST1 { V6.8B }, [X22]
    LD1 { V19.8B }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V15.16B, V16.16B, V17.16B }, [X22]
    LD1 { V2.2D, V3.2D, V4.2D }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST1 { V15.16B, V16.16B, V17.16B }, [X22]
    LD1 { V15.16B, V16.16B, V17.16B }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V15.2D, V16.2D, V17.2D }, [X22]
    LD1 { V15.2D, V16.2D, V17.2D }, [X22]
    ADD  X22, X22, X14
    ST1 { V15.4S, V16.4S, V17.4S }, [X22]
    LD1 { V15.4S, V16.4S, V17.4S }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V9.8H, V10.8H, V11.8H }, [X22]
    LD1 { V9.8H, V10.8H, V11.8H }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V15.2S, V16.2S, V17.2S }, [X22]
    LD1 { V29.1D, V30.1D, V31.1D }, [X22]
    ADD  X22, X22, X14
    ST1 { V29.1D, V30.1D, V31.1D }, [X22]
    LD1 { V26.1D, V27.1D, V28.1D }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V21.2S, V22.2S, V23.2S }, [X22]
    LD1 { V21.2S, V22.2S, V23.2S }, [X22]
    ADD  X22, X22, X14
    ST1 { V21.4H, V22.4H, V23.4H }, [X22]
    LD1 { V29.4H, V30.4H, V31.4H }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V9.8B, V10.8B, V11.8B }, [X22]
    LD1 { V9.8B, V10.8B, V11.8B }, [X22]
    ADD  X22, X22, X14
    ST1 { V9.4S, V10.4S }, [X22]
    LD1 { V16.16B, V17.16B }, [X22]
    ADD  X22, X22, X14
    ST1 { V16.16B, V17.16B }, [X22]
    LD1 { V23.16B, V24.16B }, [X22]
    ADD  X22, X22, X14
    ST1 { V23.2D, V24.2D }, [X22]
    LD1 { V21.2D, V22.2D }, [X22]
    ADD  X22, X22, X14, ASR #0
    ST1 { V27.4S, V28.4S }, [X22]
    LD1 { V9.4S, V10.4S }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST1 { V29.8H, V30.8H }, [X22]
    LD1 { V28.8H, V29.8H }, [X22]
    ADD  X22, X22, X14, LSR #0
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X17, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V0.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D0
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V1.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D1
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V2.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D2
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V3.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D3
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V4.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D4
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D5
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D6
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V7.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D7
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V8.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D8
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D9
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D10
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D11
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D12
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D13
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V14.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D14
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V15.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D15
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D16
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D17
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V18.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D18
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V19.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D19
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, V20.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D20
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D21
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V22.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D22
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D23
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D24
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D25
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D26
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D27
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D28
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D29
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D30
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X17, D31
    SUB  X9, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP01_TestFail
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
    FMOV  D1, X22
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X10
    FMOV  V3.D[1], X14
    FMOV  D4, X24
    FMOV  V4.D[1], X9
    FMOV  D5, X19
    FMOV  V5.D[1], X7
    FMOV  D6, X21
    FMOV  V6.D[1], X13
    FMOV  D7, X19
    FMOV  V7.D[1], X29
    FMOV  D8, X22
    FMOV  V8.D[1], X26
    FMOV  D9, X4
    FMOV  V9.D[1], X28
    FMOV  D10, X10
    FMOV  V10.D[1], X11
    FMOV  D11, X9
    FMOV  V11.D[1], X6
    FMOV  D12, X24
    FMOV  V12.D[1], X23
    FMOV  D13, X25
    FMOV  V13.D[1], X20
    FMOV  D14, X29
    FMOV  V14.D[1], X12
    FMOV  D15, X6
    FMOV  V15.D[1], X23
    FMOV  D16, X24
    FMOV  V16.D[1], X14
    FMOV  D17, X21
    FMOV  V17.D[1], X19
    FMOV  D18, X22
    FMOV  V18.D[1], X19
    FMOV  D19, X7
    FMOV  V19.D[1], X26
    FMOV  D20, X4
    FMOV  V20.D[1], X23
    FMOV  D21, X9
    FMOV  V21.D[1], X9
    FMOV  D22, X17
    FMOV  V22.D[1], X14
    FMOV  D23, X13
    FMOV  V23.D[1], X7
    FMOV  D24, X23
    FMOV  V24.D[1], X22
    FMOV  D25, X18
    FMOV  V25.D[1], X13
    FMOV  D26, X21
    FMOV  V26.D[1], X22
    FMOV  D27, X18
    FMOV  V27.D[1], X23
    FMOV  D28, X9
    FMOV  V28.D[1], X6
    FMOV  D29, X19
    FMOV  V29.D[1], X13
    FMOV  D30, X21
    FMOV  V30.D[1], X4
    FMOV  D31, X14
    FMOV  V31.D[1], X25
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X4, #0x2300, LSL #0
    ADD  X28, X30, X4
    ST1 { V24.16B, V25.16B, V26.16B, V27.16B }, [X28]
    LD1 { V24.8H, V25.8H, V26.8H, V27.8H }, [X28]
    ADD  X28, X28, X24
    ST1 { V22.16B, V23.16B, V24.16B, V25.16B }, [X28]
    LD1 { V19.16B, V20.16B, V21.16B, V22.16B }, [X28]
    ADD  X28, X28, X24
    ST1 { V27.2D, V28.2D, V29.2D, V30.2D }, [X28]
    LD1 { V6.2D, V7.2D, V8.2D, V9.2D }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V10.4S, V11.4S, V12.4S, V13.4S }, [X28]
    LD1 { V30.4S, V31.4S, V0.4S, V1.4S }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V30.8H, V31.8H, V0.8H, V1.8H }, [X28]
    LD1 { V16.8H, V17.8H, V18.8H, V19.8H }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V26.1D, V27.1D, V28.1D, V29.1D }, [X28]
    LD1 { V29.4H, V30.4H, V31.4H, V0.4H }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V29.1D, V30.1D, V31.1D, V0.1D }, [X28]
    LD1 { V26.1D, V27.1D, V28.1D, V29.1D }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V8.2S, V9.2S, V10.2S, V11.2S }, [X28]
    LD1 { V9.2S, V10.2S, V11.2S, V12.2S }, [X28]
    ADD  X28, X28, X24
    ST1 { V16.4H, V17.4H, V18.4H, V19.4H }, [X28]
    LD1 { V18.4H, V19.4H, V20.4H, V21.4H }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V26.8B, V27.8B, V28.8B, V29.8B }, [X28]
    LD1 { V30.8B, V31.8B, V0.8B, V1.8B }, [X28]
    ADD  X28, X28, X24
    ST1 { V30.4S }, [X28]
    LD1 { V26.16B }, [X28]
    ADD  X28, X28, X24
    ST1 { V1.16B }, [X28]
    LD1 { V13.16B }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V31.2D }, [X28]
    LD1 { V29.2D }, [X28]
    ADD  X28, X28, X24
    ST1 { V26.4S }, [X28]
    LD1 { V2.4S }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V13.8H }, [X28]
    LD1 { V31.8H }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V21.8B }, [X28]
    LD1 { V1.4H }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V2.1D }, [X28]
    LD1 { V13.1D }, [X28]
    ADD  X28, X28, X24
    ST1 { V11.2S }, [X28]
    LD1 { V21.2S }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V1.4H }, [X28]
    LD1 { V1.4H }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V21.8B }, [X28]
    LD1 { V2.8B }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V8.4S, V9.4S, V10.4S }, [X28]
    LD1 { V8.2D, V9.2D, V10.2D }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V9.16B, V10.16B, V11.16B }, [X28]
    LD1 { V0.16B, V1.16B, V2.16B }, [X28]
    ADD  X28, X28, X24
    ST1 { V0.2D, V1.2D, V2.2D }, [X28]
    LD1 { V0.2D, V1.2D, V2.2D }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V0.4S, V1.4S, V2.4S }, [X28]
    LD1 { V0.4S, V1.4S, V2.4S }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V0.8H, V1.8H, V2.8H }, [X28]
    LD1 { V0.8H, V1.8H, V2.8H }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V19.1D, V20.1D, V21.1D }, [X28]
    LD1 { V19.2S, V20.2S, V21.2S }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V0.1D, V1.1D, V2.1D }, [X28]
    LD1 { V9.1D, V10.1D, V11.1D }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V8.2S, V9.2S, V10.2S }, [X28]
    LD1 { V0.2S, V1.2S, V2.2S }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V0.4H, V1.4H, V2.4H }, [X28]
    LD1 { V8.4H, V9.4H, V10.4H }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V8.8B, V9.8B, V10.8B }, [X28]
    LD1 { V0.8B, V1.8B, V2.8B }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V19.4S, V20.4S }, [X28]
    LD1 { V19.2D, V20.2D }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V7.16B, V8.16B }, [X28]
    LD1 { V19.16B, V20.16B }, [X28]
    ADD  X28, X28, X24, LSR #0
    ST1 { V1.2D, V2.2D }, [X28]
    LD1 { V9.2D, V10.2D }, [X28]
    ADD  X28, X28, X24
    ST1 { V21.4S, V22.4S }, [X28]
    LD1 { V21.4S, V22.4S }, [X28]
    ADD  X28, X28, X24, ASR #0
    ST1 { V21.8H, V22.8H }, [X28]
    LD1 { V1.8H, V2.8H }, [X28]
    ADD  X28, X28, X24, ASR #0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D0
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D1
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V2.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D2
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V3.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D3
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V4.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D4
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V5.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D5
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V6.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D6
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V7.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D7
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D8
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D9
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D10
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D11
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D12
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D13
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V14.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D14
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V15.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D15
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V16.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D16
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V17.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D17
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D18
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V19.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D19
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V20.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D20
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D21
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V22.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D22
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V23.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D23
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V24.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D24
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, V25.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D25
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D26
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D27
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D28
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D29
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D30
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X17, D31
    SUB  X7, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X18
    FMOV  D3, X22
    FMOV  V3.D[1], X19
    FMOV  D4, X14
    FMOV  V4.D[1], X20
    FMOV  D5, X13
    FMOV  V5.D[1], X12
    FMOV  D6, X28
    FMOV  V6.D[1], X17
    FMOV  D7, X5
    FMOV  V7.D[1], X16
    FMOV  D8, X26
    FMOV  V8.D[1], X19
    FMOV  D9, X7
    FMOV  V9.D[1], X18
    FMOV  D10, X10
    FMOV  V10.D[1], X16
    FMOV  D11, X24
    FMOV  V11.D[1], X17
    FMOV  D12, X12
    FMOV  V12.D[1], X22
    FMOV  D13, X5
    FMOV  V13.D[1], X5
    FMOV  D14, X19
    FMOV  V14.D[1], X17
    FMOV  D15, X29
    FMOV  V15.D[1], X19
    FMOV  D16, X11
    FMOV  V16.D[1], X25
    FMOV  D17, X9
    FMOV  V17.D[1], X19
    FMOV  D18, X12
    FMOV  V18.D[1], X6
    FMOV  D19, X19
    FMOV  V19.D[1], X19
    FMOV  D20, X26
    FMOV  V20.D[1], X18
    FMOV  D21, X4
    FMOV  V21.D[1], X12
    FMOV  D22, X12
    FMOV  V22.D[1], X18
    FMOV  D23, X24
    FMOV  V23.D[1], X15
    FMOV  D24, X6
    FMOV  V24.D[1], X26
    FMOV  D25, X29
    FMOV  V25.D[1], X18
    FMOV  D26, X28
    FMOV  V26.D[1], X9
    FMOV  D27, X14
    FMOV  V27.D[1], X7
    FMOV  D28, X11
    FMOV  V28.D[1], X19
    FMOV  D29, X25
    FMOV  V29.D[1], X14
    FMOV  D30, X10
    FMOV  V30.D[1], X17
    FMOV  D31, X12
    FMOV  V31.D[1], X6
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X28, #0x2800, LSL #0
    ADD  X4, X30, X28
    ST1 { V24.16B, V25.16B, V26.16B, V27.16B }, [X4]
    LD1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V28.16B, V29.16B, V30.16B, V31.16B }, [X4]
    LD1 { V18.16B, V19.16B, V20.16B, V21.16B }, [X4]
    ADD  X4, X4, X16
    ST1 { V18.2D, V19.2D, V20.2D, V21.2D }, [X4]
    LD1 { V0.2D, V1.2D, V2.2D, V3.2D }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V22.4S, V23.4S, V24.4S, V25.4S }, [X4]
    LD1 { V1.4S, V2.4S, V3.4S, V4.4S }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V5.8H, V6.8H, V7.8H, V8.8H }, [X4]
    LD1 { V18.8H, V19.8H, V20.8H, V21.8H }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V18.8B, V19.8B, V20.8B, V21.8B }, [X4]
    LD1 { V24.8B, V25.8B, V26.8B, V27.8B }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V6.1D, V7.1D, V8.1D, V9.1D }, [X4]
    LD1 { V28.1D, V29.1D, V30.1D, V31.1D }, [X4]
    ADD  X4, X4, X16
    ST1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X4]
    LD1 { V7.2S, V8.2S, V9.2S, V10.2S }, [X4]
    ADD  X4, X4, X16
    ST1 { V1.4H, V2.4H, V3.4H, V4.4H }, [X4]
    LD1 { V21.4H, V22.4H, V23.4H, V24.4H }, [X4]
    ADD  X4, X4, X16
    ST1 { V25.8B, V26.8B, V27.8B, V28.8B }, [X4]
    LD1 { V20.8B, V21.8B, V22.8B, V23.8B }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V31.4S }, [X4]
    LD1 { V28.16B }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V28.16B }, [X4]
    LD1 { V2.16B }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V0.2D }, [X4]
    LD1 { V3.2D }, [X4]
    ADD  X4, X4, X16
    ST1 { V20.4S }, [X4]
    LD1 { V5.4S }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V2.8H }, [X4]
    LD1 { V0.8H }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V24.4H }, [X4]
    LD1 { V20.2S }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V30.1D }, [X4]
    LD1 { V28.1D }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V20.2S }, [X4]
    LD1 { V24.2S }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V3.4H }, [X4]
    LD1 { V2.4H }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V24.8B }, [X4]
    LD1 { V30.8B }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V31.8H, V0.8H, V1.8H }, [X4]
    LD1 { V16.8H, V17.8H, V18.8H }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V16.16B, V17.16B, V18.16B }, [X4]
    LD1 { V16.16B, V17.16B, V18.16B }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V1.2D, V2.2D, V3.2D }, [X4]
    LD1 { V0.2D, V1.2D, V2.2D }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V10.4S, V11.4S, V12.4S }, [X4]
    LD1 { V23.4S, V24.4S, V25.4S }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V16.8H, V17.8H, V18.8H }, [X4]
    LD1 { V10.8H, V11.8H, V12.8H }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V0.1D, V1.1D, V2.1D }, [X4]
    LD1 { V31.2S, V0.2S, V1.2S }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V31.1D, V0.1D, V1.1D }, [X4]
    LD1 { V11.1D, V12.1D, V13.1D }, [X4]
    ADD  X4, X4, X16
    ST1 { V10.2S, V11.2S, V12.2S }, [X4]
    LD1 { V0.2S, V1.2S, V2.2S }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V23.4H, V24.4H, V25.4H }, [X4]
    LD1 { V16.4H, V17.4H, V18.4H }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V16.8B, V17.8B, V18.8B }, [X4]
    LD1 { V23.8B, V24.8B, V25.8B }, [X4]
    ADD  X4, X4, X16
    ST1 { V24.4S, V25.4S }, [X4]
    LD1 { V19.8H, V20.8H }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V19.16B, V20.16B }, [X4]
    LD1 { V17.16B, V18.16B }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST1 { V28.2D, V29.2D }, [X4]
    LD1 { V28.2D, V29.2D }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V28.4S, V29.4S }, [X4]
    LD1 { V28.4S, V29.4S }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST1 { V17.8H, V18.8H }, [X4]
    LD1 { V24.8H, V25.8H }, [X4]
    ADD  X4, X4, X16, LSR #0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X18, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V0.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D1
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D2
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, V3.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D3
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, V4.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D4
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D5
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D6
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D7
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D8
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D9
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D10
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D11
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D12
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D13
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, V14.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D14
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, V15.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D15
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D16
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D17
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D18
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D19
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D20
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V21.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D21
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D22
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D23
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D24
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V25.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D25
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D26
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D27
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D28
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D29
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X18, D31
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP01_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X17
    FMOV  V2.D[1], X23
    FMOV  D3, X12
    FMOV  V3.D[1], X7
    FMOV  D4, X18
    FMOV  V4.D[1], X7
    FMOV  D5, X23
    FMOV  V5.D[1], X24
    FMOV  D6, X25
    FMOV  V6.D[1], X7
    FMOV  D7, X11
    FMOV  V7.D[1], X14
    FMOV  D8, X13
    FMOV  V8.D[1], X12
    FMOV  D9, X24
    FMOV  V9.D[1], X10
    FMOV  D10, X24
    FMOV  V10.D[1], X13
    FMOV  D11, X14
    FMOV  V11.D[1], X22
    FMOV  D12, X29
    FMOV  V12.D[1], X17
    FMOV  D13, X14
    FMOV  V13.D[1], X15
    FMOV  D14, X11
    FMOV  V14.D[1], X13
    FMOV  D15, X18
    FMOV  V15.D[1], X17
    FMOV  D16, X14
    FMOV  V16.D[1], X10
    FMOV  D17, X18
    FMOV  V17.D[1], X23
    FMOV  D18, X21
    FMOV  V18.D[1], X13
    FMOV  D19, X4
    FMOV  V19.D[1], X10
    FMOV  D20, X16
    FMOV  V20.D[1], X15
    FMOV  D21, X14
    FMOV  V21.D[1], X26
    FMOV  D22, X9
    FMOV  V22.D[1], X25
    FMOV  D23, X11
    FMOV  V23.D[1], X5
    FMOV  D24, X29
    FMOV  V24.D[1], X17
    FMOV  D25, X6
    FMOV  V25.D[1], X13
    FMOV  D26, X24
    FMOV  V26.D[1], X29
    FMOV  D27, X19
    FMOV  V27.D[1], X28
    FMOV  D28, X4
    FMOV  V28.D[1], X19
    FMOV  D29, X20
    FMOV  V29.D[1], X17
    FMOV  D30, X26
    FMOV  V30.D[1], X9
    FMOV  D31, X6
    FMOV  V31.D[1], X15
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X9, #0x2d00, LSL #0
    ADD  X28, X30, X9
    ST1 { V25.8H, V26.8H, V27.8H, V28.8H }, [X28]
    LD1 { V19.2D, V20.2D, V21.2D, V22.2D }, [X28]
    ADD  X28, X28, X26, LSR #0
    ST1 { V19.16B, V20.16B, V21.16B, V22.16B }, [X28]
    LD1 { V29.16B, V30.16B, V31.16B, V0.16B }, [X28]
    ADD  X28, X28, X26
    ST1 { V29.2D, V30.2D, V31.2D, V0.2D }, [X28]
    LD1 { V4.2D, V5.2D, V6.2D, V7.2D }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V4.4S, V5.4S, V6.4S, V7.4S }, [X28]
    LD1 { V29.4S, V30.4S, V31.4S, V0.4S }, [X28]
    ADD  X28, X28, X26
    ST1 { V29.8H, V30.8H, V31.8H, V0.8H }, [X28]
    LD1 { V19.8H, V20.8H, V21.8H, V22.8H }, [X28]
    ADD  X28, X28, X26
    ST1 { V7.4H, V8.4H, V9.4H, V10.4H }, [X28]
    LD1 { V25.8B, V26.8B, V27.8B, V28.8B }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V26.1D, V27.1D, V28.1D, V29.1D }, [X28]
    LD1 { V19.1D, V20.1D, V21.1D, V22.1D }, [X28]
    ADD  X28, X28, X26
    ST1 { V4.2S, V5.2S, V6.2S, V7.2S }, [X28]
    LD1 { V4.2S, V5.2S, V6.2S, V7.2S }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V4.4H, V5.4H, V6.4H, V7.4H }, [X28]
    LD1 { V10.4H, V11.4H, V12.4H, V13.4H }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V10.8B, V11.8B, V12.8B, V13.8B }, [X28]
    LD1 { V28.8B, V29.8B, V30.8B, V31.8B }, [X28]
    ADD  X28, X28, X26, LSR #0
    ST1 { V25.4S }, [X28]
    LD1 { V18.2D }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V19.16B }, [X28]
    LD1 { V26.16B }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V31.2D }, [X28]
    LD1 { V31.2D }, [X28]
    ADD  X28, X28, X26
    ST1 { V29.4S }, [X28]
    LD1 { V11.4S }, [X28]
    ADD  X28, X28, X26, LSR #0
    ST1 { V30.8H }, [X28]
    LD1 { V19.8H }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V19.4H }, [X28]
    LD1 { V27.4H }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V11.1D }, [X28]
    LD1 { V25.1D }, [X28]
    ADD  X28, X28, X26
    ST1 { V27.2S }, [X28]
    LD1 { V10.2S }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V25.4H }, [X28]
    LD1 { V11.4H }, [X28]
    ADD  X28, X28, X26
    ST1 { V18.8B }, [X28]
    LD1 { V25.8B }, [X28]
    ADD  X28, X28, X26
    ST1 { V16.8H, V17.8H, V18.8H }, [X28]
    LD1 { V16.2D, V17.2D, V18.2D }, [X28]
    ADD  X28, X28, X26
    ST1 { V16.16B, V17.16B, V18.16B }, [X28]
    LD1 { V19.16B, V20.16B, V21.16B }, [X28]
    ADD  X28, X28, X26, LSR #0
    ST1 { V15.2D, V16.2D, V17.2D }, [X28]
    LD1 { V15.2D, V16.2D, V17.2D }, [X28]
    ADD  X28, X28, X26
    ST1 { V15.4S, V16.4S, V17.4S }, [X28]
    LD1 { V28.4S, V29.4S, V30.4S }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V28.8H, V29.8H, V30.8H }, [X28]
    LD1 { V26.8H, V27.8H, V28.8H }, [X28]
    ADD  X28, X28, X26, LSR #0
    ST1 { V26.1D, V27.1D, V28.1D }, [X28]
    LD1 { V18.8B, V19.8B, V20.8B }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V19.1D, V20.1D, V21.1D }, [X28]
    LD1 { V1.1D, V2.1D, V3.1D }, [X28]
    ADD  X28, X28, X26, LSR #0
    ST1 { V30.2S, V31.2S, V0.2S }, [X28]
    LD1 { V28.2S, V29.2S, V30.2S }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V15.4H, V16.4H, V17.4H }, [X28]
    LD1 { V19.4H, V20.4H, V21.4H }, [X28]
    ADD  X28, X28, X26, LSR #0
    ST1 { V18.8B, V19.8B, V20.8B }, [X28]
    LD1 { V16.8B, V17.8B, V18.8B }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V17.4S, V18.4S }, [X28]
    LD1 { V26.4S, V27.4S }, [X28]
    ADD  X28, X28, X26
    ST1 { V26.16B, V27.16B }, [X28]
    LD1 { V31.16B, V0.16B }, [X28]
    ADD  X28, X28, X26, LSR #0
    ST1 { V2.2D, V3.2D }, [X28]
    LD1 { V17.2D, V18.2D }, [X28]
    ADD  X28, X28, X26
    ST1 { V31.4S, V0.4S }, [X28]
    LD1 { V31.4S, V0.4S }, [X28]
    ADD  X28, X28, X26, ASR #0
    ST1 { V7.8H, V8.8H }, [X28]
    LD1 { V29.8H, V30.8H }, [X28]
    ADD  X28, X28, X26, ASR #0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X24, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D0
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D1
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D2
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D3
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D4
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D5
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D6
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D7
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, V8.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D8
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, V9.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D9
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D10
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D11
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D12
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D13
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, V14.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D14
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, V15.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D15
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D16
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D17
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D18
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D19
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D20
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D21
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D22
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, V23.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D23
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, V24.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D24
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V25.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D25
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V26.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D26
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D27
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D28
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D29
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, V30.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D30
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X24, D31
    SUB  X15, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP01_TestFail

AdvsimdLoadStoreP01_TestEnd:
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
AdvsimdLoadStoreP01_TestFail:
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
