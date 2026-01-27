.global AdvsimdLoadStoreP07

.text
.p2align 4

AdvsimdLoadStoreP07:

AdvsimdLoadStoreP07_TestBegin:
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
    MOVZ  X3, #0xac0a, LSL #0
    MOVK  X3, #0x965a, LSL #16
    MOVK  X3, #0xcc59, LSL #32
    MOVK  X3, #0x2980, LSL #48
    MOVZ  X4, #0x2cc8, LSL #0
    MOVK  X4, #0x3ca7, LSL #16
    MOVK  X4, #0x6d5a, LSL #32
    MOVK  X4, #0x19d4, LSL #48
    MOVZ  X5, #0xe831, LSL #0
    MOVK  X5, #0xf1ff, LSL #16
    MOVK  X5, #0x4f04, LSL #32
    MOVK  X5, #0xaa9f, LSL #48
    MOVZ  X6, #0xce57, LSL #0
    MOVK  X6, #0x87a1, LSL #16
    MOVK  X6, #0x5e54, LSL #32
    MOVK  X6, #0x5dc8, LSL #48
    MOVZ  X7, #0x3b20, LSL #0
    MOVK  X7, #0xee6d, LSL #16
    MOVK  X7, #0x965d, LSL #32
    MOVK  X7, #0xff5d, LSL #48
    MOVZ  X8, #0xf805, LSL #0
    MOVK  X8, #0xe016, LSL #16
    MOVK  X8, #0xe728, LSL #32
    MOVK  X8, #0xaa63, LSL #48
    MOVZ  X9, #0xe0db, LSL #0
    MOVK  X9, #0xcfce, LSL #16
    MOVK  X9, #0xb251, LSL #32
    MOVK  X9, #0xca3e, LSL #48
    MOVZ  X10, #0xa4ac, LSL #0
    MOVK  X10, #0x48ff, LSL #16
    MOVK  X10, #0xd85d, LSL #32
    MOVK  X10, #0xcda6, LSL #48
    MOVZ  X12, #0x7458, LSL #0
    MOVK  X12, #0xbca2, LSL #16
    MOVK  X12, #0x3c8e, LSL #32
    MOVK  X12, #0x8609, LSL #48
    MOVZ  X13, #0xc6dd, LSL #0
    MOVK  X13, #0x4057, LSL #16
    MOVK  X13, #0x6793, LSL #32
    MOVK  X13, #0x50f6, LSL #48
    MOVZ  X16, #0xe8a0, LSL #0
    MOVK  X16, #0x3d12, LSL #16
    MOVK  X16, #0xace1, LSL #32
    MOVK  X16, #0xba0e, LSL #48
    MOVZ  X17, #0xe81a, LSL #0
    MOVK  X17, #0x1f33, LSL #16
    MOVK  X17, #0x5148, LSL #32
    MOVK  X17, #0xe75f, LSL #48
    MOVZ  X18, #0xd399, LSL #0
    MOVK  X18, #0x6abd, LSL #16
    MOVK  X18, #0x30e4, LSL #32
    MOVK  X18, #0x45e4, LSL #48
    MOVZ  X19, #0xbdb, LSL #0
    MOVK  X19, #0xc864, LSL #16
    MOVK  X19, #0xb26f, LSL #32
    MOVK  X19, #0xfe51, LSL #48
    MOVZ  X20, #0x9797, LSL #0
    MOVK  X20, #0x5c6, LSL #16
    MOVK  X20, #0x500c, LSL #32
    MOVK  X20, #0x5c67, LSL #48
    MOVZ  X21, #0x97bd, LSL #0
    MOVK  X21, #0x4798, LSL #16
    MOVK  X21, #0x1344, LSL #32
    MOVK  X21, #0x702d, LSL #48
    MOVZ  X22, #0x293e, LSL #0
    MOVK  X22, #0xfa72, LSL #16
    MOVK  X22, #0xa95d, LSL #32
    MOVK  X22, #0xb969, LSL #48
    MOVZ  X23, #0xcfb, LSL #0
    MOVK  X23, #0x2dbc, LSL #16
    MOVK  X23, #0xaf3e, LSL #32
    MOVK  X23, #0x7091, LSL #48
    MOVZ  X24, #0x8101, LSL #0
    MOVK  X24, #0x9050, LSL #16
    MOVK  X24, #0x6fa6, LSL #32
    MOVK  X24, #0x2801, LSL #48
    MOVZ  X25, #0xfc16, LSL #0
    MOVK  X25, #0x60f2, LSL #16
    MOVK  X25, #0x85c8, LSL #32
    MOVK  X25, #0x9a60, LSL #48
    MOVZ  X26, #0x6f00, LSL #0
    MOVK  X26, #0xeee4, LSL #16
    MOVK  X26, #0xacc4, LSL #32
    MOVK  X26, #0xda32, LSL #48
    MOVZ  X27, #0xdc4d, LSL #0
    MOVK  X27, #0xa380, LSL #16
    MOVK  X27, #0x8bd3, LSL #32
    MOVK  X27, #0xba3e, LSL #48
    MOVZ  X28, #0x8dcd, LSL #0
    MOVK  X28, #0xef2b, LSL #16
    MOVK  X28, #0xdf0, LSL #32
    MOVK  X28, #0x6e71, LSL #48
    MOVZ  X29, #0x5d88, LSL #0
    MOVK  X29, #0xce7b, LSL #16
    MOVK  X29, #0xdac0, LSL #32
    MOVK  X29, #0xeeb6, LSL #48
    MOVZ  X3, #0xe494, LSL #0
    MOVK  X3, #0x8fc6, LSL #16
    MOVK  X3, #0x3eda, LSL #32
    MOVK  X3, #0x5737, LSL #48
    MSR  FPCR, X3
    MOVZ  X3, #0xcd84, LSL #0
    MOVK  X3, #0xc1d2, LSL #16
    MOVK  X3, #0xad8c, LSL #32
    MOVK  X3, #0xc9be, LSL #48
    MSR  FPSR, X3
    MRS  X8, FPSR
    MOVZ  X12, #0xff60, LSL #0
    MOVK  X12, #0x7ff, LSL #16
    MOVK  X12, #0xffff, LSL #32
    MOVK  X12, #0xffff, LSL #48
    AND  X8, X8, X12
    MOVZ  X12, #0x0, LSL #0
    ORR  X8, X8, X12
    MSR  FPSR, X8
    ISB  SY
    ADDS  X22, X25, W10, SXTW #4
    MOV  X30, X1
    MOVZ  X1, #0x0, LSL #0
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
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X22
    FMOV  D3, X4
    FMOV  V3.D[1], X9
    FMOV  D4, X8
    FMOV  V4.D[1], X10
    FMOV  D5, X12
    FMOV  V5.D[1], X23
    FMOV  D6, X21
    FMOV  V6.D[1], X16
    FMOV  D7, X12
    FMOV  V7.D[1], X17
    FMOV  D8, X8
    FMOV  V8.D[1], X3
    FMOV  D9, X9
    FMOV  V9.D[1], X9
    FMOV  D10, X22
    FMOV  V10.D[1], X28
    FMOV  D11, X27
    FMOV  V11.D[1], X9
    FMOV  D12, X22
    FMOV  V12.D[1], X21
    FMOV  D13, X8
    FMOV  V13.D[1], X5
    FMOV  D14, X17
    FMOV  V14.D[1], X29
    FMOV  D15, X24
    FMOV  V15.D[1], X24
    FMOV  D16, X16
    FMOV  V16.D[1], X19
    FMOV  D17, X19
    FMOV  V17.D[1], X16
    FMOV  D18, X4
    FMOV  V18.D[1], X25
    FMOV  D19, X29
    FMOV  V19.D[1], X4
    FMOV  D20, X27
    FMOV  V20.D[1], X16
    FMOV  D21, X5
    FMOV  V21.D[1], X9
    FMOV  D22, X16
    FMOV  V22.D[1], X13
    FMOV  D23, X3
    FMOV  V23.D[1], X24
    FMOV  D24, X20
    FMOV  V24.D[1], X29
    FMOV  D25, X8
    FMOV  V25.D[1], X21
    FMOV  D26, X23
    FMOV  V26.D[1], X24
    FMOV  D27, X24
    FMOV  V27.D[1], X24
    FMOV  D28, X17
    FMOV  V28.D[1], X17
    FMOV  D29, X13
    FMOV  V29.D[1], X19
    FMOV  D30, X19
    FMOV  V30.D[1], X6
    FMOV  D31, X16
    FMOV  V31.D[1], X7
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X6, #0x0, LSL #0
    ADD  X22, X30, X6, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X22]
    LD4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X22]
    ADD  X22, X22, X24, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X22]
    LD4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X22]
    ADD  X22, X22, X24
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X22]
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X22]
    ADD  X22, X22, X24, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X22]
    LD4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X22]
    ADD  X22, X22, X24, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X22]
    LD4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X22]
    ADD  X22, X22, X24
    ST4 { V5.2S, V6.2S, V7.2S, V8.2S }, [X22]
    LD4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X22]
    ADD  X22, X22, X24, ASR #0
    ST4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X22]
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X22]
    ADD  X22, X22, X24
    ST4 { V17.4H, V18.4H, V19.4H, V20.4H }, [X22]
    LD4 { V17.4H, V18.4H, V19.4H, V20.4H }, [X22]
    ADD  X22, X22, X24, LSR #0
    ST4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X22]
    LD4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X22]
    ADD  X22, X22, X24
    MOV  X12, X22
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X12], #64
    MOV  X12, X22
    LD4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X12], #64
    ADD  X22, X22, X24, LSR #0
    MOV  X12, X22
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X12], #64
    MOV  X12, X22
    LD4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X12], #64
    ADD  X22, X22, X24, ASR #0
    MOV  X12, X22
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X12], #64
    MOV  X12, X22
    LD4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X12], #64
    ADD  X22, X22, X24
    MOV  X12, X22
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X12], #64
    MOV  X12, X22
    LD4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X12], #64
    ADD  X22, X22, X24
    MOV  X12, X22
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X12], #64
    MOV  X12, X22
    LD4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X12], #64
    ADD  X22, X22, X24, LSR #0
    MOV  X12, X22
    ST4 { V5.2S, V6.2S, V7.2S, V8.2S }, [X12], #32
    MOV  X12, X22
    LD4 { V28.4H, V29.4H, V30.4H, V31.4H }, [X12], #32
    ADD  X22, X22, X24, ASR #0
    MOV  X12, X22
    ST4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X12], #32
    MOV  X12, X22
    LD4 { V11.2S, V12.2S, V13.2S, V14.2S }, [X12], #32
    ADD  X22, X22, X24, LSR #0
    MOV  X12, X22
    ST4 { V10.4H, V11.4H, V12.4H, V13.4H }, [X12], #32
    MOV  X12, X22
    LD4 { V27.4H, V28.4H, V29.4H, V30.4H }, [X12], #32
    ADD  X22, X22, X24
    MOV  X12, X22
    ST4 { V12.8B, V13.8B, V14.8B, V15.8B }, [X12], #32
    MOV  X12, X22
    LD4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X12], #32
    ADD  X22, X22, X24, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X22], X27
    LD4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X22], X27
    ADD  X22, X22, X24, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X22], X27
    LD4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X22], X27
    ADD  X22, X22, X24, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X22], X27
    LD4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X22], X27
    ADD  X22, X22, X24, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X22], X27
    LD4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X22], X27
    ADD  X22, X22, X24, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X22], X27
    LD4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X22], X27
    ADD  X22, X22, X24, ASR #0
    ST4 { V23.4H, V24.4H, V25.4H, V26.4H }, [X22], X27
    LD4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X22], X27
    ADD  X22, X22, X24
    ST4 { V5.2S, V6.2S, V7.2S, V8.2S }, [X22], X27
    LD4 { V5.2S, V6.2S, V7.2S, V8.2S }, [X22], X27
    ADD  X22, X22, X24
    ST4 { V12.4H, V13.4H, V14.4H, V15.4H }, [X22], X27
    LD4 { V23.4H, V24.4H, V25.4H, V26.4H }, [X22], X27
    ADD  X22, X22, X24, LSR #0
    ST4 { V27.8B, V28.8B, V29.8B, V30.8B }, [X22], X27
    LD4 { V12.8B, V13.8B, V14.8B, V15.8B }, [X22], X27
    ADD  X22, X22, X24, LSR #0
    ST4 { V23.H, V24.H, V25.H, V26.H }[0x5], [X22]
    LD4 { V23.H, V24.H, V25.H, V26.H }[0x2], [X22]
    ADD  X22, X22, X24, ASR #0
    ST4 { V23.S, V24.S, V25.S, V26.S }[0x2], [X22]
    LD4 { V27.S, V28.S, V29.S, V30.S }[0x0], [X22]
    ADD  X22, X22, X24, LSR #0
    ST4 { V12.D, V13.D, V14.D, V15.D }[0x0], [X22]
    LD4 { V31.D, V0.D, V1.D, V2.D }[0x1], [X22]
    ADD  X22, X22, X24, LSR #0
    ST4 { V17.B, V18.B, V19.B, V20.B }[0x5], [X22]
    LD4 { V17.B, V18.B, V19.B, V20.B }[0xc], [X22]
    ADD  X22, X22, X24, ASR #0
    MOV  X12, X22
    ST4 { V29.H, V30.H, V31.H, V0.H }[0x6], [X12], #8
    MOV  X12, X22
    LD4 { V23.H, V24.H, V25.H, V26.H }[0x5], [X12], #8
    ADD  X22, X22, X24, LSR #0
    ST4 { V9.H, V10.H, V11.H, V12.H }[0x7], [X22], X27
    LD4 { V28.H, V29.H, V30.H, V31.H }[0x6], [X22], X27
    ADD  X22, X22, X24, LSR #0
    MOV  X12, X22
    ST4 { V24.S, V25.S, V26.S, V27.S }[0x3], [X12], #16
    MOV  X12, X22
    LD4 { V9.S, V10.S, V11.S, V12.S }[0x3], [X12], #16
    ADD  X22, X22, X24, ASR #0
    ST4 { V29.S, V30.S, V31.S, V0.S }[0x1], [X22], X27
    LD4 { V24.S, V25.S, V26.S, V27.S }[0x3], [X22], X27
    ADD  X22, X22, X24, LSR #0
    MOV  X12, X22
    ST4 { V17.D, V18.D, V19.D, V20.D }[0x1], [X12], #32
    MOV  X12, X22
    LD4 { V15.D, V16.D, V17.D, V18.D }[0x0], [X12], #32
    ADD  X22, X22, X24
    ST4 { V23.D, V24.D, V25.D, V26.D }[0x0], [X22], X27
    LD4 { V23.D, V24.D, V25.D, V26.D }[0x0], [X22], X27
    ADD  X22, X22, X24, LSR #0
    MOV  X12, X22
    ST4 { V9.B, V10.B, V11.B, V12.B }[0x6], [X12], #4
    MOV  X12, X22
    LD4 { V30.B, V31.B, V0.B, V1.B }[0x3], [X12], #4
    ADD  X22, X22, X24, LSR #0
    ST4 { V15.B, V16.B, V17.B, V18.B }[0x9], [X22], X27
    LD4 { V23.B, V24.B, V25.B, V26.B }[0x8], [X22], X27
    ADD  X22, X22, X24
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    SUB  X21, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D0
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D1
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V2.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D2
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V3.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D3
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V4.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D4
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V5.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D5
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V6.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D6
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V7.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D7
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V8.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D8
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    FMOV  X21, V9.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D9
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    FMOV  X21, V10.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D10
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V11.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D11
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V12.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D12
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V13.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D13
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V14.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D14
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V15.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a, LSL #32
    FMOV  X21, D15
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V16.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a, LSL #32
    FMOV  X21, D16
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a, LSL #32
    FMOV  X21, V17.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a, LSL #32
    FMOV  X21, D17
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a, LSL #32
    FMOV  X21, V18.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a, LSL #32
    FMOV  X21, D18
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a, LSL #32
    FMOV  X21, V19.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D19
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a, LSL #32
    FMOV  X21, V20.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D20
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V21.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D21
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V22.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D22
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D23
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V24.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D24
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V25.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D25
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V26.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D26
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V27.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D27
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a5a, LSL #32
    FMOV  X21, V28.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D28
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a5a, LSL #32
    FMOV  X21, V29.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D29
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X21, V30.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0x5a00, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D30
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X10, #0x5a5a, LSL #0
    MOVK  X10, #0x5a5a, LSL #16
    MOVK  X10, #0x5a5a, LSL #32
    MOVK  X10, #0x5a5a, LSL #48
    FMOV  X21, D31
    SUB  X25, X10, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X3
    FMOV  D3, X6
    FMOV  V3.D[1], X24
    FMOV  D4, X3
    FMOV  V4.D[1], X5
    FMOV  D5, X26
    FMOV  V5.D[1], X3
    FMOV  D6, X24
    FMOV  V6.D[1], X9
    FMOV  D7, X17
    FMOV  V7.D[1], X7
    FMOV  D8, X27
    FMOV  V8.D[1], X10
    FMOV  D9, X7
    FMOV  V9.D[1], X4
    FMOV  D10, X6
    FMOV  V10.D[1], X6
    FMOV  D11, X3
    FMOV  V11.D[1], X19
    FMOV  D12, X29
    FMOV  V12.D[1], X4
    FMOV  D13, X23
    FMOV  V13.D[1], X12
    FMOV  D14, X28
    FMOV  V14.D[1], X5
    FMOV  D15, X27
    FMOV  V15.D[1], X16
    FMOV  D16, X8
    FMOV  V16.D[1], X19
    FMOV  D17, X26
    FMOV  V17.D[1], X17
    FMOV  D18, X22
    FMOV  V18.D[1], X9
    FMOV  D19, X3
    FMOV  V19.D[1], X18
    FMOV  D20, X4
    FMOV  V20.D[1], X18
    FMOV  D21, X29
    FMOV  V21.D[1], X24
    FMOV  D22, X12
    FMOV  V22.D[1], X5
    FMOV  D23, X18
    FMOV  V23.D[1], X21
    FMOV  D24, X7
    FMOV  V24.D[1], X21
    FMOV  D25, X28
    FMOV  V25.D[1], X18
    FMOV  D26, X21
    FMOV  V26.D[1], X22
    FMOV  D27, X24
    FMOV  V27.D[1], X25
    FMOV  D28, X29
    FMOV  V28.D[1], X29
    FMOV  D29, X7
    FMOV  V29.D[1], X5
    FMOV  D30, X19
    FMOV  V30.D[1], X18
    FMOV  D31, X21
    FMOV  V31.D[1], X28
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X29, #0x500, LSL #0
    ADD  X8, X30, X29, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X8]
    LD4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X8]
    ADD  X8, X8, X16, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X8]
    LD4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X8]
    LD4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X8]
    LD4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X8]
    ADD  X8, X8, X16, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X8]
    LD4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X8]
    ADD  X8, X8, X16
    ST4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X8]
    LD4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X8]
    ADD  X8, X8, X16
    ST4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X8]
    LD4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X8]
    ADD  X8, X8, X16, LSR #0
    ST4 { V23.4H, V24.4H, V25.4H, V26.4H }, [X8]
    LD4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X8]
    ADD  X8, X8, X16, LSR #0
    ST4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X8]
    LD4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X8]
    ADD  X8, X8, X16
    MOV  X21, X8
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X21], #64
    MOV  X21, X8
    LD4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X21], #64
    ADD  X8, X8, X16, LSR #0
    MOV  X21, X8
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X21], #64
    MOV  X21, X8
    LD4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X21], #64
    ADD  X8, X8, X16, ASR #0
    MOV  X21, X8
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X21], #64
    MOV  X21, X8
    LD4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X21], #64
    ADD  X8, X8, X16
    MOV  X21, X8
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X21], #64
    MOV  X21, X8
    LD4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X21], #64
    ADD  X8, X8, X16
    MOV  X21, X8
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X21], #64
    MOV  X21, X8
    LD4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X21], #64
    ADD  X8, X8, X16
    MOV  X21, X8
    ST4 { V18.2S, V19.2S, V20.2S, V21.2S }, [X21], #32
    MOV  X21, X8
    LD4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X21], #32
    ADD  X8, X8, X16
    MOV  X21, X8
    ST4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X21], #32
    MOV  X21, X8
    LD4 { V18.2S, V19.2S, V20.2S, V21.2S }, [X21], #32
    ADD  X8, X8, X16
    MOV  X21, X8
    ST4 { V18.4H, V19.4H, V20.4H, V21.4H }, [X21], #32
    MOV  X21, X8
    LD4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X21], #32
    ADD  X8, X8, X16
    MOV  X21, X8
    ST4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X21], #32
    MOV  X21, X8
    LD4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X21], #32
    ADD  X8, X8, X16, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X8], X9
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X8], X9
    ADD  X8, X8, X16, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X8], X9
    LD4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X8], X9
    ADD  X8, X8, X16, ASR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X8], X9
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X8], X9
    ADD  X8, X8, X16, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X8], X9
    LD4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X8], X9
    ADD  X8, X8, X16, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X8], X9
    LD4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X8], X9
    ADD  X8, X8, X16
    ST4 { V18.4H, V19.4H, V20.4H, V21.4H }, [X8], X9
    LD4 { V7.8B, V8.8B, V9.8B, V10.8B }, [X8], X9
    ADD  X8, X8, X16
    ST4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X8], X9
    LD4 { V18.2S, V19.2S, V20.2S, V21.2S }, [X8], X9
    ADD  X8, X8, X16, LSR #0
    ST4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X8], X9
    LD4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X8], X9
    ADD  X8, X8, X16
    ST4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X8], X9
    LD4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X8], X9
    ADD  X8, X8, X16
    ST4 { V7.H, V8.H, V9.H, V10.H }[0x0], [X8]
    LD4 { V18.H, V19.H, V20.H, V21.H }[0x6], [X8]
    ADD  X8, X8, X16
    ST4 { V4.S, V5.S, V6.S, V7.S }[0x2], [X8]
    LD4 { V7.S, V8.S, V9.S, V10.S }[0x2], [X8]
    ADD  X8, X8, X16, ASR #0
    ST4 { V29.D, V30.D, V31.D, V0.D }[0x0], [X8]
    LD4 { V29.D, V30.D, V31.D, V0.D }[0x1], [X8]
    ADD  X8, X8, X16, ASR #0
    ST4 { V29.B, V30.B, V31.B, V0.B }[0x9], [X8]
    LD4 { V29.B, V30.B, V31.B, V0.B }[0x8], [X8]
    ADD  X8, X8, X16, ASR #0
    MOV  X21, X8
    ST4 { V18.H, V19.H, V20.H, V21.H }[0x6], [X21], #8
    MOV  X21, X8
    LD4 { V7.H, V8.H, V9.H, V10.H }[0x0], [X21], #8
    ADD  X8, X8, X16, ASR #0
    ST4 { V4.H, V5.H, V6.H, V7.H }[0x6], [X8], X9
    LD4 { V18.H, V19.H, V20.H, V21.H }[0x3], [X8], X9
    ADD  X8, X8, X16, LSR #0
    MOV  X21, X8
    ST4 { V29.S, V30.S, V31.S, V0.S }[0x1], [X21], #16
    MOV  X21, X8
    LD4 { V29.S, V30.S, V31.S, V0.S }[0x1], [X21], #16
    ADD  X8, X8, X16, LSR #0
    ST4 { V29.S, V30.S, V31.S, V0.S }[0x3], [X8], X9
    LD4 { V4.S, V5.S, V6.S, V7.S }[0x3], [X8], X9
    ADD  X8, X8, X16
    MOV  X21, X8
    ST4 { V10.D, V11.D, V12.D, V13.D }[0x1], [X21], #32
    MOV  X21, X8
    LD4 { V29.D, V30.D, V31.D, V0.D }[0x1], [X21], #32
    ADD  X8, X8, X16, LSR #0
    ST4 { V29.D, V30.D, V31.D, V0.D }[0x0], [X8], X9
    LD4 { V29.D, V30.D, V31.D, V0.D }[0x0], [X8], X9
    ADD  X8, X8, X16
    MOV  X21, X8
    ST4 { V4.B, V5.B, V6.B, V7.B }[0xe], [X21], #4
    MOV  X21, X8
    LD4 { V10.B, V11.B, V12.B, V13.B }[0xb], [X21], #4
    ADD  X8, X8, X16
    ST4 { V29.B, V30.B, V31.B, V0.B }[0x4], [X8], X9
    LD4 { V4.B, V5.B, V6.B, V7.B }[0x0], [X8], X9
    ADD  X8, X8, X16, ASR #0
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X4, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X4, FPSR
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V0.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D0
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V1.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D1
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V2.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D2
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V3.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D3
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V4.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D4
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V5.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D5
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V6.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D6
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V7.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D7
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    FMOV  X4, V8.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D8
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    FMOV  X4, V9.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D9
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa500, LSL #16
    FMOV  X4, V10.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D10
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V11.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D11
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D12
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V13.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D13
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V14.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D14
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D15
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V16.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D16
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V17.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D17
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5a5, LSL #32
    FMOV  X4, V18.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D18
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5a5, LSL #32
    FMOV  X4, V19.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D19
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5a5, LSL #32
    FMOV  X4, V20.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D20
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5a5, LSL #32
    FMOV  X4, V21.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    FMOV  X4, D21
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D22
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D23
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D24
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D25
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D26
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V27.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D27
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D28
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V29.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D29
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V30.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D30
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, V31.D[1]
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X4, D31
    SUB  X26, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
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
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X10
    FMOV  D3, X24
    FMOV  V3.D[1], X18
    FMOV  D4, X3
    FMOV  V4.D[1], X3
    FMOV  D5, X10
    FMOV  V5.D[1], X24
    FMOV  D6, X12
    FMOV  V6.D[1], X7
    FMOV  D7, X24
    FMOV  V7.D[1], X17
    FMOV  D8, X28
    FMOV  V8.D[1], X9
    FMOV  D9, X5
    FMOV  V9.D[1], X4
    FMOV  D10, X17
    FMOV  V10.D[1], X19
    FMOV  D11, X20
    FMOV  V11.D[1], X13
    FMOV  D12, X5
    FMOV  V12.D[1], X13
    FMOV  D13, X19
    FMOV  V13.D[1], X16
    FMOV  D14, X23
    FMOV  V14.D[1], X17
    FMOV  D15, X29
    FMOV  V15.D[1], X7
    FMOV  D16, X18
    FMOV  V16.D[1], X24
    FMOV  D17, X10
    FMOV  V17.D[1], X12
    FMOV  D18, X3
    FMOV  V18.D[1], X27
    FMOV  D19, X6
    FMOV  V19.D[1], X27
    FMOV  D20, X27
    FMOV  V20.D[1], X13
    FMOV  D21, X12
    FMOV  V21.D[1], X18
    FMOV  D22, X5
    FMOV  V22.D[1], X21
    FMOV  D23, X16
    FMOV  V23.D[1], X24
    FMOV  D24, X25
    FMOV  V24.D[1], X25
    FMOV  D25, X5
    FMOV  V25.D[1], X26
    FMOV  D26, X27
    FMOV  V26.D[1], X21
    FMOV  D27, X27
    FMOV  V27.D[1], X19
    FMOV  D28, X13
    FMOV  V28.D[1], X23
    FMOV  D29, X21
    FMOV  V29.D[1], X20
    FMOV  D30, X26
    FMOV  V30.D[1], X5
    FMOV  D31, X20
    FMOV  V31.D[1], X13
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X12, #0xa00, LSL #0
    ADD  X28, X30, X12, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X28]
    LD4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X28]
    ADD  X28, X28, X17, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X28]
    LD4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X28]
    ADD  X28, X28, X17, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X28]
    LD4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X28]
    ADD  X28, X28, X17, ASR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X28]
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X28]
    ADD  X28, X28, X17
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X28]
    LD4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X28]
    ADD  X28, X28, X17, ASR #0
    ST4 { V11.8B, V12.8B, V13.8B, V14.8B }, [X28]
    LD4 { V6.4H, V7.4H, V8.4H, V9.4H }, [X28]
    ADD  X28, X28, X17
    ST4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X28]
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X28]
    ADD  X28, X28, X17, LSR #0
    ST4 { V5.4H, V6.4H, V7.4H, V8.4H }, [X28]
    LD4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X28]
    ADD  X28, X28, X17, ASR #0
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X28]
    LD4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X28]
    ADD  X28, X28, X17
    MOV  X7, X28
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X7], #64
    MOV  X7, X28
    LD4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X7], #64
    ADD  X28, X28, X17, ASR #0
    MOV  X7, X28
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X7], #64
    MOV  X7, X28
    LD4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X7], #64
    ADD  X28, X28, X17, ASR #0
    MOV  X7, X28
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X7], #64
    MOV  X7, X28
    LD4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X7], #64
    ADD  X28, X28, X17, LSR #0
    MOV  X7, X28
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X7], #64
    MOV  X7, X28
    LD4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X7], #64
    ADD  X28, X28, X17, LSR #0
    MOV  X7, X28
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X7], #64
    MOV  X7, X28
    LD4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X7], #64
    ADD  X28, X28, X17, ASR #0
    MOV  X7, X28
    ST4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X7], #32
    MOV  X7, X28
    LD4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X7], #32
    ADD  X28, X28, X17, LSR #0
    MOV  X7, X28
    ST4 { V5.2S, V6.2S, V7.2S, V8.2S }, [X7], #32
    MOV  X7, X28
    LD4 { V5.2S, V6.2S, V7.2S, V8.2S }, [X7], #32
    ADD  X28, X28, X17, LSR #0
    MOV  X7, X28
    ST4 { V1.4H, V2.4H, V3.4H, V4.4H }, [X7], #32
    MOV  X7, X28
    LD4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X7], #32
    ADD  X28, X28, X17, LSR #0
    MOV  X7, X28
    ST4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X7], #32
    MOV  X7, X28
    LD4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X7], #32
    ADD  X28, X28, X17
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X28], X4
    LD4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X28], X4
    ADD  X28, X28, X17, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X28], X4
    LD4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X28], X4
    ADD  X28, X28, X17, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X28], X4
    LD4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X28], X4
    ADD  X28, X28, X17
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X28], X4
    LD4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X28], X4
    ADD  X28, X28, X17
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X28], X4
    LD4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X28], X4
    ADD  X28, X28, X17, ASR #0
    ST4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X28], X4
    LD4 { V5.4H, V6.4H, V7.4H, V8.4H }, [X28], X4
    ADD  X28, X28, X17, LSR #0
    ST4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X28], X4
    LD4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X28], X4
    ADD  X28, X28, X17, ASR #0
    ST4 { V10.4H, V11.4H, V12.4H, V13.4H }, [X28], X4
    LD4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X28], X4
    ADD  X28, X28, X17, LSR #0
    ST4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X28], X4
    LD4 { V12.8B, V13.8B, V14.8B, V15.8B }, [X28], X4
    ADD  X28, X28, X17, ASR #0
    ST4 { V5.H, V6.H, V7.H, V8.H }[0x0], [X28]
    LD4 { V19.H, V20.H, V21.H, V22.H }[0x4], [X28]
    ADD  X28, X28, X17, ASR #0
    ST4 { V12.S, V13.S, V14.S, V15.S }[0x3], [X28]
    LD4 { V5.S, V6.S, V7.S, V8.S }[0x1], [X28]
    ADD  X28, X28, X17, ASR #0
    ST4 { V19.D, V20.D, V21.D, V22.D }[0x0], [X28]
    LD4 { V12.D, V13.D, V14.D, V15.D }[0x1], [X28]
    ADD  X28, X28, X17, LSR #0
    ST4 { V12.B, V13.B, V14.B, V15.B }[0x3], [X28]
    LD4 { V10.B, V11.B, V12.B, V13.B }[0x8], [X28]
    ADD  X28, X28, X17
    MOV  X7, X28
    ST4 { V5.H, V6.H, V7.H, V8.H }[0x7], [X7], #8
    MOV  X7, X28
    LD4 { V5.H, V6.H, V7.H, V8.H }[0x5], [X7], #8
    ADD  X28, X28, X17, ASR #0
    ST4 { V24.H, V25.H, V26.H, V27.H }[0x1], [X28], X4
    LD4 { V19.H, V20.H, V21.H, V22.H }[0x4], [X28], X4
    ADD  X28, X28, X17
    MOV  X7, X28
    ST4 { V5.S, V6.S, V7.S, V8.S }[0x0], [X7], #16
    MOV  X7, X28
    LD4 { V5.S, V6.S, V7.S, V8.S }[0x1], [X7], #16
    ADD  X28, X28, X17, LSR #0
    ST4 { V19.S, V20.S, V21.S, V22.S }[0x3], [X28], X4
    LD4 { V16.S, V17.S, V18.S, V19.S }[0x3], [X28], X4
    ADD  X28, X28, X17, ASR #0
    MOV  X7, X28
    ST4 { V5.D, V6.D, V7.D, V8.D }[0x1], [X7], #32
    MOV  X7, X28
    LD4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X7], #32
    ADD  X28, X28, X17
    ST4 { V17.D, V18.D, V19.D, V20.D }[0x1], [X28], X4
    LD4 { V18.D, V19.D, V20.D, V21.D }[0x0], [X28], X4
    ADD  X28, X28, X17, LSR #0
    MOV  X7, X28
    ST4 { V13.B, V14.B, V15.B, V16.B }[0xa], [X7], #4
    MOV  X7, X28
    LD4 { V13.B, V14.B, V15.B, V16.B }[0xc], [X7], #4
    ADD  X28, X28, X17
    ST4 { V8.B, V9.B, V10.B, V11.B }[0x2], [X28], X4
    LD4 { V6.B, V7.B, V8.B, V9.B }[0x3], [X28], X4
    ADD  X28, X28, X17, ASR #0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X13, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V0.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D0
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V1.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D1
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V2.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D2
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V3.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D3
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D4
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D5
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V6.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D6
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V7.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D7
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V8.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D8
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D9
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a, LSL #0
    FMOV  X13, V10.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D10
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a, LSL #0
    FMOV  X13, V11.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D11
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, V12.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D12
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V13.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D13
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D14
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D15
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V16.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D16
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V17.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D17
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D18
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, D19
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    FMOV  X13, D20
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    FMOV  X13, D21
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D22
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D23
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, V24.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D24
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, V25.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D25
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, V26.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D26
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, V27.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D27
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, V28.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D28
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V29.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D29
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D30
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X13, D31
    SUB  X6, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X4
    FMOV  V3.D[1], X9
    FMOV  D4, X24
    FMOV  V4.D[1], X17
    FMOV  D5, X12
    FMOV  V5.D[1], X5
    FMOV  D6, X27
    FMOV  V6.D[1], X4
    FMOV  D7, X13
    FMOV  V7.D[1], X6
    FMOV  D8, X10
    FMOV  V8.D[1], X21
    FMOV  D9, X4
    FMOV  V9.D[1], X26
    FMOV  D10, X28
    FMOV  V10.D[1], X3
    FMOV  D11, X26
    FMOV  V11.D[1], X3
    FMOV  D12, X23
    FMOV  V12.D[1], X27
    FMOV  D13, X24
    FMOV  V13.D[1], X27
    FMOV  D14, X6
    FMOV  V14.D[1], X16
    FMOV  D15, X28
    FMOV  V15.D[1], X9
    FMOV  D16, X17
    FMOV  V16.D[1], X8
    FMOV  D17, X10
    FMOV  V17.D[1], X25
    FMOV  D18, X10
    FMOV  V18.D[1], X25
    FMOV  D19, X23
    FMOV  V19.D[1], X12
    FMOV  D20, X3
    FMOV  V20.D[1], X27
    FMOV  D21, X13
    FMOV  V21.D[1], X12
    FMOV  D22, X28
    FMOV  V22.D[1], X26
    FMOV  D23, X29
    FMOV  V23.D[1], X18
    FMOV  D24, X9
    FMOV  V24.D[1], X21
    FMOV  D25, X22
    FMOV  V25.D[1], X4
    FMOV  D26, X3
    FMOV  V26.D[1], X5
    FMOV  D27, X24
    FMOV  V27.D[1], X3
    FMOV  D28, X3
    FMOV  V28.D[1], X23
    FMOV  D29, X28
    FMOV  V29.D[1], X5
    FMOV  D30, X6
    FMOV  V30.D[1], X3
    FMOV  D31, X29
    FMOV  V31.D[1], X26
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X10, #0xf00, LSL #0
    ADD  X27, X30, X10
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X27]
    LD4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X27]
    LD4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X27]
    ADD  X27, X27, X29
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X27]
    LD4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X27]
    LD4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X27]
    LD4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X27]
    ADD  X27, X27, X29
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X27]
    LD4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X27]
    LD4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X27]
    ADD  X27, X27, X29
    ST4 { V24.4H, V25.4H, V26.4H, V27.4H }, [X27]
    LD4 { V24.4H, V25.4H, V26.4H, V27.4H }, [X27]
    ADD  X27, X27, X29
    ST4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X27]
    LD4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X27]
    ADD  X27, X27, X29, LSR #0
    MOV  X20, X27
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X20], #64
    MOV  X20, X27
    LD4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X20], #64
    ADD  X27, X27, X29, ASR #0
    MOV  X20, X27
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X20], #64
    MOV  X20, X27
    LD4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X20], #64
    ADD  X27, X27, X29, ASR #0
    MOV  X20, X27
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X20], #64
    MOV  X20, X27
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X20], #64
    ADD  X27, X27, X29, LSR #0
    MOV  X20, X27
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X20], #64
    MOV  X20, X27
    LD4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X20], #64
    ADD  X27, X27, X29, LSR #0
    MOV  X20, X27
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X20], #64
    MOV  X20, X27
    LD4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X20], #64
    ADD  X27, X27, X29, LSR #0
    MOV  X20, X27
    ST4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X20], #32
    MOV  X20, X27
    LD4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X20], #32
    ADD  X27, X27, X29, LSR #0
    MOV  X20, X27
    ST4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X20], #32
    MOV  X20, X27
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X20], #32
    ADD  X27, X27, X29, ASR #0
    MOV  X20, X27
    ST4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X20], #32
    MOV  X20, X27
    LD4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X20], #32
    ADD  X27, X27, X29
    MOV  X20, X27
    ST4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X20], #32
    MOV  X20, X27
    LD4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X20], #32
    ADD  X27, X27, X29, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X27], X16
    LD4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X27], X16
    ADD  X27, X27, X29, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X27], X16
    LD4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X27], X16
    ADD  X27, X27, X29, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X27], X16
    LD4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X27], X16
    ADD  X27, X27, X29
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X27], X16
    LD4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X27], X16
    ADD  X27, X27, X29, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X27], X16
    LD4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X27], X16
    ADD  X27, X27, X29, LSR #0
    ST4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X27], X16
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X27], X16
    ADD  X27, X27, X29, ASR #0
    ST4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X27], X16
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X27], X16
    ADD  X27, X27, X29
    ST4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X27], X16
    LD4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X27], X16
    ADD  X27, X27, X29
    ST4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X27], X16
    LD4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X27], X16
    ADD  X27, X27, X29, ASR #0
    ST4 { V23.H, V24.H, V25.H, V26.H }[0x1], [X27]
    LD4 { V23.H, V24.H, V25.H, V26.H }[0x0], [X27]
    ADD  X27, X27, X29
    ST4 { V23.S, V24.S, V25.S, V26.S }[0x0], [X27]
    LD4 { V23.S, V24.S, V25.S, V26.S }[0x0], [X27]
    ADD  X27, X27, X29
    ST4 { V17.D, V18.D, V19.D, V20.D }[0x1], [X27]
    LD4 { V14.D, V15.D, V16.D, V17.D }[0x1], [X27]
    ADD  X27, X27, X29, LSR #0
    ST4 { V29.B, V30.B, V31.B, V0.B }[0x6], [X27]
    LD4 { V10.B, V11.B, V12.B, V13.B }[0x2], [X27]
    ADD  X27, X27, X29, LSR #0
    MOV  X20, X27
    ST4 { V23.H, V24.H, V25.H, V26.H }[0x4], [X20], #8
    MOV  X20, X27
    LD4 { V23.H, V24.H, V25.H, V26.H }[0x2], [X20], #8
    ADD  X27, X27, X29, ASR #0
    ST4 { V12.H, V13.H, V14.H, V15.H }[0x6], [X27], X16
    LD4 { V26.H, V27.H, V28.H, V29.H }[0x4], [X27], X16
    ADD  X27, X27, X29, LSR #0
    MOV  X20, X27
    ST4 { V27.S, V28.S, V29.S, V30.S }[0x1], [X20], #16
    MOV  X20, X27
    LD4 { V26.S, V27.S, V28.S, V29.S }[0x2], [X20], #16
    ADD  X27, X27, X29, LSR #0
    ST4 { V26.S, V27.S, V28.S, V29.S }[0x3], [X27], X16
    LD4 { V0.S, V1.S, V2.S, V3.S }[0x2], [X27], X16
    ADD  X27, X27, X29
    MOV  X20, X27
    ST4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X20], #32
    MOV  X20, X27
    LD4 { V26.D, V27.D, V28.D, V29.D }[0x1], [X20], #32
    ADD  X27, X27, X29, LSR #0
    ST4 { V25.D, V26.D, V27.D, V28.D }[0x0], [X27], X16
    LD4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X27], X16
    ADD  X27, X27, X29
    MOV  X20, X27
    ST4 { V10.B, V11.B, V12.B, V13.B }[0x2], [X20], #4
    MOV  X20, X27
    LD4 { V29.B, V30.B, V31.B, V0.B }[0xb], [X20], #4
    ADD  X27, X27, X29, ASR #0
    ST4 { V25.B, V26.B, V27.B, V28.B }[0xd], [X27], X16
    LD4 { V10.B, V11.B, V12.B, V13.B }[0x3], [X27], X16
    ADD  X27, X27, X29, ASR #0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X7, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa500, LSL #16
    FMOV  X7, V0.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D0
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V1.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D1
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D2
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D3
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D4
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V5.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D5
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D6
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V7.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D7
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V8.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D8
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D9
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D10
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D11
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V12.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D12
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V13.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D13
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V14.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D14
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D15
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D16
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D17
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D18
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D19
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D20
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D21
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D22
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D23
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D24
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D25
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V26.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D26
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V27.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D27
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V28.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D28
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, V29.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D29
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa500, LSL #16
    FMOV  X7, V30.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D30
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa500, LSL #16
    FMOV  X7, V31.D[1]
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X7, D31
    SUB  X6, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
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
    FMOV  V2.D[1], X4
    FMOV  D3, X4
    FMOV  V3.D[1], X24
    FMOV  D4, X19
    FMOV  V4.D[1], X20
    FMOV  D5, X13
    FMOV  V5.D[1], X9
    FMOV  D6, X18
    FMOV  V6.D[1], X13
    FMOV  D7, X28
    FMOV  V7.D[1], X13
    FMOV  D8, X12
    FMOV  V8.D[1], X10
    FMOV  D9, X16
    FMOV  V9.D[1], X10
    FMOV  D10, X27
    FMOV  V10.D[1], X26
    FMOV  D11, X22
    FMOV  V11.D[1], X23
    FMOV  D12, X16
    FMOV  V12.D[1], X24
    FMOV  D13, X9
    FMOV  V13.D[1], X3
    FMOV  D14, X18
    FMOV  V14.D[1], X8
    FMOV  D15, X16
    FMOV  V15.D[1], X8
    FMOV  D16, X13
    FMOV  V16.D[1], X3
    FMOV  D17, X3
    FMOV  V17.D[1], X13
    FMOV  D18, X5
    FMOV  V18.D[1], X20
    FMOV  D19, X20
    FMOV  V19.D[1], X25
    FMOV  D20, X23
    FMOV  V20.D[1], X25
    FMOV  D21, X16
    FMOV  V21.D[1], X5
    FMOV  D22, X29
    FMOV  V22.D[1], X27
    FMOV  D23, X7
    FMOV  V23.D[1], X25
    FMOV  D24, X21
    FMOV  V24.D[1], X4
    FMOV  D25, X10
    FMOV  V25.D[1], X9
    FMOV  D26, X29
    FMOV  V26.D[1], X26
    FMOV  D27, X7
    FMOV  V27.D[1], X13
    FMOV  D28, X4
    FMOV  V28.D[1], X27
    FMOV  D29, X3
    FMOV  V29.D[1], X25
    FMOV  D30, X5
    FMOV  V30.D[1], X8
    FMOV  D31, X24
    FMOV  V31.D[1], X5
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X8, #0x1400, LSL #0
    ADD  X19, X30, X8, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X19]
    LD4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X19]
    ADD  X19, X19, X22, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X19]
    LD4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X19]
    ADD  X19, X19, X22, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X19]
    LD4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X19]
    ADD  X19, X19, X22
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X19]
    LD4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X19]
    ADD  X19, X19, X22, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X19]
    LD4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X19]
    ADD  X19, X19, X22, LSR #0
    ST4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X19]
    LD4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X19]
    ADD  X19, X19, X22
    ST4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X19]
    LD4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X19]
    ADD  X19, X19, X22, LSR #0
    ST4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X19]
    LD4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X19]
    ADD  X19, X19, X22, ASR #0
    ST4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X19]
    LD4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X19]
    ADD  X19, X19, X22, LSR #0
    MOV  X16, X19
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X16], #64
    MOV  X16, X19
    LD4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X16], #64
    ADD  X19, X19, X22
    MOV  X16, X19
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X16], #64
    MOV  X16, X19
    LD4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X16], #64
    ADD  X19, X19, X22
    MOV  X16, X19
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X16], #64
    MOV  X16, X19
    LD4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X16], #64
    ADD  X19, X19, X22, ASR #0
    MOV  X16, X19
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X16], #64
    MOV  X16, X19
    LD4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X16], #64
    ADD  X19, X19, X22
    MOV  X16, X19
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X16], #64
    MOV  X16, X19
    LD4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X16], #64
    ADD  X19, X19, X22, ASR #0
    MOV  X16, X19
    ST4 { V12.4H, V13.4H, V14.4H, V15.4H }, [X16], #32
    MOV  X16, X19
    LD4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X16], #32
    ADD  X19, X19, X22
    MOV  X16, X19
    ST4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X16], #32
    MOV  X16, X19
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X16], #32
    ADD  X19, X19, X22, ASR #0
    MOV  X16, X19
    ST4 { V5.4H, V6.4H, V7.4H, V8.4H }, [X16], #32
    MOV  X16, X19
    LD4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X16], #32
    ADD  X19, X19, X22, ASR #0
    MOV  X16, X19
    ST4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X16], #32
    MOV  X16, X19
    LD4 { V12.8B, V13.8B, V14.8B, V15.8B }, [X16], #32
    ADD  X19, X19, X22, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X19], X25
    LD4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X19], X25
    ADD  X19, X19, X22, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X19], X25
    LD4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X19], X25
    ADD  X19, X19, X22, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X19], X25
    LD4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X19], X25
    ADD  X19, X19, X22
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X19], X25
    LD4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X19], X25
    ADD  X19, X19, X22, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X19], X25
    LD4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X19], X25
    ADD  X19, X19, X22, ASR #0
    ST4 { V22.8B, V23.8B, V24.8B, V25.8B }, [X19], X25
    LD4 { V28.4H, V29.4H, V30.4H, V31.4H }, [X19], X25
    ADD  X19, X19, X22
    ST4 { V28.2S, V29.2S, V30.2S, V31.2S }, [X19], X25
    LD4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X19], X25
    ADD  X19, X19, X22, LSR #0
    ST4 { V23.4H, V24.4H, V25.4H, V26.4H }, [X19], X25
    LD4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X19], X25
    ADD  X19, X19, X22, LSR #0
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X19], X25
    LD4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X19], X25
    ADD  X19, X19, X22
    ST4 { V20.H, V21.H, V22.H, V23.H }[0x2], [X19]
    LD4 { V20.H, V21.H, V22.H, V23.H }[0x7], [X19]
    ADD  X19, X19, X22, LSR #0
    ST4 { V5.S, V6.S, V7.S, V8.S }[0x0], [X19]
    LD4 { V28.S, V29.S, V30.S, V31.S }[0x0], [X19]
    ADD  X19, X19, X22, LSR #0
    ST4 { V28.D, V29.D, V30.D, V31.D }[0x0], [X19]
    LD4 { V5.D, V6.D, V7.D, V8.D }[0x0], [X19]
    ADD  X19, X19, X22, LSR #0
    ST4 { V12.B, V13.B, V14.B, V15.B }[0x1], [X19]
    LD4 { V12.B, V13.B, V14.B, V15.B }[0x8], [X19]
    ADD  X19, X19, X22
    MOV  X16, X19
    ST4 { V12.H, V13.H, V14.H, V15.H }[0x4], [X16], #8
    MOV  X16, X19
    LD4 { V12.H, V13.H, V14.H, V15.H }[0x4], [X16], #8
    ADD  X19, X19, X22, LSR #0
    ST4 { V5.H, V6.H, V7.H, V8.H }[0x5], [X19], X25
    LD4 { V28.H, V29.H, V30.H, V31.H }[0x0], [X19], X25
    ADD  X19, X19, X22, ASR #0
    MOV  X16, X19
    ST4 { V20.S, V21.S, V22.S, V23.S }[0x3], [X16], #16
    MOV  X16, X19
    LD4 { V3.S, V4.S, V5.S, V6.S }[0x0], [X16], #16
    ADD  X19, X19, X22
    ST4 { V28.S, V29.S, V30.S, V31.S }[0x1], [X19], X25
    LD4 { V28.S, V29.S, V30.S, V31.S }[0x3], [X19], X25
    ADD  X19, X19, X22, ASR #0
    MOV  X16, X19
    ST4 { V3.D, V4.D, V5.D, V6.D }[0x1], [X16], #32
    MOV  X16, X19
    LD4 { V20.D, V21.D, V22.D, V23.D }[0x0], [X16], #32
    ADD  X19, X19, X22, ASR #0
    ST4 { V28.D, V29.D, V30.D, V31.D }[0x1], [X19], X25
    LD4 { V3.D, V4.D, V5.D, V6.D }[0x0], [X19], X25
    ADD  X19, X19, X22
    MOV  X16, X19
    ST4 { V12.B, V13.B, V14.B, V15.B }[0x9], [X16], #4
    MOV  X16, X19
    LD4 { V28.B, V29.B, V30.B, V31.B }[0x2], [X16], #4
    ADD  X19, X19, X22
    ST4 { V20.B, V21.B, V22.B, V23.B }[0xc], [X19], X25
    LD4 { V20.B, V21.B, V22.B, V23.B }[0x6], [X19], X25
    ADD  X19, X19, X22, LSR #0
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X26, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a, LSL #0
    MOVK  X17, #0x5a, LSL #16
    MOVK  X17, #0x5a, LSL #32
    MOVK  X17, #0x5a, LSL #48
    FMOV  X26, V0.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D0
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V1.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D1
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V2.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D2
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D3
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D4
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D5
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D6
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D7
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D8
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V9.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D9
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D10
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D11
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D12
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X26, V13.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D13
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X26, V14.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D14
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D15
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V16.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D16
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V17.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D17
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D18
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D19
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V20.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a, LSL #48
    FMOV  X26, D20
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V21.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, D21
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V22.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a, LSL #48
    FMOV  X26, D22
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a, LSL #0
    MOVK  X17, #0x5a, LSL #16
    MOVK  X17, #0x5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V23.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a, LSL #48
    FMOV  X26, D23
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V24.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D24
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D25
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D26
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D27
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V28.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a00, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D28
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V29.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a00, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D29
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V30.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a00, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D30
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, V31.D[1]
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a00, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X26, D31
    SUB  X12, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
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
    FMOV  V2.D[1], X29
    FMOV  D3, X7
    FMOV  V3.D[1], X27
    FMOV  D4, X25
    FMOV  V4.D[1], X21
    FMOV  D5, X20
    FMOV  V5.D[1], X8
    FMOV  D6, X5
    FMOV  V6.D[1], X4
    FMOV  D7, X9
    FMOV  V7.D[1], X5
    FMOV  D8, X21
    FMOV  V8.D[1], X8
    FMOV  D9, X26
    FMOV  V9.D[1], X25
    FMOV  D10, X25
    FMOV  V10.D[1], X17
    FMOV  D11, X16
    FMOV  V11.D[1], X3
    FMOV  D12, X29
    FMOV  V12.D[1], X18
    FMOV  D13, X20
    FMOV  V13.D[1], X5
    FMOV  D14, X16
    FMOV  V14.D[1], X3
    FMOV  D15, X27
    FMOV  V15.D[1], X27
    FMOV  D16, X26
    FMOV  V16.D[1], X24
    FMOV  D17, X22
    FMOV  V17.D[1], X23
    FMOV  D18, X22
    FMOV  V18.D[1], X21
    FMOV  D19, X17
    FMOV  V19.D[1], X27
    FMOV  D20, X8
    FMOV  V20.D[1], X29
    FMOV  D21, X17
    FMOV  V21.D[1], X26
    FMOV  D22, X6
    FMOV  V22.D[1], X27
    FMOV  D23, X4
    FMOV  V23.D[1], X19
    FMOV  D24, X16
    FMOV  V24.D[1], X12
    FMOV  D25, X3
    FMOV  V25.D[1], X13
    FMOV  D26, X27
    FMOV  V26.D[1], X8
    FMOV  D27, X28
    FMOV  V27.D[1], X7
    FMOV  D28, X13
    FMOV  V28.D[1], X29
    FMOV  D29, X20
    FMOV  V29.D[1], X10
    FMOV  D30, X4
    FMOV  V30.D[1], X5
    FMOV  D31, X16
    FMOV  V31.D[1], X20
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X25, #0x1900, LSL #0
    ADD  X26, X30, X25
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X26]
    LD4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X26]
    ADD  X26, X26, X17, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X26]
    LD4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X26]
    ADD  X26, X26, X17, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X26]
    LD4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X26]
    ADD  X26, X26, X17, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X26]
    LD4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X26]
    ADD  X26, X26, X17
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X26]
    LD4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X26]
    ADD  X26, X26, X17, ASR #0
    ST4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X26]
    LD4 { V14.2S, V15.2S, V16.2S, V17.2S }, [X26]
    ADD  X26, X26, X17, LSR #0
    ST4 { V14.2S, V15.2S, V16.2S, V17.2S }, [X26]
    LD4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X26]
    ADD  X26, X26, X17, LSR #0
    ST4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X26]
    LD4 { V18.4H, V19.4H, V20.4H, V21.4H }, [X26]
    ADD  X26, X26, X17
    ST4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X26]
    LD4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X26]
    ADD  X26, X26, X17, LSR #0
    MOV  X8, X26
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X8], #64
    MOV  X8, X26
    LD4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X8], #64
    ADD  X26, X26, X17
    MOV  X8, X26
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X8], #64
    MOV  X8, X26
    LD4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X8], #64
    ADD  X26, X26, X17, ASR #0
    MOV  X8, X26
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X8], #64
    MOV  X8, X26
    LD4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X8], #64
    ADD  X26, X26, X17, ASR #0
    MOV  X8, X26
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X8], #64
    MOV  X8, X26
    LD4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X8], #64
    ADD  X26, X26, X17
    MOV  X8, X26
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X8], #64
    MOV  X8, X26
    LD4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X8], #64
    ADD  X26, X26, X17
    MOV  X8, X26
    ST4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X8], #32
    MOV  X8, X26
    LD4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X8], #32
    ADD  X26, X26, X17, LSR #0
    MOV  X8, X26
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X8], #32
    MOV  X8, X26
    LD4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X8], #32
    ADD  X26, X26, X17, ASR #0
    MOV  X8, X26
    ST4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X8], #32
    MOV  X8, X26
    LD4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X8], #32
    ADD  X26, X26, X17
    MOV  X8, X26
    ST4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X8], #32
    MOV  X8, X26
    LD4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X8], #32
    ADD  X26, X26, X17, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X26], X24
    LD4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X26], X24
    ADD  X26, X26, X17, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X26], X24
    LD4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X26], X24
    ADD  X26, X26, X17, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X26], X24
    LD4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X26], X24
    ADD  X26, X26, X17, ASR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X26], X24
    LD4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X26], X24
    ADD  X26, X26, X17, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X26], X24
    LD4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X26], X24
    ADD  X26, X26, X17, LSR #0
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X26], X24
    LD4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X26], X24
    ADD  X26, X26, X17, ASR #0
    ST4 { V19.2S, V20.2S, V21.2S, V22.2S }, [X26], X24
    LD4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X26], X24
    ADD  X26, X26, X17
    ST4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X26], X24
    LD4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X26], X24
    ADD  X26, X26, X17
    ST4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X26], X24
    LD4 { V19.8B, V20.8B, V21.8B, V22.8B }, [X26], X24
    ADD  X26, X26, X17, ASR #0
    ST4 { V19.H, V20.H, V21.H, V22.H }[0x0], [X26]
    LD4 { V19.H, V20.H, V21.H, V22.H }[0x1], [X26]
    ADD  X26, X26, X17, ASR #0
    ST4 { V19.S, V20.S, V21.S, V22.S }[0x3], [X26]
    LD4 { V13.S, V14.S, V15.S, V16.S }[0x1], [X26]
    ADD  X26, X26, X17, ASR #0
    ST4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X26]
    LD4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X26]
    ADD  X26, X26, X17
    ST4 { V13.B, V14.B, V15.B, V16.B }[0x6], [X26]
    LD4 { V19.B, V20.B, V21.B, V22.B }[0x2], [X26]
    ADD  X26, X26, X17, LSR #0
    MOV  X8, X26
    ST4 { V19.H, V20.H, V21.H, V22.H }[0x5], [X8], #8
    MOV  X8, X26
    LD4 { V13.H, V14.H, V15.H, V16.H }[0x5], [X8], #8
    ADD  X26, X26, X17
    ST4 { V13.H, V14.H, V15.H, V16.H }[0x6], [X26], X24
    LD4 { V19.H, V20.H, V21.H, V22.H }[0x3], [X26], X24
    ADD  X26, X26, X17, ASR #0
    MOV  X8, X26
    ST4 { V19.S, V20.S, V21.S, V22.S }[0x2], [X8], #16
    MOV  X8, X26
    LD4 { V19.S, V20.S, V21.S, V22.S }[0x3], [X8], #16
    ADD  X26, X26, X17, LSR #0
    ST4 { V19.S, V20.S, V21.S, V22.S }[0x0], [X26], X24
    LD4 { V19.S, V20.S, V21.S, V22.S }[0x0], [X26], X24
    ADD  X26, X26, X17, LSR #0
    MOV  X8, X26
    ST4 { V19.D, V20.D, V21.D, V22.D }[0x1], [X8], #32
    MOV  X8, X26
    LD4 { V13.D, V14.D, V15.D, V16.D }[0x0], [X8], #32
    ADD  X26, X26, X17
    ST4 { V0.D, V1.D, V2.D, V3.D }[0x1], [X26], X24
    LD4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X26], X24
    ADD  X26, X26, X17, LSR #0
    MOV  X8, X26
    ST4 { V11.B, V12.B, V13.B, V14.B }[0x2], [X8], #4
    MOV  X8, X26
    LD4 { V12.B, V13.B, V14.B, V15.B }[0x1], [X8], #4
    ADD  X26, X26, X17, LSR #0
    ST4 { V12.B, V13.B, V14.B, V15.B }[0x6], [X26], X24
    LD4 { V19.B, V20.B, V21.B, V22.B }[0xa], [X26], X24
    ADD  X26, X26, X17
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X20, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    MRS  X20, FPSR
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V0.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, D0
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, V1.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D1
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, V2.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D2
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, V3.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D3
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, V4.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D4
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, V5.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D5
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V6.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D6
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V7.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D7
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V8.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D8
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V9.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D9
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V10.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D10
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V11.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D11
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V12.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D12
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V13.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa500, LSL #0
    FMOV  X20, D13
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V14.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, D14
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V15.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, D15
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V16.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, D16
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V17.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D17
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V18.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D18
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    MOVK  X5, #0xa5, LSL #16
    FMOV  X20, V19.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa500, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    FMOV  X20, D19
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V20.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa500, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    FMOV  X20, D20
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V21.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa500, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    FMOV  X20, D21
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V22.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa500, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    FMOV  X20, D22
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, V23.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D23
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, V24.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D24
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, V25.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D25
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V26.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D26
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V27.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D27
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V28.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D28
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D29
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D30
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x0, LSL #0
    FMOV  X20, V31.D[1]
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    FMOV  X20, D31
    SUB  X10, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X23
    FMOV  D3, X24
    FMOV  V3.D[1], X9
    FMOV  D4, X3
    FMOV  V4.D[1], X20
    FMOV  D5, X19
    FMOV  V5.D[1], X21
    FMOV  D6, X13
    FMOV  V6.D[1], X13
    FMOV  D7, X29
    FMOV  V7.D[1], X29
    FMOV  D8, X28
    FMOV  V8.D[1], X20
    FMOV  D9, X27
    FMOV  V9.D[1], X16
    FMOV  D10, X27
    FMOV  V10.D[1], X13
    FMOV  D11, X28
    FMOV  V11.D[1], X7
    FMOV  D12, X23
    FMOV  V12.D[1], X5
    FMOV  D13, X13
    FMOV  V13.D[1], X27
    FMOV  D14, X19
    FMOV  V14.D[1], X13
    FMOV  D15, X21
    FMOV  V15.D[1], X5
    FMOV  D16, X23
    FMOV  V16.D[1], X25
    FMOV  D17, X5
    FMOV  V17.D[1], X28
    FMOV  D18, X6
    FMOV  V18.D[1], X28
    FMOV  D19, X23
    FMOV  V19.D[1], X27
    FMOV  D20, X26
    FMOV  V20.D[1], X22
    FMOV  D21, X5
    FMOV  V21.D[1], X17
    FMOV  D22, X17
    FMOV  V22.D[1], X19
    FMOV  D23, X29
    FMOV  V23.D[1], X6
    FMOV  D24, X12
    FMOV  V24.D[1], X12
    FMOV  D25, X8
    FMOV  V25.D[1], X25
    FMOV  D26, X27
    FMOV  V26.D[1], X29
    FMOV  D27, X22
    FMOV  V27.D[1], X12
    FMOV  D28, X21
    FMOV  V28.D[1], X21
    FMOV  D29, X26
    FMOV  V29.D[1], X26
    FMOV  D30, X16
    FMOV  V30.D[1], X19
    FMOV  D31, X25
    FMOV  V31.D[1], X8
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X28, #0x1e00, LSL #0
    ADD  X26, X30, X28
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X26]
    LD4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X26]
    ADD  X26, X26, X25, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X26]
    LD4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X26]
    ADD  X26, X26, X25
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X26]
    LD4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X26]
    ADD  X26, X26, X25, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X26]
    LD4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X26]
    ADD  X26, X26, X25
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X26]
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X26]
    ADD  X26, X26, X25
    ST4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X26]
    LD4 { V18.4H, V19.4H, V20.4H, V21.4H }, [X26]
    ADD  X26, X26, X25, ASR #0
    ST4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X26]
    LD4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X26]
    ADD  X26, X26, X25, LSR #0
    ST4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X26]
    LD4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X26]
    ADD  X26, X26, X25
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X26]
    LD4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X26]
    ADD  X26, X26, X25, LSR #0
    MOV  X16, X26
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X16], #64
    MOV  X16, X26
    LD4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X16], #64
    ADD  X26, X26, X25, LSR #0
    MOV  X16, X26
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X16], #64
    MOV  X16, X26
    LD4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X16], #64
    ADD  X26, X26, X25, ASR #0
    MOV  X16, X26
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X16], #64
    MOV  X16, X26
    LD4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X16], #64
    ADD  X26, X26, X25, LSR #0
    MOV  X16, X26
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X16], #64
    MOV  X16, X26
    LD4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X16], #64
    ADD  X26, X26, X25, ASR #0
    MOV  X16, X26
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X16], #64
    MOV  X16, X26
    LD4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X16], #64
    ADD  X26, X26, X25, LSR #0
    MOV  X16, X26
    ST4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X16], #32
    MOV  X16, X26
    LD4 { V6.4H, V7.4H, V8.4H, V9.4H }, [X16], #32
    ADD  X26, X26, X25, ASR #0
    MOV  X16, X26
    ST4 { V0.2S, V1.2S, V2.2S, V3.2S }, [X16], #32
    MOV  X16, X26
    LD4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X16], #32
    ADD  X26, X26, X25, ASR #0
    MOV  X16, X26
    ST4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X16], #32
    MOV  X16, X26
    LD4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X16], #32
    ADD  X26, X26, X25, ASR #0
    MOV  X16, X26
    ST4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X16], #32
    MOV  X16, X26
    LD4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X16], #32
    ADD  X26, X26, X25, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X26], X22
    LD4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X26], X22
    ADD  X26, X26, X25, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X26], X22
    LD4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X26], X22
    ADD  X26, X26, X25
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X26], X22
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X26], X22
    ADD  X26, X26, X25
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X26], X22
    LD4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X26], X22
    ADD  X26, X26, X25, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X26], X22
    LD4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X26], X22
    ADD  X26, X26, X25, LSR #0
    ST4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X26], X22
    LD4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X26], X22
    ADD  X26, X26, X25, LSR #0
    ST4 { V19.2S, V20.2S, V21.2S, V22.2S }, [X26], X22
    LD4 { V19.2S, V20.2S, V21.2S, V22.2S }, [X26], X22
    ADD  X26, X26, X25, LSR #0
    ST4 { V6.4H, V7.4H, V8.4H, V9.4H }, [X26], X22
    LD4 { V4.4H, V5.4H, V6.4H, V7.4H }, [X26], X22
    ADD  X26, X26, X25
    ST4 { V4.8B, V5.8B, V6.8B, V7.8B }, [X26], X22
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X26], X22
    ADD  X26, X26, X25, ASR #0
    ST4 { V21.H, V22.H, V23.H, V24.H }[0x1], [X26]
    LD4 { V16.H, V17.H, V18.H, V19.H }[0x4], [X26]
    ADD  X26, X26, X25
    ST4 { V15.S, V16.S, V17.S, V18.S }[0x0], [X26]
    LD4 { V6.S, V7.S, V8.S, V9.S }[0x2], [X26]
    ADD  X26, X26, X25, ASR #0
    ST4 { V8.D, V9.D, V10.D, V11.D }[0x0], [X26]
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x0], [X26]
    ADD  X26, X26, X25, LSR #0
    ST4 { V10.B, V11.B, V12.B, V13.B }[0xb], [X26]
    LD4 { V10.B, V11.B, V12.B, V13.B }[0xd], [X26]
    ADD  X26, X26, X25, ASR #0
    MOV  X16, X26
    ST4 { V10.H, V11.H, V12.H, V13.H }[0x1], [X16], #8
    MOV  X16, X26
    LD4 { V8.H, V9.H, V10.H, V11.H }[0x4], [X16], #8
    ADD  X26, X26, X25, ASR #0
    ST4 { V26.H, V27.H, V28.H, V29.H }[0x0], [X26], X22
    LD4 { V26.H, V27.H, V28.H, V29.H }[0x0], [X26], X22
    ADD  X26, X26, X25, ASR #0
    MOV  X16, X26
    ST4 { V6.S, V7.S, V8.S, V9.S }[0x0], [X16], #16
    MOV  X16, X26
    LD4 { V15.S, V16.S, V17.S, V18.S }[0x3], [X16], #16
    ADD  X26, X26, X25, LSR #0
    ST4 { V4.S, V5.S, V6.S, V7.S }[0x0], [X26], X22
    LD4 { V5.S, V6.S, V7.S, V8.S }[0x2], [X26], X22
    ADD  X26, X26, X25, LSR #0
    MOV  X16, X26
    ST4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X16], #32
    MOV  X16, X26
    LD4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X16], #32
    ADD  X26, X26, X25, LSR #0
    ST4 { V15.D, V16.D, V17.D, V18.D }[0x1], [X26], X22
    LD4 { V15.D, V16.D, V17.D, V18.D }[0x0], [X26], X22
    ADD  X26, X26, X25, ASR #0
    MOV  X16, X26
    ST4 { V5.B, V6.B, V7.B, V8.B }[0xb], [X16], #4
    MOV  X16, X26
    LD4 { V6.B, V7.B, V8.B, V9.B }[0x9], [X16], #4
    ADD  X26, X26, X25
    ST4 { V15.B, V16.B, V17.B, V18.B }[0x2], [X26], X22
    LD4 { V15.B, V16.B, V17.B, V18.B }[0x3], [X26], X22
    ADD  X26, X26, X25, LSR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X4, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X4, FPSR
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V0.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D0
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V1.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D1
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V2.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D2
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V3.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D3
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V4.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D4
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    FMOV  X4, V5.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D5
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    FMOV  X4, V6.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D6
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    FMOV  X4, V7.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D7
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V8.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D8
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V9.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D9
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V10.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D10
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V11.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D11
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V12.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D12
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V13.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D13
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V14.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D14
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V15.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D15
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V16.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D16
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V17.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D17
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V18.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D18
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    FMOV  X4, V19.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D19
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V20.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D20
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V21.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D21
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V22.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D22
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V23.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D23
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V24.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D24
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V25.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D25
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V26.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D26
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V27.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D27
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V28.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D28
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V29.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D29
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, V30.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D30
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X4, V31.D[1]
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X4, D31
    SUB  X8, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X29
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X24
    FMOV  V2.D[1], X6
    FMOV  D3, X24
    FMOV  V3.D[1], X26
    FMOV  D4, X7
    FMOV  V4.D[1], X3
    FMOV  D5, X16
    FMOV  V5.D[1], X13
    FMOV  D6, X28
    FMOV  V6.D[1], X16
    FMOV  D7, X13
    FMOV  V7.D[1], X25
    FMOV  D8, X27
    FMOV  V8.D[1], X26
    FMOV  D9, X27
    FMOV  V9.D[1], X29
    FMOV  D10, X19
    FMOV  V10.D[1], X13
    FMOV  D11, X24
    FMOV  V11.D[1], X9
    FMOV  D12, X9
    FMOV  V12.D[1], X4
    FMOV  D13, X22
    FMOV  V13.D[1], X8
    FMOV  D14, X28
    FMOV  V14.D[1], X26
    FMOV  D15, X20
    FMOV  V15.D[1], X4
    FMOV  D16, X5
    FMOV  V16.D[1], X8
    FMOV  D17, X28
    FMOV  V17.D[1], X29
    FMOV  D18, X29
    FMOV  V18.D[1], X29
    FMOV  D19, X24
    FMOV  V19.D[1], X20
    FMOV  D20, X12
    FMOV  V20.D[1], X8
    FMOV  D21, X16
    FMOV  V21.D[1], X12
    FMOV  D22, X18
    FMOV  V22.D[1], X4
    FMOV  D23, X16
    FMOV  V23.D[1], X24
    FMOV  D24, X22
    FMOV  V24.D[1], X23
    FMOV  D25, X12
    FMOV  V25.D[1], X3
    FMOV  D26, X25
    FMOV  V26.D[1], X17
    FMOV  D27, X20
    FMOV  V27.D[1], X10
    FMOV  D28, X29
    FMOV  V28.D[1], X18
    FMOV  D29, X19
    FMOV  V29.D[1], X24
    FMOV  D30, X13
    FMOV  V30.D[1], X13
    FMOV  D31, X4
    FMOV  V31.D[1], X8
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X22, #0x2300, LSL #0
    ADD  X7, X30, X22, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X7]
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X7]
    ADD  X7, X7, X8, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X7]
    LD4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X7]
    ADD  X7, X7, X8, ASR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X7]
    LD4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X7]
    ADD  X7, X7, X8
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X7]
    LD4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X7]
    ADD  X7, X7, X8
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X7]
    LD4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X7]
    ADD  X7, X7, X8, LSR #0
    ST4 { V19.8B, V20.8B, V21.8B, V22.8B }, [X7]
    LD4 { V11.2S, V12.2S, V13.2S, V14.2S }, [X7]
    ADD  X7, X7, X8
    ST4 { V11.2S, V12.2S, V13.2S, V14.2S }, [X7]
    LD4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X7]
    ADD  X7, X7, X8, ASR #0
    ST4 { V2.4H, V3.4H, V4.4H, V5.4H }, [X7]
    LD4 { V11.4H, V12.4H, V13.4H, V14.4H }, [X7]
    ADD  X7, X7, X8
    ST4 { V11.8B, V12.8B, V13.8B, V14.8B }, [X7]
    LD4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X7]
    ADD  X7, X7, X8
    MOV  X27, X7
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X27], #64
    MOV  X27, X7
    LD4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X27], #64
    ADD  X7, X7, X8, ASR #0
    MOV  X27, X7
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X27], #64
    MOV  X27, X7
    LD4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X27], #64
    ADD  X7, X7, X8
    MOV  X27, X7
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X27], #64
    MOV  X27, X7
    LD4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X27], #64
    ADD  X7, X7, X8, ASR #0
    MOV  X27, X7
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X27], #64
    MOV  X27, X7
    LD4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X27], #64
    ADD  X7, X7, X8, ASR #0
    MOV  X27, X7
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X27], #64
    MOV  X27, X7
    LD4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X27], #64
    ADD  X7, X7, X8, LSR #0
    MOV  X27, X7
    ST4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X27], #32
    MOV  X27, X7
    LD4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X27], #32
    ADD  X7, X7, X8, ASR #0
    MOV  X27, X7
    ST4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X27], #32
    MOV  X27, X7
    LD4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X27], #32
    ADD  X7, X7, X8, LSR #0
    MOV  X27, X7
    ST4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X27], #32
    MOV  X27, X7
    LD4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X27], #32
    ADD  X7, X7, X8, ASR #0
    MOV  X27, X7
    ST4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X27], #32
    MOV  X27, X7
    LD4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X27], #32
    ADD  X7, X7, X8, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X7], X6
    LD4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X7], X6
    ADD  X7, X7, X8, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X7], X6
    LD4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X7], X6
    ADD  X7, X7, X8
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X7], X6
    LD4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X7], X6
    ADD  X7, X7, X8, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X7], X6
    LD4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X7], X6
    ADD  X7, X7, X8, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X7], X6
    LD4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X7], X6
    ADD  X7, X7, X8
    ST4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X7], X6
    LD4 { V22.8B, V23.8B, V24.8B, V25.8B }, [X7], X6
    ADD  X7, X7, X8, LSR #0
    ST4 { V5.2S, V6.2S, V7.2S, V8.2S }, [X7], X6
    LD4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X7], X6
    ADD  X7, X7, X8, LSR #0
    ST4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X7], X6
    LD4 { V12.4H, V13.4H, V14.4H, V15.4H }, [X7], X6
    ADD  X7, X7, X8, ASR #0
    ST4 { V22.8B, V23.8B, V24.8B, V25.8B }, [X7], X6
    LD4 { V9.8B, V10.8B, V11.8B, V12.8B }, [X7], X6
    ADD  X7, X7, X8, ASR #0
    ST4 { V14.H, V15.H, V16.H, V17.H }[0x3], [X7]
    LD4 { V5.H, V6.H, V7.H, V8.H }[0x7], [X7]
    ADD  X7, X7, X8, LSR #0
    ST4 { V8.S, V9.S, V10.S, V11.S }[0x1], [X7]
    LD4 { V29.S, V30.S, V31.S, V0.S }[0x2], [X7]
    ADD  X7, X7, X8
    ST4 { V7.D, V8.D, V9.D, V10.D }[0x1], [X7]
    LD4 { V7.D, V8.D, V9.D, V10.D }[0x0], [X7]
    ADD  X7, X7, X8, ASR #0
    ST4 { V5.B, V6.B, V7.B, V8.B }[0x4], [X7]
    LD4 { V31.B, V0.B, V1.B, V2.B }[0x4], [X7]
    ADD  X7, X7, X8
    MOV  X27, X7
    ST4 { V29.H, V30.H, V31.H, V0.H }[0x3], [X27], #8
    MOV  X27, X7
    LD4 { V20.H, V21.H, V22.H, V23.H }[0x3], [X27], #8
    ADD  X7, X7, X8, LSR #0
    ST4 { V20.H, V21.H, V22.H, V23.H }[0x5], [X7], X6
    LD4 { V14.H, V15.H, V16.H, V17.H }[0x7], [X7], X6
    ADD  X7, X7, X8, ASR #0
    MOV  X27, X7
    ST4 { V14.S, V15.S, V16.S, V17.S }[0x3], [X27], #16
    MOV  X27, X7
    LD4 { V29.S, V30.S, V31.S, V0.S }[0x0], [X27], #16
    ADD  X7, X7, X8
    ST4 { V30.S, V31.S, V0.S, V1.S }[0x3], [X7], X6
    LD4 { V5.S, V6.S, V7.S, V8.S }[0x0], [X7], X6
    ADD  X7, X7, X8
    MOV  X27, X7
    ST4 { V21.D, V22.D, V23.D, V24.D }[0x1], [X27], #32
    MOV  X27, X7
    LD4 { V14.D, V15.D, V16.D, V17.D }[0x1], [X27], #32
    ADD  X7, X7, X8, LSR #0
    ST4 { V5.D, V6.D, V7.D, V8.D }[0x0], [X7], X6
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x0], [X7], X6
    ADD  X7, X7, X8, ASR #0
    MOV  X27, X7
    ST4 { V14.B, V15.B, V16.B, V17.B }[0xf], [X27], #4
    MOV  X27, X7
    LD4 { V14.B, V15.B, V16.B, V17.B }[0xf], [X27], #4
    ADD  X7, X7, X8
    ST4 { V14.B, V15.B, V16.B, V17.B }[0x7], [X7], X6
    LD4 { V30.B, V31.B, V0.B, V1.B }[0x3], [X7], X6
    ADD  X7, X7, X8
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X3, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X3, FPSR
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    FMOV  X3, V0.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa500, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D0
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D1
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D2
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, V3.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D3
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D4
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, V5.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D5
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, V6.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D6
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, V7.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D7
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, V8.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D8
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D9
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D11
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V12.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D12
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V13.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D13
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V14.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D14
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D15
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D16
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D17
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, V18.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D18
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, V19.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D19
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V20.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D20
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D21
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D22
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D23
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D24
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D25
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D26
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D27
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, V28.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D28
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, V29.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D29
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    FMOV  X3, V30.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa500, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D30
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    FMOV  X3, V31.D[1]
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa500, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X3, D31
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X4
    FMOV  D3, X24
    FMOV  V3.D[1], X17
    FMOV  D4, X21
    FMOV  V4.D[1], X26
    FMOV  D5, X5
    FMOV  V5.D[1], X10
    FMOV  D6, X18
    FMOV  V6.D[1], X24
    FMOV  D7, X18
    FMOV  V7.D[1], X20
    FMOV  D8, X26
    FMOV  V8.D[1], X6
    FMOV  D9, X20
    FMOV  V9.D[1], X26
    FMOV  D10, X19
    FMOV  V10.D[1], X10
    FMOV  D11, X10
    FMOV  V11.D[1], X9
    FMOV  D12, X26
    FMOV  V12.D[1], X20
    FMOV  D13, X22
    FMOV  V13.D[1], X18
    FMOV  D14, X22
    FMOV  V14.D[1], X16
    FMOV  D15, X8
    FMOV  V15.D[1], X16
    FMOV  D16, X13
    FMOV  V16.D[1], X25
    FMOV  D17, X23
    FMOV  V17.D[1], X8
    FMOV  D18, X29
    FMOV  V18.D[1], X24
    FMOV  D19, X5
    FMOV  V19.D[1], X10
    FMOV  D20, X9
    FMOV  V20.D[1], X17
    FMOV  D21, X6
    FMOV  V21.D[1], X29
    FMOV  D22, X26
    FMOV  V22.D[1], X3
    FMOV  D23, X4
    FMOV  V23.D[1], X28
    FMOV  D24, X5
    FMOV  V24.D[1], X10
    FMOV  D25, X27
    FMOV  V25.D[1], X29
    FMOV  D26, X24
    FMOV  V26.D[1], X3
    FMOV  D27, X19
    FMOV  V27.D[1], X24
    FMOV  D28, X19
    FMOV  V28.D[1], X6
    FMOV  D29, X5
    FMOV  V29.D[1], X27
    FMOV  D30, X3
    FMOV  V30.D[1], X4
    FMOV  D31, X25
    FMOV  V31.D[1], X25
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X23, #0x2800, LSL #0
    ADD  X4, X30, X23, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X4]
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X4]
    ADD  X4, X4, X25, ASR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X4]
    LD4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X4]
    ADD  X4, X4, X25, ASR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X4]
    LD4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X4]
    ADD  X4, X4, X25, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X4]
    LD4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X4]
    ADD  X4, X4, X25, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X4]
    LD4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X4]
    ADD  X4, X4, X25, ASR #0
    ST4 { V9.8B, V10.8B, V11.8B, V12.8B }, [X4]
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X4]
    ADD  X4, X4, X25
    ST4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X4]
    LD4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X4]
    ADD  X4, X4, X25
    ST4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X4]
    LD4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X4]
    ADD  X4, X4, X25, LSR #0
    ST4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X4]
    LD4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X4]
    ADD  X4, X4, X25, ASR #0
    MOV  X21, X4
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X21], #64
    MOV  X21, X4
    LD4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X21], #64
    ADD  X4, X4, X25
    MOV  X21, X4
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X21], #64
    MOV  X21, X4
    LD4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X21], #64
    ADD  X4, X4, X25, ASR #0
    MOV  X21, X4
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X21], #64
    MOV  X21, X4
    LD4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X21], #64
    ADD  X4, X4, X25, ASR #0
    MOV  X21, X4
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X21], #64
    MOV  X21, X4
    LD4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X21], #64
    ADD  X4, X4, X25, ASR #0
    MOV  X21, X4
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X21], #64
    MOV  X21, X4
    LD4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X21], #64
    ADD  X4, X4, X25, ASR #0
    MOV  X21, X4
    ST4 { V15.8B, V16.8B, V17.8B, V18.8B }, [X21], #32
    MOV  X21, X4
    LD4 { V27.4H, V28.4H, V29.4H, V30.4H }, [X21], #32
    ADD  X4, X4, X25, ASR #0
    MOV  X21, X4
    ST4 { V15.2S, V16.2S, V17.2S, V18.2S }, [X21], #32
    MOV  X21, X4
    LD4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X21], #32
    ADD  X4, X4, X25, ASR #0
    MOV  X21, X4
    ST4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X21], #32
    MOV  X21, X4
    LD4 { V1.4H, V2.4H, V3.4H, V4.4H }, [X21], #32
    ADD  X4, X4, X25
    MOV  X21, X4
    ST4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X21], #32
    MOV  X21, X4
    LD4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X21], #32
    ADD  X4, X4, X25
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X4], X7
    LD4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X4], X7
    ADD  X4, X4, X25, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X4], X7
    LD4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X4], X7
    ADD  X4, X4, X25
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X4], X7
    LD4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X4], X7
    ADD  X4, X4, X25, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X4], X7
    LD4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X4], X7
    ADD  X4, X4, X25, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X4], X7
    LD4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X4], X7
    ADD  X4, X4, X25
    ST4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X4], X7
    LD4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X4], X7
    ADD  X4, X4, X25
    ST4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X4], X7
    LD4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X4], X7
    ADD  X4, X4, X25, LSR #0
    ST4 { V15.4H, V16.4H, V17.4H, V18.4H }, [X4], X7
    LD4 { V24.4H, V25.4H, V26.4H, V27.4H }, [X4], X7
    ADD  X4, X4, X25, LSR #0
    ST4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X4], X7
    LD4 { V27.8B, V28.8B, V29.8B, V30.8B }, [X4], X7
    ADD  X4, X4, X25, LSR #0
    ST4 { V27.H, V28.H, V29.H, V30.H }[0x4], [X4]
    LD4 { V24.H, V25.H, V26.H, V27.H }[0x3], [X4]
    ADD  X4, X4, X25, ASR #0
    ST4 { V24.S, V25.S, V26.S, V27.S }[0x1], [X4]
    LD4 { V8.S, V9.S, V10.S, V11.S }[0x1], [X4]
    ADD  X4, X4, X25
    ST4 { V8.D, V9.D, V10.D, V11.D }[0x1], [X4]
    LD4 { V3.D, V4.D, V5.D, V6.D }[0x0], [X4]
    ADD  X4, X4, X25, LSR #0
    ST4 { V2.B, V3.B, V4.B, V5.B }[0x4], [X4]
    LD4 { V2.B, V3.B, V4.B, V5.B }[0x8], [X4]
    ADD  X4, X4, X25
    MOV  X21, X4
    ST4 { V2.H, V3.H, V4.H, V5.H }[0x4], [X21], #8
    MOV  X21, X4
    LD4 { V26.H, V27.H, V28.H, V29.H }[0x0], [X21], #8
    ADD  X4, X4, X25, LSR #0
    ST4 { V26.H, V27.H, V28.H, V29.H }[0x3], [X4], X7
    LD4 { V8.H, V9.H, V10.H, V11.H }[0x2], [X4], X7
    ADD  X4, X4, X25, ASR #0
    MOV  X21, X4
    ST4 { V13.S, V14.S, V15.S, V16.S }[0x0], [X21], #16
    MOV  X21, X4
    LD4 { V4.S, V5.S, V6.S, V7.S }[0x2], [X21], #16
    ADD  X4, X4, X25, ASR #0
    ST4 { V8.S, V9.S, V10.S, V11.S }[0x0], [X4], X7
    LD4 { V8.S, V9.S, V10.S, V11.S }[0x2], [X4], X7
    ADD  X4, X4, X25, ASR #0
    MOV  X21, X4
    ST4 { V8.D, V9.D, V10.D, V11.D }[0x1], [X21], #32
    MOV  X21, X4
    LD4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X21], #32
    ADD  X4, X4, X25, ASR #0
    ST4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X4], X7
    LD4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X4], X7
    ADD  X4, X4, X25, LSR #0
    MOV  X21, X4
    ST4 { V26.B, V27.B, V28.B, V29.B }[0x7], [X21], #4
    MOV  X21, X4
    LD4 { V8.B, V9.B, V10.B, V11.B }[0x9], [X21], #4
    ADD  X4, X4, X25
    ST4 { V4.B, V5.B, V6.B, V7.B }[0x7], [X4], X7
    LD4 { V26.B, V27.B, V28.B, V29.B }[0x7], [X4], X7
    ADD  X4, X4, X25
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X3, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    MRS  X3, FPSR
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V0.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D0
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V1.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D1
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D2
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D3
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X3, V4.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, D4
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V5.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D5
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V6.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D6
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X3, V7.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D7
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X3, V8.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X3, D8
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X3, V9.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X3, D9
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V10.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    FMOV  X3, D10
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V11.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    FMOV  X3, D11
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V12.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D12
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V13.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D13
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V14.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D14
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V15.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D15
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V16.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D16
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D17
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V18.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D18
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V19.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D19
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V20.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D20
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V21.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D21
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V22.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D22
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, V23.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D23
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    FMOV  X3, D24
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    FMOV  X3, D25
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    FMOV  X3, D26
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a00, LSL #48
    FMOV  X3, D27
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D28
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V29.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D29
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V30.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D30
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x0, LSL #0
    FMOV  X3, V31.D[1]
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    FMOV  X3, D31
    SUB  X10, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
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
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X23
    FMOV  D3, X3
    FMOV  V3.D[1], X12
    FMOV  D4, X10
    FMOV  V4.D[1], X7
    FMOV  D5, X6
    FMOV  V5.D[1], X23
    FMOV  D6, X5
    FMOV  V6.D[1], X18
    FMOV  D7, X12
    FMOV  V7.D[1], X18
    FMOV  D8, X5
    FMOV  V8.D[1], X13
    FMOV  D9, X3
    FMOV  V9.D[1], X3
    FMOV  D10, X25
    FMOV  V10.D[1], X19
    FMOV  D11, X18
    FMOV  V11.D[1], X28
    FMOV  D12, X20
    FMOV  V12.D[1], X6
    FMOV  D13, X23
    FMOV  V13.D[1], X8
    FMOV  D14, X20
    FMOV  V14.D[1], X17
    FMOV  D15, X13
    FMOV  V15.D[1], X23
    FMOV  D16, X26
    FMOV  V16.D[1], X6
    FMOV  D17, X19
    FMOV  V17.D[1], X9
    FMOV  D18, X17
    FMOV  V18.D[1], X8
    FMOV  D19, X3
    FMOV  V19.D[1], X22
    FMOV  D20, X17
    FMOV  V20.D[1], X19
    FMOV  D21, X19
    FMOV  V21.D[1], X4
    FMOV  D22, X13
    FMOV  V22.D[1], X8
    FMOV  D23, X7
    FMOV  V23.D[1], X6
    FMOV  D24, X6
    FMOV  V24.D[1], X12
    FMOV  D25, X20
    FMOV  V25.D[1], X3
    FMOV  D26, X7
    FMOV  V26.D[1], X12
    FMOV  D27, X26
    FMOV  V27.D[1], X28
    FMOV  D28, X18
    FMOV  V28.D[1], X21
    FMOV  D29, X6
    FMOV  V29.D[1], X4
    FMOV  D30, X8
    FMOV  V30.D[1], X8
    FMOV  D31, X26
    FMOV  V31.D[1], X9
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X26, #0x2d00, LSL #0
    ADD  X27, X30, X26
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X27]
    LD4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X27]
    ADD  X27, X27, X6, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X27]
    LD4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X27]
    ADD  X27, X27, X6
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X27]
    LD4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X27]
    ADD  X27, X27, X6, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X27]
    LD4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X27]
    ADD  X27, X27, X6, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X27]
    LD4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X27]
    ADD  X27, X27, X6, LSR #0
    ST4 { V6.4H, V7.4H, V8.4H, V9.4H }, [X27]
    LD4 { V22.4H, V23.4H, V24.4H, V25.4H }, [X27]
    ADD  X27, X27, X6
    ST4 { V14.2S, V15.2S, V16.2S, V17.2S }, [X27]
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X27]
    ADD  X27, X27, X6
    ST4 { V17.4H, V18.4H, V19.4H, V20.4H }, [X27]
    LD4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X27]
    ADD  X27, X27, X6, LSR #0
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X27]
    LD4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X27]
    ADD  X27, X27, X6, LSR #0
    MOV  X25, X27
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X25], #64
    MOV  X25, X27
    LD4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X25], #64
    ADD  X27, X27, X6, LSR #0
    MOV  X25, X27
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X25], #64
    MOV  X25, X27
    LD4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X25], #64
    ADD  X27, X27, X6
    MOV  X25, X27
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X25], #64
    MOV  X25, X27
    LD4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X25], #64
    ADD  X27, X27, X6
    MOV  X25, X27
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X25], #64
    MOV  X25, X27
    LD4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X25], #64
    ADD  X27, X27, X6
    MOV  X25, X27
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X25], #64
    MOV  X25, X27
    LD4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X25], #64
    ADD  X27, X27, X6, ASR #0
    MOV  X25, X27
    ST4 { V1.4H, V2.4H, V3.4H, V4.4H }, [X25], #32
    MOV  X25, X27
    LD4 { V18.4H, V19.4H, V20.4H, V21.4H }, [X25], #32
    ADD  X27, X27, X6, ASR #0
    MOV  X25, X27
    ST4 { V18.2S, V19.2S, V20.2S, V21.2S }, [X25], #32
    MOV  X25, X27
    LD4 { V21.2S, V22.2S, V23.2S, V24.2S }, [X25], #32
    ADD  X27, X27, X6, LSR #0
    MOV  X25, X27
    ST4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X25], #32
    MOV  X25, X27
    LD4 { V1.4H, V2.4H, V3.4H, V4.4H }, [X25], #32
    ADD  X27, X27, X6, LSR #0
    MOV  X25, X27
    ST4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X25], #32
    MOV  X25, X27
    LD4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X25], #32
    ADD  X27, X27, X6, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X27], X20
    LD4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X27], X20
    ADD  X27, X27, X6, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X27], X20
    LD4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X27], X20
    ADD  X27, X27, X6, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X27], X20
    LD4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X27], X20
    ADD  X27, X27, X6, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X27], X20
    LD4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X27], X20
    ADD  X27, X27, X6, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X27], X20
    LD4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X27], X20
    ADD  X27, X27, X6
    ST4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X27], X20
    LD4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X27], X20
    ADD  X27, X27, X6, LSR #0
    ST4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X27], X20
    LD4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X27], X20
    ADD  X27, X27, X6, ASR #0
    ST4 { V27.4H, V28.4H, V29.4H, V30.4H }, [X27], X20
    LD4 { V27.4H, V28.4H, V29.4H, V30.4H }, [X27], X20
    ADD  X27, X27, X6
    ST4 { V27.8B, V28.8B, V29.8B, V30.8B }, [X27], X20
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X27], X20
    ADD  X27, X27, X6
    ST4 { V28.H, V29.H, V30.H, V31.H }[0x5], [X27]
    LD4 { V27.H, V28.H, V29.H, V30.H }[0x3], [X27]
    ADD  X27, X27, X6
    ST4 { V1.S, V2.S, V3.S, V4.S }[0x1], [X27]
    LD4 { V28.S, V29.S, V30.S, V31.S }[0x1], [X27]
    ADD  X27, X27, X6, ASR #0
    ST4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X27]
    LD4 { V19.D, V20.D, V21.D, V22.D }[0x1], [X27]
    ADD  X27, X27, X6
    ST4 { V19.B, V20.B, V21.B, V22.B }[0xe], [X27]
    LD4 { V25.B, V26.B, V27.B, V28.B }[0xc], [X27]
    ADD  X27, X27, X6
    MOV  X25, X27
    ST4 { V7.H, V8.H, V9.H, V10.H }[0x3], [X25], #8
    MOV  X25, X27
    LD4 { V25.H, V26.H, V27.H, V28.H }[0x0], [X25], #8
    ADD  X27, X27, X6, LSR #0
    ST4 { V25.H, V26.H, V27.H, V28.H }[0x7], [X27], X20
    LD4 { V7.H, V8.H, V9.H, V10.H }[0x3], [X27], X20
    ADD  X27, X27, X6, LSR #0
    MOV  X25, X27
    ST4 { V7.S, V8.S, V9.S, V10.S }[0x1], [X25], #16
    MOV  X25, X27
    LD4 { V1.S, V2.S, V3.S, V4.S }[0x3], [X25], #16
    ADD  X27, X27, X6, LSR #0
    ST4 { V1.S, V2.S, V3.S, V4.S }[0x1], [X27], X20
    LD4 { V25.S, V26.S, V27.S, V28.S }[0x0], [X27], X20
    ADD  X27, X27, X6, LSR #0
    MOV  X25, X27
    ST4 { V25.D, V26.D, V27.D, V28.D }[0x0], [X25], #32
    MOV  X25, X27
    LD4 { V25.D, V26.D, V27.D, V28.D }[0x0], [X25], #32
    ADD  X27, X27, X6
    ST4 { V25.D, V26.D, V27.D, V28.D }[0x1], [X27], X20
    LD4 { V7.D, V8.D, V9.D, V10.D }[0x0], [X27], X20
    ADD  X27, X27, X6, ASR #0
    MOV  X25, X27
    ST4 { V7.B, V8.B, V9.B, V10.B }[0xa], [X25], #4
    MOV  X25, X27
    LD4 { V7.B, V8.B, V9.B, V10.B }[0x3], [X25], #4
    ADD  X27, X27, X6
    ST4 { V1.B, V2.B, V3.B, V4.B }[0x0], [X27], X20
    LD4 { V25.B, V26.B, V27.B, V28.B }[0x1], [X27], X20
    ADD  X27, X27, X6, ASR #0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X16, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D0
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    FMOV  X16, V1.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D1
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    FMOV  X16, V2.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D2
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    FMOV  X16, V3.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D3
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    FMOV  X16, V4.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D4
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D5
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V6.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D6
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V7.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa500, LSL #16
    MOVK  X13, #0xa5, LSL #32
    FMOV  X16, D7
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V8.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa500, LSL #16
    FMOV  X16, D8
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V9.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa500, LSL #16
    MOVK  X13, #0xa5, LSL #32
    FMOV  X16, D9
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V10.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa500, LSL #16
    MOVK  X13, #0xa5, LSL #32
    FMOV  X16, D10
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V11.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D11
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V12.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D12
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V13.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D13
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V14.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D14
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V15.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D15
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D16
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D17
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V18.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D18
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V19.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D19
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    FMOV  X16, V20.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D20
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D21
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D22
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D23
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D24
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5, LSL #32
    FMOV  X16, V25.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D25
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D26
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5, LSL #32
    FMOV  X16, V27.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    FMOV  X16, D27
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5, LSL #32
    FMOV  X16, V28.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D28
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D29
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D30
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X16, D31
    SUB  X17, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X28
    FMOV  D1, X26
    FMOV  V1.D[1], X24
    FMOV  D2, X27
    FMOV  V2.D[1], X3
    FMOV  D3, X7
    FMOV  V3.D[1], X25
    FMOV  D4, X3
    FMOV  V4.D[1], X16
    FMOV  D5, X12
    FMOV  V5.D[1], X18
    FMOV  D6, X23
    FMOV  V6.D[1], X17
    FMOV  D7, X7
    FMOV  V7.D[1], X21
    FMOV  D8, X18
    FMOV  V8.D[1], X21
    FMOV  D9, X19
    FMOV  V9.D[1], X17
    FMOV  D10, X6
    FMOV  V10.D[1], X16
    FMOV  D11, X18
    FMOV  V11.D[1], X24
    FMOV  D12, X10
    FMOV  V12.D[1], X9
    FMOV  D13, X5
    FMOV  V13.D[1], X24
    FMOV  D14, X8
    FMOV  V14.D[1], X8
    FMOV  D15, X3
    FMOV  V15.D[1], X18
    FMOV  D16, X16
    FMOV  V16.D[1], X8
    FMOV  D17, X22
    FMOV  V17.D[1], X16
    FMOV  D18, X5
    FMOV  V18.D[1], X3
    FMOV  D19, X22
    FMOV  V19.D[1], X25
    FMOV  D20, X27
    FMOV  V20.D[1], X27
    FMOV  D21, X26
    FMOV  V21.D[1], X28
    FMOV  D22, X22
    FMOV  V22.D[1], X6
    FMOV  D23, X3
    FMOV  V23.D[1], X10
    FMOV  D24, X3
    FMOV  V24.D[1], X3
    FMOV  D25, X8
    FMOV  V25.D[1], X7
    FMOV  D26, X17
    FMOV  V26.D[1], X10
    FMOV  D27, X5
    FMOV  V27.D[1], X28
    FMOV  D28, X6
    FMOV  V28.D[1], X4
    FMOV  D29, X10
    FMOV  V29.D[1], X23
    FMOV  D30, X25
    FMOV  V30.D[1], X16
    FMOV  D31, X24
    FMOV  V31.D[1], X22
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X17, #0x0, LSL #0
    ADD  X8, X30, X17
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X8]
    LD4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X8]
    ADD  X8, X8, X23
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X8]
    LD4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X8]
    ADD  X8, X8, X23, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X8]
    LD4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X8]
    ADD  X8, X8, X23
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X8]
    LD4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X8]
    ADD  X8, X8, X23, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X8]
    LD4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X8]
    ADD  X8, X8, X23, LSR #0
    ST4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X8]
    LD4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X8]
    ADD  X8, X8, X23, ASR #0
    ST4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X8]
    LD4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X8]
    ADD  X8, X8, X23, LSR #0
    ST4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X8]
    LD4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X8]
    ADD  X8, X8, X23
    ST4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X8]
    LD4 { V12.8B, V13.8B, V14.8B, V15.8B }, [X8]
    ADD  X8, X8, X23
    MOV  X9, X8
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X9], #64
    MOV  X9, X8
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X9], #64
    ADD  X8, X8, X23
    MOV  X9, X8
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X9], #64
    MOV  X9, X8
    LD4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X9], #64
    ADD  X8, X8, X23, LSR #0
    MOV  X9, X8
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X9], #64
    MOV  X9, X8
    LD4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X9], #64
    ADD  X8, X8, X23, LSR #0
    MOV  X9, X8
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X9], #64
    MOV  X9, X8
    LD4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X9], #64
    ADD  X8, X8, X23, LSR #0
    MOV  X9, X8
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X9], #64
    MOV  X9, X8
    LD4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X9], #64
    ADD  X8, X8, X23
    MOV  X9, X8
    ST4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X9], #32
    MOV  X9, X8
    LD4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X9], #32
    ADD  X8, X8, X23, LSR #0
    MOV  X9, X8
    ST4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X9], #32
    MOV  X9, X8
    LD4 { V11.2S, V12.2S, V13.2S, V14.2S }, [X9], #32
    ADD  X8, X8, X23
    MOV  X9, X8
    ST4 { V11.4H, V12.4H, V13.4H, V14.4H }, [X9], #32
    MOV  X9, X8
    LD4 { V11.4H, V12.4H, V13.4H, V14.4H }, [X9], #32
    ADD  X8, X8, X23
    MOV  X9, X8
    ST4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X9], #32
    MOV  X9, X8
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X9], #32
    ADD  X8, X8, X23, LSR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X8], X25
    LD4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X8], X25
    ADD  X8, X8, X23, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X8], X25
    LD4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X8], X25
    ADD  X8, X8, X23, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X8], X25
    LD4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X8], X25
    ADD  X8, X8, X23, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X8], X25
    LD4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X8], X25
    ADD  X8, X8, X23
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X8], X25
    LD4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X8], X25
    ADD  X8, X8, X23
    ST4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X8], X25
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X8], X25
    ADD  X8, X8, X23
    ST4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X8], X25
    LD4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X8], X25
    ADD  X8, X8, X23
    ST4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X8], X25
    LD4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X8], X25
    ADD  X8, X8, X23, LSR #0
    ST4 { V7.8B, V8.8B, V9.8B, V10.8B }, [X8], X25
    LD4 { V7.8B, V8.8B, V9.8B, V10.8B }, [X8], X25
    ADD  X8, X8, X23, LSR #0
    ST4 { V11.H, V12.H, V13.H, V14.H }[0x1], [X8]
    LD4 { V12.H, V13.H, V14.H, V15.H }[0x4], [X8]
    ADD  X8, X8, X23
    ST4 { V26.S, V27.S, V28.S, V29.S }[0x0], [X8]
    LD4 { V15.S, V16.S, V17.S, V18.S }[0x3], [X8]
    ADD  X8, X8, X23, ASR #0
    ST4 { V2.D, V3.D, V4.D, V5.D }[0x1], [X8]
    LD4 { V31.D, V0.D, V1.D, V2.D }[0x1], [X8]
    ADD  X8, X8, X23
    ST4 { V12.B, V13.B, V14.B, V15.B }[0x7], [X8]
    LD4 { V27.B, V28.B, V29.B, V30.B }[0x0], [X8]
    ADD  X8, X8, X23
    MOV  X9, X8
    ST4 { V7.H, V8.H, V9.H, V10.H }[0x0], [X9], #8
    MOV  X9, X8
    LD4 { V2.H, V3.H, V4.H, V5.H }[0x5], [X9], #8
    ADD  X8, X8, X23, ASR #0
    ST4 { V2.H, V3.H, V4.H, V5.H }[0x3], [X8], X25
    LD4 { V8.H, V9.H, V10.H, V11.H }[0x1], [X8], X25
    ADD  X8, X8, X23
    MOV  X9, X8
    ST4 { V27.S, V28.S, V29.S, V30.S }[0x1], [X9], #16
    MOV  X9, X8
    LD4 { V15.S, V16.S, V17.S, V18.S }[0x3], [X9], #16
    ADD  X8, X8, X23, LSR #0
    ST4 { V6.S, V7.S, V8.S, V9.S }[0x0], [X8], X25
    LD4 { V24.S, V25.S, V26.S, V27.S }[0x3], [X8], X25
    ADD  X8, X8, X23
    MOV  X9, X8
    ST4 { V15.D, V16.D, V17.D, V18.D }[0x1], [X9], #32
    MOV  X9, X8
    LD4 { V4.D, V5.D, V6.D, V7.D }[0x1], [X9], #32
    ADD  X8, X8, X23, ASR #0
    ST4 { V4.D, V5.D, V6.D, V7.D }[0x0], [X8], X25
    LD4 { V6.D, V7.D, V8.D, V9.D }[0x0], [X8], X25
    ADD  X8, X8, X23
    MOV  X9, X8
    ST4 { V8.B, V9.B, V10.B, V11.B }[0xa], [X9], #4
    MOV  X9, X8
    LD4 { V8.B, V9.B, V10.B, V11.B }[0xa], [X9], #4
    ADD  X8, X8, X23, ASR #0
    ST4 { V14.B, V15.B, V16.B, V17.B }[0xd], [X8], X25
    LD4 { V15.B, V16.B, V17.B, V18.B }[0xf], [X8], X25
    ADD  X8, X8, X23
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X12, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X12, FPSR
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V0.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D0
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V1.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D1
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V2.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D2
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V3.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D3
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V4.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D4
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V5.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D5
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V6.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D6
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V7.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D7
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X12, V8.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D8
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X12, V9.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D9
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X12, V10.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D10
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X12, V11.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D11
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    FMOV  X12, V12.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D12
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V13.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D13
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V14.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D14
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V15.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D15
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V16.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D16
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V17.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D17
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V18.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D18
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X12, V19.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D19
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V20.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D20
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V21.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D21
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V22.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D22
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X12, V23.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D23
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V24.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D24
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V25.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D25
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V26.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D26
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V27.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D27
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X12, V28.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D28
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V29.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D29
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V30.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D30
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, V31.D[1]
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X12, D31
    SUB  X21, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP07_TestFail
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
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X17
    FMOV  V2.D[1], X21
    FMOV  D3, X12
    FMOV  V3.D[1], X25
    FMOV  D4, X4
    FMOV  V4.D[1], X24
    FMOV  D5, X21
    FMOV  V5.D[1], X5
    FMOV  D6, X27
    FMOV  V6.D[1], X10
    FMOV  D7, X18
    FMOV  V7.D[1], X26
    FMOV  D8, X26
    FMOV  V8.D[1], X13
    FMOV  D9, X4
    FMOV  V9.D[1], X19
    FMOV  D10, X5
    FMOV  V10.D[1], X5
    FMOV  D11, X17
    FMOV  V11.D[1], X22
    FMOV  D12, X16
    FMOV  V12.D[1], X20
    FMOV  D13, X26
    FMOV  V13.D[1], X13
    FMOV  D14, X26
    FMOV  V14.D[1], X5
    FMOV  D15, X9
    FMOV  V15.D[1], X17
    FMOV  D16, X5
    FMOV  V16.D[1], X23
    FMOV  D17, X6
    FMOV  V17.D[1], X12
    FMOV  D18, X26
    FMOV  V18.D[1], X10
    FMOV  D19, X4
    FMOV  V19.D[1], X25
    FMOV  D20, X24
    FMOV  V20.D[1], X17
    FMOV  D21, X6
    FMOV  V21.D[1], X12
    FMOV  D22, X3
    FMOV  V22.D[1], X21
    FMOV  D23, X18
    FMOV  V23.D[1], X16
    FMOV  D24, X9
    FMOV  V24.D[1], X4
    FMOV  D25, X22
    FMOV  V25.D[1], X23
    FMOV  D26, X4
    FMOV  V26.D[1], X24
    FMOV  D27, X28
    FMOV  V27.D[1], X12
    FMOV  D28, X24
    FMOV  V28.D[1], X24
    FMOV  D29, X9
    FMOV  V29.D[1], X27
    FMOV  D30, X25
    FMOV  V30.D[1], X13
    FMOV  D31, X20
    FMOV  V31.D[1], X12
    MOVZ  X18, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X6, #0x500, LSL #0
    ADD  X25, X30, X6, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X25]
    LD4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X25]
    ADD  X25, X25, X29, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X25]
    LD4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X25]
    ADD  X25, X25, X29, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X25]
    LD4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X25]
    ADD  X25, X25, X29, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X25]
    LD4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X25]
    ADD  X25, X25, X29, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X25]
    LD4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X25]
    ADD  X25, X25, X29, LSR #0
    ST4 { V28.4H, V29.4H, V30.4H, V31.4H }, [X25]
    LD4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X25]
    ADD  X25, X25, X29
    ST4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X25]
    LD4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X25]
    ADD  X25, X25, X29, LSR #0
    ST4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X25]
    LD4 { V27.4H, V28.4H, V29.4H, V30.4H }, [X25]
    ADD  X25, X25, X29
    ST4 { V20.8B, V21.8B, V22.8B, V23.8B }, [X25]
    LD4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X25]
    ADD  X25, X25, X29, ASR #0
    MOV  X8, X25
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X8], #64
    MOV  X8, X25
    LD4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X8], #64
    ADD  X25, X25, X29
    MOV  X8, X25
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X8], #64
    MOV  X8, X25
    LD4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X8], #64
    ADD  X25, X25, X29
    MOV  X8, X25
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X8], #64
    MOV  X8, X25
    LD4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X8], #64
    ADD  X25, X25, X29, ASR #0
    MOV  X8, X25
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X8], #64
    MOV  X8, X25
    LD4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X8], #64
    ADD  X25, X25, X29
    MOV  X8, X25
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X8], #64
    MOV  X8, X25
    LD4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X8], #64
    ADD  X25, X25, X29, ASR #0
    MOV  X8, X25
    ST4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X8], #32
    MOV  X8, X25
    LD4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X8], #32
    ADD  X25, X25, X29, ASR #0
    MOV  X8, X25
    ST4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X8], #32
    MOV  X8, X25
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X8], #32
    ADD  X25, X25, X29, LSR #0
    MOV  X8, X25
    ST4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X8], #32
    MOV  X8, X25
    LD4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X8], #32
    ADD  X25, X25, X29, LSR #0
    MOV  X8, X25
    ST4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X8], #32
    MOV  X8, X25
    LD4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X8], #32
    ADD  X25, X25, X29, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X25], X18
    LD4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X25], X18
    ADD  X25, X25, X29
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X25], X18
    LD4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X25], X18
    ADD  X25, X25, X29, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X25], X18
    LD4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X25], X18
    ADD  X25, X25, X29, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X25], X18
    LD4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X25], X18
    ADD  X25, X25, X29
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X25], X18
    LD4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X25], X18
    ADD  X25, X25, X29, ASR #0
    ST4 { V19.2S, V20.2S, V21.2S, V22.2S }, [X25], X18
    LD4 { V6.4H, V7.4H, V8.4H, V9.4H }, [X25], X18
    ADD  X25, X25, X29, ASR #0
    ST4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X25], X18
    LD4 { V19.2S, V20.2S, V21.2S, V22.2S }, [X25], X18
    ADD  X25, X25, X29, LSR #0
    ST4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X25], X18
    LD4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X25], X18
    ADD  X25, X25, X29, ASR #0
    ST4 { V19.8B, V20.8B, V21.8B, V22.8B }, [X25], X18
    LD4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X25], X18
    ADD  X25, X25, X29, LSR #0
    ST4 { V6.H, V7.H, V8.H, V9.H }[0x4], [X25]
    LD4 { V19.H, V20.H, V21.H, V22.H }[0x4], [X25]
    ADD  X25, X25, X29
    ST4 { V8.S, V9.S, V10.S, V11.S }[0x3], [X25]
    LD4 { V6.S, V7.S, V8.S, V9.S }[0x1], [X25]
    ADD  X25, X25, X29, ASR #0
    ST4 { V19.D, V20.D, V21.D, V22.D }[0x1], [X25]
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x0], [X25]
    ADD  X25, X25, X29, LSR #0
    ST4 { V21.B, V22.B, V23.B, V24.B }[0xe], [X25]
    LD4 { V11.B, V12.B, V13.B, V14.B }[0x0], [X25]
    ADD  X25, X25, X29, ASR #0
    MOV  X8, X25
    ST4 { V30.H, V31.H, V0.H, V1.H }[0x5], [X8], #8
    MOV  X8, X25
    LD4 { V21.H, V22.H, V23.H, V24.H }[0x3], [X8], #8
    ADD  X25, X25, X29
    ST4 { V28.H, V29.H, V30.H, V31.H }[0x4], [X25], X18
    LD4 { V29.H, V30.H, V31.H, V0.H }[0x3], [X25], X18
    ADD  X25, X25, X29, LSR #0
    MOV  X8, X25
    ST4 { V11.S, V12.S, V13.S, V14.S }[0x0], [X8], #16
    MOV  X8, X25
    LD4 { V26.S, V27.S, V28.S, V29.S }[0x0], [X8], #16
    ADD  X25, X25, X29, LSR #0
    ST4 { V27.S, V28.S, V29.S, V30.S }[0x3], [X25], X18
    LD4 { V23.S, V24.S, V25.S, V26.S }[0x1], [X25], X18
    ADD  X25, X25, X29, ASR #0
    MOV  X8, X25
    ST4 { V21.D, V22.D, V23.D, V24.D }[0x1], [X8], #32
    MOV  X8, X25
    LD4 { V11.D, V12.D, V13.D, V14.D }[0x0], [X8], #32
    ADD  X25, X25, X29, LSR #0
    ST4 { V5.D, V6.D, V7.D, V8.D }[0x1], [X25], X18
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x1], [X25], X18
    ADD  X25, X25, X29, LSR #0
    MOV  X8, X25
    ST4 { V22.B, V23.B, V24.B, V25.B }[0x2], [X8], #4
    MOV  X8, X25
    LD4 { V5.B, V6.B, V7.B, V8.B }[0xa], [X8], #4
    ADD  X25, X25, X29
    ST4 { V3.B, V4.B, V5.B, V6.B }[0xd], [X25], X18
    LD4 { V27.B, V28.B, V29.B, V30.B }[0xe], [X25], X18
    ADD  X25, X25, X29, ASR #0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X27, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X27, FPSR
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V0.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D0
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V1.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D1
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D2
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D3
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V4.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D4
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V5.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D5
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    FMOV  X27, D6
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V7.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    FMOV  X27, D7
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5, LSL #16
    FMOV  X27, V8.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D8
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D9
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V10.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D10
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V11.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D11
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V12.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D12
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V13.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D13
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V14.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D14
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V15.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D15
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V16.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D16
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V17.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D17
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V18.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D18
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V19.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D19
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V20.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D20
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V21.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D21
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D22
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D23
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, D24
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V25.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    FMOV  X27, D25
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa500, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    FMOV  X27, D26
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa500, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D27
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa500, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, D28
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    FMOV  X27, D29
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X27, V30.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    FMOV  X27, D30
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    FMOV  X27, V31.D[1]
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    FMOV  X27, D31
    SUB  X3, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
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
    FMOV  V1.D[1], X28
    FMOV  D2, X23
    FMOV  V2.D[1], X29
    FMOV  D3, X29
    FMOV  V3.D[1], X23
    FMOV  D4, X25
    FMOV  V4.D[1], X26
    FMOV  D5, X3
    FMOV  V5.D[1], X17
    FMOV  D6, X3
    FMOV  V6.D[1], X3
    FMOV  D7, X27
    FMOV  V7.D[1], X6
    FMOV  D8, X22
    FMOV  V8.D[1], X3
    FMOV  D9, X27
    FMOV  V9.D[1], X28
    FMOV  D10, X13
    FMOV  V10.D[1], X20
    FMOV  D11, X3
    FMOV  V11.D[1], X27
    FMOV  D12, X20
    FMOV  V12.D[1], X27
    FMOV  D13, X10
    FMOV  V13.D[1], X26
    FMOV  D14, X16
    FMOV  V14.D[1], X3
    FMOV  D15, X20
    FMOV  V15.D[1], X4
    FMOV  D16, X24
    FMOV  V16.D[1], X21
    FMOV  D17, X21
    FMOV  V17.D[1], X23
    FMOV  D18, X25
    FMOV  V18.D[1], X19
    FMOV  D19, X3
    FMOV  V19.D[1], X18
    FMOV  D20, X16
    FMOV  V20.D[1], X13
    FMOV  D21, X7
    FMOV  V21.D[1], X27
    FMOV  D22, X26
    FMOV  V22.D[1], X16
    FMOV  D23, X9
    FMOV  V23.D[1], X13
    FMOV  D24, X5
    FMOV  V24.D[1], X25
    FMOV  D25, X28
    FMOV  V25.D[1], X9
    FMOV  D26, X19
    FMOV  V26.D[1], X10
    FMOV  D27, X27
    FMOV  V27.D[1], X29
    FMOV  D28, X22
    FMOV  V28.D[1], X27
    FMOV  D29, X27
    FMOV  V29.D[1], X13
    FMOV  D30, X21
    FMOV  V30.D[1], X26
    FMOV  D31, X16
    FMOV  V31.D[1], X22
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X18, #0xa00, LSL #0
    ADD  X19, X30, X18, LSR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X19]
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X19]
    ADD  X19, X19, X24, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X19]
    LD4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X19]
    ADD  X19, X19, X24, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X19]
    LD4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X19]
    ADD  X19, X19, X24, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X19]
    LD4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X19]
    ADD  X19, X19, X24, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X19]
    LD4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X19]
    ADD  X19, X19, X24, ASR #0
    ST4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X19]
    LD4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X19]
    ADD  X19, X19, X24, LSR #0
    ST4 { V18.2S, V19.2S, V20.2S, V21.2S }, [X19]
    LD4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X19]
    ADD  X19, X19, X24
    ST4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X19]
    LD4 { V6.4H, V7.4H, V8.4H, V9.4H }, [X19]
    ADD  X19, X19, X24, LSR #0
    ST4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X19]
    LD4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X19]
    ADD  X19, X19, X24
    MOV  X23, X19
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X23], #64
    MOV  X23, X19
    LD4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X23], #64
    ADD  X19, X19, X24
    MOV  X23, X19
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X23], #64
    MOV  X23, X19
    LD4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X23], #64
    ADD  X19, X19, X24
    MOV  X23, X19
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X23], #64
    MOV  X23, X19
    LD4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X23], #64
    ADD  X19, X19, X24
    MOV  X23, X19
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X23], #64
    MOV  X23, X19
    LD4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X23], #64
    ADD  X19, X19, X24, ASR #0
    MOV  X23, X19
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X23], #64
    MOV  X23, X19
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X23], #64
    ADD  X19, X19, X24
    MOV  X23, X19
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X23], #32
    MOV  X23, X19
    LD4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X23], #32
    ADD  X19, X19, X24, ASR #0
    MOV  X23, X19
    ST4 { V5.2S, V6.2S, V7.2S, V8.2S }, [X23], #32
    MOV  X23, X19
    LD4 { V5.2S, V6.2S, V7.2S, V8.2S }, [X23], #32
    ADD  X19, X19, X24
    MOV  X23, X19
    ST4 { V5.4H, V6.4H, V7.4H, V8.4H }, [X23], #32
    MOV  X23, X19
    LD4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X23], #32
    ADD  X19, X19, X24, LSR #0
    MOV  X23, X19
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X23], #32
    MOV  X23, X19
    LD4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X23], #32
    ADD  X19, X19, X24
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X19], X26
    LD4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X19], X26
    ADD  X19, X19, X24, LSR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X19], X26
    LD4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X19], X26
    ADD  X19, X19, X24, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X19], X26
    LD4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X19], X26
    ADD  X19, X19, X24, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X19], X26
    LD4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X19], X26
    ADD  X19, X19, X24, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X19], X26
    LD4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X19], X26
    ADD  X19, X19, X24, ASR #0
    ST4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X19], X26
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X19], X26
    ADD  X19, X19, X24
    ST4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X19], X26
    LD4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X19], X26
    ADD  X19, X19, X24, ASR #0
    ST4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X19], X26
    LD4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X19], X26
    ADD  X19, X19, X24
    ST4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X19], X26
    LD4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X19], X26
    ADD  X19, X19, X24
    ST4 { V30.H, V31.H, V0.H, V1.H }[0x5], [X19]
    LD4 { V23.H, V24.H, V25.H, V26.H }[0x7], [X19]
    ADD  X19, X19, X24, LSR #0
    ST4 { V7.S, V8.S, V9.S, V10.S }[0x0], [X19]
    LD4 { V7.S, V8.S, V9.S, V10.S }[0x3], [X19]
    ADD  X19, X19, X24
    ST4 { V7.D, V8.D, V9.D, V10.D }[0x0], [X19]
    LD4 { V7.D, V8.D, V9.D, V10.D }[0x1], [X19]
    ADD  X19, X19, X24, LSR #0
    ST4 { V23.B, V24.B, V25.B, V26.B }[0x3], [X19]
    LD4 { V23.B, V24.B, V25.B, V26.B }[0x9], [X19]
    ADD  X19, X19, X24, LSR #0
    MOV  X23, X19
    ST4 { V7.H, V8.H, V9.H, V10.H }[0x5], [X23], #8
    MOV  X23, X19
    LD4 { V7.H, V8.H, V9.H, V10.H }[0x6], [X23], #8
    ADD  X19, X19, X24, LSR #0
    ST4 { V13.H, V14.H, V15.H, V16.H }[0x6], [X19], X26
    LD4 { V5.H, V6.H, V7.H, V8.H }[0x3], [X19], X26
    ADD  X19, X19, X24, ASR #0
    MOV  X23, X19
    ST4 { V23.S, V24.S, V25.S, V26.S }[0x3], [X23], #16
    MOV  X23, X19
    LD4 { V13.S, V14.S, V15.S, V16.S }[0x1], [X23], #16
    ADD  X19, X19, X24
    ST4 { V5.S, V6.S, V7.S, V8.S }[0x0], [X19], X26
    LD4 { V5.S, V6.S, V7.S, V8.S }[0x2], [X19], X26
    ADD  X19, X19, X24
    MOV  X23, X19
    ST4 { V2.D, V3.D, V4.D, V5.D }[0x0], [X23], #32
    MOV  X23, X19
    LD4 { V2.D, V3.D, V4.D, V5.D }[0x0], [X23], #32
    ADD  X19, X19, X24, LSR #0
    ST4 { V2.D, V3.D, V4.D, V5.D }[0x1], [X19], X26
    LD4 { V2.D, V3.D, V4.D, V5.D }[0x1], [X19], X26
    ADD  X19, X19, X24
    MOV  X23, X19
    ST4 { V3.B, V4.B, V5.B, V6.B }[0x3], [X23], #4
    MOV  X23, X19
    LD4 { V23.B, V24.B, V25.B, V26.B }[0x4], [X23], #4
    ADD  X19, X19, X24, ASR #0
    ST4 { V31.B, V0.B, V1.B, V2.B }[0x5], [X19], X26
    LD4 { V0.B, V1.B, V2.B, V3.B }[0xe], [X19], X26
    ADD  X19, X19, X24, ASR #0
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X21
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X5, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    MRS  X5, FPSR
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a, LSL #48
    FMOV  X5, V0.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D0
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a, LSL #48
    FMOV  X5, V1.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D1
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a, LSL #48
    FMOV  X5, V2.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D2
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V3.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D3
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V4.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D4
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V5.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    FMOV  X5, D5
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X5, V6.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    FMOV  X5, D6
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V7.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    FMOV  X5, D7
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V8.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    FMOV  X5, D8
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V9.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D9
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V10.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D10
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V11.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D11
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V12.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D12
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V13.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X5, D13
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X5, D14
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X5, D15
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X5, D16
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V17.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D17
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V18.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D18
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V19.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D19
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V20.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D20
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D21
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V22.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D22
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a00, LSL #0
    FMOV  X5, V23.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D23
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a00, LSL #0
    FMOV  X5, V24.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D24
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a00, LSL #0
    FMOV  X5, V25.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D25
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a00, LSL #0
    FMOV  X5, V26.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D26
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V27.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D27
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V28.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D28
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, V29.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D29
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V30.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D30
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X5, V31.D[1]
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X5, D31
    SUB  X29, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X23
    FMOV  V3.D[1], X7
    FMOV  D4, X16
    FMOV  V4.D[1], X23
    FMOV  D5, X19
    FMOV  V5.D[1], X20
    FMOV  D6, X23
    FMOV  V6.D[1], X20
    FMOV  D7, X25
    FMOV  V7.D[1], X7
    FMOV  D8, X5
    FMOV  V8.D[1], X12
    FMOV  D9, X17
    FMOV  V9.D[1], X13
    FMOV  D10, X21
    FMOV  V10.D[1], X19
    FMOV  D11, X29
    FMOV  V11.D[1], X6
    FMOV  D12, X8
    FMOV  V12.D[1], X27
    FMOV  D13, X10
    FMOV  V13.D[1], X6
    FMOV  D14, X22
    FMOV  V14.D[1], X23
    FMOV  D15, X12
    FMOV  V15.D[1], X23
    FMOV  D16, X21
    FMOV  V16.D[1], X20
    FMOV  D17, X20
    FMOV  V17.D[1], X27
    FMOV  D18, X25
    FMOV  V18.D[1], X12
    FMOV  D19, X5
    FMOV  V19.D[1], X20
    FMOV  D20, X19
    FMOV  V20.D[1], X10
    FMOV  D21, X5
    FMOV  V21.D[1], X24
    FMOV  D22, X29
    FMOV  V22.D[1], X10
    FMOV  D23, X26
    FMOV  V23.D[1], X6
    FMOV  D24, X9
    FMOV  V24.D[1], X23
    FMOV  D25, X8
    FMOV  V25.D[1], X28
    FMOV  D26, X28
    FMOV  V26.D[1], X27
    FMOV  D27, X13
    FMOV  V27.D[1], X22
    FMOV  D28, X9
    FMOV  V28.D[1], X10
    FMOV  D29, X10
    FMOV  V29.D[1], X4
    FMOV  D30, X9
    FMOV  V30.D[1], X7
    FMOV  D31, X8
    FMOV  V31.D[1], X9
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X29, #0xf00, LSL #0
    ADD  X27, X30, X29
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X27]
    LD4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X27]
    ADD  X27, X27, X4, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X27]
    LD4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X27]
    ADD  X27, X27, X4, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X27]
    LD4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X27]
    ADD  X27, X27, X4, ASR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X27]
    LD4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X27]
    ADD  X27, X27, X4
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X27]
    LD4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X27]
    ADD  X27, X27, X4
    ST4 { V27.8B, V28.8B, V29.8B, V30.8B }, [X27]
    LD4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X27]
    ADD  X27, X27, X4, ASR #0
    ST4 { V0.2S, V1.2S, V2.2S, V3.2S }, [X27]
    LD4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X27]
    ADD  X27, X27, X4, LSR #0
    ST4 { V23.4H, V24.4H, V25.4H, V26.4H }, [X27]
    LD4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X27]
    ADD  X27, X27, X4
    ST4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X27]
    LD4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X27]
    ADD  X27, X27, X4, LSR #0
    MOV  X16, X27
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X16], #64
    MOV  X16, X27
    LD4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X16], #64
    ADD  X27, X27, X4, LSR #0
    MOV  X16, X27
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X16], #64
    MOV  X16, X27
    LD4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X16], #64
    ADD  X27, X27, X4
    MOV  X16, X27
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X16], #64
    MOV  X16, X27
    LD4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X16], #64
    ADD  X27, X27, X4, LSR #0
    MOV  X16, X27
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X16], #64
    MOV  X16, X27
    LD4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X16], #64
    ADD  X27, X27, X4, LSR #0
    MOV  X16, X27
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X16], #64
    MOV  X16, X27
    LD4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X16], #64
    ADD  X27, X27, X4, LSR #0
    MOV  X16, X27
    ST4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X16], #32
    MOV  X16, X27
    LD4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X16], #32
    ADD  X27, X27, X4, LSR #0
    MOV  X16, X27
    ST4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X16], #32
    MOV  X16, X27
    LD4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X16], #32
    ADD  X27, X27, X4
    MOV  X16, X27
    ST4 { V4.4H, V5.4H, V6.4H, V7.4H }, [X16], #32
    MOV  X16, X27
    LD4 { V4.4H, V5.4H, V6.4H, V7.4H }, [X16], #32
    ADD  X27, X27, X4, LSR #0
    MOV  X16, X27
    ST4 { V4.8B, V5.8B, V6.8B, V7.8B }, [X16], #32
    MOV  X16, X27
    LD4 { V4.8B, V5.8B, V6.8B, V7.8B }, [X16], #32
    ADD  X27, X27, X4
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X27], X7
    LD4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X27], X7
    ADD  X27, X27, X4, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X27], X7
    LD4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X27], X7
    ADD  X27, X27, X4, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X27], X7
    LD4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X27], X7
    ADD  X27, X27, X4, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X27], X7
    LD4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X27], X7
    ADD  X27, X27, X4
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X27], X7
    LD4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X27], X7
    ADD  X27, X27, X4
    ST4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X27], X7
    LD4 { V10.4H, V11.4H, V12.4H, V13.4H }, [X27], X7
    ADD  X27, X27, X4, LSR #0
    ST4 { V28.2S, V29.2S, V30.2S, V31.2S }, [X27], X7
    LD4 { V0.2S, V1.2S, V2.2S, V3.2S }, [X27], X7
    ADD  X27, X27, X4, ASR #0
    ST4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X27], X7
    LD4 { V22.4H, V23.4H, V24.4H, V25.4H }, [X27], X7
    ADD  X27, X27, X4, ASR #0
    ST4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X27], X7
    LD4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X27], X7
    ADD  X27, X27, X4, LSR #0
    ST4 { V6.H, V7.H, V8.H, V9.H }[0x5], [X27]
    LD4 { V28.H, V29.H, V30.H, V31.H }[0x7], [X27]
    ADD  X27, X27, X4
    ST4 { V22.S, V23.S, V24.S, V25.S }[0x0], [X27]
    LD4 { V22.S, V23.S, V24.S, V25.S }[0x3], [X27]
    ADD  X27, X27, X4
    ST4 { V28.D, V29.D, V30.D, V31.D }[0x0], [X27]
    LD4 { V7.D, V8.D, V9.D, V10.D }[0x1], [X27]
    ADD  X27, X27, X4
    ST4 { V22.B, V23.B, V24.B, V25.B }[0xc], [X27]
    LD4 { V28.B, V29.B, V30.B, V31.B }[0xd], [X27]
    ADD  X27, X27, X4
    MOV  X16, X27
    ST4 { V29.H, V30.H, V31.H, V0.H }[0x2], [X16], #8
    MOV  X16, X27
    LD4 { V22.H, V23.H, V24.H, V25.H }[0x2], [X16], #8
    ADD  X27, X27, X4
    ST4 { V7.H, V8.H, V9.H, V10.H }[0x6], [X27], X7
    LD4 { V29.H, V30.H, V31.H, V0.H }[0x3], [X27], X7
    ADD  X27, X27, X4, ASR #0
    MOV  X16, X27
    ST4 { V21.S, V22.S, V23.S, V24.S }[0x3], [X16], #16
    MOV  X16, X27
    LD4 { V7.S, V8.S, V9.S, V10.S }[0x2], [X16], #16
    ADD  X27, X27, X4, LSR #0
    ST4 { V0.S, V1.S, V2.S, V3.S }[0x1], [X27], X7
    LD4 { V21.S, V22.S, V23.S, V24.S }[0x2], [X27], X7
    ADD  X27, X27, X4, ASR #0
    MOV  X16, X27
    ST4 { V26.D, V27.D, V28.D, V29.D }[0x1], [X16], #32
    MOV  X16, X27
    LD4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X16], #32
    ADD  X27, X27, X4, ASR #0
    ST4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X27], X7
    LD4 { V26.D, V27.D, V28.D, V29.D }[0x1], [X27], X7
    ADD  X27, X27, X4
    MOV  X16, X27
    ST4 { V16.B, V17.B, V18.B, V19.B }[0xb], [X16], #4
    MOV  X16, X27
    LD4 { V0.B, V1.B, V2.B, V3.B }[0xb], [X16], #4
    ADD  X27, X27, X4, LSR #0
    ST4 { V0.B, V1.B, V2.B, V3.B }[0x5], [X27], X7
    LD4 { V16.B, V17.B, V18.B, V19.B }[0xe], [X27], X7
    ADD  X27, X27, X4
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X19, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa500, LSL #16
    FMOV  X19, V0.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X19, D0
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa500, LSL #16
    FMOV  X19, V1.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X19, D1
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa500, LSL #16
    FMOV  X19, V2.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    FMOV  X19, D2
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa500, LSL #16
    FMOV  X19, V3.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    FMOV  X19, D3
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D4
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X19, V5.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D5
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X19, V6.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D6
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V7.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D7
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V8.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D8
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V9.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D9
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V10.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D10
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D11
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D12
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X19, V13.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D13
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D14
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V15.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D15
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa500, LSL #48
    FMOV  X19, V16.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D16
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa500, LSL #48
    FMOV  X19, V17.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D17
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V18.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D18
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V19.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D19
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V20.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D20
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    FMOV  X19, V21.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D21
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D22
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V23.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D23
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V24.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D24
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, V25.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D25
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D26
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x0, LSL #0
    FMOV  X19, V27.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D27
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    FMOV  X19, V28.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D28
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    FMOV  X19, V29.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D29
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    FMOV  X19, V30.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D30
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    FMOV  X19, V31.D[1]
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    FMOV  X19, D31
    SUB  X26, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP07_TestFail
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
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X10
    FMOV  D3, X22
    FMOV  V3.D[1], X5
    FMOV  D4, X5
    FMOV  V4.D[1], X12
    FMOV  D5, X3
    FMOV  V5.D[1], X29
    FMOV  D6, X21
    FMOV  V6.D[1], X22
    FMOV  D7, X3
    FMOV  V7.D[1], X3
    FMOV  D8, X12
    FMOV  V8.D[1], X20
    FMOV  D9, X28
    FMOV  V9.D[1], X13
    FMOV  D10, X3
    FMOV  V10.D[1], X18
    FMOV  D11, X5
    FMOV  V11.D[1], X29
    FMOV  D12, X16
    FMOV  V12.D[1], X26
    FMOV  D13, X4
    FMOV  V13.D[1], X29
    FMOV  D14, X22
    FMOV  V14.D[1], X5
    FMOV  D15, X17
    FMOV  V15.D[1], X7
    FMOV  D16, X17
    FMOV  V16.D[1], X13
    FMOV  D17, X24
    FMOV  V17.D[1], X16
    FMOV  D18, X19
    FMOV  V18.D[1], X28
    FMOV  D19, X3
    FMOV  V19.D[1], X5
    FMOV  D20, X10
    FMOV  V20.D[1], X16
    FMOV  D21, X16
    FMOV  V21.D[1], X5
    FMOV  D22, X26
    FMOV  V22.D[1], X19
    FMOV  D23, X7
    FMOV  V23.D[1], X26
    FMOV  D24, X24
    FMOV  V24.D[1], X16
    FMOV  D25, X6
    FMOV  V25.D[1], X12
    FMOV  D26, X24
    FMOV  V26.D[1], X16
    FMOV  D27, X13
    FMOV  V27.D[1], X26
    FMOV  D28, X10
    FMOV  V28.D[1], X21
    FMOV  D29, X8
    FMOV  V29.D[1], X17
    FMOV  D30, X26
    FMOV  V30.D[1], X28
    FMOV  D31, X19
    FMOV  V31.D[1], X17
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X8, #0x1400, LSL #0
    ADD  X16, X30, X8
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X16]
    LD4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X16]
    ADD  X16, X16, X10, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X16]
    LD4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X16]
    ADD  X16, X16, X10, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X16]
    LD4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X16]
    ADD  X16, X16, X10
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X16]
    LD4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X16]
    ADD  X16, X16, X10, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X16]
    LD4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X16]
    ADD  X16, X16, X10, ASR #0
    ST4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X16]
    LD4 { V2.4H, V3.4H, V4.4H, V5.4H }, [X16]
    ADD  X16, X16, X10, LSR #0
    ST4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X16]
    LD4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X16]
    ADD  X16, X16, X10, LSR #0
    ST4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X16]
    LD4 { V15.4H, V16.4H, V17.4H, V18.4H }, [X16]
    ADD  X16, X16, X10
    ST4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X16]
    LD4 { V20.8B, V21.8B, V22.8B, V23.8B }, [X16]
    ADD  X16, X16, X10, LSR #0
    MOV  X18, X16
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X18], #64
    MOV  X18, X16
    LD4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X18], #64
    ADD  X16, X16, X10, LSR #0
    MOV  X18, X16
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X18], #64
    MOV  X18, X16
    LD4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X18], #64
    ADD  X16, X16, X10, LSR #0
    MOV  X18, X16
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X18], #64
    MOV  X18, X16
    LD4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X18], #64
    ADD  X16, X16, X10
    MOV  X18, X16
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X18], #64
    MOV  X18, X16
    LD4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X18], #64
    ADD  X16, X16, X10, ASR #0
    MOV  X18, X16
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X18], #64
    MOV  X18, X16
    LD4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X18], #64
    ADD  X16, X16, X10
    MOV  X18, X16
    ST4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X18], #32
    MOV  X18, X16
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X18], #32
    ADD  X16, X16, X10, ASR #0
    MOV  X18, X16
    ST4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X18], #32
    MOV  X18, X16
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X18], #32
    ADD  X16, X16, X10, LSR #0
    MOV  X18, X16
    ST4 { V17.4H, V18.4H, V19.4H, V20.4H }, [X18], #32
    MOV  X18, X16
    LD4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X18], #32
    ADD  X16, X16, X10
    MOV  X18, X16
    ST4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X18], #32
    MOV  X18, X16
    LD4 { V11.8B, V12.8B, V13.8B, V14.8B }, [X18], #32
    ADD  X16, X16, X10
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X16], X5
    LD4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X16], X5
    ADD  X16, X16, X10, ASR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X16], X5
    LD4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X16], X5
    ADD  X16, X16, X10, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X16], X5
    LD4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X16], X5
    ADD  X16, X16, X10, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X16], X5
    LD4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X16], X5
    ADD  X16, X16, X10, ASR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X16], X5
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X16], X5
    ADD  X16, X16, X10, ASR #0
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X16], X5
    LD4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X16], X5
    ADD  X16, X16, X10, ASR #0
    ST4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X16], X5
    LD4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X16], X5
    ADD  X16, X16, X10, LSR #0
    ST4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X16], X5
    LD4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X16], X5
    ADD  X16, X16, X10, LSR #0
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X16], X5
    LD4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X16], X5
    ADD  X16, X16, X10, LSR #0
    ST4 { V31.H, V0.H, V1.H, V2.H }[0x2], [X16]
    LD4 { V28.H, V29.H, V30.H, V31.H }[0x3], [X16]
    ADD  X16, X16, X10
    ST4 { V5.S, V6.S, V7.S, V8.S }[0x3], [X16]
    LD4 { V5.S, V6.S, V7.S, V8.S }[0x1], [X16]
    ADD  X16, X16, X10, ASR #0
    ST4 { V5.D, V6.D, V7.D, V8.D }[0x0], [X16]
    LD4 { V1.D, V2.D, V3.D, V4.D }[0x0], [X16]
    ADD  X16, X16, X10, ASR #0
    ST4 { V28.B, V29.B, V30.B, V31.B }[0xf], [X16]
    LD4 { V5.B, V6.B, V7.B, V8.B }[0x7], [X16]
    ADD  X16, X16, X10
    MOV  X18, X16
    ST4 { V5.H, V6.H, V7.H, V8.H }[0x3], [X18], #8
    MOV  X18, X16
    LD4 { V28.H, V29.H, V30.H, V31.H }[0x7], [X18], #8
    ADD  X16, X16, X10, LSR #0
    ST4 { V1.H, V2.H, V3.H, V4.H }[0x0], [X16], X5
    LD4 { V3.H, V4.H, V5.H, V6.H }[0x0], [X16], X5
    ADD  X16, X16, X10, LSR #0
    MOV  X18, X16
    ST4 { V3.S, V4.S, V5.S, V6.S }[0x3], [X18], #16
    MOV  X18, X16
    LD4 { V0.S, V1.S, V2.S, V3.S }[0x1], [X18], #16
    ADD  X16, X16, X10, ASR #0
    ST4 { V30.S, V31.S, V0.S, V1.S }[0x0], [X16], X5
    LD4 { V14.S, V15.S, V16.S, V17.S }[0x3], [X16], X5
    ADD  X16, X16, X10
    MOV  X18, X16
    ST4 { V14.D, V15.D, V16.D, V17.D }[0x0], [X18], #32
    MOV  X18, X16
    LD4 { V14.D, V15.D, V16.D, V17.D }[0x1], [X18], #32
    ADD  X16, X16, X10, LSR #0
    ST4 { V17.D, V18.D, V19.D, V20.D }[0x1], [X16], X5
    LD4 { V30.D, V31.D, V0.D, V1.D }[0x0], [X16], X5
    ADD  X16, X16, X10, LSR #0
    MOV  X18, X16
    ST4 { V30.B, V31.B, V0.B, V1.B }[0x6], [X18], #4
    MOV  X18, X16
    LD4 { V30.B, V31.B, V0.B, V1.B }[0x0], [X18], #4
    ADD  X16, X16, X10, ASR #0
    ST4 { V31.B, V0.B, V1.B, V2.B }[0x5], [X16], X5
    LD4 { V31.B, V0.B, V1.B, V2.B }[0xe], [X16], X5
    ADD  X16, X16, X10
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X24, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D0
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x5a, LSL #48
    FMOV  X24, V1.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D1
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    FMOV  X24, D2
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    FMOV  X24, D3
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    FMOV  X24, D4
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a00, LSL #48
    FMOV  X24, D5
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a00, LSL #48
    FMOV  X24, D6
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V7.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    FMOV  X24, D7
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    FMOV  X24, D8
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D9
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D10
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D11
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D12
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V13.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D13
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, V14.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D14
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, V15.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D15
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, V16.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D16
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, V17.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D17
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D18
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D19
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, V20.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D20
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D21
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D22
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V23.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D23
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, V24.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D24
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, V25.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D25
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, V26.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D26
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, V27.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D27
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a00, LSL #48
    FMOV  X24, V28.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D28
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a00, LSL #48
    FMOV  X24, V29.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D29
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X24, D30
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X24, D31
    SUB  X6, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X24
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X18
    FMOV  V3.D[1], X21
    FMOV  D4, X29
    FMOV  V4.D[1], X16
    FMOV  D5, X7
    FMOV  V5.D[1], X17
    FMOV  D6, X6
    FMOV  V6.D[1], X8
    FMOV  D7, X13
    FMOV  V7.D[1], X3
    FMOV  D8, X27
    FMOV  V8.D[1], X4
    FMOV  D9, X18
    FMOV  V9.D[1], X29
    FMOV  D10, X7
    FMOV  V10.D[1], X10
    FMOV  D11, X21
    FMOV  V11.D[1], X23
    FMOV  D12, X6
    FMOV  V12.D[1], X6
    FMOV  D13, X25
    FMOV  V13.D[1], X22
    FMOV  D14, X4
    FMOV  V14.D[1], X9
    FMOV  D15, X5
    FMOV  V15.D[1], X12
    FMOV  D16, X29
    FMOV  V16.D[1], X12
    FMOV  D17, X24
    FMOV  V17.D[1], X20
    FMOV  D18, X26
    FMOV  V18.D[1], X8
    FMOV  D19, X25
    FMOV  V19.D[1], X17
    FMOV  D20, X16
    FMOV  V20.D[1], X3
    FMOV  D21, X10
    FMOV  V21.D[1], X9
    FMOV  D22, X26
    FMOV  V22.D[1], X13
    FMOV  D23, X17
    FMOV  V23.D[1], X4
    FMOV  D24, X29
    FMOV  V24.D[1], X27
    FMOV  D25, X23
    FMOV  V25.D[1], X16
    FMOV  D26, X29
    FMOV  V26.D[1], X17
    FMOV  D27, X9
    FMOV  V27.D[1], X18
    FMOV  D28, X6
    FMOV  V28.D[1], X22
    FMOV  D29, X25
    FMOV  V29.D[1], X27
    FMOV  D30, X8
    FMOV  V30.D[1], X5
    FMOV  D31, X13
    FMOV  V31.D[1], X12
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X12, #0x1900, LSL #0
    ADD  X6, X30, X12
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X6]
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X6]
    ADD  X6, X6, X25
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X6]
    LD4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X6]
    ADD  X6, X6, X25
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X6]
    LD4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X6]
    ADD  X6, X6, X25
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X6]
    LD4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X6]
    ADD  X6, X6, X25, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X6]
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X6]
    ADD  X6, X6, X25
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X6]
    LD4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X6]
    ADD  X6, X6, X25, ASR #0
    ST4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X6]
    LD4 { V9.2S, V10.2S, V11.2S, V12.2S }, [X6]
    ADD  X6, X6, X25, LSR #0
    ST4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X6]
    LD4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X6]
    ADD  X6, X6, X25, ASR #0
    ST4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X6]
    LD4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X6]
    ADD  X6, X6, X25
    MOV  X5, X6
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X5], #64
    MOV  X5, X6
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X5], #64
    ADD  X6, X6, X25
    MOV  X5, X6
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X5], #64
    MOV  X5, X6
    LD4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X5], #64
    ADD  X6, X6, X25, LSR #0
    MOV  X5, X6
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X5], #64
    MOV  X5, X6
    LD4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X5], #64
    ADD  X6, X6, X25
    MOV  X5, X6
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X5], #64
    MOV  X5, X6
    LD4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X5], #64
    ADD  X6, X6, X25, LSR #0
    MOV  X5, X6
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X5], #64
    MOV  X5, X6
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X5], #64
    ADD  X6, X6, X25, LSR #0
    MOV  X5, X6
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X5], #32
    MOV  X5, X6
    LD4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X5], #32
    ADD  X6, X6, X25
    MOV  X5, X6
    ST4 { V14.2S, V15.2S, V16.2S, V17.2S }, [X5], #32
    MOV  X5, X6
    LD4 { V14.2S, V15.2S, V16.2S, V17.2S }, [X5], #32
    ADD  X6, X6, X25, LSR #0
    MOV  X5, X6
    ST4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X5], #32
    MOV  X5, X6
    LD4 { V8.4H, V9.4H, V10.4H, V11.4H }, [X5], #32
    ADD  X6, X6, X25, ASR #0
    MOV  X5, X6
    ST4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X5], #32
    MOV  X5, X6
    LD4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X5], #32
    ADD  X6, X6, X25, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X6], X28
    LD4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X6], X28
    ADD  X6, X6, X25, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X6], X28
    LD4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X6], X28
    ADD  X6, X6, X25, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X6], X28
    LD4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X6], X28
    ADD  X6, X6, X25
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X6], X28
    LD4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X6], X28
    ADD  X6, X6, X25
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X6], X28
    LD4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X6], X28
    ADD  X6, X6, X25
    ST4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X6], X28
    LD4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X6], X28
    ADD  X6, X6, X25
    ST4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X6], X28
    LD4 { V14.2S, V15.2S, V16.2S, V17.2S }, [X6], X28
    ADD  X6, X6, X25
    ST4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X6], X28
    LD4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X6], X28
    ADD  X6, X6, X25, ASR #0
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X6], X28
    LD4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X6], X28
    ADD  X6, X6, X25, ASR #0
    ST4 { V16.H, V17.H, V18.H, V19.H }[0x2], [X6]
    LD4 { V16.H, V17.H, V18.H, V19.H }[0x1], [X6]
    ADD  X6, X6, X25, LSR #0
    ST4 { V3.S, V4.S, V5.S, V6.S }[0x3], [X6]
    LD4 { V3.S, V4.S, V5.S, V6.S }[0x1], [X6]
    ADD  X6, X6, X25
    ST4 { V9.D, V10.D, V11.D, V12.D }[0x0], [X6]
    LD4 { V9.D, V10.D, V11.D, V12.D }[0x0], [X6]
    ADD  X6, X6, X25, LSR #0
    ST4 { V10.B, V11.B, V12.B, V13.B }[0xb], [X6]
    LD4 { V20.B, V21.B, V22.B, V23.B }[0x7], [X6]
    ADD  X6, X6, X25, LSR #0
    MOV  X5, X6
    ST4 { V13.H, V14.H, V15.H, V16.H }[0x7], [X5], #8
    MOV  X5, X6
    LD4 { V15.H, V16.H, V17.H, V18.H }[0x4], [X5], #8
    ADD  X6, X6, X25, ASR #0
    ST4 { V19.H, V20.H, V21.H, V22.H }[0x6], [X6], X28
    LD4 { V19.H, V20.H, V21.H, V22.H }[0x7], [X6], X28
    ADD  X6, X6, X25
    MOV  X5, X6
    ST4 { V17.S, V18.S, V19.S, V20.S }[0x1], [X5], #16
    MOV  X5, X6
    LD4 { V22.S, V23.S, V24.S, V25.S }[0x2], [X5], #16
    ADD  X6, X6, X25, ASR #0
    ST4 { V21.S, V22.S, V23.S, V24.S }[0x1], [X6], X28
    LD4 { V6.S, V7.S, V8.S, V9.S }[0x1], [X6], X28
    ADD  X6, X6, X25, ASR #0
    MOV  X5, X6
    ST4 { V6.D, V7.D, V8.D, V9.D }[0x0], [X5], #32
    MOV  X5, X6
    LD4 { V6.D, V7.D, V8.D, V9.D }[0x0], [X5], #32
    ADD  X6, X6, X25, ASR #0
    ST4 { V8.D, V9.D, V10.D, V11.D }[0x0], [X6], X28
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x0], [X6], X28
    ADD  X6, X6, X25, LSR #0
    MOV  X5, X6
    ST4 { V30.B, V31.B, V0.B, V1.B }[0x2], [X5], #4
    MOV  X5, X6
    LD4 { V8.B, V9.B, V10.B, V11.B }[0x1], [X5], #4
    ADD  X6, X6, X25, ASR #0
    ST4 { V22.B, V23.B, V24.B, V25.B }[0xf], [X6], X28
    LD4 { V22.B, V23.B, V24.B, V25.B }[0xa], [X6], X28
    ADD  X6, X6, X25, LSR #0
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X24, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V0.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D0
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D1
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D2
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V3.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    FMOV  X24, D3
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V4.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    FMOV  X24, D4
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V5.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    FMOV  X24, D5
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V6.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5, LSL #48
    FMOV  X24, D6
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V7.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5, LSL #48
    FMOV  X24, D7
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D8
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D9
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D10
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D11
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V12.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D12
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V13.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D13
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V14.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D14
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    FMOV  X24, V15.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D15
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V16.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D16
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V17.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D17
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V18.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D18
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V19.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D19
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5, LSL #48
    FMOV  X24, D20
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D21
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa500, LSL #16
    FMOV  X24, V22.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D22
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa500, LSL #16
    FMOV  X24, V23.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D23
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V24.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D24
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V25.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D25
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V26.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D26
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V27.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D27
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V28.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D28
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V29.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D29
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, V30.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D30
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V31.D[1]
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X24, D31
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X23
    FMOV  V2.D[1], X29
    FMOV  D3, X17
    FMOV  V3.D[1], X13
    FMOV  D4, X27
    FMOV  V4.D[1], X6
    FMOV  D5, X6
    FMOV  V5.D[1], X26
    FMOV  D6, X10
    FMOV  V6.D[1], X3
    FMOV  D7, X7
    FMOV  V7.D[1], X7
    FMOV  D8, X29
    FMOV  V8.D[1], X8
    FMOV  D9, X21
    FMOV  V9.D[1], X8
    FMOV  D10, X26
    FMOV  V10.D[1], X7
    FMOV  D11, X16
    FMOV  V11.D[1], X13
    FMOV  D12, X18
    FMOV  V12.D[1], X21
    FMOV  D13, X25
    FMOV  V13.D[1], X17
    FMOV  D14, X8
    FMOV  V14.D[1], X6
    FMOV  D15, X24
    FMOV  V15.D[1], X9
    FMOV  D16, X8
    FMOV  V16.D[1], X7
    FMOV  D17, X16
    FMOV  V17.D[1], X5
    FMOV  D18, X13
    FMOV  V18.D[1], X26
    FMOV  D19, X3
    FMOV  V19.D[1], X9
    FMOV  D20, X25
    FMOV  V20.D[1], X6
    FMOV  D21, X28
    FMOV  V21.D[1], X24
    FMOV  D22, X28
    FMOV  V22.D[1], X26
    FMOV  D23, X7
    FMOV  V23.D[1], X4
    FMOV  D24, X24
    FMOV  V24.D[1], X23
    FMOV  D25, X27
    FMOV  V25.D[1], X8
    FMOV  D26, X18
    FMOV  V26.D[1], X24
    FMOV  D27, X8
    FMOV  V27.D[1], X21
    FMOV  D28, X23
    FMOV  V28.D[1], X26
    FMOV  D29, X10
    FMOV  V29.D[1], X4
    FMOV  D30, X8
    FMOV  V30.D[1], X17
    FMOV  D31, X3
    FMOV  V31.D[1], X29
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X6, #0x1e00, LSL #0
    ADD  X13, X30, X6, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X13]
    LD4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X13]
    ADD  X13, X13, X29
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X13]
    LD4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X13]
    ADD  X13, X13, X29, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X13]
    LD4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X13]
    ADD  X13, X13, X29
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X13]
    LD4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X13]
    ADD  X13, X13, X29
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X13]
    LD4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X13]
    ADD  X13, X13, X29
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X13]
    LD4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X13]
    ADD  X13, X13, X29, LSR #0
    ST4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X13]
    LD4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X13]
    ADD  X13, X13, X29, LSR #0
    ST4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X13]
    LD4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X13]
    ADD  X13, X13, X29
    ST4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X13]
    LD4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X13]
    ADD  X13, X13, X29
    MOV  X26, X13
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X26], #64
    MOV  X26, X13
    LD4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X26], #64
    ADD  X13, X13, X29
    MOV  X26, X13
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X26], #64
    MOV  X26, X13
    LD4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X26], #64
    ADD  X13, X13, X29, ASR #0
    MOV  X26, X13
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X26], #64
    MOV  X26, X13
    LD4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X26], #64
    ADD  X13, X13, X29, LSR #0
    MOV  X26, X13
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X26], #64
    MOV  X26, X13
    LD4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X26], #64
    ADD  X13, X13, X29
    MOV  X26, X13
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X26], #64
    MOV  X26, X13
    LD4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X26], #64
    ADD  X13, X13, X29, LSR #0
    MOV  X26, X13
    ST4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X26], #32
    MOV  X26, X13
    LD4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X26], #32
    ADD  X13, X13, X29, LSR #0
    MOV  X26, X13
    ST4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X26], #32
    MOV  X26, X13
    LD4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X26], #32
    ADD  X13, X13, X29, LSR #0
    MOV  X26, X13
    ST4 { V12.4H, V13.4H, V14.4H, V15.4H }, [X26], #32
    MOV  X26, X13
    LD4 { V8.4H, V9.4H, V10.4H, V11.4H }, [X26], #32
    ADD  X13, X13, X29, LSR #0
    MOV  X26, X13
    ST4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X26], #32
    MOV  X26, X13
    LD4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X26], #32
    ADD  X13, X13, X29, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X13], X5
    LD4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X13], X5
    ADD  X13, X13, X29
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X13], X5
    LD4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X13], X5
    ADD  X13, X13, X29
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X13], X5
    LD4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X13], X5
    ADD  X13, X13, X29
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X13], X5
    LD4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X13], X5
    ADD  X13, X13, X29, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X13], X5
    LD4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X13], X5
    ADD  X13, X13, X29
    ST4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X13], X5
    LD4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X13], X5
    ADD  X13, X13, X29, ASR #0
    ST4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X13], X5
    LD4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X13], X5
    ADD  X13, X13, X29
    ST4 { V9.4H, V10.4H, V11.4H, V12.4H }, [X13], X5
    LD4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X13], X5
    ADD  X13, X13, X29
    ST4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X13], X5
    LD4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X13], X5
    ADD  X13, X13, X29, LSR #0
    ST4 { V13.H, V14.H, V15.H, V16.H }[0x5], [X13]
    LD4 { V12.H, V13.H, V14.H, V15.H }[0x1], [X13]
    ADD  X13, X13, X29, LSR #0
    ST4 { V10.S, V11.S, V12.S, V13.S }[0x3], [X13]
    LD4 { V10.S, V11.S, V12.S, V13.S }[0x2], [X13]
    ADD  X13, X13, X29, ASR #0
    ST4 { V11.D, V12.D, V13.D, V14.D }[0x0], [X13]
    LD4 { V17.D, V18.D, V19.D, V20.D }[0x0], [X13]
    ADD  X13, X13, X29, ASR #0
    ST4 { V17.B, V18.B, V19.B, V20.B }[0xf], [X13]
    LD4 { V1.B, V2.B, V3.B, V4.B }[0x4], [X13]
    ADD  X13, X13, X29, LSR #0
    MOV  X26, X13
    ST4 { V1.H, V2.H, V3.H, V4.H }[0x3], [X26], #8
    MOV  X26, X13
    LD4 { V11.H, V12.H, V13.H, V14.H }[0x6], [X26], #8
    ADD  X13, X13, X29, ASR #0
    ST4 { V12.H, V13.H, V14.H, V15.H }[0x3], [X13], X5
    LD4 { V13.H, V14.H, V15.H, V16.H }[0x5], [X13], X5
    ADD  X13, X13, X29
    MOV  X26, X13
    ST4 { V8.S, V9.S, V10.S, V11.S }[0x2], [X26], #16
    MOV  X26, X13
    LD4 { V8.S, V9.S, V10.S, V11.S }[0x3], [X26], #16
    ADD  X13, X13, X29, ASR #0
    ST4 { V13.S, V14.S, V15.S, V16.S }[0x0], [X13], X5
    LD4 { V15.S, V16.S, V17.S, V18.S }[0x1], [X13], X5
    ADD  X13, X13, X29, ASR #0
    MOV  X26, X13
    ST4 { V8.D, V9.D, V10.D, V11.D }[0x1], [X26], #32
    MOV  X26, X13
    LD4 { V8.D, V9.D, V10.D, V11.D }[0x1], [X26], #32
    ADD  X13, X13, X29, LSR #0
    ST4 { V8.D, V9.D, V10.D, V11.D }[0x0], [X13], X5
    LD4 { V23.D, V24.D, V25.D, V26.D }[0x1], [X13], X5
    ADD  X13, X13, X29
    MOV  X26, X13
    ST4 { V23.B, V24.B, V25.B, V26.B }[0x6], [X26], #4
    MOV  X26, X13
    LD4 { V23.B, V24.B, V25.B, V26.B }[0x9], [X26], #4
    ADD  X13, X13, X29, ASR #0
    ST4 { V15.B, V16.B, V17.B, V18.B }[0x5], [X13], X5
    LD4 { V14.B, V15.B, V16.B, V17.B }[0xf], [X13], X5
    ADD  X13, X13, X29, ASR #0
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    SUB  X24, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X24, FPSR
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V0.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D0
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V1.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a00, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D1
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V2.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a00, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D2
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V3.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a00, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D3
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V4.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a00, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D4
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V5.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D5
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V6.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D6
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V7.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D7
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V8.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D8
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V9.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D9
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V10.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D10
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V11.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D11
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    FMOV  X24, V12.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D12
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    FMOV  X24, V13.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D13
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a00, LSL #48
    FMOV  X24, V14.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D14
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a00, LSL #48
    FMOV  X24, V15.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    FMOV  X24, D15
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a00, LSL #48
    FMOV  X24, V16.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    FMOV  X24, D16
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0x5a00, LSL #48
    FMOV  X24, V17.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    FMOV  X24, D17
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V18.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D18
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V19.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D19
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V20.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D20
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V21.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D21
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V22.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D22
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V23.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D23
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V24.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D24
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V25.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D25
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V26.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D26
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V27.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D27
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V28.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D28
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V29.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D29
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X24, V30.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D30
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, V31.D[1]
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    MOVZ  X19, #0x5a5a, LSL #0
    MOVK  X19, #0x5a5a, LSL #16
    MOVK  X19, #0x5a5a, LSL #32
    MOVK  X19, #0x5a5a, LSL #48
    FMOV  X24, D31
    SUB  X7, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X23
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X10
    FMOV  V3.D[1], X25
    FMOV  D4, X24
    FMOV  V4.D[1], X21
    FMOV  D5, X12
    FMOV  V5.D[1], X9
    FMOV  D6, X28
    FMOV  V6.D[1], X20
    FMOV  D7, X18
    FMOV  V7.D[1], X26
    FMOV  D8, X10
    FMOV  V8.D[1], X18
    FMOV  D9, X22
    FMOV  V9.D[1], X27
    FMOV  D10, X18
    FMOV  V10.D[1], X28
    FMOV  D11, X6
    FMOV  V11.D[1], X25
    FMOV  D12, X8
    FMOV  V12.D[1], X7
    FMOV  D13, X27
    FMOV  V13.D[1], X23
    FMOV  D14, X10
    FMOV  V14.D[1], X12
    FMOV  D15, X27
    FMOV  V15.D[1], X26
    FMOV  D16, X8
    FMOV  V16.D[1], X6
    FMOV  D17, X13
    FMOV  V17.D[1], X17
    FMOV  D18, X12
    FMOV  V18.D[1], X13
    FMOV  D19, X24
    FMOV  V19.D[1], X19
    FMOV  D20, X12
    FMOV  V20.D[1], X8
    FMOV  D21, X9
    FMOV  V21.D[1], X4
    FMOV  D22, X16
    FMOV  V22.D[1], X28
    FMOV  D23, X9
    FMOV  V23.D[1], X24
    FMOV  D24, X3
    FMOV  V24.D[1], X27
    FMOV  D25, X22
    FMOV  V25.D[1], X13
    FMOV  D26, X9
    FMOV  V26.D[1], X28
    FMOV  D27, X23
    FMOV  V27.D[1], X9
    FMOV  D28, X3
    FMOV  V28.D[1], X29
    FMOV  D29, X25
    FMOV  V29.D[1], X28
    FMOV  D30, X5
    FMOV  V30.D[1], X29
    FMOV  D31, X28
    FMOV  V31.D[1], X12
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X22, #0x2300, LSL #0
    ADD  X7, X30, X22, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X7]
    LD4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X7]
    ADD  X7, X7, X12, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X7]
    LD4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X7]
    ADD  X7, X7, X12, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X7]
    LD4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X7]
    ADD  X7, X7, X12, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X7]
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X7]
    ADD  X7, X7, X12, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X7]
    LD4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X7]
    ADD  X7, X7, X12, ASR #0
    ST4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X7]
    LD4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X7]
    ADD  X7, X7, X12, LSR #0
    ST4 { V15.2S, V16.2S, V17.2S, V18.2S }, [X7]
    LD4 { V24.2S, V25.2S, V26.2S, V27.2S }, [X7]
    ADD  X7, X7, X12, ASR #0
    ST4 { V8.4H, V9.4H, V10.4H, V11.4H }, [X7]
    LD4 { V9.4H, V10.4H, V11.4H, V12.4H }, [X7]
    ADD  X7, X7, X12
    ST4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X7]
    LD4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X7]
    ADD  X7, X7, X12, LSR #0
    MOV  X28, X7
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X28], #64
    MOV  X28, X7
    LD4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X28], #64
    ADD  X7, X7, X12, ASR #0
    MOV  X28, X7
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X28], #64
    MOV  X28, X7
    LD4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X28], #64
    ADD  X7, X7, X12, ASR #0
    MOV  X28, X7
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X28], #64
    MOV  X28, X7
    LD4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X28], #64
    ADD  X7, X7, X12
    MOV  X28, X7
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X28], #64
    MOV  X28, X7
    LD4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X28], #64
    ADD  X7, X7, X12, ASR #0
    MOV  X28, X7
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X28], #64
    MOV  X28, X7
    LD4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X28], #64
    ADD  X7, X7, X12
    MOV  X28, X7
    ST4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X28], #32
    MOV  X28, X7
    LD4 { V24.2S, V25.2S, V26.2S, V27.2S }, [X28], #32
    ADD  X7, X7, X12, ASR #0
    MOV  X28, X7
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X28], #32
    MOV  X28, X7
    LD4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X28], #32
    ADD  X7, X7, X12
    MOV  X28, X7
    ST4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X28], #32
    MOV  X28, X7
    LD4 { V23.4H, V24.4H, V25.4H, V26.4H }, [X28], #32
    ADD  X7, X7, X12, LSR #0
    MOV  X28, X7
    ST4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X28], #32
    MOV  X28, X7
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X28], #32
    ADD  X7, X7, X12, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X7], X17
    LD4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X7], X17
    ADD  X7, X7, X12, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X7], X17
    LD4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X7], X17
    ADD  X7, X7, X12, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X7], X17
    LD4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X7], X17
    ADD  X7, X7, X12
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X7], X17
    LD4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X7], X17
    ADD  X7, X7, X12, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X7], X17
    LD4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X7], X17
    ADD  X7, X7, X12, LSR #0
    ST4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X7], X17
    LD4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X7], X17
    ADD  X7, X7, X12, ASR #0
    ST4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X7], X17
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X7], X17
    ADD  X7, X7, X12, ASR #0
    ST4 { V17.4H, V18.4H, V19.4H, V20.4H }, [X7], X17
    LD4 { V17.4H, V18.4H, V19.4H, V20.4H }, [X7], X17
    ADD  X7, X7, X12, ASR #0
    ST4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X7], X17
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X7], X17
    ADD  X7, X7, X12, ASR #0
    ST4 { V1.H, V2.H, V3.H, V4.H }[0x3], [X7]
    LD4 { V12.H, V13.H, V14.H, V15.H }[0x4], [X7]
    ADD  X7, X7, X12, LSR #0
    ST4 { V23.S, V24.S, V25.S, V26.S }[0x0], [X7]
    LD4 { V1.S, V2.S, V3.S, V4.S }[0x3], [X7]
    ADD  X7, X7, X12, LSR #0
    ST4 { V6.D, V7.D, V8.D, V9.D }[0x1], [X7]
    LD4 { V23.D, V24.D, V25.D, V26.D }[0x1], [X7]
    ADD  X7, X7, X12, ASR #0
    ST4 { V12.B, V13.B, V14.B, V15.B }[0x3], [X7]
    LD4 { V24.B, V25.B, V26.B, V27.B }[0x5], [X7]
    ADD  X7, X7, X12, LSR #0
    MOV  X28, X7
    ST4 { V1.H, V2.H, V3.H, V4.H }[0x0], [X28], #8
    MOV  X28, X7
    LD4 { V1.H, V2.H, V3.H, V4.H }[0x1], [X28], #8
    ADD  X7, X7, X12, ASR #0
    ST4 { V24.H, V25.H, V26.H, V27.H }[0x0], [X7], X17
    LD4 { V12.H, V13.H, V14.H, V15.H }[0x6], [X7], X17
    ADD  X7, X7, X12, ASR #0
    MOV  X28, X7
    ST4 { V12.S, V13.S, V14.S, V15.S }[0x0], [X28], #16
    MOV  X28, X7
    LD4 { V24.S, V25.S, V26.S, V27.S }[0x1], [X28], #16
    ADD  X7, X7, X12
    ST4 { V13.S, V14.S, V15.S, V16.S }[0x0], [X7], X17
    LD4 { V6.S, V7.S, V8.S, V9.S }[0x0], [X7], X17
    ADD  X7, X7, X12, LSR #0
    MOV  X28, X7
    ST4 { V6.D, V7.D, V8.D, V9.D }[0x1], [X28], #32
    MOV  X28, X7
    LD4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X28], #32
    ADD  X7, X7, X12, ASR #0
    ST4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X7], X17
    LD4 { V12.D, V13.D, V14.D, V15.D }[0x1], [X7], X17
    ADD  X7, X7, X12
    MOV  X28, X7
    ST4 { V12.B, V13.B, V14.B, V15.B }[0x0], [X28], #4
    MOV  X28, X7
    LD4 { V13.B, V14.B, V15.B, V16.B }[0x1], [X28], #4
    ADD  X7, X7, X12, LSR #0
    ST4 { V24.B, V25.B, V26.B, V27.B }[0x3], [X7], X17
    LD4 { V3.B, V4.B, V5.B, V6.B }[0x6], [X7], X17
    ADD  X7, X7, X12, LSR #0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X16, FPSR
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V0.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D0
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V1.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D1
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V2.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D2
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V3.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D3
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V4.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D4
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V5.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D5
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V6.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D6
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V7.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D7
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V8.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D8
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V9.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D9
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V10.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D10
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V11.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D11
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V12.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D12
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V13.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D13
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V14.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D14
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V15.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D15
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V16.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D16
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V17.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D17
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V18.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D18
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V19.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D19
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V20.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D20
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V21.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D21
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, V22.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D22
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V23.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D23
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V24.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D24
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V25.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D25
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V26.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D26
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V27.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D27
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V28.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D28
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V29.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D29
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V30.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D30
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X16, V31.D[1]
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    FMOV  X16, D31
    SUB  X4, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X26
    FMOV  V2.D[1], X17
    FMOV  D3, X22
    FMOV  V3.D[1], X28
    FMOV  D4, X9
    FMOV  V4.D[1], X23
    FMOV  D5, X7
    FMOV  V5.D[1], X13
    FMOV  D6, X4
    FMOV  V6.D[1], X25
    FMOV  D7, X27
    FMOV  V7.D[1], X26
    FMOV  D8, X9
    FMOV  V8.D[1], X28
    FMOV  D9, X24
    FMOV  V9.D[1], X26
    FMOV  D10, X20
    FMOV  V10.D[1], X4
    FMOV  D11, X8
    FMOV  V11.D[1], X12
    FMOV  D12, X28
    FMOV  V12.D[1], X10
    FMOV  D13, X7
    FMOV  V13.D[1], X6
    FMOV  D14, X9
    FMOV  V14.D[1], X25
    FMOV  D15, X13
    FMOV  V15.D[1], X26
    FMOV  D16, X21
    FMOV  V16.D[1], X17
    FMOV  D17, X16
    FMOV  V17.D[1], X24
    FMOV  D18, X29
    FMOV  V18.D[1], X9
    FMOV  D19, X16
    FMOV  V19.D[1], X28
    FMOV  D20, X22
    FMOV  V20.D[1], X28
    FMOV  D21, X13
    FMOV  V21.D[1], X17
    FMOV  D22, X13
    FMOV  V22.D[1], X16
    FMOV  D23, X24
    FMOV  V23.D[1], X23
    FMOV  D24, X18
    FMOV  V24.D[1], X29
    FMOV  D25, X27
    FMOV  V25.D[1], X22
    FMOV  D26, X26
    FMOV  V26.D[1], X12
    FMOV  D27, X12
    FMOV  V27.D[1], X7
    FMOV  D28, X17
    FMOV  V28.D[1], X18
    FMOV  D29, X20
    FMOV  V29.D[1], X12
    FMOV  D30, X17
    FMOV  V30.D[1], X28
    FMOV  D31, X16
    FMOV  V31.D[1], X21
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X24, #0x2800, LSL #0
    ADD  X12, X30, X24
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X12]
    LD4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X12]
    ADD  X12, X12, X27, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X12]
    LD4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X12]
    ADD  X12, X12, X27, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X12]
    LD4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X12]
    ADD  X12, X12, X27, ASR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X12]
    LD4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X12]
    ADD  X12, X12, X27
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X12]
    LD4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X12]
    ADD  X12, X12, X27
    ST4 { V14.2S, V15.2S, V16.2S, V17.2S }, [X12]
    LD4 { V12.8B, V13.8B, V14.8B, V15.8B }, [X12]
    ADD  X12, X12, X27
    ST4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X12]
    LD4 { V4.2S, V5.2S, V6.2S, V7.2S }, [X12]
    ADD  X12, X12, X27
    ST4 { V4.4H, V5.4H, V6.4H, V7.4H }, [X12]
    LD4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X12]
    ADD  X12, X12, X27, ASR #0
    ST4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X12]
    LD4 { V19.8B, V20.8B, V21.8B, V22.8B }, [X12]
    ADD  X12, X12, X27, ASR #0
    MOV  X29, X12
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X29], #64
    MOV  X29, X12
    LD4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X29], #64
    ADD  X12, X12, X27
    MOV  X29, X12
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X29], #64
    MOV  X29, X12
    LD4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X29], #64
    ADD  X12, X12, X27, LSR #0
    MOV  X29, X12
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X29], #64
    MOV  X29, X12
    LD4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X29], #64
    ADD  X12, X12, X27
    MOV  X29, X12
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X29], #64
    MOV  X29, X12
    LD4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X29], #64
    ADD  X12, X12, X27, LSR #0
    MOV  X29, X12
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X29], #64
    MOV  X29, X12
    LD4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X29], #64
    ADD  X12, X12, X27
    MOV  X29, X12
    ST4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X29], #32
    MOV  X29, X12
    LD4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X29], #32
    ADD  X12, X12, X27, LSR #0
    MOV  X29, X12
    ST4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X29], #32
    MOV  X29, X12
    LD4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X29], #32
    ADD  X12, X12, X27
    MOV  X29, X12
    ST4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X29], #32
    MOV  X29, X12
    LD4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X29], #32
    ADD  X12, X12, X27, ASR #0
    MOV  X29, X12
    ST4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X29], #32
    MOV  X29, X12
    LD4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X29], #32
    ADD  X12, X12, X27
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X12], X19
    LD4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X12], X19
    ADD  X12, X12, X27, ASR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X12], X19
    LD4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X12], X19
    ADD  X12, X12, X27
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X12], X19
    LD4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X12], X19
    ADD  X12, X12, X27, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X12], X19
    LD4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X12], X19
    ADD  X12, X12, X27, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X12], X19
    LD4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X12], X19
    ADD  X12, X12, X27, LSR #0
    ST4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X12], X19
    LD4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X12], X19
    ADD  X12, X12, X27, ASR #0
    ST4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X12], X19
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X12], X19
    ADD  X12, X12, X27, LSR #0
    ST4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X12], X19
    LD4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X12], X19
    ADD  X12, X12, X27
    ST4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X12], X19
    LD4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X12], X19
    ADD  X12, X12, X27
    ST4 { V0.H, V1.H, V2.H, V3.H }[0x5], [X12]
    LD4 { V25.H, V26.H, V27.H, V28.H }[0x1], [X12]
    ADD  X12, X12, X27
    ST4 { V17.S, V18.S, V19.S, V20.S }[0x0], [X12]
    LD4 { V13.S, V14.S, V15.S, V16.S }[0x2], [X12]
    ADD  X12, X12, X27, ASR #0
    ST4 { V25.D, V26.D, V27.D, V28.D }[0x1], [X12]
    LD4 { V7.D, V8.D, V9.D, V10.D }[0x0], [X12]
    ADD  X12, X12, X27, ASR #0
    ST4 { V7.B, V8.B, V9.B, V10.B }[0x2], [X12]
    LD4 { V7.B, V8.B, V9.B, V10.B }[0xa], [X12]
    ADD  X12, X12, X27, LSR #0
    MOV  X29, X12
    ST4 { V13.H, V14.H, V15.H, V16.H }[0x4], [X29], #8
    MOV  X29, X12
    LD4 { V13.H, V14.H, V15.H, V16.H }[0x1], [X29], #8
    ADD  X12, X12, X27, LSR #0
    ST4 { V13.H, V14.H, V15.H, V16.H }[0x7], [X12], X19
    LD4 { V17.H, V18.H, V19.H, V20.H }[0x0], [X12], X19
    ADD  X12, X12, X27, LSR #0
    MOV  X29, X12
    ST4 { V17.S, V18.S, V19.S, V20.S }[0x0], [X29], #16
    MOV  X29, X12
    LD4 { V0.S, V1.S, V2.S, V3.S }[0x3], [X29], #16
    ADD  X12, X12, X27
    ST4 { V0.S, V1.S, V2.S, V3.S }[0x3], [X12], X19
    LD4 { V13.S, V14.S, V15.S, V16.S }[0x1], [X12], X19
    ADD  X12, X12, X27
    MOV  X29, X12
    ST4 { V7.D, V8.D, V9.D, V10.D }[0x1], [X29], #32
    MOV  X29, X12
    LD4 { V17.D, V18.D, V19.D, V20.D }[0x1], [X29], #32
    ADD  X12, X12, X27
    ST4 { V16.D, V17.D, V18.D, V19.D }[0x1], [X12], X19
    LD4 { V16.D, V17.D, V18.D, V19.D }[0x1], [X12], X19
    ADD  X12, X12, X27
    MOV  X29, X12
    ST4 { V30.B, V31.B, V0.B, V1.B }[0x1], [X29], #4
    MOV  X29, X12
    LD4 { V0.B, V1.B, V2.B, V3.B }[0xa], [X29], #4
    ADD  X12, X12, X27
    ST4 { V13.B, V14.B, V15.B, V16.B }[0xf], [X12], X19
    LD4 { V3.B, V4.B, V5.B, V6.B }[0x3], [X12], X19
    ADD  X12, X12, X27, LSR #0
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X3, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    MRS  X3, FPSR
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V0.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D0
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V1.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D1
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V2.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D2
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V3.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D3
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D4
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V5.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D5
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D6
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D7
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a00, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V8.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D8
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a00, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V9.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D9
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a00, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V10.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, D10
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V11.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D11
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V12.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D12
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V13.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D13
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V14.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D14
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    FMOV  X3, V15.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D15
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    FMOV  X3, V16.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D16
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V17.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D17
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a00, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V18.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D18
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a00, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V19.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D19
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a00, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V20.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D20
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V21.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D21
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V22.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D22
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V23.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D23
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V24.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D24
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D25
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D26
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V27.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D27
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x0, LSL #0
    FMOV  X3, V28.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D28
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V29.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D29
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V30.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D30
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, V31.D[1]
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    FMOV  X3, D31
    SUB  X25, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X23
    FMOV  V2.D[1], X3
    FMOV  D3, X12
    FMOV  V3.D[1], X26
    FMOV  D4, X6
    FMOV  V4.D[1], X13
    FMOV  D5, X29
    FMOV  V5.D[1], X6
    FMOV  D6, X24
    FMOV  V6.D[1], X27
    FMOV  D7, X13
    FMOV  V7.D[1], X9
    FMOV  D8, X5
    FMOV  V8.D[1], X25
    FMOV  D9, X27
    FMOV  V9.D[1], X29
    FMOV  D10, X8
    FMOV  V10.D[1], X18
    FMOV  D11, X22
    FMOV  V11.D[1], X7
    FMOV  D12, X24
    FMOV  V12.D[1], X22
    FMOV  D13, X21
    FMOV  V13.D[1], X22
    FMOV  D14, X25
    FMOV  V14.D[1], X8
    FMOV  D15, X22
    FMOV  V15.D[1], X17
    FMOV  D16, X8
    FMOV  V16.D[1], X4
    FMOV  D17, X3
    FMOV  V17.D[1], X13
    FMOV  D18, X21
    FMOV  V18.D[1], X28
    FMOV  D19, X22
    FMOV  V19.D[1], X24
    FMOV  D20, X8
    FMOV  V20.D[1], X22
    FMOV  D21, X27
    FMOV  V21.D[1], X20
    FMOV  D22, X29
    FMOV  V22.D[1], X9
    FMOV  D23, X28
    FMOV  V23.D[1], X8
    FMOV  D24, X17
    FMOV  V24.D[1], X16
    FMOV  D25, X23
    FMOV  V25.D[1], X19
    FMOV  D26, X20
    FMOV  V26.D[1], X9
    FMOV  D27, X25
    FMOV  V27.D[1], X18
    FMOV  D28, X17
    FMOV  V28.D[1], X29
    FMOV  D29, X13
    FMOV  V29.D[1], X7
    FMOV  D30, X29
    FMOV  V30.D[1], X13
    FMOV  D31, X25
    FMOV  V31.D[1], X5
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X18, #0x40, LSL #0
    MOVZ  X22, #0x2d00, LSL #0
    ADD  X9, X30, X22, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X9]
    LD4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X9]
    ADD  X9, X9, X18
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X9]
    LD4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X9]
    ADD  X9, X9, X18, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X9]
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X9]
    ADD  X9, X9, X18
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X9]
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X9]
    ADD  X9, X9, X18, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X9]
    LD4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X9]
    ADD  X9, X9, X18
    ST4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X9]
    LD4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X9]
    ADD  X9, X9, X18, ASR #0
    ST4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X9]
    LD4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X9]
    ADD  X9, X9, X18
    ST4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X9]
    LD4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X9]
    ADD  X9, X9, X18, ASR #0
    ST4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X9]
    LD4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X9]
    ADD  X9, X9, X18, LSR #0
    MOV  X8, X9
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X8], #64
    MOV  X8, X9
    LD4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X8], #64
    ADD  X9, X9, X18, LSR #0
    MOV  X8, X9
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X8], #64
    MOV  X8, X9
    LD4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X8], #64
    ADD  X9, X9, X18, ASR #0
    MOV  X8, X9
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X8], #64
    MOV  X8, X9
    LD4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X8], #64
    ADD  X9, X9, X18
    MOV  X8, X9
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X8], #64
    MOV  X8, X9
    LD4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X8], #64
    ADD  X9, X9, X18
    MOV  X8, X9
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X8], #64
    MOV  X8, X9
    LD4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X8], #64
    ADD  X9, X9, X18, LSR #0
    MOV  X8, X9
    ST4 { V23.4H, V24.4H, V25.4H, V26.4H }, [X8], #32
    MOV  X8, X9
    LD4 { V12.4H, V13.4H, V14.4H, V15.4H }, [X8], #32
    ADD  X9, X9, X18, ASR #0
    MOV  X8, X9
    ST4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X8], #32
    MOV  X8, X9
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X8], #32
    ADD  X9, X9, X18, ASR #0
    MOV  X8, X9
    ST4 { V12.4H, V13.4H, V14.4H, V15.4H }, [X8], #32
    MOV  X8, X9
    LD4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X8], #32
    ADD  X9, X9, X18, ASR #0
    MOV  X8, X9
    ST4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X8], #32
    MOV  X8, X9
    LD4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X8], #32
    ADD  X9, X9, X18, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X9], X10
    LD4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X9], X10
    ADD  X9, X9, X18, LSR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X9], X10
    LD4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X9], X10
    ADD  X9, X9, X18
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X9], X10
    LD4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X9], X10
    ADD  X9, X9, X18
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X9], X10
    LD4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X9], X10
    ADD  X9, X9, X18, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X9], X10
    LD4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X9], X10
    ADD  X9, X9, X18, LSR #0
    ST4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X9], X10
    LD4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X9], X10
    ADD  X9, X9, X18, ASR #0
    ST4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X9], X10
    LD4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X9], X10
    ADD  X9, X9, X18, LSR #0
    ST4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X9], X10
    LD4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X9], X10
    ADD  X9, X9, X18, LSR #0
    ST4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X9], X10
    LD4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X9], X10
    ADD  X9, X9, X18, ASR #0
    ST4 { V17.H, V18.H, V19.H, V20.H }[0x6], [X9]
    LD4 { V0.H, V1.H, V2.H, V3.H }[0x6], [X9]
    ADD  X9, X9, X18
    ST4 { V17.S, V18.S, V19.S, V20.S }[0x1], [X9]
    LD4 { V17.S, V18.S, V19.S, V20.S }[0x2], [X9]
    ADD  X9, X9, X18, LSR #0
    ST4 { V18.D, V19.D, V20.D, V21.D }[0x1], [X9]
    LD4 { V19.D, V20.D, V21.D, V22.D }[0x1], [X9]
    ADD  X9, X9, X18, ASR #0
    ST4 { V31.B, V0.B, V1.B, V2.B }[0xc], [X9]
    LD4 { V10.B, V11.B, V12.B, V13.B }[0xf], [X9]
    ADD  X9, X9, X18
    MOV  X8, X9
    ST4 { V19.H, V20.H, V21.H, V22.H }[0x3], [X8], #8
    MOV  X8, X9
    LD4 { V31.H, V0.H, V1.H, V2.H }[0x0], [X8], #8
    ADD  X9, X9, X18, LSR #0
    ST4 { V31.H, V0.H, V1.H, V2.H }[0x6], [X9], X10
    LD4 { V3.H, V4.H, V5.H, V6.H }[0x2], [X9], X10
    ADD  X9, X9, X18
    MOV  X8, X9
    ST4 { V3.S, V4.S, V5.S, V6.S }[0x0], [X8], #16
    MOV  X8, X9
    LD4 { V13.S, V14.S, V15.S, V16.S }[0x0], [X8], #16
    ADD  X9, X9, X18
    ST4 { V13.S, V14.S, V15.S, V16.S }[0x3], [X9], X10
    LD4 { V13.S, V14.S, V15.S, V16.S }[0x0], [X9], X10
    ADD  X9, X9, X18
    MOV  X8, X9
    ST4 { V17.D, V18.D, V19.D, V20.D }[0x0], [X8], #32
    MOV  X8, X9
    LD4 { V3.D, V4.D, V5.D, V6.D }[0x0], [X8], #32
    ADD  X9, X9, X18, ASR #0
    ST4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X9], X10
    LD4 { V31.D, V0.D, V1.D, V2.D }[0x1], [X9], X10
    ADD  X9, X9, X18
    MOV  X8, X9
    ST4 { V31.B, V0.B, V1.B, V2.B }[0x0], [X8], #4
    MOV  X8, X9
    LD4 { V13.B, V14.B, V15.B, V16.B }[0xd], [X8], #4
    ADD  X9, X9, X18
    ST4 { V13.B, V14.B, V15.B, V16.B }[0x7], [X9], X10
    LD4 { V12.B, V13.B, V14.B, V15.B }[0x4], [X9], X10
    ADD  X9, X9, X18, ASR #0
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    MRS  X27, FPSR
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V0.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D0
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V1.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D1
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D2
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V3.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D3
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V4.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D4
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V5.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D5
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V6.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D6
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V7.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D7
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V8.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D8
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V9.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D9
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5, LSL #48
    FMOV  X27, V10.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D10
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5, LSL #48
    FMOV  X27, V11.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D11
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V12.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D12
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa500, LSL #32
    FMOV  X27, V13.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D13
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa500, LSL #32
    FMOV  X27, V14.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D14
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa500, LSL #32
    FMOV  X27, V15.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D15
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa500, LSL #32
    FMOV  X27, V16.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D16
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    FMOV  X27, V17.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D17
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    FMOV  X27, V18.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D18
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    FMOV  X27, V19.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D19
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    FMOV  X27, V20.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D20
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    FMOV  X27, V21.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D21
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V22.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D22
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V23.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D23
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V24.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D24
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, V25.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D25
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V26.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D26
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V27.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D27
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V28.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D28
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V29.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D29
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V30.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D30
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X27, V31.D[1]
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    FMOV  X27, D31
    SUB  X3, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP07_TestFail

AdvsimdLoadStoreP07_TestEnd:
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
AdvsimdLoadStoreP07_TestFail:
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
