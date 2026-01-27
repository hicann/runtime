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
    MOVZ  X2, #0x8f69, LSL #0
    MOVK  X2, #0xea7a, LSL #16
    MOVK  X2, #0xccd3, LSL #32
    MOVK  X2, #0x5abc, LSL #48
    MOVZ  X3, #0x970c, LSL #0
    MOVK  X3, #0x2eff, LSL #16
    MOVK  X3, #0x37b4, LSL #32
    MOVK  X3, #0x9b52, LSL #48
    MOVZ  X4, #0x83ef, LSL #0
    MOVK  X4, #0x6c23, LSL #16
    MOVK  X4, #0x29ba, LSL #32
    MOVK  X4, #0x6e6d, LSL #48
    MOVZ  X5, #0x3059, LSL #0
    MOVK  X5, #0x3753, LSL #16
    MOVK  X5, #0xd4cc, LSL #32
    MOVK  X5, #0xb22f, LSL #48
    MOVZ  X6, #0x3c08, LSL #0
    MOVK  X6, #0x50be, LSL #16
    MOVK  X6, #0xac49, LSL #32
    MOVK  X6, #0xb54c, LSL #48
    MOVZ  X7, #0xb9c1, LSL #0
    MOVK  X7, #0xb00f, LSL #16
    MOVK  X7, #0xb9e7, LSL #32
    MOVK  X7, #0x462f, LSL #48
    MOVZ  X8, #0x6065, LSL #0
    MOVK  X8, #0xd6e8, LSL #16
    MOVK  X8, #0xc3c9, LSL #32
    MOVK  X8, #0xaffe, LSL #48
    MOVZ  X9, #0xe6eb, LSL #0
    MOVK  X9, #0xed8f, LSL #16
    MOVK  X9, #0xda20, LSL #32
    MOVK  X9, #0xb249, LSL #48
    MOVZ  X10, #0xd9e8, LSL #0
    MOVK  X10, #0x39cc, LSL #16
    MOVK  X10, #0xc991, LSL #32
    MOVK  X10, #0x6f35, LSL #48
    MOVZ  X11, #0xa366, LSL #0
    MOVK  X11, #0x8640, LSL #16
    MOVK  X11, #0x6b66, LSL #32
    MOVK  X11, #0x8d3a, LSL #48
    MOVZ  X12, #0xc57f, LSL #0
    MOVK  X12, #0x8695, LSL #16
    MOVK  X12, #0x8afb, LSL #32
    MOVK  X12, #0x6db6, LSL #48
    MOVZ  X13, #0x569, LSL #0
    MOVK  X13, #0x65e5, LSL #16
    MOVK  X13, #0xb24b, LSL #32
    MOVK  X13, #0xb768, LSL #48
    MOVZ  X14, #0xe3b8, LSL #0
    MOVK  X14, #0x704c, LSL #16
    MOVK  X14, #0xa62a, LSL #32
    MOVK  X14, #0x6c4e, LSL #48
    MOVZ  X15, #0x45f2, LSL #0
    MOVK  X15, #0xf706, LSL #16
    MOVK  X15, #0xa855, LSL #32
    MOVK  X15, #0x43fd, LSL #48
    MOVZ  X16, #0x96c6, LSL #0
    MOVK  X16, #0xcc92, LSL #16
    MOVK  X16, #0x1381, LSL #32
    MOVK  X16, #0xf0bb, LSL #48
    MOVZ  X17, #0x14ea, LSL #0
    MOVK  X17, #0x9351, LSL #16
    MOVK  X17, #0x8861, LSL #32
    MOVK  X17, #0x916f, LSL #48
    MOVZ  X23, #0xd349, LSL #0
    MOVK  X23, #0x331a, LSL #16
    MOVK  X23, #0xcd4b, LSL #32
    MOVK  X23, #0xa47d, LSL #48
    MOVZ  X24, #0x86a6, LSL #0
    MOVK  X24, #0x9a4a, LSL #16
    MOVK  X24, #0xbf50, LSL #32
    MOVK  X24, #0x9be4, LSL #48
    MOVZ  X25, #0x6f48, LSL #0
    MOVK  X25, #0x84d9, LSL #16
    MOVK  X25, #0x5294, LSL #32
    MOVK  X25, #0x9fd4, LSL #48
    MOVZ  X26, #0xa5ac, LSL #0
    MOVK  X26, #0xb8b1, LSL #16
    MOVK  X26, #0x2be2, LSL #32
    MOVK  X26, #0xb1ba, LSL #48
    MOVZ  X27, #0x2b04, LSL #0
    MOVK  X27, #0xdc00, LSL #16
    MOVK  X27, #0xf868, LSL #32
    MOVK  X27, #0x966c, LSL #48
    MOVZ  X28, #0x3f17, LSL #0
    MOVK  X28, #0x29d6, LSL #16
    MOVK  X28, #0x62e1, LSL #32
    MOVK  X28, #0x282c, LSL #48
    MOVZ  X29, #0x9434, LSL #0
    MOVK  X29, #0x79b2, LSL #16
    MOVK  X29, #0xe034, LSL #32
    MOVK  X29, #0xf0b9, LSL #48
    MOVZ  X8, #0x45cd, LSL #0
    MOVK  X8, #0x2e64, LSL #16
    MOVK  X8, #0x1093, LSL #32
    MOVK  X8, #0xc491, LSL #48
    MSR  FPCR, X8
    MRS  X11, FPCR
    MOVZ  X28, #0x60ff, LSL #0
    MOVK  X28, #0xffff, LSL #16
    MOVK  X28, #0xffff, LSL #32
    MOVK  X28, #0xffff, LSL #48
    AND  X11, X11, X28
    MOVZ  X28, #0x0, LSL #0
    ORR  X11, X11, X28
    MSR  FPCR, X11
    ISB  SY
    MOVZ  X8, #0x70f, LSL #0
    MOVK  X8, #0xa208, LSL #16
    MOVK  X8, #0x5e0b, LSL #32
    MOVK  X8, #0x4b38, LSL #48
    MSR  FPSR, X8
    MRS  X5, FPSR
    MOVZ  X17, #0xff60, LSL #0
    MOVK  X17, #0x7ff, LSL #16
    MOVK  X17, #0xffff, LSL #32
    MOVK  X17, #0xffff, LSL #48
    AND  X5, X5, X17
    MOVZ  X17, #0x0, LSL #0
    ORR  X5, X5, X17
    MSR  FPSR, X5
    ISB  SY
    SUBS  W27, W11, W6, SXTX #2
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
    FMOV  V0.D[1], X28
    FMOV  D1, X25
    FMOV  V1.D[1], X6
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X29
    FMOV  V3.D[1], X10
    FMOV  D4, X2
    FMOV  V4.D[1], X29
    FMOV  D5, X25
    FMOV  V5.D[1], X2
    FMOV  D6, X25
    FMOV  V6.D[1], X25
    FMOV  D7, X12
    FMOV  V7.D[1], X8
    FMOV  D8, X11
    FMOV  V8.D[1], X9
    FMOV  D9, X28
    FMOV  V9.D[1], X14
    FMOV  D10, X12
    FMOV  V10.D[1], X8
    FMOV  D11, X24
    FMOV  V11.D[1], X23
    FMOV  D12, X9
    FMOV  V12.D[1], X25
    FMOV  D13, X15
    FMOV  V13.D[1], X12
    FMOV  D14, X10
    FMOV  V14.D[1], X10
    FMOV  D15, X24
    FMOV  V15.D[1], X17
    FMOV  D16, X4
    FMOV  V16.D[1], X17
    FMOV  D17, X29
    FMOV  V17.D[1], X12
    FMOV  D18, X24
    FMOV  V18.D[1], X9
    FMOV  D19, X13
    FMOV  V19.D[1], X5
    FMOV  D20, X23
    FMOV  V20.D[1], X24
    FMOV  D21, X6
    FMOV  V21.D[1], X24
    FMOV  D22, X29
    FMOV  V22.D[1], X14
    FMOV  D23, X11
    FMOV  V23.D[1], X15
    FMOV  D24, X25
    FMOV  V24.D[1], X2
    FMOV  D25, X24
    FMOV  V25.D[1], X9
    FMOV  D26, X9
    FMOV  V26.D[1], X14
    FMOV  D27, X9
    FMOV  V27.D[1], X7
    FMOV  D28, X23
    FMOV  V28.D[1], X16
    FMOV  D29, X24
    FMOV  V29.D[1], X15
    FMOV  D30, X4
    FMOV  V30.D[1], X4
    FMOV  D31, X27
    FMOV  V31.D[1], X26
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X14, #0x40, LSL #0
    MOVZ  X11, #0x0, LSL #0
    ADD  X8, X30, X11
    ST1 { V27.4S }, [X8], X23
    LD1 { V16.4S }, [X8], X23
    ADD  X8, X8, X14, ASR #0
    ST1 { V26.16B }, [X8], X23
    LD1 { V15.16B }, [X8], X23
    ADD  X8, X8, X14, LSR #0
    ST1 { V28.2D }, [X8], X23
    LD1 { V23.2D }, [X8], X23
    ADD  X8, X8, X14, LSR #0
    ST1 { V23.4S }, [X8], X23
    LD1 { V22.4S }, [X8], X23
    ADD  X8, X8, X14
    ST1 { V22.8H }, [X8], X23
    LD1 { V2.8H }, [X8], X23
    ADD  X8, X8, X14
    ST1 { V7.2S }, [X8], X23
    LD1 { V31.2S }, [X8], X23
    ADD  X8, X8, X14
    ST1 { V15.1D }, [X8], X23
    LD1 { V0.1D }, [X8], X23
    ADD  X8, X8, X14
    ST1 { V23.2S }, [X8], X23
    LD1 { V12.2S }, [X8], X23
    ADD  X8, X8, X14, ASR #0
    ST1 { V2.4H }, [X8], X23
    LD1 { V21.4H }, [X8], X23
    ADD  X8, X8, X14, LSR #0
    ST1 { V12.8B }, [X8], X23
    LD1 { V22.8B }, [X8], X23
    ADD  X8, X8, X14
    MOV  X7, X8
    ST1 { V11.16B, V12.16B, V13.16B }, [X7], #48
    MOV  X7, X8
    LD1 { V25.4S, V26.4S, V27.4S }, [X7], #48
    ADD  X8, X8, X14, ASR #0
    MOV  X7, X8
    ST1 { V28.16B, V29.16B, V30.16B }, [X7], #48
    MOV  X7, X8
    LD1 { V14.16B, V15.16B, V16.16B }, [X7], #48
    ADD  X8, X8, X14, LSR #0
    MOV  X7, X8
    ST1 { V14.2D, V15.2D, V16.2D }, [X7], #48
    MOV  X7, X8
    LD1 { V12.2D, V13.2D, V14.2D }, [X7], #48
    ADD  X8, X8, X14, ASR #0
    MOV  X7, X8
    ST1 { V22.4S, V23.4S, V24.4S }, [X7], #48
    MOV  X7, X8
    LD1 { V22.4S, V23.4S, V24.4S }, [X7], #48
    ADD  X8, X8, X14, ASR #0
    MOV  X7, X8
    ST1 { V30.8H, V31.8H, V0.8H }, [X7], #48
    MOV  X7, X8
    LD1 { V29.8H, V30.8H, V31.8H }, [X7], #48
    ADD  X8, X8, X14, LSR #0
    MOV  X7, X8
    ST1 { V1.4H, V2.4H, V3.4H }, [X7], #24
    MOV  X7, X8
    LD1 { V5.4H, V6.4H, V7.4H }, [X7], #24
    ADD  X8, X8, X14
    MOV  X7, X8
    ST1 { V29.1D, V30.1D, V31.1D }, [X7], #24
    MOV  X7, X8
    LD1 { V1.1D, V2.1D, V3.1D }, [X7], #24
    ADD  X8, X8, X14
    MOV  X7, X8
    ST1 { V14.2S, V15.2S, V16.2S }, [X7], #24
    MOV  X7, X8
    LD1 { V25.2S, V26.2S, V27.2S }, [X7], #24
    ADD  X8, X8, X14, ASR #0
    MOV  X7, X8
    ST1 { V18.4H, V19.4H, V20.4H }, [X7], #24
    MOV  X7, X8
    LD1 { V9.4H, V10.4H, V11.4H }, [X7], #24
    ADD  X8, X8, X14, ASR #0
    MOV  X7, X8
    ST1 { V14.8B, V15.8B, V16.8B }, [X7], #24
    MOV  X7, X8
    LD1 { V12.8B, V13.8B, V14.8B }, [X7], #24
    ADD  X8, X8, X14, ASR #0
    ST1 { V30.4S, V31.4S, V0.4S }, [X8], X23
    LD1 { V6.8H, V7.8H, V8.8H }, [X8], X23
    ADD  X8, X8, X14, LSR #0
    ST1 { V24.16B, V25.16B, V26.16B }, [X8], X23
    LD1 { V22.16B, V23.16B, V24.16B }, [X8], X23
    ADD  X8, X8, X14
    ST1 { V11.2D, V12.2D, V13.2D }, [X8], X23
    LD1 { V20.2D, V21.2D, V22.2D }, [X8], X23
    ADD  X8, X8, X14, LSR #0
    ST1 { V29.4S, V30.4S, V31.4S }, [X8], X23
    LD1 { V13.4S, V14.4S, V15.4S }, [X8], X23
    ADD  X8, X8, X14
    ST1 { V29.8H, V30.8H, V31.8H }, [X8], X23
    LD1 { V26.8H, V27.8H, V28.8H }, [X8], X23
    ADD  X8, X8, X14, ASR #0
    ST1 { V20.2S, V21.2S, V22.2S }, [X8], X23
    LD1 { V26.8B, V27.8B, V28.8B }, [X8], X23
    ADD  X8, X8, X14, ASR #0
    ST1 { V17.1D, V18.1D, V19.1D }, [X8], X23
    LD1 { V26.1D, V27.1D, V28.1D }, [X8], X23
    ADD  X8, X8, X14, LSR #0
    ST1 { V14.2S, V15.2S, V16.2S }, [X8], X23
    LD1 { V19.2S, V20.2S, V21.2S }, [X8], X23
    ADD  X8, X8, X14
    ST1 { V26.4H, V27.4H, V28.4H }, [X8], X23
    LD1 { V16.4H, V17.4H, V18.4H }, [X8], X23
    ADD  X8, X8, X14
    ST1 { V6.8B, V7.8B, V8.8B }, [X8], X23
    LD1 { V21.8B, V22.8B, V23.8B }, [X8], X23
    ADD  X8, X8, X14, ASR #0
    MOV  X7, X8
    ST1 { V8.4S, V9.4S }, [X7], #32
    MOV  X7, X8
    LD1 { V14.8H, V15.8H }, [X7], #32
    ADD  X8, X8, X14
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X2
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X3
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X4
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X5
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X6
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X9
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X10
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X13
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X15
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X16
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X17
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X25
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X28
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X12, X27, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    MRS  X27, FPSR
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V0.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D0
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V1.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D1
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V2.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D2
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V3.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D3
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V4.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D4
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V5.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D5
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V6.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D6
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V7.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D7
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V8.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D8
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V9.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D9
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V10.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D10
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V11.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D11
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V12.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D12
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V13.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D13
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V14.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D14
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V15.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D15
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V16.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D16
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V17.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D17
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V18.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D18
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V19.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D19
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V20.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D20
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V21.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D21
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V22.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D22
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V23.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D23
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V24.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D24
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V25.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D25
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V26.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D26
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V27.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D27
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V28.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D28
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V29.D[1]
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D29
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V30.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D30
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, V31.D[1]
    MOVZ  X12, #0x0, LSL #0
    SUB  X26, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    FMOV  X27, D31
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X26, X12, X27
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
    FMOV  V0.D[1], X6
    FMOV  D1, X29
    FMOV  V1.D[1], X25
    FMOV  D2, X27
    FMOV  V2.D[1], X6
    FMOV  D3, X29
    FMOV  V3.D[1], X28
    FMOV  D4, X8
    FMOV  V4.D[1], X7
    FMOV  D5, X13
    FMOV  V5.D[1], X2
    FMOV  D6, X6
    FMOV  V6.D[1], X17
    FMOV  D7, X6
    FMOV  V7.D[1], X3
    FMOV  D8, X5
    FMOV  V8.D[1], X8
    FMOV  D9, X9
    FMOV  V9.D[1], X24
    FMOV  D10, X14
    FMOV  V10.D[1], X7
    FMOV  D11, X26
    FMOV  V11.D[1], X9
    FMOV  D12, X5
    FMOV  V12.D[1], X25
    FMOV  D13, X24
    FMOV  V13.D[1], X8
    FMOV  D14, X27
    FMOV  V14.D[1], X28
    FMOV  D15, X4
    FMOV  V15.D[1], X6
    FMOV  D16, X23
    FMOV  V16.D[1], X29
    FMOV  D17, X29
    FMOV  V17.D[1], X14
    FMOV  D18, X3
    FMOV  V18.D[1], X6
    FMOV  D19, X17
    FMOV  V19.D[1], X6
    FMOV  D20, X17
    FMOV  V20.D[1], X23
    FMOV  D21, X27
    FMOV  V21.D[1], X28
    FMOV  D22, X6
    FMOV  V22.D[1], X11
    FMOV  D23, X28
    FMOV  V23.D[1], X13
    FMOV  D24, X14
    FMOV  V24.D[1], X14
    FMOV  D25, X25
    FMOV  V25.D[1], X6
    FMOV  D26, X28
    FMOV  V26.D[1], X7
    FMOV  D27, X6
    FMOV  V27.D[1], X2
    FMOV  D28, X4
    FMOV  V28.D[1], X25
    FMOV  D29, X27
    FMOV  V29.D[1], X10
    FMOV  D30, X26
    FMOV  V30.D[1], X3
    FMOV  D31, X14
    FMOV  V31.D[1], X23
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X2, #0x500, LSL #0
    ADD  X7, X30, X2
    ST1 { V25.4S }, [X7], X13
    LD1 { V22.4S }, [X7], X13
    ADD  X7, X7, X6, ASR #0
    ST1 { V27.16B }, [X7], X13
    LD1 { V21.16B }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    ST1 { V22.2D }, [X7], X13
    LD1 { V29.2D }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    ST1 { V30.4S }, [X7], X13
    LD1 { V2.4S }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    ST1 { V31.8H }, [X7], X13
    LD1 { V16.8H }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    ST1 { V16.1D }, [X7], X13
    LD1 { V26.8B }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    ST1 { V2.1D }, [X7], X13
    LD1 { V29.1D }, [X7], X13
    ADD  X7, X7, X6
    ST1 { V21.2S }, [X7], X13
    LD1 { V15.2S }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    ST1 { V7.4H }, [X7], X13
    LD1 { V12.4H }, [X7], X13
    ADD  X7, X7, X6, ASR #0
    ST1 { V26.8B }, [X7], X13
    LD1 { V29.8B }, [X7], X13
    ADD  X7, X7, X6
    MOV  X15, X7
    ST1 { V1.2D, V2.2D, V3.2D }, [X15], #48
    MOV  X15, X7
    LD1 { V27.4S, V28.4S, V29.4S }, [X15], #48
    ADD  X7, X7, X6, LSR #0
    MOV  X15, X7
    ST1 { V19.16B, V20.16B, V21.16B }, [X15], #48
    MOV  X15, X7
    LD1 { V5.16B, V6.16B, V7.16B }, [X15], #48
    ADD  X7, X7, X6, ASR #0
    MOV  X15, X7
    ST1 { V27.2D, V28.2D, V29.2D }, [X15], #48
    MOV  X15, X7
    LD1 { V5.2D, V6.2D, V7.2D }, [X15], #48
    ADD  X7, X7, X6, ASR #0
    MOV  X15, X7
    ST1 { V12.4S, V13.4S, V14.4S }, [X15], #48
    MOV  X15, X7
    LD1 { V13.4S, V14.4S, V15.4S }, [X15], #48
    ADD  X7, X7, X6, LSR #0
    MOV  X15, X7
    ST1 { V13.8H, V14.8H, V15.8H }, [X15], #48
    MOV  X15, X7
    LD1 { V25.8H, V26.8H, V27.8H }, [X15], #48
    ADD  X7, X7, X6
    MOV  X15, X7
    ST1 { V5.1D, V6.1D, V7.1D }, [X15], #24
    MOV  X15, X7
    LD1 { V5.4H, V6.4H, V7.4H }, [X15], #24
    ADD  X7, X7, X6, ASR #0
    MOV  X15, X7
    ST1 { V2.1D, V3.1D, V4.1D }, [X15], #24
    MOV  X15, X7
    LD1 { V4.1D, V5.1D, V6.1D }, [X15], #24
    ADD  X7, X7, X6, LSR #0
    MOV  X15, X7
    ST1 { V31.2S, V0.2S, V1.2S }, [X15], #24
    MOV  X15, X7
    LD1 { V15.2S, V16.2S, V17.2S }, [X15], #24
    ADD  X7, X7, X6
    MOV  X15, X7
    ST1 { V25.4H, V26.4H, V27.4H }, [X15], #24
    MOV  X15, X7
    LD1 { V31.4H, V0.4H, V1.4H }, [X15], #24
    ADD  X7, X7, X6
    MOV  X15, X7
    ST1 { V15.8B, V16.8B, V17.8B }, [X15], #24
    MOV  X15, X7
    LD1 { V9.8B, V10.8B, V11.8B }, [X15], #24
    ADD  X7, X7, X6, LSR #0
    ST1 { V9.2D, V10.2D, V11.2D }, [X7], X13
    LD1 { V15.8H, V16.8H, V17.8H }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    ST1 { V27.16B, V28.16B, V29.16B }, [X7], X13
    LD1 { V26.16B, V27.16B, V28.16B }, [X7], X13
    ADD  X7, X7, X6
    ST1 { V26.2D, V27.2D, V28.2D }, [X7], X13
    LD1 { V26.2D, V27.2D, V28.2D }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    ST1 { V4.4S, V5.4S, V6.4S }, [X7], X13
    LD1 { V4.4S, V5.4S, V6.4S }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    ST1 { V6.8H, V7.8H, V8.8H }, [X7], X13
    LD1 { V12.8H, V13.8H, V14.8H }, [X7], X13
    ADD  X7, X7, X6, ASR #0
    ST1 { V24.4H, V25.4H, V26.4H }, [X7], X13
    LD1 { V7.1D, V8.1D, V9.1D }, [X7], X13
    ADD  X7, X7, X6
    ST1 { V22.1D, V23.1D, V24.1D }, [X7], X13
    LD1 { V24.1D, V25.1D, V26.1D }, [X7], X13
    ADD  X7, X7, X6
    ST1 { V12.2S, V13.2S, V14.2S }, [X7], X13
    LD1 { V12.2S, V13.2S, V14.2S }, [X7], X13
    ADD  X7, X7, X6
    ST1 { V12.4H, V13.4H, V14.4H }, [X7], X13
    LD1 { V12.4H, V13.4H, V14.4H }, [X7], X13
    ADD  X7, X7, X6, ASR #0
    ST1 { V7.8B, V8.8B, V9.8B }, [X7], X13
    LD1 { V6.8B, V7.8B, V8.8B }, [X7], X13
    ADD  X7, X7, X6, LSR #0
    MOV  X15, X7
    ST1 { V13.4S, V14.4S }, [X15], #32
    MOV  X15, X7
    LD1 { V22.2D, V23.2D }, [X15], #32
    ADD  X7, X7, X6, ASR #0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X23
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X25, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MRS  X8, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D1
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D2
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D3
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D4
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D5
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D6
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D7
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D8
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D9
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D10
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D11
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D12
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D13
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D14
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D15
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D17
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D18
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D19
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D20
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D21
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D22
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D23
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D24
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D25
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D26
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D27
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D28
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D29
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D30
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D31
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X6
    FMOV  V0.D[1], X29
    FMOV  D1, X29
    FMOV  V1.D[1], X28
    FMOV  D2, X25
    FMOV  V2.D[1], X16
    FMOV  D3, X27
    FMOV  V3.D[1], X6
    FMOV  D4, X24
    FMOV  V4.D[1], X8
    FMOV  D5, X15
    FMOV  V5.D[1], X8
    FMOV  D6, X16
    FMOV  V6.D[1], X23
    FMOV  D7, X13
    FMOV  V7.D[1], X15
    FMOV  D8, X17
    FMOV  V8.D[1], X9
    FMOV  D9, X13
    FMOV  V9.D[1], X6
    FMOV  D10, X8
    FMOV  V10.D[1], X6
    FMOV  D11, X26
    FMOV  V11.D[1], X4
    FMOV  D12, X7
    FMOV  V12.D[1], X7
    FMOV  D13, X24
    FMOV  V13.D[1], X15
    FMOV  D14, X11
    FMOV  V14.D[1], X24
    FMOV  D15, X10
    FMOV  V15.D[1], X11
    FMOV  D16, X12
    FMOV  V16.D[1], X9
    FMOV  D17, X26
    FMOV  V17.D[1], X25
    FMOV  D18, X5
    FMOV  V18.D[1], X10
    FMOV  D19, X7
    FMOV  V19.D[1], X6
    FMOV  D20, X29
    FMOV  V20.D[1], X15
    FMOV  D21, X26
    FMOV  V21.D[1], X27
    FMOV  D22, X25
    FMOV  V22.D[1], X10
    FMOV  D23, X25
    FMOV  V23.D[1], X9
    FMOV  D24, X6
    FMOV  V24.D[1], X13
    FMOV  D25, X17
    FMOV  V25.D[1], X14
    FMOV  D26, X5
    FMOV  V26.D[1], X2
    FMOV  D27, X11
    FMOV  V27.D[1], X26
    FMOV  D28, X27
    FMOV  V28.D[1], X17
    FMOV  D29, X6
    FMOV  V29.D[1], X27
    FMOV  D30, X12
    FMOV  V30.D[1], X24
    FMOV  D31, X24
    FMOV  V31.D[1], X6
    MOVZ  X10, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X27, #0xa00, LSL #0
    ADD  X16, X30, X27, LSR #0
    ST1 { V24.8H }, [X16], X10
    LD1 { V11.2D }, [X16], X10
    ADD  X16, X16, X6, ASR #0
    ST1 { V29.16B }, [X16], X10
    LD1 { V25.16B }, [X16], X10
    ADD  X16, X16, X6, LSR #0
    ST1 { V26.2D }, [X16], X10
    LD1 { V31.2D }, [X16], X10
    ADD  X16, X16, X6, LSR #0
    ST1 { V28.4S }, [X16], X10
    LD1 { V12.4S }, [X16], X10
    ADD  X16, X16, X6, ASR #0
    ST1 { V12.8H }, [X16], X10
    LD1 { V1.8H }, [X16], X10
    ADD  X16, X16, X6, ASR #0
    ST1 { V5.8B }, [X16], X10
    LD1 { V28.8B }, [X16], X10
    ADD  X16, X16, X6, ASR #0
    ST1 { V29.1D }, [X16], X10
    LD1 { V16.1D }, [X16], X10
    ADD  X16, X16, X6, ASR #0
    ST1 { V20.2S }, [X16], X10
    LD1 { V2.2S }, [X16], X10
    ADD  X16, X16, X6, LSR #0
    ST1 { V16.4H }, [X16], X10
    LD1 { V0.4H }, [X16], X10
    ADD  X16, X16, X6, LSR #0
    ST1 { V1.8B }, [X16], X10
    LD1 { V18.8B }, [X16], X10
    ADD  X16, X16, X6, LSR #0
    MOV  X23, X16
    ST1 { V25.16B, V26.16B, V27.16B }, [X23], #48
    MOV  X23, X16
    LD1 { V9.4S, V10.4S, V11.4S }, [X23], #48
    ADD  X16, X16, X6
    MOV  X23, X16
    ST1 { V27.16B, V28.16B, V29.16B }, [X23], #48
    MOV  X23, X16
    LD1 { V31.16B, V0.16B, V1.16B }, [X23], #48
    ADD  X16, X16, X6, LSR #0
    MOV  X23, X16
    ST1 { V31.2D, V0.2D, V1.2D }, [X23], #48
    MOV  X23, X16
    LD1 { V19.2D, V20.2D, V21.2D }, [X23], #48
    ADD  X16, X16, X6
    MOV  X23, X16
    ST1 { V10.4S, V11.4S, V12.4S }, [X23], #48
    MOV  X23, X16
    LD1 { V14.4S, V15.4S, V16.4S }, [X23], #48
    ADD  X16, X16, X6, LSR #0
    MOV  X23, X16
    ST1 { V19.8H, V20.8H, V21.8H }, [X23], #48
    MOV  X23, X16
    LD1 { V1.8H, V2.8H, V3.8H }, [X23], #48
    ADD  X16, X16, X6
    MOV  X23, X16
    ST1 { V10.8B, V11.8B, V12.8B }, [X23], #24
    MOV  X23, X16
    LD1 { V13.4H, V14.4H, V15.4H }, [X23], #24
    ADD  X16, X16, X6
    MOV  X23, X16
    ST1 { V14.1D, V15.1D, V16.1D }, [X23], #24
    MOV  X23, X16
    LD1 { V22.1D, V23.1D, V24.1D }, [X23], #24
    ADD  X16, X16, X6, ASR #0
    MOV  X23, X16
    ST1 { V15.2S, V16.2S, V17.2S }, [X23], #24
    MOV  X23, X16
    LD1 { V10.2S, V11.2S, V12.2S }, [X23], #24
    ADD  X16, X16, X6
    MOV  X23, X16
    ST1 { V9.4H, V10.4H, V11.4H }, [X23], #24
    MOV  X23, X16
    LD1 { V14.4H, V15.4H, V16.4H }, [X23], #24
    ADD  X16, X16, X6, LSR #0
    MOV  X23, X16
    ST1 { V30.8B, V31.8B, V0.8B }, [X23], #24
    MOV  X23, X16
    LD1 { V30.8B, V31.8B, V0.8B }, [X23], #24
    ADD  X16, X16, X6
    ST1 { V22.16B, V23.16B, V24.16B }, [X16], X10
    LD1 { V22.8H, V23.8H, V24.8H }, [X16], X10
    ADD  X16, X16, X6
    ST1 { V14.16B, V15.16B, V16.16B }, [X16], X10
    LD1 { V9.16B, V10.16B, V11.16B }, [X16], X10
    ADD  X16, X16, X6, LSR #0
    ST1 { V8.2D, V9.2D, V10.2D }, [X16], X10
    LD1 { V8.2D, V9.2D, V10.2D }, [X16], X10
    ADD  X16, X16, X6, ASR #0
    ST1 { V22.4S, V23.4S, V24.4S }, [X16], X10
    LD1 { V6.4S, V7.4S, V8.4S }, [X16], X10
    ADD  X16, X16, X6
    ST1 { V8.8H, V9.8H, V10.8H }, [X16], X10
    LD1 { V22.8H, V23.8H, V24.8H }, [X16], X10
    ADD  X16, X16, X6, LSR #0
    ST1 { V31.8B, V0.8B, V1.8B }, [X16], X10
    LD1 { V8.8B, V9.8B, V10.8B }, [X16], X10
    ADD  X16, X16, X6, ASR #0
    ST1 { V10.1D, V11.1D, V12.1D }, [X16], X10
    LD1 { V31.1D, V0.1D, V1.1D }, [X16], X10
    ADD  X16, X16, X6
    ST1 { V31.2S, V0.2S, V1.2S }, [X16], X10
    LD1 { V31.2S, V0.2S, V1.2S }, [X16], X10
    ADD  X16, X16, X6
    ST1 { V6.4H, V7.4H, V8.4H }, [X16], X10
    LD1 { V10.4H, V11.4H, V12.4H }, [X16], X10
    ADD  X16, X16, X6
    ST1 { V9.8B, V10.8B, V11.8B }, [X16], X10
    LD1 { V29.8B, V30.8B, V31.8B }, [X16], X10
    ADD  X16, X16, X6
    MOV  X23, X16
    ST1 { V10.4S, V11.4S }, [X23], #32
    MOV  X23, X16
    LD1 { V16.2D, V17.2D }, [X23], #32
    ADD  X16, X16, X6, ASR #0
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X7
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X8
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X12
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X17
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X15, #0x5a5a, LSL #0
    MOVK  X15, #0x5a5a, LSL #16
    MOVK  X15, #0x5a5a, LSL #32
    MOVK  X15, #0x5a5a, LSL #48
    SUB  X28, X15, X29
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MRS  X15, FPSR
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D1
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D2
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V3.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D3
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V4.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D4
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V5.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D5
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D6
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D7
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D8
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D9
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V10.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D10
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V11.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D11
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V12.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D12
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D13
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D14
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D15
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D16
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D17
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D18
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V19.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D19
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V20.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D20
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V21.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D21
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D22
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V23.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D23
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V24.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D24
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V25.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D25
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V26.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D26
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V27.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D27
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V28.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D28
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V29.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D29
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V30.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D30
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X15, D31
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D1, X27
    FMOV  V1.D[1], X17
    FMOV  D2, X26
    FMOV  V2.D[1], X7
    FMOV  D3, X12
    FMOV  V3.D[1], X29
    FMOV  D4, X13
    FMOV  V4.D[1], X16
    FMOV  D5, X17
    FMOV  V5.D[1], X28
    FMOV  D6, X28
    FMOV  V6.D[1], X13
    FMOV  D7, X15
    FMOV  V7.D[1], X27
    FMOV  D8, X27
    FMOV  V8.D[1], X28
    FMOV  D9, X15
    FMOV  V9.D[1], X28
    FMOV  D10, X5
    FMOV  V10.D[1], X14
    FMOV  D11, X3
    FMOV  V11.D[1], X24
    FMOV  D12, X23
    FMOV  V12.D[1], X2
    FMOV  D13, X5
    FMOV  V13.D[1], X4
    FMOV  D14, X25
    FMOV  V14.D[1], X4
    FMOV  D15, X17
    FMOV  V15.D[1], X10
    FMOV  D16, X5
    FMOV  V16.D[1], X27
    FMOV  D17, X4
    FMOV  V17.D[1], X2
    FMOV  D18, X8
    FMOV  V18.D[1], X13
    FMOV  D19, X16
    FMOV  V19.D[1], X15
    FMOV  D20, X9
    FMOV  V20.D[1], X23
    FMOV  D21, X3
    FMOV  V21.D[1], X13
    FMOV  D22, X23
    FMOV  V22.D[1], X24
    FMOV  D23, X25
    FMOV  V23.D[1], X8
    FMOV  D24, X29
    FMOV  V24.D[1], X26
    FMOV  D25, X4
    FMOV  V25.D[1], X6
    FMOV  D26, X7
    FMOV  V26.D[1], X25
    FMOV  D27, X26
    FMOV  V27.D[1], X12
    FMOV  D28, X23
    FMOV  V28.D[1], X7
    FMOV  D29, X13
    FMOV  V29.D[1], X28
    FMOV  D30, X27
    FMOV  V30.D[1], X13
    FMOV  D31, X7
    FMOV  V31.D[1], X15
    MOVZ  X17, #0x0, LSL #0
    MOVZ  X23, #0x40, LSL #0
    MOVZ  X5, #0xf00, LSL #0
    ADD  X27, X30, X5, LSR #0
    ST1 { V28.4S }, [X27], X17
    LD1 { V22.2D }, [X27], X17
    ADD  X27, X27, X23
    ST1 { V27.16B }, [X27], X17
    LD1 { V15.16B }, [X27], X17
    ADD  X27, X27, X23
    ST1 { V1.2D }, [X27], X17
    LD1 { V22.2D }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    ST1 { V16.4S }, [X27], X17
    LD1 { V9.4S }, [X27], X17
    ADD  X27, X27, X23, ASR #0
    ST1 { V9.8H }, [X27], X17
    LD1 { V6.8H }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    ST1 { V15.1D }, [X27], X17
    LD1 { V5.2S }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    ST1 { V5.1D }, [X27], X17
    LD1 { V15.1D }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    ST1 { V5.2S }, [X27], X17
    LD1 { V20.2S }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    ST1 { V15.4H }, [X27], X17
    LD1 { V20.4H }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    ST1 { V22.8B }, [X27], X17
    LD1 { V16.8B }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    MOV  X6, X27
    ST1 { V15.4S, V16.4S, V17.4S }, [X6], #48
    MOV  X6, X27
    LD1 { V22.2D, V23.2D, V24.2D }, [X6], #48
    ADD  X27, X27, X23, ASR #0
    MOV  X6, X27
    ST1 { V22.16B, V23.16B, V24.16B }, [X6], #48
    MOV  X6, X27
    LD1 { V20.16B, V21.16B, V22.16B }, [X6], #48
    ADD  X27, X27, X23, LSR #0
    MOV  X6, X27
    ST1 { V20.2D, V21.2D, V22.2D }, [X6], #48
    MOV  X6, X27
    LD1 { V31.2D, V0.2D, V1.2D }, [X6], #48
    ADD  X27, X27, X23
    MOV  X6, X27
    ST1 { V18.4S, V19.4S, V20.4S }, [X6], #48
    MOV  X6, X27
    LD1 { V29.4S, V30.4S, V31.4S }, [X6], #48
    ADD  X27, X27, X23
    MOV  X6, X27
    ST1 { V18.8H, V19.8H, V20.8H }, [X6], #48
    MOV  X6, X27
    LD1 { V21.8H, V22.8H, V23.8H }, [X6], #48
    ADD  X27, X27, X23, LSR #0
    MOV  X6, X27
    ST1 { V21.4H, V22.4H, V23.4H }, [X6], #24
    MOV  X6, X27
    LD1 { V27.4H, V28.4H, V29.4H }, [X6], #24
    ADD  X27, X27, X23, ASR #0
    MOV  X6, X27
    ST1 { V28.1D, V29.1D, V30.1D }, [X6], #24
    MOV  X6, X27
    LD1 { V13.1D, V14.1D, V15.1D }, [X6], #24
    ADD  X27, X27, X23, LSR #0
    MOV  X6, X27
    ST1 { V21.2S, V22.2S, V23.2S }, [X6], #24
    MOV  X6, X27
    LD1 { V24.2S, V25.2S, V26.2S }, [X6], #24
    ADD  X27, X27, X23
    MOV  X6, X27
    ST1 { V30.4H, V31.4H, V0.4H }, [X6], #24
    MOV  X6, X27
    LD1 { V30.4H, V31.4H, V0.4H }, [X6], #24
    ADD  X27, X27, X23, ASR #0
    MOV  X6, X27
    ST1 { V15.8B, V16.8B, V17.8B }, [X6], #24
    MOV  X6, X27
    LD1 { V16.8B, V17.8B, V18.8B }, [X6], #24
    ADD  X27, X27, X23, ASR #0
    ST1 { V30.16B, V31.16B, V0.16B }, [X27], X17
    LD1 { V25.2D, V26.2D, V27.2D }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    ST1 { V24.16B, V25.16B, V26.16B }, [X27], X17
    LD1 { V20.16B, V21.16B, V22.16B }, [X27], X17
    ADD  X27, X27, X23
    ST1 { V20.2D, V21.2D, V22.2D }, [X27], X17
    LD1 { V15.2D, V16.2D, V17.2D }, [X27], X17
    ADD  X27, X27, X23
    ST1 { V15.4S, V16.4S, V17.4S }, [X27], X17
    LD1 { V20.4S, V21.4S, V22.4S }, [X27], X17
    ADD  X27, X27, X23
    ST1 { V0.8H, V1.8H, V2.8H }, [X27], X17
    LD1 { V0.8H, V1.8H, V2.8H }, [X27], X17
    ADD  X27, X27, X23
    ST1 { V20.4H, V21.4H, V22.4H }, [X27], X17
    LD1 { V20.4H, V21.4H, V22.4H }, [X27], X17
    ADD  X27, X27, X23
    ST1 { V0.1D, V1.1D, V2.1D }, [X27], X17
    LD1 { V24.1D, V25.1D, V26.1D }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    ST1 { V20.2S, V21.2S, V22.2S }, [X27], X17
    LD1 { V20.2S, V21.2S, V22.2S }, [X27], X17
    ADD  X27, X27, X23, LSR #0
    ST1 { V24.4H, V25.4H, V26.4H }, [X27], X17
    LD1 { V3.4H, V4.4H, V5.4H }, [X27], X17
    ADD  X27, X27, X23, ASR #0
    ST1 { V20.8B, V21.8B, V22.8B }, [X27], X17
    LD1 { V24.8B, V25.8B, V26.8B }, [X27], X17
    ADD  X27, X27, X23, ASR #0
    MOV  X6, X27
    ST1 { V11.2D, V12.2D }, [X6], #32
    MOV  X6, X27
    LD1 { V30.16B, V31.16B }, [X6], #32
    ADD  X27, X27, X23, LSR #0
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0xa5a5, LSL #0
    MOVK  X7, #0xa5a5, LSL #16
    MOVK  X7, #0xa5a5, LSL #32
    MOVK  X7, #0xa5a5, LSL #48
    SUB  X25, X7, X28
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    MRS  X7, FPSR
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D0
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D1
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D2
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D3
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D4
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D5
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D6
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D7
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D8
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D9
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D10
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D11
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D12
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D13
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D14
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D15
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D16
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D17
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D18
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D19
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D20
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D21
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D22
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D23
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D24
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D25
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D26
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D27
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D28
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X25, #0x0, LSL #0
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D29
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D30
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D31
    MOVZ  X25, #0xa5a5, LSL #0
    MOVK  X25, #0xa5a5, LSL #16
    MOVK  X25, #0xa5a5, LSL #32
    MOVK  X25, #0xa5a5, LSL #48
    SUB  X29, X25, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X29
    FMOV  V1.D[1], X4
    FMOV  D2, X12
    FMOV  V2.D[1], X27
    FMOV  D3, X3
    FMOV  V3.D[1], X15
    FMOV  D4, X28
    FMOV  V4.D[1], X29
    FMOV  D5, X12
    FMOV  V5.D[1], X6
    FMOV  D6, X10
    FMOV  V6.D[1], X9
    FMOV  D7, X16
    FMOV  V7.D[1], X3
    FMOV  D8, X11
    FMOV  V8.D[1], X6
    FMOV  D9, X15
    FMOV  V9.D[1], X23
    FMOV  D10, X24
    FMOV  V10.D[1], X16
    FMOV  D11, X24
    FMOV  V11.D[1], X17
    FMOV  D12, X2
    FMOV  V12.D[1], X4
    FMOV  D13, X17
    FMOV  V13.D[1], X17
    FMOV  D14, X4
    FMOV  V14.D[1], X13
    FMOV  D15, X4
    FMOV  V15.D[1], X24
    FMOV  D16, X11
    FMOV  V16.D[1], X10
    FMOV  D17, X23
    FMOV  V17.D[1], X2
    FMOV  D18, X13
    FMOV  V18.D[1], X17
    FMOV  D19, X29
    FMOV  V19.D[1], X15
    FMOV  D20, X15
    FMOV  V20.D[1], X17
    FMOV  D21, X8
    FMOV  V21.D[1], X13
    FMOV  D22, X17
    FMOV  V22.D[1], X11
    FMOV  D23, X13
    FMOV  V23.D[1], X4
    FMOV  D24, X15
    FMOV  V24.D[1], X6
    FMOV  D25, X15
    FMOV  V25.D[1], X17
    FMOV  D26, X9
    FMOV  V26.D[1], X13
    FMOV  D27, X9
    FMOV  V27.D[1], X14
    FMOV  D28, X14
    FMOV  V28.D[1], X5
    FMOV  D29, X3
    FMOV  V29.D[1], X4
    FMOV  D30, X29
    FMOV  V30.D[1], X6
    FMOV  D31, X29
    FMOV  V31.D[1], X16
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X8, #0x1400, LSL #0
    ADD  X23, X30, X8, ASR #0
    ST1 { V30.4S }, [X23], X2
    LD1 { V19.2D }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    ST1 { V27.16B }, [X23], X2
    LD1 { V9.16B }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    ST1 { V17.2D }, [X23], X2
    LD1 { V29.2D }, [X23], X2
    ADD  X23, X23, X25, ASR #0
    ST1 { V9.4S }, [X23], X2
    LD1 { V12.4S }, [X23], X2
    ADD  X23, X23, X25, ASR #0
    ST1 { V1.8H }, [X23], X2
    LD1 { V24.8H }, [X23], X2
    ADD  X23, X23, X25, ASR #0
    ST1 { V0.4H }, [X23], X2
    LD1 { V16.8B }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    ST1 { V29.1D }, [X23], X2
    LD1 { V28.1D }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    ST1 { V16.2S }, [X23], X2
    LD1 { V31.2S }, [X23], X2
    ADD  X23, X23, X25, ASR #0
    ST1 { V12.4H }, [X23], X2
    LD1 { V21.4H }, [X23], X2
    ADD  X23, X23, X25
    ST1 { V21.8B }, [X23], X2
    LD1 { V15.8B }, [X23], X2
    ADD  X23, X23, X25, ASR #0
    MOV  X5, X23
    ST1 { V24.4S, V25.4S, V26.4S }, [X5], #48
    MOV  X5, X23
    LD1 { V6.16B, V7.16B, V8.16B }, [X5], #48
    ADD  X23, X23, X25
    MOV  X5, X23
    ST1 { V6.16B, V7.16B, V8.16B }, [X5], #48
    MOV  X5, X23
    LD1 { V20.16B, V21.16B, V22.16B }, [X5], #48
    ADD  X23, X23, X25, ASR #0
    MOV  X5, X23
    ST1 { V20.2D, V21.2D, V22.2D }, [X5], #48
    MOV  X5, X23
    LD1 { V5.2D, V6.2D, V7.2D }, [X5], #48
    ADD  X23, X23, X25
    MOV  X5, X23
    ST1 { V5.4S, V6.4S, V7.4S }, [X5], #48
    MOV  X5, X23
    LD1 { V9.4S, V10.4S, V11.4S }, [X5], #48
    ADD  X23, X23, X25
    MOV  X5, X23
    ST1 { V7.8H, V8.8H, V9.8H }, [X5], #48
    MOV  X5, X23
    LD1 { V27.8H, V28.8H, V29.8H }, [X5], #48
    ADD  X23, X23, X25
    MOV  X5, X23
    ST1 { V27.1D, V28.1D, V29.1D }, [X5], #24
    MOV  X5, X23
    LD1 { V0.4H, V1.4H, V2.4H }, [X5], #24
    ADD  X23, X23, X25
    MOV  X5, X23
    ST1 { V2.1D, V3.1D, V4.1D }, [X5], #24
    MOV  X5, X23
    LD1 { V22.1D, V23.1D, V24.1D }, [X5], #24
    ADD  X23, X23, X25
    MOV  X5, X23
    ST1 { V22.2S, V23.2S, V24.2S }, [X5], #24
    MOV  X5, X23
    LD1 { V7.2S, V8.2S, V9.2S }, [X5], #24
    ADD  X23, X23, X25, ASR #0
    MOV  X5, X23
    ST1 { V14.4H, V15.4H, V16.4H }, [X5], #24
    MOV  X5, X23
    LD1 { V22.4H, V23.4H, V24.4H }, [X5], #24
    ADD  X23, X23, X25
    MOV  X5, X23
    ST1 { V22.8B, V23.8B, V24.8B }, [X5], #24
    MOV  X5, X23
    LD1 { V0.8B, V1.8B, V2.8B }, [X5], #24
    ADD  X23, X23, X25
    ST1 { V0.2D, V1.2D, V2.2D }, [X23], X2
    LD1 { V5.2D, V6.2D, V7.2D }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    ST1 { V25.16B, V26.16B, V27.16B }, [X23], X2
    LD1 { V25.16B, V26.16B, V27.16B }, [X23], X2
    ADD  X23, X23, X25, ASR #0
    ST1 { V1.2D, V2.2D, V3.2D }, [X23], X2
    LD1 { V1.2D, V2.2D, V3.2D }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    ST1 { V7.4S, V8.4S, V9.4S }, [X23], X2
    LD1 { V7.4S, V8.4S, V9.4S }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    ST1 { V25.8H, V26.8H, V27.8H }, [X23], X2
    LD1 { V23.8H, V24.8H, V25.8H }, [X23], X2
    ADD  X23, X23, X25, ASR #0
    ST1 { V23.8B, V24.8B, V25.8B }, [X23], X2
    LD1 { V22.2S, V23.2S, V24.2S }, [X23], X2
    ADD  X23, X23, X25, ASR #0
    ST1 { V26.1D, V27.1D, V28.1D }, [X23], X2
    LD1 { V26.1D, V27.1D, V28.1D }, [X23], X2
    ADD  X23, X23, X25, ASR #0
    ST1 { V31.2S, V0.2S, V1.2S }, [X23], X2
    LD1 { V31.2S, V0.2S, V1.2S }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    ST1 { V19.4H, V20.4H, V21.4H }, [X23], X2
    LD1 { V26.4H, V27.4H, V28.4H }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    ST1 { V26.8B, V27.8B, V28.8B }, [X23], X2
    LD1 { V26.8B, V27.8B, V28.8B }, [X23], X2
    ADD  X23, X23, X25, LSR #0
    MOV  X5, X23
    ST1 { V24.2D, V25.2D }, [X5], #32
    MOV  X5, X23
    LD1 { V4.4S, V5.4S }, [X5], #32
    ADD  X23, X23, X25, LSR #0
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X6
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X9
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X14
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X16
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X27
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0x5a5a, LSL #0
    MOVK  X17, #0x5a5a, LSL #16
    MOVK  X17, #0x5a5a, LSL #32
    MOVK  X17, #0x5a5a, LSL #48
    SUB  X11, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    MRS  X17, FPSR
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D0
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D1
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D2
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D3
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D4
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D5
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D6
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D7
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D8
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D9
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D10
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D11
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D12
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D13
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D14
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D15
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D16
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D17
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D18
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D19
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D20
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D21
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D22
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D23
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D24
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D25
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D26
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D27
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D28
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D29
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D30
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X11, #0x0, LSL #0
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D31
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X15, X11, X17
    ADD  X1, X1, #0x1
    CBNZ  X15, AdvsimdLoadStoreP03_TestFail
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
    FMOV  V0.D[1], X6
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X13
    FMOV  V2.D[1], X28
    FMOV  D3, X10
    FMOV  V3.D[1], X13
    FMOV  D4, X8
    FMOV  V4.D[1], X17
    FMOV  D5, X8
    FMOV  V5.D[1], X6
    FMOV  D6, X5
    FMOV  V6.D[1], X25
    FMOV  D7, X12
    FMOV  V7.D[1], X2
    FMOV  D8, X9
    FMOV  V8.D[1], X16
    FMOV  D9, X28
    FMOV  V9.D[1], X9
    FMOV  D10, X3
    FMOV  V10.D[1], X7
    FMOV  D11, X27
    FMOV  V11.D[1], X13
    FMOV  D12, X2
    FMOV  V12.D[1], X14
    FMOV  D13, X23
    FMOV  V13.D[1], X3
    FMOV  D14, X17
    FMOV  V14.D[1], X29
    FMOV  D15, X8
    FMOV  V15.D[1], X7
    FMOV  D16, X23
    FMOV  V16.D[1], X8
    FMOV  D17, X9
    FMOV  V17.D[1], X16
    FMOV  D18, X10
    FMOV  V18.D[1], X6
    FMOV  D19, X13
    FMOV  V19.D[1], X17
    FMOV  D20, X6
    FMOV  V20.D[1], X3
    FMOV  D21, X16
    FMOV  V21.D[1], X7
    FMOV  D22, X10
    FMOV  V22.D[1], X11
    FMOV  D23, X4
    FMOV  V23.D[1], X25
    FMOV  D24, X23
    FMOV  V24.D[1], X3
    FMOV  D25, X12
    FMOV  V25.D[1], X5
    FMOV  D26, X5
    FMOV  V26.D[1], X7
    FMOV  D27, X11
    FMOV  V27.D[1], X29
    FMOV  D28, X9
    FMOV  V28.D[1], X24
    FMOV  D29, X27
    FMOV  V29.D[1], X6
    FMOV  D30, X15
    FMOV  V30.D[1], X17
    FMOV  D31, X5
    FMOV  V31.D[1], X28
    MOVZ  X2, #0x0, LSL #0
    MOVZ  X6, #0x40, LSL #0
    MOVZ  X9, #0x1900, LSL #0
    ADD  X14, X30, X9, ASR #0
    ST1 { V18.4S }, [X14], X2
    LD1 { V13.2D }, [X14], X2
    ADD  X14, X14, X6
    ST1 { V13.16B }, [X14], X2
    LD1 { V6.16B }, [X14], X2
    ADD  X14, X14, X6, ASR #0
    ST1 { V31.2D }, [X14], X2
    LD1 { V28.2D }, [X14], X2
    ADD  X14, X14, X6
    ST1 { V17.4S }, [X14], X2
    LD1 { V4.4S }, [X14], X2
    ADD  X14, X14, X6
    ST1 { V6.8H }, [X14], X2
    LD1 { V9.8H }, [X14], X2
    ADD  X14, X14, X6, LSR #0
    ST1 { V4.4H }, [X14], X2
    LD1 { V3.2S }, [X14], X2
    ADD  X14, X14, X6, LSR #0
    ST1 { V31.1D }, [X14], X2
    LD1 { V28.1D }, [X14], X2
    ADD  X14, X14, X6, LSR #0
    ST1 { V14.2S }, [X14], X2
    LD1 { V27.2S }, [X14], X2
    ADD  X14, X14, X6
    ST1 { V20.4H }, [X14], X2
    LD1 { V3.4H }, [X14], X2
    ADD  X14, X14, X6
    ST1 { V28.8B }, [X14], X2
    LD1 { V19.8B }, [X14], X2
    ADD  X14, X14, X6, LSR #0
    MOV  X23, X14
    ST1 { V30.2D, V31.2D, V0.2D }, [X23], #48
    MOV  X23, X14
    LD1 { V14.2D, V15.2D, V16.2D }, [X23], #48
    ADD  X14, X14, X6
    MOV  X23, X14
    ST1 { V3.16B, V4.16B, V5.16B }, [X23], #48
    MOV  X23, X14
    LD1 { V14.16B, V15.16B, V16.16B }, [X23], #48
    ADD  X14, X14, X6, ASR #0
    MOV  X23, X14
    ST1 { V3.2D, V4.2D, V5.2D }, [X23], #48
    MOV  X23, X14
    LD1 { V30.2D, V31.2D, V0.2D }, [X23], #48
    ADD  X14, X14, X6
    MOV  X23, X14
    ST1 { V30.4S, V31.4S, V0.4S }, [X23], #48
    MOV  X23, X14
    LD1 { V17.4S, V18.4S, V19.4S }, [X23], #48
    ADD  X14, X14, X6, LSR #0
    MOV  X23, X14
    ST1 { V14.8H, V15.8H, V16.8H }, [X23], #48
    MOV  X23, X14
    LD1 { V23.8H, V24.8H, V25.8H }, [X23], #48
    ADD  X14, X14, X6
    MOV  X23, X14
    ST1 { V17.1D, V18.1D, V19.1D }, [X23], #24
    MOV  X23, X14
    LD1 { V2.8B, V3.8B, V4.8B }, [X23], #24
    ADD  X14, X14, X6, ASR #0
    MOV  X23, X14
    ST1 { V27.1D, V28.1D, V29.1D }, [X23], #24
    MOV  X23, X14
    LD1 { V9.1D, V10.1D, V11.1D }, [X23], #24
    ADD  X14, X14, X6, ASR #0
    MOV  X23, X14
    ST1 { V15.2S, V16.2S, V17.2S }, [X23], #24
    MOV  X23, X14
    LD1 { V30.2S, V31.2S, V0.2S }, [X23], #24
    ADD  X14, X14, X6, LSR #0
    MOV  X23, X14
    ST1 { V26.4H, V27.4H, V28.4H }, [X23], #24
    MOV  X23, X14
    LD1 { V3.4H, V4.4H, V5.4H }, [X23], #24
    ADD  X14, X14, X6, ASR #0
    MOV  X23, X14
    ST1 { V23.8B, V24.8B, V25.8B }, [X23], #24
    MOV  X23, X14
    LD1 { V10.8B, V11.8B, V12.8B }, [X23], #24
    ADD  X14, X14, X6
    ST1 { V16.4S, V17.4S, V18.4S }, [X14], X2
    LD1 { V1.8H, V2.8H, V3.8H }, [X14], X2
    ADD  X14, X14, X6
    ST1 { V1.16B, V2.16B, V3.16B }, [X14], X2
    LD1 { V14.16B, V15.16B, V16.16B }, [X14], X2
    ADD  X14, X14, X6, LSR #0
    ST1 { V10.2D, V11.2D, V12.2D }, [X14], X2
    LD1 { V25.2D, V26.2D, V27.2D }, [X14], X2
    ADD  X14, X14, X6, ASR #0
    ST1 { V14.4S, V15.4S, V16.4S }, [X14], X2
    LD1 { V16.4S, V17.4S, V18.4S }, [X14], X2
    ADD  X14, X14, X6, LSR #0
    ST1 { V12.8H, V13.8H, V14.8H }, [X14], X2
    LD1 { V10.8H, V11.8H, V12.8H }, [X14], X2
    ADD  X14, X14, X6, ASR #0
    ST1 { V22.8B, V23.8B, V24.8B }, [X14], X2
    LD1 { V22.8B, V23.8B, V24.8B }, [X14], X2
    ADD  X14, X14, X6
    ST1 { V25.1D, V26.1D, V27.1D }, [X14], X2
    LD1 { V22.1D, V23.1D, V24.1D }, [X14], X2
    ADD  X14, X14, X6, ASR #0
    ST1 { V10.2S, V11.2S, V12.2S }, [X14], X2
    LD1 { V1.2S, V2.2S, V3.2S }, [X14], X2
    ADD  X14, X14, X6, ASR #0
    ST1 { V29.4H, V30.4H, V31.4H }, [X14], X2
    LD1 { V12.4H, V13.4H, V14.4H }, [X14], X2
    ADD  X14, X14, X6, ASR #0
    ST1 { V22.8B, V23.8B, V24.8B }, [X14], X2
    LD1 { V22.8B, V23.8B, V24.8B }, [X14], X2
    ADD  X14, X14, X6
    MOV  X23, X14
    ST1 { V23.2D, V24.2D }, [X23], #32
    MOV  X23, X14
    LD1 { V16.8H, V17.8H }, [X23], #32
    ADD  X14, X14, X6, LSR #0
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X28
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0xa5a5, LSL #0
    MOVK  X8, #0xa5a5, LSL #16
    MOVK  X8, #0xa5a5, LSL #32
    MOVK  X8, #0xa5a5, LSL #48
    SUB  X3, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MRS  X8, FPSR
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D0
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D1
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D2
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D3
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D4
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D5
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D6
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D7
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D8
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D9
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D10
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D11
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D12
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D13
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D14
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D15
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D16
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D17
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D18
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D19
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D20
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D21
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D22
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D23
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D24
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D25
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D26
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D27
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D28
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D29
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D30
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D31
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X16, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X16, AdvsimdLoadStoreP03_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X28
    FMOV  D2, X10
    FMOV  V2.D[1], X27
    FMOV  D3, X16
    FMOV  V3.D[1], X24
    FMOV  D4, X7
    FMOV  V4.D[1], X11
    FMOV  D5, X28
    FMOV  V5.D[1], X12
    FMOV  D6, X14
    FMOV  V6.D[1], X17
    FMOV  D7, X23
    FMOV  V7.D[1], X5
    FMOV  D8, X29
    FMOV  V8.D[1], X15
    FMOV  D9, X4
    FMOV  V9.D[1], X24
    FMOV  D10, X24
    FMOV  V10.D[1], X16
    FMOV  D11, X15
    FMOV  V11.D[1], X26
    FMOV  D12, X12
    FMOV  V12.D[1], X17
    FMOV  D13, X12
    FMOV  V13.D[1], X23
    FMOV  D14, X8
    FMOV  V14.D[1], X29
    FMOV  D15, X27
    FMOV  V15.D[1], X13
    FMOV  D16, X24
    FMOV  V16.D[1], X4
    FMOV  D17, X28
    FMOV  V17.D[1], X5
    FMOV  D18, X2
    FMOV  V18.D[1], X2
    FMOV  D19, X26
    FMOV  V19.D[1], X6
    FMOV  D20, X15
    FMOV  V20.D[1], X16
    FMOV  D21, X5
    FMOV  V21.D[1], X13
    FMOV  D22, X6
    FMOV  V22.D[1], X29
    FMOV  D23, X16
    FMOV  V23.D[1], X23
    FMOV  D24, X24
    FMOV  V24.D[1], X3
    FMOV  D25, X13
    FMOV  V25.D[1], X23
    FMOV  D26, X15
    FMOV  V26.D[1], X23
    FMOV  D27, X14
    FMOV  V27.D[1], X14
    FMOV  D28, X14
    FMOV  V28.D[1], X15
    FMOV  D29, X17
    FMOV  V29.D[1], X8
    FMOV  D30, X11
    FMOV  V30.D[1], X6
    FMOV  D31, X3
    FMOV  V31.D[1], X13
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X25, #0x1e00, LSL #0
    ADD  X23, X30, X25, LSR #0
    ST1 { V27.2D }, [X23], X4
    LD1 { V30.16B }, [X23], X4
    ADD  X23, X23, X27, ASR #0
    ST1 { V30.16B }, [X23], X4
    LD1 { V28.16B }, [X23], X4
    ADD  X23, X23, X27
    ST1 { V31.2D }, [X23], X4
    LD1 { V19.2D }, [X23], X4
    ADD  X23, X23, X27, LSR #0
    ST1 { V10.4S }, [X23], X4
    LD1 { V5.4S }, [X23], X4
    ADD  X23, X23, X27
    ST1 { V26.8H }, [X23], X4
    LD1 { V24.8H }, [X23], X4
    ADD  X23, X23, X27
    ST1 { V28.1D }, [X23], X4
    LD1 { V12.2S }, [X23], X4
    ADD  X23, X23, X27, LSR #0
    ST1 { V12.1D }, [X23], X4
    LD1 { V3.1D }, [X23], X4
    ADD  X23, X23, X27
    ST1 { V3.2S }, [X23], X4
    LD1 { V26.2S }, [X23], X4
    ADD  X23, X23, X27, LSR #0
    ST1 { V27.4H }, [X23], X4
    LD1 { V31.4H }, [X23], X4
    ADD  X23, X23, X27, LSR #0
    ST1 { V6.8B }, [X23], X4
    LD1 { V19.8B }, [X23], X4
    ADD  X23, X23, X27, ASR #0
    MOV  X17, X23
    ST1 { V28.2D, V29.2D, V30.2D }, [X17], #48
    MOV  X17, X23
    LD1 { V31.8H, V0.8H, V1.8H }, [X17], #48
    ADD  X23, X23, X27
    MOV  X17, X23
    ST1 { V29.16B, V30.16B, V31.16B }, [X17], #48
    MOV  X17, X23
    LD1 { V24.16B, V25.16B, V26.16B }, [X17], #48
    ADD  X23, X23, X27, LSR #0
    MOV  X17, X23
    ST1 { V24.2D, V25.2D, V26.2D }, [X17], #48
    MOV  X17, X23
    LD1 { V15.2D, V16.2D, V17.2D }, [X17], #48
    ADD  X23, X23, X27, ASR #0
    MOV  X17, X23
    ST1 { V15.4S, V16.4S, V17.4S }, [X17], #48
    MOV  X17, X23
    LD1 { V25.4S, V26.4S, V27.4S }, [X17], #48
    ADD  X23, X23, X27, ASR #0
    MOV  X17, X23
    ST1 { V2.8H, V3.8H, V4.8H }, [X17], #48
    MOV  X17, X23
    LD1 { V27.8H, V28.8H, V29.8H }, [X17], #48
    ADD  X23, X23, X27
    MOV  X17, X23
    ST1 { V26.4H, V27.4H, V28.4H }, [X17], #24
    MOV  X17, X23
    LD1 { V13.8B, V14.8B, V15.8B }, [X17], #24
    ADD  X23, X23, X27, ASR #0
    MOV  X17, X23
    ST1 { V13.1D, V14.1D, V15.1D }, [X17], #24
    MOV  X17, X23
    LD1 { V31.1D, V0.1D, V1.1D }, [X17], #24
    ADD  X23, X23, X27, LSR #0
    MOV  X17, X23
    ST1 { V31.2S, V0.2S, V1.2S }, [X17], #24
    MOV  X17, X23
    LD1 { V31.2S, V0.2S, V1.2S }, [X17], #24
    ADD  X23, X23, X27
    MOV  X17, X23
    ST1 { V12.4H, V13.4H, V14.4H }, [X17], #24
    MOV  X17, X23
    LD1 { V26.4H, V27.4H, V28.4H }, [X17], #24
    ADD  X23, X23, X27
    MOV  X17, X23
    ST1 { V26.8B, V27.8B, V28.8B }, [X17], #24
    MOV  X17, X23
    LD1 { V14.8B, V15.8B, V16.8B }, [X17], #24
    ADD  X23, X23, X27
    ST1 { V31.4S, V0.4S, V1.4S }, [X23], X4
    LD1 { V31.2D, V0.2D, V1.2D }, [X23], X4
    ADD  X23, X23, X27
    ST1 { V6.16B, V7.16B, V8.16B }, [X23], X4
    LD1 { V23.16B, V24.16B, V25.16B }, [X23], X4
    ADD  X23, X23, X27, LSR #0
    ST1 { V14.2D, V15.2D, V16.2D }, [X23], X4
    LD1 { V13.2D, V14.2D, V15.2D }, [X23], X4
    ADD  X23, X23, X27
    ST1 { V13.4S, V14.4S, V15.4S }, [X23], X4
    LD1 { V6.4S, V7.4S, V8.4S }, [X23], X4
    ADD  X23, X23, X27
    ST1 { V11.8H, V12.8H, V13.8H }, [X23], X4
    LD1 { V13.8H, V14.8H, V15.8H }, [X23], X4
    ADD  X23, X23, X27
    ST1 { V28.8B, V29.8B, V30.8B }, [X23], X4
    LD1 { V13.1D, V14.1D, V15.1D }, [X23], X4
    ADD  X23, X23, X27, LSR #0
    ST1 { V13.1D, V14.1D, V15.1D }, [X23], X4
    LD1 { V14.1D, V15.1D, V16.1D }, [X23], X4
    ADD  X23, X23, X27, LSR #0
    ST1 { V14.2S, V15.2S, V16.2S }, [X23], X4
    LD1 { V11.2S, V12.2S, V13.2S }, [X23], X4
    ADD  X23, X23, X27, ASR #0
    ST1 { V13.4H, V14.4H, V15.4H }, [X23], X4
    LD1 { V13.4H, V14.4H, V15.4H }, [X23], X4
    ADD  X23, X23, X27, LSR #0
    ST1 { V6.8B, V7.8B, V8.8B }, [X23], X4
    LD1 { V28.8B, V29.8B, V30.8B }, [X23], X4
    ADD  X23, X23, X27
    MOV  X17, X23
    ST1 { V13.16B, V14.16B }, [X17], #32
    MOV  X17, X23
    LD1 { V18.16B, V19.16B }, [X17], #32
    ADD  X23, X23, X27, LSR #0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X2
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X12
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X15
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X24
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X13, X28, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MRS  X28, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V0.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D1
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V2.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D2
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D3
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V4.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D4
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V5.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D5
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D6
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D7
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D8
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V9.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D9
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V10.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D10
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D11
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D12
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D13
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D14
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D15
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D16
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V17.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D17
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D18
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D19
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V20.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D20
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V21.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D21
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V22.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D22
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V23.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D23
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V24.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D24
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V25.D[1]
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D25
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D26
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D27
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V28.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D28
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V29.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D29
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V30.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D30
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, V31.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X28, D31
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X6, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
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
    FMOV  V0.D[1], X25
    FMOV  D1, X3
    FMOV  V1.D[1], X27
    FMOV  D2, X29
    FMOV  V2.D[1], X9
    FMOV  D3, X26
    FMOV  V3.D[1], X28
    FMOV  D4, X3
    FMOV  V4.D[1], X3
    FMOV  D5, X3
    FMOV  V5.D[1], X29
    FMOV  D6, X3
    FMOV  V6.D[1], X14
    FMOV  D7, X13
    FMOV  V7.D[1], X15
    FMOV  D8, X11
    FMOV  V8.D[1], X13
    FMOV  D9, X24
    FMOV  V9.D[1], X2
    FMOV  D10, X26
    FMOV  V10.D[1], X25
    FMOV  D11, X25
    FMOV  V11.D[1], X15
    FMOV  D12, X24
    FMOV  V12.D[1], X16
    FMOV  D13, X13
    FMOV  V13.D[1], X15
    FMOV  D14, X8
    FMOV  V14.D[1], X29
    FMOV  D15, X17
    FMOV  V15.D[1], X13
    FMOV  D16, X5
    FMOV  V16.D[1], X13
    FMOV  D17, X7
    FMOV  V17.D[1], X3
    FMOV  D18, X10
    FMOV  V18.D[1], X3
    FMOV  D19, X11
    FMOV  V19.D[1], X8
    FMOV  D20, X2
    FMOV  V20.D[1], X4
    FMOV  D21, X12
    FMOV  V21.D[1], X8
    FMOV  D22, X25
    FMOV  V22.D[1], X12
    FMOV  D23, X29
    FMOV  V23.D[1], X12
    FMOV  D24, X14
    FMOV  V24.D[1], X11
    FMOV  D25, X13
    FMOV  V25.D[1], X3
    FMOV  D26, X5
    FMOV  V26.D[1], X24
    FMOV  D27, X23
    FMOV  V27.D[1], X27
    FMOV  D28, X25
    FMOV  V28.D[1], X5
    FMOV  D29, X27
    FMOV  V29.D[1], X7
    FMOV  D30, X15
    FMOV  V30.D[1], X3
    FMOV  D31, X25
    FMOV  V31.D[1], X7
    MOVZ  X26, #0x0, LSL #0
    MOVZ  X27, #0x40, LSL #0
    MOVZ  X10, #0x2300, LSL #0
    ADD  X8, X30, X10, ASR #0
    ST1 { V26.2D }, [X8], X26
    LD1 { V2.16B }, [X8], X26
    ADD  X8, X8, X27, ASR #0
    ST1 { V27.16B }, [X8], X26
    LD1 { V25.16B }, [X8], X26
    ADD  X8, X8, X27, ASR #0
    ST1 { V28.2D }, [X8], X26
    LD1 { V12.2D }, [X8], X26
    ADD  X8, X8, X27, ASR #0
    ST1 { V29.4S }, [X8], X26
    LD1 { V10.4S }, [X8], X26
    ADD  X8, X8, X27, ASR #0
    ST1 { V31.8H }, [X8], X26
    LD1 { V7.8H }, [X8], X26
    ADD  X8, X8, X27, ASR #0
    ST1 { V12.8B }, [X8], X26
    LD1 { V29.1D }, [X8], X26
    ADD  X8, X8, X27, LSR #0
    ST1 { V30.1D }, [X8], X26
    LD1 { V16.1D }, [X8], X26
    ADD  X8, X8, X27
    ST1 { V8.2S }, [X8], X26
    LD1 { V7.2S }, [X8], X26
    ADD  X8, X8, X27, LSR #0
    ST1 { V7.4H }, [X8], X26
    LD1 { V19.4H }, [X8], X26
    ADD  X8, X8, X27, LSR #0
    ST1 { V25.8B }, [X8], X26
    LD1 { V8.8B }, [X8], X26
    ADD  X8, X8, X27, ASR #0
    MOV  X7, X8
    ST1 { V16.2D, V17.2D, V18.2D }, [X7], #48
    MOV  X7, X8
    LD1 { V31.2D, V0.2D, V1.2D }, [X7], #48
    ADD  X8, X8, X27, LSR #0
    MOV  X7, X8
    ST1 { V31.16B, V0.16B, V1.16B }, [X7], #48
    MOV  X7, X8
    LD1 { V19.16B, V20.16B, V21.16B }, [X7], #48
    ADD  X8, X8, X27, LSR #0
    MOV  X7, X8
    ST1 { V19.2D, V20.2D, V21.2D }, [X7], #48
    MOV  X7, X8
    LD1 { V26.2D, V27.2D, V28.2D }, [X7], #48
    ADD  X8, X8, X27, LSR #0
    MOV  X7, X8
    ST1 { V29.4S, V30.4S, V31.4S }, [X7], #48
    MOV  X7, X8
    LD1 { V10.4S, V11.4S, V12.4S }, [X7], #48
    ADD  X8, X8, X27
    MOV  X7, X8
    ST1 { V6.8H, V7.8H, V8.8H }, [X7], #48
    MOV  X7, X8
    LD1 { V26.8H, V27.8H, V28.8H }, [X7], #48
    ADD  X8, X8, X27, LSR #0
    MOV  X7, X8
    ST1 { V7.8B, V8.8B, V9.8B }, [X7], #24
    MOV  X7, X8
    LD1 { V6.2S, V7.2S, V8.2S }, [X7], #24
    ADD  X8, X8, X27
    MOV  X7, X8
    ST1 { V6.1D, V7.1D, V8.1D }, [X7], #24
    MOV  X7, X8
    LD1 { V29.1D, V30.1D, V31.1D }, [X7], #24
    ADD  X8, X8, X27, LSR #0
    MOV  X7, X8
    ST1 { V26.2S, V27.2S, V28.2S }, [X7], #24
    MOV  X7, X8
    LD1 { V23.2S, V24.2S, V25.2S }, [X7], #24
    ADD  X8, X8, X27, LSR #0
    MOV  X7, X8
    ST1 { V29.4H, V30.4H, V31.4H }, [X7], #24
    MOV  X7, X8
    LD1 { V29.4H, V30.4H, V31.4H }, [X7], #24
    ADD  X8, X8, X27, LSR #0
    MOV  X7, X8
    ST1 { V29.8B, V30.8B, V31.8B }, [X7], #24
    MOV  X7, X8
    LD1 { V27.8B, V28.8B, V29.8B }, [X7], #24
    ADD  X8, X8, X27, LSR #0
    ST1 { V13.4S, V14.4S, V15.4S }, [X8], X26
    LD1 { V22.2D, V23.2D, V24.2D }, [X8], X26
    ADD  X8, X8, X27, ASR #0
    ST1 { V14.16B, V15.16B, V16.16B }, [X8], X26
    LD1 { V14.16B, V15.16B, V16.16B }, [X8], X26
    ADD  X8, X8, X27
    ST1 { V14.2D, V15.2D, V16.2D }, [X8], X26
    LD1 { V13.2D, V14.2D, V15.2D }, [X8], X26
    ADD  X8, X8, X27, ASR #0
    ST1 { V27.4S, V28.4S, V29.4S }, [X8], X26
    LD1 { V23.4S, V24.4S, V25.4S }, [X8], X26
    ADD  X8, X8, X27
    ST1 { V14.8H, V15.8H, V16.8H }, [X8], X26
    LD1 { V23.8H, V24.8H, V25.8H }, [X8], X26
    ADD  X8, X8, X27, LSR #0
    ST1 { V23.8B, V24.8B, V25.8B }, [X8], X26
    LD1 { V14.8B, V15.8B, V16.8B }, [X8], X26
    ADD  X8, X8, X27
    ST1 { V21.1D, V22.1D, V23.1D }, [X8], X26
    LD1 { V6.1D, V7.1D, V8.1D }, [X8], X26
    ADD  X8, X8, X27, LSR #0
    ST1 { V6.2S, V7.2S, V8.2S }, [X8], X26
    LD1 { V16.2S, V17.2S, V18.2S }, [X8], X26
    ADD  X8, X8, X27, LSR #0
    ST1 { V17.4H, V18.4H, V19.4H }, [X8], X26
    LD1 { V6.4H, V7.4H, V8.4H }, [X8], X26
    ADD  X8, X8, X27, LSR #0
    ST1 { V19.8B, V20.8B, V21.8B }, [X8], X26
    LD1 { V19.8B, V20.8B, V21.8B }, [X8], X26
    ADD  X8, X8, X27, ASR #0
    MOV  X7, X8
    ST1 { V6.16B, V7.16B }, [X7], #32
    MOV  X7, X8
    LD1 { V24.16B, V25.16B }, [X7], #32
    ADD  X8, X8, X27, LSR #0
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X12
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X17
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X2, #0xa5a5, LSL #0
    MOVK  X2, #0xa5a5, LSL #16
    MOVK  X2, #0xa5a5, LSL #32
    MOVK  X2, #0xa5a5, LSL #48
    SUB  X29, X2, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MRS  X2, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V0.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V1.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D1
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V2.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D2
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V3.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D3
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V4.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D4
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V5.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D5
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D6
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D7
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D8
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V9.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D9
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D10
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V11.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D11
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D12
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V13.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D13
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D14
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D15
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D16
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D17
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D18
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V19.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D19
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D20
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D21
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V22.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D22
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V23.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D23
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D24
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D25
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V26.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D26
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D27
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D28
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D29
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D30
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X4, X29, X2
    ADD  X1, X1, #0x1
    CBNZ  X4, AdvsimdLoadStoreP03_TestFail
    FMOV  X2, D31
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X4, X29, X2
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
    FMOV  D1, X28
    FMOV  V1.D[1], X29
    FMOV  D2, X26
    FMOV  V2.D[1], X25
    FMOV  D3, X4
    FMOV  V3.D[1], X15
    FMOV  D4, X5
    FMOV  V4.D[1], X12
    FMOV  D5, X26
    FMOV  V5.D[1], X9
    FMOV  D6, X7
    FMOV  V6.D[1], X28
    FMOV  D7, X16
    FMOV  V7.D[1], X2
    FMOV  D8, X23
    FMOV  V8.D[1], X5
    FMOV  D9, X3
    FMOV  V9.D[1], X7
    FMOV  D10, X6
    FMOV  V10.D[1], X16
    FMOV  D11, X7
    FMOV  V11.D[1], X2
    FMOV  D12, X3
    FMOV  V12.D[1], X6
    FMOV  D13, X26
    FMOV  V13.D[1], X23
    FMOV  D14, X14
    FMOV  V14.D[1], X29
    FMOV  D15, X2
    FMOV  V15.D[1], X3
    FMOV  D16, X3
    FMOV  V16.D[1], X12
    FMOV  D17, X3
    FMOV  V17.D[1], X28
    FMOV  D18, X7
    FMOV  V18.D[1], X10
    FMOV  D19, X8
    FMOV  V19.D[1], X14
    FMOV  D20, X7
    FMOV  V20.D[1], X26
    FMOV  D21, X9
    FMOV  V21.D[1], X13
    FMOV  D22, X25
    FMOV  V22.D[1], X11
    FMOV  D23, X2
    FMOV  V23.D[1], X23
    FMOV  D24, X10
    FMOV  V24.D[1], X14
    FMOV  D25, X14
    FMOV  V25.D[1], X7
    FMOV  D26, X14
    FMOV  V26.D[1], X29
    FMOV  D27, X9
    FMOV  V27.D[1], X3
    FMOV  D28, X14
    FMOV  V28.D[1], X6
    FMOV  D29, X14
    FMOV  V29.D[1], X17
    FMOV  D30, X29
    FMOV  V30.D[1], X24
    FMOV  D31, X25
    FMOV  V31.D[1], X14
    MOVZ  X8, #0x0, LSL #0
    MOVZ  X26, #0x40, LSL #0
    MOVZ  X17, #0x2800, LSL #0
    ADD  X4, X30, X17, LSR #0
    ST1 { V29.8H }, [X4], X8
    LD1 { V18.4S }, [X4], X8
    ADD  X4, X4, X26, ASR #0
    ST1 { V26.16B }, [X4], X8
    LD1 { V6.16B }, [X4], X8
    ADD  X4, X4, X26, LSR #0
    ST1 { V30.2D }, [X4], X8
    LD1 { V6.2D }, [X4], X8
    ADD  X4, X4, X26
    ST1 { V6.4S }, [X4], X8
    LD1 { V12.4S }, [X4], X8
    ADD  X4, X4, X26
    ST1 { V18.8H }, [X4], X8
    LD1 { V17.8H }, [X4], X8
    ADD  X4, X4, X26
    ST1 { V31.2S }, [X4], X8
    LD1 { V1.1D }, [X4], X8
    ADD  X4, X4, X26
    ST1 { V17.1D }, [X4], X8
    LD1 { V30.1D }, [X4], X8
    ADD  X4, X4, X26, LSR #0
    ST1 { V15.2S }, [X4], X8
    LD1 { V27.2S }, [X4], X8
    ADD  X4, X4, X26
    ST1 { V1.4H }, [X4], X8
    LD1 { V8.4H }, [X4], X8
    ADD  X4, X4, X26, ASR #0
    ST1 { V8.8B }, [X4], X8
    LD1 { V13.8B }, [X4], X8
    ADD  X4, X4, X26
    MOV  X13, X4
    ST1 { V11.4S, V12.4S, V13.4S }, [X13], #48
    MOV  X13, X4
    LD1 { V18.4S, V19.4S, V20.4S }, [X13], #48
    ADD  X4, X4, X26, LSR #0
    MOV  X13, X4
    ST1 { V18.16B, V19.16B, V20.16B }, [X13], #48
    MOV  X13, X4
    LD1 { V31.16B, V0.16B, V1.16B }, [X13], #48
    ADD  X4, X4, X26
    MOV  X13, X4
    ST1 { V2.2D, V3.2D, V4.2D }, [X13], #48
    MOV  X13, X4
    LD1 { V2.2D, V3.2D, V4.2D }, [X13], #48
    ADD  X4, X4, X26
    MOV  X13, X4
    ST1 { V1.4S, V2.4S, V3.4S }, [X13], #48
    MOV  X13, X4
    LD1 { V13.4S, V14.4S, V15.4S }, [X13], #48
    ADD  X4, X4, X26
    MOV  X13, X4
    ST1 { V13.8H, V14.8H, V15.8H }, [X13], #48
    MOV  X13, X4
    LD1 { V6.8H, V7.8H, V8.8H }, [X13], #48
    ADD  X4, X4, X26, LSR #0
    MOV  X13, X4
    ST1 { V12.8B, V13.8B, V14.8B }, [X13], #24
    MOV  X13, X4
    LD1 { V2.4H, V3.4H, V4.4H }, [X13], #24
    ADD  X4, X4, X26, ASR #0
    MOV  X13, X4
    ST1 { V27.1D, V28.1D, V29.1D }, [X13], #24
    MOV  X13, X4
    LD1 { V10.1D, V11.1D, V12.1D }, [X13], #24
    ADD  X4, X4, X26, LSR #0
    MOV  X13, X4
    ST1 { V7.2S, V8.2S, V9.2S }, [X13], #24
    MOV  X13, X4
    LD1 { V16.2S, V17.2S, V18.2S }, [X13], #24
    ADD  X4, X4, X26
    MOV  X13, X4
    ST1 { V13.4H, V14.4H, V15.4H }, [X13], #24
    MOV  X13, X4
    LD1 { V9.4H, V10.4H, V11.4H }, [X13], #24
    ADD  X4, X4, X26, ASR #0
    MOV  X13, X4
    ST1 { V2.8B, V3.8B, V4.8B }, [X13], #24
    MOV  X13, X4
    LD1 { V10.8B, V11.8B, V12.8B }, [X13], #24
    ADD  X4, X4, X26
    ST1 { V17.16B, V18.16B, V19.16B }, [X4], X8
    LD1 { V24.8H, V25.8H, V26.8H }, [X4], X8
    ADD  X4, X4, X26, ASR #0
    ST1 { V12.16B, V13.16B, V14.16B }, [X4], X8
    LD1 { V15.16B, V16.16B, V17.16B }, [X4], X8
    ADD  X4, X4, X26
    ST1 { V25.2D, V26.2D, V27.2D }, [X4], X8
    LD1 { V25.2D, V26.2D, V27.2D }, [X4], X8
    ADD  X4, X4, X26
    ST1 { V28.4S, V29.4S, V30.4S }, [X4], X8
    LD1 { V28.4S, V29.4S, V30.4S }, [X4], X8
    ADD  X4, X4, X26
    ST1 { V26.8H, V27.8H, V28.8H }, [X4], X8
    LD1 { V12.8H, V13.8H, V14.8H }, [X4], X8
    ADD  X4, X4, X26, LSR #0
    ST1 { V5.8B, V6.8B, V7.8B }, [X4], X8
    LD1 { V5.2S, V6.2S, V7.2S }, [X4], X8
    ADD  X4, X4, X26, ASR #0
    ST1 { V26.1D, V27.1D, V28.1D }, [X4], X8
    LD1 { V26.1D, V27.1D, V28.1D }, [X4], X8
    ADD  X4, X4, X26
    ST1 { V28.2S, V29.2S, V30.2S }, [X4], X8
    LD1 { V28.2S, V29.2S, V30.2S }, [X4], X8
    ADD  X4, X4, X26, ASR #0
    ST1 { V13.4H, V14.4H, V15.4H }, [X4], X8
    LD1 { V13.4H, V14.4H, V15.4H }, [X4], X8
    ADD  X4, X4, X26, LSR #0
    ST1 { V25.8B, V26.8B, V27.8B }, [X4], X8
    LD1 { V0.8B, V1.8B, V2.8B }, [X4], X8
    ADD  X4, X4, X26
    MOV  X13, X4
    ST1 { V4.2D, V5.2D }, [X13], #32
    MOV  X13, X4
    LD1 { V4.2D, V5.2D }, [X13], #32
    ADD  X4, X4, X26, ASR #0
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X3
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X6
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X7
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X10
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X24
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X12, #0x5a5a, LSL #0
    MOVK  X12, #0x5a5a, LSL #16
    MOVK  X12, #0x5a5a, LSL #32
    MOVK  X12, #0x5a5a, LSL #48
    SUB  X29, X12, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MRS  X12, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D0
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D1
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V2.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D2
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D3
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D4
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D5
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D6
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D7
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V8.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D8
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D9
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D10
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D11
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V12.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D12
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D13
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D14
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D15
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D16
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V17.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D17
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D18
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V19.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D19
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D20
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V21.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D21
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V22.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D22
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V23.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D23
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D24
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D25
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D26
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D27
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D28
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V29.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D29
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D30
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, V31.D[1]
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
    FMOV  X12, D31
    MOVZ  X29, #0x5a5a, LSL #0
    MOVK  X29, #0x5a5a, LSL #16
    MOVK  X29, #0x5a5a, LSL #32
    MOVK  X29, #0x5a5a, LSL #48
    SUB  X11, X29, X12
    ADD  X1, X1, #0x1
    CBNZ  X11, AdvsimdLoadStoreP03_TestFail
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
    FMOV  V0.D[1], X17
    FMOV  D1, X29
    FMOV  V1.D[1], X26
    FMOV  D2, X17
    FMOV  V2.D[1], X27
    FMOV  D3, X7
    FMOV  V3.D[1], X9
    FMOV  D4, X28
    FMOV  V4.D[1], X5
    FMOV  D5, X29
    FMOV  V5.D[1], X8
    FMOV  D6, X15
    FMOV  V6.D[1], X14
    FMOV  D7, X8
    FMOV  V7.D[1], X11
    FMOV  D8, X27
    FMOV  V8.D[1], X24
    FMOV  D9, X7
    FMOV  V9.D[1], X8
    FMOV  D10, X3
    FMOV  V10.D[1], X2
    FMOV  D11, X5
    FMOV  V11.D[1], X16
    FMOV  D12, X8
    FMOV  V12.D[1], X2
    FMOV  D13, X4
    FMOV  V13.D[1], X16
    FMOV  D14, X25
    FMOV  V14.D[1], X3
    FMOV  D15, X9
    FMOV  V15.D[1], X12
    FMOV  D16, X11
    FMOV  V16.D[1], X29
    FMOV  D17, X10
    FMOV  V17.D[1], X4
    FMOV  D18, X23
    FMOV  V18.D[1], X10
    FMOV  D19, X15
    FMOV  V19.D[1], X2
    FMOV  D20, X11
    FMOV  V20.D[1], X2
    FMOV  D21, X8
    FMOV  V21.D[1], X27
    FMOV  D22, X10
    FMOV  V22.D[1], X5
    FMOV  D23, X2
    FMOV  V23.D[1], X15
    FMOV  D24, X28
    FMOV  V24.D[1], X24
    FMOV  D25, X27
    FMOV  V25.D[1], X15
    FMOV  D26, X9
    FMOV  V26.D[1], X23
    FMOV  D27, X15
    FMOV  V27.D[1], X8
    FMOV  D28, X11
    FMOV  V28.D[1], X15
    FMOV  D29, X25
    FMOV  V29.D[1], X6
    FMOV  D30, X8
    FMOV  V30.D[1], X28
    FMOV  D31, X26
    FMOV  V31.D[1], X8
    MOVZ  X27, #0x0, LSL #0
    MOVZ  X4, #0x40, LSL #0
    MOVZ  X15, #0x2d00, LSL #0
    ADD  X2, X30, X15, LSR #0
    ST1 { V23.16B }, [X2], X27
    LD1 { V0.16B }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    ST1 { V3.16B }, [X2], X27
    LD1 { V10.16B }, [X2], X27
    ADD  X2, X2, X4
    ST1 { V4.2D }, [X2], X27
    LD1 { V25.2D }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    ST1 { V18.4S }, [X2], X27
    LD1 { V19.4S }, [X2], X27
    ADD  X2, X2, X4
    ST1 { V31.8H }, [X2], X27
    LD1 { V18.8H }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    ST1 { V27.2S }, [X2], X27
    LD1 { V5.2S }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    ST1 { V29.1D }, [X2], X27
    LD1 { V4.1D }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    ST1 { V13.2S }, [X2], X27
    LD1 { V22.2S }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    ST1 { V21.4H }, [X2], X27
    LD1 { V5.4H }, [X2], X27
    ADD  X2, X2, X4, ASR #0
    ST1 { V25.8B }, [X2], X27
    LD1 { V5.8B }, [X2], X27
    ADD  X2, X2, X4, ASR #0
    MOV  X11, X2
    ST1 { V15.2D, V16.2D, V17.2D }, [X11], #48
    MOV  X11, X2
    LD1 { V3.8H, V4.8H, V5.8H }, [X11], #48
    ADD  X2, X2, X4, LSR #0
    MOV  X11, X2
    ST1 { V1.16B, V2.16B, V3.16B }, [X11], #48
    MOV  X11, X2
    LD1 { V17.16B, V18.16B, V19.16B }, [X11], #48
    ADD  X2, X2, X4
    MOV  X11, X2
    ST1 { V17.2D, V18.2D, V19.2D }, [X11], #48
    MOV  X11, X2
    LD1 { V14.2D, V15.2D, V16.2D }, [X11], #48
    ADD  X2, X2, X4, ASR #0
    MOV  X11, X2
    ST1 { V14.4S, V15.4S, V16.4S }, [X11], #48
    MOV  X11, X2
    LD1 { V28.4S, V29.4S, V30.4S }, [X11], #48
    ADD  X2, X2, X4, ASR #0
    MOV  X11, X2
    ST1 { V28.8H, V29.8H, V30.8H }, [X11], #48
    MOV  X11, X2
    LD1 { V16.8H, V17.8H, V18.8H }, [X11], #48
    ADD  X2, X2, X4, ASR #0
    MOV  X11, X2
    ST1 { V16.4H, V17.4H, V18.4H }, [X11], #24
    MOV  X11, X2
    LD1 { V16.4H, V17.4H, V18.4H }, [X11], #24
    ADD  X2, X2, X4
    MOV  X11, X2
    ST1 { V14.1D, V15.1D, V16.1D }, [X11], #24
    MOV  X11, X2
    LD1 { V14.1D, V15.1D, V16.1D }, [X11], #24
    ADD  X2, X2, X4
    MOV  X11, X2
    ST1 { V12.2S, V13.2S, V14.2S }, [X11], #24
    MOV  X11, X2
    LD1 { V21.2S, V22.2S, V23.2S }, [X11], #24
    ADD  X2, X2, X4, ASR #0
    MOV  X11, X2
    ST1 { V1.4H, V2.4H, V3.4H }, [X11], #24
    MOV  X11, X2
    LD1 { V8.4H, V9.4H, V10.4H }, [X11], #24
    ADD  X2, X2, X4, LSR #0
    MOV  X11, X2
    ST1 { V25.8B, V26.8B, V27.8B }, [X11], #24
    MOV  X11, X2
    LD1 { V24.8B, V25.8B, V26.8B }, [X11], #24
    ADD  X2, X2, X4, ASR #0
    ST1 { V22.16B, V23.16B, V24.16B }, [X2], X27
    LD1 { V12.8H, V13.8H, V14.8H }, [X2], X27
    ADD  X2, X2, X4
    ST1 { V22.16B, V23.16B, V24.16B }, [X2], X27
    LD1 { V10.16B, V11.16B, V12.16B }, [X2], X27
    ADD  X2, X2, X4
    ST1 { V11.2D, V12.2D, V13.2D }, [X2], X27
    LD1 { V6.2D, V7.2D, V8.2D }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    ST1 { V6.4S, V7.4S, V8.4S }, [X2], X27
    LD1 { V22.4S, V23.4S, V24.4S }, [X2], X27
    ADD  X2, X2, X4, ASR #0
    ST1 { V22.8H, V23.8H, V24.8H }, [X2], X27
    LD1 { V11.8H, V12.8H, V13.8H }, [X2], X27
    ADD  X2, X2, X4, ASR #0
    ST1 { V12.2S, V13.2S, V14.2S }, [X2], X27
    LD1 { V1.4H, V2.4H, V3.4H }, [X2], X27
    ADD  X2, X2, X4, ASR #0
    ST1 { V24.1D, V25.1D, V26.1D }, [X2], X27
    LD1 { V15.1D, V16.1D, V17.1D }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    ST1 { V1.2S, V2.2S, V3.2S }, [X2], X27
    LD1 { V17.2S, V18.2S, V19.2S }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    ST1 { V25.4H, V26.4H, V27.4H }, [X2], X27
    LD1 { V25.4H, V26.4H, V27.4H }, [X2], X27
    ADD  X2, X2, X4, ASR #0
    ST1 { V5.8B, V6.8B, V7.8B }, [X2], X27
    LD1 { V23.8B, V24.8B, V25.8B }, [X2], X27
    ADD  X2, X2, X4, LSR #0
    MOV  X11, X2
    ST1 { V24.2D, V25.2D }, [X11], #32
    MOV  X11, X2
    LD1 { V13.2D, V14.2D }, [X11], #32
    ADD  X2, X2, X4, LSR #0
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X3
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X5
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X6
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X7
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X8
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X9
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X14
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X16
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X17
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X23
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X25
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X26
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X28
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MOVZ  X24, #0xa5a5, LSL #0
    MOVK  X24, #0xa5a5, LSL #16
    MOVK  X24, #0xa5a5, LSL #32
    MOVK  X24, #0xa5a5, LSL #48
    SUB  X13, X24, X29
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    MRS  X24, FPSR
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V0.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D0
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V1.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D1
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V2.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D2
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V3.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D3
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V4.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D4
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V5.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D5
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V6.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D6
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V7.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D7
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V8.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D8
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V9.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D9
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V10.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D10
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V11.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D11
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V12.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D12
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V13.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D13
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V14.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D14
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V15.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D15
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V16.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D16
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V17.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D17
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V18.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D18
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V19.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D19
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V20.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D20
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V21.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D21
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V22.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D22
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V23.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D23
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V24.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D24
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V25.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D25
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V26.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D26
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V27.D[1]
    MOVZ  X13, #0x0, LSL #0
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D27
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V28.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D28
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V29.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D29
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V30.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D30
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, V31.D[1]
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X24, D31
    MOVZ  X13, #0xa5a5, LSL #0
    MOVK  X13, #0xa5a5, LSL #16
    MOVK  X13, #0xa5a5, LSL #32
    MOVK  X13, #0xa5a5, LSL #48
    SUB  X12, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D1, X28
    FMOV  V1.D[1], X27
    FMOV  D2, X12
    FMOV  V2.D[1], X29
    FMOV  D3, X24
    FMOV  V3.D[1], X26
    FMOV  D4, X8
    FMOV  V4.D[1], X14
    FMOV  D5, X25
    FMOV  V5.D[1], X25
    FMOV  D6, X5
    FMOV  V6.D[1], X11
    FMOV  D7, X27
    FMOV  V7.D[1], X25
    FMOV  D8, X11
    FMOV  V8.D[1], X4
    FMOV  D9, X25
    FMOV  V9.D[1], X28
    FMOV  D10, X23
    FMOV  V10.D[1], X24
    FMOV  D11, X7
    FMOV  V11.D[1], X9
    FMOV  D12, X12
    FMOV  V12.D[1], X13
    FMOV  D13, X12
    FMOV  V13.D[1], X7
    FMOV  D14, X7
    FMOV  V14.D[1], X9
    FMOV  D15, X29
    FMOV  V15.D[1], X14
    FMOV  D16, X16
    FMOV  V16.D[1], X23
    FMOV  D17, X24
    FMOV  V17.D[1], X9
    FMOV  D18, X11
    FMOV  V18.D[1], X28
    FMOV  D19, X4
    FMOV  V19.D[1], X10
    FMOV  D20, X15
    FMOV  V20.D[1], X16
    FMOV  D21, X15
    FMOV  V21.D[1], X12
    FMOV  D22, X3
    FMOV  V22.D[1], X25
    FMOV  D23, X28
    FMOV  V23.D[1], X11
    FMOV  D24, X10
    FMOV  V24.D[1], X17
    FMOV  D25, X7
    FMOV  V25.D[1], X29
    FMOV  D26, X6
    FMOV  V26.D[1], X23
    FMOV  D27, X12
    FMOV  V27.D[1], X4
    FMOV  D28, X28
    FMOV  V28.D[1], X16
    FMOV  D29, X25
    FMOV  V29.D[1], X15
    FMOV  D30, X13
    FMOV  V30.D[1], X29
    FMOV  D31, X28
    FMOV  V31.D[1], X24
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X15, #0x40, LSL #0
    MOVZ  X16, #0x0, LSL #0
    ADD  X3, X30, X16, ASR #0
    ST1 { V29.4S }, [X3], X24
    LD1 { V18.4S }, [X3], X24
    ADD  X3, X3, X15, ASR #0
    ST1 { V31.16B }, [X3], X24
    LD1 { V27.16B }, [X3], X24
    ADD  X3, X3, X15, ASR #0
    ST1 { V25.2D }, [X3], X24
    LD1 { V25.2D }, [X3], X24
    ADD  X3, X3, X15
    ST1 { V18.4S }, [X3], X24
    LD1 { V21.4S }, [X3], X24
    ADD  X3, X3, X15, ASR #0
    ST1 { V21.8H }, [X3], X24
    LD1 { V3.8H }, [X3], X24
    ADD  X3, X3, X15, LSR #0
    ST1 { V18.1D }, [X3], X24
    LD1 { V3.2S }, [X3], X24
    ADD  X3, X3, X15
    ST1 { V8.1D }, [X3], X24
    LD1 { V20.1D }, [X3], X24
    ADD  X3, X3, X15, LSR #0
    ST1 { V23.2S }, [X3], X24
    LD1 { V21.2S }, [X3], X24
    ADD  X3, X3, X15
    ST1 { V3.4H }, [X3], X24
    LD1 { V2.4H }, [X3], X24
    ADD  X3, X3, X15, LSR #0
    ST1 { V16.8B }, [X3], X24
    LD1 { V22.8B }, [X3], X24
    ADD  X3, X3, X15
    MOV  X17, X3
    ST1 { V24.8H, V25.8H, V26.8H }, [X17], #48
    MOV  X17, X3
    LD1 { V16.8H, V17.8H, V18.8H }, [X17], #48
    ADD  X3, X3, X15
    MOV  X17, X3
    ST1 { V16.16B, V17.16B, V18.16B }, [X17], #48
    MOV  X17, X3
    LD1 { V10.16B, V11.16B, V12.16B }, [X17], #48
    ADD  X3, X3, X15, LSR #0
    MOV  X17, X3
    ST1 { V10.2D, V11.2D, V12.2D }, [X17], #48
    MOV  X17, X3
    LD1 { V2.2D, V3.2D, V4.2D }, [X17], #48
    ADD  X3, X3, X15, LSR #0
    MOV  X17, X3
    ST1 { V10.4S, V11.4S, V12.4S }, [X17], #48
    MOV  X17, X3
    LD1 { V17.4S, V18.4S, V19.4S }, [X17], #48
    ADD  X3, X3, X15, ASR #0
    MOV  X17, X3
    ST1 { V17.8H, V18.8H, V19.8H }, [X17], #48
    MOV  X17, X3
    LD1 { V3.8H, V4.8H, V5.8H }, [X17], #48
    ADD  X3, X3, X15
    MOV  X17, X3
    ST1 { V2.4H, V3.4H, V4.4H }, [X17], #24
    MOV  X17, X3
    LD1 { V19.2S, V20.2S, V21.2S }, [X17], #24
    ADD  X3, X3, X15, ASR #0
    MOV  X17, X3
    ST1 { V19.1D, V20.1D, V21.1D }, [X17], #24
    MOV  X17, X3
    LD1 { V10.1D, V11.1D, V12.1D }, [X17], #24
    ADD  X3, X3, X15, LSR #0
    MOV  X17, X3
    ST1 { V29.2S, V30.2S, V31.2S }, [X17], #24
    MOV  X17, X3
    LD1 { V3.2S, V4.2S, V5.2S }, [X17], #24
    ADD  X3, X3, X15
    MOV  X17, X3
    ST1 { V21.4H, V22.4H, V23.4H }, [X17], #24
    MOV  X17, X3
    LD1 { V19.4H, V20.4H, V21.4H }, [X17], #24
    ADD  X3, X3, X15, ASR #0
    MOV  X17, X3
    ST1 { V3.8B, V4.8B, V5.8B }, [X17], #24
    MOV  X17, X3
    LD1 { V12.8B, V13.8B, V14.8B }, [X17], #24
    ADD  X3, X3, X15
    ST1 { V16.2D, V17.2D, V18.2D }, [X3], X24
    LD1 { V3.2D, V4.2D, V5.2D }, [X3], X24
    ADD  X3, X3, X15
    ST1 { V10.16B, V11.16B, V12.16B }, [X3], X24
    LD1 { V14.16B, V15.16B, V16.16B }, [X3], X24
    ADD  X3, X3, X15, ASR #0
    ST1 { V3.2D, V4.2D, V5.2D }, [X3], X24
    LD1 { V3.2D, V4.2D, V5.2D }, [X3], X24
    ADD  X3, X3, X15, LSR #0
    ST1 { V3.4S, V4.4S, V5.4S }, [X3], X24
    LD1 { V26.4S, V27.4S, V28.4S }, [X3], X24
    ADD  X3, X3, X15, LSR #0
    ST1 { V2.8H, V3.8H, V4.8H }, [X3], X24
    LD1 { V20.8H, V21.8H, V22.8H }, [X3], X24
    ADD  X3, X3, X15, ASR #0
    ST1 { V30.1D, V31.1D, V0.1D }, [X3], X24
    LD1 { V30.8B, V31.8B, V0.8B }, [X3], X24
    ADD  X3, X3, X15, ASR #0
    ST1 { V0.1D, V1.1D, V2.1D }, [X3], X24
    LD1 { V0.1D, V1.1D, V2.1D }, [X3], X24
    ADD  X3, X3, X15, LSR #0
    ST1 { V2.2S, V3.2S, V4.2S }, [X3], X24
    LD1 { V31.2S, V0.2S, V1.2S }, [X3], X24
    ADD  X3, X3, X15
    ST1 { V31.4H, V0.4H, V1.4H }, [X3], X24
    LD1 { V31.4H, V0.4H, V1.4H }, [X3], X24
    ADD  X3, X3, X15, LSR #0
    ST1 { V31.8B, V0.8B, V1.8B }, [X3], X24
    LD1 { V8.8B, V9.8B, V10.8B }, [X3], X24
    ADD  X3, X3, X15
    MOV  X17, X3
    ST1 { V4.8H, V5.8H }, [X17], #32
    MOV  X17, X3
    LD1 { V1.4S, V2.4S }, [X17], #32
    ADD  X3, X3, X15, LSR #0
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X4
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X5
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X6
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X7
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X8
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X9
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X10
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X12
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X14
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X23
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X25
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X26
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X27
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X28
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MOVZ  X11, #0x5a5a, LSL #0
    MOVK  X11, #0x5a5a, LSL #16
    MOVK  X11, #0x5a5a, LSL #32
    MOVK  X11, #0x5a5a, LSL #48
    SUB  X2, X11, X29
    ADD  X1, X1, #0x1
    CBNZ  X2, AdvsimdLoadStoreP03_TestFail
    MRS  X11, FPSR
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V0.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D0
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V1.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D1
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V2.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D2
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V3.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D3
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V4.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D4
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V5.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D5
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V6.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D6
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V7.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D7
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V8.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D8
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V9.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D9
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V10.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D10
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V11.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D11
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V12.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D12
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V13.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D13
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V14.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D14
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V15.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D15
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V16.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D16
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V17.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D17
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V18.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D18
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V19.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D19
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V20.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D20
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V21.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D21
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V22.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D22
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V23.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D23
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V24.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D24
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V25.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D25
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V26.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D26
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V27.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D27
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V28.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D28
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V29.D[1]
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D29
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V30.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D30
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, V31.D[1]
    MOVZ  X2, #0x0, LSL #0
    SUB  X13, X2, X11
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X11, D31
    MOVZ  X2, #0x5a5a, LSL #0
    MOVK  X2, #0x5a5a, LSL #16
    MOVK  X2, #0x5a5a, LSL #32
    MOVK  X2, #0x5a5a, LSL #48
    SUB  X13, X2, X11
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
    FMOV  V0.D[1], X27
    FMOV  D1, X26
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X7
    FMOV  D3, X3
    FMOV  V3.D[1], X26
    FMOV  D4, X8
    FMOV  V4.D[1], X25
    FMOV  D5, X28
    FMOV  V5.D[1], X7
    FMOV  D6, X6
    FMOV  V6.D[1], X27
    FMOV  D7, X28
    FMOV  V7.D[1], X25
    FMOV  D8, X10
    FMOV  V8.D[1], X4
    FMOV  D9, X15
    FMOV  V9.D[1], X2
    FMOV  D10, X8
    FMOV  V10.D[1], X3
    FMOV  D11, X28
    FMOV  V11.D[1], X4
    FMOV  D12, X5
    FMOV  V12.D[1], X27
    FMOV  D13, X7
    FMOV  V13.D[1], X10
    FMOV  D14, X23
    FMOV  V14.D[1], X12
    FMOV  D15, X7
    FMOV  V15.D[1], X10
    FMOV  D16, X12
    FMOV  V16.D[1], X26
    FMOV  D17, X23
    FMOV  V17.D[1], X9
    FMOV  D18, X27
    FMOV  V18.D[1], X17
    FMOV  D19, X24
    FMOV  V19.D[1], X5
    FMOV  D20, X12
    FMOV  V20.D[1], X13
    FMOV  D21, X28
    FMOV  V21.D[1], X4
    FMOV  D22, X25
    FMOV  V22.D[1], X5
    FMOV  D23, X26
    FMOV  V23.D[1], X4
    FMOV  D24, X14
    FMOV  V24.D[1], X17
    FMOV  D25, X10
    FMOV  V25.D[1], X16
    FMOV  D26, X2
    FMOV  V26.D[1], X16
    FMOV  D27, X5
    FMOV  V27.D[1], X23
    FMOV  D28, X2
    FMOV  V28.D[1], X17
    FMOV  D29, X17
    FMOV  V29.D[1], X27
    FMOV  D30, X9
    FMOV  V30.D[1], X7
    FMOV  D31, X11
    FMOV  V31.D[1], X11
    MOVZ  X9, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X16, #0x500, LSL #0
    ADD  X27, X30, X16, LSR #0
    ST1 { V24.2D }, [X27], X9
    LD1 { V27.16B }, [X27], X9
    ADD  X27, X27, X2, LSR #0
    ST1 { V25.16B }, [X27], X9
    LD1 { V12.16B }, [X27], X9
    ADD  X27, X27, X2
    ST1 { V7.2D }, [X27], X9
    LD1 { V25.2D }, [X27], X9
    ADD  X27, X27, X2
    ST1 { V25.4S }, [X27], X9
    LD1 { V18.4S }, [X27], X9
    ADD  X27, X27, X2, LSR #0
    ST1 { V9.8H }, [X27], X9
    LD1 { V9.8H }, [X27], X9
    ADD  X27, X27, X2
    ST1 { V1.2S }, [X27], X9
    LD1 { V26.8B }, [X27], X9
    ADD  X27, X27, X2, ASR #0
    ST1 { V22.1D }, [X27], X9
    LD1 { V5.1D }, [X27], X9
    ADD  X27, X27, X2, ASR #0
    ST1 { V18.2S }, [X27], X9
    LD1 { V5.2S }, [X27], X9
    ADD  X27, X27, X2
    ST1 { V5.4H }, [X27], X9
    LD1 { V12.4H }, [X27], X9
    ADD  X27, X27, X2, ASR #0
    ST1 { V27.8B }, [X27], X9
    LD1 { V22.8B }, [X27], X9
    ADD  X27, X27, X2, LSR #0
    MOV  X14, X27
    ST1 { V30.4S, V31.4S, V0.4S }, [X14], #48
    MOV  X14, X27
    LD1 { V24.4S, V25.4S, V26.4S }, [X14], #48
    ADD  X27, X27, X2, ASR #0
    MOV  X14, X27
    ST1 { V20.16B, V21.16B, V22.16B }, [X14], #48
    MOV  X14, X27
    LD1 { V11.16B, V12.16B, V13.16B }, [X14], #48
    ADD  X27, X27, X2, LSR #0
    MOV  X14, X27
    ST1 { V11.2D, V12.2D, V13.2D }, [X14], #48
    MOV  X14, X27
    LD1 { V3.2D, V4.2D, V5.2D }, [X14], #48
    ADD  X27, X27, X2, ASR #0
    MOV  X14, X27
    ST1 { V3.4S, V4.4S, V5.4S }, [X14], #48
    MOV  X14, X27
    LD1 { V6.4S, V7.4S, V8.4S }, [X14], #48
    ADD  X27, X27, X2
    MOV  X14, X27
    ST1 { V6.8H, V7.8H, V8.8H }, [X14], #48
    MOV  X14, X27
    LD1 { V0.8H, V1.8H, V2.8H }, [X14], #48
    ADD  X27, X27, X2, ASR #0
    MOV  X14, X27
    ST1 { V14.1D, V15.1D, V16.1D }, [X14], #24
    MOV  X14, X27
    LD1 { V11.2S, V12.2S, V13.2S }, [X14], #24
    ADD  X27, X27, X2, LSR #0
    MOV  X14, X27
    ST1 { V15.1D, V16.1D, V17.1D }, [X14], #24
    MOV  X14, X27
    LD1 { V5.1D, V6.1D, V7.1D }, [X14], #24
    ADD  X27, X27, X2
    MOV  X14, X27
    ST1 { V14.2S, V15.2S, V16.2S }, [X14], #24
    MOV  X14, X27
    LD1 { V7.2S, V8.2S, V9.2S }, [X14], #24
    ADD  X27, X27, X2, LSR #0
    MOV  X14, X27
    ST1 { V0.4H, V1.4H, V2.4H }, [X14], #24
    MOV  X14, X27
    LD1 { V0.4H, V1.4H, V2.4H }, [X14], #24
    ADD  X27, X27, X2, LSR #0
    MOV  X14, X27
    ST1 { V7.8B, V8.8B, V9.8B }, [X14], #24
    MOV  X14, X27
    LD1 { V14.8B, V15.8B, V16.8B }, [X14], #24
    ADD  X27, X27, X2, LSR #0
    ST1 { V0.4S, V1.4S, V2.4S }, [X27], X9
    LD1 { V22.4S, V23.4S, V24.4S }, [X27], X9
    ADD  X27, X27, X2, LSR #0
    ST1 { V14.16B, V15.16B, V16.16B }, [X27], X9
    LD1 { V28.16B, V29.16B, V30.16B }, [X27], X9
    ADD  X27, X27, X2, ASR #0
    ST1 { V22.2D, V23.2D, V24.2D }, [X27], X9
    LD1 { V23.2D, V24.2D, V25.2D }, [X27], X9
    ADD  X27, X27, X2
    ST1 { V15.4S, V16.4S, V17.4S }, [X27], X9
    LD1 { V16.4S, V17.4S, V18.4S }, [X27], X9
    ADD  X27, X27, X2, LSR #0
    ST1 { V23.8H, V24.8H, V25.8H }, [X27], X9
    LD1 { V5.8H, V6.8H, V7.8H }, [X27], X9
    ADD  X27, X27, X2
    ST1 { V16.8B, V17.8B, V18.8B }, [X27], X9
    LD1 { V11.2S, V12.2S, V13.2S }, [X27], X9
    ADD  X27, X27, X2, ASR #0
    ST1 { V11.1D, V12.1D, V13.1D }, [X27], X9
    LD1 { V23.1D, V24.1D, V25.1D }, [X27], X9
    ADD  X27, X27, X2, LSR #0
    ST1 { V1.2S, V2.2S, V3.2S }, [X27], X9
    LD1 { V11.2S, V12.2S, V13.2S }, [X27], X9
    ADD  X27, X27, X2, ASR #0
    ST1 { V2.4H, V3.4H, V4.4H }, [X27], X9
    LD1 { V21.4H, V22.4H, V23.4H }, [X27], X9
    ADD  X27, X27, X2, LSR #0
    ST1 { V23.8B, V24.8B, V25.8B }, [X27], X9
    LD1 { V13.8B, V14.8B, V15.8B }, [X27], X9
    ADD  X27, X27, X2
    MOV  X14, X27
    ST1 { V21.8H, V22.8H }, [X14], #32
    MOV  X14, X27
    LD1 { V23.2D, V24.2D }, [X14], #32
    ADD  X27, X27, X2, LSR #0
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X10
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X23
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X25
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X17, #0xa5a5, LSL #0
    MOVK  X17, #0xa5a5, LSL #16
    MOVK  X17, #0xa5a5, LSL #32
    MOVK  X17, #0xa5a5, LSL #48
    SUB  X5, X17, X29
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MRS  X17, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D0
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D1
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D2
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V3.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D3
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V4.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D4
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D5
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V6.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D6
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V7.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D7
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D8
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V9.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D9
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V10.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D10
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V11.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D11
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V12.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D12
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D13
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D14
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D15
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D16
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V17.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D17
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V18.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D18
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V19.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D19
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V20.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D20
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V21.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D21
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V22.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D22
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D23
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V24.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D24
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D25
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V26.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D26
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V27.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D27
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V28.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D28
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V29.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D29
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D30
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, V31.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    FMOV  X17, D31
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X6, X5, X17
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
    FMOV  D1, X25
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X13
    FMOV  D3, X25
    FMOV  V3.D[1], X2
    FMOV  D4, X23
    FMOV  V4.D[1], X3
    FMOV  D5, X25
    FMOV  V5.D[1], X24
    FMOV  D6, X6
    FMOV  V6.D[1], X29
    FMOV  D7, X3
    FMOV  V7.D[1], X17
    FMOV  D8, X5
    FMOV  V8.D[1], X9
    FMOV  D9, X9
    FMOV  V9.D[1], X29
    FMOV  D10, X5
    FMOV  V10.D[1], X5
    FMOV  D11, X25
    FMOV  V11.D[1], X4
    FMOV  D12, X7
    FMOV  V12.D[1], X28
    FMOV  D13, X9
    FMOV  V13.D[1], X3
    FMOV  D14, X27
    FMOV  V14.D[1], X8
    FMOV  D15, X11
    FMOV  V15.D[1], X24
    FMOV  D16, X16
    FMOV  V16.D[1], X8
    FMOV  D17, X16
    FMOV  V17.D[1], X3
    FMOV  D18, X29
    FMOV  V18.D[1], X29
    FMOV  D19, X29
    FMOV  V19.D[1], X8
    FMOV  D20, X12
    FMOV  V20.D[1], X8
    FMOV  D21, X3
    FMOV  V21.D[1], X8
    FMOV  D22, X3
    FMOV  V22.D[1], X3
    FMOV  D23, X6
    FMOV  V23.D[1], X11
    FMOV  D24, X25
    FMOV  V24.D[1], X2
    FMOV  D25, X8
    FMOV  V25.D[1], X17
    FMOV  D26, X14
    FMOV  V26.D[1], X23
    FMOV  D27, X9
    FMOV  V27.D[1], X5
    FMOV  D28, X4
    FMOV  V28.D[1], X4
    FMOV  D29, X8
    FMOV  V29.D[1], X2
    FMOV  D30, X9
    FMOV  V30.D[1], X8
    FMOV  D31, X8
    FMOV  V31.D[1], X7
    MOVZ  X4, #0x0, LSL #0
    MOVZ  X28, #0x40, LSL #0
    MOVZ  X23, #0xa00, LSL #0
    ADD  X7, X30, X23, ASR #0
    ST1 { V28.8H }, [X7], X4
    LD1 { V20.4S }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V30.16B }, [X7], X4
    LD1 { V21.16B }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V21.2D }, [X7], X4
    LD1 { V24.2D }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V31.4S }, [X7], X4
    LD1 { V26.4S }, [X7], X4
    ADD  X7, X7, X28
    ST1 { V26.8H }, [X7], X4
    LD1 { V19.8H }, [X7], X4
    ADD  X7, X7, X28
    ST1 { V20.4H }, [X7], X4
    LD1 { V8.2S }, [X7], X4
    ADD  X7, X7, X28, LSR #0
    ST1 { V24.1D }, [X7], X4
    LD1 { V14.1D }, [X7], X4
    ADD  X7, X7, X28, LSR #0
    ST1 { V19.2S }, [X7], X4
    LD1 { V18.2S }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V19.4H }, [X7], X4
    LD1 { V4.4H }, [X7], X4
    ADD  X7, X7, X28, LSR #0
    ST1 { V5.8B }, [X7], X4
    LD1 { V22.8B }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    MOV  X14, X7
    ST1 { V6.8H, V7.8H, V8.8H }, [X14], #48
    MOV  X14, X7
    LD1 { V0.8H, V1.8H, V2.8H }, [X14], #48
    ADD  X7, X7, X28, LSR #0
    MOV  X14, X7
    ST1 { V0.16B, V1.16B, V2.16B }, [X14], #48
    MOV  X14, X7
    LD1 { V11.16B, V12.16B, V13.16B }, [X14], #48
    ADD  X7, X7, X28
    MOV  X14, X7
    ST1 { V11.2D, V12.2D, V13.2D }, [X14], #48
    MOV  X14, X7
    LD1 { V25.2D, V26.2D, V27.2D }, [X14], #48
    ADD  X7, X7, X28, ASR #0
    MOV  X14, X7
    ST1 { V30.4S, V31.4S, V0.4S }, [X14], #48
    MOV  X14, X7
    LD1 { V6.4S, V7.4S, V8.4S }, [X14], #48
    ADD  X7, X7, X28
    MOV  X14, X7
    ST1 { V4.8H, V5.8H, V6.8H }, [X14], #48
    MOV  X14, X7
    LD1 { V30.8H, V31.8H, V0.8H }, [X14], #48
    ADD  X7, X7, X28, ASR #0
    MOV  X14, X7
    ST1 { V14.4H, V15.4H, V16.4H }, [X14], #24
    MOV  X14, X7
    LD1 { V12.8B, V13.8B, V14.8B }, [X14], #24
    ADD  X7, X7, X28
    MOV  X14, X7
    ST1 { V4.1D, V5.1D, V6.1D }, [X14], #24
    MOV  X14, X7
    LD1 { V4.1D, V5.1D, V6.1D }, [X14], #24
    ADD  X7, X7, X28
    MOV  X14, X7
    ST1 { V12.2S, V13.2S, V14.2S }, [X14], #24
    MOV  X14, X7
    LD1 { V12.2S, V13.2S, V14.2S }, [X14], #24
    ADD  X7, X7, X28, LSR #0
    MOV  X14, X7
    ST1 { V12.4H, V13.4H, V14.4H }, [X14], #24
    MOV  X14, X7
    LD1 { V7.4H, V8.4H, V9.4H }, [X14], #24
    ADD  X7, X7, X28, ASR #0
    MOV  X14, X7
    ST1 { V5.8B, V6.8B, V7.8B }, [X14], #24
    MOV  X14, X7
    LD1 { V5.8B, V6.8B, V7.8B }, [X14], #24
    ADD  X7, X7, X28, LSR #0
    ST1 { V15.8H, V16.8H, V17.8H }, [X7], X4
    LD1 { V15.8H, V16.8H, V17.8H }, [X7], X4
    ADD  X7, X7, X28
    ST1 { V5.16B, V6.16B, V7.16B }, [X7], X4
    LD1 { V12.16B, V13.16B, V14.16B }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V17.2D, V18.2D, V19.2D }, [X7], X4
    LD1 { V2.2D, V3.2D, V4.2D }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V4.4S, V5.4S, V6.4S }, [X7], X4
    LD1 { V4.4S, V5.4S, V6.4S }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V5.8H, V6.8H, V7.8H }, [X7], X4
    LD1 { V20.8H, V21.8H, V22.8H }, [X7], X4
    ADD  X7, X7, X28
    ST1 { V2.1D, V3.1D, V4.1D }, [X7], X4
    LD1 { V4.1D, V5.1D, V6.1D }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V14.1D, V15.1D, V16.1D }, [X7], X4
    LD1 { V17.1D, V18.1D, V19.1D }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V24.2S, V25.2S, V26.2S }, [X7], X4
    LD1 { V27.2S, V28.2S, V29.2S }, [X7], X4
    ADD  X7, X7, X28, ASR #0
    ST1 { V19.4H, V20.4H, V21.4H }, [X7], X4
    LD1 { V14.4H, V15.4H, V16.4H }, [X7], X4
    ADD  X7, X7, X28, LSR #0
    ST1 { V15.8B, V16.8B, V17.8B }, [X7], X4
    LD1 { V15.8B, V16.8B, V17.8B }, [X7], X4
    ADD  X7, X7, X28
    MOV  X14, X7
    ST1 { V4.8H, V5.8H }, [X14], #32
    MOV  X14, X7
    LD1 { V28.16B, V29.16B }, [X14], #32
    ADD  X7, X7, X28
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X2
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X3
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X5
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X6
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X9
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X10
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X11
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X12
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X15
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X16
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X24
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X25
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X27
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X26, X8, X29
    ADD  X1, X1, #0x1
    CBNZ  X26, AdvsimdLoadStoreP03_TestFail
    MRS  X8, FPSR
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V0.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D0
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V1.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D1
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V2.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D2
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V3.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D3
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V4.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D4
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V5.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D5
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V6.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D6
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V7.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D7
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V8.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D8
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V9.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D9
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V10.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D10
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V11.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D11
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V12.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D12
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V13.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D13
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V14.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D14
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V15.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D15
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V16.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D16
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V17.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D17
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V18.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D18
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V19.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D19
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V20.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D20
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V21.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D21
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V22.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D22
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V23.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D23
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V24.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D24
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V25.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D25
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V26.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D26
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V27.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D27
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V28.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D28
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V29.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D29
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V30.D[1]
    MOVZ  X26, #0x0, LSL #0
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D30
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, V31.D[1]
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
    ADD  X1, X1, #0x1
    CBNZ  X17, AdvsimdLoadStoreP03_TestFail
    FMOV  X8, D31
    MOVZ  X26, #0x5a5a, LSL #0
    MOVK  X26, #0x5a5a, LSL #16
    MOVK  X26, #0x5a5a, LSL #32
    MOVK  X26, #0x5a5a, LSL #48
    SUB  X17, X26, X8
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
    FMOV  D1, X27
    FMOV  V1.D[1], X29
    FMOV  D2, X28
    FMOV  V2.D[1], X25
    FMOV  D3, X26
    FMOV  V3.D[1], X6
    FMOV  D4, X25
    FMOV  V4.D[1], X9
    FMOV  D5, X12
    FMOV  V5.D[1], X13
    FMOV  D6, X15
    FMOV  V6.D[1], X12
    FMOV  D7, X7
    FMOV  V7.D[1], X5
    FMOV  D8, X10
    FMOV  V8.D[1], X28
    FMOV  D9, X3
    FMOV  V9.D[1], X15
    FMOV  D10, X6
    FMOV  V10.D[1], X4
    FMOV  D11, X23
    FMOV  V11.D[1], X10
    FMOV  D12, X28
    FMOV  V12.D[1], X11
    FMOV  D13, X10
    FMOV  V13.D[1], X13
    FMOV  D14, X24
    FMOV  V14.D[1], X16
    FMOV  D15, X3
    FMOV  V15.D[1], X9
    FMOV  D16, X26
    FMOV  V16.D[1], X12
    FMOV  D17, X24
    FMOV  V17.D[1], X17
    FMOV  D18, X27
    FMOV  V18.D[1], X25
    FMOV  D19, X26
    FMOV  V19.D[1], X27
    FMOV  D20, X25
    FMOV  V20.D[1], X14
    FMOV  D21, X17
    FMOV  V21.D[1], X6
    FMOV  D22, X14
    FMOV  V22.D[1], X2
    FMOV  D23, X2
    FMOV  V23.D[1], X16
    FMOV  D24, X7
    FMOV  V24.D[1], X8
    FMOV  D25, X26
    FMOV  V25.D[1], X7
    FMOV  D26, X5
    FMOV  V26.D[1], X6
    FMOV  D27, X26
    FMOV  V27.D[1], X3
    FMOV  D28, X28
    FMOV  V28.D[1], X3
    FMOV  D29, X9
    FMOV  V29.D[1], X27
    FMOV  D30, X15
    FMOV  V30.D[1], X24
    FMOV  D31, X25
    FMOV  V31.D[1], X25
    MOVZ  X23, #0x0, LSL #0
    MOVZ  X16, #0x40, LSL #0
    MOVZ  X25, #0xf00, LSL #0
    ADD  X2, X30, X25, ASR #0
    ST1 { V26.2D }, [X2], X23
    LD1 { V20.4S }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V0.16B }, [X2], X23
    LD1 { V27.16B }, [X2], X23
    ADD  X2, X2, X16, ASR #0
    ST1 { V21.2D }, [X2], X23
    LD1 { V8.2D }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V28.4S }, [X2], X23
    LD1 { V13.4S }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V27.8H }, [X2], X23
    LD1 { V25.8H }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V30.8B }, [X2], X23
    LD1 { V24.2S }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V12.1D }, [X2], X23
    LD1 { V12.1D }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V25.2S }, [X2], X23
    LD1 { V12.2S }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V24.4H }, [X2], X23
    LD1 { V6.4H }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V8.8B }, [X2], X23
    LD1 { V30.8B }, [X2], X23
    ADD  X2, X2, X16, LSR #0
    MOV  X29, X2
    ST1 { V0.16B, V1.16B, V2.16B }, [X29], #48
    MOV  X29, X2
    LD1 { V10.4S, V11.4S, V12.4S }, [X29], #48
    ADD  X2, X2, X16, ASR #0
    MOV  X29, X2
    ST1 { V12.16B, V13.16B, V14.16B }, [X29], #48
    MOV  X29, X2
    LD1 { V6.16B, V7.16B, V8.16B }, [X29], #48
    ADD  X2, X2, X16
    MOV  X29, X2
    ST1 { V6.2D, V7.2D, V8.2D }, [X29], #48
    MOV  X29, X2
    LD1 { V10.2D, V11.2D, V12.2D }, [X29], #48
    ADD  X2, X2, X16, ASR #0
    MOV  X29, X2
    ST1 { V29.4S, V30.4S, V31.4S }, [X29], #48
    MOV  X29, X2
    LD1 { V31.4S, V0.4S, V1.4S }, [X29], #48
    ADD  X2, X2, X16
    MOV  X29, X2
    ST1 { V10.8H, V11.8H, V12.8H }, [X29], #48
    MOV  X29, X2
    LD1 { V16.8H, V17.8H, V18.8H }, [X29], #48
    ADD  X2, X2, X16, LSR #0
    MOV  X29, X2
    ST1 { V16.8B, V17.8B, V18.8B }, [X29], #24
    MOV  X29, X2
    LD1 { V25.4H, V26.4H, V27.4H }, [X29], #24
    ADD  X2, X2, X16, LSR #0
    MOV  X29, X2
    ST1 { V31.1D, V0.1D, V1.1D }, [X29], #24
    MOV  X29, X2
    LD1 { V16.1D, V17.1D, V18.1D }, [X29], #24
    ADD  X2, X2, X16, LSR #0
    MOV  X29, X2
    ST1 { V25.2S, V26.2S, V27.2S }, [X29], #24
    MOV  X29, X2
    LD1 { V31.2S, V0.2S, V1.2S }, [X29], #24
    ADD  X2, X2, X16, LSR #0
    MOV  X29, X2
    ST1 { V23.4H, V24.4H, V25.4H }, [X29], #24
    MOV  X29, X2
    LD1 { V14.4H, V15.4H, V16.4H }, [X29], #24
    ADD  X2, X2, X16, LSR #0
    MOV  X29, X2
    ST1 { V16.8B, V17.8B, V18.8B }, [X29], #24
    MOV  X29, X2
    LD1 { V23.8B, V24.8B, V25.8B }, [X29], #24
    ADD  X2, X2, X16
    ST1 { V7.2D, V8.2D, V9.2D }, [X2], X23
    LD1 { V16.16B, V17.16B, V18.16B }, [X2], X23
    ADD  X2, X2, X16, LSR #0
    ST1 { V14.16B, V15.16B, V16.16B }, [X2], X23
    LD1 { V7.16B, V8.16B, V9.16B }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V6.2D, V7.2D, V8.2D }, [X2], X23
    LD1 { V14.2D, V15.2D, V16.2D }, [X2], X23
    ADD  X2, X2, X16, LSR #0
    ST1 { V31.4S, V0.4S, V1.4S }, [X2], X23
    LD1 { V31.4S, V0.4S, V1.4S }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V13.8H, V14.8H, V15.8H }, [X2], X23
    LD1 { V6.8H, V7.8H, V8.8H }, [X2], X23
    ADD  X2, X2, X16, LSR #0
    ST1 { V23.2S, V24.2S, V25.2S }, [X2], X23
    LD1 { V3.1D, V4.1D, V5.1D }, [X2], X23
    ADD  X2, X2, X16, LSR #0
    ST1 { V9.1D, V10.1D, V11.1D }, [X2], X23
    LD1 { V23.1D, V24.1D, V25.1D }, [X2], X23
    ADD  X2, X2, X16, ASR #0
    ST1 { V23.2S, V24.2S, V25.2S }, [X2], X23
    LD1 { V23.2S, V24.2S, V25.2S }, [X2], X23
    ADD  X2, X2, X16
    ST1 { V3.4H, V4.4H, V5.4H }, [X2], X23
    LD1 { V13.4H, V14.4H, V15.4H }, [X2], X23
    ADD  X2, X2, X16, LSR #0
    ST1 { V23.8B, V24.8B, V25.8B }, [X2], X23
    LD1 { V1.8B, V2.8B, V3.8B }, [X2], X23
    ADD  X2, X2, X16, LSR #0
    MOV  X29, X2
    ST1 { V16.4S, V17.4S }, [X29], #32
    MOV  X29, X2
    LD1 { V23.4S, V24.4S }, [X29], #32
    ADD  X2, X2, X16, ASR #0
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X3
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X4
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X6
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X7
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X8
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X9
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X11
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X12
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X14
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X15
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X17
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X24
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X26
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X27
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MOVZ  X10, #0xa5a5, LSL #0
    MOVK  X10, #0xa5a5, LSL #16
    MOVK  X10, #0xa5a5, LSL #32
    MOVK  X10, #0xa5a5, LSL #48
    SUB  X5, X10, X28
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    MRS  X10, FPSR
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V0.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D0
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V1.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D1
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V2.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D2
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V3.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D3
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V4.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D4
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V5.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D5
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V6.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D6
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V7.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D7
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V8.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D8
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V9.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D9
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V10.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D10
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V11.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D11
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V12.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D12
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V13.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D13
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V14.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D14
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V15.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D15
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V16.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D16
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V17.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D17
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V18.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D18
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V19.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D19
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V20.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D20
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V21.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D21
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V22.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D22
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V23.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D23
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V24.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D24
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V25.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D25
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V26.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D26
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V27.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D27
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V28.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D28
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V29.D[1]
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D29
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V30.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D30
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, V31.D[1]
    MOVZ  X5, #0x0, LSL #0
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
    FMOV  X10, D31
    MOVZ  X5, #0xa5a5, LSL #0
    MOVK  X5, #0xa5a5, LSL #16
    MOVK  X5, #0xa5a5, LSL #32
    MOVK  X5, #0xa5a5, LSL #48
    SUB  X13, X5, X10
    ADD  X1, X1, #0x1
    CBNZ  X13, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X5
    FMOV  V0.D[1], X29
    FMOV  D1, X6
    FMOV  V1.D[1], X23
    FMOV  D2, X24
    FMOV  V2.D[1], X26
    FMOV  D3, X12
    FMOV  V3.D[1], X28
    FMOV  D4, X17
    FMOV  V4.D[1], X8
    FMOV  D5, X25
    FMOV  V5.D[1], X28
    FMOV  D6, X16
    FMOV  V6.D[1], X9
    FMOV  D7, X10
    FMOV  V7.D[1], X2
    FMOV  D8, X10
    FMOV  V8.D[1], X2
    FMOV  D9, X25
    FMOV  V9.D[1], X23
    FMOV  D10, X28
    FMOV  V10.D[1], X12
    FMOV  D11, X6
    FMOV  V11.D[1], X3
    FMOV  D12, X5
    FMOV  V12.D[1], X14
    FMOV  D13, X3
    FMOV  V13.D[1], X26
    FMOV  D14, X23
    FMOV  V14.D[1], X27
    FMOV  D15, X11
    FMOV  V15.D[1], X3
    FMOV  D16, X5
    FMOV  V16.D[1], X7
    FMOV  D17, X12
    FMOV  V17.D[1], X16
    FMOV  D18, X26
    FMOV  V18.D[1], X24
    FMOV  D19, X12
    FMOV  V19.D[1], X17
    FMOV  D20, X11
    FMOV  V20.D[1], X7
    FMOV  D21, X26
    FMOV  V21.D[1], X29
    FMOV  D22, X6
    FMOV  V22.D[1], X3
    FMOV  D23, X13
    FMOV  V23.D[1], X29
    FMOV  D24, X28
    FMOV  V24.D[1], X29
    FMOV  D25, X26
    FMOV  V25.D[1], X27
    FMOV  D26, X11
    FMOV  V26.D[1], X28
    FMOV  D27, X29
    FMOV  V27.D[1], X15
    FMOV  D28, X7
    FMOV  V28.D[1], X14
    FMOV  D29, X6
    FMOV  V29.D[1], X9
    FMOV  D30, X11
    FMOV  V30.D[1], X13
    FMOV  D31, X4
    FMOV  V31.D[1], X16
    MOVZ  X29, #0x0, LSL #0
    MOVZ  X8, #0x40, LSL #0
    MOVZ  X16, #0x1400, LSL #0
    ADD  X17, X30, X16
    ST1 { V31.16B }, [X17], X29
    LD1 { V20.4S }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V20.16B }, [X17], X29
    LD1 { V30.16B }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V31.2D }, [X17], X29
    LD1 { V0.2D }, [X17], X29
    ADD  X17, X17, X8, ASR #0
    ST1 { V18.4S }, [X17], X29
    LD1 { V4.4S }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V4.8H }, [X17], X29
    LD1 { V28.8H }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V9.4H }, [X17], X29
    LD1 { V21.8B }, [X17], X29
    ADD  X17, X17, X8
    ST1 { V10.1D }, [X17], X29
    LD1 { V0.1D }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V30.2S }, [X17], X29
    LD1 { V23.2S }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V9.4H }, [X17], X29
    LD1 { V21.4H }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V11.8B }, [X17], X29
    LD1 { V15.8B }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    MOV  X12, X17
    ST1 { V20.16B, V21.16B, V22.16B }, [X12], #48
    MOV  X12, X17
    LD1 { V24.2D, V25.2D, V26.2D }, [X12], #48
    ADD  X17, X17, X8, ASR #0
    MOV  X12, X17
    ST1 { V24.16B, V25.16B, V26.16B }, [X12], #48
    MOV  X12, X17
    LD1 { V26.16B, V27.16B, V28.16B }, [X12], #48
    ADD  X17, X17, X8, LSR #0
    MOV  X12, X17
    ST1 { V26.2D, V27.2D, V28.2D }, [X12], #48
    MOV  X12, X17
    LD1 { V13.2D, V14.2D, V15.2D }, [X12], #48
    ADD  X17, X17, X8, ASR #0
    MOV  X12, X17
    ST1 { V13.4S, V14.4S, V15.4S }, [X12], #48
    MOV  X12, X17
    LD1 { V25.4S, V26.4S, V27.4S }, [X12], #48
    ADD  X17, X17, X8, ASR #0
    MOV  X12, X17
    ST1 { V21.8H, V22.8H, V23.8H }, [X12], #48
    MOV  X12, X17
    LD1 { V21.8H, V22.8H, V23.8H }, [X12], #48
    ADD  X17, X17, X8
    MOV  X12, X17
    ST1 { V25.1D, V26.1D, V27.1D }, [X12], #24
    MOV  X12, X17
    LD1 { V0.8B, V1.8B, V2.8B }, [X12], #24
    ADD  X17, X17, X8
    MOV  X12, X17
    ST1 { V21.1D, V22.1D, V23.1D }, [X12], #24
    MOV  X12, X17
    LD1 { V13.1D, V14.1D, V15.1D }, [X12], #24
    ADD  X17, X17, X8
    MOV  X12, X17
    ST1 { V13.2S, V14.2S, V15.2S }, [X12], #24
    MOV  X12, X17
    LD1 { V25.2S, V26.2S, V27.2S }, [X12], #24
    ADD  X17, X17, X8
    MOV  X12, X17
    ST1 { V25.4H, V26.4H, V27.4H }, [X12], #24
    MOV  X12, X17
    LD1 { V25.4H, V26.4H, V27.4H }, [X12], #24
    ADD  X17, X17, X8, ASR #0
    MOV  X12, X17
    ST1 { V25.8B, V26.8B, V27.8B }, [X12], #24
    MOV  X12, X17
    LD1 { V25.8B, V26.8B, V27.8B }, [X12], #24
    ADD  X17, X17, X8
    ST1 { V25.2D, V26.2D, V27.2D }, [X17], X29
    LD1 { V24.8H, V25.8H, V26.8H }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V24.16B, V25.16B, V26.16B }, [X17], X29
    LD1 { V21.16B, V22.16B, V23.16B }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V21.2D, V22.2D, V23.2D }, [X17], X29
    LD1 { V16.2D, V17.2D, V18.2D }, [X17], X29
    ADD  X17, X17, X8, ASR #0
    ST1 { V16.4S, V17.4S, V18.4S }, [X17], X29
    LD1 { V16.4S, V17.4S, V18.4S }, [X17], X29
    ADD  X17, X17, X8
    ST1 { V2.8H, V3.8H, V4.8H }, [X17], X29
    LD1 { V22.8H, V23.8H, V24.8H }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V29.2S, V30.2S, V31.2S }, [X17], X29
    LD1 { V25.1D, V26.1D, V27.1D }, [X17], X29
    ADD  X17, X17, X8, ASR #0
    ST1 { V4.1D, V5.1D, V6.1D }, [X17], X29
    LD1 { V2.1D, V3.1D, V4.1D }, [X17], X29
    ADD  X17, X17, X8
    ST1 { V7.2S, V8.2S, V9.2S }, [X17], X29
    LD1 { V6.2S, V7.2S, V8.2S }, [X17], X29
    ADD  X17, X17, X8
    ST1 { V6.4H, V7.4H, V8.4H }, [X17], X29
    LD1 { V31.4H, V0.4H, V1.4H }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    ST1 { V27.8B, V28.8B, V29.8B }, [X17], X29
    LD1 { V5.8B, V6.8B, V7.8B }, [X17], X29
    ADD  X17, X17, X8, LSR #0
    MOV  X12, X17
    ST1 { V5.4S, V6.4S }, [X12], #32
    MOV  X12, X17
    LD1 { V8.2D, V9.2D }, [X12], #32
    ADD  X17, X17, X8
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X2
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X9
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X10
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X24
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X26
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X28, X7, X27
    ADD  X1, X1, #0x1
    CBNZ  X28, AdvsimdLoadStoreP03_TestFail
    MRS  X7, FPSR
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D0
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D1
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D2
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D3
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D4
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D5
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D6
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D7
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D8
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D9
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D10
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D11
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D12
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D13
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D14
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D15
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D16
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D17
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D18
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D19
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D20
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D21
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D22
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D23
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D24
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D25
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D26
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D27
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D28
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D29
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D30
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X28, #0x0, LSL #0
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D31
    MOVZ  X28, #0x5a5a, LSL #0
    MOVK  X28, #0x5a5a, LSL #16
    MOVK  X28, #0x5a5a, LSL #32
    MOVK  X28, #0x5a5a, LSL #48
    SUB  X25, X28, X7
    ADD  X1, X1, #0x1
    CBNZ  X25, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D1, X27
    FMOV  V1.D[1], X26
    FMOV  D2, X28
    FMOV  V2.D[1], X29
    FMOV  D3, X2
    FMOV  V3.D[1], X16
    FMOV  D4, X3
    FMOV  V4.D[1], X15
    FMOV  D5, X26
    FMOV  V5.D[1], X6
    FMOV  D6, X26
    FMOV  V6.D[1], X24
    FMOV  D7, X7
    FMOV  V7.D[1], X12
    FMOV  D8, X26
    FMOV  V8.D[1], X6
    FMOV  D9, X17
    FMOV  V9.D[1], X6
    FMOV  D10, X27
    FMOV  V10.D[1], X26
    FMOV  D11, X16
    FMOV  V11.D[1], X29
    FMOV  D12, X10
    FMOV  V12.D[1], X2
    FMOV  D13, X17
    FMOV  V13.D[1], X8
    FMOV  D14, X13
    FMOV  V14.D[1], X13
    FMOV  D15, X4
    FMOV  V15.D[1], X13
    FMOV  D16, X12
    FMOV  V16.D[1], X9
    FMOV  D17, X25
    FMOV  V17.D[1], X6
    FMOV  D18, X25
    FMOV  V18.D[1], X13
    FMOV  D19, X17
    FMOV  V19.D[1], X17
    FMOV  D20, X9
    FMOV  V20.D[1], X3
    FMOV  D21, X14
    FMOV  V21.D[1], X24
    FMOV  D22, X25
    FMOV  V22.D[1], X24
    FMOV  D23, X9
    FMOV  V23.D[1], X4
    FMOV  D24, X6
    FMOV  V24.D[1], X15
    FMOV  D25, X27
    FMOV  V25.D[1], X6
    FMOV  D26, X27
    FMOV  V26.D[1], X16
    FMOV  D27, X24
    FMOV  V27.D[1], X9
    FMOV  D28, X28
    FMOV  V28.D[1], X24
    FMOV  D29, X7
    FMOV  V29.D[1], X6
    FMOV  D30, X5
    FMOV  V30.D[1], X14
    FMOV  D31, X17
    FMOV  V31.D[1], X29
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X12, #0x40, LSL #0
    MOVZ  X17, #0x1900, LSL #0
    ADD  X10, X30, X17, ASR #0
    ST1 { V27.16B }, [X10], X24
    LD1 { V21.16B }, [X10], X24
    ADD  X10, X10, X12, ASR #0
    ST1 { V29.16B }, [X10], X24
    LD1 { V7.16B }, [X10], X24
    ADD  X10, X10, X12, ASR #0
    ST1 { V21.2D }, [X10], X24
    LD1 { V26.2D }, [X10], X24
    ADD  X10, X10, X12, LSR #0
    ST1 { V31.4S }, [X10], X24
    LD1 { V31.4S }, [X10], X24
    ADD  X10, X10, X12
    ST1 { V4.8H }, [X10], X24
    LD1 { V9.8H }, [X10], X24
    ADD  X10, X10, X12
    ST1 { V26.2S }, [X10], X24
    LD1 { V20.1D }, [X10], X24
    ADD  X10, X10, X12, ASR #0
    ST1 { V25.1D }, [X10], X24
    LD1 { V6.1D }, [X10], X24
    ADD  X10, X10, X12
    ST1 { V19.2S }, [X10], X24
    LD1 { V30.2S }, [X10], X24
    ADD  X10, X10, X12
    ST1 { V30.4H }, [X10], X24
    LD1 { V7.4H }, [X10], X24
    ADD  X10, X10, X12
    ST1 { V27.8B }, [X10], X24
    LD1 { V5.8B }, [X10], X24
    ADD  X10, X10, X12, LSR #0
    MOV  X6, X10
    ST1 { V3.8H, V4.8H, V5.8H }, [X6], #48
    MOV  X6, X10
    LD1 { V18.8H, V19.8H, V20.8H }, [X6], #48
    ADD  X10, X10, X12, ASR #0
    MOV  X6, X10
    ST1 { V5.16B, V6.16B, V7.16B }, [X6], #48
    MOV  X6, X10
    LD1 { V3.16B, V4.16B, V5.16B }, [X6], #48
    ADD  X10, X10, X12, ASR #0
    MOV  X6, X10
    ST1 { V18.2D, V19.2D, V20.2D }, [X6], #48
    MOV  X6, X10
    LD1 { V10.2D, V11.2D, V12.2D }, [X6], #48
    ADD  X10, X10, X12, LSR #0
    MOV  X6, X10
    ST1 { V10.4S, V11.4S, V12.4S }, [X6], #48
    MOV  X6, X10
    LD1 { V8.4S, V9.4S, V10.4S }, [X6], #48
    ADD  X10, X10, X12
    MOV  X6, X10
    ST1 { V30.8H, V31.8H, V0.8H }, [X6], #48
    MOV  X6, X10
    LD1 { V22.8H, V23.8H, V24.8H }, [X6], #48
    ADD  X10, X10, X12, ASR #0
    MOV  X6, X10
    ST1 { V22.4H, V23.4H, V24.4H }, [X6], #24
    MOV  X6, X10
    LD1 { V24.1D, V25.1D, V26.1D }, [X6], #24
    ADD  X10, X10, X12
    MOV  X6, X10
    ST1 { V8.1D, V9.1D, V10.1D }, [X6], #24
    MOV  X6, X10
    LD1 { V30.1D, V31.1D, V0.1D }, [X6], #24
    ADD  X10, X10, X12
    MOV  X6, X10
    ST1 { V14.2S, V15.2S, V16.2S }, [X6], #24
    MOV  X6, X10
    LD1 { V30.2S, V31.2S, V0.2S }, [X6], #24
    ADD  X10, X10, X12, LSR #0
    MOV  X6, X10
    ST1 { V24.4H, V25.4H, V26.4H }, [X6], #24
    MOV  X6, X10
    LD1 { V20.4H, V21.4H, V22.4H }, [X6], #24
    ADD  X10, X10, X12, LSR #0
    MOV  X6, X10
    ST1 { V11.8B, V12.8B, V13.8B }, [X6], #24
    MOV  X6, X10
    LD1 { V31.8B, V0.8B, V1.8B }, [X6], #24
    ADD  X10, X10, X12, ASR #0
    ST1 { V30.2D, V31.2D, V0.2D }, [X10], X24
    LD1 { V14.2D, V15.2D, V16.2D }, [X10], X24
    ADD  X10, X10, X12
    ST1 { V14.16B, V15.16B, V16.16B }, [X10], X24
    LD1 { V13.16B, V14.16B, V15.16B }, [X10], X24
    ADD  X10, X10, X12
    ST1 { V1.2D, V2.2D, V3.2D }, [X10], X24
    LD1 { V1.2D, V2.2D, V3.2D }, [X10], X24
    ADD  X10, X10, X12, ASR #0
    ST1 { V13.4S, V14.4S, V15.4S }, [X10], X24
    LD1 { V31.4S, V0.4S, V1.4S }, [X10], X24
    ADD  X10, X10, X12
    ST1 { V0.8H, V1.8H, V2.8H }, [X10], X24
    LD1 { V0.8H, V1.8H, V2.8H }, [X10], X24
    ADD  X10, X10, X12
    ST1 { V6.4H, V7.4H, V8.4H }, [X10], X24
    LD1 { V6.2S, V7.2S, V8.2S }, [X10], X24
    ADD  X10, X10, X12, ASR #0
    ST1 { V16.1D, V17.1D, V18.1D }, [X10], X24
    LD1 { V26.1D, V27.1D, V28.1D }, [X10], X24
    ADD  X10, X10, X12, ASR #0
    ST1 { V20.2S, V21.2S, V22.2S }, [X10], X24
    LD1 { V9.2S, V10.2S, V11.2S }, [X10], X24
    ADD  X10, X10, X12, ASR #0
    ST1 { V0.4H, V1.4H, V2.4H }, [X10], X24
    LD1 { V14.4H, V15.4H, V16.4H }, [X10], X24
    ADD  X10, X10, X12, ASR #0
    ST1 { V26.8B, V27.8B, V28.8B }, [X10], X24
    LD1 { V16.8B, V17.8B, V18.8B }, [X10], X24
    ADD  X10, X10, X12
    MOV  X6, X10
    ST1 { V30.2D, V31.2D }, [X6], #32
    MOV  X6, X10
    LD1 { V15.16B, V16.16B }, [X6], #32
    ADD  X10, X10, X12
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X2
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X4
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X5
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X8
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X9
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X11
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X13
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X14
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X15
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X16
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X23
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X25
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X26
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X27
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X29, X3, X28
    ADD  X1, X1, #0x1
    CBNZ  X29, AdvsimdLoadStoreP03_TestFail
    MRS  X3, FPSR
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V0.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V1.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D1
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V2.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D2
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V3.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D3
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V4.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D4
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V5.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D5
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V6.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D6
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V7.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D7
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V8.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D8
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V9.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D9
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V10.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D10
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V11.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D11
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V12.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D12
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V13.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D13
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V14.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D14
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V15.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D15
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V16.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D16
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V17.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D17
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V18.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D18
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V19.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D19
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V20.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D20
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V21.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D21
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V22.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D22
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V23.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D23
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V24.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D24
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V25.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D25
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V26.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D26
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V27.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D27
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V28.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D28
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V29.D[1]
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D29
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V30.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D30
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, V31.D[1]
    MOVZ  X29, #0x0, LSL #0
    SUB  X7, X29, X3
    ADD  X1, X1, #0x1
    CBNZ  X7, AdvsimdLoadStoreP03_TestFail
    FMOV  X3, D31
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X7, X29, X3
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
    FMOV  V0.D[1], X28
    FMOV  D1, X6
    FMOV  V1.D[1], X28
    FMOV  D2, X26
    FMOV  V2.D[1], X27
    FMOV  D3, X25
    FMOV  V3.D[1], X29
    FMOV  D4, X25
    FMOV  V4.D[1], X3
    FMOV  D5, X13
    FMOV  V5.D[1], X17
    FMOV  D6, X14
    FMOV  V6.D[1], X27
    FMOV  D7, X23
    FMOV  V7.D[1], X13
    FMOV  D8, X2
    FMOV  V8.D[1], X9
    FMOV  D9, X29
    FMOV  V9.D[1], X4
    FMOV  D10, X25
    FMOV  V10.D[1], X7
    FMOV  D11, X13
    FMOV  V11.D[1], X23
    FMOV  D12, X8
    FMOV  V12.D[1], X12
    FMOV  D13, X4
    FMOV  V13.D[1], X7
    FMOV  D14, X9
    FMOV  V14.D[1], X28
    FMOV  D15, X23
    FMOV  V15.D[1], X25
    FMOV  D16, X15
    FMOV  V16.D[1], X11
    FMOV  D17, X17
    FMOV  V17.D[1], X27
    FMOV  D18, X15
    FMOV  V18.D[1], X29
    FMOV  D19, X28
    FMOV  V19.D[1], X3
    FMOV  D20, X6
    FMOV  V20.D[1], X8
    FMOV  D21, X16
    FMOV  V21.D[1], X8
    FMOV  D22, X23
    FMOV  V22.D[1], X16
    FMOV  D23, X7
    FMOV  V23.D[1], X29
    FMOV  D24, X4
    FMOV  V24.D[1], X26
    FMOV  D25, X24
    FMOV  V25.D[1], X26
    FMOV  D26, X7
    FMOV  V26.D[1], X24
    FMOV  D27, X3
    FMOV  V27.D[1], X5
    FMOV  D28, X3
    FMOV  V28.D[1], X3
    FMOV  D29, X8
    FMOV  V29.D[1], X15
    FMOV  D30, X10
    FMOV  V30.D[1], X7
    FMOV  D31, X28
    FMOV  V31.D[1], X27
    MOVZ  X24, #0x0, LSL #0
    MOVZ  X2, #0x40, LSL #0
    MOVZ  X9, #0x1e00, LSL #0
    ADD  X26, X30, X9
    ST1 { V13.16B }, [X26], X24
    LD1 { V28.4S }, [X26], X24
    ADD  X26, X26, X2
    ST1 { V30.16B }, [X26], X24
    LD1 { V25.16B }, [X26], X24
    ADD  X26, X26, X2, LSR #0
    ST1 { V25.2D }, [X26], X24
    LD1 { V1.2D }, [X26], X24
    ADD  X26, X26, X2, ASR #0
    ST1 { V28.4S }, [X26], X24
    LD1 { V6.4S }, [X26], X24
    ADD  X26, X26, X2, ASR #0
    ST1 { V26.8H }, [X26], X24
    LD1 { V6.8H }, [X26], X24
    ADD  X26, X26, X2
    ST1 { V31.4H }, [X26], X24
    LD1 { V1.1D }, [X26], X24
    ADD  X26, X26, X2, ASR #0
    ST1 { V6.1D }, [X26], X24
    LD1 { V5.1D }, [X26], X24
    ADD  X26, X26, X2, LSR #0
    ST1 { V19.2S }, [X26], X24
    LD1 { V11.2S }, [X26], X24
    ADD  X26, X26, X2, LSR #0
    ST1 { V5.4H }, [X26], X24
    LD1 { V16.4H }, [X26], X24
    ADD  X26, X26, X2, LSR #0
    ST1 { V29.8B }, [X26], X24
    LD1 { V11.8B }, [X26], X24
    ADD  X26, X26, X2, ASR #0
    MOV  X28, X26
    ST1 { V15.2D, V16.2D, V17.2D }, [X28], #48
    MOV  X28, X26
    LD1 { V20.8H, V21.8H, V22.8H }, [X28], #48
    ADD  X26, X26, X2
    MOV  X28, X26
    ST1 { V20.16B, V21.16B, V22.16B }, [X28], #48
    MOV  X28, X26
    LD1 { V10.16B, V11.16B, V12.16B }, [X28], #48
    ADD  X26, X26, X2, ASR #0
    MOV  X28, X26
    ST1 { V20.2D, V21.2D, V22.2D }, [X28], #48
    MOV  X28, X26
    LD1 { V0.2D, V1.2D, V2.2D }, [X28], #48
    ADD  X26, X26, X2, ASR #0
    MOV  X28, X26
    ST1 { V10.4S, V11.4S, V12.4S }, [X28], #48
    MOV  X28, X26
    LD1 { V21.4S, V22.4S, V23.4S }, [X28], #48
    ADD  X26, X26, X2
    MOV  X28, X26
    ST1 { V21.8H, V22.8H, V23.8H }, [X28], #48
    MOV  X28, X26
    LD1 { V12.8H, V13.8H, V14.8H }, [X28], #48
    ADD  X26, X26, X2, ASR #0
    MOV  X28, X26
    ST1 { V24.2S, V25.2S, V26.2S }, [X28], #24
    MOV  X28, X26
    LD1 { V3.1D, V4.1D, V5.1D }, [X28], #24
    ADD  X26, X26, X2
    MOV  X28, X26
    ST1 { V21.1D, V22.1D, V23.1D }, [X28], #24
    MOV  X28, X26
    LD1 { V7.1D, V8.1D, V9.1D }, [X28], #24
    ADD  X26, X26, X2
    MOV  X28, X26
    ST1 { V7.2S, V8.2S, V9.2S }, [X28], #24
    MOV  X28, X26
    LD1 { V6.2S, V7.2S, V8.2S }, [X28], #24
    ADD  X26, X26, X2
    MOV  X28, X26
    ST1 { V12.4H, V13.4H, V14.4H }, [X28], #24
    MOV  X28, X26
    LD1 { V31.4H, V0.4H, V1.4H }, [X28], #24
    ADD  X26, X26, X2, LSR #0
    MOV  X28, X26
    ST1 { V7.8B, V8.8B, V9.8B }, [X28], #24
    MOV  X28, X26
    LD1 { V5.8B, V6.8B, V7.8B }, [X28], #24
    ADD  X26, X26, X2, ASR #0
    ST1 { V5.4S, V6.4S, V7.4S }, [X26], X24
    LD1 { V7.4S, V8.4S, V9.4S }, [X26], X24
    ADD  X26, X26, X2
    ST1 { V31.16B, V0.16B, V1.16B }, [X26], X24
    LD1 { V28.16B, V29.16B, V30.16B }, [X26], X24
    ADD  X26, X26, X2
    ST1 { V28.2D, V29.2D, V30.2D }, [X26], X24
    LD1 { V3.2D, V4.2D, V5.2D }, [X26], X24
    ADD  X26, X26, X2, LSR #0
    ST1 { V6.4S, V7.4S, V8.4S }, [X26], X24
    LD1 { V31.4S, V0.4S, V1.4S }, [X26], X24
    ADD  X26, X26, X2, LSR #0
    ST1 { V3.8H, V4.8H, V5.8H }, [X26], X24
    LD1 { V15.8H, V16.8H, V17.8H }, [X26], X24
    ADD  X26, X26, X2
    ST1 { V31.1D, V0.1D, V1.1D }, [X26], X24
    LD1 { V19.2S, V20.2S, V21.2S }, [X26], X24
    ADD  X26, X26, X2, ASR #0
    ST1 { V21.1D, V22.1D, V23.1D }, [X26], X24
    LD1 { V2.1D, V3.1D, V4.1D }, [X26], X24
    ADD  X26, X26, X2, LSR #0
    ST1 { V2.2S, V3.2S, V4.2S }, [X26], X24
    LD1 { V21.2S, V22.2S, V23.2S }, [X26], X24
    ADD  X26, X26, X2
    ST1 { V10.4H, V11.4H, V12.4H }, [X26], X24
    LD1 { V0.4H, V1.4H, V2.4H }, [X26], X24
    ADD  X26, X26, X2, ASR #0
    ST1 { V4.8B, V5.8B, V6.8B }, [X26], X24
    LD1 { V6.8B, V7.8B, V8.8B }, [X26], X24
    ADD  X26, X26, X2, LSR #0
    MOV  X28, X26
    ST1 { V8.8H, V9.8H }, [X28], #32
    MOV  X28, X26
    LD1 { V2.8H, V3.8H }, [X28], #32
    ADD  X26, X26, X2, LSR #0
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X3
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X4
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X5
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X6
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X8
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X11
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X12
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X13
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X14
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X15
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X16
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X17
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X23
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X25
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MOVZ  X7, #0x5a5a, LSL #0
    MOVK  X7, #0x5a5a, LSL #16
    MOVK  X7, #0x5a5a, LSL #32
    MOVK  X7, #0x5a5a, LSL #48
    SUB  X27, X7, X29
    ADD  X1, X1, #0x1
    CBNZ  X27, AdvsimdLoadStoreP03_TestFail
    MRS  X7, FPSR
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V0.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D0
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V1.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D1
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V2.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D2
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V3.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D3
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V4.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D4
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V5.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D5
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V6.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D6
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V7.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D7
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V8.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D8
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V9.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D9
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V10.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D10
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V11.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D11
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V12.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D12
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V13.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D13
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V14.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D14
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V15.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D15
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V16.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D16
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V17.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D17
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V18.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D18
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V19.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D19
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V20.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D20
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V21.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D21
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V22.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D22
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V23.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D23
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V24.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D24
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V25.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D25
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V26.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D26
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V27.D[1]
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D27
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V28.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D28
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V29.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D29
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V30.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D30
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, V31.D[1]
    MOVZ  X27, #0x0, LSL #0
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X7, D31
    MOVZ  X27, #0x5a5a, LSL #0
    MOVK  X27, #0x5a5a, LSL #16
    MOVK  X27, #0x5a5a, LSL #32
    MOVK  X27, #0x5a5a, LSL #48
    SUB  X10, X27, X7
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
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
    FMOV  V0.D[1], X26
    FMOV  D1, X11
    FMOV  V1.D[1], X28
    FMOV  D2, X3
    FMOV  V2.D[1], X29
    FMOV  D3, X10
    FMOV  V3.D[1], X9
    FMOV  D4, X17
    FMOV  V4.D[1], X27
    FMOV  D5, X25
    FMOV  V5.D[1], X11
    FMOV  D6, X5
    FMOV  V6.D[1], X26
    FMOV  D7, X5
    FMOV  V7.D[1], X25
    FMOV  D8, X7
    FMOV  V8.D[1], X3
    FMOV  D9, X27
    FMOV  V9.D[1], X23
    FMOV  D10, X6
    FMOV  V10.D[1], X8
    FMOV  D11, X3
    FMOV  V11.D[1], X3
    FMOV  D12, X16
    FMOV  V12.D[1], X17
    FMOV  D13, X17
    FMOV  V13.D[1], X29
    FMOV  D14, X17
    FMOV  V14.D[1], X9
    FMOV  D15, X27
    FMOV  V15.D[1], X12
    FMOV  D16, X10
    FMOV  V16.D[1], X27
    FMOV  D17, X24
    FMOV  V17.D[1], X26
    FMOV  D18, X12
    FMOV  V18.D[1], X11
    FMOV  D19, X24
    FMOV  V19.D[1], X9
    FMOV  D20, X8
    FMOV  V20.D[1], X17
    FMOV  D21, X26
    FMOV  V21.D[1], X26
    FMOV  D22, X14
    FMOV  V22.D[1], X11
    FMOV  D23, X7
    FMOV  V23.D[1], X12
    FMOV  D24, X26
    FMOV  V24.D[1], X29
    FMOV  D25, X23
    FMOV  V25.D[1], X29
    FMOV  D26, X10
    FMOV  V26.D[1], X17
    FMOV  D27, X15
    FMOV  V27.D[1], X14
    FMOV  D28, X29
    FMOV  V28.D[1], X8
    FMOV  D29, X28
    FMOV  V29.D[1], X15
    FMOV  D30, X24
    FMOV  V30.D[1], X11
    FMOV  D31, X16
    FMOV  V31.D[1], X11
    MOVZ  X28, #0x0, LSL #0
    MOVZ  X13, #0x40, LSL #0
    MOVZ  X2, #0x2300, LSL #0
    ADD  X5, X30, X2, LSR #0
    ST1 { V19.16B }, [X5], X28
    LD1 { V18.8H }, [X5], X28
    ADD  X5, X5, X13, ASR #0
    ST1 { V27.16B }, [X5], X28
    LD1 { V23.16B }, [X5], X28
    ADD  X5, X5, X13, ASR #0
    ST1 { V30.2D }, [X5], X28
    LD1 { V12.2D }, [X5], X28
    ADD  X5, X5, X13, LSR #0
    ST1 { V12.4S }, [X5], X28
    LD1 { V25.4S }, [X5], X28
    ADD  X5, X5, X13
    ST1 { V18.8H }, [X5], X28
    LD1 { V7.8H }, [X5], X28
    ADD  X5, X5, X13, ASR #0
    ST1 { V16.8B }, [X5], X28
    LD1 { V28.8B }, [X5], X28
    ADD  X5, X5, X13, LSR #0
    ST1 { V25.1D }, [X5], X28
    LD1 { V17.1D }, [X5], X28
    ADD  X5, X5, X13, LSR #0
    ST1 { V31.2S }, [X5], X28
    LD1 { V30.2S }, [X5], X28
    ADD  X5, X5, X13
    ST1 { V7.4H }, [X5], X28
    LD1 { V17.4H }, [X5], X28
    ADD  X5, X5, X13
    ST1 { V30.8B }, [X5], X28
    LD1 { V17.8B }, [X5], X28
    ADD  X5, X5, X13
    MOV  X16, X5
    ST1 { V31.2D, V0.2D, V1.2D }, [X16], #48
    MOV  X16, X5
    LD1 { V9.4S, V10.4S, V11.4S }, [X16], #48
    ADD  X5, X5, X13, LSR #0
    MOV  X16, X5
    ST1 { V9.16B, V10.16B, V11.16B }, [X16], #48
    MOV  X16, X5
    LD1 { V21.16B, V22.16B, V23.16B }, [X16], #48
    ADD  X5, X5, X13, LSR #0
    MOV  X16, X5
    ST1 { V23.2D, V24.2D, V25.2D }, [X16], #48
    MOV  X16, X5
    LD1 { V18.2D, V19.2D, V20.2D }, [X16], #48
    ADD  X5, X5, X13, ASR #0
    MOV  X16, X5
    ST1 { V25.4S, V26.4S, V27.4S }, [X16], #48
    MOV  X16, X5
    LD1 { V10.4S, V11.4S, V12.4S }, [X16], #48
    ADD  X5, X5, X13, LSR #0
    MOV  X16, X5
    ST1 { V18.8H, V19.8H, V20.8H }, [X16], #48
    MOV  X16, X5
    LD1 { V25.8H, V26.8H, V27.8H }, [X16], #48
    ADD  X5, X5, X13, LSR #0
    MOV  X16, X5
    ST1 { V23.4H, V24.4H, V25.4H }, [X16], #24
    MOV  X16, X5
    LD1 { V2.1D, V3.1D, V4.1D }, [X16], #24
    ADD  X5, X5, X13, ASR #0
    MOV  X16, X5
    ST1 { V2.1D, V3.1D, V4.1D }, [X16], #24
    MOV  X16, X5
    LD1 { V5.1D, V6.1D, V7.1D }, [X16], #24
    ADD  X5, X5, X13
    MOV  X16, X5
    ST1 { V5.2S, V6.2S, V7.2S }, [X16], #24
    MOV  X16, X5
    LD1 { V2.2S, V3.2S, V4.2S }, [X16], #24
    ADD  X5, X5, X13, ASR #0
    MOV  X16, X5
    ST1 { V5.4H, V6.4H, V7.4H }, [X16], #24
    MOV  X16, X5
    LD1 { V5.4H, V6.4H, V7.4H }, [X16], #24
    ADD  X5, X5, X13, ASR #0
    MOV  X16, X5
    ST1 { V2.8B, V3.8B, V4.8B }, [X16], #24
    MOV  X16, X5
    LD1 { V2.8B, V3.8B, V4.8B }, [X16], #24
    ADD  X5, X5, X13, ASR #0
    ST1 { V3.2D, V4.2D, V5.2D }, [X5], X28
    LD1 { V8.8H, V9.8H, V10.8H }, [X5], X28
    ADD  X5, X5, X13, ASR #0
    ST1 { V7.16B, V8.16B, V9.16B }, [X5], X28
    LD1 { V30.16B, V31.16B, V0.16B }, [X5], X28
    ADD  X5, X5, X13
    ST1 { V30.2D, V31.2D, V0.2D }, [X5], X28
    LD1 { V30.2D, V31.2D, V0.2D }, [X5], X28
    ADD  X5, X5, X13, LSR #0
    ST1 { V14.4S, V15.4S, V16.4S }, [X5], X28
    LD1 { V7.4S, V8.4S, V9.4S }, [X5], X28
    ADD  X5, X5, X13, LSR #0
    ST1 { V30.8H, V31.8H, V0.8H }, [X5], X28
    LD1 { V3.8H, V4.8H, V5.8H }, [X5], X28
    ADD  X5, X5, X13
    ST1 { V31.1D, V0.1D, V1.1D }, [X5], X28
    LD1 { V14.4H, V15.4H, V16.4H }, [X5], X28
    ADD  X5, X5, X13, LSR #0
    ST1 { V14.1D, V15.1D, V16.1D }, [X5], X28
    LD1 { V27.1D, V28.1D, V29.1D }, [X5], X28
    ADD  X5, X5, X13
    ST1 { V3.2S, V4.2S, V5.2S }, [X5], X28
    LD1 { V31.2S, V0.2S, V1.2S }, [X5], X28
    ADD  X5, X5, X13, ASR #0
    ST1 { V26.4H, V27.4H, V28.4H }, [X5], X28
    LD1 { V26.4H, V27.4H, V28.4H }, [X5], X28
    ADD  X5, X5, X13, ASR #0
    ST1 { V26.8B, V27.8B, V28.8B }, [X5], X28
    LD1 { V14.8B, V15.8B, V16.8B }, [X5], X28
    ADD  X5, X5, X13
    MOV  X16, X5
    ST1 { V23.2D, V24.2D }, [X16], #32
    MOV  X16, X5
    LD1 { V4.2D, V5.2D }, [X16], #32
    ADD  X5, X5, X13, ASR #0
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X4
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X6
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X7
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X8
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X9
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X10
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X11
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X14
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X15
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X17
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X23
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X24
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X25
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X26
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MOVZ  X29, #0xa5a5, LSL #0
    MOVK  X29, #0xa5a5, LSL #16
    MOVK  X29, #0xa5a5, LSL #32
    MOVK  X29, #0xa5a5, LSL #48
    SUB  X3, X29, X27
    ADD  X1, X1, #0x1
    CBNZ  X3, AdvsimdLoadStoreP03_TestFail
    MRS  X29, FPSR
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V0.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D0
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V1.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D1
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V2.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D2
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V3.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D3
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V4.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D4
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V5.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D5
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V6.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D6
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V7.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D7
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V8.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D8
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V9.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D9
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V10.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D10
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V11.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D11
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V12.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D12
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V13.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D13
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V14.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D14
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V15.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D15
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V16.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D16
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V17.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D17
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V18.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D18
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V19.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D19
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V20.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D20
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V21.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D21
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V22.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D22
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V23.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D23
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V24.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D24
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V25.D[1]
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D25
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V26.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D26
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V27.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D27
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V28.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D28
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V29.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D29
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V30.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D30
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, V31.D[1]
    MOVZ  X3, #0x0, LSL #0
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
    FMOV  X29, D31
    MOVZ  X3, #0xa5a5, LSL #0
    MOVK  X3, #0xa5a5, LSL #16
    MOVK  X3, #0xa5a5, LSL #32
    MOVK  X3, #0xa5a5, LSL #48
    SUB  X12, X3, X29
    ADD  X1, X1, #0x1
    CBNZ  X12, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D0, X24
    FMOV  V0.D[1], X25
    FMOV  D1, X28
    FMOV  V1.D[1], X26
    FMOV  D2, X27
    FMOV  V2.D[1], X10
    FMOV  D3, X29
    FMOV  V3.D[1], X6
    FMOV  D4, X4
    FMOV  V4.D[1], X6
    FMOV  D5, X24
    FMOV  V5.D[1], X11
    FMOV  D6, X3
    FMOV  V6.D[1], X17
    FMOV  D7, X3
    FMOV  V7.D[1], X29
    FMOV  D8, X11
    FMOV  V8.D[1], X17
    FMOV  D9, X15
    FMOV  V9.D[1], X16
    FMOV  D10, X16
    FMOV  V10.D[1], X23
    FMOV  D11, X28
    FMOV  V11.D[1], X8
    FMOV  D12, X13
    FMOV  V12.D[1], X24
    FMOV  D13, X7
    FMOV  V13.D[1], X15
    FMOV  D14, X7
    FMOV  V14.D[1], X10
    FMOV  D15, X13
    FMOV  V15.D[1], X7
    FMOV  D16, X29
    FMOV  V16.D[1], X7
    FMOV  D17, X17
    FMOV  V17.D[1], X11
    FMOV  D18, X28
    FMOV  V18.D[1], X29
    FMOV  D19, X5
    FMOV  V19.D[1], X13
    FMOV  D20, X16
    FMOV  V20.D[1], X7
    FMOV  D21, X10
    FMOV  V21.D[1], X28
    FMOV  D22, X7
    FMOV  V22.D[1], X7
    FMOV  D23, X8
    FMOV  V23.D[1], X16
    FMOV  D24, X12
    FMOV  V24.D[1], X26
    FMOV  D25, X9
    FMOV  V25.D[1], X10
    FMOV  D26, X24
    FMOV  V26.D[1], X11
    FMOV  D27, X8
    FMOV  V27.D[1], X25
    FMOV  D28, X24
    FMOV  V28.D[1], X17
    FMOV  D29, X5
    FMOV  V29.D[1], X15
    FMOV  D30, X9
    FMOV  V30.D[1], X13
    FMOV  D31, X14
    FMOV  V31.D[1], X29
    MOVZ  X12, #0x0, LSL #0
    MOVZ  X25, #0x40, LSL #0
    MOVZ  X11, #0x2800, LSL #0
    ADD  X17, X30, X11
    ST1 { V19.16B }, [X17], X12
    LD1 { V13.4S }, [X17], X12
    ADD  X17, X17, X25, LSR #0
    ST1 { V25.16B }, [X17], X12
    LD1 { V1.16B }, [X17], X12
    ADD  X17, X17, X25, ASR #0
    ST1 { V28.2D }, [X17], X12
    LD1 { V23.2D }, [X17], X12
    ADD  X17, X17, X25
    ST1 { V31.4S }, [X17], X12
    LD1 { V30.4S }, [X17], X12
    ADD  X17, X17, X25, ASR #0
    ST1 { V30.8H }, [X17], X12
    LD1 { V14.8H }, [X17], X12
    ADD  X17, X17, X25, ASR #0
    ST1 { V29.4H }, [X17], X12
    LD1 { V13.1D }, [X17], X12
    ADD  X17, X17, X25, LSR #0
    ST1 { V14.1D }, [X17], X12
    LD1 { V15.1D }, [X17], X12
    ADD  X17, X17, X25, LSR #0
    ST1 { V1.2S }, [X17], X12
    LD1 { V20.2S }, [X17], X12
    ADD  X17, X17, X25, ASR #0
    ST1 { V23.4H }, [X17], X12
    LD1 { V6.4H }, [X17], X12
    ADD  X17, X17, X25, ASR #0
    ST1 { V15.8B }, [X17], X12
    LD1 { V20.8B }, [X17], X12
    ADD  X17, X17, X25
    MOV  X27, X17
    ST1 { V10.16B, V11.16B, V12.16B }, [X27], #48
    MOV  X27, X17
    LD1 { V16.4S, V17.4S, V18.4S }, [X27], #48
    ADD  X17, X17, X25, LSR #0
    MOV  X27, X17
    ST1 { V16.16B, V17.16B, V18.16B }, [X27], #48
    MOV  X27, X17
    LD1 { V16.16B, V17.16B, V18.16B }, [X27], #48
    ADD  X17, X17, X25, LSR #0
    MOV  X27, X17
    ST1 { V16.2D, V17.2D, V18.2D }, [X27], #48
    MOV  X27, X17
    LD1 { V4.2D, V5.2D, V6.2D }, [X27], #48
    ADD  X17, X17, X25
    MOV  X27, X17
    ST1 { V18.4S, V19.4S, V20.4S }, [X27], #48
    MOV  X27, X17
    LD1 { V24.4S, V25.4S, V26.4S }, [X27], #48
    ADD  X17, X17, X25, LSR #0
    MOV  X27, X17
    ST1 { V7.8H, V8.8H, V9.8H }, [X27], #48
    MOV  X27, X17
    LD1 { V6.8H, V7.8H, V8.8H }, [X27], #48
    ADD  X17, X17, X25
    MOV  X27, X17
    ST1 { V17.2S, V18.2S, V19.2S }, [X27], #24
    MOV  X27, X17
    LD1 { V23.1D, V24.1D, V25.1D }, [X27], #24
    ADD  X17, X17, X25, ASR #0
    MOV  X27, X17
    ST1 { V23.1D, V24.1D, V25.1D }, [X27], #24
    MOV  X27, X17
    LD1 { V30.1D, V31.1D, V0.1D }, [X27], #24
    ADD  X17, X17, X25, LSR #0
    MOV  X27, X17
    ST1 { V6.2S, V7.2S, V8.2S }, [X27], #24
    MOV  X27, X17
    LD1 { V24.2S, V25.2S, V26.2S }, [X27], #24
    ADD  X17, X17, X25
    MOV  X27, X17
    ST1 { V30.4H, V31.4H, V0.4H }, [X27], #24
    MOV  X27, X17
    LD1 { V19.4H, V20.4H, V21.4H }, [X27], #24
    ADD  X17, X17, X25
    MOV  X27, X17
    ST1 { V11.8B, V12.8B, V13.8B }, [X27], #24
    MOV  X27, X17
    LD1 { V7.8B, V8.8B, V9.8B }, [X27], #24
    ADD  X17, X17, X25, LSR #0
    ST1 { V7.8H, V8.8H, V9.8H }, [X17], X12
    LD1 { V4.8H, V5.8H, V6.8H }, [X17], X12
    ADD  X17, X17, X25
    ST1 { V24.16B, V25.16B, V26.16B }, [X17], X12
    LD1 { V10.16B, V11.16B, V12.16B }, [X17], X12
    ADD  X17, X17, X25, LSR #0
    ST1 { V10.2D, V11.2D, V12.2D }, [X17], X12
    LD1 { V16.2D, V17.2D, V18.2D }, [X17], X12
    ADD  X17, X17, X25, LSR #0
    ST1 { V20.4S, V21.4S, V22.4S }, [X17], X12
    LD1 { V30.4S, V31.4S, V0.4S }, [X17], X12
    ADD  X17, X17, X25
    ST1 { V6.8H, V7.8H, V8.8H }, [X17], X12
    LD1 { V6.8H, V7.8H, V8.8H }, [X17], X12
    ADD  X17, X17, X25, ASR #0
    ST1 { V6.2S, V7.2S, V8.2S }, [X17], X12
    LD1 { V7.8B, V8.8B, V9.8B }, [X17], X12
    ADD  X17, X17, X25, ASR #0
    ST1 { V7.1D, V8.1D, V9.1D }, [X17], X12
    LD1 { V8.1D, V9.1D, V10.1D }, [X17], X12
    ADD  X17, X17, X25, LSR #0
    ST1 { V21.2S, V22.2S, V23.2S }, [X17], X12
    LD1 { V21.2S, V22.2S, V23.2S }, [X17], X12
    ADD  X17, X17, X25
    ST1 { V8.4H, V9.4H, V10.4H }, [X17], X12
    LD1 { V6.4H, V7.4H, V8.4H }, [X17], X12
    ADD  X17, X17, X25
    ST1 { V21.8B, V22.8B, V23.8B }, [X17], X12
    LD1 { V21.8B, V22.8B, V23.8B }, [X17], X12
    ADD  X17, X17, X25, LSR #0
    MOV  X27, X17
    ST1 { V12.16B, V13.16B }, [X27], #32
    MOV  X27, X17
    LD1 { V19.8H, V20.8H }, [X27], #32
    ADD  X17, X17, X25, LSR #0
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X2
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X3
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X4
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X6
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X7
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X9
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X10
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X14
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X15
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X16
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X23
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X24
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X26
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X28
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MOVZ  X13, #0x5a5a, LSL #0
    MOVK  X13, #0x5a5a, LSL #16
    MOVK  X13, #0x5a5a, LSL #32
    MOVK  X13, #0x5a5a, LSL #48
    SUB  X8, X13, X29
    ADD  X1, X1, #0x1
    CBNZ  X8, AdvsimdLoadStoreP03_TestFail
    MRS  X13, FPSR
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V0.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D0
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V1.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D1
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V2.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D2
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V3.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D3
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V4.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D4
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V5.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D5
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V6.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D6
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V7.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D7
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V8.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D8
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V9.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D9
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V10.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D10
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V11.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D11
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V12.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D12
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V13.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D13
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V14.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D14
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V15.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D15
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V16.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D16
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V17.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D17
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V18.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D18
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V19.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D19
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V20.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D20
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V21.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D21
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V22.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D22
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V23.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D23
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V24.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D24
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V25.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D25
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V26.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D26
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V27.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D27
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V28.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D28
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V29.D[1]
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D29
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V30.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D30
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, V31.D[1]
    MOVZ  X8, #0x0, LSL #0
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
    FMOV  X13, D31
    MOVZ  X8, #0x5a5a, LSL #0
    MOVK  X8, #0x5a5a, LSL #16
    MOVK  X8, #0x5a5a, LSL #32
    MOVK  X8, #0x5a5a, LSL #48
    SUB  X5, X8, X13
    ADD  X1, X1, #0x1
    CBNZ  X5, AdvsimdLoadStoreP03_TestFail
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
    FMOV  D1, X8
    FMOV  V1.D[1], X27
    FMOV  D2, X10
    FMOV  V2.D[1], X29
    FMOV  D3, X25
    FMOV  V3.D[1], X24
    FMOV  D4, X7
    FMOV  V4.D[1], X13
    FMOV  D5, X14
    FMOV  V5.D[1], X7
    FMOV  D6, X25
    FMOV  V6.D[1], X9
    FMOV  D7, X28
    FMOV  V7.D[1], X3
    FMOV  D8, X9
    FMOV  V8.D[1], X3
    FMOV  D9, X12
    FMOV  V9.D[1], X7
    FMOV  D10, X13
    FMOV  V10.D[1], X26
    FMOV  D11, X3
    FMOV  V11.D[1], X17
    FMOV  D12, X16
    FMOV  V12.D[1], X9
    FMOV  D13, X2
    FMOV  V13.D[1], X23
    FMOV  D14, X7
    FMOV  V14.D[1], X27
    FMOV  D15, X28
    FMOV  V15.D[1], X13
    FMOV  D16, X17
    FMOV  V16.D[1], X29
    FMOV  D17, X29
    FMOV  V17.D[1], X27
    FMOV  D18, X6
    FMOV  V18.D[1], X27
    FMOV  D19, X8
    FMOV  V19.D[1], X4
    FMOV  D20, X24
    FMOV  V20.D[1], X29
    FMOV  D21, X8
    FMOV  V21.D[1], X13
    FMOV  D22, X6
    FMOV  V22.D[1], X29
    FMOV  D23, X7
    FMOV  V23.D[1], X5
    FMOV  D24, X24
    FMOV  V24.D[1], X4
    FMOV  D25, X8
    FMOV  V25.D[1], X3
    FMOV  D26, X13
    FMOV  V26.D[1], X23
    FMOV  D27, X11
    FMOV  V27.D[1], X29
    FMOV  D28, X6
    FMOV  V28.D[1], X25
    FMOV  D29, X25
    FMOV  V29.D[1], X3
    FMOV  D30, X14
    FMOV  V30.D[1], X5
    FMOV  D31, X11
    FMOV  V31.D[1], X11
    MOVZ  X13, #0x0, LSL #0
    MOVZ  X24, #0x40, LSL #0
    MOVZ  X2, #0x2d00, LSL #0
    ADD  X17, X30, X2, LSR #0
    ST1 { V24.8H }, [X17], X13
    LD1 { V2.8H }, [X17], X13
    ADD  X17, X17, X24, ASR #0
    ST1 { V21.16B }, [X17], X13
    LD1 { V7.16B }, [X17], X13
    ADD  X17, X17, X24, LSR #0
    ST1 { V13.2D }, [X17], X13
    LD1 { V3.2D }, [X17], X13
    ADD  X17, X17, X24, ASR #0
    ST1 { V2.4S }, [X17], X13
    LD1 { V27.4S }, [X17], X13
    ADD  X17, X17, X24, ASR #0
    ST1 { V30.8H }, [X17], X13
    LD1 { V4.8H }, [X17], X13
    ADD  X17, X17, X24, LSR #0
    ST1 { V27.1D }, [X17], X13
    LD1 { V28.2S }, [X17], X13
    ADD  X17, X17, X24
    ST1 { V30.1D }, [X17], X13
    LD1 { V6.1D }, [X17], X13
    ADD  X17, X17, X24
    ST1 { V7.2S }, [X17], X13
    LD1 { V1.2S }, [X17], X13
    ADD  X17, X17, X24, LSR #0
    ST1 { V28.4H }, [X17], X13
    LD1 { V7.4H }, [X17], X13
    ADD  X17, X17, X24
    ST1 { V25.8B }, [X17], X13
    LD1 { V2.8B }, [X17], X13
    ADD  X17, X17, X24, ASR #0
    MOV  X5, X17
    ST1 { V19.8H, V20.8H, V21.8H }, [X5], #48
    MOV  X5, X17
    LD1 { V4.4S, V5.4S, V6.4S }, [X5], #48
    ADD  X17, X17, X24, LSR #0
    MOV  X5, X17
    ST1 { V2.16B, V3.16B, V4.16B }, [X5], #48
    MOV  X5, X17
    LD1 { V9.16B, V10.16B, V11.16B }, [X5], #48
    ADD  X17, X17, X24, ASR #0
    MOV  X5, X17
    ST1 { V5.2D, V6.2D, V7.2D }, [X5], #48
    MOV  X5, X17
    LD1 { V11.2D, V12.2D, V13.2D }, [X5], #48
    ADD  X17, X17, X24, ASR #0
    MOV  X5, X17
    ST1 { V9.4S, V10.4S, V11.4S }, [X5], #48
    MOV  X5, X17
    LD1 { V8.4S, V9.4S, V10.4S }, [X5], #48
    ADD  X17, X17, X24, LSR #0
    MOV  X5, X17
    ST1 { V8.8H, V9.8H, V10.8H }, [X5], #48
    MOV  X5, X17
    LD1 { V15.8H, V16.8H, V17.8H }, [X5], #48
    ADD  X17, X17, X24, ASR #0
    MOV  X5, X17
    ST1 { V22.2S, V23.2S, V24.2S }, [X5], #24
    MOV  X5, X17
    LD1 { V8.2S, V9.2S, V10.2S }, [X5], #24
    ADD  X17, X17, X24
    MOV  X5, X17
    ST1 { V0.1D, V1.1D, V2.1D }, [X5], #24
    MOV  X5, X17
    LD1 { V22.1D, V23.1D, V24.1D }, [X5], #24
    ADD  X17, X17, X24, ASR #0
    MOV  X5, X17
    ST1 { V17.2S, V18.2S, V19.2S }, [X5], #24
    MOV  X5, X17
    LD1 { V5.2S, V6.2S, V7.2S }, [X5], #24
    ADD  X17, X17, X24
    MOV  X5, X17
    ST1 { V14.4H, V15.4H, V16.4H }, [X5], #24
    MOV  X5, X17
    LD1 { V23.4H, V24.4H, V25.4H }, [X5], #24
    ADD  X17, X17, X24
    MOV  X5, X17
    ST1 { V2.8B, V3.8B, V4.8B }, [X5], #24
    MOV  X5, X17
    LD1 { V16.8B, V17.8B, V18.8B }, [X5], #24
    ADD  X17, X17, X24, ASR #0
    ST1 { V22.16B, V23.16B, V24.16B }, [X17], X13
    LD1 { V2.2D, V3.2D, V4.2D }, [X17], X13
    ADD  X17, X17, X24, LSR #0
    ST1 { V30.16B, V31.16B, V0.16B }, [X17], X13
    LD1 { V7.16B, V8.16B, V9.16B }, [X17], X13
    ADD  X17, X17, X24, LSR #0
    ST1 { V7.2D, V8.2D, V9.2D }, [X17], X13
    LD1 { V25.2D, V26.2D, V27.2D }, [X17], X13
    ADD  X17, X17, X24
    ST1 { V16.4S, V17.4S, V18.4S }, [X17], X13
    LD1 { V0.4S, V1.4S, V2.4S }, [X17], X13
    ADD  X17, X17, X24, ASR #0
    ST1 { V25.8H, V26.8H, V27.8H }, [X17], X13
    LD1 { V22.8H, V23.8H, V24.8H }, [X17], X13
    ADD  X17, X17, X24, ASR #0
    ST1 { V30.4H, V31.4H, V0.4H }, [X17], X13
    LD1 { V25.1D, V26.1D, V27.1D }, [X17], X13
    ADD  X17, X17, X24
    ST1 { V23.1D, V24.1D, V25.1D }, [X17], X13
    LD1 { V2.1D, V3.1D, V4.1D }, [X17], X13
    ADD  X17, X17, X24, LSR #0
    ST1 { V1.2S, V2.2S, V3.2S }, [X17], X13
    LD1 { V1.2S, V2.2S, V3.2S }, [X17], X13
    ADD  X17, X17, X24, LSR #0
    ST1 { V1.4H, V2.4H, V3.4H }, [X17], X13
    LD1 { V27.4H, V28.4H, V29.4H }, [X17], X13
    ADD  X17, X17, X24, ASR #0
    ST1 { V26.8B, V27.8B, V28.8B }, [X17], X13
    LD1 { V26.8B, V27.8B, V28.8B }, [X17], X13
    ADD  X17, X17, X24
    MOV  X5, X17
    ST1 { V11.4S, V12.4S }, [X5], #32
    MOV  X5, X17
    LD1 { V23.8H, V24.8H }, [X5], #32
    ADD  X17, X17, X24
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X3
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X4
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X7
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X8
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X9
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X11
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X12
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X14
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X15
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X16
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X25
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X26
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X27
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X28
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MOVZ  X23, #0xa5a5, LSL #0
    MOVK  X23, #0xa5a5, LSL #16
    MOVK  X23, #0xa5a5, LSL #32
    MOVK  X23, #0xa5a5, LSL #48
    SUB  X6, X23, X29
    ADD  X1, X1, #0x1
    CBNZ  X6, AdvsimdLoadStoreP03_TestFail
    MRS  X23, FPSR
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V0.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D0
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V1.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D1
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V2.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D2
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V3.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D3
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V4.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D4
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V5.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D5
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V6.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D6
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V7.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D7
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V8.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D8
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V9.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D9
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V10.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D10
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V11.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D11
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V12.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D12
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V13.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D13
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V14.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D14
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V15.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D15
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V16.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D16
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V17.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D17
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V18.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D18
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V19.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D19
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V20.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D20
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V21.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D21
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V22.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D22
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V23.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D23
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V24.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D24
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V25.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D25
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V26.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D26
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V27.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D27
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V28.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D28
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V29.D[1]
    MOVZ  X6, #0x0, LSL #0
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D29
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V30.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D30
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, V31.D[1]
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail
    FMOV  X23, D31
    MOVZ  X6, #0xa5a5, LSL #0
    MOVK  X6, #0xa5a5, LSL #16
    MOVK  X6, #0xa5a5, LSL #32
    MOVK  X6, #0xa5a5, LSL #48
    SUB  X10, X6, X23
    ADD  X1, X1, #0x1
    CBNZ  X10, AdvsimdLoadStoreP03_TestFail

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
