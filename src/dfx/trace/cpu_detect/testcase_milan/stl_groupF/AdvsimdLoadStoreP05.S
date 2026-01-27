.global AdvsimdLoadStoreP05

.text
.p2align 4

AdvsimdLoadStoreP05:

AdvsimdLoadStoreP05_TestBegin:
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
    MOVZ  X2, #0x7985, LSL #0
    MOVK  X2, #0x764b, LSL #16
    MOVK  X2, #0xac31, LSL #32
    MOVK  X2, #0x8ec7, LSL #48
    MOVZ  X3, #0xaa64, LSL #0
    MOVK  X3, #0xaca0, LSL #16
    MOVK  X3, #0x8336, LSL #32
    MOVK  X3, #0x1854, LSL #48
    MOVZ  X5, #0x89f2, LSL #0
    MOVK  X5, #0x3be3, LSL #16
    MOVK  X5, #0xad50, LSL #32
    MOVK  X5, #0x417c, LSL #48
    MOVZ  X6, #0x8da2, LSL #0
    MOVK  X6, #0xb617, LSL #16
    MOVK  X6, #0xc6fc, LSL #32
    MOVK  X6, #0x6fd9, LSL #48
    MOVZ  X7, #0x3da8, LSL #0
    MOVK  X7, #0x8c24, LSL #16
    MOVK  X7, #0x75ef, LSL #32
    MOVK  X7, #0x324d, LSL #48
    MOVZ  X8, #0x5f8d, LSL #0
    MOVK  X8, #0xf802, LSL #16
    MOVK  X8, #0xaf09, LSL #32
    MOVK  X8, #0xf0a, LSL #48
    MOVZ  X9, #0x5fa6, LSL #0
    MOVK  X9, #0x80fe, LSL #16
    MOVK  X9, #0xc822, LSL #32
    MOVK  X9, #0xe156, LSL #48
    MOVZ  X10, #0x6c5b, LSL #0
    MOVK  X10, #0x8437, LSL #16
    MOVK  X10, #0xc506, LSL #32
    MOVK  X10, #0x4768, LSL #48
    MOVZ  X11, #0x43e4, LSL #0
    MOVK  X11, #0xe5d6, LSL #16
    MOVK  X11, #0xf788, LSL #32
    MOVK  X11, #0xa42, LSL #48
    MOVZ  X13, #0x8cf, LSL #0
    MOVK  X13, #0xfae0, LSL #16
    MOVK  X13, #0xeb65, LSL #32
    MOVK  X13, #0xed78, LSL #48
    MOVZ  X14, #0x396e, LSL #0
    MOVK  X14, #0xf993, LSL #16
    MOVK  X14, #0x51b2, LSL #32
    MOVK  X14, #0x6802, LSL #48
    MOVZ  X16, #0x44ec, LSL #0
    MOVK  X16, #0x88d9, LSL #16
    MOVK  X16, #0x3726, LSL #32
    MOVK  X16, #0x897b, LSL #48
    MOVZ  X17, #0x29ce, LSL #0
    MOVK  X17, #0xe78, LSL #16
    MOVK  X17, #0x9dce, LSL #32
    MOVK  X17, #0x85e1, LSL #48
    MOVZ  X18, #0x67ee, LSL #0
    MOVK  X18, #0xd823, LSL #16
    MOVK  X18, #0xb13, LSL #32
    MOVK  X18, #0x81e2, LSL #48
    MOVZ  X19, #0x8a86, LSL #0
    MOVK  X19, #0x6fdb, LSL #16
    MOVK  X19, #0x3853, LSL #32
    MOVK  X19, #0x9fe2, LSL #48
    MOVZ  X20, #0x15cb, LSL #0
    MOVK  X20, #0xe349, LSL #16
    MOVK  X20, #0x294f, LSL #32
    MOVK  X20, #0xe2fb, LSL #48
    MOVZ  X22, #0xc87a, LSL #0
    MOVK  X22, #0x6d18, LSL #16
    MOVK  X22, #0xa22d, LSL #32
    MOVK  X22, #0x1ff2, LSL #48
    MOVZ  X23, #0xaec2, LSL #0
    MOVK  X23, #0x1b51, LSL #16
    MOVK  X23, #0x5c8c, LSL #32
    MOVK  X23, #0x1aea, LSL #48
    MOVZ  X24, #0xce5c, LSL #0
    MOVK  X24, #0x30f0, LSL #16
    MOVK  X24, #0x1baa, LSL #32
    MOVK  X24, #0xfa28, LSL #48
    MOVZ  X25, #0xd115, LSL #0
    MOVK  X25, #0x989e, LSL #16
    MOVK  X25, #0xb22b, LSL #32
    MOVK  X25, #0x1af6, LSL #48
    MOVZ  X26, #0x38f6, LSL #0
    MOVK  X26, #0x2a17, LSL #16
    MOVK  X26, #0xb90c, LSL #32
    MOVK  X26, #0x38fa, LSL #48
    MOVZ  X27, #0x1880, LSL #0
    MOVK  X27, #0xfbea, LSL #16
    MOVK  X27, #0x5583, LSL #32
    MOVK  X27, #0x4209, LSL #48
    MOVZ  X28, #0xf7ae, LSL #0
    MOVK  X28, #0xce33, LSL #16
    MOVK  X28, #0x40b1, LSL #32
    MOVK  X28, #0xd18, LSL #48
    MOVZ  X29, #0x56f9, LSL #0
    MOVK  X29, #0x253, LSL #16
    MOVK  X29, #0x1285, LSL #32
    MOVK  X29, #0x3733, LSL #48
    MOVZ  X9, #0x2441, LSL #0
    MOVK  X9, #0xf883, LSL #16
    MOVK  X9, #0xf205, LSL #32
    MOVK  X9, #0x2b0e, LSL #48
    MSR  FPCR, X9
    MOVZ  X9, #0xfda1, LSL #0
    MOVK  X9, #0x6190, LSL #16
    MOVK  X9, #0x205c, LSL #32
    MOVK  X9, #0xfe34, LSL #48
    MSR  FPSR, X9
    MRS  X8, FPSR
    MOVZ  X6, #0xff60, LSL #0
    MOVK  X6, #0x7ff, LSL #16
    MOVK  X6, #0xffff, LSL #32
    MOVK  X6, #0xffff, LSL #48
    AND  X8, X8, X6
    MOVZ  X6, #0x0, LSL #0
    ORR  X8, X8, X6
    MSR  FPSR, X8
    ISB  SY
    ANDS  X25, X18, #0xfefefefefefefefe
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
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X24
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X29
    FMOV  D4, X7
    FMOV  V4.D[1], X8
    FMOV  D5, X14
    FMOV  V5.D[1], X20
    FMOV  D6, X18
    FMOV  V6.D[1], X7
    FMOV  D7, X2
    FMOV  V7.D[1], X17
    FMOV  D8, X25
    FMOV  V8.D[1], X9
    FMOV  D9, X13
    FMOV  V9.D[1], X8
    FMOV  D10, X2
    FMOV  V10.D[1], X11
    FMOV  D11, X28
    FMOV  V11.D[1], X27
    FMOV  D12, X8
    FMOV  V12.D[1], X13
    FMOV  D13, X3
    FMOV  V13.D[1], X23
    FMOV  D14, X18
    FMOV  V14.D[1], X18
    FMOV  D15, X24
    FMOV  V15.D[1], X17
    FMOV  D16, X3
    FMOV  V16.D[1], X11
    FMOV  D17, X2
    FMOV  V17.D[1], X7
    FMOV  D18, X5
    FMOV  V18.D[1], X23
    FMOV  D19, X6
    FMOV  V19.D[1], X7
    FMOV  D20, X28
    FMOV  V20.D[1], X6
    FMOV  D21, X28
    FMOV  V21.D[1], X7
    FMOV  D22, X22
    FMOV  V22.D[1], X18
    FMOV  D23, X13
    FMOV  V23.D[1], X24
    FMOV  D24, X18
    FMOV  V24.D[1], X22
    FMOV  D25, X11
    FMOV  V25.D[1], X6
    FMOV  D26, X6
    FMOV  V26.D[1], X24
    FMOV  D27, X22
    FMOV  V27.D[1], X19
    FMOV  D28, X18
    FMOV  V28.D[1], X14
    FMOV  D29, X25
    FMOV  V29.D[1], X18
    FMOV  D30, X14
    FMOV  V30.D[1], X28
    FMOV  D31, X5
    FMOV  V31.D[1], X18
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X18, #0x0, LSL #0
    ADD  X23, X30, X18
    ST2 { V22.4S, V23.4S }, [X23]
    LD2 { V11.2D, V12.2D }, [X23]
    ADD  X23, X23, X16
    ST2 { V26.16B, V27.16B }, [X23]
    LD2 { V9.16B, V10.16B }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST2 { V6.2D, V7.2D }, [X23]
    LD2 { V15.2D, V16.2D }, [X23]
    ADD  X23, X23, X16, LSR #0
    ST2 { V24.4S, V25.4S }, [X23]
    LD2 { V14.4S, V15.4S }, [X23]
    ADD  X23, X23, X16, LSR #0
    ST2 { V11.8H, V12.8H }, [X23]
    LD2 { V30.8H, V31.8H }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST2 { V9.4H, V10.4H }, [X23]
    LD2 { V6.2S, V7.2S }, [X23]
    ADD  X23, X23, X16, LSR #0
    ST2 { V6.2S, V7.2S }, [X23]
    LD2 { V24.2S, V25.2S }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST2 { V15.4H, V16.4H }, [X23]
    LD2 { V30.4H, V31.4H }, [X23]
    ADD  X23, X23, X16, ASR #0
    ST2 { V24.8B, V25.8B }, [X23]
    LD2 { V1.8B, V2.8B }, [X23]
    ADD  X23, X23, X16, LSR #0
    MOV  X29, X23
    ST2 { V1.4S, V2.4S }, [X29], #32
    MOV  X29, X23
    LD2 { V1.4S, V2.4S }, [X29], #32
    ADD  X23, X23, X16
    MOV  X29, X23
    ST2 { V1.16B, V2.16B }, [X29], #32
    MOV  X29, X23
    LD2 { V9.16B, V10.16B }, [X29], #32
    ADD  X23, X23, X16, ASR #0
    MOV  X29, X23
    ST2 { V30.2D, V31.2D }, [X29], #32
    MOV  X29, X23
    LD2 { V1.2D, V2.2D }, [X29], #32
    ADD  X23, X23, X16, LSR #0
    MOV  X29, X23
    ST2 { V1.4S, V2.4S }, [X29], #32
    MOV  X29, X23
    LD2 { V1.4S, V2.4S }, [X29], #32
    ADD  X23, X23, X16
    MOV  X29, X23
    ST2 { V29.8H, V30.8H }, [X29], #32
    MOV  X29, X23
    LD2 { V11.8H, V12.8H }, [X29], #32
    ADD  X23, X23, X16, LSR #0
    MOV  X29, X23
    ST2 { V9.4H, V10.4H }, [X29], #16
    MOV  X29, X23
    LD2 { V25.2S, V26.2S }, [X29], #16
    ADD  X23, X23, X16, ASR #0
    MOV  X29, X23
    ST2 { V11.2S, V12.2S }, [X29], #16
    MOV  X29, X23
    LD2 { V11.2S, V12.2S }, [X29], #16
    ADD  X23, X23, X16, ASR #0
    MOV  X29, X23
    ST2 { V11.4H, V12.4H }, [X29], #16
    MOV  X29, X23
    LD2 { V3.4H, V4.4H }, [X29], #16
    ADD  X23, X23, X16, LSR #0
    MOV  X29, X23
    ST2 { V25.8B, V26.8B }, [X29], #16
    MOV  X29, X23
    LD2 { V9.8B, V10.8B }, [X29], #16
    ADD  X23, X23, X16, LSR #0
    ST2 { V9.8H, V10.8H }, [X23], X9
    LD2 { V9.4S, V10.4S }, [X23], X9
    ADD  X23, X23, X16, ASR #0
    ST2 { V9.16B, V10.16B }, [X23], X9
    LD2 { V9.16B, V10.16B }, [X23], X9
    ADD  X23, X23, X16, LSR #0
    ST2 { V9.2D, V10.2D }, [X23], X9
    LD2 { V25.2D, V26.2D }, [X23], X9
    ADD  X23, X23, X16, ASR #0
    ST2 { V3.4S, V4.4S }, [X23], X9
    LD2 { V11.4S, V12.4S }, [X23], X9
    ADD  X23, X23, X16, LSR #0
    ST2 { V25.8H, V26.8H }, [X23], X9
    LD2 { V9.8H, V10.8H }, [X23], X9
    ADD  X23, X23, X16
    ST2 { V11.2S, V12.2S }, [X23], X9
    LD2 { V11.2S, V12.2S }, [X23], X9
    ADD  X23, X23, X16, ASR #0
    ST2 { V9.2S, V10.2S }, [X23], X9
    LD2 { V9.2S, V10.2S }, [X23], X9
    ADD  X23, X23, X16, LSR #0
    ST2 { V9.4H, V10.4H }, [X23], X9
    LD2 { V9.4H, V10.4H }, [X23], X9
    ADD  X23, X23, X16, ASR #0
    ST2 { V11.8B, V12.8B }, [X23], X9
    LD2 { V11.8B, V12.8B }, [X23], X9
    ADD  X23, X23, X16
    ST2 { V9.H, V10.H }[0x0], [X23]
    LD2 { V3.H, V4.H }[0x3], [X23]
    ADD  X23, X23, X16
    ST2 { V11.S, V12.S }[0x0], [X23]
    LD2 { V11.S, V12.S }[0x3], [X23]
    ADD  X23, X23, X16, ASR #0
    ST2 { V3.D, V4.D }[0x0], [X23]
    LD2 { V3.D, V4.D }[0x0], [X23]
    ADD  X23, X23, X16, LSR #0
    ST2 { V3.B, V4.B }[0x5], [X23]
    LD2 { V3.B, V4.B }[0x8], [X23]
    ADD  X23, X23, X16, LSR #0
    MOV  X29, X23
    ST2 { V3.H, V4.H }[0x1], [X29], #4
    MOV  X29, X23
    LD2 { V3.H, V4.H }[0x1], [X29], #4
    ADD  X23, X23, X16, LSR #0
    ST2 { V3.H, V4.H }[0x4], [X23], X9
    LD2 { V3.H, V4.H }[0x7], [X23], X9
    ADD  X23, X23, X16, ASR #0
    MOV  X29, X23
    ST2 { V3.S, V4.S }[0x3], [X29], #8
    MOV  X29, X23
    LD2 { V0.S, V1.S }[0x0], [X29], #8
    ADD  X23, X23, X16
    ST2 { V0.S, V1.S }[0x0], [X23], X9
    LD2 { V14.S, V15.S }[0x2], [X23], X9
    ADD  X23, X23, X16, ASR #0
    MOV  X29, X23
    ST2 { V14.D, V15.D }[0x1], [X29], #16
    MOV  X29, X23
    LD2 { V10.D, V11.D }[0x1], [X29], #16
    ADD  X23, X23, X16
    ST2 { V10.D, V11.D }[0x0], [X23], X9
    LD2 { V29.D, V30.D }[0x1], [X23], X9
    ADD  X23, X23, X16, LSR #0
    MOV  X29, X23
    ST2 { V31.B, V0.B }[0x7], [X29], #2
    MOV  X29, X23
    LD2 { V14.B, V15.B }[0xd], [X29], #2
    ADD  X23, X23, X16, LSR #0
    ST2 { V1.B, V2.B }[0x2], [X23], X9
    LD2 { V22.B, V23.B }[0x9], [X23], X9
    ADD  X23, X23, X16
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X2
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X11
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X13
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X19
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X25
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    SUB  X10, X6, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V0.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D0
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D1
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D2
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a, LSL #0
    MOVK  X6, #0x5a, LSL #48
    FMOV  X10, V3.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D3
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a, LSL #0
    MOVK  X6, #0x5a, LSL #48
    FMOV  X10, V4.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D4
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V5.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D5
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X10, V6.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D6
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X10, V7.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D7
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V8.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D8
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X10, V9.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D9
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V10.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D10
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V11.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D11
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V12.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D12
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V13.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D13
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V14.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D14
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    MOVK  X6, #0x5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V15.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D15
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V16.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D16
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V17.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D17
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V18.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D18
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V19.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D19
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V20.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D20
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V21.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D21
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V22.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D22
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V23.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D23
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D24
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D25
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D26
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V27.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D27
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V28.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D28
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V29.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D29
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, V30.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D30
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X6, #0x5a5a, LSL #0
    MOVK  X6, #0x5a5a, LSL #16
    MOVK  X6, #0x5a5a, LSL #32
    MOVK  X6, #0x5a5a, LSL #48
    FMOV  X10, D31
    SUB  X14, X6, X10
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X23
    FMOV  V2.D[1], X29
    FMOV  D3, X18
    FMOV  V3.D[1], X10
    FMOV  D4, X11
    FMOV  V4.D[1], X10
    FMOV  D5, X25
    FMOV  V5.D[1], X6
    FMOV  D6, X16
    FMOV  V6.D[1], X27
    FMOV  D7, X26
    FMOV  V7.D[1], X18
    FMOV  D8, X16
    FMOV  V8.D[1], X22
    FMOV  D9, X25
    FMOV  V9.D[1], X27
    FMOV  D10, X13
    FMOV  V10.D[1], X6
    FMOV  D11, X27
    FMOV  V11.D[1], X26
    FMOV  D12, X20
    FMOV  V12.D[1], X16
    FMOV  D13, X11
    FMOV  V13.D[1], X23
    FMOV  D14, X5
    FMOV  V14.D[1], X13
    FMOV  D15, X23
    FMOV  V15.D[1], X13
    FMOV  D16, X29
    FMOV  V16.D[1], X9
    FMOV  D17, X6
    FMOV  V17.D[1], X26
    FMOV  D18, X28
    FMOV  V18.D[1], X23
    FMOV  D19, X16
    FMOV  V19.D[1], X23
    FMOV  D20, X25
    FMOV  V20.D[1], X24
    FMOV  D21, X28
    FMOV  V21.D[1], X22
    FMOV  D22, X3
    FMOV  V22.D[1], X13
    FMOV  D23, X8
    FMOV  V23.D[1], X10
    FMOV  D24, X5
    FMOV  V24.D[1], X11
    FMOV  D25, X5
    FMOV  V25.D[1], X8
    FMOV  D26, X10
    FMOV  V26.D[1], X23
    FMOV  D27, X13
    FMOV  V27.D[1], X19
    FMOV  D28, X26
    FMOV  V28.D[1], X10
    FMOV  D29, X10
    FMOV  V29.D[1], X29
    FMOV  D30, X19
    FMOV  V30.D[1], X23
    FMOV  D31, X10
    FMOV  V31.D[1], X11
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X27, #0x500, LSL #0
    ADD  X7, X30, X27, LSR #0
    ST2 { V5.4S, V6.4S }, [X7]
    LD2 { V25.2D, V26.2D }, [X7]
    ADD  X7, X7, X28, LSR #0
    ST2 { V25.16B, V26.16B }, [X7]
    LD2 { V18.16B, V19.16B }, [X7]
    ADD  X7, X7, X28
    ST2 { V18.2D, V19.2D }, [X7]
    LD2 { V4.2D, V5.2D }, [X7]
    ADD  X7, X7, X28
    ST2 { V30.4S, V31.4S }, [X7]
    LD2 { V25.4S, V26.4S }, [X7]
    ADD  X7, X7, X28
    ST2 { V4.8H, V5.8H }, [X7]
    LD2 { V15.8H, V16.8H }, [X7]
    ADD  X7, X7, X28, LSR #0
    ST2 { V25.8B, V26.8B }, [X7]
    LD2 { V28.2S, V29.2S }, [X7]
    ADD  X7, X7, X28, LSR #0
    ST2 { V28.2S, V29.2S }, [X7]
    LD2 { V24.2S, V25.2S }, [X7]
    ADD  X7, X7, X28
    ST2 { V15.4H, V16.4H }, [X7]
    LD2 { V24.4H, V25.4H }, [X7]
    ADD  X7, X7, X28, LSR #0
    ST2 { V24.8B, V25.8B }, [X7]
    LD2 { V17.8B, V18.8B }, [X7]
    ADD  X7, X7, X28, LSR #0
    MOV  X25, X7
    ST2 { V17.4S, V18.4S }, [X25], #32
    MOV  X25, X7
    LD2 { V4.2D, V5.2D }, [X25], #32
    ADD  X7, X7, X28
    MOV  X25, X7
    ST2 { V9.16B, V10.16B }, [X25], #32
    MOV  X25, X7
    LD2 { V24.16B, V25.16B }, [X25], #32
    ADD  X7, X7, X28, LSR #0
    MOV  X25, X7
    ST2 { V26.2D, V27.2D }, [X25], #32
    MOV  X25, X7
    LD2 { V17.2D, V18.2D }, [X25], #32
    ADD  X7, X7, X28
    MOV  X25, X7
    ST2 { V12.4S, V13.4S }, [X25], #32
    MOV  X25, X7
    LD2 { V26.4S, V27.4S }, [X25], #32
    ADD  X7, X7, X28, ASR #0
    MOV  X25, X7
    ST2 { V28.8H, V29.8H }, [X25], #32
    MOV  X25, X7
    LD2 { V28.8H, V29.8H }, [X25], #32
    ADD  X7, X7, X28, ASR #0
    MOV  X25, X7
    ST2 { V17.2S, V18.2S }, [X25], #16
    MOV  X25, X7
    LD2 { V12.4H, V13.4H }, [X25], #16
    ADD  X7, X7, X28
    MOV  X25, X7
    ST2 { V24.2S, V25.2S }, [X25], #16
    MOV  X25, X7
    LD2 { V24.2S, V25.2S }, [X25], #16
    ADD  X7, X7, X28
    MOV  X25, X7
    ST2 { V26.4H, V27.4H }, [X25], #16
    MOV  X25, X7
    LD2 { V26.4H, V27.4H }, [X25], #16
    ADD  X7, X7, X28, LSR #0
    MOV  X25, X7
    ST2 { V26.8B, V27.8B }, [X25], #16
    MOV  X25, X7
    LD2 { V25.8B, V26.8B }, [X25], #16
    ADD  X7, X7, X28, LSR #0
    ST2 { V12.16B, V13.16B }, [X7], X24
    LD2 { V3.2D, V4.2D }, [X7], X24
    ADD  X7, X7, X28, ASR #0
    ST2 { V14.16B, V15.16B }, [X7], X24
    LD2 { V23.16B, V24.16B }, [X7], X24
    ADD  X7, X7, X28, LSR #0
    ST2 { V23.2D, V24.2D }, [X7], X24
    LD2 { V12.2D, V13.2D }, [X7], X24
    ADD  X7, X7, X28
    ST2 { V25.4S, V26.4S }, [X7], X24
    LD2 { V22.4S, V23.4S }, [X7], X24
    ADD  X7, X7, X28
    ST2 { V12.8H, V13.8H }, [X7], X24
    LD2 { V13.8H, V14.8H }, [X7], X24
    ADD  X7, X7, X28, LSR #0
    ST2 { V22.2S, V23.2S }, [X7], X24
    LD2 { V8.4H, V9.4H }, [X7], X24
    ADD  X7, X7, X28
    ST2 { V3.2S, V4.2S }, [X7], X24
    LD2 { V9.2S, V10.2S }, [X7], X24
    ADD  X7, X7, X28
    ST2 { V13.4H, V14.4H }, [X7], X24
    LD2 { V15.4H, V16.4H }, [X7], X24
    ADD  X7, X7, X28, LSR #0
    ST2 { V15.8B, V16.8B }, [X7], X24
    LD2 { V23.8B, V24.8B }, [X7], X24
    ADD  X7, X7, X28, ASR #0
    ST2 { V23.H, V24.H }[0x4], [X7]
    LD2 { V24.H, V25.H }[0x4], [X7]
    ADD  X7, X7, X28, LSR #0
    ST2 { V24.S, V25.S }[0x1], [X7]
    LD2 { V17.S, V18.S }[0x3], [X7]
    ADD  X7, X7, X28, ASR #0
    ST2 { V9.D, V10.D }[0x1], [X7]
    LD2 { V28.D, V29.D }[0x0], [X7]
    ADD  X7, X7, X28, LSR #0
    ST2 { V17.B, V18.B }[0xf], [X7]
    LD2 { V3.B, V4.B }[0x7], [X7]
    ADD  X7, X7, X28, ASR #0
    MOV  X25, X7
    ST2 { V28.H, V29.H }[0x7], [X25], #4
    MOV  X25, X7
    LD2 { V24.H, V25.H }[0x5], [X25], #4
    ADD  X7, X7, X28, ASR #0
    ST2 { V3.H, V4.H }[0x5], [X7], X24
    LD2 { V9.H, V10.H }[0x2], [X7], X24
    ADD  X7, X7, X28, ASR #0
    MOV  X25, X7
    ST2 { V24.S, V25.S }[0x2], [X25], #8
    MOV  X25, X7
    LD2 { V3.S, V4.S }[0x3], [X25], #8
    ADD  X7, X7, X28, LSR #0
    ST2 { V3.S, V4.S }[0x0], [X7], X24
    LD2 { V3.S, V4.S }[0x2], [X7], X24
    ADD  X7, X7, X28
    MOV  X25, X7
    ST2 { V9.D, V10.D }[0x0], [X25], #16
    MOV  X25, X7
    LD2 { V9.D, V10.D }[0x0], [X25], #16
    ADD  X7, X7, X28
    ST2 { V3.D, V4.D }[0x1], [X7], X24
    LD2 { V3.D, V4.D }[0x0], [X7], X24
    ADD  X7, X7, X28, LSR #0
    MOV  X25, X7
    ST2 { V9.B, V10.B }[0xf], [X25], #2
    MOV  X25, X7
    LD2 { V9.B, V10.B }[0x8], [X25], #2
    ADD  X7, X7, X28, ASR #0
    ST2 { V4.B, V5.B }[0x7], [X7], X24
    LD2 { V4.B, V5.B }[0x6], [X7], X24
    ADD  X7, X7, X28, LSR #0
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X23, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X23, FPSR
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V0.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D0
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V1.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D1
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V2.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D2
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X23, V3.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X23, D3
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X23, V4.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    FMOV  X23, D4
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V5.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D5
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V6.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D6
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V7.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D7
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D8
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D9
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V10.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D10
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V11.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D11
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V12.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D12
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V13.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D13
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V14.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D14
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D15
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D16
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V17.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D17
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V18.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D18
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V19.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D19
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V20.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D20
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V21.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D21
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V22.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D22
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D23
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V24.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D24
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D25
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D26
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V27.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D27
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V28.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D28
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X23, D29
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V30.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D30
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, V31.D[1]
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X23, D31
    SUB  X16, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X23
    FMOV  D3, X26
    FMOV  V3.D[1], X17
    FMOV  D4, X25
    FMOV  V4.D[1], X19
    FMOV  D5, X26
    FMOV  V5.D[1], X20
    FMOV  D6, X14
    FMOV  V6.D[1], X3
    FMOV  D7, X18
    FMOV  V7.D[1], X20
    FMOV  D8, X19
    FMOV  V8.D[1], X11
    FMOV  D9, X6
    FMOV  V9.D[1], X13
    FMOV  D10, X10
    FMOV  V10.D[1], X26
    FMOV  D11, X22
    FMOV  V11.D[1], X24
    FMOV  D12, X8
    FMOV  V12.D[1], X27
    FMOV  D13, X29
    FMOV  V13.D[1], X28
    FMOV  D14, X14
    FMOV  V14.D[1], X14
    FMOV  D15, X19
    FMOV  V15.D[1], X10
    FMOV  D16, X23
    FMOV  V16.D[1], X7
    FMOV  D17, X14
    FMOV  V17.D[1], X11
    FMOV  D18, X6
    FMOV  V18.D[1], X3
    FMOV  D19, X7
    FMOV  V19.D[1], X3
    FMOV  D20, X27
    FMOV  V20.D[1], X10
    FMOV  D21, X8
    FMOV  V21.D[1], X3
    FMOV  D22, X5
    FMOV  V22.D[1], X16
    FMOV  D23, X13
    FMOV  V23.D[1], X20
    FMOV  D24, X10
    FMOV  V24.D[1], X28
    FMOV  D25, X9
    FMOV  V25.D[1], X24
    FMOV  D26, X22
    FMOV  V26.D[1], X25
    FMOV  D27, X22
    FMOV  V27.D[1], X2
    FMOV  D28, X26
    FMOV  V28.D[1], X3
    FMOV  D29, X13
    FMOV  V29.D[1], X11
    FMOV  D30, X13
    FMOV  V30.D[1], X17
    FMOV  D31, X19
    FMOV  V31.D[1], X6
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X26, #0xa00, LSL #0
    ADD  X27, X30, X26, LSR #0
    ST2 { V25.8H, V26.8H }, [X27]
    LD2 { V30.4S, V31.4S }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST2 { V16.16B, V17.16B }, [X27]
    LD2 { V22.16B, V23.16B }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST2 { V22.2D, V23.2D }, [X27]
    LD2 { V31.2D, V0.2D }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST2 { V29.4S, V30.4S }, [X27]
    LD2 { V18.4S, V19.4S }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST2 { V18.8H, V19.8H }, [X27]
    LD2 { V27.8H, V28.8H }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST2 { V27.2S, V28.2S }, [X27]
    LD2 { V24.2S, V25.2S }, [X27]
    ADD  X27, X27, X29
    ST2 { V31.2S, V0.2S }, [X27]
    LD2 { V4.2S, V5.2S }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST2 { V24.4H, V25.4H }, [X27]
    LD2 { V16.4H, V17.4H }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST2 { V4.8B, V5.8B }, [X27]
    LD2 { V24.8B, V25.8B }, [X27]
    ADD  X27, X27, X29, ASR #0
    MOV  X9, X27
    ST2 { V16.16B, V17.16B }, [X9], #32
    MOV  X9, X27
    LD2 { V31.2D, V0.2D }, [X9], #32
    ADD  X27, X27, X29
    MOV  X9, X27
    ST2 { V24.16B, V25.16B }, [X9], #32
    MOV  X9, X27
    LD2 { V27.16B, V28.16B }, [X9], #32
    ADD  X27, X27, X29, LSR #0
    MOV  X9, X27
    ST2 { V17.2D, V18.2D }, [X9], #32
    MOV  X9, X27
    LD2 { V4.2D, V5.2D }, [X9], #32
    ADD  X27, X27, X29, LSR #0
    MOV  X9, X27
    ST2 { V4.4S, V5.4S }, [X9], #32
    MOV  X9, X27
    LD2 { V17.4S, V18.4S }, [X9], #32
    ADD  X27, X27, X29, LSR #0
    MOV  X9, X27
    ST2 { V27.8H, V28.8H }, [X9], #32
    MOV  X9, X27
    LD2 { V24.8H, V25.8H }, [X9], #32
    ADD  X27, X27, X29
    MOV  X9, X27
    ST2 { V17.2S, V18.2S }, [X9], #16
    MOV  X9, X27
    LD2 { V4.2S, V5.2S }, [X9], #16
    ADD  X27, X27, X29
    MOV  X9, X27
    ST2 { V4.2S, V5.2S }, [X9], #16
    MOV  X9, X27
    LD2 { V4.2S, V5.2S }, [X9], #16
    ADD  X27, X27, X29
    MOV  X9, X27
    ST2 { V24.4H, V25.4H }, [X9], #16
    MOV  X9, X27
    LD2 { V17.4H, V18.4H }, [X9], #16
    ADD  X27, X27, X29
    MOV  X9, X27
    ST2 { V4.8B, V5.8B }, [X9], #16
    MOV  X9, X27
    LD2 { V4.8B, V5.8B }, [X9], #16
    ADD  X27, X27, X29, LSR #0
    ST2 { V3.8H, V4.8H }, [X27], X23
    LD2 { V3.16B, V4.16B }, [X27], X23
    ADD  X27, X27, X29
    ST2 { V16.16B, V17.16B }, [X27], X23
    LD2 { V16.16B, V17.16B }, [X27], X23
    ADD  X27, X27, X29
    ST2 { V2.2D, V3.2D }, [X27], X23
    LD2 { V2.2D, V3.2D }, [X27], X23
    ADD  X27, X27, X29, ASR #0
    ST2 { V14.4S, V15.4S }, [X27], X23
    LD2 { V20.4S, V21.4S }, [X27], X23
    ADD  X27, X27, X29
    ST2 { V16.8H, V17.8H }, [X27], X23
    LD2 { V31.8H, V0.8H }, [X27], X23
    ADD  X27, X27, X29
    ST2 { V4.8B, V5.8B }, [X27], X23
    LD2 { V1.8B, V2.8B }, [X27], X23
    ADD  X27, X27, X29
    ST2 { V9.2S, V10.2S }, [X27], X23
    LD2 { V31.2S, V0.2S }, [X27], X23
    ADD  X27, X27, X29, ASR #0
    ST2 { V31.4H, V0.4H }, [X27], X23
    LD2 { V8.4H, V9.4H }, [X27], X23
    ADD  X27, X27, X29, ASR #0
    ST2 { V8.8B, V9.8B }, [X27], X23
    LD2 { V22.8B, V23.8B }, [X27], X23
    ADD  X27, X27, X29
    ST2 { V10.H, V11.H }[0x5], [X27]
    LD2 { V20.H, V21.H }[0x3], [X27]
    ADD  X27, X27, X29, LSR #0
    ST2 { V22.S, V23.S }[0x2], [X27]
    LD2 { V6.S, V7.S }[0x0], [X27]
    ADD  X27, X27, X29
    ST2 { V6.D, V7.D }[0x0], [X27]
    LD2 { V8.D, V9.D }[0x1], [X27]
    ADD  X27, X27, X29, LSR #0
    ST2 { V20.B, V21.B }[0x3], [X27]
    LD2 { V14.B, V15.B }[0x2], [X27]
    ADD  X27, X27, X29, LSR #0
    MOV  X9, X27
    ST2 { V8.H, V9.H }[0x2], [X9], #4
    MOV  X9, X27
    LD2 { V10.H, V11.H }[0x1], [X9], #4
    ADD  X27, X27, X29, LSR #0
    ST2 { V14.H, V15.H }[0x6], [X27], X23
    LD2 { V6.H, V7.H }[0x5], [X27], X23
    ADD  X27, X27, X29, LSR #0
    MOV  X9, X27
    ST2 { V6.S, V7.S }[0x2], [X9], #8
    MOV  X9, X27
    LD2 { V22.S, V23.S }[0x2], [X9], #8
    ADD  X27, X27, X29, ASR #0
    ST2 { V10.S, V11.S }[0x2], [X27], X23
    LD2 { V6.S, V7.S }[0x3], [X27], X23
    ADD  X27, X27, X29, LSR #0
    MOV  X9, X27
    ST2 { V22.D, V23.D }[0x1], [X9], #16
    MOV  X9, X27
    LD2 { V20.D, V21.D }[0x0], [X9], #16
    ADD  X27, X27, X29, ASR #0
    ST2 { V20.D, V21.D }[0x0], [X27], X23
    LD2 { V22.D, V23.D }[0x0], [X27], X23
    ADD  X27, X27, X29, LSR #0
    MOV  X9, X27
    ST2 { V22.B, V23.B }[0x2], [X9], #2
    MOV  X9, X27
    LD2 { V21.B, V22.B }[0xf], [X9], #2
    ADD  X27, X27, X29, ASR #0
    ST2 { V6.B, V7.B }[0x1], [X27], X23
    LD2 { V6.B, V7.B }[0x4], [X27], X23
    ADD  X27, X27, X29
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X3
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X11
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X13
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X19
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X20
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    SUB  X2, X25, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    MRS  X2, FPSR
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V0.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D0
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V1.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D1
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V2.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D2
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a, LSL #0
    MOVK  X25, #0x5a, LSL #16
    MOVK  X25, #0x5a, LSL #32
    MOVK  X25, #0x5a, LSL #48
    FMOV  X2, V3.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D3
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a, LSL #0
    MOVK  X25, #0x5a, LSL #16
    MOVK  X25, #0x5a, LSL #32
    MOVK  X25, #0x5a, LSL #48
    FMOV  X2, V4.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D4
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V5.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D5
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V6.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a00, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D6
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V7.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a00, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D7
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V8.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D8
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V9.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D9
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V10.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D10
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V11.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D11
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V12.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D12
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V13.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D13
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V14.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D14
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V15.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D15
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V16.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D16
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V17.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D17
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V18.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D18
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V19.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D19
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V20.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X2, D20
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V21.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X2, D21
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a00, LSL #48
    FMOV  X2, V22.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X2, D22
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X2, V23.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    FMOV  X2, D23
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V24.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D24
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V25.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D25
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V26.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D26
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V27.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D27
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V28.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D28
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V29.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D29
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, V30.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D30
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x0, LSL #0
    FMOV  X2, V31.D[1]
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X25, #0x5a5a, LSL #0
    MOVK  X25, #0x5a5a, LSL #16
    MOVK  X25, #0x5a5a, LSL #32
    MOVK  X25, #0x5a5a, LSL #48
    FMOV  X2, D31
    SUB  X8, X25, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X19
    FMOV  D3, X7
    FMOV  V3.D[1], X27
    FMOV  D4, X10
    FMOV  V4.D[1], X17
    FMOV  D5, X18
    FMOV  V5.D[1], X27
    FMOV  D6, X8
    FMOV  V6.D[1], X13
    FMOV  D7, X23
    FMOV  V7.D[1], X7
    FMOV  D8, X26
    FMOV  V8.D[1], X11
    FMOV  D9, X29
    FMOV  V9.D[1], X5
    FMOV  D10, X23
    FMOV  V10.D[1], X10
    FMOV  D11, X23
    FMOV  V11.D[1], X26
    FMOV  D12, X17
    FMOV  V12.D[1], X22
    FMOV  D13, X8
    FMOV  V13.D[1], X28
    FMOV  D14, X19
    FMOV  V14.D[1], X7
    FMOV  D15, X18
    FMOV  V15.D[1], X10
    FMOV  D16, X16
    FMOV  V16.D[1], X5
    FMOV  D17, X7
    FMOV  V17.D[1], X14
    FMOV  D18, X9
    FMOV  V18.D[1], X25
    FMOV  D19, X27
    FMOV  V19.D[1], X13
    FMOV  D20, X3
    FMOV  V20.D[1], X27
    FMOV  D21, X7
    FMOV  V21.D[1], X25
    FMOV  D22, X27
    FMOV  V22.D[1], X19
    FMOV  D23, X2
    FMOV  V23.D[1], X29
    FMOV  D24, X5
    FMOV  V24.D[1], X20
    FMOV  D25, X9
    FMOV  V25.D[1], X18
    FMOV  D26, X22
    FMOV  V26.D[1], X16
    FMOV  D27, X18
    FMOV  V27.D[1], X16
    FMOV  D28, X6
    FMOV  V28.D[1], X11
    FMOV  D29, X16
    FMOV  V29.D[1], X13
    FMOV  D30, X7
    FMOV  V30.D[1], X29
    FMOV  D31, X10
    FMOV  V31.D[1], X18
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X17, #0xf00, LSL #0
    ADD  X3, X30, X17, LSR #0
    ST2 { V24.8H, V25.8H }, [X3]
    LD2 { V4.16B, V5.16B }, [X3]
    ADD  X3, X3, X8, ASR #0
    ST2 { V4.16B, V5.16B }, [X3]
    LD2 { V29.16B, V30.16B }, [X3]
    ADD  X3, X3, X8, ASR #0
    ST2 { V28.2D, V29.2D }, [X3]
    LD2 { V13.2D, V14.2D }, [X3]
    ADD  X3, X3, X8
    ST2 { V11.4S, V12.4S }, [X3]
    LD2 { V2.4S, V3.4S }, [X3]
    ADD  X3, X3, X8, LSR #0
    ST2 { V7.8H, V8.8H }, [X3]
    LD2 { V12.8H, V13.8H }, [X3]
    ADD  X3, X3, X8
    ST2 { V3.4H, V4.4H }, [X3]
    LD2 { V19.2S, V20.2S }, [X3]
    ADD  X3, X3, X8
    ST2 { V28.2S, V29.2S }, [X3]
    LD2 { V12.2S, V13.2S }, [X3]
    ADD  X3, X3, X8
    ST2 { V13.4H, V14.4H }, [X3]
    LD2 { V29.4H, V30.4H }, [X3]
    ADD  X3, X3, X8, ASR #0
    ST2 { V29.8B, V30.8B }, [X3]
    LD2 { V18.8B, V19.8B }, [X3]
    ADD  X3, X3, X8
    MOV  X11, X3
    ST2 { V19.2D, V20.2D }, [X11], #32
    MOV  X11, X3
    LD2 { V19.2D, V20.2D }, [X11], #32
    ADD  X3, X3, X8
    MOV  X11, X3
    ST2 { V18.16B, V19.16B }, [X11], #32
    MOV  X11, X3
    LD2 { V7.16B, V8.16B }, [X11], #32
    ADD  X3, X3, X8, ASR #0
    MOV  X11, X3
    ST2 { V21.2D, V22.2D }, [X11], #32
    MOV  X11, X3
    LD2 { V18.2D, V19.2D }, [X11], #32
    ADD  X3, X3, X8, LSR #0
    MOV  X11, X3
    ST2 { V18.4S, V19.4S }, [X11], #32
    MOV  X11, X3
    LD2 { V21.4S, V22.4S }, [X11], #32
    ADD  X3, X3, X8, ASR #0
    MOV  X11, X3
    ST2 { V8.8H, V9.8H }, [X11], #32
    MOV  X11, X3
    LD2 { V8.8H, V9.8H }, [X11], #32
    ADD  X3, X3, X8
    MOV  X11, X3
    ST2 { V21.2S, V22.2S }, [X11], #16
    MOV  X11, X3
    LD2 { V21.4H, V22.4H }, [X11], #16
    ADD  X3, X3, X8, LSR #0
    MOV  X11, X3
    ST2 { V8.2S, V9.2S }, [X11], #16
    MOV  X11, X3
    LD2 { V30.2S, V31.2S }, [X11], #16
    ADD  X3, X3, X8
    MOV  X11, X3
    ST2 { V30.4H, V31.4H }, [X11], #16
    MOV  X11, X3
    LD2 { V9.4H, V10.4H }, [X11], #16
    ADD  X3, X3, X8
    MOV  X11, X3
    ST2 { V9.8B, V10.8B }, [X11], #16
    MOV  X11, X3
    LD2 { V26.8B, V27.8B }, [X11], #16
    ADD  X3, X3, X8, ASR #0
    ST2 { V21.2D, V22.2D }, [X3], X20
    LD2 { V15.2D, V16.2D }, [X3], X20
    ADD  X3, X3, X8, LSR #0
    ST2 { V15.16B, V16.16B }, [X3], X20
    LD2 { V21.16B, V22.16B }, [X3], X20
    ADD  X3, X3, X8
    ST2 { V26.2D, V27.2D }, [X3], X20
    LD2 { V21.2D, V22.2D }, [X3], X20
    ADD  X3, X3, X8, LSR #0
    ST2 { V21.4S, V22.4S }, [X3], X20
    LD2 { V4.4S, V5.4S }, [X3], X20
    ADD  X3, X3, X8
    ST2 { V24.8H, V25.8H }, [X3], X20
    LD2 { V6.8H, V7.8H }, [X3], X20
    ADD  X3, X3, X8
    ST2 { V21.4H, V22.4H }, [X3], X20
    LD2 { V19.8B, V20.8B }, [X3], X20
    ADD  X3, X3, X8, LSR #0
    ST2 { V30.2S, V31.2S }, [X3], X20
    LD2 { V6.2S, V7.2S }, [X3], X20
    ADD  X3, X3, X8
    ST2 { V18.4H, V19.4H }, [X3], X20
    LD2 { V2.4H, V3.4H }, [X3], X20
    ADD  X3, X3, X8
    ST2 { V20.8B, V21.8B }, [X3], X20
    LD2 { V9.8B, V10.8B }, [X3], X20
    ADD  X3, X3, X8, LSR #0
    ST2 { V13.H, V14.H }[0x1], [X3]
    LD2 { V24.H, V25.H }[0x3], [X3]
    ADD  X3, X3, X8
    ST2 { V4.S, V5.S }[0x3], [X3]
    LD2 { V18.S, V19.S }[0x0], [X3]
    ADD  X3, X3, X8, ASR #0
    ST2 { V2.D, V3.D }[0x0], [X3]
    LD2 { V2.D, V3.D }[0x1], [X3]
    ADD  X3, X3, X8, LSR #0
    ST2 { V0.B, V1.B }[0x2], [X3]
    LD2 { V13.B, V14.B }[0xf], [X3]
    ADD  X3, X3, X8
    MOV  X11, X3
    ST2 { V9.H, V10.H }[0x6], [X11], #4
    MOV  X11, X3
    LD2 { V4.H, V5.H }[0x3], [X11], #4
    ADD  X3, X3, X8
    ST2 { V6.H, V7.H }[0x3], [X3], X20
    LD2 { V6.H, V7.H }[0x7], [X3], X20
    ADD  X3, X3, X8
    MOV  X11, X3
    ST2 { V15.S, V16.S }[0x1], [X11], #8
    MOV  X11, X3
    LD2 { V20.S, V21.S }[0x2], [X11], #8
    ADD  X3, X3, X8
    ST2 { V4.S, V5.S }[0x0], [X3], X20
    LD2 { V0.S, V1.S }[0x2], [X3], X20
    ADD  X3, X3, X8
    MOV  X11, X3
    ST2 { V6.D, V7.D }[0x0], [X11], #16
    MOV  X11, X3
    LD2 { V6.D, V7.D }[0x1], [X11], #16
    ADD  X3, X3, X8, ASR #0
    ST2 { V6.D, V7.D }[0x1], [X3], X20
    LD2 { V4.D, V5.D }[0x1], [X3], X20
    ADD  X3, X3, X8, LSR #0
    MOV  X11, X3
    ST2 { V20.B, V21.B }[0xb], [X11], #2
    MOV  X11, X3
    LD2 { V20.B, V21.B }[0x4], [X11], #2
    ADD  X3, X3, X8, ASR #0
    ST2 { V4.B, V5.B }[0x4], [X3], X20
    LD2 { V6.B, V7.B }[0xa], [X3], X20
    ADD  X3, X3, X8, ASR #0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D0
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V1.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D1
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D2
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V3.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D3
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V4.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    FMOV  X18, D4
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V5.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    FMOV  X18, D5
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D6
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V7.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D7
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D8
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V9.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D9
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V10.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D10
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D11
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D12
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #48
    FMOV  X18, V13.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D13
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V14.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D14
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D15
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V16.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D16
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V17.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D17
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V18.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D18
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V19.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D19
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    FMOV  X18, V20.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D20
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    FMOV  X18, V21.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D21
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D22
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V23.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D23
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V24.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D24
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V25.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D25
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V26.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D26
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D27
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D28
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D29
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V30.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D30
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X18, V31.D[1]
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X18, D31
    SUB  X5, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X17
    FMOV  V2.D[1], X7
    FMOV  D3, X24
    FMOV  V3.D[1], X26
    FMOV  D4, X8
    FMOV  V4.D[1], X13
    FMOV  D5, X25
    FMOV  V5.D[1], X22
    FMOV  D6, X19
    FMOV  V6.D[1], X7
    FMOV  D7, X16
    FMOV  V7.D[1], X26
    FMOV  D8, X10
    FMOV  V8.D[1], X29
    FMOV  D9, X2
    FMOV  V9.D[1], X10
    FMOV  D10, X29
    FMOV  V10.D[1], X24
    FMOV  D11, X20
    FMOV  V11.D[1], X25
    FMOV  D12, X5
    FMOV  V12.D[1], X10
    FMOV  D13, X10
    FMOV  V13.D[1], X9
    FMOV  D14, X16
    FMOV  V14.D[1], X25
    FMOV  D15, X25
    FMOV  V15.D[1], X7
    FMOV  D16, X14
    FMOV  V16.D[1], X7
    FMOV  D17, X11
    FMOV  V17.D[1], X25
    FMOV  D18, X23
    FMOV  V18.D[1], X28
    FMOV  D19, X3
    FMOV  V19.D[1], X18
    FMOV  D20, X27
    FMOV  V20.D[1], X18
    FMOV  D21, X10
    FMOV  V21.D[1], X11
    FMOV  D22, X20
    FMOV  V22.D[1], X13
    FMOV  D23, X8
    FMOV  V23.D[1], X27
    FMOV  D24, X9
    FMOV  V24.D[1], X27
    FMOV  D25, X5
    FMOV  V25.D[1], X18
    FMOV  D26, X18
    FMOV  V26.D[1], X13
    FMOV  D27, X25
    FMOV  V27.D[1], X27
    FMOV  D28, X14
    FMOV  V28.D[1], X6
    FMOV  D29, X17
    FMOV  V29.D[1], X23
    FMOV  D30, X11
    FMOV  V30.D[1], X27
    FMOV  D31, X14
    FMOV  V31.D[1], X29
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X16, #0x1400, LSL #0
    ADD  X28, X30, X16, LSR #0
    ST2 { V26.16B, V27.16B }, [X28]
    LD2 { V30.16B, V31.16B }, [X28]
    ADD  X28, X28, X2
    ST2 { V4.16B, V5.16B }, [X28]
    LD2 { V1.16B, V2.16B }, [X28]
    ADD  X28, X28, X2
    ST2 { V5.2D, V6.2D }, [X28]
    LD2 { V0.2D, V1.2D }, [X28]
    ADD  X28, X28, X2, ASR #0
    ST2 { V28.4S, V29.4S }, [X28]
    LD2 { V10.4S, V11.4S }, [X28]
    ADD  X28, X28, X2, LSR #0
    ST2 { V30.8H, V31.8H }, [X28]
    LD2 { V24.8H, V25.8H }, [X28]
    ADD  X28, X28, X2, ASR #0
    ST2 { V6.4H, V7.4H }, [X28]
    LD2 { V18.8B, V19.8B }, [X28]
    ADD  X28, X28, X2, ASR #0
    ST2 { V18.2S, V19.2S }, [X28]
    LD2 { V8.2S, V9.2S }, [X28]
    ADD  X28, X28, X2
    ST2 { V8.4H, V9.4H }, [X28]
    LD2 { V20.4H, V21.4H }, [X28]
    ADD  X28, X28, X2
    ST2 { V20.8B, V21.8B }, [X28]
    LD2 { V6.8B, V7.8B }, [X28]
    ADD  X28, X28, X2, ASR #0
    MOV  X29, X28
    ST2 { V6.2D, V7.2D }, [X29], #32
    MOV  X29, X28
    LD2 { V6.8H, V7.8H }, [X29], #32
    ADD  X28, X28, X2, ASR #0
    MOV  X29, X28
    ST2 { V10.16B, V11.16B }, [X29], #32
    MOV  X29, X28
    LD2 { V10.16B, V11.16B }, [X29], #32
    ADD  X28, X28, X2
    MOV  X29, X28
    ST2 { V6.2D, V7.2D }, [X29], #32
    MOV  X29, X28
    LD2 { V6.2D, V7.2D }, [X29], #32
    ADD  X28, X28, X2, LSR #0
    MOV  X29, X28
    ST2 { V10.4S, V11.4S }, [X29], #32
    MOV  X29, X28
    LD2 { V10.4S, V11.4S }, [X29], #32
    ADD  X28, X28, X2
    MOV  X29, X28
    ST2 { V10.8H, V11.8H }, [X29], #32
    MOV  X29, X28
    LD2 { V10.8H, V11.8H }, [X29], #32
    ADD  X28, X28, X2, LSR #0
    MOV  X29, X28
    ST2 { V6.2S, V7.2S }, [X29], #16
    MOV  X29, X28
    LD2 { V6.8B, V7.8B }, [X29], #16
    ADD  X28, X28, X2, ASR #0
    MOV  X29, X28
    ST2 { V10.2S, V11.2S }, [X29], #16
    MOV  X29, X28
    LD2 { V25.2S, V26.2S }, [X29], #16
    ADD  X28, X28, X2
    MOV  X29, X28
    ST2 { V25.4H, V26.4H }, [X29], #16
    MOV  X29, X28
    LD2 { V24.4H, V25.4H }, [X29], #16
    ADD  X28, X28, X2
    MOV  X29, X28
    ST2 { V6.8B, V7.8B }, [X29], #16
    MOV  X29, X28
    LD2 { V14.8B, V15.8B }, [X29], #16
    ADD  X28, X28, X2, ASR #0
    ST2 { V14.4S, V15.4S }, [X28], X24
    LD2 { V4.2D, V5.2D }, [X28], X24
    ADD  X28, X28, X2
    ST2 { V4.16B, V5.16B }, [X28], X24
    LD2 { V3.16B, V4.16B }, [X28], X24
    ADD  X28, X28, X2
    ST2 { V3.2D, V4.2D }, [X28], X24
    LD2 { V13.2D, V14.2D }, [X28], X24
    ADD  X28, X28, X2, ASR #0
    ST2 { V24.4S, V25.4S }, [X28], X24
    LD2 { V29.4S, V30.4S }, [X28], X24
    ADD  X28, X28, X2, LSR #0
    ST2 { V13.8H, V14.8H }, [X28], X24
    LD2 { V20.8H, V21.8H }, [X28], X24
    ADD  X28, X28, X2, LSR #0
    ST2 { V29.8B, V30.8B }, [X28], X24
    LD2 { V27.8B, V28.8B }, [X28], X24
    ADD  X28, X28, X2, ASR #0
    ST2 { V15.2S, V16.2S }, [X28], X24
    LD2 { V13.2S, V14.2S }, [X28], X24
    ADD  X28, X28, X2, ASR #0
    ST2 { V20.4H, V21.4H }, [X28], X24
    LD2 { V3.4H, V4.4H }, [X28], X24
    ADD  X28, X28, X2, ASR #0
    ST2 { V3.8B, V4.8B }, [X28], X24
    LD2 { V24.8B, V25.8B }, [X28], X24
    ADD  X28, X28, X2
    ST2 { V13.H, V14.H }[0x0], [X28]
    LD2 { V28.H, V29.H }[0x0], [X28]
    ADD  X28, X28, X2, ASR #0
    ST2 { V24.S, V25.S }[0x0], [X28]
    LD2 { V13.S, V14.S }[0x1], [X28]
    ADD  X28, X28, X2
    ST2 { V13.D, V14.D }[0x1], [X28]
    LD2 { V13.D, V14.D }[0x1], [X28]
    ADD  X28, X28, X2
    ST2 { V28.B, V29.B }[0x7], [X28]
    LD2 { V19.B, V20.B }[0xe], [X28]
    ADD  X28, X28, X2
    MOV  X29, X28
    ST2 { V19.H, V20.H }[0x3], [X29], #4
    MOV  X29, X28
    LD2 { V15.H, V16.H }[0x0], [X29], #4
    ADD  X28, X28, X2
    ST2 { V15.H, V16.H }[0x7], [X28], X24
    LD2 { V19.H, V20.H }[0x1], [X28], X24
    ADD  X28, X28, X2
    MOV  X29, X28
    ST2 { V18.S, V19.S }[0x3], [X29], #8
    MOV  X29, X28
    LD2 { V28.S, V29.S }[0x2], [X29], #8
    ADD  X28, X28, X2
    ST2 { V28.S, V29.S }[0x2], [X28], X24
    LD2 { V15.S, V16.S }[0x0], [X28], X24
    ADD  X28, X28, X2, LSR #0
    MOV  X29, X28
    ST2 { V13.D, V14.D }[0x0], [X29], #16
    MOV  X29, X28
    LD2 { V18.D, V19.D }[0x0], [X29], #16
    ADD  X28, X28, X2, ASR #0
    ST2 { V15.D, V16.D }[0x1], [X28], X24
    LD2 { V28.D, V29.D }[0x1], [X28], X24
    ADD  X28, X28, X2, LSR #0
    MOV  X29, X28
    ST2 { V18.B, V19.B }[0x6], [X29], #2
    MOV  X29, X28
    LD2 { V15.B, V16.B }[0xd], [X29], #2
    ADD  X28, X28, X2, ASR #0
    ST2 { V15.B, V16.B }[0xc], [X28], X24
    LD2 { V31.B, V0.B }[0xe], [X28], X24
    ADD  X28, X28, X2
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X8, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V0.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D0
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V1.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D1
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V2.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D2
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D3
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V4.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D4
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V5.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D5
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V6.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D6
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V7.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D7
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D8
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V9.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D9
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V10.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D10
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V11.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D11
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V12.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D12
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V13.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D13
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V14.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D14
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a00, LSL #32
    FMOV  X8, V15.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D15
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V16.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D16
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V17.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D17
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V18.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D18
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a, LSL #48
    FMOV  X8, V19.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D19
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a, LSL #48
    FMOV  X8, V20.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D20
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V21.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D21
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V22.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D22
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V23.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D23
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D24
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D25
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V26.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D26
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D27
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D28
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, V29.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D29
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D30
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a00, LSL #48
    FMOV  X8, V31.D[1]
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    FMOV  X8, D31
    SUB  X14, X20, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X23
    FMOV  D2, X29
    FMOV  V2.D[1], X2
    FMOV  D3, X29
    FMOV  V3.D[1], X24
    FMOV  D4, X8
    FMOV  V4.D[1], X29
    FMOV  D5, X17
    FMOV  V5.D[1], X14
    FMOV  D6, X23
    FMOV  V6.D[1], X18
    FMOV  D7, X14
    FMOV  V7.D[1], X17
    FMOV  D8, X17
    FMOV  V8.D[1], X24
    FMOV  D9, X11
    FMOV  V9.D[1], X8
    FMOV  D10, X23
    FMOV  V10.D[1], X14
    FMOV  D11, X5
    FMOV  V11.D[1], X14
    FMOV  D12, X17
    FMOV  V12.D[1], X16
    FMOV  D13, X14
    FMOV  V13.D[1], X7
    FMOV  D14, X16
    FMOV  V14.D[1], X26
    FMOV  D15, X13
    FMOV  V15.D[1], X25
    FMOV  D16, X14
    FMOV  V16.D[1], X24
    FMOV  D17, X20
    FMOV  V17.D[1], X5
    FMOV  D18, X3
    FMOV  V18.D[1], X18
    FMOV  D19, X3
    FMOV  V19.D[1], X3
    FMOV  D20, X16
    FMOV  V20.D[1], X27
    FMOV  D21, X16
    FMOV  V21.D[1], X28
    FMOV  D22, X17
    FMOV  V22.D[1], X18
    FMOV  D23, X23
    FMOV  V23.D[1], X5
    FMOV  D24, X20
    FMOV  V24.D[1], X25
    FMOV  D25, X3
    FMOV  V25.D[1], X9
    FMOV  D26, X18
    FMOV  V26.D[1], X20
    FMOV  D27, X6
    FMOV  V27.D[1], X11
    FMOV  D28, X6
    FMOV  V28.D[1], X24
    FMOV  D29, X14
    FMOV  V29.D[1], X17
    FMOV  D30, X13
    FMOV  V30.D[1], X5
    FMOV  D31, X22
    FMOV  V31.D[1], X29
    MOVZ  X3, #0x0, LSL #0
    MOVZ  X9, #0x40, LSL #0
    MOVZ  X17, #0x1900, LSL #0
    ADD  X2, X30, X17, ASR #0
    ST2 { V26.4S, V27.4S }, [X2]
    LD2 { V8.4S, V9.4S }, [X2]
    ADD  X2, X2, X9, ASR #0
    ST2 { V23.16B, V24.16B }, [X2]
    LD2 { V20.16B, V21.16B }, [X2]
    ADD  X2, X2, X9
    ST2 { V31.2D, V0.2D }, [X2]
    LD2 { V20.2D, V21.2D }, [X2]
    ADD  X2, X2, X9, ASR #0
    ST2 { V28.4S, V29.4S }, [X2]
    LD2 { V1.4S, V2.4S }, [X2]
    ADD  X2, X2, X9
    ST2 { V8.8H, V9.8H }, [X2]
    LD2 { V14.8H, V15.8H }, [X2]
    ADD  X2, X2, X9, ASR #0
    ST2 { V20.8B, V21.8B }, [X2]
    LD2 { V31.2S, V0.2S }, [X2]
    ADD  X2, X2, X9, LSR #0
    ST2 { V31.2S, V0.2S }, [X2]
    LD2 { V31.2S, V0.2S }, [X2]
    ADD  X2, X2, X9, LSR #0
    ST2 { V1.4H, V2.4H }, [X2]
    LD2 { V12.4H, V13.4H }, [X2]
    ADD  X2, X2, X9
    ST2 { V31.8B, V0.8B }, [X2]
    LD2 { V5.8B, V6.8B }, [X2]
    ADD  X2, X2, X9, LSR #0
    MOV  X25, X2
    ST2 { V14.4S, V15.4S }, [X25], #32
    MOV  X25, X2
    LD2 { V20.8H, V21.8H }, [X25], #32
    ADD  X2, X2, X9, LSR #0
    MOV  X25, X2
    ST2 { V20.16B, V21.16B }, [X25], #32
    MOV  X25, X2
    LD2 { V14.16B, V15.16B }, [X25], #32
    ADD  X2, X2, X9, LSR #0
    MOV  X25, X2
    ST2 { V13.2D, V14.2D }, [X25], #32
    MOV  X25, X2
    LD2 { V0.2D, V1.2D }, [X25], #32
    ADD  X2, X2, X9, ASR #0
    MOV  X25, X2
    ST2 { V5.4S, V6.4S }, [X25], #32
    MOV  X25, X2
    LD2 { V5.4S, V6.4S }, [X25], #32
    ADD  X2, X2, X9
    MOV  X25, X2
    ST2 { V0.8H, V1.8H }, [X25], #32
    MOV  X25, X2
    LD2 { V13.8H, V14.8H }, [X25], #32
    ADD  X2, X2, X9, LSR #0
    MOV  X25, X2
    ST2 { V5.4H, V6.4H }, [X25], #16
    MOV  X25, X2
    LD2 { V0.8B, V1.8B }, [X25], #16
    ADD  X2, X2, X9, LSR #0
    MOV  X25, X2
    ST2 { V13.2S, V14.2S }, [X25], #16
    MOV  X25, X2
    LD2 { V13.2S, V14.2S }, [X25], #16
    ADD  X2, X2, X9, LSR #0
    MOV  X25, X2
    ST2 { V13.4H, V14.4H }, [X25], #16
    MOV  X25, X2
    LD2 { V13.4H, V14.4H }, [X25], #16
    ADD  X2, X2, X9, LSR #0
    MOV  X25, X2
    ST2 { V13.8B, V14.8B }, [X25], #16
    MOV  X25, X2
    LD2 { V29.8B, V30.8B }, [X25], #16
    ADD  X2, X2, X9
    ST2 { V0.4S, V1.4S }, [X2], X3
    LD2 { V31.4S, V0.4S }, [X2], X3
    ADD  X2, X2, X9
    ST2 { V31.16B, V0.16B }, [X2], X3
    LD2 { V22.16B, V23.16B }, [X2], X3
    ADD  X2, X2, X9, LSR #0
    ST2 { V22.2D, V23.2D }, [X2], X3
    LD2 { V13.2D, V14.2D }, [X2], X3
    ADD  X2, X2, X9
    ST2 { V29.4S, V30.4S }, [X2], X3
    LD2 { V9.4S, V10.4S }, [X2], X3
    ADD  X2, X2, X9, ASR #0
    ST2 { V9.8H, V10.8H }, [X2], X3
    LD2 { V16.8H, V17.8H }, [X2], X3
    ADD  X2, X2, X9, LSR #0
    ST2 { V13.8B, V14.8B }, [X2], X3
    LD2 { V22.2S, V23.2S }, [X2], X3
    ADD  X2, X2, X9
    ST2 { V22.2S, V23.2S }, [X2], X3
    LD2 { V8.2S, V9.2S }, [X2], X3
    ADD  X2, X2, X9, ASR #0
    ST2 { V8.4H, V9.4H }, [X2], X3
    LD2 { V9.4H, V10.4H }, [X2], X3
    ADD  X2, X2, X9, LSR #0
    ST2 { V9.8B, V10.8B }, [X2], X3
    LD2 { V17.8B, V18.8B }, [X2], X3
    ADD  X2, X2, X9
    ST2 { V12.H, V13.H }[0x5], [X2]
    LD2 { V20.H, V21.H }[0x4], [X2]
    ADD  X2, X2, X9
    ST2 { V25.S, V26.S }[0x2], [X2]
    LD2 { V25.S, V26.S }[0x1], [X2]
    ADD  X2, X2, X9
    ST2 { V25.D, V26.D }[0x1], [X2]
    LD2 { V22.D, V23.D }[0x1], [X2]
    ADD  X2, X2, X9
    ST2 { V17.B, V18.B }[0xa], [X2]
    LD2 { V12.B, V13.B }[0xb], [X2]
    ADD  X2, X2, X9, LSR #0
    MOV  X25, X2
    ST2 { V20.H, V21.H }[0x7], [X25], #4
    MOV  X25, X2
    LD2 { V9.H, V10.H }[0x4], [X25], #4
    ADD  X2, X2, X9
    ST2 { V9.H, V10.H }[0x1], [X2], X3
    LD2 { V20.H, V21.H }[0x2], [X2], X3
    ADD  X2, X2, X9
    MOV  X25, X2
    ST2 { V21.S, V22.S }[0x2], [X25], #8
    MOV  X25, X2
    LD2 { V21.S, V22.S }[0x3], [X25], #8
    ADD  X2, X2, X9
    ST2 { V20.S, V21.S }[0x0], [X2], X3
    LD2 { V9.S, V10.S }[0x1], [X2], X3
    ADD  X2, X2, X9, ASR #0
    MOV  X25, X2
    ST2 { V31.D, V0.D }[0x1], [X25], #16
    MOV  X25, X2
    LD2 { V31.D, V0.D }[0x0], [X25], #16
    ADD  X2, X2, X9, LSR #0
    ST2 { V31.D, V0.D }[0x1], [X2], X3
    LD2 { V31.D, V0.D }[0x1], [X2], X3
    ADD  X2, X2, X9, LSR #0
    MOV  X25, X2
    ST2 { V9.B, V10.B }[0x2], [X25], #2
    MOV  X25, X2
    LD2 { V20.B, V21.B }[0xc], [X25], #2
    ADD  X2, X2, X9
    ST2 { V31.B, V0.B }[0x3], [X2], X3
    LD2 { V31.B, V0.B }[0x0], [X2], X3
    ADD  X2, X2, X9
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X29, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    MRS  X29, FPSR
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V0.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, D0
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V1.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D1
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V2.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D2
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V3.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D3
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V4.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D4
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V5.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D5
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V6.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D6
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V7.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D7
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V8.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D8
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    FMOV  X29, V9.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D9
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    FMOV  X29, V10.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D10
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V11.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D11
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V12.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D12
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V13.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D13
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V14.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D14
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V15.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D15
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V16.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D16
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V17.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D17
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V18.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D18
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V19.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D19
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V20.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D20
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V21.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D21
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V22.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D22
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V23.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D23
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V24.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D24
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V25.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D25
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V26.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D26
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V27.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D27
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, V28.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D28
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V29.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D29
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V30.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    FMOV  X29, D30
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, V31.D[1]
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X14, #0x0, LSL #0
    FMOV  X29, D31
    SUB  X27, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X6
    FMOV  V3.D[1], X16
    FMOV  D4, X18
    FMOV  V4.D[1], X6
    FMOV  D5, X17
    FMOV  V5.D[1], X17
    FMOV  D6, X6
    FMOV  V6.D[1], X3
    FMOV  D7, X26
    FMOV  V7.D[1], X10
    FMOV  D8, X20
    FMOV  V8.D[1], X9
    FMOV  D9, X8
    FMOV  V9.D[1], X5
    FMOV  D10, X17
    FMOV  V10.D[1], X9
    FMOV  D11, X27
    FMOV  V11.D[1], X24
    FMOV  D12, X11
    FMOV  V12.D[1], X10
    FMOV  D13, X22
    FMOV  V13.D[1], X28
    FMOV  D14, X25
    FMOV  V14.D[1], X20
    FMOV  D15, X10
    FMOV  V15.D[1], X10
    FMOV  D16, X11
    FMOV  V16.D[1], X5
    FMOV  D17, X19
    FMOV  V17.D[1], X19
    FMOV  D18, X7
    FMOV  V18.D[1], X24
    FMOV  D19, X11
    FMOV  V19.D[1], X8
    FMOV  D20, X13
    FMOV  V20.D[1], X13
    FMOV  D21, X10
    FMOV  V21.D[1], X3
    FMOV  D22, X9
    FMOV  V22.D[1], X19
    FMOV  D23, X16
    FMOV  V23.D[1], X25
    FMOV  D24, X11
    FMOV  V24.D[1], X5
    FMOV  D25, X5
    FMOV  V25.D[1], X7
    FMOV  D26, X14
    FMOV  V26.D[1], X20
    FMOV  D27, X28
    FMOV  V27.D[1], X8
    FMOV  D28, X18
    FMOV  V28.D[1], X11
    FMOV  D29, X20
    FMOV  V29.D[1], X20
    FMOV  D30, X16
    FMOV  V30.D[1], X13
    FMOV  D31, X8
    FMOV  V31.D[1], X23
    MOVZ  X5, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X26, #0x1e00, LSL #0
    ADD  X2, X30, X26, LSR #0
    ST2 { V6.4S, V7.4S }, [X2]
    LD2 { V18.4S, V19.4S }, [X2]
    ADD  X2, X2, X16
    ST2 { V22.16B, V23.16B }, [X2]
    LD2 { V5.16B, V6.16B }, [X2]
    ADD  X2, X2, X16, LSR #0
    ST2 { V5.2D, V6.2D }, [X2]
    LD2 { V19.2D, V20.2D }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST2 { V18.4S, V19.4S }, [X2]
    LD2 { V7.4S, V8.4S }, [X2]
    ADD  X2, X2, X16, LSR #0
    ST2 { V7.8H, V8.8H }, [X2]
    LD2 { V9.8H, V10.8H }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST2 { V0.4H, V1.4H }, [X2]
    LD2 { V7.2S, V8.2S }, [X2]
    ADD  X2, X2, X16, LSR #0
    ST2 { V9.2S, V10.2S }, [X2]
    LD2 { V17.2S, V18.2S }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST2 { V17.4H, V18.4H }, [X2]
    LD2 { V15.4H, V16.4H }, [X2]
    ADD  X2, X2, X16, ASR #0
    ST2 { V7.8B, V8.8B }, [X2]
    LD2 { V30.8B, V31.8B }, [X2]
    ADD  X2, X2, X16, ASR #0
    MOV  X11, X2
    ST2 { V30.4S, V31.4S }, [X11], #32
    MOV  X11, X2
    LD2 { V9.4S, V10.4S }, [X11], #32
    ADD  X2, X2, X16, LSR #0
    MOV  X11, X2
    ST2 { V9.16B, V10.16B }, [X11], #32
    MOV  X11, X2
    LD2 { V30.16B, V31.16B }, [X11], #32
    ADD  X2, X2, X16, ASR #0
    MOV  X11, X2
    ST2 { V15.2D, V16.2D }, [X11], #32
    MOV  X11, X2
    LD2 { V7.2D, V8.2D }, [X11], #32
    ADD  X2, X2, X16, LSR #0
    MOV  X11, X2
    ST2 { V30.4S, V31.4S }, [X11], #32
    MOV  X11, X2
    LD2 { V17.4S, V18.4S }, [X11], #32
    ADD  X2, X2, X16, ASR #0
    MOV  X11, X2
    ST2 { V8.8H, V9.8H }, [X11], #32
    MOV  X11, X2
    LD2 { V8.8H, V9.8H }, [X11], #32
    ADD  X2, X2, X16
    MOV  X11, X2
    ST2 { V17.8B, V18.8B }, [X11], #16
    MOV  X11, X2
    LD2 { V16.4H, V17.4H }, [X11], #16
    ADD  X2, X2, X16, ASR #0
    MOV  X11, X2
    ST2 { V16.2S, V17.2S }, [X11], #16
    MOV  X11, X2
    LD2 { V16.2S, V17.2S }, [X11], #16
    ADD  X2, X2, X16, LSR #0
    MOV  X11, X2
    ST2 { V8.4H, V9.4H }, [X11], #16
    MOV  X11, X2
    LD2 { V8.4H, V9.4H }, [X11], #16
    ADD  X2, X2, X16, ASR #0
    MOV  X11, X2
    ST2 { V8.8B, V9.8B }, [X11], #16
    MOV  X11, X2
    LD2 { V8.8B, V9.8B }, [X11], #16
    ADD  X2, X2, X16, ASR #0
    ST2 { V8.16B, V9.16B }, [X2], X5
    LD2 { V8.4S, V9.4S }, [X2], X5
    ADD  X2, X2, X16
    ST2 { V8.16B, V9.16B }, [X2], X5
    LD2 { V8.16B, V9.16B }, [X2], X5
    ADD  X2, X2, X16
    ST2 { V8.2D, V9.2D }, [X2], X5
    LD2 { V18.2D, V19.2D }, [X2], X5
    ADD  X2, X2, X16, LSR #0
    ST2 { V18.4S, V19.4S }, [X2], X5
    LD2 { V18.4S, V19.4S }, [X2], X5
    ADD  X2, X2, X16
    ST2 { V18.8H, V19.8H }, [X2], X5
    LD2 { V18.8H, V19.8H }, [X2], X5
    ADD  X2, X2, X16, LSR #0
    ST2 { V18.8B, V19.8B }, [X2], X5
    LD2 { V20.2S, V21.2S }, [X2], X5
    ADD  X2, X2, X16, LSR #0
    ST2 { V20.2S, V21.2S }, [X2], X5
    LD2 { V15.2S, V16.2S }, [X2], X5
    ADD  X2, X2, X16, ASR #0
    ST2 { V15.4H, V16.4H }, [X2], X5
    LD2 { V18.4H, V19.4H }, [X2], X5
    ADD  X2, X2, X16, LSR #0
    ST2 { V17.8B, V18.8B }, [X2], X5
    LD2 { V25.8B, V26.8B }, [X2], X5
    ADD  X2, X2, X16
    ST2 { V27.H, V28.H }[0x2], [X2]
    LD2 { V1.H, V2.H }[0x0], [X2]
    ADD  X2, X2, X16
    ST2 { V24.S, V25.S }[0x1], [X2]
    LD2 { V10.S, V11.S }[0x0], [X2]
    ADD  X2, X2, X16, ASR #0
    ST2 { V29.D, V30.D }[0x1], [X2]
    LD2 { V2.D, V3.D }[0x0], [X2]
    ADD  X2, X2, X16, ASR #0
    ST2 { V26.B, V27.B }[0x6], [X2]
    LD2 { V25.B, V26.B }[0x7], [X2]
    ADD  X2, X2, X16, LSR #0
    MOV  X11, X2
    ST2 { V4.H, V5.H }[0x7], [X11], #4
    MOV  X11, X2
    LD2 { V17.H, V18.H }[0x3], [X11], #4
    ADD  X2, X2, X16, LSR #0
    ST2 { V24.H, V25.H }[0x2], [X2], X5
    LD2 { V6.H, V7.H }[0x2], [X2], X5
    ADD  X2, X2, X16, ASR #0
    MOV  X11, X2
    ST2 { V17.S, V18.S }[0x0], [X11], #8
    MOV  X11, X2
    LD2 { V15.S, V16.S }[0x1], [X11], #8
    ADD  X2, X2, X16
    ST2 { V21.S, V22.S }[0x3], [X2], X5
    LD2 { V29.S, V30.S }[0x1], [X2], X5
    ADD  X2, X2, X16
    MOV  X11, X2
    ST2 { V6.D, V7.D }[0x1], [X11], #16
    MOV  X11, X2
    LD2 { V6.D, V7.D }[0x1], [X11], #16
    ADD  X2, X2, X16
    ST2 { V29.D, V30.D }[0x0], [X2], X5
    LD2 { V24.D, V25.D }[0x1], [X2], X5
    ADD  X2, X2, X16, LSR #0
    MOV  X11, X2
    ST2 { V2.B, V3.B }[0xa], [X11], #2
    MOV  X11, X2
    LD2 { V17.B, V18.B }[0x8], [X11], #2
    ADD  X2, X2, X16, LSR #0
    ST2 { V16.B, V17.B }[0xe], [X2], X5
    LD2 { V29.B, V30.B }[0x1], [X2], X5
    ADD  X2, X2, X16, LSR #0
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X20
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X19, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    MRS  X19, FPSR
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V0.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D0
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V1.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D1
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V2.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D2
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V3.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, D3
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V4.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D4
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V5.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D5
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V6.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D6
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V7.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D7
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V8.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D8
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V9.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D9
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V10.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D10
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V11.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D11
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V12.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D12
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V13.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D13
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V14.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D14
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V15.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D15
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V16.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D16
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a, LSL #0
    FMOV  X19, V17.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D17
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a, LSL #0
    FMOV  X19, V18.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D18
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V19.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D19
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V20.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D20
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V21.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D21
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V22.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D22
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V23.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D23
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    FMOV  X19, V24.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D24
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V25.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D25
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V26.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D26
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V27.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D27
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V28.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D28
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, V29.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    FMOV  X19, D29
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V30.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D30
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x0, LSL #0
    FMOV  X19, V31.D[1]
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    FMOV  X19, D31
    SUB  X13, X7, X19
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X28
    FMOV  V1.D[1], X25
    FMOV  D2, X29
    FMOV  V2.D[1], X7
    FMOV  D3, X29
    FMOV  V3.D[1], X18
    FMOV  D4, X23
    FMOV  V4.D[1], X7
    FMOV  D5, X27
    FMOV  V5.D[1], X28
    FMOV  D6, X9
    FMOV  V6.D[1], X28
    FMOV  D7, X26
    FMOV  V7.D[1], X24
    FMOV  D8, X8
    FMOV  V8.D[1], X3
    FMOV  D9, X25
    FMOV  V9.D[1], X23
    FMOV  D10, X23
    FMOV  V10.D[1], X11
    FMOV  D11, X23
    FMOV  V11.D[1], X20
    FMOV  D12, X6
    FMOV  V12.D[1], X7
    FMOV  D13, X5
    FMOV  V13.D[1], X23
    FMOV  D14, X29
    FMOV  V14.D[1], X8
    FMOV  D15, X16
    FMOV  V15.D[1], X13
    FMOV  D16, X26
    FMOV  V16.D[1], X3
    FMOV  D17, X3
    FMOV  V17.D[1], X5
    FMOV  D18, X23
    FMOV  V18.D[1], X9
    FMOV  D19, X28
    FMOV  V19.D[1], X9
    FMOV  D20, X22
    FMOV  V20.D[1], X7
    FMOV  D21, X5
    FMOV  V21.D[1], X5
    FMOV  D22, X16
    FMOV  V22.D[1], X3
    FMOV  D23, X5
    FMOV  V23.D[1], X8
    FMOV  D24, X6
    FMOV  V24.D[1], X9
    FMOV  D25, X16
    FMOV  V25.D[1], X2
    FMOV  D26, X27
    FMOV  V26.D[1], X26
    FMOV  D27, X20
    FMOV  V27.D[1], X20
    FMOV  D28, X8
    FMOV  V28.D[1], X22
    FMOV  D29, X10
    FMOV  V29.D[1], X16
    FMOV  D30, X17
    FMOV  V30.D[1], X23
    FMOV  D31, X17
    FMOV  V31.D[1], X8
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X18, #0x40, LSL #0
    MOVZ  X29, #0x2300, LSL #0
    ADD  X25, X30, X29, ASR #0
    ST2 { V18.16B, V19.16B }, [X25]
    LD2 { V21.16B, V22.16B }, [X25]
    ADD  X25, X25, X18
    ST2 { V23.16B, V24.16B }, [X25]
    LD2 { V22.16B, V23.16B }, [X25]
    ADD  X25, X25, X18, LSR #0
    ST2 { V9.2D, V10.2D }, [X25]
    LD2 { V30.2D, V31.2D }, [X25]
    ADD  X25, X25, X18, LSR #0
    ST2 { V29.4S, V30.4S }, [X25]
    LD2 { V16.4S, V17.4S }, [X25]
    ADD  X25, X25, X18
    ST2 { V16.8H, V17.8H }, [X25]
    LD2 { V3.8H, V4.8H }, [X25]
    ADD  X25, X25, X18, LSR #0
    ST2 { V22.2S, V23.2S }, [X25]
    LD2 { V2.8B, V3.8B }, [X25]
    ADD  X25, X25, X18, ASR #0
    ST2 { V2.2S, V3.2S }, [X25]
    LD2 { V20.2S, V21.2S }, [X25]
    ADD  X25, X25, X18
    ST2 { V22.4H, V23.4H }, [X25]
    LD2 { V29.4H, V30.4H }, [X25]
    ADD  X25, X25, X18, ASR #0
    ST2 { V9.8B, V10.8B }, [X25]
    LD2 { V1.8B, V2.8B }, [X25]
    ADD  X25, X25, X18, ASR #0
    MOV  X11, X25
    ST2 { V1.16B, V2.16B }, [X11], #32
    MOV  X11, X25
    LD2 { V26.2D, V27.2D }, [X11], #32
    ADD  X25, X25, X18
    MOV  X11, X25
    ST2 { V29.16B, V30.16B }, [X11], #32
    MOV  X11, X25
    LD2 { V13.16B, V14.16B }, [X11], #32
    ADD  X25, X25, X18, ASR #0
    MOV  X11, X25
    ST2 { V26.2D, V27.2D }, [X11], #32
    MOV  X11, X25
    LD2 { V2.2D, V3.2D }, [X11], #32
    ADD  X25, X25, X18, LSR #0
    MOV  X11, X25
    ST2 { V2.4S, V3.4S }, [X11], #32
    MOV  X11, X25
    LD2 { V25.4S, V26.4S }, [X11], #32
    ADD  X25, X25, X18
    MOV  X11, X25
    ST2 { V13.8H, V14.8H }, [X11], #32
    MOV  X11, X25
    LD2 { V14.8H, V15.8H }, [X11], #32
    ADD  X25, X25, X18, ASR #0
    MOV  X11, X25
    ST2 { V14.2S, V15.2S }, [X11], #16
    MOV  X11, X25
    LD2 { V13.2S, V14.2S }, [X11], #16
    ADD  X25, X25, X18, ASR #0
    MOV  X11, X25
    ST2 { V13.2S, V14.2S }, [X11], #16
    MOV  X11, X25
    LD2 { V22.2S, V23.2S }, [X11], #16
    ADD  X25, X25, X18, LSR #0
    MOV  X11, X25
    ST2 { V25.4H, V26.4H }, [X11], #16
    MOV  X11, X25
    LD2 { V14.4H, V15.4H }, [X11], #16
    ADD  X25, X25, X18
    MOV  X11, X25
    ST2 { V14.8B, V15.8B }, [X11], #16
    MOV  X11, X25
    LD2 { V24.8B, V25.8B }, [X11], #16
    ADD  X25, X25, X18, LSR #0
    ST2 { V22.8H, V23.8H }, [X25], X2
    LD2 { V4.2D, V5.2D }, [X25], X2
    ADD  X25, X25, X18, ASR #0
    ST2 { V24.16B, V25.16B }, [X25], X2
    LD2 { V21.16B, V22.16B }, [X25], X2
    ADD  X25, X25, X18, ASR #0
    ST2 { V21.2D, V22.2D }, [X25], X2
    LD2 { V26.2D, V27.2D }, [X25], X2
    ADD  X25, X25, X18, LSR #0
    ST2 { V26.4S, V27.4S }, [X25], X2
    LD2 { V30.4S, V31.4S }, [X25], X2
    ADD  X25, X25, X18, LSR #0
    ST2 { V30.8H, V31.8H }, [X25], X2
    LD2 { V22.8H, V23.8H }, [X25], X2
    ADD  X25, X25, X18, LSR #0
    ST2 { V4.8B, V5.8B }, [X25], X2
    LD2 { V12.2S, V13.2S }, [X25], X2
    ADD  X25, X25, X18, ASR #0
    ST2 { V22.2S, V23.2S }, [X25], X2
    LD2 { V10.2S, V11.2S }, [X25], X2
    ADD  X25, X25, X18, LSR #0
    ST2 { V12.4H, V13.4H }, [X25], X2
    LD2 { V24.4H, V25.4H }, [X25], X2
    ADD  X25, X25, X18
    ST2 { V10.8B, V11.8B }, [X25], X2
    LD2 { V21.8B, V22.8B }, [X25], X2
    ADD  X25, X25, X18, LSR #0
    ST2 { V24.H, V25.H }[0x7], [X25]
    LD2 { V12.H, V13.H }[0x5], [X25]
    ADD  X25, X25, X18, ASR #0
    ST2 { V12.S, V13.S }[0x3], [X25]
    LD2 { V24.S, V25.S }[0x1], [X25]
    ADD  X25, X25, X18
    ST2 { V24.D, V25.D }[0x0], [X25]
    LD2 { V24.D, V25.D }[0x0], [X25]
    ADD  X25, X25, X18
    ST2 { V21.B, V22.B }[0xd], [X25]
    LD2 { V8.B, V9.B }[0xe], [X25]
    ADD  X25, X25, X18, LSR #0
    MOV  X11, X25
    ST2 { V8.H, V9.H }[0x6], [X11], #4
    MOV  X11, X25
    LD2 { V10.H, V11.H }[0x1], [X11], #4
    ADD  X25, X25, X18
    ST2 { V24.H, V25.H }[0x7], [X25], X2
    LD2 { V12.H, V13.H }[0x4], [X25], X2
    ADD  X25, X25, X18, LSR #0
    MOV  X11, X25
    ST2 { V10.S, V11.S }[0x2], [X11], #8
    MOV  X11, X25
    LD2 { V21.S, V22.S }[0x1], [X11], #8
    ADD  X25, X25, X18, LSR #0
    ST2 { V21.S, V22.S }[0x3], [X25], X2
    LD2 { V10.S, V11.S }[0x1], [X25], X2
    ADD  X25, X25, X18, ASR #0
    MOV  X11, X25
    ST2 { V10.D, V11.D }[0x1], [X11], #16
    MOV  X11, X25
    LD2 { V24.D, V25.D }[0x0], [X11], #16
    ADD  X25, X25, X18
    ST2 { V24.D, V25.D }[0x1], [X25], X2
    LD2 { V21.D, V22.D }[0x0], [X25], X2
    ADD  X25, X25, X18
    MOV  X11, X25
    ST2 { V12.B, V13.B }[0xa], [X11], #2
    MOV  X11, X25
    LD2 { V12.B, V13.B }[0x4], [X11], #2
    ADD  X25, X25, X18, ASR #0
    ST2 { V12.B, V13.B }[0xc], [X25], X2
    LD2 { V12.B, V13.B }[0xf], [X25], X2
    ADD  X25, X25, X18, LSR #0
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X3
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X24
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X10, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X10, FPSR
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, V0.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D0
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V1.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D1
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V2.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D2
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V3.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D3
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V4.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D4
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V5.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D5
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, V6.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D6
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, V7.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D7
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa500, LSL #48
    FMOV  X10, V8.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D8
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa500, LSL #48
    FMOV  X10, V9.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D9
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V10.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    FMOV  X10, D10
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V11.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    FMOV  X10, D11
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V12.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa500, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D12
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V13.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa500, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D13
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V14.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D14
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V15.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D15
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, V16.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D16
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, V17.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D17
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, V18.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D18
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, V19.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D19
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V20.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D20
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V21.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, D21
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V22.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, D22
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V23.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D23
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V24.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, D24
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V25.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, D25
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V26.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D26
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V27.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D27
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, V28.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D28
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V29.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D29
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V30.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D30
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X10, V31.D[1]
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X10, D31
    SUB  X13, X19, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X26
    FMOV  V3.D[1], X20
    FMOV  D4, X17
    FMOV  V4.D[1], X27
    FMOV  D5, X27
    FMOV  V5.D[1], X7
    FMOV  D6, X25
    FMOV  V6.D[1], X11
    FMOV  D7, X29
    FMOV  V7.D[1], X19
    FMOV  D8, X25
    FMOV  V8.D[1], X8
    FMOV  D9, X24
    FMOV  V9.D[1], X2
    FMOV  D10, X5
    FMOV  V10.D[1], X25
    FMOV  D11, X14
    FMOV  V11.D[1], X22
    FMOV  D12, X3
    FMOV  V12.D[1], X26
    FMOV  D13, X2
    FMOV  V13.D[1], X26
    FMOV  D14, X25
    FMOV  V14.D[1], X3
    FMOV  D15, X7
    FMOV  V15.D[1], X11
    FMOV  D16, X7
    FMOV  V16.D[1], X14
    FMOV  D17, X22
    FMOV  V17.D[1], X26
    FMOV  D18, X24
    FMOV  V18.D[1], X19
    FMOV  D19, X2
    FMOV  V19.D[1], X14
    FMOV  D20, X28
    FMOV  V20.D[1], X2
    FMOV  D21, X14
    FMOV  V21.D[1], X14
    FMOV  D22, X16
    FMOV  V22.D[1], X19
    FMOV  D23, X18
    FMOV  V23.D[1], X19
    FMOV  D24, X19
    FMOV  V24.D[1], X9
    FMOV  D25, X14
    FMOV  V25.D[1], X29
    FMOV  D26, X8
    FMOV  V26.D[1], X10
    FMOV  D27, X7
    FMOV  V27.D[1], X26
    FMOV  D28, X2
    FMOV  V28.D[1], X10
    FMOV  D29, X28
    FMOV  V29.D[1], X27
    FMOV  D30, X18
    FMOV  V30.D[1], X7
    FMOV  D31, X20
    FMOV  V31.D[1], X25
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X10, #0x2800, LSL #0
    ADD  X19, X30, X10, ASR #0
    ST2 { V27.8H, V28.8H }, [X19]
    LD2 { V22.16B, V23.16B }, [X19]
    ADD  X19, X19, X28
    ST2 { V25.16B, V26.16B }, [X19]
    LD2 { V19.16B, V20.16B }, [X19]
    ADD  X19, X19, X28
    ST2 { V12.2D, V13.2D }, [X19]
    LD2 { V7.2D, V8.2D }, [X19]
    ADD  X19, X19, X28, ASR #0
    ST2 { V30.4S, V31.4S }, [X19]
    LD2 { V30.4S, V31.4S }, [X19]
    ADD  X19, X19, X28, LSR #0
    ST2 { V22.8H, V23.8H }, [X19]
    LD2 { V31.8H, V0.8H }, [X19]
    ADD  X19, X19, X28, ASR #0
    ST2 { V30.4H, V31.4H }, [X19]
    LD2 { V29.2S, V30.2S }, [X19]
    ADD  X19, X19, X28, ASR #0
    ST2 { V7.2S, V8.2S }, [X19]
    LD2 { V19.2S, V20.2S }, [X19]
    ADD  X19, X19, X28, ASR #0
    ST2 { V24.4H, V25.4H }, [X19]
    LD2 { V12.4H, V13.4H }, [X19]
    ADD  X19, X19, X28, LSR #0
    ST2 { V19.8B, V20.8B }, [X19]
    LD2 { V11.8B, V12.8B }, [X19]
    ADD  X19, X19, X28, LSR #0
    MOV  X16, X19
    ST2 { V12.2D, V13.2D }, [X16], #32
    MOV  X16, X19
    LD2 { V27.4S, V28.4S }, [X16], #32
    ADD  X19, X19, X28
    MOV  X16, X19
    ST2 { V27.16B, V28.16B }, [X16], #32
    MOV  X16, X19
    LD2 { V10.16B, V11.16B }, [X16], #32
    ADD  X19, X19, X28, ASR #0
    MOV  X16, X19
    ST2 { V10.2D, V11.2D }, [X16], #32
    MOV  X16, X19
    LD2 { V10.2D, V11.2D }, [X16], #32
    ADD  X19, X19, X28, ASR #0
    MOV  X16, X19
    ST2 { V10.4S, V11.4S }, [X16], #32
    MOV  X16, X19
    LD2 { V11.4S, V12.4S }, [X16], #32
    ADD  X19, X19, X28, ASR #0
    MOV  X16, X19
    ST2 { V11.8H, V12.8H }, [X16], #32
    MOV  X16, X19
    LD2 { V10.8H, V11.8H }, [X16], #32
    ADD  X19, X19, X28
    MOV  X16, X19
    ST2 { V0.2S, V1.2S }, [X16], #16
    MOV  X16, X19
    LD2 { V12.2S, V13.2S }, [X16], #16
    ADD  X19, X19, X28, LSR #0
    MOV  X16, X19
    ST2 { V30.2S, V31.2S }, [X16], #16
    MOV  X16, X19
    LD2 { V0.2S, V1.2S }, [X16], #16
    ADD  X19, X19, X28
    MOV  X16, X19
    ST2 { V1.4H, V2.4H }, [X16], #16
    MOV  X16, X19
    LD2 { V1.4H, V2.4H }, [X16], #16
    ADD  X19, X19, X28
    MOV  X16, X19
    ST2 { V10.8B, V11.8B }, [X16], #16
    MOV  X16, X19
    LD2 { V24.8B, V25.8B }, [X16], #16
    ADD  X19, X19, X28
    ST2 { V24.4S, V25.4S }, [X19], X25
    LD2 { V27.8H, V28.8H }, [X19], X25
    ADD  X19, X19, X28, ASR #0
    ST2 { V21.16B, V22.16B }, [X19], X25
    LD2 { V6.16B, V7.16B }, [X19], X25
    ADD  X19, X19, X28, ASR #0
    ST2 { V12.2D, V13.2D }, [X19], X25
    LD2 { V22.2D, V23.2D }, [X19], X25
    ADD  X19, X19, X28, LSR #0
    ST2 { V27.4S, V28.4S }, [X19], X25
    LD2 { V7.4S, V8.4S }, [X19], X25
    ADD  X19, X19, X28, ASR #0
    ST2 { V22.8H, V23.8H }, [X19], X25
    LD2 { V29.8H, V30.8H }, [X19], X25
    ADD  X19, X19, X28, LSR #0
    ST2 { V29.4H, V30.4H }, [X19], X25
    LD2 { V13.2S, V14.2S }, [X19], X25
    ADD  X19, X19, X28, ASR #0
    ST2 { V6.2S, V7.2S }, [X19], X25
    LD2 { V22.2S, V23.2S }, [X19], X25
    ADD  X19, X19, X28, LSR #0
    ST2 { V22.4H, V23.4H }, [X19], X25
    LD2 { V19.4H, V20.4H }, [X19], X25
    ADD  X19, X19, X28, ASR #0
    ST2 { V19.8B, V20.8B }, [X19], X25
    LD2 { V2.8B, V3.8B }, [X19], X25
    ADD  X19, X19, X28, LSR #0
    ST2 { V2.H, V3.H }[0x7], [X19]
    LD2 { V28.H, V29.H }[0x4], [X19]
    ADD  X19, X19, X28
    ST2 { V28.S, V29.S }[0x1], [X19]
    LD2 { V6.S, V7.S }[0x2], [X19]
    ADD  X19, X19, X28, ASR #0
    ST2 { V13.D, V14.D }[0x1], [X19]
    LD2 { V28.D, V29.D }[0x0], [X19]
    ADD  X19, X19, X28, LSR #0
    ST2 { V6.B, V7.B }[0x6], [X19]
    LD2 { V13.B, V14.B }[0x7], [X19]
    ADD  X19, X19, X28
    MOV  X16, X19
    ST2 { V13.H, V14.H }[0x3], [X16], #4
    MOV  X16, X19
    LD2 { V22.H, V23.H }[0x3], [X16], #4
    ADD  X19, X19, X28, ASR #0
    ST2 { V28.H, V29.H }[0x5], [X19], X25
    LD2 { V28.H, V29.H }[0x1], [X19], X25
    ADD  X19, X19, X28, LSR #0
    MOV  X16, X19
    ST2 { V28.S, V29.S }[0x1], [X16], #8
    MOV  X16, X19
    LD2 { V28.S, V29.S }[0x3], [X16], #8
    ADD  X19, X19, X28, LSR #0
    ST2 { V15.S, V16.S }[0x1], [X19], X25
    LD2 { V15.S, V16.S }[0x0], [X19], X25
    ADD  X19, X19, X28, ASR #0
    MOV  X16, X19
    ST2 { V15.D, V16.D }[0x0], [X16], #16
    MOV  X16, X19
    LD2 { V13.D, V14.D }[0x1], [X16], #16
    ADD  X19, X19, X28
    ST2 { V18.D, V19.D }[0x1], [X19], X25
    LD2 { V15.D, V16.D }[0x1], [X19], X25
    ADD  X19, X19, X28
    MOV  X16, X19
    ST2 { V15.B, V16.B }[0x0], [X16], #2
    MOV  X16, X19
    LD2 { V18.B, V19.B }[0x4], [X16], #2
    ADD  X19, X19, X28, LSR #0
    ST2 { V13.B, V14.B }[0xa], [X19], X25
    LD2 { V15.B, V16.B }[0x5], [X19], X25
    ADD  X19, X19, X28
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X8, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    MRS  X8, FPSR
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V0.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D0
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V1.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D1
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V2.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D2
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V3.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D3
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V4.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D4
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V5.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D5
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V6.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D6
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    FMOV  X8, V7.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D7
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V8.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D8
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V9.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D9
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V10.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D10
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V11.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D11
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V12.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D12
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V13.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D13
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V14.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D14
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V15.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D15
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V16.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D16
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V17.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D17
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V18.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D18
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V19.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D19
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V20.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D20
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V21.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D21
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V22.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D22
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V23.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D23
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V24.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D24
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V25.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D25
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V26.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D26
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V27.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D27
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V28.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, D28
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V29.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, D29
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X8, V30.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D30
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, V31.D[1]
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X8, D31
    SUB  X22, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X27
    FMOV  D1, X23
    FMOV  V1.D[1], X28
    FMOV  D2, X29
    FMOV  V2.D[1], X20
    FMOV  D3, X9
    FMOV  V3.D[1], X13
    FMOV  D4, X5
    FMOV  V4.D[1], X7
    FMOV  D5, X23
    FMOV  V5.D[1], X8
    FMOV  D6, X24
    FMOV  V6.D[1], X11
    FMOV  D7, X24
    FMOV  V7.D[1], X7
    FMOV  D8, X25
    FMOV  V8.D[1], X9
    FMOV  D9, X11
    FMOV  V9.D[1], X26
    FMOV  D10, X11
    FMOV  V10.D[1], X20
    FMOV  D11, X7
    FMOV  V11.D[1], X26
    FMOV  D12, X14
    FMOV  V12.D[1], X8
    FMOV  D13, X20
    FMOV  V13.D[1], X24
    FMOV  D14, X6
    FMOV  V14.D[1], X24
    FMOV  D15, X26
    FMOV  V15.D[1], X9
    FMOV  D16, X23
    FMOV  V16.D[1], X20
    FMOV  D17, X26
    FMOV  V17.D[1], X23
    FMOV  D18, X11
    FMOV  V18.D[1], X10
    FMOV  D19, X16
    FMOV  V19.D[1], X22
    FMOV  D20, X13
    FMOV  V20.D[1], X23
    FMOV  D21, X13
    FMOV  V21.D[1], X8
    FMOV  D22, X14
    FMOV  V22.D[1], X26
    FMOV  D23, X19
    FMOV  V23.D[1], X25
    FMOV  D24, X7
    FMOV  V24.D[1], X9
    FMOV  D25, X9
    FMOV  V25.D[1], X8
    FMOV  D26, X22
    FMOV  V26.D[1], X28
    FMOV  D27, X26
    FMOV  V27.D[1], X14
    FMOV  D28, X28
    FMOV  V28.D[1], X23
    FMOV  D29, X17
    FMOV  V29.D[1], X6
    FMOV  D30, X14
    FMOV  V30.D[1], X11
    FMOV  D31, X13
    FMOV  V31.D[1], X3
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X10, #0x2d00, LSL #0
    ADD  X18, X30, X10, LSR #0
    ST2 { V10.4S, V11.4S }, [X18]
    LD2 { V7.4S, V8.4S }, [X18]
    ADD  X18, X18, X3
    ST2 { V20.16B, V21.16B }, [X18]
    LD2 { V17.16B, V18.16B }, [X18]
    ADD  X18, X18, X3, LSR #0
    ST2 { V5.2D, V6.2D }, [X18]
    LD2 { V9.2D, V10.2D }, [X18]
    ADD  X18, X18, X3, ASR #0
    ST2 { V17.4S, V18.4S }, [X18]
    LD2 { V3.4S, V4.4S }, [X18]
    ADD  X18, X18, X3, ASR #0
    ST2 { V23.8H, V24.8H }, [X18]
    LD2 { V12.8H, V13.8H }, [X18]
    ADD  X18, X18, X3, ASR #0
    ST2 { V8.4H, V9.4H }, [X18]
    LD2 { V8.4H, V9.4H }, [X18]
    ADD  X18, X18, X3, LSR #0
    ST2 { V3.2S, V4.2S }, [X18]
    LD2 { V6.2S, V7.2S }, [X18]
    ADD  X18, X18, X3, LSR #0
    ST2 { V15.4H, V16.4H }, [X18]
    LD2 { V14.4H, V15.4H }, [X18]
    ADD  X18, X18, X3, ASR #0
    ST2 { V9.8B, V10.8B }, [X18]
    LD2 { V30.8B, V31.8B }, [X18]
    ADD  X18, X18, X3
    MOV  X13, X18
    ST2 { V25.2D, V26.2D }, [X13], #32
    MOV  X13, X18
    LD2 { V9.2D, V10.2D }, [X13], #32
    ADD  X18, X18, X3, LSR #0
    MOV  X13, X18
    ST2 { V9.16B, V10.16B }, [X13], #32
    MOV  X13, X18
    LD2 { V9.16B, V10.16B }, [X13], #32
    ADD  X18, X18, X3, LSR #0
    MOV  X13, X18
    ST2 { V9.2D, V10.2D }, [X13], #32
    MOV  X13, X18
    LD2 { V25.2D, V26.2D }, [X13], #32
    ADD  X18, X18, X3, LSR #0
    MOV  X13, X18
    ST2 { V30.4S, V31.4S }, [X13], #32
    MOV  X13, X18
    LD2 { V9.4S, V10.4S }, [X13], #32
    ADD  X18, X18, X3, LSR #0
    MOV  X13, X18
    ST2 { V9.8H, V10.8H }, [X13], #32
    MOV  X13, X18
    LD2 { V30.8H, V31.8H }, [X13], #32
    ADD  X18, X18, X3
    MOV  X13, X18
    ST2 { V30.4H, V31.4H }, [X13], #16
    MOV  X13, X18
    LD2 { V30.4H, V31.4H }, [X13], #16
    ADD  X18, X18, X3
    MOV  X13, X18
    ST2 { V30.2S, V31.2S }, [X13], #16
    MOV  X13, X18
    LD2 { V27.2S, V28.2S }, [X13], #16
    ADD  X18, X18, X3
    MOV  X13, X18
    ST2 { V27.4H, V28.4H }, [X13], #16
    MOV  X13, X18
    LD2 { V11.4H, V12.4H }, [X13], #16
    ADD  X18, X18, X3, ASR #0
    MOV  X13, X18
    ST2 { V11.8B, V12.8B }, [X13], #16
    MOV  X13, X18
    LD2 { V12.8B, V13.8B }, [X13], #16
    ADD  X18, X18, X3, LSR #0
    ST2 { V12.16B, V13.16B }, [X18], X24
    LD2 { V26.2D, V27.2D }, [X18], X24
    ADD  X18, X18, X3, LSR #0
    ST2 { V25.16B, V26.16B }, [X18], X24
    LD2 { V15.16B, V16.16B }, [X18], X24
    ADD  X18, X18, X3, LSR #0
    ST2 { V12.2D, V13.2D }, [X18], X24
    LD2 { V30.2D, V31.2D }, [X18], X24
    ADD  X18, X18, X3, LSR #0
    ST2 { V26.4S, V27.4S }, [X18], X24
    LD2 { V28.4S, V29.4S }, [X18], X24
    ADD  X18, X18, X3, ASR #0
    ST2 { V27.8H, V28.8H }, [X18], X24
    LD2 { V2.8H, V3.8H }, [X18], X24
    ADD  X18, X18, X3
    ST2 { V2.2S, V3.2S }, [X18], X24
    LD2 { V13.2S, V14.2S }, [X18], X24
    ADD  X18, X18, X3, LSR #0
    ST2 { V5.2S, V6.2S }, [X18], X24
    LD2 { V12.2S, V13.2S }, [X18], X24
    ADD  X18, X18, X3
    ST2 { V8.4H, V9.4H }, [X18], X24
    LD2 { V15.4H, V16.4H }, [X18], X24
    ADD  X18, X18, X3, LSR #0
    ST2 { V14.8B, V15.8B }, [X18], X24
    LD2 { V29.8B, V30.8B }, [X18], X24
    ADD  X18, X18, X3
    ST2 { V6.H, V7.H }[0x7], [X18]
    LD2 { V22.H, V23.H }[0x0], [X18]
    ADD  X18, X18, X3
    ST2 { V7.S, V8.S }[0x0], [X18]
    LD2 { V21.S, V22.S }[0x2], [X18]
    ADD  X18, X18, X3
    ST2 { V28.D, V29.D }[0x1], [X18]
    LD2 { V12.D, V13.D }[0x1], [X18]
    ADD  X18, X18, X3
    ST2 { V22.B, V23.B }[0x6], [X18]
    LD2 { V14.B, V15.B }[0xe], [X18]
    ADD  X18, X18, X3, LSR #0
    MOV  X13, X18
    ST2 { V13.H, V14.H }[0x3], [X13], #4
    MOV  X13, X18
    LD2 { V22.H, V23.H }[0x3], [X13], #4
    ADD  X18, X18, X3, LSR #0
    ST2 { V14.H, V15.H }[0x7], [X18], X24
    LD2 { V28.H, V29.H }[0x5], [X18], X24
    ADD  X18, X18, X3, ASR #0
    MOV  X13, X18
    ST2 { V20.S, V21.S }[0x1], [X13], #8
    MOV  X13, X18
    LD2 { V20.S, V21.S }[0x0], [X13], #8
    ADD  X18, X18, X3
    ST2 { V2.S, V3.S }[0x2], [X18], X24
    LD2 { V14.S, V15.S }[0x2], [X18], X24
    ADD  X18, X18, X3
    MOV  X13, X18
    ST2 { V14.D, V15.D }[0x1], [X13], #16
    MOV  X13, X18
    LD2 { V2.D, V3.D }[0x1], [X13], #16
    ADD  X18, X18, X3, ASR #0
    ST2 { V2.D, V3.D }[0x1], [X18], X24
    LD2 { V2.D, V3.D }[0x0], [X18], X24
    ADD  X18, X18, X3
    MOV  X13, X18
    ST2 { V2.B, V3.B }[0x7], [X13], #2
    MOV  X13, X18
    LD2 { V2.B, V3.B }[0xd], [X13], #2
    ADD  X18, X18, X3
    ST2 { V2.B, V3.B }[0x1], [X18], X24
    LD2 { V2.B, V3.B }[0xb], [X18], X24
    ADD  X18, X18, X3, ASR #0
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X17, X19, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MRS  X17, FPSR
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V0.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D0
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V1.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D1
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5, LSL #48
    FMOV  X17, V2.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5, LSL #48
    FMOV  X17, D2
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5, LSL #48
    FMOV  X17, V3.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5, LSL #48
    FMOV  X17, D3
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V4.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D4
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V5.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D5
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V6.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D6
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V7.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D7
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V8.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D8
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V9.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D9
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V10.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D10
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V11.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D11
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V12.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D12
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V13.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D13
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5, LSL #48
    FMOV  X17, V14.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D14
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5, LSL #48
    FMOV  X17, V15.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D15
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V16.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D16
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V17.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D17
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V18.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D18
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V19.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D19
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V20.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D20
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V21.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D21
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V22.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D22
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V23.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D23
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V24.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D24
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, V25.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D25
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V26.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D26
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V27.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D27
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5, LSL #16
    FMOV  X17, V28.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D28
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    MOVK  X19, #0xa5, LSL #16
    FMOV  X17, V29.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D29
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V30.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D30
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0x0, LSL #0
    FMOV  X17, V31.D[1]
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    FMOV  X17, D31
    SUB  X26, X19, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X16
    FMOV  D3, X28
    FMOV  V3.D[1], X14
    FMOV  D4, X22
    FMOV  V4.D[1], X24
    FMOV  D5, X9
    FMOV  V5.D[1], X10
    FMOV  D6, X11
    FMOV  V6.D[1], X27
    FMOV  D7, X13
    FMOV  V7.D[1], X18
    FMOV  D8, X13
    FMOV  V8.D[1], X23
    FMOV  D9, X6
    FMOV  V9.D[1], X17
    FMOV  D10, X7
    FMOV  V10.D[1], X24
    FMOV  D11, X10
    FMOV  V11.D[1], X19
    FMOV  D12, X17
    FMOV  V12.D[1], X28
    FMOV  D13, X8
    FMOV  V13.D[1], X6
    FMOV  D14, X14
    FMOV  V14.D[1], X17
    FMOV  D15, X16
    FMOV  V15.D[1], X20
    FMOV  D16, X17
    FMOV  V16.D[1], X19
    FMOV  D17, X9
    FMOV  V17.D[1], X7
    FMOV  D18, X6
    FMOV  V18.D[1], X26
    FMOV  D19, X14
    FMOV  V19.D[1], X26
    FMOV  D20, X11
    FMOV  V20.D[1], X23
    FMOV  D21, X29
    FMOV  V21.D[1], X18
    FMOV  D22, X28
    FMOV  V22.D[1], X29
    FMOV  D23, X17
    FMOV  V23.D[1], X11
    FMOV  D24, X7
    FMOV  V24.D[1], X16
    FMOV  D25, X5
    FMOV  V25.D[1], X23
    FMOV  D26, X25
    FMOV  V26.D[1], X7
    FMOV  D27, X28
    FMOV  V27.D[1], X28
    FMOV  D28, X24
    FMOV  V28.D[1], X29
    FMOV  D29, X26
    FMOV  V29.D[1], X25
    FMOV  D30, X9
    FMOV  V30.D[1], X9
    FMOV  D31, X16
    FMOV  V31.D[1], X5
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X18, #0x0, LSL #0
    ADD  X7, X30, X18, LSR #0
    ST2 { V24.16B, V25.16B }, [X7]
    LD2 { V20.16B, V21.16B }, [X7]
    ADD  X7, X7, X28
    ST2 { V28.16B, V29.16B }, [X7]
    LD2 { V22.16B, V23.16B }, [X7]
    ADD  X7, X7, X28
    ST2 { V20.2D, V21.2D }, [X7]
    LD2 { V4.2D, V5.2D }, [X7]
    ADD  X7, X7, X28, LSR #0
    ST2 { V30.4S, V31.4S }, [X7]
    LD2 { V14.4S, V15.4S }, [X7]
    ADD  X7, X7, X28, ASR #0
    ST2 { V4.8H, V5.8H }, [X7]
    LD2 { V20.8H, V21.8H }, [X7]
    ADD  X7, X7, X28, ASR #0
    ST2 { V21.2S, V22.2S }, [X7]
    LD2 { V7.2S, V8.2S }, [X7]
    ADD  X7, X7, X28, ASR #0
    ST2 { V7.2S, V8.2S }, [X7]
    LD2 { V13.2S, V14.2S }, [X7]
    ADD  X7, X7, X28, ASR #0
    ST2 { V7.4H, V8.4H }, [X7]
    LD2 { V29.4H, V30.4H }, [X7]
    ADD  X7, X7, X28
    ST2 { V13.8B, V14.8B }, [X7]
    LD2 { V6.8B, V7.8B }, [X7]
    ADD  X7, X7, X28, LSR #0
    MOV  X29, X7
    ST2 { V29.8H, V30.8H }, [X29], #32
    MOV  X29, X7
    LD2 { V15.4S, V16.4S }, [X29], #32
    ADD  X7, X7, X28, LSR #0
    MOV  X29, X7
    ST2 { V2.16B, V3.16B }, [X29], #32
    MOV  X29, X7
    LD2 { V17.16B, V18.16B }, [X29], #32
    ADD  X7, X7, X28
    MOV  X29, X7
    ST2 { V21.2D, V22.2D }, [X29], #32
    MOV  X29, X7
    LD2 { V11.2D, V12.2D }, [X29], #32
    ADD  X7, X7, X28
    MOV  X29, X7
    ST2 { V11.4S, V12.4S }, [X29], #32
    MOV  X29, X7
    LD2 { V28.4S, V29.4S }, [X29], #32
    ADD  X7, X7, X28, LSR #0
    MOV  X29, X7
    ST2 { V15.8H, V16.8H }, [X29], #32
    MOV  X29, X7
    LD2 { V3.8H, V4.8H }, [X29], #32
    ADD  X7, X7, X28
    MOV  X29, X7
    ST2 { V17.4H, V18.4H }, [X29], #16
    MOV  X29, X7
    LD2 { V29.2S, V30.2S }, [X29], #16
    ADD  X7, X7, X28, LSR #0
    MOV  X29, X7
    ST2 { V28.2S, V29.2S }, [X29], #16
    MOV  X29, X7
    LD2 { V16.2S, V17.2S }, [X29], #16
    ADD  X7, X7, X28, LSR #0
    MOV  X29, X7
    ST2 { V16.4H, V17.4H }, [X29], #16
    MOV  X29, X7
    LD2 { V6.4H, V7.4H }, [X29], #16
    ADD  X7, X7, X28
    MOV  X29, X7
    ST2 { V6.8B, V7.8B }, [X29], #16
    MOV  X29, X7
    LD2 { V2.8B, V3.8B }, [X29], #16
    ADD  X7, X7, X28
    ST2 { V2.16B, V3.16B }, [X7], X10
    LD2 { V31.2D, V0.2D }, [X7], X10
    ADD  X7, X7, X28, LSR #0
    ST2 { V30.16B, V31.16B }, [X7], X10
    LD2 { V25.16B, V26.16B }, [X7], X10
    ADD  X7, X7, X28
    ST2 { V25.2D, V26.2D }, [X7], X10
    LD2 { V22.2D, V23.2D }, [X7], X10
    ADD  X7, X7, X28, ASR #0
    ST2 { V22.4S, V23.4S }, [X7], X10
    LD2 { V16.4S, V17.4S }, [X7], X10
    ADD  X7, X7, X28, LSR #0
    ST2 { V16.8H, V17.8H }, [X7], X10
    LD2 { V25.8H, V26.8H }, [X7], X10
    ADD  X7, X7, X28
    ST2 { V8.8B, V9.8B }, [X7], X10
    LD2 { V6.4H, V7.4H }, [X7], X10
    ADD  X7, X7, X28
    ST2 { V20.2S, V21.2S }, [X7], X10
    LD2 { V2.2S, V3.2S }, [X7], X10
    ADD  X7, X7, X28
    ST2 { V18.4H, V19.4H }, [X7], X10
    LD2 { V22.4H, V23.4H }, [X7], X10
    ADD  X7, X7, X28
    ST2 { V6.8B, V7.8B }, [X7], X10
    LD2 { V8.8B, V9.8B }, [X7], X10
    ADD  X7, X7, X28
    ST2 { V8.H, V9.H }[0x4], [X7]
    LD2 { V20.H, V21.H }[0x6], [X7]
    ADD  X7, X7, X28, ASR #0
    ST2 { V2.S, V3.S }[0x3], [X7]
    LD2 { V16.S, V17.S }[0x1], [X7]
    ADD  X7, X7, X28, LSR #0
    ST2 { V20.D, V21.D }[0x1], [X7]
    LD2 { V18.D, V19.D }[0x0], [X7]
    ADD  X7, X7, X28
    ST2 { V22.B, V23.B }[0x6], [X7]
    LD2 { V21.B, V22.B }[0xd], [X7]
    ADD  X7, X7, X28, ASR #0
    MOV  X29, X7
    ST2 { V16.H, V17.H }[0x4], [X29], #4
    MOV  X29, X7
    LD2 { V2.H, V3.H }[0x4], [X29], #4
    ADD  X7, X7, X28, LSR #0
    ST2 { V2.H, V3.H }[0x0], [X7], X10
    LD2 { V8.H, V9.H }[0x1], [X7], X10
    ADD  X7, X7, X28
    MOV  X29, X7
    ST2 { V21.S, V22.S }[0x2], [X29], #8
    MOV  X29, X7
    LD2 { V22.S, V23.S }[0x0], [X29], #8
    ADD  X7, X7, X28
    ST2 { V18.S, V19.S }[0x1], [X7], X10
    LD2 { V17.S, V18.S }[0x1], [X7], X10
    ADD  X7, X7, X28, LSR #0
    MOV  X29, X7
    ST2 { V17.D, V18.D }[0x1], [X29], #16
    MOV  X29, X7
    LD2 { V16.D, V17.D }[0x0], [X29], #16
    ADD  X7, X7, X28, LSR #0
    ST2 { V16.D, V17.D }[0x0], [X7], X10
    LD2 { V0.D, V1.D }[0x1], [X7], X10
    ADD  X7, X7, X28
    MOV  X29, X7
    ST2 { V22.B, V23.B }[0xf], [X29], #2
    MOV  X29, X7
    LD2 { V28.B, V29.B }[0xd], [X29], #2
    ADD  X7, X7, X28, LSR #0
    ST2 { V8.B, V9.B }[0xc], [X7], X10
    LD2 { V16.B, V17.B }[0x0], [X7], X10
    ADD  X7, X7, X28, LSR #0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X23, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X23, FPSR
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V0.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D0
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V1.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D1
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V2.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D2
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V3.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D3
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V4.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D4
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V5.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D5
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V6.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D6
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V7.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D7
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V8.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D8
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V9.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D9
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V10.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D10
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V11.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D11
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V12.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D12
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V13.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D13
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V14.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D14
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V15.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D15
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V16.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, D16
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V17.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a00, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D17
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V18.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D18
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V19.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D19
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V20.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D20
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a00, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V21.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D21
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a00, LSL #32
    FMOV  X23, V22.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D22
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V23.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D23
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V24.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D24
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V25.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D25
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V26.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D26
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V27.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D27
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, V28.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D28
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V29.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D29
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V30.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D30
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X23, V31.D[1]
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X23, D31
    SUB  X27, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X16
    FMOV  D3, X19
    FMOV  V3.D[1], X24
    FMOV  D4, X5
    FMOV  V4.D[1], X20
    FMOV  D5, X9
    FMOV  V5.D[1], X24
    FMOV  D6, X8
    FMOV  V6.D[1], X22
    FMOV  D7, X2
    FMOV  V7.D[1], X25
    FMOV  D8, X25
    FMOV  V8.D[1], X9
    FMOV  D9, X24
    FMOV  V9.D[1], X19
    FMOV  D10, X14
    FMOV  V10.D[1], X3
    FMOV  D11, X8
    FMOV  V11.D[1], X2
    FMOV  D12, X6
    FMOV  V12.D[1], X24
    FMOV  D13, X5
    FMOV  V13.D[1], X2
    FMOV  D14, X19
    FMOV  V14.D[1], X13
    FMOV  D15, X17
    FMOV  V15.D[1], X14
    FMOV  D16, X14
    FMOV  V16.D[1], X23
    FMOV  D17, X10
    FMOV  V17.D[1], X10
    FMOV  D18, X2
    FMOV  V18.D[1], X24
    FMOV  D19, X3
    FMOV  V19.D[1], X9
    FMOV  D20, X5
    FMOV  V20.D[1], X24
    FMOV  D21, X10
    FMOV  V21.D[1], X9
    FMOV  D22, X16
    FMOV  V22.D[1], X20
    FMOV  D23, X13
    FMOV  V23.D[1], X19
    FMOV  D24, X24
    FMOV  V24.D[1], X25
    FMOV  D25, X22
    FMOV  V25.D[1], X9
    FMOV  D26, X14
    FMOV  V26.D[1], X14
    FMOV  D27, X29
    FMOV  V27.D[1], X27
    FMOV  D28, X18
    FMOV  V28.D[1], X13
    FMOV  D29, X10
    FMOV  V29.D[1], X6
    FMOV  D30, X25
    FMOV  V30.D[1], X27
    FMOV  D31, X2
    FMOV  V31.D[1], X2
    MOVZ  X6, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X10, #0x500, LSL #0
    ADD  X13, X30, X10, ASR #0
    ST2 { V28.16B, V29.16B }, [X13]
    LD2 { V20.4S, V21.4S }, [X13]
    ADD  X13, X13, X7
    ST2 { V20.16B, V21.16B }, [X13]
    LD2 { V25.16B, V26.16B }, [X13]
    ADD  X13, X13, X7
    ST2 { V30.2D, V31.2D }, [X13]
    LD2 { V31.2D, V0.2D }, [X13]
    ADD  X13, X13, X7
    ST2 { V31.4S, V0.4S }, [X13]
    LD2 { V11.4S, V12.4S }, [X13]
    ADD  X13, X13, X7, ASR #0
    ST2 { V11.8H, V12.8H }, [X13]
    LD2 { V2.8H, V3.8H }, [X13]
    ADD  X13, X13, X7, LSR #0
    ST2 { V15.4H, V16.4H }, [X13]
    LD2 { V13.2S, V14.2S }, [X13]
    ADD  X13, X13, X7
    ST2 { V25.2S, V26.2S }, [X13]
    LD2 { V31.2S, V0.2S }, [X13]
    ADD  X13, X13, X7
    ST2 { V31.4H, V0.4H }, [X13]
    LD2 { V17.4H, V18.4H }, [X13]
    ADD  X13, X13, X7
    ST2 { V13.8B, V14.8B }, [X13]
    LD2 { V25.8B, V26.8B }, [X13]
    ADD  X13, X13, X7
    MOV  X2, X13
    ST2 { V2.2D, V3.2D }, [X2], #32
    MOV  X2, X13
    LD2 { V28.8H, V29.8H }, [X2], #32
    ADD  X13, X13, X7, ASR #0
    MOV  X2, X13
    ST2 { V25.16B, V26.16B }, [X2], #32
    MOV  X2, X13
    LD2 { V2.16B, V3.16B }, [X2], #32
    ADD  X13, X13, X7, ASR #0
    MOV  X2, X13
    ST2 { V17.2D, V18.2D }, [X2], #32
    MOV  X2, X13
    LD2 { V17.2D, V18.2D }, [X2], #32
    ADD  X13, X13, X7, LSR #0
    MOV  X2, X13
    ST2 { V2.4S, V3.4S }, [X2], #32
    MOV  X2, X13
    LD2 { V25.4S, V26.4S }, [X2], #32
    ADD  X13, X13, X7, LSR #0
    MOV  X2, X13
    ST2 { V28.8H, V29.8H }, [X2], #32
    MOV  X2, X13
    LD2 { V28.8H, V29.8H }, [X2], #32
    ADD  X13, X13, X7, ASR #0
    MOV  X2, X13
    ST2 { V28.4H, V29.4H }, [X2], #16
    MOV  X2, X13
    LD2 { V28.4H, V29.4H }, [X2], #16
    ADD  X13, X13, X7, ASR #0
    MOV  X2, X13
    ST2 { V28.2S, V29.2S }, [X2], #16
    MOV  X2, X13
    LD2 { V13.2S, V14.2S }, [X2], #16
    ADD  X13, X13, X7, LSR #0
    MOV  X2, X13
    ST2 { V25.4H, V26.4H }, [X2], #16
    MOV  X2, X13
    LD2 { V15.4H, V16.4H }, [X2], #16
    ADD  X13, X13, X7
    MOV  X2, X13
    ST2 { V15.8B, V16.8B }, [X2], #16
    MOV  X2, X13
    LD2 { V26.8B, V27.8B }, [X2], #16
    ADD  X13, X13, X7, LSR #0
    ST2 { V11.16B, V12.16B }, [X13], X6
    LD2 { V2.8H, V3.8H }, [X13], X6
    ADD  X13, X13, X7, LSR #0
    ST2 { V29.16B, V30.16B }, [X13], X6
    LD2 { V21.16B, V22.16B }, [X13], X6
    ADD  X13, X13, X7, LSR #0
    ST2 { V21.2D, V22.2D }, [X13], X6
    LD2 { V16.2D, V17.2D }, [X13], X6
    ADD  X13, X13, X7, LSR #0
    ST2 { V2.4S, V3.4S }, [X13], X6
    LD2 { V20.4S, V21.4S }, [X13], X6
    ADD  X13, X13, X7, ASR #0
    ST2 { V26.8H, V27.8H }, [X13], X6
    LD2 { V13.8H, V14.8H }, [X13], X6
    ADD  X13, X13, X7
    ST2 { V17.4H, V18.4H }, [X13], X6
    LD2 { V15.4H, V16.4H }, [X13], X6
    ADD  X13, X13, X7, ASR #0
    ST2 { V13.2S, V14.2S }, [X13], X6
    LD2 { V13.2S, V14.2S }, [X13], X6
    ADD  X13, X13, X7, ASR #0
    ST2 { V13.4H, V14.4H }, [X13], X6
    LD2 { V6.4H, V7.4H }, [X13], X6
    ADD  X13, X13, X7
    ST2 { V6.8B, V7.8B }, [X13], X6
    LD2 { V13.8B, V14.8B }, [X13], X6
    ADD  X13, X13, X7, ASR #0
    ST2 { V13.H, V14.H }[0x4], [X13]
    LD2 { V17.H, V18.H }[0x5], [X13]
    ADD  X13, X13, X7, LSR #0
    ST2 { V15.S, V16.S }[0x0], [X13]
    LD2 { V15.S, V16.S }[0x3], [X13]
    ADD  X13, X13, X7, ASR #0
    ST2 { V16.D, V17.D }[0x1], [X13]
    LD2 { V6.D, V7.D }[0x0], [X13]
    ADD  X13, X13, X7, ASR #0
    ST2 { V20.B, V21.B }[0x8], [X13]
    LD2 { V2.B, V3.B }[0x7], [X13]
    ADD  X13, X13, X7, LSR #0
    MOV  X2, X13
    ST2 { V2.H, V3.H }[0x0], [X2], #4
    MOV  X2, X13
    LD2 { V13.H, V14.H }[0x6], [X2], #4
    ADD  X13, X13, X7, LSR #0
    ST2 { V26.H, V27.H }[0x4], [X13], X6
    LD2 { V2.H, V3.H }[0x4], [X13], X6
    ADD  X13, X13, X7, ASR #0
    MOV  X2, X13
    ST2 { V13.S, V14.S }[0x2], [X2], #8
    MOV  X2, X13
    LD2 { V16.S, V17.S }[0x2], [X2], #8
    ADD  X13, X13, X7, ASR #0
    ST2 { V2.S, V3.S }[0x2], [X13], X6
    LD2 { V26.S, V27.S }[0x1], [X13], X6
    ADD  X13, X13, X7
    MOV  X2, X13
    ST2 { V26.D, V27.D }[0x1], [X2], #16
    MOV  X2, X13
    LD2 { V2.D, V3.D }[0x1], [X2], #16
    ADD  X13, X13, X7
    ST2 { V16.D, V17.D }[0x1], [X13], X6
    LD2 { V16.D, V17.D }[0x1], [X13], X6
    ADD  X13, X13, X7, ASR #0
    MOV  X2, X13
    ST2 { V16.B, V17.B }[0xb], [X2], #2
    MOV  X2, X13
    LD2 { V13.B, V14.B }[0x3], [X2], #2
    ADD  X13, X13, X7, ASR #0
    ST2 { V2.B, V3.B }[0x3], [X13], X6
    LD2 { V26.B, V27.B }[0x0], [X13], X6
    ADD  X13, X13, X7, ASR #0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X5
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X18
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X20
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X14, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X14, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X14, FPSR
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V0.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D0
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V1.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D1
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V2.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D2
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V3.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D3
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V4.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D4
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V5.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D5
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V6.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D6
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V7.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D7
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V8.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D8
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V9.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D9
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V10.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D10
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V11.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D11
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V12.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D12
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    FMOV  X14, V13.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D13
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    FMOV  X14, V14.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D14
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V15.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D15
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V16.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D16
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V17.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D17
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V18.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D18
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V19.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D19
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V20.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D20
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V21.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D21
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V22.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D22
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V23.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D23
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V24.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D24
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V25.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D25
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V26.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D26
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V27.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D27
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V28.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D28
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V29.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D29
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, V30.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D30
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X14, V31.D[1]
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X14, D31
    SUB  X22, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X24
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X10
    FMOV  D3, X16
    FMOV  V3.D[1], X25
    FMOV  D4, X2
    FMOV  V4.D[1], X13
    FMOV  D5, X28
    FMOV  V5.D[1], X25
    FMOV  D6, X25
    FMOV  V6.D[1], X18
    FMOV  D7, X22
    FMOV  V7.D[1], X5
    FMOV  D8, X18
    FMOV  V8.D[1], X11
    FMOV  D9, X13
    FMOV  V9.D[1], X14
    FMOV  D10, X3
    FMOV  V10.D[1], X17
    FMOV  D11, X7
    FMOV  V11.D[1], X6
    FMOV  D12, X3
    FMOV  V12.D[1], X27
    FMOV  D13, X6
    FMOV  V13.D[1], X22
    FMOV  D14, X10
    FMOV  V14.D[1], X22
    FMOV  D15, X23
    FMOV  V15.D[1], X5
    FMOV  D16, X18
    FMOV  V16.D[1], X7
    FMOV  D17, X20
    FMOV  V17.D[1], X25
    FMOV  D18, X25
    FMOV  V18.D[1], X3
    FMOV  D19, X28
    FMOV  V19.D[1], X25
    FMOV  D20, X3
    FMOV  V20.D[1], X29
    FMOV  D21, X18
    FMOV  V21.D[1], X23
    FMOV  D22, X13
    FMOV  V22.D[1], X20
    FMOV  D23, X27
    FMOV  V23.D[1], X18
    FMOV  D24, X9
    FMOV  V24.D[1], X19
    FMOV  D25, X25
    FMOV  V25.D[1], X24
    FMOV  D26, X20
    FMOV  V26.D[1], X28
    FMOV  D27, X19
    FMOV  V27.D[1], X9
    FMOV  D28, X16
    FMOV  V28.D[1], X14
    FMOV  D29, X28
    FMOV  V29.D[1], X28
    FMOV  D30, X24
    FMOV  V30.D[1], X28
    FMOV  D31, X10
    FMOV  V31.D[1], X11
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X5, #0xa00, LSL #0
    ADD  X14, X30, X5
    ST2 { V28.4S, V29.4S }, [X14]
    LD2 { V28.4S, V29.4S }, [X14]
    ADD  X14, X14, X28, LSR #0
    ST2 { V16.16B, V17.16B }, [X14]
    LD2 { V30.16B, V31.16B }, [X14]
    ADD  X14, X14, X28, ASR #0
    ST2 { V28.2D, V29.2D }, [X14]
    LD2 { V0.2D, V1.2D }, [X14]
    ADD  X14, X14, X28, ASR #0
    ST2 { V30.4S, V31.4S }, [X14]
    LD2 { V25.4S, V26.4S }, [X14]
    ADD  X14, X14, X28, LSR #0
    ST2 { V23.8H, V24.8H }, [X14]
    LD2 { V24.8H, V25.8H }, [X14]
    ADD  X14, X14, X28
    ST2 { V24.2S, V25.2S }, [X14]
    LD2 { V10.8B, V11.8B }, [X14]
    ADD  X14, X14, X28, ASR #0
    ST2 { V10.2S, V11.2S }, [X14]
    LD2 { V5.2S, V6.2S }, [X14]
    ADD  X14, X14, X28, ASR #0
    ST2 { V0.4H, V1.4H }, [X14]
    LD2 { V15.4H, V16.4H }, [X14]
    ADD  X14, X14, X28, LSR #0
    ST2 { V15.8B, V16.8B }, [X14]
    LD2 { V22.8B, V23.8B }, [X14]
    ADD  X14, X14, X28, LSR #0
    MOV  X24, X14
    ST2 { V22.2D, V23.2D }, [X24], #32
    MOV  X24, X14
    LD2 { V22.16B, V23.16B }, [X24], #32
    ADD  X14, X14, X28, LSR #0
    MOV  X24, X14
    ST2 { V22.16B, V23.16B }, [X24], #32
    MOV  X24, X14
    LD2 { V15.16B, V16.16B }, [X24], #32
    ADD  X14, X14, X28, LSR #0
    MOV  X24, X14
    ST2 { V15.2D, V16.2D }, [X24], #32
    MOV  X24, X14
    LD2 { V10.2D, V11.2D }, [X24], #32
    ADD  X14, X14, X28, LSR #0
    MOV  X24, X14
    ST2 { V10.4S, V11.4S }, [X24], #32
    MOV  X24, X14
    LD2 { V15.4S, V16.4S }, [X24], #32
    ADD  X14, X14, X28, ASR #0
    MOV  X24, X14
    ST2 { V15.8H, V16.8H }, [X24], #32
    MOV  X24, X14
    LD2 { V22.8H, V23.8H }, [X24], #32
    ADD  X14, X14, X28, LSR #0
    MOV  X24, X14
    ST2 { V22.8B, V23.8B }, [X24], #16
    MOV  X24, X14
    LD2 { V15.4H, V16.4H }, [X24], #16
    ADD  X14, X14, X28
    MOV  X24, X14
    ST2 { V10.2S, V11.2S }, [X24], #16
    MOV  X24, X14
    LD2 { V10.2S, V11.2S }, [X24], #16
    ADD  X14, X14, X28, LSR #0
    MOV  X24, X14
    ST2 { V25.4H, V26.4H }, [X24], #16
    MOV  X24, X14
    LD2 { V27.4H, V28.4H }, [X24], #16
    ADD  X14, X14, X28
    MOV  X24, X14
    ST2 { V30.8B, V31.8B }, [X24], #16
    MOV  X24, X14
    LD2 { V6.8B, V7.8B }, [X24], #16
    ADD  X14, X14, X28, LSR #0
    ST2 { V26.2D, V27.2D }, [X14], X22
    LD2 { V13.8H, V14.8H }, [X14], X22
    ADD  X14, X14, X28, LSR #0
    ST2 { V14.16B, V15.16B }, [X14], X22
    LD2 { V31.16B, V0.16B }, [X14], X22
    ADD  X14, X14, X28
    ST2 { V24.2D, V25.2D }, [X14], X22
    LD2 { V10.2D, V11.2D }, [X14], X22
    ADD  X14, X14, X28
    ST2 { V6.4S, V7.4S }, [X14], X22
    LD2 { V19.4S, V20.4S }, [X14], X22
    ADD  X14, X14, X28, LSR #0
    ST2 { V16.8H, V17.8H }, [X14], X22
    LD2 { V12.8H, V13.8H }, [X14], X22
    ADD  X14, X14, X28, ASR #0
    ST2 { V31.2S, V0.2S }, [X14], X22
    LD2 { V18.8B, V19.8B }, [X14], X22
    ADD  X14, X14, X28
    ST2 { V18.2S, V19.2S }, [X14], X22
    LD2 { V24.2S, V25.2S }, [X14], X22
    ADD  X14, X14, X28, LSR #0
    ST2 { V12.4H, V13.4H }, [X14], X22
    LD2 { V15.4H, V16.4H }, [X14], X22
    ADD  X14, X14, X28, ASR #0
    ST2 { V15.8B, V16.8B }, [X14], X22
    LD2 { V15.8B, V16.8B }, [X14], X22
    ADD  X14, X14, X28
    ST2 { V10.H, V11.H }[0x3], [X14]
    LD2 { V26.H, V27.H }[0x7], [X14]
    ADD  X14, X14, X28, ASR #0
    ST2 { V24.S, V25.S }[0x3], [X14]
    LD2 { V24.S, V25.S }[0x3], [X14]
    ADD  X14, X14, X28, ASR #0
    ST2 { V24.D, V25.D }[0x0], [X14]
    LD2 { V12.D, V13.D }[0x1], [X14]
    ADD  X14, X14, X28
    ST2 { V12.B, V13.B }[0xe], [X14]
    LD2 { V24.B, V25.B }[0xc], [X14]
    ADD  X14, X14, X28, LSR #0
    MOV  X24, X14
    ST2 { V26.H, V27.H }[0x5], [X24], #4
    MOV  X24, X14
    LD2 { V12.H, V13.H }[0x3], [X24], #4
    ADD  X14, X14, X28
    ST2 { V15.H, V16.H }[0x5], [X14], X22
    LD2 { V15.H, V16.H }[0x1], [X14], X22
    ADD  X14, X14, X28
    MOV  X24, X14
    ST2 { V12.S, V13.S }[0x1], [X24], #8
    MOV  X24, X14
    LD2 { V12.S, V13.S }[0x2], [X24], #8
    ADD  X14, X14, X28, LSR #0
    ST2 { V12.S, V13.S }[0x0], [X14], X22
    LD2 { V26.S, V27.S }[0x2], [X14], X22
    ADD  X14, X14, X28
    MOV  X24, X14
    ST2 { V26.D, V27.D }[0x1], [X24], #16
    MOV  X24, X14
    LD2 { V12.D, V13.D }[0x1], [X24], #16
    ADD  X14, X14, X28, LSR #0
    ST2 { V12.D, V13.D }[0x0], [X14], X22
    LD2 { V0.D, V1.D }[0x0], [X14], X22
    ADD  X14, X14, X28, LSR #0
    MOV  X24, X14
    ST2 { V15.B, V16.B }[0x6], [X24], #2
    MOV  X24, X14
    LD2 { V28.B, V29.B }[0x2], [X24], #2
    ADD  X14, X14, X28, ASR #0
    ST2 { V0.B, V1.B }[0x2], [X14], X22
    LD2 { V1.B, V2.B }[0x4], [X14], X22
    ADD  X14, X14, X28, ASR #0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X6, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X6, FPSR
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V0.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D0
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V1.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    FMOV  X6, D1
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V2.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D2
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V3.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D3
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V4.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D4
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V5.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D5
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V6.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D6
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V7.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D7
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V8.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D8
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V9.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D9
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V10.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D10
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V11.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D11
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V12.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D12
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V13.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    FMOV  X6, D13
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    FMOV  X6, V14.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D14
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V15.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D15
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V16.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D16
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V17.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D17
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V18.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D18
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V19.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D19
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V20.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D20
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V21.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D21
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V22.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D22
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V23.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D23
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a, LSL #32
    FMOV  X6, V24.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D24
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a, LSL #32
    FMOV  X6, V25.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D25
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V26.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D26
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V27.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D27
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X6, V28.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D28
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V29.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D29
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, V30.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D30
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    FMOV  X6, V31.D[1]
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    FMOV  X6, D31
    SUB  X19, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X27
    FMOV  V2.D[1], X17
    FMOV  D3, X14
    FMOV  V3.D[1], X29
    FMOV  D4, X13
    FMOV  V4.D[1], X23
    FMOV  D5, X28
    FMOV  V5.D[1], X19
    FMOV  D6, X27
    FMOV  V6.D[1], X20
    FMOV  D7, X27
    FMOV  V7.D[1], X18
    FMOV  D8, X17
    FMOV  V8.D[1], X14
    FMOV  D9, X2
    FMOV  V9.D[1], X24
    FMOV  D10, X10
    FMOV  V10.D[1], X29
    FMOV  D11, X24
    FMOV  V11.D[1], X19
    FMOV  D12, X18
    FMOV  V12.D[1], X17
    FMOV  D13, X5
    FMOV  V13.D[1], X8
    FMOV  D14, X19
    FMOV  V14.D[1], X11
    FMOV  D15, X29
    FMOV  V15.D[1], X2
    FMOV  D16, X27
    FMOV  V16.D[1], X14
    FMOV  D17, X11
    FMOV  V17.D[1], X24
    FMOV  D18, X18
    FMOV  V18.D[1], X27
    FMOV  D19, X24
    FMOV  V19.D[1], X13
    FMOV  D20, X5
    FMOV  V20.D[1], X8
    FMOV  D21, X25
    FMOV  V21.D[1], X10
    FMOV  D22, X19
    FMOV  V22.D[1], X6
    FMOV  D23, X18
    FMOV  V23.D[1], X13
    FMOV  D24, X18
    FMOV  V24.D[1], X29
    FMOV  D25, X28
    FMOV  V25.D[1], X28
    FMOV  D26, X20
    FMOV  V26.D[1], X9
    FMOV  D27, X14
    FMOV  V27.D[1], X18
    FMOV  D28, X16
    FMOV  V28.D[1], X27
    FMOV  D29, X20
    FMOV  V29.D[1], X14
    FMOV  D30, X6
    FMOV  V30.D[1], X28
    FMOV  D31, X13
    FMOV  V31.D[1], X8
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X20, #0xf00, LSL #0
    ADD  X5, X30, X20
    ST2 { V19.2D, V20.2D }, [X5]
    LD2 { V20.2D, V21.2D }, [X5]
    ADD  X5, X5, X8, ASR #0
    ST2 { V26.16B, V27.16B }, [X5]
    LD2 { V9.16B, V10.16B }, [X5]
    ADD  X5, X5, X8, LSR #0
    ST2 { V20.2D, V21.2D }, [X5]
    LD2 { V25.2D, V26.2D }, [X5]
    ADD  X5, X5, X8
    ST2 { V4.4S, V5.4S }, [X5]
    LD2 { V10.4S, V11.4S }, [X5]
    ADD  X5, X5, X8
    ST2 { V25.8H, V26.8H }, [X5]
    LD2 { V2.8H, V3.8H }, [X5]
    ADD  X5, X5, X8, LSR #0
    ST2 { V2.8B, V3.8B }, [X5]
    LD2 { V2.8B, V3.8B }, [X5]
    ADD  X5, X5, X8
    ST2 { V6.2S, V7.2S }, [X5]
    LD2 { V21.2S, V22.2S }, [X5]
    ADD  X5, X5, X8, ASR #0
    ST2 { V9.4H, V10.4H }, [X5]
    LD2 { V5.4H, V6.4H }, [X5]
    ADD  X5, X5, X8
    ST2 { V2.8B, V3.8B }, [X5]
    LD2 { V30.8B, V31.8B }, [X5]
    ADD  X5, X5, X8, LSR #0
    MOV  X25, X5
    ST2 { V5.8H, V6.8H }, [X25], #32
    MOV  X25, X5
    LD2 { V24.8H, V25.8H }, [X25], #32
    ADD  X5, X5, X8
    MOV  X25, X5
    ST2 { V21.16B, V22.16B }, [X25], #32
    MOV  X25, X5
    LD2 { V16.16B, V17.16B }, [X25], #32
    ADD  X5, X5, X8, ASR #0
    MOV  X25, X5
    ST2 { V16.2D, V17.2D }, [X25], #32
    MOV  X25, X5
    LD2 { V7.2D, V8.2D }, [X25], #32
    ADD  X5, X5, X8, LSR #0
    MOV  X25, X5
    ST2 { V24.4S, V25.4S }, [X25], #32
    MOV  X25, X5
    LD2 { V16.4S, V17.4S }, [X25], #32
    ADD  X5, X5, X8, LSR #0
    MOV  X25, X5
    ST2 { V16.8H, V17.8H }, [X25], #32
    MOV  X25, X5
    LD2 { V29.8H, V30.8H }, [X25], #32
    ADD  X5, X5, X8
    MOV  X25, X5
    ST2 { V7.4H, V8.4H }, [X25], #16
    MOV  X25, X5
    LD2 { V15.4H, V16.4H }, [X25], #16
    ADD  X5, X5, X8
    MOV  X25, X5
    ST2 { V15.2S, V16.2S }, [X25], #16
    MOV  X25, X5
    LD2 { V30.2S, V31.2S }, [X25], #16
    ADD  X5, X5, X8, ASR #0
    MOV  X25, X5
    ST2 { V30.4H, V31.4H }, [X25], #16
    MOV  X25, X5
    LD2 { V5.4H, V6.4H }, [X25], #16
    ADD  X5, X5, X8, LSR #0
    MOV  X25, X5
    ST2 { V23.8B, V24.8B }, [X25], #16
    MOV  X25, X5
    LD2 { V31.8B, V0.8B }, [X25], #16
    ADD  X5, X5, X8
    ST2 { V29.4S, V30.4S }, [X5], X29
    LD2 { V8.16B, V9.16B }, [X5], X29
    ADD  X5, X5, X8, LSR #0
    ST2 { V26.16B, V27.16B }, [X5], X29
    LD2 { V24.16B, V25.16B }, [X5], X29
    ADD  X5, X5, X8
    ST2 { V14.2D, V15.2D }, [X5], X29
    LD2 { V11.2D, V12.2D }, [X5], X29
    ADD  X5, X5, X8, LSR #0
    ST2 { V24.4S, V25.4S }, [X5], X29
    LD2 { V26.4S, V27.4S }, [X5], X29
    ADD  X5, X5, X8, LSR #0
    ST2 { V11.8H, V12.8H }, [X5], X29
    LD2 { V14.8H, V15.8H }, [X5], X29
    ADD  X5, X5, X8, ASR #0
    ST2 { V8.2S, V9.2S }, [X5], X29
    LD2 { V13.4H, V14.4H }, [X5], X29
    ADD  X5, X5, X8
    ST2 { V31.2S, V0.2S }, [X5], X29
    LD2 { V8.2S, V9.2S }, [X5], X29
    ADD  X5, X5, X8, LSR #0
    ST2 { V8.4H, V9.4H }, [X5], X29
    LD2 { V4.4H, V5.4H }, [X5], X29
    ADD  X5, X5, X8, LSR #0
    ST2 { V26.8B, V27.8B }, [X5], X29
    LD2 { V29.8B, V30.8B }, [X5], X29
    ADD  X5, X5, X8, LSR #0
    ST2 { V13.H, V14.H }[0x6], [X5]
    LD2 { V20.H, V21.H }[0x6], [X5]
    ADD  X5, X5, X8, LSR #0
    ST2 { V4.S, V5.S }[0x3], [X5]
    LD2 { V1.S, V2.S }[0x0], [X5]
    ADD  X5, X5, X8, LSR #0
    ST2 { V1.D, V2.D }[0x1], [X5]
    LD2 { V8.D, V9.D }[0x1], [X5]
    ADD  X5, X5, X8
    ST2 { V29.B, V30.B }[0x9], [X5]
    LD2 { V4.B, V5.B }[0x9], [X5]
    ADD  X5, X5, X8, ASR #0
    MOV  X25, X5
    ST2 { V8.H, V9.H }[0x0], [X25], #4
    MOV  X25, X5
    LD2 { V13.H, V14.H }[0x3], [X25], #4
    ADD  X5, X5, X8, ASR #0
    ST2 { V4.H, V5.H }[0x3], [X5], X29
    LD2 { V4.H, V5.H }[0x0], [X5], X29
    ADD  X5, X5, X8, LSR #0
    MOV  X25, X5
    ST2 { V20.S, V21.S }[0x0], [X25], #8
    MOV  X25, X5
    LD2 { V1.S, V2.S }[0x1], [X25], #8
    ADD  X5, X5, X8, ASR #0
    ST2 { V13.S, V14.S }[0x3], [X5], X29
    LD2 { V8.S, V9.S }[0x1], [X5], X29
    ADD  X5, X5, X8
    MOV  X25, X5
    ST2 { V1.D, V2.D }[0x0], [X25], #16
    MOV  X25, X5
    LD2 { V13.D, V14.D }[0x1], [X25], #16
    ADD  X5, X5, X8
    ST2 { V13.D, V14.D }[0x0], [X5], X29
    LD2 { V13.D, V14.D }[0x0], [X5], X29
    ADD  X5, X5, X8, LSR #0
    MOV  X25, X5
    ST2 { V8.B, V9.B }[0x3], [X25], #2
    MOV  X25, X5
    LD2 { V1.B, V2.B }[0x4], [X25], #2
    ADD  X5, X5, X8, ASR #0
    ST2 { V1.B, V2.B }[0x5], [X5], X29
    LD2 { V8.B, V9.B }[0x0], [X5], X29
    ADD  X5, X5, X8, LSR #0
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X2
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X6
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X10
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X13
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X17
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X19
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X22
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X7, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MRS  X7, FPSR
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V0.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D0
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V1.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D1
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V2.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D2
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V3.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D3
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V4.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D4
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V5.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D5
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V6.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D6
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V7.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D7
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V8.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    FMOV  X7, D8
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V9.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    FMOV  X7, D9
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V10.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D10
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V11.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D11
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V12.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D12
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V13.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D13
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V14.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D14
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V15.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D15
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V16.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D16
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V17.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D17
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V18.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D18
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V19.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D19
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V20.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D20
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V21.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D21
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V22.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D22
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V23.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D23
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V24.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D24
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V25.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D25
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V26.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D26
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V27.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D27
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, V28.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D28
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V29.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D29
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V30.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D30
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0x0, LSL #0
    FMOV  X7, V31.D[1]
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    FMOV  X7, D31
    SUB  X18, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X26
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X28
    FMOV  D3, X8
    FMOV  V3.D[1], X18
    FMOV  D4, X14
    FMOV  V4.D[1], X7
    FMOV  D5, X22
    FMOV  V5.D[1], X28
    FMOV  D6, X24
    FMOV  V6.D[1], X25
    FMOV  D7, X13
    FMOV  V7.D[1], X10
    FMOV  D8, X8
    FMOV  V8.D[1], X20
    FMOV  D9, X2
    FMOV  V9.D[1], X7
    FMOV  D10, X29
    FMOV  V10.D[1], X27
    FMOV  D11, X17
    FMOV  V11.D[1], X29
    FMOV  D12, X14
    FMOV  V12.D[1], X2
    FMOV  D13, X29
    FMOV  V13.D[1], X8
    FMOV  D14, X6
    FMOV  V14.D[1], X5
    FMOV  D15, X6
    FMOV  V15.D[1], X14
    FMOV  D16, X7
    FMOV  V16.D[1], X27
    FMOV  D17, X27
    FMOV  V17.D[1], X9
    FMOV  D18, X7
    FMOV  V18.D[1], X8
    FMOV  D19, X20
    FMOV  V19.D[1], X16
    FMOV  D20, X9
    FMOV  V20.D[1], X18
    FMOV  D21, X27
    FMOV  V21.D[1], X28
    FMOV  D22, X18
    FMOV  V22.D[1], X27
    FMOV  D23, X20
    FMOV  V23.D[1], X18
    FMOV  D24, X19
    FMOV  V24.D[1], X18
    FMOV  D25, X11
    FMOV  V25.D[1], X24
    FMOV  D26, X29
    FMOV  V26.D[1], X8
    FMOV  D27, X3
    FMOV  V27.D[1], X13
    FMOV  D28, X14
    FMOV  V28.D[1], X9
    FMOV  D29, X18
    FMOV  V29.D[1], X19
    FMOV  D30, X9
    FMOV  V30.D[1], X6
    FMOV  D31, X18
    FMOV  V31.D[1], X27
    MOVZ  X11, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X3, #0x1400, LSL #0
    ADD  X8, X30, X3, LSR #0
    ST2 { V27.16B, V28.16B }, [X8]
    LD2 { V5.2D, V6.2D }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V30.16B, V31.16B }, [X8]
    LD2 { V27.16B, V28.16B }, [X8]
    ADD  X8, X8, X16, LSR #0
    ST2 { V21.2D, V22.2D }, [X8]
    LD2 { V8.2D, V9.2D }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V28.4S, V29.4S }, [X8]
    LD2 { V8.4S, V9.4S }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V8.8H, V9.8H }, [X8]
    LD2 { V9.8H, V10.8H }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V5.4H, V6.4H }, [X8]
    LD2 { V17.8B, V18.8B }, [X8]
    ADD  X8, X8, X16
    ST2 { V28.2S, V29.2S }, [X8]
    LD2 { V17.2S, V18.2S }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V17.4H, V18.4H }, [X8]
    LD2 { V23.4H, V24.4H }, [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V10.8B, V11.8B }, [X8]
    LD2 { V24.8B, V25.8B }, [X8]
    ADD  X8, X8, X16, ASR #0
    MOV  X17, X8
    ST2 { V22.2D, V23.2D }, [X17], #32
    MOV  X17, X8
    LD2 { V18.4S, V19.4S }, [X17], #32
    ADD  X8, X8, X16
    MOV  X17, X8
    ST2 { V18.16B, V19.16B }, [X17], #32
    MOV  X17, X8
    LD2 { V10.16B, V11.16B }, [X17], #32
    ADD  X8, X8, X16, ASR #0
    MOV  X17, X8
    ST2 { V10.2D, V11.2D }, [X17], #32
    MOV  X17, X8
    LD2 { V22.2D, V23.2D }, [X17], #32
    ADD  X8, X8, X16, LSR #0
    MOV  X17, X8
    ST2 { V23.4S, V24.4S }, [X17], #32
    MOV  X17, X8
    LD2 { V18.4S, V19.4S }, [X17], #32
    ADD  X8, X8, X16
    MOV  X17, X8
    ST2 { V18.8H, V19.8H }, [X17], #32
    MOV  X17, X8
    LD2 { V10.8H, V11.8H }, [X17], #32
    ADD  X8, X8, X16, ASR #0
    MOV  X17, X8
    ST2 { V29.8B, V30.8B }, [X17], #16
    MOV  X17, X8
    LD2 { V29.8B, V30.8B }, [X17], #16
    ADD  X8, X8, X16, ASR #0
    MOV  X17, X8
    ST2 { V10.2S, V11.2S }, [X17], #16
    MOV  X17, X8
    LD2 { V18.2S, V19.2S }, [X17], #16
    ADD  X8, X8, X16, LSR #0
    MOV  X17, X8
    ST2 { V29.4H, V30.4H }, [X17], #16
    MOV  X17, X8
    LD2 { V23.4H, V24.4H }, [X17], #16
    ADD  X8, X8, X16, LSR #0
    MOV  X17, X8
    ST2 { V18.8B, V19.8B }, [X17], #16
    MOV  X17, X8
    LD2 { V18.8B, V19.8B }, [X17], #16
    ADD  X8, X8, X16, ASR #0
    ST2 { V18.16B, V19.16B }, [X8], X11
    LD2 { V29.2D, V30.2D }, [X8], X11
    ADD  X8, X8, X16, LSR #0
    ST2 { V29.16B, V30.16B }, [X8], X11
    LD2 { V18.16B, V19.16B }, [X8], X11
    ADD  X8, X8, X16, ASR #0
    ST2 { V18.2D, V19.2D }, [X8], X11
    LD2 { V29.2D, V30.2D }, [X8], X11
    ADD  X8, X8, X16
    ST2 { V29.4S, V30.4S }, [X8], X11
    LD2 { V29.4S, V30.4S }, [X8], X11
    ADD  X8, X8, X16, LSR #0
    ST2 { V23.8H, V24.8H }, [X8], X11
    LD2 { V18.8H, V19.8H }, [X8], X11
    ADD  X8, X8, X16, ASR #0
    ST2 { V29.4H, V30.4H }, [X8], X11
    LD2 { V29.4H, V30.4H }, [X8], X11
    ADD  X8, X8, X16
    ST2 { V8.2S, V9.2S }, [X8], X11
    LD2 { V23.2S, V24.2S }, [X8], X11
    ADD  X8, X8, X16, ASR #0
    ST2 { V18.4H, V19.4H }, [X8], X11
    LD2 { V9.4H, V10.4H }, [X8], X11
    ADD  X8, X8, X16
    ST2 { V29.8B, V30.8B }, [X8], X11
    LD2 { V31.8B, V0.8B }, [X8], X11
    ADD  X8, X8, X16, ASR #0
    ST2 { V9.H, V10.H }[0x1], [X8]
    LD2 { V20.H, V21.H }[0x6], [X8]
    ADD  X8, X8, X16
    ST2 { V20.S, V21.S }[0x2], [X8]
    LD2 { V31.S, V0.S }[0x2], [X8]
    ADD  X8, X8, X16, LSR #0
    ST2 { V23.D, V24.D }[0x1], [X8]
    LD2 { V24.D, V25.D }[0x1], [X8]
    ADD  X8, X8, X16, ASR #0
    ST2 { V24.B, V25.B }[0xf], [X8]
    LD2 { V15.B, V16.B }[0x6], [X8]
    ADD  X8, X8, X16, ASR #0
    MOV  X17, X8
    ST2 { V31.H, V0.H }[0x0], [X17], #4
    MOV  X17, X8
    LD2 { V13.H, V14.H }[0x0], [X17], #4
    ADD  X8, X8, X16, LSR #0
    ST2 { V13.H, V14.H }[0x5], [X8], X11
    LD2 { V9.H, V10.H }[0x3], [X8], X11
    ADD  X8, X8, X16, ASR #0
    MOV  X17, X8
    ST2 { V9.S, V10.S }[0x2], [X17], #8
    MOV  X17, X8
    LD2 { V18.S, V19.S }[0x2], [X17], #8
    ADD  X8, X8, X16
    ST2 { V25.S, V26.S }[0x0], [X8], X11
    LD2 { V20.S, V21.S }[0x0], [X8], X11
    ADD  X8, X8, X16, LSR #0
    MOV  X17, X8
    ST2 { V15.D, V16.D }[0x0], [X17], #16
    MOV  X17, X8
    LD2 { V15.D, V16.D }[0x0], [X17], #16
    ADD  X8, X8, X16
    ST2 { V18.D, V19.D }[0x0], [X8], X11
    LD2 { V18.D, V19.D }[0x1], [X8], X11
    ADD  X8, X8, X16, LSR #0
    MOV  X17, X8
    ST2 { V20.B, V21.B }[0x3], [X17], #2
    MOV  X17, X8
    LD2 { V20.B, V21.B }[0x0], [X17], #2
    ADD  X8, X8, X16
    ST2 { V18.B, V19.B }[0x8], [X8], X11
    LD2 { V31.B, V0.B }[0xa], [X8], X11
    ADD  X8, X8, X16, LSR #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X20, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    MRS  X20, FPSR
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    FMOV  X20, V0.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D0
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V1.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D1
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V2.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D2
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V3.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D3
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V4.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D4
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V5.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D5
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V6.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D6
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V7.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D7
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V8.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D8
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X20, V9.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D9
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X20, V10.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D10
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X20, V11.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D11
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V12.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D12
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V13.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D13
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V14.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D14
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V15.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a00, LSL #48
    FMOV  X20, D15
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V16.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a00, LSL #48
    FMOV  X20, D16
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X20, V17.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D17
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V18.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D18
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V19.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D19
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V20.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D20
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V21.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D21
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    FMOV  X20, V22.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D22
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X20, V23.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D23
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X20, V24.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D24
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X20, V25.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D25
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V26.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D26
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V27.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D27
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, V28.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D28
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X20, V29.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D29
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X20, V30.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D30
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    FMOV  X20, V31.D[1]
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X20, D31
    SUB  X5, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X22
    FMOV  D1, X25
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X28
    FMOV  D3, X14
    FMOV  V3.D[1], X22
    FMOV  D4, X25
    FMOV  V4.D[1], X26
    FMOV  D5, X22
    FMOV  V5.D[1], X3
    FMOV  D6, X5
    FMOV  V6.D[1], X2
    FMOV  D7, X17
    FMOV  V7.D[1], X25
    FMOV  D8, X26
    FMOV  V8.D[1], X5
    FMOV  D9, X18
    FMOV  V9.D[1], X10
    FMOV  D10, X18
    FMOV  V10.D[1], X6
    FMOV  D11, X24
    FMOV  V11.D[1], X9
    FMOV  D12, X29
    FMOV  V12.D[1], X10
    FMOV  D13, X6
    FMOV  V13.D[1], X17
    FMOV  D14, X20
    FMOV  V14.D[1], X25
    FMOV  D15, X7
    FMOV  V15.D[1], X29
    FMOV  D16, X29
    FMOV  V16.D[1], X18
    FMOV  D17, X8
    FMOV  V17.D[1], X24
    FMOV  D18, X27
    FMOV  V18.D[1], X25
    FMOV  D19, X7
    FMOV  V19.D[1], X9
    FMOV  D20, X23
    FMOV  V20.D[1], X16
    FMOV  D21, X7
    FMOV  V21.D[1], X29
    FMOV  D22, X9
    FMOV  V22.D[1], X16
    FMOV  D23, X18
    FMOV  V23.D[1], X13
    FMOV  D24, X9
    FMOV  V24.D[1], X19
    FMOV  D25, X28
    FMOV  V25.D[1], X9
    FMOV  D26, X8
    FMOV  V26.D[1], X6
    FMOV  D27, X25
    FMOV  V27.D[1], X28
    FMOV  D28, X16
    FMOV  V28.D[1], X11
    FMOV  D29, X9
    FMOV  V29.D[1], X17
    FMOV  D30, X26
    FMOV  V30.D[1], X16
    FMOV  D31, X26
    FMOV  V31.D[1], X19
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X3, #0x40, LSL #0
    MOVZ  X11, #0x1900, LSL #0
    ADD  X22, X30, X11, ASR #0
    ST2 { V20.8H, V21.8H }, [X22]
    LD2 { V8.2D, V9.2D }, [X22]
    ADD  X22, X22, X3
    ST2 { V29.16B, V30.16B }, [X22]
    LD2 { V16.16B, V17.16B }, [X22]
    ADD  X22, X22, X3, LSR #0
    ST2 { V30.2D, V31.2D }, [X22]
    LD2 { V14.2D, V15.2D }, [X22]
    ADD  X22, X22, X3, ASR #0
    ST2 { V15.4S, V16.4S }, [X22]
    LD2 { V4.4S, V5.4S }, [X22]
    ADD  X22, X22, X3
    ST2 { V27.8H, V28.8H }, [X22]
    LD2 { V25.8H, V26.8H }, [X22]
    ADD  X22, X22, X3, ASR #0
    ST2 { V25.2S, V26.2S }, [X22]
    LD2 { V11.2S, V12.2S }, [X22]
    ADD  X22, X22, X3, ASR #0
    ST2 { V4.2S, V5.2S }, [X22]
    LD2 { V24.2S, V25.2S }, [X22]
    ADD  X22, X22, X3, LSR #0
    ST2 { V24.4H, V25.4H }, [X22]
    LD2 { V30.4H, V31.4H }, [X22]
    ADD  X22, X22, X3, LSR #0
    ST2 { V30.8B, V31.8B }, [X22]
    LD2 { V31.8B, V0.8B }, [X22]
    ADD  X22, X22, X3, LSR #0
    MOV  X28, X22
    ST2 { V26.16B, V27.16B }, [X28], #32
    MOV  X28, X22
    LD2 { V25.4S, V26.4S }, [X28], #32
    ADD  X22, X22, X3
    MOV  X28, X22
    ST2 { V19.16B, V20.16B }, [X28], #32
    MOV  X28, X22
    LD2 { V9.16B, V10.16B }, [X28], #32
    ADD  X22, X22, X3
    MOV  X28, X22
    ST2 { V31.2D, V0.2D }, [X28], #32
    MOV  X28, X22
    LD2 { V20.2D, V21.2D }, [X28], #32
    ADD  X22, X22, X3
    MOV  X28, X22
    ST2 { V20.4S, V21.4S }, [X28], #32
    MOV  X28, X22
    LD2 { V18.4S, V19.4S }, [X28], #32
    ADD  X22, X22, X3, ASR #0
    MOV  X28, X22
    ST2 { V9.8H, V10.8H }, [X28], #32
    MOV  X28, X22
    LD2 { V13.8H, V14.8H }, [X28], #32
    ADD  X22, X22, X3, LSR #0
    MOV  X28, X22
    ST2 { V13.2S, V14.2S }, [X28], #16
    MOV  X28, X22
    LD2 { V1.2S, V2.2S }, [X28], #16
    ADD  X22, X22, X3
    MOV  X28, X22
    ST2 { V1.2S, V2.2S }, [X28], #16
    MOV  X28, X22
    LD2 { V11.2S, V12.2S }, [X28], #16
    ADD  X22, X22, X3, ASR #0
    MOV  X28, X22
    ST2 { V11.4H, V12.4H }, [X28], #16
    MOV  X28, X22
    LD2 { V26.4H, V27.4H }, [X28], #16
    ADD  X22, X22, X3, ASR #0
    MOV  X28, X22
    ST2 { V26.8B, V27.8B }, [X28], #16
    MOV  X28, X22
    LD2 { V29.8B, V30.8B }, [X28], #16
    ADD  X22, X22, X3, ASR #0
    ST2 { V29.8H, V30.8H }, [X22], X29
    LD2 { V11.2D, V12.2D }, [X22], X29
    ADD  X22, X22, X3
    ST2 { V11.16B, V12.16B }, [X22], X29
    LD2 { V8.16B, V9.16B }, [X22], X29
    ADD  X22, X22, X3
    ST2 { V8.2D, V9.2D }, [X22], X29
    LD2 { V2.2D, V3.2D }, [X22], X29
    ADD  X22, X22, X3, ASR #0
    ST2 { V25.4S, V26.4S }, [X22], X29
    LD2 { V14.4S, V15.4S }, [X22], X29
    ADD  X22, X22, X3, LSR #0
    ST2 { V30.8H, V31.8H }, [X22], X29
    LD2 { V2.8H, V3.8H }, [X22], X29
    ADD  X22, X22, X3
    ST2 { V19.8B, V20.8B }, [X22], X29
    LD2 { V7.2S, V8.2S }, [X22], X29
    ADD  X22, X22, X3
    ST2 { V27.2S, V28.2S }, [X22], X29
    LD2 { V0.2S, V1.2S }, [X22], X29
    ADD  X22, X22, X3, ASR #0
    ST2 { V19.4H, V20.4H }, [X22], X29
    LD2 { V21.4H, V22.4H }, [X22], X29
    ADD  X22, X22, X3, ASR #0
    ST2 { V1.8B, V2.8B }, [X22], X29
    LD2 { V8.8B, V9.8B }, [X22], X29
    ADD  X22, X22, X3, ASR #0
    ST2 { V12.H, V13.H }[0x5], [X22]
    LD2 { V1.H, V2.H }[0x7], [X22]
    ADD  X22, X22, X3, ASR #0
    ST2 { V14.S, V15.S }[0x0], [X22]
    LD2 { V5.S, V6.S }[0x1], [X22]
    ADD  X22, X22, X3, LSR #0
    ST2 { V6.D, V7.D }[0x0], [X22]
    LD2 { V12.D, V13.D }[0x1], [X22]
    ADD  X22, X22, X3, ASR #0
    ST2 { V1.B, V2.B }[0xe], [X22]
    LD2 { V1.B, V2.B }[0x0], [X22]
    ADD  X22, X22, X3, ASR #0
    MOV  X28, X22
    ST2 { V30.H, V31.H }[0x1], [X28], #4
    MOV  X28, X22
    LD2 { V6.H, V7.H }[0x6], [X28], #4
    ADD  X22, X22, X3, ASR #0
    ST2 { V5.H, V6.H }[0x1], [X22], X29
    LD2 { V14.H, V15.H }[0x3], [X22], X29
    ADD  X22, X22, X3, LSR #0
    MOV  X28, X22
    ST2 { V12.S, V13.S }[0x0], [X28], #8
    MOV  X28, X22
    LD2 { V5.S, V6.S }[0x1], [X28], #8
    ADD  X22, X22, X3
    ST2 { V1.S, V2.S }[0x3], [X22], X29
    LD2 { V12.S, V13.S }[0x3], [X22], X29
    ADD  X22, X22, X3, ASR #0
    MOV  X28, X22
    ST2 { V14.D, V15.D }[0x1], [X28], #16
    MOV  X28, X22
    LD2 { V1.D, V2.D }[0x1], [X28], #16
    ADD  X22, X22, X3
    ST2 { V5.D, V6.D }[0x1], [X22], X29
    LD2 { V14.D, V15.D }[0x0], [X22], X29
    ADD  X22, X22, X3, ASR #0
    MOV  X28, X22
    ST2 { V13.B, V14.B }[0xc], [X28], #2
    MOV  X28, X22
    LD2 { V13.B, V14.B }[0xb], [X28], #2
    ADD  X22, X22, X3
    ST2 { V14.B, V15.B }[0xc], [X22], X29
    LD2 { V5.B, V6.B }[0x9], [X22], X29
    ADD  X22, X22, X3, LSR #0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X20
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X26, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    MRS  X26, FPSR
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V0.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D0
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V1.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa500, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D1
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V2.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D2
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V3.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D3
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V4.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D4
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V5.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D5
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V6.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D6
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0xa5a5, LSL #32
    FMOV  X26, V7.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D7
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V8.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D8
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V9.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D9
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V10.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D10
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V11.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D11
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    FMOV  X26, V12.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D12
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5, LSL #16
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V13.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D13
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V14.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D14
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V15.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D15
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V16.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D16
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V17.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D17
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V18.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D18
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V19.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D19
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V20.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D20
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V21.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D21
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V22.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D22
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V23.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D23
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V24.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D24
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V25.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D25
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V26.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D26
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V27.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D27
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, V28.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D28
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V29.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D29
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V30.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D30
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0x0, LSL #0
    FMOV  X26, V31.D[1]
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    FMOV  X26, D31
    SUB  X18, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X18
    FMOV  V3.D[1], X27
    FMOV  D4, X16
    FMOV  V4.D[1], X13
    FMOV  D5, X14
    FMOV  V5.D[1], X18
    FMOV  D6, X24
    FMOV  V6.D[1], X29
    FMOV  D7, X7
    FMOV  V7.D[1], X10
    FMOV  D8, X11
    FMOV  V8.D[1], X27
    FMOV  D9, X11
    FMOV  V9.D[1], X8
    FMOV  D10, X27
    FMOV  V10.D[1], X6
    FMOV  D11, X16
    FMOV  V11.D[1], X17
    FMOV  D12, X10
    FMOV  V12.D[1], X17
    FMOV  D13, X24
    FMOV  V13.D[1], X11
    FMOV  D14, X22
    FMOV  V14.D[1], X16
    FMOV  D15, X8
    FMOV  V15.D[1], X20
    FMOV  D16, X25
    FMOV  V16.D[1], X7
    FMOV  D17, X10
    FMOV  V17.D[1], X14
    FMOV  D18, X2
    FMOV  V18.D[1], X2
    FMOV  D19, X6
    FMOV  V19.D[1], X7
    FMOV  D20, X29
    FMOV  V20.D[1], X19
    FMOV  D21, X22
    FMOV  V21.D[1], X28
    FMOV  D22, X3
    FMOV  V22.D[1], X9
    FMOV  D23, X3
    FMOV  V23.D[1], X28
    FMOV  D24, X24
    FMOV  V24.D[1], X5
    FMOV  D25, X24
    FMOV  V25.D[1], X20
    FMOV  D26, X24
    FMOV  V26.D[1], X7
    FMOV  D27, X9
    FMOV  V27.D[1], X9
    FMOV  D28, X27
    FMOV  V28.D[1], X26
    FMOV  D29, X8
    FMOV  V29.D[1], X18
    FMOV  D30, X6
    FMOV  V30.D[1], X17
    FMOV  D31, X28
    FMOV  V31.D[1], X3
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X8, #0x1e00, LSL #0
    ADD  X28, X30, X8, ASR #0
    ST2 { V24.8H, V25.8H }, [X28]
    LD2 { V20.8H, V21.8H }, [X28]
    ADD  X28, X28, X2, LSR #0
    ST2 { V29.16B, V30.16B }, [X28]
    LD2 { V28.16B, V29.16B }, [X28]
    ADD  X28, X28, X2
    ST2 { V1.2D, V2.2D }, [X28]
    LD2 { V28.2D, V29.2D }, [X28]
    ADD  X28, X28, X2, ASR #0
    ST2 { V28.4S, V29.4S }, [X28]
    LD2 { V28.4S, V29.4S }, [X28]
    ADD  X28, X28, X2, ASR #0
    ST2 { V20.8H, V21.8H }, [X28]
    LD2 { V16.8H, V17.8H }, [X28]
    ADD  X28, X28, X2, ASR #0
    ST2 { V28.8B, V29.8B }, [X28]
    LD2 { V7.4H, V8.4H }, [X28]
    ADD  X28, X28, X2, LSR #0
    ST2 { V7.2S, V8.2S }, [X28]
    LD2 { V20.2S, V21.2S }, [X28]
    ADD  X28, X28, X2
    ST2 { V16.4H, V17.4H }, [X28]
    LD2 { V11.4H, V12.4H }, [X28]
    ADD  X28, X28, X2, ASR #0
    ST2 { V20.8B, V21.8B }, [X28]
    LD2 { V15.8B, V16.8B }, [X28]
    ADD  X28, X28, X2, ASR #0
    MOV  X10, X28
    ST2 { V26.4S, V27.4S }, [X10], #32
    MOV  X10, X28
    LD2 { V8.8H, V9.8H }, [X10], #32
    ADD  X28, X28, X2
    MOV  X10, X28
    ST2 { V15.16B, V16.16B }, [X10], #32
    MOV  X10, X28
    LD2 { V17.16B, V18.16B }, [X10], #32
    ADD  X28, X28, X2, ASR #0
    MOV  X10, X28
    ST2 { V8.2D, V9.2D }, [X10], #32
    MOV  X10, X28
    LD2 { V1.2D, V2.2D }, [X10], #32
    ADD  X28, X28, X2
    MOV  X10, X28
    ST2 { V1.4S, V2.4S }, [X10], #32
    MOV  X10, X28
    LD2 { V7.4S, V8.4S }, [X10], #32
    ADD  X28, X28, X2, ASR #0
    MOV  X10, X28
    ST2 { V17.8H, V18.8H }, [X10], #32
    MOV  X10, X28
    LD2 { V11.8H, V12.8H }, [X10], #32
    ADD  X28, X28, X2, ASR #0
    MOV  X10, X28
    ST2 { V11.8B, V12.8B }, [X10], #16
    MOV  X10, X28
    LD2 { V28.2S, V29.2S }, [X10], #16
    ADD  X28, X28, X2
    MOV  X10, X28
    ST2 { V7.2S, V8.2S }, [X10], #16
    MOV  X10, X28
    LD2 { V23.2S, V24.2S }, [X10], #16
    ADD  X28, X28, X2, LSR #0
    MOV  X10, X28
    ST2 { V28.4H, V29.4H }, [X10], #16
    MOV  X10, X28
    LD2 { V15.4H, V16.4H }, [X10], #16
    ADD  X28, X28, X2, LSR #0
    MOV  X10, X28
    ST2 { V15.8B, V16.8B }, [X10], #16
    MOV  X10, X28
    LD2 { V7.8B, V8.8B }, [X10], #16
    ADD  X28, X28, X2
    ST2 { V7.8H, V8.8H }, [X28], X26
    LD2 { V22.2D, V23.2D }, [X28], X26
    ADD  X28, X28, X2, LSR #0
    ST2 { V21.16B, V22.16B }, [X28], X26
    LD2 { V3.16B, V4.16B }, [X28], X26
    ADD  X28, X28, X2, ASR #0
    ST2 { V12.2D, V13.2D }, [X28], X26
    LD2 { V11.2D, V12.2D }, [X28], X26
    ADD  X28, X28, X2, ASR #0
    ST2 { V14.4S, V15.4S }, [X28], X26
    LD2 { V21.4S, V22.4S }, [X28], X26
    ADD  X28, X28, X2, LSR #0
    ST2 { V21.8H, V22.8H }, [X28], X26
    LD2 { V16.8H, V17.8H }, [X28], X26
    ADD  X28, X28, X2
    ST2 { V9.4H, V10.4H }, [X28], X26
    LD2 { V1.2S, V2.2S }, [X28], X26
    ADD  X28, X28, X2
    ST2 { V2.2S, V3.2S }, [X28], X26
    LD2 { V28.2S, V29.2S }, [X28], X26
    ADD  X28, X28, X2, ASR #0
    ST2 { V19.4H, V20.4H }, [X28], X26
    LD2 { V13.4H, V14.4H }, [X28], X26
    ADD  X28, X28, X2
    ST2 { V16.8B, V17.8B }, [X28], X26
    LD2 { V16.8B, V17.8B }, [X28], X26
    ADD  X28, X28, X2
    ST2 { V13.H, V14.H }[0x3], [X28]
    LD2 { V3.H, V4.H }[0x5], [X28]
    ADD  X28, X28, X2
    ST2 { V11.S, V12.S }[0x1], [X28]
    LD2 { V25.S, V26.S }[0x1], [X28]
    ADD  X28, X28, X2
    ST2 { V4.D, V5.D }[0x1], [X28]
    LD2 { V10.D, V11.D }[0x0], [X28]
    ADD  X28, X28, X2, ASR #0
    ST2 { V10.B, V11.B }[0x0], [X28]
    LD2 { V7.B, V8.B }[0x9], [X28]
    ADD  X28, X28, X2, LSR #0
    MOV  X10, X28
    ST2 { V16.H, V17.H }[0x4], [X10], #4
    MOV  X10, X28
    LD2 { V16.H, V17.H }[0x4], [X10], #4
    ADD  X28, X28, X2, ASR #0
    ST2 { V7.H, V8.H }[0x5], [X28], X26
    LD2 { V10.H, V11.H }[0x6], [X28], X26
    ADD  X28, X28, X2, ASR #0
    MOV  X10, X28
    ST2 { V25.S, V26.S }[0x3], [X10], #8
    MOV  X10, X28
    LD2 { V15.S, V16.S }[0x2], [X10], #8
    ADD  X28, X28, X2, LSR #0
    ST2 { V15.S, V16.S }[0x0], [X28], X26
    LD2 { V25.S, V26.S }[0x3], [X28], X26
    ADD  X28, X28, X2, ASR #0
    MOV  X10, X28
    ST2 { V4.D, V5.D }[0x1], [X10], #16
    MOV  X10, X28
    LD2 { V7.D, V8.D }[0x0], [X10], #16
    ADD  X28, X28, X2
    ST2 { V17.D, V18.D }[0x0], [X28], X26
    LD2 { V8.D, V9.D }[0x0], [X28], X26
    ADD  X28, X28, X2
    MOV  X10, X28
    ST2 { V30.B, V31.B }[0x2], [X10], #2
    MOV  X10, X28
    LD2 { V15.B, V16.B }[0x2], [X10], #2
    ADD  X28, X28, X2, ASR #0
    ST2 { V25.B, V26.B }[0x4], [X28], X26
    LD2 { V4.B, V5.B }[0x5], [X28], X26
    ADD  X28, X28, X2
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X18, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V1.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D1
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V2.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D2
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X18, V3.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D3
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X18, V4.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D4
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V5.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D5
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V6.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D6
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X18, D7
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a00, LSL #0
    FMOV  X18, V8.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D8
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V9.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D9
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V10.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X18, D10
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V11.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D11
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V12.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D12
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D13
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D14
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X18, V15.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D15
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    FMOV  X18, V16.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D16
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D17
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V18.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D18
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D19
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V20.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D20
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V21.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D21
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V22.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D22
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V23.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D23
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D24
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V25.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D25
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V26.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D26
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V27.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D27
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V28.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D28
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x0, LSL #0
    FMOV  X18, V29.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D29
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V30.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, V31.D[1]
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    FMOV  X18, D31
    SUB  X20, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V1.D[1], X24
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X7
    FMOV  V3.D[1], X16
    FMOV  D4, X6
    FMOV  V4.D[1], X3
    FMOV  D5, X27
    FMOV  V5.D[1], X16
    FMOV  D6, X3
    FMOV  V6.D[1], X3
    FMOV  D7, X25
    FMOV  V7.D[1], X2
    FMOV  D8, X9
    FMOV  V8.D[1], X14
    FMOV  D9, X9
    FMOV  V9.D[1], X17
    FMOV  D10, X13
    FMOV  V10.D[1], X23
    FMOV  D11, X14
    FMOV  V11.D[1], X20
    FMOV  D12, X9
    FMOV  V12.D[1], X3
    FMOV  D13, X24
    FMOV  V13.D[1], X26
    FMOV  D14, X24
    FMOV  V14.D[1], X13
    FMOV  D15, X28
    FMOV  V15.D[1], X29
    FMOV  D16, X8
    FMOV  V16.D[1], X17
    FMOV  D17, X18
    FMOV  V17.D[1], X22
    FMOV  D18, X10
    FMOV  V18.D[1], X23
    FMOV  D19, X25
    FMOV  V19.D[1], X5
    FMOV  D20, X17
    FMOV  V20.D[1], X11
    FMOV  D21, X6
    FMOV  V21.D[1], X25
    FMOV  D22, X7
    FMOV  V22.D[1], X26
    FMOV  D23, X20
    FMOV  V23.D[1], X2
    FMOV  D24, X16
    FMOV  V24.D[1], X28
    FMOV  D25, X13
    FMOV  V25.D[1], X11
    FMOV  D26, X20
    FMOV  V26.D[1], X3
    FMOV  D27, X19
    FMOV  V27.D[1], X5
    FMOV  D28, X11
    FMOV  V28.D[1], X7
    FMOV  D29, X18
    FMOV  V29.D[1], X3
    FMOV  D30, X8
    FMOV  V30.D[1], X29
    FMOV  D31, X25
    FMOV  V31.D[1], X3
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X27, #0x2300, LSL #0
    ADD  X9, X30, X27
    ST2 { V25.4S, V26.4S }, [X9]
    LD2 { V21.2D, V22.2D }, [X9]
    ADD  X9, X9, X5, ASR #0
    ST2 { V27.16B, V28.16B }, [X9]
    LD2 { V28.16B, V29.16B }, [X9]
    ADD  X9, X9, X5, LSR #0
    ST2 { V28.2D, V29.2D }, [X9]
    LD2 { V15.2D, V16.2D }, [X9]
    ADD  X9, X9, X5
    ST2 { V15.4S, V16.4S }, [X9]
    LD2 { V23.4S, V24.4S }, [X9]
    ADD  X9, X9, X5, LSR #0
    ST2 { V23.8H, V24.8H }, [X9]
    LD2 { V28.8H, V29.8H }, [X9]
    ADD  X9, X9, X5
    ST2 { V21.4H, V22.4H }, [X9]
    LD2 { V22.4H, V23.4H }, [X9]
    ADD  X9, X9, X5
    ST2 { V28.2S, V29.2S }, [X9]
    LD2 { V7.2S, V8.2S }, [X9]
    ADD  X9, X9, X5
    ST2 { V22.4H, V23.4H }, [X9]
    LD2 { V25.4H, V26.4H }, [X9]
    ADD  X9, X9, X5
    ST2 { V25.8B, V26.8B }, [X9]
    LD2 { V8.8B, V9.8B }, [X9]
    ADD  X9, X9, X5
    MOV  X8, X9
    ST2 { V8.8H, V9.8H }, [X8], #32
    MOV  X8, X9
    LD2 { V10.2D, V11.2D }, [X8], #32
    ADD  X9, X9, X5, ASR #0
    MOV  X8, X9
    ST2 { V11.16B, V12.16B }, [X8], #32
    MOV  X8, X9
    LD2 { V8.16B, V9.16B }, [X8], #32
    ADD  X9, X9, X5, LSR #0
    MOV  X8, X9
    ST2 { V9.2D, V10.2D }, [X8], #32
    MOV  X8, X9
    LD2 { V9.2D, V10.2D }, [X8], #32
    ADD  X9, X9, X5
    MOV  X8, X9
    ST2 { V19.4S, V20.4S }, [X8], #32
    MOV  X8, X9
    LD2 { V19.4S, V20.4S }, [X8], #32
    ADD  X9, X9, X5
    MOV  X8, X9
    ST2 { V12.8H, V13.8H }, [X8], #32
    MOV  X8, X9
    LD2 { V11.8H, V12.8H }, [X8], #32
    ADD  X9, X9, X5, ASR #0
    MOV  X8, X9
    ST2 { V30.8B, V31.8B }, [X8], #16
    MOV  X8, X9
    LD2 { V30.2S, V31.2S }, [X8], #16
    ADD  X9, X9, X5, ASR #0
    MOV  X8, X9
    ST2 { V9.2S, V10.2S }, [X8], #16
    MOV  X8, X9
    LD2 { V16.2S, V17.2S }, [X8], #16
    ADD  X9, X9, X5, ASR #0
    MOV  X8, X9
    ST2 { V9.4H, V10.4H }, [X8], #16
    MOV  X8, X9
    LD2 { V23.4H, V24.4H }, [X8], #16
    ADD  X9, X9, X5, ASR #0
    MOV  X8, X9
    ST2 { V16.8B, V17.8B }, [X8], #16
    MOV  X8, X9
    LD2 { V10.8B, V11.8B }, [X8], #16
    ADD  X9, X9, X5, LSR #0
    ST2 { V23.4S, V24.4S }, [X9], X13
    LD2 { V3.2D, V4.2D }, [X9], X13
    ADD  X9, X9, X5, ASR #0
    ST2 { V3.16B, V4.16B }, [X9], X13
    LD2 { V0.16B, V1.16B }, [X9], X13
    ADD  X9, X9, X5, ASR #0
    ST2 { V10.2D, V11.2D }, [X9], X13
    LD2 { V3.2D, V4.2D }, [X9], X13
    ADD  X9, X9, X5, LSR #0
    ST2 { V30.4S, V31.4S }, [X9], X13
    LD2 { V16.4S, V17.4S }, [X9], X13
    ADD  X9, X9, X5, LSR #0
    ST2 { V0.8H, V1.8H }, [X9], X13
    LD2 { V20.8H, V21.8H }, [X9], X13
    ADD  X9, X9, X5, LSR #0
    ST2 { V16.2S, V17.2S }, [X9], X13
    LD2 { V16.2S, V17.2S }, [X9], X13
    ADD  X9, X9, X5
    ST2 { V3.2S, V4.2S }, [X9], X13
    LD2 { V23.2S, V24.2S }, [X9], X13
    ADD  X9, X9, X5
    ST2 { V16.4H, V17.4H }, [X9], X13
    LD2 { V29.4H, V30.4H }, [X9], X13
    ADD  X9, X9, X5, LSR #0
    ST2 { V23.8B, V24.8B }, [X9], X13
    LD2 { V13.8B, V14.8B }, [X9], X13
    ADD  X9, X9, X5
    ST2 { V13.H, V14.H }[0x7], [X9]
    LD2 { V27.H, V28.H }[0x4], [X9]
    ADD  X9, X9, X5, LSR #0
    ST2 { V20.S, V21.S }[0x3], [X9]
    LD2 { V3.S, V4.S }[0x3], [X9]
    ADD  X9, X9, X5
    ST2 { V29.D, V30.D }[0x1], [X9]
    LD2 { V20.D, V21.D }[0x1], [X9]
    ADD  X9, X9, X5, LSR #0
    ST2 { V27.B, V28.B }[0xc], [X9]
    LD2 { V0.B, V1.B }[0xc], [X9]
    ADD  X9, X9, X5, LSR #0
    MOV  X8, X9
    ST2 { V0.H, V1.H }[0x6], [X8], #4
    MOV  X8, X9
    LD2 { V27.H, V28.H }[0x4], [X8], #4
    ADD  X9, X9, X5, ASR #0
    ST2 { V3.H, V4.H }[0x0], [X9], X13
    LD2 { V29.H, V30.H }[0x0], [X9], X13
    ADD  X9, X9, X5
    MOV  X8, X9
    ST2 { V27.S, V28.S }[0x1], [X8], #8
    MOV  X8, X9
    LD2 { V3.S, V4.S }[0x0], [X8], #8
    ADD  X9, X9, X5, LSR #0
    ST2 { V20.S, V21.S }[0x3], [X9], X13
    LD2 { V20.S, V21.S }[0x2], [X9], X13
    ADD  X9, X9, X5, LSR #0
    MOV  X8, X9
    ST2 { V29.D, V30.D }[0x1], [X8], #16
    MOV  X8, X9
    LD2 { V27.D, V28.D }[0x1], [X8], #16
    ADD  X9, X9, X5
    ST2 { V3.D, V4.D }[0x1], [X9], X13
    LD2 { V3.D, V4.D }[0x0], [X9], X13
    ADD  X9, X9, X5, LSR #0
    MOV  X8, X9
    ST2 { V7.B, V8.B }[0xa], [X8], #2
    MOV  X8, X9
    LD2 { V29.B, V30.B }[0x6], [X8], #2
    ADD  X9, X9, X5, LSR #0
    ST2 { V20.B, V21.B }[0xa], [X9], X13
    LD2 { V20.B, V21.B }[0x5], [X9], X13
    ADD  X9, X9, X5, ASR #0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X18
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X19
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X20
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X22
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X23
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X25
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X11, X10, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    MRS  X11, FPSR
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa5, LSL #32
    FMOV  X11, V0.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D0
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    MOVK  X10, #0xa5, LSL #32
    FMOV  X11, V1.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D1
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, V2.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D2
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V3.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, D3
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V4.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, D4
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, V5.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D5
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, V6.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D6
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V7.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D7
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V8.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D8
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, V9.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D9
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V10.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D10
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V11.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D11
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, V12.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D12
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V13.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D13
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V14.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D14
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, V15.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D15
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V16.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D16
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V17.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D17
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, V18.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D18
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, V19.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D19
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V20.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D20
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V21.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D21
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V22.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D22
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V23.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D23
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V24.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D24
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V25.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D25
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V26.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D26
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V27.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D27
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V28.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D28
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V29.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa500, LSL #48
    FMOV  X11, D29
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V30.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa500, LSL #48
    FMOV  X11, D30
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0x0, LSL #0
    FMOV  X11, V31.D[1]
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    FMOV  X11, D31
    SUB  X28, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
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
    FMOV  V2.D[1], X16
    FMOV  D3, X26
    FMOV  V3.D[1], X16
    FMOV  D4, X20
    FMOV  V4.D[1], X19
    FMOV  D5, X22
    FMOV  V5.D[1], X5
    FMOV  D6, X16
    FMOV  V6.D[1], X19
    FMOV  D7, X8
    FMOV  V7.D[1], X2
    FMOV  D8, X14
    FMOV  V8.D[1], X20
    FMOV  D9, X17
    FMOV  V9.D[1], X7
    FMOV  D10, X7
    FMOV  V10.D[1], X8
    FMOV  D11, X5
    FMOV  V11.D[1], X6
    FMOV  D12, X26
    FMOV  V12.D[1], X2
    FMOV  D13, X28
    FMOV  V13.D[1], X13
    FMOV  D14, X20
    FMOV  V14.D[1], X17
    FMOV  D15, X20
    FMOV  V15.D[1], X14
    FMOV  D16, X26
    FMOV  V16.D[1], X24
    FMOV  D17, X25
    FMOV  V17.D[1], X28
    FMOV  D18, X23
    FMOV  V18.D[1], X28
    FMOV  D19, X14
    FMOV  V19.D[1], X13
    FMOV  D20, X29
    FMOV  V20.D[1], X14
    FMOV  D21, X20
    FMOV  V21.D[1], X28
    FMOV  D22, X19
    FMOV  V22.D[1], X20
    FMOV  D23, X16
    FMOV  V23.D[1], X8
    FMOV  D24, X11
    FMOV  V24.D[1], X25
    FMOV  D25, X17
    FMOV  V25.D[1], X27
    FMOV  D26, X5
    FMOV  V26.D[1], X18
    FMOV  D27, X13
    FMOV  V27.D[1], X5
    FMOV  D28, X5
    FMOV  V28.D[1], X29
    FMOV  D29, X13
    FMOV  V29.D[1], X11
    FMOV  D30, X23
    FMOV  V30.D[1], X22
    FMOV  D31, X14
    FMOV  V31.D[1], X14
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X3, #0x2800, LSL #0
    ADD  X16, X30, X3
    ST2 { V13.8H, V14.8H }, [X16]
    LD2 { V27.4S, V28.4S }, [X16]
    ADD  X16, X16, X14
    ST2 { V29.16B, V30.16B }, [X16]
    LD2 { V16.16B, V17.16B }, [X16]
    ADD  X16, X16, X14
    ST2 { V27.2D, V28.2D }, [X16]
    LD2 { V12.2D, V13.2D }, [X16]
    ADD  X16, X16, X14
    ST2 { V12.4S, V13.4S }, [X16]
    LD2 { V18.4S, V19.4S }, [X16]
    ADD  X16, X16, X14, LSR #0
    ST2 { V16.8H, V17.8H }, [X16]
    LD2 { V2.8H, V3.8H }, [X16]
    ADD  X16, X16, X14, ASR #0
    ST2 { V18.2S, V19.2S }, [X16]
    LD2 { V17.8B, V18.8B }, [X16]
    ADD  X16, X16, X14
    ST2 { V17.2S, V18.2S }, [X16]
    LD2 { V24.2S, V25.2S }, [X16]
    ADD  X16, X16, X14
    ST2 { V2.4H, V3.4H }, [X16]
    LD2 { V6.4H, V7.4H }, [X16]
    ADD  X16, X16, X14
    ST2 { V6.8B, V7.8B }, [X16]
    LD2 { V6.8B, V7.8B }, [X16]
    ADD  X16, X16, X14, ASR #0
    MOV  X17, X16
    ST2 { V24.16B, V25.16B }, [X17], #32
    MOV  X17, X16
    LD2 { V2.4S, V3.4S }, [X17], #32
    ADD  X16, X16, X14, LSR #0
    MOV  X17, X16
    ST2 { V2.16B, V3.16B }, [X17], #32
    MOV  X17, X16
    LD2 { V24.16B, V25.16B }, [X17], #32
    ADD  X16, X16, X14, ASR #0
    MOV  X17, X16
    ST2 { V6.2D, V7.2D }, [X17], #32
    MOV  X17, X16
    LD2 { V6.2D, V7.2D }, [X17], #32
    ADD  X16, X16, X14, ASR #0
    MOV  X17, X16
    ST2 { V24.4S, V25.4S }, [X17], #32
    MOV  X17, X16
    LD2 { V2.4S, V3.4S }, [X17], #32
    ADD  X16, X16, X14
    MOV  X17, X16
    ST2 { V2.8H, V3.8H }, [X17], #32
    MOV  X17, X16
    LD2 { V24.8H, V25.8H }, [X17], #32
    ADD  X16, X16, X14, LSR #0
    MOV  X17, X16
    ST2 { V15.4H, V16.4H }, [X17], #16
    MOV  X17, X16
    LD2 { V4.2S, V5.2S }, [X17], #16
    ADD  X16, X16, X14
    MOV  X17, X16
    ST2 { V6.2S, V7.2S }, [X17], #16
    MOV  X17, X16
    LD2 { V24.2S, V25.2S }, [X17], #16
    ADD  X16, X16, X14, ASR #0
    MOV  X17, X16
    ST2 { V4.4H, V5.4H }, [X17], #16
    MOV  X17, X16
    LD2 { V14.4H, V15.4H }, [X17], #16
    ADD  X16, X16, X14, ASR #0
    MOV  X17, X16
    ST2 { V14.8B, V15.8B }, [X17], #16
    MOV  X17, X16
    LD2 { V25.8B, V26.8B }, [X17], #16
    ADD  X16, X16, X14, LSR #0
    ST2 { V29.16B, V30.16B }, [X16], X9
    LD2 { V1.2D, V2.2D }, [X16], X9
    ADD  X16, X16, X14, ASR #0
    ST2 { V14.16B, V15.16B }, [X16], X9
    LD2 { V14.16B, V15.16B }, [X16], X9
    ADD  X16, X16, X14, ASR #0
    ST2 { V25.2D, V26.2D }, [X16], X9
    LD2 { V26.2D, V27.2D }, [X16], X9
    ADD  X16, X16, X14, ASR #0
    ST2 { V1.4S, V2.4S }, [X16], X9
    LD2 { V18.4S, V19.4S }, [X16], X9
    ADD  X16, X16, X14, LSR #0
    ST2 { V14.8H, V15.8H }, [X16], X9
    LD2 { V9.8H, V10.8H }, [X16], X9
    ADD  X16, X16, X14, LSR #0
    ST2 { V26.4H, V27.4H }, [X16], X9
    LD2 { V13.2S, V14.2S }, [X16], X9
    ADD  X16, X16, X14
    ST2 { V13.2S, V14.2S }, [X16], X9
    LD2 { V12.2S, V13.2S }, [X16], X9
    ADD  X16, X16, X14
    ST2 { V18.4H, V19.4H }, [X16], X9
    LD2 { V3.4H, V4.4H }, [X16], X9
    ADD  X16, X16, X14, LSR #0
    ST2 { V9.8B, V10.8B }, [X16], X9
    LD2 { V25.8B, V26.8B }, [X16], X9
    ADD  X16, X16, X14, LSR #0
    ST2 { V12.H, V13.H }[0x4], [X16]
    LD2 { V23.H, V24.H }[0x6], [X16]
    ADD  X16, X16, X14, LSR #0
    ST2 { V25.S, V26.S }[0x2], [X16]
    LD2 { V25.S, V26.S }[0x2], [X16]
    ADD  X16, X16, X14, ASR #0
    ST2 { V3.D, V4.D }[0x1], [X16]
    LD2 { V13.D, V14.D }[0x1], [X16]
    ADD  X16, X16, X14
    ST2 { V23.B, V24.B }[0xf], [X16]
    LD2 { V9.B, V10.B }[0x6], [X16]
    ADD  X16, X16, X14, LSR #0
    MOV  X17, X16
    ST2 { V9.H, V10.H }[0x1], [X17], #4
    MOV  X17, X16
    LD2 { V9.H, V10.H }[0x6], [X17], #4
    ADD  X16, X16, X14, LSR #0
    ST2 { V13.H, V14.H }[0x4], [X16], X9
    LD2 { V13.H, V14.H }[0x2], [X16], X9
    ADD  X16, X16, X14, LSR #0
    MOV  X17, X16
    ST2 { V9.S, V10.S }[0x1], [X17], #8
    MOV  X17, X16
    LD2 { V9.S, V10.S }[0x3], [X17], #8
    ADD  X16, X16, X14, ASR #0
    ST2 { V13.S, V14.S }[0x2], [X16], X9
    LD2 { V23.S, V24.S }[0x2], [X16], X9
    ADD  X16, X16, X14, ASR #0
    MOV  X17, X16
    ST2 { V25.D, V26.D }[0x1], [X17], #16
    MOV  X17, X16
    LD2 { V13.D, V14.D }[0x0], [X17], #16
    ADD  X16, X16, X14
    ST2 { V13.D, V14.D }[0x1], [X16], X9
    LD2 { V13.D, V14.D }[0x0], [X16], X9
    ADD  X16, X16, X14, LSR #0
    MOV  X17, X16
    ST2 { V9.B, V10.B }[0x1], [X17], #2
    MOV  X17, X16
    LD2 { V25.B, V26.B }[0xd], [X17], #2
    ADD  X16, X16, X14, ASR #0
    ST2 { V23.B, V24.B }[0x1], [X16], X9
    LD2 { V13.B, V14.B }[0x8], [X16], X9
    ADD  X16, X16, X14, ASR #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X19
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X18, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    MRS  X18, FPSR
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V0.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D0
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V1.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D1
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V2.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D2
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V3.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D3
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V4.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D4
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V5.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D5
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V6.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D6
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V7.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D7
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V8.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D8
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V9.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D9
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a00, LSL #48
    FMOV  X18, V10.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a00, LSL #48
    FMOV  X18, D10
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V11.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D11
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V12.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D12
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a, LSL #0
    FMOV  X18, V13.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, D13
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a, LSL #0
    FMOV  X18, V14.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, D14
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V15.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D15
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V16.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D16
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V17.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D17
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V18.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D18
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V19.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D19
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V20.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D20
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V21.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D21
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V22.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D22
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V23.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D23
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V24.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D24
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a00, LSL #32
    FMOV  X18, V25.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D25
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a00, LSL #32
    FMOV  X18, V26.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D26
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x0, LSL #0
    FMOV  X18, V27.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D27
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V28.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D28
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V29.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D29
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V30.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D30
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, V31.D[1]
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    FMOV  X18, D31
    SUB  X7, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X27
    FMOV  D1, X25
    FMOV  V1.D[1], X29
    FMOV  D2, X24
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X10
    FMOV  D4, X3
    FMOV  V4.D[1], X22
    FMOV  D5, X3
    FMOV  V5.D[1], X19
    FMOV  D6, X2
    FMOV  V6.D[1], X19
    FMOV  D7, X19
    FMOV  V7.D[1], X26
    FMOV  D8, X24
    FMOV  V8.D[1], X3
    FMOV  D9, X29
    FMOV  V9.D[1], X13
    FMOV  D10, X8
    FMOV  V10.D[1], X29
    FMOV  D11, X20
    FMOV  V11.D[1], X9
    FMOV  D12, X14
    FMOV  V12.D[1], X23
    FMOV  D13, X23
    FMOV  V13.D[1], X23
    FMOV  D14, X29
    FMOV  V14.D[1], X9
    FMOV  D15, X5
    FMOV  V15.D[1], X2
    FMOV  D16, X5
    FMOV  V16.D[1], X20
    FMOV  D17, X7
    FMOV  V17.D[1], X25
    FMOV  D18, X9
    FMOV  V18.D[1], X18
    FMOV  D19, X29
    FMOV  V19.D[1], X8
    FMOV  D20, X16
    FMOV  V20.D[1], X3
    FMOV  D21, X11
    FMOV  V21.D[1], X8
    FMOV  D22, X8
    FMOV  V22.D[1], X26
    FMOV  D23, X28
    FMOV  V23.D[1], X9
    FMOV  D24, X6
    FMOV  V24.D[1], X7
    FMOV  D25, X14
    FMOV  V25.D[1], X22
    FMOV  D26, X17
    FMOV  V26.D[1], X11
    FMOV  D27, X13
    FMOV  V27.D[1], X23
    FMOV  D28, X20
    FMOV  V28.D[1], X28
    FMOV  D29, X16
    FMOV  V29.D[1], X25
    FMOV  D30, X19
    FMOV  V30.D[1], X7
    FMOV  D31, X11
    FMOV  V31.D[1], X24
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X18, #0x40, LSL #0
    MOVZ  X2, #0x2d00, LSL #0
    ADD  X19, X30, X2, LSR #0
    ST2 { V25.4S, V26.4S }, [X19]
    LD2 { V3.16B, V4.16B }, [X19]
    ADD  X19, X19, X18
    ST2 { V3.16B, V4.16B }, [X19]
    LD2 { V16.16B, V17.16B }, [X19]
    ADD  X19, X19, X18
    ST2 { V1.2D, V2.2D }, [X19]
    LD2 { V8.2D, V9.2D }, [X19]
    ADD  X19, X19, X18
    ST2 { V16.4S, V17.4S }, [X19]
    LD2 { V25.4S, V26.4S }, [X19]
    ADD  X19, X19, X18, ASR #0
    ST2 { V8.8H, V9.8H }, [X19]
    LD2 { V17.8H, V18.8H }, [X19]
    ADD  X19, X19, X18
    ST2 { V26.2S, V27.2S }, [X19]
    LD2 { V7.2S, V8.2S }, [X19]
    ADD  X19, X19, X18
    ST2 { V29.2S, V30.2S }, [X19]
    LD2 { V1.2S, V2.2S }, [X19]
    ADD  X19, X19, X18
    ST2 { V31.4H, V0.4H }, [X19]
    LD2 { V25.4H, V26.4H }, [X19]
    ADD  X19, X19, X18, ASR #0
    ST2 { V1.8B, V2.8B }, [X19]
    LD2 { V27.8B, V28.8B }, [X19]
    ADD  X19, X19, X18, ASR #0
    MOV  X13, X19
    ST2 { V27.2D, V28.2D }, [X13], #32
    MOV  X13, X19
    LD2 { V10.2D, V11.2D }, [X13], #32
    ADD  X19, X19, X18
    MOV  X13, X19
    ST2 { V17.16B, V18.16B }, [X13], #32
    MOV  X13, X19
    LD2 { V9.16B, V10.16B }, [X13], #32
    ADD  X19, X19, X18
    MOV  X13, X19
    ST2 { V9.2D, V10.2D }, [X13], #32
    MOV  X13, X19
    LD2 { V24.2D, V25.2D }, [X13], #32
    ADD  X19, X19, X18, LSR #0
    MOV  X13, X19
    ST2 { V24.4S, V25.4S }, [X13], #32
    MOV  X13, X19
    LD2 { V16.4S, V17.4S }, [X13], #32
    ADD  X19, X19, X18, ASR #0
    MOV  X13, X19
    ST2 { V4.8H, V5.8H }, [X13], #32
    MOV  X13, X19
    LD2 { V4.8H, V5.8H }, [X13], #32
    ADD  X19, X19, X18
    MOV  X13, X19
    ST2 { V4.8B, V5.8B }, [X13], #16
    MOV  X13, X19
    LD2 { V19.2S, V20.2S }, [X13], #16
    ADD  X19, X19, X18, ASR #0
    MOV  X13, X19
    ST2 { V14.2S, V15.2S }, [X13], #16
    MOV  X13, X19
    LD2 { V24.2S, V25.2S }, [X13], #16
    ADD  X19, X19, X18
    MOV  X13, X19
    ST2 { V24.4H, V25.4H }, [X13], #16
    MOV  X13, X19
    LD2 { V24.4H, V25.4H }, [X13], #16
    ADD  X19, X19, X18, ASR #0
    MOV  X13, X19
    ST2 { V19.8B, V20.8B }, [X13], #16
    MOV  X13, X19
    LD2 { V4.8B, V5.8B }, [X13], #16
    ADD  X19, X19, X18, ASR #0
    ST2 { V24.4S, V25.4S }, [X19], X10
    LD2 { V2.16B, V3.16B }, [X19], X10
    ADD  X19, X19, X18
    ST2 { V2.16B, V3.16B }, [X19], X10
    LD2 { V2.16B, V3.16B }, [X19], X10
    ADD  X19, X19, X18, ASR #0
    ST2 { V2.2D, V3.2D }, [X19], X10
    LD2 { V2.2D, V3.2D }, [X19], X10
    ADD  X19, X19, X18, LSR #0
    ST2 { V4.4S, V5.4S }, [X19], X10
    LD2 { V24.4S, V25.4S }, [X19], X10
    ADD  X19, X19, X18, LSR #0
    ST2 { V24.8H, V25.8H }, [X19], X10
    LD2 { V4.8H, V5.8H }, [X19], X10
    ADD  X19, X19, X18, LSR #0
    ST2 { V23.4H, V24.4H }, [X19], X10
    LD2 { V24.2S, V25.2S }, [X19], X10
    ADD  X19, X19, X18
    ST2 { V4.2S, V5.2S }, [X19], X10
    LD2 { V19.2S, V20.2S }, [X19], X10
    ADD  X19, X19, X18, LSR #0
    ST2 { V31.4H, V0.4H }, [X19], X10
    LD2 { V11.4H, V12.4H }, [X19], X10
    ADD  X19, X19, X18
    ST2 { V11.8B, V12.8B }, [X19], X10
    LD2 { V11.8B, V12.8B }, [X19], X10
    ADD  X19, X19, X18, LSR #0
    ST2 { V24.H, V25.H }[0x4], [X19]
    LD2 { V24.H, V25.H }[0x4], [X19]
    ADD  X19, X19, X18, ASR #0
    ST2 { V24.S, V25.S }[0x1], [X19]
    LD2 { V24.S, V25.S }[0x0], [X19]
    ADD  X19, X19, X18, ASR #0
    ST2 { V19.D, V20.D }[0x1], [X19]
    LD2 { V31.D, V0.D }[0x0], [X19]
    ADD  X19, X19, X18, LSR #0
    ST2 { V2.B, V3.B }[0xa], [X19]
    LD2 { V3.B, V4.B }[0x8], [X19]
    ADD  X19, X19, X18
    MOV  X13, X19
    ST2 { V31.H, V0.H }[0x2], [X13], #4
    MOV  X13, X19
    LD2 { V31.H, V0.H }[0x2], [X13], #4
    ADD  X19, X19, X18, LSR #0
    ST2 { V31.H, V0.H }[0x6], [X19], X10
    LD2 { V31.H, V0.H }[0x4], [X19], X10
    ADD  X19, X19, X18, ASR #0
    MOV  X13, X19
    ST2 { V3.S, V4.S }[0x3], [X13], #8
    MOV  X13, X19
    LD2 { V19.S, V20.S }[0x3], [X13], #8
    ADD  X19, X19, X18
    ST2 { V31.S, V0.S }[0x0], [X19], X10
    LD2 { V3.S, V4.S }[0x2], [X19], X10
    ADD  X19, X19, X18, ASR #0
    MOV  X13, X19
    ST2 { V19.D, V20.D }[0x0], [X13], #16
    MOV  X13, X19
    LD2 { V31.D, V0.D }[0x0], [X13], #16
    ADD  X19, X19, X18, LSR #0
    ST2 { V24.D, V25.D }[0x1], [X19], X10
    LD2 { V19.D, V20.D }[0x1], [X19], X10
    ADD  X19, X19, X18, LSR #0
    MOV  X13, X19
    ST2 { V31.B, V0.B }[0x6], [X13], #2
    MOV  X13, X19
    LD2 { V31.B, V0.B }[0xc], [X13], #2
    ADD  X19, X19, X18, LSR #0
    ST2 { V31.B, V0.B }[0x7], [X19], X10
    LD2 { V24.B, V25.B }[0xf], [X19], X10
    ADD  X19, X19, X18
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X28, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    MRS  X28, FPSR
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V0.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D0
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V1.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D1
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V2.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D2
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V3.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D3
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V4.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D4
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V5.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D5
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V6.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D6
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V7.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D7
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V8.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D8
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V9.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D9
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V10.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D10
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V11.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D11
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V12.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D12
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V13.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D13
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V14.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D14
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V15.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D15
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V16.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D16
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V17.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D17
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V18.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D18
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V19.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D19
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V20.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D20
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V21.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D21
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V22.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D22
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V23.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D23
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #48
    FMOV  X28, V24.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D24
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #48
    FMOV  X28, V25.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D25
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V26.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D26
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V27.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D27
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0x0, LSL #0
    FMOV  X28, V28.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D28
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V29.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D29
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V30.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D30
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, V31.D[1]
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  X28, D31
    SUB  X7, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP05_TestFail

AdvsimdLoadStoreP05_TestEnd:
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
AdvsimdLoadStoreP05_TestFail:
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
