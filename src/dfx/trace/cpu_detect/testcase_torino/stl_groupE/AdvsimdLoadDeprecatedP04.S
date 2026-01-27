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
    MOVZ  X2, #0x90ac, LSL #0
    MOVK  X2, #0xd285, LSL #16
    MOVK  X2, #0x351a, LSL #32
    MOVK  X2, #0xe04, LSL #48
    MOVZ  X4, #0x780f, LSL #0
    MOVK  X4, #0x54f3, LSL #16
    MOVK  X4, #0xff15, LSL #32
    MOVK  X4, #0xdad8, LSL #48
    MOVZ  X7, #0x3177, LSL #0
    MOVK  X7, #0xf66, LSL #16
    MOVK  X7, #0x7876, LSL #32
    MOVK  X7, #0xb77a, LSL #48
    MOVZ  X8, #0x313b, LSL #0
    MOVK  X8, #0xe963, LSL #16
    MOVK  X8, #0x2e38, LSL #32
    MOVK  X8, #0xa8be, LSL #48
    MOVZ  X9, #0xfcd5, LSL #0
    MOVK  X9, #0xb9ba, LSL #16
    MOVK  X9, #0xf22f, LSL #32
    MOVK  X9, #0xc42, LSL #48
    MOVZ  X10, #0xea5e, LSL #0
    MOVK  X10, #0x43b5, LSL #16
    MOVK  X10, #0x50b6, LSL #32
    MOVK  X10, #0x4ab5, LSL #48
    MOVZ  X11, #0x7357, LSL #0
    MOVK  X11, #0xafe2, LSL #16
    MOVK  X11, #0x65b, LSL #32
    MOVK  X11, #0x302d, LSL #48
    MOVZ  X12, #0x3536, LSL #0
    MOVK  X12, #0xffb9, LSL #16
    MOVK  X12, #0x6602, LSL #32
    MOVK  X12, #0x7c43, LSL #48
    MOVZ  X13, #0x4533, LSL #0
    MOVK  X13, #0x783b, LSL #16
    MOVK  X13, #0x72f1, LSL #32
    MOVK  X13, #0x2a56, LSL #48
    MOVZ  X14, #0x3549, LSL #0
    MOVK  X14, #0xc205, LSL #16
    MOVK  X14, #0xce2b, LSL #32
    MOVK  X14, #0x38a4, LSL #48
    MOVZ  X15, #0x176e, LSL #0
    MOVK  X15, #0xa225, LSL #16
    MOVK  X15, #0x720, LSL #32
    MOVK  X15, #0x46e0, LSL #48
    MOVZ  X16, #0xfc93, LSL #0
    MOVK  X16, #0x2e82, LSL #16
    MOVK  X16, #0x1134, LSL #32
    MOVK  X16, #0x3ecc, LSL #48
    MOVZ  X17, #0x5828, LSL #0
    MOVK  X17, #0xb316, LSL #16
    MOVK  X17, #0x3a9e, LSL #32
    MOVK  X17, #0x3977, LSL #48
    MOVZ  X18, #0x9ba0, LSL #0
    MOVK  X18, #0x6923, LSL #16
    MOVK  X18, #0x5ec, LSL #32
    MOVK  X18, #0x5417, LSL #48
    MOVZ  X19, #0x5ccb, LSL #0
    MOVK  X19, #0xf34f, LSL #16
    MOVK  X19, #0x48a9, LSL #32
    MOVK  X19, #0xa787, LSL #48
    MOVZ  X20, #0x7d67, LSL #0
    MOVK  X20, #0x80f3, LSL #16
    MOVK  X20, #0x5163, LSL #32
    MOVK  X20, #0x7d70, LSL #48
    MOVZ  X21, #0x3a96, LSL #0
    MOVK  X21, #0x15cd, LSL #16
    MOVK  X21, #0xa077, LSL #32
    MOVK  X21, #0x9a0d, LSL #48
    MOVZ  X22, #0x415, LSL #0
    MOVK  X22, #0xb4cf, LSL #16
    MOVK  X22, #0x86a6, LSL #32
    MOVK  X22, #0xbf9a, LSL #48
    MOVZ  X23, #0x6da9, LSL #0
    MOVK  X23, #0xd080, LSL #16
    MOVK  X23, #0x4eac, LSL #32
    MOVK  X23, #0x48b1, LSL #48
    MOVZ  X24, #0xbd28, LSL #0
    MOVK  X24, #0xbc5a, LSL #16
    MOVK  X24, #0x17ee, LSL #32
    MOVK  X24, #0x379c, LSL #48
    MOVZ  X25, #0xc27f, LSL #0
    MOVK  X25, #0x88f7, LSL #16
    MOVK  X25, #0xc508, LSL #32
    MOVK  X25, #0x3878, LSL #48
    MOVZ  X26, #0xe956, LSL #0
    MOVK  X26, #0x7754, LSL #16
    MOVK  X26, #0x6207, LSL #32
    MOVK  X26, #0x6e0, LSL #48
    MOVZ  X27, #0xcab0, LSL #0
    MOVK  X27, #0x45bd, LSL #16
    MOVK  X27, #0x1757, LSL #32
    MOVK  X27, #0x1baa, LSL #48
    MOVZ  X28, #0x9a86, LSL #0
    MOVK  X28, #0x397f, LSL #16
    MOVK  X28, #0xc777, LSL #32
    MOVK  X28, #0xf251, LSL #48
    MOVZ  X29, #0x5937, LSL #0
    MOVK  X29, #0x8064, LSL #16
    MOVK  X29, #0x8ee8, LSL #32
    MOVK  X29, #0x1f5f, LSL #48
    MOVZ  X25, #0xb40d, LSL #0
    MOVK  X25, #0x2ca6, LSL #16
    MOVK  X25, #0x868e, LSL #32
    MOVK  X25, #0xb67, LSL #48
    MSR  FPCR, X25
    MRS  X17, FPCR
    MOVZ  X24, #0x60ff, LSL #0
    MOVK  X24, #0xffff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    AND  X17, X17, X24
    MOVZ  X24, #0x0, LSL #0
    ORR  X17, X17, X24
    MSR  FPCR, X17
    ISB  SY
    MOVZ  X25, #0xc840, LSL #0
    MOVK  X25, #0x9127, LSL #16
    MOVK  X25, #0x2a83, LSL #32
    MOVK  X25, #0xb4ae, LSL #48
    MSR  FPSR, X25
    MRS  X18, FPSR
    MOVZ  X24, #0xff60, LSL #0
    MOVK  X24, #0x7ff, LSL #16
    MOVK  X24, #0xffff, LSL #32
    MOVK  X24, #0xffff, LSL #48
    AND  X18, X18, X24
    MOVZ  X24, #0x0, LSL #0
    ORR  X18, X18, X24
    MSR  FPSR, X18
    ISB  SY
    ANDS  W13, W17, #0x380038
    MOV  X30, X1
    MOVZ  X1, #0x0, LSL #0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  D0, X23
    FMOV  V0.D[1], X27
    FMOV  D1, X16
    FMOV  V1.D[1], X26
    FMOV  D2, X29
    FMOV  V2.D[1], X17
    FMOV  D3, X28
    FMOV  V3.D[1], X15
    FMOV  D4, X12
    FMOV  V4.D[1], X15
    FMOV  D5, X10
    FMOV  V5.D[1], X17
    FMOV  D6, X20
    FMOV  V6.D[1], X25
    FMOV  D7, X21
    FMOV  V7.D[1], X29
    FMOV  D8, X15
    FMOV  V8.D[1], X11
    FMOV  D9, X15
    FMOV  V9.D[1], X2
    FMOV  D10, X28
    FMOV  V10.D[1], X7
    FMOV  D11, X27
    FMOV  V11.D[1], X14
    FMOV  D12, X25
    FMOV  V12.D[1], X24
    FMOV  D13, X16
    FMOV  V13.D[1], X11
    FMOV  D14, X16
    FMOV  V14.D[1], X20
    FMOV  D15, X16
    FMOV  V15.D[1], X26
    FMOV  D16, X13
    FMOV  V16.D[1], X25
    FMOV  D17, X17
    FMOV  V17.D[1], X27
    FMOV  D18, X10
    FMOV  V18.D[1], X13
    FMOV  D19, X21
    FMOV  V19.D[1], X7
    FMOV  D20, X16
    FMOV  V20.D[1], X29
    FMOV  D21, X27
    FMOV  V21.D[1], X24
    FMOV  D22, X16
    FMOV  V22.D[1], X20
    FMOV  D23, X9
    FMOV  V23.D[1], X22
    FMOV  D24, X22
    FMOV  V24.D[1], X4
    FMOV  D25, X22
    FMOV  V25.D[1], X10
    FMOV  D26, X15
    FMOV  V26.D[1], X28
    FMOV  D27, X12
    FMOV  V27.D[1], X2
    FMOV  D28, X17
    FMOV  V28.D[1], X24
    FMOV  D29, X18
    FMOV  V29.D[1], X12
    FMOV  D30, X9
    FMOV  V30.D[1], X2
    FMOV  D31, X13
    FMOV  V31.D[1], X9
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X2, #0x0, LSL #0
    ADD  X13, X30, X2, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X13]
    LD4R { V28.16B, V29.16B, V30.16B, V31.16B }, [X13]
    ADD  X13, X13, X27, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X13]
    LD4R { V1.16B, V2.16B, V3.16B, V4.16B }, [X13]
    ADD  X13, X13, X27, LSR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X13]
    LD4R { V9.2D, V10.2D, V11.2D, V12.2D }, [X13]
    ADD  X13, X13, X27, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X13]
    LD4R { V8.4S, V9.4S, V10.4S, V11.4S }, [X13]
    ADD  X13, X13, X27
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X13]
    LD4R { V9.8H, V10.8H, V11.8H, V12.8H }, [X13]
    ADD  X13, X13, X27, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X13]
    LD4R { V29.4H, V30.4H, V31.4H, V0.4H }, [X13]
    ADD  X13, X13, X27, ASR #0
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X13]
    LD4R { V1.1D, V2.1D, V3.1D, V4.1D }, [X13]
    ADD  X13, X13, X27, LSR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X13]
    LD4R { V7.2S, V8.2S, V9.2S, V10.2S }, [X13]
    ADD  X13, X13, X27, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X13]
    LD4R { V16.4H, V17.4H, V18.4H, V19.4H }, [X13]
    ADD  X13, X13, X27
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X13]
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X13]
    ADD  X13, X13, X27, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X13]
    MOV  X24, X13
    LD4R { V5.2S, V6.2S, V7.2S, V8.2S }, [X24], #16
    ADD  X13, X13, X27
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X13]
    MOV  X24, X13
    LD4R { V6.2S, V7.2S, V8.2S, V9.2S }, [X24], #16
    ADD  X13, X13, X27, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X13]
    MOV  X24, X13
    LD4R { V23.4S, V24.4S, V25.4S, V26.4S }, [X24], #16
    ADD  X13, X13, X27, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X13]
    MOV  X24, X13
    LD4R { V6.2D, V7.2D, V8.2D, V9.2D }, [X24], #32
    ADD  X13, X13, X27, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X13]
    MOV  X24, X13
    LD4R { V26.1D, V27.1D, V28.1D, V29.1D }, [X24], #32
    ADD  X13, X13, X27
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X13]
    MOV  X24, X13
    LD4R { V18.2D, V19.2D, V20.2D, V21.2D }, [X24], #32
    ADD  X13, X13, X27, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X13]
    MOV  X24, X13
    LD4R { V23.16B, V24.16B, V25.16B, V26.16B }, [X24], #4
    ADD  X13, X13, X27, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X13]
    MOV  X24, X13
    LD4R { V4.16B, V5.16B, V6.16B, V7.16B }, [X24], #4
    ADD  X13, X13, X27, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X13]
    MOV  X24, X13
    LD4R { V15.8B, V16.8B, V17.8B, V18.8B }, [X24], #4
    ADD  X13, X13, X27, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X13]
    MOV  X24, X13
    LD4R { V30.4H, V31.4H, V0.4H, V1.4H }, [X24], #8
    ADD  X13, X13, X27, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X13]
    MOV  X24, X13
    LD4R { V13.8H, V14.8H, V15.8H, V16.8H }, [X24], #8
    ADD  X13, X13, X27, LSR #0
    ST4 { V30.4S, V31.4S, V0.4S, V1.4S }, [X13]
    MOV  X24, X13
    LD4R { V1.8H, V2.8H, V3.8H, V4.8H }, [X24], #8
    ADD  X13, X13, X27
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X13]
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X13], X17
    ADD  X13, X13, X27
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X13]
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X13], X17
    ADD  X13, X13, X27, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X13]
    LD4R { V23.2D, V24.2D, V25.2D, V26.2D }, [X13], X17
    ADD  X13, X13, X27, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X13]
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X13], X17
    ADD  X13, X13, X27, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X13]
    LD4R { V28.8H, V29.8H, V30.8H, V31.8H }, [X13], X17
    ADD  X13, X13, X27, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X13]
    LD4R { V31.2S, V0.2S, V1.2S, V2.2S }, [X13], X17
    ADD  X13, X13, X27, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X13]
    LD4R { V23.1D, V24.1D, V25.1D, V26.1D }, [X13], X17
    ADD  X13, X13, X27, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X13]
    LD4R { V26.2S, V27.2S, V28.2S, V29.2S }, [X13], X17
    ADD  X13, X13, X27
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X13]
    LD4R { V28.4H, V29.4H, V30.4H, V31.4H }, [X13], X17
    ADD  X13, X13, X27
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X13]
    LD4R { V13.8B, V14.8B, V15.8B, V16.8B }, [X13], X17
    ADD  X13, X13, X27, LSR #0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X16
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X19
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X25
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X23, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X23, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X14, FPSR
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D0
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D1
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D2
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D3
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D4
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D5
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D6
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D7
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D8
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D9
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D10
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D11
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D12
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D13
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D14
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D15
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D16
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D17
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D18
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D19
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D20
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D21
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D22
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D23
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D24
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D25
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D26
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D27
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D28
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D29
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D30
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X23, #0x0, LSL #0
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D31
    MOVZ  X23, #0x5a5a, LSL #0
    MOVK  X23, #0x5a5a, LSL #16
    MOVK  X23, #0x5a5a, LSL #32
    MOVK  X23, #0x5a5a, LSL #48
    SUB  X29, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X8
    FMOV  D1, X4
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X9
    FMOV  D3, X27
    FMOV  V3.D[1], X26
    FMOV  D4, X9
    FMOV  V4.D[1], X25
    FMOV  D5, X29
    FMOV  V5.D[1], X14
    FMOV  D6, X17
    FMOV  V6.D[1], X17
    FMOV  D7, X21
    FMOV  V7.D[1], X8
    FMOV  D8, X11
    FMOV  V8.D[1], X2
    FMOV  D9, X4
    FMOV  V9.D[1], X8
    FMOV  D10, X29
    FMOV  V10.D[1], X8
    FMOV  D11, X22
    FMOV  V11.D[1], X15
    FMOV  D12, X26
    FMOV  V12.D[1], X29
    FMOV  D13, X4
    FMOV  V13.D[1], X20
    FMOV  D14, X19
    FMOV  V14.D[1], X10
    FMOV  D15, X26
    FMOV  V15.D[1], X28
    FMOV  D16, X20
    FMOV  V16.D[1], X29
    FMOV  D17, X14
    FMOV  V17.D[1], X26
    FMOV  D18, X20
    FMOV  V18.D[1], X24
    FMOV  D19, X21
    FMOV  V19.D[1], X27
    FMOV  D20, X16
    FMOV  V20.D[1], X18
    FMOV  D21, X10
    FMOV  V21.D[1], X7
    FMOV  D22, X24
    FMOV  V22.D[1], X25
    FMOV  D23, X17
    FMOV  V23.D[1], X28
    FMOV  D24, X29
    FMOV  V24.D[1], X18
    FMOV  D25, X23
    FMOV  V25.D[1], X20
    FMOV  D26, X10
    FMOV  V26.D[1], X22
    FMOV  D27, X21
    FMOV  V27.D[1], X23
    FMOV  D28, X16
    FMOV  V28.D[1], X8
    FMOV  D29, X8
    FMOV  V29.D[1], X26
    FMOV  D30, X26
    FMOV  V30.D[1], X19
    FMOV  D31, X19
    FMOV  V31.D[1], X10
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X27, #0x500, LSL #0
    ADD  X8, X30, X27
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X8]
    LD4R { V7.2D, V8.2D, V9.2D, V10.2D }, [X8]
    ADD  X8, X8, X7, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X8]
    LD4R { V26.16B, V27.16B, V28.16B, V29.16B }, [X8]
    ADD  X8, X8, X7, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X8]
    LD4R { V12.2D, V13.2D, V14.2D, V15.2D }, [X8]
    ADD  X8, X8, X7
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X8]
    LD4R { V6.4S, V7.4S, V8.4S, V9.4S }, [X8]
    ADD  X8, X8, X7, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X8]
    LD4R { V10.8H, V11.8H, V12.8H, V13.8H }, [X8]
    ADD  X8, X8, X7, ASR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X8]
    LD4R { V13.2S, V14.2S, V15.2S, V16.2S }, [X8]
    ADD  X8, X8, X7, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X8]
    LD4R { V27.1D, V28.1D, V29.1D, V30.1D }, [X8]
    ADD  X8, X8, X7, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X8]
    LD4R { V6.2S, V7.2S, V8.2S, V9.2S }, [X8]
    ADD  X8, X8, X7, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X8]
    LD4R { V0.4H, V1.4H, V2.4H, V3.4H }, [X8]
    ADD  X8, X8, X7, LSR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X8]
    LD4R { V8.8B, V9.8B, V10.8B, V11.8B }, [X8]
    ADD  X8, X8, X7
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X8]
    MOV  X13, X8
    LD4R { V30.4S, V31.4S, V0.4S, V1.4S }, [X13], #16
    ADD  X8, X8, X7, LSR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X8]
    MOV  X13, X8
    LD4R { V7.2S, V8.2S, V9.2S, V10.2S }, [X13], #16
    ADD  X8, X8, X7
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X8]
    MOV  X13, X8
    LD4R { V23.4S, V24.4S, V25.4S, V26.4S }, [X13], #16
    ADD  X8, X8, X7, ASR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X8]
    MOV  X13, X8
    LD4R { V31.1D, V0.1D, V1.1D, V2.1D }, [X13], #32
    ADD  X8, X8, X7, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X8]
    MOV  X13, X8
    LD4R { V3.1D, V4.1D, V5.1D, V6.1D }, [X13], #32
    ADD  X8, X8, X7, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X8]
    MOV  X13, X8
    LD4R { V28.2D, V29.2D, V30.2D, V31.2D }, [X13], #32
    ADD  X8, X8, X7
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X8]
    MOV  X13, X8
    LD4R { V15.8B, V16.8B, V17.8B, V18.8B }, [X13], #4
    ADD  X8, X8, X7
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X8]
    MOV  X13, X8
    LD4R { V21.16B, V22.16B, V23.16B, V24.16B }, [X13], #4
    ADD  X8, X8, X7, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X8]
    MOV  X13, X8
    LD4R { V8.8B, V9.8B, V10.8B, V11.8B }, [X13], #4
    ADD  X8, X8, X7
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X8]
    MOV  X13, X8
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X13], #8
    ADD  X8, X8, X7, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X8]
    MOV  X13, X8
    LD4R { V13.8H, V14.8H, V15.8H, V16.8H }, [X13], #8
    ADD  X8, X8, X7, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X8]
    MOV  X13, X8
    LD4R { V18.4H, V19.4H, V20.4H, V21.4H }, [X13], #8
    ADD  X8, X8, X7, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X8]
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X8], X26
    ADD  X8, X8, X7, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X8]
    LD4R { V7.16B, V8.16B, V9.16B, V10.16B }, [X8], X26
    ADD  X8, X8, X7
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X8]
    LD4R { V17.2D, V18.2D, V19.2D, V20.2D }, [X8], X26
    ADD  X8, X8, X7, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X8]
    LD4R { V7.4S, V8.4S, V9.4S, V10.4S }, [X8], X26
    ADD  X8, X8, X7, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X8]
    LD4R { V21.8H, V22.8H, V23.8H, V24.8H }, [X8], X26
    ADD  X8, X8, X7, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X8]
    LD4R { V19.4H, V20.4H, V21.4H, V22.4H }, [X8], X26
    ADD  X8, X8, X7
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X8]
    LD4R { V7.1D, V8.1D, V9.1D, V10.1D }, [X8], X26
    ADD  X8, X8, X7, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X8]
    LD4R { V0.2S, V1.2S, V2.2S, V3.2S }, [X8], X26
    ADD  X8, X8, X7, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X8]
    LD4R { V19.4H, V20.4H, V21.4H, V22.4H }, [X8], X26
    ADD  X8, X8, X7, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X8]
    LD4R { V7.8B, V8.8B, V9.8B, V10.8B }, [X8], X26
    ADD  X8, X8, X7, LSR #0
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0xa5a5, LSL #0
    MOVK  X9, #0xa5a5, LSL #16
    MOVK  X9, #0xa5a5, LSL #32
    MOVK  X9, #0xa5a5, LSL #48
    SUB  X24, X9, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X9, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D1
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D2
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D3
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D4
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D5
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D6
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D7
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D8
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D9
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D10
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D11
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D12
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D13
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D14
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D15
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D16
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D17
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D18
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D19
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D20
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D21
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D22
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D23
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D24
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D25
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D26
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D27
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D28
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D29
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D30
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D31
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X21, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X24
    FMOV  D1, X7
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X10
    FMOV  V3.D[1], X19
    FMOV  D4, X11
    FMOV  V4.D[1], X11
    FMOV  D5, X2
    FMOV  V5.D[1], X29
    FMOV  D6, X9
    FMOV  V6.D[1], X14
    FMOV  D7, X19
    FMOV  V7.D[1], X24
    FMOV  D8, X24
    FMOV  V8.D[1], X8
    FMOV  D9, X7
    FMOV  V9.D[1], X28
    FMOV  D10, X13
    FMOV  V10.D[1], X20
    FMOV  D11, X13
    FMOV  V11.D[1], X11
    FMOV  D12, X16
    FMOV  V12.D[1], X25
    FMOV  D13, X21
    FMOV  V13.D[1], X2
    FMOV  D14, X24
    FMOV  V14.D[1], X2
    FMOV  D15, X15
    FMOV  V15.D[1], X14
    FMOV  D16, X17
    FMOV  V16.D[1], X10
    FMOV  D17, X27
    FMOV  V17.D[1], X14
    FMOV  D18, X19
    FMOV  V18.D[1], X19
    FMOV  D19, X2
    FMOV  V19.D[1], X22
    FMOV  D20, X18
    FMOV  V20.D[1], X7
    FMOV  D21, X28
    FMOV  V21.D[1], X10
    FMOV  D22, X10
    FMOV  V22.D[1], X21
    FMOV  D23, X9
    FMOV  V23.D[1], X15
    FMOV  D24, X12
    FMOV  V24.D[1], X12
    FMOV  D25, X2
    FMOV  V25.D[1], X23
    FMOV  D26, X25
    FMOV  V26.D[1], X15
    FMOV  D27, X15
    FMOV  V27.D[1], X10
    FMOV  D28, X7
    FMOV  V28.D[1], X12
    FMOV  D29, X15
    FMOV  V29.D[1], X25
    FMOV  D30, X10
    FMOV  V30.D[1], X27
    FMOV  D31, X16
    FMOV  V31.D[1], X12
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X2, #0xa00, LSL #0
    ADD  X19, X30, X2
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X19]
    LD4R { V26.2D, V27.2D, V28.2D, V29.2D }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X19]
    LD4R { V1.16B, V2.16B, V3.16B, V4.16B }, [X19]
    ADD  X19, X19, X15
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X19]
    LD4R { V9.2D, V10.2D, V11.2D, V12.2D }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X19]
    LD4R { V14.4S, V15.4S, V16.4S, V17.4S }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X19]
    LD4R { V8.8H, V9.8H, V10.8H, V11.8H }, [X19]
    ADD  X19, X19, X15
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X19]
    LD4R { V15.4H, V16.4H, V17.4H, V18.4H }, [X19]
    ADD  X19, X19, X15
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X19]
    LD4R { V30.1D, V31.1D, V0.1D, V1.1D }, [X19]
    ADD  X19, X19, X15, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X19]
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X19]
    LD4R { V17.4H, V18.4H, V19.4H, V20.4H }, [X19]
    ADD  X19, X19, X15
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X19]
    LD4R { V4.8B, V5.8B, V6.8B, V7.8B }, [X19]
    ADD  X19, X19, X15, LSR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X19]
    MOV  X8, X19
    LD4R { V21.4S, V22.4S, V23.4S, V24.4S }, [X8], #16
    ADD  X19, X19, X15, LSR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X19]
    MOV  X8, X19
    LD4R { V30.2S, V31.2S, V0.2S, V1.2S }, [X8], #16
    ADD  X19, X19, X15
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X19]
    MOV  X8, X19
    LD4R { V8.4S, V9.4S, V10.4S, V11.4S }, [X8], #16
    ADD  X19, X19, X15, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X19]
    MOV  X8, X19
    LD4R { V4.2D, V5.2D, V6.2D, V7.2D }, [X8], #32
    ADD  X19, X19, X15, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X19]
    MOV  X8, X19
    LD4R { V4.1D, V5.1D, V6.1D, V7.1D }, [X8], #32
    ADD  X19, X19, X15
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X19]
    MOV  X8, X19
    LD4R { V26.2D, V27.2D, V28.2D, V29.2D }, [X8], #32
    ADD  X19, X19, X15, ASR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X19]
    MOV  X8, X19
    LD4R { V11.8B, V12.8B, V13.8B, V14.8B }, [X8], #4
    ADD  X19, X19, X15, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X19]
    MOV  X8, X19
    LD4R { V17.16B, V18.16B, V19.16B, V20.16B }, [X8], #4
    ADD  X19, X19, X15, LSR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X19]
    MOV  X8, X19
    LD4R { V11.8B, V12.8B, V13.8B, V14.8B }, [X8], #4
    ADD  X19, X19, X15, LSR #0
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X19]
    MOV  X8, X19
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X8], #8
    ADD  X19, X19, X15
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X19]
    MOV  X8, X19
    LD4R { V11.8H, V12.8H, V13.8H, V14.8H }, [X8], #8
    ADD  X19, X19, X15
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X19]
    MOV  X8, X19
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X8], #8
    ADD  X19, X19, X15, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X19]
    LD4R { V5.4S, V6.4S, V7.4S, V8.4S }, [X19], X12
    ADD  X19, X19, X15
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X19]
    LD4R { V11.16B, V12.16B, V13.16B, V14.16B }, [X19], X12
    ADD  X19, X19, X15, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X19]
    LD4R { V15.2D, V16.2D, V17.2D, V18.2D }, [X19], X12
    ADD  X19, X19, X15, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X19]
    LD4R { V16.4S, V17.4S, V18.4S, V19.4S }, [X19], X12
    ADD  X19, X19, X15
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X19]
    LD4R { V10.8H, V11.8H, V12.8H, V13.8H }, [X19], X12
    ADD  X19, X19, X15, ASR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X19]
    LD4R { V16.1D, V17.1D, V18.1D, V19.1D }, [X19], X12
    ADD  X19, X19, X15, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X19]
    LD4R { V11.1D, V12.1D, V13.1D, V14.1D }, [X19], X12
    ADD  X19, X19, X15
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X19]
    LD4R { V5.2S, V6.2S, V7.2S, V8.2S }, [X19], X12
    ADD  X19, X19, X15, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X19]
    LD4R { V30.4H, V31.4H, V0.4H, V1.4H }, [X19], X12
    ADD  X19, X19, X15, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X19]
    LD4R { V11.8B, V12.8B, V13.8B, V14.8B }, [X19], X12
    ADD  X19, X19, X15
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X7
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X10
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X18
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X20
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X21
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X22
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X24
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X26
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X9, #0x5a5a, LSL #0
    MOVK  X9, #0x5a5a, LSL #16
    MOVK  X9, #0x5a5a, LSL #32
    MOVK  X9, #0x5a5a, LSL #48
    SUB  X27, X9, X28
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X9, FPSR
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D0
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D1
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V2.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D2
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V3.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D3
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D4
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D5
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D6
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D7
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D8
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V9.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D9
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V10.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D10
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D11
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V12.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D12
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D13
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V14.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D14
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V15.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D15
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D16
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D17
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V18.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D18
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D19
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V20.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D20
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V21.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D21
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V22.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D22
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V23.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D23
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V24.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D24
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V25.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D25
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V26.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D26
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V27.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D27
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V28.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D28
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V29.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D29
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D30
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X9, D31
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X29, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X12
    FMOV  V2.D[1], X21
    FMOV  D3, X19
    FMOV  V3.D[1], X15
    FMOV  D4, X16
    FMOV  V4.D[1], X17
    FMOV  D5, X15
    FMOV  V5.D[1], X14
    FMOV  D6, X16
    FMOV  V6.D[1], X14
    FMOV  D7, X4
    FMOV  V7.D[1], X9
    FMOV  D8, X13
    FMOV  V8.D[1], X26
    FMOV  D9, X7
    FMOV  V9.D[1], X23
    FMOV  D10, X15
    FMOV  V10.D[1], X15
    FMOV  D11, X4
    FMOV  V11.D[1], X20
    FMOV  D12, X2
    FMOV  V12.D[1], X25
    FMOV  D13, X26
    FMOV  V13.D[1], X2
    FMOV  D14, X8
    FMOV  V14.D[1], X18
    FMOV  D15, X15
    FMOV  V15.D[1], X17
    FMOV  D16, X18
    FMOV  V16.D[1], X19
    FMOV  D17, X27
    FMOV  V17.D[1], X24
    FMOV  D18, X23
    FMOV  V18.D[1], X21
    FMOV  D19, X13
    FMOV  V19.D[1], X9
    FMOV  D20, X23
    FMOV  V20.D[1], X15
    FMOV  D21, X13
    FMOV  V21.D[1], X12
    FMOV  D22, X15
    FMOV  V22.D[1], X13
    FMOV  D23, X24
    FMOV  V23.D[1], X9
    FMOV  D24, X15
    FMOV  V24.D[1], X11
    FMOV  D25, X22
    FMOV  V25.D[1], X28
    FMOV  D26, X20
    FMOV  V26.D[1], X15
    FMOV  D27, X29
    FMOV  V27.D[1], X23
    FMOV  D28, X22
    FMOV  V28.D[1], X26
    FMOV  D29, X23
    FMOV  V29.D[1], X25
    FMOV  D30, X13
    FMOV  V30.D[1], X12
    FMOV  D31, X27
    FMOV  V31.D[1], X7
    MOVZ  X15, #0x0, LSL #0
    MOVZ  X10, #0x40, LSL #0
    MOVZ  X27, #0xf00, LSL #0
    ADD  X7, X30, X27
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X7]
    LD4R { V2.16B, V3.16B, V4.16B, V5.16B }, [X7]
    ADD  X7, X7, X10, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X7]
    LD4R { V5.16B, V6.16B, V7.16B, V8.16B }, [X7]
    ADD  X7, X7, X10
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X7]
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X7]
    ADD  X7, X7, X10, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X7]
    LD4R { V18.4S, V19.4S, V20.4S, V21.4S }, [X7]
    ADD  X7, X7, X10, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X7]
    LD4R { V19.8H, V20.8H, V21.8H, V22.8H }, [X7]
    ADD  X7, X7, X10, LSR #0
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X7]
    LD4R { V17.2S, V18.2S, V19.2S, V20.2S }, [X7]
    ADD  X7, X7, X10, ASR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X7]
    LD4R { V8.1D, V9.1D, V10.1D, V11.1D }, [X7]
    ADD  X7, X7, X10, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X7]
    LD4R { V12.2S, V13.2S, V14.2S, V15.2S }, [X7]
    ADD  X7, X7, X10, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X7]
    LD4R { V12.4H, V13.4H, V14.4H, V15.4H }, [X7]
    ADD  X7, X7, X10, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X7]
    LD4R { V7.8B, V8.8B, V9.8B, V10.8B }, [X7]
    ADD  X7, X7, X10, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X7]
    MOV  X25, X7
    LD4R { V18.4S, V19.4S, V20.4S, V21.4S }, [X25], #16
    ADD  X7, X7, X10, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X7]
    MOV  X25, X7
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X25], #16
    ADD  X7, X7, X10, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X7]
    MOV  X25, X7
    LD4R { V16.4S, V17.4S, V18.4S, V19.4S }, [X25], #16
    ADD  X7, X7, X10
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X7]
    MOV  X25, X7
    LD4R { V8.1D, V9.1D, V10.1D, V11.1D }, [X25], #32
    ADD  X7, X7, X10
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X7]
    MOV  X25, X7
    LD4R { V13.1D, V14.1D, V15.1D, V16.1D }, [X25], #32
    ADD  X7, X7, X10, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X7]
    MOV  X25, X7
    LD4R { V25.2D, V26.2D, V27.2D, V28.2D }, [X25], #32
    ADD  X7, X7, X10, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X7]
    MOV  X25, X7
    LD4R { V21.16B, V22.16B, V23.16B, V24.16B }, [X25], #4
    ADD  X7, X7, X10, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X7]
    MOV  X25, X7
    LD4R { V28.16B, V29.16B, V30.16B, V31.16B }, [X25], #4
    ADD  X7, X7, X10, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X7]
    MOV  X25, X7
    LD4R { V25.8B, V26.8B, V27.8B, V28.8B }, [X25], #4
    ADD  X7, X7, X10, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X7]
    MOV  X25, X7
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X25], #8
    ADD  X7, X7, X10
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X7]
    MOV  X25, X7
    LD4R { V8.8H, V9.8H, V10.8H, V11.8H }, [X25], #8
    ADD  X7, X7, X10, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X7]
    MOV  X25, X7
    LD4R { V3.8H, V4.8H, V5.8H, V6.8H }, [X25], #8
    ADD  X7, X7, X10
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X7]
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X7], X15
    ADD  X7, X7, X10, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X7]
    LD4R { V3.16B, V4.16B, V5.16B, V6.16B }, [X7], X15
    ADD  X7, X7, X10
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X7]
    LD4R { V0.2D, V1.2D, V2.2D, V3.2D }, [X7], X15
    ADD  X7, X7, X10, ASR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X7]
    LD4R { V27.4S, V28.4S, V29.4S, V30.4S }, [X7], X15
    ADD  X7, X7, X10
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X7]
    LD4R { V15.8H, V16.8H, V17.8H, V18.8H }, [X7], X15
    ADD  X7, X7, X10, ASR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X7]
    LD4R { V20.2S, V21.2S, V22.2S, V23.2S }, [X7], X15
    ADD  X7, X7, X10, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X7]
    LD4R { V6.1D, V7.1D, V8.1D, V9.1D }, [X7], X15
    ADD  X7, X7, X10, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X7]
    LD4R { V8.2S, V9.2S, V10.2S, V11.2S }, [X7], X15
    ADD  X7, X7, X10
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X7]
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X7], X15
    ADD  X7, X7, X10
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X7]
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X7], X15
    ADD  X7, X7, X10, ASR #0
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X24, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X28, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D1
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D2
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D3
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D4
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D5
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D6
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D7
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D8
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D9
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D10
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D11
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D12
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D13
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D14
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D15
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D16
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D17
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D18
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D19
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D20
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D21
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D22
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D23
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D24
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D25
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D26
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D27
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D28
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D29
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D30
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D31
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X22, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X22, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  D0, X11
    FMOV  V0.D[1], X25
    FMOV  D1, X26
    FMOV  V1.D[1], X23
    FMOV  D2, X27
    FMOV  V2.D[1], X9
    FMOV  D3, X28
    FMOV  V3.D[1], X20
    FMOV  D4, X19
    FMOV  V4.D[1], X29
    FMOV  D5, X15
    FMOV  V5.D[1], X11
    FMOV  D6, X28
    FMOV  V6.D[1], X26
    FMOV  D7, X13
    FMOV  V7.D[1], X20
    FMOV  D8, X8
    FMOV  V8.D[1], X28
    FMOV  D9, X12
    FMOV  V9.D[1], X22
    FMOV  D10, X27
    FMOV  V10.D[1], X7
    FMOV  D11, X28
    FMOV  V11.D[1], X18
    FMOV  D12, X25
    FMOV  V12.D[1], X13
    FMOV  D13, X13
    FMOV  V13.D[1], X29
    FMOV  D14, X17
    FMOV  V14.D[1], X20
    FMOV  D15, X20
    FMOV  V15.D[1], X4
    FMOV  D16, X10
    FMOV  V16.D[1], X28
    FMOV  D17, X22
    FMOV  V17.D[1], X22
    FMOV  D18, X12
    FMOV  V18.D[1], X22
    FMOV  D19, X14
    FMOV  V19.D[1], X7
    FMOV  D20, X27
    FMOV  V20.D[1], X21
    FMOV  D21, X23
    FMOV  V21.D[1], X29
    FMOV  D22, X11
    FMOV  V22.D[1], X15
    FMOV  D23, X24
    FMOV  V23.D[1], X11
    FMOV  D24, X27
    FMOV  V24.D[1], X15
    FMOV  D25, X20
    FMOV  V25.D[1], X11
    FMOV  D26, X14
    FMOV  V26.D[1], X10
    FMOV  D27, X7
    FMOV  V27.D[1], X12
    FMOV  D28, X20
    FMOV  V28.D[1], X17
    FMOV  D29, X15
    FMOV  V29.D[1], X24
    FMOV  D30, X10
    FMOV  V30.D[1], X18
    FMOV  D31, X8
    FMOV  V31.D[1], X25
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X21, #0x40, LSL #0
    MOVZ  X12, #0x1400, LSL #0
    ADD  X17, X30, X12, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X17]
    LD4R { V26.4S, V27.4S, V28.4S, V29.4S }, [X17]
    ADD  X17, X17, X21
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X17]
    LD4R { V29.16B, V30.16B, V31.16B, V0.16B }, [X17]
    ADD  X17, X17, X21, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X17]
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X17]
    ADD  X17, X17, X21, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X17]
    LD4R { V1.4S, V2.4S, V3.4S, V4.4S }, [X17]
    ADD  X17, X17, X21
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X17]
    LD4R { V23.8H, V24.8H, V25.8H, V26.8H }, [X17]
    ADD  X17, X17, X21, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X17]
    LD4R { V0.2S, V1.2S, V2.2S, V3.2S }, [X17]
    ADD  X17, X17, X21, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X17]
    LD4R { V24.1D, V25.1D, V26.1D, V27.1D }, [X17]
    ADD  X17, X17, X21
    ST4 { V10.4S, V11.4S, V12.4S, V13.4S }, [X17]
    LD4R { V12.2S, V13.2S, V14.2S, V15.2S }, [X17]
    ADD  X17, X17, X21, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X17]
    LD4R { V30.4H, V31.4H, V0.4H, V1.4H }, [X17]
    ADD  X17, X17, X21, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X17]
    LD4R { V25.8B, V26.8B, V27.8B, V28.8B }, [X17]
    ADD  X17, X17, X21, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X17]
    MOV  X26, X17
    LD4R { V31.2S, V0.2S, V1.2S, V2.2S }, [X26], #16
    ADD  X17, X17, X21
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X17]
    MOV  X26, X17
    LD4R { V30.2S, V31.2S, V0.2S, V1.2S }, [X26], #16
    ADD  X17, X17, X21, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X17]
    MOV  X26, X17
    LD4R { V9.4S, V10.4S, V11.4S, V12.4S }, [X26], #16
    ADD  X17, X17, X21
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X17]
    MOV  X26, X17
    LD4R { V9.2D, V10.2D, V11.2D, V12.2D }, [X26], #32
    ADD  X17, X17, X21, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X17]
    MOV  X26, X17
    LD4R { V15.1D, V16.1D, V17.1D, V18.1D }, [X26], #32
    ADD  X17, X17, X21
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X17]
    MOV  X26, X17
    LD4R { V5.2D, V6.2D, V7.2D, V8.2D }, [X26], #32
    ADD  X17, X17, X21, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X17]
    MOV  X26, X17
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X26], #4
    ADD  X17, X17, X21, LSR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X17]
    MOV  X26, X17
    LD4R { V5.16B, V6.16B, V7.16B, V8.16B }, [X26], #4
    ADD  X17, X17, X21, ASR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X17]
    MOV  X26, X17
    LD4R { V0.8B, V1.8B, V2.8B, V3.8B }, [X26], #4
    ADD  X17, X17, X21
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X17]
    MOV  X26, X17
    LD4R { V15.4H, V16.4H, V17.4H, V18.4H }, [X26], #8
    ADD  X17, X17, X21, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X17]
    MOV  X26, X17
    LD4R { V0.8H, V1.8H, V2.8H, V3.8H }, [X26], #8
    ADD  X17, X17, X21
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X17]
    MOV  X26, X17
    LD4R { V6.8H, V7.8H, V8.8H, V9.8H }, [X26], #8
    ADD  X17, X17, X21, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X17]
    LD4R { V22.16B, V23.16B, V24.16B, V25.16B }, [X17], X9
    ADD  X17, X17, X21
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X17]
    LD4R { V15.16B, V16.16B, V17.16B, V18.16B }, [X17], X9
    ADD  X17, X17, X21, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X17]
    LD4R { V8.2D, V9.2D, V10.2D, V11.2D }, [X17], X9
    ADD  X17, X17, X21, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X17]
    LD4R { V21.4S, V22.4S, V23.4S, V24.4S }, [X17], X9
    ADD  X17, X17, X21, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X17]
    LD4R { V25.8H, V26.8H, V27.8H, V28.8H }, [X17], X9
    ADD  X17, X17, X21
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X17]
    LD4R { V18.4H, V19.4H, V20.4H, V21.4H }, [X17], X9
    ADD  X17, X17, X21, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X17]
    LD4R { V23.1D, V24.1D, V25.1D, V26.1D }, [X17], X9
    ADD  X17, X17, X21
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X17]
    LD4R { V6.2S, V7.2S, V8.2S, V9.2S }, [X17], X9
    ADD  X17, X17, X21, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X17]
    LD4R { V21.4H, V22.4H, V23.4H, V24.4H }, [X17], X9
    ADD  X17, X17, X21, LSR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X17]
    LD4R { V9.8B, V10.8B, V11.8B, V12.8B }, [X17], X9
    ADD  X17, X17, X21
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X29, X28, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X28, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D26
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D27
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D28
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X28, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X18, X29, X28
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  D1, X22
    FMOV  V1.D[1], X28
    FMOV  D2, X23
    FMOV  V2.D[1], X29
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X25
    FMOV  V4.D[1], X7
    FMOV  D5, X20
    FMOV  V5.D[1], X23
    FMOV  D6, X24
    FMOV  V6.D[1], X16
    FMOV  D7, X19
    FMOV  V7.D[1], X2
    FMOV  D8, X28
    FMOV  V8.D[1], X13
    FMOV  D9, X24
    FMOV  V9.D[1], X17
    FMOV  D10, X13
    FMOV  V10.D[1], X18
    FMOV  D11, X9
    FMOV  V11.D[1], X21
    FMOV  D12, X9
    FMOV  V12.D[1], X26
    FMOV  D13, X15
    FMOV  V13.D[1], X7
    FMOV  D14, X22
    FMOV  V14.D[1], X4
    FMOV  D15, X29
    FMOV  V15.D[1], X18
    FMOV  D16, X10
    FMOV  V16.D[1], X18
    FMOV  D17, X2
    FMOV  V17.D[1], X16
    FMOV  D18, X23
    FMOV  V18.D[1], X23
    FMOV  D19, X24
    FMOV  V19.D[1], X29
    FMOV  D20, X21
    FMOV  V20.D[1], X24
    FMOV  D21, X14
    FMOV  V21.D[1], X8
    FMOV  D22, X12
    FMOV  V22.D[1], X15
    FMOV  D23, X25
    FMOV  V23.D[1], X10
    FMOV  D24, X27
    FMOV  V24.D[1], X13
    FMOV  D25, X9
    FMOV  V25.D[1], X28
    FMOV  D26, X18
    FMOV  V26.D[1], X28
    FMOV  D27, X23
    FMOV  V27.D[1], X18
    FMOV  D28, X13
    FMOV  V28.D[1], X19
    FMOV  D29, X8
    FMOV  V29.D[1], X14
    FMOV  D30, X23
    FMOV  V30.D[1], X19
    FMOV  D31, X2
    FMOV  V31.D[1], X22
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X18, #0x1900, LSL #0
    ADD  X9, X30, X18
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X9]
    LD4R { V21.8H, V22.8H, V23.8H, V24.8H }, [X9]
    ADD  X9, X9, X27, LSR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X9]
    LD4R { V12.16B, V13.16B, V14.16B, V15.16B }, [X9]
    ADD  X9, X9, X27, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X9]
    LD4R { V17.2D, V18.2D, V19.2D, V20.2D }, [X9]
    ADD  X9, X9, X27
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X9]
    LD4R { V30.4S, V31.4S, V0.4S, V1.4S }, [X9]
    ADD  X9, X9, X27, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X9]
    LD4R { V21.8H, V22.8H, V23.8H, V24.8H }, [X9]
    ADD  X9, X9, X27, LSR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X9]
    LD4R { V11.4H, V12.4H, V13.4H, V14.4H }, [X9]
    ADD  X9, X9, X27
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X9]
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X9]
    ADD  X9, X9, X27
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X9]
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X9]
    ADD  X9, X9, X27, ASR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X9]
    LD4R { V1.4H, V2.4H, V3.4H, V4.4H }, [X9]
    ADD  X9, X9, X27, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X9]
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X9]
    ADD  X9, X9, X27
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X9]
    MOV  X14, X9
    LD4R { V31.4S, V0.4S, V1.4S, V2.4S }, [X14], #16
    ADD  X9, X9, X27
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X9]
    MOV  X14, X9
    LD4R { V20.2S, V21.2S, V22.2S, V23.2S }, [X14], #16
    ADD  X9, X9, X27, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X9]
    MOV  X14, X9
    LD4R { V31.4S, V0.4S, V1.4S, V2.4S }, [X14], #16
    ADD  X9, X9, X27, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X9]
    MOV  X14, X9
    LD4R { V26.1D, V27.1D, V28.1D, V29.1D }, [X14], #32
    ADD  X9, X9, X27
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X9]
    MOV  X14, X9
    LD4R { V12.1D, V13.1D, V14.1D, V15.1D }, [X14], #32
    ADD  X9, X9, X27
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X9]
    MOV  X14, X9
    LD4R { V17.2D, V18.2D, V19.2D, V20.2D }, [X14], #32
    ADD  X9, X9, X27, ASR #0
    ST4 { V12.8H, V13.8H, V14.8H, V15.8H }, [X9]
    MOV  X14, X9
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X14], #4
    ADD  X9, X9, X27, ASR #0
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X9]
    MOV  X14, X9
    LD4R { V13.16B, V14.16B, V15.16B, V16.16B }, [X14], #4
    ADD  X9, X9, X27
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X9]
    MOV  X14, X9
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X14], #4
    ADD  X9, X9, X27
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X9]
    MOV  X14, X9
    LD4R { V23.4H, V24.4H, V25.4H, V26.4H }, [X14], #8
    ADD  X9, X9, X27
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X9]
    MOV  X14, X9
    LD4R { V5.8H, V6.8H, V7.8H, V8.8H }, [X14], #8
    ADD  X9, X9, X27, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X9]
    MOV  X14, X9
    LD4R { V28.4H, V29.4H, V30.4H, V31.4H }, [X14], #8
    ADD  X9, X9, X27, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X9]
    LD4R { V1.8H, V2.8H, V3.8H, V4.8H }, [X9], X12
    ADD  X9, X9, X27, LSR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X9]
    LD4R { V16.16B, V17.16B, V18.16B, V19.16B }, [X9], X12
    ADD  X9, X9, X27, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X9]
    LD4R { V5.2D, V6.2D, V7.2D, V8.2D }, [X9], X12
    ADD  X9, X9, X27
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X9]
    LD4R { V9.4S, V10.4S, V11.4S, V12.4S }, [X9], X12
    ADD  X9, X9, X27
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X9]
    LD4R { V2.8H, V3.8H, V4.8H, V5.8H }, [X9], X12
    ADD  X9, X9, X27, ASR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X9]
    LD4R { V10.1D, V11.1D, V12.1D, V13.1D }, [X9], X12
    ADD  X9, X9, X27, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X9]
    LD4R { V29.1D, V30.1D, V31.1D, V0.1D }, [X9], X12
    ADD  X9, X9, X27, ASR #0
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X9]
    LD4R { V4.2S, V5.2S, V6.2S, V7.2S }, [X9], X12
    ADD  X9, X9, X27
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X9]
    LD4R { V4.4H, V5.4H, V6.4H, V7.4H }, [X9], X12
    ADD  X9, X9, X27, LSR #0
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X9]
    LD4R { V0.8B, V1.8B, V2.8B, V3.8B }, [X9], X12
    ADD  X9, X9, X27, LSR #0
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X16
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X20
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X28, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X4, FPSR
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D0
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D1
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D2
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D3
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D4
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D5
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D6
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D7
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D8
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D9
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D10
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D11
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D12
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D13
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D14
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D15
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D16
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D17
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D18
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D19
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D20
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D21
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D22
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D23
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D24
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D25
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D26
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D27
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D28
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D29
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D30
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D31
    MOVZ  X28, #0xa5a5, LSL #0
    MOVK  X28, #0xa5a5, LSL #16
    MOVK  X28, #0xa5a5, LSL #32
    MOVK  X28, #0xa5a5, LSL #48
    SUB  X21, X28, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X26
    FMOV  D3, X19
    FMOV  V3.D[1], X21
    FMOV  D4, X2
    FMOV  V4.D[1], X29
    FMOV  D5, X25
    FMOV  V5.D[1], X2
    FMOV  D6, X12
    FMOV  V6.D[1], X7
    FMOV  D7, X10
    FMOV  V7.D[1], X11
    FMOV  D8, X14
    FMOV  V8.D[1], X13
    FMOV  D9, X20
    FMOV  V9.D[1], X9
    FMOV  D10, X11
    FMOV  V10.D[1], X29
    FMOV  D11, X24
    FMOV  V11.D[1], X9
    FMOV  D12, X18
    FMOV  V12.D[1], X15
    FMOV  D13, X27
    FMOV  V13.D[1], X26
    FMOV  D14, X9
    FMOV  V14.D[1], X11
    FMOV  D15, X15
    FMOV  V15.D[1], X25
    FMOV  D16, X20
    FMOV  V16.D[1], X17
    FMOV  D17, X2
    FMOV  V17.D[1], X9
    FMOV  D18, X7
    FMOV  V18.D[1], X25
    FMOV  D19, X27
    FMOV  V19.D[1], X14
    FMOV  D20, X19
    FMOV  V20.D[1], X7
    FMOV  D21, X17
    FMOV  V21.D[1], X18
    FMOV  D22, X16
    FMOV  V22.D[1], X11
    FMOV  D23, X10
    FMOV  V23.D[1], X10
    FMOV  D24, X2
    FMOV  V24.D[1], X7
    FMOV  D25, X2
    FMOV  V25.D[1], X10
    FMOV  D26, X16
    FMOV  V26.D[1], X24
    FMOV  D27, X4
    FMOV  V27.D[1], X21
    FMOV  D28, X27
    FMOV  V28.D[1], X26
    FMOV  D29, X15
    FMOV  V29.D[1], X4
    FMOV  D30, X14
    FMOV  V30.D[1], X27
    FMOV  D31, X18
    FMOV  V31.D[1], X2
    MOVZ  X20, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X17, #0x1e00, LSL #0
    ADD  X16, X30, X17, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X16]
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X16]
    ADD  X16, X16, X24
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X16]
    LD4R { V29.16B, V30.16B, V31.16B, V0.16B }, [X16]
    ADD  X16, X16, X24
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X16]
    LD4R { V21.2D, V22.2D, V23.2D, V24.2D }, [X16]
    ADD  X16, X16, X24, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X16]
    LD4R { V16.4S, V17.4S, V18.4S, V19.4S }, [X16]
    ADD  X16, X16, X24, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X16]
    LD4R { V0.8H, V1.8H, V2.8H, V3.8H }, [X16]
    ADD  X16, X16, X24, LSR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X16]
    LD4R { V25.8B, V26.8B, V27.8B, V28.8B }, [X16]
    ADD  X16, X16, X24, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X16]
    LD4R { V15.1D, V16.1D, V17.1D, V18.1D }, [X16]
    ADD  X16, X16, X24, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X16]
    LD4R { V5.2S, V6.2S, V7.2S, V8.2S }, [X16]
    ADD  X16, X16, X24
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X16]
    LD4R { V16.4H, V17.4H, V18.4H, V19.4H }, [X16]
    ADD  X16, X16, X24, LSR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X16]
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X16]
    ADD  X16, X16, X24
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X16]
    MOV  X26, X16
    LD4R { V25.4S, V26.4S, V27.4S, V28.4S }, [X26], #16
    ADD  X16, X16, X24
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X16]
    MOV  X26, X16
    LD4R { V17.2S, V18.2S, V19.2S, V20.2S }, [X26], #16
    ADD  X16, X16, X24, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X16]
    MOV  X26, X16
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X26], #16
    ADD  X16, X16, X24, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X16]
    MOV  X26, X16
    LD4R { V21.2D, V22.2D, V23.2D, V24.2D }, [X26], #32
    ADD  X16, X16, X24, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X16]
    MOV  X26, X16
    LD4R { V17.1D, V18.1D, V19.1D, V20.1D }, [X26], #32
    ADD  X16, X16, X24
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X16]
    MOV  X26, X16
    LD4R { V7.2D, V8.2D, V9.2D, V10.2D }, [X26], #32
    ADD  X16, X16, X24
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X16]
    MOV  X26, X16
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X26], #4
    ADD  X16, X16, X24, LSR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X16]
    MOV  X26, X16
    LD4R { V1.16B, V2.16B, V3.16B, V4.16B }, [X26], #4
    ADD  X16, X16, X24, ASR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X16]
    MOV  X26, X16
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X26], #4
    ADD  X16, X16, X24, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X16]
    MOV  X26, X16
    LD4R { V19.4H, V20.4H, V21.4H, V22.4H }, [X26], #8
    ADD  X16, X16, X24
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X16]
    MOV  X26, X16
    LD4R { V17.8H, V18.8H, V19.8H, V20.8H }, [X26], #8
    ADD  X16, X16, X24
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X16]
    MOV  X26, X16
    LD4R { V8.4H, V9.4H, V10.4H, V11.4H }, [X26], #8
    ADD  X16, X16, X24, ASR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X16]
    LD4R { V24.2D, V25.2D, V26.2D, V27.2D }, [X16], X20
    ADD  X16, X16, X24
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X16]
    LD4R { V1.16B, V2.16B, V3.16B, V4.16B }, [X16], X20
    ADD  X16, X16, X24, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X16]
    LD4R { V24.2D, V25.2D, V26.2D, V27.2D }, [X16], X20
    ADD  X16, X16, X24, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X16]
    LD4R { V9.4S, V10.4S, V11.4S, V12.4S }, [X16], X20
    ADD  X16, X16, X24
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X16]
    LD4R { V4.8H, V5.8H, V6.8H, V7.8H }, [X16], X20
    ADD  X16, X16, X24
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X16]
    LD4R { V28.1D, V29.1D, V30.1D, V31.1D }, [X16], X20
    ADD  X16, X16, X24
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X16]
    LD4R { V6.1D, V7.1D, V8.1D, V9.1D }, [X16], X20
    ADD  X16, X16, X24, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X16]
    LD4R { V4.2S, V5.2S, V6.2S, V7.2S }, [X16], X20
    ADD  X16, X16, X24, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X16]
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X16], X20
    ADD  X16, X16, X24
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X16]
    LD4R { V12.8B, V13.8B, V14.8B, V15.8B }, [X16], X20
    ADD  X16, X16, X24, ASR #0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X21
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X28, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X8, FPSR
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D1
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D2
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D3
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D4
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D5
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D6
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D7
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D8
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D9
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D10
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D11
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D12
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D13
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D14
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D15
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D16
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D17
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D18
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D19
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D20
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D21
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D22
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D23
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D24
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D25
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D26
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D27
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D28
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D29
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D30
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D31
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X7, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  D1, X26
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X27
    FMOV  D3, X26
    FMOV  V3.D[1], X24
    FMOV  D4, X17
    FMOV  V4.D[1], X10
    FMOV  D5, X19
    FMOV  V5.D[1], X4
    FMOV  D6, X9
    FMOV  V6.D[1], X17
    FMOV  D7, X8
    FMOV  V7.D[1], X18
    FMOV  D8, X17
    FMOV  V8.D[1], X12
    FMOV  D9, X23
    FMOV  V9.D[1], X27
    FMOV  D10, X14
    FMOV  V10.D[1], X22
    FMOV  D11, X10
    FMOV  V11.D[1], X11
    FMOV  D12, X17
    FMOV  V12.D[1], X23
    FMOV  D13, X20
    FMOV  V13.D[1], X2
    FMOV  D14, X15
    FMOV  V14.D[1], X21
    FMOV  D15, X26
    FMOV  V15.D[1], X12
    FMOV  D16, X21
    FMOV  V16.D[1], X25
    FMOV  D17, X27
    FMOV  V17.D[1], X4
    FMOV  D18, X12
    FMOV  V18.D[1], X26
    FMOV  D19, X10
    FMOV  V19.D[1], X22
    FMOV  D20, X8
    FMOV  V20.D[1], X23
    FMOV  D21, X28
    FMOV  V21.D[1], X15
    FMOV  D22, X10
    FMOV  V22.D[1], X28
    FMOV  D23, X25
    FMOV  V23.D[1], X28
    FMOV  D24, X12
    FMOV  V24.D[1], X7
    FMOV  D25, X12
    FMOV  V25.D[1], X21
    FMOV  D26, X18
    FMOV  V26.D[1], X28
    FMOV  D27, X24
    FMOV  V27.D[1], X28
    FMOV  D28, X13
    FMOV  V28.D[1], X14
    FMOV  D29, X4
    FMOV  V29.D[1], X10
    FMOV  D30, X9
    FMOV  V30.D[1], X23
    FMOV  D31, X25
    FMOV  V31.D[1], X7
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X19, #0x2300, LSL #0
    ADD  X17, X30, X19, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X17]
    LD4R { V11.4S, V12.4S, V13.4S, V14.4S }, [X17]
    ADD  X17, X17, X26, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X17]
    LD4R { V5.16B, V6.16B, V7.16B, V8.16B }, [X17]
    ADD  X17, X17, X26, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X17]
    LD4R { V25.2D, V26.2D, V27.2D, V28.2D }, [X17]
    ADD  X17, X17, X26, LSR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X17]
    LD4R { V25.4S, V26.4S, V27.4S, V28.4S }, [X17]
    ADD  X17, X17, X26, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X17]
    LD4R { V5.8H, V6.8H, V7.8H, V8.8H }, [X17]
    ADD  X17, X17, X26, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X17]
    LD4R { V25.4H, V26.4H, V27.4H, V28.4H }, [X17]
    ADD  X17, X17, X26, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X17]
    LD4R { V11.1D, V12.1D, V13.1D, V14.1D }, [X17]
    ADD  X17, X17, X26, ASR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X17]
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X17]
    ADD  X17, X17, X26, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X17]
    LD4R { V25.4H, V26.4H, V27.4H, V28.4H }, [X17]
    ADD  X17, X17, X26
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X17]
    LD4R { V19.8B, V20.8B, V21.8B, V22.8B }, [X17]
    ADD  X17, X17, X26, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X17]
    MOV  X8, X17
    LD4R { V11.2S, V12.2S, V13.2S, V14.2S }, [X8], #16
    ADD  X17, X17, X26, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X17]
    MOV  X8, X17
    LD4R { V20.2S, V21.2S, V22.2S, V23.2S }, [X8], #16
    ADD  X17, X17, X26, LSR #0
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X17]
    MOV  X8, X17
    LD4R { V11.4S, V12.4S, V13.4S, V14.4S }, [X8], #16
    ADD  X17, X17, X26, ASR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X17]
    MOV  X8, X17
    LD4R { V26.2D, V27.2D, V28.2D, V29.2D }, [X8], #32
    ADD  X17, X17, X26, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X17]
    MOV  X8, X17
    LD4R { V11.1D, V12.1D, V13.1D, V14.1D }, [X8], #32
    ADD  X17, X17, X26, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X17]
    MOV  X8, X17
    LD4R { V12.2D, V13.2D, V14.2D, V15.2D }, [X8], #32
    ADD  X17, X17, X26, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X17]
    MOV  X8, X17
    LD4R { V29.8B, V30.8B, V31.8B, V0.8B }, [X8], #4
    ADD  X17, X17, X26
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X17]
    MOV  X8, X17
    LD4R { V0.16B, V1.16B, V2.16B, V3.16B }, [X8], #4
    ADD  X17, X17, X26
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X17]
    MOV  X8, X17
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X8], #4
    ADD  X17, X17, X26, ASR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X17]
    MOV  X8, X17
    LD4R { V9.4H, V10.4H, V11.4H, V12.4H }, [X8], #8
    ADD  X17, X17, X26
    ST4 { V11.2D, V12.2D, V13.2D, V14.2D }, [X17]
    MOV  X8, X17
    LD4R { V19.8H, V20.8H, V21.8H, V22.8H }, [X8], #8
    ADD  X17, X17, X26, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X17]
    MOV  X8, X17
    LD4R { V22.4H, V23.4H, V24.4H, V25.4H }, [X8], #8
    ADD  X17, X17, X26, ASR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X17]
    LD4R { V10.2D, V11.2D, V12.2D, V13.2D }, [X17], X28
    ADD  X17, X17, X26
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X17]
    LD4R { V12.16B, V13.16B, V14.16B, V15.16B }, [X17], X28
    ADD  X17, X17, X26, ASR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X17]
    LD4R { V15.2D, V16.2D, V17.2D, V18.2D }, [X17], X28
    ADD  X17, X17, X26, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X17]
    LD4R { V13.4S, V14.4S, V15.4S, V16.4S }, [X17], X28
    ADD  X17, X17, X26
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X17]
    LD4R { V28.8H, V29.8H, V30.8H, V31.8H }, [X17], X28
    ADD  X17, X17, X26, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X17]
    LD4R { V19.2S, V20.2S, V21.2S, V22.2S }, [X17], X28
    ADD  X17, X17, X26, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X17]
    LD4R { V8.1D, V9.1D, V10.1D, V11.1D }, [X17], X28
    ADD  X17, X17, X26, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X17]
    LD4R { V21.2S, V22.2S, V23.2S, V24.2S }, [X17], X28
    ADD  X17, X17, X26
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X17]
    LD4R { V19.4H, V20.4H, V21.4H, V22.4H }, [X17], X28
    ADD  X17, X17, X26, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X17]
    LD4R { V13.8B, V14.8B, V15.8B, V16.8B }, [X17], X28
    ADD  X17, X17, X26
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X10
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X18, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X18, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X2, FPSR
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D0
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D1
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D2
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D3
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D4
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D5
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D6
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D7
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D8
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D9
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D10
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D11
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D12
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D13
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D14
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D15
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D16
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D17
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D18
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D19
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D20
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D21
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D22
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D23
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D24
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X18, #0x0, LSL #0
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D25
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D26
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D27
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D28
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D29
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D30
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D31
    MOVZ  X18, #0xa5a5, LSL #0
    MOVK  X18, #0xa5a5, LSL #16
    MOVK  X18, #0xa5a5, LSL #32
    MOVK  X18, #0xa5a5, LSL #48
    SUB  X29, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  D1, X4
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X27
    FMOV  D3, X12
    FMOV  V3.D[1], X13
    FMOV  D4, X8
    FMOV  V4.D[1], X25
    FMOV  D5, X21
    FMOV  V5.D[1], X18
    FMOV  D6, X22
    FMOV  V6.D[1], X13
    FMOV  D7, X7
    FMOV  V7.D[1], X11
    FMOV  D8, X12
    FMOV  V8.D[1], X27
    FMOV  D9, X19
    FMOV  V9.D[1], X12
    FMOV  D10, X9
    FMOV  V10.D[1], X27
    FMOV  D11, X14
    FMOV  V11.D[1], X9
    FMOV  D12, X29
    FMOV  V12.D[1], X27
    FMOV  D13, X4
    FMOV  V13.D[1], X11
    FMOV  D14, X4
    FMOV  V14.D[1], X19
    FMOV  D15, X19
    FMOV  V15.D[1], X18
    FMOV  D16, X24
    FMOV  V16.D[1], X17
    FMOV  D17, X12
    FMOV  V17.D[1], X23
    FMOV  D18, X2
    FMOV  V18.D[1], X25
    FMOV  D19, X29
    FMOV  V19.D[1], X23
    FMOV  D20, X29
    FMOV  V20.D[1], X15
    FMOV  D21, X22
    FMOV  V21.D[1], X20
    FMOV  D22, X19
    FMOV  V22.D[1], X9
    FMOV  D23, X7
    FMOV  V23.D[1], X7
    FMOV  D24, X15
    FMOV  V24.D[1], X15
    FMOV  D25, X29
    FMOV  V25.D[1], X9
    FMOV  D26, X22
    FMOV  V26.D[1], X17
    FMOV  D27, X27
    FMOV  V27.D[1], X28
    FMOV  D28, X11
    FMOV  V28.D[1], X29
    FMOV  D29, X22
    FMOV  V29.D[1], X14
    FMOV  D30, X25
    FMOV  V30.D[1], X10
    FMOV  D31, X10
    FMOV  V31.D[1], X13
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X29, #0x40, LSL #0
    MOVZ  X19, #0x2800, LSL #0
    ADD  X27, X30, X19
    ST4 { V1.4S, V2.4S, V3.4S, V4.4S }, [X27]
    LD4R { V24.16B, V25.16B, V26.16B, V27.16B }, [X27]
    ADD  X27, X27, X29
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X27]
    LD4R { V4.16B, V5.16B, V6.16B, V7.16B }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X27]
    LD4R { V9.2D, V10.2D, V11.2D, V12.2D }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X27]
    LD4R { V16.4S, V17.4S, V18.4S, V19.4S }, [X27]
    ADD  X27, X27, X29
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X27]
    LD4R { V30.8H, V31.8H, V0.8H, V1.8H }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X27]
    LD4R { V29.4H, V30.4H, V31.4H, V0.4H }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X27]
    LD4R { V24.1D, V25.1D, V26.1D, V27.1D }, [X27]
    ADD  X27, X27, X29, ASR #0
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X27]
    LD4R { V4.2S, V5.2S, V6.2S, V7.2S }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST4 { V18.8H, V19.8H, V20.8H, V21.8H }, [X27]
    LD4R { V29.4H, V30.4H, V31.4H, V0.4H }, [X27]
    ADD  X27, X27, X29, LSR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X27]
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X27]
    ADD  X27, X27, X29
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X27]
    MOV  X7, X27
    LD4R { V25.4S, V26.4S, V27.4S, V28.4S }, [X7], #16
    ADD  X27, X27, X29
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X27]
    MOV  X7, X27
    LD4R { V26.2S, V27.2S, V28.2S, V29.2S }, [X7], #16
    ADD  X27, X27, X29, LSR #0
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X27]
    MOV  X7, X27
    LD4R { V13.4S, V14.4S, V15.4S, V16.4S }, [X7], #16
    ADD  X27, X27, X29
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X27]
    MOV  X7, X27
    LD4R { V13.1D, V14.1D, V15.1D, V16.1D }, [X7], #32
    ADD  X27, X27, X29, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X27]
    MOV  X7, X27
    LD4R { V24.1D, V25.1D, V26.1D, V27.1D }, [X7], #32
    ADD  X27, X27, X29
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X27]
    MOV  X7, X27
    LD4R { V29.2D, V30.2D, V31.2D, V0.2D }, [X7], #32
    ADD  X27, X27, X29
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X27]
    MOV  X7, X27
    LD4R { V19.8B, V20.8B, V21.8B, V22.8B }, [X7], #4
    ADD  X27, X27, X29, ASR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X27]
    MOV  X7, X27
    LD4R { V4.16B, V5.16B, V6.16B, V7.16B }, [X7], #4
    ADD  X27, X27, X29, LSR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X27]
    MOV  X7, X27
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X7], #4
    ADD  X27, X27, X29
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X27]
    MOV  X7, X27
    LD4R { V19.4H, V20.4H, V21.4H, V22.4H }, [X7], #8
    ADD  X27, X27, X29, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X27]
    MOV  X7, X27
    LD4R { V2.8H, V3.8H, V4.8H, V5.8H }, [X7], #8
    ADD  X27, X27, X29
    ST4 { V4.4S, V5.4S, V6.4S, V7.4S }, [X27]
    MOV  X7, X27
    LD4R { V10.8H, V11.8H, V12.8H, V13.8H }, [X7], #8
    ADD  X27, X27, X29
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X27]
    LD4R { V23.2D, V24.2D, V25.2D, V26.2D }, [X27], X9
    ADD  X27, X27, X29, LSR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X27]
    LD4R { V23.16B, V24.16B, V25.16B, V26.16B }, [X27], X9
    ADD  X27, X27, X29, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X27]
    LD4R { V25.2D, V26.2D, V27.2D, V28.2D }, [X27], X9
    ADD  X27, X27, X29, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X27]
    LD4R { V16.4S, V17.4S, V18.4S, V19.4S }, [X27], X9
    ADD  X27, X27, X29
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X27]
    LD4R { V18.8H, V19.8H, V20.8H, V21.8H }, [X27], X9
    ADD  X27, X27, X29, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X27]
    LD4R { V27.1D, V28.1D, V29.1D, V30.1D }, [X27], X9
    ADD  X27, X27, X29, LSR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X27]
    LD4R { V0.1D, V1.1D, V2.1D, V3.1D }, [X27], X9
    ADD  X27, X27, X29, LSR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X27]
    LD4R { V24.2S, V25.2S, V26.2S, V27.2S }, [X27], X9
    ADD  X27, X27, X29, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X27]
    LD4R { V12.4H, V13.4H, V14.4H, V15.4H }, [X27], X9
    ADD  X27, X27, X29, ASR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X27]
    LD4R { V29.8B, V30.8B, V31.8B, V0.8B }, [X27], X9
    ADD  X27, X27, X29, ASR #0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X8
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X11
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X12
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X17
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X18
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X20
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X21
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X22
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X25
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X24, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X24, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X13, FPSR
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D1
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D2
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D3
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D4
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D5
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D6
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D7
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D8
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D9
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D10
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D11
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D12
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D13
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D14
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D15
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D16
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D17
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D18
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D19
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D20
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D21
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D22
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D23
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D24
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D25
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D26
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D27
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D28
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D29
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D30
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X24, #0x0, LSL #0
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X13, D31
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X16, X24, X13
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  D0, X8
    FMOV  V0.D[1], X23
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X20
    FMOV  V2.D[1], X10
    FMOV  D3, X26
    FMOV  V3.D[1], X4
    FMOV  D4, X18
    FMOV  V4.D[1], X28
    FMOV  D5, X29
    FMOV  V5.D[1], X9
    FMOV  D6, X25
    FMOV  V6.D[1], X22
    FMOV  D7, X21
    FMOV  V7.D[1], X23
    FMOV  D8, X4
    FMOV  V8.D[1], X12
    FMOV  D9, X24
    FMOV  V9.D[1], X10
    FMOV  D10, X16
    FMOV  V10.D[1], X24
    FMOV  D11, X26
    FMOV  V11.D[1], X19
    FMOV  D12, X8
    FMOV  V12.D[1], X17
    FMOV  D13, X25
    FMOV  V13.D[1], X7
    FMOV  D14, X16
    FMOV  V14.D[1], X13
    FMOV  D15, X22
    FMOV  V15.D[1], X9
    FMOV  D16, X2
    FMOV  V16.D[1], X4
    FMOV  D17, X17
    FMOV  V17.D[1], X4
    FMOV  D18, X17
    FMOV  V18.D[1], X15
    FMOV  D19, X14
    FMOV  V19.D[1], X9
    FMOV  D20, X24
    FMOV  V20.D[1], X19
    FMOV  D21, X23
    FMOV  V21.D[1], X8
    FMOV  D22, X7
    FMOV  V22.D[1], X24
    FMOV  D23, X11
    FMOV  V23.D[1], X16
    FMOV  D24, X12
    FMOV  V24.D[1], X19
    FMOV  D25, X15
    FMOV  V25.D[1], X27
    FMOV  D26, X2
    FMOV  V26.D[1], X10
    FMOV  D27, X15
    FMOV  V27.D[1], X26
    FMOV  D28, X21
    FMOV  V28.D[1], X4
    FMOV  D29, X13
    FMOV  V29.D[1], X16
    FMOV  D30, X20
    FMOV  V30.D[1], X22
    FMOV  D31, X17
    FMOV  V31.D[1], X28
    MOVZ  X25, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X19, #0x2d00, LSL #0
    ADD  X10, X30, X19, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X10]
    LD4R { V23.16B, V24.16B, V25.16B, V26.16B }, [X10]
    ADD  X10, X10, X14, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X10]
    LD4R { V1.16B, V2.16B, V3.16B, V4.16B }, [X10]
    ADD  X10, X10, X14
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X10]
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X10]
    ADD  X10, X10, X14, LSR #0
    ST4 { V22.4S, V23.4S, V24.4S, V25.4S }, [X10]
    LD4R { V3.4S, V4.4S, V5.4S, V6.4S }, [X10]
    ADD  X10, X10, X14, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X10]
    LD4R { V19.8H, V20.8H, V21.8H, V22.8H }, [X10]
    ADD  X10, X10, X14, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X10]
    LD4R { V24.1D, V25.1D, V26.1D, V27.1D }, [X10]
    ADD  X10, X10, X14
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X10]
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X10]
    ADD  X10, X10, X14, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X10]
    LD4R { V12.2S, V13.2S, V14.2S, V15.2S }, [X10]
    ADD  X10, X10, X14, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X10]
    LD4R { V20.4H, V21.4H, V22.4H, V23.4H }, [X10]
    ADD  X10, X10, X14, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X10]
    LD4R { V2.8B, V3.8B, V4.8B, V5.8B }, [X10]
    ADD  X10, X10, X14, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X10]
    MOV  X9, X10
    LD4R { V15.2S, V16.2S, V17.2S, V18.2S }, [X9], #16
    ADD  X10, X10, X14, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X10]
    MOV  X9, X10
    LD4R { V3.2S, V4.2S, V5.2S, V6.2S }, [X9], #16
    ADD  X10, X10, X14, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X10]
    MOV  X9, X10
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X9], #16
    ADD  X10, X10, X14
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X10]
    MOV  X9, X10
    LD4R { V20.1D, V21.1D, V22.1D, V23.1D }, [X9], #32
    ADD  X10, X10, X14
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X10]
    MOV  X9, X10
    LD4R { V11.1D, V12.1D, V13.1D, V14.1D }, [X9], #32
    ADD  X10, X10, X14
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X10]
    MOV  X9, X10
    LD4R { V15.2D, V16.2D, V17.2D, V18.2D }, [X9], #32
    ADD  X10, X10, X14, LSR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X10]
    MOV  X9, X10
    LD4R { V15.8B, V16.8B, V17.8B, V18.8B }, [X9], #4
    ADD  X10, X10, X14, LSR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X10]
    MOV  X9, X10
    LD4R { V9.16B, V10.16B, V11.16B, V12.16B }, [X9], #4
    ADD  X10, X10, X14, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X10]
    MOV  X9, X10
    LD4R { V6.8B, V7.8B, V8.8B, V9.8B }, [X9], #4
    ADD  X10, X10, X14, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X10]
    MOV  X9, X10
    LD4R { V29.4H, V30.4H, V31.4H, V0.4H }, [X9], #8
    ADD  X10, X10, X14, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X10]
    MOV  X9, X10
    LD4R { V28.8H, V29.8H, V30.8H, V31.8H }, [X9], #8
    ADD  X10, X10, X14, LSR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X10]
    MOV  X9, X10
    LD4R { V9.4H, V10.4H, V11.4H, V12.4H }, [X9], #8
    ADD  X10, X10, X14
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X10]
    LD4R { V8.2D, V9.2D, V10.2D, V11.2D }, [X10], X25
    ADD  X10, X10, X14, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X10]
    LD4R { V31.16B, V0.16B, V1.16B, V2.16B }, [X10], X25
    ADD  X10, X10, X14, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X10]
    LD4R { V6.2D, V7.2D, V8.2D, V9.2D }, [X10], X25
    ADD  X10, X10, X14, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X10]
    LD4R { V12.4S, V13.4S, V14.4S, V15.4S }, [X10], X25
    ADD  X10, X10, X14, LSR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X10]
    LD4R { V7.8H, V8.8H, V9.8H, V10.8H }, [X10], X25
    ADD  X10, X10, X14, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X10]
    LD4R { V7.1D, V8.1D, V9.1D, V10.1D }, [X10], X25
    ADD  X10, X10, X14, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X10]
    LD4R { V15.1D, V16.1D, V17.1D, V18.1D }, [X10], X25
    ADD  X10, X10, X14, ASR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X10]
    LD4R { V15.2S, V16.2S, V17.2S, V18.2S }, [X10], X25
    ADD  X10, X10, X14, ASR #0
    ST4 { V12.16B, V13.16B, V14.16B, V15.16B }, [X10]
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X10], X25
    ADD  X10, X10, X14
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X10]
    LD4R { V30.8B, V31.8B, V0.8B, V1.8B }, [X10], X25
    ADD  X10, X10, X14
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X20
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X2, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D1
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D2
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D3
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D4
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D5
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D6
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D7
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D8
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D9
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D10
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D11
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D12
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D13
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D14
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D15
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D16
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D17
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D18
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D19
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D20
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D21
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D22
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D23
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D24
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D25
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D26
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D27
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D28
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D29
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D30
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X2, D31
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X11, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  D1, X17
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X15
    FMOV  D3, X24
    FMOV  V3.D[1], X14
    FMOV  D4, X15
    FMOV  V4.D[1], X4
    FMOV  D5, X8
    FMOV  V5.D[1], X27
    FMOV  D6, X26
    FMOV  V6.D[1], X26
    FMOV  D7, X22
    FMOV  V7.D[1], X19
    FMOV  D8, X21
    FMOV  V8.D[1], X4
    FMOV  D9, X12
    FMOV  V9.D[1], X20
    FMOV  D10, X13
    FMOV  V10.D[1], X25
    FMOV  D11, X14
    FMOV  V11.D[1], X13
    FMOV  D12, X14
    FMOV  V12.D[1], X2
    FMOV  D13, X21
    FMOV  V13.D[1], X4
    FMOV  D14, X20
    FMOV  V14.D[1], X11
    FMOV  D15, X8
    FMOV  V15.D[1], X9
    FMOV  D16, X24
    FMOV  V16.D[1], X26
    FMOV  D17, X19
    FMOV  V17.D[1], X7
    FMOV  D18, X10
    FMOV  V18.D[1], X26
    FMOV  D19, X4
    FMOV  V19.D[1], X19
    FMOV  D20, X27
    FMOV  V20.D[1], X11
    FMOV  D21, X16
    FMOV  V21.D[1], X29
    FMOV  D22, X4
    FMOV  V22.D[1], X17
    FMOV  D23, X12
    FMOV  V23.D[1], X18
    FMOV  D24, X24
    FMOV  V24.D[1], X26
    FMOV  D25, X14
    FMOV  V25.D[1], X12
    FMOV  D26, X29
    FMOV  V26.D[1], X22
    FMOV  D27, X8
    FMOV  V27.D[1], X27
    FMOV  D28, X2
    FMOV  V28.D[1], X26
    FMOV  D29, X12
    FMOV  V29.D[1], X17
    FMOV  D30, X14
    FMOV  V30.D[1], X27
    FMOV  D31, X9
    FMOV  V31.D[1], X10
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X19, #0x0, LSL #0
    ADD  X22, X30, X19
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X22]
    LD4R { V22.8H, V23.8H, V24.8H, V25.8H }, [X22]
    ADD  X22, X22, X16
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X22]
    LD4R { V19.16B, V20.16B, V21.16B, V22.16B }, [X22]
    ADD  X22, X22, X16
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X22]
    LD4R { V28.2D, V29.2D, V30.2D, V31.2D }, [X22]
    ADD  X22, X22, X16, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X22]
    LD4R { V15.4S, V16.4S, V17.4S, V18.4S }, [X22]
    ADD  X22, X22, X16
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X22]
    LD4R { V11.8H, V12.8H, V13.8H, V14.8H }, [X22]
    ADD  X22, X22, X16, ASR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X22]
    LD4R { V24.8B, V25.8B, V26.8B, V27.8B }, [X22]
    ADD  X22, X22, X16, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X22]
    LD4R { V19.1D, V20.1D, V21.1D, V22.1D }, [X22]
    ADD  X22, X22, X16, ASR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X22]
    LD4R { V2.2S, V3.2S, V4.2S, V5.2S }, [X22]
    ADD  X22, X22, X16
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X22]
    LD4R { V20.4H, V21.4H, V22.4H, V23.4H }, [X22]
    ADD  X22, X22, X16, LSR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X22]
    LD4R { V25.8B, V26.8B, V27.8B, V28.8B }, [X22]
    ADD  X22, X22, X16, LSR #0
    ST4 { V19.16B, V20.16B, V21.16B, V22.16B }, [X22]
    MOV  X18, X22
    LD4R { V6.4S, V7.4S, V8.4S, V9.4S }, [X18], #16
    ADD  X22, X22, X16, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X22]
    MOV  X18, X22
    LD4R { V6.2S, V7.2S, V8.2S, V9.2S }, [X18], #16
    ADD  X22, X22, X16, ASR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X22]
    MOV  X18, X22
    LD4R { V7.4S, V8.4S, V9.4S, V10.4S }, [X18], #16
    ADD  X22, X22, X16
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X22]
    MOV  X18, X22
    LD4R { V9.1D, V10.1D, V11.1D, V12.1D }, [X18], #32
    ADD  X22, X22, X16, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X22]
    MOV  X18, X22
    LD4R { V19.1D, V20.1D, V21.1D, V22.1D }, [X18], #32
    ADD  X22, X22, X16, LSR #0
    ST4 { V15.4S, V16.4S, V17.4S, V18.4S }, [X22]
    MOV  X18, X22
    LD4R { V28.2D, V29.2D, V30.2D, V31.2D }, [X18], #32
    ADD  X22, X22, X16
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X22]
    MOV  X18, X22
    LD4R { V22.8B, V23.8B, V24.8B, V25.8B }, [X18], #4
    ADD  X22, X22, X16, LSR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X22]
    MOV  X18, X22
    LD4R { V3.16B, V4.16B, V5.16B, V6.16B }, [X18], #4
    ADD  X22, X22, X16, LSR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X22]
    MOV  X18, X22
    LD4R { V4.8B, V5.8B, V6.8B, V7.8B }, [X18], #4
    ADD  X22, X22, X16
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X22]
    MOV  X18, X22
    LD4R { V9.4H, V10.4H, V11.4H, V12.4H }, [X18], #8
    ADD  X22, X22, X16, ASR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X22]
    MOV  X18, X22
    LD4R { V2.8H, V3.8H, V4.8H, V5.8H }, [X18], #8
    ADD  X22, X22, X16
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X22]
    MOV  X18, X22
    LD4R { V24.4H, V25.4H, V26.4H, V27.4H }, [X18], #8
    ADD  X22, X22, X16, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X22]
    LD4R { V5.16B, V6.16B, V7.16B, V8.16B }, [X22], X7
    ADD  X22, X22, X16
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X22]
    LD4R { V20.16B, V21.16B, V22.16B, V23.16B }, [X22], X7
    ADD  X22, X22, X16, ASR #0
    ST4 { V7.2D, V8.2D, V9.2D, V10.2D }, [X22]
    LD4R { V18.2D, V19.2D, V20.2D, V21.2D }, [X22], X7
    ADD  X22, X22, X16
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X22]
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X22], X7
    ADD  X22, X22, X16, LSR #0
    ST4 { V18.16B, V19.16B, V20.16B, V21.16B }, [X22]
    LD4R { V12.8H, V13.8H, V14.8H, V15.8H }, [X22], X7
    ADD  X22, X22, X16, LSR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X22]
    LD4R { V13.1D, V14.1D, V15.1D, V16.1D }, [X22], X7
    ADD  X22, X22, X16, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X22]
    LD4R { V28.1D, V29.1D, V30.1D, V31.1D }, [X22], X7
    ADD  X22, X22, X16
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X22]
    LD4R { V3.2S, V4.2S, V5.2S, V6.2S }, [X22], X7
    ADD  X22, X22, X16, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X22]
    LD4R { V7.4H, V8.4H, V9.4H, V10.4H }, [X22], X7
    ADD  X22, X22, X16, ASR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X22]
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X22], X7
    ADD  X22, X22, X16, ASR #0
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X8
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
    SUB  X4, X14, X10
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
    SUB  X4, X14, X12
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
    SUB  X4, X14, X15
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
    SUB  X4, X14, X23
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X24
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X25
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
    MOVZ  X14, #0x5a5a, LSL #0
    MOVK  X14, #0x5a5a, LSL #16
    MOVK  X14, #0x5a5a, LSL #32
    MOVK  X14, #0x5a5a, LSL #48
    SUB  X4, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X14, FPSR
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D0
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D1
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D2
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D3
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D4
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D5
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D6
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D7
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D8
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D9
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D10
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D11
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D12
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D13
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D14
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D15
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D16
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D17
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D18
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D19
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D20
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D21
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D22
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D23
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D24
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D25
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D26
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D27
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D28
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D29
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D30
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X4, #0x0, LSL #0
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D31
    MOVZ  X4, #0x5a5a, LSL #0
    MOVK  X4, #0x5a5a, LSL #16
    MOVK  X4, #0x5a5a, LSL #32
    MOVK  X4, #0x5a5a, LSL #48
    SUB  X2, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  D1, X26
    FMOV  V1.D[1], X28
    FMOV  D2, X27
    FMOV  V2.D[1], X20
    FMOV  D3, X2
    FMOV  V3.D[1], X10
    FMOV  D4, X15
    FMOV  V4.D[1], X4
    FMOV  D5, X4
    FMOV  V5.D[1], X23
    FMOV  D6, X14
    FMOV  V6.D[1], X19
    FMOV  D7, X12
    FMOV  V7.D[1], X10
    FMOV  D8, X10
    FMOV  V8.D[1], X27
    FMOV  D9, X16
    FMOV  V9.D[1], X8
    FMOV  D10, X17
    FMOV  V10.D[1], X8
    FMOV  D11, X12
    FMOV  V11.D[1], X23
    FMOV  D12, X17
    FMOV  V12.D[1], X26
    FMOV  D13, X7
    FMOV  V13.D[1], X29
    FMOV  D14, X16
    FMOV  V14.D[1], X11
    FMOV  D15, X12
    FMOV  V15.D[1], X27
    FMOV  D16, X21
    FMOV  V16.D[1], X7
    FMOV  D17, X28
    FMOV  V17.D[1], X29
    FMOV  D18, X17
    FMOV  V18.D[1], X22
    FMOV  D19, X14
    FMOV  V19.D[1], X11
    FMOV  D20, X26
    FMOV  V20.D[1], X16
    FMOV  D21, X27
    FMOV  V21.D[1], X13
    FMOV  D22, X20
    FMOV  V22.D[1], X7
    FMOV  D23, X19
    FMOV  V23.D[1], X28
    FMOV  D24, X7
    FMOV  V24.D[1], X21
    FMOV  D25, X24
    FMOV  V25.D[1], X29
    FMOV  D26, X21
    FMOV  V26.D[1], X20
    FMOV  D27, X24
    FMOV  V27.D[1], X25
    FMOV  D28, X28
    FMOV  V28.D[1], X11
    FMOV  D29, X4
    FMOV  V29.D[1], X19
    FMOV  D30, X16
    FMOV  V30.D[1], X7
    FMOV  D31, X4
    FMOV  V31.D[1], X4
    MOVZ  X22, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X25, #0x500, LSL #0
    ADD  X23, X30, X25
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X23]
    LD4R { V24.4S, V25.4S, V26.4S, V27.4S }, [X23]
    ADD  X23, X23, X7
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X23]
    LD4R { V28.16B, V29.16B, V30.16B, V31.16B }, [X23]
    ADD  X23, X23, X7, ASR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X23]
    LD4R { V23.2D, V24.2D, V25.2D, V26.2D }, [X23]
    ADD  X23, X23, X7
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X23]
    LD4R { V21.4S, V22.4S, V23.4S, V24.4S }, [X23]
    ADD  X23, X23, X7, ASR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X23]
    LD4R { V17.8H, V18.8H, V19.8H, V20.8H }, [X23]
    ADD  X23, X23, X7, ASR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X23]
    LD4R { V31.4H, V0.4H, V1.4H, V2.4H }, [X23]
    ADD  X23, X23, X7, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X23]
    LD4R { V31.1D, V0.1D, V1.1D, V2.1D }, [X23]
    ADD  X23, X23, X7, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X23]
    LD4R { V14.2S, V15.2S, V16.2S, V17.2S }, [X23]
    ADD  X23, X23, X7
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X23]
    LD4R { V25.4H, V26.4H, V27.4H, V28.4H }, [X23]
    ADD  X23, X23, X7, LSR #0
    ST4 { V7.4S, V8.4S, V9.4S, V10.4S }, [X23]
    LD4R { V4.8B, V5.8B, V6.8B, V7.8B }, [X23]
    ADD  X23, X23, X7, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X23]
    MOV  X18, X23
    LD4R { V26.4S, V27.4S, V28.4S, V29.4S }, [X18], #16
    ADD  X23, X23, X7
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X23]
    MOV  X18, X23
    LD4R { V9.2S, V10.2S, V11.2S, V12.2S }, [X18], #16
    ADD  X23, X23, X7
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X23]
    MOV  X18, X23
    LD4R { V31.4S, V0.4S, V1.4S, V2.4S }, [X18], #16
    ADD  X23, X23, X7, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X23]
    MOV  X18, X23
    LD4R { V15.2D, V16.2D, V17.2D, V18.2D }, [X18], #32
    ADD  X23, X23, X7, LSR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X23]
    MOV  X18, X23
    LD4R { V26.1D, V27.1D, V28.1D, V29.1D }, [X18], #32
    ADD  X23, X23, X7, ASR #0
    ST4 { V3.2D, V4.2D, V5.2D, V6.2D }, [X23]
    MOV  X18, X23
    LD4R { V15.2D, V16.2D, V17.2D, V18.2D }, [X18], #32
    ADD  X23, X23, X7, LSR #0
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X23]
    MOV  X18, X23
    LD4R { V4.16B, V5.16B, V6.16B, V7.16B }, [X18], #4
    ADD  X23, X23, X7, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X23]
    MOV  X18, X23
    LD4R { V31.16B, V0.16B, V1.16B, V2.16B }, [X18], #4
    ADD  X23, X23, X7, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X23]
    MOV  X18, X23
    LD4R { V1.8B, V2.8B, V3.8B, V4.8B }, [X18], #4
    ADD  X23, X23, X7, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X23]
    MOV  X18, X23
    LD4R { V2.4H, V3.4H, V4.4H, V5.4H }, [X18], #8
    ADD  X23, X23, X7, LSR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X23]
    MOV  X18, X23
    LD4R { V16.8H, V17.8H, V18.8H, V19.8H }, [X18], #8
    ADD  X23, X23, X7, LSR #0
    ST4 { V0.2D, V1.2D, V2.2D, V3.2D }, [X23]
    MOV  X18, X23
    LD4R { V25.8H, V26.8H, V27.8H, V28.8H }, [X18], #8
    ADD  X23, X23, X7
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X23]
    LD4R { V28.8H, V29.8H, V30.8H, V31.8H }, [X23], X22
    ADD  X23, X23, X7, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X23]
    LD4R { V29.16B, V30.16B, V31.16B, V0.16B }, [X23], X22
    ADD  X23, X23, X7, ASR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X23]
    LD4R { V25.2D, V26.2D, V27.2D, V28.2D }, [X23], X22
    ADD  X23, X23, X7, ASR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X23]
    LD4R { V10.4S, V11.4S, V12.4S, V13.4S }, [X23], X22
    ADD  X23, X23, X7, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X23]
    LD4R { V20.8H, V21.8H, V22.8H, V23.8H }, [X23], X22
    ADD  X23, X23, X7
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X23]
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X23], X22
    ADD  X23, X23, X7, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X23]
    LD4R { V26.1D, V27.1D, V28.1D, V29.1D }, [X23], X22
    ADD  X23, X23, X7, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X23]
    LD4R { V26.2S, V27.2S, V28.2S, V29.2S }, [X23], X22
    ADD  X23, X23, X7, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X23]
    LD4R { V8.4H, V9.4H, V10.4H, V11.4H }, [X23], X22
    ADD  X23, X23, X7, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X23]
    LD4R { V8.8B, V9.8B, V10.8B, V11.8B }, [X23], X22
    ADD  X23, X23, X7
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X11
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X12
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X13
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X27
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X28
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X4, #0xa5a5, LSL #0
    MOVK  X4, #0xa5a5, LSL #16
    MOVK  X4, #0xa5a5, LSL #32
    MOVK  X4, #0xa5a5, LSL #48
    SUB  X20, X4, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X4, FPSR
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V0.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V1.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D1
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D2
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D3
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D4
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D5
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V6.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D6
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V7.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D7
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D8
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V9.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D9
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D10
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D11
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V12.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D12
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V13.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D13
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D14
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V15.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D15
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V16.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D16
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V17.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D17
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V18.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D18
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V19.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D19
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V20.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D20
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V21.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D21
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V22.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D22
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V23.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D23
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V24.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D24
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V25.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D25
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D26
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D27
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D28
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D29
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V30.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D30
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, V31.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X4, D31
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X16, X20, X4
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  V0.D[1], X10
    FMOV  D1, X29
    FMOV  V1.D[1], X27
    FMOV  D2, X28
    FMOV  V2.D[1], X7
    FMOV  D3, X26
    FMOV  V3.D[1], X10
    FMOV  D4, X10
    FMOV  V4.D[1], X17
    FMOV  D5, X8
    FMOV  V5.D[1], X2
    FMOV  D6, X7
    FMOV  V6.D[1], X13
    FMOV  D7, X11
    FMOV  V7.D[1], X14
    FMOV  D8, X29
    FMOV  V8.D[1], X16
    FMOV  D9, X14
    FMOV  V9.D[1], X23
    FMOV  D10, X23
    FMOV  V10.D[1], X19
    FMOV  D11, X20
    FMOV  V11.D[1], X8
    FMOV  D12, X7
    FMOV  V12.D[1], X2
    FMOV  D13, X25
    FMOV  V13.D[1], X8
    FMOV  D14, X21
    FMOV  V14.D[1], X24
    FMOV  D15, X17
    FMOV  V15.D[1], X17
    FMOV  D16, X2
    FMOV  V16.D[1], X29
    FMOV  D17, X13
    FMOV  V17.D[1], X23
    FMOV  D18, X2
    FMOV  V18.D[1], X15
    FMOV  D19, X10
    FMOV  V19.D[1], X13
    FMOV  D20, X20
    FMOV  V20.D[1], X18
    FMOV  D21, X22
    FMOV  V21.D[1], X13
    FMOV  D22, X11
    FMOV  V22.D[1], X7
    FMOV  D23, X4
    FMOV  V23.D[1], X2
    FMOV  D24, X11
    FMOV  V24.D[1], X18
    FMOV  D25, X12
    FMOV  V25.D[1], X8
    FMOV  D26, X22
    FMOV  V26.D[1], X11
    FMOV  D27, X24
    FMOV  V27.D[1], X4
    FMOV  D28, X15
    FMOV  V28.D[1], X21
    FMOV  D29, X9
    FMOV  V29.D[1], X17
    FMOV  D30, X25
    FMOV  V30.D[1], X2
    FMOV  D31, X21
    FMOV  V31.D[1], X22
    MOVZ  X7, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X23, #0xa00, LSL #0
    ADD  X29, X30, X23
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X29]
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X29]
    ADD  X29, X29, X4, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X29]
    LD4R { V27.16B, V28.16B, V29.16B, V30.16B }, [X29]
    ADD  X29, X29, X4, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X29]
    LD4R { V3.2D, V4.2D, V5.2D, V6.2D }, [X29]
    ADD  X29, X29, X4, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X29]
    LD4R { V3.4S, V4.4S, V5.4S, V6.4S }, [X29]
    ADD  X29, X29, X4
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X29]
    LD4R { V4.8H, V5.8H, V6.8H, V7.8H }, [X29]
    ADD  X29, X29, X4, ASR #0
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X29]
    LD4R { V1.4H, V2.4H, V3.4H, V4.4H }, [X29]
    ADD  X29, X29, X4, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X29]
    LD4R { V11.1D, V12.1D, V13.1D, V14.1D }, [X29]
    ADD  X29, X29, X4, ASR #0
    ST4 { V1.8H, V2.8H, V3.8H, V4.8H }, [X29]
    LD4R { V15.2S, V16.2S, V17.2S, V18.2S }, [X29]
    ADD  X29, X29, X4
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X29]
    LD4R { V25.4H, V26.4H, V27.4H, V28.4H }, [X29]
    ADD  X29, X29, X4
    ST4 { V29.2D, V30.2D, V31.2D, V0.2D }, [X29]
    LD4R { V30.8B, V31.8B, V0.8B, V1.8B }, [X29]
    ADD  X29, X29, X4
    ST4 { V15.2D, V16.2D, V17.2D, V18.2D }, [X29]
    MOV  X15, X29
    LD4R { V15.4S, V16.4S, V17.4S, V18.4S }, [X15], #16
    ADD  X29, X29, X4, ASR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X29]
    MOV  X15, X29
    LD4R { V21.2S, V22.2S, V23.2S, V24.2S }, [X15], #16
    ADD  X29, X29, X4, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X29]
    MOV  X15, X29
    LD4R { V24.4S, V25.4S, V26.4S, V27.4S }, [X15], #16
    ADD  X29, X29, X4, LSR #0
    ST4 { V25.16B, V26.16B, V27.16B, V28.16B }, [X29]
    MOV  X15, X29
    LD4R { V16.1D, V17.1D, V18.1D, V19.1D }, [X15], #32
    ADD  X29, X29, X4, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X29]
    MOV  X15, X29
    LD4R { V21.1D, V22.1D, V23.1D, V24.1D }, [X15], #32
    ADD  X29, X29, X4, ASR #0
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X29]
    MOV  X15, X29
    LD4R { V13.2D, V14.2D, V15.2D, V16.2D }, [X15], #32
    ADD  X29, X29, X4, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X29]
    MOV  X15, X29
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X15], #4
    ADD  X29, X29, X4, ASR #0
    ST4 { V5.2D, V6.2D, V7.2D, V8.2D }, [X29]
    MOV  X15, X29
    LD4R { V19.16B, V20.16B, V21.16B, V22.16B }, [X15], #4
    ADD  X29, X29, X4
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X29]
    MOV  X15, X29
    LD4R { V26.8B, V27.8B, V28.8B, V29.8B }, [X15], #4
    ADD  X29, X29, X4, ASR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X29]
    MOV  X15, X29
    LD4R { V5.4H, V6.4H, V7.4H, V8.4H }, [X15], #8
    ADD  X29, X29, X4, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X29]
    MOV  X15, X29
    LD4R { V0.8H, V1.8H, V2.8H, V3.8H }, [X15], #8
    ADD  X29, X29, X4, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X29]
    MOV  X15, X29
    LD4R { V23.4H, V24.4H, V25.4H, V26.4H }, [X15], #8
    ADD  X29, X29, X4, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X29]
    LD4R { V4.8H, V5.8H, V6.8H, V7.8H }, [X29], X7
    ADD  X29, X29, X4, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X29]
    LD4R { V16.16B, V17.16B, V18.16B, V19.16B }, [X29], X7
    ADD  X29, X29, X4, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X29]
    LD4R { V0.2D, V1.2D, V2.2D, V3.2D }, [X29], X7
    ADD  X29, X29, X4, LSR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X29]
    LD4R { V9.4S, V10.4S, V11.4S, V12.4S }, [X29], X7
    ADD  X29, X29, X4
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X29]
    LD4R { V21.8H, V22.8H, V23.8H, V24.8H }, [X29], X7
    ADD  X29, X29, X4, ASR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X29]
    LD4R { V9.4H, V10.4H, V11.4H, V12.4H }, [X29], X7
    ADD  X29, X29, X4
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X29]
    LD4R { V23.1D, V24.1D, V25.1D, V26.1D }, [X29], X7
    ADD  X29, X29, X4, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X29]
    LD4R { V25.2S, V26.2S, V27.2S, V28.2S }, [X29], X7
    ADD  X29, X29, X4
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X29]
    LD4R { V4.4H, V5.4H, V6.4H, V7.4H }, [X29], X7
    ADD  X29, X29, X4
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X29]
    LD4R { V10.8B, V11.8B, V12.8B, V13.8B }, [X29], X7
    ADD  X29, X29, X4
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X14
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X16
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X19
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X24
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X25
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X18, #0x5a5a, LSL #0
    MOVK  X18, #0x5a5a, LSL #16
    MOVK  X18, #0x5a5a, LSL #32
    MOVK  X18, #0x5a5a, LSL #48
    SUB  X17, X18, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X18, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V0.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D0
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V1.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D1
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V2.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D2
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V3.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D3
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D4
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V5.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D5
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D6
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D7
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D8
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D9
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D10
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V11.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D11
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V12.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D12
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V13.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D13
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V14.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D14
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V15.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D15
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V16.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D16
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V17.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D17
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V18.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D18
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V19.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D19
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V20.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D20
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V21.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D21
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V22.D[1]
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D22
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D23
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D24
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D25
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D26
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D27
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D28
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V29.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D29
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V30.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D30
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, V31.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X18, D31
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X13, X17, X18
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  V0.D[1], X19
    FMOV  D1, X11
    FMOV  V1.D[1], X28
    FMOV  D2, X23
    FMOV  V2.D[1], X27
    FMOV  D3, X16
    FMOV  V3.D[1], X23
    FMOV  D4, X26
    FMOV  V4.D[1], X29
    FMOV  D5, X14
    FMOV  V5.D[1], X19
    FMOV  D6, X20
    FMOV  V6.D[1], X28
    FMOV  D7, X24
    FMOV  V7.D[1], X15
    FMOV  D8, X21
    FMOV  V8.D[1], X22
    FMOV  D9, X24
    FMOV  V9.D[1], X19
    FMOV  D10, X20
    FMOV  V10.D[1], X23
    FMOV  D11, X22
    FMOV  V11.D[1], X10
    FMOV  D12, X25
    FMOV  V12.D[1], X7
    FMOV  D13, X14
    FMOV  V13.D[1], X24
    FMOV  D14, X25
    FMOV  V14.D[1], X29
    FMOV  D15, X25
    FMOV  V15.D[1], X28
    FMOV  D16, X9
    FMOV  V16.D[1], X18
    FMOV  D17, X17
    FMOV  V17.D[1], X10
    FMOV  D18, X21
    FMOV  V18.D[1], X27
    FMOV  D19, X21
    FMOV  V19.D[1], X24
    FMOV  D20, X29
    FMOV  V20.D[1], X7
    FMOV  D21, X18
    FMOV  V21.D[1], X11
    FMOV  D22, X13
    FMOV  V22.D[1], X2
    FMOV  D23, X26
    FMOV  V23.D[1], X8
    FMOV  D24, X16
    FMOV  V24.D[1], X7
    FMOV  D25, X18
    FMOV  V25.D[1], X28
    FMOV  D26, X8
    FMOV  V26.D[1], X20
    FMOV  D27, X4
    FMOV  V27.D[1], X17
    FMOV  D28, X26
    FMOV  V28.D[1], X12
    FMOV  D29, X13
    FMOV  V29.D[1], X15
    FMOV  D30, X4
    FMOV  V30.D[1], X20
    FMOV  D31, X20
    FMOV  V31.D[1], X19
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X13, #0xf00, LSL #0
    ADD  X7, X30, X13
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X7]
    LD4R { V29.4S, V30.4S, V31.4S, V0.4S }, [X7]
    ADD  X7, X7, X23, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X7]
    LD4R { V20.16B, V21.16B, V22.16B, V23.16B }, [X7]
    ADD  X7, X7, X23, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X7]
    LD4R { V14.2D, V15.2D, V16.2D, V17.2D }, [X7]
    ADD  X7, X7, X23, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X7]
    LD4R { V9.4S, V10.4S, V11.4S, V12.4S }, [X7]
    ADD  X7, X7, X23, ASR #0
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X7]
    LD4R { V17.8H, V18.8H, V19.8H, V20.8H }, [X7]
    ADD  X7, X7, X23, ASR #0
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X7]
    LD4R { V5.2S, V6.2S, V7.2S, V8.2S }, [X7]
    ADD  X7, X7, X23
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X7]
    LD4R { V8.1D, V9.1D, V10.1D, V11.1D }, [X7]
    ADD  X7, X7, X23, ASR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X7]
    LD4R { V29.2S, V30.2S, V31.2S, V0.2S }, [X7]
    ADD  X7, X7, X23, LSR #0
    ST4 { V20.8H, V21.8H, V22.8H, V23.8H }, [X7]
    LD4R { V9.4H, V10.4H, V11.4H, V12.4H }, [X7]
    ADD  X7, X7, X23, LSR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X7]
    LD4R { V25.8B, V26.8B, V27.8B, V28.8B }, [X7]
    ADD  X7, X7, X23, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X7]
    MOV  X17, X7
    LD4R { V26.4S, V27.4S, V28.4S, V29.4S }, [X17], #16
    ADD  X7, X7, X23, LSR #0
    ST4 { V28.4S, V29.4S, V30.4S, V31.4S }, [X7]
    MOV  X17, X7
    LD4R { V14.2S, V15.2S, V16.2S, V17.2S }, [X17], #16
    ADD  X7, X7, X23
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X7]
    MOV  X17, X7
    LD4R { V20.4S, V21.4S, V22.4S, V23.4S }, [X17], #16
    ADD  X7, X7, X23, ASR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X7]
    MOV  X17, X7
    LD4R { V20.2D, V21.2D, V22.2D, V23.2D }, [X17], #32
    ADD  X7, X7, X23
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X7]
    MOV  X17, X7
    LD4R { V6.1D, V7.1D, V8.1D, V9.1D }, [X17], #32
    ADD  X7, X7, X23
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X7]
    MOV  X17, X7
    LD4R { V14.2D, V15.2D, V16.2D, V17.2D }, [X17], #32
    ADD  X7, X7, X23, ASR #0
    ST4 { V6.8H, V7.8H, V8.8H, V9.8H }, [X7]
    MOV  X17, X7
    LD4R { V3.8B, V4.8B, V5.8B, V6.8B }, [X17], #4
    ADD  X7, X7, X23, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X7]
    MOV  X17, X7
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X17], #4
    ADD  X7, X7, X23, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X7]
    MOV  X17, X7
    LD4R { V30.8B, V31.8B, V0.8B, V1.8B }, [X17], #4
    ADD  X7, X7, X23, ASR #0
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X7]
    MOV  X17, X7
    LD4R { V30.4H, V31.4H, V0.4H, V1.4H }, [X17], #8
    ADD  X7, X7, X23
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X7]
    MOV  X17, X7
    LD4R { V14.8H, V15.8H, V16.8H, V17.8H }, [X17], #8
    ADD  X7, X7, X23, ASR #0
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X7]
    MOV  X17, X7
    LD4R { V2.4H, V3.4H, V4.4H, V5.4H }, [X17], #8
    ADD  X7, X7, X23
    ST4 { V14.8H, V15.8H, V16.8H, V17.8H }, [X7]
    LD4R { V19.2D, V20.2D, V21.2D, V22.2D }, [X7], X27
    ADD  X7, X7, X23, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X7]
    LD4R { V6.16B, V7.16B, V8.16B, V9.16B }, [X7], X27
    ADD  X7, X7, X23, LSR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X7]
    LD4R { V21.2D, V22.2D, V23.2D, V24.2D }, [X7], X27
    ADD  X7, X7, X23, LSR #0
    ST4 { V21.2D, V22.2D, V23.2D, V24.2D }, [X7]
    LD4R { V30.4S, V31.4S, V0.4S, V1.4S }, [X7], X27
    ADD  X7, X7, X23, LSR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X7]
    LD4R { V2.8H, V3.8H, V4.8H, V5.8H }, [X7], X27
    ADD  X7, X7, X23, LSR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X7]
    LD4R { V22.2S, V23.2S, V24.2S, V25.2S }, [X7], X27
    ADD  X7, X7, X23, LSR #0
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X7]
    LD4R { V22.1D, V23.1D, V24.1D, V25.1D }, [X7], X27
    ADD  X7, X7, X23
    ST4 { V22.2D, V23.2D, V24.2D, V25.2D }, [X7]
    LD4R { V23.2S, V24.2S, V25.2S, V26.2S }, [X7], X27
    ADD  X7, X7, X23, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X7]
    LD4R { V22.4H, V23.4H, V24.4H, V25.4H }, [X7], X27
    ADD  X7, X7, X23
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X7]
    LD4R { V31.8B, V0.8B, V1.8B, V2.8B }, [X7], X27
    ADD  X7, X7, X23, LSR #0
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
    SUB  X11, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X10
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
    SUB  X11, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X18
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
    SUB  X11, X12, X20
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
    SUB  X11, X12, X24
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
    SUB  X11, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X11, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X12, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D0
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D1
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D2
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D3
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D4
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D5
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D6
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D7
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D8
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D9
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D10
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D11
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D12
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D13
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D14
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D15
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D16
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D17
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D18
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D19
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D20
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D21
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D22
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D23
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D24
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D25
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D26
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D27
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D28
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D29
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D30
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D31
    MOVZ  X11, #0xa5a5, LSL #0
    MOVK  X11, #0xa5a5, LSL #16
    MOVK  X11, #0xa5a5, LSL #32
    MOVK  X11, #0xa5a5, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  D0, X15
    FMOV  V0.D[1], X26
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X12
    FMOV  D3, X18
    FMOV  V3.D[1], X24
    FMOV  D4, X14
    FMOV  V4.D[1], X13
    FMOV  D5, X20
    FMOV  V5.D[1], X24
    FMOV  D6, X12
    FMOV  V6.D[1], X11
    FMOV  D7, X27
    FMOV  V7.D[1], X24
    FMOV  D8, X9
    FMOV  V8.D[1], X28
    FMOV  D9, X24
    FMOV  V9.D[1], X24
    FMOV  D10, X25
    FMOV  V10.D[1], X26
    FMOV  D11, X20
    FMOV  V11.D[1], X22
    FMOV  D12, X26
    FMOV  V12.D[1], X12
    FMOV  D13, X27
    FMOV  V13.D[1], X7
    FMOV  D14, X28
    FMOV  V14.D[1], X11
    FMOV  D15, X29
    FMOV  V15.D[1], X29
    FMOV  D16, X21
    FMOV  V16.D[1], X8
    FMOV  D17, X28
    FMOV  V17.D[1], X2
    FMOV  D18, X24
    FMOV  V18.D[1], X14
    FMOV  D19, X4
    FMOV  V19.D[1], X8
    FMOV  D20, X24
    FMOV  V20.D[1], X4
    FMOV  D21, X2
    FMOV  V21.D[1], X10
    FMOV  D22, X25
    FMOV  V22.D[1], X20
    FMOV  D23, X23
    FMOV  V23.D[1], X4
    FMOV  D24, X12
    FMOV  V24.D[1], X10
    FMOV  D25, X18
    FMOV  V25.D[1], X21
    FMOV  D26, X23
    FMOV  V26.D[1], X23
    FMOV  D27, X10
    FMOV  V27.D[1], X15
    FMOV  D28, X19
    FMOV  V28.D[1], X29
    FMOV  D29, X25
    FMOV  V29.D[1], X25
    FMOV  D30, X4
    FMOV  V30.D[1], X15
    FMOV  D31, X21
    FMOV  V31.D[1], X11
    MOVZ  X16, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X7, #0x1400, LSL #0
    ADD  X28, X30, X7
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X28]
    LD4R { V3.4S, V4.4S, V5.4S, V6.4S }, [X28]
    ADD  X28, X28, X8, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X28]
    LD4R { V1.16B, V2.16B, V3.16B, V4.16B }, [X28]
    ADD  X28, X28, X8
    ST4 { V3.8H, V4.8H, V5.8H, V6.8H }, [X28]
    LD4R { V28.2D, V29.2D, V30.2D, V31.2D }, [X28]
    ADD  X28, X28, X8, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X28]
    LD4R { V12.4S, V13.4S, V14.4S, V15.4S }, [X28]
    ADD  X28, X28, X8, ASR #0
    ST4 { V19.8H, V20.8H, V21.8H, V22.8H }, [X28]
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X28]
    ADD  X28, X28, X8, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X28]
    LD4R { V3.8B, V4.8B, V5.8B, V6.8B }, [X28]
    ADD  X28, X28, X8, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X28]
    LD4R { V27.1D, V28.1D, V29.1D, V30.1D }, [X28]
    ADD  X28, X28, X8, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X28]
    LD4R { V8.2S, V9.2S, V10.2S, V11.2S }, [X28]
    ADD  X28, X28, X8
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X28]
    LD4R { V7.4H, V8.4H, V9.4H, V10.4H }, [X28]
    ADD  X28, X28, X8, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X28]
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X28]
    ADD  X28, X28, X8
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X28]
    MOV  X13, X28
    LD4R { V10.2S, V11.2S, V12.2S, V13.2S }, [X13], #16
    ADD  X28, X28, X8, LSR #0
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X28]
    MOV  X13, X28
    LD4R { V27.2S, V28.2S, V29.2S, V30.2S }, [X13], #16
    ADD  X28, X28, X8, LSR #0
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X28]
    MOV  X13, X28
    LD4R { V6.4S, V7.4S, V8.4S, V9.4S }, [X13], #16
    ADD  X28, X28, X8, LSR #0
    ST4 { V8.4S, V9.4S, V10.4S, V11.4S }, [X28]
    MOV  X13, X28
    LD4R { V8.1D, V9.1D, V10.1D, V11.1D }, [X13], #32
    ADD  X28, X28, X8
    ST4 { V7.16B, V8.16B, V9.16B, V10.16B }, [X28]
    MOV  X13, X28
    LD4R { V23.1D, V24.1D, V25.1D, V26.1D }, [X13], #32
    ADD  X28, X28, X8
    ST4 { V31.4S, V0.4S, V1.4S, V2.4S }, [X28]
    MOV  X13, X28
    LD4R { V28.2D, V29.2D, V30.2D, V31.2D }, [X13], #32
    ADD  X28, X28, X8
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X28]
    MOV  X13, X28
    LD4R { V6.16B, V7.16B, V8.16B, V9.16B }, [X13], #4
    ADD  X28, X28, X8, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X28]
    MOV  X13, X28
    LD4R { V26.16B, V27.16B, V28.16B, V29.16B }, [X13], #4
    ADD  X28, X28, X8
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X28]
    MOV  X13, X28
    LD4R { V0.8B, V1.8B, V2.8B, V3.8B }, [X13], #4
    ADD  X28, X28, X8, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X28]
    MOV  X13, X28
    LD4R { V31.4H, V0.4H, V1.4H, V2.4H }, [X13], #8
    ADD  X28, X28, X8, ASR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X28]
    MOV  X13, X28
    LD4R { V22.8H, V23.8H, V24.8H, V25.8H }, [X13], #8
    ADD  X28, X28, X8, LSR #0
    ST4 { V22.8H, V23.8H, V24.8H, V25.8H }, [X28]
    MOV  X13, X28
    LD4R { V12.8H, V13.8H, V14.8H, V15.8H }, [X13], #8
    ADD  X28, X28, X8, LSR #0
    ST4 { V12.4S, V13.4S, V14.4S, V15.4S }, [X28]
    LD4R { V0.16B, V1.16B, V2.16B, V3.16B }, [X28], X16
    ADD  X28, X28, X8, LSR #0
    ST4 { V0.16B, V1.16B, V2.16B, V3.16B }, [X28]
    LD4R { V17.16B, V18.16B, V19.16B, V20.16B }, [X28], X16
    ADD  X28, X28, X8
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X28]
    LD4R { V27.2D, V28.2D, V29.2D, V30.2D }, [X28], X16
    ADD  X28, X28, X8, LSR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X28]
    LD4R { V3.4S, V4.4S, V5.4S, V6.4S }, [X28], X16
    ADD  X28, X28, X8, LSR #0
    ST4 { V19.2D, V20.2D, V21.2D, V22.2D }, [X28]
    LD4R { V31.8H, V0.8H, V1.8H, V2.8H }, [X28], X16
    ADD  X28, X28, X8, LSR #0
    ST4 { V2.8H, V3.8H, V4.8H, V5.8H }, [X28]
    LD4R { V18.4H, V19.4H, V20.4H, V21.4H }, [X28], X16
    ADD  X28, X28, X8, ASR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X28]
    LD4R { V12.1D, V13.1D, V14.1D, V15.1D }, [X28], X16
    ADD  X28, X28, X8, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X28]
    LD4R { V5.2S, V6.2S, V7.2S, V8.2S }, [X28], X16
    ADD  X28, X28, X8
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X28]
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X28], X16
    ADD  X28, X28, X8
    ST4 { V16.4S, V17.4S, V18.4S, V19.4S }, [X28]
    LD4R { V4.8B, V5.8B, V6.8B, V7.8B }, [X28], X16
    ADD  X28, X28, X8, LSR #0
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X18
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X19
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X21
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X22
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X24, #0x5a5a, LSL #0
    MOVK  X24, #0x5a5a, LSL #16
    MOVK  X24, #0x5a5a, LSL #32
    MOVK  X24, #0x5a5a, LSL #48
    SUB  X29, X24, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X24, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D26
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D27
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D28
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X24, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X20, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  D0, X20
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X29
    FMOV  V2.D[1], X23
    FMOV  D3, X29
    FMOV  V3.D[1], X10
    FMOV  D4, X28
    FMOV  V4.D[1], X17
    FMOV  D5, X28
    FMOV  V5.D[1], X25
    FMOV  D6, X17
    FMOV  V6.D[1], X20
    FMOV  D7, X9
    FMOV  V7.D[1], X19
    FMOV  D8, X11
    FMOV  V8.D[1], X19
    FMOV  D9, X11
    FMOV  V9.D[1], X26
    FMOV  D10, X22
    FMOV  V10.D[1], X14
    FMOV  D11, X8
    FMOV  V11.D[1], X15
    FMOV  D12, X28
    FMOV  V12.D[1], X11
    FMOV  D13, X14
    FMOV  V13.D[1], X13
    FMOV  D14, X14
    FMOV  V14.D[1], X27
    FMOV  D15, X23
    FMOV  V15.D[1], X18
    FMOV  D16, X4
    FMOV  V16.D[1], X25
    FMOV  D17, X4
    FMOV  V17.D[1], X22
    FMOV  D18, X21
    FMOV  V18.D[1], X13
    FMOV  D19, X26
    FMOV  V19.D[1], X29
    FMOV  D20, X17
    FMOV  V20.D[1], X15
    FMOV  D21, X9
    FMOV  V21.D[1], X26
    FMOV  D22, X21
    FMOV  V22.D[1], X10
    FMOV  D23, X4
    FMOV  V23.D[1], X2
    FMOV  D24, X18
    FMOV  V24.D[1], X20
    FMOV  D25, X27
    FMOV  V25.D[1], X28
    FMOV  D26, X20
    FMOV  V26.D[1], X18
    FMOV  D27, X13
    FMOV  V27.D[1], X24
    FMOV  D28, X28
    FMOV  V28.D[1], X13
    FMOV  D29, X18
    FMOV  V29.D[1], X20
    FMOV  D30, X10
    FMOV  V30.D[1], X4
    FMOV  D31, X10
    FMOV  V31.D[1], X19
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X25, #0x1900, LSL #0
    ADD  X23, X30, X25, ASR #0
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X23]
    LD4R { V22.8H, V23.8H, V24.8H, V25.8H }, [X23]
    ADD  X23, X23, X24, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X23]
    LD4R { V23.16B, V24.16B, V25.16B, V26.16B }, [X23]
    ADD  X23, X23, X24
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X23]
    LD4R { V13.2D, V14.2D, V15.2D, V16.2D }, [X23]
    ADD  X23, X23, X24, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X23]
    LD4R { V13.4S, V14.4S, V15.4S, V16.4S }, [X23]
    ADD  X23, X23, X24, LSR #0
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X23]
    LD4R { V13.8H, V14.8H, V15.8H, V16.8H }, [X23]
    ADD  X23, X23, X24, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X23]
    LD4R { V29.2S, V30.2S, V31.2S, V0.2S }, [X23]
    ADD  X23, X23, X24
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X23]
    LD4R { V0.1D, V1.1D, V2.1D, V3.1D }, [X23]
    ADD  X23, X23, X24, ASR #0
    ST4 { V23.4S, V24.4S, V25.4S, V26.4S }, [X23]
    LD4R { V30.2S, V31.2S, V0.2S, V1.2S }, [X23]
    ADD  X23, X23, X24, LSR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X23]
    LD4R { V27.4H, V28.4H, V29.4H, V30.4H }, [X23]
    ADD  X23, X23, X24, LSR #0
    ST4 { V0.4S, V1.4S, V2.4S, V3.4S }, [X23]
    LD4R { V8.8B, V9.8B, V10.8B, V11.8B }, [X23]
    ADD  X23, X23, X24
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X23]
    MOV  X19, X23
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X19], #16
    ADD  X23, X23, X24, LSR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X23]
    MOV  X19, X23
    LD4R { V8.2S, V9.2S, V10.2S, V11.2S }, [X19], #16
    ADD  X23, X23, X24, ASR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X23]
    MOV  X19, X23
    LD4R { V31.4S, V0.4S, V1.4S, V2.4S }, [X19], #16
    ADD  X23, X23, X24, LSR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X23]
    MOV  X19, X23
    LD4R { V31.1D, V0.1D, V1.1D, V2.1D }, [X19], #32
    ADD  X23, X23, X24, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X23]
    MOV  X19, X23
    LD4R { V27.1D, V28.1D, V29.1D, V30.1D }, [X19], #32
    ADD  X23, X23, X24, ASR #0
    ST4 { V30.2D, V31.2D, V0.2D, V1.2D }, [X23]
    MOV  X19, X23
    LD4R { V11.2D, V12.2D, V13.2D, V14.2D }, [X19], #32
    ADD  X23, X23, X24
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X23]
    MOV  X19, X23
    LD4R { V20.8B, V21.8B, V22.8B, V23.8B }, [X19], #4
    ADD  X23, X23, X24
    ST4 { V20.4S, V21.4S, V22.4S, V23.4S }, [X23]
    MOV  X19, X23
    LD4R { V11.16B, V12.16B, V13.16B, V14.16B }, [X19], #4
    ADD  X23, X23, X24, LSR #0
    ST4 { V19.4S, V20.4S, V21.4S, V22.4S }, [X23]
    MOV  X19, X23
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X19], #4
    ADD  X23, X23, X24, ASR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X23]
    MOV  X19, X23
    LD4R { V18.4H, V19.4H, V20.4H, V21.4H }, [X19], #8
    ADD  X23, X23, X24, LSR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X23]
    MOV  X19, X23
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X19], #8
    ADD  X23, X23, X24, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X23]
    MOV  X19, X23
    LD4R { V22.8H, V23.8H, V24.8H, V25.8H }, [X19], #8
    ADD  X23, X23, X24
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X23]
    LD4R { V30.4S, V31.4S, V0.4S, V1.4S }, [X23], X13
    ADD  X23, X23, X24
    ST4 { V23.2D, V24.2D, V25.2D, V26.2D }, [X23]
    LD4R { V11.16B, V12.16B, V13.16B, V14.16B }, [X23], X13
    ADD  X23, X23, X24, LSR #0
    ST4 { V1.2D, V2.2D, V3.2D, V4.2D }, [X23]
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X23], X13
    ADD  X23, X23, X24
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X23]
    LD4R { V17.4S, V18.4S, V19.4S, V20.4S }, [X23], X13
    ADD  X23, X23, X24, LSR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X23]
    LD4R { V31.8H, V0.8H, V1.8H, V2.8H }, [X23], X13
    ADD  X23, X23, X24, LSR #0
    ST4 { V31.2D, V0.2D, V1.2D, V2.2D }, [X23]
    LD4R { V6.4H, V7.4H, V8.4H, V9.4H }, [X23], X13
    ADD  X23, X23, X24
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X23]
    LD4R { V25.1D, V26.1D, V27.1D, V28.1D }, [X23], X13
    ADD  X23, X23, X24, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X23]
    LD4R { V22.2S, V23.2S, V24.2S, V25.2S }, [X23], X13
    ADD  X23, X23, X24, ASR #0
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X23]
    LD4R { V1.4H, V2.4H, V3.4H, V4.4H }, [X23], X13
    ADD  X23, X23, X24, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X23]
    LD4R { V25.8B, V26.8B, V27.8B, V28.8B }, [X23], X13
    ADD  X23, X23, X24
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X2
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X4
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X7
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X9
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X10
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X11
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X12
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X15
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X18
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X20
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X21
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X22
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X26
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X27
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X28
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X14, #0xa5a5, LSL #0
    MOVK  X14, #0xa5a5, LSL #16
    MOVK  X14, #0xa5a5, LSL #32
    MOVK  X14, #0xa5a5, LSL #48
    SUB  X17, X14, X29
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X14, FPSR
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V0.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D0
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V1.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D1
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V2.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D2
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V3.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D3
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V4.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D4
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V5.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D5
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V6.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D6
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V7.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D7
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V8.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D8
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V9.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D9
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V10.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D10
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V11.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D11
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V12.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D12
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V13.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D13
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V14.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D14
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V15.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D15
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V16.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D16
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V17.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D17
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V18.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D18
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V19.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D19
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V20.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D20
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V21.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D21
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V22.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D22
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V23.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D23
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V24.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D24
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V25.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D25
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V26.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D26
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V27.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D27
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V28.D[1]
    MOVZ  X17, #0x0, LSL #0
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D28
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V29.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D29
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V30.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D30
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, V31.D[1]
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X14, D31
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X16, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  D0, X23
    FMOV  V0.D[1], X25
    FMOV  D1, X27
    FMOV  V1.D[1], X24
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X19
    FMOV  V3.D[1], X15
    FMOV  D4, X23
    FMOV  V4.D[1], X4
    FMOV  D5, X8
    FMOV  V5.D[1], X20
    FMOV  D6, X15
    FMOV  V6.D[1], X14
    FMOV  D7, X2
    FMOV  V7.D[1], X15
    FMOV  D8, X20
    FMOV  V8.D[1], X13
    FMOV  D9, X7
    FMOV  V9.D[1], X2
    FMOV  D10, X13
    FMOV  V10.D[1], X11
    FMOV  D11, X21
    FMOV  V11.D[1], X19
    FMOV  D12, X12
    FMOV  V12.D[1], X15
    FMOV  D13, X20
    FMOV  V13.D[1], X22
    FMOV  D14, X12
    FMOV  V14.D[1], X14
    FMOV  D15, X8
    FMOV  V15.D[1], X19
    FMOV  D16, X14
    FMOV  V16.D[1], X7
    FMOV  D17, X27
    FMOV  V17.D[1], X4
    FMOV  D18, X8
    FMOV  V18.D[1], X28
    FMOV  D19, X8
    FMOV  V19.D[1], X17
    FMOV  D20, X27
    FMOV  V20.D[1], X16
    FMOV  D21, X13
    FMOV  V21.D[1], X17
    FMOV  D22, X2
    FMOV  V22.D[1], X24
    FMOV  D23, X13
    FMOV  V23.D[1], X28
    FMOV  D24, X16
    FMOV  V24.D[1], X23
    FMOV  D25, X25
    FMOV  V25.D[1], X21
    FMOV  D26, X29
    FMOV  V26.D[1], X14
    FMOV  D27, X4
    FMOV  V27.D[1], X8
    FMOV  D28, X11
    FMOV  V28.D[1], X21
    FMOV  D29, X2
    FMOV  V29.D[1], X8
    FMOV  D30, X8
    FMOV  V30.D[1], X15
    FMOV  D31, X13
    FMOV  V31.D[1], X13
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X7, #0x40, LSL #0
    MOVZ  X26, #0x1e00, LSL #0
    ADD  X18, X30, X26
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X18]
    LD4R { V16.16B, V17.16B, V18.16B, V19.16B }, [X18]
    ADD  X18, X18, X7
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X18]
    LD4R { V29.16B, V30.16B, V31.16B, V0.16B }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X18]
    LD4R { V11.2D, V12.2D, V13.2D, V14.2D }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X18]
    LD4R { V2.4S, V3.4S, V4.4S, V5.4S }, [X18]
    ADD  X18, X18, X7
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X18]
    LD4R { V6.8H, V7.8H, V8.8H, V9.8H }, [X18]
    ADD  X18, X18, X7, ASR #0
    ST4 { V17.16B, V18.16B, V19.16B, V20.16B }, [X18]
    LD4R { V14.4H, V15.4H, V16.4H, V17.4H }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X18]
    LD4R { V9.1D, V10.1D, V11.1D, V12.1D }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X18]
    LD4R { V29.2S, V30.2S, V31.2S, V0.2S }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V2.2D, V3.2D, V4.2D, V5.2D }, [X18]
    LD4R { V21.4H, V22.4H, V23.4H, V24.4H }, [X18]
    ADD  X18, X18, X7, LSR #0
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X18]
    LD4R { V24.8B, V25.8B, V26.8B, V27.8B }, [X18]
    ADD  X18, X18, X7
    ST4 { V22.16B, V23.16B, V24.16B, V25.16B }, [X18]
    MOV  X24, X18
    LD4R { V2.2S, V3.2S, V4.2S, V5.2S }, [X24], #16
    ADD  X18, X18, X7, ASR #0
    ST4 { V8.2D, V9.2D, V10.2D, V11.2D }, [X18]
    MOV  X24, X18
    LD4R { V13.2S, V14.2S, V15.2S, V16.2S }, [X24], #16
    ADD  X18, X18, X7, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X18]
    MOV  X24, X18
    LD4R { V6.4S, V7.4S, V8.4S, V9.4S }, [X24], #16
    ADD  X18, X18, X7, ASR #0
    ST4 { V6.16B, V7.16B, V8.16B, V9.16B }, [X18]
    MOV  X24, X18
    LD4R { V29.2D, V30.2D, V31.2D, V0.2D }, [X24], #32
    ADD  X18, X18, X7
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X18]
    MOV  X24, X18
    LD4R { V7.1D, V8.1D, V9.1D, V10.1D }, [X24], #32
    ADD  X18, X18, X7, ASR #0
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X18]
    MOV  X24, X18
    LD4R { V13.2D, V14.2D, V15.2D, V16.2D }, [X24], #32
    ADD  X18, X18, X7
    ST4 { V31.16B, V0.16B, V1.16B, V2.16B }, [X18]
    MOV  X24, X18
    LD4R { V22.16B, V23.16B, V24.16B, V25.16B }, [X24], #4
    ADD  X18, X18, X7
    ST4 { V30.16B, V31.16B, V0.16B, V1.16B }, [X18]
    MOV  X24, X18
    LD4R { V24.16B, V25.16B, V26.16B, V27.16B }, [X24], #4
    ADD  X18, X18, X7, LSR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X18]
    MOV  X24, X18
    LD4R { V14.8B, V15.8B, V16.8B, V17.8B }, [X24], #4
    ADD  X18, X18, X7
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X18]
    MOV  X24, X18
    LD4R { V31.4H, V0.4H, V1.4H, V2.4H }, [X24], #8
    ADD  X18, X18, X7
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X18]
    MOV  X24, X18
    LD4R { V14.8H, V15.8H, V16.8H, V17.8H }, [X24], #8
    ADD  X18, X18, X7, LSR #0
    ST4 { V31.8H, V0.8H, V1.8H, V2.8H }, [X18]
    MOV  X24, X18
    LD4R { V10.4H, V11.4H, V12.4H, V13.4H }, [X24], #8
    ADD  X18, X18, X7
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X18]
    LD4R { V21.2D, V22.2D, V23.2D, V24.2D }, [X18], X8
    ADD  X18, X18, X7, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X18]
    LD4R { V5.16B, V6.16B, V7.16B, V8.16B }, [X18], X8
    ADD  X18, X18, X7, ASR #0
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X18]
    LD4R { V31.2D, V0.2D, V1.2D, V2.2D }, [X18], X8
    ADD  X18, X18, X7
    ST4 { V1.16B, V2.16B, V3.16B, V4.16B }, [X18]
    LD4R { V14.4S, V15.4S, V16.4S, V17.4S }, [X18], X8
    ADD  X18, X18, X7, LSR #0
    ST4 { V28.2D, V29.2D, V30.2D, V31.2D }, [X18]
    LD4R { V6.8H, V7.8H, V8.8H, V9.8H }, [X18], X8
    ADD  X18, X18, X7, ASR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X18]
    LD4R { V11.8B, V12.8B, V13.8B, V14.8B }, [X18], X8
    ADD  X18, X18, X7
    ST4 { V11.4S, V12.4S, V13.4S, V14.4S }, [X18]
    LD4R { V28.1D, V29.1D, V30.1D, V31.1D }, [X18], X8
    ADD  X18, X18, X7
    ST4 { V6.2D, V7.2D, V8.2D, V9.2D }, [X18]
    LD4R { V21.2S, V22.2S, V23.2S, V24.2S }, [X18], X8
    ADD  X18, X18, X7, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X18]
    LD4R { V14.4H, V15.4H, V16.4H, V17.4H }, [X18], X8
    ADD  X18, X18, X7, LSR #0
    ST4 { V14.16B, V15.16B, V16.16B, V17.16B }, [X18]
    LD4R { V14.8B, V15.8B, V16.8B, V17.8B }, [X18], X8
    ADD  X18, X18, X7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X20
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X21, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X29, FPSR
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D1
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D2
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D3
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D4
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D5
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D6
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D7
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D8
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D9
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D10
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D11
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D12
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D13
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D14
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D15
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D16
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D17
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D18
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D19
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D20
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D21
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D22
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D23
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D24
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D25
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D26
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D27
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D28
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D29
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D30
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X29, D31
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X28, X21, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  D0, X4
    FMOV  V0.D[1], X23
    FMOV  D1, X29
    FMOV  V1.D[1], X10
    FMOV  D2, X27
    FMOV  V2.D[1], X22
    FMOV  D3, X26
    FMOV  V3.D[1], X28
    FMOV  D4, X20
    FMOV  V4.D[1], X18
    FMOV  D5, X23
    FMOV  V5.D[1], X19
    FMOV  D6, X18
    FMOV  V6.D[1], X15
    FMOV  D7, X7
    FMOV  V7.D[1], X9
    FMOV  D8, X2
    FMOV  V8.D[1], X20
    FMOV  D9, X27
    FMOV  V9.D[1], X9
    FMOV  D10, X7
    FMOV  V10.D[1], X23
    FMOV  D11, X10
    FMOV  V11.D[1], X26
    FMOV  D12, X21
    FMOV  V12.D[1], X26
    FMOV  D13, X26
    FMOV  V13.D[1], X11
    FMOV  D14, X29
    FMOV  V14.D[1], X10
    FMOV  D15, X20
    FMOV  V15.D[1], X7
    FMOV  D16, X29
    FMOV  V16.D[1], X27
    FMOV  D17, X17
    FMOV  V17.D[1], X25
    FMOV  D18, X2
    FMOV  V18.D[1], X8
    FMOV  D19, X25
    FMOV  V19.D[1], X15
    FMOV  D20, X17
    FMOV  V20.D[1], X2
    FMOV  D21, X16
    FMOV  V21.D[1], X22
    FMOV  D22, X18
    FMOV  V22.D[1], X7
    FMOV  D23, X29
    FMOV  V23.D[1], X29
    FMOV  D24, X21
    FMOV  V24.D[1], X27
    FMOV  D25, X18
    FMOV  V25.D[1], X21
    FMOV  D26, X11
    FMOV  V26.D[1], X15
    FMOV  D27, X17
    FMOV  V27.D[1], X21
    FMOV  D28, X15
    FMOV  V28.D[1], X23
    FMOV  D29, X15
    FMOV  V29.D[1], X29
    FMOV  D30, X8
    FMOV  V30.D[1], X25
    FMOV  D31, X12
    FMOV  V31.D[1], X21
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X22, #0x40, LSL #0
    MOVZ  X11, #0x2300, LSL #0
    ADD  X26, X30, X11, LSR #0
    ST4 { V25.8H, V26.8H, V27.8H, V28.8H }, [X26]
    LD4R { V31.16B, V0.16B, V1.16B, V2.16B }, [X26]
    ADD  X26, X26, X22, LSR #0
    ST4 { V30.8H, V31.8H, V0.8H, V1.8H }, [X26]
    LD4R { V14.16B, V15.16B, V16.16B, V17.16B }, [X26]
    ADD  X26, X26, X22, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X26]
    LD4R { V27.2D, V28.2D, V29.2D, V30.2D }, [X26]
    ADD  X26, X26, X22
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X26]
    LD4R { V26.4S, V27.4S, V28.4S, V29.4S }, [X26]
    ADD  X26, X26, X22
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X26]
    LD4R { V18.8H, V19.8H, V20.8H, V21.8H }, [X26]
    ADD  X26, X26, X22, LSR #0
    ST4 { V11.16B, V12.16B, V13.16B, V14.16B }, [X26]
    LD4R { V24.2S, V25.2S, V26.2S, V27.2S }, [X26]
    ADD  X26, X26, X22, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X26]
    LD4R { V28.1D, V29.1D, V30.1D, V31.1D }, [X26]
    ADD  X26, X26, X22, ASR #0
    ST4 { V18.4S, V19.4S, V20.4S, V21.4S }, [X26]
    LD4R { V5.2S, V6.2S, V7.2S, V8.2S }, [X26]
    ADD  X26, X26, X22, LSR #0
    ST4 { V25.4S, V26.4S, V27.4S, V28.4S }, [X26]
    LD4R { V15.4H, V16.4H, V17.4H, V18.4H }, [X26]
    ADD  X26, X26, X22, LSR #0
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X26]
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X26]
    ADD  X26, X26, X22
    ST4 { V15.16B, V16.16B, V17.16B, V18.16B }, [X26]
    MOV  X13, X26
    LD4R { V15.4S, V16.4S, V17.4S, V18.4S }, [X13], #16
    ADD  X26, X26, X22, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X26]
    MOV  X13, X26
    LD4R { V22.2S, V23.2S, V24.2S, V25.2S }, [X13], #16
    ADD  X26, X26, X22, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X26]
    MOV  X13, X26
    LD4R { V9.4S, V10.4S, V11.4S, V12.4S }, [X13], #16
    ADD  X26, X26, X22, ASR #0
    ST4 { V29.8H, V30.8H, V31.8H, V0.8H }, [X26]
    MOV  X13, X26
    LD4R { V26.2D, V27.2D, V28.2D, V29.2D }, [X13], #32
    ADD  X26, X26, X22, LSR #0
    ST4 { V26.4S, V27.4S, V28.4S, V29.4S }, [X26]
    MOV  X13, X26
    LD4R { V26.1D, V27.1D, V28.1D, V29.1D }, [X13], #32
    ADD  X26, X26, X22, LSR #0
    ST4 { V9.4S, V10.4S, V11.4S, V12.4S }, [X26]
    MOV  X13, X26
    LD4R { V10.2D, V11.2D, V12.2D, V13.2D }, [X13], #32
    ADD  X26, X26, X22, ASR #0
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X26]
    MOV  X13, X26
    LD4R { V2.8B, V3.8B, V4.8B, V5.8B }, [X13], #4
    ADD  X26, X26, X22, LSR #0
    ST4 { V13.16B, V14.16B, V15.16B, V16.16B }, [X26]
    MOV  X13, X26
    LD4R { V17.16B, V18.16B, V19.16B, V20.16B }, [X13], #4
    ADD  X26, X26, X22, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X26]
    MOV  X13, X26
    LD4R { V15.8B, V16.8B, V17.8B, V18.8B }, [X13], #4
    ADD  X26, X26, X22, ASR #0
    ST4 { V8.16B, V9.16B, V10.16B, V11.16B }, [X26]
    MOV  X13, X26
    LD4R { V12.4H, V13.4H, V14.4H, V15.4H }, [X13], #8
    ADD  X26, X26, X22, LSR #0
    ST4 { V20.2D, V21.2D, V22.2D, V23.2D }, [X26]
    MOV  X13, X26
    LD4R { V19.8H, V20.8H, V21.8H, V22.8H }, [X13], #8
    ADD  X26, X26, X22, ASR #0
    ST4 { V11.8H, V12.8H, V13.8H, V14.8H }, [X26]
    MOV  X13, X26
    LD4R { V26.8H, V27.8H, V28.8H, V29.8H }, [X13], #8
    ADD  X26, X26, X22, LSR #0
    ST4 { V26.2D, V27.2D, V28.2D, V29.2D }, [X26]
    LD4R { V10.16B, V11.16B, V12.16B, V13.16B }, [X26], X28
    ADD  X26, X26, X22, LSR #0
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X26]
    LD4R { V31.16B, V0.16B, V1.16B, V2.16B }, [X26], X28
    ADD  X26, X26, X22
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X26]
    LD4R { V24.2D, V25.2D, V26.2D, V27.2D }, [X26], X28
    ADD  X26, X26, X22, ASR #0
    ST4 { V27.2D, V28.2D, V29.2D, V30.2D }, [X26]
    LD4R { V19.4S, V20.4S, V21.4S, V22.4S }, [X26], X28
    ADD  X26, X26, X22, ASR #0
    ST4 { V14.4S, V15.4S, V16.4S, V17.4S }, [X26]
    LD4R { V10.8H, V11.8H, V12.8H, V13.8H }, [X26], X28
    ADD  X26, X26, X22, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X26]
    LD4R { V10.1D, V11.1D, V12.1D, V13.1D }, [X26], X28
    ADD  X26, X26, X22, LSR #0
    ST4 { V16.8H, V17.8H, V18.8H, V19.8H }, [X26]
    LD4R { V27.1D, V28.1D, V29.1D, V30.1D }, [X26], X28
    ADD  X26, X26, X22, ASR #0
    ST4 { V24.4S, V25.4S, V26.4S, V27.4S }, [X26]
    LD4R { V15.2S, V16.2S, V17.2S, V18.2S }, [X26], X28
    ADD  X26, X26, X22, ASR #0
    ST4 { V25.2D, V26.2D, V27.2D, V28.2D }, [X26]
    LD4R { V23.4H, V24.4H, V25.4H, V26.4H }, [X26], X28
    ADD  X26, X26, X22, ASR #0
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X26]
    LD4R { V2.8B, V3.8B, V4.8B, V5.8B }, [X26], X28
    ADD  X26, X26, X22, LSR #0
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X4
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X8
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X17
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X18
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X19
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X21
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X12, #0xa5a5, LSL #0
    MOVK  X12, #0xa5a5, LSL #16
    MOVK  X12, #0xa5a5, LSL #32
    MOVK  X12, #0xa5a5, LSL #48
    SUB  X20, X12, X29
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X12, FPSR
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D0
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D1
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D2
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D3
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D4
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D5
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D6
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D7
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D8
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D9
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D10
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D11
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D12
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D13
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D14
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D15
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D16
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D17
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D18
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D19
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D20
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D21
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D22
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D23
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D24
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D25
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D26
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D27
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D28
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D29
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X20, #0x0, LSL #0
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D30
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X12, D31
    MOVZ  X20, #0xa5a5, LSL #0
    MOVK  X20, #0xa5a5, LSL #16
    MOVK  X20, #0xa5a5, LSL #32
    MOVK  X20, #0xa5a5, LSL #48
    SUB  X27, X20, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
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
    FMOV  D0, X11
    FMOV  V0.D[1], X28
    FMOV  D1, X16
    FMOV  V1.D[1], X13
    FMOV  D2, X16
    FMOV  V2.D[1], X16
    FMOV  D3, X29
    FMOV  V3.D[1], X27
    FMOV  D4, X25
    FMOV  V4.D[1], X29
    FMOV  D5, X10
    FMOV  V5.D[1], X17
    FMOV  D6, X21
    FMOV  V6.D[1], X17
    FMOV  D7, X13
    FMOV  V7.D[1], X24
    FMOV  D8, X12
    FMOV  V8.D[1], X27
    FMOV  D9, X21
    FMOV  V9.D[1], X14
    FMOV  D10, X18
    FMOV  V10.D[1], X17
    FMOV  D11, X11
    FMOV  V11.D[1], X10
    FMOV  D12, X9
    FMOV  V12.D[1], X16
    FMOV  D13, X24
    FMOV  V13.D[1], X21
    FMOV  D14, X12
    FMOV  V14.D[1], X27
    FMOV  D15, X15
    FMOV  V15.D[1], X21
    FMOV  D16, X7
    FMOV  V16.D[1], X7
    FMOV  D17, X19
    FMOV  V17.D[1], X23
    FMOV  D18, X4
    FMOV  V18.D[1], X2
    FMOV  D19, X23
    FMOV  V19.D[1], X26
    FMOV  D20, X11
    FMOV  V20.D[1], X7
    FMOV  D21, X17
    FMOV  V21.D[1], X13
    FMOV  D22, X7
    FMOV  V22.D[1], X20
    FMOV  D23, X23
    FMOV  V23.D[1], X10
    FMOV  D24, X12
    FMOV  V24.D[1], X27
    FMOV  D25, X14
    FMOV  V25.D[1], X29
    FMOV  D26, X20
    FMOV  V26.D[1], X4
    FMOV  D27, X24
    FMOV  V27.D[1], X10
    FMOV  D28, X2
    FMOV  V28.D[1], X20
    FMOV  D29, X17
    FMOV  V29.D[1], X17
    FMOV  D30, X13
    FMOV  V30.D[1], X22
    FMOV  D31, X22
    FMOV  V31.D[1], X29
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X20, #0x40, LSL #0
    MOVZ  X15, #0x2800, LSL #0
    ADD  X25, X30, X15, ASR #0
    ST4 { V12.2D, V13.2D, V14.2D, V15.2D }, [X25]
    LD4R { V26.16B, V27.16B, V28.16B, V29.16B }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V27.4S, V28.4S, V29.4S, V30.4S }, [X25]
    LD4R { V25.16B, V26.16B, V27.16B, V28.16B }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X25]
    LD4R { V28.2D, V29.2D, V30.2D, V31.2D }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X25]
    LD4R { V6.4S, V7.4S, V8.4S, V9.4S }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V13.4S, V14.4S, V15.4S, V16.4S }, [X25]
    LD4R { V3.8H, V4.8H, V5.8H, V6.8H }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X25]
    LD4R { V4.1D, V5.1D, V6.1D, V7.1D }, [X25]
    ADD  X25, X25, X20, ASR #0
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X25]
    LD4R { V28.1D, V29.1D, V30.1D, V31.1D }, [X25]
    ADD  X25, X25, X20
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X25]
    LD4R { V15.2S, V16.2S, V17.2S, V18.2S }, [X25]
    ADD  X25, X25, X20, LSR #0
    ST4 { V20.16B, V21.16B, V22.16B, V23.16B }, [X25]
    LD4R { V4.4H, V5.4H, V6.4H, V7.4H }, [X25]
    ADD  X25, X25, X20, ASR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X25]
    LD4R { V2.8B, V3.8B, V4.8B, V5.8B }, [X25]
    ADD  X25, X25, X20
    ST4 { V6.4S, V7.4S, V8.4S, V9.4S }, [X25]
    MOV  X24, X25
    LD4R { V20.4S, V21.4S, V22.4S, V23.4S }, [X24], #16
    ADD  X25, X25, X20, ASR #0
    ST4 { V27.8H, V28.8H, V29.8H, V30.8H }, [X25]
    MOV  X24, X25
    LD4R { V18.2S, V19.2S, V20.2S, V21.2S }, [X24], #16
    ADD  X25, X25, X20, ASR #0
    ST4 { V15.8H, V16.8H, V17.8H, V18.8H }, [X25]
    MOV  X24, X25
    LD4R { V0.4S, V1.4S, V2.4S, V3.4S }, [X24], #16
    ADD  X25, X25, X20, ASR #0
    ST4 { V17.2D, V18.2D, V19.2D, V20.2D }, [X25]
    MOV  X24, X25
    LD4R { V6.1D, V7.1D, V8.1D, V9.1D }, [X24], #32
    ADD  X25, X25, X20, LSR #0
    ST4 { V4.2D, V5.2D, V6.2D, V7.2D }, [X25]
    MOV  X24, X25
    LD4R { V21.1D, V22.1D, V23.1D, V24.1D }, [X24], #32
    ADD  X25, X25, X20
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X25]
    MOV  X24, X25
    LD4R { V24.2D, V25.2D, V26.2D, V27.2D }, [X24], #32
    ADD  X25, X25, X20, ASR #0
    ST4 { V24.16B, V25.16B, V26.16B, V27.16B }, [X25]
    MOV  X24, X25
    LD4R { V19.16B, V20.16B, V21.16B, V22.16B }, [X24], #4
    ADD  X25, X25, X20, ASR #0
    ST4 { V7.8H, V8.8H, V9.8H, V10.8H }, [X25]
    MOV  X24, X25
    LD4R { V15.16B, V16.16B, V17.16B, V18.16B }, [X24], #4
    ADD  X25, X25, X20, LSR #0
    ST4 { V4.16B, V5.16B, V6.16B, V7.16B }, [X25]
    MOV  X24, X25
    LD4R { V23.8B, V24.8B, V25.8B, V26.8B }, [X24], #4
    ADD  X25, X25, X20, ASR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X25]
    MOV  X24, X25
    LD4R { V2.4H, V3.4H, V4.4H, V5.4H }, [X24], #8
    ADD  X25, X25, X20, LSR #0
    ST4 { V17.4S, V18.4S, V19.4S, V20.4S }, [X25]
    MOV  X24, X25
    LD4R { V6.8H, V7.8H, V8.8H, V9.8H }, [X24], #8
    ADD  X25, X25, X20, ASR #0
    ST4 { V3.4S, V4.4S, V5.4S, V6.4S }, [X25]
    MOV  X24, X25
    LD4R { V3.8H, V4.8H, V5.8H, V6.8H }, [X24], #8
    ADD  X25, X25, X20, ASR #0
    ST4 { V24.8H, V25.8H, V26.8H, V27.8H }, [X25]
    LD4R { V17.8H, V18.8H, V19.8H, V20.8H }, [X25], X17
    ADD  X25, X25, X20, ASR #0
    ST4 { V2.4S, V3.4S, V4.4S, V5.4S }, [X25]
    LD4R { V16.16B, V17.16B, V18.16B, V19.16B }, [X25], X17
    ADD  X25, X25, X20, ASR #0
    ST4 { V16.16B, V17.16B, V18.16B, V19.16B }, [X25]
    LD4R { V0.2D, V1.2D, V2.2D, V3.2D }, [X25], X17
    ADD  X25, X25, X20, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X25]
    LD4R { V0.4S, V1.4S, V2.4S, V3.4S }, [X25], X17
    ADD  X25, X25, X20
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X25]
    LD4R { V17.8H, V18.8H, V19.8H, V20.8H }, [X25], X17
    ADD  X25, X25, X20
    ST4 { V23.16B, V24.16B, V25.16B, V26.16B }, [X25]
    LD4R { V23.4H, V24.4H, V25.4H, V26.4H }, [X25], X17
    ADD  X25, X25, X20
    ST4 { V23.8H, V24.8H, V25.8H, V26.8H }, [X25]
    LD4R { V0.1D, V1.1D, V2.1D, V3.1D }, [X25], X17
    ADD  X25, X25, X20
    ST4 { V17.8H, V18.8H, V19.8H, V20.8H }, [X25]
    LD4R { V16.2S, V17.2S, V18.2S, V19.2S }, [X25], X17
    ADD  X25, X25, X20, LSR #0
    ST4 { V0.8H, V1.8H, V2.8H, V3.8H }, [X25]
    LD4R { V24.4H, V25.4H, V26.4H, V27.4H }, [X25], X17
    ADD  X25, X25, X20, ASR #0
    ST4 { V16.2D, V17.2D, V18.2D, V19.2D }, [X25]
    LD4R { V16.8B, V17.8B, V18.8B, V19.8B }, [X25], X17
    ADD  X25, X25, X20
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X18
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X19
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X22
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X21, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X21, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X8, FPSR
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D0
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D1
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D2
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D3
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D4
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D5
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D6
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D7
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D8
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D9
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D10
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D11
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D12
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D13
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D14
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D15
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D16
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D17
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D18
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D19
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D20
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D21
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D22
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D23
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D24
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D25
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D26
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D27
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D28
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D29
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D30
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X21, #0x0, LSL #0
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X8, D31
    MOVZ  X21, #0x5a5a, LSL #0
    MOVK  X21, #0x5a5a, LSL #16
    MOVK  X21, #0x5a5a, LSL #32
    MOVK  X21, #0x5a5a, LSL #48
    SUB  X10, X21, X8
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
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
    FMOV  V1.D[1], X25
    FMOV  D2, X28
    FMOV  V2.D[1], X21
    FMOV  D3, X10
    FMOV  V3.D[1], X2
    FMOV  D4, X12
    FMOV  V4.D[1], X21
    FMOV  D5, X22
    FMOV  V5.D[1], X11
    FMOV  D6, X17
    FMOV  V6.D[1], X12
    FMOV  D7, X28
    FMOV  V7.D[1], X20
    FMOV  D8, X2
    FMOV  V8.D[1], X4
    FMOV  D9, X12
    FMOV  V9.D[1], X20
    FMOV  D10, X22
    FMOV  V10.D[1], X16
    FMOV  D11, X26
    FMOV  V11.D[1], X14
    FMOV  D12, X7
    FMOV  V12.D[1], X22
    FMOV  D13, X12
    FMOV  V13.D[1], X4
    FMOV  D14, X19
    FMOV  V14.D[1], X29
    FMOV  D15, X17
    FMOV  V15.D[1], X17
    FMOV  D16, X18
    FMOV  V16.D[1], X21
    FMOV  D17, X15
    FMOV  V17.D[1], X9
    FMOV  D18, X25
    FMOV  V18.D[1], X12
    FMOV  D19, X25
    FMOV  V19.D[1], X24
    FMOV  D20, X13
    FMOV  V20.D[1], X4
    FMOV  D21, X2
    FMOV  V21.D[1], X7
    FMOV  D22, X25
    FMOV  V22.D[1], X21
    FMOV  D23, X21
    FMOV  V23.D[1], X28
    FMOV  D24, X24
    FMOV  V24.D[1], X20
    FMOV  D25, X21
    FMOV  V25.D[1], X7
    FMOV  D26, X2
    FMOV  V26.D[1], X18
    FMOV  D27, X19
    FMOV  V27.D[1], X13
    FMOV  D28, X27
    FMOV  V28.D[1], X19
    FMOV  D29, X19
    FMOV  V29.D[1], X23
    FMOV  D30, X28
    FMOV  V30.D[1], X28
    FMOV  D31, X11
    FMOV  V31.D[1], X15
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X13, #0x2d00, LSL #0
    ADD  X25, X30, X13
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X25]
    LD4R { V4.8H, V5.8H, V6.8H, V7.8H }, [X25]
    ADD  X25, X25, X14
    ST4 { V4.8H, V5.8H, V6.8H, V7.8H }, [X25]
    LD4R { V26.16B, V27.16B, V28.16B, V29.16B }, [X25]
    ADD  X25, X25, X14, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X25]
    LD4R { V22.2D, V23.2D, V24.2D, V25.2D }, [X25]
    ADD  X25, X25, X14, LSR #0
    ST4 { V24.2D, V25.2D, V26.2D, V27.2D }, [X25]
    LD4R { V21.4S, V22.4S, V23.4S, V24.4S }, [X25]
    ADD  X25, X25, X14
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X25]
    LD4R { V5.8H, V6.8H, V7.8H, V8.8H }, [X25]
    ADD  X25, X25, X14
    ST4 { V10.16B, V11.16B, V12.16B, V13.16B }, [X25]
    LD4R { V26.2S, V27.2S, V28.2S, V29.2S }, [X25]
    ADD  X25, X25, X14, LSR #0
    ST4 { V26.8H, V27.8H, V28.8H, V29.8H }, [X25]
    LD4R { V26.1D, V27.1D, V28.1D, V29.1D }, [X25]
    ADD  X25, X25, X14, LSR #0
    ST4 { V26.16B, V27.16B, V28.16B, V29.16B }, [X25]
    LD4R { V16.2S, V17.2S, V18.2S, V19.2S }, [X25]
    ADD  X25, X25, X14, LSR #0
    ST4 { V5.8H, V6.8H, V7.8H, V8.8H }, [X25]
    LD4R { V6.4H, V7.4H, V8.4H, V9.4H }, [X25]
    ADD  X25, X25, X14, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X25]
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X25]
    ADD  X25, X25, X14, LSR #0
    ST4 { V28.16B, V29.16B, V30.16B, V31.16B }, [X25]
    MOV  X27, X25
    LD4R { V26.4S, V27.4S, V28.4S, V29.4S }, [X27], #16
    ADD  X25, X25, X14, ASR #0
    ST4 { V21.16B, V22.16B, V23.16B, V24.16B }, [X25]
    MOV  X27, X25
    LD4R { V11.2S, V12.2S, V13.2S, V14.2S }, [X27], #16
    ADD  X25, X25, X14
    ST4 { V5.16B, V6.16B, V7.16B, V8.16B }, [X25]
    MOV  X27, X25
    LD4R { V5.4S, V6.4S, V7.4S, V8.4S }, [X27], #16
    ADD  X25, X25, X14
    ST4 { V29.4S, V30.4S, V31.4S, V0.4S }, [X25]
    MOV  X27, X25
    LD4R { V1.1D, V2.1D, V3.1D, V4.1D }, [X27], #32
    ADD  X25, X25, X14
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X25]
    MOV  X27, X25
    LD4R { V21.1D, V22.1D, V23.1D, V24.1D }, [X27], #32
    ADD  X25, X25, X14, LSR #0
    ST4 { V5.4S, V6.4S, V7.4S, V8.4S }, [X25]
    MOV  X27, X25
    LD4R { V13.2D, V14.2D, V15.2D, V16.2D }, [X27], #32
    ADD  X25, X25, X14
    ST4 { V13.2D, V14.2D, V15.2D, V16.2D }, [X25]
    MOV  X27, X25
    LD4R { V5.8B, V6.8B, V7.8B, V8.8B }, [X27], #4
    ADD  X25, X25, X14, LSR #0
    ST4 { V2.16B, V3.16B, V4.16B, V5.16B }, [X25]
    MOV  X27, X25
    LD4R { V0.16B, V1.16B, V2.16B, V3.16B }, [X27], #4
    ADD  X25, X25, X14, LSR #0
    ST4 { V9.2D, V10.2D, V11.2D, V12.2D }, [X25]
    MOV  X27, X25
    LD4R { V0.8B, V1.8B, V2.8B, V3.8B }, [X27], #4
    ADD  X25, X25, X14
    ST4 { V29.16B, V30.16B, V31.16B, V0.16B }, [X25]
    MOV  X27, X25
    LD4R { V13.4H, V14.4H, V15.4H, V16.4H }, [X27], #8
    ADD  X25, X25, X14, ASR #0
    ST4 { V13.8H, V14.8H, V15.8H, V16.8H }, [X25]
    MOV  X27, X25
    LD4R { V29.8H, V30.8H, V31.8H, V0.8H }, [X27], #8
    ADD  X25, X25, X14, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X25]
    MOV  X27, X25
    LD4R { V10.4H, V11.4H, V12.4H, V13.4H }, [X27], #8
    ADD  X25, X25, X14, ASR #0
    ST4 { V21.8H, V22.8H, V23.8H, V24.8H }, [X25]
    LD4R { V28.8H, V29.8H, V30.8H, V31.8H }, [X25], X9
    ADD  X25, X25, X14, LSR #0
    ST4 { V10.2D, V11.2D, V12.2D, V13.2D }, [X25]
    LD4R { V21.16B, V22.16B, V23.16B, V24.16B }, [X25], X9
    ADD  X25, X25, X14, ASR #0
    ST4 { V14.2D, V15.2D, V16.2D, V17.2D }, [X25]
    LD4R { V11.2D, V12.2D, V13.2D, V14.2D }, [X25], X9
    ADD  X25, X25, X14
    ST4 { V8.8H, V9.8H, V10.8H, V11.8H }, [X25]
    LD4R { V24.4S, V25.4S, V26.4S, V27.4S }, [X25], X9
    ADD  X25, X25, X14, LSR #0
    ST4 { V28.8H, V29.8H, V30.8H, V31.8H }, [X25]
    LD4R { V8.8H, V9.8H, V10.8H, V11.8H }, [X25], X9
    ADD  X25, X25, X14, LSR #0
    ST4 { V9.8H, V10.8H, V11.8H, V12.8H }, [X25]
    LD4R { V21.1D, V22.1D, V23.1D, V24.1D }, [X25], X9
    ADD  X25, X25, X14
    ST4 { V27.16B, V28.16B, V29.16B, V30.16B }, [X25]
    LD4R { V26.1D, V27.1D, V28.1D, V29.1D }, [X25], X9
    ADD  X25, X25, X14, LSR #0
    ST4 { V21.4S, V22.4S, V23.4S, V24.4S }, [X25]
    LD4R { V9.2S, V10.2S, V11.2S, V12.2S }, [X25], X9
    ADD  X25, X25, X14
    ST4 { V3.16B, V4.16B, V5.16B, V6.16B }, [X25]
    LD4R { V31.4H, V0.4H, V1.4H, V2.4H }, [X25], X9
    ADD  X25, X25, X14, ASR #0
    ST4 { V9.16B, V10.16B, V11.16B, V12.16B }, [X25]
    LD4R { V4.8B, V5.8B, V6.8B, V7.8B }, [X25], X9
    ADD  X25, X25, X14
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X2
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X4
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X7
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X10
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X11
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X12
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X15
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X16
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X17
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X18
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X21
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X22
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X23
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X24
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X28
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MOVZ  X26, #0xa5a5, LSL #0
    MOVK  X26, #0xa5a5, LSL #16
    MOVK  X26, #0xa5a5, LSL #32
    MOVK  X26, #0xa5a5, LSL #48
    SUB  X19, X26, X29
    ADD  X1, X1, #0x1
    CBNZ  X19, AdvsimdLoadDeprecatedP04_TestFail
    MRS  X26, FPSR
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V0.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D0
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V1.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D1
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V2.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D2
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V3.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D3
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V4.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D4
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V5.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D5
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V6.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D6
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V7.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D7
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V8.D[1]
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D8
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V9.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D9
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V10.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D10
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V11.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D11
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V12.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D12
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V13.D[1]
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D13
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V14.D[1]
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D14
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V15.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D15
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V16.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D16
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V17.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D17
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V18.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D18
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V19.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D19
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V20.D[1]
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D20
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V21.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D21
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V22.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D22
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V23.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D23
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V24.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D24
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V25.D[1]
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D25
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V26.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D26
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V27.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D27
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V28.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D28
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V29.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D29
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V30.D[1]
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D30
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, V31.D[1]
    MOVZ  X19, #0x0, LSL #0
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail
    FMOV  X26, D31
    MOVZ  X19, #0xa5a5, LSL #0
    MOVK  X19, #0xa5a5, LSL #16
    MOVK  X19, #0xa5a5, LSL #32
    MOVK  X19, #0xa5a5, LSL #48
    SUB  X20, X19, X26
    ADD  X1, X1, #0x1
    CBNZ  X20, AdvsimdLoadDeprecatedP04_TestFail

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
