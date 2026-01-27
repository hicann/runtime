.global AdvsimdLoadStoreP03

.text
.p2align 4

AdvsimdLoadStoreP03:

AdvsimdLoadStoreP03_TestBegin:
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
    MOVZ  X2, #0xc274, LSL #0
    MOVK  X2, #0x5559, LSL #16
    MOVK  X2, #0x3450, LSL #32
    MOVK  X2, #0x5510, LSL #48
    MOVZ  X3, #0x3bff, LSL #0
    MOVK  X3, #0x449e, LSL #16
    MOVK  X3, #0xd029, LSL #32
    MOVK  X3, #0x6399, LSL #48
    MOVZ  X4, #0x2a9d, LSL #0
    MOVK  X4, #0x47a5, LSL #16
    MOVK  X4, #0x5049, LSL #32
    MOVK  X4, #0x6f18, LSL #48
    MOVZ  X5, #0xb633, LSL #0
    MOVK  X5, #0x56f8, LSL #16
    MOVK  X5, #0x9c5d, LSL #32
    MOVK  X5, #0xe111, LSL #48
    MOVZ  X6, #0xa0c3, LSL #0
    MOVK  X6, #0x738d, LSL #16
    MOVK  X6, #0xa47c, LSL #32
    MOVK  X6, #0x2412, LSL #48
    MOVZ  X7, #0x5817, LSL #0
    MOVK  X7, #0xd1a3, LSL #16
    MOVK  X7, #0xaa1b, LSL #32
    MOVK  X7, #0x5131, LSL #48
    MOVZ  X8, #0xe276, LSL #0
    MOVK  X8, #0xacb7, LSL #16
    MOVK  X8, #0xdab9, LSL #32
    MOVK  X8, #0xe1ab, LSL #48
    MOVZ  X9, #0x948f, LSL #0
    MOVK  X9, #0xb97a, LSL #16
    MOVK  X9, #0x41a1, LSL #32
    MOVK  X9, #0x2dfd, LSL #48
    MOVZ  X10, #0xaed, LSL #0
    MOVK  X10, #0xfc46, LSL #16
    MOVK  X10, #0x6fa6, LSL #32
    MOVK  X10, #0x5de1, LSL #48
    MOVZ  X11, #0xe15f, LSL #0
    MOVK  X11, #0xa75, LSL #16
    MOVK  X11, #0xa31, LSL #32
    MOVK  X11, #0x47cc, LSL #48
    MOVZ  X12, #0x7f1, LSL #0
    MOVK  X12, #0x1bbe, LSL #16
    MOVK  X12, #0x9bd, LSL #32
    MOVK  X12, #0xf92d, LSL #48
    MOVZ  X13, #0xba0b, LSL #0
    MOVK  X13, #0xb3aa, LSL #16
    MOVK  X13, #0xbfca, LSL #32
    MOVK  X13, #0xf2fa, LSL #48
    MOVZ  X14, #0x6d29, LSL #0
    MOVK  X14, #0x97fe, LSL #16
    MOVK  X14, #0x8c8f, LSL #32
    MOVK  X14, #0x843, LSL #48
    MOVZ  X15, #0x42c0, LSL #0
    MOVK  X15, #0xf43a, LSL #16
    MOVK  X15, #0xef6e, LSL #32
    MOVK  X15, #0x1a40, LSL #48
    MOVZ  X16, #0x4b64, LSL #0
    MOVK  X16, #0xd94b, LSL #16
    MOVK  X16, #0x69de, LSL #32
    MOVK  X16, #0xead, LSL #48
    MOVZ  X17, #0x23e, LSL #0
    MOVK  X17, #0x7f76, LSL #16
    MOVK  X17, #0xbd9a, LSL #32
    MOVK  X17, #0x3cbe, LSL #48
    MOVZ  X19, #0x4f71, LSL #0
    MOVK  X19, #0x705, LSL #16
    MOVK  X19, #0x2098, LSL #32
    MOVK  X19, #0xa426, LSL #48
    MOVZ  X20, #0xafed, LSL #0
    MOVK  X20, #0x40b3, LSL #16
    MOVK  X20, #0xdbc, LSL #32
    MOVK  X20, #0xc12f, LSL #48
    MOVZ  X22, #0xcb74, LSL #0
    MOVK  X22, #0x564e, LSL #16
    MOVK  X22, #0x3fd1, LSL #32
    MOVK  X22, #0xf878, LSL #48
    MOVZ  X23, #0xf4e5, LSL #0
    MOVK  X23, #0xba20, LSL #16
    MOVK  X23, #0x8583, LSL #32
    MOVK  X23, #0x86c9, LSL #48
    MOVZ  X24, #0xcb06, LSL #0
    MOVK  X24, #0x8ad7, LSL #16
    MOVK  X24, #0xd15c, LSL #32
    MOVK  X24, #0x1b68, LSL #48
    MOVZ  X26, #0xec57, LSL #0
    MOVK  X26, #0xfa18, LSL #16
    MOVK  X26, #0xb659, LSL #32
    MOVK  X26, #0xe04a, LSL #48
    MOVZ  X27, #0x3e8a, LSL #0
    MOVK  X27, #0x784, LSL #16
    MOVK  X27, #0xde3e, LSL #32
    MOVK  X27, #0xe361, LSL #48
    MOVZ  X28, #0xb4e6, LSL #0
    MOVK  X28, #0x5bc3, LSL #16
    MOVK  X28, #0xa080, LSL #32
    MOVK  X28, #0x3a2c, LSL #48
    MOVZ  X11, #0xa47a, LSL #0
    MOVK  X11, #0xf941, LSL #16
    MOVK  X11, #0x8b6b, LSL #32
    MOVK  X11, #0xfde6, LSL #48
    MSR  FPCR, X11
    MOVZ  X11, #0xd15b, LSL #0
    MOVK  X11, #0xd63d, LSL #16
    MOVK  X11, #0x670d, LSL #32
    MOVK  X11, #0x9381, LSL #48
    MSR  FPSR, X11
    MRS  X9, FPSR
    MOVZ  X3, #0xff60, LSL #0
    MOVK  X3, #0x7ff, LSL #16
    MOVK  X3, #0xffff, LSL #32
    MOVK  X3, #0xffff, LSL #48
    AND  X9, X9, X3
    MOVZ  X3, #0x0, LSL #0
    ORR  X9, X9, X3
    MSR  FPSR, X9
    ISB  SY
    ANDS  W22, W13, #0x1fc00000
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
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X22
    FMOV  D3, X9
    FMOV  V3.D[1], X9
    FMOV  D4, X27
    FMOV  V4.D[1], X20
    FMOV  D5, X13
    FMOV  V5.D[1], X19
    FMOV  D6, X28
    FMOV  V6.D[1], X7
    FMOV  D7, X16
    FMOV  V7.D[1], X24
    FMOV  D8, X24
    FMOV  V8.D[1], X8
    FMOV  D9, X19
    FMOV  V9.D[1], X14
    FMOV  D10, X9
    FMOV  V10.D[1], X22
    FMOV  D11, X4
    FMOV  V11.D[1], X20
    FMOV  D12, X6
    FMOV  V12.D[1], X22
    FMOV  D13, X10
    FMOV  V13.D[1], X9
    FMOV  D14, X7
    FMOV  V14.D[1], X26
    FMOV  D15, X14
    FMOV  V15.D[1], X20
    FMOV  D16, X24
    FMOV  V16.D[1], X24
    FMOV  D17, X15
    FMOV  V17.D[1], X6
    FMOV  D18, X16
    FMOV  V18.D[1], X22
    FMOV  D19, X17
    FMOV  V19.D[1], X19
    FMOV  D20, X6
    FMOV  V20.D[1], X14
    FMOV  D21, X26
    FMOV  V21.D[1], X22
    FMOV  D22, X6
    FMOV  V22.D[1], X11
    FMOV  D23, X8
    FMOV  V23.D[1], X7
    FMOV  D24, X3
    FMOV  V24.D[1], X26
    FMOV  D25, X17
    FMOV  V25.D[1], X2
    FMOV  D26, X16
    FMOV  V26.D[1], X17
    FMOV  D27, X8
    FMOV  V27.D[1], X15
    FMOV  D28, X11
    FMOV  V28.D[1], X28
    FMOV  D29, X6
    FMOV  V29.D[1], X11
    FMOV  D30, X14
    FMOV  V30.D[1], X23
    FMOV  D31, X23
    FMOV  V31.D[1], X22
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X5, #0x0, LSL #0
    ADD  X2, X30, X5, ASR #0
    ST1 { V31.8H }, [X2], X7
    LD1 { V8.16B }, [X2], X7
    ADD  X2, X2, X14
    ST1 { V29.16B }, [X2], X7
    LD1 { V17.16B }, [X2], X7
    ADD  X2, X2, X14
    ST1 { V24.2D }, [X2], X7
    LD1 { V16.2D }, [X2], X7
    ADD  X2, X2, X14, ASR #0
    ST1 { V28.4S }, [X2], X7
    LD1 { V0.4S }, [X2], X7
    ADD  X2, X2, X14, ASR #0
    ST1 { V0.8H }, [X2], X7
    LD1 { V18.8H }, [X2], X7
    ADD  X2, X2, X14
    ST1 { V16.1D }, [X2], X7
    LD1 { V0.2S }, [X2], X7
    ADD  X2, X2, X14, ASR #0
    ST1 { V0.1D }, [X2], X7
    LD1 { V19.1D }, [X2], X7
    ADD  X2, X2, X14, LSR #0
    ST1 { V19.2S }, [X2], X7
    LD1 { V15.2S }, [X2], X7
    ADD  X2, X2, X14
    ST1 { V18.4H }, [X2], X7
    LD1 { V3.4H }, [X2], X7
    ADD  X2, X2, X14, ASR #0
    ST1 { V15.8B }, [X2], X7
    LD1 { V16.8B }, [X2], X7
    ADD  X2, X2, X14, LSR #0
    MOV  X13, X2
    ST1 { V18.2D, V19.2D, V20.2D }, [X13], #48
    MOV  X13, X2
    LD1 { V13.4S, V14.4S, V15.4S }, [X13], #48
    ADD  X2, X2, X14, ASR #0
    MOV  X13, X2
    ST1 { V23.16B, V24.16B, V25.16B }, [X13], #48
    MOV  X13, X2
    LD1 { V15.16B, V16.16B, V17.16B }, [X13], #48
    ADD  X2, X2, X14
    MOV  X13, X2
    ST1 { V13.2D, V14.2D, V15.2D }, [X13], #48
    MOV  X13, X2
    LD1 { V24.2D, V25.2D, V26.2D }, [X13], #48
    ADD  X2, X2, X14, LSR #0
    MOV  X13, X2
    ST1 { V24.4S, V25.4S, V26.4S }, [X13], #48
    MOV  X13, X2
    LD1 { V9.4S, V10.4S, V11.4S }, [X13], #48
    ADD  X2, X2, X14
    MOV  X13, X2
    ST1 { V8.8H, V9.8H, V10.8H }, [X13], #48
    MOV  X13, X2
    LD1 { V23.8H, V24.8H, V25.8H }, [X13], #48
    ADD  X2, X2, X14
    MOV  X13, X2
    ST1 { V30.2S, V31.2S, V0.2S }, [X13], #24
    MOV  X13, X2
    LD1 { V8.8B, V9.8B, V10.8B }, [X13], #24
    ADD  X2, X2, X14
    MOV  X13, X2
    ST1 { V23.1D, V24.1D, V25.1D }, [X13], #24
    MOV  X13, X2
    LD1 { V14.1D, V15.1D, V16.1D }, [X13], #24
    ADD  X2, X2, X14, ASR #0
    MOV  X13, X2
    ST1 { V14.2S, V15.2S, V16.2S }, [X13], #24
    MOV  X13, X2
    LD1 { V15.2S, V16.2S, V17.2S }, [X13], #24
    ADD  X2, X2, X14, ASR #0
    MOV  X13, X2
    ST1 { V15.4H, V16.4H, V17.4H }, [X13], #24
    MOV  X13, X2
    LD1 { V21.4H, V22.4H, V23.4H }, [X13], #24
    ADD  X2, X2, X14, LSR #0
    MOV  X13, X2
    ST1 { V21.8B, V22.8B, V23.8B }, [X13], #24
    MOV  X13, X2
    LD1 { V4.8B, V5.8B, V6.8B }, [X13], #24
    ADD  X2, X2, X14
    ST1 { V4.8H, V5.8H, V6.8H }, [X2], X7
    LD1 { V22.4S, V23.4S, V24.4S }, [X2], X7
    ADD  X2, X2, X14, ASR #0
    ST1 { V22.16B, V23.16B, V24.16B }, [X2], X7
    LD1 { V23.16B, V24.16B, V25.16B }, [X2], X7
    ADD  X2, X2, X14, LSR #0
    ST1 { V23.2D, V24.2D, V25.2D }, [X2], X7
    LD1 { V4.2D, V5.2D, V6.2D }, [X2], X7
    ADD  X2, X2, X14, LSR #0
    ST1 { V4.4S, V5.4S, V6.4S }, [X2], X7
    LD1 { V22.4S, V23.4S, V24.4S }, [X2], X7
    ADD  X2, X2, X14
    ST1 { V22.8H, V23.8H, V24.8H }, [X2], X7
    LD1 { V21.8H, V22.8H, V23.8H }, [X2], X7
    ADD  X2, X2, X14, LSR #0
    ST1 { V6.2S, V7.2S, V8.2S }, [X2], X7
    LD1 { V21.8B, V22.8B, V23.8B }, [X2], X7
    ADD  X2, X2, X14, LSR #0
    ST1 { V30.1D, V31.1D, V0.1D }, [X2], X7
    LD1 { V15.1D, V16.1D, V17.1D }, [X2], X7
    ADD  X2, X2, X14, ASR #0
    ST1 { V28.2S, V29.2S, V30.2S }, [X2], X7
    LD1 { V30.2S, V31.2S, V0.2S }, [X2], X7
    ADD  X2, X2, X14
    ST1 { V21.4H, V22.4H, V23.4H }, [X2], X7
    LD1 { V10.4H, V11.4H, V12.4H }, [X2], X7
    ADD  X2, X2, X14
    ST1 { V15.8B, V16.8B, V17.8B }, [X2], X7
    LD1 { V6.8B, V7.8B, V8.8B }, [X2], X7
    ADD  X2, X2, X14, LSR #0
    MOV  X13, X2
    ST1 { V17.8H, V18.8H }, [X13], #32
    MOV  X13, X2
    LD1 { V17.4S, V18.4S }, [X13], #32
    ADD  X2, X2, X14
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X12, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V0.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D0
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D1
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, V2.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D2
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V3.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D3
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V4.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D4
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V5.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D5
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V6.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D6
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V7.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D7
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D8
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D9
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D10
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D11
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D12
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D13
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V14.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D14
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V15.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D15
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V16.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D16
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V17.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D17
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, V18.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D18
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D19
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, V20.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D20
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V21.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D21
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V22.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D22
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D23
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V24.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D24
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V25.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D25
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, V26.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D26
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D27
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, V28.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D28
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, V29.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D29
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V30.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D30
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X12, V31.D[1]
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X12, D31
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X22
    FMOV  D2, X27
    FMOV  V2.D[1], X16
    FMOV  D3, X12
    FMOV  V3.D[1], X22
    FMOV  D4, X12
    FMOV  V4.D[1], X20
    FMOV  D5, X13
    FMOV  V5.D[1], X13
    FMOV  D6, X2
    FMOV  V6.D[1], X27
    FMOV  D7, X22
    FMOV  V7.D[1], X7
    FMOV  D8, X9
    FMOV  V8.D[1], X20
    FMOV  D9, X8
    FMOV  V9.D[1], X6
    FMOV  D10, X26
    FMOV  V10.D[1], X26
    FMOV  D11, X10
    FMOV  V11.D[1], X3
    FMOV  D12, X8
    FMOV  V12.D[1], X6
    FMOV  D13, X16
    FMOV  V13.D[1], X10
    FMOV  D14, X9
    FMOV  V14.D[1], X17
    FMOV  D15, X2
    FMOV  V15.D[1], X17
    FMOV  D16, X28
    FMOV  V16.D[1], X8
    FMOV  D17, X28
    FMOV  V17.D[1], X27
    FMOV  D18, X3
    FMOV  V18.D[1], X17
    FMOV  D19, X13
    FMOV  V19.D[1], X26
    FMOV  D20, X9
    FMOV  V20.D[1], X23
    FMOV  D21, X15
    FMOV  V21.D[1], X24
    FMOV  D22, X23
    FMOV  V22.D[1], X10
    FMOV  D23, X13
    FMOV  V23.D[1], X13
    FMOV  D24, X11
    FMOV  V24.D[1], X5
    FMOV  D25, X12
    FMOV  V25.D[1], X5
    FMOV  D26, X28
    FMOV  V26.D[1], X26
    FMOV  D27, X3
    FMOV  V27.D[1], X3
    FMOV  D28, X7
    FMOV  V28.D[1], X26
    FMOV  D29, X8
    FMOV  V29.D[1], X20
    FMOV  D30, X14
    FMOV  V30.D[1], X16
    FMOV  D31, X22
    FMOV  V31.D[1], X8
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X27, #0x500, LSL #0
    ADD  X8, X30, X27
    ST1 { V27.2D }, [X8], X5
    LD1 { V12.16B }, [X8], X5
    ADD  X8, X8, X10, LSR #0
    ST1 { V12.16B }, [X8], X5
    LD1 { V21.16B }, [X8], X5
    ADD  X8, X8, X10, ASR #0
    ST1 { V29.2D }, [X8], X5
    LD1 { V24.2D }, [X8], X5
    ADD  X8, X8, X10
    ST1 { V28.4S }, [X8], X5
    LD1 { V16.4S }, [X8], X5
    ADD  X8, X8, X10, LSR #0
    ST1 { V30.8H }, [X8], X5
    LD1 { V3.8H }, [X8], X5
    ADD  X8, X8, X10, LSR #0
    ST1 { V16.8B }, [X8], X5
    LD1 { V20.1D }, [X8], X5
    ADD  X8, X8, X10, ASR #0
    ST1 { V20.1D }, [X8], X5
    LD1 { V17.1D }, [X8], X5
    ADD  X8, X8, X10
    ST1 { V17.2S }, [X8], X5
    LD1 { V13.2S }, [X8], X5
    ADD  X8, X8, X10, LSR #0
    ST1 { V31.4H }, [X8], X5
    LD1 { V12.4H }, [X8], X5
    ADD  X8, X8, X10, LSR #0
    ST1 { V21.8B }, [X8], X5
    LD1 { V21.8B }, [X8], X5
    ADD  X8, X8, X10, ASR #0
    MOV  X7, X8
    ST1 { V23.4S, V24.4S, V25.4S }, [X7], #48
    MOV  X7, X8
    LD1 { V23.8H, V24.8H, V25.8H }, [X7], #48
    ADD  X8, X8, X10
    MOV  X7, X8
    ST1 { V23.16B, V24.16B, V25.16B }, [X7], #48
    MOV  X7, X8
    LD1 { V17.16B, V18.16B, V19.16B }, [X7], #48
    ADD  X8, X8, X10, ASR #0
    MOV  X7, X8
    ST1 { V17.2D, V18.2D, V19.2D }, [X7], #48
    MOV  X7, X8
    LD1 { V9.2D, V10.2D, V11.2D }, [X7], #48
    ADD  X8, X8, X10
    MOV  X7, X8
    ST1 { V9.4S, V10.4S, V11.4S }, [X7], #48
    MOV  X7, X8
    LD1 { V3.4S, V4.4S, V5.4S }, [X7], #48
    ADD  X8, X8, X10, LSR #0
    MOV  X7, X8
    ST1 { V3.8H, V4.8H, V5.8H }, [X7], #48
    MOV  X7, X8
    LD1 { V19.8H, V20.8H, V21.8H }, [X7], #48
    ADD  X8, X8, X10, LSR #0
    MOV  X7, X8
    ST1 { V19.4H, V20.4H, V21.4H }, [X7], #24
    MOV  X7, X8
    LD1 { V25.2S, V26.2S, V27.2S }, [X7], #24
    ADD  X8, X8, X10, LSR #0
    MOV  X7, X8
    ST1 { V18.1D, V19.1D, V20.1D }, [X7], #24
    MOV  X7, X8
    LD1 { V30.1D, V31.1D, V0.1D }, [X7], #24
    ADD  X8, X8, X10
    MOV  X7, X8
    ST1 { V18.2S, V19.2S, V20.2S }, [X7], #24
    MOV  X7, X8
    LD1 { V24.2S, V25.2S, V26.2S }, [X7], #24
    ADD  X8, X8, X10, LSR #0
    MOV  X7, X8
    ST1 { V17.4H, V18.4H, V19.4H }, [X7], #24
    MOV  X7, X8
    LD1 { V19.4H, V20.4H, V21.4H }, [X7], #24
    ADD  X8, X8, X10, ASR #0
    MOV  X7, X8
    ST1 { V24.8B, V25.8B, V26.8B }, [X7], #24
    MOV  X7, X8
    LD1 { V23.8B, V24.8B, V25.8B }, [X7], #24
    ADD  X8, X8, X10, LSR #0
    ST1 { V19.2D, V20.2D, V21.2D }, [X8], X5
    LD1 { V18.4S, V19.4S, V20.4S }, [X8], X5
    ADD  X8, X8, X10
    ST1 { V30.16B, V31.16B, V0.16B }, [X8], X5
    LD1 { V27.16B, V28.16B, V29.16B }, [X8], X5
    ADD  X8, X8, X10, LSR #0
    ST1 { V27.2D, V28.2D, V29.2D }, [X8], X5
    LD1 { V1.2D, V2.2D, V3.2D }, [X8], X5
    ADD  X8, X8, X10, ASR #0
    ST1 { V18.4S, V19.4S, V20.4S }, [X8], X5
    LD1 { V19.4S, V20.4S, V21.4S }, [X8], X5
    ADD  X8, X8, X10
    ST1 { V23.8H, V24.8H, V25.8H }, [X8], X5
    LD1 { V5.8H, V6.8H, V7.8H }, [X8], X5
    ADD  X8, X8, X10
    ST1 { V19.8B, V20.8B, V21.8B }, [X8], X5
    LD1 { V6.4H, V7.4H, V8.4H }, [X8], X5
    ADD  X8, X8, X10, LSR #0
    ST1 { V6.1D, V7.1D, V8.1D }, [X8], X5
    LD1 { V18.1D, V19.1D, V20.1D }, [X8], X5
    ADD  X8, X8, X10, LSR #0
    ST1 { V9.2S, V10.2S, V11.2S }, [X8], X5
    LD1 { V6.2S, V7.2S, V8.2S }, [X8], X5
    ADD  X8, X8, X10, LSR #0
    ST1 { V18.4H, V19.4H, V20.4H }, [X8], X5
    LD1 { V27.4H, V28.4H, V29.4H }, [X8], X5
    ADD  X8, X8, X10, ASR #0
    ST1 { V6.8B, V7.8B, V8.8B }, [X8], X5
    LD1 { V23.8B, V24.8B, V25.8B }, [X8], X5
    ADD  X8, X8, X10
    MOV  X7, X8
    ST1 { V27.16B, V28.16B }, [X7], #32
    MOV  X7, X8
    LD1 { V7.16B, V8.16B }, [X7], #32
    ADD  X8, X8, X10
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X19
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X22
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X9, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, V4.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V8.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, V10.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, V11.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, V14.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, V15.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V24.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X28, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X23
    FMOV  D1, X24
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X13
    FMOV  D3, X17
    FMOV  V3.D[1], X13
    FMOV  D4, X28
    FMOV  V4.D[1], X7
    FMOV  D5, X22
    FMOV  V5.D[1], X5
    FMOV  D6, X7
    FMOV  V6.D[1], X20
    FMOV  D7, X11
    FMOV  V7.D[1], X11
    FMOV  D8, X27
    FMOV  V8.D[1], X16
    FMOV  D9, X9
    FMOV  V9.D[1], X5
    FMOV  D10, X23
    FMOV  V10.D[1], X6
    FMOV  D11, X3
    FMOV  V11.D[1], X19
    FMOV  D12, X5
    FMOV  V12.D[1], X23
    FMOV  D13, X28
    FMOV  V13.D[1], X11
    FMOV  D14, X15
    FMOV  V14.D[1], X11
    FMOV  D15, X26
    FMOV  V15.D[1], X11
    FMOV  D16, X7
    FMOV  V16.D[1], X14
    FMOV  D17, X24
    FMOV  V17.D[1], X5
    FMOV  D18, X9
    FMOV  V18.D[1], X10
    FMOV  D19, X3
    FMOV  V19.D[1], X16
    FMOV  D20, X7
    FMOV  V20.D[1], X11
    FMOV  D21, X20
    FMOV  V21.D[1], X5
    FMOV  D22, X13
    FMOV  V22.D[1], X2
    FMOV  D23, X22
    FMOV  V23.D[1], X13
    FMOV  D24, X10
    FMOV  V24.D[1], X2
    FMOV  D25, X26
    FMOV  V25.D[1], X4
    FMOV  D26, X27
    FMOV  V26.D[1], X19
    FMOV  D27, X11
    FMOV  V27.D[1], X7
    FMOV  D28, X10
    FMOV  V28.D[1], X23
    FMOV  D29, X11
    FMOV  V29.D[1], X15
    FMOV  D30, X4
    FMOV  V30.D[1], X19
    FMOV  D31, X12
    FMOV  V31.D[1], X19
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X16, #0xa00, LSL #0
    ADD  X15, X30, X16, ASR #0
    ST1 { V26.2D }, [X15], X8
    LD1 { V27.16B }, [X15], X8
    ADD  X15, X15, X14
    ST1 { V27.16B }, [X15], X8
    LD1 { V3.16B }, [X15], X8
    ADD  X15, X15, X14, ASR #0
    ST1 { V3.2D }, [X15], X8
    LD1 { V8.2D }, [X15], X8
    ADD  X15, X15, X14, ASR #0
    ST1 { V8.4S }, [X15], X8
    LD1 { V13.4S }, [X15], X8
    ADD  X15, X15, X14, ASR #0
    ST1 { V13.8H }, [X15], X8
    LD1 { V16.8H }, [X15], X8
    ADD  X15, X15, X14, ASR #0
    ST1 { V16.8B }, [X15], X8
    LD1 { V25.4H }, [X15], X8
    ADD  X15, X15, X14, LSR #0
    ST1 { V29.1D }, [X15], X8
    LD1 { V11.1D }, [X15], X8
    ADD  X15, X15, X14, ASR #0
    ST1 { V11.2S }, [X15], X8
    LD1 { V12.2S }, [X15], X8
    ADD  X15, X15, X14
    ST1 { V12.4H }, [X15], X8
    LD1 { V23.4H }, [X15], X8
    ADD  X15, X15, X14, LSR #0
    ST1 { V25.8B }, [X15], X8
    LD1 { V31.8B }, [X15], X8
    ADD  X15, X15, X14
    MOV  X4, X15
    ST1 { V13.4S, V14.4S, V15.4S }, [X4], #48
    MOV  X4, X15
    LD1 { V29.8H, V30.8H, V31.8H }, [X4], #48
    ADD  X15, X15, X14
    MOV  X4, X15
    ST1 { V14.16B, V15.16B, V16.16B }, [X4], #48
    MOV  X4, X15
    LD1 { V29.16B, V30.16B, V31.16B }, [X4], #48
    ADD  X15, X15, X14, ASR #0
    MOV  X4, X15
    ST1 { V11.2D, V12.2D, V13.2D }, [X4], #48
    MOV  X4, X15
    LD1 { V0.2D, V1.2D, V2.2D }, [X4], #48
    ADD  X15, X15, X14
    MOV  X4, X15
    ST1 { V13.4S, V14.4S, V15.4S }, [X4], #48
    MOV  X4, X15
    LD1 { V5.4S, V6.4S, V7.4S }, [X4], #48
    ADD  X15, X15, X14, LSR #0
    MOV  X4, X15
    ST1 { V29.8H, V30.8H, V31.8H }, [X4], #48
    MOV  X4, X15
    LD1 { V22.8H, V23.8H, V24.8H }, [X4], #48
    ADD  X15, X15, X14, LSR #0
    MOV  X4, X15
    ST1 { V0.2S, V1.2S, V2.2S }, [X4], #24
    MOV  X4, X15
    LD1 { V17.1D, V18.1D, V19.1D }, [X4], #24
    ADD  X15, X15, X14
    MOV  X4, X15
    ST1 { V5.1D, V6.1D, V7.1D }, [X4], #24
    MOV  X4, X15
    LD1 { V6.1D, V7.1D, V8.1D }, [X4], #24
    ADD  X15, X15, X14, LSR #0
    MOV  X4, X15
    ST1 { V6.2S, V7.2S, V8.2S }, [X4], #24
    MOV  X4, X15
    LD1 { V0.2S, V1.2S, V2.2S }, [X4], #24
    ADD  X15, X15, X14, ASR #0
    MOV  X4, X15
    ST1 { V22.4H, V23.4H, V24.4H }, [X4], #24
    MOV  X4, X15
    LD1 { V22.4H, V23.4H, V24.4H }, [X4], #24
    ADD  X15, X15, X14
    MOV  X4, X15
    ST1 { V0.8B, V1.8B, V2.8B }, [X4], #24
    MOV  X4, X15
    LD1 { V0.8B, V1.8B, V2.8B }, [X4], #24
    ADD  X15, X15, X14, LSR #0
    ST1 { V17.2D, V18.2D, V19.2D }, [X15], X8
    LD1 { V6.4S, V7.4S, V8.4S }, [X15], X8
    ADD  X15, X15, X14, ASR #0
    ST1 { V0.16B, V1.16B, V2.16B }, [X15], X8
    LD1 { V21.16B, V22.16B, V23.16B }, [X15], X8
    ADD  X15, X15, X14, ASR #0
    ST1 { V22.2D, V23.2D, V24.2D }, [X15], X8
    LD1 { V22.2D, V23.2D, V24.2D }, [X15], X8
    ADD  X15, X15, X14, LSR #0
    ST1 { V6.4S, V7.4S, V8.4S }, [X15], X8
    LD1 { V0.4S, V1.4S, V2.4S }, [X15], X8
    ADD  X15, X15, X14
    ST1 { V22.8H, V23.8H, V24.8H }, [X15], X8
    LD1 { V17.8H, V18.8H, V19.8H }, [X15], X8
    ADD  X15, X15, X14, LSR #0
    ST1 { V17.1D, V18.1D, V19.1D }, [X15], X8
    LD1 { V6.4H, V7.4H, V8.4H }, [X15], X8
    ADD  X15, X15, X14, ASR #0
    ST1 { V0.1D, V1.1D, V2.1D }, [X15], X8
    LD1 { V17.1D, V18.1D, V19.1D }, [X15], X8
    ADD  X15, X15, X14
    ST1 { V17.2S, V18.2S, V19.2S }, [X15], X8
    LD1 { V6.2S, V7.2S, V8.2S }, [X15], X8
    ADD  X15, X15, X14, LSR #0
    ST1 { V26.4H, V27.4H, V28.4H }, [X15], X8
    LD1 { V26.4H, V27.4H, V28.4H }, [X15], X8
    ADD  X15, X15, X14
    ST1 { V26.8B, V27.8B, V28.8B }, [X15], X8
    LD1 { V18.8B, V19.8B, V20.8B }, [X15], X8
    ADD  X15, X15, X14, ASR #0
    MOV  X4, X15
    ST1 { V7.8H, V8.8H }, [X4], #32
    MOV  X4, X15
    LD1 { V17.4S, V18.4S }, [X4], #32
    ADD  X15, X15, X14, ASR #0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X10, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V0.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D0
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D1
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D2
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V3.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D3
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V4.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D4
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V5.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D5
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D6
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D7
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V8.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D8
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V9.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D9
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V10.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D10
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D11
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D12
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V13.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D13
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V14.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D14
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V15.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D15
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V16.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D16
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V17.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D17
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V18.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D18
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V19.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D19
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D20
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D21
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D22
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D23
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D24
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D25
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D26
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D27
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X10, V28.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D28
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V29.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D29
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V30.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D30
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, V31.D[1]
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X10, D31
    SUB  X3, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X22
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X24
    FMOV  V2.D[1], X3
    FMOV  D3, X14
    FMOV  V3.D[1], X4
    FMOV  D4, X19
    FMOV  V4.D[1], X11
    FMOV  D5, X8
    FMOV  V5.D[1], X6
    FMOV  D6, X14
    FMOV  V6.D[1], X14
    FMOV  D7, X27
    FMOV  V7.D[1], X28
    FMOV  D8, X17
    FMOV  V8.D[1], X16
    FMOV  D9, X4
    FMOV  V9.D[1], X19
    FMOV  D10, X2
    FMOV  V10.D[1], X16
    FMOV  D11, X24
    FMOV  V11.D[1], X9
    FMOV  D12, X8
    FMOV  V12.D[1], X9
    FMOV  D13, X7
    FMOV  V13.D[1], X28
    FMOV  D14, X2
    FMOV  V14.D[1], X20
    FMOV  D15, X16
    FMOV  V15.D[1], X5
    FMOV  D16, X2
    FMOV  V16.D[1], X14
    FMOV  D17, X14
    FMOV  V17.D[1], X2
    FMOV  D18, X11
    FMOV  V18.D[1], X7
    FMOV  D19, X3
    FMOV  V19.D[1], X10
    FMOV  D20, X8
    FMOV  V20.D[1], X6
    FMOV  D21, X16
    FMOV  V21.D[1], X13
    FMOV  D22, X10
    FMOV  V22.D[1], X27
    FMOV  D23, X4
    FMOV  V23.D[1], X23
    FMOV  D24, X4
    FMOV  V24.D[1], X11
    FMOV  D25, X28
    FMOV  V25.D[1], X26
    FMOV  D26, X6
    FMOV  V26.D[1], X3
    FMOV  D27, X3
    FMOV  V27.D[1], X9
    FMOV  D28, X8
    FMOV  V28.D[1], X2
    FMOV  D29, X2
    FMOV  V29.D[1], X2
    FMOV  D30, X6
    FMOV  V30.D[1], X16
    FMOV  D31, X4
    FMOV  V31.D[1], X11
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X8, #0xf00, LSL #0
    ADD  X26, X30, X8, LSR #0
    ST1 { V25.2D }, [X26], X12
    LD1 { V20.16B }, [X26], X12
    ADD  X26, X26, X5, LSR #0
    ST1 { V28.16B }, [X26], X12
    LD1 { V7.16B }, [X26], X12
    ADD  X26, X26, X5, LSR #0
    ST1 { V27.2D }, [X26], X12
    LD1 { V1.2D }, [X26], X12
    ADD  X26, X26, X5, ASR #0
    ST1 { V31.4S }, [X26], X12
    LD1 { V28.4S }, [X26], X12
    ADD  X26, X26, X5, ASR #0
    ST1 { V28.8H }, [X26], X12
    LD1 { V9.8H }, [X26], X12
    ADD  X26, X26, X5, ASR #0
    ST1 { V1.1D }, [X26], X12
    LD1 { V29.1D }, [X26], X12
    ADD  X26, X26, X5
    ST1 { V7.1D }, [X26], X12
    LD1 { V24.1D }, [X26], X12
    ADD  X26, X26, X5, ASR #0
    ST1 { V20.2S }, [X26], X12
    LD1 { V19.2S }, [X26], X12
    ADD  X26, X26, X5, LSR #0
    ST1 { V19.4H }, [X26], X12
    LD1 { V28.4H }, [X26], X12
    ADD  X26, X26, X5, LSR #0
    ST1 { V28.8B }, [X26], X12
    LD1 { V20.8B }, [X26], X12
    ADD  X26, X26, X5, LSR #0
    MOV  X23, X26
    ST1 { V3.2D, V4.2D, V5.2D }, [X23], #48
    MOV  X23, X26
    LD1 { V24.16B, V25.16B, V26.16B }, [X23], #48
    ADD  X26, X26, X5, ASR #0
    MOV  X23, X26
    ST1 { V13.16B, V14.16B, V15.16B }, [X23], #48
    MOV  X23, X26
    LD1 { V27.16B, V28.16B, V29.16B }, [X23], #48
    ADD  X26, X26, X5, LSR #0
    MOV  X23, X26
    ST1 { V27.2D, V28.2D, V29.2D }, [X23], #48
    MOV  X23, X26
    LD1 { V23.2D, V24.2D, V25.2D }, [X23], #48
    ADD  X26, X26, X5
    MOV  X23, X26
    ST1 { V23.4S, V24.4S, V25.4S }, [X23], #48
    MOV  X23, X26
    LD1 { V23.4S, V24.4S, V25.4S }, [X23], #48
    ADD  X26, X26, X5, ASR #0
    MOV  X23, X26
    ST1 { V24.8H, V25.8H, V26.8H }, [X23], #48
    MOV  X23, X26
    LD1 { V13.8H, V14.8H, V15.8H }, [X23], #48
    ADD  X26, X26, X5
    MOV  X23, X26
    ST1 { V31.8B, V0.8B, V1.8B }, [X23], #24
    MOV  X23, X26
    LD1 { V27.1D, V28.1D, V29.1D }, [X23], #24
    ADD  X26, X26, X5, ASR #0
    MOV  X23, X26
    ST1 { V27.1D, V28.1D, V29.1D }, [X23], #24
    MOV  X23, X26
    LD1 { V27.1D, V28.1D, V29.1D }, [X23], #24
    ADD  X26, X26, X5, ASR #0
    MOV  X23, X26
    ST1 { V27.2S, V28.2S, V29.2S }, [X23], #24
    MOV  X23, X26
    LD1 { V27.2S, V28.2S, V29.2S }, [X23], #24
    ADD  X26, X26, X5
    MOV  X23, X26
    ST1 { V13.4H, V14.4H, V15.4H }, [X23], #24
    MOV  X23, X26
    LD1 { V13.4H, V14.4H, V15.4H }, [X23], #24
    ADD  X26, X26, X5, LSR #0
    MOV  X23, X26
    ST1 { V27.8B, V28.8B, V29.8B }, [X23], #24
    MOV  X23, X26
    LD1 { V27.8B, V28.8B, V29.8B }, [X23], #24
    ADD  X26, X26, X5
    ST1 { V13.4S, V14.4S, V15.4S }, [X26], X12
    LD1 { V13.4S, V14.4S, V15.4S }, [X26], X12
    ADD  X26, X26, X5, ASR #0
    ST1 { V13.16B, V14.16B, V15.16B }, [X26], X12
    LD1 { V13.16B, V14.16B, V15.16B }, [X26], X12
    ADD  X26, X26, X5
    ST1 { V27.2D, V28.2D, V29.2D }, [X26], X12
    LD1 { V27.2D, V28.2D, V29.2D }, [X26], X12
    ADD  X26, X26, X5
    ST1 { V13.4S, V14.4S, V15.4S }, [X26], X12
    LD1 { V1.4S, V2.4S, V3.4S }, [X26], X12
    ADD  X26, X26, X5, ASR #0
    ST1 { V1.8H, V2.8H, V3.8H }, [X26], X12
    LD1 { V10.8H, V11.8H, V12.8H }, [X26], X12
    ADD  X26, X26, X5, LSR #0
    ST1 { V10.1D, V11.1D, V12.1D }, [X26], X12
    LD1 { V28.8B, V29.8B, V30.8B }, [X26], X12
    ADD  X26, X26, X5, ASR #0
    ST1 { V5.1D, V6.1D, V7.1D }, [X26], X12
    LD1 { V6.1D, V7.1D, V8.1D }, [X26], X12
    ADD  X26, X26, X5
    ST1 { V6.2S, V7.2S, V8.2S }, [X26], X12
    LD1 { V6.2S, V7.2S, V8.2S }, [X26], X12
    ADD  X26, X26, X5, ASR #0
    ST1 { V27.4H, V28.4H, V29.4H }, [X26], X12
    LD1 { V5.4H, V6.4H, V7.4H }, [X26], X12
    ADD  X26, X26, X5
    ST1 { V6.8B, V7.8B, V8.8B }, [X26], X12
    LD1 { V1.8B, V2.8B, V3.8B }, [X26], X12
    ADD  X26, X26, X5, LSR #0
    MOV  X23, X26
    ST1 { V2.2D, V3.2D }, [X23], #32
    MOV  X23, X26
    LD1 { V10.16B, V11.16B }, [X23], #32
    ADD  X26, X26, X5, LSR #0
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X19, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V0.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D0
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V1.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D1
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V2.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D2
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V3.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D3
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D4
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V5.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D5
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V6.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D6
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D7
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D8
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V9.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D9
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D10
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D11
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D12
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V13.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D13
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V14.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D14
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D15
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V16.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D16
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V17.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D17
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V18.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D18
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V19.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D19
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D20
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V21.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D21
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D22
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V23.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D23
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V24.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D24
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V25.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D25
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V26.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D26
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V27.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D27
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V28.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D28
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V29.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D29
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D30
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, V31.D[1]
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    FMOV  X19, D31
    SUB  X7, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X24
    FMOV  D1, X23
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X6
    FMOV  D3, X3
    FMOV  V3.D[1], X22
    FMOV  D4, X6
    FMOV  V4.D[1], X16
    FMOV  D5, X11
    FMOV  V5.D[1], X6
    FMOV  D6, X4
    FMOV  V6.D[1], X15
    FMOV  D7, X15
    FMOV  V7.D[1], X16
    FMOV  D8, X3
    FMOV  V8.D[1], X28
    FMOV  D9, X28
    FMOV  V9.D[1], X10
    FMOV  D10, X8
    FMOV  V10.D[1], X28
    FMOV  D11, X5
    FMOV  V11.D[1], X12
    FMOV  D12, X17
    FMOV  V12.D[1], X28
    FMOV  D13, X15
    FMOV  V13.D[1], X7
    FMOV  D14, X4
    FMOV  V14.D[1], X3
    FMOV  D15, X14
    FMOV  V15.D[1], X17
    FMOV  D16, X24
    FMOV  V16.D[1], X3
    FMOV  D17, X5
    FMOV  V17.D[1], X20
    FMOV  D18, X28
    FMOV  V18.D[1], X20
    FMOV  D19, X16
    FMOV  V19.D[1], X22
    FMOV  D20, X8
    FMOV  V20.D[1], X10
    FMOV  D21, X14
    FMOV  V21.D[1], X10
    FMOV  D22, X5
    FMOV  V22.D[1], X4
    FMOV  D23, X16
    FMOV  V23.D[1], X11
    FMOV  D24, X13
    FMOV  V24.D[1], X10
    FMOV  D25, X10
    FMOV  V25.D[1], X15
    FMOV  D26, X24
    FMOV  V26.D[1], X3
    FMOV  D27, X24
    FMOV  V27.D[1], X19
    FMOV  D28, X16
    FMOV  V28.D[1], X24
    FMOV  D29, X16
    FMOV  V29.D[1], X20
    FMOV  D30, X22
    FMOV  V30.D[1], X13
    FMOV  D31, X4
    FMOV  V31.D[1], X11
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X8, #0x1400, LSL #0
    ADD  X13, X30, X8, ASR #0
    ST1 { V30.2D }, [X13], X5
    LD1 { V10.4S }, [X13], X5
    ADD  X13, X13, X16
    ST1 { V29.16B }, [X13], X5
    LD1 { V3.16B }, [X13], X5
    ADD  X13, X13, X16, ASR #0
    ST1 { V10.2D }, [X13], X5
    LD1 { V12.2D }, [X13], X5
    ADD  X13, X13, X16, LSR #0
    ST1 { V3.4S }, [X13], X5
    LD1 { V7.4S }, [X13], X5
    ADD  X13, X13, X16, LSR #0
    ST1 { V31.8H }, [X13], X5
    LD1 { V25.8H }, [X13], X5
    ADD  X13, X13, X16, ASR #0
    ST1 { V12.8B }, [X13], X5
    LD1 { V11.8B }, [X13], X5
    ADD  X13, X13, X16
    ST1 { V7.1D }, [X13], X5
    LD1 { V24.1D }, [X13], X5
    ADD  X13, X13, X16, ASR #0
    ST1 { V11.2S }, [X13], X5
    LD1 { V21.2S }, [X13], X5
    ADD  X13, X13, X16, ASR #0
    ST1 { V25.4H }, [X13], X5
    LD1 { V1.4H }, [X13], X5
    ADD  X13, X13, X16
    ST1 { V1.8B }, [X13], X5
    LD1 { V8.8B }, [X13], X5
    ADD  X13, X13, X16, ASR #0
    MOV  X15, X13
    ST1 { V22.2D, V23.2D, V24.2D }, [X15], #48
    MOV  X15, X13
    LD1 { V17.2D, V18.2D, V19.2D }, [X15], #48
    ADD  X13, X13, X16
    MOV  X15, X13
    ST1 { V17.16B, V18.16B, V19.16B }, [X15], #48
    MOV  X15, X13
    LD1 { V17.16B, V18.16B, V19.16B }, [X15], #48
    ADD  X13, X13, X16, LSR #0
    MOV  X15, X13
    ST1 { V25.2D, V26.2D, V27.2D }, [X15], #48
    MOV  X15, X13
    LD1 { V7.2D, V8.2D, V9.2D }, [X15], #48
    ADD  X13, X13, X16, ASR #0
    MOV  X15, X13
    ST1 { V17.4S, V18.4S, V19.4S }, [X15], #48
    MOV  X15, X13
    LD1 { V1.4S, V2.4S, V3.4S }, [X15], #48
    ADD  X13, X13, X16, ASR #0
    MOV  X15, X13
    ST1 { V1.8H, V2.8H, V3.8H }, [X15], #48
    MOV  X15, X13
    LD1 { V31.8H, V0.8H, V1.8H }, [X15], #48
    ADD  X13, X13, X16, LSR #0
    MOV  X15, X13
    ST1 { V31.1D, V0.1D, V1.1D }, [X15], #24
    MOV  X15, X13
    LD1 { V4.4H, V5.4H, V6.4H }, [X15], #24
    ADD  X13, X13, X16
    MOV  X15, X13
    ST1 { V4.1D, V5.1D, V6.1D }, [X15], #24
    MOV  X15, X13
    LD1 { V1.1D, V2.1D, V3.1D }, [X15], #24
    ADD  X13, X13, X16
    MOV  X15, X13
    ST1 { V1.2S, V2.2S, V3.2S }, [X15], #24
    MOV  X15, X13
    LD1 { V4.2S, V5.2S, V6.2S }, [X15], #24
    ADD  X13, X13, X16
    MOV  X15, X13
    ST1 { V4.4H, V5.4H, V6.4H }, [X15], #24
    MOV  X15, X13
    LD1 { V4.4H, V5.4H, V6.4H }, [X15], #24
    ADD  X13, X13, X16, ASR #0
    MOV  X15, X13
    ST1 { V4.8B, V5.8B, V6.8B }, [X15], #24
    MOV  X15, X13
    LD1 { V3.8B, V4.8B, V5.8B }, [X15], #24
    ADD  X13, X13, X16, LSR #0
    ST1 { V9.16B, V10.16B, V11.16B }, [X13], X5
    LD1 { V9.8H, V10.8H, V11.8H }, [X13], X5
    ADD  X13, X13, X16, ASR #0
    ST1 { V31.16B, V0.16B, V1.16B }, [X13], X5
    LD1 { V0.16B, V1.16B, V2.16B }, [X13], X5
    ADD  X13, X13, X16
    ST1 { V2.2D, V3.2D, V4.2D }, [X13], X5
    LD1 { V31.2D, V0.2D, V1.2D }, [X13], X5
    ADD  X13, X13, X16, LSR #0
    ST1 { V9.4S, V10.4S, V11.4S }, [X13], X5
    LD1 { V20.4S, V21.4S, V22.4S }, [X13], X5
    ADD  X13, X13, X16, ASR #0
    ST1 { V7.8H, V8.8H, V9.8H }, [X13], X5
    LD1 { V10.8H, V11.8H, V12.8H }, [X13], X5
    ADD  X13, X13, X16, LSR #0
    ST1 { V10.4H, V11.4H, V12.4H }, [X13], X5
    LD1 { V31.4H, V0.4H, V1.4H }, [X13], X5
    ADD  X13, X13, X16, LSR #0
    ST1 { V29.1D, V30.1D, V31.1D }, [X13], X5
    LD1 { V29.1D, V30.1D, V31.1D }, [X13], X5
    ADD  X13, X13, X16
    ST1 { V16.2S, V17.2S, V18.2S }, [X13], X5
    LD1 { V15.2S, V16.2S, V17.2S }, [X13], X5
    ADD  X13, X13, X16
    ST1 { V29.4H, V30.4H, V31.4H }, [X13], X5
    LD1 { V19.4H, V20.4H, V21.4H }, [X13], X5
    ADD  X13, X13, X16, LSR #0
    ST1 { V19.8B, V20.8B, V21.8B }, [X13], X5
    LD1 { V10.8B, V11.8B, V12.8B }, [X13], X5
    ADD  X13, X13, X16
    MOV  X15, X13
    ST1 { V11.4S, V12.4S }, [X15], #32
    MOV  X15, X13
    LD1 { V19.8H, V20.8H }, [X15], #32
    ADD  X13, X13, X16
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X24, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D0
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D1
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D2
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D3
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D4
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D5
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D6
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V7.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D7
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V8.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D8
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V9.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D9
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D10
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D11
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D12
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V13.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D13
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V14.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D14
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D15
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D16
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D17
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V18.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D18
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D19
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D20
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D21
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D22
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V23.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D23
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V24.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D24
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V25.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D25
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V26.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D26
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V27.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D27
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, V28.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D28
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D29
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D30
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X24, D31
    SUB  X26, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X23
    FMOV  D1, X20
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X24
    FMOV  D3, X17
    FMOV  V3.D[1], X28
    FMOV  D4, X11
    FMOV  V4.D[1], X7
    FMOV  D5, X7
    FMOV  V5.D[1], X6
    FMOV  D6, X2
    FMOV  V6.D[1], X2
    FMOV  D7, X13
    FMOV  V7.D[1], X17
    FMOV  D8, X14
    FMOV  V8.D[1], X10
    FMOV  D9, X15
    FMOV  V9.D[1], X2
    FMOV  D10, X7
    FMOV  V10.D[1], X17
    FMOV  D11, X14
    FMOV  V11.D[1], X16
    FMOV  D12, X5
    FMOV  V12.D[1], X16
    FMOV  D13, X14
    FMOV  V13.D[1], X4
    FMOV  D14, X3
    FMOV  V14.D[1], X13
    FMOV  D15, X14
    FMOV  V15.D[1], X28
    FMOV  D16, X24
    FMOV  V16.D[1], X2
    FMOV  D17, X2
    FMOV  V17.D[1], X6
    FMOV  D18, X23
    FMOV  V18.D[1], X13
    FMOV  D19, X2
    FMOV  V19.D[1], X11
    FMOV  D20, X16
    FMOV  V20.D[1], X12
    FMOV  D21, X11
    FMOV  V21.D[1], X5
    FMOV  D22, X28
    FMOV  V22.D[1], X24
    FMOV  D23, X13
    FMOV  V23.D[1], X26
    FMOV  D24, X20
    FMOV  V24.D[1], X23
    FMOV  D25, X16
    FMOV  V25.D[1], X27
    FMOV  D26, X10
    FMOV  V26.D[1], X16
    FMOV  D27, X20
    FMOV  V27.D[1], X8
    FMOV  D28, X5
    FMOV  V28.D[1], X13
    FMOV  D29, X4
    FMOV  V29.D[1], X9
    FMOV  D30, X13
    FMOV  V30.D[1], X27
    FMOV  D31, X6
    FMOV  V31.D[1], X4
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X28, #0x1900, LSL #0
    ADD  X6, X30, X28, ASR #0
    ST1 { V28.16B }, [X6], X26
    LD1 { V1.4S }, [X6], X26
    ADD  X6, X6, X3
    ST1 { V25.16B }, [X6], X26
    LD1 { V24.16B }, [X6], X26
    ADD  X6, X6, X3, LSR #0
    ST1 { V24.2D }, [X6], X26
    LD1 { V19.2D }, [X6], X26
    ADD  X6, X6, X3, ASR #0
    ST1 { V30.4S }, [X6], X26
    LD1 { V24.4S }, [X6], X26
    ADD  X6, X6, X3
    ST1 { V31.8H }, [X6], X26
    LD1 { V24.8H }, [X6], X26
    ADD  X6, X6, X3
    ST1 { V1.2S }, [X6], X26
    LD1 { V9.8B }, [X6], X26
    ADD  X6, X6, X3, ASR #0
    ST1 { V9.1D }, [X6], X26
    LD1 { V5.1D }, [X6], X26
    ADD  X6, X6, X3, ASR #0
    ST1 { V24.2S }, [X6], X26
    LD1 { V22.2S }, [X6], X26
    ADD  X6, X6, X3, ASR #0
    ST1 { V22.4H }, [X6], X26
    LD1 { V27.4H }, [X6], X26
    ADD  X6, X6, X3, LSR #0
    ST1 { V26.8B }, [X6], X26
    LD1 { V3.8B }, [X6], X26
    ADD  X6, X6, X3
    MOV  X16, X6
    ST1 { V19.4S, V20.4S, V21.4S }, [X16], #48
    MOV  X16, X6
    LD1 { V6.16B, V7.16B, V8.16B }, [X16], #48
    ADD  X6, X6, X3
    MOV  X16, X6
    ST1 { V6.16B, V7.16B, V8.16B }, [X16], #48
    MOV  X16, X6
    LD1 { V3.16B, V4.16B, V5.16B }, [X16], #48
    ADD  X6, X6, X3, LSR #0
    MOV  X16, X6
    ST1 { V30.2D, V31.2D, V0.2D }, [X16], #48
    MOV  X16, X6
    LD1 { V14.2D, V15.2D, V16.2D }, [X16], #48
    ADD  X6, X6, X3, ASR #0
    MOV  X16, X6
    ST1 { V3.4S, V4.4S, V5.4S }, [X16], #48
    MOV  X16, X6
    LD1 { V29.4S, V30.4S, V31.4S }, [X16], #48
    ADD  X6, X6, X3, ASR #0
    MOV  X16, X6
    ST1 { V29.8H, V30.8H, V31.8H }, [X16], #48
    MOV  X16, X6
    LD1 { V3.8H, V4.8H, V5.8H }, [X16], #48
    ADD  X6, X6, X3, ASR #0
    MOV  X16, X6
    ST1 { V3.4H, V4.4H, V5.4H }, [X16], #24
    MOV  X16, X6
    LD1 { V3.4H, V4.4H, V5.4H }, [X16], #24
    ADD  X6, X6, X3
    MOV  X16, X6
    ST1 { V14.1D, V15.1D, V16.1D }, [X16], #24
    MOV  X16, X6
    LD1 { V14.1D, V15.1D, V16.1D }, [X16], #24
    ADD  X6, X6, X3, ASR #0
    MOV  X16, X6
    ST1 { V3.2S, V4.2S, V5.2S }, [X16], #24
    MOV  X16, X6
    LD1 { V29.2S, V30.2S, V31.2S }, [X16], #24
    ADD  X6, X6, X3, LSR #0
    MOV  X16, X6
    ST1 { V14.4H, V15.4H, V16.4H }, [X16], #24
    MOV  X16, X6
    LD1 { V14.4H, V15.4H, V16.4H }, [X16], #24
    ADD  X6, X6, X3
    MOV  X16, X6
    ST1 { V14.8B, V15.8B, V16.8B }, [X16], #24
    MOV  X16, X6
    LD1 { V5.8B, V6.8B, V7.8B }, [X16], #24
    ADD  X6, X6, X3, ASR #0
    ST1 { V5.8H, V6.8H, V7.8H }, [X6], X26
    LD1 { V5.16B, V6.16B, V7.16B }, [X6], X26
    ADD  X6, X6, X3, ASR #0
    ST1 { V29.16B, V30.16B, V31.16B }, [X6], X26
    LD1 { V29.16B, V30.16B, V31.16B }, [X6], X26
    ADD  X6, X6, X3, LSR #0
    ST1 { V1.2D, V2.2D, V3.2D }, [X6], X26
    LD1 { V14.2D, V15.2D, V16.2D }, [X6], X26
    ADD  X6, X6, X3
    ST1 { V26.4S, V27.4S, V28.4S }, [X6], X26
    LD1 { V1.4S, V2.4S, V3.4S }, [X6], X26
    ADD  X6, X6, X3, LSR #0
    ST1 { V29.8H, V30.8H, V31.8H }, [X6], X26
    LD1 { V27.8H, V28.8H, V29.8H }, [X6], X26
    ADD  X6, X6, X3
    ST1 { V1.1D, V2.1D, V3.1D }, [X6], X26
    LD1 { V1.4H, V2.4H, V3.4H }, [X6], X26
    ADD  X6, X6, X3, LSR #0
    ST1 { V6.1D, V7.1D, V8.1D }, [X6], X26
    LD1 { V30.1D, V31.1D, V0.1D }, [X6], X26
    ADD  X6, X6, X3, LSR #0
    ST1 { V27.2S, V28.2S, V29.2S }, [X6], X26
    LD1 { V6.2S, V7.2S, V8.2S }, [X6], X26
    ADD  X6, X6, X3, LSR #0
    ST1 { V1.4H, V2.4H, V3.4H }, [X6], X26
    LD1 { V26.4H, V27.4H, V28.4H }, [X6], X26
    ADD  X6, X6, X3, ASR #0
    ST1 { V30.8B, V31.8B, V0.8B }, [X6], X26
    LD1 { V1.8B, V2.8B, V3.8B }, [X6], X26
    ADD  X6, X6, X3, LSR #0
    MOV  X16, X6
    ST1 { V2.16B, V3.16B }, [X16], #32
    MOV  X16, X6
    LD1 { V30.2D, V31.2D }, [X16], #32
    ADD  X6, X6, X3, LSR #0
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X13, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D0
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D1
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D2
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D3
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D4
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D5
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D6
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D7
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D8
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D9
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V10.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D10
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V11.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D11
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V12.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D12
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V13.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D13
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V14.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D14
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V15.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D15
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D16
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V17.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D17
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V18.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D18
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V19.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D19
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V20.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D20
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V21.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D21
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D22
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V23.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D23
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V24.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D24
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, V25.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D25
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D26
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D27
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D28
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D29
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D30
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X13, D31
    SUB  X7, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X23
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X24
    FMOV  V2.D[1], X6
    FMOV  D3, X14
    FMOV  V3.D[1], X20
    FMOV  D4, X13
    FMOV  V4.D[1], X17
    FMOV  D5, X6
    FMOV  V5.D[1], X17
    FMOV  D6, X5
    FMOV  V6.D[1], X5
    FMOV  D7, X8
    FMOV  V7.D[1], X19
    FMOV  D8, X14
    FMOV  V8.D[1], X13
    FMOV  D9, X7
    FMOV  V9.D[1], X13
    FMOV  D10, X15
    FMOV  V10.D[1], X27
    FMOV  D11, X2
    FMOV  V11.D[1], X28
    FMOV  D12, X9
    FMOV  V12.D[1], X5
    FMOV  D13, X15
    FMOV  V13.D[1], X16
    FMOV  D14, X16
    FMOV  V14.D[1], X28
    FMOV  D15, X15
    FMOV  V15.D[1], X12
    FMOV  D16, X6
    FMOV  V16.D[1], X22
    FMOV  D17, X11
    FMOV  V17.D[1], X26
    FMOV  D18, X22
    FMOV  V18.D[1], X8
    FMOV  D19, X5
    FMOV  V19.D[1], X17
    FMOV  D20, X14
    FMOV  V20.D[1], X24
    FMOV  D21, X20
    FMOV  V21.D[1], X11
    FMOV  D22, X17
    FMOV  V22.D[1], X26
    FMOV  D23, X7
    FMOV  V23.D[1], X26
    FMOV  D24, X13
    FMOV  V24.D[1], X19
    FMOV  D25, X26
    FMOV  V25.D[1], X23
    FMOV  D26, X19
    FMOV  V26.D[1], X12
    FMOV  D27, X13
    FMOV  V27.D[1], X28
    FMOV  D28, X28
    FMOV  V28.D[1], X11
    FMOV  D29, X6
    FMOV  V29.D[1], X10
    FMOV  D30, X19
    FMOV  V30.D[1], X8
    FMOV  D31, X6
    FMOV  V31.D[1], X26
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X19, #0x1e00, LSL #0
    ADD  X16, X30, X19, LSR #0
    ST1 { V25.16B }, [X16], X2
    LD1 { V6.8H }, [X16], X2
    ADD  X16, X16, X8, LSR #0
    ST1 { V30.16B }, [X16], X2
    LD1 { V31.16B }, [X16], X2
    ADD  X16, X16, X8
    ST1 { V6.2D }, [X16], X2
    LD1 { V29.2D }, [X16], X2
    ADD  X16, X16, X8, ASR #0
    ST1 { V28.4S }, [X16], X2
    LD1 { V13.4S }, [X16], X2
    ADD  X16, X16, X8, ASR #0
    ST1 { V13.8H }, [X16], X2
    LD1 { V27.8H }, [X16], X2
    ADD  X16, X16, X8
    ST1 { V27.4H }, [X16], X2
    LD1 { V0.8B }, [X16], X2
    ADD  X16, X16, X8, ASR #0
    ST1 { V29.1D }, [X16], X2
    LD1 { V13.1D }, [X16], X2
    ADD  X16, X16, X8
    ST1 { V31.2S }, [X16], X2
    LD1 { V30.2S }, [X16], X2
    ADD  X16, X16, X8, ASR #0
    ST1 { V30.4H }, [X16], X2
    LD1 { V22.4H }, [X16], X2
    ADD  X16, X16, X8, LSR #0
    ST1 { V22.8B }, [X16], X2
    LD1 { V15.8B }, [X16], X2
    ADD  X16, X16, X8, ASR #0
    MOV  X22, X16
    ST1 { V21.4S, V22.4S, V23.4S }, [X22], #48
    MOV  X22, X16
    LD1 { V7.2D, V8.2D, V9.2D }, [X22], #48
    ADD  X16, X16, X8, ASR #0
    MOV  X22, X16
    ST1 { V7.16B, V8.16B, V9.16B }, [X22], #48
    MOV  X22, X16
    LD1 { V20.16B, V21.16B, V22.16B }, [X22], #48
    ADD  X16, X16, X8, LSR #0
    MOV  X22, X16
    ST1 { V18.2D, V19.2D, V20.2D }, [X22], #48
    MOV  X22, X16
    LD1 { V2.2D, V3.2D, V4.2D }, [X22], #48
    ADD  X16, X16, X8
    MOV  X22, X16
    ST1 { V16.4S, V17.4S, V18.4S }, [X22], #48
    MOV  X22, X16
    LD1 { V24.4S, V25.4S, V26.4S }, [X22], #48
    ADD  X16, X16, X8
    MOV  X22, X16
    ST1 { V23.8H, V24.8H, V25.8H }, [X22], #48
    MOV  X22, X16
    LD1 { V17.8H, V18.8H, V19.8H }, [X22], #48
    ADD  X16, X16, X8, ASR #0
    MOV  X22, X16
    ST1 { V10.8B, V11.8B, V12.8B }, [X22], #24
    MOV  X22, X16
    LD1 { V29.4H, V30.4H, V31.4H }, [X22], #24
    ADD  X16, X16, X8
    MOV  X22, X16
    ST1 { V2.1D, V3.1D, V4.1D }, [X22], #24
    MOV  X22, X16
    LD1 { V11.1D, V12.1D, V13.1D }, [X22], #24
    ADD  X16, X16, X8, LSR #0
    MOV  X22, X16
    ST1 { V28.2S, V29.2S, V30.2S }, [X22], #24
    MOV  X22, X16
    LD1 { V23.2S, V24.2S, V25.2S }, [X22], #24
    ADD  X16, X16, X8, LSR #0
    MOV  X22, X16
    ST1 { V23.4H, V24.4H, V25.4H }, [X22], #24
    MOV  X22, X16
    LD1 { V23.4H, V24.4H, V25.4H }, [X22], #24
    ADD  X16, X16, X8, LSR #0
    MOV  X22, X16
    ST1 { V26.8B, V27.8B, V28.8B }, [X22], #24
    MOV  X22, X16
    LD1 { V26.8B, V27.8B, V28.8B }, [X22], #24
    ADD  X16, X16, X8
    ST1 { V26.4S, V27.4S, V28.4S }, [X16], X2
    LD1 { V26.8H, V27.8H, V28.8H }, [X16], X2
    ADD  X16, X16, X8
    ST1 { V11.16B, V12.16B, V13.16B }, [X16], X2
    LD1 { V11.16B, V12.16B, V13.16B }, [X16], X2
    ADD  X16, X16, X8
    ST1 { V23.2D, V24.2D, V25.2D }, [X16], X2
    LD1 { V23.2D, V24.2D, V25.2D }, [X16], X2
    ADD  X16, X16, X8
    ST1 { V26.4S, V27.4S, V28.4S }, [X16], X2
    LD1 { V26.4S, V27.4S, V28.4S }, [X16], X2
    ADD  X16, X16, X8
    ST1 { V23.8H, V24.8H, V25.8H }, [X16], X2
    LD1 { V23.8H, V24.8H, V25.8H }, [X16], X2
    ADD  X16, X16, X8, LSR #0
    ST1 { V23.2S, V24.2S, V25.2S }, [X16], X2
    LD1 { V1.1D, V2.1D, V3.1D }, [X16], X2
    ADD  X16, X16, X8
    ST1 { V11.1D, V12.1D, V13.1D }, [X16], X2
    LD1 { V16.1D, V17.1D, V18.1D }, [X16], X2
    ADD  X16, X16, X8, LSR #0
    ST1 { V16.2S, V17.2S, V18.2S }, [X16], X2
    LD1 { V3.2S, V4.2S, V5.2S }, [X16], X2
    ADD  X16, X16, X8, ASR #0
    ST1 { V3.4H, V4.4H, V5.4H }, [X16], X2
    LD1 { V7.4H, V8.4H, V9.4H }, [X16], X2
    ADD  X16, X16, X8, ASR #0
    ST1 { V7.8B, V8.8B, V9.8B }, [X16], X2
    LD1 { V3.8B, V4.8B, V5.8B }, [X16], X2
    ADD  X16, X16, X8
    MOV  X22, X16
    ST1 { V1.16B, V2.16B }, [X22], #32
    MOV  X22, X16
    LD1 { V1.16B, V2.16B }, [X22], #32
    ADD  X16, X16, X8, LSR #0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X17, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V0.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D0
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V1.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D1
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V2.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D2
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V3.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D3
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V4.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D4
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V5.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D5
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, V6.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D6
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D7
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D8
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D9
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, V10.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D10
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D11
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D12
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D13
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, V14.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D14
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V15.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D15
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D16
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V17.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D17
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V18.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D18
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, V19.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D19
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, V20.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D20
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V21.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D21
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, V22.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D22
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V23.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D23
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V24.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D24
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V25.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D25
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D26
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D27
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V28.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D28
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V29.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D29
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D30
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X17, D31
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X23
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X22
    FMOV  D3, X4
    FMOV  V3.D[1], X11
    FMOV  D4, X15
    FMOV  V4.D[1], X7
    FMOV  D5, X7
    FMOV  V5.D[1], X8
    FMOV  D6, X15
    FMOV  V6.D[1], X15
    FMOV  D7, X19
    FMOV  V7.D[1], X5
    FMOV  D8, X11
    FMOV  V8.D[1], X14
    FMOV  D9, X5
    FMOV  V9.D[1], X2
    FMOV  D10, X10
    FMOV  V10.D[1], X9
    FMOV  D11, X5
    FMOV  V11.D[1], X13
    FMOV  D12, X3
    FMOV  V12.D[1], X22
    FMOV  D13, X11
    FMOV  V13.D[1], X22
    FMOV  D14, X15
    FMOV  V14.D[1], X5
    FMOV  D15, X17
    FMOV  V15.D[1], X5
    FMOV  D16, X10
    FMOV  V16.D[1], X22
    FMOV  D17, X8
    FMOV  V17.D[1], X7
    FMOV  D18, X24
    FMOV  V18.D[1], X26
    FMOV  D19, X10
    FMOV  V19.D[1], X9
    FMOV  D20, X2
    FMOV  V20.D[1], X6
    FMOV  D21, X7
    FMOV  V21.D[1], X6
    FMOV  D22, X23
    FMOV  V22.D[1], X20
    FMOV  D23, X7
    FMOV  V23.D[1], X28
    FMOV  D24, X23
    FMOV  V24.D[1], X5
    FMOV  D25, X15
    FMOV  V25.D[1], X11
    FMOV  D26, X4
    FMOV  V26.D[1], X24
    FMOV  D27, X23
    FMOV  V27.D[1], X27
    FMOV  D28, X20
    FMOV  V28.D[1], X14
    FMOV  D29, X11
    FMOV  V29.D[1], X11
    FMOV  D30, X10
    FMOV  V30.D[1], X27
    FMOV  D31, X12
    FMOV  V31.D[1], X10
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X10, #0x2300, LSL #0
    ADD  X16, X30, X10, LSR #0
    ST1 { V26.8H }, [X16], X17
    LD1 { V28.2D }, [X16], X17
    ADD  X16, X16, X8, LSR #0
    ST1 { V24.16B }, [X16], X17
    LD1 { V20.16B }, [X16], X17
    ADD  X16, X16, X8, LSR #0
    ST1 { V27.2D }, [X16], X17
    LD1 { V18.2D }, [X16], X17
    ADD  X16, X16, X8
    ST1 { V30.4S }, [X16], X17
    LD1 { V25.4S }, [X16], X17
    ADD  X16, X16, X8
    ST1 { V28.8H }, [X16], X17
    LD1 { V25.8H }, [X16], X17
    ADD  X16, X16, X8
    ST1 { V18.8B }, [X16], X17
    LD1 { V27.8B }, [X16], X17
    ADD  X16, X16, X8, LSR #0
    ST1 { V20.1D }, [X16], X17
    LD1 { V9.1D }, [X16], X17
    ADD  X16, X16, X8
    ST1 { V9.2S }, [X16], X17
    LD1 { V25.2S }, [X16], X17
    ADD  X16, X16, X8, LSR #0
    ST1 { V25.4H }, [X16], X17
    LD1 { V22.4H }, [X16], X17
    ADD  X16, X16, X8, LSR #0
    ST1 { V27.8B }, [X16], X17
    LD1 { V14.8B }, [X16], X17
    ADD  X16, X16, X8
    MOV  X7, X16
    ST1 { V6.8H, V7.8H, V8.8H }, [X7], #48
    MOV  X7, X16
    LD1 { V22.2D, V23.2D, V24.2D }, [X7], #48
    ADD  X16, X16, X8, ASR #0
    MOV  X7, X16
    ST1 { V25.16B, V26.16B, V27.16B }, [X7], #48
    MOV  X7, X16
    LD1 { V25.16B, V26.16B, V27.16B }, [X7], #48
    ADD  X16, X16, X8, ASR #0
    MOV  X7, X16
    ST1 { V17.2D, V18.2D, V19.2D }, [X7], #48
    MOV  X7, X16
    LD1 { V23.2D, V24.2D, V25.2D }, [X7], #48
    ADD  X16, X16, X8, ASR #0
    MOV  X7, X16
    ST1 { V26.4S, V27.4S, V28.4S }, [X7], #48
    MOV  X7, X16
    LD1 { V22.4S, V23.4S, V24.4S }, [X7], #48
    ADD  X16, X16, X8, ASR #0
    MOV  X7, X16
    ST1 { V30.8H, V31.8H, V0.8H }, [X7], #48
    MOV  X7, X16
    LD1 { V0.8H, V1.8H, V2.8H }, [X7], #48
    ADD  X16, X16, X8, ASR #0
    MOV  X7, X16
    ST1 { V18.8B, V19.8B, V20.8B }, [X7], #24
    MOV  X7, X16
    LD1 { V14.8B, V15.8B, V16.8B }, [X7], #24
    ADD  X16, X16, X8
    MOV  X7, X16
    ST1 { V23.1D, V24.1D, V25.1D }, [X7], #24
    MOV  X7, X16
    LD1 { V26.1D, V27.1D, V28.1D }, [X7], #24
    ADD  X16, X16, X8
    MOV  X7, X16
    ST1 { V26.2S, V27.2S, V28.2S }, [X7], #24
    MOV  X7, X16
    LD1 { V18.2S, V19.2S, V20.2S }, [X7], #24
    ADD  X16, X16, X8, ASR #0
    MOV  X7, X16
    ST1 { V14.4H, V15.4H, V16.4H }, [X7], #24
    MOV  X7, X16
    LD1 { V14.4H, V15.4H, V16.4H }, [X7], #24
    ADD  X16, X16, X8, ASR #0
    MOV  X7, X16
    ST1 { V14.8B, V15.8B, V16.8B }, [X7], #24
    MOV  X7, X16
    LD1 { V2.8B, V3.8B, V4.8B }, [X7], #24
    ADD  X16, X16, X8
    ST1 { V2.16B, V3.16B, V4.16B }, [X16], X17
    LD1 { V2.16B, V3.16B, V4.16B }, [X16], X17
    ADD  X16, X16, X8, ASR #0
    ST1 { V18.16B, V19.16B, V20.16B }, [X16], X17
    LD1 { V14.16B, V15.16B, V16.16B }, [X16], X17
    ADD  X16, X16, X8, ASR #0
    ST1 { V14.2D, V15.2D, V16.2D }, [X16], X17
    LD1 { V18.2D, V19.2D, V20.2D }, [X16], X17
    ADD  X16, X16, X8
    ST1 { V18.4S, V19.4S, V20.4S }, [X16], X17
    LD1 { V14.4S, V15.4S, V16.4S }, [X16], X17
    ADD  X16, X16, X8, ASR #0
    ST1 { V14.8H, V15.8H, V16.8H }, [X16], X17
    LD1 { V14.8H, V15.8H, V16.8H }, [X16], X17
    ADD  X16, X16, X8, ASR #0
    ST1 { V14.4H, V15.4H, V16.4H }, [X16], X17
    LD1 { V18.4H, V19.4H, V20.4H }, [X16], X17
    ADD  X16, X16, X8
    ST1 { V2.1D, V3.1D, V4.1D }, [X16], X17
    LD1 { V14.1D, V15.1D, V16.1D }, [X16], X17
    ADD  X16, X16, X8, LSR #0
    ST1 { V14.2S, V15.2S, V16.2S }, [X16], X17
    LD1 { V2.2S, V3.2S, V4.2S }, [X16], X17
    ADD  X16, X16, X8, ASR #0
    ST1 { V18.4H, V19.4H, V20.4H }, [X16], X17
    LD1 { V14.4H, V15.4H, V16.4H }, [X16], X17
    ADD  X16, X16, X8
    ST1 { V2.8B, V3.8B, V4.8B }, [X16], X17
    LD1 { V18.8B, V19.8B, V20.8B }, [X16], X17
    ADD  X16, X16, X8, ASR #0
    MOV  X7, X16
    ST1 { V14.2D, V15.2D }, [X7], #32
    MOV  X7, X16
    LD1 { V14.2D, V15.2D }, [X7], #32
    ADD  X16, X16, X8, ASR #0
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X6, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X6, FPSR
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V0.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D0
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V1.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D1
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D2
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D3
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V4.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D4
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V5.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D5
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V6.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D6
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V7.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D7
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V8.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D8
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V9.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D9
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V10.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D10
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V11.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D11
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V12.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D12
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V13.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D13
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D14
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D15
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D16
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V17.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D17
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D18
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D19
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D20
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V21.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D21
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V22.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D22
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D23
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V24.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D24
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V25.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D25
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D26
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D27
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D28
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V29.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D29
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V30.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D30
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, V31.D[1]
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X6, D31
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X23
    FMOV  D1, X27
    FMOV  V1.D[1], X20
    FMOV  D2, X26
    FMOV  V2.D[1], X24
    FMOV  D3, X4
    FMOV  V3.D[1], X5
    FMOV  D4, X13
    FMOV  V4.D[1], X3
    FMOV  D5, X4
    FMOV  V5.D[1], X22
    FMOV  D6, X14
    FMOV  V6.D[1], X4
    FMOV  D7, X28
    FMOV  V7.D[1], X27
    FMOV  D8, X5
    FMOV  V8.D[1], X20
    FMOV  D9, X9
    FMOV  V9.D[1], X10
    FMOV  D10, X27
    FMOV  V10.D[1], X16
    FMOV  D11, X5
    FMOV  V11.D[1], X27
    FMOV  D12, X3
    FMOV  V12.D[1], X19
    FMOV  D13, X19
    FMOV  V13.D[1], X19
    FMOV  D14, X9
    FMOV  V14.D[1], X5
    FMOV  D15, X14
    FMOV  V15.D[1], X15
    FMOV  D16, X3
    FMOV  V16.D[1], X13
    FMOV  D17, X4
    FMOV  V17.D[1], X12
    FMOV  D18, X28
    FMOV  V18.D[1], X10
    FMOV  D19, X8
    FMOV  V19.D[1], X15
    FMOV  D20, X28
    FMOV  V20.D[1], X13
    FMOV  D21, X27
    FMOV  V21.D[1], X19
    FMOV  D22, X4
    FMOV  V22.D[1], X13
    FMOV  D23, X13
    FMOV  V23.D[1], X26
    FMOV  D24, X4
    FMOV  V24.D[1], X15
    FMOV  D25, X13
    FMOV  V25.D[1], X3
    FMOV  D26, X3
    FMOV  V26.D[1], X27
    FMOV  D27, X17
    FMOV  V27.D[1], X28
    FMOV  D28, X27
    FMOV  V28.D[1], X24
    FMOV  D29, X24
    FMOV  V29.D[1], X7
    FMOV  D30, X4
    FMOV  V30.D[1], X5
    FMOV  D31, X20
    FMOV  V31.D[1], X23
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X5, #0x2800, LSL #0
    ADD  X6, X30, X5, ASR #0
    ST1 { V27.2D }, [X6], X27
    LD1 { V9.16B }, [X6], X27
    ADD  X6, X6, X17
    ST1 { V9.16B }, [X6], X27
    LD1 { V27.16B }, [X6], X27
    ADD  X6, X6, X17, ASR #0
    ST1 { V27.2D }, [X6], X27
    LD1 { V28.2D }, [X6], X27
    ADD  X6, X6, X17
    ST1 { V30.4S }, [X6], X27
    LD1 { V0.4S }, [X6], X27
    ADD  X6, X6, X17, LSR #0
    ST1 { V31.8H }, [X6], X27
    LD1 { V12.8H }, [X6], X27
    ADD  X6, X6, X17, LSR #0
    ST1 { V28.2S }, [X6], X27
    LD1 { V1.8B }, [X6], X27
    ADD  X6, X6, X17, ASR #0
    ST1 { V1.1D }, [X6], X27
    LD1 { V0.1D }, [X6], X27
    ADD  X6, X6, X17, LSR #0
    ST1 { V12.2S }, [X6], X27
    LD1 { V12.2S }, [X6], X27
    ADD  X6, X6, X17
    ST1 { V12.4H }, [X6], X27
    LD1 { V16.4H }, [X6], X27
    ADD  X6, X6, X17, LSR #0
    ST1 { V13.8B }, [X6], X27
    LD1 { V28.8B }, [X6], X27
    ADD  X6, X6, X17, ASR #0
    MOV  X14, X6
    ST1 { V21.4S, V22.4S, V23.4S }, [X14], #48
    MOV  X14, X6
    LD1 { V26.8H, V27.8H, V28.8H }, [X14], #48
    ADD  X6, X6, X17, LSR #0
    MOV  X14, X6
    ST1 { V18.16B, V19.16B, V20.16B }, [X14], #48
    MOV  X14, X6
    LD1 { V12.16B, V13.16B, V14.16B }, [X14], #48
    ADD  X6, X6, X17, LSR #0
    MOV  X14, X6
    ST1 { V10.2D, V11.2D, V12.2D }, [X14], #48
    MOV  X14, X6
    LD1 { V17.2D, V18.2D, V19.2D }, [X14], #48
    ADD  X6, X6, X17
    MOV  X14, X6
    ST1 { V26.4S, V27.4S, V28.4S }, [X14], #48
    MOV  X14, X6
    LD1 { V30.4S, V31.4S, V0.4S }, [X14], #48
    ADD  X6, X6, X17
    MOV  X14, X6
    ST1 { V21.8H, V22.8H, V23.8H }, [X14], #48
    MOV  X14, X6
    LD1 { V26.8H, V27.8H, V28.8H }, [X14], #48
    ADD  X6, X6, X17, LSR #0
    MOV  X14, X6
    ST1 { V17.8B, V18.8B, V19.8B }, [X14], #24
    MOV  X14, X6
    LD1 { V8.8B, V9.8B, V10.8B }, [X14], #24
    ADD  X6, X6, X17
    MOV  X14, X6
    ST1 { V8.1D, V9.1D, V10.1D }, [X14], #24
    MOV  X14, X6
    LD1 { V15.1D, V16.1D, V17.1D }, [X14], #24
    ADD  X6, X6, X17
    MOV  X14, X6
    ST1 { V26.2S, V27.2S, V28.2S }, [X14], #24
    MOV  X14, X6
    LD1 { V28.2S, V29.2S, V30.2S }, [X14], #24
    ADD  X6, X6, X17, ASR #0
    MOV  X14, X6
    ST1 { V28.4H, V29.4H, V30.4H }, [X14], #24
    MOV  X14, X6
    LD1 { V8.4H, V9.4H, V10.4H }, [X14], #24
    ADD  X6, X6, X17, ASR #0
    MOV  X14, X6
    ST1 { V8.8B, V9.8B, V10.8B }, [X14], #24
    MOV  X14, X6
    LD1 { V8.8B, V9.8B, V10.8B }, [X14], #24
    ADD  X6, X6, X17, ASR #0
    ST1 { V15.8H, V16.8H, V17.8H }, [X6], X27
    LD1 { V15.16B, V16.16B, V17.16B }, [X6], X27
    ADD  X6, X6, X17, ASR #0
    ST1 { V26.16B, V27.16B, V28.16B }, [X6], X27
    LD1 { V26.16B, V27.16B, V28.16B }, [X6], X27
    ADD  X6, X6, X17
    ST1 { V15.2D, V16.2D, V17.2D }, [X6], X27
    LD1 { V15.2D, V16.2D, V17.2D }, [X6], X27
    ADD  X6, X6, X17, ASR #0
    ST1 { V8.4S, V9.4S, V10.4S }, [X6], X27
    LD1 { V7.4S, V8.4S, V9.4S }, [X6], X27
    ADD  X6, X6, X17, ASR #0
    ST1 { V15.8H, V16.8H, V17.8H }, [X6], X27
    LD1 { V26.8H, V27.8H, V28.8H }, [X6], X27
    ADD  X6, X6, X17
    ST1 { V7.2S, V8.2S, V9.2S }, [X6], X27
    LD1 { V16.2S, V17.2S, V18.2S }, [X6], X27
    ADD  X6, X6, X17, LSR #0
    ST1 { V26.1D, V27.1D, V28.1D }, [X6], X27
    LD1 { V24.1D, V25.1D, V26.1D }, [X6], X27
    ADD  X6, X6, X17, LSR #0
    ST1 { V16.2S, V17.2S, V18.2S }, [X6], X27
    LD1 { V31.2S, V0.2S, V1.2S }, [X6], X27
    ADD  X6, X6, X17, ASR #0
    ST1 { V31.4H, V0.4H, V1.4H }, [X6], X27
    LD1 { V17.4H, V18.4H, V19.4H }, [X6], X27
    ADD  X6, X6, X17, LSR #0
    ST1 { V17.8B, V18.8B, V19.8B }, [X6], X27
    LD1 { V18.8B, V19.8B, V20.8B }, [X6], X27
    ADD  X6, X6, X17
    MOV  X14, X6
    ST1 { V18.2D, V19.2D }, [X14], #32
    MOV  X14, X6
    LD1 { V10.16B, V11.16B }, [X14], #32
    ADD  X6, X6, X17, LSR #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X11, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V0.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D0
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V1.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D1
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V2.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D2
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V3.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D3
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V4.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D4
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V5.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D5
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V6.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D6
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D7
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D8
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V9.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D9
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D10
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D11
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V12.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D12
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V13.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D13
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V14.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D14
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V15.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D15
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D16
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D17
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V18.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D18
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V19.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D19
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D20
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V21.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D21
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V22.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D22
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, V23.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D23
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D24
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D25
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D26
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D27
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D28
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D29
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D30
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X11, D31
    SUB  X20, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X20
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X24
    FMOV  V2.D[1], X28
    FMOV  D3, X15
    FMOV  V3.D[1], X5
    FMOV  D4, X6
    FMOV  V4.D[1], X9
    FMOV  D5, X26
    FMOV  V5.D[1], X27
    FMOV  D6, X6
    FMOV  V6.D[1], X9
    FMOV  D7, X24
    FMOV  V7.D[1], X17
    FMOV  D8, X27
    FMOV  V8.D[1], X13
    FMOV  D9, X13
    FMOV  V9.D[1], X24
    FMOV  D10, X9
    FMOV  V10.D[1], X11
    FMOV  D11, X20
    FMOV  V11.D[1], X17
    FMOV  D12, X4
    FMOV  V12.D[1], X14
    FMOV  D13, X24
    FMOV  V13.D[1], X12
    FMOV  D14, X8
    FMOV  V14.D[1], X26
    FMOV  D15, X2
    FMOV  V15.D[1], X2
    FMOV  D16, X14
    FMOV  V16.D[1], X16
    FMOV  D17, X7
    FMOV  V17.D[1], X12
    FMOV  D18, X11
    FMOV  V18.D[1], X7
    FMOV  D19, X14
    FMOV  V19.D[1], X5
    FMOV  D20, X26
    FMOV  V20.D[1], X9
    FMOV  D21, X23
    FMOV  V21.D[1], X15
    FMOV  D22, X6
    FMOV  V22.D[1], X11
    FMOV  D23, X8
    FMOV  V23.D[1], X24
    FMOV  D24, X20
    FMOV  V24.D[1], X11
    FMOV  D25, X28
    FMOV  V25.D[1], X23
    FMOV  D26, X24
    FMOV  V26.D[1], X28
    FMOV  D27, X14
    FMOV  V27.D[1], X8
    FMOV  D28, X13
    FMOV  V28.D[1], X26
    FMOV  D29, X3
    FMOV  V29.D[1], X23
    FMOV  D30, X8
    FMOV  V30.D[1], X23
    FMOV  D31, X8
    FMOV  V31.D[1], X19
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X2, #0x2d00, LSL #0
    ADD  X14, X30, X2, LSR #0
    ST1 { V27.2D }, [X14], X17
    LD1 { V2.4S }, [X14], X17
    ADD  X14, X14, X8, ASR #0
    ST1 { V31.16B }, [X14], X17
    LD1 { V19.16B }, [X14], X17
    ADD  X14, X14, X8, LSR #0
    ST1 { V29.2D }, [X14], X17
    LD1 { V28.2D }, [X14], X17
    ADD  X14, X14, X8, LSR #0
    ST1 { V2.4S }, [X14], X17
    LD1 { V10.4S }, [X14], X17
    ADD  X14, X14, X8, ASR #0
    ST1 { V25.8H }, [X14], X17
    LD1 { V18.8H }, [X14], X17
    ADD  X14, X14, X8, LSR #0
    ST1 { V18.8B }, [X14], X17
    LD1 { V12.1D }, [X14], X17
    ADD  X14, X14, X8, ASR #0
    ST1 { V28.1D }, [X14], X17
    LD1 { V11.1D }, [X14], X17
    ADD  X14, X14, X8
    ST1 { V11.2S }, [X14], X17
    LD1 { V0.2S }, [X14], X17
    ADD  X14, X14, X8, ASR #0
    ST1 { V0.4H }, [X14], X17
    LD1 { V8.4H }, [X14], X17
    ADD  X14, X14, X8
    ST1 { V8.8B }, [X14], X17
    LD1 { V25.8B }, [X14], X17
    ADD  X14, X14, X8, LSR #0
    MOV  X15, X14
    ST1 { V6.4S, V7.4S, V8.4S }, [X15], #48
    MOV  X15, X14
    LD1 { V16.16B, V17.16B, V18.16B }, [X15], #48
    ADD  X14, X14, X8, ASR #0
    MOV  X15, X14
    ST1 { V17.16B, V18.16B, V19.16B }, [X15], #48
    MOV  X15, X14
    LD1 { V5.16B, V6.16B, V7.16B }, [X15], #48
    ADD  X14, X14, X8, ASR #0
    MOV  X15, X14
    ST1 { V11.2D, V12.2D, V13.2D }, [X15], #48
    MOV  X15, X14
    LD1 { V13.2D, V14.2D, V15.2D }, [X15], #48
    ADD  X14, X14, X8
    MOV  X15, X14
    ST1 { V5.4S, V6.4S, V7.4S }, [X15], #48
    MOV  X15, X14
    LD1 { V8.4S, V9.4S, V10.4S }, [X15], #48
    ADD  X14, X14, X8, LSR #0
    MOV  X15, X14
    ST1 { V14.8H, V15.8H, V16.8H }, [X15], #48
    MOV  X15, X14
    LD1 { V31.8H, V0.8H, V1.8H }, [X15], #48
    ADD  X14, X14, X8
    MOV  X15, X14
    ST1 { V8.4H, V9.4H, V10.4H }, [X15], #24
    MOV  X15, X14
    LD1 { V15.8B, V16.8B, V17.8B }, [X15], #24
    ADD  X14, X14, X8
    MOV  X15, X14
    ST1 { V15.1D, V16.1D, V17.1D }, [X15], #24
    MOV  X15, X14
    LD1 { V25.1D, V26.1D, V27.1D }, [X15], #24
    ADD  X14, X14, X8
    MOV  X15, X14
    ST1 { V25.2S, V26.2S, V27.2S }, [X15], #24
    MOV  X15, X14
    LD1 { V5.2S, V6.2S, V7.2S }, [X15], #24
    ADD  X14, X14, X8, LSR #0
    MOV  X15, X14
    ST1 { V5.4H, V6.4H, V7.4H }, [X15], #24
    MOV  X15, X14
    LD1 { V15.4H, V16.4H, V17.4H }, [X15], #24
    ADD  X14, X14, X8, LSR #0
    MOV  X15, X14
    ST1 { V15.8B, V16.8B, V17.8B }, [X15], #24
    MOV  X15, X14
    LD1 { V15.8B, V16.8B, V17.8B }, [X15], #24
    ADD  X14, X14, X8, ASR #0
    ST1 { V31.8H, V0.8H, V1.8H }, [X14], X17
    LD1 { V25.2D, V26.2D, V27.2D }, [X14], X17
    ADD  X14, X14, X8
    ST1 { V15.16B, V16.16B, V17.16B }, [X14], X17
    LD1 { V8.16B, V9.16B, V10.16B }, [X14], X17
    ADD  X14, X14, X8, LSR #0
    ST1 { V14.2D, V15.2D, V16.2D }, [X14], X17
    LD1 { V31.2D, V0.2D, V1.2D }, [X14], X17
    ADD  X14, X14, X8
    ST1 { V25.4S, V26.4S, V27.4S }, [X14], X17
    LD1 { V25.4S, V26.4S, V27.4S }, [X14], X17
    ADD  X14, X14, X8, ASR #0
    ST1 { V8.8H, V9.8H, V10.8H }, [X14], X17
    LD1 { V8.8H, V9.8H, V10.8H }, [X14], X17
    ADD  X14, X14, X8
    ST1 { V25.4H, V26.4H, V27.4H }, [X14], X17
    LD1 { V25.1D, V26.1D, V27.1D }, [X14], X17
    ADD  X14, X14, X8
    ST1 { V8.1D, V9.1D, V10.1D }, [X14], X17
    LD1 { V8.1D, V9.1D, V10.1D }, [X14], X17
    ADD  X14, X14, X8
    ST1 { V8.2S, V9.2S, V10.2S }, [X14], X17
    LD1 { V14.2S, V15.2S, V16.2S }, [X14], X17
    ADD  X14, X14, X8, ASR #0
    ST1 { V31.4H, V0.4H, V1.4H }, [X14], X17
    LD1 { V25.4H, V26.4H, V27.4H }, [X14], X17
    ADD  X14, X14, X8, ASR #0
    ST1 { V14.8B, V15.8B, V16.8B }, [X14], X17
    LD1 { V31.8B, V0.8B, V1.8B }, [X14], X17
    ADD  X14, X14, X8
    MOV  X15, X14
    ST1 { V26.8H, V27.8H }, [X15], #32
    MOV  X15, X14
    LD1 { V8.2D, V9.2D }, [X15], #32
    ADD  X14, X14, X8
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X5, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X5, FPSR
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V0.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D0
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V1.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D1
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V2.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D2
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V3.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D3
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V4.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D4
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V5.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D5
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V6.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D6
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V7.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D7
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V8.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D8
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V9.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D9
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D10
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D11
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D12
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V13.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D13
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D14
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D15
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D16
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V17.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D17
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V18.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D18
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V19.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D19
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V20.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D20
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V21.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D21
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V22.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D22
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V23.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D23
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V24.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D24
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D25
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D26
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D27
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V28.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D28
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V29.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D29
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, V30.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D30
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X5, D31
    SUB  X27, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X26
    FMOV  V0.D[1], X23
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X24
    FMOV  V2.D[1], X19
    FMOV  D3, X23
    FMOV  V3.D[1], X7
    FMOV  D4, X16
    FMOV  V4.D[1], X3
    FMOV  D5, X15
    FMOV  V5.D[1], X11
    FMOV  D6, X17
    FMOV  V6.D[1], X28
    FMOV  D7, X23
    FMOV  V7.D[1], X12
    FMOV  D8, X28
    FMOV  V8.D[1], X7
    FMOV  D9, X27
    FMOV  V9.D[1], X27
    FMOV  D10, X3
    FMOV  V10.D[1], X6
    FMOV  D11, X9
    FMOV  V11.D[1], X16
    FMOV  D12, X19
    FMOV  V12.D[1], X23
    FMOV  D13, X4
    FMOV  V13.D[1], X9
    FMOV  D14, X27
    FMOV  V14.D[1], X7
    FMOV  D15, X8
    FMOV  V15.D[1], X16
    FMOV  D16, X28
    FMOV  V16.D[1], X8
    FMOV  D17, X6
    FMOV  V17.D[1], X11
    FMOV  D18, X17
    FMOV  V18.D[1], X12
    FMOV  D19, X22
    FMOV  V19.D[1], X23
    FMOV  D20, X10
    FMOV  V20.D[1], X8
    FMOV  D21, X5
    FMOV  V21.D[1], X14
    FMOV  D22, X7
    FMOV  V22.D[1], X5
    FMOV  D23, X16
    FMOV  V23.D[1], X5
    FMOV  D24, X23
    FMOV  V24.D[1], X17
    FMOV  D25, X13
    FMOV  V25.D[1], X5
    FMOV  D26, X6
    FMOV  V26.D[1], X19
    FMOV  D27, X19
    FMOV  V27.D[1], X6
    FMOV  D28, X20
    FMOV  V28.D[1], X10
    FMOV  D29, X5
    FMOV  V29.D[1], X6
    FMOV  D30, X4
    FMOV  V30.D[1], X17
    FMOV  D31, X9
    FMOV  V31.D[1], X6
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X12, #0x0, LSL #0
    ADD  X9, X30, X12
    ST1 { V30.16B }, [X9], X8
    LD1 { V19.8H }, [X9], X8
    ADD  X9, X9, X2, LSR #0
    ST1 { V26.16B }, [X9], X8
    LD1 { V8.16B }, [X9], X8
    ADD  X9, X9, X2, LSR #0
    ST1 { V27.2D }, [X9], X8
    LD1 { V29.2D }, [X9], X8
    ADD  X9, X9, X2, ASR #0
    ST1 { V19.4S }, [X9], X8
    LD1 { V8.4S }, [X9], X8
    ADD  X9, X9, X2, LSR #0
    ST1 { V8.8H }, [X9], X8
    LD1 { V0.8H }, [X9], X8
    ADD  X9, X9, X2
    ST1 { V31.8B }, [X9], X8
    LD1 { V12.1D }, [X9], X8
    ADD  X9, X9, X2, LSR #0
    ST1 { V28.1D }, [X9], X8
    LD1 { V17.1D }, [X9], X8
    ADD  X9, X9, X2, ASR #0
    ST1 { V17.2S }, [X9], X8
    LD1 { V25.2S }, [X9], X8
    ADD  X9, X9, X2, LSR #0
    ST1 { V29.4H }, [X9], X8
    LD1 { V18.4H }, [X9], X8
    ADD  X9, X9, X2, LSR #0
    ST1 { V12.8B }, [X9], X8
    LD1 { V15.8B }, [X9], X8
    ADD  X9, X9, X2
    MOV  X19, X9
    ST1 { V18.2D, V19.2D, V20.2D }, [X19], #48
    MOV  X19, X9
    LD1 { V6.8H, V7.8H, V8.8H }, [X19], #48
    ADD  X9, X9, X2, LSR #0
    MOV  X19, X9
    ST1 { V6.16B, V7.16B, V8.16B }, [X19], #48
    MOV  X19, X9
    LD1 { V2.16B, V3.16B, V4.16B }, [X19], #48
    ADD  X9, X9, X2, ASR #0
    MOV  X19, X9
    ST1 { V2.2D, V3.2D, V4.2D }, [X19], #48
    MOV  X19, X9
    LD1 { V20.2D, V21.2D, V22.2D }, [X19], #48
    ADD  X9, X9, X2
    MOV  X19, X9
    ST1 { V20.4S, V21.4S, V22.4S }, [X19], #48
    MOV  X19, X9
    LD1 { V2.4S, V3.4S, V4.4S }, [X19], #48
    ADD  X9, X9, X2, ASR #0
    MOV  X19, X9
    ST1 { V2.8H, V3.8H, V4.8H }, [X19], #48
    MOV  X19, X9
    LD1 { V6.8H, V7.8H, V8.8H }, [X19], #48
    ADD  X9, X9, X2, LSR #0
    MOV  X19, X9
    ST1 { V6.2S, V7.2S, V8.2S }, [X19], #24
    MOV  X19, X9
    LD1 { V2.2S, V3.2S, V4.2S }, [X19], #24
    ADD  X9, X9, X2
    MOV  X19, X9
    ST1 { V11.1D, V12.1D, V13.1D }, [X19], #24
    MOV  X19, X9
    LD1 { V6.1D, V7.1D, V8.1D }, [X19], #24
    ADD  X9, X9, X2, LSR #0
    MOV  X19, X9
    ST1 { V26.2S, V27.2S, V28.2S }, [X19], #24
    MOV  X19, X9
    LD1 { V26.2S, V27.2S, V28.2S }, [X19], #24
    ADD  X9, X9, X2
    MOV  X19, X9
    ST1 { V26.4H, V27.4H, V28.4H }, [X19], #24
    MOV  X19, X9
    LD1 { V11.4H, V12.4H, V13.4H }, [X19], #24
    ADD  X9, X9, X2
    MOV  X19, X9
    ST1 { V2.8B, V3.8B, V4.8B }, [X19], #24
    MOV  X19, X9
    LD1 { V2.8B, V3.8B, V4.8B }, [X19], #24
    ADD  X9, X9, X2, LSR #0
    ST1 { V11.16B, V12.16B, V13.16B }, [X9], X8
    LD1 { V26.16B, V27.16B, V28.16B }, [X9], X8
    ADD  X9, X9, X2, LSR #0
    ST1 { V2.16B, V3.16B, V4.16B }, [X9], X8
    LD1 { V2.16B, V3.16B, V4.16B }, [X9], X8
    ADD  X9, X9, X2
    ST1 { V2.2D, V3.2D, V4.2D }, [X9], X8
    LD1 { V11.2D, V12.2D, V13.2D }, [X9], X8
    ADD  X9, X9, X2, ASR #0
    ST1 { V26.4S, V27.4S, V28.4S }, [X9], X8
    LD1 { V26.4S, V27.4S, V28.4S }, [X9], X8
    ADD  X9, X9, X2, ASR #0
    ST1 { V6.8H, V7.8H, V8.8H }, [X9], X8
    LD1 { V6.8H, V7.8H, V8.8H }, [X9], X8
    ADD  X9, X9, X2
    ST1 { V23.1D, V24.1D, V25.1D }, [X9], X8
    LD1 { V2.8B, V3.8B, V4.8B }, [X9], X8
    ADD  X9, X9, X2
    ST1 { V2.1D, V3.1D, V4.1D }, [X9], X8
    LD1 { V23.1D, V24.1D, V25.1D }, [X9], X8
    ADD  X9, X9, X2, ASR #0
    ST1 { V11.2S, V12.2S, V13.2S }, [X9], X8
    LD1 { V2.2S, V3.2S, V4.2S }, [X9], X8
    ADD  X9, X9, X2, ASR #0
    ST1 { V24.4H, V25.4H, V26.4H }, [X9], X8
    LD1 { V24.4H, V25.4H, V26.4H }, [X9], X8
    ADD  X9, X9, X2, ASR #0
    ST1 { V24.8B, V25.8B, V26.8B }, [X9], X8
    LD1 { V24.8B, V25.8B, V26.8B }, [X9], X8
    ADD  X9, X9, X2, ASR #0
    MOV  X19, X9
    ST1 { V7.4S, V8.4S }, [X19], #32
    MOV  X19, X9
    LD1 { V11.8H, V12.8H }, [X19], #32
    ADD  X9, X9, X2, ASR #0
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X15, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X15, FPSR
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V0.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D0
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V1.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D1
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V2.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D2
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V3.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D3
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V4.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D4
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V5.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D5
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V6.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D6
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V7.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D7
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V8.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D8
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V9.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D9
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V10.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D10
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V11.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D11
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V12.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D12
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V13.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D13
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V14.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D14
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V15.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D15
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V16.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D16
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V17.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D17
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V18.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D18
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V19.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D19
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V20.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D20
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V21.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D21
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V22.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D22
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V23.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D23
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V24.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D24
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V25.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D25
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V26.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D26
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V27.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D27
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X15, V28.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D28
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V29.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D29
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V30.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D30
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, V31.D[1]
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X15, D31
    SUB  X4, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X22
    FMOV  V2.D[1], X7
    FMOV  D3, X14
    FMOV  V3.D[1], X9
    FMOV  D4, X7
    FMOV  V4.D[1], X12
    FMOV  D5, X23
    FMOV  V5.D[1], X15
    FMOV  D6, X12
    FMOV  V6.D[1], X27
    FMOV  D7, X11
    FMOV  V7.D[1], X3
    FMOV  D8, X26
    FMOV  V8.D[1], X14
    FMOV  D9, X17
    FMOV  V9.D[1], X8
    FMOV  D10, X19
    FMOV  V10.D[1], X7
    FMOV  D11, X10
    FMOV  V11.D[1], X14
    FMOV  D12, X14
    FMOV  V12.D[1], X3
    FMOV  D13, X15
    FMOV  V13.D[1], X26
    FMOV  D14, X3
    FMOV  V14.D[1], X8
    FMOV  D15, X16
    FMOV  V15.D[1], X17
    FMOV  D16, X24
    FMOV  V16.D[1], X4
    FMOV  D17, X12
    FMOV  V17.D[1], X19
    FMOV  D18, X27
    FMOV  V18.D[1], X8
    FMOV  D19, X22
    FMOV  V19.D[1], X4
    FMOV  D20, X27
    FMOV  V20.D[1], X3
    FMOV  D21, X27
    FMOV  V21.D[1], X17
    FMOV  D22, X26
    FMOV  V22.D[1], X8
    FMOV  D23, X10
    FMOV  V23.D[1], X22
    FMOV  D24, X19
    FMOV  V24.D[1], X2
    FMOV  D25, X15
    FMOV  V25.D[1], X15
    FMOV  D26, X15
    FMOV  V26.D[1], X13
    FMOV  D27, X5
    FMOV  V27.D[1], X28
    FMOV  D28, X17
    FMOV  V28.D[1], X8
    FMOV  D29, X14
    FMOV  V29.D[1], X3
    FMOV  D30, X4
    FMOV  V30.D[1], X19
    FMOV  D31, X13
    FMOV  V31.D[1], X12
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X11, #0x500, LSL #0
    ADD  X7, X30, X11, ASR #0
    ST1 { V24.4S }, [X7], X12
    LD1 { V27.16B }, [X7], X12
    ADD  X7, X7, X19
    ST1 { V30.16B }, [X7], X12
    LD1 { V31.16B }, [X7], X12
    ADD  X7, X7, X19, LSR #0
    ST1 { V23.2D }, [X7], X12
    LD1 { V30.2D }, [X7], X12
    ADD  X7, X7, X19, ASR #0
    ST1 { V29.4S }, [X7], X12
    LD1 { V1.4S }, [X7], X12
    ADD  X7, X7, X19, LSR #0
    ST1 { V31.8H }, [X7], X12
    LD1 { V7.8H }, [X7], X12
    ADD  X7, X7, X19, ASR #0
    ST1 { V27.2S }, [X7], X12
    LD1 { V31.2S }, [X7], X12
    ADD  X7, X7, X19, LSR #0
    ST1 { V1.1D }, [X7], X12
    LD1 { V15.1D }, [X7], X12
    ADD  X7, X7, X19
    ST1 { V15.2S }, [X7], X12
    LD1 { V30.2S }, [X7], X12
    ADD  X7, X7, X19, ASR #0
    ST1 { V7.4H }, [X7], X12
    LD1 { V27.4H }, [X7], X12
    ADD  X7, X7, X19
    ST1 { V27.8B }, [X7], X12
    LD1 { V19.8B }, [X7], X12
    ADD  X7, X7, X19, LSR #0
    MOV  X22, X7
    ST1 { V7.8H, V8.8H, V9.8H }, [X22], #48
    MOV  X22, X7
    LD1 { V11.2D, V12.2D, V13.2D }, [X22], #48
    ADD  X7, X7, X19
    MOV  X22, X7
    ST1 { V18.16B, V19.16B, V20.16B }, [X22], #48
    MOV  X22, X7
    LD1 { V1.16B, V2.16B, V3.16B }, [X22], #48
    ADD  X7, X7, X19, LSR #0
    MOV  X22, X7
    ST1 { V11.2D, V12.2D, V13.2D }, [X22], #48
    MOV  X22, X7
    LD1 { V28.2D, V29.2D, V30.2D }, [X22], #48
    ADD  X7, X7, X19
    MOV  X22, X7
    ST1 { V1.4S, V2.4S, V3.4S }, [X22], #48
    MOV  X22, X7
    LD1 { V13.4S, V14.4S, V15.4S }, [X22], #48
    ADD  X7, X7, X19, ASR #0
    MOV  X22, X7
    ST1 { V28.8H, V29.8H, V30.8H }, [X22], #48
    MOV  X22, X7
    LD1 { V28.8H, V29.8H, V30.8H }, [X22], #48
    ADD  X7, X7, X19, LSR #0
    MOV  X22, X7
    ST1 { V28.2S, V29.2S, V30.2S }, [X22], #24
    MOV  X22, X7
    LD1 { V28.4H, V29.4H, V30.4H }, [X22], #24
    ADD  X7, X7, X19
    MOV  X22, X7
    ST1 { V28.1D, V29.1D, V30.1D }, [X22], #24
    MOV  X22, X7
    LD1 { V1.1D, V2.1D, V3.1D }, [X22], #24
    ADD  X7, X7, X19
    MOV  X22, X7
    ST1 { V1.2S, V2.2S, V3.2S }, [X22], #24
    MOV  X22, X7
    LD1 { V28.2S, V29.2S, V30.2S }, [X22], #24
    ADD  X7, X7, X19
    MOV  X22, X7
    ST1 { V28.4H, V29.4H, V30.4H }, [X22], #24
    MOV  X22, X7
    LD1 { V28.4H, V29.4H, V30.4H }, [X22], #24
    ADD  X7, X7, X19
    MOV  X22, X7
    ST1 { V28.8B, V29.8B, V30.8B }, [X22], #24
    MOV  X22, X7
    LD1 { V28.8B, V29.8B, V30.8B }, [X22], #24
    ADD  X7, X7, X19, LSR #0
    ST1 { V28.4S, V29.4S, V30.4S }, [X7], X12
    LD1 { V9.16B, V10.16B, V11.16B }, [X7], X12
    ADD  X7, X7, X19
    ST1 { V5.16B, V6.16B, V7.16B }, [X7], X12
    LD1 { V1.16B, V2.16B, V3.16B }, [X7], X12
    ADD  X7, X7, X19, ASR #0
    ST1 { V30.2D, V31.2D, V0.2D }, [X7], X12
    LD1 { V28.2D, V29.2D, V30.2D }, [X7], X12
    ADD  X7, X7, X19, LSR #0
    ST1 { V28.4S, V29.4S, V30.4S }, [X7], X12
    LD1 { V5.4S, V6.4S, V7.4S }, [X7], X12
    ADD  X7, X7, X19
    ST1 { V9.8H, V10.8H, V11.8H }, [X7], X12
    LD1 { V29.8H, V30.8H, V31.8H }, [X7], X12
    ADD  X7, X7, X19, LSR #0
    ST1 { V1.4H, V2.4H, V3.4H }, [X7], X12
    LD1 { V30.4H, V31.4H, V0.4H }, [X7], X12
    ADD  X7, X7, X19
    ST1 { V30.1D, V31.1D, V0.1D }, [X7], X12
    LD1 { V30.1D, V31.1D, V0.1D }, [X7], X12
    ADD  X7, X7, X19
    ST1 { V30.2S, V31.2S, V0.2S }, [X7], X12
    LD1 { V1.2S, V2.2S, V3.2S }, [X7], X12
    ADD  X7, X7, X19, LSR #0
    ST1 { V1.4H, V2.4H, V3.4H }, [X7], X12
    LD1 { V0.4H, V1.4H, V2.4H }, [X7], X12
    ADD  X7, X7, X19
    ST1 { V0.8B, V1.8B, V2.8B }, [X7], X12
    LD1 { V0.8B, V1.8B, V2.8B }, [X7], X12
    ADD  X7, X7, X19
    MOV  X22, X7
    ST1 { V0.8H, V1.8H }, [X22], #32
    MOV  X22, X7
    LD1 { V11.8H, V12.8H }, [X22], #32
    ADD  X7, X7, X19, LSR #0
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X9, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V0.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V1.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V2.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V3.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V4.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V7.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V9.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D10
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D11
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D12
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V13.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V15.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V16.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V17.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V18.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V19.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V20.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V21.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V22.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V23.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V25.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, V26.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V30.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X9, V31.D[1]
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X4, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X22
    FMOV  D3, X3
    FMOV  V3.D[1], X19
    FMOV  D4, X10
    FMOV  V4.D[1], X28
    FMOV  D5, X28
    FMOV  V5.D[1], X23
    FMOV  D6, X20
    FMOV  V6.D[1], X11
    FMOV  D7, X17
    FMOV  V7.D[1], X20
    FMOV  D8, X6
    FMOV  V8.D[1], X20
    FMOV  D9, X14
    FMOV  V9.D[1], X7
    FMOV  D10, X2
    FMOV  V10.D[1], X24
    FMOV  D11, X14
    FMOV  V11.D[1], X27
    FMOV  D12, X8
    FMOV  V12.D[1], X4
    FMOV  D13, X15
    FMOV  V13.D[1], X4
    FMOV  D14, X15
    FMOV  V14.D[1], X16
    FMOV  D15, X10
    FMOV  V15.D[1], X17
    FMOV  D16, X23
    FMOV  V16.D[1], X26
    FMOV  D17, X10
    FMOV  V17.D[1], X6
    FMOV  D18, X17
    FMOV  V18.D[1], X20
    FMOV  D19, X10
    FMOV  V19.D[1], X10
    FMOV  D20, X7
    FMOV  V20.D[1], X19
    FMOV  D21, X26
    FMOV  V21.D[1], X12
    FMOV  D22, X12
    FMOV  V22.D[1], X17
    FMOV  D23, X3
    FMOV  V23.D[1], X2
    FMOV  D24, X3
    FMOV  V24.D[1], X14
    FMOV  D25, X8
    FMOV  V25.D[1], X16
    FMOV  D26, X11
    FMOV  V26.D[1], X19
    FMOV  D27, X14
    FMOV  V27.D[1], X5
    FMOV  D28, X5
    FMOV  V28.D[1], X28
    FMOV  D29, X26
    FMOV  V29.D[1], X11
    FMOV  D30, X23
    FMOV  V30.D[1], X14
    FMOV  D31, X16
    FMOV  V31.D[1], X26
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X3, #0xa00, LSL #0
    ADD  X10, X30, X3, LSR #0
    ST1 { V31.4S }, [X10], X19
    LD1 { V24.2D }, [X10], X19
    ADD  X10, X10, X5
    ST1 { V27.16B }, [X10], X19
    LD1 { V24.16B }, [X10], X19
    ADD  X10, X10, X5, ASR #0
    ST1 { V28.2D }, [X10], X19
    LD1 { V28.2D }, [X10], X19
    ADD  X10, X10, X5, LSR #0
    ST1 { V28.4S }, [X10], X19
    LD1 { V13.4S }, [X10], X19
    ADD  X10, X10, X5, LSR #0
    ST1 { V13.8H }, [X10], X19
    LD1 { V2.8H }, [X10], X19
    ADD  X10, X10, X5, LSR #0
    ST1 { V2.8B }, [X10], X19
    LD1 { V30.1D }, [X10], X19
    ADD  X10, X10, X5, ASR #0
    ST1 { V30.1D }, [X10], X19
    LD1 { V16.1D }, [X10], X19
    ADD  X10, X10, X5, LSR #0
    ST1 { V16.2S }, [X10], X19
    LD1 { V22.2S }, [X10], X19
    ADD  X10, X10, X5, ASR #0
    ST1 { V24.4H }, [X10], X19
    LD1 { V3.4H }, [X10], X19
    ADD  X10, X10, X5, ASR #0
    ST1 { V31.8B }, [X10], X19
    LD1 { V7.8B }, [X10], X19
    ADD  X10, X10, X5, ASR #0
    MOV  X16, X10
    ST1 { V19.2D, V20.2D, V21.2D }, [X16], #48
    MOV  X16, X10
    LD1 { V12.16B, V13.16B, V14.16B }, [X16], #48
    ADD  X10, X10, X5, LSR #0
    MOV  X16, X10
    ST1 { V22.16B, V23.16B, V24.16B }, [X16], #48
    MOV  X16, X10
    LD1 { V5.16B, V6.16B, V7.16B }, [X16], #48
    ADD  X10, X10, X5, LSR #0
    MOV  X16, X10
    ST1 { V18.2D, V19.2D, V20.2D }, [X16], #48
    MOV  X16, X10
    LD1 { V18.2D, V19.2D, V20.2D }, [X16], #48
    ADD  X10, X10, X5, LSR #0
    MOV  X16, X10
    ST1 { V5.4S, V6.4S, V7.4S }, [X16], #48
    MOV  X16, X10
    LD1 { V8.4S, V9.4S, V10.4S }, [X16], #48
    ADD  X10, X10, X5, ASR #0
    MOV  X16, X10
    ST1 { V12.8H, V13.8H, V14.8H }, [X16], #48
    MOV  X16, X10
    LD1 { V18.8H, V19.8H, V20.8H }, [X16], #48
    ADD  X10, X10, X5
    MOV  X16, X10
    ST1 { V24.2S, V25.2S, V26.2S }, [X16], #24
    MOV  X16, X10
    LD1 { V24.8B, V25.8B, V26.8B }, [X16], #24
    ADD  X10, X10, X5, ASR #0
    MOV  X16, X10
    ST1 { V24.1D, V25.1D, V26.1D }, [X16], #24
    MOV  X16, X10
    LD1 { V21.1D, V22.1D, V23.1D }, [X16], #24
    ADD  X10, X10, X5, ASR #0
    MOV  X16, X10
    ST1 { V21.2S, V22.2S, V23.2S }, [X16], #24
    MOV  X16, X10
    LD1 { V31.2S, V0.2S, V1.2S }, [X16], #24
    ADD  X10, X10, X5, LSR #0
    MOV  X16, X10
    ST1 { V18.4H, V19.4H, V20.4H }, [X16], #24
    MOV  X16, X10
    LD1 { V24.4H, V25.4H, V26.4H }, [X16], #24
    ADD  X10, X10, X5, ASR #0
    MOV  X16, X10
    ST1 { V24.8B, V25.8B, V26.8B }, [X16], #24
    MOV  X16, X10
    LD1 { V12.8B, V13.8B, V14.8B }, [X16], #24
    ADD  X10, X10, X5, ASR #0
    ST1 { V31.8H, V0.8H, V1.8H }, [X10], X19
    LD1 { V21.16B, V22.16B, V23.16B }, [X10], X19
    ADD  X10, X10, X5
    ST1 { V12.16B, V13.16B, V14.16B }, [X10], X19
    LD1 { V18.16B, V19.16B, V20.16B }, [X10], X19
    ADD  X10, X10, X5, LSR #0
    ST1 { V18.2D, V19.2D, V20.2D }, [X10], X19
    LD1 { V18.2D, V19.2D, V20.2D }, [X10], X19
    ADD  X10, X10, X5
    ST1 { V18.4S, V19.4S, V20.4S }, [X10], X19
    LD1 { V18.4S, V19.4S, V20.4S }, [X10], X19
    ADD  X10, X10, X5, LSR #0
    ST1 { V19.8H, V20.8H, V21.8H }, [X10], X19
    LD1 { V31.8H, V0.8H, V1.8H }, [X10], X19
    ADD  X10, X10, X5, ASR #0
    ST1 { V31.2S, V0.2S, V1.2S }, [X10], X19
    LD1 { V4.2S, V5.2S, V6.2S }, [X10], X19
    ADD  X10, X10, X5, LSR #0
    ST1 { V19.1D, V20.1D, V21.1D }, [X10], X19
    LD1 { V31.1D, V0.1D, V1.1D }, [X10], X19
    ADD  X10, X10, X5, ASR #0
    ST1 { V31.2S, V0.2S, V1.2S }, [X10], X19
    LD1 { V19.2S, V20.2S, V21.2S }, [X10], X19
    ADD  X10, X10, X5, ASR #0
    ST1 { V4.4H, V5.4H, V6.4H }, [X10], X19
    LD1 { V24.4H, V25.4H, V26.4H }, [X10], X19
    ADD  X10, X10, X5
    ST1 { V18.8B, V19.8B, V20.8B }, [X10], X19
    LD1 { V31.8B, V0.8B, V1.8B }, [X10], X19
    ADD  X10, X10, X5
    MOV  X16, X10
    ST1 { V22.16B, V23.16B }, [X16], #32
    MOV  X16, X10
    LD1 { V22.4S, V23.4S }, [X16], #32
    ADD  X10, X10, X5, ASR #0
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X8, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D0
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D1
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V2.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D2
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D3
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D4
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D5
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D6
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V7.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D7
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D8
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V9.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D9
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V10.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D10
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D11
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D12
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V13.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D13
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D14
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D15
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D16
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V17.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D17
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D18
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D19
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D20
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D21
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D22
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D23
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D24
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D25
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D26
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V27.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D27
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V28.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D28
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, V29.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D29
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D30
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X8, D31
    SUB  X13, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X24
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X14
    FMOV  D3, X12
    FMOV  V3.D[1], X26
    FMOV  D4, X15
    FMOV  V4.D[1], X5
    FMOV  D5, X15
    FMOV  V5.D[1], X26
    FMOV  D6, X14
    FMOV  V6.D[1], X27
    FMOV  D7, X20
    FMOV  V7.D[1], X9
    FMOV  D8, X8
    FMOV  V8.D[1], X14
    FMOV  D9, X20
    FMOV  V9.D[1], X27
    FMOV  D10, X13
    FMOV  V10.D[1], X20
    FMOV  D11, X17
    FMOV  V11.D[1], X8
    FMOV  D12, X24
    FMOV  V12.D[1], X6
    FMOV  D13, X12
    FMOV  V13.D[1], X24
    FMOV  D14, X7
    FMOV  V14.D[1], X14
    FMOV  D15, X7
    FMOV  V15.D[1], X15
    FMOV  D16, X27
    FMOV  V16.D[1], X11
    FMOV  D17, X13
    FMOV  V17.D[1], X4
    FMOV  D18, X13
    FMOV  V18.D[1], X5
    FMOV  D19, X4
    FMOV  V19.D[1], X26
    FMOV  D20, X17
    FMOV  V20.D[1], X11
    FMOV  D21, X20
    FMOV  V21.D[1], X10
    FMOV  D22, X5
    FMOV  V22.D[1], X13
    FMOV  D23, X8
    FMOV  V23.D[1], X5
    FMOV  D24, X24
    FMOV  V24.D[1], X5
    FMOV  D25, X7
    FMOV  V25.D[1], X7
    FMOV  D26, X27
    FMOV  V26.D[1], X13
    FMOV  D27, X22
    FMOV  V27.D[1], X14
    FMOV  D28, X23
    FMOV  V28.D[1], X12
    FMOV  D29, X5
    FMOV  V29.D[1], X27
    FMOV  D30, X8
    FMOV  V30.D[1], X12
    FMOV  D31, X26
    FMOV  V31.D[1], X24
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X27, #0xf00, LSL #0
    ADD  X2, X30, X27, LSR #0
    ST1 { V27.8H }, [X2], X7
    LD1 { V6.16B }, [X2], X7
    ADD  X2, X2, X3, LSR #0
    ST1 { V30.16B }, [X2], X7
    LD1 { V0.16B }, [X2], X7
    ADD  X2, X2, X3, LSR #0
    ST1 { V0.2D }, [X2], X7
    LD1 { V26.2D }, [X2], X7
    ADD  X2, X2, X3
    ST1 { V25.4S }, [X2], X7
    LD1 { V26.4S }, [X2], X7
    ADD  X2, X2, X3, ASR #0
    ST1 { V6.8H }, [X2], X7
    LD1 { V7.8H }, [X2], X7
    ADD  X2, X2, X3, ASR #0
    ST1 { V7.4H }, [X2], X7
    LD1 { V4.4H }, [X2], X7
    ADD  X2, X2, X3
    ST1 { V26.1D }, [X2], X7
    LD1 { V15.1D }, [X2], X7
    ADD  X2, X2, X3, LSR #0
    ST1 { V4.2S }, [X2], X7
    LD1 { V30.2S }, [X2], X7
    ADD  X2, X2, X3, ASR #0
    ST1 { V30.4H }, [X2], X7
    LD1 { V19.4H }, [X2], X7
    ADD  X2, X2, X3, ASR #0
    ST1 { V19.8B }, [X2], X7
    LD1 { V27.8B }, [X2], X7
    ADD  X2, X2, X3
    MOV  X13, X2
    ST1 { V22.16B, V23.16B, V24.16B }, [X13], #48
    MOV  X13, X2
    LD1 { V30.2D, V31.2D, V0.2D }, [X13], #48
    ADD  X2, X2, X3, LSR #0
    MOV  X13, X2
    ST1 { V4.16B, V5.16B, V6.16B }, [X13], #48
    MOV  X13, X2
    LD1 { V9.16B, V10.16B, V11.16B }, [X13], #48
    ADD  X2, X2, X3, LSR #0
    MOV  X13, X2
    ST1 { V28.2D, V29.2D, V30.2D }, [X13], #48
    MOV  X13, X2
    LD1 { V16.2D, V17.2D, V18.2D }, [X13], #48
    ADD  X2, X2, X3
    MOV  X13, X2
    ST1 { V16.4S, V17.4S, V18.4S }, [X13], #48
    MOV  X13, X2
    LD1 { V22.4S, V23.4S, V24.4S }, [X13], #48
    ADD  X2, X2, X3, LSR #0
    MOV  X13, X2
    ST1 { V18.8H, V19.8H, V20.8H }, [X13], #48
    MOV  X13, X2
    LD1 { V4.8H, V5.8H, V6.8H }, [X13], #48
    ADD  X2, X2, X3, LSR #0
    MOV  X13, X2
    ST1 { V22.2S, V23.2S, V24.2S }, [X13], #24
    MOV  X13, X2
    LD1 { V0.1D, V1.1D, V2.1D }, [X13], #24
    ADD  X2, X2, X3
    MOV  X13, X2
    ST1 { V4.1D, V5.1D, V6.1D }, [X13], #24
    MOV  X13, X2
    LD1 { V18.1D, V19.1D, V20.1D }, [X13], #24
    ADD  X2, X2, X3, ASR #0
    MOV  X13, X2
    ST1 { V18.2S, V19.2S, V20.2S }, [X13], #24
    MOV  X13, X2
    LD1 { V22.2S, V23.2S, V24.2S }, [X13], #24
    ADD  X2, X2, X3
    MOV  X13, X2
    ST1 { V22.4H, V23.4H, V24.4H }, [X13], #24
    MOV  X13, X2
    LD1 { V17.4H, V18.4H, V19.4H }, [X13], #24
    ADD  X2, X2, X3, LSR #0
    MOV  X13, X2
    ST1 { V0.8B, V1.8B, V2.8B }, [X13], #24
    MOV  X13, X2
    LD1 { V0.8B, V1.8B, V2.8B }, [X13], #24
    ADD  X2, X2, X3, LSR #0
    ST1 { V0.16B, V1.16B, V2.16B }, [X2], X7
    LD1 { V4.4S, V5.4S, V6.4S }, [X2], X7
    ADD  X2, X2, X3, ASR #0
    ST1 { V17.16B, V18.16B, V19.16B }, [X2], X7
    LD1 { V0.16B, V1.16B, V2.16B }, [X2], X7
    ADD  X2, X2, X3, ASR #0
    ST1 { V0.2D, V1.2D, V2.2D }, [X2], X7
    LD1 { V17.2D, V18.2D, V19.2D }, [X2], X7
    ADD  X2, X2, X3
    ST1 { V25.4S, V26.4S, V27.4S }, [X2], X7
    LD1 { V22.4S, V23.4S, V24.4S }, [X2], X7
    ADD  X2, X2, X3, ASR #0
    ST1 { V22.8H, V23.8H, V24.8H }, [X2], X7
    LD1 { V22.8H, V23.8H, V24.8H }, [X2], X7
    ADD  X2, X2, X3, ASR #0
    ST1 { V22.1D, V23.1D, V24.1D }, [X2], X7
    LD1 { V22.8B, V23.8B, V24.8B }, [X2], X7
    ADD  X2, X2, X3
    ST1 { V22.1D, V23.1D, V24.1D }, [X2], X7
    LD1 { V22.1D, V23.1D, V24.1D }, [X2], X7
    ADD  X2, X2, X3, LSR #0
    ST1 { V17.2S, V18.2S, V19.2S }, [X2], X7
    LD1 { V0.2S, V1.2S, V2.2S }, [X2], X7
    ADD  X2, X2, X3, ASR #0
    ST1 { V22.4H, V23.4H, V24.4H }, [X2], X7
    LD1 { V25.4H, V26.4H, V27.4H }, [X2], X7
    ADD  X2, X2, X3, LSR #0
    ST1 { V0.8B, V1.8B, V2.8B }, [X2], X7
    LD1 { V0.8B, V1.8B, V2.8B }, [X2], X7
    ADD  X2, X2, X3, LSR #0
    MOV  X13, X2
    ST1 { V0.8H, V1.8H }, [X13], #32
    MOV  X13, X2
    LD1 { V18.8H, V19.8H }, [X13], #32
    ADD  X2, X2, X3, LSR #0
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X15
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X22, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X22, FPSR
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V0.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D0
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V1.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D1
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V2.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D2
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V3.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D3
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V4.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D4
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V5.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D5
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V6.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D6
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V7.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D7
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V8.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D8
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V9.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D9
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V10.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D10
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V11.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D11
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V12.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D12
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V13.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D13
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V14.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D14
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V15.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D15
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V16.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D16
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V17.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D17
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V18.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D18
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V19.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D19
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V20.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D20
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V21.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D21
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V22.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D22
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V23.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D23
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V24.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D24
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V25.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D25
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V26.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D26
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X22, V27.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D27
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V28.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D28
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V29.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D29
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V30.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D30
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, V31.D[1]
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X22, D31
    SUB  X20, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X27
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X24
    FMOV  V2.D[1], X4
    FMOV  D3, X28
    FMOV  V3.D[1], X28
    FMOV  D4, X13
    FMOV  V4.D[1], X14
    FMOV  D5, X24
    FMOV  V5.D[1], X24
    FMOV  D6, X28
    FMOV  V6.D[1], X22
    FMOV  D7, X5
    FMOV  V7.D[1], X27
    FMOV  D8, X11
    FMOV  V8.D[1], X14
    FMOV  D9, X10
    FMOV  V9.D[1], X19
    FMOV  D10, X13
    FMOV  V10.D[1], X24
    FMOV  D11, X24
    FMOV  V11.D[1], X4
    FMOV  D12, X28
    FMOV  V12.D[1], X22
    FMOV  D13, X4
    FMOV  V13.D[1], X4
    FMOV  D14, X2
    FMOV  V14.D[1], X26
    FMOV  D15, X12
    FMOV  V15.D[1], X28
    FMOV  D16, X17
    FMOV  V16.D[1], X26
    FMOV  D17, X27
    FMOV  V17.D[1], X2
    FMOV  D18, X26
    FMOV  V18.D[1], X28
    FMOV  D19, X7
    FMOV  V19.D[1], X4
    FMOV  D20, X6
    FMOV  V20.D[1], X26
    FMOV  D21, X14
    FMOV  V21.D[1], X5
    FMOV  D22, X13
    FMOV  V22.D[1], X17
    FMOV  D23, X22
    FMOV  V23.D[1], X10
    FMOV  D24, X10
    FMOV  V24.D[1], X24
    FMOV  D25, X28
    FMOV  V25.D[1], X20
    FMOV  D26, X15
    FMOV  V26.D[1], X10
    FMOV  D27, X8
    FMOV  V27.D[1], X3
    FMOV  D28, X8
    FMOV  V28.D[1], X24
    FMOV  D29, X28
    FMOV  V29.D[1], X28
    FMOV  D30, X12
    FMOV  V30.D[1], X6
    FMOV  D31, X2
    FMOV  V31.D[1], X5
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X10, #0x1400, LSL #0
    ADD  X22, X30, X10
    ST1 { V25.2D }, [X22], X11
    LD1 { V2.4S }, [X22], X11
    ADD  X22, X22, X24, LSR #0
    ST1 { V2.16B }, [X22], X11
    LD1 { V10.16B }, [X22], X11
    ADD  X22, X22, X24, LSR #0
    ST1 { V29.2D }, [X22], X11
    LD1 { V6.2D }, [X22], X11
    ADD  X22, X22, X24
    ST1 { V30.4S }, [X22], X11
    LD1 { V20.4S }, [X22], X11
    ADD  X22, X22, X24, LSR #0
    ST1 { V26.8H }, [X22], X11
    LD1 { V19.8H }, [X22], X11
    ADD  X22, X22, X24
    ST1 { V10.4H }, [X22], X11
    LD1 { V30.8B }, [X22], X11
    ADD  X22, X22, X24
    ST1 { V31.1D }, [X22], X11
    LD1 { V23.1D }, [X22], X11
    ADD  X22, X22, X24, LSR #0
    ST1 { V20.2S }, [X22], X11
    LD1 { V4.2S }, [X22], X11
    ADD  X22, X22, X24, LSR #0
    ST1 { V30.4H }, [X22], X11
    LD1 { V22.4H }, [X22], X11
    ADD  X22, X22, X24, ASR #0
    ST1 { V22.8B }, [X22], X11
    LD1 { V4.8B }, [X22], X11
    ADD  X22, X22, X24, ASR #0
    MOV  X26, X22
    ST1 { V9.16B, V10.16B, V11.16B }, [X26], #48
    MOV  X26, X22
    LD1 { V24.16B, V25.16B, V26.16B }, [X26], #48
    ADD  X22, X22, X24, ASR #0
    MOV  X26, X22
    ST1 { V25.16B, V26.16B, V27.16B }, [X26], #48
    MOV  X26, X22
    LD1 { V22.16B, V23.16B, V24.16B }, [X26], #48
    ADD  X22, X22, X24, LSR #0
    MOV  X26, X22
    ST1 { V5.2D, V6.2D, V7.2D }, [X26], #48
    MOV  X26, X22
    LD1 { V17.2D, V18.2D, V19.2D }, [X26], #48
    ADD  X22, X22, X24
    MOV  X26, X22
    ST1 { V17.4S, V18.4S, V19.4S }, [X26], #48
    MOV  X26, X22
    LD1 { V17.4S, V18.4S, V19.4S }, [X26], #48
    ADD  X22, X22, X24, LSR #0
    MOV  X26, X22
    ST1 { V22.8H, V23.8H, V24.8H }, [X26], #48
    MOV  X26, X22
    LD1 { V5.8H, V6.8H, V7.8H }, [X26], #48
    ADD  X22, X22, X24
    MOV  X26, X22
    ST1 { V5.4H, V6.4H, V7.4H }, [X26], #24
    MOV  X26, X22
    LD1 { V22.8B, V23.8B, V24.8B }, [X26], #24
    ADD  X22, X22, X24
    MOV  X26, X22
    ST1 { V22.1D, V23.1D, V24.1D }, [X26], #24
    MOV  X26, X22
    LD1 { V5.1D, V6.1D, V7.1D }, [X26], #24
    ADD  X22, X22, X24, ASR #0
    MOV  X26, X22
    ST1 { V5.2S, V6.2S, V7.2S }, [X26], #24
    MOV  X26, X22
    LD1 { V22.2S, V23.2S, V24.2S }, [X26], #24
    ADD  X22, X22, X24, LSR #0
    MOV  X26, X22
    ST1 { V22.4H, V23.4H, V24.4H }, [X26], #24
    MOV  X26, X22
    LD1 { V5.4H, V6.4H, V7.4H }, [X26], #24
    ADD  X22, X22, X24, LSR #0
    MOV  X26, X22
    ST1 { V5.8B, V6.8B, V7.8B }, [X26], #24
    MOV  X26, X22
    LD1 { V22.8B, V23.8B, V24.8B }, [X26], #24
    ADD  X22, X22, X24
    ST1 { V22.4S, V23.4S, V24.4S }, [X22], X11
    LD1 { V22.2D, V23.2D, V24.2D }, [X22], X11
    ADD  X22, X22, X24
    ST1 { V27.16B, V28.16B, V29.16B }, [X22], X11
    LD1 { V5.16B, V6.16B, V7.16B }, [X22], X11
    ADD  X22, X22, X24, ASR #0
    ST1 { V13.2D, V14.2D, V15.2D }, [X22], X11
    LD1 { V27.2D, V28.2D, V29.2D }, [X22], X11
    ADD  X22, X22, X24, LSR #0
    ST1 { V10.4S, V11.4S, V12.4S }, [X22], X11
    LD1 { V30.4S, V31.4S, V0.4S }, [X22], X11
    ADD  X22, X22, X24, ASR #0
    ST1 { V30.8H, V31.8H, V0.8H }, [X22], X11
    LD1 { V10.8H, V11.8H, V12.8H }, [X22], X11
    ADD  X22, X22, X24, LSR #0
    ST1 { V27.2S, V28.2S, V29.2S }, [X22], X11
    LD1 { V29.2S, V30.2S, V31.2S }, [X22], X11
    ADD  X22, X22, X24, ASR #0
    ST1 { V5.1D, V6.1D, V7.1D }, [X22], X11
    LD1 { V22.1D, V23.1D, V24.1D }, [X22], X11
    ADD  X22, X22, X24, LSR #0
    ST1 { V10.2S, V11.2S, V12.2S }, [X22], X11
    LD1 { V4.2S, V5.2S, V6.2S }, [X22], X11
    ADD  X22, X22, X24
    ST1 { V8.4H, V9.4H, V10.4H }, [X22], X11
    LD1 { V24.4H, V25.4H, V26.4H }, [X22], X11
    ADD  X22, X22, X24, ASR #0
    ST1 { V24.8B, V25.8B, V26.8B }, [X22], X11
    LD1 { V9.8B, V10.8B, V11.8B }, [X22], X11
    ADD  X22, X22, X24, ASR #0
    MOV  X26, X22
    ST1 { V9.8H, V10.8H }, [X26], #32
    MOV  X26, X22
    LD1 { V10.4S, V11.4S }, [X26], #32
    ADD  X22, X22, X24, ASR #0
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X13, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V0.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D0
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V1.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D1
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V2.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D2
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V3.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D3
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D4
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D5
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D6
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V7.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D7
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V8.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D8
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D9
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D10
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D11
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V12.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D12
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V13.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D13
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V14.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D14
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V15.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D15
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V16.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D16
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V17.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D17
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V18.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D18
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V19.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D19
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V20.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D20
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V21.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D21
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D22
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D23
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D24
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D25
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D26
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V27.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D27
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, V28.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D28
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D29
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D30
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X13, D31
    SUB  X23, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X23
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X20
    FMOV  D3, X12
    FMOV  V3.D[1], X4
    FMOV  D4, X4
    FMOV  V4.D[1], X16
    FMOV  D5, X6
    FMOV  V5.D[1], X22
    FMOV  D6, X5
    FMOV  V6.D[1], X2
    FMOV  D7, X28
    FMOV  V7.D[1], X22
    FMOV  D8, X8
    FMOV  V8.D[1], X4
    FMOV  D9, X19
    FMOV  V9.D[1], X9
    FMOV  D10, X8
    FMOV  V10.D[1], X12
    FMOV  D11, X15
    FMOV  V11.D[1], X23
    FMOV  D12, X2
    FMOV  V12.D[1], X27
    FMOV  D13, X19
    FMOV  V13.D[1], X27
    FMOV  D14, X4
    FMOV  V14.D[1], X7
    FMOV  D15, X17
    FMOV  V15.D[1], X7
    FMOV  D16, X23
    FMOV  V16.D[1], X5
    FMOV  D17, X13
    FMOV  V17.D[1], X17
    FMOV  D18, X10
    FMOV  V18.D[1], X14
    FMOV  D19, X4
    FMOV  V19.D[1], X15
    FMOV  D20, X28
    FMOV  V20.D[1], X24
    FMOV  D21, X16
    FMOV  V21.D[1], X19
    FMOV  D22, X8
    FMOV  V22.D[1], X6
    FMOV  D23, X23
    FMOV  V23.D[1], X23
    FMOV  D24, X28
    FMOV  V24.D[1], X24
    FMOV  D25, X5
    FMOV  V25.D[1], X11
    FMOV  D26, X5
    FMOV  V26.D[1], X14
    FMOV  D27, X12
    FMOV  V27.D[1], X23
    FMOV  D28, X4
    FMOV  V28.D[1], X3
    FMOV  D29, X12
    FMOV  V29.D[1], X15
    FMOV  D30, X16
    FMOV  V30.D[1], X4
    FMOV  D31, X8
    FMOV  V31.D[1], X15
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X11, #0x1900, LSL #0
    ADD  X2, X30, X11, ASR #0
    ST1 { V29.8H }, [X2], X22
    LD1 { V5.4S }, [X2], X22
    ADD  X2, X2, X3
    ST1 { V24.16B }, [X2], X22
    LD1 { V8.16B }, [X2], X22
    ADD  X2, X2, X3, ASR #0
    ST1 { V23.2D }, [X2], X22
    LD1 { V16.2D }, [X2], X22
    ADD  X2, X2, X3, ASR #0
    ST1 { V25.4S }, [X2], X22
    LD1 { V31.4S }, [X2], X22
    ADD  X2, X2, X3, ASR #0
    ST1 { V16.8H }, [X2], X22
    LD1 { V29.8H }, [X2], X22
    ADD  X2, X2, X3
    ST1 { V8.1D }, [X2], X22
    LD1 { V20.4H }, [X2], X22
    ADD  X2, X2, X3, ASR #0
    ST1 { V31.1D }, [X2], X22
    LD1 { V1.1D }, [X2], X22
    ADD  X2, X2, X3
    ST1 { V1.2S }, [X2], X22
    LD1 { V15.2S }, [X2], X22
    ADD  X2, X2, X3, LSR #0
    ST1 { V29.4H }, [X2], X22
    LD1 { V3.4H }, [X2], X22
    ADD  X2, X2, X3, ASR #0
    ST1 { V20.8B }, [X2], X22
    LD1 { V17.8B }, [X2], X22
    ADD  X2, X2, X3, LSR #0
    MOV  X15, X2
    ST1 { V27.2D, V28.2D, V29.2D }, [X15], #48
    MOV  X15, X2
    LD1 { V20.2D, V21.2D, V22.2D }, [X15], #48
    ADD  X2, X2, X3
    MOV  X15, X2
    ST1 { V3.16B, V4.16B, V5.16B }, [X15], #48
    MOV  X15, X2
    LD1 { V11.16B, V12.16B, V13.16B }, [X15], #48
    ADD  X2, X2, X3
    MOV  X15, X2
    ST1 { V20.2D, V21.2D, V22.2D }, [X15], #48
    MOV  X15, X2
    LD1 { V5.2D, V6.2D, V7.2D }, [X15], #48
    ADD  X2, X2, X3, ASR #0
    MOV  X15, X2
    ST1 { V11.4S, V12.4S, V13.4S }, [X15], #48
    MOV  X15, X2
    LD1 { V19.4S, V20.4S, V21.4S }, [X15], #48
    ADD  X2, X2, X3
    MOV  X15, X2
    ST1 { V19.8H, V20.8H, V21.8H }, [X15], #48
    MOV  X15, X2
    LD1 { V29.8H, V30.8H, V31.8H }, [X15], #48
    ADD  X2, X2, X3, ASR #0
    MOV  X15, X2
    ST1 { V7.1D, V8.1D, V9.1D }, [X15], #24
    MOV  X15, X2
    LD1 { V31.2S, V0.2S, V1.2S }, [X15], #24
    ADD  X2, X2, X3, LSR #0
    MOV  X15, X2
    ST1 { V31.1D, V0.1D, V1.1D }, [X15], #24
    MOV  X15, X2
    LD1 { V11.1D, V12.1D, V13.1D }, [X15], #24
    ADD  X2, X2, X3, LSR #0
    MOV  X15, X2
    ST1 { V11.2S, V12.2S, V13.2S }, [X15], #24
    MOV  X15, X2
    LD1 { V11.2S, V12.2S, V13.2S }, [X15], #24
    ADD  X2, X2, X3, LSR #0
    MOV  X15, X2
    ST1 { V11.4H, V12.4H, V13.4H }, [X15], #24
    MOV  X15, X2
    LD1 { V11.4H, V12.4H, V13.4H }, [X15], #24
    ADD  X2, X2, X3, ASR #0
    MOV  X15, X2
    ST1 { V11.8B, V12.8B, V13.8B }, [X15], #24
    MOV  X15, X2
    LD1 { V31.8B, V0.8B, V1.8B }, [X15], #24
    ADD  X2, X2, X3, LSR #0
    ST1 { V31.4S, V0.4S, V1.4S }, [X2], X22
    LD1 { V31.2D, V0.2D, V1.2D }, [X2], X22
    ADD  X2, X2, X3
    ST1 { V31.16B, V0.16B, V1.16B }, [X2], X22
    LD1 { V11.16B, V12.16B, V13.16B }, [X2], X22
    ADD  X2, X2, X3, ASR #0
    ST1 { V11.2D, V12.2D, V13.2D }, [X2], X22
    LD1 { V31.2D, V0.2D, V1.2D }, [X2], X22
    ADD  X2, X2, X3
    ST1 { V1.4S, V2.4S, V3.4S }, [X2], X22
    LD1 { V11.4S, V12.4S, V13.4S }, [X2], X22
    ADD  X2, X2, X3, ASR #0
    ST1 { V30.8H, V31.8H, V0.8H }, [X2], X22
    LD1 { V30.8H, V31.8H, V0.8H }, [X2], X22
    ADD  X2, X2, X3
    ST1 { V17.2S, V18.2S, V19.2S }, [X2], X22
    LD1 { V17.1D, V18.1D, V19.1D }, [X2], X22
    ADD  X2, X2, X3, ASR #0
    ST1 { V30.1D, V31.1D, V0.1D }, [X2], X22
    LD1 { V1.1D, V2.1D, V3.1D }, [X2], X22
    ADD  X2, X2, X3
    ST1 { V17.2S, V18.2S, V19.2S }, [X2], X22
    LD1 { V30.2S, V31.2S, V0.2S }, [X2], X22
    ADD  X2, X2, X3, LSR #0
    ST1 { V11.4H, V12.4H, V13.4H }, [X2], X22
    LD1 { V11.4H, V12.4H, V13.4H }, [X2], X22
    ADD  X2, X2, X3, ASR #0
    ST1 { V1.8B, V2.8B, V3.8B }, [X2], X22
    LD1 { V17.8B, V18.8B, V19.8B }, [X2], X22
    ADD  X2, X2, X3, LSR #0
    MOV  X15, X2
    ST1 { V17.2D, V18.2D }, [X15], #32
    MOV  X15, X2
    LD1 { V2.16B, V3.16B }, [X15], #32
    ADD  X2, X2, X3, ASR #0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X28, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V0.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D0
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D1
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D2
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D3
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V4.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D4
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D5
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D6
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V7.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D7
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V8.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D8
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D9
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D10
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D11
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D12
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D13
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V14.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D14
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D15
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D16
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V17.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D18
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D19
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V20.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D20
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V21.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D21
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D22
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D23
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D24
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D25
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D26
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D27
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, V28.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D28
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D29
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D30
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X28, V31.D[1]
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X28, D31
    SUB  X24, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X23
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X24
    FMOV  V2.D[1], X15
    FMOV  D3, X19
    FMOV  V3.D[1], X11
    FMOV  D4, X22
    FMOV  V4.D[1], X10
    FMOV  D5, X13
    FMOV  V5.D[1], X12
    FMOV  D6, X11
    FMOV  V6.D[1], X26
    FMOV  D7, X27
    FMOV  V7.D[1], X2
    FMOV  D8, X9
    FMOV  V8.D[1], X8
    FMOV  D9, X3
    FMOV  V9.D[1], X8
    FMOV  D10, X15
    FMOV  V10.D[1], X26
    FMOV  D11, X15
    FMOV  V11.D[1], X10
    FMOV  D12, X10
    FMOV  V12.D[1], X8
    FMOV  D13, X12
    FMOV  V13.D[1], X17
    FMOV  D14, X15
    FMOV  V14.D[1], X14
    FMOV  D15, X17
    FMOV  V15.D[1], X14
    FMOV  D16, X9
    FMOV  V16.D[1], X27
    FMOV  D17, X3
    FMOV  V17.D[1], X15
    FMOV  D18, X13
    FMOV  V18.D[1], X7
    FMOV  D19, X11
    FMOV  V19.D[1], X17
    FMOV  D20, X2
    FMOV  V20.D[1], X28
    FMOV  D21, X9
    FMOV  V21.D[1], X6
    FMOV  D22, X3
    FMOV  V22.D[1], X15
    FMOV  D23, X24
    FMOV  V23.D[1], X5
    FMOV  D24, X8
    FMOV  V24.D[1], X12
    FMOV  D25, X3
    FMOV  V25.D[1], X4
    FMOV  D26, X3
    FMOV  V26.D[1], X3
    FMOV  D27, X7
    FMOV  V27.D[1], X26
    FMOV  D28, X28
    FMOV  V28.D[1], X11
    FMOV  D29, X6
    FMOV  V29.D[1], X9
    FMOV  D30, X26
    FMOV  V30.D[1], X17
    FMOV  D31, X27
    FMOV  V31.D[1], X10
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X4, #0x1e00, LSL #0
    ADD  X16, X30, X4, ASR #0
    ST1 { V24.16B }, [X16], X12
    LD1 { V29.2D }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V27.16B }, [X16], X12
    LD1 { V12.16B }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V25.2D }, [X16], X12
    LD1 { V26.2D }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V29.4S }, [X16], X12
    LD1 { V6.4S }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V12.8H }, [X16], X12
    LD1 { V16.8H }, [X16], X12
    ADD  X16, X16, X26, LSR #0
    ST1 { V16.8B }, [X16], X12
    LD1 { V12.1D }, [X16], X12
    ADD  X16, X16, X26, LSR #0
    ST1 { V28.1D }, [X16], X12
    LD1 { V23.1D }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V23.2S }, [X16], X12
    LD1 { V5.2S }, [X16], X12
    ADD  X16, X16, X26
    ST1 { V12.4H }, [X16], X12
    LD1 { V18.4H }, [X16], X12
    ADD  X16, X16, X26
    ST1 { V6.8B }, [X16], X12
    LD1 { V27.8B }, [X16], X12
    ADD  X16, X16, X26
    MOV  X7, X16
    ST1 { V3.16B, V4.16B, V5.16B }, [X7], #48
    MOV  X7, X16
    LD1 { V0.16B, V1.16B, V2.16B }, [X7], #48
    ADD  X16, X16, X26, LSR #0
    MOV  X7, X16
    ST1 { V0.16B, V1.16B, V2.16B }, [X7], #48
    MOV  X7, X16
    LD1 { V24.16B, V25.16B, V26.16B }, [X7], #48
    ADD  X16, X16, X26
    MOV  X7, X16
    ST1 { V16.2D, V17.2D, V18.2D }, [X7], #48
    MOV  X7, X16
    LD1 { V14.2D, V15.2D, V16.2D }, [X7], #48
    ADD  X16, X16, X26, LSR #0
    MOV  X7, X16
    ST1 { V14.4S, V15.4S, V16.4S }, [X7], #48
    MOV  X7, X16
    LD1 { V0.4S, V1.4S, V2.4S }, [X7], #48
    ADD  X16, X16, X26, ASR #0
    MOV  X7, X16
    ST1 { V24.8H, V25.8H, V26.8H }, [X7], #48
    MOV  X7, X16
    LD1 { V14.8H, V15.8H, V16.8H }, [X7], #48
    ADD  X16, X16, X26
    MOV  X7, X16
    ST1 { V3.4H, V4.4H, V5.4H }, [X7], #24
    MOV  X7, X16
    LD1 { V24.1D, V25.1D, V26.1D }, [X7], #24
    ADD  X16, X16, X26, ASR #0
    MOV  X7, X16
    ST1 { V14.1D, V15.1D, V16.1D }, [X7], #24
    MOV  X7, X16
    LD1 { V14.1D, V15.1D, V16.1D }, [X7], #24
    ADD  X16, X16, X26
    MOV  X7, X16
    ST1 { V0.2S, V1.2S, V2.2S }, [X7], #24
    MOV  X7, X16
    LD1 { V1.2S, V2.2S, V3.2S }, [X7], #24
    ADD  X16, X16, X26, LSR #0
    MOV  X7, X16
    ST1 { V24.4H, V25.4H, V26.4H }, [X7], #24
    MOV  X7, X16
    LD1 { V24.4H, V25.4H, V26.4H }, [X7], #24
    ADD  X16, X16, X26, LSR #0
    MOV  X7, X16
    ST1 { V14.8B, V15.8B, V16.8B }, [X7], #24
    MOV  X7, X16
    LD1 { V14.8B, V15.8B, V16.8B }, [X7], #24
    ADD  X16, X16, X26
    ST1 { V1.8H, V2.8H, V3.8H }, [X16], X12
    LD1 { V1.8H, V2.8H, V3.8H }, [X16], X12
    ADD  X16, X16, X26
    ST1 { V1.16B, V2.16B, V3.16B }, [X16], X12
    LD1 { V30.16B, V31.16B, V0.16B }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V14.2D, V15.2D, V16.2D }, [X16], X12
    LD1 { V1.2D, V2.2D, V3.2D }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V30.4S, V31.4S, V0.4S }, [X16], X12
    LD1 { V14.4S, V15.4S, V16.4S }, [X16], X12
    ADD  X16, X16, X26, LSR #0
    ST1 { V1.8H, V2.8H, V3.8H }, [X16], X12
    LD1 { V30.8H, V31.8H, V0.8H }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V14.4H, V15.4H, V16.4H }, [X16], X12
    LD1 { V14.8B, V15.8B, V16.8B }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V30.1D, V31.1D, V0.1D }, [X16], X12
    LD1 { V1.1D, V2.1D, V3.1D }, [X16], X12
    ADD  X16, X16, X26, ASR #0
    ST1 { V14.2S, V15.2S, V16.2S }, [X16], X12
    LD1 { V14.2S, V15.2S, V16.2S }, [X16], X12
    ADD  X16, X16, X26
    ST1 { V14.4H, V15.4H, V16.4H }, [X16], X12
    LD1 { V14.4H, V15.4H, V16.4H }, [X16], X12
    ADD  X16, X16, X26, LSR #0
    ST1 { V1.8B, V2.8B, V3.8B }, [X16], X12
    LD1 { V1.8B, V2.8B, V3.8B }, [X16], X12
    ADD  X16, X16, X26, LSR #0
    MOV  X7, X16
    ST1 { V15.16B, V16.16B }, [X7], #32
    MOV  X7, X16
    LD1 { V15.2D, V16.2D }, [X7], #32
    ADD  X16, X16, X26, ASR #0
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X6, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    MRS  X6, FPSR
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D0
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V1.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D1
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V2.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D2
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V3.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D3
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V4.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D4
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D5
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V6.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D6
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V7.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D7
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V8.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D8
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V9.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D9
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V10.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D10
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V11.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D11
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V12.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D12
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V13.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D13
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V14.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D14
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D15
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D16
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V17.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D17
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D18
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V19.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D19
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V20.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D20
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V21.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D21
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V22.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D22
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D23
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V24.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D24
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V25.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D25
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V26.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D26
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V27.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D27
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V28.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D28
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, V29.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D29
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V30.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D30
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x0, LSL #0
    FMOV  X6, V31.D[1]
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    FMOV  X6, D31
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X28
    FMOV  V0.D[1], X20
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X24
    FMOV  V2.D[1], X23
    FMOV  D3, X24
    FMOV  V3.D[1], X24
    FMOV  D4, X23
    FMOV  V4.D[1], X10
    FMOV  D5, X13
    FMOV  V5.D[1], X11
    FMOV  D6, X17
    FMOV  V6.D[1], X27
    FMOV  D7, X8
    FMOV  V7.D[1], X23
    FMOV  D8, X9
    FMOV  V8.D[1], X13
    FMOV  D9, X16
    FMOV  V9.D[1], X3
    FMOV  D10, X10
    FMOV  V10.D[1], X3
    FMOV  D11, X27
    FMOV  V11.D[1], X5
    FMOV  D12, X10
    FMOV  V12.D[1], X17
    FMOV  D13, X24
    FMOV  V13.D[1], X11
    FMOV  D14, X22
    FMOV  V14.D[1], X19
    FMOV  D15, X28
    FMOV  V15.D[1], X2
    FMOV  D16, X13
    FMOV  V16.D[1], X13
    FMOV  D17, X22
    FMOV  V17.D[1], X11
    FMOV  D18, X26
    FMOV  V18.D[1], X10
    FMOV  D19, X26
    FMOV  V19.D[1], X26
    FMOV  D20, X28
    FMOV  V20.D[1], X16
    FMOV  D21, X5
    FMOV  V21.D[1], X14
    FMOV  D22, X14
    FMOV  V22.D[1], X23
    FMOV  D23, X20
    FMOV  V23.D[1], X10
    FMOV  D24, X13
    FMOV  V24.D[1], X19
    FMOV  D25, X13
    FMOV  V25.D[1], X19
    FMOV  D26, X2
    FMOV  V26.D[1], X10
    FMOV  D27, X23
    FMOV  V27.D[1], X24
    FMOV  D28, X17
    FMOV  V28.D[1], X4
    FMOV  D29, X13
    FMOV  V29.D[1], X6
    FMOV  D30, X14
    FMOV  V30.D[1], X9
    FMOV  D31, X8
    FMOV  V31.D[1], X13
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X11, #0x40, LSL #0
    MOVZ  X7, #0x2300, LSL #0
    ADD  X27, X30, X7, LSR #0
    ST1 { V31.8H }, [X27], X26
    LD1 { V18.2D }, [X27], X26
    ADD  X27, X27, X11, ASR #0
    ST1 { V26.16B }, [X27], X26
    LD1 { V28.16B }, [X27], X26
    ADD  X27, X27, X11, LSR #0
    ST1 { V27.2D }, [X27], X26
    LD1 { V25.2D }, [X27], X26
    ADD  X27, X27, X11, LSR #0
    ST1 { V18.4S }, [X27], X26
    LD1 { V10.4S }, [X27], X26
    ADD  X27, X27, X11
    ST1 { V10.8H }, [X27], X26
    LD1 { V11.8H }, [X27], X26
    ADD  X27, X27, X11, LSR #0
    ST1 { V25.1D }, [X27], X26
    LD1 { V11.1D }, [X27], X26
    ADD  X27, X27, X11, LSR #0
    ST1 { V11.1D }, [X27], X26
    LD1 { V17.1D }, [X27], X26
    ADD  X27, X27, X11, LSR #0
    ST1 { V28.2S }, [X27], X26
    LD1 { V17.2S }, [X27], X26
    ADD  X27, X27, X11, LSR #0
    ST1 { V17.4H }, [X27], X26
    LD1 { V30.4H }, [X27], X26
    ADD  X27, X27, X11, ASR #0
    ST1 { V8.8B }, [X27], X26
    LD1 { V4.8B }, [X27], X26
    ADD  X27, X27, X11
    MOV  X19, X27
    ST1 { V20.2D, V21.2D, V22.2D }, [X19], #48
    MOV  X19, X27
    LD1 { V22.16B, V23.16B, V24.16B }, [X19], #48
    ADD  X27, X27, X11, ASR #0
    MOV  X19, X27
    ST1 { V6.16B, V7.16B, V8.16B }, [X19], #48
    MOV  X19, X27
    LD1 { V27.16B, V28.16B, V29.16B }, [X19], #48
    ADD  X27, X27, X11
    MOV  X19, X27
    ST1 { V24.2D, V25.2D, V26.2D }, [X19], #48
    MOV  X19, X27
    LD1 { V23.2D, V24.2D, V25.2D }, [X19], #48
    ADD  X27, X27, X11, ASR #0
    MOV  X19, X27
    ST1 { V22.4S, V23.4S, V24.4S }, [X19], #48
    MOV  X19, X27
    LD1 { V2.4S, V3.4S, V4.4S }, [X19], #48
    ADD  X27, X27, X11, LSR #0
    MOV  X19, X27
    ST1 { V27.8H, V28.8H, V29.8H }, [X19], #48
    MOV  X19, X27
    LD1 { V16.8H, V17.8H, V18.8H }, [X19], #48
    ADD  X27, X27, X11
    MOV  X19, X27
    ST1 { V22.2S, V23.2S, V24.2S }, [X19], #24
    MOV  X19, X27
    LD1 { V18.1D, V19.1D, V20.1D }, [X19], #24
    ADD  X27, X27, X11
    MOV  X19, X27
    ST1 { V11.1D, V12.1D, V13.1D }, [X19], #24
    MOV  X19, X27
    LD1 { V1.1D, V2.1D, V3.1D }, [X19], #24
    ADD  X27, X27, X11, LSR #0
    MOV  X19, X27
    ST1 { V17.2S, V18.2S, V19.2S }, [X19], #24
    MOV  X19, X27
    LD1 { V27.2S, V28.2S, V29.2S }, [X19], #24
    ADD  X27, X27, X11, ASR #0
    MOV  X19, X27
    ST1 { V27.4H, V28.4H, V29.4H }, [X19], #24
    MOV  X19, X27
    LD1 { V17.4H, V18.4H, V19.4H }, [X19], #24
    ADD  X27, X27, X11, LSR #0
    MOV  X19, X27
    ST1 { V1.8B, V2.8B, V3.8B }, [X19], #24
    MOV  X19, X27
    LD1 { V27.8B, V28.8B, V29.8B }, [X19], #24
    ADD  X27, X27, X11, ASR #0
    ST1 { V17.16B, V18.16B, V19.16B }, [X27], X26
    LD1 { V1.4S, V2.4S, V3.4S }, [X27], X26
    ADD  X27, X27, X11, ASR #0
    ST1 { V1.16B, V2.16B, V3.16B }, [X27], X26
    LD1 { V17.16B, V18.16B, V19.16B }, [X27], X26
    ADD  X27, X27, X11, ASR #0
    ST1 { V27.2D, V28.2D, V29.2D }, [X27], X26
    LD1 { V27.2D, V28.2D, V29.2D }, [X27], X26
    ADD  X27, X27, X11
    ST1 { V17.4S, V18.4S, V19.4S }, [X27], X26
    LD1 { V17.4S, V18.4S, V19.4S }, [X27], X26
    ADD  X27, X27, X11, ASR #0
    ST1 { V27.8H, V28.8H, V29.8H }, [X27], X26
    LD1 { V27.8H, V28.8H, V29.8H }, [X27], X26
    ADD  X27, X27, X11
    ST1 { V27.8B, V28.8B, V29.8B }, [X27], X26
    LD1 { V27.1D, V28.1D, V29.1D }, [X27], X26
    ADD  X27, X27, X11
    ST1 { V17.1D, V18.1D, V19.1D }, [X27], X26
    LD1 { V1.1D, V2.1D, V3.1D }, [X27], X26
    ADD  X27, X27, X11
    ST1 { V27.2S, V28.2S, V29.2S }, [X27], X26
    LD1 { V18.2S, V19.2S, V20.2S }, [X27], X26
    ADD  X27, X27, X11
    ST1 { V1.4H, V2.4H, V3.4H }, [X27], X26
    LD1 { V2.4H, V3.4H, V4.4H }, [X27], X26
    ADD  X27, X27, X11, ASR #0
    ST1 { V2.8B, V3.8B, V4.8B }, [X27], X26
    LD1 { V2.8B, V3.8B, V4.8B }, [X27], X26
    ADD  X27, X27, X11, ASR #0
    MOV  X19, X27
    ST1 { V2.2D, V3.2D }, [X19], #32
    MOV  X19, X27
    LD1 { V29.8H, V30.8H }, [X19], #32
    ADD  X27, X27, X11
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X16, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V0.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D0
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V1.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D1
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V2.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D2
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V3.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D3
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V4.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D4
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D5
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V6.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D6
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V7.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D7
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D8
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D9
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V10.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D10
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D11
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D12
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V13.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D13
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V14.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D14
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D15
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V16.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D16
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D17
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D18
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D19
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D20
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D21
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D22
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V23.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D23
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V24.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D24
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V25.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D25
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V26.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D26
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D27
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D28
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D29
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D30
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, V31.D[1]
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    FMOV  X16, D31
    SUB  X6, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X27
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X17
    FMOV  V2.D[1], X24
    FMOV  D3, X22
    FMOV  V3.D[1], X4
    FMOV  D4, X23
    FMOV  V4.D[1], X23
    FMOV  D5, X15
    FMOV  V5.D[1], X28
    FMOV  D6, X16
    FMOV  V6.D[1], X2
    FMOV  D7, X11
    FMOV  V7.D[1], X5
    FMOV  D8, X7
    FMOV  V8.D[1], X10
    FMOV  D9, X5
    FMOV  V9.D[1], X22
    FMOV  D10, X28
    FMOV  V10.D[1], X12
    FMOV  D11, X8
    FMOV  V11.D[1], X11
    FMOV  D12, X2
    FMOV  V12.D[1], X26
    FMOV  D13, X27
    FMOV  V13.D[1], X23
    FMOV  D14, X4
    FMOV  V14.D[1], X6
    FMOV  D15, X10
    FMOV  V15.D[1], X28
    FMOV  D16, X10
    FMOV  V16.D[1], X8
    FMOV  D17, X4
    FMOV  V17.D[1], X26
    FMOV  D18, X16
    FMOV  V18.D[1], X3
    FMOV  D19, X26
    FMOV  V19.D[1], X23
    FMOV  D20, X17
    FMOV  V20.D[1], X23
    FMOV  D21, X28
    FMOV  V21.D[1], X17
    FMOV  D22, X26
    FMOV  V22.D[1], X7
    FMOV  D23, X15
    FMOV  V23.D[1], X3
    FMOV  D24, X9
    FMOV  V24.D[1], X14
    FMOV  D25, X24
    FMOV  V25.D[1], X15
    FMOV  D26, X4
    FMOV  V26.D[1], X8
    FMOV  D27, X15
    FMOV  V27.D[1], X23
    FMOV  D28, X15
    FMOV  V28.D[1], X26
    FMOV  D29, X20
    FMOV  V29.D[1], X4
    FMOV  D30, X19
    FMOV  V30.D[1], X19
    FMOV  D31, X22
    FMOV  V31.D[1], X12
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X14, #0x2800, LSL #0
    ADD  X4, X30, X14, LSR #0
    ST1 { V24.4S }, [X4], X9
    LD1 { V0.2D }, [X4], X9
    ADD  X4, X4, X2, ASR #0
    ST1 { V30.16B }, [X4], X9
    LD1 { V11.16B }, [X4], X9
    ADD  X4, X4, X2, LSR #0
    ST1 { V11.2D }, [X4], X9
    LD1 { V26.2D }, [X4], X9
    ADD  X4, X4, X2, ASR #0
    ST1 { V26.4S }, [X4], X9
    LD1 { V16.4S }, [X4], X9
    ADD  X4, X4, X2
    ST1 { V0.8H }, [X4], X9
    LD1 { V14.8H }, [X4], X9
    ADD  X4, X4, X2, ASR #0
    ST1 { V31.8B }, [X4], X9
    LD1 { V6.2S }, [X4], X9
    ADD  X4, X4, X2
    ST1 { V16.1D }, [X4], X9
    LD1 { V10.1D }, [X4], X9
    ADD  X4, X4, X2, LSR #0
    ST1 { V10.2S }, [X4], X9
    LD1 { V14.2S }, [X4], X9
    ADD  X4, X4, X2
    ST1 { V14.4H }, [X4], X9
    LD1 { V10.4H }, [X4], X9
    ADD  X4, X4, X2, LSR #0
    ST1 { V7.8B }, [X4], X9
    LD1 { V12.8B }, [X4], X9
    ADD  X4, X4, X2
    MOV  X10, X4
    ST1 { V28.8H, V29.8H, V30.8H }, [X10], #48
    MOV  X10, X4
    LD1 { V21.2D, V22.2D, V23.2D }, [X10], #48
    ADD  X4, X4, X2, LSR #0
    MOV  X10, X4
    ST1 { V22.16B, V23.16B, V24.16B }, [X10], #48
    MOV  X10, X4
    LD1 { V16.16B, V17.16B, V18.16B }, [X10], #48
    ADD  X4, X4, X2, ASR #0
    MOV  X10, X4
    ST1 { V1.2D, V2.2D, V3.2D }, [X10], #48
    MOV  X10, X4
    LD1 { V11.2D, V12.2D, V13.2D }, [X10], #48
    ADD  X4, X4, X2, ASR #0
    MOV  X10, X4
    ST1 { V11.4S, V12.4S, V13.4S }, [X10], #48
    MOV  X10, X4
    LD1 { V28.4S, V29.4S, V30.4S }, [X10], #48
    ADD  X4, X4, X2, ASR #0
    MOV  X10, X4
    ST1 { V16.8H, V17.8H, V18.8H }, [X10], #48
    MOV  X10, X4
    LD1 { V22.8H, V23.8H, V24.8H }, [X10], #48
    ADD  X4, X4, X2, ASR #0
    MOV  X10, X4
    ST1 { V28.1D, V29.1D, V30.1D }, [X10], #24
    MOV  X10, X4
    LD1 { V28.4H, V29.4H, V30.4H }, [X10], #24
    ADD  X4, X4, X2
    MOV  X10, X4
    ST1 { V22.1D, V23.1D, V24.1D }, [X10], #24
    MOV  X10, X4
    LD1 { V16.1D, V17.1D, V18.1D }, [X10], #24
    ADD  X4, X4, X2
    MOV  X10, X4
    ST1 { V28.2S, V29.2S, V30.2S }, [X10], #24
    MOV  X10, X4
    LD1 { V22.2S, V23.2S, V24.2S }, [X10], #24
    ADD  X4, X4, X2, ASR #0
    MOV  X10, X4
    ST1 { V16.4H, V17.4H, V18.4H }, [X10], #24
    MOV  X10, X4
    LD1 { V28.4H, V29.4H, V30.4H }, [X10], #24
    ADD  X4, X4, X2, ASR #0
    MOV  X10, X4
    ST1 { V28.8B, V29.8B, V30.8B }, [X10], #24
    MOV  X10, X4
    LD1 { V28.8B, V29.8B, V30.8B }, [X10], #24
    ADD  X4, X4, X2, LSR #0
    ST1 { V22.4S, V23.4S, V24.4S }, [X4], X9
    LD1 { V22.8H, V23.8H, V24.8H }, [X4], X9
    ADD  X4, X4, X2, LSR #0
    ST1 { V28.16B, V29.16B, V30.16B }, [X4], X9
    LD1 { V24.16B, V25.16B, V26.16B }, [X4], X9
    ADD  X4, X4, X2, LSR #0
    ST1 { V24.2D, V25.2D, V26.2D }, [X4], X9
    LD1 { V16.2D, V17.2D, V18.2D }, [X4], X9
    ADD  X4, X4, X2, ASR #0
    ST1 { V16.4S, V17.4S, V18.4S }, [X4], X9
    LD1 { V16.4S, V17.4S, V18.4S }, [X4], X9
    ADD  X4, X4, X2
    ST1 { V24.8H, V25.8H, V26.8H }, [X4], X9
    LD1 { V28.8H, V29.8H, V30.8H }, [X4], X9
    ADD  X4, X4, X2, LSR #0
    ST1 { V28.2S, V29.2S, V30.2S }, [X4], X9
    LD1 { V24.1D, V25.1D, V26.1D }, [X4], X9
    ADD  X4, X4, X2, LSR #0
    ST1 { V21.1D, V22.1D, V23.1D }, [X4], X9
    LD1 { V28.1D, V29.1D, V30.1D }, [X4], X9
    ADD  X4, X4, X2
    ST1 { V24.2S, V25.2S, V26.2S }, [X4], X9
    LD1 { V24.2S, V25.2S, V26.2S }, [X4], X9
    ADD  X4, X4, X2, ASR #0
    ST1 { V24.4H, V25.4H, V26.4H }, [X4], X9
    LD1 { V21.4H, V22.4H, V23.4H }, [X4], X9
    ADD  X4, X4, X2, LSR #0
    ST1 { V28.8B, V29.8B, V30.8B }, [X4], X9
    LD1 { V24.8B, V25.8B, V26.8B }, [X4], X9
    ADD  X4, X4, X2, ASR #0
    MOV  X10, X4
    ST1 { V21.8H, V22.8H }, [X10], #32
    MOV  X10, X4
    LD1 { V29.4S, V30.4S }, [X10], #32
    ADD  X4, X4, X2
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X19
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X5, X15, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    MRS  X5, FPSR
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V0.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D0
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V1.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D1
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V2.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D2
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V3.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D3
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V4.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D4
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V5.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D5
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V6.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D6
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V7.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D7
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V8.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D8
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V9.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D9
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D10
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V11.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D11
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V12.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D12
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V13.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D13
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D14
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V15.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D15
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D16
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V17.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D17
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V18.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D18
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V19.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D19
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V20.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D20
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D21
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V22.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D22
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D23
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V24.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D24
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D25
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D26
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V27.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D27
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V28.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D28
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V29.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D29
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D30
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, V31.D[1]
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    FMOV  X5, D31
    SUB  X12, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X19
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X2
    FMOV  V3.D[1], X15
    FMOV  D4, X17
    FMOV  V4.D[1], X28
    FMOV  D5, X24
    FMOV  V5.D[1], X3
    FMOV  D6, X3
    FMOV  V6.D[1], X2
    FMOV  D7, X12
    FMOV  V7.D[1], X10
    FMOV  D8, X2
    FMOV  V8.D[1], X24
    FMOV  D9, X7
    FMOV  V9.D[1], X22
    FMOV  D10, X17
    FMOV  V10.D[1], X13
    FMOV  D11, X27
    FMOV  V11.D[1], X24
    FMOV  D12, X9
    FMOV  V12.D[1], X20
    FMOV  D13, X23
    FMOV  V13.D[1], X15
    FMOV  D14, X8
    FMOV  V14.D[1], X10
    FMOV  D15, X14
    FMOV  V15.D[1], X3
    FMOV  D16, X7
    FMOV  V16.D[1], X27
    FMOV  D17, X17
    FMOV  V17.D[1], X10
    FMOV  D18, X23
    FMOV  V18.D[1], X23
    FMOV  D19, X10
    FMOV  V19.D[1], X24
    FMOV  D20, X7
    FMOV  V20.D[1], X26
    FMOV  D21, X9
    FMOV  V21.D[1], X20
    FMOV  D22, X5
    FMOV  V22.D[1], X4
    FMOV  D23, X16
    FMOV  V23.D[1], X17
    FMOV  D24, X16
    FMOV  V24.D[1], X4
    FMOV  D25, X2
    FMOV  V25.D[1], X28
    FMOV  D26, X28
    FMOV  V26.D[1], X12
    FMOV  D27, X16
    FMOV  V27.D[1], X12
    FMOV  D28, X23
    FMOV  V28.D[1], X27
    FMOV  D29, X8
    FMOV  V29.D[1], X12
    FMOV  D30, X6
    FMOV  V30.D[1], X6
    FMOV  D31, X16
    FMOV  V31.D[1], X3
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X10, #0x2d00, LSL #0
    ADD  X24, X30, X10, ASR #0
    ST1 { V23.8H }, [X24], X6
    LD1 { V6.16B }, [X24], X6
    ADD  X24, X24, X15
    ST1 { V25.16B }, [X24], X6
    LD1 { V11.16B }, [X24], X6
    ADD  X24, X24, X15, LSR #0
    ST1 { V27.2D }, [X24], X6
    LD1 { V22.2D }, [X24], X6
    ADD  X24, X24, X15
    ST1 { V28.4S }, [X24], X6
    LD1 { V12.4S }, [X24], X6
    ADD  X24, X24, X15, ASR #0
    ST1 { V6.8H }, [X24], X6
    LD1 { V15.8H }, [X24], X6
    ADD  X24, X24, X15
    ST1 { V22.8B }, [X24], X6
    LD1 { V29.1D }, [X24], X6
    ADD  X24, X24, X15
    ST1 { V12.1D }, [X24], X6
    LD1 { V3.1D }, [X24], X6
    ADD  X24, X24, X15, LSR #0
    ST1 { V11.2S }, [X24], X6
    LD1 { V3.2S }, [X24], X6
    ADD  X24, X24, X15, LSR #0
    ST1 { V15.4H }, [X24], X6
    LD1 { V22.4H }, [X24], X6
    ADD  X24, X24, X15, LSR #0
    ST1 { V22.8B }, [X24], X6
    LD1 { V27.8B }, [X24], X6
    ADD  X24, X24, X15, ASR #0
    MOV  X2, X24
    ST1 { V30.8H, V31.8H, V0.8H }, [X2], #48
    MOV  X2, X24
    LD1 { V3.2D, V4.2D, V5.2D }, [X2], #48
    ADD  X24, X24, X15, ASR #0
    MOV  X2, X24
    ST1 { V30.16B, V31.16B, V0.16B }, [X2], #48
    MOV  X2, X24
    LD1 { V29.16B, V30.16B, V31.16B }, [X2], #48
    ADD  X24, X24, X15, LSR #0
    MOV  X2, X24
    ST1 { V29.2D, V30.2D, V31.2D }, [X2], #48
    MOV  X2, X24
    LD1 { V15.2D, V16.2D, V17.2D }, [X2], #48
    ADD  X24, X24, X15, LSR #0
    MOV  X2, X24
    ST1 { V15.4S, V16.4S, V17.4S }, [X2], #48
    MOV  X2, X24
    LD1 { V18.4S, V19.4S, V20.4S }, [X2], #48
    ADD  X24, X24, X15, ASR #0
    MOV  X2, X24
    ST1 { V18.8H, V19.8H, V20.8H }, [X2], #48
    MOV  X2, X24
    LD1 { V4.8H, V5.8H, V6.8H }, [X2], #48
    ADD  X24, X24, X15, ASR #0
    MOV  X2, X24
    ST1 { V4.4H, V5.4H, V6.4H }, [X2], #24
    MOV  X2, X24
    LD1 { V5.2S, V6.2S, V7.2S }, [X2], #24
    ADD  X24, X24, X15, LSR #0
    MOV  X2, X24
    ST1 { V5.1D, V6.1D, V7.1D }, [X2], #24
    MOV  X2, X24
    LD1 { V26.1D, V27.1D, V28.1D }, [X2], #24
    ADD  X24, X24, X15, ASR #0
    MOV  X2, X24
    ST1 { V14.2S, V15.2S, V16.2S }, [X2], #24
    MOV  X2, X24
    LD1 { V29.2S, V30.2S, V31.2S }, [X2], #24
    ADD  X24, X24, X15, LSR #0
    MOV  X2, X24
    ST1 { V27.4H, V28.4H, V29.4H }, [X2], #24
    MOV  X2, X24
    LD1 { V14.4H, V15.4H, V16.4H }, [X2], #24
    ADD  X24, X24, X15, LSR #0
    MOV  X2, X24
    ST1 { V4.8B, V5.8B, V6.8B }, [X2], #24
    MOV  X2, X24
    LD1 { V18.8B, V19.8B, V20.8B }, [X2], #24
    ADD  X24, X24, X15
    ST1 { V3.2D, V4.2D, V5.2D }, [X24], X6
    LD1 { V4.16B, V5.16B, V6.16B }, [X24], X6
    ADD  X24, X24, X15, ASR #0
    ST1 { V13.16B, V14.16B, V15.16B }, [X24], X6
    LD1 { V27.16B, V28.16B, V29.16B }, [X24], X6
    ADD  X24, X24, X15, ASR #0
    ST1 { V27.2D, V28.2D, V29.2D }, [X24], X6
    LD1 { V13.2D, V14.2D, V15.2D }, [X24], X6
    ADD  X24, X24, X15
    ST1 { V4.4S, V5.4S, V6.4S }, [X24], X6
    LD1 { V4.4S, V5.4S, V6.4S }, [X24], X6
    ADD  X24, X24, X15, LSR #0
    ST1 { V29.8H, V30.8H, V31.8H }, [X24], X6
    LD1 { V23.8H, V24.8H, V25.8H }, [X24], X6
    ADD  X24, X24, X15, LSR #0
    ST1 { V13.2S, V14.2S, V15.2S }, [X24], X6
    LD1 { V13.1D, V14.1D, V15.1D }, [X24], X6
    ADD  X24, X24, X15, ASR #0
    ST1 { V7.1D, V8.1D, V9.1D }, [X24], X6
    LD1 { V29.1D, V30.1D, V31.1D }, [X24], X6
    ADD  X24, X24, X15, LSR #0
    ST1 { V13.2S, V14.2S, V15.2S }, [X24], X6
    LD1 { V13.2S, V14.2S, V15.2S }, [X24], X6
    ADD  X24, X24, X15
    ST1 { V23.4H, V24.4H, V25.4H }, [X24], X6
    LD1 { V14.4H, V15.4H, V16.4H }, [X24], X6
    ADD  X24, X24, X15, LSR #0
    ST1 { V14.8B, V15.8B, V16.8B }, [X24], X6
    LD1 { V14.8B, V15.8B, V16.8B }, [X24], X6
    ADD  X24, X24, X15
    MOV  X2, X24
    ST1 { V14.8H, V15.8H }, [X2], #32
    MOV  X2, X24
    LD1 { V24.8H, V25.8H }, [X2], #32
    ADD  X24, X24, X15
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V0.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D0
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V1.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D1
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V2.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D2
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V3.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D3
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V4.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D4
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V5.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D5
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D6
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D7
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V8.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D8
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D9
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D10
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V11.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D11
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V12.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D12
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D13
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V14.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D14
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V15.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D15
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V16.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D16
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D18
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D19
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D20
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V21.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D21
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V22.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D22
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V23.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D23
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V24.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D24
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V25.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D25
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D26
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D27
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D28
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D29
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D30
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V31.D[1]
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D31
    SUB  X27, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail

AdvsimdLoadStoreP03_TestEnd:
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
AdvsimdLoadStoreP03_TestFail:
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
