.global AdvsimdLoadStoreP06

.text
.p2align 4

AdvsimdLoadStoreP06:

AdvsimdLoadStoreP06_TestBegin:
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
    MOVZ  X2, #0xacdd, LSL #0
    MOVK  X2, #0x31c9, LSL #16
    MOVK  X2, #0xc11b, LSL #32
    MOVK  X2, #0x8f36, LSL #48
    MOVZ  X3, #0xc6cc, LSL #0
    MOVK  X3, #0x1a9f, LSL #16
    MOVK  X3, #0xb23c, LSL #32
    MOVK  X3, #0xf263, LSL #48
    MOVZ  X4, #0x357, LSL #0
    MOVK  X4, #0xd7b8, LSL #16
    MOVK  X4, #0x2c18, LSL #32
    MOVK  X4, #0x7219, LSL #48
    MOVZ  X5, #0xac74, LSL #0
    MOVK  X5, #0x6610, LSL #16
    MOVK  X5, #0x1b33, LSL #32
    MOVK  X5, #0xfca8, LSL #48
    MOVZ  X7, #0xc90d, LSL #0
    MOVK  X7, #0xda56, LSL #16
    MOVK  X7, #0x61db, LSL #32
    MOVK  X7, #0xc166, LSL #48
    MOVZ  X8, #0xcdd5, LSL #0
    MOVK  X8, #0x581d, LSL #16
    MOVK  X8, #0xb24d, LSL #32
    MOVK  X8, #0x200e, LSL #48
    MOVZ  X9, #0x4d5b, LSL #0
    MOVK  X9, #0x9d52, LSL #16
    MOVK  X9, #0x1fe6, LSL #32
    MOVK  X9, #0x672d, LSL #48
    MOVZ  X10, #0x3d53, LSL #0
    MOVK  X10, #0x1f11, LSL #16
    MOVK  X10, #0x3572, LSL #32
    MOVK  X10, #0x7d4c, LSL #48
    MOVZ  X11, #0x634, LSL #0
    MOVK  X11, #0xcb63, LSL #16
    MOVK  X11, #0xe409, LSL #32
    MOVK  X11, #0x7e94, LSL #48
    MOVZ  X12, #0xd354, LSL #0
    MOVK  X12, #0x3423, LSL #16
    MOVK  X12, #0x35a, LSL #32
    MOVK  X12, #0x59cf, LSL #48
    MOVZ  X13, #0x51bc, LSL #0
    MOVK  X13, #0x3343, LSL #16
    MOVK  X13, #0xca26, LSL #32
    MOVK  X13, #0x499e, LSL #48
    MOVZ  X14, #0xbfd3, LSL #0
    MOVK  X14, #0xb2f4, LSL #16
    MOVK  X14, #0x8f1c, LSL #32
    MOVK  X14, #0xc416, LSL #48
    MOVZ  X16, #0x404f, LSL #0
    MOVK  X16, #0xb2bc, LSL #16
    MOVK  X16, #0x63d4, LSL #32
    MOVK  X16, #0x5989, LSL #48
    MOVZ  X17, #0x9a78, LSL #0
    MOVK  X17, #0xc144, LSL #16
    MOVK  X17, #0x8cdb, LSL #32
    MOVK  X17, #0x4081, LSL #48
    MOVZ  X19, #0xf18a, LSL #0
    MOVK  X19, #0xf3d1, LSL #16
    MOVK  X19, #0x24e8, LSL #32
    MOVK  X19, #0xcd12, LSL #48
    MOVZ  X20, #0x6df3, LSL #0
    MOVK  X20, #0x7f55, LSL #16
    MOVK  X20, #0xe2d7, LSL #32
    MOVK  X20, #0x1b5f, LSL #48
    MOVZ  X21, #0x2dea, LSL #0
    MOVK  X21, #0x5328, LSL #16
    MOVK  X21, #0x6f15, LSL #32
    MOVK  X21, #0x1682, LSL #48
    MOVZ  X22, #0x89e, LSL #0
    MOVK  X22, #0x3b65, LSL #16
    MOVK  X22, #0xf0c6, LSL #32
    MOVK  X22, #0xe82f, LSL #48
    MOVZ  X23, #0x690d, LSL #0
    MOVK  X23, #0x695c, LSL #16
    MOVK  X23, #0x2f56, LSL #32
    MOVK  X23, #0x8e88, LSL #48
    MOVZ  X25, #0xd7c0, LSL #0
    MOVK  X25, #0xaf01, LSL #16
    MOVK  X25, #0x2140, LSL #32
    MOVK  X25, #0xbafc, LSL #48
    MOVZ  X26, #0xfc00, LSL #0
    MOVK  X26, #0x587, LSL #16
    MOVK  X26, #0x242d, LSL #32
    MOVK  X26, #0xf89e, LSL #48
    MOVZ  X27, #0x6620, LSL #0
    MOVK  X27, #0x531f, LSL #16
    MOVK  X27, #0x9c7d, LSL #32
    MOVK  X27, #0x3001, LSL #48
    MOVZ  X28, #0xcce1, LSL #0
    MOVK  X28, #0x24c5, LSL #16
    MOVK  X28, #0xce14, LSL #32
    MOVK  X28, #0xf99a, LSL #48
    MOVZ  X29, #0x817a, LSL #0
    MOVK  X29, #0x3f2f, LSL #16
    MOVK  X29, #0xc23d, LSL #32
    MOVK  X29, #0x3350, LSL #48
    MOVZ  X11, #0xcc69, LSL #0
    MOVK  X11, #0x9a84, LSL #16
    MOVK  X11, #0xbed9, LSL #32
    MOVK  X11, #0xc04b, LSL #48
    MSR  FPCR, X11
    MOVZ  X11, #0x3eff, LSL #0
    MOVK  X11, #0xb72a, LSL #16
    MOVK  X11, #0xe253, LSL #32
    MOVK  X11, #0xca72, LSL #48
    MSR  FPSR, X11
    MRS  X13, FPSR
    MOVZ  X22, #0xff60, LSL #0
    MOVK  X22, #0x7ff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    AND  X13, X13, X22
    MOVZ  X22, #0x0, LSL #0
    ORR  X13, X13, X22
    MSR  FPSR, X13
    ISB  SY
    ADDS  W14, W14, W5, SXTX #2
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X23
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X17
    FMOV  V3.D[1], X16
    FMOV  D4, X22
    FMOV  V4.D[1], X25
    FMOV  D5, X19
    FMOV  V5.D[1], X20
    FMOV  D6, X7
    FMOV  V6.D[1], X2
    FMOV  D7, X27
    FMOV  V7.D[1], X17
    FMOV  D8, X12
    FMOV  V8.D[1], X11
    FMOV  D9, X7
    FMOV  V9.D[1], X27
    FMOV  D10, X20
    FMOV  V10.D[1], X10
    FMOV  D11, X21
    FMOV  V11.D[1], X29
    FMOV  D12, X10
    FMOV  V12.D[1], X17
    FMOV  D13, X12
    FMOV  V13.D[1], X22
    FMOV  D14, X27
    FMOV  V14.D[1], X4
    FMOV  D15, X25
    FMOV  V15.D[1], X13
    FMOV  D16, X27
    FMOV  V16.D[1], X12
    FMOV  D17, X5
    FMOV  V17.D[1], X16
    FMOV  D18, X3
    FMOV  V18.D[1], X17
    FMOV  D19, X16
    FMOV  V19.D[1], X3
    FMOV  D20, X17
    FMOV  V20.D[1], X12
    FMOV  D21, X9
    FMOV  V21.D[1], X20
    FMOV  D22, X26
    FMOV  V22.D[1], X28
    FMOV  D23, X13
    FMOV  V23.D[1], X2
    FMOV  D24, X22
    FMOV  V24.D[1], X17
    FMOV  D25, X13
    FMOV  V25.D[1], X14
    FMOV  D26, X27
    FMOV  V26.D[1], X29
    FMOV  D27, X13
    FMOV  V27.D[1], X19
    FMOV  D28, X23
    FMOV  V28.D[1], X12
    FMOV  D29, X19
    FMOV  V29.D[1], X22
    FMOV  D30, X3
    FMOV  V30.D[1], X17
    FMOV  D31, X9
    FMOV  V31.D[1], X4
    MOVZ  X14, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X10, #0x0, LSL #0
    ADD  X17, X30, X10, ASR #0
    ST3 { V26.16B, V27.16B, V28.16B }, [X17]
    LD3 { V1.4S, V2.4S, V3.4S }, [X17]
    ADD  X17, X17, X19, ASR #0
    ST3 { V2.16B, V3.16B, V4.16B }, [X17]
    LD3 { V9.16B, V10.16B, V11.16B }, [X17]
    ADD  X17, X17, X19, ASR #0
    ST3 { V1.2D, V2.2D, V3.2D }, [X17]
    LD3 { V17.2D, V18.2D, V19.2D }, [X17]
    ADD  X17, X17, X19, LSR #0
    ST3 { V9.4S, V10.4S, V11.4S }, [X17]
    LD3 { V6.4S, V7.4S, V8.4S }, [X17]
    ADD  X17, X17, X19, LSR #0
    ST3 { V17.8H, V18.8H, V19.8H }, [X17]
    LD3 { V29.8H, V30.8H, V31.8H }, [X17]
    ADD  X17, X17, X19
    ST3 { V29.8B, V30.8B, V31.8B }, [X17]
    LD3 { V9.2S, V10.2S, V11.2S }, [X17]
    ADD  X17, X17, X19, LSR #0
    ST3 { V6.2S, V7.2S, V8.2S }, [X17]
    LD3 { V6.2S, V7.2S, V8.2S }, [X17]
    ADD  X17, X17, X19, ASR #0
    ST3 { V6.4H, V7.4H, V8.4H }, [X17]
    LD3 { V29.4H, V30.4H, V31.4H }, [X17]
    ADD  X17, X17, X19, LSR #0
    ST3 { V9.8B, V10.8B, V11.8B }, [X17]
    LD3 { V6.8B, V7.8B, V8.8B }, [X17]
    ADD  X17, X17, X19
    MOV  X22, X17
    ST3 { V26.8H, V27.8H, V28.8H }, [X22], #48
    MOV  X22, X17
    LD3 { V2.2D, V3.2D, V4.2D }, [X22], #48
    ADD  X17, X17, X19, ASR #0
    MOV  X22, X17
    ST3 { V6.16B, V7.16B, V8.16B }, [X22], #48
    MOV  X22, X17
    LD3 { V6.16B, V7.16B, V8.16B }, [X22], #48
    ADD  X17, X17, X19, ASR #0
    MOV  X22, X17
    ST3 { V29.2D, V30.2D, V31.2D }, [X22], #48
    MOV  X22, X17
    LD3 { V26.2D, V27.2D, V28.2D }, [X22], #48
    ADD  X17, X17, X19
    MOV  X22, X17
    ST3 { V8.4S, V9.4S, V10.4S }, [X22], #48
    MOV  X22, X17
    LD3 { V11.4S, V12.4S, V13.4S }, [X22], #48
    ADD  X17, X17, X19
    MOV  X22, X17
    ST3 { V26.8H, V27.8H, V28.8H }, [X22], #48
    MOV  X22, X17
    LD3 { V29.8H, V30.8H, V31.8H }, [X22], #48
    ADD  X17, X17, X19, LSR #0
    MOV  X22, X17
    ST3 { V11.2S, V12.2S, V13.2S }, [X22], #24
    MOV  X22, X17
    LD3 { V20.2S, V21.2S, V22.2S }, [X22], #24
    ADD  X17, X17, X19
    MOV  X22, X17
    ST3 { V2.2S, V3.2S, V4.2S }, [X22], #24
    MOV  X22, X17
    LD3 { V9.2S, V10.2S, V11.2S }, [X22], #24
    ADD  X17, X17, X19, ASR #0
    MOV  X22, X17
    ST3 { V29.4H, V30.4H, V31.4H }, [X22], #24
    MOV  X22, X17
    LD3 { V26.4H, V27.4H, V28.4H }, [X22], #24
    ADD  X17, X17, X19, ASR #0
    MOV  X22, X17
    ST3 { V20.8B, V21.8B, V22.8B }, [X22], #24
    MOV  X22, X17
    LD3 { V2.8B, V3.8B, V4.8B }, [X22], #24
    ADD  X17, X17, X19, ASR #0
    ST3 { V2.8H, V3.8H, V4.8H }, [X17], X14
    LD3 { V2.16B, V3.16B, V4.16B }, [X17], X14
    ADD  X17, X17, X19, ASR #0
    ST3 { V26.16B, V27.16B, V28.16B }, [X17], X14
    LD3 { V20.16B, V21.16B, V22.16B }, [X17], X14
    ADD  X17, X17, X19, LSR #0
    ST3 { V2.2D, V3.2D, V4.2D }, [X17], X14
    LD3 { V27.2D, V28.2D, V29.2D }, [X17], X14
    ADD  X17, X17, X19, ASR #0
    ST3 { V20.4S, V21.4S, V22.4S }, [X17], X14
    LD3 { V30.4S, V31.4S, V0.4S }, [X17], X14
    ADD  X17, X17, X19, LSR #0
    ST3 { V28.8H, V29.8H, V30.8H }, [X17], X14
    LD3 { V20.8H, V21.8H, V22.8H }, [X17], X14
    ADD  X17, X17, X19
    ST3 { V20.8B, V21.8B, V22.8B }, [X17], X14
    LD3 { V28.2S, V29.2S, V30.2S }, [X17], X14
    ADD  X17, X17, X19, ASR #0
    ST3 { V9.2S, V10.2S, V11.2S }, [X17], X14
    LD3 { V20.2S, V21.2S, V22.2S }, [X17], X14
    ADD  X17, X17, X19, LSR #0
    ST3 { V30.4H, V31.4H, V0.4H }, [X17], X14
    LD3 { V2.4H, V3.4H, V4.4H }, [X17], X14
    ADD  X17, X17, X19, LSR #0
    ST3 { V20.8B, V21.8B, V22.8B }, [X17], X14
    LD3 { V9.8B, V10.8B, V11.8B }, [X17], X14
    ADD  X17, X17, X19, ASR #0
    ST3 { V29.H, V30.H, V31.H }[0x3], [X17]
    LD3 { V30.H, V31.H, V0.H }[0x0], [X17]
    ADD  X17, X17, X19, LSR #0
    ST3 { V30.S, V31.S, V0.S }[0x0], [X17]
    LD3 { V30.S, V31.S, V0.S }[0x0], [X17]
    ADD  X17, X17, X19, ASR #0
    ST3 { V2.D, V3.D, V4.D }[0x1], [X17]
    LD3 { V2.D, V3.D, V4.D }[0x0], [X17]
    ADD  X17, X17, X19
    ST3 { V9.B, V10.B, V11.B }[0x8], [X17]
    LD3 { V20.B, V21.B, V22.B }[0x8], [X17]
    ADD  X17, X17, X19, ASR #0
    MOV  X22, X17
    ST3 { V20.H, V21.H, V22.H }[0x1], [X22], #6
    MOV  X22, X17
    LD3 { V17.H, V18.H, V19.H }[0x6], [X22], #6
    ADD  X17, X17, X19
    ST3 { V2.H, V3.H, V4.H }[0x0], [X17], X14
    LD3 { V24.H, V25.H, V26.H }[0x4], [X17], X14
    ADD  X17, X17, X19, ASR #0
    MOV  X22, X17
    ST3 { V30.S, V31.S, V0.S }[0x0], [X22], #12
    MOV  X22, X17
    LD3 { V2.S, V3.S, V4.S }[0x3], [X22], #12
    ADD  X17, X17, X19, LSR #0
    ST3 { V17.S, V18.S, V19.S }[0x0], [X17], X14
    LD3 { V17.S, V18.S, V19.S }[0x2], [X17], X14
    ADD  X17, X17, X19, ASR #0
    MOV  X22, X17
    ST3 { V2.D, V3.D, V4.D }[0x1], [X22], #24
    MOV  X22, X17
    LD3 { V2.D, V3.D, V4.D }[0x0], [X22], #24
    ADD  X17, X17, X19
    ST3 { V17.D, V18.D, V19.D }[0x0], [X17], X14
    LD3 { V30.D, V31.D, V0.D }[0x0], [X17], X14
    ADD  X17, X17, X19
    MOV  X22, X17
    ST3 { V30.B, V31.B, V0.B }[0x7], [X22], #3
    MOV  X22, X17
    LD3 { V17.B, V18.B, V19.B }[0xf], [X22], #3
    ADD  X17, X17, X19
    ST3 { V17.B, V18.B, V19.B }[0x2], [X17], X14
    LD3 { V30.B, V31.B, V0.B }[0x8], [X17], X14
    ADD  X17, X17, X19, ASR #0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X21
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X25, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X25, FPSR
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a, LSL #0
    FMOV  X25, V0.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D0
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V1.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D1
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V2.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D2
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V3.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D3
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V4.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D4
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V5.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D5
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V6.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D6
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V7.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D7
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V8.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D8
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V9.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D9
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V10.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D10
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V11.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D11
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V12.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D12
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V13.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D13
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V14.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D14
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V15.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D15
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V16.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D16
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V17.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D17
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V18.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D18
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V19.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D19
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V20.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D20
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V21.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D21
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V22.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D22
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V23.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D23
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V24.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D24
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, V25.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D25
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V26.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D26
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V27.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D27
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V28.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D28
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X25, V29.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D29
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a, LSL #0
    FMOV  X25, V30.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D30
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a, LSL #0
    FMOV  X25, V31.D[1]
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    FMOV  X25, D31
    SUB  X27, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X26
    FMOV  D3, X7
    FMOV  V3.D[1], X19
    FMOV  D4, X3
    FMOV  V4.D[1], X27
    FMOV  D5, X26
    FMOV  V5.D[1], X4
    FMOV  D6, X9
    FMOV  V6.D[1], X14
    FMOV  D7, X2
    FMOV  V7.D[1], X29
    FMOV  D8, X25
    FMOV  V8.D[1], X17
    FMOV  D9, X23
    FMOV  V9.D[1], X3
    FMOV  D10, X19
    FMOV  V10.D[1], X7
    FMOV  D11, X11
    FMOV  V11.D[1], X12
    FMOV  D12, X26
    FMOV  V12.D[1], X25
    FMOV  D13, X26
    FMOV  V13.D[1], X4
    FMOV  D14, X11
    FMOV  V14.D[1], X7
    FMOV  D15, X22
    FMOV  V15.D[1], X14
    FMOV  D16, X4
    FMOV  V16.D[1], X8
    FMOV  D17, X17
    FMOV  V17.D[1], X7
    FMOV  D18, X5
    FMOV  V18.D[1], X28
    FMOV  D19, X5
    FMOV  V19.D[1], X22
    FMOV  D20, X21
    FMOV  V20.D[1], X21
    FMOV  D21, X27
    FMOV  V21.D[1], X7
    FMOV  D22, X22
    FMOV  V22.D[1], X20
    FMOV  D23, X27
    FMOV  V23.D[1], X7
    FMOV  D24, X9
    FMOV  V24.D[1], X12
    FMOV  D25, X13
    FMOV  V25.D[1], X28
    FMOV  D26, X7
    FMOV  V26.D[1], X20
    FMOV  D27, X13
    FMOV  V27.D[1], X14
    FMOV  D28, X26
    FMOV  V28.D[1], X17
    FMOV  D29, X19
    FMOV  V29.D[1], X3
    FMOV  D30, X23
    FMOV  V30.D[1], X23
    FMOV  D31, X9
    FMOV  V31.D[1], X28
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X5, #0x500, LSL #0
    ADD  X2, X30, X5, LSR #0
    ST3 { V30.4S, V31.4S, V0.4S }, [X2]
    LD3 { V27.4S, V28.4S, V29.4S }, [X2]
    ADD  X2, X2, X14, LSR #0
    ST3 { V27.16B, V28.16B, V29.16B }, [X2]
    LD3 { V25.16B, V26.16B, V27.16B }, [X2]
    ADD  X2, X2, X14, LSR #0
    ST3 { V25.2D, V26.2D, V27.2D }, [X2]
    LD3 { V19.2D, V20.2D, V21.2D }, [X2]
    ADD  X2, X2, X14
    ST3 { V19.4S, V20.4S, V21.4S }, [X2]
    LD3 { V21.4S, V22.4S, V23.4S }, [X2]
    ADD  X2, X2, X14, ASR #0
    ST3 { V21.8H, V22.8H, V23.8H }, [X2]
    LD3 { V2.8H, V3.8H, V4.8H }, [X2]
    ADD  X2, X2, X14, ASR #0
    ST3 { V21.8B, V22.8B, V23.8B }, [X2]
    LD3 { V27.8B, V28.8B, V29.8B }, [X2]
    ADD  X2, X2, X14, ASR #0
    ST3 { V2.2S, V3.2S, V4.2S }, [X2]
    LD3 { V9.2S, V10.2S, V11.2S }, [X2]
    ADD  X2, X2, X14, ASR #0
    ST3 { V26.4H, V27.4H, V28.4H }, [X2]
    LD3 { V11.4H, V12.4H, V13.4H }, [X2]
    ADD  X2, X2, X14, ASR #0
    ST3 { V12.8B, V13.8B, V14.8B }, [X2]
    LD3 { V26.8B, V27.8B, V28.8B }, [X2]
    ADD  X2, X2, X14
    MOV  X20, X2
    ST3 { V20.2D, V21.2D, V22.2D }, [X20], #48
    MOV  X20, X2
    LD3 { V12.4S, V13.4S, V14.4S }, [X20], #48
    ADD  X2, X2, X14
    MOV  X20, X2
    ST3 { V9.16B, V10.16B, V11.16B }, [X20], #48
    MOV  X20, X2
    LD3 { V2.16B, V3.16B, V4.16B }, [X20], #48
    ADD  X2, X2, X14
    MOV  X20, X2
    ST3 { V23.2D, V24.2D, V25.2D }, [X20], #48
    MOV  X20, X2
    LD3 { V9.2D, V10.2D, V11.2D }, [X20], #48
    ADD  X2, X2, X14, LSR #0
    MOV  X20, X2
    ST3 { V2.4S, V3.4S, V4.4S }, [X20], #48
    MOV  X20, X2
    LD3 { V23.4S, V24.4S, V25.4S }, [X20], #48
    ADD  X2, X2, X14, LSR #0
    MOV  X20, X2
    ST3 { V26.8H, V27.8H, V28.8H }, [X20], #48
    MOV  X20, X2
    LD3 { V20.8H, V21.8H, V22.8H }, [X20], #48
    ADD  X2, X2, X14, LSR #0
    MOV  X20, X2
    ST3 { V23.2S, V24.2S, V25.2S }, [X20], #24
    MOV  X20, X2
    LD3 { V25.8B, V26.8B, V27.8B }, [X20], #24
    ADD  X2, X2, X14, ASR #0
    MOV  X20, X2
    ST3 { V25.2S, V26.2S, V27.2S }, [X20], #24
    MOV  X20, X2
    LD3 { V2.2S, V3.2S, V4.2S }, [X20], #24
    ADD  X2, X2, X14, ASR #0
    MOV  X20, X2
    ST3 { V9.4H, V10.4H, V11.4H }, [X20], #24
    MOV  X20, X2
    LD3 { V22.4H, V23.4H, V24.4H }, [X20], #24
    ADD  X2, X2, X14, ASR #0
    MOV  X20, X2
    ST3 { V21.8B, V22.8B, V23.8B }, [X20], #24
    MOV  X20, X2
    LD3 { V9.8B, V10.8B, V11.8B }, [X20], #24
    ADD  X2, X2, X14, ASR #0
    ST3 { V9.2D, V10.2D, V11.2D }, [X2], X16
    LD3 { V21.16B, V22.16B, V23.16B }, [X2], X16
    ADD  X2, X2, X14, ASR #0
    ST3 { V20.16B, V21.16B, V22.16B }, [X2], X16
    LD3 { V25.16B, V26.16B, V27.16B }, [X2], X16
    ADD  X2, X2, X14, ASR #0
    ST3 { V25.2D, V26.2D, V27.2D }, [X2], X16
    LD3 { V25.2D, V26.2D, V27.2D }, [X2], X16
    ADD  X2, X2, X14
    ST3 { V23.4S, V24.4S, V25.4S }, [X2], X16
    LD3 { V9.4S, V10.4S, V11.4S }, [X2], X16
    ADD  X2, X2, X14, LSR #0
    ST3 { V9.8H, V10.8H, V11.8H }, [X2], X16
    LD3 { V23.8H, V24.8H, V25.8H }, [X2], X16
    ADD  X2, X2, X14, ASR #0
    ST3 { V24.4H, V25.4H, V26.4H }, [X2], X16
    LD3 { V9.8B, V10.8B, V11.8B }, [X2], X16
    ADD  X2, X2, X14
    ST3 { V26.2S, V27.2S, V28.2S }, [X2], X16
    LD3 { V20.2S, V21.2S, V22.2S }, [X2], X16
    ADD  X2, X2, X14, LSR #0
    ST3 { V21.4H, V22.4H, V23.4H }, [X2], X16
    LD3 { V10.4H, V11.4H, V12.4H }, [X2], X16
    ADD  X2, X2, X14, LSR #0
    ST3 { V10.8B, V11.8B, V12.8B }, [X2], X16
    LD3 { V24.8B, V25.8B, V26.8B }, [X2], X16
    ADD  X2, X2, X14, LSR #0
    ST3 { V26.H, V27.H, V28.H }[0x1], [X2]
    LD3 { V21.H, V22.H, V23.H }[0x4], [X2]
    ADD  X2, X2, X14
    ST3 { V20.S, V21.S, V22.S }[0x1], [X2]
    LD3 { V20.S, V21.S, V22.S }[0x1], [X2]
    ADD  X2, X2, X14, LSR #0
    ST3 { V23.D, V24.D, V25.D }[0x1], [X2]
    LD3 { V25.D, V26.D, V27.D }[0x0], [X2]
    ADD  X2, X2, X14, ASR #0
    ST3 { V25.B, V26.B, V27.B }[0x6], [X2]
    LD3 { V27.B, V28.B, V29.B }[0x0], [X2]
    ADD  X2, X2, X14, LSR #0
    MOV  X20, X2
    ST3 { V27.H, V28.H, V29.H }[0x7], [X20], #6
    MOV  X20, X2
    LD3 { V10.H, V11.H, V12.H }[0x2], [X20], #6
    ADD  X2, X2, X14, ASR #0
    ST3 { V10.H, V11.H, V12.H }[0x2], [X2], X16
    LD3 { V30.H, V31.H, V0.H }[0x3], [X2], X16
    ADD  X2, X2, X14
    MOV  X20, X2
    ST3 { V30.S, V31.S, V0.S }[0x3], [X20], #12
    MOV  X20, X2
    LD3 { V10.S, V11.S, V12.S }[0x1], [X20], #12
    ADD  X2, X2, X14, LSR #0
    ST3 { V10.S, V11.S, V12.S }[0x0], [X2], X16
    LD3 { V30.S, V31.S, V0.S }[0x1], [X2], X16
    ADD  X2, X2, X14, ASR #0
    MOV  X20, X2
    ST3 { V30.D, V31.D, V0.D }[0x0], [X20], #24
    MOV  X20, X2
    LD3 { V28.D, V29.D, V30.D }[0x0], [X20], #24
    ADD  X2, X2, X14
    ST3 { V28.D, V29.D, V30.D }[0x0], [X2], X16
    LD3 { V28.D, V29.D, V30.D }[0x1], [X2], X16
    ADD  X2, X2, X14
    MOV  X20, X2
    ST3 { V28.B, V29.B, V30.B }[0x2], [X20], #3
    MOV  X20, X2
    LD3 { V10.B, V11.B, V12.B }[0xf], [X20], #3
    ADD  X2, X2, X14, LSR #0
    ST3 { V13.B, V14.B, V15.B }[0x2], [X2], X16
    LD3 { V30.B, V31.B, V0.B }[0xb], [X2], X16
    ADD  X2, X2, X14, LSR #0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X21, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X21, FPSR
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V0.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D0
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V1.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D1
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V2.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D2
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V3.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D3
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V4.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D4
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V5.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D5
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V6.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D6
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V7.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D7
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V8.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D8
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V9.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D9
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xa500, LSL #48
    FMOV  X21, V10.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D10
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xa500, LSL #48
    FMOV  X21, V11.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D11
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xa500, LSL #48
    FMOV  X21, V12.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D12
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V13.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D13
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V14.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D14
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V15.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D15
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V16.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D16
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V17.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D17
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V18.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D18
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V19.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D19
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V20.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D20
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    FMOV  X21, V21.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D21
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    FMOV  X21, V22.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D22
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    FMOV  X21, V23.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D23
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V24.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D24
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V25.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    FMOV  X21, D25
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V26.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D26
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, V27.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X21, D27
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V28.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D28
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V29.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D29
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V30.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D30
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, V31.D[1]
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X21, D31
    SUB  X22, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X10
    FMOV  V3.D[1], X16
    FMOV  D4, X5
    FMOV  V4.D[1], X27
    FMOV  D5, X9
    FMOV  V5.D[1], X22
    FMOV  D6, X3
    FMOV  V6.D[1], X23
    FMOV  D7, X5
    FMOV  V7.D[1], X7
    FMOV  D8, X12
    FMOV  V8.D[1], X12
    FMOV  D9, X11
    FMOV  V9.D[1], X12
    FMOV  D10, X22
    FMOV  V10.D[1], X27
    FMOV  D11, X19
    FMOV  V11.D[1], X3
    FMOV  D12, X27
    FMOV  V12.D[1], X22
    FMOV  D13, X5
    FMOV  V13.D[1], X28
    FMOV  D14, X10
    FMOV  V14.D[1], X14
    FMOV  D15, X7
    FMOV  V15.D[1], X23
    FMOV  D16, X11
    FMOV  V16.D[1], X19
    FMOV  D17, X20
    FMOV  V17.D[1], X16
    FMOV  D18, X29
    FMOV  V18.D[1], X20
    FMOV  D19, X10
    FMOV  V19.D[1], X5
    FMOV  D20, X7
    FMOV  V20.D[1], X12
    FMOV  D21, X13
    FMOV  V21.D[1], X3
    FMOV  D22, X20
    FMOV  V22.D[1], X2
    FMOV  D23, X29
    FMOV  V23.D[1], X13
    FMOV  D24, X29
    FMOV  V24.D[1], X27
    FMOV  D25, X29
    FMOV  V25.D[1], X26
    FMOV  D26, X10
    FMOV  V26.D[1], X22
    FMOV  D27, X7
    FMOV  V27.D[1], X8
    FMOV  D28, X13
    FMOV  V28.D[1], X4
    FMOV  D29, X10
    FMOV  V29.D[1], X3
    FMOV  D30, X28
    FMOV  V30.D[1], X27
    FMOV  D31, X14
    FMOV  V31.D[1], X10
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X28, #0xa00, LSL #0
    ADD  X11, X30, X28
    ST3 { V2.16B, V3.16B, V4.16B }, [X11]
    LD3 { V23.4S, V24.4S, V25.4S }, [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V30.16B, V31.16B, V0.16B }, [X11]
    LD3 { V28.16B, V29.16B, V30.16B }, [X11]
    ADD  X11, X11, X21, LSR #0
    ST3 { V24.2D, V25.2D, V26.2D }, [X11]
    LD3 { V7.2D, V8.2D, V9.2D }, [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V7.4S, V8.4S, V9.4S }, [X11]
    LD3 { V11.4S, V12.4S, V13.4S }, [X11]
    ADD  X11, X11, X21
    ST3 { V11.8H, V12.8H, V13.8H }, [X11]
    LD3 { V19.8H, V20.8H, V21.8H }, [X11]
    ADD  X11, X11, X21, LSR #0
    ST3 { V29.4H, V30.4H, V31.4H }, [X11]
    LD3 { V29.4H, V30.4H, V31.4H }, [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V4.2S, V5.2S, V6.2S }, [X11]
    LD3 { V11.2S, V12.2S, V13.2S }, [X11]
    ADD  X11, X11, X21, LSR #0
    ST3 { V17.4H, V18.4H, V19.4H }, [X11]
    LD3 { V4.4H, V5.4H, V6.4H }, [X11]
    ADD  X11, X11, X21, LSR #0
    ST3 { V25.8B, V26.8B, V27.8B }, [X11]
    LD3 { V7.8B, V8.8B, V9.8B }, [X11]
    ADD  X11, X11, X21, LSR #0
    MOV  X3, X11
    ST3 { V6.2D, V7.2D, V8.2D }, [X3], #48
    MOV  X3, X11
    LD3 { V10.16B, V11.16B, V12.16B }, [X3], #48
    ADD  X11, X11, X21
    MOV  X3, X11
    ST3 { V9.16B, V10.16B, V11.16B }, [X3], #48
    MOV  X3, X11
    LD3 { V9.16B, V10.16B, V11.16B }, [X3], #48
    ADD  X11, X11, X21, LSR #0
    MOV  X3, X11
    ST3 { V9.2D, V10.2D, V11.2D }, [X3], #48
    MOV  X3, X11
    LD3 { V6.2D, V7.2D, V8.2D }, [X3], #48
    ADD  X11, X11, X21
    MOV  X3, X11
    ST3 { V6.4S, V7.4S, V8.4S }, [X3], #48
    MOV  X3, X11
    LD3 { V9.4S, V10.4S, V11.4S }, [X3], #48
    ADD  X11, X11, X21
    MOV  X3, X11
    ST3 { V30.8H, V31.8H, V0.8H }, [X3], #48
    MOV  X3, X11
    LD3 { V6.8H, V7.8H, V8.8H }, [X3], #48
    ADD  X11, X11, X21, LSR #0
    MOV  X3, X11
    ST3 { V8.2S, V9.2S, V10.2S }, [X3], #24
    MOV  X3, X11
    LD3 { V30.4H, V31.4H, V0.4H }, [X3], #24
    ADD  X11, X11, X21, LSR #0
    MOV  X3, X11
    ST3 { V2.2S, V3.2S, V4.2S }, [X3], #24
    MOV  X3, X11
    LD3 { V2.2S, V3.2S, V4.2S }, [X3], #24
    ADD  X11, X11, X21
    MOV  X3, X11
    ST3 { V2.4H, V3.4H, V4.4H }, [X3], #24
    MOV  X3, X11
    LD3 { V8.4H, V9.4H, V10.4H }, [X3], #24
    ADD  X11, X11, X21, LSR #0
    MOV  X3, X11
    ST3 { V8.8B, V9.8B, V10.8B }, [X3], #24
    MOV  X3, X11
    LD3 { V8.8B, V9.8B, V10.8B }, [X3], #24
    ADD  X11, X11, X21, ASR #0
    ST3 { V30.2D, V31.2D, V0.2D }, [X11], X25
    LD3 { V2.4S, V3.4S, V4.4S }, [X11], X25
    ADD  X11, X11, X21
    ST3 { V2.16B, V3.16B, V4.16B }, [X11], X25
    LD3 { V2.16B, V3.16B, V4.16B }, [X11], X25
    ADD  X11, X11, X21
    ST3 { V2.2D, V3.2D, V4.2D }, [X11], X25
    LD3 { V30.2D, V31.2D, V0.2D }, [X11], X25
    ADD  X11, X11, X21, ASR #0
    ST3 { V30.4S, V31.4S, V0.4S }, [X11], X25
    LD3 { V2.4S, V3.4S, V4.4S }, [X11], X25
    ADD  X11, X11, X21
    ST3 { V2.8H, V3.8H, V4.8H }, [X11], X25
    LD3 { V30.8H, V31.8H, V0.8H }, [X11], X25
    ADD  X11, X11, X21
    ST3 { V30.2S, V31.2S, V0.2S }, [X11], X25
    LD3 { V30.4H, V31.4H, V0.4H }, [X11], X25
    ADD  X11, X11, X21, ASR #0
    ST3 { V8.2S, V9.2S, V10.2S }, [X11], X25
    LD3 { V2.2S, V3.2S, V4.2S }, [X11], X25
    ADD  X11, X11, X21, ASR #0
    ST3 { V2.4H, V3.4H, V4.4H }, [X11], X25
    LD3 { V2.4H, V3.4H, V4.4H }, [X11], X25
    ADD  X11, X11, X21, ASR #0
    ST3 { V2.8B, V3.8B, V4.8B }, [X11], X25
    LD3 { V2.8B, V3.8B, V4.8B }, [X11], X25
    ADD  X11, X11, X21
    ST3 { V30.H, V31.H, V0.H }[0x5], [X11]
    LD3 { V30.H, V31.H, V0.H }[0x3], [X11]
    ADD  X11, X11, X21, LSR #0
    ST3 { V2.S, V3.S, V4.S }[0x3], [X11]
    LD3 { V2.S, V3.S, V4.S }[0x3], [X11]
    ADD  X11, X11, X21
    ST3 { V30.D, V31.D, V0.D }[0x0], [X11]
    LD3 { V30.D, V31.D, V0.D }[0x0], [X11]
    ADD  X11, X11, X21
    ST3 { V30.B, V31.B, V0.B }[0x8], [X11]
    LD3 { V8.B, V9.B, V10.B }[0xc], [X11]
    ADD  X11, X11, X21
    MOV  X3, X11
    ST3 { V8.H, V9.H, V10.H }[0x1], [X3], #6
    MOV  X3, X11
    LD3 { V8.H, V9.H, V10.H }[0x1], [X3], #6
    ADD  X11, X11, X21
    ST3 { V8.H, V9.H, V10.H }[0x1], [X11], X25
    LD3 { V30.H, V31.H, V0.H }[0x2], [X11], X25
    ADD  X11, X11, X21, LSR #0
    MOV  X3, X11
    ST3 { V30.S, V31.S, V0.S }[0x0], [X3], #12
    MOV  X3, X11
    LD3 { V8.S, V9.S, V10.S }[0x2], [X3], #12
    ADD  X11, X11, X21, LSR #0
    ST3 { V8.S, V9.S, V10.S }[0x0], [X11], X25
    LD3 { V8.S, V9.S, V10.S }[0x2], [X11], X25
    ADD  X11, X11, X21, LSR #0
    MOV  X3, X11
    ST3 { V8.D, V9.D, V10.D }[0x1], [X3], #24
    MOV  X3, X11
    LD3 { V8.D, V9.D, V10.D }[0x1], [X3], #24
    ADD  X11, X11, X21
    ST3 { V8.D, V9.D, V10.D }[0x1], [X11], X25
    LD3 { V30.D, V31.D, V0.D }[0x0], [X11], X25
    ADD  X11, X11, X21, LSR #0
    MOV  X3, X11
    ST3 { V30.B, V31.B, V0.B }[0xe], [X3], #3
    MOV  X3, X11
    LD3 { V30.B, V31.B, V0.B }[0x5], [X3], #3
    ADD  X11, X11, X21, LSR #0
    ST3 { V24.B, V25.B, V26.B }[0x2], [X11], X25
    LD3 { V8.B, V9.B, V10.B }[0x8], [X11], X25
    ADD  X11, X11, X21, ASR #0
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X29, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X29, FPSR
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    FMOV  X29, D0
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V1.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D1
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D2
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D3
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D4
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D5
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D6
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V7.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D7
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    FMOV  X29, V8.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D8
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    FMOV  X29, V9.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D9
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    FMOV  X29, V10.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D10
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V11.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D11
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D12
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D13
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V14.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D14
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V15.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D15
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V16.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D16
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V17.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D17
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V18.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D18
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V19.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D19
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V20.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D20
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V21.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D21
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V22.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D22
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V23.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D23
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V24.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D24
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V25.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D25
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V26.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D26
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V27.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D27
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, V28.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D28
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X29, D29
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    FMOV  X29, D30
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    FMOV  X29, D31
    SUB  X20, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X23
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X20
    FMOV  D3, X27
    FMOV  V3.D[1], X2
    FMOV  D4, X3
    FMOV  V4.D[1], X22
    FMOV  D5, X3
    FMOV  V5.D[1], X12
    FMOV  D6, X26
    FMOV  V6.D[1], X16
    FMOV  D7, X23
    FMOV  V7.D[1], X22
    FMOV  D8, X13
    FMOV  V8.D[1], X23
    FMOV  D9, X20
    FMOV  V9.D[1], X25
    FMOV  D10, X9
    FMOV  V10.D[1], X2
    FMOV  D11, X25
    FMOV  V11.D[1], X25
    FMOV  D12, X22
    FMOV  V12.D[1], X23
    FMOV  D13, X21
    FMOV  V13.D[1], X27
    FMOV  D14, X8
    FMOV  V14.D[1], X21
    FMOV  D15, X14
    FMOV  V15.D[1], X21
    FMOV  D16, X8
    FMOV  V16.D[1], X4
    FMOV  D17, X19
    FMOV  V17.D[1], X29
    FMOV  D18, X25
    FMOV  V18.D[1], X13
    FMOV  D19, X25
    FMOV  V19.D[1], X22
    FMOV  D20, X3
    FMOV  V20.D[1], X28
    FMOV  D21, X13
    FMOV  V21.D[1], X22
    FMOV  D22, X25
    FMOV  V22.D[1], X16
    FMOV  D23, X3
    FMOV  V23.D[1], X7
    FMOV  D24, X23
    FMOV  V24.D[1], X23
    FMOV  D25, X5
    FMOV  V25.D[1], X5
    FMOV  D26, X29
    FMOV  V26.D[1], X4
    FMOV  D27, X7
    FMOV  V27.D[1], X17
    FMOV  D28, X13
    FMOV  V28.D[1], X26
    FMOV  D29, X12
    FMOV  V29.D[1], X22
    FMOV  D30, X9
    FMOV  V30.D[1], X13
    FMOV  D31, X8
    FMOV  V31.D[1], X29
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X26, #0xf00, LSL #0
    ADD  X9, X30, X26
    ST3 { V2.8H, V3.8H, V4.8H }, [X9]
    LD3 { V23.16B, V24.16B, V25.16B }, [X9]
    ADD  X9, X9, X14
    ST3 { V7.16B, V8.16B, V9.16B }, [X9]
    LD3 { V0.16B, V1.16B, V2.16B }, [X9]
    ADD  X9, X9, X14, ASR #0
    ST3 { V23.2D, V24.2D, V25.2D }, [X9]
    LD3 { V1.2D, V2.2D, V3.2D }, [X9]
    ADD  X9, X9, X14
    ST3 { V1.4S, V2.4S, V3.4S }, [X9]
    LD3 { V2.4S, V3.4S, V4.4S }, [X9]
    ADD  X9, X9, X14, LSR #0
    ST3 { V2.8H, V3.8H, V4.8H }, [X9]
    LD3 { V18.8H, V19.8H, V20.8H }, [X9]
    ADD  X9, X9, X14, ASR #0
    ST3 { V13.8B, V14.8B, V15.8B }, [X9]
    LD3 { V27.8B, V28.8B, V29.8B }, [X9]
    ADD  X9, X9, X14, LSR #0
    ST3 { V18.2S, V19.2S, V20.2S }, [X9]
    LD3 { V2.2S, V3.2S, V4.2S }, [X9]
    ADD  X9, X9, X14, ASR #0
    ST3 { V11.4H, V12.4H, V13.4H }, [X9]
    LD3 { V23.4H, V24.4H, V25.4H }, [X9]
    ADD  X9, X9, X14, ASR #0
    ST3 { V19.8B, V20.8B, V21.8B }, [X9]
    LD3 { V11.8B, V12.8B, V13.8B }, [X9]
    ADD  X9, X9, X14, LSR #0
    MOV  X5, X9
    ST3 { V2.16B, V3.16B, V4.16B }, [X5], #48
    MOV  X5, X9
    LD3 { V2.2D, V3.2D, V4.2D }, [X5], #48
    ADD  X9, X9, X14
    MOV  X5, X9
    ST3 { V27.16B, V28.16B, V29.16B }, [X5], #48
    MOV  X5, X9
    LD3 { V4.16B, V5.16B, V6.16B }, [X5], #48
    ADD  X9, X9, X14, LSR #0
    MOV  X5, X9
    ST3 { V4.2D, V5.2D, V6.2D }, [X5], #48
    MOV  X5, X9
    LD3 { V19.2D, V20.2D, V21.2D }, [X5], #48
    ADD  X9, X9, X14
    MOV  X5, X9
    ST3 { V19.4S, V20.4S, V21.4S }, [X5], #48
    MOV  X5, X9
    LD3 { V19.4S, V20.4S, V21.4S }, [X5], #48
    ADD  X9, X9, X14
    MOV  X5, X9
    ST3 { V19.8H, V20.8H, V21.8H }, [X5], #48
    MOV  X5, X9
    LD3 { V19.8H, V20.8H, V21.8H }, [X5], #48
    ADD  X9, X9, X14
    MOV  X5, X9
    ST3 { V19.4H, V20.4H, V21.4H }, [X5], #24
    MOV  X5, X9
    LD3 { V27.8B, V28.8B, V29.8B }, [X5], #24
    ADD  X9, X9, X14, ASR #0
    MOV  X5, X9
    ST3 { V11.2S, V12.2S, V13.2S }, [X5], #24
    MOV  X5, X9
    LD3 { V11.2S, V12.2S, V13.2S }, [X5], #24
    ADD  X9, X9, X14
    MOV  X5, X9
    ST3 { V27.4H, V28.4H, V29.4H }, [X5], #24
    MOV  X5, X9
    LD3 { V27.4H, V28.4H, V29.4H }, [X5], #24
    ADD  X9, X9, X14
    MOV  X5, X9
    ST3 { V11.8B, V12.8B, V13.8B }, [X5], #24
    MOV  X5, X9
    LD3 { V19.8B, V20.8B, V21.8B }, [X5], #24
    ADD  X9, X9, X14
    ST3 { V19.8H, V20.8H, V21.8H }, [X9], X10
    LD3 { V11.2D, V12.2D, V13.2D }, [X9], X10
    ADD  X9, X9, X14, ASR #0
    ST3 { V27.16B, V28.16B, V29.16B }, [X9], X10
    LD3 { V27.16B, V28.16B, V29.16B }, [X9], X10
    ADD  X9, X9, X14, LSR #0
    ST3 { V27.2D, V28.2D, V29.2D }, [X9], X10
    LD3 { V19.2D, V20.2D, V21.2D }, [X9], X10
    ADD  X9, X9, X14, LSR #0
    ST3 { V11.4S, V12.4S, V13.4S }, [X9], X10
    LD3 { V11.4S, V12.4S, V13.4S }, [X9], X10
    ADD  X9, X9, X14, ASR #0
    ST3 { V19.8H, V20.8H, V21.8H }, [X9], X10
    LD3 { V19.8H, V20.8H, V21.8H }, [X9], X10
    ADD  X9, X9, X14
    ST3 { V19.2S, V20.2S, V21.2S }, [X9], X10
    LD3 { V27.4H, V28.4H, V29.4H }, [X9], X10
    ADD  X9, X9, X14
    ST3 { V27.2S, V28.2S, V29.2S }, [X9], X10
    LD3 { V12.2S, V13.2S, V14.2S }, [X9], X10
    ADD  X9, X9, X14, LSR #0
    ST3 { V11.4H, V12.4H, V13.4H }, [X9], X10
    LD3 { V11.4H, V12.4H, V13.4H }, [X9], X10
    ADD  X9, X9, X14, ASR #0
    ST3 { V29.8B, V30.8B, V31.8B }, [X9], X10
    LD3 { V29.8B, V30.8B, V31.8B }, [X9], X10
    ADD  X9, X9, X14
    ST3 { V4.H, V5.H, V6.H }[0x7], [X9]
    LD3 { V19.H, V20.H, V21.H }[0x6], [X9]
    ADD  X9, X9, X14
    ST3 { V11.S, V12.S, V13.S }[0x0], [X9]
    LD3 { V6.S, V7.S, V8.S }[0x3], [X9]
    ADD  X9, X9, X14, ASR #0
    ST3 { V6.D, V7.D, V8.D }[0x1], [X9]
    LD3 { V11.D, V12.D, V13.D }[0x1], [X9]
    ADD  X9, X9, X14, LSR #0
    ST3 { V18.B, V19.B, V20.B }[0x7], [X9]
    LD3 { V6.B, V7.B, V8.B }[0x8], [X9]
    ADD  X9, X9, X14, LSR #0
    MOV  X5, X9
    ST3 { V25.H, V26.H, V27.H }[0x6], [X5], #6
    MOV  X5, X9
    LD3 { V25.H, V26.H, V27.H }[0x0], [X5], #6
    ADD  X9, X9, X14
    ST3 { V25.H, V26.H, V27.H }[0x1], [X9], X10
    LD3 { V8.H, V9.H, V10.H }[0x6], [X9], X10
    ADD  X9, X9, X14, LSR #0
    MOV  X5, X9
    ST3 { V8.S, V9.S, V10.S }[0x0], [X5], #12
    MOV  X5, X9
    LD3 { V18.S, V19.S, V20.S }[0x1], [X5], #12
    ADD  X9, X9, X14
    ST3 { V27.S, V28.S, V29.S }[0x2], [X9], X10
    LD3 { V8.S, V9.S, V10.S }[0x3], [X9], X10
    ADD  X9, X9, X14, LSR #0
    MOV  X5, X9
    ST3 { V18.D, V19.D, V20.D }[0x1], [X5], #24
    MOV  X5, X9
    LD3 { V27.D, V28.D, V29.D }[0x0], [X5], #24
    ADD  X9, X9, X14, ASR #0
    ST3 { V8.D, V9.D, V10.D }[0x1], [X9], X10
    LD3 { V28.D, V29.D, V30.D }[0x0], [X9], X10
    ADD  X9, X9, X14, ASR #0
    MOV  X5, X9
    ST3 { V28.B, V29.B, V30.B }[0xc], [X5], #3
    MOV  X5, X9
    LD3 { V8.B, V9.B, V10.B }[0xe], [X5], #3
    ADD  X9, X9, X14, ASR #0
    ST3 { V23.B, V24.B, V25.B }[0x0], [X9], X10
    LD3 { V23.B, V24.B, V25.B }[0xe], [X9], X10
    ADD  X9, X9, X14
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X8, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V0.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D0
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V1.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D1
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D2
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D3
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D4
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D5
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V6.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D6
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V7.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D7
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    FMOV  X8, V8.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D8
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    FMOV  X8, V9.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D9
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    FMOV  X8, V10.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D10
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D11
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V12.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D12
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V13.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D13
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D14
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D15
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V16.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D16
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V17.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D17
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V18.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D18
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D19
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D20
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D21
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V22.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D22
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5, LSL #48
    FMOV  X8, V23.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D23
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5, LSL #48
    FMOV  X8, V24.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D24
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D25
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, V26.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D26
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D27
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    FMOV  X8, D28
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    FMOV  X8, D29
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    FMOV  X8, D30
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X8, D31
    SUB  X21, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X22
    FMOV  D4, X22
    FMOV  V4.D[1], X28
    FMOV  D5, X7
    FMOV  V5.D[1], X22
    FMOV  D6, X19
    FMOV  V6.D[1], X5
    FMOV  D7, X9
    FMOV  V7.D[1], X20
    FMOV  D8, X4
    FMOV  V8.D[1], X28
    FMOV  D9, X5
    FMOV  V9.D[1], X21
    FMOV  D10, X2
    FMOV  V10.D[1], X22
    FMOV  D11, X29
    FMOV  V11.D[1], X17
    FMOV  D12, X27
    FMOV  V12.D[1], X13
    FMOV  D13, X4
    FMOV  V13.D[1], X22
    FMOV  D14, X2
    FMOV  V14.D[1], X2
    FMOV  D15, X21
    FMOV  V15.D[1], X23
    FMOV  D16, X2
    FMOV  V16.D[1], X29
    FMOV  D17, X19
    FMOV  V17.D[1], X9
    FMOV  D18, X27
    FMOV  V18.D[1], X27
    FMOV  D19, X13
    FMOV  V19.D[1], X9
    FMOV  D20, X9
    FMOV  V20.D[1], X22
    FMOV  D21, X2
    FMOV  V21.D[1], X3
    FMOV  D22, X10
    FMOV  V22.D[1], X2
    FMOV  D23, X21
    FMOV  V23.D[1], X13
    FMOV  D24, X13
    FMOV  V24.D[1], X12
    FMOV  D25, X7
    FMOV  V25.D[1], X9
    FMOV  D26, X9
    FMOV  V26.D[1], X20
    FMOV  D27, X9
    FMOV  V27.D[1], X12
    FMOV  D28, X20
    FMOV  V28.D[1], X22
    FMOV  D29, X19
    FMOV  V29.D[1], X9
    FMOV  D30, X13
    FMOV  V30.D[1], X28
    FMOV  D31, X14
    FMOV  V31.D[1], X19
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X22, #0x1400, LSL #0
    ADD  X4, X30, X22, LSR #0
    ST3 { V22.16B, V23.16B, V24.16B }, [X4]
    LD3 { V1.16B, V2.16B, V3.16B }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST3 { V25.16B, V26.16B, V27.16B }, [X4]
    LD3 { V20.16B, V21.16B, V22.16B }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST3 { V1.2D, V2.2D, V3.2D }, [X4]
    LD3 { V9.2D, V10.2D, V11.2D }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST3 { V20.4S, V21.4S, V22.4S }, [X4]
    LD3 { V8.4S, V9.4S, V10.4S }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST3 { V9.8H, V10.8H, V11.8H }, [X4]
    LD3 { V3.8H, V4.8H, V5.8H }, [X4]
    ADD  X4, X4, X16, ASR #0
    ST3 { V20.2S, V21.2S, V22.2S }, [X4]
    LD3 { V26.2S, V27.2S, V28.2S }, [X4]
    ADD  X4, X4, X16, LSR #0
    ST3 { V26.2S, V27.2S, V28.2S }, [X4]
    LD3 { V13.2S, V14.2S, V15.2S }, [X4]
    ADD  X4, X4, X16
    ST3 { V13.4H, V14.4H, V15.4H }, [X4]
    LD3 { V9.4H, V10.4H, V11.4H }, [X4]
    ADD  X4, X4, X16
    ST3 { V3.8B, V4.8B, V5.8B }, [X4]
    LD3 { V4.8B, V5.8B, V6.8B }, [X4]
    ADD  X4, X4, X16, LSR #0
    MOV  X26, X4
    ST3 { V31.2D, V0.2D, V1.2D }, [X26], #48
    MOV  X26, X4
    LD3 { V20.4S, V21.4S, V22.4S }, [X26], #48
    ADD  X4, X4, X16, ASR #0
    MOV  X26, X4
    ST3 { V9.16B, V10.16B, V11.16B }, [X26], #48
    MOV  X26, X4
    LD3 { V21.16B, V22.16B, V23.16B }, [X26], #48
    ADD  X4, X4, X16, ASR #0
    MOV  X26, X4
    ST3 { V20.2D, V21.2D, V22.2D }, [X26], #48
    MOV  X26, X4
    LD3 { V31.2D, V0.2D, V1.2D }, [X26], #48
    ADD  X4, X4, X16, ASR #0
    MOV  X26, X4
    ST3 { V31.4S, V0.4S, V1.4S }, [X26], #48
    MOV  X26, X4
    LD3 { V18.4S, V19.4S, V20.4S }, [X26], #48
    ADD  X4, X4, X16, LSR #0
    MOV  X26, X4
    ST3 { V18.8H, V19.8H, V20.8H }, [X26], #48
    MOV  X26, X4
    LD3 { V9.8H, V10.8H, V11.8H }, [X26], #48
    ADD  X4, X4, X16, ASR #0
    MOV  X26, X4
    ST3 { V9.4H, V10.4H, V11.4H }, [X26], #24
    MOV  X26, X4
    LD3 { V9.2S, V10.2S, V11.2S }, [X26], #24
    ADD  X4, X4, X16, ASR #0
    MOV  X26, X4
    ST3 { V9.2S, V10.2S, V11.2S }, [X26], #24
    MOV  X26, X4
    LD3 { V18.2S, V19.2S, V20.2S }, [X26], #24
    ADD  X4, X4, X16
    MOV  X26, X4
    ST3 { V27.4H, V28.4H, V29.4H }, [X26], #24
    MOV  X26, X4
    LD3 { V4.4H, V5.4H, V6.4H }, [X26], #24
    ADD  X4, X4, X16, LSR #0
    MOV  X26, X4
    ST3 { V31.8B, V0.8B, V1.8B }, [X26], #24
    MOV  X26, X4
    LD3 { V19.8B, V20.8B, V21.8B }, [X26], #24
    ADD  X4, X4, X16, LSR #0
    ST3 { V13.2D, V14.2D, V15.2D }, [X4], X28
    LD3 { V13.8H, V14.8H, V15.8H }, [X4], X28
    ADD  X4, X4, X16, LSR #0
    ST3 { V4.16B, V5.16B, V6.16B }, [X4], X28
    LD3 { V31.16B, V0.16B, V1.16B }, [X4], X28
    ADD  X4, X4, X16, ASR #0
    ST3 { V18.2D, V19.2D, V20.2D }, [X4], X28
    LD3 { V4.2D, V5.2D, V6.2D }, [X4], X28
    ADD  X4, X4, X16
    ST3 { V31.4S, V0.4S, V1.4S }, [X4], X28
    LD3 { V9.4S, V10.4S, V11.4S }, [X4], X28
    ADD  X4, X4, X16
    ST3 { V28.8H, V29.8H, V30.8H }, [X4], X28
    LD3 { V28.8H, V29.8H, V30.8H }, [X4], X28
    ADD  X4, X4, X16, LSR #0
    ST3 { V9.8B, V10.8B, V11.8B }, [X4], X28
    LD3 { V11.4H, V12.4H, V13.4H }, [X4], X28
    ADD  X4, X4, X16, LSR #0
    ST3 { V4.2S, V5.2S, V6.2S }, [X4], X28
    LD3 { V18.2S, V19.2S, V20.2S }, [X4], X28
    ADD  X4, X4, X16
    ST3 { V7.4H, V8.4H, V9.4H }, [X4], X28
    LD3 { V4.4H, V5.4H, V6.4H }, [X4], X28
    ADD  X4, X4, X16, ASR #0
    ST3 { V28.8B, V29.8B, V30.8B }, [X4], X28
    LD3 { V7.8B, V8.8B, V9.8B }, [X4], X28
    ADD  X4, X4, X16, ASR #0
    ST3 { V11.H, V12.H, V13.H }[0x7], [X4]
    LD3 { V31.H, V0.H, V1.H }[0x2], [X4]
    ADD  X4, X4, X16, ASR #0
    ST3 { V6.S, V7.S, V8.S }[0x0], [X4]
    LD3 { V6.S, V7.S, V8.S }[0x2], [X4]
    ADD  X4, X4, X16, ASR #0
    ST3 { V18.D, V19.D, V20.D }[0x0], [X4]
    LD3 { V10.D, V11.D, V12.D }[0x1], [X4]
    ADD  X4, X4, X16, ASR #0
    ST3 { V10.B, V11.B, V12.B }[0x6], [X4]
    LD3 { V10.B, V11.B, V12.B }[0xf], [X4]
    ADD  X4, X4, X16, ASR #0
    MOV  X26, X4
    ST3 { V6.H, V7.H, V8.H }[0x0], [X26], #6
    MOV  X26, X4
    LD3 { V6.H, V7.H, V8.H }[0x6], [X26], #6
    ADD  X4, X4, X16
    ST3 { V10.H, V11.H, V12.H }[0x4], [X4], X28
    LD3 { V11.H, V12.H, V13.H }[0x7], [X4], X28
    ADD  X4, X4, X16, ASR #0
    MOV  X26, X4
    ST3 { V6.S, V7.S, V8.S }[0x0], [X26], #12
    MOV  X26, X4
    LD3 { V6.S, V7.S, V8.S }[0x3], [X26], #12
    ADD  X4, X4, X16, LSR #0
    ST3 { V6.S, V7.S, V8.S }[0x2], [X4], X28
    LD3 { V6.S, V7.S, V8.S }[0x0], [X4], X28
    ADD  X4, X4, X16
    MOV  X26, X4
    ST3 { V31.D, V0.D, V1.D }[0x1], [X26], #24
    MOV  X26, X4
    LD3 { V31.D, V0.D, V1.D }[0x1], [X26], #24
    ADD  X4, X4, X16
    ST3 { V31.D, V0.D, V1.D }[0x1], [X4], X28
    LD3 { V31.D, V0.D, V1.D }[0x1], [X4], X28
    ADD  X4, X4, X16
    MOV  X26, X4
    ST3 { V31.B, V0.B, V1.B }[0x2], [X26], #3
    MOV  X26, X4
    LD3 { V31.B, V0.B, V1.B }[0xa], [X26], #3
    ADD  X4, X4, X16, LSR #0
    ST3 { V31.B, V0.B, V1.B }[0xc], [X4], X28
    LD3 { V2.B, V3.B, V4.B }[0x1], [X4], X28
    ADD  X4, X4, X16, LSR #0
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X13, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a, LSL #16
    FMOV  X13, V0.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D0
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a, LSL #16
    FMOV  X13, V1.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D1
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V2.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D2
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V3.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D3
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V4.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D4
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D5
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V6.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D6
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V7.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D7
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V8.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D8
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V9.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D9
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V10.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D10
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V11.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D11
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V12.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D12
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V13.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D13
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V14.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D14
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D15
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V16.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D16
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V17.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D17
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V18.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D18
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D19
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D20
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V21.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D21
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V22.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D22
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V23.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D23
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V24.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D24
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V25.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D25
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D26
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D27
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X13, V28.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D28
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V29.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D29
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, V30.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D30
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0x5a, LSL #16
    FMOV  X13, V31.D[1]
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #48
    FMOV  X13, D31
    SUB  X14, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X13
    FMOV  D3, X14
    FMOV  V3.D[1], X22
    FMOV  D4, X14
    FMOV  V4.D[1], X7
    FMOV  D5, X20
    FMOV  V5.D[1], X13
    FMOV  D6, X25
    FMOV  V6.D[1], X4
    FMOV  D7, X16
    FMOV  V7.D[1], X14
    FMOV  D8, X22
    FMOV  V8.D[1], X19
    FMOV  D9, X7
    FMOV  V9.D[1], X7
    FMOV  D10, X12
    FMOV  V10.D[1], X26
    FMOV  D11, X10
    FMOV  V11.D[1], X19
    FMOV  D12, X22
    FMOV  V12.D[1], X20
    FMOV  D13, X17
    FMOV  V13.D[1], X7
    FMOV  D14, X23
    FMOV  V14.D[1], X17
    FMOV  D15, X16
    FMOV  V15.D[1], X29
    FMOV  D16, X4
    FMOV  V16.D[1], X26
    FMOV  D17, X4
    FMOV  V17.D[1], X12
    FMOV  D18, X11
    FMOV  V18.D[1], X25
    FMOV  D19, X11
    FMOV  V19.D[1], X21
    FMOV  D20, X20
    FMOV  V20.D[1], X16
    FMOV  D21, X21
    FMOV  V21.D[1], X20
    FMOV  D22, X12
    FMOV  V22.D[1], X29
    FMOV  D23, X17
    FMOV  V23.D[1], X22
    FMOV  D24, X12
    FMOV  V24.D[1], X2
    FMOV  D25, X22
    FMOV  V25.D[1], X26
    FMOV  D26, X26
    FMOV  V26.D[1], X28
    FMOV  D27, X21
    FMOV  V27.D[1], X10
    FMOV  D28, X23
    FMOV  V28.D[1], X21
    FMOV  D29, X27
    FMOV  V29.D[1], X14
    FMOV  D30, X7
    FMOV  V30.D[1], X23
    FMOV  D31, X23
    FMOV  V31.D[1], X8
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X11, #0x1900, LSL #0
    ADD  X23, X30, X11
    ST3 { V27.4S, V28.4S, V29.4S }, [X23]
    LD3 { V21.2D, V22.2D, V23.2D }, [X23]
    ADD  X23, X23, X21
    ST3 { V21.16B, V22.16B, V23.16B }, [X23]
    LD3 { V22.16B, V23.16B, V24.16B }, [X23]
    ADD  X23, X23, X21
    ST3 { V22.2D, V23.2D, V24.2D }, [X23]
    LD3 { V13.2D, V14.2D, V15.2D }, [X23]
    ADD  X23, X23, X21
    ST3 { V5.4S, V6.4S, V7.4S }, [X23]
    LD3 { V12.4S, V13.4S, V14.4S }, [X23]
    ADD  X23, X23, X21
    ST3 { V5.8H, V6.8H, V7.8H }, [X23]
    LD3 { V17.8H, V18.8H, V19.8H }, [X23]
    ADD  X23, X23, X21, LSR #0
    ST3 { V15.8B, V16.8B, V17.8B }, [X23]
    LD3 { V17.8B, V18.8B, V19.8B }, [X23]
    ADD  X23, X23, X21, ASR #0
    ST3 { V13.2S, V14.2S, V15.2S }, [X23]
    LD3 { V3.2S, V4.2S, V5.2S }, [X23]
    ADD  X23, X23, X21
    ST3 { V3.4H, V4.4H, V5.4H }, [X23]
    LD3 { V13.4H, V14.4H, V15.4H }, [X23]
    ADD  X23, X23, X21, LSR #0
    ST3 { V4.8B, V5.8B, V6.8B }, [X23]
    LD3 { V22.8B, V23.8B, V24.8B }, [X23]
    ADD  X23, X23, X21
    MOV  X7, X23
    ST3 { V22.8H, V23.8H, V24.8H }, [X7], #48
    MOV  X7, X23
    LD3 { V3.2D, V4.2D, V5.2D }, [X7], #48
    ADD  X23, X23, X21, ASR #0
    MOV  X7, X23
    ST3 { V17.16B, V18.16B, V19.16B }, [X7], #48
    MOV  X7, X23
    LD3 { V22.16B, V23.16B, V24.16B }, [X7], #48
    ADD  X23, X23, X21, ASR #0
    MOV  X7, X23
    ST3 { V3.2D, V4.2D, V5.2D }, [X7], #48
    MOV  X7, X23
    LD3 { V17.2D, V18.2D, V19.2D }, [X7], #48
    ADD  X23, X23, X21
    MOV  X7, X23
    ST3 { V22.4S, V23.4S, V24.4S }, [X7], #48
    MOV  X7, X23
    LD3 { V3.4S, V4.4S, V5.4S }, [X7], #48
    ADD  X23, X23, X21, ASR #0
    MOV  X7, X23
    ST3 { V17.8H, V18.8H, V19.8H }, [X7], #48
    MOV  X7, X23
    LD3 { V22.8H, V23.8H, V24.8H }, [X7], #48
    ADD  X23, X23, X21, ASR #0
    MOV  X7, X23
    ST3 { V22.4H, V23.4H, V24.4H }, [X7], #24
    MOV  X7, X23
    LD3 { V17.2S, V18.2S, V19.2S }, [X7], #24
    ADD  X23, X23, X21, ASR #0
    MOV  X7, X23
    ST3 { V17.2S, V18.2S, V19.2S }, [X7], #24
    MOV  X7, X23
    LD3 { V17.2S, V18.2S, V19.2S }, [X7], #24
    ADD  X23, X23, X21, ASR #0
    MOV  X7, X23
    ST3 { V22.4H, V23.4H, V24.4H }, [X7], #24
    MOV  X7, X23
    LD3 { V22.4H, V23.4H, V24.4H }, [X7], #24
    ADD  X23, X23, X21, LSR #0
    MOV  X7, X23
    ST3 { V17.8B, V18.8B, V19.8B }, [X7], #24
    MOV  X7, X23
    LD3 { V23.8B, V24.8B, V25.8B }, [X7], #24
    ADD  X23, X23, X21, ASR #0
    ST3 { V3.2D, V4.2D, V5.2D }, [X23], X13
    LD3 { V12.4S, V13.4S, V14.4S }, [X23], X13
    ADD  X23, X23, X21, ASR #0
    ST3 { V12.16B, V13.16B, V14.16B }, [X23], X13
    LD3 { V1.16B, V2.16B, V3.16B }, [X23], X13
    ADD  X23, X23, X21
    ST3 { V22.2D, V23.2D, V24.2D }, [X23], X13
    LD3 { V31.2D, V0.2D, V1.2D }, [X23], X13
    ADD  X23, X23, X21, LSR #0
    ST3 { V21.4S, V22.4S, V23.4S }, [X23], X13
    LD3 { V18.4S, V19.4S, V20.4S }, [X23], X13
    ADD  X23, X23, X21, LSR #0
    ST3 { V30.8H, V31.8H, V0.8H }, [X23], X13
    LD3 { V18.8H, V19.8H, V20.8H }, [X23], X13
    ADD  X23, X23, X21, LSR #0
    ST3 { V18.2S, V19.2S, V20.2S }, [X23], X13
    LD3 { V30.8B, V31.8B, V0.8B }, [X23], X13
    ADD  X23, X23, X21, LSR #0
    ST3 { V31.2S, V0.2S, V1.2S }, [X23], X13
    LD3 { V19.2S, V20.2S, V21.2S }, [X23], X13
    ADD  X23, X23, X21, ASR #0
    ST3 { V27.4H, V28.4H, V29.4H }, [X23], X13
    LD3 { V12.4H, V13.4H, V14.4H }, [X23], X13
    ADD  X23, X23, X21
    ST3 { V30.8B, V31.8B, V0.8B }, [X23], X13
    LD3 { V29.8B, V30.8B, V31.8B }, [X23], X13
    ADD  X23, X23, X21, LSR #0
    ST3 { V19.H, V20.H, V21.H }[0x4], [X23]
    LD3 { V18.H, V19.H, V20.H }[0x4], [X23]
    ADD  X23, X23, X21
    ST3 { V29.S, V30.S, V31.S }[0x3], [X23]
    LD3 { V27.S, V28.S, V29.S }[0x3], [X23]
    ADD  X23, X23, X21, ASR #0
    ST3 { V27.D, V28.D, V29.D }[0x1], [X23]
    LD3 { V24.D, V25.D, V26.D }[0x1], [X23]
    ADD  X23, X23, X21
    ST3 { V18.B, V19.B, V20.B }[0x6], [X23]
    LD3 { V19.B, V20.B, V21.B }[0x2], [X23]
    ADD  X23, X23, X21, LSR #0
    MOV  X7, X23
    ST3 { V24.H, V25.H, V26.H }[0x2], [X7], #6
    MOV  X7, X23
    LD3 { V27.H, V28.H, V29.H }[0x7], [X7], #6
    ADD  X23, X23, X21, ASR #0
    ST3 { V19.H, V20.H, V21.H }[0x6], [X23], X13
    LD3 { V19.H, V20.H, V21.H }[0x4], [X23], X13
    ADD  X23, X23, X21, ASR #0
    MOV  X7, X23
    ST3 { V27.S, V28.S, V29.S }[0x3], [X7], #12
    MOV  X7, X23
    LD3 { V25.S, V26.S, V27.S }[0x0], [X7], #12
    ADD  X23, X23, X21
    ST3 { V19.S, V20.S, V21.S }[0x3], [X23], X13
    LD3 { V18.S, V19.S, V20.S }[0x3], [X23], X13
    ADD  X23, X23, X21, ASR #0
    MOV  X7, X23
    ST3 { V25.D, V26.D, V27.D }[0x1], [X7], #24
    MOV  X7, X23
    LD3 { V25.D, V26.D, V27.D }[0x0], [X7], #24
    ADD  X23, X23, X21, ASR #0
    ST3 { V18.D, V19.D, V20.D }[0x1], [X23], X13
    LD3 { V3.D, V4.D, V5.D }[0x0], [X23], X13
    ADD  X23, X23, X21
    MOV  X7, X23
    ST3 { V3.B, V4.B, V5.B }[0xa], [X7], #3
    MOV  X7, X23
    LD3 { V18.B, V19.B, V20.B }[0x6], [X7], #3
    ADD  X23, X23, X21, ASR #0
    ST3 { V25.B, V26.B, V27.B }[0xa], [X23], X13
    LD3 { V29.B, V30.B, V31.B }[0xc], [X23], X13
    ADD  X23, X23, X21, LSR #0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X29, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X29, FPSR
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D0
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D1
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V2.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D2
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V3.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    FMOV  X29, D3
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V4.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, D4
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, D5
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V6.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D6
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V7.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D7
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V8.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D8
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V9.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D9
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V10.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D10
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V11.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D11
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D12
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D13
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D14
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V15.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D15
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V16.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D16
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D17
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    FMOV  X29, V18.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa500, LSL #48
    FMOV  X29, D18
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V19.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa500, LSL #48
    FMOV  X29, D19
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V20.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa500, LSL #48
    FMOV  X29, D20
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V21.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D21
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V22.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D22
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V23.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D23
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    FMOV  X29, V24.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D24
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    FMOV  X29, V25.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    FMOV  X29, D25
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V26.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, D26
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V27.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D27
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V28.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D28
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, V29.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D29
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D30
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa5, LSL #32
    FMOV  X29, V31.D[1]
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X29, D31
    SUB  X20, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X19
    FMOV  D3, X10
    FMOV  V3.D[1], X29
    FMOV  D4, X3
    FMOV  V4.D[1], X16
    FMOV  D5, X25
    FMOV  V5.D[1], X2
    FMOV  D6, X29
    FMOV  V6.D[1], X26
    FMOV  D7, X2
    FMOV  V7.D[1], X7
    FMOV  D8, X17
    FMOV  V8.D[1], X17
    FMOV  D9, X27
    FMOV  V9.D[1], X7
    FMOV  D10, X11
    FMOV  V10.D[1], X22
    FMOV  D11, X2
    FMOV  V11.D[1], X7
    FMOV  D12, X26
    FMOV  V12.D[1], X4
    FMOV  D13, X2
    FMOV  V13.D[1], X29
    FMOV  D14, X11
    FMOV  V14.D[1], X21
    FMOV  D15, X19
    FMOV  V15.D[1], X12
    FMOV  D16, X22
    FMOV  V16.D[1], X26
    FMOV  D17, X21
    FMOV  V17.D[1], X3
    FMOV  D18, X20
    FMOV  V18.D[1], X14
    FMOV  D19, X29
    FMOV  V19.D[1], X13
    FMOV  D20, X27
    FMOV  V20.D[1], X3
    FMOV  D21, X25
    FMOV  V21.D[1], X2
    FMOV  D22, X5
    FMOV  V22.D[1], X28
    FMOV  D23, X17
    FMOV  V23.D[1], X21
    FMOV  D24, X4
    FMOV  V24.D[1], X13
    FMOV  D25, X8
    FMOV  V25.D[1], X27
    FMOV  D26, X2
    FMOV  V26.D[1], X29
    FMOV  D27, X4
    FMOV  V27.D[1], X27
    FMOV  D28, X19
    FMOV  V28.D[1], X21
    FMOV  D29, X4
    FMOV  V29.D[1], X7
    FMOV  D30, X26
    FMOV  V30.D[1], X26
    FMOV  D31, X11
    FMOV  V31.D[1], X4
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X19, #0x1e00, LSL #0
    ADD  X17, X30, X19
    ST3 { V24.16B, V25.16B, V26.16B }, [X17]
    LD3 { V9.8H, V10.8H, V11.8H }, [X17]
    ADD  X17, X17, X28, LSR #0
    ST3 { V29.16B, V30.16B, V31.16B }, [X17]
    LD3 { V30.16B, V31.16B, V0.16B }, [X17]
    ADD  X17, X17, X28, ASR #0
    ST3 { V10.2D, V11.2D, V12.2D }, [X17]
    LD3 { V27.2D, V28.2D, V29.2D }, [X17]
    ADD  X17, X17, X28, ASR #0
    ST3 { V30.4S, V31.4S, V0.4S }, [X17]
    LD3 { V21.4S, V22.4S, V23.4S }, [X17]
    ADD  X17, X17, X28
    ST3 { V21.8H, V22.8H, V23.8H }, [X17]
    LD3 { V3.8H, V4.8H, V5.8H }, [X17]
    ADD  X17, X17, X28
    ST3 { V17.8B, V18.8B, V19.8B }, [X17]
    LD3 { V17.4H, V18.4H, V19.4H }, [X17]
    ADD  X17, X17, X28
    ST3 { V17.2S, V18.2S, V19.2S }, [X17]
    LD3 { V17.2S, V18.2S, V19.2S }, [X17]
    ADD  X17, X17, X28
    ST3 { V17.4H, V18.4H, V19.4H }, [X17]
    LD3 { V10.4H, V11.4H, V12.4H }, [X17]
    ADD  X17, X17, X28
    ST3 { V3.8B, V4.8B, V5.8B }, [X17]
    LD3 { V3.8B, V4.8B, V5.8B }, [X17]
    ADD  X17, X17, X28, LSR #0
    MOV  X21, X17
    ST3 { V3.8H, V4.8H, V5.8H }, [X21], #48
    MOV  X21, X17
    LD3 { V21.8H, V22.8H, V23.8H }, [X21], #48
    ADD  X17, X17, X28
    MOV  X21, X17
    ST3 { V21.16B, V22.16B, V23.16B }, [X21], #48
    MOV  X21, X17
    LD3 { V17.16B, V18.16B, V19.16B }, [X21], #48
    ADD  X17, X17, X28, ASR #0
    MOV  X21, X17
    ST3 { V10.2D, V11.2D, V12.2D }, [X21], #48
    MOV  X21, X17
    LD3 { V21.2D, V22.2D, V23.2D }, [X21], #48
    ADD  X17, X17, X28
    MOV  X21, X17
    ST3 { V17.4S, V18.4S, V19.4S }, [X21], #48
    MOV  X21, X17
    LD3 { V3.4S, V4.4S, V5.4S }, [X21], #48
    ADD  X17, X17, X28
    MOV  X21, X17
    ST3 { V21.8H, V22.8H, V23.8H }, [X21], #48
    MOV  X21, X17
    LD3 { V27.8H, V28.8H, V29.8H }, [X21], #48
    ADD  X17, X17, X28
    MOV  X21, X17
    ST3 { V3.8B, V4.8B, V5.8B }, [X21], #24
    MOV  X21, X17
    LD3 { V10.2S, V11.2S, V12.2S }, [X21], #24
    ADD  X17, X17, X28, ASR #0
    MOV  X21, X17
    ST3 { V10.2S, V11.2S, V12.2S }, [X21], #24
    MOV  X21, X17
    LD3 { V21.2S, V22.2S, V23.2S }, [X21], #24
    ADD  X17, X17, X28
    MOV  X21, X17
    ST3 { V27.4H, V28.4H, V29.4H }, [X21], #24
    MOV  X21, X17
    LD3 { V3.4H, V4.4H, V5.4H }, [X21], #24
    ADD  X17, X17, X28, LSR #0
    MOV  X21, X17
    ST3 { V3.8B, V4.8B, V5.8B }, [X21], #24
    MOV  X21, X17
    LD3 { V27.8B, V28.8B, V29.8B }, [X21], #24
    ADD  X17, X17, X28, LSR #0
    ST3 { V27.2D, V28.2D, V29.2D }, [X17], X12
    LD3 { V10.16B, V11.16B, V12.16B }, [X17], X12
    ADD  X17, X17, X28, ASR #0
    ST3 { V10.16B, V11.16B, V12.16B }, [X17], X12
    LD3 { V27.16B, V28.16B, V29.16B }, [X17], X12
    ADD  X17, X17, X28, LSR #0
    ST3 { V27.2D, V28.2D, V29.2D }, [X17], X12
    LD3 { V10.2D, V11.2D, V12.2D }, [X17], X12
    ADD  X17, X17, X28, ASR #0
    ST3 { V21.4S, V22.4S, V23.4S }, [X17], X12
    LD3 { V27.4S, V28.4S, V29.4S }, [X17], X12
    ADD  X17, X17, X28, LSR #0
    ST3 { V4.8H, V5.8H, V6.8H }, [X17], X12
    LD3 { V3.8H, V4.8H, V5.8H }, [X17], X12
    ADD  X17, X17, X28, ASR #0
    ST3 { V3.4H, V4.4H, V5.4H }, [X17], X12
    LD3 { V3.8B, V4.8B, V5.8B }, [X17], X12
    ADD  X17, X17, X28
    ST3 { V2.2S, V3.2S, V4.2S }, [X17], X12
    LD3 { V2.2S, V3.2S, V4.2S }, [X17], X12
    ADD  X17, X17, X28
    ST3 { V2.4H, V3.4H, V4.4H }, [X17], X12
    LD3 { V2.4H, V3.4H, V4.4H }, [X17], X12
    ADD  X17, X17, X28
    ST3 { V14.8B, V15.8B, V16.8B }, [X17], X12
    LD3 { V14.8B, V15.8B, V16.8B }, [X17], X12
    ADD  X17, X17, X28, ASR #0
    ST3 { V21.H, V22.H, V23.H }[0x1], [X17]
    LD3 { V21.H, V22.H, V23.H }[0x3], [X17]
    ADD  X17, X17, X28, ASR #0
    ST3 { V3.S, V4.S, V5.S }[0x3], [X17]
    LD3 { V14.S, V15.S, V16.S }[0x3], [X17]
    ADD  X17, X17, X28, ASR #0
    ST3 { V21.D, V22.D, V23.D }[0x0], [X17]
    LD3 { V3.D, V4.D, V5.D }[0x1], [X17]
    ADD  X17, X17, X28, ASR #0
    ST3 { V18.B, V19.B, V20.B }[0x1], [X17]
    LD3 { V13.B, V14.B, V15.B }[0x9], [X17]
    ADD  X17, X17, X28
    MOV  X21, X17
    ST3 { V2.H, V3.H, V4.H }[0x6], [X21], #6
    MOV  X21, X17
    LD3 { V21.H, V22.H, V23.H }[0x5], [X21], #6
    ADD  X17, X17, X28, ASR #0
    ST3 { V14.H, V15.H, V16.H }[0x6], [X17], X12
    LD3 { V7.H, V8.H, V9.H }[0x2], [X17], X12
    ADD  X17, X17, X28, LSR #0
    MOV  X21, X17
    ST3 { V1.S, V2.S, V3.S }[0x0], [X21], #12
    MOV  X21, X17
    LD3 { V6.S, V7.S, V8.S }[0x2], [X21], #12
    ADD  X17, X17, X28, LSR #0
    ST3 { V23.S, V24.S, V25.S }[0x2], [X17], X12
    LD3 { V28.S, V29.S, V30.S }[0x1], [X17], X12
    ADD  X17, X17, X28
    MOV  X21, X17
    ST3 { V28.D, V29.D, V30.D }[0x1], [X21], #24
    MOV  X21, X17
    LD3 { V14.D, V15.D, V16.D }[0x0], [X21], #24
    ADD  X17, X17, X28
    ST3 { V6.D, V7.D, V8.D }[0x1], [X17], X12
    LD3 { V18.D, V19.D, V20.D }[0x1], [X17], X12
    ADD  X17, X17, X28, ASR #0
    MOV  X21, X17
    ST3 { V14.B, V15.B, V16.B }[0xa], [X21], #3
    MOV  X21, X17
    LD3 { V12.B, V13.B, V14.B }[0xf], [X21], #3
    ADD  X17, X17, X28, ASR #0
    ST3 { V12.B, V13.B, V14.B }[0x5], [X17], X12
    LD3 { V28.B, V29.B, V30.B }[0xd], [X17], X12
    ADD  X17, X17, X28
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X5, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X5, FPSR
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V0.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D0
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V1.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D1
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, V2.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D2
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V3.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D3
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V4.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D4
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V5.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D5
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V6.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D6
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V7.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D7
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V8.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D8
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V9.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D9
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, V10.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D10
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, V11.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D11
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, V12.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D12
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a, LSL #48
    FMOV  X5, V13.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D13
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a00, LSL #0
    FMOV  X5, V14.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, D14
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a00, LSL #0
    FMOV  X5, V15.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, D15
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, V16.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D16
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, V17.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D17
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V18.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D18
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V19.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D19
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V20.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D20
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, V21.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D21
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    FMOV  X5, V22.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D22
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    FMOV  X5, V23.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D23
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V24.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D24
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V25.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D25
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V26.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D26
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X5, V27.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D27
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5a00, LSL #32
    FMOV  X5, V28.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D28
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0x5a00, LSL #32
    FMOV  X5, V29.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D29
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V30.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D30
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, V31.D[1]
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    FMOV  X5, D31
    SUB  X14, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X27
    FMOV  D3, X27
    FMOV  V3.D[1], X26
    FMOV  D4, X26
    FMOV  V4.D[1], X4
    FMOV  D5, X20
    FMOV  V5.D[1], X23
    FMOV  D6, X16
    FMOV  V6.D[1], X9
    FMOV  D7, X27
    FMOV  V7.D[1], X21
    FMOV  D8, X17
    FMOV  V8.D[1], X16
    FMOV  D9, X26
    FMOV  V9.D[1], X5
    FMOV  D10, X28
    FMOV  V10.D[1], X12
    FMOV  D11, X25
    FMOV  V11.D[1], X17
    FMOV  D12, X12
    FMOV  V12.D[1], X5
    FMOV  D13, X12
    FMOV  V13.D[1], X5
    FMOV  D14, X21
    FMOV  V14.D[1], X27
    FMOV  D15, X23
    FMOV  V15.D[1], X17
    FMOV  D16, X20
    FMOV  V16.D[1], X14
    FMOV  D17, X10
    FMOV  V17.D[1], X22
    FMOV  D18, X9
    FMOV  V18.D[1], X29
    FMOV  D19, X27
    FMOV  V19.D[1], X27
    FMOV  D20, X5
    FMOV  V20.D[1], X3
    FMOV  D21, X5
    FMOV  V21.D[1], X14
    FMOV  D22, X4
    FMOV  V22.D[1], X2
    FMOV  D23, X29
    FMOV  V23.D[1], X7
    FMOV  D24, X10
    FMOV  V24.D[1], X3
    FMOV  D25, X16
    FMOV  V25.D[1], X5
    FMOV  D26, X16
    FMOV  V26.D[1], X13
    FMOV  D27, X12
    FMOV  V27.D[1], X8
    FMOV  D28, X12
    FMOV  V28.D[1], X22
    FMOV  D29, X8
    FMOV  V29.D[1], X29
    FMOV  D30, X8
    FMOV  V30.D[1], X29
    FMOV  D31, X28
    FMOV  V31.D[1], X3
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X27, #0x2300, LSL #0
    ADD  X17, X30, X27, ASR #0
    ST3 { V14.8H, V15.8H, V16.8H }, [X17]
    LD3 { V9.16B, V10.16B, V11.16B }, [X17]
    ADD  X17, X17, X5
    ST3 { V27.16B, V28.16B, V29.16B }, [X17]
    LD3 { V20.16B, V21.16B, V22.16B }, [X17]
    ADD  X17, X17, X5
    ST3 { V9.2D, V10.2D, V11.2D }, [X17]
    LD3 { V15.2D, V16.2D, V17.2D }, [X17]
    ADD  X17, X17, X5, ASR #0
    ST3 { V15.4S, V16.4S, V17.4S }, [X17]
    LD3 { V5.4S, V6.4S, V7.4S }, [X17]
    ADD  X17, X17, X5, ASR #0
    ST3 { V20.8H, V21.8H, V22.8H }, [X17]
    LD3 { V20.8H, V21.8H, V22.8H }, [X17]
    ADD  X17, X17, X5
    ST3 { V31.4H, V0.4H, V1.4H }, [X17]
    LD3 { V2.8B, V3.8B, V4.8B }, [X17]
    ADD  X17, X17, X5
    ST3 { V4.2S, V5.2S, V6.2S }, [X17]
    LD3 { V9.2S, V10.2S, V11.2S }, [X17]
    ADD  X17, X17, X5
    ST3 { V20.4H, V21.4H, V22.4H }, [X17]
    LD3 { V4.4H, V5.4H, V6.4H }, [X17]
    ADD  X17, X17, X5, LSR #0
    ST3 { V4.8B, V5.8B, V6.8B }, [X17]
    LD3 { V4.8B, V5.8B, V6.8B }, [X17]
    ADD  X17, X17, X5
    MOV  X25, X17
    ST3 { V22.16B, V23.16B, V24.16B }, [X25], #48
    MOV  X25, X17
    LD3 { V31.16B, V0.16B, V1.16B }, [X25], #48
    ADD  X17, X17, X5, LSR #0
    MOV  X25, X17
    ST3 { V2.16B, V3.16B, V4.16B }, [X25], #48
    MOV  X25, X17
    LD3 { V22.16B, V23.16B, V24.16B }, [X25], #48
    ADD  X17, X17, X5
    MOV  X25, X17
    ST3 { V9.2D, V10.2D, V11.2D }, [X25], #48
    MOV  X25, X17
    LD3 { V2.2D, V3.2D, V4.2D }, [X25], #48
    ADD  X17, X17, X5, LSR #0
    MOV  X25, X17
    ST3 { V31.4S, V0.4S, V1.4S }, [X25], #48
    MOV  X25, X17
    LD3 { V9.4S, V10.4S, V11.4S }, [X25], #48
    ADD  X17, X17, X5, ASR #0
    MOV  X25, X17
    ST3 { V9.8H, V10.8H, V11.8H }, [X25], #48
    MOV  X25, X17
    LD3 { V31.8H, V0.8H, V1.8H }, [X25], #48
    ADD  X17, X17, X5, ASR #0
    MOV  X25, X17
    ST3 { V22.8B, V23.8B, V24.8B }, [X25], #24
    MOV  X25, X17
    LD3 { V22.2S, V23.2S, V24.2S }, [X25], #24
    ADD  X17, X17, X5, LSR #0
    MOV  X25, X17
    ST3 { V22.2S, V23.2S, V24.2S }, [X25], #24
    MOV  X25, X17
    LD3 { V9.2S, V10.2S, V11.2S }, [X25], #24
    ADD  X17, X17, X5, ASR #0
    MOV  X25, X17
    ST3 { V31.4H, V0.4H, V1.4H }, [X25], #24
    MOV  X25, X17
    LD3 { V31.4H, V0.4H, V1.4H }, [X25], #24
    ADD  X17, X17, X5, LSR #0
    MOV  X25, X17
    ST3 { V31.8B, V0.8B, V1.8B }, [X25], #24
    MOV  X25, X17
    LD3 { V31.8B, V0.8B, V1.8B }, [X25], #24
    ADD  X17, X17, X5, ASR #0
    ST3 { V9.4S, V10.4S, V11.4S }, [X17], X10
    LD3 { V9.4S, V10.4S, V11.4S }, [X17], X10
    ADD  X17, X17, X5
    ST3 { V9.16B, V10.16B, V11.16B }, [X17], X10
    LD3 { V9.16B, V10.16B, V11.16B }, [X17], X10
    ADD  X17, X17, X5
    ST3 { V31.2D, V0.2D, V1.2D }, [X17], X10
    LD3 { V31.2D, V0.2D, V1.2D }, [X17], X10
    ADD  X17, X17, X5, ASR #0
    ST3 { V9.4S, V10.4S, V11.4S }, [X17], X10
    LD3 { V9.4S, V10.4S, V11.4S }, [X17], X10
    ADD  X17, X17, X5
    ST3 { V31.8H, V0.8H, V1.8H }, [X17], X10
    LD3 { V31.8H, V0.8H, V1.8H }, [X17], X10
    ADD  X17, X17, X5, LSR #0
    ST3 { V31.8B, V0.8B, V1.8B }, [X17], X10
    LD3 { V31.2S, V0.2S, V1.2S }, [X17], X10
    ADD  X17, X17, X5, ASR #0
    ST3 { V9.2S, V10.2S, V11.2S }, [X17], X10
    LD3 { V9.2S, V10.2S, V11.2S }, [X17], X10
    ADD  X17, X17, X5, ASR #0
    ST3 { V31.4H, V0.4H, V1.4H }, [X17], X10
    LD3 { V7.4H, V8.4H, V9.4H }, [X17], X10
    ADD  X17, X17, X5, LSR #0
    ST3 { V30.8B, V31.8B, V0.8B }, [X17], X10
    LD3 { V24.8B, V25.8B, V26.8B }, [X17], X10
    ADD  X17, X17, X5, LSR #0
    ST3 { V7.H, V8.H, V9.H }[0x5], [X17]
    LD3 { V9.H, V10.H, V11.H }[0x1], [X17]
    ADD  X17, X17, X5, LSR #0
    ST3 { V6.S, V7.S, V8.S }[0x0], [X17]
    LD3 { V16.S, V17.S, V18.S }[0x2], [X17]
    ADD  X17, X17, X5
    ST3 { V24.D, V25.D, V26.D }[0x1], [X17]
    LD3 { V10.D, V11.D, V12.D }[0x1], [X17]
    ADD  X17, X17, X5, LSR #0
    ST3 { V9.B, V10.B, V11.B }[0xc], [X17]
    LD3 { V19.B, V20.B, V21.B }[0x3], [X17]
    ADD  X17, X17, X5, ASR #0
    MOV  X25, X17
    ST3 { V19.H, V20.H, V21.H }[0x2], [X25], #6
    MOV  X25, X17
    LD3 { V9.H, V10.H, V11.H }[0x2], [X25], #6
    ADD  X17, X17, X5
    ST3 { V9.H, V10.H, V11.H }[0x3], [X17], X10
    LD3 { V31.H, V0.H, V1.H }[0x7], [X17], X10
    ADD  X17, X17, X5, ASR #0
    MOV  X25, X17
    ST3 { V16.S, V17.S, V18.S }[0x3], [X25], #12
    MOV  X25, X17
    LD3 { V24.S, V25.S, V26.S }[0x1], [X25], #12
    ADD  X17, X17, X5, LSR #0
    ST3 { V2.S, V3.S, V4.S }[0x2], [X17], X10
    LD3 { V1.S, V2.S, V3.S }[0x2], [X17], X10
    ADD  X17, X17, X5, LSR #0
    MOV  X25, X17
    ST3 { V0.D, V1.D, V2.D }[0x0], [X25], #24
    MOV  X25, X17
    LD3 { V19.D, V20.D, V21.D }[0x1], [X25], #24
    ADD  X17, X17, X5
    ST3 { V19.D, V20.D, V21.D }[0x1], [X17], X10
    LD3 { V19.D, V20.D, V21.D }[0x1], [X17], X10
    ADD  X17, X17, X5
    MOV  X25, X17
    ST3 { V24.B, V25.B, V26.B }[0x5], [X25], #3
    MOV  X25, X17
    LD3 { V22.B, V23.B, V24.B }[0x3], [X25], #3
    ADD  X17, X17, X5
    ST3 { V22.B, V23.B, V24.B }[0x2], [X17], X10
    LD3 { V9.B, V10.B, V11.B }[0x8], [X17], X10
    ADD  X17, X17, X5
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X22
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X26, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V0.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D0
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V1.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D1
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D2
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D3
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D4
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D5
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D6
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D7
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D8
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D9
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D10
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D11
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V12.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D12
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V13.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D13
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V14.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D14
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V15.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D15
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V16.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D16
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V17.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D17
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V18.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D18
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V19.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D19
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V20.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D20
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V21.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D21
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D22
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V23.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D23
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D24
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D25
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D26
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V27.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D27
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V28.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D28
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V29.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D29
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V30.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D30
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, V31.D[1]
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    FMOV  X26, D31
    SUB  X7, X12, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X12
    FMOV  D3, X20
    FMOV  V3.D[1], X21
    FMOV  D4, X7
    FMOV  V4.D[1], X16
    FMOV  D5, X23
    FMOV  V5.D[1], X16
    FMOV  D6, X20
    FMOV  V6.D[1], X2
    FMOV  D7, X11
    FMOV  V7.D[1], X13
    FMOV  D8, X5
    FMOV  V8.D[1], X7
    FMOV  D9, X10
    FMOV  V9.D[1], X21
    FMOV  D10, X10
    FMOV  V10.D[1], X11
    FMOV  D11, X23
    FMOV  V11.D[1], X3
    FMOV  D12, X22
    FMOV  V12.D[1], X13
    FMOV  D13, X21
    FMOV  V13.D[1], X11
    FMOV  D14, X2
    FMOV  V14.D[1], X11
    FMOV  D15, X3
    FMOV  V15.D[1], X16
    FMOV  D16, X9
    FMOV  V16.D[1], X13
    FMOV  D17, X19
    FMOV  V17.D[1], X9
    FMOV  D18, X7
    FMOV  V18.D[1], X29
    FMOV  D19, X4
    FMOV  V19.D[1], X5
    FMOV  D20, X11
    FMOV  V20.D[1], X13
    FMOV  D21, X17
    FMOV  V21.D[1], X16
    FMOV  D22, X2
    FMOV  V22.D[1], X9
    FMOV  D23, X19
    FMOV  V23.D[1], X14
    FMOV  D24, X4
    FMOV  V24.D[1], X9
    FMOV  D25, X29
    FMOV  V25.D[1], X22
    FMOV  D26, X5
    FMOV  V26.D[1], X2
    FMOV  D27, X3
    FMOV  V27.D[1], X20
    FMOV  D28, X17
    FMOV  V28.D[1], X3
    FMOV  D29, X14
    FMOV  V29.D[1], X13
    FMOV  D30, X11
    FMOV  V30.D[1], X7
    FMOV  D31, X20
    FMOV  V31.D[1], X25
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X16, #0x2800, LSL #0
    ADD  X7, X30, X16
    ST3 { V24.4S, V25.4S, V26.4S }, [X7]
    LD3 { V25.2D, V26.2D, V27.2D }, [X7]
    ADD  X7, X7, X25
    ST3 { V13.16B, V14.16B, V15.16B }, [X7]
    LD3 { V10.16B, V11.16B, V12.16B }, [X7]
    ADD  X7, X7, X25
    ST3 { V21.2D, V22.2D, V23.2D }, [X7]
    LD3 { V15.2D, V16.2D, V17.2D }, [X7]
    ADD  X7, X7, X25
    ST3 { V25.4S, V26.4S, V27.4S }, [X7]
    LD3 { V13.4S, V14.4S, V15.4S }, [X7]
    ADD  X7, X7, X25, LSR #0
    ST3 { V23.8H, V24.8H, V25.8H }, [X7]
    LD3 { V7.8H, V8.8H, V9.8H }, [X7]
    ADD  X7, X7, X25
    ST3 { V13.2S, V14.2S, V15.2S }, [X7]
    LD3 { V19.8B, V20.8B, V21.8B }, [X7]
    ADD  X7, X7, X25, LSR #0
    ST3 { V15.2S, V16.2S, V17.2S }, [X7]
    LD3 { V6.2S, V7.2S, V8.2S }, [X7]
    ADD  X7, X7, X25, LSR #0
    ST3 { V6.4H, V7.4H, V8.4H }, [X7]
    LD3 { V26.4H, V27.4H, V28.4H }, [X7]
    ADD  X7, X7, X25, ASR #0
    ST3 { V9.8B, V10.8B, V11.8B }, [X7]
    LD3 { V23.8B, V24.8B, V25.8B }, [X7]
    ADD  X7, X7, X25, ASR #0
    MOV  X23, X7
    ST3 { V26.4S, V27.4S, V28.4S }, [X23], #48
    MOV  X23, X7
    LD3 { V9.16B, V10.16B, V11.16B }, [X23], #48
    ADD  X7, X7, X25, ASR #0
    MOV  X23, X7
    ST3 { V23.16B, V24.16B, V25.16B }, [X23], #48
    MOV  X23, X7
    LD3 { V2.16B, V3.16B, V4.16B }, [X23], #48
    ADD  X7, X7, X25, LSR #0
    MOV  X23, X7
    ST3 { V2.2D, V3.2D, V4.2D }, [X23], #48
    MOV  X23, X7
    LD3 { V6.2D, V7.2D, V8.2D }, [X23], #48
    ADD  X7, X7, X25, ASR #0
    MOV  X23, X7
    ST3 { V19.4S, V20.4S, V21.4S }, [X23], #48
    MOV  X23, X7
    LD3 { V19.4S, V20.4S, V21.4S }, [X23], #48
    ADD  X7, X7, X25, LSR #0
    MOV  X23, X7
    ST3 { V6.8H, V7.8H, V8.8H }, [X23], #48
    MOV  X23, X7
    LD3 { V2.8H, V3.8H, V4.8H }, [X23], #48
    ADD  X7, X7, X25
    MOV  X23, X7
    ST3 { V19.4H, V20.4H, V21.4H }, [X23], #24
    MOV  X23, X7
    LD3 { V19.2S, V20.2S, V21.2S }, [X23], #24
    ADD  X7, X7, X25, LSR #0
    MOV  X23, X7
    ST3 { V2.2S, V3.2S, V4.2S }, [X23], #24
    MOV  X23, X7
    LD3 { V6.2S, V7.2S, V8.2S }, [X23], #24
    ADD  X7, X7, X25, ASR #0
    MOV  X23, X7
    ST3 { V6.4H, V7.4H, V8.4H }, [X23], #24
    MOV  X23, X7
    LD3 { V6.4H, V7.4H, V8.4H }, [X23], #24
    ADD  X7, X7, X25
    MOV  X23, X7
    ST3 { V19.8B, V20.8B, V21.8B }, [X23], #24
    MOV  X23, X7
    LD3 { V19.8B, V20.8B, V21.8B }, [X23], #24
    ADD  X7, X7, X25, LSR #0
    ST3 { V6.16B, V7.16B, V8.16B }, [X7], X5
    LD3 { V6.8H, V7.8H, V8.8H }, [X7], X5
    ADD  X7, X7, X25, LSR #0
    ST3 { V6.16B, V7.16B, V8.16B }, [X7], X5
    LD3 { V2.16B, V3.16B, V4.16B }, [X7], X5
    ADD  X7, X7, X25, ASR #0
    ST3 { V2.2D, V3.2D, V4.2D }, [X7], X5
    LD3 { V6.2D, V7.2D, V8.2D }, [X7], X5
    ADD  X7, X7, X25, LSR #0
    ST3 { V6.4S, V7.4S, V8.4S }, [X7], X5
    LD3 { V2.4S, V3.4S, V4.4S }, [X7], X5
    ADD  X7, X7, X25, ASR #0
    ST3 { V19.8H, V20.8H, V21.8H }, [X7], X5
    LD3 { V6.8H, V7.8H, V8.8H }, [X7], X5
    ADD  X7, X7, X25, ASR #0
    ST3 { V2.2S, V3.2S, V4.2S }, [X7], X5
    LD3 { V2.4H, V3.4H, V4.4H }, [X7], X5
    ADD  X7, X7, X25
    ST3 { V2.2S, V3.2S, V4.2S }, [X7], X5
    LD3 { V19.2S, V20.2S, V21.2S }, [X7], X5
    ADD  X7, X7, X25, LSR #0
    ST3 { V19.4H, V20.4H, V21.4H }, [X7], X5
    LD3 { V2.4H, V3.4H, V4.4H }, [X7], X5
    ADD  X7, X7, X25
    ST3 { V6.8B, V7.8B, V8.8B }, [X7], X5
    LD3 { V19.8B, V20.8B, V21.8B }, [X7], X5
    ADD  X7, X7, X25
    ST3 { V2.H, V3.H, V4.H }[0x4], [X7]
    LD3 { V6.H, V7.H, V8.H }[0x2], [X7]
    ADD  X7, X7, X25
    ST3 { V27.S, V28.S, V29.S }[0x0], [X7]
    LD3 { V2.S, V3.S, V4.S }[0x1], [X7]
    ADD  X7, X7, X25, LSR #0
    ST3 { V5.D, V6.D, V7.D }[0x0], [X7]
    LD3 { V27.D, V28.D, V29.D }[0x1], [X7]
    ADD  X7, X7, X25
    ST3 { V19.B, V20.B, V21.B }[0x3], [X7]
    LD3 { V19.B, V20.B, V21.B }[0x7], [X7]
    ADD  X7, X7, X25, ASR #0
    MOV  X23, X7
    ST3 { V19.H, V20.H, V21.H }[0x2], [X23], #6
    MOV  X23, X7
    LD3 { V2.H, V3.H, V4.H }[0x4], [X23], #6
    ADD  X7, X7, X25, LSR #0
    ST3 { V27.H, V28.H, V29.H }[0x0], [X7], X5
    LD3 { V5.H, V6.H, V7.H }[0x1], [X7], X5
    ADD  X7, X7, X25
    MOV  X23, X7
    ST3 { V2.S, V3.S, V4.S }[0x2], [X23], #12
    MOV  X23, X7
    LD3 { V19.S, V20.S, V21.S }[0x3], [X23], #12
    ADD  X7, X7, X25
    ST3 { V19.S, V20.S, V21.S }[0x3], [X7], X5
    LD3 { V19.S, V20.S, V21.S }[0x1], [X7], X5
    ADD  X7, X7, X25
    MOV  X23, X7
    ST3 { V15.D, V16.D, V17.D }[0x0], [X23], #24
    MOV  X23, X7
    LD3 { V27.D, V28.D, V29.D }[0x1], [X23], #24
    ADD  X7, X7, X25, ASR #0
    ST3 { V19.D, V20.D, V21.D }[0x0], [X7], X5
    LD3 { V2.D, V3.D, V4.D }[0x0], [X7], X5
    ADD  X7, X7, X25, LSR #0
    MOV  X23, X7
    ST3 { V5.B, V6.B, V7.B }[0x0], [X23], #3
    MOV  X23, X7
    LD3 { V15.B, V16.B, V17.B }[0x4], [X23], #3
    ADD  X7, X7, X25, ASR #0
    ST3 { V27.B, V28.B, V29.B }[0xa], [X7], X5
    LD3 { V27.B, V28.B, V29.B }[0x3], [X7], X5
    ADD  X7, X7, X25, LSR #0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X3, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X3, FPSR
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V0.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D0
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V1.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D1
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X3, V2.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    FMOV  X3, D2
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X3, V3.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    FMOV  X3, D3
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    FMOV  X3, V4.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    FMOV  X3, D4
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V5.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D5
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V6.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D6
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V7.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D7
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V8.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D8
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V9.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D9
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V10.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D10
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V11.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D11
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V12.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D12
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V13.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D13
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V14.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D14
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V15.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D15
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V16.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D16
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V17.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D17
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V18.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D18
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #32
    FMOV  X3, V19.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    FMOV  X3, D19
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #32
    FMOV  X3, V20.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    FMOV  X3, D20
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0x5a5a, LSL #32
    FMOV  X3, V21.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    FMOV  X3, D21
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V22.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D22
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V23.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D23
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V24.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D24
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V25.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D25
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X3, V26.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D26
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V27.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D27
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V28.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D28
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V29.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D29
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V30.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D30
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, V31.D[1]
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    FMOV  X3, D31
    SUB  X13, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X17
    FMOV  D3, X12
    FMOV  V3.D[1], X29
    FMOV  D4, X4
    FMOV  V4.D[1], X14
    FMOV  D5, X10
    FMOV  V5.D[1], X29
    FMOV  D6, X4
    FMOV  V6.D[1], X14
    FMOV  D7, X4
    FMOV  V7.D[1], X29
    FMOV  D8, X19
    FMOV  V8.D[1], X2
    FMOV  D9, X4
    FMOV  V9.D[1], X17
    FMOV  D10, X23
    FMOV  V10.D[1], X17
    FMOV  D11, X9
    FMOV  V11.D[1], X23
    FMOV  D12, X16
    FMOV  V12.D[1], X25
    FMOV  D13, X10
    FMOV  V13.D[1], X20
    FMOV  D14, X2
    FMOV  V14.D[1], X21
    FMOV  D15, X5
    FMOV  V15.D[1], X5
    FMOV  D16, X22
    FMOV  V16.D[1], X4
    FMOV  D17, X4
    FMOV  V17.D[1], X12
    FMOV  D18, X27
    FMOV  V18.D[1], X16
    FMOV  D19, X20
    FMOV  V19.D[1], X13
    FMOV  D20, X19
    FMOV  V20.D[1], X27
    FMOV  D21, X2
    FMOV  V21.D[1], X20
    FMOV  D22, X28
    FMOV  V22.D[1], X28
    FMOV  D23, X26
    FMOV  V23.D[1], X14
    FMOV  D24, X7
    FMOV  V24.D[1], X7
    FMOV  D25, X29
    FMOV  V25.D[1], X13
    FMOV  D26, X13
    FMOV  V26.D[1], X23
    FMOV  D27, X9
    FMOV  V27.D[1], X26
    FMOV  D28, X17
    FMOV  V28.D[1], X16
    FMOV  D29, X10
    FMOV  V29.D[1], X4
    FMOV  D30, X19
    FMOV  V30.D[1], X9
    FMOV  D31, X8
    FMOV  V31.D[1], X12
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X5, #0x2d00, LSL #0
    ADD  X22, X30, X5, LSR #0
    ST3 { V28.4S, V29.4S, V30.4S }, [X22]
    LD3 { V15.8H, V16.8H, V17.8H }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST3 { V25.16B, V26.16B, V27.16B }, [X22]
    LD3 { V27.16B, V28.16B, V29.16B }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST3 { V15.2D, V16.2D, V17.2D }, [X22]
    LD3 { V10.2D, V11.2D, V12.2D }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST3 { V27.4S, V28.4S, V29.4S }, [X22]
    LD3 { V12.4S, V13.4S, V14.4S }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST3 { V10.8H, V11.8H, V12.8H }, [X22]
    LD3 { V5.8H, V6.8H, V7.8H }, [X22]
    ADD  X22, X22, X14
    ST3 { V5.2S, V6.2S, V7.2S }, [X22]
    LD3 { V5.4H, V6.4H, V7.4H }, [X22]
    ADD  X22, X22, X14
    ST3 { V5.2S, V6.2S, V7.2S }, [X22]
    LD3 { V27.2S, V28.2S, V29.2S }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST3 { V27.4H, V28.4H, V29.4H }, [X22]
    LD3 { V5.4H, V6.4H, V7.4H }, [X22]
    ADD  X22, X22, X14, LSR #0
    ST3 { V5.8B, V6.8B, V7.8B }, [X22]
    LD3 { V15.8B, V16.8B, V17.8B }, [X22]
    ADD  X22, X22, X14
    MOV  X26, X22
    ST3 { V19.2D, V20.2D, V21.2D }, [X26], #48
    MOV  X26, X22
    LD3 { V19.16B, V20.16B, V21.16B }, [X26], #48
    ADD  X22, X22, X14
    MOV  X26, X22
    ST3 { V15.16B, V16.16B, V17.16B }, [X26], #48
    MOV  X26, X22
    LD3 { V5.16B, V6.16B, V7.16B }, [X26], #48
    ADD  X22, X22, X14, ASR #0
    MOV  X26, X22
    ST3 { V5.2D, V6.2D, V7.2D }, [X26], #48
    MOV  X26, X22
    LD3 { V10.2D, V11.2D, V12.2D }, [X26], #48
    ADD  X22, X22, X14
    MOV  X26, X22
    ST3 { V19.4S, V20.4S, V21.4S }, [X26], #48
    MOV  X26, X22
    LD3 { V5.4S, V6.4S, V7.4S }, [X26], #48
    ADD  X22, X22, X14, LSR #0
    MOV  X26, X22
    ST3 { V5.8H, V6.8H, V7.8H }, [X26], #48
    MOV  X26, X22
    LD3 { V5.8H, V6.8H, V7.8H }, [X26], #48
    ADD  X22, X22, X14, LSR #0
    MOV  X26, X22
    ST3 { V10.4H, V11.4H, V12.4H }, [X26], #24
    MOV  X26, X22
    LD3 { V19.8B, V20.8B, V21.8B }, [X26], #24
    ADD  X22, X22, X14, LSR #0
    MOV  X26, X22
    ST3 { V19.2S, V20.2S, V21.2S }, [X26], #24
    MOV  X26, X22
    LD3 { V10.2S, V11.2S, V12.2S }, [X26], #24
    ADD  X22, X22, X14, ASR #0
    MOV  X26, X22
    ST3 { V5.4H, V6.4H, V7.4H }, [X26], #24
    MOV  X26, X22
    LD3 { V19.4H, V20.4H, V21.4H }, [X26], #24
    ADD  X22, X22, X14, LSR #0
    MOV  X26, X22
    ST3 { V10.8B, V11.8B, V12.8B }, [X26], #24
    MOV  X26, X22
    LD3 { V10.8B, V11.8B, V12.8B }, [X26], #24
    ADD  X22, X22, X14
    ST3 { V19.8H, V20.8H, V21.8H }, [X22], X23
    LD3 { V5.8H, V6.8H, V7.8H }, [X22], X23
    ADD  X22, X22, X14, ASR #0
    ST3 { V10.16B, V11.16B, V12.16B }, [X22], X23
    LD3 { V19.16B, V20.16B, V21.16B }, [X22], X23
    ADD  X22, X22, X14, LSR #0
    ST3 { V19.2D, V20.2D, V21.2D }, [X22], X23
    LD3 { V10.2D, V11.2D, V12.2D }, [X22], X23
    ADD  X22, X22, X14
    ST3 { V10.4S, V11.4S, V12.4S }, [X22], X23
    LD3 { V19.4S, V20.4S, V21.4S }, [X22], X23
    ADD  X22, X22, X14, LSR #0
    ST3 { V16.8H, V17.8H, V18.8H }, [X22], X23
    LD3 { V10.8H, V11.8H, V12.8H }, [X22], X23
    ADD  X22, X22, X14, LSR #0
    ST3 { V5.8B, V6.8B, V7.8B }, [X22], X23
    LD3 { V16.4H, V17.4H, V18.4H }, [X22], X23
    ADD  X22, X22, X14, ASR #0
    ST3 { V18.2S, V19.2S, V20.2S }, [X22], X23
    LD3 { V18.2S, V19.2S, V20.2S }, [X22], X23
    ADD  X22, X22, X14
    ST3 { V2.4H, V3.4H, V4.4H }, [X22], X23
    LD3 { V4.4H, V5.4H, V6.4H }, [X22], X23
    ADD  X22, X22, X14, LSR #0
    ST3 { V4.8B, V5.8B, V6.8B }, [X22], X23
    LD3 { V16.8B, V17.8B, V18.8B }, [X22], X23
    ADD  X22, X22, X14, ASR #0
    ST3 { V17.H, V18.H, V19.H }[0x4], [X22]
    LD3 { V1.H, V2.H, V3.H }[0x2], [X22]
    ADD  X22, X22, X14, ASR #0
    ST3 { V4.S, V5.S, V6.S }[0x2], [X22]
    LD3 { V17.S, V18.S, V19.S }[0x1], [X22]
    ADD  X22, X22, X14
    ST3 { V16.D, V17.D, V18.D }[0x1], [X22]
    LD3 { V16.D, V17.D, V18.D }[0x1], [X22]
    ADD  X22, X22, X14
    ST3 { V19.B, V20.B, V21.B }[0xa], [X22]
    LD3 { V4.B, V5.B, V6.B }[0xf], [X22]
    ADD  X22, X22, X14, ASR #0
    MOV  X26, X22
    ST3 { V2.H, V3.H, V4.H }[0x6], [X26], #6
    MOV  X26, X22
    LD3 { V2.H, V3.H, V4.H }[0x2], [X26], #6
    ADD  X22, X22, X14, LSR #0
    ST3 { V4.H, V5.H, V6.H }[0x6], [X22], X23
    LD3 { V19.H, V20.H, V21.H }[0x0], [X22], X23
    ADD  X22, X22, X14, ASR #0
    MOV  X26, X22
    ST3 { V12.S, V13.S, V14.S }[0x3], [X26], #12
    MOV  X26, X22
    LD3 { V4.S, V5.S, V6.S }[0x3], [X26], #12
    ADD  X22, X22, X14, LSR #0
    ST3 { V17.S, V18.S, V19.S }[0x2], [X22], X23
    LD3 { V12.S, V13.S, V14.S }[0x1], [X22], X23
    ADD  X22, X22, X14, LSR #0
    MOV  X26, X22
    ST3 { V3.D, V4.D, V5.D }[0x1], [X26], #24
    MOV  X26, X22
    LD3 { V17.D, V18.D, V19.D }[0x0], [X26], #24
    ADD  X22, X22, X14, LSR #0
    ST3 { V19.D, V20.D, V21.D }[0x0], [X22], X23
    LD3 { V19.D, V20.D, V21.D }[0x1], [X22], X23
    ADD  X22, X22, X14
    MOV  X26, X22
    ST3 { V18.B, V19.B, V20.B }[0xe], [X26], #3
    MOV  X26, X22
    LD3 { V3.B, V4.B, V5.B }[0x6], [X26], #3
    ADD  X22, X22, X14, ASR #0
    ST3 { V12.B, V13.B, V14.B }[0xb], [X22], X23
    LD3 { V12.B, V13.B, V14.B }[0xd], [X22], X23
    ADD  X22, X22, X14, LSR #0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X19, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V0.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D0
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V1.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D1
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V2.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D2
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V3.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa500, LSL #48
    FMOV  X19, D3
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D4
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V5.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D5
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D6
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D7
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V8.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D8
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V9.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D9
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D10
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D11
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V12.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    FMOV  X19, D12
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V13.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    FMOV  X19, D13
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    FMOV  X19, D14
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D15
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V16.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D16
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V17.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D17
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V18.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D18
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V19.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D19
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V20.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D20
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V21.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D21
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D22
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V23.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D23
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V24.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D24
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V25.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D25
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V26.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D26
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V27.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D27
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V28.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D28
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0x0, LSL #0
    FMOV  X19, V29.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D29
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V30.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D30
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, V31.D[1]
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    FMOV  X19, D31
    SUB  X2, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X26
    FMOV  D1, X23
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X8
    FMOV  V3.D[1], X19
    FMOV  D4, X22
    FMOV  V4.D[1], X17
    FMOV  D5, X26
    FMOV  V5.D[1], X26
    FMOV  D6, X7
    FMOV  V6.D[1], X20
    FMOV  D7, X27
    FMOV  V7.D[1], X8
    FMOV  D8, X28
    FMOV  V8.D[1], X20
    FMOV  D9, X10
    FMOV  V9.D[1], X23
    FMOV  D10, X20
    FMOV  V10.D[1], X19
    FMOV  D11, X20
    FMOV  V11.D[1], X25
    FMOV  D12, X5
    FMOV  V12.D[1], X10
    FMOV  D13, X14
    FMOV  V13.D[1], X2
    FMOV  D14, X19
    FMOV  V14.D[1], X28
    FMOV  D15, X23
    FMOV  V15.D[1], X8
    FMOV  D16, X10
    FMOV  V16.D[1], X29
    FMOV  D17, X7
    FMOV  V17.D[1], X28
    FMOV  D18, X23
    FMOV  V18.D[1], X25
    FMOV  D19, X16
    FMOV  V19.D[1], X28
    FMOV  D20, X25
    FMOV  V20.D[1], X4
    FMOV  D21, X4
    FMOV  V21.D[1], X5
    FMOV  D22, X17
    FMOV  V22.D[1], X28
    FMOV  D23, X19
    FMOV  V23.D[1], X13
    FMOV  D24, X9
    FMOV  V24.D[1], X11
    FMOV  D25, X2
    FMOV  V25.D[1], X17
    FMOV  D26, X29
    FMOV  V26.D[1], X28
    FMOV  D27, X10
    FMOV  V27.D[1], X26
    FMOV  D28, X5
    FMOV  V28.D[1], X28
    FMOV  D29, X9
    FMOV  V29.D[1], X4
    FMOV  D30, X16
    FMOV  V30.D[1], X4
    FMOV  D31, X23
    FMOV  V31.D[1], X8
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X9, #0x0, LSL #0
    ADD  X27, X30, X9, ASR #0
    ST3 { V27.8H, V28.8H, V29.8H }, [X27]
    LD3 { V24.2D, V25.2D, V26.2D }, [X27]
    ADD  X27, X27, X20, ASR #0
    ST3 { V24.16B, V25.16B, V26.16B }, [X27]
    LD3 { V12.16B, V13.16B, V14.16B }, [X27]
    ADD  X27, X27, X20, LSR #0
    ST3 { V12.2D, V13.2D, V14.2D }, [X27]
    LD3 { V13.2D, V14.2D, V15.2D }, [X27]
    ADD  X27, X27, X20, ASR #0
    ST3 { V6.4S, V7.4S, V8.4S }, [X27]
    LD3 { V18.4S, V19.4S, V20.4S }, [X27]
    ADD  X27, X27, X20, ASR #0
    ST3 { V18.8H, V19.8H, V20.8H }, [X27]
    LD3 { V18.8H, V19.8H, V20.8H }, [X27]
    ADD  X27, X27, X20, ASR #0
    ST3 { V13.2S, V14.2S, V15.2S }, [X27]
    LD3 { V26.8B, V27.8B, V28.8B }, [X27]
    ADD  X27, X27, X20, ASR #0
    ST3 { V18.2S, V19.2S, V20.2S }, [X27]
    LD3 { V23.2S, V24.2S, V25.2S }, [X27]
    ADD  X27, X27, X20
    ST3 { V23.4H, V24.4H, V25.4H }, [X27]
    LD3 { V23.4H, V24.4H, V25.4H }, [X27]
    ADD  X27, X27, X20
    ST3 { V23.8B, V24.8B, V25.8B }, [X27]
    LD3 { V23.8B, V24.8B, V25.8B }, [X27]
    ADD  X27, X27, X20
    MOV  X22, X27
    ST3 { V8.2D, V9.2D, V10.2D }, [X22], #48
    MOV  X22, X27
    LD3 { V4.4S, V5.4S, V6.4S }, [X22], #48
    ADD  X27, X27, X20
    MOV  X22, X27
    ST3 { V26.16B, V27.16B, V28.16B }, [X22], #48
    MOV  X22, X27
    LD3 { V28.16B, V29.16B, V30.16B }, [X22], #48
    ADD  X27, X27, X20, LSR #0
    MOV  X22, X27
    ST3 { V4.2D, V5.2D, V6.2D }, [X22], #48
    MOV  X22, X27
    LD3 { V8.2D, V9.2D, V10.2D }, [X22], #48
    ADD  X27, X27, X20, ASR #0
    MOV  X22, X27
    ST3 { V28.4S, V29.4S, V30.4S }, [X22], #48
    MOV  X22, X27
    LD3 { V4.4S, V5.4S, V6.4S }, [X22], #48
    ADD  X27, X27, X20, ASR #0
    MOV  X22, X27
    ST3 { V8.8H, V9.8H, V10.8H }, [X22], #48
    MOV  X22, X27
    LD3 { V26.8H, V27.8H, V28.8H }, [X22], #48
    ADD  X27, X27, X20, ASR #0
    MOV  X22, X27
    ST3 { V26.4H, V27.4H, V28.4H }, [X22], #24
    MOV  X22, X27
    LD3 { V8.8B, V9.8B, V10.8B }, [X22], #24
    ADD  X27, X27, X20, ASR #0
    MOV  X22, X27
    ST3 { V4.2S, V5.2S, V6.2S }, [X22], #24
    MOV  X22, X27
    LD3 { V4.2S, V5.2S, V6.2S }, [X22], #24
    ADD  X27, X27, X20, LSR #0
    MOV  X22, X27
    ST3 { V4.4H, V5.4H, V6.4H }, [X22], #24
    MOV  X22, X27
    LD3 { V4.4H, V5.4H, V6.4H }, [X22], #24
    ADD  X27, X27, X20, ASR #0
    MOV  X22, X27
    ST3 { V4.8B, V5.8B, V6.8B }, [X22], #24
    MOV  X22, X27
    LD3 { V4.8B, V5.8B, V6.8B }, [X22], #24
    ADD  X27, X27, X20, ASR #0
    ST3 { V8.2D, V9.2D, V10.2D }, [X27], X19
    LD3 { V8.4S, V9.4S, V10.4S }, [X27], X19
    ADD  X27, X27, X20
    ST3 { V8.16B, V9.16B, V10.16B }, [X27], X19
    LD3 { V8.16B, V9.16B, V10.16B }, [X27], X19
    ADD  X27, X27, X20, LSR #0
    ST3 { V8.2D, V9.2D, V10.2D }, [X27], X19
    LD3 { V8.2D, V9.2D, V10.2D }, [X27], X19
    ADD  X27, X27, X20, LSR #0
    ST3 { V8.4S, V9.4S, V10.4S }, [X27], X19
    LD3 { V8.4S, V9.4S, V10.4S }, [X27], X19
    ADD  X27, X27, X20, LSR #0
    ST3 { V4.8H, V5.8H, V6.8H }, [X27], X19
    LD3 { V4.8H, V5.8H, V6.8H }, [X27], X19
    ADD  X27, X27, X20, LSR #0
    ST3 { V8.2S, V9.2S, V10.2S }, [X27], X19
    LD3 { V13.4H, V14.4H, V15.4H }, [X27], X19
    ADD  X27, X27, X20
    ST3 { V4.2S, V5.2S, V6.2S }, [X27], X19
    LD3 { V6.2S, V7.2S, V8.2S }, [X27], X19
    ADD  X27, X27, X20, ASR #0
    ST3 { V13.4H, V14.4H, V15.4H }, [X27], X19
    LD3 { V6.4H, V7.4H, V8.4H }, [X27], X19
    ADD  X27, X27, X20
    ST3 { V6.8B, V7.8B, V8.8B }, [X27], X19
    LD3 { V30.8B, V31.8B, V0.8B }, [X27], X19
    ADD  X27, X27, X20
    ST3 { V14.H, V15.H, V16.H }[0x6], [X27]
    LD3 { V11.H, V12.H, V13.H }[0x6], [X27]
    ADD  X27, X27, X20, ASR #0
    ST3 { V22.S, V23.S, V24.S }[0x1], [X27]
    LD3 { V14.S, V15.S, V16.S }[0x2], [X27]
    ADD  X27, X27, X20, ASR #0
    ST3 { V14.D, V15.D, V16.D }[0x1], [X27]
    LD3 { V22.D, V23.D, V24.D }[0x1], [X27]
    ADD  X27, X27, X20, ASR #0
    ST3 { V11.B, V12.B, V13.B }[0x6], [X27]
    LD3 { V16.B, V17.B, V18.B }[0x8], [X27]
    ADD  X27, X27, X20, ASR #0
    MOV  X22, X27
    ST3 { V30.H, V31.H, V0.H }[0x1], [X22], #6
    MOV  X22, X27
    LD3 { V30.H, V31.H, V0.H }[0x0], [X22], #6
    ADD  X27, X27, X20, ASR #0
    ST3 { V30.H, V31.H, V0.H }[0x1], [X27], X19
    LD3 { V11.H, V12.H, V13.H }[0x1], [X27], X19
    ADD  X27, X27, X20, ASR #0
    MOV  X22, X27
    ST3 { V11.S, V12.S, V13.S }[0x1], [X22], #12
    MOV  X22, X27
    LD3 { V6.S, V7.S, V8.S }[0x0], [X22], #12
    ADD  X27, X27, X20, ASR #0
    ST3 { V16.S, V17.S, V18.S }[0x2], [X27], X19
    LD3 { V11.S, V12.S, V13.S }[0x3], [X27], X19
    ADD  X27, X27, X20, ASR #0
    MOV  X22, X27
    ST3 { V11.D, V12.D, V13.D }[0x1], [X22], #24
    MOV  X22, X27
    LD3 { V16.D, V17.D, V18.D }[0x1], [X22], #24
    ADD  X27, X27, X20, LSR #0
    ST3 { V16.D, V17.D, V18.D }[0x1], [X27], X19
    LD3 { V28.D, V29.D, V30.D }[0x1], [X27], X19
    ADD  X27, X27, X20
    MOV  X22, X27
    ST3 { V28.B, V29.B, V30.B }[0x5], [X22], #3
    MOV  X22, X27
    LD3 { V11.B, V12.B, V13.B }[0xf], [X22], #3
    ADD  X27, X27, X20, ASR #0
    ST3 { V6.B, V7.B, V8.B }[0xb], [X27], X19
    LD3 { V28.B, V29.B, V30.B }[0x0], [X27], X19
    ADD  X27, X27, X20, LSR #0
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X21
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X26, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D0
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V1.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D1
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V2.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D2
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V3.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D3
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V4.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D4
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V5.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D5
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V6.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D6
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V7.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D7
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D8
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D9
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V10.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D10
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V11.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D11
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V12.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D12
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V13.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D13
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    FMOV  X26, V14.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D14
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    FMOV  X26, V15.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D15
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V16.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D16
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V17.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D17
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V18.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D18
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V19.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D19
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V20.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D20
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V21.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D21
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    FMOV  X26, V22.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D22
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    FMOV  X26, V23.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D23
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V24.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D24
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V25.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D25
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V26.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D26
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V27.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D27
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V28.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a00, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D28
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V29.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a00, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D29
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, V30.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a00, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D30
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X26, D31
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X29
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X22
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X21
    FMOV  D4, X19
    FMOV  V4.D[1], X11
    FMOV  D5, X13
    FMOV  V5.D[1], X25
    FMOV  D6, X17
    FMOV  V6.D[1], X10
    FMOV  D7, X23
    FMOV  V7.D[1], X16
    FMOV  D8, X14
    FMOV  V8.D[1], X29
    FMOV  D9, X21
    FMOV  V9.D[1], X12
    FMOV  D10, X23
    FMOV  V10.D[1], X14
    FMOV  D11, X10
    FMOV  V11.D[1], X23
    FMOV  D12, X14
    FMOV  V12.D[1], X26
    FMOV  D13, X23
    FMOV  V13.D[1], X26
    FMOV  D14, X5
    FMOV  V14.D[1], X9
    FMOV  D15, X4
    FMOV  V15.D[1], X25
    FMOV  D16, X23
    FMOV  V16.D[1], X21
    FMOV  D17, X29
    FMOV  V17.D[1], X21
    FMOV  D18, X9
    FMOV  V18.D[1], X13
    FMOV  D19, X26
    FMOV  V19.D[1], X25
    FMOV  D20, X25
    FMOV  V20.D[1], X26
    FMOV  D21, X8
    FMOV  V21.D[1], X29
    FMOV  D22, X3
    FMOV  V22.D[1], X20
    FMOV  D23, X17
    FMOV  V23.D[1], X11
    FMOV  D24, X21
    FMOV  V24.D[1], X26
    FMOV  D25, X14
    FMOV  V25.D[1], X5
    FMOV  D26, X28
    FMOV  V26.D[1], X29
    FMOV  D27, X22
    FMOV  V27.D[1], X7
    FMOV  D28, X9
    FMOV  V28.D[1], X28
    FMOV  D29, X22
    FMOV  V29.D[1], X28
    FMOV  D30, X28
    FMOV  V30.D[1], X14
    FMOV  D31, X21
    FMOV  V31.D[1], X9
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X22, #0x500, LSL #0
    ADD  X11, X30, X22, ASR #0
    ST3 { V20.2D, V21.2D, V22.2D }, [X11]
    LD3 { V17.2D, V18.2D, V19.2D }, [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V26.16B, V27.16B, V28.16B }, [X11]
    LD3 { V21.16B, V22.16B, V23.16B }, [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V9.2D, V10.2D, V11.2D }, [X11]
    LD3 { V16.2D, V17.2D, V18.2D }, [X11]
    ADD  X11, X11, X21
    ST3 { V21.4S, V22.4S, V23.4S }, [X11]
    LD3 { V5.4S, V6.4S, V7.4S }, [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V16.8H, V17.8H, V18.8H }, [X11]
    LD3 { V25.8H, V26.8H, V27.8H }, [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V25.2S, V26.2S, V27.2S }, [X11]
    LD3 { V11.2S, V12.2S, V13.2S }, [X11]
    ADD  X11, X11, X21, LSR #0
    ST3 { V5.2S, V6.2S, V7.2S }, [X11]
    LD3 { V5.2S, V6.2S, V7.2S }, [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V5.4H, V6.4H, V7.4H }, [X11]
    LD3 { V25.4H, V26.4H, V27.4H }, [X11]
    ADD  X11, X11, X21
    ST3 { V25.8B, V26.8B, V27.8B }, [X11]
    LD3 { V21.8B, V22.8B, V23.8B }, [X11]
    ADD  X11, X11, X21, ASR #0
    MOV  X19, X11
    ST3 { V11.2D, V12.2D, V13.2D }, [X19], #48
    MOV  X19, X11
    LD3 { V16.8H, V17.8H, V18.8H }, [X19], #48
    ADD  X11, X11, X21, LSR #0
    MOV  X19, X11
    ST3 { V16.16B, V17.16B, V18.16B }, [X19], #48
    MOV  X19, X11
    LD3 { V11.16B, V12.16B, V13.16B }, [X19], #48
    ADD  X11, X11, X21
    MOV  X19, X11
    ST3 { V21.2D, V22.2D, V23.2D }, [X19], #48
    MOV  X19, X11
    LD3 { V21.2D, V22.2D, V23.2D }, [X19], #48
    ADD  X11, X11, X21
    MOV  X19, X11
    ST3 { V21.4S, V22.4S, V23.4S }, [X19], #48
    MOV  X19, X11
    LD3 { V21.4S, V22.4S, V23.4S }, [X19], #48
    ADD  X11, X11, X21
    MOV  X19, X11
    ST3 { V11.8H, V12.8H, V13.8H }, [X19], #48
    MOV  X19, X11
    LD3 { V16.8H, V17.8H, V18.8H }, [X19], #48
    ADD  X11, X11, X21
    MOV  X19, X11
    ST3 { V16.8B, V17.8B, V18.8B }, [X19], #24
    MOV  X19, X11
    LD3 { V16.8B, V17.8B, V18.8B }, [X19], #24
    ADD  X11, X11, X21
    MOV  X19, X11
    ST3 { V21.2S, V22.2S, V23.2S }, [X19], #24
    MOV  X19, X11
    LD3 { V21.2S, V22.2S, V23.2S }, [X19], #24
    ADD  X11, X11, X21, LSR #0
    MOV  X19, X11
    ST3 { V21.4H, V22.4H, V23.4H }, [X19], #24
    MOV  X19, X11
    LD3 { V11.4H, V12.4H, V13.4H }, [X19], #24
    ADD  X11, X11, X21
    MOV  X19, X11
    ST3 { V11.8B, V12.8B, V13.8B }, [X19], #24
    MOV  X19, X11
    LD3 { V20.8B, V21.8B, V22.8B }, [X19], #24
    ADD  X11, X11, X21
    ST3 { V20.16B, V21.16B, V22.16B }, [X11], X5
    LD3 { V11.2D, V12.2D, V13.2D }, [X11], X5
    ADD  X11, X11, X21, ASR #0
    ST3 { V11.16B, V12.16B, V13.16B }, [X11], X5
    LD3 { V11.16B, V12.16B, V13.16B }, [X11], X5
    ADD  X11, X11, X21, ASR #0
    ST3 { V11.2D, V12.2D, V13.2D }, [X11], X5
    LD3 { V20.2D, V21.2D, V22.2D }, [X11], X5
    ADD  X11, X11, X21, ASR #0
    ST3 { V20.4S, V21.4S, V22.4S }, [X11], X5
    LD3 { V13.4S, V14.4S, V15.4S }, [X11], X5
    ADD  X11, X11, X21
    ST3 { V13.8H, V14.8H, V15.8H }, [X11], X5
    LD3 { V20.8H, V21.8H, V22.8H }, [X11], X5
    ADD  X11, X11, X21, ASR #0
    ST3 { V20.2S, V21.2S, V22.2S }, [X11], X5
    LD3 { V27.2S, V28.2S, V29.2S }, [X11], X5
    ADD  X11, X11, X21, ASR #0
    ST3 { V10.2S, V11.2S, V12.2S }, [X11], X5
    LD3 { V20.2S, V21.2S, V22.2S }, [X11], X5
    ADD  X11, X11, X21
    ST3 { V3.4H, V4.4H, V5.4H }, [X11], X5
    LD3 { V10.4H, V11.4H, V12.4H }, [X11], X5
    ADD  X11, X11, X21
    ST3 { V20.8B, V21.8B, V22.8B }, [X11], X5
    LD3 { V20.8B, V21.8B, V22.8B }, [X11], X5
    ADD  X11, X11, X21, ASR #0
    ST3 { V27.H, V28.H, V29.H }[0x6], [X11]
    LD3 { V3.H, V4.H, V5.H }[0x6], [X11]
    ADD  X11, X11, X21
    ST3 { V3.S, V4.S, V5.S }[0x0], [X11]
    LD3 { V0.S, V1.S, V2.S }[0x0], [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V10.D, V11.D, V12.D }[0x1], [X11]
    LD3 { V10.D, V11.D, V12.D }[0x0], [X11]
    ADD  X11, X11, X21, ASR #0
    ST3 { V20.B, V21.B, V22.B }[0xa], [X11]
    LD3 { V3.B, V4.B, V5.B }[0x8], [X11]
    ADD  X11, X11, X21, LSR #0
    MOV  X19, X11
    ST3 { V10.H, V11.H, V12.H }[0x3], [X19], #6
    MOV  X19, X11
    LD3 { V20.H, V21.H, V22.H }[0x6], [X19], #6
    ADD  X11, X11, X21
    ST3 { V1.H, V2.H, V3.H }[0x6], [X11], X5
    LD3 { V1.H, V2.H, V3.H }[0x6], [X11], X5
    ADD  X11, X11, X21, ASR #0
    MOV  X19, X11
    ST3 { V20.S, V21.S, V22.S }[0x0], [X19], #12
    MOV  X19, X11
    LD3 { V20.S, V21.S, V22.S }[0x0], [X19], #12
    ADD  X11, X11, X21, LSR #0
    ST3 { V20.S, V21.S, V22.S }[0x3], [X11], X5
    LD3 { V10.S, V11.S, V12.S }[0x3], [X11], X5
    ADD  X11, X11, X21
    MOV  X19, X11
    ST3 { V10.D, V11.D, V12.D }[0x1], [X19], #24
    MOV  X19, X11
    LD3 { V10.D, V11.D, V12.D }[0x0], [X19], #24
    ADD  X11, X11, X21, ASR #0
    ST3 { V1.D, V2.D, V3.D }[0x0], [X11], X5
    LD3 { V20.D, V21.D, V22.D }[0x0], [X11], X5
    ADD  X11, X11, X21, LSR #0
    MOV  X19, X11
    ST3 { V20.B, V21.B, V22.B }[0xc], [X19], #3
    MOV  X19, X11
    LD3 { V1.B, V2.B, V3.B }[0xd], [X19], #3
    ADD  X11, X11, X21, ASR #0
    ST3 { V10.B, V11.B, V12.B }[0xf], [X11], X5
    LD3 { V20.B, V21.B, V22.B }[0x3], [X11], X5
    ADD  X11, X11, X21, LSR #0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X27
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X9, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X9, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    MRS  X9, FPSR
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V0.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D0
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V1.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D1
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V2.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D2
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa500, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V3.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D3
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa500, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V4.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D4
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V5.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D5
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V6.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D6
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V7.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D7
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V8.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D8
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V9.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D9
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V10.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D10
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V11.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D11
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V12.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, D12
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V13.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D13
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V14.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D14
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V15.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D15
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V16.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D16
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V17.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D17
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V18.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D18
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V19.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D19
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V20.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D20
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V21.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D21
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V22.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D22
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V23.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D23
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V24.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D24
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V25.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D25
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V26.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D26
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V27.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D27
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V28.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D28
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0x0, LSL #0
    FMOV  X9, V29.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D29
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V30.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D30
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, V31.D[1]
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    FMOV  X9, D31
    SUB  X17, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X21
    FMOV  V0.D[1], X29
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X28
    FMOV  V3.D[1], X28
    FMOV  D4, X19
    FMOV  V4.D[1], X27
    FMOV  D5, X12
    FMOV  V5.D[1], X16
    FMOV  D6, X23
    FMOV  V6.D[1], X26
    FMOV  D7, X28
    FMOV  V7.D[1], X2
    FMOV  D8, X17
    FMOV  V8.D[1], X7
    FMOV  D9, X28
    FMOV  V9.D[1], X8
    FMOV  D10, X20
    FMOV  V10.D[1], X9
    FMOV  D11, X28
    FMOV  V11.D[1], X23
    FMOV  D12, X4
    FMOV  V12.D[1], X4
    FMOV  D13, X13
    FMOV  V13.D[1], X20
    FMOV  D14, X3
    FMOV  V14.D[1], X21
    FMOV  D15, X11
    FMOV  V15.D[1], X8
    FMOV  D16, X16
    FMOV  V16.D[1], X26
    FMOV  D17, X13
    FMOV  V17.D[1], X2
    FMOV  D18, X26
    FMOV  V18.D[1], X5
    FMOV  D19, X20
    FMOV  V19.D[1], X17
    FMOV  D20, X4
    FMOV  V20.D[1], X21
    FMOV  D21, X26
    FMOV  V21.D[1], X17
    FMOV  D22, X19
    FMOV  V22.D[1], X10
    FMOV  D23, X23
    FMOV  V23.D[1], X3
    FMOV  D24, X11
    FMOV  V24.D[1], X16
    FMOV  D25, X21
    FMOV  V25.D[1], X8
    FMOV  D26, X13
    FMOV  V26.D[1], X2
    FMOV  D27, X27
    FMOV  V27.D[1], X3
    FMOV  D28, X21
    FMOV  V28.D[1], X19
    FMOV  D29, X8
    FMOV  V29.D[1], X9
    FMOV  D30, X17
    FMOV  V30.D[1], X20
    FMOV  D31, X9
    FMOV  V31.D[1], X14
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X20, #0xa00, LSL #0
    ADD  X4, X30, X20, ASR #0
    ST3 { V9.2D, V10.2D, V11.2D }, [X4]
    LD3 { V26.2D, V27.2D, V28.2D }, [X4]
    ADD  X4, X4, X29, LSR #0
    ST3 { V16.16B, V17.16B, V18.16B }, [X4]
    LD3 { V4.16B, V5.16B, V6.16B }, [X4]
    ADD  X4, X4, X29, LSR #0
    ST3 { V5.2D, V6.2D, V7.2D }, [X4]
    LD3 { V11.2D, V12.2D, V13.2D }, [X4]
    ADD  X4, X4, X29, ASR #0
    ST3 { V28.4S, V29.4S, V30.4S }, [X4]
    LD3 { V21.4S, V22.4S, V23.4S }, [X4]
    ADD  X4, X4, X29
    ST3 { V8.8H, V9.8H, V10.8H }, [X4]
    LD3 { V6.8H, V7.8H, V8.8H }, [X4]
    ADD  X4, X4, X29, LSR #0
    ST3 { V6.2S, V7.2S, V8.2S }, [X4]
    LD3 { V18.2S, V19.2S, V20.2S }, [X4]
    ADD  X4, X4, X29, LSR #0
    ST3 { V30.2S, V31.2S, V0.2S }, [X4]
    LD3 { V20.2S, V21.2S, V22.2S }, [X4]
    ADD  X4, X4, X29
    ST3 { V11.4H, V12.4H, V13.4H }, [X4]
    LD3 { V11.4H, V12.4H, V13.4H }, [X4]
    ADD  X4, X4, X29, ASR #0
    ST3 { V25.8B, V26.8B, V27.8B }, [X4]
    LD3 { V26.8B, V27.8B, V28.8B }, [X4]
    ADD  X4, X4, X29, LSR #0
    MOV  X12, X4
    ST3 { V3.16B, V4.16B, V5.16B }, [X12], #48
    MOV  X12, X4
    LD3 { V6.8H, V7.8H, V8.8H }, [X12], #48
    ADD  X4, X4, X29, LSR #0
    MOV  X12, X4
    ST3 { V25.16B, V26.16B, V27.16B }, [X12], #48
    MOV  X12, X4
    LD3 { V25.16B, V26.16B, V27.16B }, [X12], #48
    ADD  X4, X4, X29, ASR #0
    MOV  X12, X4
    ST3 { V6.2D, V7.2D, V8.2D }, [X12], #48
    MOV  X12, X4
    LD3 { V6.2D, V7.2D, V8.2D }, [X12], #48
    ADD  X4, X4, X29, ASR #0
    MOV  X12, X4
    ST3 { V18.4S, V19.4S, V20.4S }, [X12], #48
    MOV  X12, X4
    LD3 { V18.4S, V19.4S, V20.4S }, [X12], #48
    ADD  X4, X4, X29, LSR #0
    MOV  X12, X4
    ST3 { V26.8H, V27.8H, V28.8H }, [X12], #48
    MOV  X12, X4
    LD3 { V26.8H, V27.8H, V28.8H }, [X12], #48
    ADD  X4, X4, X29, ASR #0
    MOV  X12, X4
    ST3 { V22.4H, V23.4H, V24.4H }, [X12], #24
    MOV  X12, X4
    LD3 { V22.4H, V23.4H, V24.4H }, [X12], #24
    ADD  X4, X4, X29
    MOV  X12, X4
    ST3 { V26.2S, V27.2S, V28.2S }, [X12], #24
    MOV  X12, X4
    LD3 { V27.2S, V28.2S, V29.2S }, [X12], #24
    ADD  X4, X4, X29, LSR #0
    MOV  X12, X4
    ST3 { V18.4H, V19.4H, V20.4H }, [X12], #24
    MOV  X12, X4
    LD3 { V2.4H, V3.4H, V4.4H }, [X12], #24
    ADD  X4, X4, X29
    MOV  X12, X4
    ST3 { V22.8B, V23.8B, V24.8B }, [X12], #24
    MOV  X12, X4
    LD3 { V9.8B, V10.8B, V11.8B }, [X12], #24
    ADD  X4, X4, X29, LSR #0
    ST3 { V9.2D, V10.2D, V11.2D }, [X4], X17
    LD3 { V16.16B, V17.16B, V18.16B }, [X4], X17
    ADD  X4, X4, X29
    ST3 { V27.16B, V28.16B, V29.16B }, [X4], X17
    LD3 { V28.16B, V29.16B, V30.16B }, [X4], X17
    ADD  X4, X4, X29, ASR #0
    ST3 { V28.2D, V29.2D, V30.2D }, [X4], X17
    LD3 { V27.2D, V28.2D, V29.2D }, [X4], X17
    ADD  X4, X4, X29
    ST3 { V2.4S, V3.4S, V4.4S }, [X4], X17
    LD3 { V24.4S, V25.4S, V26.4S }, [X4], X17
    ADD  X4, X4, X29
    ST3 { V24.8H, V25.8H, V26.8H }, [X4], X17
    LD3 { V30.8H, V31.8H, V0.8H }, [X4], X17
    ADD  X4, X4, X29, LSR #0
    ST3 { V27.8B, V28.8B, V29.8B }, [X4], X17
    LD3 { V22.8B, V23.8B, V24.8B }, [X4], X17
    ADD  X4, X4, X29, ASR #0
    ST3 { V22.2S, V23.2S, V24.2S }, [X4], X17
    LD3 { V22.2S, V23.2S, V24.2S }, [X4], X17
    ADD  X4, X4, X29, ASR #0
    ST3 { V16.4H, V17.4H, V18.4H }, [X4], X17
    LD3 { V2.4H, V3.4H, V4.4H }, [X4], X17
    ADD  X4, X4, X29
    ST3 { V30.8B, V31.8B, V0.8B }, [X4], X17
    LD3 { V29.8B, V30.8B, V31.8B }, [X4], X17
    ADD  X4, X4, X29, ASR #0
    ST3 { V22.H, V23.H, V24.H }[0x5], [X4]
    LD3 { V16.H, V17.H, V18.H }[0x6], [X4]
    ADD  X4, X4, X29, LSR #0
    ST3 { V29.S, V30.S, V31.S }[0x3], [X4]
    LD3 { V12.S, V13.S, V14.S }[0x1], [X4]
    ADD  X4, X4, X29
    ST3 { V2.D, V3.D, V4.D }[0x1], [X4]
    LD3 { V2.D, V3.D, V4.D }[0x0], [X4]
    ADD  X4, X4, X29, LSR #0
    ST3 { V2.B, V3.B, V4.B }[0x5], [X4]
    LD3 { V29.B, V30.B, V31.B }[0xc], [X4]
    ADD  X4, X4, X29
    MOV  X12, X4
    ST3 { V16.H, V17.H, V18.H }[0x7], [X12], #6
    MOV  X12, X4
    LD3 { V31.H, V0.H, V1.H }[0x5], [X12], #6
    ADD  X4, X4, X29
    ST3 { V18.H, V19.H, V20.H }[0x3], [X4], X17
    LD3 { V2.H, V3.H, V4.H }[0x7], [X4], X17
    ADD  X4, X4, X29
    MOV  X12, X4
    ST3 { V2.S, V3.S, V4.S }[0x3], [X12], #12
    MOV  X12, X4
    LD3 { V2.S, V3.S, V4.S }[0x1], [X12], #12
    ADD  X4, X4, X29, ASR #0
    ST3 { V1.S, V2.S, V3.S }[0x0], [X4], X17
    LD3 { V17.S, V18.S, V19.S }[0x2], [X4], X17
    ADD  X4, X4, X29, LSR #0
    MOV  X12, X4
    ST3 { V17.D, V18.D, V19.D }[0x1], [X12], #24
    MOV  X12, X4
    LD3 { V23.D, V24.D, V25.D }[0x0], [X12], #24
    ADD  X4, X4, X29
    ST3 { V23.D, V24.D, V25.D }[0x1], [X4], X17
    LD3 { V1.D, V2.D, V3.D }[0x1], [X4], X17
    ADD  X4, X4, X29, ASR #0
    MOV  X12, X4
    ST3 { V1.B, V2.B, V3.B }[0x0], [X12], #3
    MOV  X12, X4
    LD3 { V17.B, V18.B, V19.B }[0xf], [X12], #3
    ADD  X4, X4, X29, ASR #0
    ST3 { V13.B, V14.B, V15.B }[0xa], [X4], X17
    LD3 { V1.B, V2.B, V3.B }[0x2], [X4], X17
    ADD  X4, X4, X29, LSR #0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X8, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D0
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a00, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D1
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D2
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D3
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, V4.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D4
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, V5.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D5
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, V6.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D6
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, V7.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D7
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, V8.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D8
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D9
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D10
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V11.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D11
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    FMOV  X8, D12
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V13.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    FMOV  X8, D13
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, V14.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    FMOV  X8, D14
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D15
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D16
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a00, LSL #48
    FMOV  X8, V17.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D17
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D18
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D19
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D20
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D21
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D22
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    FMOV  X8, D23
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, D24
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, D25
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D26
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D27
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D28
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D29
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D30
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X8, V31.D[1]
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X8, D31
    SUB  X25, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X27
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X23
    FMOV  V2.D[1], X17
    FMOV  D3, X17
    FMOV  V3.D[1], X4
    FMOV  D4, X2
    FMOV  V4.D[1], X14
    FMOV  D5, X7
    FMOV  V5.D[1], X16
    FMOV  D6, X2
    FMOV  V6.D[1], X10
    FMOV  D7, X5
    FMOV  V7.D[1], X16
    FMOV  D8, X11
    FMOV  V8.D[1], X5
    FMOV  D9, X25
    FMOV  V9.D[1], X11
    FMOV  D10, X12
    FMOV  V10.D[1], X13
    FMOV  D11, X5
    FMOV  V11.D[1], X2
    FMOV  D12, X22
    FMOV  V12.D[1], X16
    FMOV  D13, X28
    FMOV  V13.D[1], X25
    FMOV  D14, X21
    FMOV  V14.D[1], X16
    FMOV  D15, X23
    FMOV  V15.D[1], X19
    FMOV  D16, X2
    FMOV  V16.D[1], X28
    FMOV  D17, X17
    FMOV  V17.D[1], X2
    FMOV  D18, X22
    FMOV  V18.D[1], X11
    FMOV  D19, X19
    FMOV  V19.D[1], X3
    FMOV  D20, X19
    FMOV  V20.D[1], X2
    FMOV  D21, X22
    FMOV  V21.D[1], X12
    FMOV  D22, X4
    FMOV  V22.D[1], X19
    FMOV  D23, X4
    FMOV  V23.D[1], X9
    FMOV  D24, X23
    FMOV  V24.D[1], X25
    FMOV  D25, X21
    FMOV  V25.D[1], X3
    FMOV  D26, X2
    FMOV  V26.D[1], X2
    FMOV  D27, X19
    FMOV  V27.D[1], X26
    FMOV  D28, X25
    FMOV  V28.D[1], X8
    FMOV  D29, X16
    FMOV  V29.D[1], X25
    FMOV  D30, X12
    FMOV  V30.D[1], X9
    FMOV  D31, X7
    FMOV  V31.D[1], X13
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X11, #0xf00, LSL #0
    ADD  X21, X30, X11
    ST3 { V16.8H, V17.8H, V18.8H }, [X21]
    LD3 { V7.4S, V8.4S, V9.4S }, [X21]
    ADD  X21, X21, X4
    ST3 { V0.16B, V1.16B, V2.16B }, [X21]
    LD3 { V12.16B, V13.16B, V14.16B }, [X21]
    ADD  X21, X21, X4
    ST3 { V28.2D, V29.2D, V30.2D }, [X21]
    LD3 { V15.2D, V16.2D, V17.2D }, [X21]
    ADD  X21, X21, X4, ASR #0
    ST3 { V7.4S, V8.4S, V9.4S }, [X21]
    LD3 { V17.4S, V18.4S, V19.4S }, [X21]
    ADD  X21, X21, X4
    ST3 { V1.8H, V2.8H, V3.8H }, [X21]
    LD3 { V24.8H, V25.8H, V26.8H }, [X21]
    ADD  X21, X21, X4, ASR #0
    ST3 { V12.4H, V13.4H, V14.4H }, [X21]
    LD3 { V28.8B, V29.8B, V30.8B }, [X21]
    ADD  X21, X21, X4
    ST3 { V13.2S, V14.2S, V15.2S }, [X21]
    LD3 { V19.2S, V20.2S, V21.2S }, [X21]
    ADD  X21, X21, X4
    ST3 { V19.4H, V20.4H, V21.4H }, [X21]
    LD3 { V11.4H, V12.4H, V13.4H }, [X21]
    ADD  X21, X21, X4, ASR #0
    ST3 { V24.8B, V25.8B, V26.8B }, [X21]
    LD3 { V7.8B, V8.8B, V9.8B }, [X21]
    ADD  X21, X21, X4
    MOV  X12, X21
    ST3 { V11.4S, V12.4S, V13.4S }, [X12], #48
    MOV  X12, X21
    LD3 { V11.8H, V12.8H, V13.8H }, [X12], #48
    ADD  X21, X21, X4, LSR #0
    MOV  X12, X21
    ST3 { V28.16B, V29.16B, V30.16B }, [X12], #48
    MOV  X12, X21
    LD3 { V6.16B, V7.16B, V8.16B }, [X12], #48
    ADD  X21, X21, X4, ASR #0
    MOV  X12, X21
    ST3 { V6.2D, V7.2D, V8.2D }, [X12], #48
    MOV  X12, X21
    LD3 { V3.2D, V4.2D, V5.2D }, [X12], #48
    ADD  X21, X21, X4, LSR #0
    MOV  X12, X21
    ST3 { V11.4S, V12.4S, V13.4S }, [X12], #48
    MOV  X12, X21
    LD3 { V11.4S, V12.4S, V13.4S }, [X12], #48
    ADD  X21, X21, X4, LSR #0
    MOV  X12, X21
    ST3 { V3.8H, V4.8H, V5.8H }, [X12], #48
    MOV  X12, X21
    LD3 { V6.8H, V7.8H, V8.8H }, [X12], #48
    ADD  X21, X21, X4
    MOV  X12, X21
    ST3 { V11.8B, V12.8B, V13.8B }, [X12], #24
    MOV  X12, X21
    LD3 { V3.2S, V4.2S, V5.2S }, [X12], #24
    ADD  X21, X21, X4, LSR #0
    MOV  X12, X21
    ST3 { V6.2S, V7.2S, V8.2S }, [X12], #24
    MOV  X12, X21
    LD3 { V28.2S, V29.2S, V30.2S }, [X12], #24
    ADD  X21, X21, X4, ASR #0
    MOV  X12, X21
    ST3 { V6.4H, V7.4H, V8.4H }, [X12], #24
    MOV  X12, X21
    LD3 { V11.4H, V12.4H, V13.4H }, [X12], #24
    ADD  X21, X21, X4, ASR #0
    MOV  X12, X21
    ST3 { V28.8B, V29.8B, V30.8B }, [X12], #24
    MOV  X12, X21
    LD3 { V28.8B, V29.8B, V30.8B }, [X12], #24
    ADD  X21, X21, X4
    ST3 { V28.4S, V29.4S, V30.4S }, [X21], X5
    LD3 { V18.16B, V19.16B, V20.16B }, [X21], X5
    ADD  X21, X21, X4
    ST3 { V18.16B, V19.16B, V20.16B }, [X21], X5
    LD3 { V18.16B, V19.16B, V20.16B }, [X21], X5
    ADD  X21, X21, X4
    ST3 { V11.2D, V12.2D, V13.2D }, [X21], X5
    LD3 { V28.2D, V29.2D, V30.2D }, [X21], X5
    ADD  X21, X21, X4
    ST3 { V18.4S, V19.4S, V20.4S }, [X21], X5
    LD3 { V11.4S, V12.4S, V13.4S }, [X21], X5
    ADD  X21, X21, X4
    ST3 { V11.8H, V12.8H, V13.8H }, [X21], X5
    LD3 { V11.8H, V12.8H, V13.8H }, [X21], X5
    ADD  X21, X21, X4, ASR #0
    ST3 { V11.2S, V12.2S, V13.2S }, [X21], X5
    LD3 { V11.2S, V12.2S, V13.2S }, [X21], X5
    ADD  X21, X21, X4, ASR #0
    ST3 { V28.2S, V29.2S, V30.2S }, [X21], X5
    LD3 { V28.2S, V29.2S, V30.2S }, [X21], X5
    ADD  X21, X21, X4, ASR #0
    ST3 { V28.4H, V29.4H, V30.4H }, [X21], X5
    LD3 { V7.4H, V8.4H, V9.4H }, [X21], X5
    ADD  X21, X21, X4, LSR #0
    ST3 { V11.8B, V12.8B, V13.8B }, [X21], X5
    LD3 { V18.8B, V19.8B, V20.8B }, [X21], X5
    ADD  X21, X21, X4, ASR #0
    ST3 { V7.H, V8.H, V9.H }[0x4], [X21]
    LD3 { V11.H, V12.H, V13.H }[0x4], [X21]
    ADD  X21, X21, X4
    ST3 { V18.S, V19.S, V20.S }[0x1], [X21]
    LD3 { V7.S, V8.S, V9.S }[0x2], [X21]
    ADD  X21, X21, X4
    ST3 { V11.D, V12.D, V13.D }[0x1], [X21]
    LD3 { V18.D, V19.D, V20.D }[0x0], [X21]
    ADD  X21, X21, X4, LSR #0
    ST3 { V7.B, V8.B, V9.B }[0x2], [X21]
    LD3 { V11.B, V12.B, V13.B }[0xc], [X21]
    ADD  X21, X21, X4
    MOV  X12, X21
    ST3 { V18.H, V19.H, V20.H }[0x7], [X12], #6
    MOV  X12, X21
    LD3 { V18.H, V19.H, V20.H }[0x1], [X12], #6
    ADD  X21, X21, X4, ASR #0
    ST3 { V11.H, V12.H, V13.H }[0x6], [X21], X5
    LD3 { V11.H, V12.H, V13.H }[0x3], [X21], X5
    ADD  X21, X21, X4, ASR #0
    MOV  X12, X21
    ST3 { V11.S, V12.S, V13.S }[0x3], [X12], #12
    MOV  X12, X21
    LD3 { V11.S, V12.S, V13.S }[0x2], [X12], #12
    ADD  X21, X21, X4
    ST3 { V11.S, V12.S, V13.S }[0x2], [X21], X5
    LD3 { V25.S, V26.S, V27.S }[0x0], [X21], X5
    ADD  X21, X21, X4, ASR #0
    MOV  X12, X21
    ST3 { V18.D, V19.D, V20.D }[0x0], [X12], #24
    MOV  X12, X21
    LD3 { V11.D, V12.D, V13.D }[0x0], [X12], #24
    ADD  X21, X21, X4, LSR #0
    ST3 { V11.D, V12.D, V13.D }[0x0], [X21], X5
    LD3 { V11.D, V12.D, V13.D }[0x0], [X21], X5
    ADD  X21, X21, X4, ASR #0
    MOV  X12, X21
    ST3 { V25.B, V26.B, V27.B }[0x5], [X12], #3
    MOV  X12, X21
    LD3 { V18.B, V19.B, V20.B }[0x8], [X12], #3
    ADD  X21, X21, X4, LSR #0
    ST3 { V11.B, V12.B, V13.B }[0x6], [X21], X5
    LD3 { V11.B, V12.B, V13.B }[0xc], [X21], X5
    ADD  X21, X21, X4, ASR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X28, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V0.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D0
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V1.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D1
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V2.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D2
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D3
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D4
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V5.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D5
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V6.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D6
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X28, V7.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D7
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X28, V8.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D8
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    FMOV  X28, V9.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D9
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D10
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D11
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D12
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X28, V13.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D13
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V14.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D14
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V15.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D15
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D16
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X28, V18.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D18
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D19
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, D20
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V21.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D21
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D22
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D23
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D24
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5, LSL #0
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D25
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V26.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5, LSL #0
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D26
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V27.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5, LSL #0
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D27
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D28
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V29.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D29
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X28, V30.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D30
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X28, D31
    SUB  X14, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X26
    FMOV  V0.D[1], X22
    FMOV  D1, X25
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X29
    FMOV  V3.D[1], X14
    FMOV  D4, X28
    FMOV  V4.D[1], X5
    FMOV  D5, X23
    FMOV  V5.D[1], X16
    FMOV  D6, X10
    FMOV  V6.D[1], X8
    FMOV  D7, X2
    FMOV  V7.D[1], X19
    FMOV  D8, X8
    FMOV  V8.D[1], X7
    FMOV  D9, X22
    FMOV  V9.D[1], X7
    FMOV  D10, X19
    FMOV  V10.D[1], X27
    FMOV  D11, X22
    FMOV  V11.D[1], X11
    FMOV  D12, X26
    FMOV  V12.D[1], X2
    FMOV  D13, X10
    FMOV  V13.D[1], X21
    FMOV  D14, X27
    FMOV  V14.D[1], X13
    FMOV  D15, X5
    FMOV  V15.D[1], X3
    FMOV  D16, X3
    FMOV  V16.D[1], X2
    FMOV  D17, X28
    FMOV  V17.D[1], X11
    FMOV  D18, X26
    FMOV  V18.D[1], X2
    FMOV  D19, X21
    FMOV  V19.D[1], X9
    FMOV  D20, X4
    FMOV  V20.D[1], X23
    FMOV  D21, X9
    FMOV  V21.D[1], X27
    FMOV  D22, X16
    FMOV  V22.D[1], X28
    FMOV  D23, X14
    FMOV  V23.D[1], X27
    FMOV  D24, X2
    FMOV  V24.D[1], X8
    FMOV  D25, X4
    FMOV  V25.D[1], X9
    FMOV  D26, X12
    FMOV  V26.D[1], X25
    FMOV  D27, X7
    FMOV  V27.D[1], X28
    FMOV  D28, X19
    FMOV  V28.D[1], X16
    FMOV  D29, X11
    FMOV  V29.D[1], X19
    FMOV  D30, X10
    FMOV  V30.D[1], X26
    FMOV  D31, X13
    FMOV  V31.D[1], X4
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X23, #0x1400, LSL #0
    ADD  X20, X30, X23, ASR #0
    ST3 { V24.8H, V25.8H, V26.8H }, [X20]
    LD3 { V28.16B, V29.16B, V30.16B }, [X20]
    ADD  X20, X20, X19
    ST3 { V27.16B, V28.16B, V29.16B }, [X20]
    LD3 { V5.16B, V6.16B, V7.16B }, [X20]
    ADD  X20, X20, X19, ASR #0
    ST3 { V24.2D, V25.2D, V26.2D }, [X20]
    LD3 { V28.2D, V29.2D, V30.2D }, [X20]
    ADD  X20, X20, X19, ASR #0
    ST3 { V28.4S, V29.4S, V30.4S }, [X20]
    LD3 { V10.4S, V11.4S, V12.4S }, [X20]
    ADD  X20, X20, X19, ASR #0
    ST3 { V5.8H, V6.8H, V7.8H }, [X20]
    LD3 { V13.8H, V14.8H, V15.8H }, [X20]
    ADD  X20, X20, X19, LSR #0
    ST3 { V13.8B, V14.8B, V15.8B }, [X20]
    LD3 { V22.2S, V23.2S, V24.2S }, [X20]
    ADD  X20, X20, X19, LSR #0
    ST3 { V22.2S, V23.2S, V24.2S }, [X20]
    LD3 { V25.2S, V26.2S, V27.2S }, [X20]
    ADD  X20, X20, X19
    ST3 { V10.4H, V11.4H, V12.4H }, [X20]
    LD3 { V5.4H, V6.4H, V7.4H }, [X20]
    ADD  X20, X20, X19
    ST3 { V25.8B, V26.8B, V27.8B }, [X20]
    LD3 { V28.8B, V29.8B, V30.8B }, [X20]
    ADD  X20, X20, X19
    MOV  X2, X20
    ST3 { V28.2D, V29.2D, V30.2D }, [X2], #48
    MOV  X2, X20
    LD3 { V22.8H, V23.8H, V24.8H }, [X2], #48
    ADD  X20, X20, X19, ASR #0
    MOV  X2, X20
    ST3 { V5.16B, V6.16B, V7.16B }, [X2], #48
    MOV  X2, X20
    LD3 { V5.16B, V6.16B, V7.16B }, [X2], #48
    ADD  X20, X20, X19, ASR #0
    MOV  X2, X20
    ST3 { V5.2D, V6.2D, V7.2D }, [X2], #48
    MOV  X2, X20
    LD3 { V5.2D, V6.2D, V7.2D }, [X2], #48
    ADD  X20, X20, X19, ASR #0
    MOV  X2, X20
    ST3 { V5.4S, V6.4S, V7.4S }, [X2], #48
    MOV  X2, X20
    LD3 { V28.4S, V29.4S, V30.4S }, [X2], #48
    ADD  X20, X20, X19, LSR #0
    MOV  X2, X20
    ST3 { V22.8H, V23.8H, V24.8H }, [X2], #48
    MOV  X2, X20
    LD3 { V5.8H, V6.8H, V7.8H }, [X2], #48
    ADD  X20, X20, X19
    MOV  X2, X20
    ST3 { V19.2S, V20.2S, V21.2S }, [X2], #24
    MOV  X2, X20
    LD3 { V22.4H, V23.4H, V24.4H }, [X2], #24
    ADD  X20, X20, X19
    MOV  X2, X20
    ST3 { V22.2S, V23.2S, V24.2S }, [X2], #24
    MOV  X2, X20
    LD3 { V19.2S, V20.2S, V21.2S }, [X2], #24
    ADD  X20, X20, X19
    MOV  X2, X20
    ST3 { V19.4H, V20.4H, V21.4H }, [X2], #24
    MOV  X2, X20
    LD3 { V22.4H, V23.4H, V24.4H }, [X2], #24
    ADD  X20, X20, X19, LSR #0
    MOV  X2, X20
    ST3 { V22.8B, V23.8B, V24.8B }, [X2], #24
    MOV  X2, X20
    LD3 { V19.8B, V20.8B, V21.8B }, [X2], #24
    ADD  X20, X20, X19, ASR #0
    ST3 { V19.4S, V20.4S, V21.4S }, [X20], X12
    LD3 { V20.2D, V21.2D, V22.2D }, [X20], X12
    ADD  X20, X20, X19, LSR #0
    ST3 { V20.16B, V21.16B, V22.16B }, [X20], X12
    LD3 { V20.16B, V21.16B, V22.16B }, [X20], X12
    ADD  X20, X20, X19
    ST3 { V20.2D, V21.2D, V22.2D }, [X20], X12
    LD3 { V20.2D, V21.2D, V22.2D }, [X20], X12
    ADD  X20, X20, X19, ASR #0
    ST3 { V20.4S, V21.4S, V22.4S }, [X20], X12
    LD3 { V20.4S, V21.4S, V22.4S }, [X20], X12
    ADD  X20, X20, X19, ASR #0
    ST3 { V20.8H, V21.8H, V22.8H }, [X20], X12
    LD3 { V20.8H, V21.8H, V22.8H }, [X20], X12
    ADD  X20, X20, X19, LSR #0
    ST3 { V15.2S, V16.2S, V17.2S }, [X20], X12
    LD3 { V15.8B, V16.8B, V17.8B }, [X20], X12
    ADD  X20, X20, X19
    ST3 { V29.2S, V30.2S, V31.2S }, [X20], X12
    LD3 { V29.2S, V30.2S, V31.2S }, [X20], X12
    ADD  X20, X20, X19, ASR #0
    ST3 { V20.4H, V21.4H, V22.4H }, [X20], X12
    LD3 { V20.4H, V21.4H, V22.4H }, [X20], X12
    ADD  X20, X20, X19, ASR #0
    ST3 { V29.8B, V30.8B, V31.8B }, [X20], X12
    LD3 { V29.8B, V30.8B, V31.8B }, [X20], X12
    ADD  X20, X20, X19, LSR #0
    ST3 { V6.H, V7.H, V8.H }[0x0], [X20]
    LD3 { V6.H, V7.H, V8.H }[0x5], [X20]
    ADD  X20, X20, X19, LSR #0
    ST3 { V26.S, V27.S, V28.S }[0x1], [X20]
    LD3 { V27.S, V28.S, V29.S }[0x2], [X20]
    ADD  X20, X20, X19, ASR #0
    ST3 { V20.D, V21.D, V22.D }[0x0], [X20]
    LD3 { V16.D, V17.D, V18.D }[0x1], [X20]
    ADD  X20, X20, X19, ASR #0
    ST3 { V7.B, V8.B, V9.B }[0x2], [X20]
    LD3 { V16.B, V17.B, V18.B }[0xb], [X20]
    ADD  X20, X20, X19, ASR #0
    MOV  X2, X20
    ST3 { V16.H, V17.H, V18.H }[0x6], [X2], #6
    MOV  X2, X20
    LD3 { V27.H, V28.H, V29.H }[0x3], [X2], #6
    ADD  X20, X20, X19, ASR #0
    ST3 { V28.H, V29.H, V30.H }[0x2], [X20], X12
    LD3 { V16.H, V17.H, V18.H }[0x2], [X20], X12
    ADD  X20, X20, X19, ASR #0
    MOV  X2, X20
    ST3 { V16.S, V17.S, V18.S }[0x2], [X2], #12
    MOV  X2, X20
    LD3 { V21.S, V22.S, V23.S }[0x3], [X2], #12
    ADD  X20, X20, X19, LSR #0
    ST3 { V21.S, V22.S, V23.S }[0x0], [X20], X12
    LD3 { V26.S, V27.S, V28.S }[0x1], [X20], X12
    ADD  X20, X20, X19, ASR #0
    MOV  X2, X20
    ST3 { V26.D, V27.D, V28.D }[0x1], [X2], #24
    MOV  X2, X20
    LD3 { V27.D, V28.D, V29.D }[0x1], [X2], #24
    ADD  X20, X20, X19, ASR #0
    ST3 { V2.D, V3.D, V4.D }[0x0], [X20], X12
    LD3 { V21.D, V22.D, V23.D }[0x1], [X20], X12
    ADD  X20, X20, X19
    MOV  X2, X20
    ST3 { V12.B, V13.B, V14.B }[0x5], [X2], #3
    MOV  X2, X20
    LD3 { V16.B, V17.B, V18.B }[0x2], [X2], #3
    ADD  X20, X20, X19, LSR #0
    ST3 { V27.B, V28.B, V29.B }[0x2], [X20], X12
    LD3 { V2.B, V3.B, V4.B }[0xe], [X20], X12
    ADD  X20, X20, X19, LSR #0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X27
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X13, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    MRS  X13, FPSR
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V0.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D0
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V1.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D1
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V2.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D2
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V3.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D3
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V4.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D4
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V5.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D5
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    FMOV  X13, V6.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D6
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    FMOV  X13, V7.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D7
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V8.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D8
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V9.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D9
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V10.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D10
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V11.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D11
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V12.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D12
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V13.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D13
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V14.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D14
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V15.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D15
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V16.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D16
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V17.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D17
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V18.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D18
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V19.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D19
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V20.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D20
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V21.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D21
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V22.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D22
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, V23.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D23
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V24.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D24
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V25.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D25
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V26.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D26
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V27.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D27
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    FMOV  X13, V28.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D28
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    FMOV  X13, V29.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D29
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V30.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D30
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x0, LSL #0
    FMOV  X13, V31.D[1]
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    FMOV  X13, D31
    SUB  X8, X21, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X17
    FMOV  D3, X29
    FMOV  V3.D[1], X21
    FMOV  D4, X8
    FMOV  V4.D[1], X21
    FMOV  D5, X17
    FMOV  V5.D[1], X13
    FMOV  D6, X14
    FMOV  V6.D[1], X13
    FMOV  D7, X23
    FMOV  V7.D[1], X3
    FMOV  D8, X26
    FMOV  V8.D[1], X21
    FMOV  D9, X26
    FMOV  V9.D[1], X2
    FMOV  D10, X10
    FMOV  V10.D[1], X20
    FMOV  D11, X10
    FMOV  V11.D[1], X26
    FMOV  D12, X13
    FMOV  V12.D[1], X28
    FMOV  D13, X10
    FMOV  V13.D[1], X3
    FMOV  D14, X26
    FMOV  V14.D[1], X22
    FMOV  D15, X27
    FMOV  V15.D[1], X16
    FMOV  D16, X14
    FMOV  V16.D[1], X23
    FMOV  D17, X27
    FMOV  V17.D[1], X16
    FMOV  D18, X9
    FMOV  V18.D[1], X25
    FMOV  D19, X29
    FMOV  V19.D[1], X10
    FMOV  D20, X8
    FMOV  V20.D[1], X19
    FMOV  D21, X26
    FMOV  V21.D[1], X13
    FMOV  D22, X9
    FMOV  V22.D[1], X8
    FMOV  D23, X7
    FMOV  V23.D[1], X5
    FMOV  D24, X9
    FMOV  V24.D[1], X14
    FMOV  D25, X12
    FMOV  V25.D[1], X9
    FMOV  D26, X16
    FMOV  V26.D[1], X2
    FMOV  D27, X16
    FMOV  V27.D[1], X21
    FMOV  D28, X22
    FMOV  V28.D[1], X16
    FMOV  D29, X8
    FMOV  V29.D[1], X10
    FMOV  D30, X20
    FMOV  V30.D[1], X14
    FMOV  D31, X16
    FMOV  V31.D[1], X19
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X21, #0x1900, LSL #0
    ADD  X10, X30, X21, ASR #0
    ST3 { V29.16B, V30.16B, V31.16B }, [X10]
    LD3 { V12.2D, V13.2D, V14.2D }, [X10]
    ADD  X10, X10, X19
    ST3 { V25.16B, V26.16B, V27.16B }, [X10]
    LD3 { V2.16B, V3.16B, V4.16B }, [X10]
    ADD  X10, X10, X19, LSR #0
    ST3 { V30.2D, V31.2D, V0.2D }, [X10]
    LD3 { V9.2D, V10.2D, V11.2D }, [X10]
    ADD  X10, X10, X19, LSR #0
    ST3 { V12.4S, V13.4S, V14.4S }, [X10]
    LD3 { V1.4S, V2.4S, V3.4S }, [X10]
    ADD  X10, X10, X19
    ST3 { V1.8H, V2.8H, V3.8H }, [X10]
    LD3 { V9.8H, V10.8H, V11.8H }, [X10]
    ADD  X10, X10, X19
    ST3 { V9.8B, V10.8B, V11.8B }, [X10]
    LD3 { V12.8B, V13.8B, V14.8B }, [X10]
    ADD  X10, X10, X19, ASR #0
    ST3 { V12.2S, V13.2S, V14.2S }, [X10]
    LD3 { V7.2S, V8.2S, V9.2S }, [X10]
    ADD  X10, X10, X19, LSR #0
    ST3 { V7.4H, V8.4H, V9.4H }, [X10]
    LD3 { V1.4H, V2.4H, V3.4H }, [X10]
    ADD  X10, X10, X19
    ST3 { V0.8B, V1.8B, V2.8B }, [X10]
    LD3 { V7.8B, V8.8B, V9.8B }, [X10]
    ADD  X10, X10, X19, LSR #0
    MOV  X2, X10
    ST3 { V0.8H, V1.8H, V2.8H }, [X2], #48
    MOV  X2, X10
    LD3 { V0.8H, V1.8H, V2.8H }, [X2], #48
    ADD  X10, X10, X19
    MOV  X2, X10
    ST3 { V22.16B, V23.16B, V24.16B }, [X2], #48
    MOV  X2, X10
    LD3 { V12.16B, V13.16B, V14.16B }, [X2], #48
    ADD  X10, X10, X19, LSR #0
    MOV  X2, X10
    ST3 { V7.2D, V8.2D, V9.2D }, [X2], #48
    MOV  X2, X10
    LD3 { V22.2D, V23.2D, V24.2D }, [X2], #48
    ADD  X10, X10, X19, ASR #0
    MOV  X2, X10
    ST3 { V27.4S, V28.4S, V29.4S }, [X2], #48
    MOV  X2, X10
    LD3 { V27.4S, V28.4S, V29.4S }, [X2], #48
    ADD  X10, X10, X19, LSR #0
    MOV  X2, X10
    ST3 { V27.8H, V28.8H, V29.8H }, [X2], #48
    MOV  X2, X10
    LD3 { V27.8H, V28.8H, V29.8H }, [X2], #48
    ADD  X10, X10, X19
    MOV  X2, X10
    ST3 { V22.4H, V23.4H, V24.4H }, [X2], #24
    MOV  X2, X10
    LD3 { V7.8B, V8.8B, V9.8B }, [X2], #24
    ADD  X10, X10, X19, ASR #0
    MOV  X2, X10
    ST3 { V7.2S, V8.2S, V9.2S }, [X2], #24
    MOV  X2, X10
    LD3 { V7.2S, V8.2S, V9.2S }, [X2], #24
    ADD  X10, X10, X19, ASR #0
    MOV  X2, X10
    ST3 { V7.4H, V8.4H, V9.4H }, [X2], #24
    MOV  X2, X10
    LD3 { V22.4H, V23.4H, V24.4H }, [X2], #24
    ADD  X10, X10, X19, ASR #0
    MOV  X2, X10
    ST3 { V22.8B, V23.8B, V24.8B }, [X2], #24
    MOV  X2, X10
    LD3 { V7.8B, V8.8B, V9.8B }, [X2], #24
    ADD  X10, X10, X19, ASR #0
    ST3 { V7.2D, V8.2D, V9.2D }, [X10], X5
    LD3 { V7.4S, V8.4S, V9.4S }, [X10], X5
    ADD  X10, X10, X19
    ST3 { V7.16B, V8.16B, V9.16B }, [X10], X5
    LD3 { V22.16B, V23.16B, V24.16B }, [X10], X5
    ADD  X10, X10, X19, ASR #0
    ST3 { V22.2D, V23.2D, V24.2D }, [X10], X5
    LD3 { V22.2D, V23.2D, V24.2D }, [X10], X5
    ADD  X10, X10, X19, LSR #0
    ST3 { V22.4S, V23.4S, V24.4S }, [X10], X5
    LD3 { V7.4S, V8.4S, V9.4S }, [X10], X5
    ADD  X10, X10, X19
    ST3 { V7.8H, V8.8H, V9.8H }, [X10], X5
    LD3 { V7.8H, V8.8H, V9.8H }, [X10], X5
    ADD  X10, X10, X19, ASR #0
    ST3 { V28.4H, V29.4H, V30.4H }, [X10], X5
    LD3 { V6.4H, V7.4H, V8.4H }, [X10], X5
    ADD  X10, X10, X19, ASR #0
    ST3 { V15.2S, V16.2S, V17.2S }, [X10], X5
    LD3 { V15.2S, V16.2S, V17.2S }, [X10], X5
    ADD  X10, X10, X19, ASR #0
    ST3 { V22.4H, V23.4H, V24.4H }, [X10], X5
    LD3 { V22.4H, V23.4H, V24.4H }, [X10], X5
    ADD  X10, X10, X19, LSR #0
    ST3 { V6.8B, V7.8B, V8.8B }, [X10], X5
    LD3 { V28.8B, V29.8B, V30.8B }, [X10], X5
    ADD  X10, X10, X19, ASR #0
    ST3 { V2.H, V3.H, V4.H }[0x0], [X10]
    LD3 { V2.H, V3.H, V4.H }[0x1], [X10]
    ADD  X10, X10, X19, ASR #0
    ST3 { V2.S, V3.S, V4.S }[0x3], [X10]
    LD3 { V2.S, V3.S, V4.S }[0x0], [X10]
    ADD  X10, X10, X19, LSR #0
    ST3 { V2.D, V3.D, V4.D }[0x0], [X10]
    LD3 { V2.D, V3.D, V4.D }[0x0], [X10]
    ADD  X10, X10, X19, ASR #0
    ST3 { V2.B, V3.B, V4.B }[0x4], [X10]
    LD3 { V2.B, V3.B, V4.B }[0x2], [X10]
    ADD  X10, X10, X19
    MOV  X2, X10
    ST3 { V28.H, V29.H, V30.H }[0x0], [X2], #6
    MOV  X2, X10
    LD3 { V28.H, V29.H, V30.H }[0x1], [X2], #6
    ADD  X10, X10, X19, ASR #0
    ST3 { V2.H, V3.H, V4.H }[0x1], [X10], X5
    LD3 { V2.H, V3.H, V4.H }[0x3], [X10], X5
    ADD  X10, X10, X19, LSR #0
    MOV  X2, X10
    ST3 { V28.S, V29.S, V30.S }[0x1], [X2], #12
    MOV  X2, X10
    LD3 { V28.S, V29.S, V30.S }[0x2], [X2], #12
    ADD  X10, X10, X19, ASR #0
    ST3 { V28.S, V29.S, V30.S }[0x2], [X10], X5
    LD3 { V28.S, V29.S, V30.S }[0x2], [X10], X5
    ADD  X10, X10, X19
    MOV  X2, X10
    ST3 { V28.D, V29.D, V30.D }[0x1], [X2], #24
    MOV  X2, X10
    LD3 { V28.D, V29.D, V30.D }[0x0], [X2], #24
    ADD  X10, X10, X19
    ST3 { V28.D, V29.D, V30.D }[0x0], [X10], X5
    LD3 { V30.D, V31.D, V0.D }[0x1], [X10], X5
    ADD  X10, X10, X19
    MOV  X2, X10
    ST3 { V2.B, V3.B, V4.B }[0xf], [X2], #3
    MOV  X2, X10
    LD3 { V6.B, V7.B, V8.B }[0x4], [X2], #3
    ADD  X10, X10, X19, LSR #0
    ST3 { V6.B, V7.B, V8.B }[0x4], [X10], X5
    LD3 { V25.B, V26.B, V27.B }[0x0], [X10], X5
    ADD  X10, X10, X19, LSR #0
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X27, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X27, FPSR
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X27, V0.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D0
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V1.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D1
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V2.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xa5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5, LSL #48
    FMOV  X27, D2
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V3.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    MOVK  X7, #0xa5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5, LSL #48
    FMOV  X27, D3
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V4.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D4
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V5.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D5
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V6.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa500, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D6
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V7.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa500, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D7
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V8.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D8
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V9.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D9
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V10.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D10
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V11.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D11
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V12.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D12
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V13.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D13
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V14.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D14
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V15.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D15
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V16.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D16
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V17.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D17
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V18.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D18
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V19.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D19
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V20.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D20
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V21.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D21
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V22.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D22
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V23.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D23
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X27, V24.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D24
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V25.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa500, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D25
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V26.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa500, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D26
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, V27.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D27
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X27, V28.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X27, D28
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X27, V29.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X27, D29
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X27, V30.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X27, D30
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    FMOV  X27, V31.D[1]
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    FMOV  X27, D31
    SUB  X12, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X3
    FMOV  D3, X21
    FMOV  V3.D[1], X25
    FMOV  D4, X11
    FMOV  V4.D[1], X22
    FMOV  D5, X7
    FMOV  V5.D[1], X28
    FMOV  D6, X16
    FMOV  V6.D[1], X16
    FMOV  D7, X17
    FMOV  V7.D[1], X23
    FMOV  D8, X4
    FMOV  V8.D[1], X2
    FMOV  D9, X22
    FMOV  V9.D[1], X20
    FMOV  D10, X27
    FMOV  V10.D[1], X23
    FMOV  D11, X28
    FMOV  V11.D[1], X25
    FMOV  D12, X21
    FMOV  V12.D[1], X20
    FMOV  D13, X23
    FMOV  V13.D[1], X13
    FMOV  D14, X14
    FMOV  V14.D[1], X26
    FMOV  D15, X22
    FMOV  V15.D[1], X29
    FMOV  D16, X21
    FMOV  V16.D[1], X5
    FMOV  D17, X2
    FMOV  V17.D[1], X17
    FMOV  D18, X10
    FMOV  V18.D[1], X5
    FMOV  D19, X21
    FMOV  V19.D[1], X12
    FMOV  D20, X13
    FMOV  V20.D[1], X27
    FMOV  D21, X12
    FMOV  V21.D[1], X7
    FMOV  D22, X26
    FMOV  V22.D[1], X20
    FMOV  D23, X16
    FMOV  V23.D[1], X12
    FMOV  D24, X13
    FMOV  V24.D[1], X14
    FMOV  D25, X13
    FMOV  V25.D[1], X29
    FMOV  D26, X25
    FMOV  V26.D[1], X26
    FMOV  D27, X12
    FMOV  V27.D[1], X26
    FMOV  D28, X14
    FMOV  V28.D[1], X13
    FMOV  D29, X19
    FMOV  V29.D[1], X12
    FMOV  D30, X10
    FMOV  V30.D[1], X12
    FMOV  D31, X13
    FMOV  V31.D[1], X28
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X17, #0x1e00, LSL #0
    ADD  X10, X30, X17
    ST3 { V30.16B, V31.16B, V0.16B }, [X10]
    LD3 { V2.4S, V3.4S, V4.4S }, [X10]
    ADD  X10, X10, X13, LSR #0
    ST3 { V26.16B, V27.16B, V28.16B }, [X10]
    LD3 { V26.16B, V27.16B, V28.16B }, [X10]
    ADD  X10, X10, X13, ASR #0
    ST3 { V6.2D, V7.2D, V8.2D }, [X10]
    LD3 { V21.2D, V22.2D, V23.2D }, [X10]
    ADD  X10, X10, X13, ASR #0
    ST3 { V21.4S, V22.4S, V23.4S }, [X10]
    LD3 { V25.4S, V26.4S, V27.4S }, [X10]
    ADD  X10, X10, X13, LSR #0
    ST3 { V18.8H, V19.8H, V20.8H }, [X10]
    LD3 { V30.8H, V31.8H, V0.8H }, [X10]
    ADD  X10, X10, X13
    ST3 { V30.4H, V31.4H, V0.4H }, [X10]
    LD3 { V1.8B, V2.8B, V3.8B }, [X10]
    ADD  X10, X10, X13, LSR #0
    ST3 { V2.2S, V3.2S, V4.2S }, [X10]
    LD3 { V19.2S, V20.2S, V21.2S }, [X10]
    ADD  X10, X10, X13, LSR #0
    ST3 { V11.4H, V12.4H, V13.4H }, [X10]
    LD3 { V21.4H, V22.4H, V23.4H }, [X10]
    ADD  X10, X10, X13, ASR #0
    ST3 { V25.8B, V26.8B, V27.8B }, [X10]
    LD3 { V2.8B, V3.8B, V4.8B }, [X10]
    ADD  X10, X10, X13, LSR #0
    MOV  X8, X10
    ST3 { V19.4S, V20.4S, V21.4S }, [X8], #48
    MOV  X8, X10
    LD3 { V25.2D, V26.2D, V27.2D }, [X8], #48
    ADD  X10, X10, X13, LSR #0
    MOV  X8, X10
    ST3 { V25.16B, V26.16B, V27.16B }, [X8], #48
    MOV  X8, X10
    LD3 { V19.16B, V20.16B, V21.16B }, [X8], #48
    ADD  X10, X10, X13
    MOV  X8, X10
    ST3 { V19.2D, V20.2D, V21.2D }, [X8], #48
    MOV  X8, X10
    LD3 { V25.2D, V26.2D, V27.2D }, [X8], #48
    ADD  X10, X10, X13, LSR #0
    MOV  X8, X10
    ST3 { V25.4S, V26.4S, V27.4S }, [X8], #48
    MOV  X8, X10
    LD3 { V25.4S, V26.4S, V27.4S }, [X8], #48
    ADD  X10, X10, X13
    MOV  X8, X10
    ST3 { V25.8H, V26.8H, V27.8H }, [X8], #48
    MOV  X8, X10
    LD3 { V25.8H, V26.8H, V27.8H }, [X8], #48
    ADD  X10, X10, X13
    MOV  X8, X10
    ST3 { V25.2S, V26.2S, V27.2S }, [X8], #24
    MOV  X8, X10
    LD3 { V19.2S, V20.2S, V21.2S }, [X8], #24
    ADD  X10, X10, X13, ASR #0
    MOV  X8, X10
    ST3 { V19.2S, V20.2S, V21.2S }, [X8], #24
    MOV  X8, X10
    LD3 { V25.2S, V26.2S, V27.2S }, [X8], #24
    ADD  X10, X10, X13, ASR #0
    MOV  X8, X10
    ST3 { V26.4H, V27.4H, V28.4H }, [X8], #24
    MOV  X8, X10
    LD3 { V19.4H, V20.4H, V21.4H }, [X8], #24
    ADD  X10, X10, X13, ASR #0
    MOV  X8, X10
    ST3 { V21.8B, V22.8B, V23.8B }, [X8], #24
    MOV  X8, X10
    LD3 { V26.8B, V27.8B, V28.8B }, [X8], #24
    ADD  X10, X10, X13, ASR #0
    ST3 { V27.8H, V28.8H, V29.8H }, [X10], X23
    LD3 { V27.16B, V28.16B, V29.16B }, [X10], X23
    ADD  X10, X10, X13, LSR #0
    ST3 { V10.16B, V11.16B, V12.16B }, [X10], X23
    LD3 { V10.16B, V11.16B, V12.16B }, [X10], X23
    ADD  X10, X10, X13, LSR #0
    ST3 { V25.2D, V26.2D, V27.2D }, [X10], X23
    LD3 { V21.2D, V22.2D, V23.2D }, [X10], X23
    ADD  X10, X10, X13, ASR #0
    ST3 { V10.4S, V11.4S, V12.4S }, [X10], X23
    LD3 { V10.4S, V11.4S, V12.4S }, [X10], X23
    ADD  X10, X10, X13, LSR #0
    ST3 { V21.8H, V22.8H, V23.8H }, [X10], X23
    LD3 { V17.8H, V18.8H, V19.8H }, [X10], X23
    ADD  X10, X10, X13
    ST3 { V17.2S, V18.2S, V19.2S }, [X10], X23
    LD3 { V17.8B, V18.8B, V19.8B }, [X10], X23
    ADD  X10, X10, X13, ASR #0
    ST3 { V10.2S, V11.2S, V12.2S }, [X10], X23
    LD3 { V10.2S, V11.2S, V12.2S }, [X10], X23
    ADD  X10, X10, X13, LSR #0
    ST3 { V17.4H, V18.4H, V19.4H }, [X10], X23
    LD3 { V17.4H, V18.4H, V19.4H }, [X10], X23
    ADD  X10, X10, X13
    ST3 { V10.8B, V11.8B, V12.8B }, [X10], X23
    LD3 { V21.8B, V22.8B, V23.8B }, [X10], X23
    ADD  X10, X10, X13, LSR #0
    ST3 { V17.H, V18.H, V19.H }[0x2], [X10]
    LD3 { V17.H, V18.H, V19.H }[0x7], [X10]
    ADD  X10, X10, X13, ASR #0
    ST3 { V24.S, V25.S, V26.S }[0x3], [X10]
    LD3 { V27.S, V28.S, V29.S }[0x2], [X10]
    ADD  X10, X10, X13
    ST3 { V27.D, V28.D, V29.D }[0x1], [X10]
    LD3 { V27.D, V28.D, V29.D }[0x1], [X10]
    ADD  X10, X10, X13
    ST3 { V27.B, V28.B, V29.B }[0xd], [X10]
    LD3 { V27.B, V28.B, V29.B }[0xe], [X10]
    ADD  X10, X10, X13, ASR #0
    MOV  X8, X10
    ST3 { V27.H, V28.H, V29.H }[0x6], [X8], #6
    MOV  X8, X10
    LD3 { V26.H, V27.H, V28.H }[0x4], [X8], #6
    ADD  X10, X10, X13, LSR #0
    ST3 { V26.H, V27.H, V28.H }[0x0], [X10], X23
    LD3 { V25.H, V26.H, V27.H }[0x1], [X10], X23
    ADD  X10, X10, X13
    MOV  X8, X10
    ST3 { V25.S, V26.S, V27.S }[0x2], [X8], #12
    MOV  X8, X10
    LD3 { V24.S, V25.S, V26.S }[0x3], [X8], #12
    ADD  X10, X10, X13, ASR #0
    ST3 { V24.S, V25.S, V26.S }[0x1], [X10], X23
    LD3 { V16.S, V17.S, V18.S }[0x0], [X10], X23
    ADD  X10, X10, X13, LSR #0
    MOV  X8, X10
    ST3 { V16.D, V17.D, V18.D }[0x1], [X8], #24
    MOV  X8, X10
    LD3 { V19.D, V20.D, V21.D }[0x1], [X8], #24
    ADD  X10, X10, X13
    ST3 { V31.D, V0.D, V1.D }[0x0], [X10], X23
    LD3 { V31.D, V0.D, V1.D }[0x1], [X10], X23
    ADD  X10, X10, X13, ASR #0
    MOV  X8, X10
    ST3 { V2.B, V3.B, V4.B }[0x3], [X8], #3
    MOV  X8, X10
    LD3 { V16.B, V17.B, V18.B }[0x5], [X8], #3
    ADD  X10, X10, X13, LSR #0
    ST3 { V29.B, V30.B, V31.B }[0x2], [X10], X23
    LD3 { V29.B, V30.B, V31.B }[0x0], [X10], X23
    ADD  X10, X10, X13, ASR #0
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X19, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V0.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D0
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V1.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D1
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X19, V2.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D2
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X19, V3.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D3
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X19, V4.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D4
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V5.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D5
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D6
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V7.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D7
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V8.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D8
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V9.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D9
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D10
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X19, V11.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D11
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X19, V12.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D12
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V13.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D13
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D14
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V15.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D15
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V16.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D16
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V17.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D17
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V18.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D18
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V19.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D19
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V20.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D20
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V21.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D21
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X19, V22.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D22
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X19, V23.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D23
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    FMOV  X19, V24.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D24
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    FMOV  X19, V25.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D25
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x5a00, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V26.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D26
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a00, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    FMOV  X19, V27.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D27
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a00, LSL #0
    MOVK  X4, #0x5a00, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V28.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D28
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x0, LSL #0
    MOVK  X4, #0x5a00, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V29.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D29
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V30.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D30
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, V31.D[1]
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    FMOV  X19, D31
    SUB  X26, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X26
    FMOV  D1, X25
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X5
    FMOV  V3.D[1], X8
    FMOV  D4, X17
    FMOV  V4.D[1], X4
    FMOV  D5, X17
    FMOV  V5.D[1], X28
    FMOV  D6, X12
    FMOV  V6.D[1], X12
    FMOV  D7, X3
    FMOV  V7.D[1], X26
    FMOV  D8, X8
    FMOV  V8.D[1], X27
    FMOV  D9, X3
    FMOV  V9.D[1], X20
    FMOV  D10, X29
    FMOV  V10.D[1], X21
    FMOV  D11, X9
    FMOV  V11.D[1], X8
    FMOV  D12, X11
    FMOV  V12.D[1], X13
    FMOV  D13, X4
    FMOV  V13.D[1], X11
    FMOV  D14, X28
    FMOV  V14.D[1], X10
    FMOV  D15, X29
    FMOV  V15.D[1], X20
    FMOV  D16, X14
    FMOV  V16.D[1], X5
    FMOV  D17, X9
    FMOV  V17.D[1], X21
    FMOV  D18, X17
    FMOV  V18.D[1], X25
    FMOV  D19, X21
    FMOV  V19.D[1], X16
    FMOV  D20, X9
    FMOV  V20.D[1], X21
    FMOV  D21, X14
    FMOV  V21.D[1], X17
    FMOV  D22, X27
    FMOV  V22.D[1], X13
    FMOV  D23, X10
    FMOV  V23.D[1], X14
    FMOV  D24, X29
    FMOV  V24.D[1], X12
    FMOV  D25, X29
    FMOV  V25.D[1], X16
    FMOV  D26, X25
    FMOV  V26.D[1], X5
    FMOV  D27, X17
    FMOV  V27.D[1], X17
    FMOV  D28, X17
    FMOV  V28.D[1], X2
    FMOV  D29, X14
    FMOV  V29.D[1], X19
    FMOV  D30, X26
    FMOV  V30.D[1], X7
    FMOV  D31, X12
    FMOV  V31.D[1], X20
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X13, #0x2300, LSL #0
    ADD  X20, X30, X13, LSR #0
    ST3 { V29.4S, V30.4S, V31.4S }, [X20]
    LD3 { V15.8H, V16.8H, V17.8H }, [X20]
    ADD  X20, X20, X25, LSR #0
    ST3 { V0.16B, V1.16B, V2.16B }, [X20]
    LD3 { V18.16B, V19.16B, V20.16B }, [X20]
    ADD  X20, X20, X25
    ST3 { V18.2D, V19.2D, V20.2D }, [X20]
    LD3 { V0.2D, V1.2D, V2.2D }, [X20]
    ADD  X20, X20, X25, LSR #0
    ST3 { V0.4S, V1.4S, V2.4S }, [X20]
    LD3 { V9.4S, V10.4S, V11.4S }, [X20]
    ADD  X20, X20, X25, LSR #0
    ST3 { V15.8H, V16.8H, V17.8H }, [X20]
    LD3 { V21.8H, V22.8H, V23.8H }, [X20]
    ADD  X20, X20, X25
    ST3 { V25.4H, V26.4H, V27.4H }, [X20]
    LD3 { V18.2S, V19.2S, V20.2S }, [X20]
    ADD  X20, X20, X25, ASR #0
    ST3 { V19.2S, V20.2S, V21.2S }, [X20]
    LD3 { V15.2S, V16.2S, V17.2S }, [X20]
    ADD  X20, X20, X25, LSR #0
    ST3 { V5.4H, V6.4H, V7.4H }, [X20]
    LD3 { V0.4H, V1.4H, V2.4H }, [X20]
    ADD  X20, X20, X25, ASR #0
    ST3 { V24.8B, V25.8B, V26.8B }, [X20]
    LD3 { V5.8B, V6.8B, V7.8B }, [X20]
    ADD  X20, X20, X25, ASR #0
    MOV  X17, X20
    ST3 { V4.16B, V5.16B, V6.16B }, [X17], #48
    MOV  X17, X20
    LD3 { V24.2D, V25.2D, V26.2D }, [X17], #48
    ADD  X20, X20, X25, LSR #0
    MOV  X17, X20
    ST3 { V24.16B, V25.16B, V26.16B }, [X17], #48
    MOV  X17, X20
    LD3 { V24.16B, V25.16B, V26.16B }, [X17], #48
    ADD  X20, X20, X25
    MOV  X17, X20
    ST3 { V0.2D, V1.2D, V2.2D }, [X17], #48
    MOV  X17, X20
    LD3 { V4.2D, V5.2D, V6.2D }, [X17], #48
    ADD  X20, X20, X25, LSR #0
    MOV  X17, X20
    ST3 { V4.4S, V5.4S, V6.4S }, [X17], #48
    MOV  X17, X20
    LD3 { V0.4S, V1.4S, V2.4S }, [X17], #48
    ADD  X20, X20, X25, ASR #0
    MOV  X17, X20
    ST3 { V24.8H, V25.8H, V26.8H }, [X17], #48
    MOV  X17, X20
    LD3 { V4.8H, V5.8H, V6.8H }, [X17], #48
    ADD  X20, X20, X25, ASR #0
    MOV  X17, X20
    ST3 { V0.2S, V1.2S, V2.2S }, [X17], #24
    MOV  X17, X20
    LD3 { V24.8B, V25.8B, V26.8B }, [X17], #24
    ADD  X20, X20, X25, ASR #0
    MOV  X17, X20
    ST3 { V24.2S, V25.2S, V26.2S }, [X17], #24
    MOV  X17, X20
    LD3 { V24.2S, V25.2S, V26.2S }, [X17], #24
    ADD  X20, X20, X25, LSR #0
    MOV  X17, X20
    ST3 { V24.4H, V25.4H, V26.4H }, [X17], #24
    MOV  X17, X20
    LD3 { V24.4H, V25.4H, V26.4H }, [X17], #24
    ADD  X20, X20, X25
    MOV  X17, X20
    ST3 { V24.8B, V25.8B, V26.8B }, [X17], #24
    MOV  X17, X20
    LD3 { V24.8B, V25.8B, V26.8B }, [X17], #24
    ADD  X20, X20, X25, LSR #0
    ST3 { V4.8H, V5.8H, V6.8H }, [X20], X11
    LD3 { V0.2D, V1.2D, V2.2D }, [X20], X11
    ADD  X20, X20, X25, LSR #0
    ST3 { V0.16B, V1.16B, V2.16B }, [X20], X11
    LD3 { V12.16B, V13.16B, V14.16B }, [X20], X11
    ADD  X20, X20, X25, ASR #0
    ST3 { V24.2D, V25.2D, V26.2D }, [X20], X11
    LD3 { V24.2D, V25.2D, V26.2D }, [X20], X11
    ADD  X20, X20, X25, LSR #0
    ST3 { V17.4S, V18.4S, V19.4S }, [X20], X11
    LD3 { V17.4S, V18.4S, V19.4S }, [X20], X11
    ADD  X20, X20, X25, LSR #0
    ST3 { V29.8H, V30.8H, V31.8H }, [X20], X11
    LD3 { V30.8H, V31.8H, V0.8H }, [X20], X11
    ADD  X20, X20, X25
    ST3 { V12.4H, V13.4H, V14.4H }, [X20], X11
    LD3 { V21.4H, V22.4H, V23.4H }, [X20], X11
    ADD  X20, X20, X25
    ST3 { V24.2S, V25.2S, V26.2S }, [X20], X11
    LD3 { V2.2S, V3.2S, V4.2S }, [X20], X11
    ADD  X20, X20, X25, LSR #0
    ST3 { V30.4H, V31.4H, V0.4H }, [X20], X11
    LD3 { V24.4H, V25.4H, V26.4H }, [X20], X11
    ADD  X20, X20, X25
    ST3 { V17.8B, V18.8B, V19.8B }, [X20], X11
    LD3 { V30.8B, V31.8B, V0.8B }, [X20], X11
    ADD  X20, X20, X25, ASR #0
    ST3 { V30.H, V31.H, V0.H }[0x0], [X20]
    LD3 { V17.H, V18.H, V19.H }[0x2], [X20]
    ADD  X20, X20, X25, ASR #0
    ST3 { V25.S, V26.S, V27.S }[0x3], [X20]
    LD3 { V25.S, V26.S, V27.S }[0x2], [X20]
    ADD  X20, X20, X25, ASR #0
    ST3 { V21.D, V22.D, V23.D }[0x1], [X20]
    LD3 { V12.D, V13.D, V14.D }[0x0], [X20]
    ADD  X20, X20, X25
    ST3 { V12.B, V13.B, V14.B }[0xd], [X20]
    LD3 { V12.B, V13.B, V14.B }[0x2], [X20]
    ADD  X20, X20, X25, LSR #0
    MOV  X17, X20
    ST3 { V17.H, V18.H, V19.H }[0x6], [X17], #6
    MOV  X17, X20
    LD3 { V30.H, V31.H, V0.H }[0x5], [X17], #6
    ADD  X20, X20, X25, LSR #0
    ST3 { V25.H, V26.H, V27.H }[0x4], [X20], X11
    LD3 { V17.H, V18.H, V19.H }[0x3], [X20], X11
    ADD  X20, X20, X25, ASR #0
    MOV  X17, X20
    ST3 { V12.S, V13.S, V14.S }[0x1], [X17], #12
    MOV  X17, X20
    LD3 { V25.S, V26.S, V27.S }[0x2], [X17], #12
    ADD  X20, X20, X25
    ST3 { V25.S, V26.S, V27.S }[0x2], [X20], X11
    LD3 { V12.S, V13.S, V14.S }[0x2], [X20], X11
    ADD  X20, X20, X25
    MOV  X17, X20
    ST3 { V30.D, V31.D, V0.D }[0x1], [X17], #24
    MOV  X17, X20
    LD3 { V30.D, V31.D, V0.D }[0x0], [X17], #24
    ADD  X20, X20, X25, ASR #0
    ST3 { V17.D, V18.D, V19.D }[0x1], [X20], X11
    LD3 { V25.D, V26.D, V27.D }[0x1], [X20], X11
    ADD  X20, X20, X25, ASR #0
    MOV  X17, X20
    ST3 { V25.B, V26.B, V27.B }[0x6], [X17], #3
    MOV  X17, X20
    LD3 { V25.B, V26.B, V27.B }[0x1], [X17], #3
    ADD  X20, X20, X25, ASR #0
    ST3 { V25.B, V26.B, V27.B }[0xb], [X20], X11
    LD3 { V25.B, V26.B, V27.B }[0xd], [X20], X11
    ADD  X20, X20, X25
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X5
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X7, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, D0
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa5, LSL #16
    MOVK  X16, #0xa5, LSL #48
    FMOV  X7, V1.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D1
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D2
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D3
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D4
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa500, LSL #0
    MOVK  X16, #0xa5, LSL #32
    MOVK  X16, #0xa500, LSL #48
    FMOV  X7, V5.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D5
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa5, LSL #16
    MOVK  X16, #0xa500, LSL #32
    FMOV  X7, V6.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D6
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D7
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V8.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D8
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V9.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D9
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D10
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D11
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa500, LSL #48
    FMOV  X7, V12.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, D12
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa5, LSL #48
    FMOV  X7, V13.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, D13
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa500, LSL #32
    FMOV  X7, V14.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    MOVK  X16, #0xa5, LSL #16
    FMOV  X7, D14
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D15
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D16
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    FMOV  X7, D17
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V18.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    FMOV  X7, D18
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V19.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D19
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V20.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D20
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D21
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D22
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V23.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D23
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V24.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D24
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V25.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D25
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V26.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D26
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V27.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D27
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V28.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D28
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, V29.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    FMOV  X7, D29
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, D30
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
    MOVZ  X16, #0x0, LSL #0
    FMOV  X7, D31
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X25
    FMOV  V0.D[1], X22
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X22
    FMOV  V3.D[1], X16
    FMOV  D4, X4
    FMOV  V4.D[1], X25
    FMOV  D5, X26
    FMOV  V5.D[1], X10
    FMOV  D6, X26
    FMOV  V6.D[1], X3
    FMOV  D7, X4
    FMOV  V7.D[1], X12
    FMOV  D8, X28
    FMOV  V8.D[1], X5
    FMOV  D9, X14
    FMOV  V9.D[1], X7
    FMOV  D10, X28
    FMOV  V10.D[1], X22
    FMOV  D11, X7
    FMOV  V11.D[1], X19
    FMOV  D12, X29
    FMOV  V12.D[1], X2
    FMOV  D13, X22
    FMOV  V13.D[1], X4
    FMOV  D14, X7
    FMOV  V14.D[1], X2
    FMOV  D15, X16
    FMOV  V15.D[1], X4
    FMOV  D16, X14
    FMOV  V16.D[1], X22
    FMOV  D17, X5
    FMOV  V17.D[1], X4
    FMOV  D18, X21
    FMOV  V18.D[1], X9
    FMOV  D19, X29
    FMOV  V19.D[1], X17
    FMOV  D20, X27
    FMOV  V20.D[1], X28
    FMOV  D21, X5
    FMOV  V21.D[1], X8
    FMOV  D22, X13
    FMOV  V22.D[1], X10
    FMOV  D23, X8
    FMOV  V23.D[1], X7
    FMOV  D24, X28
    FMOV  V24.D[1], X20
    FMOV  D25, X12
    FMOV  V25.D[1], X16
    FMOV  D26, X17
    FMOV  V26.D[1], X7
    FMOV  D27, X25
    FMOV  V27.D[1], X29
    FMOV  D28, X25
    FMOV  V28.D[1], X14
    FMOV  D29, X5
    FMOV  V29.D[1], X23
    FMOV  D30, X7
    FMOV  V30.D[1], X7
    FMOV  D31, X2
    FMOV  V31.D[1], X25
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X9, #0x2800, LSL #0
    ADD  X13, X30, X9, LSR #0
    ST3 { V27.4S, V28.4S, V29.4S }, [X13]
    LD3 { V3.16B, V4.16B, V5.16B }, [X13]
    ADD  X13, X13, X3, ASR #0
    ST3 { V3.16B, V4.16B, V5.16B }, [X13]
    LD3 { V0.16B, V1.16B, V2.16B }, [X13]
    ADD  X13, X13, X3
    ST3 { V0.2D, V1.2D, V2.2D }, [X13]
    LD3 { V8.2D, V9.2D, V10.2D }, [X13]
    ADD  X13, X13, X3, LSR #0
    ST3 { V13.4S, V14.4S, V15.4S }, [X13]
    LD3 { V7.4S, V8.4S, V9.4S }, [X13]
    ADD  X13, X13, X3
    ST3 { V8.8H, V9.8H, V10.8H }, [X13]
    LD3 { V0.8H, V1.8H, V2.8H }, [X13]
    ADD  X13, X13, X3, LSR #0
    ST3 { V27.4H, V28.4H, V29.4H }, [X13]
    LD3 { V27.2S, V28.2S, V29.2S }, [X13]
    ADD  X13, X13, X3
    ST3 { V22.2S, V23.2S, V24.2S }, [X13]
    LD3 { V13.2S, V14.2S, V15.2S }, [X13]
    ADD  X13, X13, X3
    ST3 { V0.4H, V1.4H, V2.4H }, [X13]
    LD3 { V22.4H, V23.4H, V24.4H }, [X13]
    ADD  X13, X13, X3
    ST3 { V0.8B, V1.8B, V2.8B }, [X13]
    LD3 { V8.8B, V9.8B, V10.8B }, [X13]
    ADD  X13, X13, X3, ASR #0
    MOV  X4, X13
    ST3 { V22.8H, V23.8H, V24.8H }, [X4], #48
    MOV  X4, X13
    LD3 { V22.2D, V23.2D, V24.2D }, [X4], #48
    ADD  X13, X13, X3
    MOV  X4, X13
    ST3 { V28.16B, V29.16B, V30.16B }, [X4], #48
    MOV  X4, X13
    LD3 { V28.16B, V29.16B, V30.16B }, [X4], #48
    ADD  X13, X13, X3, ASR #0
    MOV  X4, X13
    ST3 { V13.2D, V14.2D, V15.2D }, [X4], #48
    MOV  X4, X13
    LD3 { V0.2D, V1.2D, V2.2D }, [X4], #48
    ADD  X13, X13, X3, ASR #0
    MOV  X4, X13
    ST3 { V22.4S, V23.4S, V24.4S }, [X4], #48
    MOV  X4, X13
    LD3 { V22.4S, V23.4S, V24.4S }, [X4], #48
    ADD  X13, X13, X3
    MOV  X4, X13
    ST3 { V28.8H, V29.8H, V30.8H }, [X4], #48
    MOV  X4, X13
    LD3 { V28.8H, V29.8H, V30.8H }, [X4], #48
    ADD  X13, X13, X3, LSR #0
    MOV  X4, X13
    ST3 { V28.2S, V29.2S, V30.2S }, [X4], #24
    MOV  X4, X13
    LD3 { V8.8B, V9.8B, V10.8B }, [X4], #24
    ADD  X13, X13, X3, ASR #0
    MOV  X4, X13
    ST3 { V22.2S, V23.2S, V24.2S }, [X4], #24
    MOV  X4, X13
    LD3 { V22.2S, V23.2S, V24.2S }, [X4], #24
    ADD  X13, X13, X3
    MOV  X4, X13
    ST3 { V8.4H, V9.4H, V10.4H }, [X4], #24
    MOV  X4, X13
    LD3 { V28.4H, V29.4H, V30.4H }, [X4], #24
    ADD  X13, X13, X3, ASR #0
    MOV  X4, X13
    ST3 { V28.8B, V29.8B, V30.8B }, [X4], #24
    MOV  X4, X13
    LD3 { V28.8B, V29.8B, V30.8B }, [X4], #24
    ADD  X13, X13, X3
    ST3 { V22.2D, V23.2D, V24.2D }, [X13], X25
    LD3 { V8.16B, V9.16B, V10.16B }, [X13], X25
    ADD  X13, X13, X3
    ST3 { V8.16B, V9.16B, V10.16B }, [X13], X25
    LD3 { V8.16B, V9.16B, V10.16B }, [X13], X25
    ADD  X13, X13, X3, ASR #0
    ST3 { V8.2D, V9.2D, V10.2D }, [X13], X25
    LD3 { V8.2D, V9.2D, V10.2D }, [X13], X25
    ADD  X13, X13, X3, ASR #0
    ST3 { V28.4S, V29.4S, V30.4S }, [X13], X25
    LD3 { V28.4S, V29.4S, V30.4S }, [X13], X25
    ADD  X13, X13, X3
    ST3 { V8.8H, V9.8H, V10.8H }, [X13], X25
    LD3 { V8.8H, V9.8H, V10.8H }, [X13], X25
    ADD  X13, X13, X3, LSR #0
    ST3 { V26.8B, V27.8B, V28.8B }, [X13], X25
    LD3 { V22.4H, V23.4H, V24.4H }, [X13], X25
    ADD  X13, X13, X3, LSR #0
    ST3 { V8.2S, V9.2S, V10.2S }, [X13], X25
    LD3 { V8.2S, V9.2S, V10.2S }, [X13], X25
    ADD  X13, X13, X3, LSR #0
    ST3 { V22.4H, V23.4H, V24.4H }, [X13], X25
    LD3 { V22.4H, V23.4H, V24.4H }, [X13], X25
    ADD  X13, X13, X3
    ST3 { V8.8B, V9.8B, V10.8B }, [X13], X25
    LD3 { V8.8B, V9.8B, V10.8B }, [X13], X25
    ADD  X13, X13, X3
    ST3 { V8.H, V9.H, V10.H }[0x7], [X13]
    LD3 { V26.H, V27.H, V28.H }[0x1], [X13]
    ADD  X13, X13, X3, LSR #0
    ST3 { V22.S, V23.S, V24.S }[0x0], [X13]
    LD3 { V22.S, V23.S, V24.S }[0x0], [X13]
    ADD  X13, X13, X3, ASR #0
    ST3 { V22.D, V23.D, V24.D }[0x0], [X13]
    LD3 { V8.D, V9.D, V10.D }[0x1], [X13]
    ADD  X13, X13, X3, LSR #0
    ST3 { V8.B, V9.B, V10.B }[0x6], [X13]
    LD3 { V10.B, V11.B, V12.B }[0x6], [X13]
    ADD  X13, X13, X3, LSR #0
    MOV  X4, X13
    ST3 { V26.H, V27.H, V28.H }[0x2], [X4], #6
    MOV  X4, X13
    LD3 { V22.H, V23.H, V24.H }[0x6], [X4], #6
    ADD  X13, X13, X3, ASR #0
    ST3 { V10.H, V11.H, V12.H }[0x4], [X13], X25
    LD3 { V10.H, V11.H, V12.H }[0x1], [X13], X25
    ADD  X13, X13, X3, LSR #0
    MOV  X4, X13
    ST3 { V22.S, V23.S, V24.S }[0x3], [X4], #12
    MOV  X4, X13
    LD3 { V26.S, V27.S, V28.S }[0x0], [X4], #12
    ADD  X13, X13, X3
    ST3 { V26.S, V27.S, V28.S }[0x1], [X13], X25
    LD3 { V16.S, V17.S, V18.S }[0x2], [X13], X25
    ADD  X13, X13, X3, LSR #0
    MOV  X4, X13
    ST3 { V26.D, V27.D, V28.D }[0x1], [X4], #24
    MOV  X4, X13
    LD3 { V22.D, V23.D, V24.D }[0x0], [X4], #24
    ADD  X13, X13, X3, ASR #0
    ST3 { V22.D, V23.D, V24.D }[0x1], [X13], X25
    LD3 { V22.D, V23.D, V24.D }[0x1], [X13], X25
    ADD  X13, X13, X3, LSR #0
    MOV  X4, X13
    ST3 { V16.B, V17.B, V18.B }[0x1], [X4], #3
    MOV  X4, X13
    LD3 { V26.B, V27.B, V28.B }[0xc], [X4], #3
    ADD  X13, X13, X3
    ST3 { V26.B, V27.B, V28.B }[0xa], [X13], X25
    LD3 { V26.B, V27.B, V28.B }[0xf], [X13], X25
    ADD  X13, X13, X3, ASR #0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X20, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    MRS  X20, FPSR
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V0.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D0
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V1.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D1
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V2.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D2
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V3.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D3
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V4.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D4
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V5.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D5
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V6.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D6
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V7.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D7
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V8.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D8
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V9.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D9
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V10.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D10
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V11.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D11
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V12.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D12
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V13.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D13
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V14.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D14
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V15.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D15
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V16.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D16
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V17.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D17
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V18.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D18
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V19.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D19
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V20.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D20
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V21.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D21
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    FMOV  X20, V22.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D22
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    FMOV  X20, V23.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, D23
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    FMOV  X20, V24.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, D24
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V25.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D25
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V26.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D26
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a, LSL #32
    FMOV  X20, V27.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D27
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    MOVK  X28, #0x5a, LSL #32
    FMOV  X20, V28.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D28
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D29
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D30
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, V31.D[1]
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    FMOV  X20, D31
    SUB  X23, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
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
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X27
    FMOV  V0.D[1], X28
    FMOV  D1, X23
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X11
    FMOV  D3, X25
    FMOV  V3.D[1], X28
    FMOV  D4, X17
    FMOV  V4.D[1], X8
    FMOV  D5, X16
    FMOV  V5.D[1], X19
    FMOV  D6, X4
    FMOV  V6.D[1], X28
    FMOV  D7, X27
    FMOV  V7.D[1], X16
    FMOV  D8, X13
    FMOV  V8.D[1], X13
    FMOV  D9, X29
    FMOV  V9.D[1], X3
    FMOV  D10, X11
    FMOV  V10.D[1], X16
    FMOV  D11, X21
    FMOV  V11.D[1], X2
    FMOV  D12, X29
    FMOV  V12.D[1], X3
    FMOV  D13, X14
    FMOV  V13.D[1], X20
    FMOV  D14, X29
    FMOV  V14.D[1], X4
    FMOV  D15, X9
    FMOV  V15.D[1], X16
    FMOV  D16, X11
    FMOV  V16.D[1], X12
    FMOV  D17, X29
    FMOV  V17.D[1], X16
    FMOV  D18, X10
    FMOV  V18.D[1], X28
    FMOV  D19, X16
    FMOV  V19.D[1], X26
    FMOV  D20, X29
    FMOV  V20.D[1], X21
    FMOV  D21, X29
    FMOV  V21.D[1], X27
    FMOV  D22, X26
    FMOV  V22.D[1], X16
    FMOV  D23, X5
    FMOV  V23.D[1], X27
    FMOV  D24, X5
    FMOV  V24.D[1], X9
    FMOV  D25, X27
    FMOV  V25.D[1], X19
    FMOV  D26, X25
    FMOV  V26.D[1], X28
    FMOV  D27, X27
    FMOV  V27.D[1], X7
    FMOV  D28, X20
    FMOV  V28.D[1], X27
    FMOV  D29, X25
    FMOV  V29.D[1], X10
    FMOV  D30, X27
    FMOV  V30.D[1], X8
    FMOV  D31, X22
    FMOV  V31.D[1], X16
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X8, #0x2d00, LSL #0
    ADD  X9, X30, X8, ASR #0
    ST3 { V22.16B, V23.16B, V24.16B }, [X9]
    LD3 { V21.16B, V22.16B, V23.16B }, [X9]
    ADD  X9, X9, X5
    ST3 { V27.16B, V28.16B, V29.16B }, [X9]
    LD3 { V27.16B, V28.16B, V29.16B }, [X9]
    ADD  X9, X9, X5, ASR #0
    ST3 { V10.2D, V11.2D, V12.2D }, [X9]
    LD3 { V30.2D, V31.2D, V0.2D }, [X9]
    ADD  X9, X9, X5, LSR #0
    ST3 { V30.4S, V31.4S, V0.4S }, [X9]
    LD3 { V10.4S, V11.4S, V12.4S }, [X9]
    ADD  X9, X9, X5
    ST3 { V27.8H, V28.8H, V29.8H }, [X9]
    LD3 { V4.8H, V5.8H, V6.8H }, [X9]
    ADD  X9, X9, X5, ASR #0
    ST3 { V4.8B, V5.8B, V6.8B }, [X9]
    LD3 { V28.8B, V29.8B, V30.8B }, [X9]
    ADD  X9, X9, X5
    ST3 { V10.2S, V11.2S, V12.2S }, [X9]
    LD3 { V30.2S, V31.2S, V0.2S }, [X9]
    ADD  X9, X9, X5, LSR #0
    ST3 { V10.4H, V11.4H, V12.4H }, [X9]
    LD3 { V9.4H, V10.4H, V11.4H }, [X9]
    ADD  X9, X9, X5
    ST3 { V21.8B, V22.8B, V23.8B }, [X9]
    LD3 { V0.8B, V1.8B, V2.8B }, [X9]
    ADD  X9, X9, X5
    MOV  X21, X9
    ST3 { V29.16B, V30.16B, V31.16B }, [X21], #48
    MOV  X21, X9
    LD3 { V12.4S, V13.4S, V14.4S }, [X21], #48
    ADD  X9, X9, X5, LSR #0
    MOV  X21, X9
    ST3 { V9.16B, V10.16B, V11.16B }, [X21], #48
    MOV  X21, X9
    LD3 { V31.16B, V0.16B, V1.16B }, [X21], #48
    ADD  X9, X9, X5
    MOV  X21, X9
    ST3 { V31.2D, V0.2D, V1.2D }, [X21], #48
    MOV  X21, X9
    LD3 { V21.2D, V22.2D, V23.2D }, [X21], #48
    ADD  X9, X9, X5, LSR #0
    MOV  X21, X9
    ST3 { V21.4S, V22.4S, V23.4S }, [X21], #48
    MOV  X21, X9
    LD3 { V21.4S, V22.4S, V23.4S }, [X21], #48
    ADD  X9, X9, X5, ASR #0
    MOV  X21, X9
    ST3 { V21.8H, V22.8H, V23.8H }, [X21], #48
    MOV  X21, X9
    LD3 { V9.8H, V10.8H, V11.8H }, [X21], #48
    ADD  X9, X9, X5, ASR #0
    MOV  X21, X9
    ST3 { V9.4H, V10.4H, V11.4H }, [X21], #24
    MOV  X21, X9
    LD3 { V21.4H, V22.4H, V23.4H }, [X21], #24
    ADD  X9, X9, X5
    MOV  X21, X9
    ST3 { V21.2S, V22.2S, V23.2S }, [X21], #24
    MOV  X21, X9
    LD3 { V21.2S, V22.2S, V23.2S }, [X21], #24
    ADD  X9, X9, X5, ASR #0
    MOV  X21, X9
    ST3 { V21.4H, V22.4H, V23.4H }, [X21], #24
    MOV  X21, X9
    LD3 { V31.4H, V0.4H, V1.4H }, [X21], #24
    ADD  X9, X9, X5
    MOV  X21, X9
    ST3 { V14.8B, V15.8B, V16.8B }, [X21], #24
    MOV  X21, X9
    LD3 { V9.8B, V10.8B, V11.8B }, [X21], #24
    ADD  X9, X9, X5, ASR #0
    ST3 { V29.4S, V30.4S, V31.4S }, [X9], X13
    LD3 { V29.4S, V30.4S, V31.4S }, [X9], X13
    ADD  X9, X9, X5, LSR #0
    ST3 { V7.16B, V8.16B, V9.16B }, [X9], X13
    LD3 { V14.16B, V15.16B, V16.16B }, [X9], X13
    ADD  X9, X9, X5
    ST3 { V22.2D, V23.2D, V24.2D }, [X9], X13
    LD3 { V7.2D, V8.2D, V9.2D }, [X9], X13
    ADD  X9, X9, X5, ASR #0
    ST3 { V30.4S, V31.4S, V0.4S }, [X9], X13
    LD3 { V17.4S, V18.4S, V19.4S }, [X9], X13
    ADD  X9, X9, X5, ASR #0
    ST3 { V7.8H, V8.8H, V9.8H }, [X9], X13
    LD3 { V30.8H, V31.8H, V0.8H }, [X9], X13
    ADD  X9, X9, X5, ASR #0
    ST3 { V7.8B, V8.8B, V9.8B }, [X9], X13
    LD3 { V22.2S, V23.2S, V24.2S }, [X9], X13
    ADD  X9, X9, X5, ASR #0
    ST3 { V14.2S, V15.2S, V16.2S }, [X9], X13
    LD3 { V14.2S, V15.2S, V16.2S }, [X9], X13
    ADD  X9, X9, X5
    ST3 { V7.4H, V8.4H, V9.4H }, [X9], X13
    LD3 { V7.4H, V8.4H, V9.4H }, [X9], X13
    ADD  X9, X9, X5
    ST3 { V14.8B, V15.8B, V16.8B }, [X9], X13
    LD3 { V26.8B, V27.8B, V28.8B }, [X9], X13
    ADD  X9, X9, X5, LSR #0
    ST3 { V26.H, V27.H, V28.H }[0x7], [X9]
    LD3 { V4.H, V5.H, V6.H }[0x1], [X9]
    ADD  X9, X9, X5
    ST3 { V6.S, V7.S, V8.S }[0x0], [X9]
    LD3 { V26.S, V27.S, V28.S }[0x0], [X9]
    ADD  X9, X9, X5, LSR #0
    ST3 { V22.D, V23.D, V24.D }[0x1], [X9]
    LD3 { V28.D, V29.D, V30.D }[0x0], [X9]
    ADD  X9, X9, X5
    ST3 { V9.B, V10.B, V11.B }[0x4], [X9]
    LD3 { V9.B, V10.B, V11.B }[0x6], [X9]
    ADD  X9, X9, X5, LSR #0
    MOV  X21, X9
    ST3 { V27.H, V28.H, V29.H }[0x0], [X21], #6
    MOV  X21, X9
    LD3 { V13.H, V14.H, V15.H }[0x3], [X21], #6
    ADD  X9, X9, X5
    ST3 { V13.H, V14.H, V15.H }[0x4], [X9], X13
    LD3 { V20.H, V21.H, V22.H }[0x5], [X9], X13
    ADD  X9, X9, X5
    MOV  X21, X9
    ST3 { V20.S, V21.S, V22.S }[0x2], [X21], #12
    MOV  X21, X9
    LD3 { V6.S, V7.S, V8.S }[0x1], [X21], #12
    ADD  X9, X9, X5, ASR #0
    ST3 { V9.S, V10.S, V11.S }[0x0], [X9], X13
    LD3 { V28.S, V29.S, V30.S }[0x3], [X9], X13
    ADD  X9, X9, X5, ASR #0
    MOV  X21, X9
    ST3 { V28.D, V29.D, V30.D }[0x1], [X21], #24
    MOV  X21, X9
    LD3 { V20.D, V21.D, V22.D }[0x1], [X21], #24
    ADD  X9, X9, X5
    ST3 { V20.D, V21.D, V22.D }[0x1], [X9], X13
    LD3 { V28.D, V29.D, V30.D }[0x1], [X9], X13
    ADD  X9, X9, X5, LSR #0
    MOV  X21, X9
    ST3 { V28.B, V29.B, V30.B }[0x1], [X21], #3
    MOV  X21, X9
    LD3 { V9.B, V10.B, V11.B }[0x5], [X21], #3
    ADD  X9, X9, X5, ASR #0
    ST3 { V9.B, V10.B, V11.B }[0xe], [X9], X13
    LD3 { V20.B, V21.B, V22.B }[0xe], [X9], X13
    ADD  X9, X9, X5
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X2, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X2, FPSR
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, V0.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D0
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D1
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D2
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, V3.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D3
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, V4.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D4
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, V5.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D5
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, V6.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    FMOV  X2, D6
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V7.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    FMOV  X2, D7
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V8.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    FMOV  X2, D8
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V9.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D9
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V10.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D10
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V11.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D11
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V12.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D12
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V13.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D13
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V14.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    FMOV  X2, D14
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V15.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    FMOV  X2, D15
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D16
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D17
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D18
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V19.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D19
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa500, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D20
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa500, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D21
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa500, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D22
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V23.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D23
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D24
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, V25.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D25
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V26.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D26
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D27
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, V28.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D28
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, V29.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D29
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, V30.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, D30
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    FMOV  X2, D31
    SUB  X23, X17, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP06_TestFail

AdvsimdLoadStoreP06_TestEnd:
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
AdvsimdLoadStoreP06_TestFail:
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
