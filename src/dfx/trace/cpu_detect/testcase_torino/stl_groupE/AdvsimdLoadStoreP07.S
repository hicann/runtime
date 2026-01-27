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
    SUB  SP, SP, #0x10
    STR  P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P1, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P2, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P3, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P4, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P5, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P6, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P7, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P8, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P9, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P10, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P11, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P12, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P13, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P14, [SP, #0, MUL VL]
    SUB  SP, SP, #0x10
    STR  P15, [SP, #0, MUL VL]
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    STR  X15, [X0, #0]
    LDR  P0, [X0, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z0.D, Z1.D, Z2.D, Z3.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z4.D, Z5.D, Z6.D, Z7.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z8.D, Z9.D, Z10.D, Z11.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z12.D, Z13.D, Z14.D, Z15.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z16.D, Z17.D, Z18.D, Z19.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z20.D, Z21.D, Z22.D, Z23.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z24.D, Z25.D, Z26.D, Z27.D }, P0, [SP, #0, MUL VL]
    SUB  SP, SP, #0x80
    ST4D  { Z28.D, Z29.D, Z30.D, Z31.D }, P0, [SP, #0, MUL VL]
    MRS  X2, FPCR
    MRS  X3, FPSR
    MRS  X4, NZCV
    STP  X2, X3, [SP, #-16]!
    STP  X4, X2, [SP, #-16]!
    MOVZ  X2, #0xce32, LSL #0
    MOVK  X2, #0x7989, LSL #16
    MOVK  X2, #0x44c5, LSL #32
    MOVK  X2, #0x2a6, LSL #48
    MOVZ  X3, #0x8cbb, LSL #0
    MOVK  X3, #0x1073, LSL #16
    MOVK  X3, #0xaa73, LSL #32
    MOVK  X3, #0x96dd, LSL #48
    MOVZ  X4, #0x7dbf, LSL #0
    MOVK  X4, #0xcfde, LSL #16
    MOVK  X4, #0xef2d, LSL #32
    MOVK  X4, #0xc537, LSL #48
    MOVZ  X5, #0x4bb6, LSL #0
    MOVK  X5, #0x4c94, LSL #16
    MOVK  X5, #0xa34b, LSL #32
    MOVK  X5, #0x6e52, LSL #48
    MOVZ  X6, #0x3e43, LSL #0
    MOVK  X6, #0x52bc, LSL #16
    MOVK  X6, #0xbbc, LSL #32
    MOVK  X6, #0x710f, LSL #48
    MOVZ  X7, #0x1ed2, LSL #0
    MOVK  X7, #0xb1b0, LSL #16
    MOVK  X7, #0x6a47, LSL #32
    MOVK  X7, #0x9d0c, LSL #48
    MOVZ  X8, #0xb0, LSL #0
    MOVK  X8, #0x2e46, LSL #16
    MOVK  X8, #0xcf58, LSL #32
    MOVK  X8, #0x4bf3, LSL #48
    MOVZ  X12, #0xc357, LSL #0
    MOVK  X12, #0xc868, LSL #16
    MOVK  X12, #0xacdf, LSL #32
    MOVK  X12, #0xe5b9, LSL #48
    MOVZ  X15, #0x36bd, LSL #0
    MOVK  X15, #0x1878, LSL #16
    MOVK  X15, #0x7234, LSL #32
    MOVK  X15, #0x55a4, LSL #48
    MOVZ  X16, #0x15, LSL #0
    MOVK  X16, #0x4f6, LSL #16
    MOVK  X16, #0xe5a, LSL #32
    MOVK  X16, #0x87fc, LSL #48
    MOVZ  X17, #0x1120, LSL #0
    MOVK  X17, #0xc4fe, LSL #16
    MOVK  X17, #0xa8d0, LSL #32
    MOVK  X17, #0x7765, LSL #48
    MOVZ  X18, #0x80ba, LSL #0
    MOVK  X18, #0xa4dc, LSL #16
    MOVK  X18, #0x7358, LSL #32
    MOVK  X18, #0x9a04, LSL #48
    MOVZ  X19, #0x673b, LSL #0
    MOVK  X19, #0x75fe, LSL #16
    MOVK  X19, #0xb782, LSL #32
    MOVK  X19, #0x34c, LSL #48
    MOVZ  X20, #0x841f, LSL #0
    MOVK  X20, #0x6a46, LSL #16
    MOVK  X20, #0x34ad, LSL #32
    MOVK  X20, #0xa323, LSL #48
    MOVZ  X21, #0xfdfc, LSL #0
    MOVK  X21, #0xd2e9, LSL #16
    MOVK  X21, #0x4dd7, LSL #32
    MOVK  X21, #0xc821, LSL #48
    MOVZ  X22, #0x88be, LSL #0
    MOVK  X22, #0x4e7, LSL #16
    MOVK  X22, #0xa6db, LSL #32
    MOVK  X22, #0x883a, LSL #48
    MOVZ  X23, #0x833c, LSL #0
    MOVK  X23, #0x4cc0, LSL #16
    MOVK  X23, #0xd0be, LSL #32
    MOVK  X23, #0x9fc9, LSL #48
    MOVZ  X24, #0x3ee6, LSL #0
    MOVK  X24, #0x3299, LSL #16
    MOVK  X24, #0xe63c, LSL #32
    MOVK  X24, #0x1f1f, LSL #48
    MOVZ  X25, #0x1e0b, LSL #0
    MOVK  X25, #0xacc7, LSL #16
    MOVK  X25, #0xa47, LSL #32
    MOVK  X25, #0xb8e9, LSL #48
    MOVZ  X26, #0x6061, LSL #0
    MOVK  X26, #0x3c41, LSL #16
    MOVK  X26, #0x1320, LSL #32
    MOVK  X26, #0xa9ed, LSL #48
    MOVZ  X27, #0x33ff, LSL #0
    MOVK  X27, #0x9a0f, LSL #16
    MOVK  X27, #0x844, LSL #32
    MOVK  X27, #0x9318, LSL #48
    MOVZ  X28, #0xc44d, LSL #0
    MOVK  X28, #0xd2fa, LSL #16
    MOVK  X28, #0x9aba, LSL #32
    MOVK  X28, #0x3915, LSL #48
    MOVZ  X29, #0x7d02, LSL #0
    MOVK  X29, #0x4fd7, LSL #16
    MOVK  X29, #0x92cb, LSL #32
    MOVK  X29, #0xb35e, LSL #48
    MOVZ  X22, #0x4475, LSL #0
    MOVK  X22, #0x32f9, LSL #16
    MOVK  X22, #0x21c0, LSL #32
    MOVK  X22, #0x9672, LSL #48
    MSR  FPCR, X22
    MRS  X8, FPCR
    MOVZ  X22, #0x60ff, LSL #0
    MOVK  X22, #0xffff, LSL #16
    MOVK  X22, #0xffff, LSL #32
    MOVK  X22, #0xffff, LSL #48
    AND  X8, X8, X22
    MOVZ  X22, #0x0, LSL #0
    ORR  X8, X8, X22
    MSR  FPCR, X8
    ISB  SY
    MOVZ  X22, #0xcac, LSL #0
    MOVK  X22, #0xef4f, LSL #16
    MOVK  X22, #0x2b2f, LSL #32
    MOVK  X22, #0xf778, LSL #48
    MSR  FPSR, X22
    MRS  X25, FPSR
    MOVZ  X23, #0xff60, LSL #0
    MOVK  X23, #0x7ff, LSL #16
    MOVK  X23, #0xffff, LSL #32
    MOVK  X23, #0xffff, LSL #48
    AND  X25, X25, X23
    MOVZ  X23, #0x0, LSL #0
    ORR  X25, X25, X23
    MSR  FPSR, X25
    ISB  SY
    SUBS  W26, W8, #0xef4, LSL #12
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X20
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X8
    FMOV  V2.D[1], X28
    FMOV  D3, X27
    FMOV  V3.D[1], X22
    FMOV  D4, X19
    FMOV  V4.D[1], X23
    FMOV  D5, X29
    FMOV  V5.D[1], X22
    FMOV  D6, X2
    FMOV  V6.D[1], X24
    FMOV  D7, X7
    FMOV  V7.D[1], X27
    FMOV  D8, X5
    FMOV  V8.D[1], X7
    FMOV  D9, X16
    FMOV  V9.D[1], X19
    FMOV  D10, X24
    FMOV  V10.D[1], X28
    FMOV  D11, X25
    FMOV  V11.D[1], X2
    FMOV  D12, X7
    FMOV  V12.D[1], X25
    FMOV  D13, X6
    FMOV  V13.D[1], X2
    FMOV  D14, X27
    FMOV  V14.D[1], X3
    FMOV  D15, X17
    FMOV  V15.D[1], X7
    FMOV  D16, X29
    FMOV  V16.D[1], X7
    FMOV  D17, X2
    FMOV  V17.D[1], X25
    FMOV  D18, X5
    FMOV  V18.D[1], X5
    FMOV  D19, X24
    FMOV  V19.D[1], X18
    FMOV  D20, X27
    FMOV  V20.D[1], X29
    FMOV  D21, X20
    FMOV  V21.D[1], X16
    FMOV  D22, X2
    FMOV  V22.D[1], X7
    FMOV  D23, X17
    FMOV  V23.D[1], X20
    FMOV  D24, X29
    FMOV  V24.D[1], X3
    FMOV  D25, X12
    FMOV  V25.D[1], X3
    FMOV  D26, X23
    FMOV  V26.D[1], X8
    FMOV  D27, X22
    FMOV  V27.D[1], X19
    FMOV  D28, X15
    FMOV  V28.D[1], X24
    FMOV  D29, X20
    FMOV  V29.D[1], X17
    FMOV  D30, X6
    FMOV  V30.D[1], X8
    FMOV  D31, X7
    FMOV  V31.D[1], X25
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X17, #0x40, LSL #0
    MOVZ  X23, #0x0, LSL #0
    ADD  X18, X30, X23, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X18]
    LD4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X18]
    ADD  X18, X18, X17, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X18]
    LD4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X18]
    ADD  X18, X18, X17
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X18]
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X18]
    ADD  X18, X18, X17, LSR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X18]
    LD4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X18]
    ADD  X18, X18, X17, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X18]
    LD4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X18]
    ADD  X18, X18, X17, ASR #0
    ST4 { V9.8B, V10.8B, V11.8B, V12.8B }, [X18]
    LD4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X18]
    ADD  X18, X18, X17, ASR #0
    ST4 { V3.2S, V4.2S, V5.2S, V6.2S }, [X18]
    LD4 { V24.2S, V25.2S, V26.2S, V27.2S }, [X18]
    ADD  X18, X18, X17
    ST4 { V24.4H, V25.4H, V26.4H, V27.4H }, [X18]
    LD4 { V18.4H, V19.4H, V20.4H, V21.4H }, [X18]
    ADD  X18, X18, X17, LSR #0
    ST4 { V0.8B, V1.8B, V2.8B, V3.8B }, [X18]
    LD4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X18]
    ADD  X18, X18, X17, LSR #0
    MOV  X20, X18
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X20], #64
    MOV  X20, X18
    LD4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X20], #64
    ADD  X18, X18, X17, ASR #0
    MOV  X20, X18
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X20], #64
    MOV  X20, X18
    LD4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X20], #64
    ADD  X18, X18, X17, LSR #0
    MOV  X20, X18
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X20], #64
    MOV  X20, X18
    LD4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X20], #64
    ADD  X18, X18, X17, LSR #0
    MOV  X20, X18
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X20], #64
    MOV  X20, X18
    LD4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X20], #64
    ADD  X18, X18, X17, ASR #0
    MOV  X20, X18
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X20], #64
    MOV  X20, X18
    LD4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X20], #64
    ADD  X18, X18, X17
    MOV  X20, X18
    ST4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X20], #32
    MOV  X20, X18
    LD4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X20], #32
    ADD  X18, X18, X17
    MOV  X20, X18
    ST4 { V9.2S, V10.2S, V11.2S, V12.2S }, [X20], #32
    MOV  X20, X18
    LD4 { V15.2S, V16.2S, V17.2S, V18.2S }, [X20], #32
    ADD  X18, X18, X17, LSR #0
    MOV  X20, X18
    ST4 { V15.4H, V16.4H, V17.4H, V18.4H }, [X20], #32
    MOV  X20, X18
    LD4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X20], #32
    ADD  X18, X18, X17, ASR #0
    MOV  X20, X18
    ST4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X20], #32
    MOV  X20, X18
    LD4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X20], #32
    ADD  X18, X18, X17, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X18], X28
    LD4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X18], X28
    ADD  X18, X18, X17, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X18], X28
    LD4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X18], X28
    ADD  X18, X18, X17
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X18], X28
    LD4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X18], X28
    ADD  X18, X18, X17, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X18], X28
    LD4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X18], X28
    ADD  X18, X18, X17, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X18], X28
    LD4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X18], X28
    ADD  X18, X18, X17, LSR #0
    ST4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X18], X28
    LD4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X18], X28
    ADD  X18, X18, X17, ASR #0
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X18], X28
    LD4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X18], X28
    ADD  X18, X18, X17, ASR #0
    ST4 { V8.4H, V9.4H, V10.4H, V11.4H }, [X18], X28
    LD4 { V28.4H, V29.4H, V30.4H, V31.4H }, [X18], X28
    ADD  X18, X18, X17
    ST4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X18], X28
    LD4 { V22.8B, V23.8B, V24.8B, V25.8B }, [X18], X28
    ADD  X18, X18, X17, ASR #0
    ST4 { V22.H, V23.H, V24.H, V25.H }[0x0], [X18]
    LD4 { V28.H, V29.H, V30.H, V31.H }[0x1], [X18]
    ADD  X18, X18, X17, LSR #0
    ST4 { V28.S, V29.S, V30.S, V31.S }[0x0], [X18]
    LD4 { V23.S, V24.S, V25.S, V26.S }[0x0], [X18]
    ADD  X18, X18, X17, LSR #0
    ST4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X18]
    LD4 { V8.D, V9.D, V10.D, V11.D }[0x1], [X18]
    ADD  X18, X18, X17
    ST4 { V22.B, V23.B, V24.B, V25.B }[0x6], [X18]
    LD4 { V28.B, V29.B, V30.B, V31.B }[0x4], [X18]
    ADD  X18, X18, X17, LSR #0
    MOV  X20, X18
    ST4 { V18.H, V19.H, V20.H, V21.H }[0x0], [X20], #8
    MOV  X20, X18
    LD4 { V13.H, V14.H, V15.H, V16.H }[0x2], [X20], #8
    ADD  X18, X18, X17, LSR #0
    ST4 { V8.H, V9.H, V10.H, V11.H }[0x7], [X18], X28
    LD4 { V29.H, V30.H, V31.H, V0.H }[0x5], [X18], X28
    ADD  X18, X18, X17, LSR #0
    MOV  X20, X18
    ST4 { V8.S, V9.S, V10.S, V11.S }[0x3], [X20], #16
    MOV  X20, X18
    LD4 { V22.S, V23.S, V24.S, V25.S }[0x1], [X20], #16
    ADD  X18, X18, X17, ASR #0
    ST4 { V18.S, V19.S, V20.S, V21.S }[0x2], [X18], X28
    LD4 { V18.S, V19.S, V20.S, V21.S }[0x2], [X18], X28
    ADD  X18, X18, X17
    MOV  X20, X18
    ST4 { V20.D, V21.D, V22.D, V23.D }[0x0], [X20], #32
    MOV  X20, X18
    LD4 { V3.D, V4.D, V5.D, V6.D }[0x1], [X20], #32
    ADD  X18, X18, X17
    ST4 { V22.D, V23.D, V24.D, V25.D }[0x0], [X18], X28
    LD4 { V23.D, V24.D, V25.D, V26.D }[0x1], [X18], X28
    ADD  X18, X18, X17
    MOV  X20, X18
    ST4 { V29.B, V30.B, V31.B, V0.B }[0x6], [X20], #4
    MOV  X20, X18
    LD4 { V28.B, V29.B, V30.B, V31.B }[0xc], [X20], #4
    ADD  X18, X18, X17, ASR #0
    ST4 { V28.B, V29.B, V30.B, V31.B }[0x3], [X18], X28
    LD4 { V28.B, V29.B, V30.B, V31.B }[0x0], [X18], X28
    ADD  X18, X18, X17, ASR #0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X8, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    MRS  X24, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D1
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D2
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D3
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D4
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D5
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D6
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D7
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D8
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D9
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D10
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D11
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D12
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D13
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D14
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D15
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D16
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D17
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D18
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D19
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D20
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D21
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D22
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D23
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D24
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D25
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D26
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D27
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a, LSL #32
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D28
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a, LSL #32
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D29
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a, LSL #32
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D30
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a, LSL #32
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D31
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X7, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    FMOV  D1, X5
    FMOV  V1.D[1], X15
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X22
    FMOV  V3.D[1], X29
    FMOV  D4, X6
    FMOV  V4.D[1], X4
    FMOV  D5, X15
    FMOV  V5.D[1], X5
    FMOV  D6, X6
    FMOV  V6.D[1], X2
    FMOV  D7, X16
    FMOV  V7.D[1], X21
    FMOV  D8, X12
    FMOV  V8.D[1], X17
    FMOV  D9, X5
    FMOV  V9.D[1], X27
    FMOV  D10, X25
    FMOV  V10.D[1], X15
    FMOV  D11, X28
    FMOV  V11.D[1], X23
    FMOV  D12, X23
    FMOV  V12.D[1], X18
    FMOV  D13, X18
    FMOV  V13.D[1], X12
    FMOV  D14, X16
    FMOV  V14.D[1], X27
    FMOV  D15, X3
    FMOV  V15.D[1], X21
    FMOV  D16, X21
    FMOV  V16.D[1], X8
    FMOV  D17, X24
    FMOV  V17.D[1], X2
    FMOV  D18, X20
    FMOV  V18.D[1], X27
    FMOV  D19, X23
    FMOV  V19.D[1], X15
    FMOV  D20, X12
    FMOV  V20.D[1], X28
    FMOV  D21, X24
    FMOV  V21.D[1], X16
    FMOV  D22, X15
    FMOV  V22.D[1], X24
    FMOV  D23, X27
    FMOV  V23.D[1], X29
    FMOV  D24, X15
    FMOV  V24.D[1], X8
    FMOV  D25, X4
    FMOV  V25.D[1], X4
    FMOV  D26, X23
    FMOV  V26.D[1], X19
    FMOV  D27, X4
    FMOV  V27.D[1], X17
    FMOV  D28, X15
    FMOV  V28.D[1], X27
    FMOV  D29, X23
    FMOV  V29.D[1], X25
    FMOV  D30, X28
    FMOV  V30.D[1], X22
    FMOV  D31, X4
    FMOV  V31.D[1], X7
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X20, #0x500, LSL #0
    ADD  X12, X30, X20
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X12]
    LD4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X12]
    ADD  X12, X12, X22
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X12]
    LD4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X12]
    ADD  X12, X12, X22
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X12]
    LD4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X12]
    ADD  X12, X12, X22
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X12]
    LD4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X12]
    ADD  X12, X12, X22
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X12]
    LD4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X12]
    ADD  X12, X12, X22, LSR #0
    ST4 { V28.2S, V29.2S, V30.2S, V31.2S }, [X12]
    LD4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X12]
    ADD  X12, X12, X22, LSR #0
    ST4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X12]
    LD4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X12]
    ADD  X12, X12, X22, ASR #0
    ST4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X12]
    LD4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X12]
    ADD  X12, X12, X22, LSR #0
    ST4 { V20.8B, V21.8B, V22.8B, V23.8B }, [X12]
    LD4 { V19.8B, V20.8B, V21.8B, V22.8B }, [X12]
    ADD  X12, X12, X22
    MOV  X3, X12
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X3], #64
    MOV  X3, X12
    LD4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X3], #64
    ADD  X12, X12, X22, LSR #0
    MOV  X3, X12
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X3], #64
    MOV  X3, X12
    LD4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X3], #64
    ADD  X12, X12, X22, LSR #0
    MOV  X3, X12
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X3], #64
    MOV  X3, X12
    LD4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X3], #64
    ADD  X12, X12, X22
    MOV  X3, X12
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X3], #64
    MOV  X3, X12
    LD4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X3], #64
    ADD  X12, X12, X22, LSR #0
    MOV  X3, X12
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X3], #64
    MOV  X3, X12
    LD4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X3], #64
    ADD  X12, X12, X22, ASR #0
    MOV  X3, X12
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X3], #32
    MOV  X3, X12
    LD4 { V11.2S, V12.2S, V13.2S, V14.2S }, [X3], #32
    ADD  X12, X12, X22, ASR #0
    MOV  X3, X12
    ST4 { V21.2S, V22.2S, V23.2S, V24.2S }, [X3], #32
    MOV  X3, X12
    LD4 { V28.2S, V29.2S, V30.2S, V31.2S }, [X3], #32
    ADD  X12, X12, X22
    MOV  X3, X12
    ST4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X3], #32
    MOV  X3, X12
    LD4 { V4.4H, V5.4H, V6.4H, V7.4H }, [X3], #32
    ADD  X12, X12, X22, LSR #0
    MOV  X3, X12
    ST4 { V11.8B, V12.8B, V13.8B, V14.8B }, [X3], #32
    MOV  X3, X12
    LD4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X3], #32
    ADD  X12, X12, X22, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X12], X4
    LD4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X12], X4
    ADD  X12, X12, X22
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X12], X4
    LD4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X12], X4
    ADD  X12, X12, X22, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X12], X4
    LD4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X12], X4
    ADD  X12, X12, X22, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X12], X4
    LD4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X12], X4
    ADD  X12, X12, X22, ASR #0
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X12], X4
    LD4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X12], X4
    ADD  X12, X12, X22
    ST4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X12], X4
    LD4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X12], X4
    ADD  X12, X12, X22, ASR #0
    ST4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X12], X4
    LD4 { V9.2S, V10.2S, V11.2S, V12.2S }, [X12], X4
    ADD  X12, X12, X22, ASR #0
    ST4 { V15.4H, V16.4H, V17.4H, V18.4H }, [X12], X4
    LD4 { V4.4H, V5.4H, V6.4H, V7.4H }, [X12], X4
    ADD  X12, X12, X22, LSR #0
    ST4 { V9.8B, V10.8B, V11.8B, V12.8B }, [X12], X4
    LD4 { V0.8B, V1.8B, V2.8B, V3.8B }, [X12], X4
    ADD  X12, X12, X22
    ST4 { V26.H, V27.H, V28.H, V29.H }[0x5], [X12]
    LD4 { V15.H, V16.H, V17.H, V18.H }[0x5], [X12]
    ADD  X12, X12, X22, ASR #0
    ST4 { V3.S, V4.S, V5.S, V6.S }[0x2], [X12]
    LD4 { V9.S, V10.S, V11.S, V12.S }[0x3], [X12]
    ADD  X12, X12, X22
    ST4 { V30.D, V31.D, V0.D, V1.D }[0x0], [X12]
    LD4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X12]
    ADD  X12, X12, X22, ASR #0
    ST4 { V15.B, V16.B, V17.B, V18.B }[0xb], [X12]
    LD4 { V13.B, V14.B, V15.B, V16.B }[0x6], [X12]
    ADD  X12, X12, X22, ASR #0
    MOV  X3, X12
    ST4 { V19.H, V20.H, V21.H, V22.H }[0x1], [X3], #8
    MOV  X3, X12
    LD4 { V6.H, V7.H, V8.H, V9.H }[0x7], [X3], #8
    ADD  X12, X12, X22
    ST4 { V7.H, V8.H, V9.H, V10.H }[0x1], [X12], X4
    LD4 { V27.H, V28.H, V29.H, V30.H }[0x1], [X12], X4
    ADD  X12, X12, X22, LSR #0
    MOV  X3, X12
    ST4 { V11.S, V12.S, V13.S, V14.S }[0x1], [X3], #16
    MOV  X3, X12
    LD4 { V11.S, V12.S, V13.S, V14.S }[0x2], [X3], #16
    ADD  X12, X12, X22
    ST4 { V13.S, V14.S, V15.S, V16.S }[0x2], [X12], X4
    LD4 { V14.S, V15.S, V16.S, V17.S }[0x3], [X12], X4
    ADD  X12, X12, X22, ASR #0
    MOV  X3, X12
    ST4 { V14.D, V15.D, V16.D, V17.D }[0x1], [X3], #32
    MOV  X3, X12
    LD4 { V7.D, V8.D, V9.D, V10.D }[0x0], [X3], #32
    ADD  X12, X12, X22, ASR #0
    ST4 { V8.D, V9.D, V10.D, V11.D }[0x0], [X12], X4
    LD4 { V19.D, V20.D, V21.D, V22.D }[0x0], [X12], X4
    ADD  X12, X12, X22
    MOV  X3, X12
    ST4 { V0.B, V1.B, V2.B, V3.B }[0x3], [X3], #4
    MOV  X3, X12
    LD4 { V13.B, V14.B, V15.B, V16.B }[0x7], [X3], #4
    ADD  X12, X12, X22, ASR #0
    ST4 { V27.B, V28.B, V29.B, V30.B }[0x6], [X12], X4
    LD4 { V24.B, V25.B, V26.B, V27.B }[0xa], [X12], X4
    ADD  X12, X12, X22, LSR #0
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X27, X21, X2
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
    SUB  X27, X21, X8
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
    SUB  X27, X21, X18
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
    MRS  X21, FPSR
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D1
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D2
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D3
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D4
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D5
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D6
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D7
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa500, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D8
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D9
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5a5, LSL #32
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D10
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D11
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D12
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa500, LSL #16
    MOVK  X27, #0xa5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D13
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa500, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D14
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D15
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5a5, LSL #32
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D16
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D17
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5, LSL #16
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D18
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D19
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa500, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D20
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5a5, LSL #32
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D21
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D22
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D23
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5, LSL #16
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D24
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5, LSL #16
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D25
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5, LSL #16
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D26
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5, LSL #16
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D27
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D28
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5, LSL #16
    MOVK  X27, #0xa5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D29
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5, LSL #16
    MOVK  X27, #0xa5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D30
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0xa5, LSL #16
    MOVK  X27, #0xa5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D31
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X15, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    FMOV  D1, X27
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X23
    FMOV  D3, X20
    FMOV  V3.D[1], X27
    FMOV  D4, X29
    FMOV  V4.D[1], X20
    FMOV  D5, X25
    FMOV  V5.D[1], X29
    FMOV  D6, X24
    FMOV  V6.D[1], X23
    FMOV  D7, X21
    FMOV  V7.D[1], X15
    FMOV  D8, X6
    FMOV  V8.D[1], X18
    FMOV  D9, X7
    FMOV  V9.D[1], X15
    FMOV  D10, X18
    FMOV  V10.D[1], X7
    FMOV  D11, X16
    FMOV  V11.D[1], X25
    FMOV  D12, X29
    FMOV  V12.D[1], X18
    FMOV  D13, X17
    FMOV  V13.D[1], X29
    FMOV  D14, X17
    FMOV  V14.D[1], X20
    FMOV  D15, X24
    FMOV  V15.D[1], X20
    FMOV  D16, X12
    FMOV  V16.D[1], X27
    FMOV  D17, X21
    FMOV  V17.D[1], X5
    FMOV  D18, X3
    FMOV  V18.D[1], X28
    FMOV  D19, X4
    FMOV  V19.D[1], X17
    FMOV  D20, X15
    FMOV  V20.D[1], X24
    FMOV  D21, X8
    FMOV  V21.D[1], X15
    FMOV  D22, X25
    FMOV  V22.D[1], X19
    FMOV  D23, X7
    FMOV  V23.D[1], X20
    FMOV  D24, X2
    FMOV  V24.D[1], X18
    FMOV  D25, X21
    FMOV  V25.D[1], X28
    FMOV  D26, X28
    FMOV  V26.D[1], X25
    FMOV  D27, X4
    FMOV  V27.D[1], X4
    FMOV  D28, X7
    FMOV  V28.D[1], X8
    FMOV  D29, X5
    FMOV  V29.D[1], X24
    FMOV  D30, X2
    FMOV  V30.D[1], X16
    FMOV  D31, X2
    FMOV  V31.D[1], X6
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X19, #0xa00, LSL #0
    ADD  X22, X30, X19, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X22]
    LD4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X22]
    ADD  X22, X22, X21, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X22]
    LD4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X22]
    ADD  X22, X22, X21
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X22]
    LD4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X22]
    ADD  X22, X22, X21, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X22]
    LD4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X22]
    ADD  X22, X22, X21
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X22]
    LD4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X22]
    ADD  X22, X22, X21, ASR #0
    ST4 { V6.4H, V7.4H, V8.4H, V9.4H }, [X22]
    LD4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X22]
    ADD  X22, X22, X21, LSR #0
    ST4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X22]
    LD4 { V3.2S, V4.2S, V5.2S, V6.2S }, [X22]
    ADD  X22, X22, X21, LSR #0
    ST4 { V11.4H, V12.4H, V13.4H, V14.4H }, [X22]
    LD4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X22]
    ADD  X22, X22, X21, ASR #0
    ST4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X22]
    LD4 { V27.8B, V28.8B, V29.8B, V30.8B }, [X22]
    ADD  X22, X22, X21, ASR #0
    MOV  X28, X22
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X28], #64
    MOV  X28, X22
    LD4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X28], #64
    ADD  X22, X22, X21, ASR #0
    MOV  X28, X22
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X28], #64
    MOV  X28, X22
    LD4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X28], #64
    ADD  X22, X22, X21, LSR #0
    MOV  X28, X22
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X28], #64
    MOV  X28, X22
    LD4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X28], #64
    ADD  X22, X22, X21, ASR #0
    MOV  X28, X22
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X28], #64
    MOV  X28, X22
    LD4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X28], #64
    ADD  X22, X22, X21
    MOV  X28, X22
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X28], #64
    MOV  X28, X22
    LD4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X28], #64
    ADD  X22, X22, X21, LSR #0
    MOV  X28, X22
    ST4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X28], #32
    MOV  X28, X22
    LD4 { V11.4H, V12.4H, V13.4H, V14.4H }, [X28], #32
    ADD  X22, X22, X21, LSR #0
    MOV  X28, X22
    ST4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X28], #32
    MOV  X28, X22
    LD4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X28], #32
    ADD  X22, X22, X21
    MOV  X28, X22
    ST4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X28], #32
    MOV  X28, X22
    LD4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X28], #32
    ADD  X22, X22, X21
    MOV  X28, X22
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X28], #32
    MOV  X28, X22
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X28], #32
    ADD  X22, X22, X21, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X22], X24
    LD4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X22], X24
    ADD  X22, X22, X21, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X22], X24
    LD4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X22], X24
    ADD  X22, X22, X21, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X22], X24
    LD4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X22], X24
    ADD  X22, X22, X21, ASR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X22], X24
    LD4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X22], X24
    ADD  X22, X22, X21, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X22], X24
    LD4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X22], X24
    ADD  X22, X22, X21, ASR #0
    ST4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X22], X24
    LD4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X22], X24
    ADD  X22, X22, X21
    ST4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X22], X24
    LD4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X22], X24
    ADD  X22, X22, X21, ASR #0
    ST4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X22], X24
    LD4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X22], X24
    ADD  X22, X22, X21
    ST4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X22], X24
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X22], X24
    ADD  X22, X22, X21
    ST4 { V29.H, V30.H, V31.H, V0.H }[0x7], [X22]
    LD4 { V23.H, V24.H, V25.H, V26.H }[0x6], [X22]
    ADD  X22, X22, X21
    ST4 { V23.S, V24.S, V25.S, V26.S }[0x2], [X22]
    LD4 { V27.S, V28.S, V29.S, V30.S }[0x0], [X22]
    ADD  X22, X22, X21, ASR #0
    ST4 { V11.D, V12.D, V13.D, V14.D }[0x0], [X22]
    LD4 { V23.D, V24.D, V25.D, V26.D }[0x1], [X22]
    ADD  X22, X22, X21
    ST4 { V25.B, V26.B, V27.B, V28.B }[0x6], [X22]
    LD4 { V0.B, V1.B, V2.B, V3.B }[0xf], [X22]
    ADD  X22, X22, X21, LSR #0
    MOV  X28, X22
    ST4 { V20.H, V21.H, V22.H, V23.H }[0x6], [X28], #8
    MOV  X28, X22
    LD4 { V11.H, V12.H, V13.H, V14.H }[0x6], [X28], #8
    ADD  X22, X22, X21, LSR #0
    ST4 { V13.H, V14.H, V15.H, V16.H }[0x4], [X22], X24
    LD4 { V13.H, V14.H, V15.H, V16.H }[0x0], [X22], X24
    ADD  X22, X22, X21, LSR #0
    MOV  X28, X22
    ST4 { V26.S, V27.S, V28.S, V29.S }[0x3], [X28], #16
    MOV  X28, X22
    LD4 { V20.S, V21.S, V22.S, V23.S }[0x3], [X28], #16
    ADD  X22, X22, X21
    ST4 { V13.S, V14.S, V15.S, V16.S }[0x0], [X22], X24
    LD4 { V20.S, V21.S, V22.S, V23.S }[0x1], [X22], X24
    ADD  X22, X22, X21, LSR #0
    MOV  X28, X22
    ST4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X28], #32
    MOV  X28, X22
    LD4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X28], #32
    ADD  X22, X22, X21, LSR #0
    ST4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X22], X24
    LD4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X22], X24
    ADD  X22, X22, X21, LSR #0
    MOV  X28, X22
    ST4 { V0.B, V1.B, V2.B, V3.B }[0xa], [X28], #4
    MOV  X28, X22
    LD4 { V22.B, V23.B, V24.B, V25.B }[0xe], [X28], #4
    ADD  X22, X22, X21
    ST4 { V24.B, V25.B, V26.B, V27.B }[0xa], [X22], X24
    LD4 { V23.B, V24.B, V25.B, V26.B }[0x1], [X22], X24
    ADD  X22, X22, X21, ASR #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X27, X2, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    MRS  X2, FPSR
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a00, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D0
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a00, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D1
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a00, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D2
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a00, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D3
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D4
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D5
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D6
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D7
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D8
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D9
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D10
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a5a, LSL #32
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D11
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a5a, LSL #32
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D12
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D13
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D14
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D15
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D16
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D17
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D18
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D19
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D20
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a, LSL #16
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D21
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a, LSL #16
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D22
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D23
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a00, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D24
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a00, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D25
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D26
    MOVZ  X27, #0x5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D27
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D28
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D29
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D30
    MOVZ  X27, #0x0, LSL #0
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    FMOV  X2, D31
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    FMOV  D1, X6
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X17
    FMOV  V3.D[1], X19
    FMOV  D4, X21
    FMOV  V4.D[1], X23
    FMOV  D5, X22
    FMOV  V5.D[1], X22
    FMOV  D6, X2
    FMOV  V6.D[1], X17
    FMOV  D7, X16
    FMOV  V7.D[1], X4
    FMOV  D8, X2
    FMOV  V8.D[1], X5
    FMOV  D9, X26
    FMOV  V9.D[1], X28
    FMOV  D10, X20
    FMOV  V10.D[1], X20
    FMOV  D11, X23
    FMOV  V11.D[1], X7
    FMOV  D12, X5
    FMOV  V12.D[1], X2
    FMOV  D13, X25
    FMOV  V13.D[1], X21
    FMOV  D14, X22
    FMOV  V14.D[1], X26
    FMOV  D15, X22
    FMOV  V15.D[1], X3
    FMOV  D16, X21
    FMOV  V16.D[1], X16
    FMOV  D17, X12
    FMOV  V17.D[1], X24
    FMOV  D18, X22
    FMOV  V18.D[1], X24
    FMOV  D19, X6
    FMOV  V19.D[1], X28
    FMOV  D20, X27
    FMOV  V20.D[1], X3
    FMOV  D21, X21
    FMOV  V21.D[1], X17
    FMOV  D22, X15
    FMOV  V22.D[1], X3
    FMOV  D23, X29
    FMOV  V23.D[1], X8
    FMOV  D24, X23
    FMOV  V24.D[1], X19
    FMOV  D25, X29
    FMOV  V25.D[1], X24
    FMOV  D26, X15
    FMOV  V26.D[1], X15
    FMOV  D27, X2
    FMOV  V27.D[1], X15
    FMOV  D28, X26
    FMOV  V28.D[1], X17
    FMOV  D29, X28
    FMOV  V29.D[1], X7
    FMOV  D30, X20
    FMOV  V30.D[1], X3
    FMOV  D31, X5
    FMOV  V31.D[1], X24
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X19, #0x40, LSL #0
    MOVZ  X2, #0xf00, LSL #0
    ADD  X22, X30, X2, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X22]
    LD4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X22]
    ADD  X22, X22, X19, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X22]
    LD4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X22]
    ADD  X22, X22, X19
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X22]
    LD4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X22]
    ADD  X22, X22, X19
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X22]
    LD4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X22]
    ADD  X22, X22, X19, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X22]
    LD4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X22]
    ADD  X22, X22, X19
    ST4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X22]
    LD4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X22]
    ADD  X22, X22, X19, ASR #0
    ST4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X22]
    LD4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X22]
    ADD  X22, X22, X19, ASR #0
    ST4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X22]
    LD4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X22]
    ADD  X22, X22, X19, ASR #0
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X22]
    LD4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X22]
    ADD  X22, X22, X19, LSR #0
    MOV  X5, X22
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X5], #64
    MOV  X5, X22
    LD4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X5], #64
    ADD  X22, X22, X19, LSR #0
    MOV  X5, X22
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X5], #64
    MOV  X5, X22
    LD4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X5], #64
    ADD  X22, X22, X19, LSR #0
    MOV  X5, X22
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X5], #64
    MOV  X5, X22
    LD4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X5], #64
    ADD  X22, X22, X19, LSR #0
    MOV  X5, X22
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X5], #64
    MOV  X5, X22
    LD4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X5], #64
    ADD  X22, X22, X19, ASR #0
    MOV  X5, X22
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X5], #64
    MOV  X5, X22
    LD4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X5], #64
    ADD  X22, X22, X19, ASR #0
    MOV  X5, X22
    ST4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X5], #32
    MOV  X5, X22
    LD4 { V28.8B, V29.8B, V30.8B, V31.8B }, [X5], #32
    ADD  X22, X22, X19
    MOV  X5, X22
    ST4 { V28.2S, V29.2S, V30.2S, V31.2S }, [X5], #32
    MOV  X5, X22
    LD4 { V24.2S, V25.2S, V26.2S, V27.2S }, [X5], #32
    ADD  X22, X22, X19, ASR #0
    MOV  X5, X22
    ST4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X5], #32
    MOV  X5, X22
    LD4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X5], #32
    ADD  X22, X22, X19, ASR #0
    MOV  X5, X22
    ST4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X5], #32
    MOV  X5, X22
    LD4 { V20.8B, V21.8B, V22.8B, V23.8B }, [X5], #32
    ADD  X22, X22, X19
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X22], X25
    LD4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X22], X25
    ADD  X22, X22, X19
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X22], X25
    LD4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X22], X25
    ADD  X22, X22, X19
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X22], X25
    LD4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X22], X25
    ADD  X22, X22, X19
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X22], X25
    LD4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X22], X25
    ADD  X22, X22, X19, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X22], X25
    LD4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X22], X25
    ADD  X22, X22, X19
    ST4 { V7.8B, V8.8B, V9.8B, V10.8B }, [X22], X25
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X22], X25
    ADD  X22, X22, X19, ASR #0
    ST4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X22], X25
    LD4 { V9.2S, V10.2S, V11.2S, V12.2S }, [X22], X25
    ADD  X22, X22, X19, ASR #0
    ST4 { V9.4H, V10.4H, V11.4H, V12.4H }, [X22], X25
    LD4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X22], X25
    ADD  X22, X22, X19, LSR #0
    ST4 { V28.8B, V29.8B, V30.8B, V31.8B }, [X22], X25
    LD4 { V20.8B, V21.8B, V22.8B, V23.8B }, [X22], X25
    ADD  X22, X22, X19
    ST4 { V20.H, V21.H, V22.H, V23.H }[0x4], [X22]
    LD4 { V19.H, V20.H, V21.H, V22.H }[0x3], [X22]
    ADD  X22, X22, X19, ASR #0
    ST4 { V19.S, V20.S, V21.S, V22.S }[0x0], [X22]
    LD4 { V19.S, V20.S, V21.S, V22.S }[0x2], [X22]
    ADD  X22, X22, X19, LSR #0
    ST4 { V7.D, V8.D, V9.D, V10.D }[0x0], [X22]
    LD4 { V9.D, V10.D, V11.D, V12.D }[0x0], [X22]
    ADD  X22, X22, X19, ASR #0
    ST4 { V30.B, V31.B, V0.B, V1.B }[0x6], [X22]
    LD4 { V18.B, V19.B, V20.B, V21.B }[0x2], [X22]
    ADD  X22, X22, X19, ASR #0
    MOV  X5, X22
    ST4 { V18.H, V19.H, V20.H, V21.H }[0x3], [X5], #8
    MOV  X5, X22
    LD4 { V29.H, V30.H, V31.H, V0.H }[0x2], [X5], #8
    ADD  X22, X22, X19, LSR #0
    ST4 { V30.H, V31.H, V0.H, V1.H }[0x7], [X22], X25
    LD4 { V18.H, V19.H, V20.H, V21.H }[0x4], [X22], X25
    ADD  X22, X22, X19
    MOV  X5, X22
    ST4 { V9.S, V10.S, V11.S, V12.S }[0x3], [X5], #16
    MOV  X5, X22
    LD4 { V7.S, V8.S, V9.S, V10.S }[0x2], [X5], #16
    ADD  X22, X22, X19, LSR #0
    ST4 { V22.S, V23.S, V24.S, V25.S }[0x3], [X22], X25
    LD4 { V22.S, V23.S, V24.S, V25.S }[0x3], [X22], X25
    ADD  X22, X22, X19, ASR #0
    MOV  X5, X22
    ST4 { V21.D, V22.D, V23.D, V24.D }[0x0], [X5], #32
    MOV  X5, X22
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x0], [X5], #32
    ADD  X22, X22, X19, LSR #0
    ST4 { V29.D, V30.D, V31.D, V0.D }[0x1], [X22], X25
    LD4 { V0.D, V1.D, V2.D, V3.D }[0x1], [X22], X25
    ADD  X22, X22, X19
    MOV  X5, X22
    ST4 { V7.B, V8.B, V9.B, V10.B }[0xc], [X5], #4
    MOV  X5, X22
    LD4 { V9.B, V10.B, V11.B, V12.B }[0xf], [X5], #4
    ADD  X22, X22, X19, ASR #0
    ST4 { V15.B, V16.B, V17.B, V18.B }[0x0], [X22], X25
    LD4 { V4.B, V5.B, V6.B, V7.B }[0x1], [X22], X25
    ADD  X22, X22, X19, LSR #0
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0xa5a5, LSL #0
    MOVK  X16, #0xa5a5, LSL #16
    MOVK  X16, #0xa5a5, LSL #32
    MOVK  X16, #0xa5a5, LSL #48
    SUB  X18, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MRS  X16, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D1
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D2
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D3
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D4
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D5
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D6
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D7
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D8
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D9
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa500, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D10
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D11
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D12
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D13
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D14
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D15
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D16
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D17
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D18
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D19
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D20
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D21
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D22
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D23
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D24
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D25
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D26
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D27
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D28
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D29
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D30
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D31
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X8, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X28
    FMOV  V0.D[1], X23
    FMOV  D1, X2
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X29
    FMOV  D3, X22
    FMOV  V3.D[1], X25
    FMOV  D4, X24
    FMOV  V4.D[1], X12
    FMOV  D5, X3
    FMOV  V5.D[1], X12
    FMOV  D6, X5
    FMOV  V6.D[1], X8
    FMOV  D7, X6
    FMOV  V7.D[1], X7
    FMOV  D8, X17
    FMOV  V8.D[1], X17
    FMOV  D9, X23
    FMOV  V9.D[1], X18
    FMOV  D10, X21
    FMOV  V10.D[1], X18
    FMOV  D11, X18
    FMOV  V11.D[1], X20
    FMOV  D12, X7
    FMOV  V12.D[1], X3
    FMOV  D13, X27
    FMOV  V13.D[1], X2
    FMOV  D14, X6
    FMOV  V14.D[1], X23
    FMOV  D15, X4
    FMOV  V15.D[1], X3
    FMOV  D16, X25
    FMOV  V16.D[1], X16
    FMOV  D17, X23
    FMOV  V17.D[1], X7
    FMOV  D18, X28
    FMOV  V18.D[1], X18
    FMOV  D19, X6
    FMOV  V19.D[1], X26
    FMOV  D20, X25
    FMOV  V20.D[1], X20
    FMOV  D21, X2
    FMOV  V21.D[1], X8
    FMOV  D22, X19
    FMOV  V22.D[1], X18
    FMOV  D23, X5
    FMOV  V23.D[1], X26
    FMOV  D24, X26
    FMOV  V24.D[1], X26
    FMOV  D25, X23
    FMOV  V25.D[1], X19
    FMOV  D26, X23
    FMOV  V26.D[1], X21
    FMOV  D27, X6
    FMOV  V27.D[1], X19
    FMOV  D28, X21
    FMOV  V28.D[1], X12
    FMOV  D29, X29
    FMOV  V29.D[1], X24
    FMOV  D30, X23
    FMOV  V30.D[1], X24
    FMOV  D31, X15
    FMOV  V31.D[1], X4
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X26, #0x1400, LSL #0
    ADD  X17, X30, X26
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X17]
    LD4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X17]
    ADD  X17, X17, X2, LSR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X17]
    LD4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X17]
    ADD  X17, X17, X2, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X17]
    LD4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X17]
    ADD  X17, X17, X2, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X17]
    LD4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X17]
    ADD  X17, X17, X2
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X17]
    LD4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X17]
    ADD  X17, X17, X2, LSR #0
    ST4 { V24.2S, V25.2S, V26.2S, V27.2S }, [X17]
    LD4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X17]
    ADD  X17, X17, X2, ASR #0
    ST4 { V28.2S, V29.2S, V30.2S, V31.2S }, [X17]
    LD4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X17]
    ADD  X17, X17, X2
    ST4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X17]
    LD4 { V10.4H, V11.4H, V12.4H, V13.4H }, [X17]
    ADD  X17, X17, X2, ASR #0
    ST4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X17]
    LD4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X17]
    ADD  X17, X17, X2, ASR #0
    MOV  X21, X17
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X21], #64
    MOV  X21, X17
    LD4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X21], #64
    ADD  X17, X17, X2
    MOV  X21, X17
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X21], #64
    MOV  X21, X17
    LD4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X21], #64
    ADD  X17, X17, X2, ASR #0
    MOV  X21, X17
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X21], #64
    MOV  X21, X17
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X21], #64
    ADD  X17, X17, X2, ASR #0
    MOV  X21, X17
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X21], #64
    MOV  X21, X17
    LD4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X21], #64
    ADD  X17, X17, X2, LSR #0
    MOV  X21, X17
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X21], #64
    MOV  X21, X17
    LD4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X21], #64
    ADD  X17, X17, X2
    MOV  X21, X17
    ST4 { V0.8B, V1.8B, V2.8B, V3.8B }, [X21], #32
    MOV  X21, X17
    LD4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X21], #32
    ADD  X17, X17, X2
    MOV  X21, X17
    ST4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X21], #32
    MOV  X21, X17
    LD4 { V22.2S, V23.2S, V24.2S, V25.2S }, [X21], #32
    ADD  X17, X17, X2, ASR #0
    MOV  X21, X17
    ST4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X21], #32
    MOV  X21, X17
    LD4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X21], #32
    ADD  X17, X17, X2, ASR #0
    MOV  X21, X17
    ST4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X21], #32
    MOV  X21, X17
    LD4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X21], #32
    ADD  X17, X17, X2, LSR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X17], X27
    LD4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X17], X27
    ADD  X17, X17, X2
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X17], X27
    LD4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X17], X27
    ADD  X17, X17, X2
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X17], X27
    LD4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X17], X27
    ADD  X17, X17, X2, LSR #0
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X17], X27
    LD4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X17], X27
    ADD  X17, X17, X2, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X17], X27
    LD4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X17], X27
    ADD  X17, X17, X2, LSR #0
    ST4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X17], X27
    LD4 { V20.8B, V21.8B, V22.8B, V23.8B }, [X17], X27
    ADD  X17, X17, X2, ASR #0
    ST4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X17], X27
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X17], X27
    ADD  X17, X17, X2
    ST4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X17], X27
    LD4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X17], X27
    ADD  X17, X17, X2, ASR #0
    ST4 { V11.8B, V12.8B, V13.8B, V14.8B }, [X17], X27
    LD4 { V11.8B, V12.8B, V13.8B, V14.8B }, [X17], X27
    ADD  X17, X17, X2, LSR #0
    ST4 { V21.H, V22.H, V23.H, V24.H }[0x0], [X17]
    LD4 { V14.H, V15.H, V16.H, V17.H }[0x7], [X17]
    ADD  X17, X17, X2, LSR #0
    ST4 { V28.S, V29.S, V30.S, V31.S }[0x0], [X17]
    LD4 { V31.S, V0.S, V1.S, V2.S }[0x3], [X17]
    ADD  X17, X17, X2, ASR #0
    ST4 { V11.D, V12.D, V13.D, V14.D }[0x1], [X17]
    LD4 { V31.D, V0.D, V1.D, V2.D }[0x0], [X17]
    ADD  X17, X17, X2, ASR #0
    ST4 { V2.B, V3.B, V4.B, V5.B }[0xb], [X17]
    LD4 { V2.B, V3.B, V4.B, V5.B }[0x6], [X17]
    ADD  X17, X17, X2, ASR #0
    MOV  X21, X17
    ST4 { V14.H, V15.H, V16.H, V17.H }[0x6], [X21], #8
    MOV  X21, X17
    LD4 { V11.H, V12.H, V13.H, V14.H }[0x7], [X21], #8
    ADD  X17, X17, X2, ASR #0
    ST4 { V1.H, V2.H, V3.H, V4.H }[0x1], [X17], X27
    LD4 { V28.H, V29.H, V30.H, V31.H }[0x7], [X17], X27
    ADD  X17, X17, X2, ASR #0
    MOV  X21, X17
    ST4 { V20.S, V21.S, V22.S, V23.S }[0x3], [X21], #16
    MOV  X21, X17
    LD4 { V20.S, V21.S, V22.S, V23.S }[0x1], [X21], #16
    ADD  X17, X17, X2
    ST4 { V11.S, V12.S, V13.S, V14.S }[0x3], [X17], X27
    LD4 { V4.S, V5.S, V6.S, V7.S }[0x1], [X17], X27
    ADD  X17, X17, X2, ASR #0
    MOV  X21, X17
    ST4 { V29.D, V30.D, V31.D, V0.D }[0x0], [X21], #32
    MOV  X21, X17
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x1], [X21], #32
    ADD  X17, X17, X2, ASR #0
    ST4 { V22.D, V23.D, V24.D, V25.D }[0x1], [X17], X27
    LD4 { V31.D, V0.D, V1.D, V2.D }[0x0], [X17], X27
    ADD  X17, X17, X2, ASR #0
    MOV  X21, X17
    ST4 { V4.B, V5.B, V6.B, V7.B }[0x4], [X21], #4
    MOV  X21, X17
    LD4 { V27.B, V28.B, V29.B, V30.B }[0x9], [X21], #4
    ADD  X17, X17, X2, ASR #0
    ST4 { V30.B, V31.B, V0.B, V1.B }[0x9], [X17], X27
    LD4 { V22.B, V23.B, V24.B, V25.B }[0x9], [X17], X27
    ADD  X17, X17, X2
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X18
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X22
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X5, #0x5a5a, LSL #0
    MOVK  X5, #0x5a5a, LSL #16
    MOVK  X5, #0x5a5a, LSL #32
    MOVK  X5, #0x5a5a, LSL #48
    SUB  X12, X5, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MRS  X5, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D0
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V1.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D1
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V2.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D2
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V3.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D3
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V4.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D4
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V5.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D5
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V6.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D6
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V7.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D7
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V8.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D8
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D9
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D10
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D11
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D12
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V13.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D13
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D14
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V15.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D15
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D16
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D17
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D18
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D19
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D20
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V21.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D21
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V22.D[1]
    MOVZ  X12, #0x5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D22
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D23
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D24
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V25.D[1]
    MOVZ  X12, #0x5a00, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D25
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D26
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D27
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D28
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D29
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D30
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    FMOV  X5, D31
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X24, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X5
    FMOV  V0.D[1], X29
    FMOV  D1, X24
    FMOV  V1.D[1], X2
    FMOV  D2, X16
    FMOV  V2.D[1], X25
    FMOV  D3, X3
    FMOV  V3.D[1], X4
    FMOV  D4, X27
    FMOV  V4.D[1], X22
    FMOV  D5, X12
    FMOV  V5.D[1], X28
    FMOV  D6, X2
    FMOV  V6.D[1], X22
    FMOV  D7, X21
    FMOV  V7.D[1], X26
    FMOV  D8, X8
    FMOV  V8.D[1], X29
    FMOV  D9, X19
    FMOV  V9.D[1], X27
    FMOV  D10, X26
    FMOV  V10.D[1], X4
    FMOV  D11, X17
    FMOV  V11.D[1], X6
    FMOV  D12, X12
    FMOV  V12.D[1], X27
    FMOV  D13, X17
    FMOV  V13.D[1], X5
    FMOV  D14, X6
    FMOV  V14.D[1], X20
    FMOV  D15, X20
    FMOV  V15.D[1], X19
    FMOV  D16, X25
    FMOV  V16.D[1], X5
    FMOV  D17, X26
    FMOV  V17.D[1], X22
    FMOV  D18, X16
    FMOV  V18.D[1], X29
    FMOV  D19, X22
    FMOV  V19.D[1], X12
    FMOV  D20, X5
    FMOV  V20.D[1], X29
    FMOV  D21, X3
    FMOV  V21.D[1], X4
    FMOV  D22, X6
    FMOV  V22.D[1], X25
    FMOV  D23, X6
    FMOV  V23.D[1], X28
    FMOV  D24, X29
    FMOV  V24.D[1], X24
    FMOV  D25, X19
    FMOV  V25.D[1], X12
    FMOV  D26, X5
    FMOV  V26.D[1], X3
    FMOV  D27, X24
    FMOV  V27.D[1], X20
    FMOV  D28, X4
    FMOV  V28.D[1], X29
    FMOV  D29, X19
    FMOV  V29.D[1], X15
    FMOV  D30, X4
    FMOV  V30.D[1], X2
    FMOV  D31, X3
    FMOV  V31.D[1], X5
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X16, #0x1900, LSL #0
    ADD  X15, X30, X16, LSR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X15]
    LD4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X15]
    ADD  X15, X15, X20
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X15]
    LD4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X15]
    ADD  X15, X15, X20, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X15]
    LD4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X15]
    ADD  X15, X15, X20, LSR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X15]
    LD4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X15]
    ADD  X15, X15, X20
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X15]
    LD4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X15]
    ADD  X15, X15, X20
    ST4 { V12.8B, V13.8B, V14.8B, V15.8B }, [X15]
    LD4 { V4.8B, V5.8B, V6.8B, V7.8B }, [X15]
    ADD  X15, X15, X20, LSR #0
    ST4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X15]
    LD4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X15]
    ADD  X15, X15, X20
    ST4 { V5.4H, V6.4H, V7.4H, V8.4H }, [X15]
    LD4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X15]
    ADD  X15, X15, X20
    ST4 { V19.8B, V20.8B, V21.8B, V22.8B }, [X15]
    LD4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X15]
    ADD  X15, X15, X20
    MOV  X26, X15
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X26], #64
    MOV  X26, X15
    LD4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X26], #64
    ADD  X15, X15, X20, ASR #0
    MOV  X26, X15
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X26], #64
    MOV  X26, X15
    LD4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X26], #64
    ADD  X15, X15, X20
    MOV  X26, X15
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X26], #64
    MOV  X26, X15
    LD4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X26], #64
    ADD  X15, X15, X20
    MOV  X26, X15
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X26], #64
    MOV  X26, X15
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X26], #64
    ADD  X15, X15, X20
    MOV  X26, X15
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X26], #64
    MOV  X26, X15
    LD4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X26], #64
    ADD  X15, X15, X20, ASR #0
    MOV  X26, X15
    ST4 { V27.4H, V28.4H, V29.4H, V30.4H }, [X26], #32
    MOV  X26, X15
    LD4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X26], #32
    ADD  X15, X15, X20, LSR #0
    MOV  X26, X15
    ST4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X26], #32
    MOV  X26, X15
    LD4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X26], #32
    ADD  X15, X15, X20, ASR #0
    MOV  X26, X15
    ST4 { V11.4H, V12.4H, V13.4H, V14.4H }, [X26], #32
    MOV  X26, X15
    LD4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X26], #32
    ADD  X15, X15, X20, ASR #0
    MOV  X26, X15
    ST4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X26], #32
    MOV  X26, X15
    LD4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X26], #32
    ADD  X15, X15, X20
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X15], X27
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X15], X27
    ADD  X15, X15, X20
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X15], X27
    LD4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X15], X27
    ADD  X15, X15, X20, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X15], X27
    LD4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X15], X27
    ADD  X15, X15, X20, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X15], X27
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X15], X27
    ADD  X15, X15, X20, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X15], X27
    LD4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X15], X27
    ADD  X15, X15, X20, LSR #0
    ST4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X15], X27
    LD4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X15], X27
    ADD  X15, X15, X20, ASR #0
    ST4 { V11.2S, V12.2S, V13.2S, V14.2S }, [X15], X27
    LD4 { V3.2S, V4.2S, V5.2S, V6.2S }, [X15], X27
    ADD  X15, X15, X20, LSR #0
    ST4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X15], X27
    LD4 { V23.4H, V24.4H, V25.4H, V26.4H }, [X15], X27
    ADD  X15, X15, X20
    ST4 { V7.8B, V8.8B, V9.8B, V10.8B }, [X15], X27
    LD4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X15], X27
    ADD  X15, X15, X20, ASR #0
    ST4 { V23.H, V24.H, V25.H, V26.H }[0x3], [X15]
    LD4 { V28.H, V29.H, V30.H, V31.H }[0x7], [X15]
    ADD  X15, X15, X20, ASR #0
    ST4 { V5.S, V6.S, V7.S, V8.S }[0x0], [X15]
    LD4 { V12.S, V13.S, V14.S, V15.S }[0x0], [X15]
    ADD  X15, X15, X20, ASR #0
    ST4 { V21.D, V22.D, V23.D, V24.D }[0x1], [X15]
    LD4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X15]
    ADD  X15, X15, X20, ASR #0
    ST4 { V22.B, V23.B, V24.B, V25.B }[0x9], [X15]
    LD4 { V29.B, V30.B, V31.B, V0.B }[0x9], [X15]
    ADD  X15, X15, X20, ASR #0
    MOV  X26, X15
    ST4 { V28.H, V29.H, V30.H, V31.H }[0x1], [X26], #8
    MOV  X26, X15
    LD4 { V21.H, V22.H, V23.H, V24.H }[0x5], [X26], #8
    ADD  X15, X15, X20, ASR #0
    ST4 { V21.H, V22.H, V23.H, V24.H }[0x3], [X15], X27
    LD4 { V28.H, V29.H, V30.H, V31.H }[0x7], [X15], X27
    ADD  X15, X15, X20, LSR #0
    MOV  X26, X15
    ST4 { V29.S, V30.S, V31.S, V0.S }[0x1], [X26], #16
    MOV  X26, X15
    LD4 { V4.S, V5.S, V6.S, V7.S }[0x0], [X26], #16
    ADD  X15, X15, X20, LSR #0
    ST4 { V28.S, V29.S, V30.S, V31.S }[0x1], [X15], X27
    LD4 { V22.S, V23.S, V24.S, V25.S }[0x3], [X15], X27
    ADD  X15, X15, X20, ASR #0
    MOV  X26, X15
    ST4 { V25.D, V26.D, V27.D, V28.D }[0x1], [X26], #32
    MOV  X26, X15
    LD4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X26], #32
    ADD  X15, X15, X20
    ST4 { V26.D, V27.D, V28.D, V29.D }[0x1], [X15], X27
    LD4 { V20.D, V21.D, V22.D, V23.D }[0x0], [X15], X27
    ADD  X15, X15, X20, ASR #0
    MOV  X26, X15
    ST4 { V4.B, V5.B, V6.B, V7.B }[0x1], [X26], #4
    MOV  X26, X15
    LD4 { V9.B, V10.B, V11.B, V12.B }[0xf], [X26], #4
    ADD  X15, X15, X20, LSR #0
    ST4 { V31.B, V0.B, V1.B, V2.B }[0x0], [X15], X27
    LD4 { V25.B, V26.B, V27.B, V28.B }[0xb], [X15], X27
    ADD  X15, X15, X20, LSR #0
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X21, #0xa5a5, LSL #0
    MOVK  X21, #0xa5a5, LSL #16
    MOVK  X21, #0xa5a5, LSL #32
    MOVK  X21, #0xa5a5, LSL #48
    SUB  X29, X21, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MRS  X21, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D0
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V1.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D1
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D2
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D3
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D4
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D5
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D6
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D7
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D8
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V9.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D9
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D10
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D11
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D12
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D13
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D14
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D15
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D16
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V17.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D17
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V18.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D18
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D19
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D20
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D21
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D22
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D23
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D24
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D25
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D26
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D27
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D28
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D29
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V30.D[1]
    MOVZ  X29, #0xa5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D30
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X21, D31
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    FMOV  D1, X29
    FMOV  V1.D[1], X23
    FMOV  D2, X3
    FMOV  V2.D[1], X28
    FMOV  D3, X8
    FMOV  V3.D[1], X29
    FMOV  D4, X6
    FMOV  V4.D[1], X12
    FMOV  D5, X12
    FMOV  V5.D[1], X27
    FMOV  D6, X4
    FMOV  V6.D[1], X29
    FMOV  D7, X4
    FMOV  V7.D[1], X2
    FMOV  D8, X16
    FMOV  V8.D[1], X19
    FMOV  D9, X8
    FMOV  V9.D[1], X20
    FMOV  D10, X19
    FMOV  V10.D[1], X22
    FMOV  D11, X29
    FMOV  V11.D[1], X16
    FMOV  D12, X20
    FMOV  V12.D[1], X16
    FMOV  D13, X18
    FMOV  V13.D[1], X19
    FMOV  D14, X24
    FMOV  V14.D[1], X27
    FMOV  D15, X6
    FMOV  V15.D[1], X19
    FMOV  D16, X17
    FMOV  V16.D[1], X21
    FMOV  D17, X17
    FMOV  V17.D[1], X6
    FMOV  D18, X5
    FMOV  V18.D[1], X8
    FMOV  D19, X27
    FMOV  V19.D[1], X25
    FMOV  D20, X17
    FMOV  V20.D[1], X22
    FMOV  D21, X29
    FMOV  V21.D[1], X27
    FMOV  D22, X18
    FMOV  V22.D[1], X26
    FMOV  D23, X7
    FMOV  V23.D[1], X16
    FMOV  D24, X29
    FMOV  V24.D[1], X7
    FMOV  D25, X16
    FMOV  V25.D[1], X25
    FMOV  D26, X25
    FMOV  V26.D[1], X8
    FMOV  D27, X5
    FMOV  V27.D[1], X22
    FMOV  D28, X7
    FMOV  V28.D[1], X27
    FMOV  D29, X19
    FMOV  V29.D[1], X22
    FMOV  D30, X28
    FMOV  V30.D[1], X6
    FMOV  D31, X19
    FMOV  V31.D[1], X6
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X6, #0x1e00, LSL #0
    ADD  X3, X30, X6
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X3]
    LD4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X3]
    ADD  X3, X3, X8
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X3]
    LD4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X3]
    ADD  X3, X3, X8, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X3]
    LD4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X3]
    ADD  X3, X3, X8, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X3]
    LD4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X3]
    ADD  X3, X3, X8, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X3]
    LD4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X3]
    ADD  X3, X3, X8, LSR #0
    ST4 { V22.4H, V23.4H, V24.4H, V25.4H }, [X3]
    LD4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X3]
    ADD  X3, X3, X8
    ST4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X3]
    LD4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X3]
    ADD  X3, X3, X8
    ST4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X3]
    LD4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X3]
    ADD  X3, X3, X8, ASR #0
    ST4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X3]
    LD4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X3]
    ADD  X3, X3, X8, ASR #0
    MOV  X4, X3
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X4], #64
    MOV  X4, X3
    LD4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X4], #64
    ADD  X3, X3, X8, ASR #0
    MOV  X4, X3
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X4], #64
    MOV  X4, X3
    LD4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X4], #64
    ADD  X3, X3, X8, ASR #0
    MOV  X4, X3
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X4], #64
    MOV  X4, X3
    LD4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X4], #64
    ADD  X3, X3, X8, LSR #0
    MOV  X4, X3
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X4], #64
    MOV  X4, X3
    LD4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X4], #64
    ADD  X3, X3, X8
    MOV  X4, X3
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X4], #64
    MOV  X4, X3
    LD4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X4], #64
    ADD  X3, X3, X8
    MOV  X4, X3
    ST4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X4], #32
    MOV  X4, X3
    LD4 { V9.4H, V10.4H, V11.4H, V12.4H }, [X4], #32
    ADD  X3, X3, X8
    MOV  X4, X3
    ST4 { V9.2S, V10.2S, V11.2S, V12.2S }, [X4], #32
    MOV  X4, X3
    LD4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X4], #32
    ADD  X3, X3, X8, ASR #0
    MOV  X4, X3
    ST4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X4], #32
    MOV  X4, X3
    LD4 { V5.4H, V6.4H, V7.4H, V8.4H }, [X4], #32
    ADD  X3, X3, X8
    MOV  X4, X3
    ST4 { V5.8B, V6.8B, V7.8B, V8.8B }, [X4], #32
    MOV  X4, X3
    LD4 { V7.8B, V8.8B, V9.8B, V10.8B }, [X4], #32
    ADD  X3, X3, X8, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X3], X19
    LD4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X3], X19
    ADD  X3, X3, X8, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X3], X19
    LD4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X3], X19
    ADD  X3, X3, X8, LSR #0
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X3], X19
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X3], X19
    ADD  X3, X3, X8, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X3], X19
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X3], X19
    ADD  X3, X3, X8
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X3], X19
    LD4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X3], X19
    ADD  X3, X3, X8, ASR #0
    ST4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X3], X19
    LD4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X3], X19
    ADD  X3, X3, X8
    ST4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X3], X19
    LD4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X3], X19
    ADD  X3, X3, X8, ASR #0
    ST4 { V10.4H, V11.4H, V12.4H, V13.4H }, [X3], X19
    LD4 { V27.4H, V28.4H, V29.4H, V30.4H }, [X3], X19
    ADD  X3, X3, X8, LSR #0
    ST4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X3], X19
    LD4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X3], X19
    ADD  X3, X3, X8, LSR #0
    ST4 { V17.H, V18.H, V19.H, V20.H }[0x5], [X3]
    LD4 { V18.H, V19.H, V20.H, V21.H }[0x6], [X3]
    ADD  X3, X3, X8
    ST4 { V18.S, V19.S, V20.S, V21.S }[0x0], [X3]
    LD4 { V18.S, V19.S, V20.S, V21.S }[0x0], [X3]
    ADD  X3, X3, X8
    ST4 { V17.D, V18.D, V19.D, V20.D }[0x0], [X3]
    LD4 { V17.D, V18.D, V19.D, V20.D }[0x1], [X3]
    ADD  X3, X3, X8, LSR #0
    ST4 { V29.B, V30.B, V31.B, V0.B }[0x1], [X3]
    LD4 { V30.B, V31.B, V0.B, V1.B }[0x0], [X3]
    ADD  X3, X3, X8, LSR #0
    MOV  X4, X3
    ST4 { V30.H, V31.H, V0.H, V1.H }[0x2], [X4], #8
    MOV  X4, X3
    LD4 { V30.H, V31.H, V0.H, V1.H }[0x6], [X4], #8
    ADD  X3, X3, X8, ASR #0
    ST4 { V11.H, V12.H, V13.H, V14.H }[0x1], [X3], X19
    LD4 { V11.H, V12.H, V13.H, V14.H }[0x5], [X3], X19
    ADD  X3, X3, X8, ASR #0
    MOV  X4, X3
    ST4 { V17.S, V18.S, V19.S, V20.S }[0x0], [X4], #16
    MOV  X4, X3
    LD4 { V5.S, V6.S, V7.S, V8.S }[0x1], [X4], #16
    ADD  X3, X3, X8, ASR #0
    ST4 { V11.S, V12.S, V13.S, V14.S }[0x1], [X3], X19
    LD4 { V6.S, V7.S, V8.S, V9.S }[0x0], [X3], X19
    ADD  X3, X3, X8, ASR #0
    MOV  X4, X3
    ST4 { V5.D, V6.D, V7.D, V8.D }[0x1], [X4], #32
    MOV  X4, X3
    LD4 { V16.D, V17.D, V18.D, V19.D }[0x0], [X4], #32
    ADD  X3, X3, X8
    ST4 { V7.D, V8.D, V9.D, V10.D }[0x1], [X3], X19
    LD4 { V20.D, V21.D, V22.D, V23.D }[0x0], [X3], X19
    ADD  X3, X3, X8
    MOV  X4, X3
    ST4 { V11.B, V12.B, V13.B, V14.B }[0xe], [X4], #4
    MOV  X4, X3
    LD4 { V10.B, V11.B, V12.B, V13.B }[0xb], [X4], #4
    ADD  X3, X3, X8
    ST4 { V16.B, V17.B, V18.B, V19.B }[0x3], [X3], X19
    LD4 { V9.B, V10.B, V11.B, V12.B }[0x3], [X3], X19
    ADD  X3, X3, X8, LSR #0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X15
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X16
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X17
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X18
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X21
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X22
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X24
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X2, X20, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP07_TestFail
    MRS  X20, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a5a, LSL #32
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V1.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a5a, LSL #32
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D1
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V2.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D2
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V3.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D3
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V4.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D4
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V5.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D5
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V6.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D6
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V7.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D7
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D8
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D9
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D10
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a, LSL #16
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D11
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D12
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V13.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D13
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D14
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D15
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D16
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V17.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D17
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V18.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D18
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V19.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D19
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V20.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D20
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V21.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D21
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V22.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D22
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V23.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D23
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V24.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D24
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V25.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D25
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V26.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D26
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V27.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D27
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V28.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D28
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V29.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D29
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a5a, LSL #32
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D30
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    MOVK  X2, #0x5a5a, LSL #32
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
    FMOV  X20, D31
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X25, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X16
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X23
    FMOV  D3, X28
    FMOV  V3.D[1], X6
    FMOV  D4, X27
    FMOV  V4.D[1], X2
    FMOV  D5, X22
    FMOV  V5.D[1], X29
    FMOV  D6, X16
    FMOV  V6.D[1], X6
    FMOV  D7, X25
    FMOV  V7.D[1], X25
    FMOV  D8, X3
    FMOV  V8.D[1], X28
    FMOV  D9, X5
    FMOV  V9.D[1], X17
    FMOV  D10, X29
    FMOV  V10.D[1], X7
    FMOV  D11, X4
    FMOV  V11.D[1], X12
    FMOV  D12, X26
    FMOV  V12.D[1], X8
    FMOV  D13, X6
    FMOV  V13.D[1], X6
    FMOV  D14, X16
    FMOV  V14.D[1], X12
    FMOV  D15, X23
    FMOV  V15.D[1], X20
    FMOV  D16, X5
    FMOV  V16.D[1], X15
    FMOV  D17, X18
    FMOV  V17.D[1], X25
    FMOV  D18, X8
    FMOV  V18.D[1], X17
    FMOV  D19, X25
    FMOV  V19.D[1], X22
    FMOV  D20, X29
    FMOV  V20.D[1], X23
    FMOV  D21, X15
    FMOV  V21.D[1], X28
    FMOV  D22, X7
    FMOV  V22.D[1], X20
    FMOV  D23, X8
    FMOV  V23.D[1], X2
    FMOV  D24, X28
    FMOV  V24.D[1], X19
    FMOV  D25, X26
    FMOV  V25.D[1], X8
    FMOV  D26, X16
    FMOV  V26.D[1], X5
    FMOV  D27, X16
    FMOV  V27.D[1], X27
    FMOV  D28, X6
    FMOV  V28.D[1], X8
    FMOV  D29, X18
    FMOV  V29.D[1], X3
    FMOV  D30, X16
    FMOV  V30.D[1], X4
    FMOV  D31, X19
    FMOV  V31.D[1], X2
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X4, #0x2300, LSL #0
    ADD  X12, X30, X4, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X12]
    LD4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X12]
    ADD  X12, X12, X20, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X12]
    LD4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X12]
    ADD  X12, X12, X20, LSR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X12]
    LD4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X12]
    ADD  X12, X12, X20, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X12]
    LD4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X12]
    ADD  X12, X12, X20, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X12]
    LD4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X12]
    ADD  X12, X12, X20, ASR #0
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X12]
    LD4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X12]
    ADD  X12, X12, X20, ASR #0
    ST4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X12]
    LD4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X12]
    ADD  X12, X12, X20, ASR #0
    ST4 { V12.4H, V13.4H, V14.4H, V15.4H }, [X12]
    LD4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X12]
    ADD  X12, X12, X20, LSR #0
    ST4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X12]
    LD4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X12]
    ADD  X12, X12, X20, LSR #0
    MOV  X21, X12
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X21], #64
    MOV  X21, X12
    LD4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X21], #64
    ADD  X12, X12, X20
    MOV  X21, X12
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X21], #64
    MOV  X21, X12
    LD4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X21], #64
    ADD  X12, X12, X20
    MOV  X21, X12
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X21], #64
    MOV  X21, X12
    LD4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X21], #64
    ADD  X12, X12, X20, LSR #0
    MOV  X21, X12
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X21], #64
    MOV  X21, X12
    LD4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X21], #64
    ADD  X12, X12, X20, ASR #0
    MOV  X21, X12
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X21], #64
    MOV  X21, X12
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X21], #64
    ADD  X12, X12, X20, LSR #0
    MOV  X21, X12
    ST4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X21], #32
    MOV  X21, X12
    LD4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X21], #32
    ADD  X12, X12, X20
    MOV  X21, X12
    ST4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X21], #32
    MOV  X21, X12
    LD4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X21], #32
    ADD  X12, X12, X20, ASR #0
    MOV  X21, X12
    ST4 { V2.4H, V3.4H, V4.4H, V5.4H }, [X21], #32
    MOV  X21, X12
    LD4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X21], #32
    ADD  X12, X12, X20
    MOV  X21, X12
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X21], #32
    MOV  X21, X12
    LD4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X21], #32
    ADD  X12, X12, X20, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X12], X27
    LD4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X12], X27
    ADD  X12, X12, X20
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X12], X27
    LD4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X12], X27
    ADD  X12, X12, X20, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X12], X27
    LD4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X12], X27
    ADD  X12, X12, X20
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X12], X27
    LD4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X12], X27
    ADD  X12, X12, X20, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X12], X27
    LD4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X12], X27
    ADD  X12, X12, X20, LSR #0
    ST4 { V15.8B, V16.8B, V17.8B, V18.8B }, [X12], X27
    LD4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X12], X27
    ADD  X12, X12, X20, LSR #0
    ST4 { V19.2S, V20.2S, V21.2S, V22.2S }, [X12], X27
    LD4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X12], X27
    ADD  X12, X12, X20, LSR #0
    ST4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X12], X27
    LD4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X12], X27
    ADD  X12, X12, X20
    ST4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X12], X27
    LD4 { V0.8B, V1.8B, V2.8B, V3.8B }, [X12], X27
    ADD  X12, X12, X20, ASR #0
    ST4 { V0.H, V1.H, V2.H, V3.H }[0x4], [X12]
    LD4 { V14.H, V15.H, V16.H, V17.H }[0x7], [X12]
    ADD  X12, X12, X20, LSR #0
    ST4 { V14.S, V15.S, V16.S, V17.S }[0x1], [X12]
    LD4 { V28.S, V29.S, V30.S, V31.S }[0x2], [X12]
    ADD  X12, X12, X20, LSR #0
    ST4 { V28.D, V29.D, V30.D, V31.D }[0x1], [X12]
    LD4 { V29.D, V30.D, V31.D, V0.D }[0x0], [X12]
    ADD  X12, X12, X20, ASR #0
    ST4 { V16.B, V17.B, V18.B, V19.B }[0x0], [X12]
    LD4 { V21.B, V22.B, V23.B, V24.B }[0xc], [X12]
    ADD  X12, X12, X20, LSR #0
    MOV  X21, X12
    ST4 { V1.H, V2.H, V3.H, V4.H }[0x1], [X21], #8
    MOV  X21, X12
    LD4 { V17.H, V18.H, V19.H, V20.H }[0x0], [X21], #8
    ADD  X12, X12, X20
    ST4 { V20.H, V21.H, V22.H, V23.H }[0x4], [X12], X27
    LD4 { V17.H, V18.H, V19.H, V20.H }[0x1], [X12], X27
    ADD  X12, X12, X20, LSR #0
    MOV  X21, X12
    ST4 { V1.S, V2.S, V3.S, V4.S }[0x0], [X21], #16
    MOV  X21, X12
    LD4 { V15.S, V16.S, V17.S, V18.S }[0x3], [X21], #16
    ADD  X12, X12, X20, LSR #0
    ST4 { V10.S, V11.S, V12.S, V13.S }[0x0], [X12], X27
    LD4 { V9.S, V10.S, V11.S, V12.S }[0x3], [X12], X27
    ADD  X12, X12, X20, ASR #0
    MOV  X21, X12
    ST4 { V13.D, V14.D, V15.D, V16.D }[0x0], [X21], #32
    MOV  X21, X12
    LD4 { V2.D, V3.D, V4.D, V5.D }[0x0], [X21], #32
    ADD  X12, X12, X20, LSR #0
    ST4 { V2.D, V3.D, V4.D, V5.D }[0x0], [X12], X27
    LD4 { V4.D, V5.D, V6.D, V7.D }[0x1], [X12], X27
    ADD  X12, X12, X20, LSR #0
    MOV  X21, X12
    ST4 { V16.B, V17.B, V18.B, V19.B }[0xf], [X21], #4
    MOV  X21, X12
    LD4 { V18.B, V19.B, V20.B, V21.B }[0x1], [X21], #4
    ADD  X12, X12, X20, LSR #0
    ST4 { V18.B, V19.B, V20.B, V21.B }[0xe], [X12], X27
    LD4 { V14.B, V15.B, V16.B, V17.B }[0x9], [X12], X27
    ADD  X12, X12, X20
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X22
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X15, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    MRS  X3, FPSR
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D0
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D1
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D2
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D3
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D4
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D5
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D6
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D7
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D8
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D9
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D10
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D11
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D12
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D13
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X15, #0xa500, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D14
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D15
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D16
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D17
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D18
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D19
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D20
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5, LSL #32
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D21
    MOVZ  X15, #0xa5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5, LSL #32
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D22
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5, LSL #32
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D23
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X15, #0x0, LSL #0
    MOVK  X15, #0xa5, LSL #32
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D24
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D25
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D26
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X15, #0x0, LSL #0
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D27
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D28
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D29
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D30
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D31
    MOVZ  X15, #0xa5a5, LSL #0
    MOVK  X15, #0xa5a5, LSL #16
    MOVK  X15, #0xa5a5, LSL #32
    MOVK  X15, #0xa5a5, LSL #48
    SUB  X7, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    FMOV  V1.D[1], X19
    FMOV  D2, X4
    FMOV  V2.D[1], X28
    FMOV  D3, X17
    FMOV  V3.D[1], X27
    FMOV  D4, X24
    FMOV  V4.D[1], X18
    FMOV  D5, X23
    FMOV  V5.D[1], X12
    FMOV  D6, X26
    FMOV  V6.D[1], X29
    FMOV  D7, X2
    FMOV  V7.D[1], X23
    FMOV  D8, X18
    FMOV  V8.D[1], X17
    FMOV  D9, X5
    FMOV  V9.D[1], X18
    FMOV  D10, X12
    FMOV  V10.D[1], X7
    FMOV  D11, X27
    FMOV  V11.D[1], X18
    FMOV  D12, X7
    FMOV  V12.D[1], X16
    FMOV  D13, X8
    FMOV  V13.D[1], X8
    FMOV  D14, X4
    FMOV  V14.D[1], X8
    FMOV  D15, X19
    FMOV  V15.D[1], X19
    FMOV  D16, X24
    FMOV  V16.D[1], X16
    FMOV  D17, X16
    FMOV  V17.D[1], X23
    FMOV  D18, X21
    FMOV  V18.D[1], X19
    FMOV  D19, X12
    FMOV  V19.D[1], X2
    FMOV  D20, X20
    FMOV  V20.D[1], X27
    FMOV  D21, X8
    FMOV  V21.D[1], X18
    FMOV  D22, X3
    FMOV  V22.D[1], X23
    FMOV  D23, X24
    FMOV  V23.D[1], X3
    FMOV  D24, X27
    FMOV  V24.D[1], X3
    FMOV  D25, X19
    FMOV  V25.D[1], X15
    FMOV  D26, X29
    FMOV  V26.D[1], X25
    FMOV  D27, X17
    FMOV  V27.D[1], X18
    FMOV  D28, X24
    FMOV  V28.D[1], X15
    FMOV  D29, X8
    FMOV  V29.D[1], X4
    FMOV  D30, X24
    FMOV  V30.D[1], X5
    FMOV  D31, X21
    FMOV  V31.D[1], X23
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X5, #0x2800, LSL #0
    ADD  X15, X30, X5, LSR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X15]
    LD4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X15]
    ADD  X15, X15, X21
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X15]
    LD4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X15]
    LD4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X15]
    ADD  X15, X15, X21, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X15]
    LD4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X15]
    LD4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X15]
    LD4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X15]
    LD4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X15]
    ADD  X15, X15, X21
    ST4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X15]
    LD4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X15]
    LD4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X15]
    ADD  X15, X15, X21
    MOV  X23, X15
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X23], #64
    MOV  X23, X15
    LD4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X23], #64
    ADD  X15, X15, X21
    MOV  X23, X15
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X23], #64
    MOV  X23, X15
    LD4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X23], #64
    ADD  X15, X15, X21
    MOV  X23, X15
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X23], #64
    MOV  X23, X15
    LD4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X23], #64
    ADD  X15, X15, X21, LSR #0
    MOV  X23, X15
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X23], #64
    MOV  X23, X15
    LD4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X23], #64
    ADD  X15, X15, X21, LSR #0
    MOV  X23, X15
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X23], #64
    MOV  X23, X15
    LD4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X23], #64
    ADD  X15, X15, X21, LSR #0
    MOV  X23, X15
    ST4 { V24.4H, V25.4H, V26.4H, V27.4H }, [X23], #32
    MOV  X23, X15
    LD4 { V28.8B, V29.8B, V30.8B, V31.8B }, [X23], #32
    ADD  X15, X15, X21, LSR #0
    MOV  X23, X15
    ST4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X23], #32
    MOV  X23, X15
    LD4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X23], #32
    ADD  X15, X15, X21
    MOV  X23, X15
    ST4 { V12.4H, V13.4H, V14.4H, V15.4H }, [X23], #32
    MOV  X23, X15
    LD4 { V9.4H, V10.4H, V11.4H, V12.4H }, [X23], #32
    ADD  X15, X15, X21, ASR #0
    MOV  X23, X15
    ST4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X23], #32
    MOV  X23, X15
    LD4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X23], #32
    ADD  X15, X15, X21, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X15], X17
    LD4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X15], X17
    ADD  X15, X15, X21, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X15], X17
    LD4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X15], X17
    ADD  X15, X15, X21
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X15], X17
    LD4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X15], X17
    ADD  X15, X15, X21
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X15], X17
    LD4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X15], X17
    ADD  X15, X15, X21, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X15], X17
    LD4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X15], X17
    ADD  X15, X15, X21, ASR #0
    ST4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X15], X17
    LD4 { V18.2S, V19.2S, V20.2S, V21.2S }, [X15], X17
    ADD  X15, X15, X21
    ST4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X15], X17
    LD4 { V4.2S, V5.2S, V6.2S, V7.2S }, [X15], X17
    ADD  X15, X15, X21, LSR #0
    ST4 { V27.4H, V28.4H, V29.4H, V30.4H }, [X15], X17
    LD4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X15], X17
    ADD  X15, X15, X21, ASR #0
    ST4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X15], X17
    LD4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X15], X17
    ADD  X15, X15, X21, ASR #0
    ST4 { V7.H, V8.H, V9.H, V10.H }[0x1], [X15]
    LD4 { V12.H, V13.H, V14.H, V15.H }[0x5], [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V12.S, V13.S, V14.S, V15.S }[0x1], [X15]
    LD4 { V14.S, V15.S, V16.S, V17.S }[0x2], [X15]
    ADD  X15, X15, X21
    ST4 { V21.D, V22.D, V23.D, V24.D }[0x0], [X15]
    LD4 { V7.D, V8.D, V9.D, V10.D }[0x0], [X15]
    ADD  X15, X15, X21, LSR #0
    ST4 { V15.B, V16.B, V17.B, V18.B }[0x5], [X15]
    LD4 { V15.B, V16.B, V17.B, V18.B }[0x9], [X15]
    ADD  X15, X15, X21, ASR #0
    MOV  X23, X15
    ST4 { V14.H, V15.H, V16.H, V17.H }[0x5], [X23], #8
    MOV  X23, X15
    LD4 { V17.H, V18.H, V19.H, V20.H }[0x1], [X23], #8
    ADD  X15, X15, X21, ASR #0
    ST4 { V6.H, V7.H, V8.H, V9.H }[0x4], [X15], X17
    LD4 { V15.H, V16.H, V17.H, V18.H }[0x7], [X15], X17
    ADD  X15, X15, X21
    MOV  X23, X15
    ST4 { V22.S, V23.S, V24.S, V25.S }[0x3], [X23], #16
    MOV  X23, X15
    LD4 { V3.S, V4.S, V5.S, V6.S }[0x3], [X23], #16
    ADD  X15, X15, X21, LSR #0
    ST4 { V15.S, V16.S, V17.S, V18.S }[0x0], [X15], X17
    LD4 { V12.S, V13.S, V14.S, V15.S }[0x1], [X15], X17
    ADD  X15, X15, X21, LSR #0
    MOV  X23, X15
    ST4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X23], #32
    MOV  X23, X15
    LD4 { V12.D, V13.D, V14.D, V15.D }[0x1], [X23], #32
    ADD  X15, X15, X21
    ST4 { V12.D, V13.D, V14.D, V15.D }[0x1], [X15], X17
    LD4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X15], X17
    ADD  X15, X15, X21
    MOV  X23, X15
    ST4 { V29.B, V30.B, V31.B, V0.B }[0x2], [X23], #4
    MOV  X23, X15
    LD4 { V19.B, V20.B, V21.B, V22.B }[0x3], [X23], #4
    ADD  X15, X15, X21
    ST4 { V6.B, V7.B, V8.B, V9.B }[0x0], [X15], X17
    LD4 { V14.B, V15.B, V16.B, V17.B }[0x2], [X15], X17
    ADD  X15, X15, X21, LSR #0
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X2
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X6
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X7
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X12
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X18
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X19
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X24
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X25
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X26
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X27
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X28
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X16, X22, X29
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    MRS  X22, FPSR
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V0.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D0
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V1.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D1
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V2.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D2
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V3.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D3
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V4.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D4
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V5.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D5
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V6.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D6
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V7.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D7
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V8.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D8
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V9.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D9
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V10.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D10
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V11.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D11
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V12.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D12
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V13.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D13
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V14.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D14
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V15.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D15
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V16.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D16
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V17.D[1]
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D17
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V18.D[1]
    MOVZ  X16, #0x5a00, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D18
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V19.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D19
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V20.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D20
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V21.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D21
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V22.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D22
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V23.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D23
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V24.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D24
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V25.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D25
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V26.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D26
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V27.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D27
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V28.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D28
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V29.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D29
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V30.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D30
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, V31.D[1]
    MOVZ  X16, #0x0, LSL #0
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    FMOV  X22, D31
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X20, X16, X22
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X15
    FMOV  V0.D[1], X29
    FMOV  D1, X28
    FMOV  V1.D[1], X8
    FMOV  D2, X27
    FMOV  V2.D[1], X26
    FMOV  D3, X20
    FMOV  V3.D[1], X6
    FMOV  D4, X5
    FMOV  V4.D[1], X12
    FMOV  D5, X8
    FMOV  V5.D[1], X19
    FMOV  D6, X16
    FMOV  V6.D[1], X29
    FMOV  D7, X17
    FMOV  V7.D[1], X15
    FMOV  D8, X17
    FMOV  V8.D[1], X16
    FMOV  D9, X17
    FMOV  V9.D[1], X24
    FMOV  D10, X12
    FMOV  V10.D[1], X19
    FMOV  D11, X24
    FMOV  V11.D[1], X16
    FMOV  D12, X20
    FMOV  V12.D[1], X8
    FMOV  D13, X12
    FMOV  V13.D[1], X21
    FMOV  D14, X15
    FMOV  V14.D[1], X8
    FMOV  D15, X18
    FMOV  V15.D[1], X17
    FMOV  D16, X7
    FMOV  V16.D[1], X5
    FMOV  D17, X24
    FMOV  V17.D[1], X22
    FMOV  D18, X12
    FMOV  V18.D[1], X7
    FMOV  D19, X25
    FMOV  V19.D[1], X8
    FMOV  D20, X17
    FMOV  V20.D[1], X7
    FMOV  D21, X25
    FMOV  V21.D[1], X27
    FMOV  D22, X16
    FMOV  V22.D[1], X3
    FMOV  D23, X28
    FMOV  V23.D[1], X27
    FMOV  D24, X26
    FMOV  V24.D[1], X5
    FMOV  D25, X22
    FMOV  V25.D[1], X28
    FMOV  D26, X6
    FMOV  V26.D[1], X22
    FMOV  D27, X17
    FMOV  V27.D[1], X21
    FMOV  D28, X5
    FMOV  V28.D[1], X21
    FMOV  D29, X7
    FMOV  V29.D[1], X2
    FMOV  D30, X24
    FMOV  V30.D[1], X20
    FMOV  D31, X26
    FMOV  V31.D[1], X8
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X15, #0x2d00, LSL #0
    ADD  X25, X30, X15, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X25]
    LD4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X25]
    ADD  X25, X25, X22, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X25]
    LD4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X25]
    ADD  X25, X25, X22, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X25]
    LD4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X25]
    ADD  X25, X25, X22
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X25]
    LD4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X25]
    ADD  X25, X25, X22
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X25]
    LD4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X25]
    ADD  X25, X25, X22, ASR #0
    ST4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X25]
    LD4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X25]
    ADD  X25, X25, X22, ASR #0
    ST4 { V15.2S, V16.2S, V17.2S, V18.2S }, [X25]
    LD4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X25]
    ADD  X25, X25, X22
    ST4 { V28.4H, V29.4H, V30.4H, V31.4H }, [X25]
    LD4 { V24.4H, V25.4H, V26.4H, V27.4H }, [X25]
    ADD  X25, X25, X22, ASR #0
    ST4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X25]
    LD4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X25]
    ADD  X25, X25, X22, ASR #0
    MOV  X2, X25
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X2], #64
    MOV  X2, X25
    LD4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X2], #64
    ADD  X25, X25, X22
    MOV  X2, X25
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X2], #64
    MOV  X2, X25
    LD4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X2], #64
    ADD  X25, X25, X22, LSR #0
    MOV  X2, X25
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X2], #64
    MOV  X2, X25
    LD4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X2], #64
    ADD  X25, X25, X22
    MOV  X2, X25
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X2], #64
    MOV  X2, X25
    LD4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X2], #64
    ADD  X25, X25, X22, LSR #0
    MOV  X2, X25
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X2], #64
    MOV  X2, X25
    LD4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X2], #64
    ADD  X25, X25, X22, LSR #0
    MOV  X2, X25
    ST4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X2], #32
    MOV  X2, X25
    LD4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X2], #32
    ADD  X25, X25, X22, ASR #0
    MOV  X2, X25
    ST4 { V27.2S, V28.2S, V29.2S, V30.2S }, [X2], #32
    MOV  X2, X25
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X2], #32
    ADD  X25, X25, X22, ASR #0
    MOV  X2, X25
    ST4 { V1.4H, V2.4H, V3.4H, V4.4H }, [X2], #32
    MOV  X2, X25
    LD4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X2], #32
    ADD  X25, X25, X22
    MOV  X2, X25
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X2], #32
    MOV  X2, X25
    LD4 { V15.8B, V16.8B, V17.8B, V18.8B }, [X2], #32
    ADD  X25, X25, X22
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X25], X4
    LD4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X25], X4
    ADD  X25, X25, X22
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X25], X4
    LD4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X25], X4
    ADD  X25, X25, X22
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X25], X4
    LD4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X25], X4
    ADD  X25, X25, X22
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X25], X4
    LD4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X25], X4
    ADD  X25, X25, X22, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X25], X4
    LD4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X25], X4
    ADD  X25, X25, X22, LSR #0
    ST4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X25], X4
    LD4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X25], X4
    ADD  X25, X25, X22, LSR #0
    ST4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X25], X4
    LD4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X25], X4
    ADD  X25, X25, X22
    ST4 { V8.4H, V9.4H, V10.4H, V11.4H }, [X25], X4
    LD4 { V6.4H, V7.4H, V8.4H, V9.4H }, [X25], X4
    ADD  X25, X25, X22, ASR #0
    ST4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X25], X4
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X25], X4
    ADD  X25, X25, X22, ASR #0
    ST4 { V16.H, V17.H, V18.H, V19.H }[0x7], [X25]
    LD4 { V16.H, V17.H, V18.H, V19.H }[0x0], [X25]
    ADD  X25, X25, X22, LSR #0
    ST4 { V4.S, V5.S, V6.S, V7.S }[0x2], [X25]
    LD4 { V4.S, V5.S, V6.S, V7.S }[0x0], [X25]
    ADD  X25, X25, X22, ASR #0
    ST4 { V25.D, V26.D, V27.D, V28.D }[0x1], [X25]
    LD4 { V10.D, V11.D, V12.D, V13.D }[0x0], [X25]
    ADD  X25, X25, X22, ASR #0
    ST4 { V8.B, V9.B, V10.B, V11.B }[0xa], [X25]
    LD4 { V16.B, V17.B, V18.B, V19.B }[0x8], [X25]
    ADD  X25, X25, X22, LSR #0
    MOV  X2, X25
    ST4 { V16.H, V17.H, V18.H, V19.H }[0x4], [X2], #8
    MOV  X2, X25
    LD4 { V16.H, V17.H, V18.H, V19.H }[0x0], [X2], #8
    ADD  X25, X25, X22
    ST4 { V4.H, V5.H, V6.H, V7.H }[0x4], [X25], X4
    LD4 { V26.H, V27.H, V28.H, V29.H }[0x1], [X25], X4
    ADD  X25, X25, X22
    MOV  X2, X25
    ST4 { V16.S, V17.S, V18.S, V19.S }[0x0], [X2], #16
    MOV  X2, X25
    LD4 { V6.S, V7.S, V8.S, V9.S }[0x0], [X2], #16
    ADD  X25, X25, X22, ASR #0
    ST4 { V6.S, V7.S, V8.S, V9.S }[0x2], [X25], X4
    LD4 { V10.S, V11.S, V12.S, V13.S }[0x1], [X25], X4
    ADD  X25, X25, X22, LSR #0
    MOV  X2, X25
    ST4 { V11.D, V12.D, V13.D, V14.D }[0x0], [X2], #32
    MOV  X2, X25
    LD4 { V6.D, V7.D, V8.D, V9.D }[0x0], [X2], #32
    ADD  X25, X25, X22, ASR #0
    ST4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X25], X4
    LD4 { V11.D, V12.D, V13.D, V14.D }[0x1], [X25], X4
    ADD  X25, X25, X22
    MOV  X2, X25
    ST4 { V11.B, V12.B, V13.B, V14.B }[0x2], [X2], #4
    MOV  X2, X25
    LD4 { V23.B, V24.B, V25.B, V26.B }[0x9], [X2], #4
    ADD  X25, X25, X22
    ST4 { V23.B, V24.B, V25.B, V26.B }[0x7], [X25], X4
    LD4 { V24.B, V25.B, V26.B, V27.B }[0x7], [X25], X4
    ADD  X25, X25, X22, LSR #0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    MRS  X18, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D1
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D2
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D3
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D4
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D5
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D6
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D7
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D8
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D9
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D10
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D11
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D12
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D13
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D14
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D15
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D16
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D17
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D18
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D19
    MOVZ  X12, #0x0, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D20
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D21
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D22
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D23
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D24
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D25
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X12, #0xa500, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D26
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D27
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D28
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D29
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D30
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D31
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X28, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    FMOV  D1, X19
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X5
    FMOV  D3, X12
    FMOV  V3.D[1], X20
    FMOV  D4, X8
    FMOV  V4.D[1], X17
    FMOV  D5, X24
    FMOV  V5.D[1], X16
    FMOV  D6, X17
    FMOV  V6.D[1], X7
    FMOV  D7, X5
    FMOV  V7.D[1], X29
    FMOV  D8, X21
    FMOV  V8.D[1], X7
    FMOV  D9, X2
    FMOV  V9.D[1], X5
    FMOV  D10, X6
    FMOV  V10.D[1], X5
    FMOV  D11, X18
    FMOV  V11.D[1], X29
    FMOV  D12, X24
    FMOV  V12.D[1], X12
    FMOV  D13, X26
    FMOV  V13.D[1], X15
    FMOV  D14, X5
    FMOV  V14.D[1], X17
    FMOV  D15, X2
    FMOV  V15.D[1], X19
    FMOV  D16, X20
    FMOV  V16.D[1], X5
    FMOV  D17, X18
    FMOV  V17.D[1], X15
    FMOV  D18, X17
    FMOV  V18.D[1], X25
    FMOV  D19, X2
    FMOV  V19.D[1], X23
    FMOV  D20, X3
    FMOV  V20.D[1], X19
    FMOV  D21, X12
    FMOV  V21.D[1], X21
    FMOV  D22, X27
    FMOV  V22.D[1], X25
    FMOV  D23, X4
    FMOV  V23.D[1], X18
    FMOV  D24, X26
    FMOV  V24.D[1], X27
    FMOV  D25, X27
    FMOV  V25.D[1], X5
    FMOV  D26, X26
    FMOV  V26.D[1], X19
    FMOV  D27, X25
    FMOV  V27.D[1], X27
    FMOV  D28, X29
    FMOV  V28.D[1], X27
    FMOV  D29, X17
    FMOV  V29.D[1], X5
    FMOV  D30, X5
    FMOV  V30.D[1], X24
    FMOV  D31, X2
    FMOV  V31.D[1], X29
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X2, #0x0, LSL #0
    ADD  X3, X30, X2, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X3]
    LD4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X3]
    ADD  X3, X3, X21, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X3]
    LD4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X3]
    ADD  X3, X3, X21
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X3]
    LD4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X3]
    ADD  X3, X3, X21, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X3]
    LD4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X3]
    ADD  X3, X3, X21, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X3]
    LD4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X3]
    ADD  X3, X3, X21, ASR #0
    ST4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X3]
    LD4 { V10.4H, V11.4H, V12.4H, V13.4H }, [X3]
    ADD  X3, X3, X21, ASR #0
    ST4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X3]
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X3]
    ADD  X3, X3, X21
    ST4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X3]
    LD4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X3]
    ADD  X3, X3, X21, ASR #0
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X3]
    LD4 { V27.8B, V28.8B, V29.8B, V30.8B }, [X3]
    ADD  X3, X3, X21, LSR #0
    MOV  X28, X3
    ST4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X28], #64
    MOV  X28, X3
    LD4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X28], #64
    ADD  X3, X3, X21
    MOV  X28, X3
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X28], #64
    MOV  X28, X3
    LD4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X28], #64
    ADD  X3, X3, X21, ASR #0
    MOV  X28, X3
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X28], #64
    MOV  X28, X3
    LD4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X28], #64
    ADD  X3, X3, X21, LSR #0
    MOV  X28, X3
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X28], #64
    MOV  X28, X3
    LD4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X28], #64
    ADD  X3, X3, X21, LSR #0
    MOV  X28, X3
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X28], #64
    MOV  X28, X3
    LD4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X28], #64
    ADD  X3, X3, X21, ASR #0
    MOV  X28, X3
    ST4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X28], #32
    MOV  X28, X3
    LD4 { V18.2S, V19.2S, V20.2S, V21.2S }, [X28], #32
    ADD  X3, X3, X21, ASR #0
    MOV  X28, X3
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X28], #32
    MOV  X28, X3
    LD4 { V28.2S, V29.2S, V30.2S, V31.2S }, [X28], #32
    ADD  X3, X3, X21
    MOV  X28, X3
    ST4 { V28.4H, V29.4H, V30.4H, V31.4H }, [X28], #32
    MOV  X28, X3
    LD4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X28], #32
    ADD  X3, X3, X21, ASR #0
    MOV  X28, X3
    ST4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X28], #32
    MOV  X28, X3
    LD4 { V20.8B, V21.8B, V22.8B, V23.8B }, [X28], #32
    ADD  X3, X3, X21, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X3], X19
    LD4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X3], X19
    ADD  X3, X3, X21
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X3], X19
    LD4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X3], X19
    ADD  X3, X3, X21, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X3], X19
    LD4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X3], X19
    ADD  X3, X3, X21
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X3], X19
    LD4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X3], X19
    ADD  X3, X3, X21, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X3], X19
    LD4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X3], X19
    ADD  X3, X3, X21, ASR #0
    ST4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X3], X19
    LD4 { V9.4H, V10.4H, V11.4H, V12.4H }, [X3], X19
    ADD  X3, X3, X21, LSR #0
    ST4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X3], X19
    LD4 { V24.2S, V25.2S, V26.2S, V27.2S }, [X3], X19
    ADD  X3, X3, X21
    ST4 { V1.4H, V2.4H, V3.4H, V4.4H }, [X3], X19
    LD4 { V27.4H, V28.4H, V29.4H, V30.4H }, [X3], X19
    ADD  X3, X3, X21
    ST4 { V19.8B, V20.8B, V21.8B, V22.8B }, [X3], X19
    LD4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X3], X19
    ADD  X3, X3, X21, LSR #0
    ST4 { V29.H, V30.H, V31.H, V0.H }[0x0], [X3]
    LD4 { V13.H, V14.H, V15.H, V16.H }[0x1], [X3]
    ADD  X3, X3, X21
    ST4 { V12.S, V13.S, V14.S, V15.S }[0x2], [X3]
    LD4 { V19.S, V20.S, V21.S, V22.S }[0x2], [X3]
    ADD  X3, X3, X21, ASR #0
    ST4 { V10.D, V11.D, V12.D, V13.D }[0x1], [X3]
    LD4 { V31.D, V0.D, V1.D, V2.D }[0x0], [X3]
    ADD  X3, X3, X21, LSR #0
    ST4 { V24.B, V25.B, V26.B, V27.B }[0xe], [X3]
    LD4 { V12.B, V13.B, V14.B, V15.B }[0x4], [X3]
    ADD  X3, X3, X21
    MOV  X28, X3
    ST4 { V17.H, V18.H, V19.H, V20.H }[0x3], [X28], #8
    MOV  X28, X3
    LD4 { V7.H, V8.H, V9.H, V10.H }[0x2], [X28], #8
    ADD  X3, X3, X21
    ST4 { V20.H, V21.H, V22.H, V23.H }[0x5], [X3], X19
    LD4 { V23.H, V24.H, V25.H, V26.H }[0x6], [X3], X19
    ADD  X3, X3, X21, ASR #0
    MOV  X28, X3
    ST4 { V7.S, V8.S, V9.S, V10.S }[0x2], [X28], #16
    MOV  X28, X3
    LD4 { V4.S, V5.S, V6.S, V7.S }[0x0], [X28], #16
    ADD  X3, X3, X21
    ST4 { V16.S, V17.S, V18.S, V19.S }[0x3], [X3], X19
    LD4 { V13.S, V14.S, V15.S, V16.S }[0x3], [X3], X19
    ADD  X3, X3, X21
    MOV  X28, X3
    ST4 { V4.D, V5.D, V6.D, V7.D }[0x1], [X28], #32
    MOV  X28, X3
    LD4 { V11.D, V12.D, V13.D, V14.D }[0x0], [X28], #32
    ADD  X3, X3, X21, LSR #0
    ST4 { V12.D, V13.D, V14.D, V15.D }[0x0], [X3], X19
    LD4 { V11.D, V12.D, V13.D, V14.D }[0x0], [X3], X19
    ADD  X3, X3, X21
    MOV  X28, X3
    ST4 { V23.B, V24.B, V25.B, V26.B }[0xc], [X28], #4
    MOV  X28, X3
    LD4 { V14.B, V15.B, V16.B, V17.B }[0x8], [X28], #4
    ADD  X3, X3, X21
    ST4 { V2.B, V3.B, V4.B, V5.B }[0x5], [X3], X19
    LD4 { V27.B, V28.B, V29.B, V30.B }[0xb], [X3], X19
    ADD  X3, X3, X21
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X24, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MRS  X26, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D0
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D1
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D2
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D3
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D4
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D5
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D6
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D7
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D8
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D9
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D10
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D11
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D12
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D13
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D14
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a00, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D15
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a00, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D16
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X24, #0x5a00, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D17
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D18
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D19
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D20
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D21
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D22
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D23
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D24
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D25
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D26
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a00, LSL #16
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D27
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a00, LSL #16
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D28
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a00, LSL #16
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D29
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a00, LSL #16
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D30
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
    FMOV  X26, D31
    MOVZ  X24, #0x0, LSL #0
    SUB  X7, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    FMOV  V1.D[1], X28
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X29
    FMOV  V3.D[1], X19
    FMOV  D4, X27
    FMOV  V4.D[1], X19
    FMOV  D5, X18
    FMOV  V5.D[1], X21
    FMOV  D6, X20
    FMOV  V6.D[1], X17
    FMOV  D7, X15
    FMOV  V7.D[1], X12
    FMOV  D8, X21
    FMOV  V8.D[1], X19
    FMOV  D9, X22
    FMOV  V9.D[1], X3
    FMOV  D10, X6
    FMOV  V10.D[1], X27
    FMOV  D11, X7
    FMOV  V11.D[1], X15
    FMOV  D12, X8
    FMOV  V12.D[1], X22
    FMOV  D13, X12
    FMOV  V13.D[1], X28
    FMOV  D14, X8
    FMOV  V14.D[1], X5
    FMOV  D15, X28
    FMOV  V15.D[1], X26
    FMOV  D16, X25
    FMOV  V16.D[1], X23
    FMOV  D17, X27
    FMOV  V17.D[1], X12
    FMOV  D18, X28
    FMOV  V18.D[1], X28
    FMOV  D19, X21
    FMOV  V19.D[1], X8
    FMOV  D20, X12
    FMOV  V20.D[1], X2
    FMOV  D21, X16
    FMOV  V21.D[1], X19
    FMOV  D22, X16
    FMOV  V22.D[1], X12
    FMOV  D23, X22
    FMOV  V23.D[1], X3
    FMOV  D24, X15
    FMOV  V24.D[1], X24
    FMOV  D25, X16
    FMOV  V25.D[1], X6
    FMOV  D26, X21
    FMOV  V26.D[1], X18
    FMOV  D27, X15
    FMOV  V27.D[1], X4
    FMOV  D28, X26
    FMOV  V28.D[1], X8
    FMOV  D29, X16
    FMOV  V29.D[1], X5
    FMOV  D30, X15
    FMOV  V30.D[1], X28
    FMOV  D31, X23
    FMOV  V31.D[1], X29
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X7, #0x500, LSL #0
    ADD  X6, X30, X7
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X6]
    LD4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X6]
    ADD  X6, X6, X8, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X6]
    LD4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X6]
    ADD  X6, X6, X8
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X6]
    LD4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X6]
    ADD  X6, X6, X8, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X6]
    LD4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X6]
    ADD  X6, X6, X8
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X6]
    LD4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X6]
    ADD  X6, X6, X8, ASR #0
    ST4 { V2.4H, V3.4H, V4.4H, V5.4H }, [X6]
    LD4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X6]
    ADD  X6, X6, X8, LSR #0
    ST4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X6]
    LD4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X6]
    ADD  X6, X6, X8
    ST4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X6]
    LD4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X6]
    ADD  X6, X6, X8
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X6]
    LD4 { V0.8B, V1.8B, V2.8B, V3.8B }, [X6]
    ADD  X6, X6, X8, ASR #0
    MOV  X20, X6
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X20], #64
    MOV  X20, X6
    LD4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X20], #64
    ADD  X6, X6, X8, ASR #0
    MOV  X20, X6
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X20], #64
    MOV  X20, X6
    LD4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X20], #64
    ADD  X6, X6, X8
    MOV  X20, X6
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X20], #64
    MOV  X20, X6
    LD4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X20], #64
    ADD  X6, X6, X8, ASR #0
    MOV  X20, X6
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X20], #64
    MOV  X20, X6
    LD4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X20], #64
    ADD  X6, X6, X8, ASR #0
    MOV  X20, X6
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X20], #64
    MOV  X20, X6
    LD4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X20], #64
    ADD  X6, X6, X8, ASR #0
    MOV  X20, X6
    ST4 { V19.2S, V20.2S, V21.2S, V22.2S }, [X20], #32
    MOV  X20, X6
    LD4 { V28.4H, V29.4H, V30.4H, V31.4H }, [X20], #32
    ADD  X6, X6, X8, ASR #0
    MOV  X20, X6
    ST4 { V24.2S, V25.2S, V26.2S, V27.2S }, [X20], #32
    MOV  X20, X6
    LD4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X20], #32
    ADD  X6, X6, X8, ASR #0
    MOV  X20, X6
    ST4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X20], #32
    MOV  X20, X6
    LD4 { V5.4H, V6.4H, V7.4H, V8.4H }, [X20], #32
    ADD  X6, X6, X8
    MOV  X20, X6
    ST4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X20], #32
    MOV  X20, X6
    LD4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X20], #32
    ADD  X6, X6, X8, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X6], X22
    LD4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X6], X22
    ADD  X6, X6, X8
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X6], X22
    LD4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X6], X22
    ADD  X6, X6, X8
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X6], X22
    LD4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X6], X22
    ADD  X6, X6, X8
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X6], X22
    LD4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X6], X22
    ADD  X6, X6, X8, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X6], X22
    LD4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X6], X22
    ADD  X6, X6, X8, ASR #0
    ST4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X6], X22
    LD4 { V12.8B, V13.8B, V14.8B, V15.8B }, [X6], X22
    ADD  X6, X6, X8, LSR #0
    ST4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X6], X22
    LD4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X6], X22
    ADD  X6, X6, X8, LSR #0
    ST4 { V1.4H, V2.4H, V3.4H, V4.4H }, [X6], X22
    LD4 { V1.4H, V2.4H, V3.4H, V4.4H }, [X6], X22
    ADD  X6, X6, X8, ASR #0
    ST4 { V1.8B, V2.8B, V3.8B, V4.8B }, [X6], X22
    LD4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X6], X22
    ADD  X6, X6, X8, LSR #0
    ST4 { V15.H, V16.H, V17.H, V18.H }[0x4], [X6]
    LD4 { V15.H, V16.H, V17.H, V18.H }[0x2], [X6]
    ADD  X6, X6, X8
    ST4 { V8.S, V9.S, V10.S, V11.S }[0x1], [X6]
    LD4 { V1.S, V2.S, V3.S, V4.S }[0x0], [X6]
    ADD  X6, X6, X8
    ST4 { V15.D, V16.D, V17.D, V18.D }[0x1], [X6]
    LD4 { V30.D, V31.D, V0.D, V1.D }[0x1], [X6]
    ADD  X6, X6, X8, ASR #0
    ST4 { V5.B, V6.B, V7.B, V8.B }[0x1], [X6]
    LD4 { V23.B, V24.B, V25.B, V26.B }[0x3], [X6]
    ADD  X6, X6, X8, LSR #0
    MOV  X20, X6
    ST4 { V30.H, V31.H, V0.H, V1.H }[0x4], [X20], #8
    MOV  X20, X6
    LD4 { V30.H, V31.H, V0.H, V1.H }[0x7], [X20], #8
    ADD  X6, X6, X8, ASR #0
    ST4 { V30.H, V31.H, V0.H, V1.H }[0x4], [X6], X22
    LD4 { V8.H, V9.H, V10.H, V11.H }[0x6], [X6], X22
    ADD  X6, X6, X8, ASR #0
    MOV  X20, X6
    ST4 { V14.S, V15.S, V16.S, V17.S }[0x2], [X20], #16
    MOV  X20, X6
    LD4 { V7.S, V8.S, V9.S, V10.S }[0x0], [X20], #16
    ADD  X6, X6, X8, ASR #0
    ST4 { V28.S, V29.S, V30.S, V31.S }[0x3], [X6], X22
    LD4 { V28.S, V29.S, V30.S, V31.S }[0x1], [X6], X22
    ADD  X6, X6, X8, ASR #0
    MOV  X20, X6
    ST4 { V28.D, V29.D, V30.D, V31.D }[0x1], [X20], #32
    MOV  X20, X6
    LD4 { V8.D, V9.D, V10.D, V11.D }[0x0], [X20], #32
    ADD  X6, X6, X8, ASR #0
    ST4 { V23.D, V24.D, V25.D, V26.D }[0x0], [X6], X22
    LD4 { V23.D, V24.D, V25.D, V26.D }[0x1], [X6], X22
    ADD  X6, X6, X8
    MOV  X20, X6
    ST4 { V7.B, V8.B, V9.B, V10.B }[0x7], [X20], #4
    MOV  X20, X6
    LD4 { V28.B, V29.B, V30.B, V31.B }[0xd], [X20], #4
    ADD  X6, X6, X8
    ST4 { V13.B, V14.B, V15.B, V16.B }[0xc], [X6], X22
    LD4 { V7.B, V8.B, V9.B, V10.B }[0xb], [X6], X22
    ADD  X6, X6, X8, ASR #0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MRS  X18, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D1
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D2
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D3
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D4
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D5
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D6
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D7
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D8
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D9
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D10
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D11
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D12
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D13
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D14
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D15
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D16
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D17
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D18
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D19
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D20
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D21
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D22
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D23
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D24
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D25
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D26
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X29, #0xa5, LSL #0
    MOVK  X29, #0xa5, LSL #32
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D27
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #32
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D28
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D29
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D30
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D31
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    SUB  X17, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X22
    FMOV  V0.D[1], X24
    FMOV  D1, X28
    FMOV  V1.D[1], X23
    FMOV  D2, X26
    FMOV  V2.D[1], X19
    FMOV  D3, X27
    FMOV  V3.D[1], X29
    FMOV  D4, X4
    FMOV  V4.D[1], X19
    FMOV  D5, X18
    FMOV  V5.D[1], X19
    FMOV  D6, X15
    FMOV  V6.D[1], X28
    FMOV  D7, X23
    FMOV  V7.D[1], X7
    FMOV  D8, X15
    FMOV  V8.D[1], X16
    FMOV  D9, X3
    FMOV  V9.D[1], X27
    FMOV  D10, X5
    FMOV  V10.D[1], X28
    FMOV  D11, X25
    FMOV  V11.D[1], X15
    FMOV  D12, X29
    FMOV  V12.D[1], X12
    FMOV  D13, X8
    FMOV  V13.D[1], X24
    FMOV  D14, X19
    FMOV  V14.D[1], X5
    FMOV  D15, X25
    FMOV  V15.D[1], X7
    FMOV  D16, X2
    FMOV  V16.D[1], X25
    FMOV  D17, X12
    FMOV  V17.D[1], X5
    FMOV  D18, X6
    FMOV  V18.D[1], X3
    FMOV  D19, X6
    FMOV  V19.D[1], X2
    FMOV  D20, X8
    FMOV  V20.D[1], X7
    FMOV  D21, X15
    FMOV  V21.D[1], X3
    FMOV  D22, X5
    FMOV  V22.D[1], X16
    FMOV  D23, X21
    FMOV  V23.D[1], X16
    FMOV  D24, X19
    FMOV  V24.D[1], X25
    FMOV  D25, X7
    FMOV  V25.D[1], X18
    FMOV  D26, X12
    FMOV  V26.D[1], X15
    FMOV  D27, X24
    FMOV  V27.D[1], X23
    FMOV  D28, X26
    FMOV  V28.D[1], X6
    FMOV  D29, X8
    FMOV  V29.D[1], X21
    FMOV  D30, X5
    FMOV  V30.D[1], X19
    FMOV  D31, X4
    FMOV  V31.D[1], X3
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X16, #0xa00, LSL #0
    ADD  X29, X30, X16, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X29]
    LD4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X29]
    ADD  X29, X29, X22, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X29]
    LD4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X29]
    ADD  X29, X29, X22
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X29]
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X29]
    ADD  X29, X29, X22, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X29]
    LD4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X29]
    ADD  X29, X29, X22, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X29]
    LD4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X29]
    ADD  X29, X29, X22, LSR #0
    ST4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X29]
    LD4 { V4.2S, V5.2S, V6.2S, V7.2S }, [X29]
    ADD  X29, X29, X22, LSR #0
    ST4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X29]
    LD4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X29]
    ADD  X29, X29, X22
    ST4 { V1.4H, V2.4H, V3.4H, V4.4H }, [X29]
    LD4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X29]
    ADD  X29, X29, X22, LSR #0
    ST4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X29]
    LD4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X29]
    ADD  X29, X29, X22, ASR #0
    MOV  X12, X29
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X12], #64
    MOV  X12, X29
    LD4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X12], #64
    ADD  X29, X29, X22, ASR #0
    MOV  X12, X29
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X12], #64
    MOV  X12, X29
    LD4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X12], #64
    ADD  X29, X29, X22, ASR #0
    MOV  X12, X29
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X12], #64
    MOV  X12, X29
    LD4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X12], #64
    ADD  X29, X29, X22
    MOV  X12, X29
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X12], #64
    MOV  X12, X29
    LD4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X12], #64
    ADD  X29, X29, X22, LSR #0
    MOV  X12, X29
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X12], #64
    MOV  X12, X29
    LD4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X12], #64
    ADD  X29, X29, X22, ASR #0
    MOV  X12, X29
    ST4 { V22.4H, V23.4H, V24.4H, V25.4H }, [X12], #32
    MOV  X12, X29
    LD4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X12], #32
    ADD  X29, X29, X22, ASR #0
    MOV  X12, X29
    ST4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X12], #32
    MOV  X12, X29
    LD4 { V1.2S, V2.2S, V3.2S, V4.2S }, [X12], #32
    ADD  X29, X29, X22, LSR #0
    MOV  X12, X29
    ST4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X12], #32
    MOV  X12, X29
    LD4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X12], #32
    ADD  X29, X29, X22, LSR #0
    MOV  X12, X29
    ST4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X12], #32
    MOV  X12, X29
    LD4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X12], #32
    ADD  X29, X29, X22, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X29], X17
    LD4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X29], X17
    ADD  X29, X29, X22
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X29], X17
    LD4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X29], X17
    ADD  X29, X29, X22
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X29], X17
    LD4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X29], X17
    ADD  X29, X29, X22, LSR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X29], X17
    LD4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X29], X17
    ADD  X29, X29, X22, LSR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X29], X17
    LD4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X29], X17
    ADD  X29, X29, X22, LSR #0
    ST4 { V22.4H, V23.4H, V24.4H, V25.4H }, [X29], X17
    LD4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X29], X17
    ADD  X29, X29, X22
    ST4 { V4.2S, V5.2S, V6.2S, V7.2S }, [X29], X17
    LD4 { V0.2S, V1.2S, V2.2S, V3.2S }, [X29], X17
    ADD  X29, X29, X22
    ST4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X29], X17
    LD4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X29], X17
    ADD  X29, X29, X22, ASR #0
    ST4 { V0.8B, V1.8B, V2.8B, V3.8B }, [X29], X17
    LD4 { V12.8B, V13.8B, V14.8B, V15.8B }, [X29], X17
    ADD  X29, X29, X22
    ST4 { V13.H, V14.H, V15.H, V16.H }[0x4], [X29]
    LD4 { V2.H, V3.H, V4.H, V5.H }[0x4], [X29]
    ADD  X29, X29, X22, ASR #0
    ST4 { V21.S, V22.S, V23.S, V24.S }[0x0], [X29]
    LD4 { V18.S, V19.S, V20.S, V21.S }[0x1], [X29]
    ADD  X29, X29, X22, ASR #0
    ST4 { V18.D, V19.D, V20.D, V21.D }[0x0], [X29]
    LD4 { V29.D, V30.D, V31.D, V0.D }[0x0], [X29]
    ADD  X29, X29, X22, LSR #0
    ST4 { V23.B, V24.B, V25.B, V26.B }[0xf], [X29]
    LD4 { V11.B, V12.B, V13.B, V14.B }[0x3], [X29]
    ADD  X29, X29, X22, ASR #0
    MOV  X12, X29
    ST4 { V2.H, V3.H, V4.H, V5.H }[0x1], [X12], #8
    MOV  X12, X29
    LD4 { V29.H, V30.H, V31.H, V0.H }[0x5], [X12], #8
    ADD  X29, X29, X22
    ST4 { V11.H, V12.H, V13.H, V14.H }[0x2], [X29], X17
    LD4 { V2.H, V3.H, V4.H, V5.H }[0x5], [X29], X17
    ADD  X29, X29, X22, ASR #0
    MOV  X12, X29
    ST4 { V2.S, V3.S, V4.S, V5.S }[0x2], [X12], #16
    MOV  X12, X29
    LD4 { V2.S, V3.S, V4.S, V5.S }[0x2], [X12], #16
    ADD  X29, X29, X22
    ST4 { V2.S, V3.S, V4.S, V5.S }[0x0], [X29], X17
    LD4 { V9.S, V10.S, V11.S, V12.S }[0x0], [X29], X17
    ADD  X29, X29, X22, LSR #0
    MOV  X12, X29
    ST4 { V11.D, V12.D, V13.D, V14.D }[0x1], [X12], #32
    MOV  X12, X29
    LD4 { V1.D, V2.D, V3.D, V4.D }[0x0], [X12], #32
    ADD  X29, X29, X22, LSR #0
    ST4 { V16.D, V17.D, V18.D, V19.D }[0x1], [X29], X17
    LD4 { V19.D, V20.D, V21.D, V22.D }[0x1], [X29], X17
    ADD  X29, X29, X22, LSR #0
    MOV  X12, X29
    ST4 { V9.B, V10.B, V11.B, V12.B }[0xd], [X12], #4
    MOV  X12, X29
    LD4 { V5.B, V6.B, V7.B, V8.B }[0x5], [X12], #4
    ADD  X29, X29, X22, LSR #0
    ST4 { V2.B, V3.B, V4.B, V5.B }[0x5], [X29], X17
    LD4 { V17.B, V18.B, V19.B, V20.B }[0x9], [X29], X17
    ADD  X29, X29, X22, LSR #0
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X20, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadStoreP07_TestFail
    MRS  X27, FPSR
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D0
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D1
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D2
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D3
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D4
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D5
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D6
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D7
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D8
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D9
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D10
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D11
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D12
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D13
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D14
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D15
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D16
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D17
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D18
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D19
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X20, #0x5a00, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D20
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D21
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D22
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D23
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D24
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D25
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D26
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D27
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D28
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D29
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D30
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X20, #0x0, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D31
    MOVZ  X20, #0x5a5a, LSL #0
    MOVK  X20, #0x5a5a, LSL #16
    MOVK  X20, #0x5a5a, LSL #32
    MOVK  X20, #0x5a5a, LSL #48
    SUB  X15, X20, X27
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X12
    FMOV  D3, X3
    FMOV  V3.D[1], X15
    FMOV  D4, X7
    FMOV  V4.D[1], X4
    FMOV  D5, X19
    FMOV  V5.D[1], X2
    FMOV  D6, X15
    FMOV  V6.D[1], X18
    FMOV  D7, X15
    FMOV  V7.D[1], X3
    FMOV  D8, X8
    FMOV  V8.D[1], X26
    FMOV  D9, X4
    FMOV  V9.D[1], X25
    FMOV  D10, X6
    FMOV  V10.D[1], X18
    FMOV  D11, X7
    FMOV  V11.D[1], X15
    FMOV  D12, X4
    FMOV  V12.D[1], X3
    FMOV  D13, X22
    FMOV  V13.D[1], X22
    FMOV  D14, X18
    FMOV  V14.D[1], X26
    FMOV  D15, X8
    FMOV  V15.D[1], X3
    FMOV  D16, X19
    FMOV  V16.D[1], X2
    FMOV  D17, X29
    FMOV  V17.D[1], X29
    FMOV  D18, X27
    FMOV  V18.D[1], X5
    FMOV  D19, X20
    FMOV  V19.D[1], X2
    FMOV  D20, X19
    FMOV  V20.D[1], X3
    FMOV  D21, X3
    FMOV  V21.D[1], X17
    FMOV  D22, X2
    FMOV  V22.D[1], X25
    FMOV  D23, X23
    FMOV  V23.D[1], X16
    FMOV  D24, X23
    FMOV  V24.D[1], X19
    FMOV  D25, X22
    FMOV  V25.D[1], X6
    FMOV  D26, X22
    FMOV  V26.D[1], X25
    FMOV  D27, X25
    FMOV  V27.D[1], X18
    FMOV  D28, X8
    FMOV  V28.D[1], X3
    FMOV  D29, X25
    FMOV  V29.D[1], X27
    FMOV  D30, X5
    FMOV  V30.D[1], X6
    FMOV  D31, X20
    FMOV  V31.D[1], X19
    MOVZ  X19, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X2, #0xf00, LSL #0
    ADD  X21, X30, X2, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X21]
    LD4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X21]
    ADD  X21, X21, X23, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X21]
    LD4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X21]
    ADD  X21, X21, X23, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X21]
    LD4 { V18.2D, V19.2D, V20.2D, V21.2D }, [X21]
    ADD  X21, X21, X23, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X21]
    LD4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X21]
    ADD  X21, X21, X23, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X21]
    LD4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X21]
    ADD  X21, X21, X23, ASR #0
    ST4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X21]
    LD4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X21]
    ADD  X21, X21, X23, LSR #0
    ST4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X21]
    LD4 { V0.2S, V1.2S, V2.2S, V3.2S }, [X21]
    ADD  X21, X21, X23
    ST4 { V0.4H, V1.4H, V2.4H, V3.4H }, [X21]
    LD4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X21]
    ADD  X21, X21, X23, LSR #0
    ST4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X21]
    LD4 { V22.8B, V23.8B, V24.8B, V25.8B }, [X21]
    ADD  X21, X21, X23
    MOV  X29, X21
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X29], #64
    MOV  X29, X21
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X29], #64
    ADD  X21, X21, X23
    MOV  X29, X21
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X29], #64
    MOV  X29, X21
    LD4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X29], #64
    ADD  X21, X21, X23, LSR #0
    MOV  X29, X21
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X29], #64
    MOV  X29, X21
    LD4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X29], #64
    ADD  X21, X21, X23, LSR #0
    MOV  X29, X21
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X29], #64
    MOV  X29, X21
    LD4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X29], #64
    ADD  X21, X21, X23, LSR #0
    MOV  X29, X21
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X29], #64
    MOV  X29, X21
    LD4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X29], #64
    ADD  X21, X21, X23, ASR #0
    MOV  X29, X21
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X29], #32
    MOV  X29, X21
    LD4 { V0.2S, V1.2S, V2.2S, V3.2S }, [X29], #32
    ADD  X21, X21, X23, ASR #0
    MOV  X29, X21
    ST4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X29], #32
    MOV  X29, X21
    LD4 { V22.2S, V23.2S, V24.2S, V25.2S }, [X29], #32
    ADD  X21, X21, X23, ASR #0
    MOV  X29, X21
    ST4 { V22.4H, V23.4H, V24.4H, V25.4H }, [X29], #32
    MOV  X29, X21
    LD4 { V29.4H, V30.4H, V31.4H, V0.4H }, [X29], #32
    ADD  X21, X21, X23
    MOV  X29, X21
    ST4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X29], #32
    MOV  X29, X21
    LD4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X29], #32
    ADD  X21, X21, X23, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X21], X19
    LD4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X21], X19
    ADD  X21, X21, X23
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X21], X19
    LD4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X21], X19
    ADD  X21, X21, X23, LSR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X21], X19
    LD4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X21], X19
    ADD  X21, X21, X23, ASR #0
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X21], X19
    LD4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X21], X19
    ADD  X21, X21, X23, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X21], X19
    LD4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X21], X19
    ADD  X21, X21, X23, ASR #0
    ST4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X21], X19
    LD4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X21], X19
    ADD  X21, X21, X23, ASR #0
    ST4 { V30.2S, V31.2S, V0.2S, V1.2S }, [X21], X19
    LD4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X21], X19
    ADD  X21, X21, X23
    ST4 { V24.4H, V25.4H, V26.4H, V27.4H }, [X21], X19
    LD4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X21], X19
    ADD  X21, X21, X23, ASR #0
    ST4 { V8.8B, V9.8B, V10.8B, V11.8B }, [X21], X19
    LD4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X21], X19
    ADD  X21, X21, X23, ASR #0
    ST4 { V2.H, V3.H, V4.H, V5.H }[0x1], [X21]
    LD4 { V1.H, V2.H, V3.H, V4.H }[0x1], [X21]
    ADD  X21, X21, X23, ASR #0
    ST4 { V21.S, V22.S, V23.S, V24.S }[0x1], [X21]
    LD4 { V21.S, V22.S, V23.S, V24.S }[0x2], [X21]
    ADD  X21, X21, X23
    ST4 { V1.D, V2.D, V3.D, V4.D }[0x1], [X21]
    LD4 { V29.D, V30.D, V31.D, V0.D }[0x1], [X21]
    ADD  X21, X21, X23
    ST4 { V29.B, V30.B, V31.B, V0.B }[0x7], [X21]
    LD4 { V30.B, V31.B, V0.B, V1.B }[0x1], [X21]
    ADD  X21, X21, X23, ASR #0
    MOV  X29, X21
    ST4 { V30.H, V31.H, V0.H, V1.H }[0x0], [X29], #8
    MOV  X29, X21
    LD4 { V1.H, V2.H, V3.H, V4.H }[0x3], [X29], #8
    ADD  X21, X21, X23, ASR #0
    ST4 { V21.H, V22.H, V23.H, V24.H }[0x3], [X21], X19
    LD4 { V29.H, V30.H, V31.H, V0.H }[0x3], [X21], X19
    ADD  X21, X21, X23, LSR #0
    MOV  X29, X21
    ST4 { V0.S, V1.S, V2.S, V3.S }[0x0], [X29], #16
    MOV  X29, X21
    LD4 { V21.S, V22.S, V23.S, V24.S }[0x0], [X29], #16
    ADD  X21, X21, X23
    ST4 { V21.S, V22.S, V23.S, V24.S }[0x3], [X21], X19
    LD4 { V30.S, V31.S, V0.S, V1.S }[0x1], [X21], X19
    ADD  X21, X21, X23, ASR #0
    MOV  X29, X21
    ST4 { V24.D, V25.D, V26.D, V27.D }[0x0], [X29], #32
    MOV  X29, X21
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x1], [X29], #32
    ADD  X21, X21, X23
    ST4 { V8.D, V9.D, V10.D, V11.D }[0x0], [X21], X19
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x1], [X21], X19
    ADD  X21, X21, X23, LSR #0
    MOV  X29, X21
    ST4 { V29.B, V30.B, V31.B, V0.B }[0xe], [X29], #4
    MOV  X29, X21
    LD4 { V7.B, V8.B, V9.B, V10.B }[0xc], [X29], #4
    ADD  X21, X21, X23
    ST4 { V21.B, V22.B, V23.B, V24.B }[0x9], [X21], X19
    LD4 { V30.B, V31.B, V0.B, V1.B }[0xc], [X21], X19
    ADD  X21, X21, X23, LSR #0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X5
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X24, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MRS  X4, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa5, LSL #32
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa5, LSL #32
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D1
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D2
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D3
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D4
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D5
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D6
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa500, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D7
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D8
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D9
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D10
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D11
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D12
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D13
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D14
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D15
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D16
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D17
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D18
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D19
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D20
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D21
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D22
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D23
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D24
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D25
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D26
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D27
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D28
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D29
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa5, LSL #32
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D30
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0xa5, LSL #32
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
    FMOV  X4, D31
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    SUB  X28, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    FMOV  D1, X26
    FMOV  V1.D[1], X7
    FMOV  D2, X25
    FMOV  V2.D[1], X28
    FMOV  D3, X15
    FMOV  V3.D[1], X27
    FMOV  D4, X12
    FMOV  V4.D[1], X20
    FMOV  D5, X25
    FMOV  V5.D[1], X5
    FMOV  D6, X4
    FMOV  V6.D[1], X6
    FMOV  D7, X16
    FMOV  V7.D[1], X2
    FMOV  D8, X20
    FMOV  V8.D[1], X16
    FMOV  D9, X16
    FMOV  V9.D[1], X19
    FMOV  D10, X26
    FMOV  V10.D[1], X22
    FMOV  D11, X2
    FMOV  V11.D[1], X8
    FMOV  D12, X21
    FMOV  V12.D[1], X4
    FMOV  D13, X26
    FMOV  V13.D[1], X7
    FMOV  D14, X3
    FMOV  V14.D[1], X25
    FMOV  D15, X24
    FMOV  V15.D[1], X16
    FMOV  D16, X26
    FMOV  V16.D[1], X3
    FMOV  D17, X28
    FMOV  V17.D[1], X3
    FMOV  D18, X8
    FMOV  V18.D[1], X21
    FMOV  D19, X20
    FMOV  V19.D[1], X28
    FMOV  D20, X27
    FMOV  V20.D[1], X16
    FMOV  D21, X4
    FMOV  V21.D[1], X17
    FMOV  D22, X28
    FMOV  V22.D[1], X3
    FMOV  D23, X15
    FMOV  V23.D[1], X3
    FMOV  D24, X26
    FMOV  V24.D[1], X2
    FMOV  D25, X21
    FMOV  V25.D[1], X25
    FMOV  D26, X21
    FMOV  V26.D[1], X8
    FMOV  D27, X17
    FMOV  V27.D[1], X18
    FMOV  D28, X17
    FMOV  V28.D[1], X16
    FMOV  D29, X22
    FMOV  V29.D[1], X22
    FMOV  D30, X3
    FMOV  V30.D[1], X22
    FMOV  D31, X5
    FMOV  V31.D[1], X24
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X19, #0x1400, LSL #0
    ADD  X5, X30, X19, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X5]
    LD4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X5]
    ADD  X5, X5, X7, LSR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X5]
    LD4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X5]
    ADD  X5, X5, X7, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X5]
    LD4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X5]
    ADD  X5, X5, X7, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X5]
    LD4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X5]
    ADD  X5, X5, X7
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X5]
    LD4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X5]
    ADD  X5, X5, X7, ASR #0
    ST4 { V23.8B, V24.8B, V25.8B, V26.8B }, [X5]
    LD4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X5]
    ADD  X5, X5, X7, ASR #0
    ST4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X5]
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X5]
    ADD  X5, X5, X7, ASR #0
    ST4 { V2.4H, V3.4H, V4.4H, V5.4H }, [X5]
    LD4 { V2.4H, V3.4H, V4.4H, V5.4H }, [X5]
    ADD  X5, X5, X7
    ST4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X5]
    LD4 { V15.8B, V16.8B, V17.8B, V18.8B }, [X5]
    ADD  X5, X5, X7, LSR #0
    MOV  X12, X5
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X12], #64
    MOV  X12, X5
    LD4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X12], #64
    ADD  X5, X5, X7
    MOV  X12, X5
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X12], #64
    MOV  X12, X5
    LD4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X12], #64
    ADD  X5, X5, X7, LSR #0
    MOV  X12, X5
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X12], #64
    MOV  X12, X5
    LD4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X12], #64
    ADD  X5, X5, X7, ASR #0
    MOV  X12, X5
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X12], #64
    MOV  X12, X5
    LD4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X12], #64
    ADD  X5, X5, X7
    MOV  X12, X5
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X12], #64
    MOV  X12, X5
    LD4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X12], #64
    ADD  X5, X5, X7
    MOV  X12, X5
    ST4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X12], #32
    MOV  X12, X5
    LD4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X12], #32
    ADD  X5, X5, X7, LSR #0
    MOV  X12, X5
    ST4 { V24.2S, V25.2S, V26.2S, V27.2S }, [X12], #32
    MOV  X12, X5
    LD4 { V18.2S, V19.2S, V20.2S, V21.2S }, [X12], #32
    ADD  X5, X5, X7
    MOV  X12, X5
    ST4 { V15.4H, V16.4H, V17.4H, V18.4H }, [X12], #32
    MOV  X12, X5
    LD4 { V18.4H, V19.4H, V20.4H, V21.4H }, [X12], #32
    ADD  X5, X5, X7, LSR #0
    MOV  X12, X5
    ST4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X12], #32
    MOV  X12, X5
    LD4 { V10.8B, V11.8B, V12.8B, V13.8B }, [X12], #32
    ADD  X5, X5, X7, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X5], X22
    LD4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X5], X22
    ADD  X5, X5, X7, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X5], X22
    LD4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X5], X22
    ADD  X5, X5, X7, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X5], X22
    LD4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X5], X22
    ADD  X5, X5, X7, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X5], X22
    LD4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X5], X22
    ADD  X5, X5, X7
    ST4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X5], X22
    LD4 { V10.8H, V11.8H, V12.8H, V13.8H }, [X5], X22
    ADD  X5, X5, X7
    ST4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X5], X22
    LD4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X5], X22
    ADD  X5, X5, X7
    ST4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X5], X22
    LD4 { V10.2S, V11.2S, V12.2S, V13.2S }, [X5], X22
    ADD  X5, X5, X7, LSR #0
    ST4 { V6.4H, V7.4H, V8.4H, V9.4H }, [X5], X22
    LD4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X5], X22
    ADD  X5, X5, X7, LSR #0
    ST4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X5], X22
    LD4 { V28.8B, V29.8B, V30.8B, V31.8B }, [X5], X22
    ADD  X5, X5, X7, ASR #0
    ST4 { V10.H, V11.H, V12.H, V13.H }[0x5], [X5]
    LD4 { V10.H, V11.H, V12.H, V13.H }[0x4], [X5]
    ADD  X5, X5, X7, ASR #0
    ST4 { V10.S, V11.S, V12.S, V13.S }[0x2], [X5]
    LD4 { V23.S, V24.S, V25.S, V26.S }[0x2], [X5]
    ADD  X5, X5, X7, LSR #0
    ST4 { V6.D, V7.D, V8.D, V9.D }[0x1], [X5]
    LD4 { V8.D, V9.D, V10.D, V11.D }[0x0], [X5]
    ADD  X5, X5, X7
    ST4 { V9.B, V10.B, V11.B, V12.B }[0x8], [X5]
    LD4 { V16.B, V17.B, V18.B, V19.B }[0x7], [X5]
    ADD  X5, X5, X7, ASR #0
    MOV  X12, X5
    ST4 { V19.H, V20.H, V21.H, V22.H }[0x0], [X12], #8
    MOV  X12, X5
    LD4 { V19.H, V20.H, V21.H, V22.H }[0x3], [X12], #8
    ADD  X5, X5, X7, LSR #0
    ST4 { V19.H, V20.H, V21.H, V22.H }[0x7], [X5], X22
    LD4 { V19.H, V20.H, V21.H, V22.H }[0x3], [X5], X22
    ADD  X5, X5, X7, ASR #0
    MOV  X12, X5
    ST4 { V8.S, V9.S, V10.S, V11.S }[0x3], [X12], #16
    MOV  X12, X5
    LD4 { V22.S, V23.S, V24.S, V25.S }[0x3], [X12], #16
    ADD  X5, X5, X7, LSR #0
    ST4 { V19.S, V20.S, V21.S, V22.S }[0x0], [X5], X22
    LD4 { V25.S, V26.S, V27.S, V28.S }[0x0], [X5], X22
    ADD  X5, X5, X7, ASR #0
    MOV  X12, X5
    ST4 { V24.D, V25.D, V26.D, V27.D }[0x1], [X12], #32
    MOV  X12, X5
    LD4 { V19.D, V20.D, V21.D, V22.D }[0x0], [X12], #32
    ADD  X5, X5, X7
    ST4 { V19.D, V20.D, V21.D, V22.D }[0x0], [X5], X22
    LD4 { V17.D, V18.D, V19.D, V20.D }[0x0], [X5], X22
    ADD  X5, X5, X7
    MOV  X12, X5
    ST4 { V17.B, V18.B, V19.B, V20.B }[0x7], [X12], #4
    MOV  X12, X5
    LD4 { V18.B, V19.B, V20.B, V21.B }[0x9], [X12], #4
    ADD  X5, X5, X7
    ST4 { V18.B, V19.B, V20.B, V21.B }[0xa], [X5], X22
    LD4 { V19.B, V20.B, V21.B, V22.B }[0x6], [X5], X22
    ADD  X5, X5, X7, LSR #0
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X6
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X24, X18, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadStoreP07_TestFail
    MRS  X18, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D1
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D2
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D3
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D4
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D5
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D6
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D7
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D8
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D9
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D10
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D11
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D12
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D13
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D14
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D15
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D16
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D17
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D18
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D19
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D20
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D21
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D22
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D23
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D24
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D25
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D26
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D27
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D28
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D29
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D30
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D31
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X27, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X23
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X26
    FMOV  V2.D[1], X23
    FMOV  D3, X16
    FMOV  V3.D[1], X4
    FMOV  D4, X16
    FMOV  V4.D[1], X18
    FMOV  D5, X29
    FMOV  V5.D[1], X17
    FMOV  D6, X5
    FMOV  V6.D[1], X6
    FMOV  D7, X18
    FMOV  V7.D[1], X17
    FMOV  D8, X6
    FMOV  V8.D[1], X7
    FMOV  D9, X6
    FMOV  V9.D[1], X29
    FMOV  D10, X6
    FMOV  V10.D[1], X24
    FMOV  D11, X5
    FMOV  V11.D[1], X18
    FMOV  D12, X7
    FMOV  V12.D[1], X2
    FMOV  D13, X12
    FMOV  V13.D[1], X20
    FMOV  D14, X4
    FMOV  V14.D[1], X4
    FMOV  D15, X8
    FMOV  V15.D[1], X28
    FMOV  D16, X4
    FMOV  V16.D[1], X20
    FMOV  D17, X12
    FMOV  V17.D[1], X28
    FMOV  D18, X4
    FMOV  V18.D[1], X8
    FMOV  D19, X6
    FMOV  V19.D[1], X7
    FMOV  D20, X23
    FMOV  V20.D[1], X15
    FMOV  D21, X17
    FMOV  V21.D[1], X5
    FMOV  D22, X26
    FMOV  V22.D[1], X26
    FMOV  D23, X29
    FMOV  V23.D[1], X15
    FMOV  D24, X29
    FMOV  V24.D[1], X3
    FMOV  D25, X21
    FMOV  V25.D[1], X29
    FMOV  D26, X16
    FMOV  V26.D[1], X5
    FMOV  D27, X27
    FMOV  V27.D[1], X4
    FMOV  D28, X18
    FMOV  V28.D[1], X26
    FMOV  D29, X28
    FMOV  V29.D[1], X15
    FMOV  D30, X3
    FMOV  V30.D[1], X26
    FMOV  D31, X29
    FMOV  V31.D[1], X16
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X5, #0x40, LSL #0
    MOVZ  X27, #0x1900, LSL #0
    ADD  X25, X30, X27
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X25]
    LD4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X25]
    ADD  X25, X25, X5, ASR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X25]
    LD4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X25]
    ADD  X25, X25, X5, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X25]
    LD4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X25]
    ADD  X25, X25, X5, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X25]
    LD4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X25]
    ADD  X25, X25, X5, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X25]
    LD4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X25]
    ADD  X25, X25, X5
    ST4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X25]
    LD4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X25]
    ADD  X25, X25, X5
    ST4 { V6.2S, V7.2S, V8.2S, V9.2S }, [X25]
    LD4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X25]
    ADD  X25, X25, X5
    ST4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X25]
    LD4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X25]
    ADD  X25, X25, X5
    ST4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X25]
    LD4 { V21.8B, V22.8B, V23.8B, V24.8B }, [X25]
    ADD  X25, X25, X5, ASR #0
    MOV  X16, X25
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X16], #64
    MOV  X16, X25
    LD4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X16], #64
    ADD  X25, X25, X5
    MOV  X16, X25
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X16], #64
    MOV  X16, X25
    LD4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X16], #64
    ADD  X25, X25, X5, LSR #0
    MOV  X16, X25
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X16], #64
    MOV  X16, X25
    LD4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X16], #64
    ADD  X25, X25, X5, ASR #0
    MOV  X16, X25
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X16], #64
    MOV  X16, X25
    LD4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X16], #64
    ADD  X25, X25, X5, ASR #0
    MOV  X16, X25
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X16], #64
    MOV  X16, X25
    LD4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X16], #64
    ADD  X25, X25, X5, LSR #0
    MOV  X16, X25
    ST4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X16], #32
    MOV  X16, X25
    LD4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X16], #32
    ADD  X25, X25, X5, LSR #0
    MOV  X16, X25
    ST4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X16], #32
    MOV  X16, X25
    LD4 { V29.2S, V30.2S, V31.2S, V0.2S }, [X16], #32
    ADD  X25, X25, X5, ASR #0
    MOV  X16, X25
    ST4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X16], #32
    MOV  X16, X25
    LD4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X16], #32
    ADD  X25, X25, X5
    MOV  X16, X25
    ST4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X16], #32
    MOV  X16, X25
    LD4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X16], #32
    ADD  X25, X25, X5, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X25], X23
    LD4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X25], X23
    ADD  X25, X25, X5, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X25], X23
    LD4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X25], X23
    ADD  X25, X25, X5, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X25], X23
    LD4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X25], X23
    ADD  X25, X25, X5, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X25], X23
    LD4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X25], X23
    ADD  X25, X25, X5, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X25], X23
    LD4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X25], X23
    ADD  X25, X25, X5
    ST4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X25], X23
    LD4 { V18.8B, V19.8B, V20.8B, V21.8B }, [X25], X23
    ADD  X25, X25, X5
    ST4 { V4.2S, V5.2S, V6.2S, V7.2S }, [X25], X23
    LD4 { V24.2S, V25.2S, V26.2S, V27.2S }, [X25], X23
    ADD  X25, X25, X5, ASR #0
    ST4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X25], X23
    LD4 { V4.4H, V5.4H, V6.4H, V7.4H }, [X25], X23
    ADD  X25, X25, X5
    ST4 { V7.8B, V8.8B, V9.8B, V10.8B }, [X25], X23
    LD4 { V7.8B, V8.8B, V9.8B, V10.8B }, [X25], X23
    ADD  X25, X25, X5, LSR #0
    ST4 { V6.H, V7.H, V8.H, V9.H }[0x6], [X25]
    LD4 { V20.H, V21.H, V22.H, V23.H }[0x7], [X25]
    ADD  X25, X25, X5, LSR #0
    ST4 { V21.S, V22.S, V23.S, V24.S }[0x0], [X25]
    LD4 { V21.S, V22.S, V23.S, V24.S }[0x0], [X25]
    ADD  X25, X25, X5, LSR #0
    ST4 { V21.D, V22.D, V23.D, V24.D }[0x1], [X25]
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x0], [X25]
    ADD  X25, X25, X5
    ST4 { V23.B, V24.B, V25.B, V26.B }[0xd], [X25]
    LD4 { V13.B, V14.B, V15.B, V16.B }[0x7], [X25]
    ADD  X25, X25, X5
    MOV  X16, X25
    ST4 { V13.H, V14.H, V15.H, V16.H }[0x6], [X16], #8
    MOV  X16, X25
    LD4 { V23.H, V24.H, V25.H, V26.H }[0x5], [X16], #8
    ADD  X25, X25, X5
    ST4 { V0.H, V1.H, V2.H, V3.H }[0x0], [X25], X23
    LD4 { V0.H, V1.H, V2.H, V3.H }[0x3], [X25], X23
    ADD  X25, X25, X5
    MOV  X16, X25
    ST4 { V12.S, V13.S, V14.S, V15.S }[0x3], [X16], #16
    MOV  X16, X25
    LD4 { V12.S, V13.S, V14.S, V15.S }[0x2], [X16], #16
    ADD  X25, X25, X5, LSR #0
    ST4 { V23.S, V24.S, V25.S, V26.S }[0x3], [X25], X23
    LD4 { V29.S, V30.S, V31.S, V0.S }[0x3], [X25], X23
    ADD  X25, X25, X5, LSR #0
    MOV  X16, X25
    ST4 { V18.D, V19.D, V20.D, V21.D }[0x0], [X16], #32
    MOV  X16, X25
    LD4 { V18.D, V19.D, V20.D, V21.D }[0x0], [X16], #32
    ADD  X25, X25, X5, ASR #0
    ST4 { V11.D, V12.D, V13.D, V14.D }[0x0], [X25], X23
    LD4 { V21.D, V22.D, V23.D, V24.D }[0x0], [X25], X23
    ADD  X25, X25, X5
    MOV  X16, X25
    ST4 { V21.B, V22.B, V23.B, V24.B }[0xb], [X16], #4
    MOV  X16, X25
    LD4 { V28.B, V29.B, V30.B, V31.B }[0x1], [X16], #4
    ADD  X25, X25, X5, LSR #0
    ST4 { V28.B, V29.B, V30.B, V31.B }[0x3], [X25], X23
    LD4 { V31.B, V0.B, V1.B, V2.B }[0x2], [X25], X23
    ADD  X25, X25, X5, LSR #0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X17, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MRS  X24, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D0
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D1
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D2
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D3
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D4
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D5
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D6
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D7
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D8
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D9
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D10
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D11
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D12
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D13
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D14
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D15
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D16
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D17
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D18
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D19
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D20
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D21
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D22
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D23
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D24
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D25
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D26
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D27
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D28
    MOVZ  X17, #0xa5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D29
    MOVZ  X17, #0xa5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D30
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
    FMOV  X24, D31
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X19, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    FMOV  D0, X8
    FMOV  V0.D[1], X20
    FMOV  D1, X27
    FMOV  V1.D[1], X28
    FMOV  D2, X15
    FMOV  V2.D[1], X26
    FMOV  D3, X18
    FMOV  V3.D[1], X8
    FMOV  D4, X29
    FMOV  V4.D[1], X3
    FMOV  D5, X16
    FMOV  V5.D[1], X2
    FMOV  D6, X21
    FMOV  V6.D[1], X28
    FMOV  D7, X29
    FMOV  V7.D[1], X6
    FMOV  D8, X8
    FMOV  V8.D[1], X27
    FMOV  D9, X22
    FMOV  V9.D[1], X23
    FMOV  D10, X5
    FMOV  V10.D[1], X21
    FMOV  D11, X28
    FMOV  V11.D[1], X28
    FMOV  D12, X27
    FMOV  V12.D[1], X3
    FMOV  D13, X5
    FMOV  V13.D[1], X2
    FMOV  D14, X12
    FMOV  V14.D[1], X24
    FMOV  D15, X24
    FMOV  V15.D[1], X7
    FMOV  D16, X15
    FMOV  V16.D[1], X8
    FMOV  D17, X26
    FMOV  V17.D[1], X23
    FMOV  D18, X19
    FMOV  V18.D[1], X17
    FMOV  D19, X16
    FMOV  V19.D[1], X29
    FMOV  D20, X29
    FMOV  V20.D[1], X2
    FMOV  D21, X26
    FMOV  V21.D[1], X7
    FMOV  D22, X18
    FMOV  V22.D[1], X16
    FMOV  D23, X23
    FMOV  V23.D[1], X17
    FMOV  D24, X20
    FMOV  V24.D[1], X6
    FMOV  D25, X23
    FMOV  V25.D[1], X19
    FMOV  D26, X7
    FMOV  V26.D[1], X7
    FMOV  D27, X25
    FMOV  V27.D[1], X29
    FMOV  D28, X7
    FMOV  V28.D[1], X4
    FMOV  D29, X28
    FMOV  V29.D[1], X2
    FMOV  D30, X18
    FMOV  V30.D[1], X24
    FMOV  D31, X26
    FMOV  V31.D[1], X5
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X17, #0x1e00, LSL #0
    ADD  X20, X30, X17, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X20]
    LD4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X20]
    ADD  X20, X20, X8, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X20]
    LD4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X20]
    LD4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X20]
    LD4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X20]
    ADD  X20, X20, X8, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X20]
    LD4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X20]
    ADD  X20, X20, X8, ASR #0
    ST4 { V14.4H, V15.4H, V16.4H, V17.4H }, [X20]
    LD4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V22.2S, V23.2S, V24.2S, V25.2S }, [X20]
    LD4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X20]
    ADD  X20, X20, X8
    ST4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X20]
    LD4 { V21.4H, V22.4H, V23.4H, V24.4H }, [X20]
    ADD  X20, X20, X8, ASR #0
    ST4 { V28.8B, V29.8B, V30.8B, V31.8B }, [X20]
    LD4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X20]
    ADD  X20, X20, X8, ASR #0
    MOV  X28, X20
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X28], #64
    MOV  X28, X20
    LD4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X28], #64
    ADD  X20, X20, X8
    MOV  X28, X20
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X28], #64
    MOV  X28, X20
    LD4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X28], #64
    ADD  X20, X20, X8
    MOV  X28, X20
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X28], #64
    MOV  X28, X20
    LD4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X28], #64
    ADD  X20, X20, X8
    MOV  X28, X20
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X28], #64
    MOV  X28, X20
    LD4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X28], #64
    ADD  X20, X20, X8
    MOV  X28, X20
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X28], #64
    MOV  X28, X20
    LD4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X28], #64
    ADD  X20, X20, X8
    MOV  X28, X20
    ST4 { V20.2S, V21.2S, V22.2S, V23.2S }, [X28], #32
    MOV  X28, X20
    LD4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X28], #32
    ADD  X20, X20, X8, ASR #0
    MOV  X28, X20
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X28], #32
    MOV  X28, X20
    LD4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X28], #32
    ADD  X20, X20, X8
    MOV  X28, X20
    ST4 { V12.4H, V13.4H, V14.4H, V15.4H }, [X28], #32
    MOV  X28, X20
    LD4 { V18.4H, V19.4H, V20.4H, V21.4H }, [X28], #32
    ADD  X20, X20, X8
    MOV  X28, X20
    ST4 { V30.8B, V31.8B, V0.8B, V1.8B }, [X28], #32
    MOV  X28, X20
    LD4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X28], #32
    ADD  X20, X20, X8
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X20], X15
    LD4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X20], X15
    ADD  X20, X20, X8
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X20], X15
    LD4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X20], X15
    ADD  X20, X20, X8, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X20], X15
    LD4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X20], X15
    ADD  X20, X20, X8, ASR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X20], X15
    LD4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X20], X15
    ADD  X20, X20, X8, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X20], X15
    LD4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X20], X15
    ADD  X20, X20, X8, ASR #0
    ST4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X20], X15
    LD4 { V30.4H, V31.4H, V0.4H, V1.4H }, [X20], X15
    ADD  X20, X20, X8, ASR #0
    ST4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X20], X15
    LD4 { V9.2S, V10.2S, V11.2S, V12.2S }, [X20], X15
    ADD  X20, X20, X8, LSR #0
    ST4 { V3.4H, V4.4H, V5.4H, V6.4H }, [X20], X15
    LD4 { V25.4H, V26.4H, V27.4H, V28.4H }, [X20], X15
    ADD  X20, X20, X8
    ST4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X20], X15
    LD4 { V16.8B, V17.8B, V18.8B, V19.8B }, [X20], X15
    ADD  X20, X20, X8, ASR #0
    ST4 { V8.H, V9.H, V10.H, V11.H }[0x3], [X20]
    LD4 { V26.H, V27.H, V28.H, V29.H }[0x1], [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V30.S, V31.S, V0.S, V1.S }[0x1], [X20]
    LD4 { V13.S, V14.S, V15.S, V16.S }[0x1], [X20]
    ADD  X20, X20, X8, LSR #0
    ST4 { V26.D, V27.D, V28.D, V29.D }[0x0], [X20]
    LD4 { V26.D, V27.D, V28.D, V29.D }[0x1], [X20]
    ADD  X20, X20, X8, ASR #0
    ST4 { V16.B, V17.B, V18.B, V19.B }[0x1], [X20]
    LD4 { V9.B, V10.B, V11.B, V12.B }[0xe], [X20]
    ADD  X20, X20, X8, LSR #0
    MOV  X28, X20
    ST4 { V16.H, V17.H, V18.H, V19.H }[0x0], [X28], #8
    MOV  X28, X20
    LD4 { V12.H, V13.H, V14.H, V15.H }[0x2], [X28], #8
    ADD  X20, X20, X8, LSR #0
    ST4 { V11.H, V12.H, V13.H, V14.H }[0x3], [X20], X15
    LD4 { V3.H, V4.H, V5.H, V6.H }[0x7], [X20], X15
    ADD  X20, X20, X8, LSR #0
    MOV  X28, X20
    ST4 { V13.S, V14.S, V15.S, V16.S }[0x0], [X28], #16
    MOV  X28, X20
    LD4 { V30.S, V31.S, V0.S, V1.S }[0x0], [X28], #16
    ADD  X20, X20, X8, LSR #0
    ST4 { V12.S, V13.S, V14.S, V15.S }[0x1], [X20], X15
    LD4 { V15.S, V16.S, V17.S, V18.S }[0x3], [X20], X15
    ADD  X20, X20, X8
    MOV  X28, X20
    ST4 { V15.D, V16.D, V17.D, V18.D }[0x0], [X28], #32
    MOV  X28, X20
    LD4 { V15.D, V16.D, V17.D, V18.D }[0x1], [X28], #32
    ADD  X20, X20, X8, ASR #0
    ST4 { V15.D, V16.D, V17.D, V18.D }[0x1], [X20], X15
    LD4 { V15.D, V16.D, V17.D, V18.D }[0x1], [X20], X15
    ADD  X20, X20, X8
    MOV  X28, X20
    ST4 { V30.B, V31.B, V0.B, V1.B }[0x2], [X28], #4
    MOV  X28, X20
    LD4 { V20.B, V21.B, V22.B, V23.B }[0x3], [X28], #4
    ADD  X20, X20, X8, LSR #0
    ST4 { V15.B, V16.B, V17.B, V18.B }[0xe], [X20], X15
    LD4 { V30.B, V31.B, V0.B, V1.B }[0xe], [X20], X15
    ADD  X20, X20, X8, LSR #0
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X2
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X3
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X4
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X6
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X7
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X12
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X18
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X19
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X21
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X23
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X24
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X25
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X26
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X27
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MOVZ  X16, #0x5a5a, LSL #0
    MOVK  X16, #0x5a5a, LSL #16
    MOVK  X16, #0x5a5a, LSL #32
    MOVK  X16, #0x5a5a, LSL #48
    SUB  X22, X16, X29
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadStoreP07_TestFail
    MRS  X16, FPSR
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V0.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D0
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V1.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D1
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V2.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D2
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V3.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D3
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V4.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D4
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V5.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D5
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V6.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D6
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V7.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D7
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V8.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D8
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V9.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D9
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V10.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D10
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V11.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D11
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V12.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D12
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V13.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D13
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V14.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D14
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V15.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D15
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V16.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D16
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V17.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D17
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V18.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D18
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V19.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D19
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V20.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D20
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V21.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D21
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V22.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D22
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V23.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D23
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V24.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D24
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V25.D[1]
    MOVZ  X22, #0x0, LSL #0
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D25
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V26.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D26
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V27.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D27
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V28.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D28
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V29.D[1]
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D29
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V30.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D30
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, V31.D[1]
    MOVZ  X22, #0x0, LSL #0
    MOVK  X22, #0x5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
    FMOV  X16, D31
    MOVZ  X22, #0x5a5a, LSL #0
    MOVK  X22, #0x5a5a, LSL #16
    MOVK  X22, #0x5a5a, LSL #32
    MOVK  X22, #0x5a5a, LSL #48
    SUB  X5, X22, X16
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    FMOV  D0, X24
    FMOV  V0.D[1], X23
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X8
    FMOV  V2.D[1], X27
    FMOV  D3, X15
    FMOV  V3.D[1], X28
    FMOV  D4, X21
    FMOV  V4.D[1], X18
    FMOV  D5, X12
    FMOV  V5.D[1], X2
    FMOV  D6, X17
    FMOV  V6.D[1], X7
    FMOV  D7, X25
    FMOV  V7.D[1], X18
    FMOV  D8, X6
    FMOV  V8.D[1], X15
    FMOV  D9, X26
    FMOV  V9.D[1], X28
    FMOV  D10, X4
    FMOV  V10.D[1], X3
    FMOV  D11, X12
    FMOV  V11.D[1], X20
    FMOV  D12, X7
    FMOV  V12.D[1], X24
    FMOV  D13, X17
    FMOV  V13.D[1], X8
    FMOV  D14, X18
    FMOV  V14.D[1], X25
    FMOV  D15, X19
    FMOV  V15.D[1], X16
    FMOV  D16, X8
    FMOV  V16.D[1], X5
    FMOV  D17, X17
    FMOV  V17.D[1], X28
    FMOV  D18, X27
    FMOV  V18.D[1], X4
    FMOV  D19, X5
    FMOV  V19.D[1], X12
    FMOV  D20, X28
    FMOV  V20.D[1], X17
    FMOV  D21, X22
    FMOV  V21.D[1], X22
    FMOV  D22, X4
    FMOV  V22.D[1], X23
    FMOV  D23, X15
    FMOV  V23.D[1], X5
    FMOV  D24, X20
    FMOV  V24.D[1], X23
    FMOV  D25, X17
    FMOV  V25.D[1], X21
    FMOV  D26, X12
    FMOV  V26.D[1], X18
    FMOV  D27, X3
    FMOV  V27.D[1], X3
    FMOV  D28, X6
    FMOV  V28.D[1], X12
    FMOV  D29, X25
    FMOV  V29.D[1], X17
    FMOV  D30, X16
    FMOV  V30.D[1], X21
    FMOV  D31, X25
    FMOV  V31.D[1], X12
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X25, #0x2300, LSL #0
    ADD  X7, X30, X25, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X7]
    LD4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X7]
    ADD  X7, X7, X29, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X7]
    LD4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X7]
    ADD  X7, X7, X29, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X7]
    LD4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X7]
    ADD  X7, X7, X29
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X7]
    LD4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X7]
    ADD  X7, X7, X29, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X7]
    LD4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X7]
    ADD  X7, X7, X29, LSR #0
    ST4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X7]
    LD4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X7]
    ADD  X7, X7, X29
    ST4 { V22.2S, V23.2S, V24.2S, V25.2S }, [X7]
    LD4 { V16.2S, V17.2S, V18.2S, V19.2S }, [X7]
    ADD  X7, X7, X29, ASR #0
    ST4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X7]
    LD4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X7]
    ADD  X7, X7, X29
    ST4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X7]
    LD4 { V29.8B, V30.8B, V31.8B, V0.8B }, [X7]
    ADD  X7, X7, X29, LSR #0
    MOV  X19, X7
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X19], #64
    MOV  X19, X7
    LD4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X19], #64
    ADD  X7, X7, X29, LSR #0
    MOV  X19, X7
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X19], #64
    MOV  X19, X7
    LD4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X19], #64
    ADD  X7, X7, X29
    MOV  X19, X7
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X19], #64
    MOV  X19, X7
    LD4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X19], #64
    ADD  X7, X7, X29, LSR #0
    MOV  X19, X7
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X19], #64
    MOV  X19, X7
    LD4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X19], #64
    ADD  X7, X7, X29, ASR #0
    MOV  X19, X7
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X19], #64
    MOV  X19, X7
    LD4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X19], #64
    ADD  X7, X7, X29, LSR #0
    MOV  X19, X7
    ST4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X19], #32
    MOV  X19, X7
    LD4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X19], #32
    ADD  X7, X7, X29, ASR #0
    MOV  X19, X7
    ST4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X19], #32
    MOV  X19, X7
    LD4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X19], #32
    ADD  X7, X7, X29, LSR #0
    MOV  X19, X7
    ST4 { V13.4H, V14.4H, V15.4H, V16.4H }, [X19], #32
    MOV  X19, X7
    LD4 { V28.4H, V29.4H, V30.4H, V31.4H }, [X19], #32
    ADD  X7, X7, X29
    MOV  X19, X7
    ST4 { V24.8B, V25.8B, V26.8B, V27.8B }, [X19], #32
    MOV  X19, X7
    LD4 { V13.8B, V14.8B, V15.8B, V16.8B }, [X19], #32
    ADD  X7, X7, X29, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X7], X4
    LD4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X7], X4
    ADD  X7, X7, X29, ASR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X7], X4
    LD4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X7], X4
    ADD  X7, X7, X29
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X7], X4
    LD4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X7], X4
    ADD  X7, X7, X29, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X7], X4
    LD4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X7], X4
    ADD  X7, X7, X29
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X7], X4
    LD4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X7], X4
    ADD  X7, X7, X29
    ST4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X7], X4
    LD4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X7], X4
    ADD  X7, X7, X29, ASR #0
    ST4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X7], X4
    LD4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X7], X4
    ADD  X7, X7, X29, LSR #0
    ST4 { V2.4H, V3.4H, V4.4H, V5.4H }, [X7], X4
    LD4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X7], X4
    ADD  X7, X7, X29, LSR #0
    ST4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X7], X4
    LD4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X7], X4
    ADD  X7, X7, X29, ASR #0
    ST4 { V3.H, V4.H, V5.H, V6.H }[0x1], [X7]
    LD4 { V26.H, V27.H, V28.H, V29.H }[0x4], [X7]
    ADD  X7, X7, X29
    ST4 { V26.S, V27.S, V28.S, V29.S }[0x2], [X7]
    LD4 { V12.S, V13.S, V14.S, V15.S }[0x1], [X7]
    ADD  X7, X7, X29, LSR #0
    ST4 { V3.D, V4.D, V5.D, V6.D }[0x1], [X7]
    LD4 { V9.D, V10.D, V11.D, V12.D }[0x1], [X7]
    ADD  X7, X7, X29, LSR #0
    ST4 { V11.B, V12.B, V13.B, V14.B }[0x4], [X7]
    LD4 { V11.B, V12.B, V13.B, V14.B }[0x4], [X7]
    ADD  X7, X7, X29, LSR #0
    MOV  X19, X7
    ST4 { V10.H, V11.H, V12.H, V13.H }[0x0], [X19], #8
    MOV  X19, X7
    LD4 { V10.H, V11.H, V12.H, V13.H }[0x2], [X19], #8
    ADD  X7, X7, X29, LSR #0
    ST4 { V12.H, V13.H, V14.H, V15.H }[0x4], [X7], X4
    LD4 { V25.H, V26.H, V27.H, V28.H }[0x7], [X7], X4
    ADD  X7, X7, X29
    MOV  X19, X7
    ST4 { V18.S, V19.S, V20.S, V21.S }[0x0], [X19], #16
    MOV  X19, X7
    LD4 { V11.S, V12.S, V13.S, V14.S }[0x3], [X19], #16
    ADD  X7, X7, X29, ASR #0
    ST4 { V9.S, V10.S, V11.S, V12.S }[0x2], [X7], X4
    LD4 { V3.S, V4.S, V5.S, V6.S }[0x1], [X7], X4
    ADD  X7, X7, X29, LSR #0
    MOV  X19, X7
    ST4 { V18.D, V19.D, V20.D, V21.D }[0x0], [X19], #32
    MOV  X19, X7
    LD4 { V16.D, V17.D, V18.D, V19.D }[0x0], [X19], #32
    ADD  X7, X7, X29
    ST4 { V3.D, V4.D, V5.D, V6.D }[0x1], [X7], X4
    LD4 { V9.D, V10.D, V11.D, V12.D }[0x1], [X7], X4
    ADD  X7, X7, X29, ASR #0
    MOV  X19, X7
    ST4 { V16.B, V17.B, V18.B, V19.B }[0xa], [X19], #4
    MOV  X19, X7
    LD4 { V18.B, V19.B, V20.B, V21.B }[0xb], [X19], #4
    ADD  X7, X7, X29
    ST4 { V10.B, V11.B, V12.B, V13.B }[0x0], [X7], X4
    LD4 { V10.B, V11.B, V12.B, V13.B }[0x4], [X7], X4
    ADD  X7, X7, X29, LSR #0
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X8
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X26
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MOVZ  X27, #0xa5a5, LSL #0
    MOVK  X27, #0xa5a5, LSL #16
    MOVK  X27, #0xa5a5, LSL #32
    MOVK  X27, #0xa5a5, LSL #48
    SUB  X18, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadStoreP07_TestFail
    MRS  X27, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D1
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D2
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D3
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D4
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D5
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D6
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D7
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D8
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D9
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D10
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D11
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D12
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D13
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D14
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D15
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D16
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D17
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D18
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D19
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D20
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D21
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D22
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D23
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D24
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D25
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D26
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D27
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D28
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D29
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D30
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
    FMOV  X27, D31
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X12, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
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
    FMOV  V1.D[1], X26
    FMOV  D2, X26
    FMOV  V2.D[1], X2
    FMOV  D3, X24
    FMOV  V3.D[1], X12
    FMOV  D4, X19
    FMOV  V4.D[1], X2
    FMOV  D5, X5
    FMOV  V5.D[1], X17
    FMOV  D6, X22
    FMOV  V6.D[1], X23
    FMOV  D7, X19
    FMOV  V7.D[1], X25
    FMOV  D8, X12
    FMOV  V8.D[1], X3
    FMOV  D9, X24
    FMOV  V9.D[1], X5
    FMOV  D10, X17
    FMOV  V10.D[1], X7
    FMOV  D11, X12
    FMOV  V11.D[1], X15
    FMOV  D12, X16
    FMOV  V12.D[1], X22
    FMOV  D13, X28
    FMOV  V13.D[1], X18
    FMOV  D14, X20
    FMOV  V14.D[1], X23
    FMOV  D15, X21
    FMOV  V15.D[1], X18
    FMOV  D16, X17
    FMOV  V16.D[1], X5
    FMOV  D17, X8
    FMOV  V17.D[1], X3
    FMOV  D18, X12
    FMOV  V18.D[1], X15
    FMOV  D19, X21
    FMOV  V19.D[1], X17
    FMOV  D20, X3
    FMOV  V20.D[1], X4
    FMOV  D21, X25
    FMOV  V21.D[1], X16
    FMOV  D22, X4
    FMOV  V22.D[1], X18
    FMOV  D23, X27
    FMOV  V23.D[1], X6
    FMOV  D24, X19
    FMOV  V24.D[1], X19
    FMOV  D25, X8
    FMOV  V25.D[1], X2
    FMOV  D26, X17
    FMOV  V26.D[1], X7
    FMOV  D27, X6
    FMOV  V27.D[1], X19
    FMOV  D28, X21
    FMOV  V28.D[1], X24
    FMOV  D29, X12
    FMOV  V29.D[1], X25
    FMOV  D30, X2
    FMOV  V30.D[1], X28
    FMOV  D31, X12
    FMOV  V31.D[1], X19
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X26, #0x2800, LSL #0
    ADD  X22, X30, X26, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X22]
    LD4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X22]
    ADD  X22, X22, X15, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X22]
    LD4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X22]
    ADD  X22, X22, X15, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X22]
    LD4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X22]
    ADD  X22, X22, X15
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X22]
    LD4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X22]
    ADD  X22, X22, X15
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X22]
    LD4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X22]
    ADD  X22, X22, X15
    ST4 { V22.2S, V23.2S, V24.2S, V25.2S }, [X22]
    LD4 { V8.4H, V9.4H, V10.4H, V11.4H }, [X22]
    ADD  X22, X22, X15
    ST4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X22]
    LD4 { V12.2S, V13.2S, V14.2S, V15.2S }, [X22]
    ADD  X22, X22, X15
    ST4 { V10.4H, V11.4H, V12.4H, V13.4H }, [X22]
    LD4 { V2.4H, V3.4H, V4.4H, V5.4H }, [X22]
    ADD  X22, X22, X15, LSR #0
    ST4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X22]
    LD4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X22]
    ADD  X22, X22, X15
    MOV  X2, X22
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X2], #64
    MOV  X2, X22
    LD4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X2], #64
    ADD  X22, X22, X15
    MOV  X2, X22
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X2], #64
    MOV  X2, X22
    LD4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X2], #64
    ADD  X22, X22, X15, LSR #0
    MOV  X2, X22
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X2], #64
    MOV  X2, X22
    LD4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X2], #64
    ADD  X22, X22, X15, LSR #0
    MOV  X2, X22
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X2], #64
    MOV  X2, X22
    LD4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X2], #64
    ADD  X22, X22, X15
    MOV  X2, X22
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X2], #64
    MOV  X2, X22
    LD4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X2], #64
    ADD  X22, X22, X15, ASR #0
    MOV  X2, X22
    ST4 { V31.4H, V0.4H, V1.4H, V2.4H }, [X2], #32
    MOV  X2, X22
    LD4 { V23.2S, V24.2S, V25.2S, V26.2S }, [X2], #32
    ADD  X22, X22, X15
    MOV  X2, X22
    ST4 { V4.2S, V5.2S, V6.2S, V7.2S }, [X2], #32
    MOV  X2, X22
    LD4 { V31.2S, V0.2S, V1.2S, V2.2S }, [X2], #32
    ADD  X22, X22, X15, LSR #0
    MOV  X2, X22
    ST4 { V23.4H, V24.4H, V25.4H, V26.4H }, [X2], #32
    MOV  X2, X22
    LD4 { V8.4H, V9.4H, V10.4H, V11.4H }, [X2], #32
    ADD  X22, X22, X15
    MOV  X2, X22
    ST4 { V31.8B, V0.8B, V1.8B, V2.8B }, [X2], #32
    MOV  X2, X22
    LD4 { V14.8B, V15.8B, V16.8B, V17.8B }, [X2], #32
    ADD  X22, X22, X15
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X22], X25
    LD4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X22], X25
    ADD  X22, X22, X15
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X22], X25
    LD4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X22], X25
    ADD  X22, X22, X15, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X22], X25
    LD4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X22], X25
    ADD  X22, X22, X15, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X22], X25
    LD4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X22], X25
    ADD  X22, X22, X15, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X22], X25
    LD4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X22], X25
    ADD  X22, X22, X15
    ST4 { V9.8B, V10.8B, V11.8B, V12.8B }, [X22], X25
    LD4 { V17.8B, V18.8B, V19.8B, V20.8B }, [X22], X25
    ADD  X22, X22, X15, ASR #0
    ST4 { V17.2S, V18.2S, V19.2S, V20.2S }, [X22], X25
    LD4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X22], X25
    ADD  X22, X22, X15, ASR #0
    ST4 { V26.4H, V27.4H, V28.4H, V29.4H }, [X22], X25
    LD4 { V19.4H, V20.4H, V21.4H, V22.4H }, [X22], X25
    ADD  X22, X22, X15
    ST4 { V7.8B, V8.8B, V9.8B, V10.8B }, [X22], X25
    LD4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X22], X25
    ADD  X22, X22, X15, ASR #0
    ST4 { V0.H, V1.H, V2.H, V3.H }[0x2], [X22]
    LD4 { V0.H, V1.H, V2.H, V3.H }[0x4], [X22]
    ADD  X22, X22, X15, LSR #0
    ST4 { V0.S, V1.S, V2.S, V3.S }[0x0], [X22]
    LD4 { V9.S, V10.S, V11.S, V12.S }[0x2], [X22]
    ADD  X22, X22, X15
    ST4 { V18.D, V19.D, V20.D, V21.D }[0x1], [X22]
    LD4 { V18.D, V19.D, V20.D, V21.D }[0x1], [X22]
    ADD  X22, X22, X15
    ST4 { V9.B, V10.B, V11.B, V12.B }[0x4], [X22]
    LD4 { V0.B, V1.B, V2.B, V3.B }[0x8], [X22]
    ADD  X22, X22, X15, ASR #0
    MOV  X2, X22
    ST4 { V1.H, V2.H, V3.H, V4.H }[0x7], [X2], #8
    MOV  X2, X22
    LD4 { V26.H, V27.H, V28.H, V29.H }[0x5], [X2], #8
    ADD  X22, X22, X15
    ST4 { V28.H, V29.H, V30.H, V31.H }[0x3], [X22], X25
    LD4 { V1.H, V2.H, V3.H, V4.H }[0x3], [X22], X25
    ADD  X22, X22, X15
    MOV  X2, X22
    ST4 { V0.S, V1.S, V2.S, V3.S }[0x2], [X2], #16
    MOV  X2, X22
    LD4 { V0.S, V1.S, V2.S, V3.S }[0x1], [X2], #16
    ADD  X22, X22, X15
    ST4 { V31.S, V0.S, V1.S, V2.S }[0x0], [X22], X25
    LD4 { V30.S, V31.S, V0.S, V1.S }[0x0], [X22], X25
    ADD  X22, X22, X15
    MOV  X2, X22
    ST4 { V30.D, V31.D, V0.D, V1.D }[0x0], [X2], #32
    MOV  X2, X22
    LD4 { V10.D, V11.D, V12.D, V13.D }[0x0], [X2], #32
    ADD  X22, X22, X15
    ST4 { V29.D, V30.D, V31.D, V0.D }[0x1], [X22], X25
    LD4 { V22.D, V23.D, V24.D, V25.D }[0x1], [X22], X25
    ADD  X22, X22, X15, LSR #0
    MOV  X2, X22
    ST4 { V22.B, V23.B, V24.B, V25.B }[0xa], [X2], #4
    MOV  X2, X22
    LD4 { V31.B, V0.B, V1.B, V2.B }[0xe], [X2], #4
    ADD  X22, X22, X15
    ST4 { V23.B, V24.B, V25.B, V26.B }[0x1], [X22], X25
    LD4 { V1.B, V2.B, V3.B, V4.B }[0xe], [X22], X25
    ADD  X22, X22, X15, ASR #0
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X6
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MOVZ  X3, #0x5a5a, LSL #0
    MOVK  X3, #0x5a5a, LSL #16
    MOVK  X3, #0x5a5a, LSL #32
    MOVK  X3, #0x5a5a, LSL #48
    SUB  X17, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP07_TestFail
    MRS  X3, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D0
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D1
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D2
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D3
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    MOVK  X17, #0x5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D4
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D5
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D6
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D7
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D8
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D9
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D10
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D11
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D12
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D13
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D14
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D15
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D16
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D17
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D18
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D19
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D20
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D21
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D22
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D23
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D24
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D25
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D26
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D27
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D28
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D29
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D30
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
    FMOV  X3, D31
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X16, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP07_TestFail
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
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
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
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X16
    FMOV  D3, X23
    FMOV  V3.D[1], X12
    FMOV  D4, X19
    FMOV  V4.D[1], X21
    FMOV  D5, X23
    FMOV  V5.D[1], X12
    FMOV  D6, X29
    FMOV  V6.D[1], X6
    FMOV  D7, X8
    FMOV  V7.D[1], X15
    FMOV  D8, X4
    FMOV  V8.D[1], X24
    FMOV  D9, X23
    FMOV  V9.D[1], X29
    FMOV  D10, X24
    FMOV  V10.D[1], X6
    FMOV  D11, X12
    FMOV  V11.D[1], X4
    FMOV  D12, X15
    FMOV  V12.D[1], X16
    FMOV  D13, X22
    FMOV  V13.D[1], X18
    FMOV  D14, X26
    FMOV  V14.D[1], X5
    FMOV  D15, X15
    FMOV  V15.D[1], X3
    FMOV  D16, X18
    FMOV  V16.D[1], X5
    FMOV  D17, X22
    FMOV  V17.D[1], X5
    FMOV  D18, X26
    FMOV  V18.D[1], X27
    FMOV  D19, X22
    FMOV  V19.D[1], X19
    FMOV  D20, X29
    FMOV  V20.D[1], X4
    FMOV  D21, X2
    FMOV  V21.D[1], X5
    FMOV  D22, X23
    FMOV  V22.D[1], X29
    FMOV  D23, X5
    FMOV  V23.D[1], X4
    FMOV  D24, X21
    FMOV  V24.D[1], X28
    FMOV  D25, X18
    FMOV  V25.D[1], X28
    FMOV  D26, X19
    FMOV  V26.D[1], X27
    FMOV  D27, X5
    FMOV  V27.D[1], X15
    FMOV  D28, X26
    FMOV  V28.D[1], X21
    FMOV  D29, X27
    FMOV  V29.D[1], X19
    FMOV  D30, X20
    FMOV  V30.D[1], X6
    FMOV  D31, X25
    FMOV  V31.D[1], X6
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X19, #0x2d00, LSL #0
    ADD  X6, X30, X19
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X6]
    LD4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X6]
    ADD  X6, X6, X25, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X6]
    LD4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X6]
    ADD  X6, X6, X25
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X6]
    LD4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X6]
    ADD  X6, X6, X25, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X6]
    LD4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X6]
    ADD  X6, X6, X25, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X6]
    LD4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X6]
    ADD  X6, X6, X25, ASR #0
    ST4 { V25.8B, V26.8B, V27.8B, V28.8B }, [X6]
    LD4 { V26.2S, V27.2S, V28.2S, V29.2S }, [X6]
    ADD  X6, X6, X25, LSR #0
    ST4 { V13.2S, V14.2S, V15.2S, V16.2S }, [X6]
    LD4 { V7.2S, V8.2S, V9.2S, V10.2S }, [X6]
    ADD  X6, X6, X25, ASR #0
    ST4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X6]
    LD4 { V11.4H, V12.4H, V13.4H, V14.4H }, [X6]
    ADD  X6, X6, X25, LSR #0
    ST4 { V26.8B, V27.8B, V28.8B, V29.8B }, [X6]
    LD4 { V2.8B, V3.8B, V4.8B, V5.8B }, [X6]
    ADD  X6, X6, X25, ASR #0
    MOV  X21, X6
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X21], #64
    MOV  X21, X6
    LD4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X21], #64
    ADD  X6, X6, X25, LSR #0
    MOV  X21, X6
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X21], #64
    MOV  X21, X6
    LD4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X21], #64
    ADD  X6, X6, X25, ASR #0
    MOV  X21, X6
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X21], #64
    MOV  X21, X6
    LD4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X21], #64
    ADD  X6, X6, X25, ASR #0
    MOV  X21, X6
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X21], #64
    MOV  X21, X6
    LD4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X21], #64
    ADD  X6, X6, X25, LSR #0
    MOV  X21, X6
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X21], #64
    MOV  X21, X6
    LD4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X21], #64
    ADD  X6, X6, X25, LSR #0
    MOV  X21, X6
    ST4 { V8.4H, V9.4H, V10.4H, V11.4H }, [X21], #32
    MOV  X21, X6
    LD4 { V2.4H, V3.4H, V4.4H, V5.4H }, [X21], #32
    ADD  X6, X6, X25
    MOV  X21, X6
    ST4 { V14.2S, V15.2S, V16.2S, V17.2S }, [X21], #32
    MOV  X21, X6
    LD4 { V8.2S, V9.2S, V10.2S, V11.2S }, [X21], #32
    ADD  X6, X6, X25, LSR #0
    MOV  X21, X6
    ST4 { V7.4H, V8.4H, V9.4H, V10.4H }, [X21], #32
    MOV  X21, X6
    LD4 { V11.4H, V12.4H, V13.4H, V14.4H }, [X21], #32
    ADD  X6, X6, X25, ASR #0
    MOV  X21, X6
    ST4 { V3.8B, V4.8B, V5.8B, V6.8B }, [X21], #32
    MOV  X21, X6
    LD4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X21], #32
    ADD  X6, X6, X25
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X6], X24
    LD4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X6], X24
    ADD  X6, X6, X25, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X6], X24
    LD4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X6], X24
    ADD  X6, X6, X25, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X6], X24
    LD4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X6], X24
    ADD  X6, X6, X25
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X6], X24
    LD4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X6], X24
    ADD  X6, X6, X25, ASR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X6], X24
    LD4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X6], X24
    ADD  X6, X6, X25, ASR #0
    ST4 { V6.8B, V7.8B, V8.8B, V9.8B }, [X6], X24
    LD4 { V25.2S, V26.2S, V27.2S, V28.2S }, [X6], X24
    ADD  X6, X6, X25
    ST4 { V15.2S, V16.2S, V17.2S, V18.2S }, [X6], X24
    LD4 { V2.2S, V3.2S, V4.2S, V5.2S }, [X6], X24
    ADD  X6, X6, X25, ASR #0
    ST4 { V20.4H, V21.4H, V22.4H, V23.4H }, [X6], X24
    LD4 { V16.4H, V17.4H, V18.4H, V19.4H }, [X6], X24
    ADD  X6, X6, X25
    ST4 { V22.8B, V23.8B, V24.8B, V25.8B }, [X6], X24
    LD4 { V22.8B, V23.8B, V24.8B, V25.8B }, [X6], X24
    ADD  X6, X6, X25
    ST4 { V2.H, V3.H, V4.H, V5.H }[0x7], [X6]
    LD4 { V14.H, V15.H, V16.H, V17.H }[0x4], [X6]
    ADD  X6, X6, X25
    ST4 { V24.S, V25.S, V26.S, V27.S }[0x3], [X6]
    LD4 { V12.S, V13.S, V14.S, V15.S }[0x2], [X6]
    ADD  X6, X6, X25, LSR #0
    ST4 { V3.D, V4.D, V5.D, V6.D }[0x1], [X6]
    LD4 { V29.D, V30.D, V31.D, V0.D }[0x1], [X6]
    ADD  X6, X6, X25
    ST4 { V3.B, V4.B, V5.B, V6.B }[0xb], [X6]
    LD4 { V24.B, V25.B, V26.B, V27.B }[0x4], [X6]
    ADD  X6, X6, X25
    MOV  X21, X6
    ST4 { V16.H, V17.H, V18.H, V19.H }[0x2], [X21], #8
    MOV  X21, X6
    LD4 { V3.H, V4.H, V5.H, V6.H }[0x0], [X21], #8
    ADD  X6, X6, X25, ASR #0
    ST4 { V22.H, V23.H, V24.H, V25.H }[0x2], [X6], X24
    LD4 { V16.H, V17.H, V18.H, V19.H }[0x7], [X6], X24
    ADD  X6, X6, X25, LSR #0
    MOV  X21, X6
    ST4 { V29.S, V30.S, V31.S, V0.S }[0x2], [X21], #16
    MOV  X21, X6
    LD4 { V26.S, V27.S, V28.S, V29.S }[0x3], [X21], #16
    ADD  X6, X6, X25, ASR #0
    ST4 { V1.S, V2.S, V3.S, V4.S }[0x0], [X6], X24
    LD4 { V4.S, V5.S, V6.S, V7.S }[0x3], [X6], X24
    ADD  X6, X6, X25, ASR #0
    MOV  X21, X6
    ST4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X21], #32
    MOV  X21, X6
    LD4 { V4.D, V5.D, V6.D, V7.D }[0x0], [X21], #32
    ADD  X6, X6, X25, LSR #0
    ST4 { V0.D, V1.D, V2.D, V3.D }[0x0], [X6], X24
    LD4 { V13.D, V14.D, V15.D, V16.D }[0x1], [X6], X24
    ADD  X6, X6, X25
    MOV  X21, X6
    ST4 { V26.B, V27.B, V28.B, V29.B }[0xc], [X21], #4
    MOV  X21, X6
    LD4 { V31.B, V0.B, V1.B, V2.B }[0xd], [X21], #4
    ADD  X6, X6, X25
    ST4 { V15.B, V16.B, V17.B, V18.B }[0x2], [X6], X24
    LD4 { V0.B, V1.B, V2.B, V3.B }[0xd], [X6], X24
    ADD  X6, X6, X25, LSR #0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP07_TestFail
    MRS  X18, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #32
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D1
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #32
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D2
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #32
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D3
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D4
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D5
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D6
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D7
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D8
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D9
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D10
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D11
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D12
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D13
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D14
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D15
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D16
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D17
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D18
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    MOVK  X29, #0xa500, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D19
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D20
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D21
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D22
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D23
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D24
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa500, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D25
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa500, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D26
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa500, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D27
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa500, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D28
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D29
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D30
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail
    FMOV  X18, D31
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X23, X29, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadStoreP07_TestFail

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
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    STR  X15, [X0, #0]
    LDR  P0, [X0, #0, MUL VL]
    LD4D  { Z28.D, Z29.D, Z30.D, Z31.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z24.D, Z25.D, Z26.D, Z27.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z20.D, Z21.D, Z22.D, Z23.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z16.D, Z17.D, Z18.D, Z19.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z12.D, Z13.D, Z14.D, Z15.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z8.D, Z9.D, Z10.D, Z11.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z4.D, Z5.D, Z6.D, Z7.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z0.D, Z1.D, Z2.D, Z3.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LDR  P15, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P14, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P13, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P12, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P11, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P10, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P9, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P8, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P7, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P6, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P5, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P4, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P3, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P2, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P1, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P0, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
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
    MOVZ  X15, #0xffff, LSL #0
    MOVK  X15, #0xffff, LSL #16
    MOVK  X15, #0xffff, LSL #32
    MOVK  X15, #0xffff, LSL #48
    STR  X15, [X0, #0]
    LDR  P0, [X0, #0, MUL VL]
    LD4D  { Z28.D, Z29.D, Z30.D, Z31.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z24.D, Z25.D, Z26.D, Z27.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z20.D, Z21.D, Z22.D, Z23.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z16.D, Z17.D, Z18.D, Z19.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z12.D, Z13.D, Z14.D, Z15.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z8.D, Z9.D, Z10.D, Z11.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z4.D, Z5.D, Z6.D, Z7.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LD4D  { Z0.D, Z1.D, Z2.D, Z3.D }, P0/Z, [SP, #0, MUL VL]
    ADD  SP, SP, #0x80
    LDR  P15, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P14, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P13, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P12, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P11, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P10, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P9, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P8, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P7, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P6, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P5, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P4, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P3, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P2, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P1, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
    LDR  P0, [SP, #0, MUL VL]
    ADD  SP, SP, #0x10
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
